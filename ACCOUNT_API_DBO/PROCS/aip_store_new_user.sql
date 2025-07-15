CREATE OR REPLACE PROCEDURE account_api_dbo.aip_store_new_user(
	IN p_first_name_i character varying,
	IN p_last_name_i character varying,
	IN p_user_name_i character varying,
	IN p_email_i character varying,
	IN p_user_password_i character varying,
	IN p_bio_i character varying,
	IN p_account_id_i character varying,
	IN p_notifications_i boolean)

AS $$
DECLARE
BEGIN
  INSERT INTO ACCOUNT_DBO.USERS(FIRST_NAME,
                               LAST_NAME,
                               USER_NAME,
                               EMAIL,
                               USER_PASSWORD,
                               BIO,
                               ACCOUNT_ID,
                               NOTIFICATIONS,
                               CREATE_ID,
                               CREATE_TS,
                               UPDATE_ID,
                               UPDATE_TS,
                               JOIN_DATE,
							   PHONE_NBR)
                    VALUES (P_FIRST_NAME_I,
                            P_LAST_NAME_I,
                            P_USER_NAME_I,
                            P_EMAIL_I,
                            P_USER_PASSWORD_I,
                            P_BIO_I,
                            P_ACCOUNT_ID_I,
                            P_NOTIFICATIONS_I,
                            CURRENT_USER,
                            CURRENT_TIMESTAMP,
                            NULL,
                            NULL,
                            CURRENT_TIMESTAMP,
						   NULL);

    EXCEPTION 
      WHEN OTHERS THEN
        RAISE EXCEPTION 'Error in procedure account_api_dbo.aip_store_new_user (%)', SQLERRM;
END;
$$ LANGUAGE plpgsql;