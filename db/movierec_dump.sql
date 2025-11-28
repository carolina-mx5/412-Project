--
-- PostgreSQL database dump
--

\restrict 4VIlLlJDZLZije7rRRZ3OQxVttvvqE7Dco4EUgp4yOJhjZiEwnSPO6iCOEdMB1Z

-- Dumped from database version 15.14
-- Dumped by pg_dump version 15.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tables; Type: SCHEMA; Schema: -; Owner: carolina
--

CREATE SCHEMA tables;


ALTER SCHEMA tables OWNER TO carolina;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acted_in; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.acted_in (
    a_id integer NOT NULL,
    m_id integer,
    s_id integer,
    CONSTRAINT acted_in_check CHECK ((((m_id IS NOT NULL) AND (s_id IS NULL)) OR ((m_id IS NULL) AND (s_id IS NOT NULL))))
);


ALTER TABLE tables.acted_in OWNER TO carolina;

--
-- Name: actor; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.actor (
    a_id integer NOT NULL,
    a_firstname text NOT NULL,
    a_lastname text NOT NULL
);


ALTER TABLE tables.actor OWNER TO carolina;

--
-- Name: actor_a_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.actor_a_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.actor_a_id_seq OWNER TO carolina;

--
-- Name: actor_a_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.actor_a_id_seq OWNED BY tables.actor.a_id;


--
-- Name: genre; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.genre (
    g_id integer NOT NULL,
    g_name text NOT NULL
);


ALTER TABLE tables.genre OWNER TO carolina;

--
-- Name: genre_g_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.genre_g_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.genre_g_id_seq OWNER TO carolina;

--
-- Name: genre_g_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.genre_g_id_seq OWNED BY tables.genre.g_id;


--
-- Name: hasmoviegenre; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.hasmoviegenre (
    m_id integer NOT NULL,
    g_id integer NOT NULL
);


ALTER TABLE tables.hasmoviegenre OWNER TO carolina;

--
-- Name: hasshowgenre; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.hasshowgenre (
    s_id integer NOT NULL,
    g_id integer NOT NULL
);


ALTER TABLE tables.hasshowgenre OWNER TO carolina;

--
-- Name: movie; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.movie (
    m_id integer NOT NULL,
    m_title text NOT NULL,
    m_releaseyear integer,
    m_duration integer,
    m_rating text
);


ALTER TABLE tables.movie OWNER TO carolina;

--
-- Name: movie_m_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.movie_m_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.movie_m_id_seq OWNER TO carolina;

--
-- Name: movie_m_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.movie_m_id_seq OWNED BY tables.movie.m_id;


--
-- Name: review; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.review (
    r_id integer NOT NULL,
    r_comment text,
    r_rating integer,
    r_date date DEFAULT CURRENT_DATE NOT NULL,
    u_id integer NOT NULL,
    m_id integer,
    s_id integer,
    CONSTRAINT review_check CHECK ((((m_id IS NOT NULL) AND (s_id IS NULL)) OR ((m_id IS NULL) AND (s_id IS NOT NULL)))),
    CONSTRAINT review_r_rating_check CHECK (((r_rating >= 1) AND (r_rating <= 5)))
);


ALTER TABLE tables.review OWNER TO carolina;

--
-- Name: review_r_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.review_r_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.review_r_id_seq OWNER TO carolina;

--
-- Name: review_r_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.review_r_id_seq OWNED BY tables.review.r_id;


--
-- Name: show; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.show (
    s_id integer NOT NULL,
    s_title text NOT NULL,
    s_releaseyear integer,
    s_duration integer,
    s_rating text
);


ALTER TABLE tables.show OWNER TO carolina;

--
-- Name: show_s_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.show_s_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.show_s_id_seq OWNER TO carolina;

--
-- Name: show_s_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.show_s_id_seq OWNED BY tables.show.s_id;


--
-- Name: users; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.users (
    u_id integer NOT NULL,
    u_firstname text NOT NULL,
    u_lastname text NOT NULL
);


