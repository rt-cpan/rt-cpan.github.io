--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: u95214; Type: USER ROLE; Schema: -
--

CREATE USER u95214;

--
-- Name: p95214; Type: DATABASE; Schema: -; Owner: u95214
--

CREATE DATABASE p95214 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE p95214 OWNER TO u95214;

\connect p95214

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

--
-- Name: nametable; Type: TABLE; Schema: public; Owner: u95214; Tablespace: 
--

CREATE TABLE nametable (
    fname text,
    lname text
);


ALTER TABLE public.nametable OWNER TO u95214;

--
-- Name: testtable; Type: TABLE; Schema: public; Owner: u95214; Tablespace: 
--

CREATE TABLE testtable (
    file1 bytea,
    file2 bytea
);


ALTER TABLE public.testtable OWNER TO u95214;

--
-- Data for Name: nametable; Type: TABLE DATA; Schema: public; Owner: u95214
--

COPY nametable (fname, lname) FROM stdin;
Hubert Q.	Farnsworth Junior
\.


--
-- Data for Name: testtable; Type: TABLE DATA; Schema: public; Owner: u95214
--

COPY testtable (file1, file2) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--
