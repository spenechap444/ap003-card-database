CREATE OR REPLACE FUNCTION product_api_dbo.aip_fetch_card_products(p_product_name_i	 VARCHAR,
																   p_product_category_i VARCHAR,
																   p_game_or_sport_i	VARCHAR,
																   p_set_name_i		 VARCHAR,
																   p_min_price_i	 DECIMAL(10, 2),
																   p_max_price_i	 DECIMAL(10, 2))
RETURNS TABLE (p_product_id_o VARCHAR(300),
			   p_product_name_o VARCHAR(100),
			   p_brand_o		VARCHAR(50),
			   p_product_category_o VARCHAR(100),
			   p_game_or_sport_o	VARCHAR(10),
			   p_set_name_o			VARCHAR(50),
			   p_release_date_o		DATE,
			   p_product_type_o		VARCHAR(50),
			   p_pack_count_o		INTEGER,
			   p_card_count_per_pack_o INTEGER,
			   p_total_card_count_o	INTEGER,
			   p_promo_included_o	BOOLEAN,
			   p_promo_details_o		VARCHAR(300),
			   p_msrp_o				DECIMAL(10, 2),
			   p_cost_price_o		DECIMAL(10, 2),
			   p_sale_price_o		DECIMAL(10, 2),
			   p_sku_o				VARCHAR(100),
			   p_barcode_o			VARCHAR(300),
			   p_inventory_count_o	INTEGER,
			   p_image_url_o			VARCHAR(300),
			   p_description_o		VARCHAR(300),
			   p_sealed_o			BOOLEAN,
			   p_is_active_o		BOOLEAN)
AS $$
BEGIN
  SELECT product_id,
		 product_name,
		 brand,
		 product_category,
		 game_or_sport,
		 set_name,
		 release_date,
		 product_type,
		 pack_count,
		 card_count_per_pack,
		 total_card_count,
		 promo_included,
		 promo_details,
		 msrp,
		 cost_price,
		 sale_price,
		 sku,
		 barcode,
		 inventory_count,
		 image_url,
		 description,
		 sealed,
		 is_active
	FROM PRODUCT_DBO.CARD_PRODUCT
	WHERE product_name LIKE '%' || COALESCE(p_product_name_i, '') || '%'
	  AND product_category = COALESCE(p_product_category_i, product_category)
	  AND game_or_sport = COALESCE(p_game_or_sport_i, game_or_sport)
	  AND set_name LIKE '%' || COALESCE(p_set_name_i, '') || '%'
	  AND sale_price >= COALESCE(p_min_price_i, sale_price)
	  AND sale_price <= COALESCE(p_max_price_i, sale_price)
	LIMIT p_limit_i
	OFFSET p_offset_i;

EXCEPTION 
  WHEN OTHERS THEN
    RAISE EXCEPTION 'Exception encountered for PRODUCT_API_DBO.aip_fetch_card_products (%)', SQLERRM;
END;
$$ LANGUAGE plpgsql;