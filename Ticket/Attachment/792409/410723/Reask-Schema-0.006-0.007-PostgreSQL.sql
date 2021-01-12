-- Convert schema 'sql/Reask-Schema-0.006-PostgreSQL.sql' to 'sql/Reask-Schema-0.007-PostgreSQL.sql':;

BEGIN;

ALTER TABLE query DROP CONSTRAINT ;

ALTER TABLE query ALTER COLUMN user DROP NOT NULL;


COMMIT;

