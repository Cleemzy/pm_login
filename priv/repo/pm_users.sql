--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Ubuntu 12.6-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.6 (Ubuntu 12.6-1.pgdg18.04+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_clients (
    id bigint NOT NULL,
    user_id bigint,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.active_clients OWNER TO odoo;

--
-- Name: active_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_clients_id_seq OWNER TO odoo;

--
-- Name: active_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_clients_id_seq OWNED BY public.active_clients.id;


--
-- Name: assist_contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assist_contracts (
    id bigint NOT NULL,
    title character varying(255),
    date_start date,
    date_end date,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.assist_contracts OWNER TO odoo;

--
-- Name: assist_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assist_contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assist_contracts_id_seq OWNER TO odoo;

--
-- Name: assist_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assist_contracts_id_seq OWNED BY public.assist_contracts.id;


--
-- Name: rights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rights (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.rights OWNER TO odoo;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255),
    profile_picture character varying(255),
    email character varying(255),
    password character varying(255),
    right_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO odoo;

--
-- Name: auth; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.auth AS
 SELECT users.id,
    users.username,
    users.profile_picture,
    users.email,
    users.right_id,
    rights.title
   FROM (public.users
     JOIN public.rights ON ((users.right_id = rights.id)));


ALTER TABLE public.auth OWNER TO odoo;

--
-- Name: boards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boards (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.boards OWNER TO odoo;

--
-- Name: boards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.boards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boards_id_seq OWNER TO odoo;

--
-- Name: boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.boards_id_seq OWNED BY public.boards.id;


--
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    id bigint NOT NULL,
    name character varying(255),
    stage_id bigint NOT NULL,
    "position" integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    task_id bigint
);


ALTER TABLE public.cards OWNER TO odoo;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cards_id_seq OWNER TO odoo;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- Name: clients_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients_requests (
    id bigint NOT NULL,
    content character varying(255),
    date_post timestamp(0) without time zone,
    active_client_id bigint,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.clients_requests OWNER TO odoo;

--
-- Name: clients_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_requests_id_seq OWNER TO odoo;

--
-- Name: clients_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_requests_id_seq OWNED BY public.clients_requests.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    content character varying(255),
    task_id bigint,
    poster_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO odoo;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO odoo;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.companies OWNER TO odoo;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO odoo;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.editors (
    id bigint NOT NULL,
    title character varying(255),
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.editors OWNER TO odoo;

--
-- Name: editors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.editors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.editors_id_seq OWNER TO odoo;

--
-- Name: editors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.editors_id_seq OWNED BY public.editors.id;


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licenses (
    id bigint NOT NULL,
    title character varying(255),
    date_start date,
    date_end date,
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.licenses OWNER TO odoo;

--
-- Name: licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.licenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.licenses_id_seq OWNER TO odoo;

--
-- Name: licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.licenses_id_seq OWNED BY public.licenses.id;


--
-- Name: priorities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.priorities (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.priorities OWNER TO odoo;

--
-- Name: priorities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.priorities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.priorities_id_seq OWNER TO odoo;

--
-- Name: priorities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.priorities_id_seq OWNED BY public.priorities.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    title character varying(255),
    description character varying(255),
    progression integer,
    date_start date,
    date_end date,
    estimated_duration integer,
    performed_duration integer,
    deadline date,
    active_client_id bigint,
    status_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    board_id bigint
);


ALTER TABLE public.projects OWNER TO odoo;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO odoo;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: rights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rights_id_seq OWNER TO odoo;

--
-- Name: rights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rights_id_seq OWNED BY public.rights.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO odoo;

--
-- Name: softwares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.softwares (
    id bigint NOT NULL,
    title character varying(255),
    company_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.softwares OWNER TO odoo;

--
-- Name: softwares_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.softwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.softwares_id_seq OWNER TO odoo;

--
-- Name: softwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.softwares_id_seq OWNED BY public.softwares.id;


--
-- Name: stages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stages (
    id bigint NOT NULL,
    name character varying(255),
    board_id bigint NOT NULL,
    status_id bigint,
    "position" integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.stages OWNER TO odoo;

--
-- Name: stages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stages_id_seq OWNER TO odoo;

--
-- Name: stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stages_id_seq OWNED BY public.stages.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statuses (
    id bigint NOT NULL,
    title character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.statuses OWNER TO odoo;

--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statuses_id_seq OWNER TO odoo;

--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying(255),
    progression integer,
    date_start date,
    date_end date,
    estimated_duration integer,
    performed_duration integer,
    deadline date,
    parent_id bigint,
    project_id bigint,
    contributor_id bigint,
    status_id bigint,
    priority_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    attributor_id bigint
);


ALTER TABLE public.tasks OWNER TO odoo;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO odoo;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO odoo;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_clients ALTER COLUMN id SET DEFAULT nextval('public.active_clients_id_seq'::regclass);


--
-- Name: assist_contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assist_contracts ALTER COLUMN id SET DEFAULT nextval('public.assist_contracts_id_seq'::regclass);


--
-- Name: boards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boards ALTER COLUMN id SET DEFAULT nextval('public.boards_id_seq'::regclass);


--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: clients_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients_requests ALTER COLUMN id SET DEFAULT nextval('public.clients_requests_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: editors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editors ALTER COLUMN id SET DEFAULT nextval('public.editors_id_seq'::regclass);


--
-- Name: licenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses ALTER COLUMN id SET DEFAULT nextval('public.licenses_id_seq'::regclass);


--
-- Name: priorities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priorities ALTER COLUMN id SET DEFAULT nextval('public.priorities_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: rights id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rights ALTER COLUMN id SET DEFAULT nextval('public.rights_id_seq'::regclass);


--
-- Name: softwares id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwares ALTER COLUMN id SET DEFAULT nextval('public.softwares_id_seq'::regclass);


--
-- Name: stages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stages ALTER COLUMN id SET DEFAULT nextval('public.stages_id_seq'::regclass);


--
-- Name: statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_clients (id, user_id, company_id, inserted_at, updated_at) FROM stdin;
1	33	1	2021-04-27 20:13:41	2021-04-27 20:13:41
\.


--
-- Data for Name: assist_contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assist_contracts (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.boards (id, name, inserted_at, updated_at) FROM stdin;
9	Premier test	2021-04-28 13:17:31	2021-04-28 13:17:31
10	mon_projet	2021-05-03 09:59:20	2021-05-03 09:59:20
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (id, name, stage_id, "position", inserted_at, updated_at, task_id) FROM stdin;
9	cinquième	37	1	2021-04-29 08:37:56	2021-05-01 13:23:29	5
10	pubsub	39	0	2021-05-01 13:00:55	2021-05-07 14:47:50	6
6	Seconde tâche	38	1	2021-04-29 06:25:23	2021-05-07 14:47:54	2
15	EXEMPLE	36	2	2021-05-07 14:49:09	2021-05-07 14:49:09	11
14	second_task	41	1	2021-05-03 10:18:08	2021-05-06 06:06:27	10
13	first_task	41	0	2021-05-03 10:07:31	2021-05-07 05:42:16	9
11	kanban	36	1	2021-05-01 13:07:10	2021-05-01 13:21:07	7
7	une nouvelle	37	0	2021-04-29 06:27:21	2021-05-01 13:23:14	3
1	Vraie tâche	36	0	2021-04-28 19:36:59	2021-05-05 20:27:47	1
12	CHECK	38	0	2021-05-01 13:10:32	2021-05-01 13:24:11	8
8	4eme	40	0	2021-04-29 08:37:15	2021-05-07 14:47:52	4
\.


--
-- Data for Name: clients_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients_requests (id, content, date_post, active_client_id, company_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, task_id, poster_id, inserted_at, updated_at) FROM stdin;
3	commentaire posté	9	57	2021-05-08 15:08:25	2021-05-08 15:08:25
1	premier commentaire	9	57	2021-05-08 15:03:14	2021-05-08 15:03:14
2	second commentaire	9	57	2021-05-08 15:07:33	2021-05-08 15:07:33
4	commentaire contributeur	9	56	2021-05-08 16:23:17	2021-05-08 16:23:17
5	testpost	9	57	2021-05-08 17:07:22	2021-05-08 17:07:22
6	pubsub working?	9	57	2021-05-08 17:21:28	2021-05-08 17:21:28
7	second test?	9	57	2021-05-08 17:29:16	2021-05-08 17:29:16
8	oui	9	56	2021-05-08 17:30:02	2021-05-08 17:30:02
9	but not scrolling	9	56	2021-05-08 17:34:06	2021-05-08 17:34:06
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, inserted_at, updated_at) FROM stdin;
1	SOC	2021-04-13 13:35:40	2021-04-13 13:35:40
2	COMP	2021-05-03 07:27:29	2021-05-03 07:27:29
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editors (id, title, company_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licenses (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: priorities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priorities (id, title, inserted_at, updated_at) FROM stdin;
1	Faible	2021-04-27 18:58:50	2021-04-27 18:58:50
2	Moyenne	2021-04-27 18:59:00	2021-04-27 18:59:09
3	Importante	2021-04-27 18:59:28	2021-04-27 18:59:28
4	Urgente	2021-04-27 18:59:40	2021-04-27 18:59:40
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, title, description, progression, date_start, date_end, estimated_duration, performed_duration, deadline, active_client_id, status_id, inserted_at, updated_at, board_id) FROM stdin;
14	Premier test	Kanbans test	0	2021-04-28	2021-04-30	48	0	2021-04-30	1	1	2021-04-28 13:17:31	2021-04-28 13:17:31	9
15	mon_projet	projet test pour afficher flash	0	2021-05-03	2021-05-03	24	0	2021-05-04	1	1	2021-05-03 09:59:21	2021-05-03 09:59:21	10
\.


--
-- Data for Name: rights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rights (id, title, inserted_at, updated_at) FROM stdin;
1	Admin	2021-03-24 07:25:41	2021-03-24 07:25:41
3	Contributeur	2021-03-28 20:23:20	2021-03-28 20:23:20
2	Attributeur	2021-04-13 07:55:29	2021-04-13 07:55:29
4	Client	2021-03-28 17:28:09	2021-03-28 17:28:09
5	Non attribué	2021-04-01 20:21:54	2021-04-01 20:21:54
100	Archivé(e)	2021-04-13 08:24:10	2021-04-13 08:24:10
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20210324072043	2021-03-24 07:21:45
20210324143626	2021-03-24 14:36:51
20210326102201	2021-03-26 10:24:36
20210413124124	2021-04-13 12:42:49
20210414120533	2021-04-14 12:06:36
20210414120935	2021-04-14 12:09:54
20210414132353	2021-04-14 13:24:22
20210414132720	2021-04-14 13:27:54
20210415065852	2021-04-15 06:59:48
20210415071440	2021-04-15 07:15:55
20210426095303	2021-04-26 09:54:09
20210426100413	2021-04-26 10:06:28
20210426101246	2021-04-26 10:13:17
20210426101752	2021-04-26 10:20:09
20210426102215	2021-04-26 10:24:28
20210428121839	2021-04-28 12:20:11
20210428122039	2021-04-28 12:21:49
20210428172927	2021-04-28 17:30:21
20210429061512	2021-04-29 06:17:16
\.


--
-- Data for Name: softwares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.softwares (id, title, company_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stages (id, name, board_id, status_id, "position", inserted_at, updated_at) FROM stdin;
36	A faire	9	1	0	2021-04-28 13:17:31	2021-04-28 13:17:31
37	En attente	9	2	1	2021-04-28 13:17:31	2021-04-28 13:17:31
38	En cours	9	3	2	2021-04-28 13:17:31	2021-04-28 13:17:31
39	En contrôle	9	4	3	2021-04-28 13:17:31	2021-04-28 13:17:31
40	Achevée(s)	9	5	4	2021-04-28 13:17:31	2021-04-28 13:17:31
41	A faire	10	1	0	2021-05-03 09:59:21	2021-05-03 09:59:21
42	En attente	10	2	1	2021-05-03 09:59:21	2021-05-03 09:59:21
43	En cours	10	3	2	2021-05-03 09:59:21	2021-05-03 09:59:21
44	En contrôle	10	4	3	2021-05-03 09:59:21	2021-05-03 09:59:21
45	Achevée(s)	10	5	4	2021-05-03 09:59:21	2021-05-03 09:59:21
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statuses (id, title, inserted_at, updated_at) FROM stdin;
1	A faire	2021-04-27 18:47:25	2021-04-27 18:47:25
2	En attente	2021-04-27 18:47:36	2021-04-27 18:47:36
3	En cours	2021-04-27 18:47:50	2021-04-27 18:47:50
4	En contrôle	2021-04-27 18:48:15	2021-04-27 18:48:15
5	Achevée(s)	2021-04-27 18:49:44	2021-04-27 18:49:44
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, progression, date_start, date_end, estimated_duration, performed_duration, deadline, parent_id, project_id, contributor_id, status_id, priority_id, inserted_at, updated_at, attributor_id) FROM stdin;
9	first_task	0	2021-05-03	2021-05-03	24	0	2021-05-04	\N	15	56	1	2	2021-05-03 10:07:31	2021-05-07 05:42:16	57
6	pubsub	0	2021-05-01	2021-05-01	50	0	2021-05-08	\N	14	54	4	2	2021-05-01 13:00:55	2021-05-07 14:47:50	52
7	kanban	0	2021-05-01	2021-05-01	3	0	2021-05-08	\N	14	54	1	2	2021-05-01 13:07:10	2021-05-01 13:07:16	52
4	4eme	2	2021-05-01	2021-05-01	24	0	2021-04-30	\N	14	54	5	2	2021-04-29 08:37:15	2021-05-07 14:47:52	52
2	Seconde tâche	0	2021-04-29	2021-04-29	24	0	2021-04-30	\N	14	54	3	2	2021-04-29 06:25:23	2021-05-07 14:47:54	52
1	Vraie tâche	0	2021-04-28	2021-04-30	48	0	2021-04-30	\N	14	54	1	2	2021-04-28 19:36:58	2021-05-01 13:22:42	52
3	une nouvelle	0	2021-04-29	2021-04-30	2	0	2021-04-30	\N	14	54	2	2	2021-04-29 06:27:21	2021-05-01 13:23:14	52
5	cinquième	0	2021-04-30	2021-05-01	48	0	2021-05-01	\N	14	54	2	2	2021-04-29 08:37:56	2021-05-01 13:23:29	52
8	CHECK	0	2021-05-01	2021-05-01	2	0	2021-05-08	\N	14	54	3	2	2021-05-01 13:10:32	2021-05-01 13:24:11	52
11	EXEMPLE	0	2021-05-07	2021-05-07	45	0	2021-05-08	\N	14	\N	1	2	2021-05-07 14:49:09	2021-05-07 14:49:09	57
10	second_task	0	2021-05-03	2021-05-03	10	0	2021-05-04	\N	15	\N	1	2	2021-05-03 10:18:08	2021-05-08 17:15:10	57
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, profile_picture, email, password, right_id, inserted_at, updated_at) FROM stdin;
53	Attributeur	images/profiles/default_profile_pic.png	mgbi	$2b$12$XzzR7ctCGFIaJh61ehEnSubxPtV6kazt7xXwig64bhqdZCN4HXYzO	2	2021-04-13 11:30:16	2021-04-13 11:35:15
55	Jesuisarchivé	images/profiles/default_profile_pic.png	archivé@mgbi	$2b$12$xJLHmfbZ2dKMLIOneMRpKuHi1Z0.hSkEylUfIst/eTyL/3STO4MGS	100	2021-04-13 11:46:26	2021-04-19 14:20:31
41	Test	images/profiles/test-profile.jpg	test@test	$2b$12$cXDy2z641NRtgvK5de5dheyTn6sVTAbKHvZ4YW0e9C2ehn2XZx4vC	1	2021-03-30 18:00:03	2021-03-30 18:01:54
52	Admin	images/profiles/admin-profile.jpg	admin@myadmin	$2b$12$3yngeegsjEEifTOEZDSfAeOXnuyBOkCfjGUN.7GdIW1A57mD6tKqO	1	2021-04-13 08:28:09	2021-04-13 08:54:00
57	Mgbi	images/profiles/default_profile_pic.png	admin@mgbi	$2b$12$0LWzPAdYxEQyl2BX3UL7tev4jk1Ty0jLKK7kFhHkiilAaT7ShOo3.	1	2021-05-01 21:28:30	2021-05-01 21:28:46
54	Mgbi1	images/profiles/default_profile_pic.png	contributeur@mgbi	$2b$12$sxaYg4bRhFyE7RDn0gaXcOlDkEnhOoPFpB./8Ir.RDNKR85vsv6nK	3	2021-04-13 11:38:03	2021-04-13 11:38:19
56	Mgbi2	images/profiles/default_profile_pic.png	contributeur2@mgbi	$2b$12$xjnYOEvFZyi6ky2vB8HGCO//zHlN8lqg56hBeGE/ezDgqB/z01Z8a	3	2021-05-01 18:12:11	2021-05-01 18:13:32
25	Profilnonattribué	images/profiles/Nora-profile.png	nonattribuée@mgbi	$2b$12$Iy1kKfKzrBE9iSexjuZCQOdj7tyQ3vop0mwRNfeXacY1Qe7VHmfkO	5	2021-03-25 11:09:44	2021-05-06 16:15:30
33	Eric	images/profiles/default_profile_pic.png	eric@soc	$2b$12$ITPGIbTPJJEjonr31Tuwu.vJIvX20rU6tgb.UoD86y1mzmZGIZ0zi	4	2021-03-26 06:37:02	2021-04-22 08:20:01
58	Marc	images/profiles/default_profile_pic.png	marc@comp	$2b$12$Lnbt12faR1AtMAMCetmlRuc6SDpB2pjiR936wqT4W2Eko35l4FxtO	4	2021-05-02 13:24:25	2021-05-02 13:24:38
\.


--
-- Name: active_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_clients_id_seq', 6, true);


--
-- Name: assist_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assist_contracts_id_seq', 1, false);


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.boards_id_seq', 10, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 15, true);


--
-- Name: clients_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_requests_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 9, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 2, true);


--
-- Name: editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editors_id_seq', 1, false);


--
-- Name: licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licenses_id_seq', 1, false);


--
-- Name: priorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priorities_id_seq', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 15, true);


--
-- Name: rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rights_id_seq', 30, true);


--
-- Name: softwares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.softwares_id_seq', 1, false);


--
-- Name: stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stages_id_seq', 45, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statuses_id_seq', 5, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 58, true);


--
-- Name: active_clients active_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_pkey PRIMARY KEY (id);


--
-- Name: assist_contracts assist_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assist_contracts
    ADD CONSTRAINT assist_contracts_pkey PRIMARY KEY (id);


--
-- Name: boards boards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (id);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: clients_requests clients_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients_requests
    ADD CONSTRAINT clients_requests_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: priorities priorities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priorities
    ADD CONSTRAINT priorities_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: rights rights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rights
    ADD CONSTRAINT rights_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: softwares softwares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwares
    ADD CONSTRAINT softwares_pkey PRIMARY KEY (id);


--
-- Name: stages stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- Name: statuses statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: active_clients_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX active_clients_company_id_index ON public.active_clients USING btree (company_id);


--
-- Name: active_clients_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX active_clients_user_id_index ON public.active_clients USING btree (user_id);


--
-- Name: assist_contracts_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX assist_contracts_company_id_index ON public.assist_contracts USING btree (company_id);


--
-- Name: cards_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cards_position_index ON public.cards USING btree ("position");


--
-- Name: clients_requests_active_client_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clients_requests_active_client_id_index ON public.clients_requests USING btree (active_client_id);


--
-- Name: clients_requests_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clients_requests_company_id_index ON public.clients_requests USING btree (company_id);


--
-- Name: comments_poster_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_poster_id_index ON public.comments USING btree (poster_id);


--
-- Name: comments_task_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_task_id_index ON public.comments USING btree (task_id);


--
-- Name: editors_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX editors_company_id_index ON public.editors USING btree (company_id);


--
-- Name: licenses_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX licenses_company_id_index ON public.licenses USING btree (company_id);


--
-- Name: projects_active_client_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_active_client_id_index ON public.projects USING btree (active_client_id);


--
-- Name: projects_status_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_status_id_index ON public.projects USING btree (status_id);


--
-- Name: rights_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX rights_title_index ON public.rights USING btree (title);


--
-- Name: softwares_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX softwares_company_id_index ON public.softwares USING btree (company_id);


--
-- Name: stages_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stages_position_index ON public.stages USING btree ("position");


--
-- Name: tasks_contributor_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tasks_contributor_id_index ON public.tasks USING btree (contributor_id);


--
-- Name: tasks_parent_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tasks_parent_id_index ON public.tasks USING btree (parent_id);


--
-- Name: tasks_priority_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tasks_priority_id_index ON public.tasks USING btree (priority_id);


--
-- Name: tasks_project_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tasks_project_id_index ON public.tasks USING btree (project_id);


--
-- Name: tasks_status_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tasks_status_id_index ON public.tasks USING btree (status_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_right_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_right_id_index ON public.users USING btree (right_id);


--
-- Name: users_username_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_username_index ON public.users USING btree (username);


--
-- Name: active_clients active_clients_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: active_clients active_clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_clients
    ADD CONSTRAINT active_clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: assist_contracts assist_contracts_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assist_contracts
    ADD CONSTRAINT assist_contracts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: cards cards_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.stages(id) ON DELETE CASCADE;


--
-- Name: cards cards_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: clients_requests clients_requests_active_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients_requests
    ADD CONSTRAINT clients_requests_active_client_id_fkey FOREIGN KEY (active_client_id) REFERENCES public.active_clients(id);


--
-- Name: clients_requests clients_requests_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients_requests
    ADD CONSTRAINT clients_requests_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: comments comments_poster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES public.users(id);


--
-- Name: comments comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: editors editors_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: licenses licenses_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: projects projects_active_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_active_client_id_fkey FOREIGN KEY (active_client_id) REFERENCES public.active_clients(id);


--
-- Name: projects projects_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_board_id_fkey FOREIGN KEY (board_id) REFERENCES public.boards(id);


--
-- Name: projects projects_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: softwares softwares_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwares
    ADD CONSTRAINT softwares_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: stages stages_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_board_id_fkey FOREIGN KEY (board_id) REFERENCES public.boards(id) ON DELETE CASCADE;


--
-- Name: stages stages_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stages
    ADD CONSTRAINT stages_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: tasks tasks_attributor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_attributor_id_fkey FOREIGN KEY (attributor_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_contributor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_contributor_id_fkey FOREIGN KEY (contributor_id) REFERENCES public.users(id);


--
-- Name: tasks tasks_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_priority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_priority_id_fkey FOREIGN KEY (priority_id) REFERENCES public.priorities(id);


--
-- Name: tasks tasks_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.statuses(id);


--
-- Name: users users_right_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_right_id_fkey FOREIGN KEY (right_id) REFERENCES public.rights(id);


--
-- PostgreSQL database dump complete
--