ALTER TABLE tables.users OWNER TO carolina;

--
-- Name: users_u_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.users_u_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.users_u_id_seq OWNER TO carolina;

--
-- Name: users_u_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.users_u_id_seq OWNED BY tables.users.u_id;


--
-- Name: watchlist; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.watchlist (
    w_id integer NOT NULL,
    u_id integer NOT NULL
);


ALTER TABLE tables.watchlist OWNER TO carolina;

--
-- Name: watchlist_item; Type: TABLE; Schema: tables; Owner: carolina
--

CREATE TABLE tables.watchlist_item (
    w_id integer NOT NULL,
    m_id integer,
    s_id integer,
    CONSTRAINT watch_item_check CHECK ((((m_id IS NOT NULL) AND (s_id IS NULL)) OR ((m_id IS NULL) AND (s_id IS NOT NULL))))
);


ALTER TABLE tables.watchlist_item OWNER TO carolina;

--
-- Name: watchlist_w_id_seq; Type: SEQUENCE; Schema: tables; Owner: carolina
--

CREATE SEQUENCE tables.watchlist_w_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tables.watchlist_w_id_seq OWNER TO carolina;

--
-- Name: watchlist_w_id_seq; Type: SEQUENCE OWNED BY; Schema: tables; Owner: carolina
--

ALTER SEQUENCE tables.watchlist_w_id_seq OWNED BY tables.watchlist.w_id;


--
-- Name: actor a_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.actor ALTER COLUMN a_id SET DEFAULT nextval('tables.actor_a_id_seq'::regclass);


--
-- Name: genre g_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.genre ALTER COLUMN g_id SET DEFAULT nextval('tables.genre_g_id_seq'::regclass);


--
-- Name: movie m_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.movie ALTER COLUMN m_id SET DEFAULT nextval('tables.movie_m_id_seq'::regclass);


--
-- Name: review r_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.review ALTER COLUMN r_id SET DEFAULT nextval('tables.review_r_id_seq'::regclass);


--
-- Name: show s_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.show ALTER COLUMN s_id SET DEFAULT nextval('tables.show_s_id_seq'::regclass);


--
-- Name: users u_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.users ALTER COLUMN u_id SET DEFAULT nextval('tables.users_u_id_seq'::regclass);


--
-- Name: watchlist w_id; Type: DEFAULT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist ALTER COLUMN w_id SET DEFAULT nextval('tables.watchlist_w_id_seq'::regclass);


--
-- Data for Name: acted_in; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.acted_in (a_id, m_id, s_id) FROM stdin;
1	1	\N
2	2	\N
3	3	\N
4	4	\N
5	5	\N
6	6	\N
7	7	\N
8	8	\N
9	9	\N
10	10	\N
11	\N	1
12	\N	2
13	\N	3
14	\N	4
15	\N	5
16	\N	6
17	\N	7
18	\N	8
19	\N	9
20	\N	10
\.


--
-- Data for Name: actor; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.actor (a_id, a_firstname, a_lastname) FROM stdin;
1	David	Bowie
2	Jack	Black
3	Christopher	Lambert
4	Emma	Stone
5	Ginnifer	Goodwin
7	Emily	Watson
8	Chris	Pine
9	Antonio	Banderas
10	Karl	Urban
11	Jona	Xiao
12	Louisa	Harland
13	Chicha	Amatayakul
14	Andrea	Libman
15	Kensho	Ono
16	Alejandra	Reynoso
17	Avery	Brooks
18	Tom	Ellis
19	Josh	Dallas
20	Chase	Stokes
6	Chris	Evans
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.genre (g_id, g_name) FROM stdin;
1	TV Dramas
2	TV Romance
3	TV Comedies
4	TV Horror
5	Kids' TV
6	TV Mysteries
7	Reality TV
8	Thrillers
9	Actions
10	Dramas
11	Romantic Movies
12	International Movies
13	Crime TV Shows
14	Children & Family Movies
\.


