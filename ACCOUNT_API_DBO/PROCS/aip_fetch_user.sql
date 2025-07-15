CREATE OR REPLACE FUNCTION account_api_dbo.aip_fetch_user(
	p_email_i character varying)
    RETURNS TABLE(p_first_name_o character varying, 
                  p_last_name_o character varying, 
                  p_user_name_o character varying, 
                  p_email_o character varying, 
                  p_user_password_o character varying, 
                  p_bio_o character varying, 
                  p_account_id_o character varying, 
                  p_notifications_o boolean, 
                  p_join_date_o timestamp without time zone) 
AS $$
DECLARE
BEGIN
  RETURN QUERY SELECT first_name,
                        last_name,
                        user_name,
                        email,
                        user_password,
                        bio,
                        account_id,
                        notifications,
                        join_date
                FROM ACCOUNT_DBO.USERS
                WHERE email = p_email_i;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Error occurred for account_api_dbo.aip_fetch_user: (%)', SQLERRM;
END;
$$ LANGUAGE plpgsql;