CREATE OR REPLACE FUNCTION product_api_dbo.aip_fetch_sports_cards(
	p_rookie_i 			BOOLEAN,
	p_autograph_flag_i 	BOOLEAN,
	p_patch_flag_i 		BOOLEAN,
	p_team_i			VARCHAR,
	p_numbered_flag_i	BOOLEAN,
	p_sport_type_cd_i   VARCHAR,
	p_product_cd_i		VARCHAR,
	p_variant_flag_i	BOOLEAN,
	p_grade_cd_i		VARCHAR,
	p_grade_score_i		DECIMAL,
	p_min_price_i		DECIMAL,
	p_max_price_i		DECIMAL,
	p_limit_i			INTEGER,
	p_offset_i			INTEGER)
RETURNS TABLE (p_card_id_o         VARCHAR(300),
			   p_player_name_o     VARCHAR(60),
			   p_rookie_o		   BOOLEAN,
			   p_autograph_cd_o	   VARCHAR(15),
			   p_patch_o		    VARCHAR(30),
			   p_patch_color_cnt_o	INTEGER,
			   p_team_o				VARCHAR(60),
			   p_numbered_o			VARCHAR(15),
			   p_sport_type_cd_o	VARCHAR(30),
			   p_product_cd_o		VARCHAR(30),
			   p_img_link_o			VARCHAR(300),
			   p_variant_o			BOOLEAN,
			   p_grade_type_o		VARCHAR(30),
			   p_grade_score_o		DECIMAL(3, 1),
			   p_msrp_o				DECIMAL(10, 2),
			   p_cost_price_o		DECIMAL(10, 2),
			   p_sale_price_o		DECIMAL(10, 2))
AS $$
DECLARE

BEGIN

	RETURN QUERY SELECT CARD_ID,
						PLAYER_NAME,
						ROOKIE,
						AUTOGRAPH_CD,
						PATCH,
						PATCH_COLOR_CNT,
						TEAM,
						NUMBERED,
						SPORT_TYPE_CD,
						PRODUCT_CD,
						IMG_LINK,
						VARIANT,
						GRADE_TYPE,
						GRADE_SCORE,
						MSRP,
						COST_PRICE,
						SALE_PRICE
					FROM PRODUCT_DBO.SPORTS_CARDS
					WHERE ROOKIE = COALESCE(p_rookie_i, ROOKIE)
					  AND COALESCE(AUTOGRAPH_CD, '~') = CASE WHEN p_autograph_flag_i = FALSE THEN
					  					 					COALESCE(AUTOGRAPH_CD, '~')
														 ELSE
														    AUTOGRAPH_CD
														 END
					  AND COALESCE(PATCH, '~') = CASE WHEN p_patch_flag_i = FALSE THEN
					   									COALESCE(PATCH, '~')
													   ELSE
													     PATCH
													    END
					 AND COALESCE(PATCH_COLOR_CNT, 0) >= COALESCE(p_patch_color_cnt_i, 0)
					 AND TEAM = COALESCE(p_team_i, TEAM)
					 AND COALESCE(NUMBERED, '~') = CASE WHEN p_numbered_flag_i = FALSE THEN
					 										COALESCE(NUMBERED, '~')
														ELSE
														  NUMBERED
														END
					 AND SPORT_TYPE_CD = COALESCE(p_sport_type_cd_i, SPORT_TYPE_CD)
					 AND PRODUCT_CD = COALESCE(p_product_cd_i, PRODUCT_CD)
					 AND VARIANT = COALESCE(p_variant_flag_i, VARIANT)
					 AND GRADE_CD = COALESCE(p_grade_cd_i, GRADE_CD)
					 AND COALESCE(GRADE_SCORE, 0) >= COALESCE(p_grade_score_i, 0)
					 AND SALE_PRICE >= COALESCE(p_min_price_i, sale_price)
					 AND SALE_PRICE <= COALESCE(p_max_price_i, sale_price)
					 ORDER BY CREATE_TS DESC
					 LIMIT p_limit_i
					 OFFSET p_offset_i;
EXCEPTION
  WHEN OTHERS THEN
    RAISE EXCEPTION 'Exception encountered for function product_api_dbo.aip_fetch_sports_cards (%)', SQLERRM;
END;
$$ LANGUAGE plpgsql;
					 