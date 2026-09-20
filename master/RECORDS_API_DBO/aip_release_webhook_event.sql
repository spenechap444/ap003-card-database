-- Undoes a claim when processing failed, so Telnyx's retry of the same event
-- is processed instead of being skipped as a duplicate.
-- Returns TRUE if a row was removed, FALSE if the event wasn't recorded.
CREATE OR REPLACE FUNCTION RECORDS_API_DBO.AIP_RELEASE_WEBHOOK_EVENT (
	P_EVENT_ID_I		IN VARCHAR(100)
)
RETURNS BOOLEAN
AS $$
BEGIN
	DELETE FROM RECORDS_DBO.TELNYX_WEBHOOK_EVENT
	WHERE EVENT_ID = P_EVENT_ID_I;

	RETURN FOUND;

	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in AIP_RELEASE_WEBHOOK_EVENT: % (SQLSTATE %)', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;