--
-- Data for Name: hasmoviegenre; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.hasmoviegenre (m_id, g_id) FROM stdin;
1	10
1	12
2	14
3	9
4	8
5	14
6	9
7	10
8	9
9	9
9	12
10	9
\.


--
-- Data for Name: hasshowgenre; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.hasshowgenre (s_id, g_id) FROM stdin;
1	1
1	4
1	6
2	1
2	2
2	3
3	1
3	4
3	6
4	1
4	3
4	5
5	1
5	4
5	6
6	1
6	4
7	1
8	1
8	2
8	3
9	1
9	2
10	1
10	2
10	3
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.movie (m_id, m_title, m_releaseyear, m_duration, m_rating) FROM stdin;
2	Kung Fu Panda	2008	94	4.8
3	Mortal Kombat	1995	101	3.8
4	Zombieland	2009	88	3.7
5	Tinker Bell and the Legend of the NeverBeast	2014	78	4.8
6	Thor: Ragnarok	2017	131	4.7
7	War Horse	2011	147	4.5
8	Star Trek	2009	128	4.5
9	Acts of Vengeance	2017	87	4
10	Doom	2005	105	3.6
1	Pan's Labyrinth	1986	101	4.6
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.review (r_id, r_comment, r_rating, r_date, u_id, m_id, s_id) FROM stdin;
\.


--
-- Data for Name: show; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.show (s_id, s_title, s_releaseyear, s_duration, s_rating) FROM stdin;
1	RESIDENT EVIL:Infinite Darkness	2021	1	3.5
2	Derry Girls	2018	3	4.9
3	Girl from Nowhere	2018	2	4.7
4	My Little Pony: Friendship is Magic	2010	9	4.6
5	JoJo's Bizarre Adventure	2012	5	4.7
6	Castlevania	2017	4	4.8
7	Star Trek: Deep Space Nine	1993	7	4.7
8	Lucifer	2016	6	4
9	Manifest	2018	4	3.5
10	Outer Banks	2020	4	4
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.users (u_id, u_firstname, u_lastname) FROM stdin;
1	Leonard	McCoy
2	James	Kirk
3	Nyota	Urhura
4	Twilight	Sparkle
5	Rainbow	Dash
6	Goblin	King
7	Tinker	Bell
8	Johnny	Cage
9	Po	Panda
10	Luke	Skywalker
11	Leia	Organa
14	Test	Subject
12	Demo	Wonder
\.


--
-- Data for Name: watchlist; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.watchlist (w_id, u_id) FROM stdin;
\.


--
-- Data for Name: watchlist_item; Type: TABLE DATA; Schema: tables; Owner: carolina
--

COPY tables.watchlist_item (w_id, m_id, s_id) FROM stdin;
\.


--
-- Name: actor_a_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.actor_a_id_seq', 20, true);


--
-- Name: genre_g_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.genre_g_id_seq', 14, true);


--
-- Name: movie_m_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.movie_m_id_seq', 12, true);


--
-- Name: review_r_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.review_r_id_seq', 1, false);


--
-- Name: show_s_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.show_s_id_seq', 10, true);


--
-- Name: users_u_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.users_u_id_seq', 15, true);


--
-- Name: watchlist_w_id_seq; Type: SEQUENCE SET; Schema: tables; Owner: carolina
--

SELECT pg_catalog.setval('tables.watchlist_w_id_seq', 1, false);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (a_id);


--
-- Name: genre genre_g_name_key; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.genre
    ADD CONSTRAINT genre_g_name_key UNIQUE (g_name);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (g_id);


--
-- Name: hasmoviegenre hasmoviegenre_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasmoviegenre
    ADD CONSTRAINT hasmoviegenre_pkey PRIMARY KEY (m_id, g_id);


