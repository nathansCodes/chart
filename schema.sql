--
-- PostgreSQL database dump
--

\restrict 2jXpMc58auyJxffYOaF9kfc8bjYbeGJ7ZXDweOBix72zNmslcXWomAO2dBbuOFb

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-10 18:27:29 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17497)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    p_id integer NOT NULL,
    p_vorname character varying(255),
    p_nachname character varying(255)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17496)
-- Name: person_p_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_p_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_p_id_seq OWNER TO postgres;

--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 221
-- Name: person_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_p_id_seq OWNED BY public.person.p_id;


--
-- TOC entry 224 (class 1259 OID 17507)
-- Name: person_rolle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person_rolle (
    pr_id integer NOT NULL,
    pr_person_id integer,
    pr_rolle_id integer,
    pr_eintritt date,
    pr_austritt date,
    pr_vorgesetzter integer
);


ALTER TABLE public.person_rolle OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17506)
-- Name: person_rolle_pr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_rolle_pr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_rolle_pr_id_seq OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 223
-- Name: person_rolle_pr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_rolle_pr_id_seq OWNED BY public.person_rolle.pr_id;


--
-- TOC entry 220 (class 1259 OID 17489)
-- Name: rolle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rolle (
    r_id integer NOT NULL,
    r_bezeichnung character varying(255)
);


ALTER TABLE public.rolle OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17488)
-- Name: rolle_r_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rolle_r_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rolle_r_id_seq OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 219
-- Name: rolle_r_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rolle_r_id_seq OWNED BY public.rolle.r_id;


--
-- TOC entry 3302 (class 2604 OID 17500)
-- Name: person p_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN p_id SET DEFAULT nextval('public.person_p_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 17510)
-- Name: person_rolle pr_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_rolle ALTER COLUMN pr_id SET DEFAULT nextval('public.person_rolle_pr_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 17492)
-- Name: rolle r_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolle ALTER COLUMN r_id SET DEFAULT nextval('public.rolle_r_id_seq'::regclass);


--
-- TOC entry 3463 (class 0 OID 17497)
-- Dependencies: 222
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES (1, 'Mark', 'Graf');
INSERT INTO public.person VALUES (2, 'Hubert-Peter', 'Neinberger');
INSERT INTO public.person VALUES (3, 'Helmut', 'Krastavac');
INSERT INTO public.person VALUES (4, 'Kristoph', 'Dreimauer');
INSERT INTO public.person VALUES (5, 'Susanne', 'Gerster');
INSERT INTO public.person VALUES (6, 'Josef', 'Siegbert');
INSERT INTO public.person VALUES (7, 'Rudolph', 'Wilfried');
INSERT INTO public.person VALUES (8, 'Alfred', 'Niklaus');
INSERT INTO public.person VALUES (9, 'Samuel', 'Boettinger');
INSERT INTO public.person VALUES (10, 'Marwin', 'Edeltraud');
INSERT INTO public.person VALUES (11, 'Brigitte', 'Hannah');
INSERT INTO public.person VALUES (12, 'Dietrich', 'Tiedemann');
INSERT INTO public.person VALUES (13, 'Annelise', 'Meinhard');
INSERT INTO public.person VALUES (14, 'Lara', 'Sigrid');
INSERT INTO public.person VALUES (15, 'Tilman', 'Edeltraud');
INSERT INTO public.person VALUES (16, 'Martin', 'Irmengard');


--
-- TOC entry 3465 (class 0 OID 17507)
-- Dependencies: 224
-- Data for Name: person_rolle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person_rolle VALUES (1, 1, 1, '2003-08-08', NULL, NULL);
INSERT INTO public.person_rolle VALUES (2, 2, 2, '2011-02-27', NULL, 1);
INSERT INTO public.person_rolle VALUES (3, 3, 3, '2016-11-03', NULL, 2);
INSERT INTO public.person_rolle VALUES (4, 4, 4, '2023-04-17', NULL, 3);
INSERT INTO public.person_rolle VALUES (5, 5, 2, '2023-04-17', NULL, 1);
INSERT INTO public.person_rolle VALUES (6, 6, 4, '2023-04-17', NULL, 7);
INSERT INTO public.person_rolle VALUES (7, 7, 3, '2023-04-17', NULL, 5);
INSERT INTO public.person_rolle VALUES (8, 8, 4, '2023-04-17', NULL, 7);
INSERT INTO public.person_rolle VALUES (9, 9, 4, '2023-04-17', NULL, 3);
INSERT INTO public.person_rolle VALUES (10, 10, 3, '2023-04-17', NULL, 2);
INSERT INTO public.person_rolle VALUES (11, 11, 3, '2023-04-17', NULL, 5);
INSERT INTO public.person_rolle VALUES (12, 12, 4, '2023-04-17', NULL, 10);
INSERT INTO public.person_rolle VALUES (13, 13, 4, '2023-04-17', NULL, 10);
INSERT INTO public.person_rolle VALUES (14, 14, 4, '2023-04-17', NULL, 11);
INSERT INTO public.person_rolle VALUES (15, 15, 4, '2023-04-17', NULL, 11);


--
-- TOC entry 3461 (class 0 OID 17489)
-- Dependencies: 220
-- Data for Name: rolle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rolle VALUES (1, 'Generalinspekteur');
INSERT INTO public.rolle VALUES (2, 'Major');
INSERT INTO public.rolle VALUES (3, 'Leutnant');
INSERT INTO public.rolle VALUES (4, 'Unteroffizier');


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 221
-- Name: person_p_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_p_id_seq', 16, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 223
-- Name: person_rolle_pr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_rolle_pr_id_seq', 15, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 219
-- Name: rolle_r_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rolle_r_id_seq', 4, true);


--
-- TOC entry 3307 (class 2606 OID 17505)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (p_id);


--
-- TOC entry 3309 (class 2606 OID 17513)
-- Name: person_rolle person_rolle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_rolle
    ADD CONSTRAINT person_rolle_pkey PRIMARY KEY (pr_id);


--
-- TOC entry 3305 (class 2606 OID 17495)
-- Name: rolle rolle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolle
    ADD CONSTRAINT rolle_pkey PRIMARY KEY (r_id);


--
-- TOC entry 3310 (class 2606 OID 17514)
-- Name: person_rolle person_rolle_pr_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_rolle
    ADD CONSTRAINT person_rolle_pr_person_id_fkey FOREIGN KEY (pr_person_id) REFERENCES public.person(p_id);


--
-- TOC entry 3311 (class 2606 OID 17519)
-- Name: person_rolle person_rolle_pr_rolle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_rolle
    ADD CONSTRAINT person_rolle_pr_rolle_id_fkey FOREIGN KEY (pr_rolle_id) REFERENCES public.rolle(r_id);


--
-- TOC entry 3312 (class 2606 OID 17524)
-- Name: person_rolle person_rolle_pr_vorgesetzter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person_rolle
    ADD CONSTRAINT person_rolle_pr_vorgesetzter_fkey FOREIGN KEY (pr_vorgesetzter) REFERENCES public.person_rolle(pr_id);


-- Completed on 2025-11-10 18:27:29 CET

--
-- PostgreSQL database dump complete
--

\unrestrict 2jXpMc58auyJxffYOaF9kfc8bjYbeGJ7ZXDweOBix72zNmslcXWomAO2dBbuOFb

