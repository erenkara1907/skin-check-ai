-- Create products table for skincare product recommendations
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  brand TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('temizleyici', 'tonik', 'serum', 'nemlendirici', 'spf', 'goz_kremi')),
  price_range TEXT NOT NULL,
  suitable_concerns TEXT[] NOT NULL DEFAULT '{}',
  image_url TEXT NOT NULL DEFAULT '',
  affiliate_url TEXT NOT NULL DEFAULT '',
  rating DOUBLE PRECISION NOT NULL DEFAULT 4.0 CHECK (rating >= 1.0 AND rating <= 5.0),
  description TEXT NOT NULL DEFAULT '',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- RLS: authenticated users can only read
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can read products"
  ON products FOR SELECT
  TO authenticated
  USING (true);

-- Index for concern-based queries
CREATE INDEX idx_products_concerns ON products USING GIN (suitable_concerns);
CREATE INDEX idx_products_category ON products (category);

-- Seed 24 sample products (4 per category)

-- Temizleyici (Cleanser)
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Gentle Foaming Cleanser', 'CeraVe', 'temizleyici', '₺250-350', ARRAY['acne', 'oiliness', 'pores'], 'https://placehold.co/200x200/E8F5E9/2E7D32?text=CeraVe', 'https://example.com/cerave-cleanser', 4.7, 'Köpüren yüz temizleyici, hassas ciltler için ideal. Seramidlerle cilt bariyerini korur.'),
('Salicylic Acid Cleanser', 'La Roche-Posay', 'temizleyici', '₺300-400', ARRAY['acne', 'pores', 'oiliness'], 'https://placehold.co/200x200/E3F2FD/1565C0?text=LRP', 'https://example.com/lrp-cleanser', 4.5, 'Salisilik asit içeren temizleyici, gözenekleri derinlemesine temizler.'),
('Rice Wash Cleanser', 'The Face Shop', 'temizleyici', '₺150-200', ARRAY['dryness', 'spots', 'redness'], 'https://placehold.co/200x200/FFF3E0/E65100?text=TFS', 'https://example.com/tfs-rice', 4.3, 'Pirinç özlü yumuşak temizleyici, kuruluğa eğilimli ciltler için.'),
('Green Tea Cleanser', 'Innisfree', 'temizleyici', '₺200-280', ARRAY['oiliness', 'redness', 'acne'], 'https://placehold.co/200x200/E8F5E9/388E3C?text=Innisfree', 'https://example.com/innisfree-cleanser', 4.4, 'Yeşil çay özlü temizleyici, yağlı ve karma ciltler için antioksidan koruma.');

-- Tonik (Toner)
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Glycolic Acid Toner', 'The Ordinary', 'tonik', '₺200-280', ARRAY['spots', 'pores', 'wrinkles'], 'https://placehold.co/200x200/F3E5F5/7B1FA2?text=TO', 'https://example.com/to-glycolic', 4.6, 'Glikolik asit tonik, cilt tonunu eşitler ve gözenekleri sıkılaştırır.'),
('Centella Toner', 'COSRX', 'tonik', '₺180-250', ARRAY['redness', 'acne', 'dryness'], 'https://placehold.co/200x200/E0F7FA/00838F?text=COSRX', 'https://example.com/cosrx-centella', 4.5, 'Centella asiatica özlü yatıştırıcı tonik, kızarıklığı azaltır.'),
('Hyaluronic Acid Toner', 'Hada Labo', 'tonik', '₺150-220', ARRAY['dryness', 'wrinkles'], 'https://placehold.co/200x200/E1F5FE/0277BD?text=HadaLabo', 'https://example.com/hadalabo-toner', 4.7, 'Hyaluronik asit tonik, cildi derinlemesine nemlendirir.'),
('BHA Toner', 'Paula''s Choice', 'tonik', '₺350-450', ARRAY['acne', 'pores', 'oiliness'], 'https://placehold.co/200x200/FCE4EC/C62828?text=PC', 'https://example.com/pc-bha', 4.8, 'BHA eksfoliye edici tonik, siyah noktalar ve gözenekler için etkili.');

-- Serum
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Niacinamide 10% + Zinc 1%', 'The Ordinary', 'serum', '₺150-200', ARRAY['acne', 'pores', 'oiliness', 'spots'], 'https://placehold.co/200x200/F3E5F5/6A1B9A?text=TO+Nia', 'https://example.com/to-niacinamide', 4.6, 'Niasinamid serum, gözenekleri küçültür ve sebum üretimini dengeler.'),
('Vitamin C Serum', 'Kiehl''s', 'serum', '₺500-650', ARRAY['spots', 'wrinkles', 'dryness'], 'https://placehold.co/200x200/FFF8E1/F57F17?text=Kiehls', 'https://example.com/kiehls-vitc', 4.5, 'C vitamini serumu, leke giderici ve aydınlatıcı etki.'),
('Retinol Serum', 'La Roche-Posay', 'serum', '₺400-550', ARRAY['wrinkles', 'spots', 'pores'], 'https://placehold.co/200x200/E3F2FD/1976D2?text=LRP+Ret', 'https://example.com/lrp-retinol', 4.4, 'Retinol serum, kırışıklık ve ince çizgileri azaltır.'),
('Hyaluronic Acid Serum', 'Vichy', 'serum', '₺350-450', ARRAY['dryness', 'wrinkles'], 'https://placehold.co/200x200/E8EAF6/283593?text=Vichy', 'https://example.com/vichy-ha', 4.7, 'Hyaluronik asit serum, cildi dolgunlaştırır ve yoğun nem sağlar.');