--
-- Name: hasshowgenre hasshowgenre_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasshowgenre
    ADD CONSTRAINT hasshowgenre_pkey PRIMARY KEY (s_id, g_id);


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (m_id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (r_id);


--
-- Name: show show_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.show
    ADD CONSTRAINT show_pkey PRIMARY KEY (s_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (u_id);


--
-- Name: watchlist watchlist_pkey; Type: CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist
    ADD CONSTRAINT watchlist_pkey PRIMARY KEY (w_id);


--
-- Name: acted_in acted_in_a_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.acted_in
    ADD CONSTRAINT acted_in_a_id_fkey FOREIGN KEY (a_id) REFERENCES tables.actor(a_id) ON DELETE RESTRICT;


--
-- Name: acted_in acted_in_m_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.acted_in
    ADD CONSTRAINT acted_in_m_id_fkey FOREIGN KEY (m_id) REFERENCES tables.movie(m_id) ON DELETE CASCADE;


--
-- Name: acted_in acted_in_s_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.acted_in
    ADD CONSTRAINT acted_in_s_id_fkey FOREIGN KEY (s_id) REFERENCES tables.show(s_id) ON DELETE CASCADE;


--
-- Name: hasmoviegenre hasmoviegenre_g_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasmoviegenre
    ADD CONSTRAINT hasmoviegenre_g_id_fkey FOREIGN KEY (g_id) REFERENCES tables.genre(g_id) ON DELETE RESTRICT;


--
-- Name: hasmoviegenre hasmoviegenre_m_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasmoviegenre
    ADD CONSTRAINT hasmoviegenre_m_id_fkey FOREIGN KEY (m_id) REFERENCES tables.movie(m_id) ON DELETE CASCADE;


--
-- Name: hasshowgenre hasshowgenre_g_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasshowgenre
    ADD CONSTRAINT hasshowgenre_g_id_fkey FOREIGN KEY (g_id) REFERENCES tables.genre(g_id) ON DELETE RESTRICT;


--
-- Name: hasshowgenre hasshowgenre_s_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.hasshowgenre
    ADD CONSTRAINT hasshowgenre_s_id_fkey FOREIGN KEY (s_id) REFERENCES tables.show(s_id) ON DELETE CASCADE;


--
-- Name: review review_m_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.review
    ADD CONSTRAINT review_m_id_fkey FOREIGN KEY (m_id) REFERENCES tables.movie(m_id) ON DELETE CASCADE;


--
-- Name: review review_s_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.review
    ADD CONSTRAINT review_s_id_fkey FOREIGN KEY (s_id) REFERENCES tables.show(s_id) ON DELETE CASCADE;


--
-- Name: review review_u_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.review
    ADD CONSTRAINT review_u_id_fkey FOREIGN KEY (u_id) REFERENCES tables.users(u_id) ON DELETE CASCADE;


--
-- Name: watchlist_item watchlist_item_m_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist_item
    ADD CONSTRAINT watchlist_item_m_id_fkey FOREIGN KEY (m_id) REFERENCES tables.movie(m_id) ON DELETE CASCADE;


--
-- Name: watchlist_item watchlist_item_s_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist_item
    ADD CONSTRAINT watchlist_item_s_id_fkey FOREIGN KEY (s_id) REFERENCES tables.show(s_id) ON DELETE CASCADE;


--
-- Name: watchlist_item watchlist_item_w_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist_item
    ADD CONSTRAINT watchlist_item_w_id_fkey FOREIGN KEY (w_id) REFERENCES tables.watchlist(w_id) ON DELETE CASCADE;


--
-- Name: watchlist watchlist_u_id_fkey; Type: FK CONSTRAINT; Schema: tables; Owner: carolina
--

ALTER TABLE ONLY tables.watchlist
    ADD CONSTRAINT watchlist_u_id_fkey FOREIGN KEY (u_id) REFERENCES tables.users(u_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 4VIlLlJDZLZije7rRRZ3OQxVttvvqE7Dco4EUgp4yOJhjZiEwnSPO6iCOEdMB1Z

