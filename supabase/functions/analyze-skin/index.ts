import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { encode as base64Encode } from "https://deno.land/std@0.177.0/encoding/base64.ts";

const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY")!;

const SYSTEM_PROMPT = `You are a beauty and cosmetics product recommendation assistant for a consumer mobile app. Users upload selfies and you help them find the right skincare products by assessing their complexion, texture, and visible cosmetic concerns (like dryness, oiliness, redness, pores). This is purely cosmetic advice — like a beauty counter consultation — not a medical evaluation. Always respond with valid JSON.`;

const USER_PROMPT = `Based on this selfie, provide cosmetic skincare product recommendations. Assess the complexion across 7 facial areas and suggest appropriate beauty products. Return ONLY valid JSON:
{
  "overall_score": <1-100 beauty wellness score>,
  "skin_age": <estimated number>,
  "summary": "<brief beauty assessment, 1-2 sentences>",
  "zones": [
    {
      "zone": "<forehead|left_cheek|right_cheek|nose|chin|under_eyes|jawline>",
      "score": <1-100>,
      "concerns": ["<cosmetic concern like dryness, oiliness, uneven tone, visible pores, fine lines>"],
      "severity": <1-10>,
      "recommendations": ["<beauty/skincare product tip>"]
    }
  ],
  "suggested_routine": {
    "morning": [{"step": "<step name>", "product_type": "<product category>", "reason": "<why>"}],
    "evening": [{"step": "<step name>", "product_type": "<product category>", "reason": "<why>"}]
  }
}
Include all 7 zones. Be encouraging and helpful.`;

const SYSTEM_PROMPT_TR = `Sen bir güzellik ve kozmetik ürün öneri asistanısın. Kullanıcılar selfie yükler ve sen onların cilt tipine, dokusuna ve görünür kozmetik sorunlarına (kuruluk, yağlanma, kızarıklık, gözenekler gibi) göre doğru cilt bakım ürünlerini bulmalarına yardımcı olursun. Bu tamamen kozmetik tavsiyedir — tıbbi değerlendirme değil. Her zaman geçerli JSON ile yanıt ver.`;

const USER_PROMPT_TR = `Bu selfie'ye dayanarak, kozmetik cilt bakım ürünü önerileri sun. 7 yüz bölgesinde cilt değerlendirmesi yap ve uygun güzellik ürünleri öner. SADECE geçerli JSON döndür:
{
  "overall_score": <1-100 güzellik sağlık skoru>,
  "skin_age": <tahmini yaş>,
  "summary": "<kısa güzellik değerlendirmesi, 1-2 cümle>",
  "zones": [
    {
      "zone": "<forehead|left_cheek|right_cheek|nose|chin|under_eyes|jawline>",
      "score": <1-100>,
      "concerns": ["<kuruluk, yağlanma, dengesiz ton, görünür gözenekler, ince çizgiler gibi kozmetik sorunlar>"],
      "severity": <1-10>,
      "recommendations": ["<güzellik/cilt bakım ürün önerisi>"]
    }
  ],
  "suggested_routine": {
    "morning": [{"step": "<adım adı>", "product_type": "<ürün kategorisi>", "reason": "<neden>"}],
    "evening": [{"step": "<adım adı>", "product_type": "<ürün kategorisi>", "reason": "<neden>"}]
  }
}
Tüm 7 bölgeyi dahil et. Cesaret verici ve yardımcı ol.`;

interface RequestBody {
  user_id: string;
  photo_path: string;
  locale?: string;
}

serve(async (req: Request) => {
  const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  };

  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!supabaseUrl || !supabaseServiceKey) {
      console.error("Missing env vars:", { hasUrl: !!supabaseUrl, hasKey: !!supabaseServiceKey });
      return new Response(
        JSON.stringify({ error: "Server misconfiguration" }),
        { status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    if (!OPENAI_API_KEY) {
      console.error("Missing OPENAI_API_KEY");
      return new Response(
        JSON.stringify({ error: "OpenAI API key not configured" }),
        { status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey);
    const { user_id, photo_path, locale } = (await req.json()) as RequestBody;
    const systemPrompt = locale === 'tr' ? SYSTEM_PROMPT_TR : SYSTEM_PROMPT;
    const userPrompt = locale === 'tr' ? USER_PROMPT_TR : USER_PROMPT;

    if (!user_id || !photo_path) {
      return new Response(
        JSON.stringify({ error: "Missing user_id or photo_path" }),
        { status: 400, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    console.log(`Processing: user=${user_id}, photo=${photo_path}`);

    // Download the photo directly and convert to base64
    const { data: fileData, error: downloadError } = await supabase.storage
      .from("skin-photos")
      .download(photo_path);

    if (downloadError || !fileData) {
      console.error("Download error:", downloadError);
      return new Response(
        JSON.stringify({ error: "Failed to download photo", detail: downloadError?.message }),
        { status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    const arrayBuffer = await fileData.arrayBuffer();
    const base64Image = base64Encode(new Uint8Array(arrayBuffer));
    const dataUrl = `data:image/jpeg;base64,${base64Image}`;
    console.log(`Photo loaded: ${arrayBuffer.byteLength} bytes, sending to OpenAI...`);

    // Call GPT-4o Vision with base64 image
    const openaiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: systemPrompt },
          {
            role: "user",
            content: [
              { type: "text", text: userPrompt },
              {
                type: "image_url",
                image_url: { url: dataUrl, detail: "auto" },
              },
            ],
          },
        ],
        max_tokens: 2000,
        temperature: 0.3,
        response_format: { type: "json_object" },
      }),
    });

    if (!openaiResponse.ok) {
      const errText = await openaiResponse.text();
      console.error("OpenAI error:", openaiResponse.status, errText);
      return new Response(
        JSON.stringify({ error: "AI analysis failed", detail: errText }),
        { status: 502, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    const openaiData = await openaiResponse.json();
    const choice = openaiData.choices?.[0];
    const rawContent = choice?.message?.content ?? "";
    const finishReason = choice?.finish_reason ?? "unknown";
    const refusal = choice?.message?.refusal;

    console.log("OpenAI finish_reason:", finishReason, "content length:", rawContent.length);

    if (refusal || !rawContent) {
      console.error("OpenAI refusal/empty:", refusal, JSON.stringify(openaiData));
      return new Response(
        JSON.stringify({
          error: "AI could not analyze the photo",
          detail: refusal || `finish_reason: ${finishReason}`,
        }),
        { status: 502, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

    // Parse JSON from response
    const jsonMatch = rawContent.replace(/```json\n?/g, "").replace(/```\n?/g, "").trim();
    let aiResult;
    try {
      aiResult = JSON.parse(jsonMatch);
    } catch (_parseErr) {
      console.error("Failed to parse AI response:", rawContent);
      return new Response(
        JSON.stringify({ error: "AI returned invalid response", detail: rawContent.substring(0, 300) }),
        { status: 502, headers: { "Content-Type": "application/json", ...corsHeaders } },
      );
    }

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
        JSON.stringify({ error: "Failed to save analysis", detail: analysisError.message }),
        { status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } },
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
      headers: { "Content-Type": "application/json", ...corsHeaders },
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return new Response(
      JSON.stringify({
        error: "Internal server error",
        detail: err instanceof Error ? err.message : String(err),
      }),
      { status: 500, headers: { "Content-Type": "application/json", ...corsHeaders } },
    );
  }
});
