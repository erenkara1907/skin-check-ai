import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY")!;
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const SYSTEM_PROMPT = "You are a skin health analyst.";

const USER_PROMPT = `Analyze this selfie. Return ONLY valid JSON with no extra text:
{
  "overall_score": <1-100>,
  "skin_age": <number>,
  "summary": "<string>",
  "zones": [
    {
      "zone": "<forehead|left_cheek|right_cheek|nose|chin|under_eyes|jawline>",
      "score": <1-100>,
      "concerns": ["<string>"],
      "severity": <1-10>,
      "recommendations": ["<string>"]
    }
  ],
  "suggested_routine": {
    "morning": [{"step": "<string>", "product_type": "<string>", "reason": "<string>"}],
    "evening": [{"step": "<string>", "product_type": "<string>", "reason": "<string>"}]
  }
}`;

interface RequestBody {
  user_id: string;
  photo_path: string;
}

serve(async (req: Request) => {
  // CORS
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
      },
    });
  }

  try {
    // Verify auth
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({ error: "Missing authorization" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    const { user_id, photo_path } = (await req.json()) as RequestBody;

    if (!user_id || !photo_path) {
      return new Response(
        JSON.stringify({ error: "Missing user_id or photo_path" }),
        { status: 400, headers: { "Content-Type": "application/json" } },
      );
    }

    // Get signed URL for the photo
    const { data: signedUrlData, error: signedUrlError } = await supabase.storage
      .from("skin-photos")
      .createSignedUrl(photo_path, 300); // 5 min expiry

    if (signedUrlError || !signedUrlData?.signedUrl) {
      return new Response(
        JSON.stringify({ error: "Failed to create signed URL" }),
        { status: 500, headers: { "Content-Type": "application/json" } },
      );
    }

    // Call GPT-4o Vision
    const openaiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-4o",
        messages: [
          { role: "system", content: SYSTEM_PROMPT },
          {
            role: "user",
            content: [
              { type: "text", text: USER_PROMPT },
              {
                type: "image_url",
                image_url: { url: signedUrlData.signedUrl, detail: "high" },
              },
            ],
          },
        ],
        max_tokens: 2000,
        temperature: 0.3,
      }),
    });

    if (!openaiResponse.ok) {
      const errText = await openaiResponse.text();
      console.error("OpenAI error:", errText);
      return new Response(
        JSON.stringify({ error: "AI analysis failed" }),
        { status: 502, headers: { "Content-Type": "application/json" } },
      );
    }

    const openaiData = await openaiResponse.json();
    const rawContent = openaiData.choices?.[0]?.message?.content ?? "";

    // Parse JSON from response (strip markdown fences if present)
    const jsonMatch = rawContent.replace(/```json\n?/g, "").replace(/```\n?/g, "").trim();
    const aiResult = JSON.parse(jsonMatch);

    // Save to analyses table
    const { data: analysis, error: analysisError } = await supabase
      .from("analyses")
      .insert({
        user_id,
        photo_url: photo_path,
        overall_score: aiResult.overall_score,
        skin_age: aiResult.skin_age,
        ai_response_json: aiResult,
      })
      .select()
      .single();

    if (analysisError) {
      console.error("DB insert error (analyses):", analysisError);
      return new Response(
        JSON.stringify({ error: "Failed to save analysis" }),
        { status: 500, headers: { "Content-Type": "application/json" } },
      );
    }

    // Save zone scores
    const zoneRows = (aiResult.zones ?? []).map((z: Record<string, unknown>) => ({
      analysis_id: analysis.id,
      zone: z.zone,
      score: z.score,
      concerns: z.concerns,
      severity: z.severity,
      recommendations: z.recommendations,
    }));

    if (zoneRows.length > 0) {
      const { error: zonesError } = await supabase
        .from("zone_scores")
        .insert(zoneRows);

      if (zonesError) {
        console.error("DB insert error (zone_scores):", zonesError);
      }
    }

    // Return full result
    const responseData = {
      ...analysis,
      zone_scores: zoneRows,
      ai_response_json: aiResult,
    };

    return new Response(JSON.stringify(responseData), {
      status: 200,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return new Response(
      JSON.stringify({ error: "Internal server error" }),
      { status: 500, headers: { "Content-Type": "application/json" } },
    );
  }
});
