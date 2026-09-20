-- Returns TRUE if this call recorded the event (first delivery - process it),
-- FALSE if it was already recorded (a Telnyx redelivery - skip it).
-- ON CONFLICT keeps this safe when two deliveries of the same event race.
CREATE OR REPLACE FUNCTION RECORDS_API_DBO.AIP_CLAIM_WEBHOOK_EVENT (
	P_EVENT_ID_I		IN VARCHAR(100),
	P_EVENT_TYPE_I		IN VARCHAR(50)
)
RETURNS BOOLEAN
AS $$
BEGIN
	IF P_EVENT_ID_I IS NULL OR P_EVENT_TYPE_I IS NULL THEN
		RAISE EXCEPTION 'Input parameters cannot be null';
	END IF;

	INSERT INTO RECORDS_DBO.TELNYX_WEBHOOK_EVENT (
		EVENT_ID,
		EVENT_TYPE
	) VALUES (
		P_EVENT_ID_I,
		P_EVENT_TYPE_I
	)
	ON CONFLICT (EVENT_ID) DO NOTHING;

	-- FOUND is TRUE only if the INSERT actually wrote a row.
	RETURN FOUND;

	EXCEPTION WHEN OTHERS THEN
		RAISE EXCEPTION 'Error in AIP_CLAIM_WEBHOOK_EVENT: % (SQLSTATE %)', SQLERRM, SQLSTATE;
END;
$$ LANGUAGE plpgsql;