-- Nemlendirici (Moisturizer)
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Moisturizing Cream', 'CeraVe', 'nemlendirici', '₺280-380', ARRAY['dryness', 'redness'], 'https://placehold.co/200x200/E8F5E9/1B5E20?text=CeraVe+M', 'https://example.com/cerave-moisturizer', 4.8, 'Seramid içeren nemlendirici krem, cilt bariyerini onarır.'),
('Oil-Free Moisturizer', 'Neutrogena', 'nemlendirici', '₺180-250', ARRAY['oiliness', 'acne', 'pores'], 'https://placehold.co/200x200/E3F2FD/0D47A1?text=Neutro', 'https://example.com/neutrogena-moisturizer', 4.3, 'Yağsız nemlendirici, yağlı ve akneye eğilimli ciltler için hafif formül.'),
('Aqua Bomb Cream', 'Belif', 'nemlendirici', '₺400-500', ARRAY['dryness', 'wrinkles', 'redness'], 'https://placehold.co/200x200/E0F7FA/006064?text=Belif', 'https://example.com/belif-aqua', 4.6, 'Su bazlı nemlendirici, cildi 26 saat boyunca nemli tutar.'),
('Aloe Vera Gel', 'Nature Republic', 'nemlendirici', '₺100-150', ARRAY['redness', 'acne', 'dryness'], 'https://placehold.co/200x200/C8E6C9/2E7D32?text=NR+Aloe', 'https://example.com/nr-aloe', 4.4, 'Aloe vera jeli, yatıştırıcı ve hafif nemlendirici.');

-- SPF (Sunscreen)
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Anthelios SPF 50+', 'La Roche-Posay', 'spf', '₺350-450', ARRAY['spots', 'wrinkles', 'redness'], 'https://placehold.co/200x200/FFF9C4/F57F17?text=LRP+SPF', 'https://example.com/lrp-spf', 4.8, 'Geniş spektrumlu güneş koruyucu, leke önleyici ve anti-aging etki.'),
('Watery Essence SPF 50', 'Biore', 'spf', '₺150-220', ARRAY['oiliness', 'acne'], 'https://placehold.co/200x200/E1F5FE/01579B?text=Biore', 'https://example.com/biore-spf', 4.5, 'Hafif sulu formül, yağlı ciltler için mat bitişli güneş koruyucu.'),
('Mineral Sunscreen SPF 40', 'Avene', 'spf', '₺300-400', ARRAY['redness', 'dryness', 'spots'], 'https://placehold.co/200x200/FBE9E7/BF360C?text=Avene', 'https://example.com/avene-spf', 4.4, 'Mineral güneş koruyucu, hassas ve kızarıklığa eğilimli ciltler için.'),
('Daily UV Defense SPF 50', 'Kiehl''s', 'spf', '₺450-550', ARRAY['wrinkles', 'spots'], 'https://placehold.co/200x200/FFF8E1/FF8F00?text=Kiehls+SPF', 'https://example.com/kiehls-spf', 4.6, 'Günlük güneş koruyucu, anti-aging ve aydınlatıcı özellikli.');

-- Göz Kremi (Eye Cream)
INSERT INTO products (name, brand, category, price_range, suitable_concerns, image_url, affiliate_url, rating, description) VALUES
('Caffeine Eye Serum', 'The Ordinary', 'goz_kremi', '₺130-180', ARRAY['darkCircles', 'wrinkles'], 'https://placehold.co/200x200/F3E5F5/4A148C?text=TO+Eye', 'https://example.com/to-caffeine', 4.5, 'Kafein içeren göz serumu, koyu halkaları ve şişlikleri azaltır.'),
('Eye Cream Advanced', 'Kiehl''s', 'goz_kremi', '₺550-700', ARRAY['wrinkles', 'darkCircles'], 'https://placehold.co/200x200/FFF8E1/E65100?text=Kiehls+Eye', 'https://example.com/kiehls-eye', 4.6, 'Avokado yağlı göz kremi, kırışıklık ve kuru göz çevresi için.'),
('Retinol Eye Cream', 'Neutrogena', 'goz_kremi', '₺200-280', ARRAY['wrinkles', 'darkCircles', 'spots'], 'https://placehold.co/200x200/E3F2FD/1565C0?text=Neutro+Eye', 'https://example.com/neutrogena-eye', 4.3, 'Retinol içeren göz kremi, göz çevresi kırışıklıkları için.'),
('Snail Eye Cream', 'COSRX', 'goz_kremi', '₺180-250', ARRAY['darkCircles', 'dryness', 'wrinkles'], 'https://placehold.co/200x200/E0F7FA/00695C?text=COSRX+Eye', 'https://example.com/cosrx-eye', 4.4, 'Salyangoz müsini içeren göz kremi, besleyici ve yenileyici.');
