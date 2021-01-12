CREATE TABLE t
(
  id1 integer NOT NULL,
  id2 integer NOT NULL,
  CONSTRAINT pkey PRIMARY KEY (id1, id2)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE t
  OWNER TO postgres;