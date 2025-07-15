CREATE TABLE IF NOT EXISTS account_dbo.users
(
    first_name character varying(50) COLLATE pg_catalog."default",
    last_name character varying(50) COLLATE pg_catalog."default",
    user_name character varying(50) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    user_password character varying(300) COLLATE pg_catalog."default" NOT NULL,
    bio character varying(300) COLLATE pg_catalog."default",
    account_id character varying(300) COLLATE pg_catalog."default" NOT NULL,
    notifications boolean,
    create_id character varying(30) COLLATE pg_catalog."default",
    create_ts timestamp without time zone,
    update_id character varying(30) COLLATE pg_catalog."default",
    update_ts timestamp without time zone,
    join_date timestamp without time zone,
    phone_nbr character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (account_id),
    CONSTRAINT users_email_key UNIQUE (email),
    CONSTRAINT users_user_name_key UNIQUE (user_name)
);
GRANT INSERT, UPDATE, DELETE, SELECT ON account_dbo.users TO APPUSER;