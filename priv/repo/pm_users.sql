--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)

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
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    title character varying(255),
    seen boolean,
    ongoing boolean,
    done boolean,
    file_urls character varying(255)[] DEFAULT ARRAY[]::character varying[] NOT NULL
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
    updated_at timestamp(0) without time zone NOT NULL,
    file_urls character varying(255)[] DEFAULT ARRAY[]::character varying[] NOT NULL
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
    updated_at timestamp(0) without time zone NOT NULL,
    logo character varying(255)
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
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    content character varying(255),
    seen boolean DEFAULT false NOT NULL,
    sender_id bigint,
    receiver_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO odoo;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO odoo;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: planified; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planified (
    id bigint NOT NULL,
    description character varying(255),
    dt_start timestamp(0) without time zone,
    period integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    attributor_id integer,
    contributor_id integer,
    project_id integer,
    estimated_duration integer,
    without_control boolean DEFAULT false
);


ALTER TABLE public.planified OWNER TO odoo;

--
-- Name: planified_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planified_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planified_id_seq OWNER TO odoo;

--
-- Name: planified_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planified_id_seq OWNED BY public.planified.id;


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
    attributor_id bigint,
    achieved_at timestamp(0) without time zone,
    hidden boolean DEFAULT false,
    without_control boolean DEFAULT false
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
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: planified id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planified ALTER COLUMN id SET DEFAULT nextval('public.planified_id_seq'::regclass);


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
9	63	1	2021-08-24 14:15:16	2021-08-24 14:15:16
10	64	1	2021-08-24 14:26:14	2021-08-24 14:26:14
11	65	1	2021-08-24 14:34:55	2021-08-24 14:34:55
12	66	1	2021-08-24 14:37:57	2021-08-24 14:37:57
13	67	2	2021-08-24 14:41:14	2021-08-24 14:41:14
14	68	1	2021-08-27 07:01:04	2021-08-27 07:01:04
\.


--
-- Data for Name: assist_contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assist_contracts (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
1	CONT/SOC/001	2021-06-09	2021-06-12	1	2021-06-01 22:03:42	2021-06-01 22:03:42
\.


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.boards (id, name, inserted_at, updated_at) FROM stdin;
9	Premier test	2021-04-28 13:17:31	2021-04-28 13:17:31
10	mon_projet	2021-05-03 09:59:20	2021-05-03 09:59:20
11	QLM Site E-commerce	2021-06-08 16:39:45	2021-06-08 16:39:45
12	projet test	2021-07-05 07:45:57	2021-07-05 07:45:57
13	projet test	2021-07-05 07:47:20	2021-07-05 07:47:20
14	Un projet	2021-08-10 11:48:23	2021-08-10 11:48:23
15	Un projet	2021-08-10 11:48:56	2021-08-10 11:48:56
16	sdfsd	2021-08-17 08:41:53	2021-08-17 08:41:53
17	test date finale	2021-08-17 08:44:11	2021-08-17 08:44:11
18	blocage test	2021-08-27 07:07:36	2021-08-27 07:07:36
19	second blocage	2021-08-30 10:36:38	2021-08-30 10:36:38
20	sans debut	2021-08-31 06:34:53	2021-08-31 06:34:53
21	sans debut	2021-08-31 06:34:58	2021-08-31 06:34:58
22	sans debut	2021-08-31 06:35:15	2021-08-31 06:35:15
23	sans debut	2021-08-31 06:36:09	2021-08-31 06:36:09
24	sans debut	2021-08-31 06:39:27	2021-08-31 06:39:27
25	df	2021-08-31 06:44:08	2021-08-31 06:44:08
26	sans debut	2021-08-31 06:47:27	2021-08-31 06:47:27
27	sans debut	2021-08-31 06:47:54	2021-08-31 06:47:54
28	Pr??sentation de m??moire	2021-09-19 18:26:26	2021-09-19 18:26:26
29	Planification de t??ches	2021-10-01 09:07:53	2021-10-01 09:07:53
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cards (id, name, stage_id, "position", inserted_at, updated_at, task_id) FROM stdin;
53	test date	37	0	2021-06-14 12:45:37	2021-06-21 18:03:08	50
49	Cr??ation interface Accueil	50	0	2021-06-08 16:48:28	2021-06-15 15:03:23	46
52	tache 	49	0	2021-06-11 12:31:21	2021-07-05 07:36:20	49
72	new one three	70	4	2021-08-19 08:45:07	2021-08-23 15:36:35	69
63	Second test	70	3	2021-08-13 07:20:46	2021-08-13 07:20:58	60
60	t??che test	59	0	2021-07-05 07:52:30	2021-09-01 08:06:29	57
62	T??che d??mo	70	0	2021-08-11 07:30:46	2021-09-01 09:11:38	59
105	T??chee	137	7	2021-10-08 08:00:01	2021-10-09 06:15:16	102
118	Samedi 9:20	137	6	2021-10-09 06:20:00	2021-10-09 06:30:08	115
124	Samedi 9:20	137	3	2021-10-09 06:20:00	2021-10-09 06:30:13	121
90	t??che	84	0	2021-08-27 07:10:55	2021-08-27 07:12:50	87
126	Samedi 9:20	137	1	2021-10-09 06:20:01	2021-10-09 06:30:14	123
69	sous demo	70	7	2021-08-19 08:08:56	2021-09-01 09:11:39	66
87	subdemo3	70	9	2021-08-23 11:26:33	2021-09-01 09:11:39	84
85	sub_demo	70	10	2021-08-23 11:16:08	2021-09-01 09:11:39	82
127	9:33	137	0	2021-10-09 06:33:00	2021-10-09 07:11:03	124
91	t??che sans contr??le	70	11	2021-08-31 08:03:39	2021-09-01 09:13:34	88
103	ationt??che de pr??-d??monstr	134	0	2021-09-22 08:25:28	2021-09-28 06:36:43	100
9	cinqui??me	36	0	2021-04-29 08:37:56	2021-06-11 21:10:38	5
54	alpine	36	2	2021-06-18 21:07:16	2021-06-18 22:11:32	51
56	t??che urgente	36	1	2021-06-21 21:01:46	2021-06-22 08:30:19	53
108	T??che planifi??e 2	138	5	2021-10-08 09:00:00	2021-10-09 06:15:19	105
89	w_attrib	66	17	2021-08-23 11:37:34	2021-08-23 11:37:34	86
8	4eme	38	0	2021-04-29 08:37:15	2021-06-11 16:21:48	4
79	subtask11	66	8	2021-08-23 08:50:54	2021-08-23 08:50:54	76
80	sub22	66	9	2021-08-23 09:11:33	2021-08-23 09:11:33	77
48	new_one	40	2	2021-06-05 10:54:41	2021-06-16 15:36:13	44
12	CHECK	40	4	2021-05-01 13:10:32	2021-06-04 15:37:14	8
7	une nouvelle	40	10	2021-04-29 06:27:21	2021-06-14 13:55:19	3
82	subbus	66	11	2021-08-23 11:02:29	2021-08-23 11:02:29	79
84	subreal2	66	13	2021-08-23 11:04:49	2021-08-23 11:04:49	81
117	T??che du 16:35	138	4	2021-10-08 13:35:01	2021-10-09 06:15:28	114
6	Seconde t??che	40	9	2021-04-29 06:25:23	2021-06-04 15:37:15	2
1	Vraie t??che	40	8	2021-04-28 19:36:59	2021-06-16 15:36:15	1
46	date_insert2	40	11	2021-05-27 14:28:06	2021-06-16 15:36:30	42
45	date_insert	40	7	2021-05-27 14:25:58	2021-06-24 11:41:56	41
58	Handleinfo 	40	6	2021-06-22 07:38:43	2021-06-26 17:32:55	55
11	kanban	40	1	2021-05-01 13:07:10	2021-06-26 20:00:17	7
15	EXEMPLE	39	1	2021-05-07 14:49:09	2021-06-11 16:14:07	11
122	Samedi 9:20	138	1	2021-10-09 06:20:00	2021-10-09 06:30:12	119
23	work	41	4	2021-05-11 10:08:44	2021-06-13 19:54:43	19
10	pubsub	39	0	2021-05-01 13:00:55	2021-06-21 12:28:21	6
130	T??che planifi??e 3	136	1	2021-10-09 09:00:00	2021-10-09 09:00:00	127
133	13:05	136	3	2021-10-09 10:05:01	2021-10-09 10:05:01	130
134	9:33	136	4	2021-10-11 06:33:01	2021-10-11 06:33:01	131
64	t??che sans d??but	76	0	2021-08-18 13:26:21	2021-08-18 13:26:21	61
67	snd without dt start	41	7	2021-08-18 13:44:55	2021-08-18 13:44:55	64
93	T??che de test	135	0	2021-09-19 18:27:11	2021-09-21 10:16:14	90
99	prim3	126	0	2021-09-21 10:48:10	2021-09-21 10:48:10	96
75	my_task	66	5	2021-08-23 08:40:11	2021-08-23 08:40:11	72
100	prim4	126	1	2021-09-21 15:55:15	2021-09-21 15:55:15	97
109	T??che planifi??e 2	139	1	2021-10-08 09:00:00	2021-10-09 06:15:20	106
96	T??che du mardi	135	1	2021-09-21 10:15:41	2021-09-22 08:29:23	93
110	T??che planifi??e 2	139	3	2021-10-08 09:00:00	2021-10-09 06:15:21	107
114	Plan Test	139	5	2021-10-08 12:30:00	2021-10-09 06:15:27	111
39	doudousy2	44	0	2021-05-13 21:42:44	2021-06-13 19:49:21	35
36	89	43	0	2021-05-12 13:59:05	2021-06-17 17:51:31	32
70	new one	70	2	2021-08-19 08:22:03	2021-08-23 16:03:34	67
57	R??daction	40	0	2021-06-21 21:03:00	2021-06-26 19:47:36	54
81	subsub	66	10	2021-08-23 11:01:53	2021-08-23 11:01:53	78
86	subdemo2	70	6	2021-08-23 11:17:11	2021-09-01 09:11:39	83
73	sous demo 2 	70	8	2021-08-19 08:45:42	2021-09-01 09:11:39	70
106	Non planifi??e	137	8	2021-10-08 08:39:49	2021-10-09 06:15:17	103
55	olana be	40	5	2021-06-18 22:11:13	2021-06-26 19:46:39	52
59	Update task	40	3	2021-06-22 07:44:48	2021-06-26 19:47:42	56
92	sous-t??che sans contr??le	70	12	2021-08-31 12:31:21	2021-09-01 09:14:54	89
104	T??che pour faire la d??monstration	135	2	2021-09-22 09:19:29	2021-09-24 07:10:08	101
51	cerise3	42	5	2021-06-09 13:21:35	2021-06-21 18:03:16	48
24	task_children	43	2	2021-05-11 10:39:51	2021-06-13 19:49:38	20
40	TACHE POUR MATTHIEU	42	4	2021-05-17 13:52:19	2021-06-21 18:03:18	36
43	notifs_length	43	1	2021-05-23 14:17:54	2021-06-13 19:52:26	39
112	T??che planifi??e 2	137	10	2021-10-08 09:00:00	2021-10-09 06:15:24	109
65	t??che sans d??but 2	76	1	2021-08-18 13:27:54	2021-08-18 13:27:54	62
68	sous tache oue	41	8	2021-08-18 14:07:44	2021-08-18 14:07:44	65
123	Samedi 9:20	137	4	2021-10-09 06:20:00	2021-10-09 06:30:12	120
61	sous-t??che1	60	0	2021-07-05 08:14:08	2021-09-01 08:06:29	58
38	dodosy	44	7	2021-05-13 21:36:00	2021-06-13 19:49:33	34
22	tacheee	42	3	2021-05-10 23:26:33	2021-06-13 19:49:31	18
18	sans dt de fin	42	2	2021-05-10 15:26:00	2021-06-13 19:49:45	14
44	tache notif	42	1	2021-05-23 14:19:32	2021-06-21 12:35:49	40
20	ectoassoc	43	3	2021-05-10 23:15:14	2021-06-21 12:33:20	16
31	append%2==1	44	6	2021-05-11 12:35:49	2021-06-13 19:54:34	27
119	Samedi 9:20	138	2	2021-10-09 06:20:00	2021-10-09 06:30:09	116
47	t??che test	44	4	2021-05-31 19:27:05	2021-06-13 19:49:35	43
30	test_append	43	4	2021-05-11 12:34:43	2021-06-21 12:33:23	26
35	primaire	44	2	2021-05-12 11:02:47	2021-06-21 12:34:56	31
128	9:33	138	0	2021-10-09 06:33:01	2021-10-09 07:11:03	125
33	half_append	45	4	2021-05-11 12:42:06	2021-06-13 19:54:59	29
42	notif2	45	7	2021-05-23 14:15:08	2021-06-13 19:48:35	38
28	children_length_test	45	8	2021-05-11 12:22:08	2021-06-13 19:48:38	24
27	cinqui??me t??che secondaire pour first	45	9	2021-05-11 12:12:04	2021-06-13 19:48:38	23
94	Second test d'aujourd'hui	134	1	2021-09-19 18:29:14	2021-09-24 07:10:20	91
34	assoc2nde	45	5	2021-05-11 21:12:51	2021-06-13 19:55:09	30
50	cerise2	45	0	2021-06-09 13:14:09	2021-06-28 19:15:29	47
131	T??che planifi??e 1	136	1	2021-10-09 09:00:00	2021-10-09 09:00:00	128
111	T??che planifi??e 2	139	4	2021-10-08 09:00:00	2021-10-09 06:15:23	108
115	Plan Test	139	2	2021-10-08 12:30:00	2021-10-09 06:15:30	112
120	Samedi 9:20	139	0	2021-10-09 06:20:00	2021-10-09 06:30:10	117
16	t??che secondaire pour first task	41	5	2021-05-10 11:04:55	2021-06-13 19:54:44	12
76	my_task2	66	1	2021-08-23 08:40:34	2021-08-25 08:51:43	73
14	second_task	41	1	2021-05-03 10:18:08	2021-06-13 19:53:58	10
37	cerise sur le g??teau	41	3	2021-05-12 14:19:24	2021-06-13 19:54:06	33
13	first_task	41	0	2021-05-03 10:07:31	2021-06-14 19:40:14	9
101	prim5	126	2	2021-09-21 16:09:01	2021-09-21 16:09:01	98
97	prim	130	1	2021-09-21 10:41:46	2021-09-21 17:51:47	94
66	second without dt_start	41	6	2021-08-18 13:32:11	2021-08-18 13:32:11	63
71	new one two	70	5	2021-08-19 08:30:43	2021-08-23 15:36:35	68
41	notification_secondaire	44	5	2021-05-23 14:13:06	2021-06-13 19:54:21	37
95	notif_test	66	18	2021-09-19 18:43:56	2021-09-19 18:43:56	92
116	T??che du 16:35	137	9	2021-10-08 13:35:00	2021-10-09 06:15:27	113
121	Samedi 9:20	137	5	2021-10-09 06:20:00	2021-10-09 06:30:11	118
88	wo_attrib	67	7	2021-08-23 11:37:00	2021-08-31 13:13:01	85
77	my_subtask1	66	6	2021-08-23 08:42:27	2021-08-23 08:42:27	74
78	my_subtask2	66	7	2021-08-23 08:43:12	2021-08-23 08:43:12	75
125	Samedi 9:20	137	2	2021-10-09 06:20:00	2021-10-09 06:30:13	122
83	sub_real	66	12	2021-08-23 11:03:08	2021-08-23 11:03:08	80
74	New two	66	2	2021-08-19 08:46:59	2021-08-31 13:13:56	71
107	T??che planifi??e 2	138	3	2021-10-08 09:00:00	2021-10-09 06:15:18	104
98	prim2	130	0	2021-09-21 10:42:51	2021-09-21 17:13:06	95
113	T??che planifi??e 2	138	6	2021-10-08 09:00:00	2021-10-09 06:15:25	110
102	Nouvelle t??che pour aujou'd'hui	126	3	2021-09-21 17:50:13	2021-09-21 17:50:13	99
129	10:13	136	0	2021-10-09 07:13:00	2021-10-09 07:13:00	126
132	13:03	136	2	2021-10-09 10:03:00	2021-10-09 10:03:00	129
\.


--
-- Data for Name: clients_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients_requests (id, content, date_post, active_client_id, inserted_at, updated_at, title, seen, ongoing, done, file_urls) FROM stdin;
14	3eme requ??te	2021-06-05 18:14:45	1	2021-06-05 15:14:45	2021-06-05 15:14:45	Requ??te 3	f	f	f	{}
26	ceci est une collection de fonds d'??cran	2021-06-08 11:04:07	1	2021-06-08 08:04:07	2021-06-12 09:48:22	Fond d'??cran	f	f	f	{/uploads/1361846e69b9740-e234-494e-ae88-6383904579d0.jpg,/uploads/SBKjnxm4e3aa22e-f0b5-4229-8cb4-5192c6325dd3.jpg}
13	deuxi??me requ??te 	2021-06-05 18:13:24	1	2021-06-05 15:13:24	2021-06-05 18:56:19	Requ??te 2	f	f	f	{}
15	ceci est une requ??te flash	2021-06-05 21:01:44	1	2021-06-05 18:01:44	2021-06-12 09:47:28	Requ??te flash	f	f	f	{}
12	Voici la premi??re requ??te	2021-06-05 17:39:41	1	2021-06-05 14:39:41	2021-06-07 14:41:16	Requ??te 1	t	f	f	{}
21	samurai pictures	2021-06-07 20:44:26	1	2021-06-07 17:44:26	2021-06-12 09:47:32	Samura??	f	f	f	{/uploads/136201116337dd3-836b-44e6-a5fa-cf2cd07416b8.jpg,/uploads/winter_samuraiea311a63-ef6c-4184-8329-32dd542f488e.jpg}
27	test	2021-06-16 16:27:58	1	2021-06-16 13:27:58	2021-07-04 17:38:14	Test	f	f	f	{/uploads/nihon799a0b89-ef08-4597-b35d-91e8fe2c78d7.jpg}
28	eci est un test 	2021-07-05 11:57:39	1	2021-07-05 08:57:39	2021-07-05 08:57:39	Test requ??te	f	f	f	{/uploads/musk4thc2409339-a808-46ca-8881-5ac55143900b.png}
22	des fichiers	2021-06-07 20:59:51	1	2021-06-07 17:59:51	2021-06-12 09:47:47	Fichiers	f	f	f	{/uploads/cert-21413040-107362b713fa-34ee-4193-80f3-af48536efc2d.pdf,"/uploads/cert-21413040-1024 (copy)qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7e55d38a-a14a-43ce-adeb-7153f5d79c2a.pdf"}
29	Ceci est une requ??te de d??monstration,\r\nPouvez-vous la recevoir?	2021-08-11 16:09:18	1	2021-08-11 13:09:18	2021-08-11 13:09:18	Ma requ??te	f	f	f	{/uploads/db_conceptb1978b84-b341-4d0a-848d-edfd441c428d.png}
25	??tes-vous notifi?? de cette requ??te?	2021-06-07 23:43:47	1	2021-06-07 20:43:47	2021-06-12 09:40:05	Notification?	t	f	f	{}
23	ceci est un fichier texte	2021-06-07 21:16:55	1	2021-06-07 18:16:55	2021-06-12 09:47:56	Fichier texte	f	f	f	{/uploads/test1703fef2-905a-4e5f-9396-067124e1eaaa.txt}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, task_id, poster_id, inserted_at, updated_at, file_urls) FROM stdin;
3	commentaire post??	9	57	2021-05-08 15:08:25	2021-05-08 15:08:25	{}
1	premier commentaire	9	57	2021-05-08 15:03:14	2021-05-08 15:03:14	{}
2	second commentaire	9	57	2021-05-08 15:07:33	2021-05-08 15:07:33	{}
4	commentaire contributeur	9	56	2021-05-08 16:23:17	2021-05-08 16:23:17	{}
5	testpost	9	57	2021-05-08 17:07:22	2021-05-08 17:07:22	{}
6	pubsub working?	9	57	2021-05-08 17:21:28	2021-05-08 17:21:28	{}
7	second test?	9	57	2021-05-08 17:29:16	2021-05-08 17:29:16	{}
8	oui	9	56	2021-05-08 17:30:02	2021-05-08 17:30:02	{}
9	but not scrolling	9	56	2021-05-08 17:34:06	2021-05-08 17:34:06	{}
10	is it scrolling on the bottom now?	9	57	2021-05-09 11:12:36	2021-05-09 11:12:36	{}
11	or?	9	57	2021-05-09 11:15:50	2021-05-09 11:15:50	{}
12	and now?	9	57	2021-05-09 11:16:06	2021-05-09 11:16:06	{}
13	oii	9	57	2021-05-09 11:16:13	2021-05-09 11:16:13	{}
14	oii	9	57	2021-05-09 11:16:17	2021-05-09 11:16:17	{}
15	oii	9	57	2021-05-09 11:16:18	2021-05-09 11:16:18	{}
16	premier commentaire pour cette t??che	10	57	2021-05-09 11:16:38	2021-05-09 11:16:38	{}
17	Mais est-ce que ???? scroll bien ? 	10	57	2021-05-09 11:17:03	2021-05-09 11:17:03	{}
18	Mais est-ce que ???? scroll bien ? Oui?	10	57	2021-05-09 11:17:06	2021-05-09 11:17:06	{}
19	Je ne sais pas	10	57	2021-05-09 11:17:13	2021-05-09 11:17:13	{}
20	oiii	10	57	2021-05-09 11:17:20	2021-05-09 11:17:20	{}
21	sans hooks	10	57	2021-05-09 11:18:24	2021-05-09 11:18:24	{}
22	avec hooks	10	57	2021-05-09 11:18:34	2021-05-09 11:18:34	{}
23	update?	10	57	2021-05-09 11:20:28	2021-05-09 11:20:28	{}
24	up	10	57	2021-05-09 11:20:37	2021-05-09 11:20:37	{}
25	oi	10	57	2021-05-09 11:23:00	2021-05-09 11:23:00	{}
26	oui??	10	57	2021-05-09 11:23:05	2021-05-09 11:23:05	{}
27	???? ne marche pas avec hendle-info	10	57	2021-05-09 11:23:59	2021-05-09 11:23:59	{}
28	mais avec post oui	10	57	2021-05-09 11:24:33	2021-05-09 11:24:33	{}
29	before update?	10	57	2021-05-09 11:26:15	2021-05-09 11:26:15	{}
30	en train de marcher ?	10	57	2021-05-09 11:26:25	2021-05-09 11:26:25	{}
31	e sais pas 	10	57	2021-05-09 11:26:51	2021-05-09 11:26:51	{}
32	oii	10	57	2021-05-09 11:26:55	2021-05-09 11:26:55	{}
33	oii	9	57	2021-05-09 11:29:37	2021-05-09 11:29:37	{}
34	oii	9	57	2021-05-09 11:29:59	2021-05-09 11:29:59	{}
35	pus?hed	9	57	2021-05-09 11:40:51	2021-05-09 11:40:51	{}
36	Bien s??uuur	9	57	2021-05-09 11:41:01	2021-05-09 11:41:01	{}
37	without handle_info?	9	57	2021-05-09 11:41:31	2021-05-09 11:41:31	{}
38	with handle_info	9	57	2021-05-09 11:41:45	2021-05-09 11:41:45	{}
39	cas isol??	9	57	2021-05-09 12:57:16	2021-05-09 12:57:16	{}
40	bam	9	57	2021-05-09 12:59:41	2021-05-09 12:59:41	{}
41	hoii	9	57	2021-05-09 13:00:13	2021-05-09 13:00:13	{}
42	holaa	9	57	2021-05-09 13:01:14	2021-05-09 13:01:14	{}
43	alors?	9	56	2021-05-09 13:01:20	2021-05-09 13:01:20	{}
44	postingggg	9	57	2021-05-09 13:25:05	2021-05-09 13:25:05	{}
45	pogt	9	57	2021-05-09 13:25:13	2021-05-09 13:25:13	{}
46	de aona?	9	56	2021-05-09 15:44:04	2021-05-09 15:44:04	{}
47	kaiza	9	57	2021-05-09 20:24:57	2021-05-09 20:24:57	{}
48	yoo	9	57	2021-05-09 21:18:38	2021-05-09 21:18:38	{}
49	oii	9	57	2021-05-09 21:18:58	2021-05-09 21:18:58	{}
50	oii	9	57	2021-05-09 21:19:06	2021-05-09 21:19:06	{}
51	popopo	9	57	2021-05-09 21:29:06	2021-05-09 21:29:06	{}
52	ary zao?	9	57	2021-05-09 22:44:15	2021-05-09 22:44:15	{}
53	????marche	9	57	2021-05-09 22:46:41	2021-05-09 22:46:41	{}
54	ouais	9	57	2021-05-09 22:46:49	2021-05-09 22:46:49	{}
55	houlz	10	57	2021-05-09 22:47:11	2021-05-09 22:47:11	{}
56	gg	9	56	2021-05-09 23:16:26	2021-05-09 23:16:26	{}
57	bien sur que oui	9	56	2021-05-09 23:16:50	2021-05-09 23:16:50	{}
58	hello	9	56	2021-05-09 23:17:31	2021-05-09 23:17:31	{}
59	???? va ? 	9	57	2021-05-09 23:17:43	2021-05-09 23:17:43	{}
60	ouioui	9	56	2021-05-09 23:17:48	2021-05-09 23:17:48	{}
61	assssssssssssssssssssssssssoooooooooooooooooooooocccccccccccccccccccccccc	16	57	2021-05-20 20:12:37	2021-05-20 20:12:37	{}
62	today ? 	32	57	2021-05-27 13:24:11	2021-05-27 13:24:11	{}
63	is the date correct ?	32	57	2021-05-27 17:06:40	2021-05-27 14:06:40	{}
64	date date	9	57	2021-06-05 14:13:32	2021-06-05 11:13:32	{}
65	datuu	9	57	2021-06-05 16:17:05	2021-06-05 13:17:05	{}
66	amor fati	9	57	2021-06-05 16:21:15	2021-06-05 13:21:15	{}
67	commentaire de test	9	41	2021-06-07 18:32:54	2021-06-07 15:32:54	{}
68	r??ponse test	9	57	2021-06-07 18:33:09	2021-06-07 15:33:09	{}
69	yyaa	9	57	2021-06-09 20:42:51	2021-06-09 17:42:51	{}
70	iejuh wjkdnc_ay hheaz vy_hzec n??_	49	57	2021-06-11 15:38:41	2021-06-11 12:38:41	{}
71	6528921591:m;luihy??n,k, ujhio;o;	49	57	2021-06-11 15:49:37	2021-06-11 12:49:37	{}
72	OIIIII	49	57	2021-06-11 15:50:27	2021-06-11 12:50:27	{}
73	oiii	6	57	2021-06-16 14:16:00	2021-06-16 11:16:00	{}
74	sdfsdf	42	57	2021-06-16 16:15:21	2021-06-16 13:15:21	{}
75	dsfsdfdsf	42	57	2021-06-16 16:17:15	2021-06-16 13:17:15	{}
76	pictures	5	57	2021-06-16 16:31:03	2021-06-16 13:31:03	{}
77	pictures2	5	57	2021-06-16 16:33:45	2021-06-16 13:33:45	{/uploads/SBKjnxmaecd6ac5-cb4a-4c3f-b331-b6edfc5d05b1.jpg,/uploads/Wallpaper468492608-9ed3-42ee-a817-b14fe7eb21af.jpg}
78	commentaire avec  images	5	57	2021-06-16 17:10:19	2021-06-16 14:10:19	{/uploads/nihon733e8ade-eed6-4d10-bf82-38d0ce6bb6bc.jpg,"/uploads/nihon (copy)764132a3-b3df-4710-bc41-0e1b1f8f8fb9.jpg"}
79	De nouvelles photo	5	57	2021-06-16 17:20:33	2021-06-16 14:20:33	{/uploads/13618461e39bc46-598f-4734-8821-4ec1c3a67921.jpg,/uploads/1362011bbf5e906-cf84-4d9d-b389-98b4ad8aa20d.jpg}
80	fichierss	5	57	2021-06-16 17:21:12	2021-06-16 14:21:12	{/uploads/estimationffeba190-eb1c-41cc-9487-3069ccf245cb.pdf,/uploads/estimationc76e1ffb-93be-4cc7-82a1-5e7f7269db96.png}
81	db_concept	42	41	2021-06-16 18:03:44	2021-06-16 15:03:44	{/uploads/db_concept393470dd-ab29-40ea-9d49-d8e37c87a288.png,/uploads/db_concept1fcbcb9e4-297d-49f6-b894-90297cdd50fa.png}
82	my turn	42	57	2021-06-16 18:06:07	2021-06-16 15:06:07	{/uploads/resized-image-Promod720eaa2-9437-4996-966a-d1623ac90094.jpeg}
83	sans image	5	57	2021-06-16 20:23:59	2021-06-16 17:23:59	{}
84	Overflowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww	9	57	2021-06-17 19:46:03	2021-06-17 16:46:03	{}
85	mudamuda	9	57	2021-06-18 22:46:26	2021-06-18 19:46:26	{}
86	kanban	7	57	2021-06-19 00:53:30	2021-06-18 21:53:30	{}
87	O?? nous en sommes?	91	57	2021-09-19 21:51:07	2021-09-19 18:51:07	{}
88	Plus ou moins pr??t? :')	91	54	2021-09-19 21:51:38	2021-09-19 18:51:38	{}
89	Tr??s bien, montre-leur ceci	91	57	2021-09-19 21:53:32	2021-09-19 18:53:32	{/uploads/thumbce193bfb-a73c-423d-a46e-5ef3bb668525.png}
90	Bonjour, qu'n est-il de l'avancement de cette t??che ? 	93	57	2021-09-21 13:17:32	2021-09-21 10:17:32	{}
91	Tout roule comme sur des roulettes	93	54	2021-09-21 13:18:45	2021-09-21 10:18:45	{/uploads/thumbdb7131fb-8995-4a81-8784-44a959acbfc3.png}
92	Comment va la pr??paration ? 	91	57	2021-09-22 11:27:51	2021-09-22 08:27:51	{}
93	Oui je suis pr??t	91	54	2021-09-22 11:28:33	2021-09-22 08:28:33	{/uploads/thumba9130e40-3187-4496-8bb9-e4750f6a37a6.png}
94	O?? nous en 	101	57	2021-09-22 12:21:11	2021-09-22 09:21:11	{}
95	Bien	101	54	2021-09-22 12:21:29	2021-09-22 09:21:29	{/uploads/thumbb7dd0e71-5527-414b-9102-d66a374beac7.png}
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, inserted_at, updated_at, logo) FROM stdin;
2	COMP	2021-05-03 07:27:29	2021-05-03 07:27:29	images/company_logos/company_default_logo.png
6	SOCIETAM	2021-05-14 13:08:49	2021-05-14 13:08:49	images/company_logos/company_default_logo.png
1	MGBI	2021-04-13 13:35:40	2021-06-08 16:39:58	images/company_logos/company_default_logo.png
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.editors (id, title, company_id, inserted_at, updated_at) FROM stdin;
1	SOC-EDITOR1	1	2021-06-02 15:10:15	2021-06-02 15:10:15
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licenses (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
1	LIC--SOC1	2021-06-10	2021-06-12	1	2021-06-02 20:27:41	2021-06-02 20:27:41
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, content, seen, sender_id, receiver_id, inserted_at, updated_at) FROM stdin;
17	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	53	2021-05-20 20:01:51	2021-05-20 20:01:51
20	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 06:17:41	2021-05-21 06:17:41
23	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 06:17:43	2021-05-21 06:17:43
26	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 06:17:46	2021-05-21 06:17:46
29	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 06:17:48	2021-05-21 06:17:48
32	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:19:34	2021-05-21 06:19:34
35	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:19:36	2021-05-21 06:19:36
1	Notification 1	t	56	57	2021-05-18 11:31:52	2021-05-18 11:31:52
2	Notification 2	t	56	57	2021-05-18 11:32:03	2021-05-18 11:32:03
3	Notification 3	t	56	57	2021-05-18 11:32:06	2021-05-18 13:36:29
38	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:15	2021-05-21 06:20:15
5	test date	t	56	57	2021-05-19 21:08:34	2021-05-19 21:08:34
41	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:18	2021-05-21 06:20:18
44	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:27	2021-05-21 06:20:27
47	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:30	2021-05-21 06:20:30
50	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:39	2021-05-21 06:20:39
53	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:42	2021-05-21 06:20:42
56	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:52	2021-05-21 06:20:52
59	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 06:20:55	2021-05-21 06:20:55
308	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	f	53	52	2021-05-25 17:22:30	2021-05-25 17:22:30
16	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	57	2021-05-20 20:01:51	2021-05-20 20:01:51
4	Notification 1	t	57	56	2021-05-18 11:39:55	2021-05-18 11:39:55
309	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	t	53	57	2021-05-25 17:22:30	2021-05-25 17:22:30
311	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-26 20:16:28	2021-05-26 20:16:28
312	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-26 20:16:28	2021-05-26 20:16:28
314	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 08:27:38	2021-05-27 08:27:38
42	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:18	2021-05-21 06:20:18
45	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:27	2021-05-21 06:20:27
48	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:30	2021-05-21 06:20:30
51	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:39	2021-05-21 06:20:39
54	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:42	2021-05-21 06:20:42
57	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:52	2021-05-21 06:20:52
60	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 06:20:55	2021-05-21 06:20:55
18	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	41	2021-05-20 20:01:51	2021-05-20 20:01:51
21	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 06:17:41	2021-05-21 06:17:41
24	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 06:17:43	2021-05-21 06:17:43
27	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 06:17:46	2021-05-21 06:17:46
30	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 06:17:48	2021-05-21 06:17:48
33	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:19:34	2021-05-21 06:19:34
36	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:19:36	2021-05-21 06:19:36
39	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:15	2021-05-21 06:20:15
315	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 08:27:38	2021-05-27 08:27:38
332	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:34:15	2021-05-27 14:34:15
333	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:34:15	2021-05-27 14:34:15
371	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:54	2021-05-27 14:36:54
372	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:54	2021-05-27 14:36:54
671	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-06-01 19:58:39	2021-06-01 19:58:39
65	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:21:13	2021-05-21 06:21:13
68	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:21:18	2021-05-21 06:21:18
71	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:21:25	2021-05-21 06:21:25
74	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:21:27	2021-05-21 06:21:27
77	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 06:22:33	2021-05-21 06:22:33
80	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 06:22:36	2021-05-21 06:22:36
83	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 06:22:47	2021-05-21 06:22:47
40	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:18	2021-05-21 06:20:18
43	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:27	2021-05-21 06:20:27
46	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:30	2021-05-21 06:20:30
49	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:39	2021-05-21 06:20:39
52	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:42	2021-05-21 06:20:42
55	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:52	2021-05-21 06:20:52
58	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 06:20:55	2021-05-21 06:20:55
61	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:57	2021-05-21 06:20:57
19	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 06:17:41	2021-05-21 06:17:41
22	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 06:17:43	2021-05-21 06:17:43
25	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 06:17:46	2021-05-21 06:17:46
28	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 06:17:48	2021-05-21 06:17:48
31	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:19:34	2021-05-21 06:19:34
34	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:19:36	2021-05-21 06:19:36
37	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:15	2021-05-21 06:20:15
64	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:21:13	2021-05-21 06:21:13
67	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:21:18	2021-05-21 06:21:18
70	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:21:25	2021-05-21 06:21:25
73	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:21:27	2021-05-21 06:21:27
76	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 06:22:33	2021-05-21 06:22:33
79	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 06:22:36	2021-05-21 06:22:36
82	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 06:22:47	2021-05-21 06:22:47
85	T??che "Seconde t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	52	2021-05-21 06:22:50	2021-05-21 06:22:50
86	T??che "Seconde t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	53	2021-05-21 06:22:50	2021-05-21 06:22:50
89	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	53	2021-05-21 07:40:31	2021-05-21 07:40:31
92	T??che "Seconde t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	53	2021-05-21 07:41:33	2021-05-21 07:41:33
95	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	53	2021-05-21 08:12:09	2021-05-21 08:12:09
62	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:57	2021-05-21 06:20:57
63	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:57	2021-05-21 06:20:57
66	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:21:13	2021-05-21 06:21:13
94	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	57	2021-05-21 08:12:09	2021-05-21 08:12:09
317	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 08:27:45	2021-05-27 08:27:45
318	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 08:27:45	2021-05-27 08:27:45
383	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:37:08	2021-05-27 14:37:08
384	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:37:08	2021-05-27 14:37:08
389	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:37:15	2021-05-27 14:37:15
390	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:37:15	2021-05-27 14:37:15
398	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:21	2021-05-27 14:37:21
399	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:21	2021-05-27 14:37:21
319	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 08:27:45	2021-05-27 08:27:45
98	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	t	52	53	2021-05-21 08:12:11	2021-05-21 08:12:11
101	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 08:33:37	2021-05-21 08:33:37
104	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 08:33:40	2021-05-21 08:33:40
107	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:56:59	2021-05-21 11:56:59
110	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:02	2021-05-21 11:57:02
113	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:03	2021-05-21 11:57:03
116	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:57:06	2021-05-21 11:57:06
119	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:16	2021-05-21 11:57:16
122	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:57:19	2021-05-21 11:57:19
125	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:57:21	2021-05-21 11:57:21
128	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:30	2021-05-21 11:57:30
131	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:31	2021-05-21 11:57:31
134	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:31	2021-05-21 11:57:31
320	T??che nouvellement cr??ee du nom de date_insert par Mgbi dans le projet Premier test.	f	57	52	2021-05-27 14:25:58	2021-05-27 14:25:58
321	T??che nouvellement cr??ee du nom de date_insert par Mgbi dans le projet Premier test.	f	57	53	2021-05-27 14:25:58	2021-05-27 14:25:58
99	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-21 08:12:11	2021-05-21 08:12:11
102	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 08:33:37	2021-05-21 08:33:37
105	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 08:33:40	2021-05-21 08:33:40
108	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:56:59	2021-05-21 11:56:59
111	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:02	2021-05-21 11:57:02
114	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:03	2021-05-21 11:57:03
117	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:57:06	2021-05-21 11:57:06
120	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:16	2021-05-21 11:57:16
123	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:57:19	2021-05-21 11:57:19
126	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:57:21	2021-05-21 11:57:21
129	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:30	2021-05-21 11:57:30
132	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:31	2021-05-21 11:57:31
135	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:31	2021-05-21 11:57:31
138	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:33	2021-05-21 11:57:33
141	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:33	2021-05-21 11:57:33
144	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:34	2021-05-21 11:57:34
97	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-21 08:12:11	2021-05-21 08:12:11
137	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:33	2021-05-21 11:57:33
140	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:33	2021-05-21 11:57:33
143	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:34	2021-05-21 11:57:34
326	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:28:10	2021-05-27 14:28:10
327	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:28:10	2021-05-27 14:28:10
344	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:34:38	2021-05-27 14:34:38
345	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:34:38	2021-05-27 14:34:38
375	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:01	2021-05-27 14:37:01
425	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:39:53	2021-05-27 14:39:53
426	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:39:53	2021-05-27 14:39:53
440	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 17:54:08	2021-05-27 17:54:08
441	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 17:54:08	2021-05-27 17:54:08
322	T??che nouvellement cr??ee du nom de date_insert par Mgbi dans le projet Premier test.	t	57	41	2021-05-27 14:25:58	2021-05-27 14:25:58
328	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
163	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:26	2021-05-21 11:58:26
147	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:57:35	2021-05-21 11:57:35
165	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:26	2021-05-21 11:58:26
146	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:57:35	2021-05-21 11:57:35
164	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:26	2021-05-21 11:58:26
323	T??che nouvellement cr??ee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	52	2021-05-27 14:28:06	2021-05-27 14:28:06
324	T??che nouvellement cr??ee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	53	2021-05-27 14:28:06	2021-05-27 14:28:06
395	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:19	2021-05-27 14:37:19
396	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:19	2021-05-27 14:37:19
401	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:22	2021-05-27 14:37:22
402	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:22	2021-05-27 14:37:22
518	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:33:31	2021-05-28 18:33:31
519	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:33:31	2021-05-28 18:33:31
552	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:35:13	2021-05-28 18:35:13
555	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:35:16	2021-05-28 18:35:16
582	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:55	2021-05-28 18:35:55
594	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:12	2021-05-28 18:36:12
603	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:15	2021-05-28 18:36:15
609	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:17	2021-05-28 18:36:17
612	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
647	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-31 19:09:02	2021-05-31 19:09:02
648	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-31 19:09:02	2021-05-31 19:09:02
650	T??che "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-31 19:19:44	2021-05-31 19:19:44
651	T??che "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-05-31 19:19:44	2021-05-31 19:19:44
653	T??che "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-31 19:19:45	2021-05-31 19:19:45
654	T??che "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-05-31 19:19:45	2021-05-31 19:19:45
656	T??che "notification_secondaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-31 19:25:26	2021-05-31 19:25:26
657	T??che "notification_secondaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-31 19:25:26	2021-05-31 19:25:26
659	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet mon_projet.	f	57	52	2021-05-31 19:27:05	2021-05-31 19:27:05
553	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:35:13	2021-05-28 18:35:13
556	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:35:16	2021-05-28 18:35:16
397	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:19	2021-05-27 14:37:19
403	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:22	2021-05-27 14:37:22
442	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 17:54:08	2021-05-27 17:54:08
520	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:33:31	2021-05-28 18:33:31
325	T??che nouvellement cr??ee du nom de date_insert2 par Mgbi dans le projet Premier test.	t	57	41	2021-05-27 14:28:06	2021-05-27 14:28:06
554	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:35:16	2021-05-28 18:35:16
581	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:55	2021-05-28 18:35:55
593	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:12	2021-05-28 18:36:12
602	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:15	2021-05-28 18:36:15
608	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:17	2021-05-28 18:36:17
611	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
148	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:15	2021-05-21 11:58:15
151	T??che "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:16	2021-05-21 11:58:16
154	T??che "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:17	2021-05-21 11:58:17
157	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:25	2021-05-21 11:58:25
166	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:58:33	2021-05-21 11:58:33
172	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:58:36	2021-05-21 11:58:36
175	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:41	2021-05-21 11:58:41
150	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:15	2021-05-21 11:58:15
153	T??che "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:16	2021-05-21 11:58:16
156	T??che "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:17	2021-05-21 11:58:17
159	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:25	2021-05-21 11:58:25
168	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:58:33	2021-05-21 11:58:33
174	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:58:36	2021-05-21 11:58:36
177	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:41	2021-05-21 11:58:41
149	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:15	2021-05-21 11:58:15
152	T??che "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:16	2021-05-21 11:58:16
155	T??che "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:17	2021-05-21 11:58:17
158	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:25	2021-05-21 11:58:25
167	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:58:33	2021-05-21 11:58:33
173	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:58:36	2021-05-21 11:58:36
176	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:41	2021-05-21 11:58:41
329	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:28:10	2021-05-27 14:28:10
330	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:28:10	2021-05-27 14:28:10
443	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 17:58:51	2021-05-27 17:58:51
444	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 17:58:51	2021-05-27 17:58:51
470	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:14:38	2021-05-27 18:14:38
471	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:14:38	2021-05-27 18:14:38
491	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:36:09	2021-05-27 23:36:09
492	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:36:09	2021-05-27 23:36:09
500	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:20:04	2021-05-28 18:20:04
501	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:20:04	2021-05-28 18:20:04
524	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-28 18:33:37	2021-05-28 18:33:37
525	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-28 18:33:37	2021-05-28 18:33:37
558	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:27	2021-05-28 18:35:27
567	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:38	2021-05-28 18:35:38
630	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:33	2021-05-28 18:36:33
636	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:42	2021-05-28 18:36:42
559	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:35:27	2021-05-28 18:35:27
400	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:21	2021-05-27 14:37:21
445	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 17:58:51	2021-05-27 17:58:51
331	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
557	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:35:27	2021-05-28 18:35:27
566	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:38	2021-05-28 18:35:38
629	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:33	2021-05-28 18:36:33
635	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:42	2021-05-28 18:36:42
160	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:25	2021-05-21 11:58:25
184	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:45	2021-05-21 11:58:45
162	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:25	2021-05-21 11:58:25
186	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:45	2021-05-21 11:58:45
161	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:25	2021-05-21 11:58:25
185	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:45	2021-05-21 11:58:45
335	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:34:23	2021-05-27 14:34:23
336	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:34:23	2021-05-27 14:34:23
407	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:24	2021-05-27 14:37:24
408	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:24	2021-05-27 14:37:24
446	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 17:59:07	2021-05-27 17:59:07
447	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 17:59:07	2021-05-27 17:59:07
473	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 18:15:03	2021-05-27 18:15:03
474	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 18:15:03	2021-05-27 18:15:03
482	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 23:14:48	2021-05-27 23:14:48
483	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 23:14:48	2021-05-27 23:14:48
485	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:34:43	2021-05-27 23:34:43
486	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:34:43	2021-05-27 23:34:43
503	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-28 18:20:06	2021-05-28 18:20:06
504	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-28 18:20:06	2021-05-28 18:20:06
530	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:23	2021-05-28 18:34:23
531	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:23	2021-05-28 18:34:23
546	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:08	2021-05-28 18:35:08
561	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:28	2021-05-28 18:35:28
579	T??che "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:49	2021-05-28 18:35:49
585	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:56	2021-05-28 18:35:56
600	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:14	2021-05-28 18:36:14
621	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:27	2021-05-28 18:36:27
645	T??che "Vraie t??che"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:50	2021-05-28 18:36:50
580	T??che "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:35:49	2021-05-28 18:35:49
532	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:23	2021-05-28 18:34:23
547	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:08	2021-05-28 18:35:08
562	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:35:28	2021-05-28 18:35:28
409	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:24	2021-05-27 14:37:24
448	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 17:59:07	2021-05-27 17:59:07
475	T??che "date_insert"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 18:15:03	2021-05-27 18:15:03
484	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 23:14:48	2021-05-27 23:14:48
337	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:34:23	2021-05-27 14:34:23
545	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:08	2021-05-28 18:35:08
560	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:35:28	2021-05-28 18:35:28
578	T??che "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:35:49	2021-05-28 18:35:49
584	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:56	2021-05-28 18:35:56
599	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:14	2021-05-28 18:36:14
169	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:58:35	2021-05-21 11:58:35
178	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
171	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 11:58:35	2021-05-21 11:58:35
180	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
170	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-21 11:58:35	2021-05-21 11:58:35
179	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
338	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:34:25	2021-05-27 14:34:25
339	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:34:25	2021-05-27 14:34:25
341	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:34:37	2021-05-27 14:34:37
342	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:34:37	2021-05-27 14:34:37
419	T??che "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:36	2021-05-27 14:37:36
420	T??che "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:36	2021-05-27 14:37:36
449	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 17:59:09	2021-05-27 17:59:09
450	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 17:59:09	2021-05-27 17:59:09
461	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 18:04:27	2021-05-27 18:04:27
462	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 18:04:27	2021-05-27 18:04:27
506	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:33:12	2021-05-28 18:33:12
507	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:33:12	2021-05-28 18:33:12
533	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:25	2021-05-28 18:34:25
534	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:25	2021-05-28 18:34:25
564	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:37	2021-05-28 18:35:37
573	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:35:41	2021-05-28 18:35:41
597	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:13	2021-05-28 18:36:13
606	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:16	2021-05-28 18:36:16
615	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
618	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:36:22	2021-05-28 18:36:22
627	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:32	2021-05-28 18:36:32
642	T??che "4eme"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:48	2021-05-28 18:36:48
565	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:37	2021-05-28 18:35:37
535	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:25	2021-05-28 18:34:25
421	T??che "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-05-27 14:37:36	2021-05-27 14:37:36
451	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 17:59:09	2021-05-27 17:59:09
463	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 18:04:27	2021-05-27 18:04:27
508	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:33:12	2021-05-28 18:33:12
340	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:34:25	2021-05-27 14:34:25
343	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:34:37	2021-05-27 14:34:37
563	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:37	2021-05-28 18:35:37
572	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:35:41	2021-05-28 18:35:41
596	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:13	2021-05-28 18:36:13
605	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:16	2021-05-28 18:36:16
614	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
181	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
183	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
182	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
347	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:36:43	2021-05-27 14:36:43
348	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:36:43	2021-05-27 14:36:43
365	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:52	2021-05-27 14:36:52
366	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:52	2021-05-27 14:36:52
386	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:37:11	2021-05-27 14:37:11
387	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:37:11	2021-05-27 14:37:11
392	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:18	2021-05-27 14:37:18
393	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:18	2021-05-27 14:37:18
413	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:27	2021-05-27 14:37:27
414	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:27	2021-05-27 14:37:27
428	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:43:54	2021-05-27 14:43:54
429	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:43:54	2021-05-27 14:43:54
452	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:04:08	2021-05-27 18:04:08
453	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:04:08	2021-05-27 18:04:08
464	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 18:04:29	2021-05-27 18:04:29
465	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 18:04:29	2021-05-27 18:04:29
488	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 23:36:07	2021-05-27 23:36:07
489	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 23:36:07	2021-05-27 23:36:07
509	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:33:18	2021-05-28 18:33:18
510	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:33:18	2021-05-28 18:33:18
536	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:26	2021-05-28 18:34:26
537	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:26	2021-05-28 18:34:26
540	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:34:51	2021-05-28 18:34:51
543	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:34:54	2021-05-28 18:34:54
570	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:35:40	2021-05-28 18:35:40
576	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:48	2021-05-28 18:35:48
591	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:36:04	2021-05-28 18:36:04
538	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:26	2021-05-28 18:34:26
541	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:34:51	2021-05-28 18:34:51
349	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:36:43	2021-05-27 14:36:43
367	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:52	2021-05-27 14:36:52
388	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:37:11	2021-05-27 14:37:11
539	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:34:51	2021-05-28 18:34:51
542	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:34:54	2021-05-28 18:34:54
569	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:35:40	2021-05-28 18:35:40
575	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:35:48	2021-05-28 18:35:48
590	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:36:04	2021-05-28 18:36:04
350	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:46	2021-05-27 14:36:46
88	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	52	2021-05-21 07:40:31	2021-05-21 07:40:31
91	T??che "Seconde t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	52	2021-05-21 07:41:33	2021-05-21 07:41:33
100	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 08:33:37	2021-05-21 08:33:37
103	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 08:33:40	2021-05-21 08:33:40
106	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:56:59	2021-05-21 11:56:59
109	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:02	2021-05-21 11:57:02
112	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:03	2021-05-21 11:57:03
115	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:57:06	2021-05-21 11:57:06
118	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:16	2021-05-21 11:57:16
121	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:57:19	2021-05-21 11:57:19
124	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:57:21	2021-05-21 11:57:21
127	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:30	2021-05-21 11:57:30
130	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:31	2021-05-21 11:57:31
133	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:31	2021-05-21 11:57:31
136	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:33	2021-05-21 11:57:33
139	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:33	2021-05-21 11:57:33
142	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:34	2021-05-21 11:57:34
145	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	52	2021-05-21 11:57:35	2021-05-21 11:57:35
187	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	52	2021-05-21 11:58:45	2021-05-21 11:58:45
190	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-21 12:00:28	2021-05-21 12:00:28
351	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:46	2021-05-27 14:36:46
69	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:21:18	2021-05-21 06:21:18
72	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:21:25	2021-05-21 06:21:25
75	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:21:27	2021-05-21 06:21:27
78	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 06:22:33	2021-05-21 06:22:33
81	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 06:22:36	2021-05-21 06:22:36
84	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-21 06:22:47	2021-05-21 06:22:47
87	T??che "Seconde t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-21 06:22:50	2021-05-21 06:22:50
90	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-21 07:40:31	2021-05-21 07:40:31
93	T??che "Seconde t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-21 07:41:33	2021-05-21 07:41:33
96	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	41	2021-05-21 08:12:09	2021-05-21 08:12:09
189	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 11:58:45	2021-05-21 11:58:45
192	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-21 12:00:28	2021-05-21 12:00:28
193	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:08	2021-05-22 10:07:08
196	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:10	2021-05-22 10:07:10
362	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:51	2021-05-27 14:36:51
199	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
363	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:51	2021-05-27 14:36:51
202	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
205	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:13	2021-05-22 10:07:13
374	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:01	2021-05-27 14:37:01
195	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:08	2021-05-22 10:07:08
198	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:10	2021-05-22 10:07:10
208	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
209	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:14	2021-05-22 10:07:14
353	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:48	2021-05-27 14:36:48
354	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:48	2021-05-27 14:36:48
404	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:23	2021-05-27 14:37:23
405	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:23	2021-05-27 14:37:23
416	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:34	2021-05-27 14:37:34
417	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:34	2021-05-27 14:37:34
422	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:38:25	2021-05-27 14:38:25
423	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:38:25	2021-05-27 14:38:25
431	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 16:33:39	2021-05-27 16:33:39
432	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 16:33:39	2021-05-27 16:33:39
458	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 18:04:22	2021-05-27 18:04:22
459	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 18:04:22	2021-05-27 18:04:22
476	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:15:28	2021-05-27 18:15:28
477	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:15:28	2021-05-27 18:15:28
497	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 23:38:11	2021-05-27 23:38:11
498	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 23:38:11	2021-05-27 23:38:11
512	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:33:22	2021-05-28 18:33:22
513	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:33:22	2021-05-28 18:33:22
527	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-28 18:33:41	2021-05-28 18:33:41
528	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-28 18:33:41	2021-05-28 18:33:41
549	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	f	52	53	2021-05-28 18:35:09	2021-05-28 18:35:09
588	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	f	52	53	2021-05-28 18:36:01	2021-05-28 18:36:01
624	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:29	2021-05-28 18:36:29
633	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:35	2021-05-28 18:36:35
639	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:44	2021-05-28 18:36:44
670	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-06-01 19:58:39	2021-06-01 19:58:39
529	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-28 18:33:41	2021-05-28 18:33:41
550	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:09	2021-05-28 18:35:09
355	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:48	2021-05-27 14:36:48
406	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:23	2021-05-27 14:37:23
418	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-05-27 14:37:34	2021-05-27 14:37:34
424	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:38:25	2021-05-27 14:38:25
433	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 16:33:39	2021-05-27 16:33:39
210	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
548	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:35:09	2021-05-28 18:35:09
587	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:36:01	2021-05-28 18:36:01
623	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:29	2021-05-28 18:36:29
632	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:35	2021-05-28 18:36:35
638	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:44	2021-05-28 18:36:44
356	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:49	2021-05-27 14:36:49
357	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:49	2021-05-27 14:36:49
377	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:02	2021-05-27 14:37:02
378	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:02	2021-05-27 14:37:02
434	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 16:59:29	2021-05-27 16:59:29
220	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:16	2021-05-22 10:07:16
223	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:17	2021-05-22 10:07:17
226	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
229	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
211	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
214	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
217	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
232	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-22 16:50:00	2021-05-22 16:50:00
435	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 16:59:29	2021-05-27 16:59:29
235	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-22 16:50:03	2021-05-22 16:50:03
238	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-22 16:50:10	2021-05-22 16:50:10
467	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 18:04:31	2021-05-27 18:04:31
241	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-22 16:50:12	2021-05-22 16:50:12
468	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 18:04:31	2021-05-27 18:04:31
244	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 19:29:05	2021-05-22 19:29:05
247	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
479	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 18:18:43	2021-05-27 18:18:43
250	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
480	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 18:18:43	2021-05-27 18:18:43
253	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:19	2021-05-22 21:01:19
256	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:23	2021-05-22 21:01:23
494	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 23:38:08	2021-05-27 23:38:08
495	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 23:38:08	2021-05-27 23:38:08
213	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
216	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
219	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
222	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:16	2021-05-22 10:07:16
225	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:17	2021-05-22 10:07:17
259	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:24	2021-05-22 21:01:24
262	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 13:49:26	2021-05-23 13:49:26
265	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:38	2021-05-23 13:49:38
268	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:42	2021-05-23 13:49:42
271	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:44	2021-05-23 13:49:44
274	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-23 13:49:48	2021-05-23 13:49:48
280	T??che nouvellement cr??ee du nom de tache notif par Mgbi dans le projet mon_projet.	f	57	52	2021-05-23 14:19:32	2021-05-23 14:19:32
283	T??che "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 14:39:34	2021-05-23 14:39:34
286	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-23 14:39:35	2021-05-23 14:39:35
289	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-23 14:39:36	2021-05-23 14:39:36
292	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-23 14:44:31	2021-05-23 14:44:31
359	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:50	2021-05-27 14:36:50
360	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:50	2021-05-27 14:36:50
368	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-27 14:36:53	2021-05-27 14:36:53
277	Une t??che fille de votre t??che primaire second_task du nom de notification_secondaire a ??t?? cr??ee par Mgbi2	t	56	57	2021-05-23 14:13:06	2021-05-23 14:13:06
278	Une t??che fille de votre t??che primaire cerise sur le g??teau du nom de notif2 a ??t?? cr??ee par Mgbi2 dans le projet mon_projet	t	56	57	2021-05-23 14:15:08	2021-05-23 14:15:08
279	Une t??che fille de votre t??che primaire cerise sur le g??teau du nom de notifs_length a ??t?? cr??ee par Mgbi2 dans le projet mon_projet	t	56	57	2021-05-23 14:17:54	2021-05-23 14:17:54
296	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	53	2021-05-23 15:04:22	2021-05-23 15:04:22
299	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	53	2021-05-23 15:04:29	2021-05-23 15:04:29
302	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	53	2021-05-23 15:07:37	2021-05-23 15:07:37
305	T??che "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	53	2021-05-23 15:07:48	2021-05-23 15:07:48
284	T??che "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-23 14:39:34	2021-05-23 14:39:34
287	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-23 14:39:35	2021-05-23 14:39:35
290	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-23 14:39:36	2021-05-23 14:39:36
293	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-23 14:44:31	2021-05-23 14:44:31
269	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:42	2021-05-23 13:49:42
272	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:44	2021-05-23 13:49:44
275	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-23 13:49:48	2021-05-23 13:49:48
281	T??che nouvellement cr??ee du nom de tache notif par Mgbi dans le projet mon_projet.	t	57	53	2021-05-23 14:19:32	2021-05-23 14:19:32
260	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:24	2021-05-22 21:01:24
263	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-23 13:49:26	2021-05-23 13:49:26
266	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:38	2021-05-23 13:49:38
258	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:23	2021-05-22 21:01:23
295	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	57	2021-05-23 15:04:22	2021-05-23 15:04:22
298	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-05-23 15:04:29	2021-05-23 15:04:29
301	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-05-23 15:07:37	2021-05-23 15:07:37
304	T??che "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	57	2021-05-23 15:07:48	2021-05-23 15:07:48
188	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 11:58:45	2021-05-21 11:58:45
191	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-21 12:00:28	2021-05-21 12:00:28
194	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:08	2021-05-22 10:07:08
197	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:10	2021-05-22 10:07:10
200	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:12	2021-05-22 10:07:12
203	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:12	2021-05-22 10:07:12
206	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:13	2021-05-22 10:07:13
212	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:14	2021-05-22 10:07:14
215	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:15	2021-05-22 10:07:15
218	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:15	2021-05-22 10:07:15
221	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:16	2021-05-22 10:07:16
224	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:17	2021-05-22 10:07:17
227	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:18	2021-05-22 10:07:18
230	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:18	2021-05-22 10:07:18
233	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-22 16:50:00	2021-05-22 16:50:00
236	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-22 16:50:03	2021-05-22 16:50:03
239	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	53	2021-05-22 16:50:10	2021-05-22 16:50:10
242	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	53	2021-05-22 16:50:12	2021-05-22 16:50:12
245	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 19:29:05	2021-05-22 19:29:05
248	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 21:01:17	2021-05-22 21:01:17
251	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:17	2021-05-22 21:01:17
254	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 21:01:19	2021-05-22 21:01:19
257	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:23	2021-05-22 21:01:23
307	Mgbi vous a assign?? ?? la t??che tacheee.	t	57	56	2021-05-25 05:23:16	2021-05-25 05:23:16
369	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-27 14:36:53	2021-05-27 14:36:53
380	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 14:37:03	2021-05-27 14:37:03
381	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 14:37:03	2021-05-27 14:37:03
410	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:25	2021-05-27 14:37:25
411	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:25	2021-05-27 14:37:25
437	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 17:53:57	2021-05-27 17:53:57
438	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 17:53:57	2021-05-27 17:53:57
455	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-05-27 18:04:19	2021-05-27 18:04:19
456	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-05-27 18:04:19	2021-05-27 18:04:19
515	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-05-28 18:33:26	2021-05-28 18:33:26
516	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-05-28 18:33:26	2021-05-28 18:33:26
521	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-05-28 18:33:36	2021-05-28 18:33:36
522	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-05-28 18:33:36	2021-05-28 18:33:36
551	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	57	2021-05-28 18:35:13	2021-05-28 18:35:13
660	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet mon_projet.	f	57	53	2021-05-31 19:27:05	2021-05-31 19:27:05
662	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi2	f	56	52	2021-05-31 19:29:01	2021-05-31 19:29:01
663	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi2	f	56	53	2021-05-31 19:29:01	2021-05-31 19:29:01
665	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi2	t	56	57	2021-05-31 19:29:01	2021-05-31 19:29:01
661	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet mon_projet.	t	57	41	2021-05-31 19:27:05	2021-05-31 19:27:05
664	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi2	t	56	41	2021-05-31 19:29:01	2021-05-31 19:29:01
666	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	f	56	52	2021-05-31 19:29:16	2021-05-31 19:29:16
667	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	f	56	53	2021-05-31 19:29:16	2021-05-31 19:29:16
644	T??che "Vraie t??che"\n          du projet Premier test mise dans " A faire " par Admin	t	52	57	2021-05-28 18:36:50	2021-05-28 18:36:50
641	T??che "4eme"\n          du projet Premier test mise dans " A faire " par Admin	t	52	57	2021-05-28 18:36:48	2021-05-28 18:36:48
669	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	t	56	57	2021-05-31 19:29:16	2021-05-31 19:29:16
668	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	t	56	41	2021-05-31 19:29:16	2021-05-31 19:29:16
673	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-06-01 21:03:38	2021-06-01 21:03:38
674	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-06-01 21:03:38	2021-06-01 21:03:38
676	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-06-01 21:04:02	2021-06-01 21:04:02
677	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-06-01 21:04:02	2021-06-01 21:04:02
679	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-06-01 21:10:32	2021-06-01 21:10:32
680	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-06-01 21:10:32	2021-06-01 21:10:32
682	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-03 20:06:05	2021-06-03 20:06:05
683	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-03 20:06:05	2021-06-03 20:06:05
685	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	55	2021-06-04 15:13:59	2021-06-04 15:13:59
686	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-04 15:13:59	2021-06-04 15:13:59
688	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-04 15:13:59	2021-06-04 15:13:59
689	T??che "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	55	2021-06-04 15:23:45	2021-06-04 15:23:45
690	T??che "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-04 15:23:45	2021-06-04 15:23:45
692	T??che "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-04 15:23:45	2021-06-04 15:23:45
694	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	55	2021-06-04 15:37:09	2021-06-04 15:37:09
695	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-04 15:37:09	2021-06-04 15:37:09
697	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-04 15:37:09	2021-06-04 15:37:09
698	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	55	2021-06-04 15:37:15	2021-06-04 15:37:15
699	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-04 15:37:15	2021-06-04 15:37:15
701	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-04 15:37:15	2021-06-04 15:37:15
702	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	55	2021-06-04 15:37:15	2021-06-04 15:37:15
703	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-04 15:37:15	2021-06-04 15:37:15
705	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-04 15:37:15	2021-06-04 15:37:15
707	T??che nouvellement cr??ee du nom de new_one par Mgbi dans le projet Premier test.	f	57	55	2021-06-05 10:54:41	2021-06-05 10:54:41
708	T??che nouvellement cr??ee du nom de new_one par Mgbi dans le projet Premier test.	f	57	53	2021-06-05 10:54:41	2021-06-05 10:54:41
710	T??che nouvellement cr??ee du nom de new_one par Mgbi dans le projet Premier test.	f	57	52	2021-06-05 10:54:41	2021-06-05 10:54:41
712	T??che "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-05 10:54:57	2021-06-05 10:54:57
714	T??che "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-05 10:54:57	2021-06-05 10:54:57
717	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	f	54	53	2021-06-05 12:32:16	2021-06-05 12:32:16
719	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	f	54	52	2021-06-05 12:32:16	2021-06-05 12:32:16
721	La requ??te Requ??te 2 est en cours	t	57	33	2021-06-05 18:51:10	2021-06-05 18:51:10
720	La requ??te Requ??te 2 a ??t?? mise en vu	t	57	33	2021-06-05 18:50:53	2021-06-05 18:50:53
722	La requ??te Requ??te 1 est en cours	t	57	33	2021-06-05 18:51:28	2021-06-05 18:51:28
723	La requ??te Requ??te flash a ??t?? mise en vu	t	57	33	2021-06-05 18:51:47	2021-06-05 18:51:47
724	La requ??te Requ??te flash a ??t?? non vue	t	57	33	2021-06-05 18:55:16	2021-06-05 18:55:16
725	La requ??te Requ??te 2 n'est pas en cours	t	57	33	2021-06-05 18:56:13	2021-06-05 18:56:13
715	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	57	2021-06-05 12:32:16	2021-06-05 12:32:16
704	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-06-04 15:37:15	2021-06-04 15:37:15
672	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	t	57	41	2021-06-01 19:58:39	2021-06-01 19:58:39
675	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	t	57	41	2021-06-01 21:03:38	2021-06-01 21:03:38
678	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	t	57	41	2021-06-01 21:04:02	2021-06-01 21:04:02
681	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	t	57	41	2021-06-01 21:10:32	2021-06-01 21:10:32
684	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-06-03 20:06:05	2021-06-03 20:06:05
711	T??che "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	55	2021-06-05 10:54:57	2021-06-05 10:54:57
716	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	55	2021-06-05 12:32:16	2021-06-05 12:32:16
693	Mgbi vous a assign?? ?? la t??che EXEMPLE.	t	57	54	2021-06-04 15:24:08	2021-06-04 15:24:08
706	Mgbi vous a assign?? ?? la t??che date_insert.	t	57	54	2021-06-04 15:43:53	2021-06-04 15:43:53
728	La requ??te Requ??te 1 n'est pas en cours	t	57	33	2021-06-05 18:56:34	2021-06-05 18:56:34
726	La requ??te Requ??te 2 a ??t?? non vue	t	57	33	2021-06-05 18:56:20	2021-06-05 18:56:20
727	La requ??te Requ??te 1 a ??t?? non vue	t	57	33	2021-06-05 18:56:24	2021-06-05 18:56:24
709	T??che nouvellement cr??ee du nom de new_one par Mgbi dans le projet Premier test.	t	57	41	2021-06-05 10:54:41	2021-06-05 10:54:41
713	T??che "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-06-05 10:54:57	2021-06-05 10:54:57
718	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	41	2021-06-05 12:32:16	2021-06-05 12:32:16
583	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:55	2021-05-28 18:35:55
595	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:12	2021-05-28 18:36:12
604	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:15	2021-05-28 18:36:15
610	T??che "cinqui??me"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:17	2021-05-28 18:36:17
613	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
649	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-31 19:09:02	2021-05-31 19:09:02
652	T??che "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-31 19:19:44	2021-05-31 19:19:44
655	T??che "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-31 19:19:45	2021-05-31 19:19:45
658	T??che "notification_secondaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-31 19:25:26	2021-05-31 19:25:26
568	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:38	2021-05-28 18:35:38
631	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:33	2021-05-28 18:36:33
586	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:35:56	2021-05-28 18:35:56
601	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:14	2021-05-28 18:36:14
622	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:27	2021-05-28 18:36:27
637	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:42	2021-05-28 18:36:42
574	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:35:41	2021-05-28 18:35:41
598	T??che "date_insert2"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:13	2021-05-28 18:36:13
607	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:16	2021-05-28 18:36:16
616	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
619	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	41	2021-05-28 18:36:22	2021-05-28 18:36:22
628	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:32	2021-05-28 18:36:32
643	T??che "4eme"\n          du projet Premier test mise dans " A faire " par Admin	t	52	41	2021-05-28 18:36:48	2021-05-28 18:36:48
571	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:35:40	2021-05-28 18:35:40
577	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:35:48	2021-05-28 18:35:48
589	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:36:01	2021-05-28 18:36:01
592	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:36:04	2021-05-28 18:36:04
625	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:29	2021-05-28 18:36:29
634	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:35	2021-05-28 18:36:35
640	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:44	2021-05-28 18:36:44
646	T??che "Vraie t??che"\n          du projet Premier test mise dans " A faire " par Admin	t	52	41	2021-05-28 18:36:50	2021-05-28 18:36:50
687	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-06-04 15:13:59	2021-06-04 15:13:59
691	T??che "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-06-04 15:23:45	2021-06-04 15:23:45
696	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-06-04 15:37:09	2021-06-04 15:37:09
700	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-06-04 15:37:15	2021-06-04 15:37:15
544	T??che "4eme"\n          du projet Premier test mise dans " Achev??e(s) " par Admin	t	52	41	2021-05-28 18:34:54	2021-05-28 18:34:54
373	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:54	2021-05-27 14:36:54
385	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:37:08	2021-05-27 14:37:08
391	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:37:15	2021-05-27 14:37:15
376	T??che "Vraie t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:01	2021-05-27 14:37:01
427	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:39:53	2021-05-27 14:39:53
472	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:14:38	2021-05-27 18:14:38
493	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-27 23:36:09	2021-05-27 23:36:09
502	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:20:04	2021-05-28 18:20:04
526	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-28 18:33:37	2021-05-28 18:33:37
487	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-27 23:34:43	2021-05-27 23:34:43
505	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-28 18:20:06	2021-05-28 18:20:06
394	T??che "4eme"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:18	2021-05-27 14:37:18
415	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:37:27	2021-05-27 14:37:27
430	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:43:54	2021-05-27 14:43:54
454	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:04:08	2021-05-27 18:04:08
466	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 18:04:29	2021-05-27 18:04:29
490	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 23:36:07	2021-05-27 23:36:07
511	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:33:18	2021-05-28 18:33:18
352	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:46	2021-05-27 14:36:46
364	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:51	2021-05-27 14:36:51
460	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 18:04:22	2021-05-27 18:04:22
478	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:15:28	2021-05-27 18:15:28
499	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 23:38:11	2021-05-27 23:38:11
514	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:33:22	2021-05-28 18:33:22
358	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:49	2021-05-27 14:36:49
379	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:02	2021-05-27 14:37:02
436	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 16:59:29	2021-05-27 16:59:29
469	T??che "EXEMPLE"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 18:04:31	2021-05-27 18:04:31
481	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 18:18:43	2021-05-27 18:18:43
496	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 23:38:08	2021-05-27 23:38:08
361	T??che "cinqui??me"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:50	2021-05-27 14:36:50
370	T??che "Seconde t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:36:53	2021-05-27 14:36:53
382	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:37:03	2021-05-27 14:37:03
412	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:37:25	2021-05-27 14:37:25
439	T??che "Seconde t??che"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 17:53:57	2021-05-27 17:53:57
457	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 18:04:19	2021-05-27 18:04:19
517	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-28 18:33:26	2021-05-28 18:33:26
523	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-28 18:33:36	2021-05-28 18:33:36
310	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	t	53	41	2021-05-25 17:22:30	2021-05-25 17:22:30
313	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-26 20:16:28	2021-05-26 20:16:28
316	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 08:27:38	2021-05-27 08:27:38
334	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Mgbi	t	57	41	2021-05-27 14:34:15	2021-05-27 14:34:15
346	T??che "CHECK"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-27 14:34:38	2021-05-27 14:34:38
201	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
204	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
207	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:13	2021-05-22 10:07:13
228	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
231	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
234	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-22 16:50:00	2021-05-22 16:50:00
237	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-22 16:50:03	2021-05-22 16:50:03
240	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-22 16:50:10	2021-05-22 16:50:10
243	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-22 16:50:12	2021-05-22 16:50:12
246	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 19:29:05	2021-05-22 19:29:05
249	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
252	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
255	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 21:01:19	2021-05-22 21:01:19
261	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:24	2021-05-22 21:01:24
264	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-23 13:49:26	2021-05-23 13:49:26
267	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:38	2021-05-23 13:49:38
270	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:42	2021-05-23 13:49:42
273	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:44	2021-05-23 13:49:44
276	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-23 13:49:48	2021-05-23 13:49:48
282	T??che nouvellement cr??ee du nom de tache notif par Mgbi dans le projet mon_projet.	t	57	41	2021-05-23 14:19:32	2021-05-23 14:19:32
285	T??che "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-23 14:39:34	2021-05-23 14:39:34
288	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-23 14:39:35	2021-05-23 14:39:35
291	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	t	57	41	2021-05-23 14:39:36	2021-05-23 14:39:36
294	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	t	57	41	2021-05-23 14:44:31	2021-05-23 14:44:31
297	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	41	2021-05-23 15:04:22	2021-05-23 15:04:22
300	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	41	2021-05-23 15:04:29	2021-05-23 15:04:29
303	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	41	2021-05-23 15:07:37	2021-05-23 15:07:37
306	T??che "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	41	2021-05-23 15:07:48	2021-05-23 15:07:48
730	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-05 20:39:15	2021-06-05 20:39:15
731	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-05 20:39:15	2021-06-05 20:39:15
732	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-05 20:39:15	2021-06-05 20:39:15
734	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-05 20:39:20	2021-06-05 20:39:20
735	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-05 20:39:20	2021-06-05 20:39:20
736	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-05 20:39:20	2021-06-05 20:39:20
729	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	55	2021-06-05 20:39:15	2021-06-05 20:39:15
733	T??che "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	55	2021-06-05 20:39:20	2021-06-05 20:39:20
737	La requ??te Requ??te 1 a ??t?? vue	f	57	33	2021-06-07 14:41:08	2021-06-07 14:41:08
738	La requ??te Requ??te 1 est en cours	f	57	33	2021-06-07 14:41:13	2021-06-07 14:41:13
739	La requ??te Requ??te 1 n'est pas en cours	f	57	33	2021-06-07 14:41:16	2021-06-07 14:41:16
620	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:27	2021-05-28 18:36:27
617	T??che "CHECK"\n          du projet Premier test mise dans " En contr??le " par Admin	t	52	57	2021-05-28 18:36:22	2021-05-28 18:36:22
626	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:32	2021-05-28 18:36:32
743	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Notification?".	f	33	57	2021-06-07 20:43:47	2021-06-07 20:43:47
744	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Notification?".	f	33	41	2021-06-07 20:43:47	2021-06-07 20:43:47
745	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Notification?".	f	33	52	2021-06-07 20:43:47	2021-06-07 20:43:47
746	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:58:03	2021-06-08 07:58:03
747	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:58:03	2021-06-08 07:58:03
748	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:58:03	2021-06-08 07:58:03
749	T??che "t??che test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-08 07:58:35	2021-06-08 07:58:35
750	T??che "t??che test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-08 07:58:35	2021-06-08 07:58:35
751	T??che "t??che test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-08 07:58:35	2021-06-08 07:58:35
752	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:58:37	2021-06-08 07:58:37
753	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:58:37	2021-06-08 07:58:37
754	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:58:37	2021-06-08 07:58:37
755	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 07:58:40	2021-06-08 07:58:40
756	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 07:58:40	2021-06-08 07:58:40
757	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 07:58:40	2021-06-08 07:58:40
758	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:58:45	2021-06-08 07:58:45
759	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:58:45	2021-06-08 07:58:45
760	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:58:45	2021-06-08 07:58:45
761	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:58:48	2021-06-08 07:58:48
762	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:58:48	2021-06-08 07:58:48
763	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:58:48	2021-06-08 07:58:48
764	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:58:57	2021-06-08 07:58:57
765	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:58:57	2021-06-08 07:58:57
766	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:58:57	2021-06-08 07:58:57
767	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:59:02	2021-06-08 07:59:02
768	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:59:02	2021-06-08 07:59:02
769	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:59:02	2021-06-08 07:59:02
770	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 07:59:04	2021-06-08 07:59:04
771	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 07:59:04	2021-06-08 07:59:04
772	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 07:59:04	2021-06-08 07:59:04
773	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Fond d'??cran".	f	33	57	2021-06-08 08:04:07	2021-06-08 08:04:07
774	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Fond d'??cran".	f	33	41	2021-06-08 08:04:07	2021-06-08 08:04:07
775	Le client Eric de la soci??t?? SOC a envoy?? une requ??te intitul??e "Fond d'??cran".	f	33	52	2021-06-08 08:04:07	2021-06-08 08:04:07
776	La requ??te Fond d'??cran est en cours	f	57	33	2021-06-08 08:04:26	2021-06-08 08:04:26
777	La requ??te Fond d'??cran n'est pas en cours	f	57	33	2021-06-08 08:04:27	2021-06-08 08:04:27
781	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-08 08:04:38	2021-06-08 08:04:38
782	La requ??te Fond d'??cran est en cours	f	57	33	2021-06-08 10:43:09	2021-06-08 10:43:09
778	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-08 08:04:30	2021-06-08 08:04:30
779	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-08 08:04:32	2021-06-08 08:04:32
780	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-08 08:04:37	2021-06-08 08:04:37
783	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-08 10:43:20	2021-06-08 10:43:20
784	Un projet du nom de QLM Site E-commerce a ??t?? cr??e par Mgbi	f	57	53	2021-06-08 16:39:46	2021-06-08 16:39:46
785	Un projet du nom de QLM Site E-commerce a ??t?? cr??e par Mgbi	f	57	41	2021-06-08 16:39:46	2021-06-08 16:39:46
786	Un projet du nom de QLM Site E-commerce a ??t?? cr??e par Mgbi	f	57	52	2021-06-08 16:39:46	2021-06-08 16:39:46
787	T??che nouvellement cr??ee du nom de Cr??ation interface Accueil par Mgbi dans le projet QLM Site E-commerce.	f	57	53	2021-06-08 16:48:29	2021-06-08 16:48:29
788	T??che nouvellement cr??ee du nom de Cr??ation interface Accueil par Mgbi dans le projet QLM Site E-commerce.	f	57	41	2021-06-08 16:48:29	2021-06-08 16:48:29
789	T??che nouvellement cr??ee du nom de Cr??ation interface Accueil par Mgbi dans le projet QLM Site E-commerce.	f	57	52	2021-06-08 16:48:29	2021-06-08 16:48:29
790	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-08 16:48:40	2021-06-08 16:48:40
791	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-08 16:48:40	2021-06-08 16:48:40
792	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-08 16:48:40	2021-06-08 16:48:40
793	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 16:48:42	2021-06-08 16:48:42
794	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 16:48:42	2021-06-08 16:48:42
795	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 16:48:42	2021-06-08 16:48:42
796	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-08 16:53:47	2021-06-08 16:53:47
797	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-08 16:53:47	2021-06-08 16:53:47
798	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-08 16:53:47	2021-06-08 16:53:47
799	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-08 16:53:50	2021-06-08 16:53:50
800	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-08 16:53:50	2021-06-08 16:53:50
801	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-08 16:53:50	2021-06-08 16:53:50
802	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-08 16:53:53	2021-06-08 16:53:53
803	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-08 16:53:53	2021-06-08 16:53:53
804	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-08 16:53:53	2021-06-08 16:53:53
805	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	53	2021-06-08 16:53:56	2021-06-08 16:53:56
806	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	41	2021-06-08 16:53:56	2021-06-08 16:53:56
807	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	52	2021-06-08 16:53:56	2021-06-08 16:53:56
808	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-08 18:45:11	2021-06-08 18:45:11
809	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-08 18:45:11	2021-06-08 18:45:11
810	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-08 18:45:11	2021-06-08 18:45:11
811	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 18:45:27	2021-06-08 18:45:27
812	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 18:45:27	2021-06-08 18:45:27
813	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 18:45:27	2021-06-08 18:45:27
814	T??che "test_append"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-08 18:45:28	2021-06-08 18:45:28
815	T??che "test_append"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-08 18:45:28	2021-06-08 18:45:28
816	T??che "test_append"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-08 18:45:28	2021-06-08 18:45:28
817	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-08 19:09:46	2021-06-08 19:09:46
818	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-08 19:09:46	2021-06-08 19:09:46
819	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-08 19:09:46	2021-06-08 19:09:46
820	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-08 19:09:47	2021-06-08 19:09:47
821	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-08 19:09:47	2021-06-08 19:09:47
822	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-08 19:09:47	2021-06-08 19:09:47
823	T??che "half_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-08 19:09:49	2021-06-08 19:09:49
824	T??che "half_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-08 19:09:49	2021-06-08 19:09:49
825	T??che "half_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-08 19:09:49	2021-06-08 19:09:49
826	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 19:09:52	2021-06-08 19:09:52
827	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 19:09:52	2021-06-08 19:09:52
828	T??che "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 19:09:52	2021-06-08 19:09:52
829	T??che "assoc2nde"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 19:09:54	2021-06-08 19:09:54
830	T??che "assoc2nde"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 19:09:54	2021-06-08 19:09:54
1774	La requ??te Fichiers est en cours	f	57	33	2021-06-12 09:47:36	2021-06-12 09:47:36
831	T??che "assoc2nde"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 19:09:54	2021-06-08 19:09:54
832	T??che "children_length_test"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 19:09:55	2021-06-08 19:09:55
833	T??che "children_length_test"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 19:09:55	2021-06-08 19:09:55
834	T??che "children_length_test"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 19:09:55	2021-06-08 19:09:55
835	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-08 19:09:58	2021-06-08 19:09:58
836	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-08 19:09:58	2021-06-08 19:09:58
837	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-08 19:09:58	2021-06-08 19:09:58
841	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-08 19:10:06	2021-06-08 19:10:06
842	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-08 19:10:06	2021-06-08 19:10:06
843	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-08 19:10:06	2021-06-08 19:10:06
844	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 19:10:07	2021-06-08 19:10:07
845	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 19:10:07	2021-06-08 19:10:07
846	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 19:10:07	2021-06-08 19:10:07
838	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-08 19:10:02	2021-06-08 19:10:02
839	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-08 19:10:02	2021-06-08 19:10:02
840	T??che "ectoassoc"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-08 19:10:02	2021-06-08 19:10:02
847	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:16:21	2021-06-09 06:16:21
848	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:16:21	2021-06-09 06:16:21
849	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:16:21	2021-06-09 06:16:21
850	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:32:26	2021-06-09 06:32:26
851	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:32:26	2021-06-09 06:32:26
852	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:32:26	2021-06-09 06:32:26
853	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:32:29	2021-06-09 06:32:29
854	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:32:29	2021-06-09 06:32:29
855	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:32:29	2021-06-09 06:32:29
856	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:39:41	2021-06-09 06:39:41
857	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:39:41	2021-06-09 06:39:41
858	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:39:41	2021-06-09 06:39:41
859	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:50:50	2021-06-09 06:50:50
860	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:50:50	2021-06-09 06:50:50
861	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:50:50	2021-06-09 06:50:50
862	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:50:52	2021-06-09 06:50:52
863	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:50:52	2021-06-09 06:50:52
864	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:50:52	2021-06-09 06:50:52
865	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:50:53	2021-06-09 06:50:53
866	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:50:53	2021-06-09 06:50:53
867	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:50:53	2021-06-09 06:50:53
868	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:50:55	2021-06-09 06:50:55
869	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:50:55	2021-06-09 06:50:55
870	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:50:55	2021-06-09 06:50:55
871	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:51:10	2021-06-09 06:51:10
872	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:51:10	2021-06-09 06:51:10
873	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:51:10	2021-06-09 06:51:10
874	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:51:13	2021-06-09 06:51:13
875	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:51:13	2021-06-09 06:51:13
876	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:51:13	2021-06-09 06:51:13
877	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:51:17	2021-06-09 06:51:17
878	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:51:17	2021-06-09 06:51:17
879	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:51:17	2021-06-09 06:51:17
880	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:51:18	2021-06-09 06:51:18
881	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:51:18	2021-06-09 06:51:18
882	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:51:18	2021-06-09 06:51:18
883	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:55:51	2021-06-09 06:55:51
884	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:55:51	2021-06-09 06:55:51
885	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:55:51	2021-06-09 06:55:51
886	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:55:52	2021-06-09 06:55:52
887	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:55:52	2021-06-09 06:55:52
888	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:55:52	2021-06-09 06:55:52
889	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 06:55:53	2021-06-09 06:55:53
890	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 06:55:53	2021-06-09 06:55:53
891	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 06:55:53	2021-06-09 06:55:53
2446	La requ??te Test a ??t?? vue	f	57	33	2021-06-19 16:03:11	2021-06-19 16:03:11
892	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:55:54	2021-06-09 06:55:54
893	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:55:54	2021-06-09 06:55:54
894	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:55:54	2021-06-09 06:55:54
895	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:55:55	2021-06-09 06:55:55
896	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:55:55	2021-06-09 06:55:55
897	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:55:55	2021-06-09 06:55:55
898	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 06:55:56	2021-06-09 06:55:56
899	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 06:55:56	2021-06-09 06:55:56
900	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 06:55:56	2021-06-09 06:55:56
901	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 07:49:50	2021-06-09 07:49:50
902	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 07:49:50	2021-06-09 07:49:50
903	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 07:49:50	2021-06-09 07:49:50
904	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 07:50:09	2021-06-09 07:50:09
905	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 07:50:09	2021-06-09 07:50:09
906	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 07:50:09	2021-06-09 07:50:09
907	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 07:54:33	2021-06-09 07:54:33
908	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 07:54:33	2021-06-09 07:54:33
909	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 07:54:33	2021-06-09 07:54:33
910	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 07:54:41	2021-06-09 07:54:41
911	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 07:54:41	2021-06-09 07:54:41
912	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 07:54:41	2021-06-09 07:54:41
913	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 07:54:48	2021-06-09 07:54:48
914	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 07:54:48	2021-06-09 07:54:48
915	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 07:54:48	2021-06-09 07:54:48
916	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 07:54:52	2021-06-09 07:54:52
917	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 07:54:52	2021-06-09 07:54:52
918	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 07:54:52	2021-06-09 07:54:52
919	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 07:54:59	2021-06-09 07:54:59
920	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 07:54:59	2021-06-09 07:54:59
921	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 07:54:59	2021-06-09 07:54:59
922	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 07:55:00	2021-06-09 07:55:00
923	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 07:55:00	2021-06-09 07:55:00
924	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 07:55:00	2021-06-09 07:55:00
925	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 07:56:55	2021-06-09 07:56:55
926	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 07:56:55	2021-06-09 07:56:55
927	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 07:56:55	2021-06-09 07:56:55
928	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 07:57:01	2021-06-09 07:57:01
929	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 07:57:01	2021-06-09 07:57:01
930	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 07:57:01	2021-06-09 07:57:01
931	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:06:44	2021-06-09 08:06:44
932	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:06:44	2021-06-09 08:06:44
933	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:06:44	2021-06-09 08:06:44
934	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 08:07:33	2021-06-09 08:07:33
935	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 08:07:33	2021-06-09 08:07:33
936	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 08:07:33	2021-06-09 08:07:33
937	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:09:16	2021-06-09 08:09:16
938	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:09:16	2021-06-09 08:09:16
939	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:09:16	2021-06-09 08:09:16
940	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 08:09:24	2021-06-09 08:09:24
941	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 08:09:24	2021-06-09 08:09:24
942	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 08:09:24	2021-06-09 08:09:24
943	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:26:38	2021-06-09 08:26:38
2448	La requ??te Test a ??t?? vue	f	57	33	2021-06-19 16:04:29	2021-06-19 16:04:29
944	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:26:38	2021-06-09 08:26:38
945	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:26:38	2021-06-09 08:26:38
946	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:26:50	2021-06-09 08:26:50
947	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:26:50	2021-06-09 08:26:50
948	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:26:50	2021-06-09 08:26:50
955	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:27:57	2021-06-09 08:27:57
956	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:27:57	2021-06-09 08:27:57
957	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:27:57	2021-06-09 08:27:57
970	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:51:14	2021-06-09 08:51:14
971	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:51:14	2021-06-09 08:51:14
972	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:51:14	2021-06-09 08:51:14
979	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:56:53	2021-06-09 08:56:53
980	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:56:53	2021-06-09 08:56:53
981	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:56:53	2021-06-09 08:56:53
985	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:58:00	2021-06-09 08:58:00
986	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:58:00	2021-06-09 08:58:00
987	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:58:00	2021-06-09 08:58:00
988	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 09:48:01	2021-06-09 09:48:01
989	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 09:48:01	2021-06-09 09:48:01
990	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 09:48:01	2021-06-09 09:48:01
991	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 09:48:22	2021-06-09 09:48:22
992	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 09:48:22	2021-06-09 09:48:22
993	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 09:48:22	2021-06-09 09:48:22
1003	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 09:57:57	2021-06-09 09:57:57
1004	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 09:57:57	2021-06-09 09:57:57
1005	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 09:57:57	2021-06-09 09:57:57
1015	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:52:51	2021-06-09 10:52:51
1016	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:52:51	2021-06-09 10:52:51
1017	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:52:51	2021-06-09 10:52:51
1018	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:52:54	2021-06-09 10:52:54
1019	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:52:54	2021-06-09 10:52:54
1020	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:52:54	2021-06-09 10:52:54
1039	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:53:12	2021-06-09 10:53:12
1040	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:53:12	2021-06-09 10:53:12
1041	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:53:12	2021-06-09 10:53:12
949	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:27:36	2021-06-09 08:27:36
950	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:27:36	2021-06-09 08:27:36
951	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:27:36	2021-06-09 08:27:36
958	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:31:30	2021-06-09 08:31:30
959	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:31:30	2021-06-09 08:31:30
960	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:31:30	2021-06-09 08:31:30
1006	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 10:52:45	2021-06-09 10:52:45
1007	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 10:52:45	2021-06-09 10:52:45
1008	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 10:52:45	2021-06-09 10:52:45
1033	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:53:10	2021-06-09 10:53:10
1034	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:53:10	2021-06-09 10:53:10
1035	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:53:10	2021-06-09 10:53:10
952	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:27:41	2021-06-09 08:27:41
953	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:27:41	2021-06-09 08:27:41
954	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:27:41	2021-06-09 08:27:41
961	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:48:37	2021-06-09 08:48:37
962	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:48:37	2021-06-09 08:48:37
963	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:48:37	2021-06-09 08:48:37
973	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:55:39	2021-06-09 08:55:39
974	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:55:39	2021-06-09 08:55:39
975	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:55:39	2021-06-09 08:55:39
982	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:57:04	2021-06-09 08:57:04
983	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:57:04	2021-06-09 08:57:04
984	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:57:04	2021-06-09 08:57:04
994	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 09:48:27	2021-06-09 09:48:27
995	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 09:48:27	2021-06-09 09:48:27
996	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 09:48:27	2021-06-09 09:48:27
1000	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 09:57:51	2021-06-09 09:57:51
1001	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 09:57:51	2021-06-09 09:57:51
1002	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 09:57:51	2021-06-09 09:57:51
1027	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:53:07	2021-06-09 10:53:07
1028	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:53:07	2021-06-09 10:53:07
1029	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:53:07	2021-06-09 10:53:07
1030	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:53:08	2021-06-09 10:53:08
1031	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:53:08	2021-06-09 10:53:08
1032	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:53:08	2021-06-09 10:53:08
1036	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:53:11	2021-06-09 10:53:11
1037	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:53:11	2021-06-09 10:53:11
1038	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:53:11	2021-06-09 10:53:11
1045	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:53:14	2021-06-09 10:53:14
1046	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:53:14	2021-06-09 10:53:14
1047	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:53:14	2021-06-09 10:53:14
964	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 08:48:47	2021-06-09 08:48:47
965	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 08:48:47	2021-06-09 08:48:47
966	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 08:48:47	2021-06-09 08:48:47
967	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 08:51:05	2021-06-09 08:51:05
968	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 08:51:05	2021-06-09 08:51:05
969	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 08:51:05	2021-06-09 08:51:05
976	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 08:55:51	2021-06-09 08:55:51
977	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 08:55:51	2021-06-09 08:55:51
978	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 08:55:51	2021-06-09 08:55:51
1042	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:53:13	2021-06-09 10:53:13
1043	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:53:13	2021-06-09 10:53:13
1044	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:53:13	2021-06-09 10:53:13
997	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 09:49:04	2021-06-09 09:49:04
998	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 09:49:04	2021-06-09 09:49:04
999	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 09:49:04	2021-06-09 09:49:04
1012	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 10:52:50	2021-06-09 10:52:50
1013	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 10:52:50	2021-06-09 10:52:50
1014	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 10:52:50	2021-06-09 10:52:50
1024	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:53:04	2021-06-09 10:53:04
1025	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:53:04	2021-06-09 10:53:04
1026	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:53:04	2021-06-09 10:53:04
1009	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:52:46	2021-06-09 10:52:46
1010	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:52:46	2021-06-09 10:52:46
1011	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:52:46	2021-06-09 10:52:46
1021	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:52:58	2021-06-09 10:52:58
1022	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:52:58	2021-06-09 10:52:58
1023	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:52:58	2021-06-09 10:52:58
1048	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:55:12	2021-06-09 10:55:12
1049	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:55:12	2021-06-09 10:55:12
1050	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:55:12	2021-06-09 10:55:12
1051	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:55:17	2021-06-09 10:55:17
1052	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:55:17	2021-06-09 10:55:17
1053	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:55:17	2021-06-09 10:55:17
1054	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-09 10:56:27	2021-06-09 10:56:27
1055	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-09 10:56:27	2021-06-09 10:56:27
1056	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-09 10:56:27	2021-06-09 10:56:27
1057	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 10:56:34	2021-06-09 10:56:34
1058	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 10:56:34	2021-06-09 10:56:34
1059	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 10:56:34	2021-06-09 10:56:34
1060	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 10:56:36	2021-06-09 10:56:36
1061	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 10:56:36	2021-06-09 10:56:36
1062	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 10:56:36	2021-06-09 10:56:36
1063	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 11:22:47	2021-06-09 11:22:47
1064	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 11:22:47	2021-06-09 11:22:47
1065	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 11:22:47	2021-06-09 11:22:47
1066	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 11:22:48	2021-06-09 11:22:48
1067	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 11:22:48	2021-06-09 11:22:48
1068	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 11:22:48	2021-06-09 11:22:48
1069	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 11:27:23	2021-06-09 11:27:23
1070	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 11:27:23	2021-06-09 11:27:23
1071	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 11:27:23	2021-06-09 11:27:23
1072	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 11:27:28	2021-06-09 11:27:28
1073	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 11:27:28	2021-06-09 11:27:28
1074	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 11:27:28	2021-06-09 11:27:28
1075	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 11:28:01	2021-06-09 11:28:01
1076	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 11:28:01	2021-06-09 11:28:01
1077	T??che "append%2==1"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 11:28:01	2021-06-09 11:28:01
1078	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 11:57:48	2021-06-09 11:57:48
1079	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 11:57:48	2021-06-09 11:57:48
1080	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 11:57:48	2021-06-09 11:57:48
1081	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:00:35	2021-06-09 12:00:35
1082	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:00:35	2021-06-09 12:00:35
1083	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:00:35	2021-06-09 12:00:35
1084	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 12:00:36	2021-06-09 12:00:36
1085	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 12:00:36	2021-06-09 12:00:36
1086	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 12:00:36	2021-06-09 12:00:36
1087	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:04:53	2021-06-09 12:04:53
1088	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:04:53	2021-06-09 12:04:53
1089	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:04:53	2021-06-09 12:04:53
2456	T??che 89 archiv??e par Mgbi.	f	57	53	2021-06-21 06:25:38	2021-06-21 06:25:38
1090	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 12:04:55	2021-06-09 12:04:55
1091	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 12:04:55	2021-06-09 12:04:55
1092	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 12:04:55	2021-06-09 12:04:55
1102	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 12:36:10	2021-06-09 12:36:10
1103	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 12:36:10	2021-06-09 12:36:10
1104	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 12:36:10	2021-06-09 12:36:10
1192	Une t??che fille de votre t??che primaire cerise sur le g??teau du nom de cerise2 a ??t?? cr??ee par Mgbi1 dans le projet mon_projet	f	54	57	2021-06-09 13:14:09	2021-06-09 13:14:09
1093	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:34:26	2021-06-09 12:34:26
1094	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:34:26	2021-06-09 12:34:26
1095	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:34:26	2021-06-09 12:34:26
1108	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 12:41:52	2021-06-09 12:41:52
1109	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 12:41:52	2021-06-09 12:41:52
1110	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 12:41:52	2021-06-09 12:41:52
1135	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:04:46	2021-06-09 13:04:46
1136	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:04:46	2021-06-09 13:04:46
1137	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:04:46	2021-06-09 13:04:46
1168	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:06:19	2021-06-09 13:06:19
1169	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:06:19	2021-06-09 13:06:19
1170	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:06:19	2021-06-09 13:06:19
1096	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:34:54	2021-06-09 12:34:54
1097	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:34:54	2021-06-09 12:34:54
1098	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:34:54	2021-06-09 12:34:54
1099	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:36:09	2021-06-09 12:36:09
1100	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:36:09	2021-06-09 12:36:09
1101	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:36:09	2021-06-09 12:36:09
1129	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:03:39	2021-06-09 13:03:39
1130	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:03:39	2021-06-09 13:03:39
1131	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:03:39	2021-06-09 13:03:39
1144	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:05:45	2021-06-09 13:05:45
1145	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:05:45	2021-06-09 13:05:45
1146	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:05:45	2021-06-09 13:05:45
1147	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:05:49	2021-06-09 13:05:49
1148	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:05:49	2021-06-09 13:05:49
1149	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:05:49	2021-06-09 13:05:49
1105	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 12:41:50	2021-06-09 12:41:50
1106	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 12:41:50	2021-06-09 12:41:50
1107	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 12:41:50	2021-06-09 12:41:50
1159	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:06:00	2021-06-09 13:06:00
1160	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:06:00	2021-06-09 13:06:00
1161	T??che "children_length_test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:06:00	2021-06-09 13:06:00
1165	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:06:08	2021-06-09 13:06:08
1166	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:06:08	2021-06-09 13:06:08
1167	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:06:08	2021-06-09 13:06:08
1111	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:02:08	2021-06-09 13:02:08
1112	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:02:08	2021-06-09 13:02:08
1113	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:02:08	2021-06-09 13:02:08
1114	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:02:16	2021-06-09 13:02:16
1115	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:02:16	2021-06-09 13:02:16
1116	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:02:16	2021-06-09 13:02:16
1126	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:02:43	2021-06-09 13:02:43
1127	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:02:43	2021-06-09 13:02:43
1128	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:02:43	2021-06-09 13:02:43
1150	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:05:58	2021-06-09 13:05:58
1151	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:05:58	2021-06-09 13:05:58
1152	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:05:58	2021-06-09 13:05:58
1183	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:11:32	2021-06-09 13:11:32
1184	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:11:32	2021-06-09 13:11:32
1185	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:11:32	2021-06-09 13:11:32
1197	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:14:34	2021-06-09 13:14:34
1198	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:14:34	2021-06-09 13:14:34
1199	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:14:34	2021-06-09 13:14:34
1117	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:02:32	2021-06-09 13:02:32
1118	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:02:32	2021-06-09 13:02:32
1119	T??che "children_length_test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:02:32	2021-06-09 13:02:32
1153	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 13:05:59	2021-06-09 13:05:59
1154	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 13:05:59	2021-06-09 13:05:59
1155	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 13:05:59	2021-06-09 13:05:59
1200	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:15:00	2021-06-09 13:15:00
1201	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:15:00	2021-06-09 13:15:00
1202	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:15:00	2021-06-09 13:15:00
1120	T??che "test_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:02:36	2021-06-09 13:02:36
1121	T??che "test_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:02:36	2021-06-09 13:02:36
1122	T??che "test_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:02:36	2021-06-09 13:02:36
1123	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:02:40	2021-06-09 13:02:40
1124	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:02:40	2021-06-09 13:02:40
1125	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:02:40	2021-06-09 13:02:40
1132	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:04:41	2021-06-09 13:04:41
1133	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:04:41	2021-06-09 13:04:41
1134	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:04:41	2021-06-09 13:04:41
1174	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:10:54	2021-06-09 13:10:54
1175	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:10:54	2021-06-09 13:10:54
1176	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:10:54	2021-06-09 13:10:54
1193	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi1	f	54	57	2021-06-09 13:14:30	2021-06-09 13:14:30
1194	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi1	f	54	53	2021-06-09 13:14:30	2021-06-09 13:14:30
1195	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi1	f	54	41	2021-06-09 13:14:30	2021-06-09 13:14:30
1196	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi1	f	54	52	2021-06-09 13:14:30	2021-06-09 13:14:30
1138	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:05:31	2021-06-09 13:05:31
1139	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:05:31	2021-06-09 13:05:31
1140	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:05:31	2021-06-09 13:05:31
1141	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:05:43	2021-06-09 13:05:43
1142	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:05:43	2021-06-09 13:05:43
1143	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:05:43	2021-06-09 13:05:43
1162	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:06:01	2021-06-09 13:06:01
1163	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:06:01	2021-06-09 13:06:01
1164	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:06:01	2021-06-09 13:06:01
1177	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:11:01	2021-06-09 13:11:01
1178	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:11:01	2021-06-09 13:11:01
1179	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:11:01	2021-06-09 13:11:01
1156	T??che "test_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:06:00	2021-06-09 13:06:00
1157	T??che "test_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:06:00	2021-06-09 13:06:00
1158	T??che "test_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:06:00	2021-06-09 13:06:00
1171	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 13:10:48	2021-06-09 13:10:48
1172	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 13:10:48	2021-06-09 13:10:48
1173	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 13:10:48	2021-06-09 13:10:48
1180	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:11:26	2021-06-09 13:11:26
1181	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:11:26	2021-06-09 13:11:26
1182	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:11:26	2021-06-09 13:11:26
1186	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:13:01	2021-06-09 13:13:01
1187	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:13:01	2021-06-09 13:13:01
1188	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:13:01	2021-06-09 13:13:01
1189	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:13:05	2021-06-09 13:13:05
1190	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:13:05	2021-06-09 13:13:05
1191	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:13:05	2021-06-09 13:13:05
1203	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:20:17	2021-06-09 13:20:17
1204	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:20:17	2021-06-09 13:20:17
1205	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:20:17	2021-06-09 13:20:17
1206	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:20:22	2021-06-09 13:20:22
1207	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:20:22	2021-06-09 13:20:22
1208	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:20:22	2021-06-09 13:20:22
1209	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:20:30	2021-06-09 13:20:30
1210	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:20:30	2021-06-09 13:20:30
1211	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:20:30	2021-06-09 13:20:30
1212	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:20:33	2021-06-09 13:20:33
1213	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:20:33	2021-06-09 13:20:33
1214	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:20:33	2021-06-09 13:20:33
1215	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:20:36	2021-06-09 13:20:36
1216	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:20:36	2021-06-09 13:20:36
1217	T??che "notif2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:20:36	2021-06-09 13:20:36
1218	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 13:20:39	2021-06-09 13:20:39
1219	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 13:20:39	2021-06-09 13:20:39
1220	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 13:20:39	2021-06-09 13:20:39
1221	Une t??che fille de votre t??che primaire cerise sur le g??teau du nom de cerise3 a ??t?? cr??ee par Mgbi1 dans le projet mon_projet	f	54	57	2021-06-09 13:21:35	2021-06-09 13:21:35
1222	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 13:21:42	2021-06-09 13:21:42
1223	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 13:21:42	2021-06-09 13:21:42
1224	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 13:21:42	2021-06-09 13:21:42
1225	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:21:44	2021-06-09 13:21:44
1226	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:21:44	2021-06-09 13:21:44
1227	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:21:44	2021-06-09 13:21:44
1228	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:21:57	2021-06-09 13:21:57
1229	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:21:57	2021-06-09 13:21:57
1230	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:21:57	2021-06-09 13:21:57
1231	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:31:28	2021-06-09 13:31:28
1232	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:31:28	2021-06-09 13:31:28
1233	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:31:28	2021-06-09 13:31:28
1235	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi1	f	54	53	2021-06-09 13:31:29	2021-06-09 13:31:29
1236	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi1	f	54	41	2021-06-09 13:31:29	2021-06-09 13:31:29
1237	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi1	f	54	52	2021-06-09 13:31:29	2021-06-09 13:31:29
1238	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:32:29	2021-06-09 13:32:29
1239	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:32:29	2021-06-09 13:32:29
1240	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:32:29	2021-06-09 13:32:29
1241	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 13:34:28	2021-06-09 13:34:28
1242	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 13:34:28	2021-06-09 13:34:28
1243	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 13:34:28	2021-06-09 13:34:28
1244	La t??che cerise sur le g??teau a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	53	2021-06-09 13:34:32	2021-06-09 13:34:32
1245	La t??che cerise sur le g??teau a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	41	2021-06-09 13:34:32	2021-06-09 13:34:32
1246	La t??che cerise sur le g??teau a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	52	2021-06-09 13:34:32	2021-06-09 13:34:32
1269	T??che "work"\n          du projet mon_projet mise dans " A faire " par Test	f	41	53	2021-06-09 13:37:09	2021-06-09 13:37:09
1270	T??che "work"\n          du projet mon_projet mise dans " A faire " par Test	f	41	52	2021-06-09 13:37:09	2021-06-09 13:37:09
1272	T??che "append%2==1"\n          du projet mon_projet mise dans " A faire " par Test	f	41	53	2021-06-09 13:37:11	2021-06-09 13:37:11
1273	T??che "append%2==1"\n          du projet mon_projet mise dans " A faire " par Test	f	41	52	2021-06-09 13:37:11	2021-06-09 13:37:11
1275	T??che "doudousy2"\n          du projet mon_projet mise dans " A faire " par Test	f	41	53	2021-06-09 13:37:12	2021-06-09 13:37:12
1276	T??che "doudousy2"\n          du projet mon_projet mise dans " A faire " par Test	f	41	52	2021-06-09 13:37:12	2021-06-09 13:37:12
1268	T??che "work"\n          du projet mon_projet mise dans " A faire " par Test	t	41	57	2021-06-09 13:37:09	2021-06-09 13:37:09
1271	T??che "append%2==1"\n          du projet mon_projet mise dans " A faire " par Test	t	41	57	2021-06-09 13:37:11	2021-06-09 13:37:11
1274	T??che "doudousy2"\n          du projet mon_projet mise dans " A faire " par Test	t	41	57	2021-06-09 13:37:12	2021-06-09 13:37:12
1247	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 13:34:32	2021-06-09 13:34:32
1248	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 13:34:32	2021-06-09 13:34:32
1249	T??che "cerise3"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 13:34:32	2021-06-09 13:34:32
1251	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Test	f	41	53	2021-06-09 13:36:49	2021-06-09 13:36:49
1252	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Test	f	41	52	2021-06-09 13:36:49	2021-06-09 13:36:49
1250	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Test	t	41	57	2021-06-09 13:36:49	2021-06-09 13:36:49
1254	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Test	f	41	53	2021-06-09 13:36:50	2021-06-09 13:36:50
1255	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Test	f	41	52	2021-06-09 13:36:50	2021-06-09 13:36:50
1253	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Test	t	41	57	2021-06-09 13:36:50	2021-06-09 13:36:50
1257	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En cours " par Test	f	41	53	2021-06-09 13:36:52	2021-06-09 13:36:52
1258	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En cours " par Test	f	41	52	2021-06-09 13:36:52	2021-06-09 13:36:52
1266	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Test	f	41	53	2021-06-09 13:36:57	2021-06-09 13:36:57
1267	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Test	f	41	52	2021-06-09 13:36:57	2021-06-09 13:36:57
1256	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En cours " par Test	t	41	57	2021-06-09 13:36:52	2021-06-09 13:36:52
1265	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Test	t	41	57	2021-06-09 13:36:57	2021-06-09 13:36:57
1260	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Test	f	41	53	2021-06-09 13:36:53	2021-06-09 13:36:53
1261	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Test	f	41	52	2021-06-09 13:36:53	2021-06-09 13:36:53
1263	T??che "t??che test"\n          du projet mon_projet mise dans " En cours " par Test	f	41	53	2021-06-09 13:36:56	2021-06-09 13:36:56
1264	T??che "t??che test"\n          du projet mon_projet mise dans " En cours " par Test	f	41	52	2021-06-09 13:36:56	2021-06-09 13:36:56
1277	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 16:49:34	2021-06-09 16:49:34
1278	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 16:49:34	2021-06-09 16:49:34
1279	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 16:49:34	2021-06-09 16:49:34
1280	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-09 16:49:48	2021-06-09 16:49:48
1281	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-09 16:49:48	2021-06-09 16:49:48
1282	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-09 16:49:48	2021-06-09 16:49:48
1283	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 16:49:48	2021-06-09 16:49:48
1284	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 16:49:48	2021-06-09 16:49:48
1285	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 16:49:48	2021-06-09 16:49:48
1286	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-09 18:09:41	2021-06-09 18:09:41
1287	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-09 18:09:41	2021-06-09 18:09:41
1288	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-09 18:09:41	2021-06-09 18:09:41
1289	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 18:09:53	2021-06-09 18:09:53
1290	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 18:09:53	2021-06-09 18:09:53
1291	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 18:09:53	2021-06-09 18:09:53
1292	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 18:10:00	2021-06-09 18:10:00
1293	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 18:10:00	2021-06-09 18:10:00
1294	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 18:10:00	2021-06-09 18:10:00
1295	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-09 18:10:51	2021-06-09 18:10:51
1296	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-09 18:10:51	2021-06-09 18:10:51
1297	T??che "primaire"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-09 18:10:51	2021-06-09 18:10:51
1298	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-09 20:03:21	2021-06-09 20:03:21
1299	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-09 20:03:21	2021-06-09 20:03:21
1300	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-09 20:03:21	2021-06-09 20:03:21
1301	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-09 20:03:22	2021-06-09 20:03:22
1302	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-09 20:03:22	2021-06-09 20:03:22
1303	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-09 20:03:22	2021-06-09 20:03:22
1304	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 20:03:23	2021-06-09 20:03:23
1305	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 20:03:23	2021-06-09 20:03:23
1306	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 20:03:23	2021-06-09 20:03:23
1307	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-09 20:03:24	2021-06-09 20:03:24
1308	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-09 20:03:24	2021-06-09 20:03:24
1309	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-09 20:03:24	2021-06-09 20:03:24
1310	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 21:10:27	2021-06-09 21:10:27
1311	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 21:10:27	2021-06-09 21:10:27
1312	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 21:10:27	2021-06-09 21:10:27
1313	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-09 21:10:31	2021-06-09 21:10:31
1314	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-09 21:10:31	2021-06-09 21:10:31
1315	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-09 21:10:31	2021-06-09 21:10:31
1316	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-10 07:09:29	2021-06-10 07:09:29
1317	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-10 07:09:29	2021-06-10 07:09:29
1318	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-10 07:09:29	2021-06-10 07:09:29
1319	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-10 07:09:29	2021-06-10 07:09:29
1320	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-10 07:09:29	2021-06-10 07:09:29
1321	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-10 07:09:29	2021-06-10 07:09:29
2457	T??che 89 archiv??e par Mgbi.	f	57	41	2021-06-21 06:25:38	2021-06-21 06:25:38
2458	T??che 89 archiv??e par Mgbi.	f	57	52	2021-06-21 06:25:38	2021-06-21 06:25:38
1322	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-10 07:09:39	2021-06-10 07:09:39
1323	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-10 07:09:39	2021-06-10 07:09:39
1324	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-10 07:09:39	2021-06-10 07:09:39
1325	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-10 07:09:40	2021-06-10 07:09:40
1326	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-10 07:09:40	2021-06-10 07:09:40
1327	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-10 07:09:40	2021-06-10 07:09:40
1328	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-10 07:09:41	2021-06-10 07:09:41
1329	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-10 07:09:41	2021-06-10 07:09:41
1330	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-10 07:09:41	2021-06-10 07:09:41
1331	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-10 07:09:41	2021-06-10 07:09:41
1332	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-10 07:09:41	2021-06-10 07:09:41
1333	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-10 07:09:41	2021-06-10 07:09:41
1334	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-10 07:09:43	2021-06-10 07:09:43
1335	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-10 07:09:43	2021-06-10 07:09:43
1336	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-10 07:09:43	2021-06-10 07:09:43
1338	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	52	53	2021-06-10 07:30:25	2021-06-10 07:30:25
1339	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	52	41	2021-06-10 07:30:25	2021-06-10 07:30:25
1341	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	f	52	53	2021-06-10 07:30:25	2021-06-10 07:30:25
1342	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	f	52	41	2021-06-10 07:30:25	2021-06-10 07:30:25
1344	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	53	2021-06-10 07:30:32	2021-06-10 07:30:32
1345	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	41	2021-06-10 07:30:32	2021-06-10 07:30:32
1347	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	53	2021-06-10 07:30:33	2021-06-10 07:30:33
1348	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	41	2021-06-10 07:30:33	2021-06-10 07:30:33
1350	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	53	2021-06-10 07:30:34	2021-06-10 07:30:34
1351	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Admin	f	52	41	2021-06-10 07:30:34	2021-06-10 07:30:34
1353	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Admin	f	52	53	2021-06-10 07:30:35	2021-06-10 07:30:35
1354	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Admin	f	52	41	2021-06-10 07:30:35	2021-06-10 07:30:35
1356	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	53	2021-06-10 07:30:37	2021-06-10 07:30:37
1357	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	41	2021-06-10 07:30:37	2021-06-10 07:30:37
1359	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	53	2021-06-10 07:31:48	2021-06-10 07:31:48
1360	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	41	2021-06-10 07:31:48	2021-06-10 07:31:48
1361	T??che nouvellement cr??ee du nom de tache  par Mgbi dans le projet QLM Site E-commerce.	f	57	53	2021-06-11 12:31:21	2021-06-11 12:31:21
1362	T??che nouvellement cr??ee du nom de tache  par Mgbi dans le projet QLM Site E-commerce.	f	57	41	2021-06-11 12:31:21	2021-06-11 12:31:21
1363	T??che nouvellement cr??ee du nom de tache  par Mgbi dans le projet QLM Site E-commerce.	f	57	52	2021-06-11 12:31:21	2021-06-11 12:31:21
1364	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-11 12:31:26	2021-06-11 12:31:26
1365	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-11 12:31:26	2021-06-11 12:31:26
1366	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-11 12:31:26	2021-06-11 12:31:26
1367	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-11 12:31:29	2021-06-11 12:31:29
1368	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-11 12:31:29	2021-06-11 12:31:29
1369	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-11 12:31:29	2021-06-11 12:31:29
1370	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 12:31:39	2021-06-11 12:31:39
1337	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	t	52	57	2021-06-10 07:30:25	2021-06-10 07:30:25
2612	La requ??te Test est en cours	f	57	33	2021-07-04 17:38:10	2021-07-04 17:38:10
2670	T??che t??che test archiv??e par Mgbi.	f	57	53	2021-07-05 08:25:52	2021-07-05 08:25:52
2671	T??che t??che test archiv??e par Mgbi.	f	57	41	2021-07-05 08:25:52	2021-07-05 08:25:52
2672	T??che t??che test archiv??e par Mgbi.	f	57	52	2021-07-05 08:25:52	2021-07-05 08:25:52
2875	Un projet du nom de sans debut a ??t?? cr??e par Mgbi	f	57	53	2021-08-31 06:47:54	2021-08-31 06:47:54
2876	Un projet du nom de sans debut a ??t?? cr??e par Mgbi	f	57	41	2021-08-31 06:47:54	2021-08-31 06:47:54
2877	Un projet du nom de sans debut a ??t?? cr??e par Mgbi	f	57	52	2021-08-31 06:47:54	2021-08-31 06:47:54
2878	T??che nouvellement cr??ee du nom de t??che sans contr??le par Mgbi dans le projet Un projet.	f	57	53	2021-08-31 08:03:39	2021-08-31 08:03:39
2879	T??che nouvellement cr??ee du nom de t??che sans contr??le par Mgbi dans le projet Un projet.	f	57	41	2021-08-31 08:03:39	2021-08-31 08:03:39
2880	T??che nouvellement cr??ee du nom de t??che sans contr??le par Mgbi dans le projet Un projet.	f	57	52	2021-08-31 08:03:39	2021-08-31 08:03:39
1371	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 12:31:39	2021-06-11 12:31:39
1372	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 12:31:39	2021-06-11 12:31:39
1373	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 12:31:41	2021-06-11 12:31:41
1374	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 12:31:41	2021-06-11 12:31:41
1375	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 12:31:41	2021-06-11 12:31:41
1376	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 12:31:47	2021-06-11 12:31:47
1377	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 12:31:47	2021-06-11 12:31:47
1378	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 12:31:47	2021-06-11 12:31:47
1379	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 12:31:50	2021-06-11 12:31:50
1380	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 12:31:50	2021-06-11 12:31:50
1381	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 12:31:50	2021-06-11 12:31:50
1382	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-11 12:31:53	2021-06-11 12:31:53
1383	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-11 12:31:53	2021-06-11 12:31:53
1384	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-11 12:31:53	2021-06-11 12:31:53
1385	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 12:32:46	2021-06-11 12:32:46
1386	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 12:32:46	2021-06-11 12:32:46
1387	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 12:32:46	2021-06-11 12:32:46
1388	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 12:32:50	2021-06-11 12:32:50
1389	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 12:32:50	2021-06-11 12:32:50
1390	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 12:32:50	2021-06-11 12:32:50
1391	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 12:32:53	2021-06-11 12:32:53
1392	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 12:32:53	2021-06-11 12:32:53
1393	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 12:32:53	2021-06-11 12:32:53
1394	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 12:34:54	2021-06-11 12:34:54
1395	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 12:34:54	2021-06-11 12:34:54
1396	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 12:34:54	2021-06-11 12:34:54
1397	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 12:34:57	2021-06-11 12:34:57
1398	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 12:34:57	2021-06-11 12:34:57
1399	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 12:34:57	2021-06-11 12:34:57
1400	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 12:34:59	2021-06-11 12:34:59
1401	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 12:34:59	2021-06-11 12:34:59
1402	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 12:34:59	2021-06-11 12:34:59
1403	Mgbi vous a assign?? ?? la t??che Cr??ation interface Accueil.	f	57	56	2021-06-11 12:35:36	2021-06-11 12:35:36
1404	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-11 15:26:31	2021-06-11 15:26:31
1405	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-11 15:26:31	2021-06-11 15:26:31
1406	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-11 15:26:31	2021-06-11 15:26:31
1407	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:11:59	2021-06-11 16:11:59
1408	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:11:59	2021-06-11 16:11:59
1409	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:11:59	2021-06-11 16:11:59
1410	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:12:26	2021-06-11 16:12:26
1411	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:12:26	2021-06-11 16:12:26
1412	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:12:26	2021-06-11 16:12:26
1413	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:12:41	2021-06-11 16:12:41
1414	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:12:41	2021-06-11 16:12:41
1415	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:12:41	2021-06-11 16:12:41
1416	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:13:23	2021-06-11 16:13:23
1417	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:13:23	2021-06-11 16:13:23
1418	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:13:23	2021-06-11 16:13:23
1419	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:13:25	2021-06-11 16:13:25
1420	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:13:25	2021-06-11 16:13:25
1421	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:13:25	2021-06-11 16:13:25
1422	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:13:27	2021-06-11 16:13:27
1423	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:13:27	2021-06-11 16:13:27
1424	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:13:27	2021-06-11 16:13:27
1425	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:13:32	2021-06-11 16:13:32
1426	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:13:32	2021-06-11 16:13:32
1427	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:13:32	2021-06-11 16:13:32
1428	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:13:53	2021-06-11 16:13:53
1429	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:13:53	2021-06-11 16:13:53
1430	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:13:53	2021-06-11 16:13:53
1431	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:13:59	2021-06-11 16:13:59
1432	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:13:59	2021-06-11 16:13:59
1433	T??che "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:13:59	2021-06-11 16:13:59
1434	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:14:02	2021-06-11 16:14:02
1435	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:14:02	2021-06-11 16:14:02
1436	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:14:02	2021-06-11 16:14:02
1446	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:21:45	2021-06-11 16:21:45
1447	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:21:45	2021-06-11 16:21:45
1448	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:21:45	2021-06-11 16:21:45
1452	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:21:48	2021-06-11 16:21:48
1453	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:21:48	2021-06-11 16:21:48
1454	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:21:48	2021-06-11 16:21:48
1437	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:14:03	2021-06-11 16:14:03
1438	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:14:03	2021-06-11 16:14:03
1439	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:14:03	2021-06-11 16:14:03
1440	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 16:14:04	2021-06-11 16:14:04
1441	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 16:14:04	2021-06-11 16:14:04
1442	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 16:14:04	2021-06-11 16:14:04
1443	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 16:14:07	2021-06-11 16:14:07
1444	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 16:14:07	2021-06-11 16:14:07
1445	T??che "EXEMPLE"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 16:14:07	2021-06-11 16:14:07
1449	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 16:21:46	2021-06-11 16:21:46
1450	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 16:21:46	2021-06-11 16:21:46
1451	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 16:21:46	2021-06-11 16:21:46
1455	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 16:21:49	2021-06-11 16:21:49
1456	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 16:21:49	2021-06-11 16:21:49
1457	T??che "4eme"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 16:21:49	2021-06-11 16:21:49
1458	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 20:59:19	2021-06-11 20:59:19
1459	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 20:59:19	2021-06-11 20:59:19
1460	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 20:59:19	2021-06-11 20:59:19
1461	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 20:59:30	2021-06-11 20:59:30
1462	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 20:59:30	2021-06-11 20:59:30
1463	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 20:59:30	2021-06-11 20:59:30
1464	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 20:59:32	2021-06-11 20:59:32
1465	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 20:59:32	2021-06-11 20:59:32
1466	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 20:59:32	2021-06-11 20:59:32
1467	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 20:59:33	2021-06-11 20:59:33
1468	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 20:59:33	2021-06-11 20:59:33
1469	T??che "cinqui??me"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 20:59:33	2021-06-11 20:59:33
1470	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 20:59:34	2021-06-11 20:59:34
1471	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 20:59:34	2021-06-11 20:59:34
1472	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 20:59:34	2021-06-11 20:59:34
1473	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 20:59:35	2021-06-11 20:59:35
1474	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 20:59:35	2021-06-11 20:59:35
1475	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 20:59:35	2021-06-11 20:59:35
1476	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:01:15	2021-06-11 21:01:15
1477	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:01:15	2021-06-11 21:01:15
1478	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:01:15	2021-06-11 21:01:15
1479	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:01:17	2021-06-11 21:01:17
1480	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:01:17	2021-06-11 21:01:17
1481	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:01:17	2021-06-11 21:01:17
1482	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:01:18	2021-06-11 21:01:18
1483	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:01:18	2021-06-11 21:01:18
1484	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:01:18	2021-06-11 21:01:18
1485	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:03:42	2021-06-11 21:03:42
1486	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:03:42	2021-06-11 21:03:42
1487	T??che "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:03:42	2021-06-11 21:03:42
1488	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:03:50	2021-06-11 21:03:50
1489	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:03:50	2021-06-11 21:03:50
1490	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:03:50	2021-06-11 21:03:50
1491	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:03:53	2021-06-11 21:03:53
1492	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:03:53	2021-06-11 21:03:53
1493	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:03:53	2021-06-11 21:03:53
1494	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:03:54	2021-06-11 21:03:54
1495	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:03:54	2021-06-11 21:03:54
1496	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:03:54	2021-06-11 21:03:54
1497	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:04:40	2021-06-11 21:04:40
1498	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:04:40	2021-06-11 21:04:40
1499	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:04:40	2021-06-11 21:04:40
1500	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:04:42	2021-06-11 21:04:42
1501	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:04:42	2021-06-11 21:04:42
1502	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:04:42	2021-06-11 21:04:42
1503	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:04:44	2021-06-11 21:04:44
1504	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:04:44	2021-06-11 21:04:44
1505	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:04:44	2021-06-11 21:04:44
1506	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:04:44	2021-06-11 21:04:44
1507	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:04:44	2021-06-11 21:04:44
1508	T??che "cinqui??me"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:04:44	2021-06-11 21:04:44
1524	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:06:12	2021-06-11 21:06:12
1525	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:06:12	2021-06-11 21:06:12
1526	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:06:12	2021-06-11 21:06:12
1539	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:28	2021-06-11 21:06:28
1540	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:28	2021-06-11 21:06:28
1541	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:28	2021-06-11 21:06:28
1560	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:07:38	2021-06-11 21:07:38
1561	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:07:38	2021-06-11 21:07:38
1562	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:07:38	2021-06-11 21:07:38
1566	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:07:42	2021-06-11 21:07:42
1567	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:07:42	2021-06-11 21:07:42
1568	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:07:42	2021-06-11 21:07:42
1569	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:07:43	2021-06-11 21:07:43
1570	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:07:43	2021-06-11 21:07:43
1571	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:07:43	2021-06-11 21:07:43
1575	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:07:49	2021-06-11 21:07:49
1576	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:07:49	2021-06-11 21:07:49
1577	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:07:49	2021-06-11 21:07:49
1578	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:07:56	2021-06-11 21:07:56
1579	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:07:56	2021-06-11 21:07:56
1580	T??che "task_children"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:07:56	2021-06-11 21:07:56
1590	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:08:00	2021-06-11 21:08:00
1591	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:08:00	2021-06-11 21:08:00
1592	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:08:00	2021-06-11 21:08:00
1509	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:05:06	2021-06-11 21:05:06
1510	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:05:06	2021-06-11 21:05:06
1511	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:05:06	2021-06-11 21:05:06
1548	T??che "work"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:36	2021-06-11 21:06:36
1549	T??che "work"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:36	2021-06-11 21:06:36
1550	T??che "work"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:36	2021-06-11 21:06:36
1587	T??che "tache notif"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:07:59	2021-06-11 21:07:59
1588	T??che "tache notif"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:07:59	2021-06-11 21:07:59
1589	T??che "tache notif"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:07:59	2021-06-11 21:07:59
1512	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:05:08	2021-06-11 21:05:08
1513	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:05:08	2021-06-11 21:05:08
1514	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:05:08	2021-06-11 21:05:08
1530	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:21	2021-06-11 21:06:21
1531	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:21	2021-06-11 21:06:21
1532	T??che "primaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:21	2021-06-11 21:06:21
1536	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:06:25	2021-06-11 21:06:25
1537	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:06:25	2021-06-11 21:06:25
1538	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:06:25	2021-06-11 21:06:25
1551	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:06:48	2021-06-11 21:06:48
1552	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:06:48	2021-06-11 21:06:48
1553	T??che "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:06:48	2021-06-11 21:06:48
1554	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:55	2021-06-11 21:06:55
1555	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:55	2021-06-11 21:06:55
1556	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:55	2021-06-11 21:06:55
1581	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:07:57	2021-06-11 21:07:57
1582	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:07:57	2021-06-11 21:07:57
1583	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:07:57	2021-06-11 21:07:57
1515	T??che "notif2"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:05:12	2021-06-11 21:05:12
1516	T??che "notif2"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:05:12	2021-06-11 21:05:12
1517	T??che "notif2"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:05:12	2021-06-11 21:05:12
1584	T??che "89"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:07:59	2021-06-11 21:07:59
1585	T??che "89"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:07:59	2021-06-11 21:07:59
1586	T??che "89"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:07:59	2021-06-11 21:07:59
1518	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:05:14	2021-06-11 21:05:14
1519	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:05:14	2021-06-11 21:05:14
1520	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:05:14	2021-06-11 21:05:14
1527	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:13	2021-06-11 21:06:13
1528	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:13	2021-06-11 21:06:13
1529	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:13	2021-06-11 21:06:13
1521	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:06:09	2021-06-11 21:06:09
1522	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:06:09	2021-06-11 21:06:09
1523	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:06:09	2021-06-11 21:06:09
1557	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:07:37	2021-06-11 21:07:37
1558	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:07:37	2021-06-11 21:07:37
1559	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:07:37	2021-06-11 21:07:37
1563	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:07:41	2021-06-11 21:07:41
1564	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:07:41	2021-06-11 21:07:41
1565	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:07:41	2021-06-11 21:07:41
1572	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:07:44	2021-06-11 21:07:44
1573	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:07:44	2021-06-11 21:07:44
1574	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:07:44	2021-06-11 21:07:44
1533	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:24	2021-06-11 21:06:24
1534	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:24	2021-06-11 21:06:24
1535	T??che "notif2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:24	2021-06-11 21:06:24
1542	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:06:33	2021-06-11 21:06:33
1543	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:06:33	2021-06-11 21:06:33
1544	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:06:33	2021-06-11 21:06:33
1545	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:06:34	2021-06-11 21:06:34
1546	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:06:34	2021-06-11 21:06:34
1547	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:06:34	2021-06-11 21:06:34
1593	La t??che ectoassoc a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-11 21:08:42	2021-06-11 21:08:42
1594	La t??che ectoassoc a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-11 21:08:42	2021-06-11 21:08:42
1595	La t??che ectoassoc a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-11 21:08:42	2021-06-11 21:08:42
1596	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-11 21:08:42	2021-06-11 21:08:42
1597	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-11 21:08:42	2021-06-11 21:08:42
1598	T??che "ectoassoc"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-11 21:08:42	2021-06-11 21:08:42
1599	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:08:57	2021-06-11 21:08:57
1600	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:08:57	2021-06-11 21:08:57
1601	T??che "assoc2nde"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:08:57	2021-06-11 21:08:57
1602	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:09:01	2021-06-11 21:09:01
1603	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:09:01	2021-06-11 21:09:01
1604	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:09:01	2021-06-11 21:09:01
1605	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-11 21:09:01	2021-06-11 21:09:01
1606	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-11 21:09:01	2021-06-11 21:09:01
1607	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-11 21:09:01	2021-06-11 21:09:01
1608	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:09:03	2021-06-11 21:09:03
1609	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:09:03	2021-06-11 21:09:03
1610	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:09:03	2021-06-11 21:09:03
1611	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:09:07	2021-06-11 21:09:07
1612	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:09:07	2021-06-11 21:09:07
1613	T??che "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:09:07	2021-06-11 21:09:07
1614	T??che "dodosy"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:09:10	2021-06-11 21:09:10
1615	T??che "dodosy"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:09:10	2021-06-11 21:09:10
1616	T??che "dodosy"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:09:10	2021-06-11 21:09:10
1617	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:10:04	2021-06-11 21:10:04
1618	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:10:04	2021-06-11 21:10:04
1619	T??che "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:10:04	2021-06-11 21:10:04
1620	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:10:12	2021-06-11 21:10:12
1621	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:10:12	2021-06-11 21:10:12
1622	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:10:12	2021-06-11 21:10:12
1623	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:10:38	2021-06-11 21:10:38
1624	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:10:38	2021-06-11 21:10:38
1625	T??che "cinqui??me"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:10:38	2021-06-11 21:10:38
1626	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:11:20	2021-06-11 21:11:20
1627	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:11:20	2021-06-11 21:11:20
1628	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:11:20	2021-06-11 21:11:20
1629	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-11 21:11:50	2021-06-11 21:11:50
1630	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-11 21:11:50	2021-06-11 21:11:50
1631	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-11 21:11:50	2021-06-11 21:11:50
1632	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:11:56	2021-06-11 21:11:56
1633	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:11:56	2021-06-11 21:11:56
1634	T??che "date_insert2"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:11:56	2021-06-11 21:11:56
1635	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:12:19	2021-06-11 21:12:19
1636	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:12:19	2021-06-11 21:12:19
1637	T??che "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:12:19	2021-06-11 21:12:19
1650	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-06-11 21:19:40	2021-06-11 21:19:40
1651	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-06-11 21:19:40	2021-06-11 21:19:40
1652	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-06-11 21:19:40	2021-06-11 21:19:40
1638	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:12:48	2021-06-11 21:12:48
1639	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:12:48	2021-06-11 21:12:48
1640	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:12:48	2021-06-11 21:12:48
1641	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:14:50	2021-06-11 21:14:50
1642	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:14:50	2021-06-11 21:14:50
1643	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:14:50	2021-06-11 21:14:50
1644	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:14:55	2021-06-11 21:14:55
1645	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:14:55	2021-06-11 21:14:55
1646	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:14:55	2021-06-11 21:14:55
1647	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:18:58	2021-06-11 21:18:58
1648	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:18:58	2021-06-11 21:18:58
1649	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:18:58	2021-06-11 21:18:58
1653	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:42:57	2021-06-11 21:42:57
1654	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:42:57	2021-06-11 21:42:57
1655	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:42:57	2021-06-11 21:42:57
1656	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-11 21:43:01	2021-06-11 21:43:01
1657	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-11 21:43:01	2021-06-11 21:43:01
1658	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-11 21:43:01	2021-06-11 21:43:01
1659	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-11 21:43:08	2021-06-11 21:43:08
1660	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-11 21:43:08	2021-06-11 21:43:08
1661	T??che "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-11 21:43:08	2021-06-11 21:43:08
1662	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 08:59:03	2021-06-12 08:59:03
1663	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 08:59:03	2021-06-12 08:59:03
1664	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 08:59:03	2021-06-12 08:59:03
1665	T??che "tache "\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	53	2021-06-12 08:59:09	2021-06-12 08:59:09
1666	T??che "tache "\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	41	2021-06-12 08:59:09	2021-06-12 08:59:09
1667	T??che "tache "\n          du projet QLM Site E-commerce mise dans " A faire " par Mgbi	f	57	52	2021-06-12 08:59:09	2021-06-12 08:59:09
1668	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 08:59:13	2021-06-12 08:59:13
1669	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 08:59:13	2021-06-12 08:59:13
1670	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 08:59:13	2021-06-12 08:59:13
1671	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:00:18	2021-06-12 09:00:18
1672	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:00:18	2021-06-12 09:00:18
1673	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:00:18	2021-06-12 09:00:18
1674	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:00:21	2021-06-12 09:00:21
1675	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:00:21	2021-06-12 09:00:21
1676	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:00:21	2021-06-12 09:00:21
1677	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:00:24	2021-06-12 09:00:24
1678	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:00:24	2021-06-12 09:00:24
1679	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:00:24	2021-06-12 09:00:24
1680	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:00:29	2021-06-12 09:00:29
1681	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:00:29	2021-06-12 09:00:29
1682	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:00:29	2021-06-12 09:00:29
1683	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:00:44	2021-06-12 09:00:44
1684	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:00:44	2021-06-12 09:00:44
1685	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:00:44	2021-06-12 09:00:44
1686	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:00:45	2021-06-12 09:00:45
1687	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:00:45	2021-06-12 09:00:45
1688	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:00:45	2021-06-12 09:00:45
1689	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 09:00:49	2021-06-12 09:00:49
1690	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 09:00:49	2021-06-12 09:00:49
1691	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 09:00:49	2021-06-12 09:00:49
1692	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:00:55	2021-06-12 09:00:55
1757	La requ??te Notification? a ??t?? vue	f	57	33	2021-06-12 09:40:05	2021-06-12 09:40:05
1693	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:00:55	2021-06-12 09:00:55
1694	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:00:55	2021-06-12 09:00:55
1701	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 09:10:32	2021-06-12 09:10:32
1702	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 09:10:32	2021-06-12 09:10:32
1703	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 09:10:32	2021-06-12 09:10:32
1737	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:15:18	2021-06-12 09:15:18
1738	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:15:18	2021-06-12 09:15:18
1739	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:15:18	2021-06-12 09:15:18
1740	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:15:22	2021-06-12 09:15:22
1741	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:15:22	2021-06-12 09:15:22
1742	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:15:22	2021-06-12 09:15:22
1749	La requ??te Fond d'??cran n'est pas en cours	f	57	33	2021-06-12 09:35:34	2021-06-12 09:35:34
1755	La requ??te Notification? a ??t?? vue	f	57	33	2021-06-12 09:39:32	2021-06-12 09:39:32
1756	La requ??te Notification? a ??t?? non vue	f	57	33	2021-06-12 09:40:00	2021-06-12 09:40:00
1760	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:42:11	2021-06-12 09:42:11
1764	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:45:45	2021-06-12 09:45:45
1765	Requ??te Fond d'??cran accomplie	f	57	33	2021-06-12 09:45:51	2021-06-12 09:45:51
1770	La requ??te Samura?? a ??t?? vue	f	57	33	2021-06-12 09:47:20	2021-06-12 09:47:20
1775	La requ??te Fichiers n'est pas en cours	f	57	33	2021-06-12 09:47:39	2021-06-12 09:47:39
1779	Requ??te Fichier texte non accomplie	f	57	33	2021-06-12 09:47:56	2021-06-12 09:47:56
1783	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:48:17	2021-06-12 09:48:17
1695	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 09:10:30	2021-06-12 09:10:30
1696	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 09:10:30	2021-06-12 09:10:30
1697	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 09:10:30	2021-06-12 09:10:30
1698	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 09:10:31	2021-06-12 09:10:31
1699	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 09:10:31	2021-06-12 09:10:31
1700	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 09:10:31	2021-06-12 09:10:31
1713	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 09:10:36	2021-06-12 09:10:36
1714	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 09:10:36	2021-06-12 09:10:36
1715	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 09:10:36	2021-06-12 09:10:36
1725	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 09:11:23	2021-06-12 09:11:23
1726	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 09:11:23	2021-06-12 09:11:23
1727	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 09:11:23	2021-06-12 09:11:23
1728	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:13:58	2021-06-12 09:13:58
1729	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:13:58	2021-06-12 09:13:58
1730	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:13:58	2021-06-12 09:13:58
1743	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:15:24	2021-06-12 09:15:24
1744	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:15:24	2021-06-12 09:15:24
1745	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:15:24	2021-06-12 09:15:24
1752	Requ??te Fond d'??cran non accomplie	f	57	33	2021-06-12 09:35:48	2021-06-12 09:35:48
1754	La requ??te Fond d'??cran est en cours	f	57	33	2021-06-12 09:35:52	2021-06-12 09:35:52
1758	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:41:57	2021-06-12 09:41:57
1767	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:46:01	2021-06-12 09:46:01
1768	Requ??te Fond d'??cran non accomplie	f	57	33	2021-06-12 09:47:01	2021-06-12 09:47:01
1771	La requ??te Requ??te flash a ??t?? vue	f	57	33	2021-06-12 09:47:25	2021-06-12 09:47:25
1772	La requ??te Requ??te flash a ??t?? non vue	f	57	33	2021-06-12 09:47:28	2021-06-12 09:47:28
1773	La requ??te Samura?? a ??t?? non vue	f	57	33	2021-06-12 09:47:32	2021-06-12 09:47:32
1782	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:48:08	2021-06-12 09:48:08
1784	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:48:20	2021-06-12 09:48:20
1799	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	53	2021-06-12 09:51:57	2021-06-12 09:51:57
1800	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	41	2021-06-12 09:51:57	2021-06-12 09:51:57
1801	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	52	2021-06-12 09:51:57	2021-06-12 09:51:57
1798	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	t	54	57	2021-06-12 09:51:57	2021-06-12 09:51:57
1704	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 09:10:32	2021-06-12 09:10:32
1705	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 09:10:32	2021-06-12 09:10:32
1706	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 09:10:32	2021-06-12 09:10:32
1707	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 09:10:33	2021-06-12 09:10:33
1708	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 09:10:33	2021-06-12 09:10:33
1709	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 09:10:33	2021-06-12 09:10:33
1746	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:15:27	2021-06-12 09:15:27
1747	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:15:27	2021-06-12 09:15:27
1748	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:15:27	2021-06-12 09:15:27
1751	Requ??te Fond d'??cran accomplie	f	57	33	2021-06-12 09:35:47	2021-06-12 09:35:47
1763	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:45:27	2021-06-12 09:45:27
1769	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:47:05	2021-06-12 09:47:05
1777	La requ??te Fichiers a ??t?? non vue	f	57	33	2021-06-12 09:47:47	2021-06-12 09:47:47
1778	Requ??te Fichier texte accomplie	f	57	33	2021-06-12 09:47:52	2021-06-12 09:47:52
1710	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	53	2021-06-12 09:10:34	2021-06-12 09:10:34
1711	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	41	2021-06-12 09:10:34	2021-06-12 09:10:34
1712	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Mgbi	f	57	52	2021-06-12 09:10:34	2021-06-12 09:10:34
1716	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:10:39	2021-06-12 09:10:39
1717	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:10:39	2021-06-12 09:10:39
1718	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:10:39	2021-06-12 09:10:39
1753	La requ??te Fond d'??cran n'est pas en cours	f	57	33	2021-06-12 09:35:50	2021-06-12 09:35:50
1766	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:45:57	2021-06-12 09:45:57
1811	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-12 09:52:15	2021-06-12 09:52:15
1812	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-12 09:52:15	2021-06-12 09:52:15
1813	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-12 09:52:15	2021-06-12 09:52:15
1810	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-12 09:52:15	2021-06-12 09:52:15
1719	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:10:43	2021-06-12 09:10:43
1720	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:10:43	2021-06-12 09:10:43
1721	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:10:43	2021-06-12 09:10:43
1722	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:10:46	2021-06-12 09:10:46
1723	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:10:46	2021-06-12 09:10:46
1724	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:10:46	2021-06-12 09:10:46
1731	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 09:14:08	2021-06-12 09:14:08
1732	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 09:14:08	2021-06-12 09:14:08
1733	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 09:14:08	2021-06-12 09:14:08
1750	La requ??te Fond d'??cran est en cours	f	57	33	2021-06-12 09:35:42	2021-06-12 09:35:42
1761	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:42:17	2021-06-12 09:42:17
1781	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:48:05	2021-06-12 09:48:05
1787	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-12 09:49:16	2021-06-12 09:49:16
1788	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-12 09:49:16	2021-06-12 09:49:16
1789	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-12 09:49:16	2021-06-12 09:49:16
1791	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	53	2021-06-12 09:49:20	2021-06-12 09:49:20
1792	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	41	2021-06-12 09:49:20	2021-06-12 09:49:20
1793	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	52	2021-06-12 09:49:20	2021-06-12 09:49:20
1795	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-12 09:49:28	2021-06-12 09:49:28
1796	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-12 09:49:28	2021-06-12 09:49:28
1797	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-12 09:49:28	2021-06-12 09:49:28
1803	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-12 09:52:01	2021-06-12 09:52:01
1804	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-12 09:52:01	2021-06-12 09:52:01
1805	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-12 09:52:01	2021-06-12 09:52:01
1786	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-12 09:49:16	2021-06-12 09:49:16
1790	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	t	54	57	2021-06-12 09:49:20	2021-06-12 09:49:20
1794	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-12 09:49:28	2021-06-12 09:49:28
1802	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-12 09:52:01	2021-06-12 09:52:01
1734	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 09:14:11	2021-06-12 09:14:11
1735	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 09:14:11	2021-06-12 09:14:11
1736	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 09:14:11	2021-06-12 09:14:11
1759	La requ??te Fond d'??cran a ??t?? vue	f	57	33	2021-06-12 09:42:02	2021-06-12 09:42:02
1762	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:45:25	2021-06-12 09:45:25
1776	La requ??te Fichiers a ??t?? vue	f	57	33	2021-06-12 09:47:44	2021-06-12 09:47:44
1780	La requ??te Fond d'??cran n'est pas en cours	f	57	33	2021-06-12 09:48:05	2021-06-12 09:48:05
1785	La requ??te Fond d'??cran a ??t?? non vue	f	57	33	2021-06-12 09:48:22	2021-06-12 09:48:22
1807	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	53	2021-06-12 09:52:04	2021-06-12 09:52:04
1808	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	41	2021-06-12 09:52:04	2021-06-12 09:52:04
1809	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	52	2021-06-12 09:52:04	2021-06-12 09:52:04
1815	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	53	2021-06-12 09:54:42	2021-06-12 09:54:42
1816	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	41	2021-06-12 09:54:42	2021-06-12 09:54:42
1817	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	52	2021-06-12 09:54:42	2021-06-12 09:54:42
1819	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-12 09:55:14	2021-06-12 09:55:14
1820	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-12 09:55:14	2021-06-12 09:55:14
1821	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-12 09:55:14	2021-06-12 09:55:14
1823	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	53	2021-06-12 09:57:31	2021-06-12 09:57:31
1824	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	41	2021-06-12 09:57:31	2021-06-12 09:57:31
1825	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	f	54	52	2021-06-12 09:57:31	2021-06-12 09:57:31
1827	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	41	2021-06-12 09:58:59	2021-06-12 09:58:59
1828	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	52	2021-06-12 09:58:59	2021-06-12 09:58:59
1830	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Attributeur	f	53	41	2021-06-12 09:59:02	2021-06-12 09:59:02
1831	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Attributeur	f	53	52	2021-06-12 09:59:02	2021-06-12 09:59:02
1833	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	41	2021-06-12 09:59:06	2021-06-12 09:59:06
1834	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	52	2021-06-12 09:59:06	2021-06-12 09:59:06
1836	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	41	2021-06-12 09:59:10	2021-06-12 09:59:10
1837	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	52	2021-06-12 09:59:10	2021-06-12 09:59:10
1839	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	41	2021-06-12 09:59:14	2021-06-12 09:59:14
1840	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	52	2021-06-12 09:59:14	2021-06-12 09:59:14
1842	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Attributeur	f	53	41	2021-06-12 09:59:18	2021-06-12 09:59:18
1843	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Attributeur	f	53	52	2021-06-12 09:59:18	2021-06-12 09:59:18
1845	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	41	2021-06-12 09:59:39	2021-06-12 09:59:39
1846	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	52	2021-06-12 09:59:39	2021-06-12 09:59:39
1848	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	41	2021-06-12 09:59:46	2021-06-12 09:59:46
1849	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	52	2021-06-12 09:59:46	2021-06-12 09:59:46
1806	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	t	54	57	2021-06-12 09:52:04	2021-06-12 09:52:04
1851	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	41	2021-06-12 09:59:49	2021-06-12 09:59:49
1852	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	52	2021-06-12 09:59:49	2021-06-12 09:59:49
1860	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	41	2021-06-12 10:00:06	2021-06-12 10:00:06
1861	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	52	2021-06-12 10:00:06	2021-06-12 10:00:06
1859	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	t	53	57	2021-06-12 10:00:06	2021-06-12 10:00:06
1854	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	41	2021-06-12 09:59:54	2021-06-12 09:59:54
1855	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	f	53	52	2021-06-12 09:59:54	2021-06-12 09:59:54
1853	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	t	53	57	2021-06-12 09:59:54	2021-06-12 09:59:54
1857	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	41	2021-06-12 10:00:01	2021-06-12 10:00:01
1858	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	f	53	52	2021-06-12 10:00:01	2021-06-12 10:00:01
1862	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 19:49:41	2021-06-12 19:49:41
1863	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 19:49:41	2021-06-12 19:49:41
1864	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 19:49:41	2021-06-12 19:49:41
1865	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:49:44	2021-06-12 19:49:44
1866	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:49:44	2021-06-12 19:49:44
1867	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:49:44	2021-06-12 19:49:44
1868	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 19:49:48	2021-06-12 19:49:48
1869	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 19:49:48	2021-06-12 19:49:48
1870	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 19:49:48	2021-06-12 19:49:48
1871	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:49:50	2021-06-12 19:49:50
1872	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:49:50	2021-06-12 19:49:50
1873	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:49:50	2021-06-12 19:49:50
1874	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 19:49:55	2021-06-12 19:49:55
1875	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 19:49:55	2021-06-12 19:49:55
1876	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 19:49:55	2021-06-12 19:49:55
1877	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:50:04	2021-06-12 19:50:04
1878	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:50:04	2021-06-12 19:50:04
1879	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:50:04	2021-06-12 19:50:04
1880	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-12 19:50:46	2021-06-12 19:50:46
1881	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-12 19:50:46	2021-06-12 19:50:46
1882	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-12 19:50:46	2021-06-12 19:50:46
1883	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:52:01	2021-06-12 19:52:01
1884	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:52:01	2021-06-12 19:52:01
1885	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:52:01	2021-06-12 19:52:01
1886	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:54:46	2021-06-12 19:54:46
1887	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:54:46	2021-06-12 19:54:46
1888	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:54:46	2021-06-12 19:54:46
1889	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:55:24	2021-06-12 19:55:24
1890	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:55:24	2021-06-12 19:55:24
1891	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:55:24	2021-06-12 19:55:24
1892	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:55:45	2021-06-12 19:55:45
1893	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:55:45	2021-06-12 19:55:45
1894	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:55:45	2021-06-12 19:55:45
1895	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:56:54	2021-06-12 19:56:54
1896	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:56:54	2021-06-12 19:56:54
1897	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:56:54	2021-06-12 19:56:54
1898	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:58:00	2021-06-12 19:58:00
1899	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:58:00	2021-06-12 19:58:00
1900	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:58:00	2021-06-12 19:58:00
1901	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:58:03	2021-06-12 19:58:03
1902	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:58:03	2021-06-12 19:58:03
1903	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:58:03	2021-06-12 19:58:03
1904	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:58:14	2021-06-12 19:58:14
1905	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:58:14	2021-06-12 19:58:14
1906	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:58:14	2021-06-12 19:58:14
1907	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:58:16	2021-06-12 19:58:16
1908	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:58:16	2021-06-12 19:58:16
1909	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:58:16	2021-06-12 19:58:16
1910	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:58:47	2021-06-12 19:58:47
1911	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:58:47	2021-06-12 19:58:47
1912	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:58:47	2021-06-12 19:58:47
1937	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 20:00:31	2021-06-12 20:00:31
1938	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 20:00:31	2021-06-12 20:00:31
1939	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 20:00:31	2021-06-12 20:00:31
1940	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 20:00:40	2021-06-12 20:00:40
1941	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 20:00:40	2021-06-12 20:00:40
1942	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 20:00:40	2021-06-12 20:00:40
1913	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:58:51	2021-06-12 19:58:51
1914	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:58:51	2021-06-12 19:58:51
1915	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:58:51	2021-06-12 19:58:51
1946	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 20:00:51	2021-06-12 20:00:51
1947	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 20:00:51	2021-06-12 20:00:51
1948	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 20:00:51	2021-06-12 20:00:51
1916	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:58:55	2021-06-12 19:58:55
1917	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:58:55	2021-06-12 19:58:55
1918	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:58:55	2021-06-12 19:58:55
1919	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:58:59	2021-06-12 19:58:59
1920	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:58:59	2021-06-12 19:58:59
1921	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:58:59	2021-06-12 19:58:59
1925	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:59:23	2021-06-12 19:59:23
1926	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:59:23	2021-06-12 19:59:23
1927	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:59:23	2021-06-12 19:59:23
1934	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 20:00:14	2021-06-12 20:00:14
1935	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 20:00:14	2021-06-12 20:00:14
1936	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 20:00:14	2021-06-12 20:00:14
1922	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:59:02	2021-06-12 19:59:02
1923	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:59:02	2021-06-12 19:59:02
1924	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:59:02	2021-06-12 19:59:02
1931	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 19:59:37	2021-06-12 19:59:37
1932	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 19:59:37	2021-06-12 19:59:37
1933	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 19:59:37	2021-06-12 19:59:37
1943	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 20:00:48	2021-06-12 20:00:48
1944	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 20:00:48	2021-06-12 20:00:48
1945	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 20:00:48	2021-06-12 20:00:48
1955	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 20:02:45	2021-06-12 20:02:45
1956	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 20:02:45	2021-06-12 20:02:45
1957	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 20:02:45	2021-06-12 20:02:45
1928	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 19:59:33	2021-06-12 19:59:33
1929	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 19:59:33	2021-06-12 19:59:33
1930	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 19:59:33	2021-06-12 19:59:33
1949	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-12 20:01:28	2021-06-12 20:01:28
1950	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-12 20:01:28	2021-06-12 20:01:28
1951	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-12 20:01:28	2021-06-12 20:01:28
1958	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 20:03:38	2021-06-12 20:03:38
1959	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 20:03:38	2021-06-12 20:03:38
1960	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 20:03:38	2021-06-12 20:03:38
1952	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-12 20:02:13	2021-06-12 20:02:13
1953	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-12 20:02:13	2021-06-12 20:02:13
1954	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-12 20:02:13	2021-06-12 20:02:13
1961	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:54:55	2021-06-13 09:54:55
1962	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:54:55	2021-06-13 09:54:55
1963	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:54:55	2021-06-13 09:54:55
1964	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:54:59	2021-06-13 09:54:59
1965	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:54:59	2021-06-13 09:54:59
1966	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:54:59	2021-06-13 09:54:59
1967	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 09:55:07	2021-06-13 09:55:07
1968	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 09:55:07	2021-06-13 09:55:07
1969	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 09:55:07	2021-06-13 09:55:07
1970	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-13 09:55:11	2021-06-13 09:55:11
1971	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-13 09:55:11	2021-06-13 09:55:11
1972	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-13 09:55:11	2021-06-13 09:55:11
1973	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:55:14	2021-06-13 09:55:14
1974	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:55:14	2021-06-13 09:55:14
1975	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:55:14	2021-06-13 09:55:14
1976	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 09:55:15	2021-06-13 09:55:15
1977	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 09:55:15	2021-06-13 09:55:15
1978	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 09:55:15	2021-06-13 09:55:15
1979	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:55:18	2021-06-13 09:55:18
1980	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:55:18	2021-06-13 09:55:18
1981	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:55:18	2021-06-13 09:55:18
1982	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:55:21	2021-06-13 09:55:21
1983	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:55:21	2021-06-13 09:55:21
1984	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:55:21	2021-06-13 09:55:21
1985	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 09:55:23	2021-06-13 09:55:23
1986	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 09:55:23	2021-06-13 09:55:23
1987	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 09:55:23	2021-06-13 09:55:23
1988	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 09:55:26	2021-06-13 09:55:26
1989	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 09:55:26	2021-06-13 09:55:26
1990	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 09:55:26	2021-06-13 09:55:26
1991	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 09:55:29	2021-06-13 09:55:29
1992	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 09:55:29	2021-06-13 09:55:29
1993	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 09:55:29	2021-06-13 09:55:29
1994	T??che "new_one"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 17:55:57	2021-06-13 17:55:57
1995	T??che "new_one"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 17:55:57	2021-06-13 17:55:57
1996	T??che "new_one"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 17:55:57	2021-06-13 17:55:57
1997	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-13 17:55:58	2021-06-13 17:55:58
1998	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-13 17:55:58	2021-06-13 17:55:58
1999	T??che "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-13 17:55:58	2021-06-13 17:55:58
2000	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 17:58:24	2021-06-13 17:58:24
2001	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 17:58:24	2021-06-13 17:58:24
2002	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 17:58:24	2021-06-13 17:58:24
2003	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 17:59:31	2021-06-13 17:59:31
2004	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 17:59:31	2021-06-13 17:59:31
2005	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 17:59:31	2021-06-13 17:59:31
2006	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 17:59:34	2021-06-13 17:59:34
2007	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 17:59:34	2021-06-13 17:59:34
2008	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 17:59:34	2021-06-13 17:59:34
2015	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 18:07:27	2021-06-13 18:07:27
2016	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 18:07:27	2021-06-13 18:07:27
2017	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 18:07:27	2021-06-13 18:07:27
2009	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 18:06:44	2021-06-13 18:06:44
2010	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 18:06:44	2021-06-13 18:06:44
2011	T??che "first_task"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 18:06:44	2021-06-13 18:06:44
2030	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 18:15:10	2021-06-13 18:15:10
2031	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 18:15:10	2021-06-13 18:15:10
2032	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 18:15:10	2021-06-13 18:15:10
2012	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 18:06:52	2021-06-13 18:06:52
2013	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 18:06:52	2021-06-13 18:06:52
2014	T??che "half_append"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 18:06:52	2021-06-13 18:06:52
2039	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:38:26	2021-06-13 19:38:26
2040	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:38:26	2021-06-13 19:38:26
2041	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:38:26	2021-06-13 19:38:26
2018	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 18:08:14	2021-06-13 18:08:14
2019	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 18:08:14	2021-06-13 18:08:14
2020	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 18:08:14	2021-06-13 18:08:14
2021	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 18:10:56	2021-06-13 18:10:56
2022	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 18:10:56	2021-06-13 18:10:56
2023	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 18:10:56	2021-06-13 18:10:56
2024	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 18:11:13	2021-06-13 18:11:13
2025	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 18:11:13	2021-06-13 18:11:13
2026	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 18:11:13	2021-06-13 18:11:13
2042	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:38:27	2021-06-13 19:38:27
2043	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:38:27	2021-06-13 19:38:27
2044	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:38:27	2021-06-13 19:38:27
2027	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 18:15:07	2021-06-13 18:15:07
2028	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 18:15:07	2021-06-13 18:15:07
2029	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 18:15:07	2021-06-13 18:15:07
2033	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:33:56	2021-06-13 19:33:56
2034	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:33:56	2021-06-13 19:33:56
2035	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:33:56	2021-06-13 19:33:56
2036	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:34:01	2021-06-13 19:34:01
2037	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:34:01	2021-06-13 19:34:01
2038	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:34:01	2021-06-13 19:34:01
2045	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:46:42	2021-06-13 19:46:42
2046	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:46:42	2021-06-13 19:46:42
2047	T??che "notifs_length"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:46:42	2021-06-13 19:46:42
2048	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:47:00	2021-06-13 19:47:00
2049	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:47:00	2021-06-13 19:47:00
2050	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:47:00	2021-06-13 19:47:00
2051	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:47:32	2021-06-13 19:47:32
2052	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:47:32	2021-06-13 19:47:32
2053	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:47:32	2021-06-13 19:47:32
2054	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:47:41	2021-06-13 19:47:41
2055	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:47:41	2021-06-13 19:47:41
2056	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:47:41	2021-06-13 19:47:41
2057	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:47:41	2021-06-13 19:47:41
2058	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:47:41	2021-06-13 19:47:41
2059	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:47:41	2021-06-13 19:47:41
2060	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:47:50	2021-06-13 19:47:50
2061	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:47:50	2021-06-13 19:47:50
2062	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:47:50	2021-06-13 19:47:50
2063	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:31	2021-06-13 19:48:31
2064	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:31	2021-06-13 19:48:31
2065	T??che "sans dt de fin"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:31	2021-06-13 19:48:31
2066	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:48:35	2021-06-13 19:48:35
2067	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:48:35	2021-06-13 19:48:35
2068	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:48:35	2021-06-13 19:48:35
2069	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:35	2021-06-13 19:48:35
2070	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:35	2021-06-13 19:48:35
2071	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:35	2021-06-13 19:48:35
2072	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:48:38	2021-06-13 19:48:38
2073	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:48:38	2021-06-13 19:48:38
2074	La t??che first_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:48:38	2021-06-13 19:48:38
2075	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:38	2021-06-13 19:48:38
2076	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:38	2021-06-13 19:48:38
2077	T??che "first_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:38	2021-06-13 19:48:38
2078	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:40	2021-06-13 19:48:40
2079	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:40	2021-06-13 19:48:40
2080	T??che "t??che test"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:40	2021-06-13 19:48:40
2081	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:42	2021-06-13 19:48:42
2082	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:42	2021-06-13 19:48:42
2083	T??che "dodosy"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:42	2021-06-13 19:48:42
2084	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:43	2021-06-13 19:48:43
2085	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:43	2021-06-13 19:48:43
2086	T??che "tacheee"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:43	2021-06-13 19:48:43
2087	La t??che second_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:48:44	2021-06-13 19:48:44
2088	La t??che second_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:48:44	2021-06-13 19:48:44
2089	La t??che second_task a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:48:44	2021-06-13 19:48:44
2090	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:44	2021-06-13 19:48:44
2091	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:44	2021-06-13 19:48:44
2092	T??che "second_task"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:44	2021-06-13 19:48:44
2093	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:45	2021-06-13 19:48:45
2094	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:45	2021-06-13 19:48:45
2095	T??che "work"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:45	2021-06-13 19:48:45
2120	T??che "89"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:49:15	2021-06-13 19:49:15
2121	T??che "89"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:49:15	2021-06-13 19:49:15
2122	T??che "89"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:49:15	2021-06-13 19:49:15
2135	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:25	2021-06-13 19:49:25
2136	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:25	2021-06-13 19:49:25
2137	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:25	2021-06-13 19:49:25
2141	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:29	2021-06-13 19:49:29
2142	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:29	2021-06-13 19:49:29
2143	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:29	2021-06-13 19:49:29
2147	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:49:32	2021-06-13 19:49:32
2148	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:49:32	2021-06-13 19:49:32
2149	T??che "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:49:32	2021-06-13 19:49:32
2168	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:49:45	2021-06-13 19:49:45
2169	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:49:45	2021-06-13 19:49:45
2170	T??che "sans dt de fin"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:49:45	2021-06-13 19:49:45
2228	T??che "work"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:54:43	2021-06-13 19:54:43
2229	T??che "work"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:54:43	2021-06-13 19:54:43
2230	T??che "work"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:54:43	2021-06-13 19:54:43
2267	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-13 20:00:25	2021-06-13 20:00:25
2268	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-13 20:00:25	2021-06-13 20:00:25
2269	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-13 20:00:25	2021-06-13 20:00:25
2282	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:48	2021-06-13 20:00:48
2283	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:48	2021-06-13 20:00:48
2284	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:48	2021-06-13 20:00:48
2096	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:47	2021-06-13 19:48:47
2097	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:47	2021-06-13 19:48:47
2098	T??che "task_children"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:47	2021-06-13 19:48:47
2132	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:49:24	2021-06-13 19:49:24
2133	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:49:24	2021-06-13 19:49:24
2134	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:49:24	2021-06-13 19:49:24
2201	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:53:58	2021-06-13 19:53:58
2202	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:53:58	2021-06-13 19:53:58
2203	T??che "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:53:58	2021-06-13 19:53:58
2213	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:54:16	2021-06-13 19:54:16
2214	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:54:16	2021-06-13 19:54:16
2215	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:54:16	2021-06-13 19:54:16
2246	T??che "ectoassoc"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:55:15	2021-06-13 19:55:15
2247	T??che "ectoassoc"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:55:15	2021-06-13 19:55:15
2248	T??che "ectoassoc"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:55:15	2021-06-13 19:55:15
2249	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:06	2021-06-13 20:00:06
2250	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:06	2021-06-13 20:00:06
2251	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:06	2021-06-13 20:00:06
2273	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:29	2021-06-13 20:00:29
2274	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:29	2021-06-13 20:00:29
2275	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:29	2021-06-13 20:00:29
2285	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:52	2021-06-13 20:00:52
2286	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:52	2021-06-13 20:00:52
2287	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:52	2021-06-13 20:00:52
2099	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:48:48	2021-06-13 19:48:48
2100	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:48:48	2021-06-13 19:48:48
2101	T??che "primaire"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:48:48	2021-06-13 19:48:48
2102	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:01	2021-06-13 19:49:01
2103	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:01	2021-06-13 19:49:01
2104	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:01	2021-06-13 19:49:01
2156	T??che "t??che test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:35	2021-06-13 19:49:35
2157	T??che "t??che test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:35	2021-06-13 19:49:35
2158	T??che "t??che test"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:35	2021-06-13 19:49:35
2159	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:36	2021-06-13 19:49:36
2160	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:36	2021-06-13 19:49:36
2161	T??che "first_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:36	2021-06-13 19:49:36
2186	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:52:14	2021-06-13 19:52:14
2187	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:52:14	2021-06-13 19:52:14
2188	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:52:14	2021-06-13 19:52:14
2222	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:54:32	2021-06-13 19:54:32
2223	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:54:32	2021-06-13 19:54:32
2224	T??che "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:54:32	2021-06-13 19:54:32
2270	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:27	2021-06-13 20:00:27
2271	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:27	2021-06-13 20:00:27
2272	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:27	2021-06-13 20:00:27
2105	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:02	2021-06-13 19:49:02
2106	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:02	2021-06-13 19:49:02
2107	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:02	2021-06-13 19:49:02
2114	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:49:12	2021-06-13 19:49:12
2115	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:49:12	2021-06-13 19:49:12
2116	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:49:12	2021-06-13 19:49:12
2144	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:30	2021-06-13 19:49:30
2145	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:30	2021-06-13 19:49:30
2146	T??che "work"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:30	2021-06-13 19:49:30
2150	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:33	2021-06-13 19:49:33
2151	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:33	2021-06-13 19:49:33
2152	T??che "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:33	2021-06-13 19:49:33
2171	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:50:12	2021-06-13 19:50:12
2172	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:50:12	2021-06-13 19:50:12
2173	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:50:12	2021-06-13 19:50:12
2174	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:50:12	2021-06-13 19:50:12
2175	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:50:12	2021-06-13 19:50:12
2176	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:50:12	2021-06-13 19:50:12
2195	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:52:26	2021-06-13 19:52:26
2196	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:52:26	2021-06-13 19:52:26
2197	T??che "notifs_length"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:52:26	2021-06-13 19:52:26
2198	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:53:57	2021-06-13 19:53:57
2199	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:53:57	2021-06-13 19:53:57
2200	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:53:57	2021-06-13 19:53:57
2240	La t??che ectoassoc a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	53	2021-06-13 19:55:10	2021-06-13 19:55:10
2241	La t??che ectoassoc a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	41	2021-06-13 19:55:10	2021-06-13 19:55:10
2242	La t??che ectoassoc a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	52	2021-06-13 19:55:10	2021-06-13 19:55:10
2264	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:22	2021-06-13 20:00:22
2265	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:22	2021-06-13 20:00:22
2266	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:22	2021-06-13 20:00:22
2108	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:03	2021-06-13 19:49:03
2109	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:03	2021-06-13 19:49:03
2110	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:03	2021-06-13 19:49:03
2153	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:33	2021-06-13 19:49:33
2154	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:33	2021-06-13 19:49:33
2155	T??che "dodosy"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:33	2021-06-13 19:49:33
2225	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:54:34	2021-06-13 19:54:34
2226	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:54:34	2021-06-13 19:54:34
2227	T??che "append%2==1"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:54:34	2021-06-13 19:54:34
2252	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:11	2021-06-13 20:00:11
2253	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:11	2021-06-13 20:00:11
2254	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:11	2021-06-13 20:00:11
2111	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:04	2021-06-13 19:49:04
2112	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:04	2021-06-13 19:49:04
2113	T??che "tache notif"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:04	2021-06-13 19:49:04
2117	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:49:14	2021-06-13 19:49:14
2118	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:49:14	2021-06-13 19:49:14
2119	T??che "tache notif"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:49:14	2021-06-13 19:49:14
2138	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:26	2021-06-13 19:49:26
2139	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:26	2021-06-13 19:49:26
2140	T??che "primaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:26	2021-06-13 19:49:26
2189	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:52:23	2021-06-13 19:52:23
2190	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:52:23	2021-06-13 19:52:23
2191	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:52:23	2021-06-13 19:52:23
2192	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:52:23	2021-06-13 19:52:23
2193	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:52:23	2021-06-13 19:52:23
2194	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:52:23	2021-06-13 19:52:23
2207	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:54:06	2021-06-13 19:54:06
2208	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:54:06	2021-06-13 19:54:06
2209	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:54:06	2021-06-13 19:54:06
2234	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:54:52	2021-06-13 19:54:52
2235	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:54:52	2021-06-13 19:54:52
2236	T??che "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:54:52	2021-06-13 19:54:52
2255	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:14	2021-06-13 20:00:14
2256	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:14	2021-06-13 20:00:14
2257	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:14	2021-06-13 20:00:14
2258	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:17	2021-06-13 20:00:17
2259	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:17	2021-06-13 20:00:17
2260	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:17	2021-06-13 20:00:17
2279	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:32	2021-06-13 20:00:32
2280	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:32	2021-06-13 20:00:32
2281	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:32	2021-06-13 20:00:32
2288	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 20:00:56	2021-06-13 20:00:56
2289	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 20:00:56	2021-06-13 20:00:56
2290	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 20:00:56	2021-06-13 20:00:56
2123	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:49:16	2021-06-13 19:49:16
2124	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:49:16	2021-06-13 19:49:16
2125	T??che "doudousy2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:49:16	2021-06-13 19:49:16
2165	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:38	2021-06-13 19:49:38
2166	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:38	2021-06-13 19:49:38
2167	T??che "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:38	2021-06-13 19:49:38
2237	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:54:59	2021-06-13 19:54:59
2238	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:54:59	2021-06-13 19:54:59
2239	T??che "half_append"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:54:59	2021-06-13 19:54:59
2276	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:31	2021-06-13 20:00:31
2277	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:31	2021-06-13 20:00:31
2278	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:31	2021-06-13 20:00:31
2291	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:59	2021-06-13 20:00:59
2292	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:59	2021-06-13 20:00:59
2293	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:59	2021-06-13 20:00:59
2126	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:49:21	2021-06-13 19:49:21
2127	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:49:21	2021-06-13 19:49:21
2128	T??che "doudousy2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:49:21	2021-06-13 19:49:21
2177	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:50:19	2021-06-13 19:50:19
2178	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:50:19	2021-06-13 19:50:19
2179	T??che "cerise3"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:50:19	2021-06-13 19:50:19
2204	T??che "ectoassoc"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:54:04	2021-06-13 19:54:04
2205	T??che "ectoassoc"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:54:04	2021-06-13 19:54:04
2206	T??che "ectoassoc"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:54:04	2021-06-13 19:54:04
2216	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 19:54:21	2021-06-13 19:54:21
2217	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 19:54:21	2021-06-13 19:54:21
2218	T??che "notification_secondaire"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 19:54:21	2021-06-13 19:54:21
2219	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:54:30	2021-06-13 19:54:30
2220	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:54:30	2021-06-13 19:54:30
2221	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:54:30	2021-06-13 19:54:30
2129	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:49:22	2021-06-13 19:49:22
2130	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:49:22	2021-06-13 19:49:22
2131	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:49:22	2021-06-13 19:49:22
2162	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-13 19:49:37	2021-06-13 19:49:37
2163	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-13 19:49:37	2021-06-13 19:49:37
2164	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-13 19:49:37	2021-06-13 19:49:37
2180	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-06-13 19:52:06	2021-06-13 19:52:06
2181	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-06-13 19:52:06	2021-06-13 19:52:06
2182	La t??che cerise sur le g??teau a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-06-13 19:52:06	2021-06-13 19:52:06
2183	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:52:06	2021-06-13 19:52:06
2184	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:52:06	2021-06-13 19:52:06
2185	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:52:06	2021-06-13 19:52:06
2231	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-13 19:54:44	2021-06-13 19:54:44
2232	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-13 19:54:44	2021-06-13 19:54:44
2233	T??che "t??che secondaire pour first task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-13 19:54:44	2021-06-13 19:54:44
2243	T??che "assoc2nde"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-13 19:55:10	2021-06-13 19:55:10
2244	T??che "assoc2nde"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-13 19:55:10	2021-06-13 19:55:10
2245	T??che "assoc2nde"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-13 19:55:10	2021-06-13 19:55:10
2210	T??che "cerise2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-13 19:54:14	2021-06-13 19:54:14
2211	T??che "cerise2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-13 19:54:14	2021-06-13 19:54:14
2212	T??che "cerise2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-13 19:54:14	2021-06-13 19:54:14
2261	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-13 20:00:20	2021-06-13 20:00:20
2262	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-13 20:00:20	2021-06-13 20:00:20
2263	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-13 20:00:20	2021-06-13 20:00:20
2294	T??che nouvellement cr??ee du nom de test date par Mgbi dans le projet Premier test.	f	57	53	2021-06-14 12:45:38	2021-06-14 12:45:38
2295	T??che nouvellement cr??ee du nom de test date par Mgbi dans le projet Premier test.	f	57	41	2021-06-14 12:45:38	2021-06-14 12:45:38
2296	T??che nouvellement cr??ee du nom de test date par Mgbi dans le projet Premier test.	f	57	52	2021-06-14 12:45:38	2021-06-14 12:45:38
2297	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-14 12:45:50	2021-06-14 12:45:50
2298	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-14 12:45:50	2021-06-14 12:45:50
2299	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-14 12:45:50	2021-06-14 12:45:50
2300	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-14 12:45:52	2021-06-14 12:45:52
2301	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-14 12:45:52	2021-06-14 12:45:52
2302	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-14 12:45:52	2021-06-14 12:45:52
2303	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-14 13:55:15	2021-06-14 13:55:15
2304	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-14 13:55:15	2021-06-14 13:55:15
2305	T??che "une nouvelle"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-14 13:55:15	2021-06-14 13:55:15
2306	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-14 13:55:19	2021-06-14 13:55:19
2307	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-14 13:55:19	2021-06-14 13:55:19
2308	T??che "une nouvelle"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-14 13:55:19	2021-06-14 13:55:19
2309	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	53	2021-06-14 19:37:38	2021-06-14 19:37:38
2310	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	41	2021-06-14 19:37:38	2021-06-14 19:37:38
2311	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En cours " par Mgbi	f	57	52	2021-06-14 19:37:38	2021-06-14 19:37:38
2312	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-14 19:37:42	2021-06-14 19:37:42
2313	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-14 19:37:42	2021-06-14 19:37:42
2314	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-14 19:37:42	2021-06-14 19:37:42
2315	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-14 19:37:44	2021-06-14 19:37:44
2316	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-14 19:37:44	2021-06-14 19:37:44
2317	T??che "tache "\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-14 19:37:44	2021-06-14 19:37:44
2318	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-14 19:37:46	2021-06-14 19:37:46
2319	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-14 19:37:46	2021-06-14 19:37:46
2320	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-14 19:37:46	2021-06-14 19:37:46
2321	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-14 19:37:48	2021-06-14 19:37:48
2322	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-14 19:37:48	2021-06-14 19:37:48
2323	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-14 19:37:48	2021-06-14 19:37:48
2324	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-14 19:37:51	2021-06-14 19:37:51
2325	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-14 19:37:51	2021-06-14 19:37:51
2326	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-14 19:37:51	2021-06-14 19:37:51
2327	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-14 19:38:14	2021-06-14 19:38:14
2328	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-14 19:38:14	2021-06-14 19:38:14
2329	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-14 19:38:14	2021-06-14 19:38:14
2330	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-06-14 19:38:19	2021-06-14 19:38:19
2331	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-06-14 19:38:19	2021-06-14 19:38:19
2332	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-06-14 19:38:19	2021-06-14 19:38:19
2333	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-14 19:40:09	2021-06-14 19:40:09
2334	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-14 19:40:09	2021-06-14 19:40:09
2335	T??che "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-14 19:40:09	2021-06-14 19:40:09
2336	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-14 19:40:10	2021-06-14 19:40:10
2337	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-14 19:40:10	2021-06-14 19:40:10
2338	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-14 19:40:10	2021-06-14 19:40:10
2339	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-14 19:40:13	2021-06-14 19:40:13
2340	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-14 19:40:13	2021-06-14 19:40:13
2341	T??che "first_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-14 19:40:13	2021-06-14 19:40:13
2342	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-14 19:40:14	2021-06-14 19:40:14
2343	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-14 19:40:14	2021-06-14 19:40:14
2344	T??che "first_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-14 19:40:14	2021-06-14 19:40:14
2345	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-15 14:45:49	2021-06-15 14:45:49
2346	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-15 14:45:49	2021-06-15 14:45:49
2347	T??che "pubsub"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-15 14:45:49	2021-06-15 14:45:49
2348	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-15 14:54:07	2021-06-15 14:54:07
2349	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-15 14:54:07	2021-06-15 14:54:07
2350	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-15 14:54:07	2021-06-15 14:54:07
2351	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-15 15:03:24	2021-06-15 15:03:24
2352	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-15 15:03:24	2021-06-15 15:03:24
2353	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-15 15:03:24	2021-06-15 15:03:24
2354	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-16 11:59:09	2021-06-16 11:59:09
2355	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-16 11:59:09	2021-06-16 11:59:09
2356	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-16 11:59:09	2021-06-16 11:59:09
2357	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-16 12:00:05	2021-06-16 12:00:05
2358	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-16 12:00:05	2021-06-16 12:00:05
2359	T??che "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-16 12:00:05	2021-06-16 12:00:05
2360	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test".	f	33	41	2021-06-16 13:27:58	2021-06-16 13:27:58
2361	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test".	f	33	52	2021-06-16 13:27:58	2021-06-16 13:27:58
2363	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	53	2021-06-16 15:36:13	2021-06-16 15:36:13
2364	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	52	2021-06-16 15:36:13	2021-06-16 15:36:13
2366	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	53	2021-06-16 15:36:15	2021-06-16 15:36:15
2367	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	52	2021-06-16 15:36:15	2021-06-16 15:36:15
2369	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	53	2021-06-16 15:36:30	2021-06-16 15:36:30
2370	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Test	f	41	52	2021-06-16 15:36:30	2021-06-16 15:36:30
2362	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test".	t	33	57	2021-06-16 13:27:58	2021-06-16 13:27:58
2365	T??che "new_one"\n          du projet Premier test mise dans " Achev??e(s) " par Test	t	41	57	2021-06-16 15:36:13	2021-06-16 15:36:13
2368	T??che "Vraie t??che"\n          du projet Premier test mise dans " Achev??e(s) " par Test	t	41	57	2021-06-16 15:36:15	2021-06-16 15:36:15
2371	T??che "date_insert2"\n          du projet Premier test mise dans " Achev??e(s) " par Test	t	41	57	2021-06-16 15:36:30	2021-06-16 15:36:30
1850	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	t	53	57	2021-06-12 09:59:49	2021-06-12 09:59:49
1856	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	t	53	57	2021-06-12 10:00:01	2021-06-12 10:00:01
1234	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En cours " par Mgbi1	t	54	57	2021-06-09 13:31:29	2021-06-09 13:31:29
1259	T??che "tache notif"\n          du projet mon_projet mise dans " En attente " par Test	t	41	57	2021-06-09 13:36:53	2021-06-09 13:36:53
1262	T??che "t??che test"\n          du projet mon_projet mise dans " En cours " par Test	t	41	57	2021-06-09 13:36:56	2021-06-09 13:36:56
1340	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " Achev??e(s) " par Admin	t	52	57	2021-06-10 07:30:25	2021-06-10 07:30:25
1343	T??che "notif2"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	57	2021-06-10 07:30:32	2021-06-10 07:30:32
1346	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	57	2021-06-10 07:30:33	2021-06-10 07:30:33
1349	T??che "notifs_length"\n          du projet mon_projet mise dans " En contr??le " par Admin	t	52	57	2021-06-10 07:30:34	2021-06-10 07:30:34
1352	T??che "cerise3"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	57	2021-06-10 07:30:35	2021-06-10 07:30:35
1355	T??che "cerise sur le g??teau"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-06-10 07:30:37	2021-06-10 07:30:37
1358	T??che "cinqui??me t??che secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-06-10 07:31:48	2021-06-10 07:31:48
1814	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	t	54	57	2021-06-12 09:54:42	2021-06-12 09:54:42
1818	T??che "Vraie t??che"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-12 09:55:14	2021-06-12 09:55:14
1822	T??che "Vraie t??che"\n          du projet Premier test mise dans " En cours " par Mgbi1	t	54	57	2021-06-12 09:57:31	2021-06-12 09:57:31
1826	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	t	53	57	2021-06-12 09:58:59	2021-06-12 09:58:59
2376	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	53	2021-06-16 20:59:08	2021-06-16 20:59:08
2377	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	41	2021-06-16 20:59:08	2021-06-16 20:59:08
2378	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	52	2021-06-16 20:59:08	2021-06-16 20:59:08
1829	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En attente " par Attributeur	t	53	57	2021-06-12 09:59:02	2021-06-12 09:59:02
1832	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	t	53	57	2021-06-12 09:59:06	2021-06-12 09:59:06
1835	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	t	53	57	2021-06-12 09:59:10	2021-06-12 09:59:10
1838	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	t	53	57	2021-06-12 09:59:14	2021-06-12 09:59:14
1841	T??che "Cr??ation interface Accueil"\n          du projet QLM Site E-commerce mise dans " Achev??e(s) " par Attributeur	t	53	57	2021-06-12 09:59:18	2021-06-12 09:59:18
1844	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En cours " par Attributeur	t	53	57	2021-06-12 09:59:39	2021-06-12 09:59:39
1847	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Attributeur	t	53	57	2021-06-12 09:59:46	2021-06-12 09:59:46
2372	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-16 20:59:07	2021-06-16 20:59:07
2373	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-16 20:59:07	2021-06-16 20:59:07
2374	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-16 20:59:07	2021-06-16 20:59:07
2380	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-16 20:59:09	2021-06-16 20:59:09
2381	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-16 20:59:09	2021-06-16 20:59:09
2382	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-16 20:59:09	2021-06-16 20:59:09
2384	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	53	2021-06-16 20:59:09	2021-06-16 20:59:09
2385	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	41	2021-06-16 20:59:09	2021-06-16 20:59:09
2386	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	f	54	52	2021-06-16 20:59:09	2021-06-16 20:59:09
2388	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	53	2021-06-16 20:59:10	2021-06-16 20:59:10
2389	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	41	2021-06-16 20:59:10	2021-06-16 20:59:10
2390	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	f	54	52	2021-06-16 20:59:10	2021-06-16 20:59:10
2379	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	t	54	57	2021-06-16 20:59:08	2021-06-16 20:59:08
2383	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-16 20:59:09	2021-06-16 20:59:09
2387	T??che "date_insert"\n          du projet Premier test mise dans " A faire " par Mgbi1	t	54	57	2021-06-16 20:59:09	2021-06-16 20:59:09
2391	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-16 20:59:10	2021-06-16 20:59:10
2375	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi1	t	54	57	2021-06-16 20:59:07	2021-06-16 20:59:07
2392	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-17 17:51:28	2021-06-17 17:51:28
2393	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-17 17:51:28	2021-06-17 17:51:28
2394	T??che "89"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-17 17:51:28	2021-06-17 17:51:28
2395	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-17 17:51:31	2021-06-17 17:51:31
2396	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-17 17:51:31	2021-06-17 17:51:31
2397	T??che "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-17 17:51:31	2021-06-17 17:51:31
2398	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-17 17:53:21	2021-06-17 17:53:21
2399	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-17 17:53:21	2021-06-17 17:53:21
2400	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-17 17:53:21	2021-06-17 17:53:21
2401	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-17 17:53:25	2021-06-17 17:53:25
2402	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-17 17:53:25	2021-06-17 17:53:25
2403	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-17 17:53:25	2021-06-17 17:53:25
2404	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-18 06:09:00	2021-06-18 06:09:00
2405	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-18 06:09:00	2021-06-18 06:09:00
2406	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-18 06:09:00	2021-06-18 06:09:00
2407	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-18 06:09:08	2021-06-18 06:09:08
2408	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-18 06:09:08	2021-06-18 06:09:08
2409	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-18 06:09:08	2021-06-18 06:09:08
2410	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-18 06:09:43	2021-06-18 06:09:43
2411	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-18 06:09:43	2021-06-18 06:09:43
2412	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-18 06:09:43	2021-06-18 06:09:43
2413	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-18 15:27:29	2021-06-18 15:27:29
2414	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-18 15:27:29	2021-06-18 15:27:29
2415	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-18 15:27:29	2021-06-18 15:27:29
2416	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-18 15:27:35	2021-06-18 15:27:35
2417	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-18 15:27:35	2021-06-18 15:27:35
2418	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-18 15:27:35	2021-06-18 15:27:35
2419	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-18 15:27:39	2021-06-18 15:27:39
2420	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-18 15:27:39	2021-06-18 15:27:39
2421	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-18 15:27:39	2021-06-18 15:27:39
2422	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-18 17:53:09	2021-06-18 17:53:09
2423	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-18 17:53:09	2021-06-18 17:53:09
2424	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-18 17:53:09	2021-06-18 17:53:09
2425	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-18 17:53:13	2021-06-18 17:53:13
2426	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-18 17:53:13	2021-06-18 17:53:13
2427	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-18 17:53:13	2021-06-18 17:53:13
2428	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-18 17:53:51	2021-06-18 17:53:51
2429	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-18 17:53:51	2021-06-18 17:53:51
2430	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-18 17:53:51	2021-06-18 17:53:51
2431	T??che nouvellement cr??ee du nom de alpine par Mgbi dans le projet Premier test.	f	57	53	2021-06-18 21:07:16	2021-06-18 21:07:16
2432	T??che nouvellement cr??ee du nom de alpine par Mgbi dans le projet Premier test.	f	57	41	2021-06-18 21:07:16	2021-06-18 21:07:16
2433	T??che nouvellement cr??ee du nom de alpine par Mgbi dans le projet Premier test.	f	57	52	2021-06-18 21:07:16	2021-06-18 21:07:16
2434	T??che nouvellement cr??ee du nom de olana be par Test dans le projet Premier test.	f	41	53	2021-06-18 22:11:13	2021-06-18 22:11:13
2435	T??che nouvellement cr??ee du nom de olana be par Test dans le projet Premier test.	f	41	52	2021-06-18 22:11:13	2021-06-18 22:11:13
2437	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Test	f	41	53	2021-06-18 22:11:26	2021-06-18 22:11:26
2438	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Test	f	41	52	2021-06-18 22:11:26	2021-06-18 22:11:26
2440	T??che "alpine"\n          du projet Premier test mise dans " En attente " par Test	f	41	53	2021-06-18 22:11:29	2021-06-18 22:11:29
2441	T??che "alpine"\n          du projet Premier test mise dans " En attente " par Test	f	41	52	2021-06-18 22:11:29	2021-06-18 22:11:29
2443	T??che "alpine"\n          du projet Premier test mise dans " A faire " par Test	f	41	53	2021-06-18 22:11:32	2021-06-18 22:11:32
2444	T??che "alpine"\n          du projet Premier test mise dans " A faire " par Test	f	41	52	2021-06-18 22:11:32	2021-06-18 22:11:32
2447	La requ??te Test a ??t?? non vue	f	57	33	2021-06-19 16:03:14	2021-06-19 16:03:14
2449	La requ??te Test a ??t?? non vue	f	57	33	2021-06-19 16:04:31	2021-06-19 16:04:31
2450	T??che first_task archiv??e par Mgbi.	f	57	53	2021-06-19 20:09:53	2021-06-19 20:09:53
2451	T??che first_task archiv??e par Mgbi.	f	57	41	2021-06-19 20:09:53	2021-06-19 20:09:53
2452	T??che first_task archiv??e par Mgbi.	f	57	52	2021-06-19 20:09:53	2021-06-19 20:09:53
2453	T??che sans dt de fin archiv??e par Mgbi.	f	57	53	2021-06-21 06:25:36	2021-06-21 06:25:36
2454	T??che sans dt de fin archiv??e par Mgbi.	f	57	41	2021-06-21 06:25:36	2021-06-21 06:25:36
2455	T??che sans dt de fin archiv??e par Mgbi.	f	57	52	2021-06-21 06:25:36	2021-06-21 06:25:36
2459	T??che "pubsub"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-21 12:28:13	2021-06-21 12:28:13
2460	T??che "pubsub"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-21 12:28:13	2021-06-21 12:28:13
2461	T??che "pubsub"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-21 12:28:13	2021-06-21 12:28:13
2462	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-21 12:28:21	2021-06-21 12:28:21
2463	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-21 12:28:21	2021-06-21 12:28:21
2464	T??che "pubsub"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-21 12:28:21	2021-06-21 12:28:21
2465	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-21 12:33:14	2021-06-21 12:33:14
2466	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-21 12:33:14	2021-06-21 12:33:14
2467	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-21 12:33:14	2021-06-21 12:33:14
2468	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-21 12:33:20	2021-06-21 12:33:20
2469	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-21 12:33:20	2021-06-21 12:33:20
2470	T??che "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-21 12:33:20	2021-06-21 12:33:20
2471	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-21 12:33:23	2021-06-21 12:33:23
2472	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-21 12:33:23	2021-06-21 12:33:23
2473	T??che "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-21 12:33:23	2021-06-21 12:33:23
2474	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-21 12:33:28	2021-06-21 12:33:28
2475	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-21 12:33:28	2021-06-21 12:33:28
2476	T??che "cerise2"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-21 12:33:28	2021-06-21 12:33:28
2477	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-21 15:08:23	2021-06-21 15:08:23
2478	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-21 15:08:23	2021-06-21 15:08:23
2479	T??che "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-21 15:08:23	2021-06-21 15:08:23
2480	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-21 15:08:26	2021-06-21 15:08:26
2481	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-21 15:08:26	2021-06-21 15:08:26
2482	T??che "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-21 15:08:26	2021-06-21 15:08:26
2483	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-21 18:03:01	2021-06-21 18:03:01
2484	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-21 18:03:01	2021-06-21 18:03:01
2485	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-21 18:03:01	2021-06-21 18:03:01
2486	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-21 18:03:03	2021-06-21 18:03:03
2487	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-21 18:03:03	2021-06-21 18:03:03
2488	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-21 18:03:03	2021-06-21 18:03:03
2489	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-21 18:03:05	2021-06-21 18:03:05
2490	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-21 18:03:05	2021-06-21 18:03:05
2491	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-21 18:03:05	2021-06-21 18:03:05
2492	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-21 18:03:06	2021-06-21 18:03:06
2493	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-21 18:03:06	2021-06-21 18:03:06
2494	T??che "olana be"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-21 18:03:06	2021-06-21 18:03:06
2495	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-21 18:03:07	2021-06-21 18:03:07
2496	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-21 18:03:07	2021-06-21 18:03:07
2497	T??che "test date"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-21 18:03:07	2021-06-21 18:03:07
2498	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-21 18:03:08	2021-06-21 18:03:08
2499	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-21 18:03:08	2021-06-21 18:03:08
2500	T??che "test date"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-21 18:03:08	2021-06-21 18:03:08
2501	T??che "cerise3"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-21 18:03:14	2021-06-21 18:03:14
2502	T??che "cerise3"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-21 18:03:14	2021-06-21 18:03:14
2503	T??che "cerise3"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-21 18:03:14	2021-06-21 18:03:14
2504	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-21 18:03:16	2021-06-21 18:03:16
2505	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-21 18:03:16	2021-06-21 18:03:16
2506	T??che "cerise3"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-21 18:03:16	2021-06-21 18:03:16
2507	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-06-21 18:03:17	2021-06-21 18:03:17
2508	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-06-21 18:03:17	2021-06-21 18:03:17
2509	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-06-21 18:03:17	2021-06-21 18:03:17
2510	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-21 18:03:18	2021-06-21 18:03:18
2511	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-21 18:03:18	2021-06-21 18:03:18
2512	T??che "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-21 18:03:18	2021-06-21 18:03:18
2513	T??che nouvellement cr??ee du nom de t??che urgente par Mgbi dans le projet Premier test.	f	57	53	2021-06-21 21:01:46	2021-06-21 21:01:46
2514	T??che nouvellement cr??ee du nom de t??che urgente par Mgbi dans le projet Premier test.	f	57	41	2021-06-21 21:01:46	2021-06-21 21:01:46
2515	T??che nouvellement cr??ee du nom de t??che urgente par Mgbi dans le projet Premier test.	f	57	52	2021-06-21 21:01:46	2021-06-21 21:01:46
2517	T??che nouvellement cr??ee du nom de R??daction par Mgbi dans le projet Premier test.	f	57	53	2021-06-21 21:03:00	2021-06-21 21:03:00
2518	T??che nouvellement cr??ee du nom de R??daction par Mgbi dans le projet Premier test.	f	57	41	2021-06-21 21:03:00	2021-06-21 21:03:00
2519	T??che nouvellement cr??ee du nom de R??daction par Mgbi dans le projet Premier test.	f	57	52	2021-06-21 21:03:00	2021-06-21 21:03:00
2516	Mgbi vous a assign?? ?? la t??che t??che urgente.	t	57	54	2021-06-21 21:01:55	2021-06-21 21:01:55
2520	Mgbi vous a assign?? ?? la t??che R??daction.	t	57	54	2021-06-21 21:03:09	2021-06-21 21:03:09
2521	T??che nouvellement cr??ee du nom de Handleinfo  par Mgbi dans le projet Premier test.	f	57	53	2021-06-22 07:38:43	2021-06-22 07:38:43
2522	T??che nouvellement cr??ee du nom de Handleinfo  par Mgbi dans le projet Premier test.	f	57	41	2021-06-22 07:38:43	2021-06-22 07:38:43
2523	T??che nouvellement cr??ee du nom de Handleinfo  par Mgbi dans le projet Premier test.	f	57	52	2021-06-22 07:38:43	2021-06-22 07:38:43
2524	Mgbi vous a assign?? ?? la t??che Handleinfo .	f	57	54	2021-06-22 07:39:05	2021-06-22 07:39:05
2525	T??che nouvellement cr??ee du nom de Update task par Mgbi dans le projet Premier test.	f	57	53	2021-06-22 07:44:48	2021-06-22 07:44:48
2526	T??che nouvellement cr??ee du nom de Update task par Mgbi dans le projet Premier test.	f	57	41	2021-06-22 07:44:48	2021-06-22 07:44:48
2527	T??che nouvellement cr??ee du nom de Update task par Mgbi dans le projet Premier test.	f	57	52	2021-06-22 07:44:48	2021-06-22 07:44:48
2528	Mgbi vous a assign?? ?? la t??che Update task.	f	57	54	2021-06-22 07:48:55	2021-06-22 07:48:55
2529	T??che "t??che urgente"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 07:49:41	2021-06-22 07:49:41
2530	T??che "t??che urgente"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 07:49:41	2021-06-22 07:49:41
2531	T??che "t??che urgente"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 07:49:41	2021-06-22 07:49:41
2532	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-22 07:49:42	2021-06-22 07:49:42
2533	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-22 07:49:42	2021-06-22 07:49:42
2534	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-22 07:49:42	2021-06-22 07:49:42
2535	T??che "Update task"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-22 07:49:50	2021-06-22 07:49:50
2536	T??che "Update task"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-22 07:49:50	2021-06-22 07:49:50
2537	T??che "Update task"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-22 07:49:50	2021-06-22 07:49:50
2538	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 07:49:54	2021-06-22 07:49:54
2539	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 07:49:54	2021-06-22 07:49:54
2540	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 07:49:54	2021-06-22 07:49:54
2541	Test vous a assign?? ?? la t??che olana be.	f	41	54	2021-06-22 08:06:43	2021-06-22 08:06:43
2542	T??che "R??daction"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-22 08:08:46	2021-06-22 08:08:46
2543	T??che "R??daction"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-22 08:08:46	2021-06-22 08:08:46
2544	T??che "R??daction"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-22 08:08:46	2021-06-22 08:08:46
2545	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-22 08:08:48	2021-06-22 08:08:48
2546	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-22 08:08:48	2021-06-22 08:08:48
2547	T??che "R??daction"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-22 08:08:48	2021-06-22 08:08:48
2548	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-22 08:10:20	2021-06-22 08:10:20
2549	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-22 08:10:20	2021-06-22 08:10:20
2550	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-22 08:10:20	2021-06-22 08:10:20
2551	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 08:13:16	2021-06-22 08:13:16
2552	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 08:13:16	2021-06-22 08:13:16
2553	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 08:13:16	2021-06-22 08:13:16
2554	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-22 08:13:54	2021-06-22 08:13:54
2555	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-22 08:13:54	2021-06-22 08:13:54
2556	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-22 08:13:54	2021-06-22 08:13:54
2557	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 08:13:57	2021-06-22 08:13:57
2558	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 08:13:57	2021-06-22 08:13:57
2559	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 08:13:57	2021-06-22 08:13:57
2560	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-22 08:15:03	2021-06-22 08:15:03
2561	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-22 08:15:03	2021-06-22 08:15:03
2562	T??che "Update task"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-22 08:15:03	2021-06-22 08:15:03
2563	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 08:15:48	2021-06-22 08:15:48
2564	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 08:15:48	2021-06-22 08:15:48
2565	T??che "Update task"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 08:15:48	2021-06-22 08:15:48
2566	Mgbi vous a assign?? ?? la t??che test date.	f	57	54	2021-06-22 08:17:35	2021-06-22 08:17:35
2567	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-22 08:30:09	2021-06-22 08:30:09
2568	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-22 08:30:09	2021-06-22 08:30:09
2569	T??che "kanban"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-22 08:30:09	2021-06-22 08:30:09
2570	T??che "t??che urgente"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-22 08:30:19	2021-06-22 08:30:19
2571	T??che "t??che urgente"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-22 08:30:19	2021-06-22 08:30:19
2572	T??che "t??che urgente"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-22 08:30:19	2021-06-22 08:30:19
2573	T??che "Handleinfo "\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 08:30:23	2021-06-22 08:30:23
2574	T??che "Handleinfo "\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 08:30:23	2021-06-22 08:30:23
2575	T??che "Handleinfo "\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 08:30:23	2021-06-22 08:30:23
2576	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-22 08:30:25	2021-06-22 08:30:25
2577	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-22 08:30:25	2021-06-22 08:30:25
2578	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-22 08:30:25	2021-06-22 08:30:25
2436	T??che nouvellement cr??ee du nom de olana be par Test dans le projet Premier test.	t	41	57	2021-06-18 22:11:13	2021-06-18 22:11:13
2439	T??che "olana be"\n          du projet Premier test mise dans " En attente " par Test	t	41	57	2021-06-18 22:11:26	2021-06-18 22:11:26
2442	T??che "alpine"\n          du projet Premier test mise dans " En attente " par Test	t	41	57	2021-06-18 22:11:29	2021-06-18 22:11:29
2445	T??che "alpine"\n          du projet Premier test mise dans " A faire " par Test	t	41	57	2021-06-18 22:11:32	2021-06-18 22:11:32
2579	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-24 11:41:56	2021-06-24 11:41:56
2580	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-24 11:41:56	2021-06-24 11:41:56
2581	T??che "date_insert"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-24 11:41:56	2021-06-24 11:41:56
2582	T??che "Handleinfo "\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-26 17:32:39	2021-06-26 17:32:39
2583	T??che "Handleinfo "\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-26 17:32:39	2021-06-26 17:32:39
2584	T??che "Handleinfo "\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-26 17:32:39	2021-06-26 17:32:39
2585	T??che "Handleinfo "\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-26 17:32:55	2021-06-26 17:32:55
2586	T??che "Handleinfo "\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-26 17:32:55	2021-06-26 17:32:55
2587	T??che "Handleinfo "\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-26 17:32:55	2021-06-26 17:32:55
2588	T??che "olana be"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-26 19:46:39	2021-06-26 19:46:39
2589	T??che "olana be"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-26 19:46:39	2021-06-26 19:46:39
2590	T??che "olana be"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-26 19:46:39	2021-06-26 19:46:39
2591	T??che "R??daction"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-26 19:47:36	2021-06-26 19:47:36
2592	T??che "R??daction"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-26 19:47:36	2021-06-26 19:47:36
2593	T??che "R??daction"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-26 19:47:36	2021-06-26 19:47:36
2594	T??che "Update task"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-26 19:47:42	2021-06-26 19:47:42
2595	T??che "Update task"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-26 19:47:42	2021-06-26 19:47:42
2596	T??che "Update task"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-26 19:47:42	2021-06-26 19:47:42
2597	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-26 19:58:57	2021-06-26 19:58:57
2598	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-06-26 19:58:57	2021-06-26 19:58:57
2599	T??che "kanban"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-26 19:58:57	2021-06-26 19:58:57
2600	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	53	2021-06-26 19:58:59	2021-06-26 19:58:59
2601	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	41	2021-06-26 19:58:59	2021-06-26 19:58:59
2602	T??che "kanban"\n          du projet Premier test mise dans " En contr??le " par Mgbi	f	57	52	2021-06-26 19:58:59	2021-06-26 19:58:59
2603	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-26 20:00:17	2021-06-26 20:00:17
2604	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-26 20:00:17	2021-06-26 20:00:17
2605	T??che "kanban"\n          du projet Premier test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-26 20:00:17	2021-06-26 20:00:17
2606	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	53	2021-06-28 19:15:20	2021-06-28 19:15:20
2607	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	41	2021-06-28 19:15:20	2021-06-28 19:15:20
2608	T??che "cerise2"\n          du projet mon_projet mise dans " En contr??le " par Mgbi	f	57	52	2021-06-28 19:15:20	2021-06-28 19:15:20
2609	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-06-28 19:15:29	2021-06-28 19:15:29
2610	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-06-28 19:15:29	2021-06-28 19:15:29
2611	T??che "cerise2"\n          du projet mon_projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-06-28 19:15:29	2021-06-28 19:15:29
2613	La requ??te Test n'est pas en cours	f	57	33	2021-07-04 17:38:14	2021-07-04 17:38:14
2614	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	53	2021-07-05 07:36:20	2021-07-05 07:36:20
2615	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	41	2021-07-05 07:36:20	2021-07-05 07:36:20
2616	T??che "tache "\n          du projet QLM Site E-commerce mise dans " En contr??le " par Mgbi	f	57	52	2021-07-05 07:36:20	2021-07-05 07:36:20
2617	Un projet du nom de projet test a ??t?? cr??e par Mgbi	f	57	53	2021-07-05 07:47:20	2021-07-05 07:47:20
2618	Un projet du nom de projet test a ??t?? cr??e par Mgbi	f	57	41	2021-07-05 07:47:20	2021-07-05 07:47:20
2619	Un projet du nom de projet test a ??t?? cr??e par Mgbi	f	57	52	2021-07-05 07:47:20	2021-07-05 07:47:20
2620	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet projet test.	f	57	53	2021-07-05 07:52:30	2021-07-05 07:52:30
2621	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet projet test.	f	57	41	2021-07-05 07:52:30	2021-07-05 07:52:30
2622	T??che nouvellement cr??ee du nom de t??che test par Mgbi dans le projet projet test.	f	57	52	2021-07-05 07:52:30	2021-07-05 07:52:30
2623	Mgbi vous a assign?? ?? la t??che t??che test.	f	57	62	2021-07-05 08:02:31	2021-07-05 08:02:31
2624	T??che "t??che test"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	53	2021-07-05 08:06:57	2021-07-05 08:06:57
2625	T??che "t??che test"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	41	2021-07-05 08:06:57	2021-07-05 08:06:57
2626	T??che "t??che test"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	52	2021-07-05 08:06:57	2021-07-05 08:06:57
2627	T??che "t??che test"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	57	2021-07-05 08:06:57	2021-07-05 08:06:57
2628	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	53	2021-07-05 08:07:00	2021-07-05 08:07:00
2629	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	41	2021-07-05 08:07:00	2021-07-05 08:07:00
2630	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	52	2021-07-05 08:07:00	2021-07-05 08:07:00
2631	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	57	2021-07-05 08:07:00	2021-07-05 08:07:00
2632	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	53	2021-07-05 08:08:31	2021-07-05 08:08:31
2633	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	41	2021-07-05 08:08:31	2021-07-05 08:08:31
2634	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	52	2021-07-05 08:08:31	2021-07-05 08:08:31
2635	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	57	2021-07-05 08:08:31	2021-07-05 08:08:31
2636	Une t??che fille de votre t??che primaire t??che test du nom de sous-t??che1 a ??t?? cr??ee par ContributeurMGBI dans le projet projet test	f	62	57	2021-07-05 08:14:08	2021-07-05 08:14:08
2655	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-07-05 08:23:49	2021-07-05 08:23:49
2656	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-07-05 08:23:49	2021-07-05 08:23:49
2657	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-07-05 08:23:49	2021-07-05 08:23:49
2661	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-07-05 08:23:53	2021-07-05 08:23:53
2662	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-07-05 08:23:53	2021-07-05 08:23:53
2663	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-07-05 08:23:53	2021-07-05 08:23:53
2637	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	53	2021-07-05 08:20:47	2021-07-05 08:20:47
2638	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	41	2021-07-05 08:20:47	2021-07-05 08:20:47
2639	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	52	2021-07-05 08:20:47	2021-07-05 08:20:47
2640	T??che "t??che test"\n          du projet projet test mise dans " En cours " par ContributeurMGBI	f	62	57	2021-07-05 08:20:47	2021-07-05 08:20:47
2641	T??che "sous-t??che1"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	53	2021-07-05 08:21:08	2021-07-05 08:21:08
2642	T??che "sous-t??che1"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	41	2021-07-05 08:21:08	2021-07-05 08:21:08
2643	T??che "sous-t??che1"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	52	2021-07-05 08:21:08	2021-07-05 08:21:08
2644	T??che "sous-t??che1"\n          du projet projet test mise dans " En attente " par ContributeurMGBI	f	62	57	2021-07-05 08:21:08	2021-07-05 08:21:08
2645	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	53	2021-07-05 08:21:10	2021-07-05 08:21:10
2646	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	41	2021-07-05 08:21:10	2021-07-05 08:21:10
2647	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	52	2021-07-05 08:21:10	2021-07-05 08:21:10
2648	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par ContributeurMGBI	f	62	57	2021-07-05 08:21:10	2021-07-05 08:21:10
2649	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-07-05 08:23:16	2021-07-05 08:23:16
2650	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-07-05 08:23:16	2021-07-05 08:23:16
2651	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-07-05 08:23:16	2021-07-05 08:23:16
2652	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-07-05 08:23:16	2021-07-05 08:23:16
2653	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-07-05 08:23:16	2021-07-05 08:23:16
2654	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-07-05 08:23:16	2021-07-05 08:23:16
2658	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-07-05 08:23:53	2021-07-05 08:23:53
2659	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-07-05 08:23:53	2021-07-05 08:23:53
2660	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-07-05 08:23:53	2021-07-05 08:23:53
2664	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-07-05 08:23:55	2021-07-05 08:23:55
2665	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-07-05 08:23:55	2021-07-05 08:23:55
2666	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-07-05 08:23:55	2021-07-05 08:23:55
2667	T??che sous-t??che1 archiv??e par Mgbi.	f	57	53	2021-07-05 08:25:45	2021-07-05 08:25:45
2668	T??che sous-t??che1 archiv??e par Mgbi.	f	57	41	2021-07-05 08:25:45	2021-07-05 08:25:45
2669	T??che sous-t??che1 archiv??e par Mgbi.	f	57	52	2021-07-05 08:25:45	2021-07-05 08:25:45
2673	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test requ??te".	f	33	41	2021-07-05 08:57:39	2021-07-05 08:57:39
2674	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test requ??te".	f	33	52	2021-07-05 08:57:39	2021-07-05 08:57:39
2675	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Test requ??te".	f	33	57	2021-07-05 08:57:39	2021-07-05 08:57:39
2676	Un projet du nom de Un projet a ??t?? cr??e par Mgbi	f	57	53	2021-08-10 11:48:57	2021-08-10 11:48:57
2677	Un projet du nom de Un projet a ??t?? cr??e par Mgbi	f	57	41	2021-08-10 11:48:57	2021-08-10 11:48:57
2678	Un projet du nom de Un projet a ??t?? cr??e par Mgbi	f	57	52	2021-08-10 11:48:57	2021-08-10 11:48:57
2679	T??che nouvellement cr??ee du nom de T??che d??mo par Mgbi dans le projet Un projet.	f	57	53	2021-08-11 07:30:46	2021-08-11 07:30:46
2680	T??che nouvellement cr??ee du nom de T??che d??mo par Mgbi dans le projet Un projet.	f	57	41	2021-08-11 07:30:46	2021-08-11 07:30:46
2681	T??che nouvellement cr??ee du nom de T??che d??mo par Mgbi dans le projet Un projet.	f	57	52	2021-08-11 07:30:46	2021-08-11 07:30:46
2682	T??che test date archiv??e par Mgbi.	f	57	53	2021-08-11 09:07:46	2021-08-11 09:07:46
2683	T??che test date archiv??e par Mgbi.	f	57	41	2021-08-11 09:07:46	2021-08-11 09:07:46
2684	T??che test date archiv??e par Mgbi.	f	57	52	2021-08-11 09:07:46	2021-08-11 09:07:46
2685	T??che test date archiv??e par Mgbi.	f	57	53	2021-08-11 09:08:40	2021-08-11 09:08:40
2686	T??che test date archiv??e par Mgbi.	f	57	41	2021-08-11 09:08:40	2021-08-11 09:08:40
2687	T??che test date archiv??e par Mgbi.	f	57	52	2021-08-11 09:08:40	2021-08-11 09:08:40
2688	Mgbi vous a assign?? ?? la t??che T??che d??mo.	f	57	54	2021-08-11 11:36:46	2021-08-11 11:36:46
2689	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Ma requ??te".	f	33	41	2021-08-11 13:09:18	2021-08-11 13:09:18
2690	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Ma requ??te".	f	33	52	2021-08-11 13:09:18	2021-08-11 13:09:18
2691	Le client Eric de la soci??t?? MGBI a envoy?? une requ??te intitul??e "Ma requ??te".	f	33	57	2021-08-11 13:09:18	2021-08-11 13:09:18
2692	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-12 13:26:18	2021-08-12 13:26:18
2693	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-12 13:26:18	2021-08-12 13:26:18
2694	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-12 13:26:18	2021-08-12 13:26:18
2695	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-12 13:26:23	2021-08-12 13:26:23
2696	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-12 13:26:23	2021-08-12 13:26:23
2697	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-12 13:26:23	2021-08-12 13:26:23
2698	T??che nouvellement cr??ee du nom de Second test par Mgbi dans le projet Un projet.	f	57	53	2021-08-13 07:20:46	2021-08-13 07:20:46
2699	T??che nouvellement cr??ee du nom de Second test par Mgbi dans le projet Un projet.	f	57	41	2021-08-13 07:20:46	2021-08-13 07:20:46
2700	T??che nouvellement cr??ee du nom de Second test par Mgbi dans le projet Un projet.	f	57	52	2021-08-13 07:20:46	2021-08-13 07:20:46
2701	T??che "Second test"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-13 07:20:54	2021-08-13 07:20:54
2702	T??che "Second test"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-13 07:20:54	2021-08-13 07:20:54
2703	T??che "Second test"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-13 07:20:54	2021-08-13 07:20:54
2704	T??che "Second test"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-13 07:20:58	2021-08-13 07:20:58
2705	T??che "Second test"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-13 07:20:58	2021-08-13 07:20:58
2706	T??che "Second test"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-13 07:20:58	2021-08-13 07:20:58
2707	Mgbi vous a assign?? ?? la t??che Second test.	f	57	54	2021-08-13 07:21:26	2021-08-13 07:21:26
2708	Un projet du nom de test date finale a ??t?? cr??e par Mgbi	f	57	53	2021-08-17 08:44:11	2021-08-17 08:44:11
2709	Un projet du nom de test date finale a ??t?? cr??e par Mgbi	f	57	41	2021-08-17 08:44:11	2021-08-17 08:44:11
2710	Un projet du nom de test date finale a ??t?? cr??e par Mgbi	f	57	52	2021-08-17 08:44:11	2021-08-17 08:44:11
2711	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-08-18 08:22:49	2021-08-18 08:22:49
2712	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-08-18 08:22:49	2021-08-18 08:22:49
2713	Le projet "Premier test" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-08-18 08:22:49	2021-08-18 08:22:49
2714	T??che nouvellement cr??ee du nom de t??che sans d??but par Mgbi dans le projet test date finale.	f	57	53	2021-08-18 13:26:21	2021-08-18 13:26:21
2715	T??che nouvellement cr??ee du nom de t??che sans d??but par Mgbi dans le projet test date finale.	f	57	41	2021-08-18 13:26:21	2021-08-18 13:26:21
2716	T??che nouvellement cr??ee du nom de t??che sans d??but par Mgbi dans le projet test date finale.	f	57	52	2021-08-18 13:26:21	2021-08-18 13:26:21
2717	T??che nouvellement cr??ee du nom de t??che sans d??but 2 par Mgbi dans le projet test date finale.	f	57	53	2021-08-18 13:27:54	2021-08-18 13:27:54
2718	T??che nouvellement cr??ee du nom de t??che sans d??but 2 par Mgbi dans le projet test date finale.	f	57	41	2021-08-18 13:27:54	2021-08-18 13:27:54
2719	T??che nouvellement cr??ee du nom de t??che sans d??but 2 par Mgbi dans le projet test date finale.	f	57	52	2021-08-18 13:27:54	2021-08-18 13:27:54
2720	Une t??che fille de votre t??che primaire TACHE POUR MATTHIEU du nom de second without dt_start a ??t?? cr??ee par Mgbi1 dans le projet mon_projet	f	54	57	2021-08-18 13:32:11	2021-08-18 13:32:11
2721	Une t??che fille de votre t??che primaire TACHE POUR MATTHIEU du nom de snd without dt start a ??t?? cr??ee par Mgbi1 dans le projet mon_projet	f	54	57	2021-08-18 13:44:55	2021-08-18 13:44:55
2722	Une t??che fille de votre t??che primaire TACHE POUR MATTHIEU du nom de sous tache oue a ??t?? cr??ee par Mgbi1 dans le projet mon_projet	f	54	57	2021-08-18 14:07:44	2021-08-18 14:07:44
2723	Une t??che fille de votre t??che primaire T??che d??mo du nom de sous demo a ??t?? cr??ee par Mgbi dans le projet Un projet	f	57	57	2021-08-19 08:08:56	2021-08-19 08:08:56
2724	T??che nouvellement cr??ee du nom de new one par Mgbi dans le projet Un projet.	f	57	53	2021-08-19 08:22:03	2021-08-19 08:22:03
2725	T??che nouvellement cr??ee du nom de new one par Mgbi dans le projet Un projet.	f	57	41	2021-08-19 08:22:03	2021-08-19 08:22:03
2726	T??che nouvellement cr??ee du nom de new one par Mgbi dans le projet Un projet.	f	57	52	2021-08-19 08:22:03	2021-08-19 08:22:03
2727	Une t??che fille de votre t??che primaire new one du nom de new one three a ??t?? cr??ee par Mgbi dans le projet Un projet	f	57	57	2021-08-19 08:45:07	2021-08-19 08:45:07
2728	Une t??che fille de votre t??che primaire T??che d??mo du nom de sous demo 2  a ??t?? cr??ee par Mgbi1 dans le projet Un projet	f	54	57	2021-08-19 08:45:42	2021-08-19 08:45:42
2729	T??che nouvellement cr??ee du nom de New two par Mgbi dans le projet Un projet.	f	57	53	2021-08-19 08:46:59	2021-08-19 08:46:59
2730	T??che nouvellement cr??ee du nom de New two par Mgbi dans le projet Un projet.	f	57	41	2021-08-19 08:46:59	2021-08-19 08:46:59
2731	T??che nouvellement cr??ee du nom de New two par Mgbi dans le projet Un projet.	f	57	52	2021-08-19 08:46:59	2021-08-19 08:46:59
2732	T??che nouvellement cr??ee du nom de my_task par Mgbi dans le projet Un projet.	f	57	53	2021-08-23 08:40:11	2021-08-23 08:40:11
2733	T??che nouvellement cr??ee du nom de my_task par Mgbi dans le projet Un projet.	f	57	41	2021-08-23 08:40:11	2021-08-23 08:40:11
2734	T??che nouvellement cr??ee du nom de my_task par Mgbi dans le projet Un projet.	f	57	52	2021-08-23 08:40:11	2021-08-23 08:40:11
2735	T??che nouvellement cr??ee du nom de my_task2 par Mgbi dans le projet Un projet.	f	57	53	2021-08-23 08:40:34	2021-08-23 08:40:34
2736	T??che nouvellement cr??ee du nom de my_task2 par Mgbi dans le projet Un projet.	f	57	41	2021-08-23 08:40:34	2021-08-23 08:40:34
2737	T??che nouvellement cr??ee du nom de my_task2 par Mgbi dans le projet Un projet.	f	57	52	2021-08-23 08:40:34	2021-08-23 08:40:34
2738	Une t??che fille de votre t??che primaire my_task du nom de my_subtask1 a ??t?? cr??ee par Mgbi dans le projet Un projet	f	57	57	2021-08-23 08:42:27	2021-08-23 08:42:27
2739	Une t??che fille de votre t??che primaire my_task2 du nom de my_subtask2 a ??t?? cr??ee par Mgbi1 dans le projet Un projet	f	54	57	2021-08-23 08:43:12	2021-08-23 08:43:12
2740	Vous avez ??t?? assign?? ?? la sous-t??che subreal2 du projet Un projet	f	57	54	2021-08-23 11:04:49	2021-08-23 11:04:49
2741	Vous avez ??t?? assign?? ?? la sous-t??che sub_demo du projet Un projet	f	57	54	2021-08-23 11:16:09	2021-08-23 11:16:09
2742	Vous avez ??t?? assign?? ?? la sous-t??che subdemo2 du projet Un projet	f	57	54	2021-08-23 11:17:11	2021-08-23 11:17:11
2743	Vous avez ??t?? assign?? ?? la sous-t??che subdemo3 du projet Un projet	f	57	62	2021-08-23 11:26:33	2021-08-23 11:26:33
2744	T??che nouvellement cr??ee du nom de wo_attrib par Mgbi dans le projet Un projet.	f	57	53	2021-08-23 11:37:00	2021-08-23 11:37:00
2745	T??che nouvellement cr??ee du nom de wo_attrib par Mgbi dans le projet Un projet.	f	57	41	2021-08-23 11:37:00	2021-08-23 11:37:00
2746	T??che nouvellement cr??ee du nom de wo_attrib par Mgbi dans le projet Un projet.	f	57	52	2021-08-23 11:37:00	2021-08-23 11:37:00
2747	T??che nouvellement cr??ee du nom de w_attrib par Mgbi dans le projet Un projet.	f	57	53	2021-08-23 11:37:34	2021-08-23 11:37:34
2748	T??che nouvellement cr??ee du nom de w_attrib par Mgbi dans le projet Un projet.	f	57	41	2021-08-23 11:37:34	2021-08-23 11:37:34
2749	T??che nouvellement cr??ee du nom de w_attrib par Mgbi dans le projet Un projet.	f	57	52	2021-08-23 11:37:34	2021-08-23 11:37:34
2750	T??che new one archiv??e par Mgbi.	f	57	53	2021-08-23 14:37:03	2021-08-23 14:37:03
2751	T??che new one archiv??e par Mgbi.	f	57	41	2021-08-23 14:37:03	2021-08-23 14:37:03
2752	T??che new one archiv??e par Mgbi.	f	57	52	2021-08-23 14:37:03	2021-08-23 14:37:03
2753	T??che new one archiv??e par Mgbi.	f	57	53	2021-08-23 14:37:30	2021-08-23 14:37:30
2754	T??che new one archiv??e par Mgbi.	f	57	41	2021-08-23 14:37:30	2021-08-23 14:37:30
2755	T??che new one archiv??e par Mgbi.	f	57	52	2021-08-23 14:37:30	2021-08-23 14:37:30
2756	T??che new one archiv??e par Mgbi.	f	57	53	2021-08-23 14:38:01	2021-08-23 14:38:01
2757	T??che new one archiv??e par Mgbi.	f	57	41	2021-08-23 14:38:01	2021-08-23 14:38:01
2758	T??che new one archiv??e par Mgbi.	f	57	52	2021-08-23 14:38:01	2021-08-23 14:38:01
2759	T??che sous demo archiv??e par Mgbi.	f	57	53	2021-08-23 14:38:11	2021-08-23 14:38:11
2760	T??che sous demo archiv??e par Mgbi.	f	57	41	2021-08-23 14:38:11	2021-08-23 14:38:11
2761	T??che sous demo archiv??e par Mgbi.	f	57	52	2021-08-23 14:38:11	2021-08-23 14:38:11
2762	T??che new one archiv??e par Mgbi.	f	57	53	2021-08-23 14:54:24	2021-08-23 14:54:24
2763	T??che new one archiv??e par Mgbi.	f	57	41	2021-08-23 14:54:24	2021-08-23 14:54:24
2764	T??che new one archiv??e par Mgbi.	f	57	52	2021-08-23 14:54:24	2021-08-23 14:54:24
2765	T??che New two archiv??e par Mgbi.	f	57	53	2021-08-23 14:54:45	2021-08-23 14:54:45
2766	T??che New two archiv??e par Mgbi.	f	57	41	2021-08-23 14:54:45	2021-08-23 14:54:45
2767	T??che New two archiv??e par Mgbi.	f	57	52	2021-08-23 14:54:45	2021-08-23 14:54:45
2768	T??che sous demo archiv??e par Mgbi.	f	57	53	2021-08-23 14:55:26	2021-08-23 14:55:26
2769	T??che sous demo archiv??e par Mgbi.	f	57	41	2021-08-23 14:55:26	2021-08-23 14:55:26
2770	T??che sous demo archiv??e par Mgbi.	f	57	52	2021-08-23 14:55:26	2021-08-23 14:55:26
2771	T??che new one two archiv??e par Mgbi.	f	57	53	2021-08-23 14:55:29	2021-08-23 14:55:29
2772	T??che new one two archiv??e par Mgbi.	f	57	41	2021-08-23 14:55:29	2021-08-23 14:55:29
2773	T??che new one two archiv??e par Mgbi.	f	57	52	2021-08-23 14:55:29	2021-08-23 14:55:29
2774	T??che new one archiv??e par Mgbi.	f	57	53	2021-08-23 15:25:00	2021-08-23 15:25:00
2775	T??che new one archiv??e par Mgbi.	f	57	41	2021-08-23 15:25:00	2021-08-23 15:25:00
2776	T??che new one archiv??e par Mgbi.	f	57	52	2021-08-23 15:25:00	2021-08-23 15:25:00
2777	T??che New two archiv??e par Mgbi.	f	57	53	2021-08-23 15:25:03	2021-08-23 15:25:03
2778	T??che New two archiv??e par Mgbi.	f	57	41	2021-08-23 15:25:03	2021-08-23 15:25:03
2779	T??che New two archiv??e par Mgbi.	f	57	52	2021-08-23 15:25:03	2021-08-23 15:25:03
2780	T??che "new one"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	53	2021-08-23 15:32:27	2021-08-23 15:32:27
2781	T??che "new one"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	41	2021-08-23 15:32:27	2021-08-23 15:32:27
2782	T??che "new one"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	52	2021-08-23 15:32:27	2021-08-23 15:32:27
2783	T??che "New two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	53	2021-08-23 15:33:28	2021-08-23 15:33:28
2784	T??che "New two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	41	2021-08-23 15:33:28	2021-08-23 15:33:28
2785	T??che "New two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	52	2021-08-23 15:33:28	2021-08-23 15:33:28
2786	T??che "new one two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	53	2021-08-23 15:33:34	2021-08-23 15:33:34
2787	T??che "new one two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	41	2021-08-23 15:33:34	2021-08-23 15:33:34
2788	T??che "new one two"\n          du projet Un projet mise dans " En attente " par Mgbi	f	57	52	2021-08-23 15:33:34	2021-08-23 15:33:34
2789	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-23 15:36:31	2021-08-23 15:36:31
2790	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-23 15:36:31	2021-08-23 15:36:31
2791	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-23 15:36:31	2021-08-23 15:36:31
2792	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-08-23 15:36:35	2021-08-23 15:36:35
2793	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-08-23 15:36:35	2021-08-23 15:36:35
2794	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-08-23 15:36:35	2021-08-23 15:36:35
2795	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-23 15:36:35	2021-08-23 15:36:35
2796	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-23 15:36:35	2021-08-23 15:36:35
2797	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-23 15:36:35	2021-08-23 15:36:35
2798	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-23 15:37:09	2021-08-23 15:37:09
2799	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-23 15:37:09	2021-08-23 15:37:09
2800	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-23 15:37:09	2021-08-23 15:37:09
2807	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-23 15:38:06	2021-08-23 15:38:06
2808	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-23 15:38:06	2021-08-23 15:38:06
2809	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-23 15:38:06	2021-08-23 15:38:06
2810	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-08-23 15:38:24	2021-08-23 15:38:24
2811	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-08-23 15:38:24	2021-08-23 15:38:24
2812	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-08-23 15:38:24	2021-08-23 15:38:24
2813	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-23 15:38:24	2021-08-23 15:38:24
2814	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-23 15:38:24	2021-08-23 15:38:24
2815	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-23 15:38:24	2021-08-23 15:38:24
2816	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-08-23 16:03:25	2021-08-23 16:03:25
2817	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-08-23 16:03:25	2021-08-23 16:03:25
2818	T??che "new one"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-08-23 16:03:25	2021-08-23 16:03:25
2801	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-08-23 15:37:17	2021-08-23 15:37:17
2802	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-08-23 15:37:17	2021-08-23 15:37:17
2803	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-08-23 15:37:17	2021-08-23 15:37:17
2804	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-23 15:37:17	2021-08-23 15:37:17
2805	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-23 15:37:17	2021-08-23 15:37:17
2806	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-23 15:37:17	2021-08-23 15:37:17
2819	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-08-23 16:03:34	2021-08-23 16:03:34
2820	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-08-23 16:03:34	2021-08-23 16:03:34
2821	La t??che new one a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-08-23 16:03:34	2021-08-23 16:03:34
2822	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-23 16:03:34	2021-08-23 16:03:34
2823	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-23 16:03:34	2021-08-23 16:03:34
2824	T??che "new one"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-23 16:03:34	2021-08-23 16:03:34
2825	T??che "my_task2"\n          du projet Un projet mise dans " En contr??le " par Mgbi1	f	54	53	2021-08-25 08:51:38	2021-08-25 08:51:38
2826	T??che "my_task2"\n          du projet Un projet mise dans " En contr??le " par Mgbi1	f	54	41	2021-08-25 08:51:38	2021-08-25 08:51:38
2827	T??che "my_task2"\n          du projet Un projet mise dans " En contr??le " par Mgbi1	f	54	52	2021-08-25 08:51:38	2021-08-25 08:51:38
2828	T??che "my_task2"\n          du projet Un projet mise dans " En contr??le " par Mgbi1	f	54	57	2021-08-25 08:51:38	2021-08-25 08:51:38
2829	T??che "my_task2"\n          du projet Un projet mise dans " A faire " par Mgbi1	f	54	53	2021-08-25 08:51:43	2021-08-25 08:51:43
2830	T??che "my_task2"\n          du projet Un projet mise dans " A faire " par Mgbi1	f	54	41	2021-08-25 08:51:43	2021-08-25 08:51:43
2831	T??che "my_task2"\n          du projet Un projet mise dans " A faire " par Mgbi1	f	54	52	2021-08-25 08:51:43	2021-08-25 08:51:43
2832	T??che "my_task2"\n          du projet Un projet mise dans " A faire " par Mgbi1	f	54	57	2021-08-25 08:51:43	2021-08-25 08:51:43
2833	Un projet du nom de blocage test a ??t?? cr??e par Mgbi	f	57	53	2021-08-27 07:07:36	2021-08-27 07:07:36
2834	Un projet du nom de blocage test a ??t?? cr??e par Mgbi	f	57	41	2021-08-27 07:07:36	2021-08-27 07:07:36
2835	Un projet du nom de blocage test a ??t?? cr??e par Mgbi	f	57	52	2021-08-27 07:07:36	2021-08-27 07:07:36
2836	T??che nouvellement cr??ee du nom de t??che par Mgbi dans le projet blocage test.	f	57	53	2021-08-27 07:10:55	2021-08-27 07:10:55
2837	T??che nouvellement cr??ee du nom de t??che par Mgbi dans le projet blocage test.	f	57	41	2021-08-27 07:10:55	2021-08-27 07:10:55
2838	T??che nouvellement cr??ee du nom de t??che par Mgbi dans le projet blocage test.	f	57	52	2021-08-27 07:10:55	2021-08-27 07:10:55
2839	T??che "t??che"\n          du projet blocage test mise dans " En cours " par Mgbi	f	57	53	2021-08-27 07:11:05	2021-08-27 07:11:05
2840	T??che "t??che"\n          du projet blocage test mise dans " En cours " par Mgbi	f	57	41	2021-08-27 07:11:05	2021-08-27 07:11:05
2841	T??che "t??che"\n          du projet blocage test mise dans " En cours " par Mgbi	f	57	52	2021-08-27 07:11:05	2021-08-27 07:11:05
2842	T??che "t??che"\n          du projet blocage test mise dans " En contr??le " par Mgbi	f	57	53	2021-08-27 07:11:06	2021-08-27 07:11:06
2843	T??che "t??che"\n          du projet blocage test mise dans " En contr??le " par Mgbi	f	57	41	2021-08-27 07:11:06	2021-08-27 07:11:06
2844	T??che "t??che"\n          du projet blocage test mise dans " En contr??le " par Mgbi	f	57	52	2021-08-27 07:11:06	2021-08-27 07:11:06
2845	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-27 07:11:08	2021-08-27 07:11:08
2846	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-27 07:11:08	2021-08-27 07:11:08
2847	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-27 07:11:08	2021-08-27 07:11:08
2848	T??che "t??che"\n          du projet blocage test mise dans " En blocage " par Mgbi	f	57	53	2021-08-27 07:12:48	2021-08-27 07:12:48
2849	T??che "t??che"\n          du projet blocage test mise dans " En blocage " par Mgbi	f	57	41	2021-08-27 07:12:48	2021-08-27 07:12:48
2850	T??che "t??che"\n          du projet blocage test mise dans " En blocage " par Mgbi	f	57	52	2021-08-27 07:12:48	2021-08-27 07:12:48
2851	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-08-27 07:12:50	2021-08-27 07:12:50
2852	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-08-27 07:12:50	2021-08-27 07:12:50
2853	T??che "t??che"\n          du projet blocage test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-08-27 07:12:50	2021-08-27 07:12:50
2854	T??che my_task2 archiv??e par Mgbi.	f	57	53	2021-08-30 08:08:47	2021-08-30 08:08:47
2855	T??che my_task2 archiv??e par Mgbi.	f	57	41	2021-08-30 08:08:47	2021-08-30 08:08:47
2856	T??che my_task2 archiv??e par Mgbi.	f	57	52	2021-08-30 08:08:47	2021-08-30 08:08:47
2857	T??che New two archiv??e par Mgbi.	f	57	53	2021-08-30 08:09:36	2021-08-30 08:09:36
2858	T??che New two archiv??e par Mgbi.	f	57	41	2021-08-30 08:09:36	2021-08-30 08:09:36
2859	T??che New two archiv??e par Mgbi.	f	57	52	2021-08-30 08:09:36	2021-08-30 08:09:36
2860	T??che my_task2 archiv??e par Mgbi.	f	57	53	2021-08-30 08:14:36	2021-08-30 08:14:36
2861	T??che my_task2 archiv??e par Mgbi.	f	57	41	2021-08-30 08:14:36	2021-08-30 08:14:36
2862	T??che my_task2 archiv??e par Mgbi.	f	57	52	2021-08-30 08:14:36	2021-08-30 08:14:36
2863	T??che my_task2 archiv??e par Mgbi.	f	57	53	2021-08-30 08:17:18	2021-08-30 08:17:18
2864	T??che my_task2 archiv??e par Mgbi.	f	57	41	2021-08-30 08:17:18	2021-08-30 08:17:18
2865	T??che my_task2 archiv??e par Mgbi.	f	57	52	2021-08-30 08:17:18	2021-08-30 08:17:18
2866	T??che my_task2 archiv??e par Mgbi.	f	57	53	2021-08-30 08:18:36	2021-08-30 08:18:36
2867	T??che my_task2 archiv??e par Mgbi.	f	57	41	2021-08-30 08:18:36	2021-08-30 08:18:36
2868	T??che my_task2 archiv??e par Mgbi.	f	57	52	2021-08-30 08:18:36	2021-08-30 08:18:36
2869	T??che my_task2 archiv??e par Mgbi.	f	57	53	2021-08-30 08:21:26	2021-08-30 08:21:26
2870	T??che my_task2 archiv??e par Mgbi.	f	57	41	2021-08-30 08:21:26	2021-08-30 08:21:26
2871	T??che my_task2 archiv??e par Mgbi.	f	57	52	2021-08-30 08:21:26	2021-08-30 08:21:26
2872	Un projet du nom de second blocage a ??t?? cr??e par Mgbi	f	57	53	2021-08-30 10:36:39	2021-08-30 10:36:39
2873	Un projet du nom de second blocage a ??t?? cr??e par Mgbi	f	57	41	2021-08-30 10:36:39	2021-08-30 10:36:39
2874	Un projet du nom de second blocage a ??t?? cr??e par Mgbi	f	57	52	2021-08-30 10:36:39	2021-08-30 10:36:39
2881	Vous avez ??t?? assign?? ?? la sous-t??che sous-t??che sans contr??le du projet Un projet	f	57	54	2021-08-31 12:31:22	2021-08-31 12:31:22
2882	Mgbi vous a assign?? ?? la t??che t??che sans contr??le.	f	57	54	2021-08-31 12:50:29	2021-08-31 12:50:29
2883	T??che "wo_attrib"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-08-31 13:13:01	2021-08-31 13:13:01
2884	T??che "wo_attrib"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-08-31 13:13:01	2021-08-31 13:13:01
2885	T??che "wo_attrib"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-08-31 13:13:01	2021-08-31 13:13:01
2886	T??che "New two"\n          du projet Un projet mise dans " A faire " par Mgbi	f	57	53	2021-08-31 13:13:56	2021-08-31 13:13:56
2887	T??che "New two"\n          du projet Un projet mise dans " A faire " par Mgbi	f	57	41	2021-08-31 13:13:56	2021-08-31 13:13:56
2888	T??che "New two"\n          du projet Un projet mise dans " A faire " par Mgbi	f	57	52	2021-08-31 13:13:56	2021-08-31 13:13:56
2889	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi1	f	54	53	2021-08-31 14:50:18	2021-08-31 14:50:18
2890	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi1	f	54	41	2021-08-31 14:50:18	2021-08-31 14:50:18
2891	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi1	f	54	52	2021-08-31 14:50:18	2021-08-31 14:50:18
2892	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi1	f	54	57	2021-08-31 14:50:18	2021-08-31 14:50:18
2893	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	53	2021-09-01 06:25:45	2021-09-01 06:25:45
2894	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	41	2021-09-01 06:25:45	2021-09-01 06:25:45
2895	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	52	2021-09-01 06:25:45	2021-09-01 06:25:45
2896	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 06:25:47	2021-09-01 06:25:47
2897	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 06:25:47	2021-09-01 06:25:47
2898	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 06:25:47	2021-09-01 06:25:47
2899	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	53	2021-09-01 06:25:48	2021-09-01 06:25:48
2900	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	41	2021-09-01 06:25:48	2021-09-01 06:25:48
2901	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	52	2021-09-01 06:25:48	2021-09-01 06:25:48
2902	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 06:25:50	2021-09-01 06:25:50
2903	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 06:25:50	2021-09-01 06:25:50
2904	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 06:25:50	2021-09-01 06:25:50
2905	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	53	2021-09-01 06:25:52	2021-09-01 06:25:52
2906	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	41	2021-09-01 06:25:52	2021-09-01 06:25:52
2907	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	52	2021-09-01 06:25:52	2021-09-01 06:25:52
2908	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 06:25:54	2021-09-01 06:25:54
2909	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 06:25:54	2021-09-01 06:25:54
2910	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 06:25:54	2021-09-01 06:25:54
2911	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	53	2021-09-01 06:25:56	2021-09-01 06:25:56
2912	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	41	2021-09-01 06:25:56	2021-09-01 06:25:56
2913	T??che "t??che test"\n          du projet projet test mise dans " En cours " par Mgbi	f	57	52	2021-09-01 06:25:56	2021-09-01 06:25:56
2914	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 06:25:57	2021-09-01 06:25:57
2915	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 06:25:57	2021-09-01 06:25:57
2916	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 06:25:57	2021-09-01 06:25:57
2917	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	53	2021-09-01 06:26:04	2021-09-01 06:26:04
2918	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	41	2021-09-01 06:26:04	2021-09-01 06:26:04
2919	T??che "t??che test"\n          du projet projet test mise dans " A faire " par Mgbi	f	57	52	2021-09-01 06:26:04	2021-09-01 06:26:04
2920	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 06:26:24	2021-09-01 06:26:24
2921	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 06:26:24	2021-09-01 06:26:24
2922	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 06:26:24	2021-09-01 06:26:24
2923	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-09-01 06:26:28	2021-09-01 06:26:28
2924	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-09-01 06:26:28	2021-09-01 06:26:28
2925	La t??che t??che test a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-09-01 06:26:28	2021-09-01 06:26:28
2926	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-01 06:26:28	2021-09-01 06:26:28
2927	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-01 06:26:28	2021-09-01 06:26:28
2928	T??che "t??che test"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-01 06:26:28	2021-09-01 06:26:28
2929	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 06:26:30	2021-09-01 06:26:30
2930	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 06:26:30	2021-09-01 06:26:30
2931	T??che "t??che test"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 06:26:30	2021-09-01 06:26:30
2932	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 08:06:11	2021-09-01 08:06:11
2933	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 08:06:11	2021-09-01 08:06:11
2934	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 08:06:11	2021-09-01 08:06:11
2935	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	53	2021-09-01 08:06:16	2021-09-01 08:06:16
2936	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	41	2021-09-01 08:06:16	2021-09-01 08:06:16
2937	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	52	2021-09-01 08:06:16	2021-09-01 08:06:16
2938	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-01 08:06:16	2021-09-01 08:06:16
2939	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-01 08:06:16	2021-09-01 08:06:16
2940	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-01 08:06:16	2021-09-01 08:06:16
2947	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	53	2021-09-01 08:06:29	2021-09-01 08:06:29
2948	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	41	2021-09-01 08:06:29	2021-09-01 08:06:29
2949	La t??che t??che test a ??t?? plac??e automatiquement "en cours" car toutes ses t??ches filles ont ??t?? achev??es	f	57	52	2021-09-01 08:06:29	2021-09-01 08:06:29
2953	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:35:55	2021-09-01 08:35:55
2954	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:35:55	2021-09-01 08:35:55
2955	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:35:55	2021-09-01 08:35:55
2941	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:06:23	2021-09-01 08:06:23
2942	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:06:23	2021-09-01 08:06:23
2943	T??che "t??che test"\n          du projet projet test mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:06:23	2021-09-01 08:06:23
2944	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 08:06:25	2021-09-01 08:06:25
2945	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 08:06:25	2021-09-01 08:06:25
2946	T??che "sous-t??che1"\n          du projet projet test mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 08:06:25	2021-09-01 08:06:25
2950	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-01 08:06:29	2021-09-01 08:06:29
2951	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-01 08:06:29	2021-09-01 08:06:29
2952	T??che "sous-t??che1"\n          du projet projet test mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-01 08:06:29	2021-09-01 08:06:29
2956	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:48:09	2021-09-01 08:48:09
2957	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:48:09	2021-09-01 08:48:09
2958	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:48:09	2021-09-01 08:48:09
2959	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:50:57	2021-09-01 08:50:57
2960	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:50:57	2021-09-01 08:50:57
2961	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:50:57	2021-09-01 08:50:57
2962	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:54:01	2021-09-01 08:54:01
2963	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:54:01	2021-09-01 08:54:01
2964	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:54:01	2021-09-01 08:54:01
2965	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:54:09	2021-09-01 08:54:09
2966	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:54:09	2021-09-01 08:54:09
2967	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:54:09	2021-09-01 08:54:09
2968	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:54:09	2021-09-01 08:54:09
2969	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	53	2021-09-01 08:56:45	2021-09-01 08:56:45
2970	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	41	2021-09-01 08:56:45	2021-09-01 08:56:45
2971	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En blocage " par Mgbi	f	57	52	2021-09-01 08:56:45	2021-09-01 08:56:45
2972	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:56:57	2021-09-01 08:56:57
2973	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:56:57	2021-09-01 08:56:57
2974	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:56:57	2021-09-01 08:56:57
2975	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:56:57	2021-09-01 08:56:57
2976	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:57:09	2021-09-01 08:57:09
2977	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:57:09	2021-09-01 08:57:09
2978	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:57:09	2021-09-01 08:57:09
2979	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:57:09	2021-09-01 08:57:09
2980	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:57:21	2021-09-01 08:57:21
2981	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:57:21	2021-09-01 08:57:21
2982	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:57:21	2021-09-01 08:57:21
2983	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:57:21	2021-09-01 08:57:21
2984	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:57:28	2021-09-01 08:57:28
2985	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:57:28	2021-09-01 08:57:28
2986	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:57:28	2021-09-01 08:57:28
2987	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:57:28	2021-09-01 08:57:28
2988	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:57:30	2021-09-01 08:57:30
2989	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:57:30	2021-09-01 08:57:30
2990	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:57:30	2021-09-01 08:57:30
2991	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:57:30	2021-09-01 08:57:30
2992	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 08:57:32	2021-09-01 08:57:32
2993	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 08:57:32	2021-09-01 08:57:32
2994	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 08:57:32	2021-09-01 08:57:32
2995	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 08:57:32	2021-09-01 08:57:32
2996	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 09:00:43	2021-09-01 09:00:43
2997	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 09:00:43	2021-09-01 09:00:43
2998	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 09:00:43	2021-09-01 09:00:43
2999	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 09:00:52	2021-09-01 09:00:52
3000	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 09:00:52	2021-09-01 09:00:52
3001	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 09:00:52	2021-09-01 09:00:52
3002	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 09:00:52	2021-09-01 09:00:52
3003	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 09:02:14	2021-09-01 09:02:14
3004	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 09:02:14	2021-09-01 09:02:14
3005	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 09:02:14	2021-09-01 09:02:14
3006	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 09:02:22	2021-09-01 09:02:22
3007	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 09:02:22	2021-09-01 09:02:22
3008	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 09:02:22	2021-09-01 09:02:22
3009	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 09:02:22	2021-09-01 09:02:22
3010	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	53	2021-09-01 09:07:09	2021-09-01 09:07:09
3011	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	41	2021-09-01 09:07:09	2021-09-01 09:07:09
3012	T??che "T??che d??mo"\n          du projet Un projet mise dans " En contr??le " par Mgbi	f	57	52	2021-09-01 09:07:09	2021-09-01 09:07:09
3028	T??che "sous demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:11:06	2021-09-01 09:11:06
3029	T??che "sous demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:11:06	2021-09-01 09:11:06
3030	T??che "sous demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:11:06	2021-09-01 09:11:06
3043	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 09:13:34	2021-09-01 09:13:34
3044	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 09:13:34	2021-09-01 09:13:34
3045	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 09:13:34	2021-09-01 09:13:34
3046	La t??che t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 09:13:34	2021-09-01 09:13:34
3013	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-09-01 09:07:17	2021-09-01 09:07:17
3014	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-09-01 09:07:17	2021-09-01 09:07:17
3015	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-09-01 09:07:17	2021-09-01 09:07:17
3016	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-01 09:07:17	2021-09-01 09:07:17
3017	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-01 09:07:17	2021-09-01 09:07:17
3018	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-01 09:07:17	2021-09-01 09:07:17
3019	T??che "sous demo 2 "\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:11:01	2021-09-01 09:11:01
3020	T??che "sous demo 2 "\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:11:01	2021-09-01 09:11:01
3021	T??che "sous demo 2 "\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:11:01	2021-09-01 09:11:01
3022	T??che "subdemo3"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:11:02	2021-09-01 09:11:02
3023	T??che "subdemo3"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:11:02	2021-09-01 09:11:02
3024	T??che "subdemo3"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:11:02	2021-09-01 09:11:02
3047	La t??che sous-t??che sans contr??le a ??t?? achev??e.	f	54	53	2021-09-01 09:14:54	2021-09-01 09:14:54
3048	La t??che sous-t??che sans contr??le a ??t?? achev??e.	f	54	41	2021-09-01 09:14:54	2021-09-01 09:14:54
3049	La t??che sous-t??che sans contr??le a ??t?? achev??e.	f	54	52	2021-09-01 09:14:54	2021-09-01 09:14:54
3050	La t??che sous-t??che sans contr??le a ??t?? achev??e.	f	54	57	2021-09-01 09:14:54	2021-09-01 09:14:54
3025	T??che "sub_demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:11:05	2021-09-01 09:11:05
3026	T??che "sub_demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:11:05	2021-09-01 09:11:05
3027	T??che "sub_demo"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:11:05	2021-09-01 09:11:05
3031	T??che "subdemo2"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:11:09	2021-09-01 09:11:09
3032	T??che "subdemo2"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:11:09	2021-09-01 09:11:09
3033	T??che "subdemo2"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:11:09	2021-09-01 09:11:09
3034	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	53	2021-09-01 09:11:39	2021-09-01 09:11:39
3035	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	41	2021-09-01 09:11:39	2021-09-01 09:11:39
3036	La t??che T??che d??mo a ??t?? achev??e avec toutes ses t??ches filles.	f	57	52	2021-09-01 09:11:39	2021-09-01 09:11:39
3037	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-01 09:11:39	2021-09-01 09:11:39
3038	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-01 09:11:39	2021-09-01 09:11:39
3039	T??che "T??che d??mo"\n          du projet Un projet mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-01 09:11:39	2021-09-01 09:11:39
3040	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	53	2021-09-01 09:13:26	2021-09-01 09:13:26
3041	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	41	2021-09-01 09:13:26	2021-09-01 09:13:26
3042	T??che "t??che sans contr??le"\n          du projet Un projet mise dans " En cours " par Mgbi	f	57	52	2021-09-01 09:13:26	2021-09-01 09:13:26
3051	Le projet "QLM Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-19 18:17:57	2021-09-19 18:17:57
3052	Le projet "QLM Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-19 18:17:57	2021-09-19 18:17:57
3053	Le projet "QLM Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-19 18:17:57	2021-09-19 18:17:57
3054	Le projet "Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-19 18:18:10	2021-09-19 18:18:10
3055	Le projet "Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-19 18:18:10	2021-09-19 18:18:10
3056	Le projet "Site E-commerce" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-19 18:18:10	2021-09-19 18:18:10
3057	Un projet du nom de Pr??sentation de m??moire a ??t?? cr??e par Mgbi	f	57	53	2021-09-19 18:26:26	2021-09-19 18:26:26
3058	Un projet du nom de Pr??sentation de m??moire a ??t?? cr??e par Mgbi	f	57	41	2021-09-19 18:26:26	2021-09-19 18:26:26
3059	Un projet du nom de Pr??sentation de m??moire a ??t?? cr??e par Mgbi	f	57	52	2021-09-19 18:26:26	2021-09-19 18:26:26
3060	T??che nouvellement cr??ee du nom de T??che de test par Mgbi dans le projet Pr??sentation de m??moire.	f	57	53	2021-09-19 18:27:12	2021-09-19 18:27:12
3061	T??che nouvellement cr??ee du nom de T??che de test par Mgbi dans le projet Pr??sentation de m??moire.	f	57	41	2021-09-19 18:27:12	2021-09-19 18:27:12
3062	T??che nouvellement cr??ee du nom de T??che de test par Mgbi dans le projet Pr??sentation de m??moire.	f	57	52	2021-09-19 18:27:12	2021-09-19 18:27:12
3063	T??che nouvellement cr??ee du nom de Second test d'auourd'hui par Mgbi dans le projet Pr??sentation de m??moire.	f	57	53	2021-09-19 18:29:14	2021-09-19 18:29:14
3064	T??che nouvellement cr??ee du nom de Second test d'auourd'hui par Mgbi dans le projet Pr??sentation de m??moire.	f	57	41	2021-09-19 18:29:14	2021-09-19 18:29:14
3065	T??che nouvellement cr??ee du nom de Second test d'auourd'hui par Mgbi dans le projet Pr??sentation de m??moire.	f	57	52	2021-09-19 18:29:14	2021-09-19 18:29:14
3066	T??che nouvellement cr??ee du nom de notif_test par Mgbi dans le projet Un projet.	f	57	53	2021-09-19 18:43:56	2021-09-19 18:43:56
3067	T??che nouvellement cr??ee du nom de notif_test par Mgbi dans le projet Un projet.	f	57	41	2021-09-19 18:43:56	2021-09-19 18:43:56
3068	T??che nouvellement cr??ee du nom de notif_test par Mgbi dans le projet Un projet.	f	57	52	2021-09-19 18:43:56	2021-09-19 18:43:56
3069	Mgbi vous a assign?? ?? la t??che notif_test dans le projet Un projet.	f	57	54	2021-09-19 18:43:56	2021-09-19 18:43:56
3070	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-19 18:45:24	2021-09-19 18:45:24
3071	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-19 18:45:24	2021-09-19 18:45:24
3072	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-19 18:45:24	2021-09-19 18:45:24
3073	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-19 18:45:32	2021-09-19 18:45:32
3074	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-19 18:45:32	2021-09-19 18:45:32
3075	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-19 18:45:32	2021-09-19 18:45:32
3076	T??che nouvellement cr??ee du nom de T??che du mardi par Mgbi dans le projet Pr??sentation de m??moire.	f	57	53	2021-09-21 10:15:41	2021-09-21 10:15:41
3077	T??che nouvellement cr??ee du nom de T??che du mardi par Mgbi dans le projet Pr??sentation de m??moire.	f	57	41	2021-09-21 10:15:41	2021-09-21 10:15:41
3078	T??che nouvellement cr??ee du nom de T??che du mardi par Mgbi dans le projet Pr??sentation de m??moire.	f	57	52	2021-09-21 10:15:41	2021-09-21 10:15:41
3079	Mgbi vous a assign?? ?? la t??che T??che du mardi dans le projet Pr??sentation de m??moire.	f	57	54	2021-09-21 10:15:41	2021-09-21 10:15:41
3080	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 10:16:13	2021-09-21 10:16:13
3081	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 10:16:13	2021-09-21 10:16:13
3082	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 10:16:13	2021-09-21 10:16:13
3083	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 10:16:14	2021-09-21 10:16:14
3084	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 10:16:14	2021-09-21 10:16:14
3085	T??che "T??che de test"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 10:16:14	2021-09-21 10:16:14
3086	T??che nouvellement cr??ee du nom de prim par Mgbi dans le projet sans debut.	f	57	53	2021-09-21 10:41:46	2021-09-21 10:41:46
3087	T??che nouvellement cr??ee du nom de prim par Mgbi dans le projet sans debut.	f	57	41	2021-09-21 10:41:46	2021-09-21 10:41:46
3088	T??che nouvellement cr??ee du nom de prim par Mgbi dans le projet sans debut.	f	57	52	2021-09-21 10:41:46	2021-09-21 10:41:46
3089	Mgbi vous a assign?? ?? la t??che prim dans le projet sans debut.	f	57	56	2021-09-21 10:41:46	2021-09-21 10:41:46
3090	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 10:42:38	2021-09-21 10:42:38
3091	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 10:42:38	2021-09-21 10:42:38
3092	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 10:42:38	2021-09-21 10:42:38
3093	T??che nouvellement cr??ee du nom de prim2 par Mgbi dans le projet sans debut.	f	57	53	2021-09-21 10:42:51	2021-09-21 10:42:51
3094	T??che nouvellement cr??ee du nom de prim2 par Mgbi dans le projet sans debut.	f	57	41	2021-09-21 10:42:51	2021-09-21 10:42:51
3095	T??che nouvellement cr??ee du nom de prim2 par Mgbi dans le projet sans debut.	f	57	52	2021-09-21 10:42:51	2021-09-21 10:42:51
3096	Mgbi vous a assign?? ?? la t??che prim2 dans le projet sans debut.	f	57	56	2021-09-21 10:42:51	2021-09-21 10:42:51
3097	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 10:47:23	2021-09-21 10:47:23
3098	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 10:47:23	2021-09-21 10:47:23
3099	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 10:47:23	2021-09-21 10:47:23
3100	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 10:47:38	2021-09-21 10:47:38
3101	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 10:47:38	2021-09-21 10:47:38
3102	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 10:47:38	2021-09-21 10:47:38
3103	T??che nouvellement cr??ee du nom de prim3 par Mgbi dans le projet sans debut.	f	57	53	2021-09-21 10:48:10	2021-09-21 10:48:10
3104	T??che nouvellement cr??ee du nom de prim3 par Mgbi dans le projet sans debut.	f	57	41	2021-09-21 10:48:10	2021-09-21 10:48:10
3105	T??che nouvellement cr??ee du nom de prim3 par Mgbi dans le projet sans debut.	f	57	52	2021-09-21 10:48:10	2021-09-21 10:48:10
3106	Mgbi vous a assign?? ?? la t??che prim3 dans le projet sans debut.	f	57	56	2021-09-21 10:48:10	2021-09-21 10:48:10
3107	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 15:54:30	2021-09-21 15:54:30
3108	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 15:54:30	2021-09-21 15:54:30
3109	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 15:54:30	2021-09-21 15:54:30
3110	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 15:54:34	2021-09-21 15:54:34
3111	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 15:54:34	2021-09-21 15:54:34
3112	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 15:54:34	2021-09-21 15:54:34
3113	T??che nouvellement cr??ee du nom de prim4 par Mgbi dans le projet sans debut.	f	57	53	2021-09-21 15:55:16	2021-09-21 15:55:16
3114	T??che nouvellement cr??ee du nom de prim4 par Mgbi dans le projet sans debut.	f	57	41	2021-09-21 15:55:16	2021-09-21 15:55:16
3115	T??che nouvellement cr??ee du nom de prim4 par Mgbi dans le projet sans debut.	f	57	52	2021-09-21 15:55:16	2021-09-21 15:55:16
3116	Mgbi vous a assign?? ?? la t??che prim4 dans le projet sans debut.	f	57	56	2021-09-21 15:55:16	2021-09-21 15:55:16
3117	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 16:07:12	2021-09-21 16:07:12
3118	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 16:07:12	2021-09-21 16:07:12
3119	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 16:07:12	2021-09-21 16:07:12
3120	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 16:07:15	2021-09-21 16:07:15
3121	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 16:07:15	2021-09-21 16:07:15
3122	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 16:07:15	2021-09-21 16:07:15
3123	T??che nouvellement cr??ee du nom de prim5 par Mgbi dans le projet sans debut.	f	57	53	2021-09-21 16:09:01	2021-09-21 16:09:01
3124	T??che nouvellement cr??ee du nom de prim5 par Mgbi dans le projet sans debut.	f	57	41	2021-09-21 16:09:01	2021-09-21 16:09:01
3125	T??che nouvellement cr??ee du nom de prim5 par Mgbi dans le projet sans debut.	f	57	52	2021-09-21 16:09:01	2021-09-21 16:09:01
3126	Mgbi vous a assign?? ?? la t??che prim5 dans le projet sans debut.	f	57	56	2021-09-21 16:09:01	2021-09-21 16:09:01
3127	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 16:25:40	2021-09-21 16:25:40
3128	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 16:25:40	2021-09-21 16:25:40
3129	T??che "prim"\n          du projet sans debut mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 16:25:40	2021-09-21 16:25:40
3130	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 16:25:41	2021-09-21 16:25:41
3131	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 16:25:41	2021-09-21 16:25:41
3132	T??che "prim"\n          du projet sans debut mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 16:25:41	2021-09-21 16:25:41
3133	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 16:27:37	2021-09-21 16:27:37
3134	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 16:27:37	2021-09-21 16:27:37
3135	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 16:27:37	2021-09-21 16:27:37
3136	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 16:28:15	2021-09-21 16:28:15
3137	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 16:28:15	2021-09-21 16:28:15
3138	Le projet "sans debut modifi??" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 16:28:15	2021-09-21 16:28:15
3139	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 16:58:03	2021-09-21 16:58:03
3140	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 16:58:03	2021-09-21 16:58:03
3141	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 16:58:03	2021-09-21 16:58:03
3142	T??che "prim2"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 17:12:58	2021-09-21 17:12:58
3143	T??che "prim2"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 17:12:58	2021-09-21 17:12:58
3144	T??che "prim2"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 17:12:58	2021-09-21 17:12:58
3145	T??che "prim2"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 17:13:07	2021-09-21 17:13:07
3146	T??che "prim2"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 17:13:07	2021-09-21 17:13:07
3147	T??che "prim2"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 17:13:07	2021-09-21 17:13:07
3148	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 17:13:58	2021-09-21 17:13:58
3149	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 17:13:58	2021-09-21 17:13:58
3150	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 17:13:58	2021-09-21 17:13:58
3151	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 17:26:31	2021-09-21 17:26:31
3152	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 17:26:31	2021-09-21 17:26:31
3153	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 17:26:31	2021-09-21 17:26:31
3154	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 17:27:03	2021-09-21 17:27:03
3155	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 17:27:03	2021-09-21 17:27:03
3156	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 17:27:03	2021-09-21 17:27:03
3157	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 17:27:40	2021-09-21 17:27:40
3158	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 17:27:40	2021-09-21 17:27:40
3159	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 17:27:40	2021-09-21 17:27:40
3160	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-21 17:49:00	2021-09-21 17:49:00
3161	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-21 17:49:00	2021-09-21 17:49:00
3162	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-21 17:49:00	2021-09-21 17:49:00
3166	Mgbi vous a assign?? ?? la t??che Nouvelle t??che pour aujou'd'hui dans le projet sans debut modifi??.	f	57	56	2021-09-21 17:50:13	2021-09-21 17:50:13
3163	T??che nouvellement cr??ee du nom de Nouvelle t??che pour aujou'd'hui par Mgbi dans le projet sans debut modifi??.	f	57	53	2021-09-21 17:50:13	2021-09-21 17:50:13
3164	T??che nouvellement cr??ee du nom de Nouvelle t??che pour aujou'd'hui par Mgbi dans le projet sans debut modifi??.	f	57	41	2021-09-21 17:50:13	2021-09-21 17:50:13
3165	T??che nouvellement cr??ee du nom de Nouvelle t??che pour aujou'd'hui par Mgbi dans le projet sans debut modifi??.	f	57	52	2021-09-21 17:50:13	2021-09-21 17:50:13
3170	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 17:51:27	2021-09-21 17:51:27
3171	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 17:51:27	2021-09-21 17:51:27
3172	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 17:51:27	2021-09-21 17:51:27
3167	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 17:51:22	2021-09-21 17:51:22
3168	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 17:51:22	2021-09-21 17:51:22
3169	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 17:51:22	2021-09-21 17:51:22
3173	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	53	2021-09-21 17:51:43	2021-09-21 17:51:43
3174	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	41	2021-09-21 17:51:43	2021-09-21 17:51:43
3175	T??che "prim"\n          du projet sans debut modifi?? mise dans " En contr??le " par Mgbi	f	57	52	2021-09-21 17:51:43	2021-09-21 17:51:43
3176	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-21 17:51:47	2021-09-21 17:51:47
3177	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-21 17:51:47	2021-09-21 17:51:47
3178	T??che "prim"\n          du projet sans debut modifi?? mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-21 17:51:47	2021-09-21 17:51:47
3179	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-22 08:04:31	2021-09-22 08:04:31
3180	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-22 08:04:31	2021-09-22 08:04:31
3181	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-22 08:04:31	2021-09-22 08:04:31
3182	T??che nouvellement cr??ee du nom de ationt??che de pr??-d??monstr par Mgbi dans le projet Pr??sentation de m??moire.	f	57	53	2021-09-22 08:25:28	2021-09-22 08:25:28
3183	T??che nouvellement cr??ee du nom de ationt??che de pr??-d??monstr par Mgbi dans le projet Pr??sentation de m??moire.	f	57	41	2021-09-22 08:25:28	2021-09-22 08:25:28
3184	T??che nouvellement cr??ee du nom de ationt??che de pr??-d??monstr par Mgbi dans le projet Pr??sentation de m??moire.	f	57	52	2021-09-22 08:25:28	2021-09-22 08:25:28
3185	Mgbi vous a assign?? ?? la t??che ationt??che de pr??-d??monstr dans le projet Pr??sentation de m??moire.	f	57	54	2021-09-22 08:25:28	2021-09-22 08:25:28
3186	T??che "T??che du mardi"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-22 08:29:23	2021-09-22 08:29:23
3187	T??che "T??che du mardi"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-22 08:29:23	2021-09-22 08:29:23
3188	T??che "T??che du mardi"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-22 08:29:23	2021-09-22 08:29:23
3189	T??che nouvellement cr??ee du nom de T??che pour faire la d??monstration par Mgbi dans le projet Pr??sentation de m??moire.	f	57	53	2021-09-22 09:19:29	2021-09-22 09:19:29
3190	T??che nouvellement cr??ee du nom de T??che pour faire la d??monstration par Mgbi dans le projet Pr??sentation de m??moire.	f	57	41	2021-09-22 09:19:29	2021-09-22 09:19:29
3191	T??che nouvellement cr??ee du nom de T??che pour faire la d??monstration par Mgbi dans le projet Pr??sentation de m??moire.	f	57	52	2021-09-22 09:19:29	2021-09-22 09:19:29
3192	Mgbi vous a assign?? ?? la t??che T??che pour faire la d??monstration dans le projet Pr??sentation de m??moire.	f	57	54	2021-09-22 09:19:29	2021-09-22 09:19:29
3193	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En blocage " par Mgbi1	f	54	53	2021-09-22 09:22:02	2021-09-22 09:22:02
3194	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En blocage " par Mgbi1	f	54	41	2021-09-22 09:22:02	2021-09-22 09:22:02
3195	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En blocage " par Mgbi1	f	54	52	2021-09-22 09:22:02	2021-09-22 09:22:02
3196	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En blocage " par Mgbi1	f	54	57	2021-09-22 09:22:02	2021-09-22 09:22:02
3197	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-22 09:22:24	2021-09-22 09:22:24
3198	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-22 09:22:24	2021-09-22 09:22:24
3199	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-22 09:22:24	2021-09-22 09:22:24
3200	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-24 07:10:05	2021-09-24 07:10:05
3201	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-24 07:10:05	2021-09-24 07:10:05
3202	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-24 07:10:05	2021-09-24 07:10:05
3203	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-24 07:10:08	2021-09-24 07:10:08
3204	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-24 07:10:08	2021-09-24 07:10:08
3205	T??che "T??che pour faire la d??monstration"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-24 07:10:08	2021-09-24 07:10:08
3206	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-24 07:10:13	2021-09-24 07:10:13
3207	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-24 07:10:13	2021-09-24 07:10:13
3208	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-24 07:10:13	2021-09-24 07:10:13
3209	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	53	2021-09-24 07:10:15	2021-09-24 07:10:15
3210	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	41	2021-09-24 07:10:15	2021-09-24 07:10:15
3211	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " Achev??e(s) " par Mgbi	f	57	52	2021-09-24 07:10:15	2021-09-24 07:10:15
3212	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-24 07:10:20	2021-09-24 07:10:20
3213	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-24 07:10:20	2021-09-24 07:10:20
3214	T??che "Second test d'aujourd'hui"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-24 07:10:20	2021-09-24 07:10:20
3215	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-24 07:10:23	2021-09-24 07:10:23
3216	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-24 07:10:23	2021-09-24 07:10:23
3217	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-24 07:10:23	2021-09-24 07:10:23
3218	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	53	2021-09-27 07:36:42	2021-09-27 07:36:42
3219	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	41	2021-09-27 07:36:42	2021-09-27 07:36:42
3220	Le projet "Pr??sentation de m??moire" a ??t?? mise ?? jour par Mgbi	f	57	52	2021-09-27 07:36:42	2021-09-27 07:36:42
3221	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En cours " par Mgbi	f	57	53	2021-09-28 06:36:41	2021-09-28 06:36:41
3222	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En cours " par Mgbi	f	57	41	2021-09-28 06:36:41	2021-09-28 06:36:41
3223	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En cours " par Mgbi	f	57	52	2021-09-28 06:36:41	2021-09-28 06:36:41
3224	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	53	2021-09-28 06:36:43	2021-09-28 06:36:43
3225	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	41	2021-09-28 06:36:43	2021-09-28 06:36:43
3226	T??che "ationt??che de pr??-d??monstr"\n          du projet Pr??sentation de m??moire mise dans " En contr??le " par Mgbi	f	57	52	2021-09-28 06:36:43	2021-09-28 06:36:43
3227	Un projet du nom de Planification de t??ches a ??t?? cr??e par Mgbi	f	57	53	2021-10-01 09:07:54	2021-10-01 09:07:54
3228	Un projet du nom de Planification de t??ches a ??t?? cr??e par Mgbi	f	57	41	2021-10-01 09:07:54	2021-10-01 09:07:54
3229	Un projet du nom de Planification de t??ches a ??t?? cr??e par Mgbi	f	57	52	2021-10-01 09:07:54	2021-10-01 09:07:54
3230	T??che nouvellement cr??ee du nom de T??chee par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 08:00:01	2021-10-08 08:00:01
3231	T??che nouvellement cr??ee du nom de T??chee par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 08:00:01	2021-10-08 08:00:01
3232	T??che nouvellement cr??ee du nom de T??chee par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 08:00:01	2021-10-08 08:00:01
3233	T??che nouvellement cr??ee du nom de Non planifi??e par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 08:39:49	2021-10-08 08:39:49
3234	T??che nouvellement cr??ee du nom de Non planifi??e par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 08:39:49	2021-10-08 08:39:49
3235	T??che nouvellement cr??ee du nom de Non planifi??e par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 08:39:49	2021-10-08 08:39:49
3236	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3237	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3238	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3239	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3240	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3241	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3242	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3243	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3244	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3245	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3246	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3247	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3248	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3249	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3250	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3251	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:00	2021-10-08 09:00:00
3252	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:00	2021-10-08 09:00:00
3253	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:00	2021-10-08 09:00:00
3254	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 09:00:01	2021-10-08 09:00:01
3255	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 09:00:01	2021-10-08 09:00:01
3256	T??che nouvellement cr??ee du nom de T??che planifi??e 2 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 09:00:01	2021-10-08 09:00:01
3257	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 12:30:00	2021-10-08 12:30:00
3258	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 12:30:00	2021-10-08 12:30:00
3259	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 12:30:00	2021-10-08 12:30:00
3260	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 12:30:00	2021-10-08 12:30:00
3261	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 12:30:00	2021-10-08 12:30:00
3262	T??che nouvellement cr??ee du nom de Plan Test par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 12:30:00	2021-10-08 12:30:00
3263	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 13:35:00	2021-10-08 13:35:00
3264	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 13:35:00	2021-10-08 13:35:00
3265	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 13:35:00	2021-10-08 13:35:00
3266	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-08 13:35:01	2021-10-08 13:35:01
3267	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-08 13:35:01	2021-10-08 13:35:01
3268	T??che nouvellement cr??ee du nom de T??che du 16:35 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-08 13:35:01	2021-10-08 13:35:01
3269	T??che "T??chee"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:15:16	2021-10-09 06:15:16
3270	T??che "T??chee"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:15:16	2021-10-09 06:15:16
3271	T??che "T??chee"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:15:16	2021-10-09 06:15:16
3272	T??che "Non planifi??e"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:15:17	2021-10-09 06:15:17
3273	T??che "Non planifi??e"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:15:17	2021-10-09 06:15:17
3274	T??che "Non planifi??e"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:15:17	2021-10-09 06:15:17
3275	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:15:18	2021-10-09 06:15:18
3276	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:15:18	2021-10-09 06:15:18
3277	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:15:18	2021-10-09 06:15:18
3278	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:15:19	2021-10-09 06:15:19
3279	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:15:19	2021-10-09 06:15:19
3280	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:15:19	2021-10-09 06:15:19
3281	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:15:20	2021-10-09 06:15:20
3282	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:15:20	2021-10-09 06:15:20
3283	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:15:20	2021-10-09 06:15:20
3284	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:15:21	2021-10-09 06:15:21
3285	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:15:21	2021-10-09 06:15:21
3286	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:15:21	2021-10-09 06:15:21
3287	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:15:23	2021-10-09 06:15:23
3288	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:15:23	2021-10-09 06:15:23
3289	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:15:23	2021-10-09 06:15:23
3290	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:15:24	2021-10-09 06:15:24
3291	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:15:24	2021-10-09 06:15:24
3292	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:15:24	2021-10-09 06:15:24
3293	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:15:25	2021-10-09 06:15:25
3294	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:15:25	2021-10-09 06:15:25
3295	T??che "T??che planifi??e 2"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:15:25	2021-10-09 06:15:25
3296	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:15:27	2021-10-09 06:15:27
3297	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:15:27	2021-10-09 06:15:27
3298	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:15:27	2021-10-09 06:15:27
3299	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:15:28	2021-10-09 06:15:28
3300	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:15:28	2021-10-09 06:15:28
3301	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:15:28	2021-10-09 06:15:28
3302	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:15:28	2021-10-09 06:15:28
3303	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:15:28	2021-10-09 06:15:28
3304	T??che "T??che du 16:35"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:15:28	2021-10-09 06:15:28
3305	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:15:30	2021-10-09 06:15:30
3306	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:15:30	2021-10-09 06:15:30
3307	T??che "Plan Test"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:15:30	2021-10-09 06:15:30
3308	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3309	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3310	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3311	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3312	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3313	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3314	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3315	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3316	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3323	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3324	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3325	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3350	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:12	2021-10-09 06:30:12
3351	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:12	2021-10-09 06:30:12
3352	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:12	2021-10-09 06:30:12
3359	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:14	2021-10-09 06:30:14
3360	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:14	2021-10-09 06:30:14
3361	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:14	2021-10-09 06:30:14
3365	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:33:01	2021-10-09 06:33:01
3366	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:33:01	2021-10-09 06:33:01
3367	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:33:01	2021-10-09 06:33:01
3317	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3318	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3319	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3320	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3321	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3322	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3347	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:30:12	2021-10-09 06:30:12
3348	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:30:12	2021-10-09 06:30:12
3349	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:30:12	2021-10-09 06:30:12
3356	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:13	2021-10-09 06:30:13
3357	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:13	2021-10-09 06:30:13
3358	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:13	2021-10-09 06:30:13
3362	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:33:00	2021-10-09 06:33:00
3363	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:33:00	2021-10-09 06:33:00
3364	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:33:00	2021-10-09 06:33:00
3326	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3327	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3328	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3329	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:00	2021-10-09 06:20:00
3330	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:00	2021-10-09 06:20:00
3331	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:00	2021-10-09 06:20:00
3344	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:11	2021-10-09 06:30:11
3345	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:11	2021-10-09 06:30:11
3346	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:11	2021-10-09 06:30:11
3332	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 06:20:01	2021-10-09 06:20:01
3333	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 06:20:01	2021-10-09 06:20:01
3334	T??che nouvellement cr??ee du nom de Samedi 9:20 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 06:20:01	2021-10-09 06:20:01
3341	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	53	2021-10-09 06:30:11	2021-10-09 06:30:11
3342	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	41	2021-10-09 06:30:11	2021-10-09 06:30:11
3343	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En contr??le " par Mgbi	f	57	52	2021-10-09 06:30:11	2021-10-09 06:30:11
3335	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:08	2021-10-09 06:30:08
3336	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:08	2021-10-09 06:30:08
3337	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:08	2021-10-09 06:30:08
3338	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 06:30:09	2021-10-09 06:30:09
3339	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 06:30:09	2021-10-09 06:30:09
3340	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 06:30:09	2021-10-09 06:30:09
3353	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 06:30:13	2021-10-09 06:30:13
3354	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 06:30:13	2021-10-09 06:30:13
3355	T??che "Samedi 9:20"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 06:30:13	2021-10-09 06:30:13
3368	T??che "9:33"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	53	2021-10-09 07:11:03	2021-10-09 07:11:03
3369	T??che "9:33"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	41	2021-10-09 07:11:03	2021-10-09 07:11:03
3370	T??che "9:33"\n          du projet Planification de t??ches mise dans " En blocage " par Mgbi	f	57	52	2021-10-09 07:11:03	2021-10-09 07:11:03
3371	T??che "9:33"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	53	2021-10-09 07:11:03	2021-10-09 07:11:03
3372	T??che "9:33"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	41	2021-10-09 07:11:03	2021-10-09 07:11:03
3373	T??che "9:33"\n          du projet Planification de t??ches mise dans " En cours " par Mgbi	f	57	52	2021-10-09 07:11:03	2021-10-09 07:11:03
3374	T??che nouvellement cr??ee du nom de 10:13 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 07:13:00	2021-10-09 07:13:00
3375	T??che nouvellement cr??ee du nom de 10:13 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 07:13:00	2021-10-09 07:13:00
3376	T??che nouvellement cr??ee du nom de 10:13 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 07:13:00	2021-10-09 07:13:00
3377	T??che nouvellement cr??ee du nom de T??che planifi??e 1 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 09:00:00	2021-10-09 09:00:00
3378	T??che nouvellement cr??ee du nom de T??che planifi??e 1 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 09:00:00	2021-10-09 09:00:00
3379	T??che nouvellement cr??ee du nom de T??che planifi??e 1 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 09:00:00	2021-10-09 09:00:00
3380	T??che nouvellement cr??ee du nom de T??che planifi??e 3 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-09 09:00:00	2021-10-09 09:00:00
3381	T??che nouvellement cr??ee du nom de T??che planifi??e 3 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-09 09:00:00	2021-10-09 09:00:00
3382	T??che nouvellement cr??ee du nom de T??che planifi??e 3 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-09 09:00:00	2021-10-09 09:00:00
3383	T??che nouvellement cr??ee du nom de 13:03 par Admin dans le projet Planification de t??ches.	f	52	53	2021-10-09 10:03:00	2021-10-09 10:03:00
3384	T??che nouvellement cr??ee du nom de 13:03 par Admin dans le projet Planification de t??ches.	f	52	41	2021-10-09 10:03:00	2021-10-09 10:03:00
3385	T??che nouvellement cr??ee du nom de 13:03 par Admin dans le projet Planification de t??ches.	f	52	57	2021-10-09 10:03:00	2021-10-09 10:03:00
3386	T??che nouvellement cr??ee du nom de 13:05 par Admin dans le projet Planification de t??ches.	f	52	53	2021-10-09 10:05:01	2021-10-09 10:05:01
3387	T??che nouvellement cr??ee du nom de 13:05 par Admin dans le projet Planification de t??ches.	f	52	41	2021-10-09 10:05:01	2021-10-09 10:05:01
3388	T??che nouvellement cr??ee du nom de 13:05 par Admin dans le projet Planification de t??ches.	f	52	57	2021-10-09 10:05:01	2021-10-09 10:05:01
3389	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	53	2021-10-11 06:33:01	2021-10-11 06:33:01
3390	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	41	2021-10-11 06:33:01	2021-10-11 06:33:01
3391	T??che nouvellement cr??ee du nom de 9:33 par Mgbi dans le projet Planification de t??ches.	f	57	52	2021-10-11 06:33:01	2021-10-11 06:33:01
\.


--
-- Data for Name: planified; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planified (id, description, dt_start, period, inserted_at, updated_at, attributor_id, contributor_id, project_id, estimated_duration, without_control) FROM stdin;
4	T??che planifi??e 1	2010-10-02 12:00:00	5	2021-10-01 11:26:30	2021-10-01 11:26:30	57	\N	24	5	f
5	T??che planifi??e 2	2010-10-03 12:00:00	3	2021-10-01 11:30:13	2021-10-01 11:30:13	57	\N	24	6	f
6	T??che planifi??e 3	2010-10-05 12:00:00	2	2021-10-01 11:34:23	2021-10-01 11:34:23	57	\N	24	2	f
8	T??chee	2021-10-08 11:00:00	2	2021-10-07 08:13:07	2021-10-07 08:13:07	57	\N	24	5	f
10	Plan Test	2021-10-08 15:30:00	1	2021-10-08 12:01:47	2021-10-08 12:01:47	57	\N	24	2	f
11	T??che du 16:35	2021-10-08 16:35:00	1	2021-10-08 13:31:39	2021-10-08 13:31:39	57	\N	24	5	f
12	Samedi 9:20	2021-10-09 09:20:00	1	2021-10-09 06:18:02	2021-10-09 06:18:02	57	\N	24	2	f
13	9:33	2021-10-09 09:33:00	1	2021-10-09 06:31:57	2021-10-09 06:31:57	57	\N	24	1	f
15	13:03	2021-10-09 13:03:00	1	2021-10-09 10:00:21	2021-10-09 10:00:21	52	\N	24	2	f
17	Hebdo	2021-10-09 15:20:00	7	2021-10-09 12:16:57	2021-10-09 12:16:57	52	\N	24	2	f
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
20	blocage test	test	100	2021-08-27	\N	10	0	2021-08-31	14	1	2021-08-27 07:07:36	2021-08-27 07:12:50	18
21	second blocage	second	0	2021-08-30	\N	50	0	2021-09-05	11	1	2021-08-30 10:36:39	2021-08-30 10:36:39	19
17	projet test	projet test	0	2021-07-05	2021-07-10	5	0	2021-07-10	1	1	2021-07-05 07:47:20	2021-09-01 06:26:30	13
24	Planification de t??ches	planificateur de  t??ches	0	2021-10-01	\N	100	0	2021-10-12	1	1	2021-10-01 09:07:54	2021-10-11 06:33:01	29
22	sans debut modifi??	sans modification	16	2021-08-31	\N	20	0	2021-09-01	1	1	2021-08-31 06:47:54	2021-09-21 17:51:47	27
15	mon_projet	projet test pour afficher flash	0	2021-05-03	2021-05-03	24	0	2021-05-04	1	1	2021-05-03 09:59:21	2021-06-13 19:52:26	10
16	Site E-commerce	D??veloppement d'un site e-commerce	50	2021-06-08	2021-06-11	36	0	2021-06-15	1	1	2021-06-08 16:39:46	2021-09-19 18:18:10	11
18	Un projet	ce projet est destin?? ?? ??tre affich?? lors d'une pr??sentation 	55	2021-08-10	2021-08-21	10	0	2021-08-21	1	1	2021-08-10 11:48:57	2021-09-19 18:43:56	15
19	test date finale	zozozoz	0	2021-08-17	\N	30	0	2021-08-21	1	1	2021-08-17 08:44:11	2021-08-17 08:44:11	17
14	Premier test	Kanbans test	30	2021-04-28	2021-05-01	48	0	2021-04-30	1	1	2021-04-28 13:17:31	2021-08-18 08:22:49	9
23	Pr??sentation de m??moire	Bien pr??senter son m??moire	60	2021-09-19	\N	24	0	2021-09-24	1	1	2021-09-19 18:26:26	2021-09-27 07:36:42	28
\.


--
-- Data for Name: rights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rights (id, title, inserted_at, updated_at) FROM stdin;
1	Admin	2021-03-24 07:25:41	2021-03-24 07:25:41
3	Contributeur	2021-03-28 20:23:20	2021-03-28 20:23:20
2	Attributeur	2021-04-13 07:55:29	2021-04-13 07:55:29
4	Client	2021-03-28 17:28:09	2021-03-28 17:28:09
5	Non attribu??	2021-04-01 20:21:54	2021-04-01 20:21:54
100	Archiv??(e)	2021-04-13 08:24:10	2021-04-13 08:24:10
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
20210514105447	2021-05-14 10:56:17
20210518110212	2021-05-18 11:04:23
20210527155705	2021-05-27 16:12:41
20210602180040	2021-06-02 18:03:01
20210602183517	2021-06-02 18:35:57
20210602190601	2021-06-02 19:06:19
20210602213717	2021-06-02 21:37:34
20210603161444	2021-06-03 16:17:57
20210603162215	2021-06-03 16:24:08
20210607111124	2021-06-07 11:16:10
20210608201833	2021-06-08 20:19:53
20210616083854	2021-06-16 08:40:13
20210831074824	2021-08-31 07:48:46
20210930165500	2021-09-30 16:55:29
20211001070528	2021-10-01 08:10:54
\.


--
-- Data for Name: softwares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.softwares (id, title, company_id, inserted_at, updated_at) FROM stdin;
1	LOG+SOC	1	2021-06-02 21:41:47	2021-06-02 21:41:47
\.


--
-- Data for Name: stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stages (id, name, board_id, status_id, "position", inserted_at, updated_at) FROM stdin;
36	A faire	9	1	0	2021-04-28 13:17:31	2021-04-28 13:17:31
37	En attente	9	2	1	2021-04-28 13:17:31	2021-04-28 13:17:31
38	En cours	9	3	2	2021-04-28 13:17:31	2021-04-28 13:17:31
39	En contr??le	9	4	3	2021-04-28 13:17:31	2021-04-28 13:17:31
40	Achev??e(s)	9	5	4	2021-04-28 13:17:31	2021-04-28 13:17:31
41	A faire	10	1	0	2021-05-03 09:59:21	2021-05-03 09:59:21
42	En attente	10	2	1	2021-05-03 09:59:21	2021-05-03 09:59:21
43	En cours	10	3	2	2021-05-03 09:59:21	2021-05-03 09:59:21
44	En contr??le	10	4	3	2021-05-03 09:59:21	2021-05-03 09:59:21
45	Achev??e(s)	10	5	4	2021-05-03 09:59:21	2021-05-03 09:59:21
46	A faire	11	1	0	2021-06-08 16:39:46	2021-06-08 16:39:46
47	En attente	11	2	1	2021-06-08 16:39:46	2021-06-08 16:39:46
48	En cours	11	3	2	2021-06-08 16:39:46	2021-06-08 16:39:46
49	En contr??le	11	4	3	2021-06-08 16:39:46	2021-06-08 16:39:46
50	Achev??e(s)	11	5	4	2021-06-08 16:39:46	2021-06-08 16:39:46
51	A faire	12	1	0	2021-07-05 07:45:57	2021-07-05 07:45:57
52	En attente	12	2	1	2021-07-05 07:45:57	2021-07-05 07:45:57
53	En cours	12	3	2	2021-07-05 07:45:57	2021-07-05 07:45:57
54	En contr??le	12	4	3	2021-07-05 07:45:58	2021-07-05 07:45:58
55	Achev??e(s)	12	5	4	2021-07-05 07:45:58	2021-07-05 07:45:58
56	A faire	13	1	0	2021-07-05 07:47:20	2021-07-05 07:47:20
57	En attente	13	2	1	2021-07-05 07:47:20	2021-07-05 07:47:20
58	En cours	13	3	2	2021-07-05 07:47:20	2021-07-05 07:47:20
59	En contr??le	13	4	3	2021-07-05 07:47:20	2021-07-05 07:47:20
60	Achev??e(s)	13	5	4	2021-07-05 07:47:20	2021-07-05 07:47:20
61	A faire	14	1	0	2021-08-10 11:48:23	2021-08-10 11:48:23
62	En attente	14	2	1	2021-08-10 11:48:23	2021-08-10 11:48:23
63	En cours	14	3	2	2021-08-10 11:48:23	2021-08-10 11:48:23
64	En contr??le	14	4	3	2021-08-10 11:48:23	2021-08-10 11:48:23
65	Achev??e(s)	14	5	4	2021-08-10 11:48:23	2021-08-10 11:48:23
66	A faire	15	1	0	2021-08-10 11:48:56	2021-08-10 11:48:56
67	En attente	15	2	1	2021-08-10 11:48:56	2021-08-10 11:48:56
68	En cours	15	3	2	2021-08-10 11:48:56	2021-08-10 11:48:56
69	En contr??le	15	4	3	2021-08-10 11:48:57	2021-08-10 11:48:57
70	Achev??e(s)	15	5	4	2021-08-10 11:48:57	2021-08-10 11:48:57
71	A faire	16	1	0	2021-08-17 08:41:53	2021-08-17 08:41:53
72	En attente	16	2	1	2021-08-17 08:41:54	2021-08-17 08:41:54
73	En cours	16	3	2	2021-08-17 08:41:54	2021-08-17 08:41:54
74	En contr??le	16	4	3	2021-08-17 08:41:54	2021-08-17 08:41:54
75	Achev??e(s)	16	5	4	2021-08-17 08:41:54	2021-08-17 08:41:54
76	A faire	17	1	0	2021-08-17 08:44:11	2021-08-17 08:44:11
77	En attente	17	2	1	2021-08-17 08:44:11	2021-08-17 08:44:11
78	En cours	17	3	2	2021-08-17 08:44:11	2021-08-17 08:44:11
79	En contr??le	17	4	3	2021-08-17 08:44:11	2021-08-17 08:44:11
80	Achev??e(s)	17	5	4	2021-08-17 08:44:11	2021-08-17 08:44:11
81	A faire	18	1	0	2021-08-27 07:07:36	2021-08-27 07:07:36
83	En contr??le	18	4	3	2021-08-27 07:07:36	2021-08-27 07:07:36
84	Achev??e(s)	18	5	4	2021-08-27 07:07:36	2021-08-27 07:07:36
82	En cours	18	3	2	2021-08-27 07:07:36	2021-08-27 07:07:36
85	En blocage	18	2	1	2021-08-27 07:07:36	2021-08-27 07:07:36
86	A faire	19	1	0	2021-08-30 10:36:39	2021-08-30 10:36:39
87	En blocage	19	2	1	2021-08-30 10:36:39	2021-08-30 10:36:39
88	En cours	19	3	2	2021-08-30 10:36:39	2021-08-30 10:36:39
89	En contr??le	19	4	3	2021-08-30 10:36:39	2021-08-30 10:36:39
90	Achev??e(s)	19	5	4	2021-08-30 10:36:39	2021-08-30 10:36:39
91	A faire	20	1	0	2021-08-31 06:34:53	2021-08-31 06:34:53
92	En blocage	20	2	1	2021-08-31 06:34:53	2021-08-31 06:34:53
93	En cours	20	3	2	2021-08-31 06:34:53	2021-08-31 06:34:53
94	En contr??le	20	4	3	2021-08-31 06:34:53	2021-08-31 06:34:53
95	Achev??e(s)	20	5	4	2021-08-31 06:34:53	2021-08-31 06:34:53
96	A faire	21	1	0	2021-08-31 06:34:58	2021-08-31 06:34:58
97	En blocage	21	2	1	2021-08-31 06:34:58	2021-08-31 06:34:58
98	En cours	21	3	2	2021-08-31 06:34:58	2021-08-31 06:34:58
99	En contr??le	21	4	3	2021-08-31 06:34:58	2021-08-31 06:34:58
100	Achev??e(s)	21	5	4	2021-08-31 06:34:59	2021-08-31 06:34:59
101	A faire	22	1	0	2021-08-31 06:35:15	2021-08-31 06:35:15
102	En blocage	22	2	1	2021-08-31 06:35:15	2021-08-31 06:35:15
103	En cours	22	3	2	2021-08-31 06:35:15	2021-08-31 06:35:15
104	En contr??le	22	4	3	2021-08-31 06:35:15	2021-08-31 06:35:15
105	Achev??e(s)	22	5	4	2021-08-31 06:35:15	2021-08-31 06:35:15
106	A faire	23	1	0	2021-08-31 06:36:09	2021-08-31 06:36:09
107	En blocage	23	2	1	2021-08-31 06:36:09	2021-08-31 06:36:09
108	En cours	23	3	2	2021-08-31 06:36:09	2021-08-31 06:36:09
109	En contr??le	23	4	3	2021-08-31 06:36:09	2021-08-31 06:36:09
110	Achev??e(s)	23	5	4	2021-08-31 06:36:09	2021-08-31 06:36:09
111	A faire	24	1	0	2021-08-31 06:39:27	2021-08-31 06:39:27
112	En blocage	24	2	1	2021-08-31 06:39:27	2021-08-31 06:39:27
113	En cours	24	3	2	2021-08-31 06:39:27	2021-08-31 06:39:27
114	En contr??le	24	4	3	2021-08-31 06:39:27	2021-08-31 06:39:27
115	Achev??e(s)	24	5	4	2021-08-31 06:39:27	2021-08-31 06:39:27
116	A faire	25	1	0	2021-08-31 06:44:08	2021-08-31 06:44:08
117	En blocage	25	2	1	2021-08-31 06:44:08	2021-08-31 06:44:08
118	En cours	25	3	2	2021-08-31 06:44:08	2021-08-31 06:44:08
119	En contr??le	25	4	3	2021-08-31 06:44:08	2021-08-31 06:44:08
120	Achev??e(s)	25	5	4	2021-08-31 06:44:08	2021-08-31 06:44:08
121	A faire	26	1	0	2021-08-31 06:47:27	2021-08-31 06:47:27
122	En blocage	26	2	1	2021-08-31 06:47:27	2021-08-31 06:47:27
123	En cours	26	3	2	2021-08-31 06:47:27	2021-08-31 06:47:27
124	En contr??le	26	4	3	2021-08-31 06:47:27	2021-08-31 06:47:27
127	En blocage	27	2	1	2021-08-31 06:47:54	2021-08-31 06:47:54
125	Achev??e(s)	26	5	4	2021-08-31 06:47:27	2021-08-31 06:47:27
129	En contr??le	27	4	3	2021-08-31 06:47:54	2021-08-31 06:47:54
126	A faire	27	1	0	2021-08-31 06:47:54	2021-08-31 06:47:54
128	En cours	27	3	2	2021-08-31 06:47:54	2021-08-31 06:47:54
130	Achev??e(s)	27	5	4	2021-08-31 06:47:54	2021-08-31 06:47:54
131	A faire	28	1	0	2021-09-19 18:26:26	2021-09-19 18:26:26
132	En blocage	28	2	1	2021-09-19 18:26:26	2021-09-19 18:26:26
133	En cours	28	3	2	2021-09-19 18:26:26	2021-09-19 18:26:26
134	En contr??le	28	4	3	2021-09-19 18:26:26	2021-09-19 18:26:26
135	Achev??e(s)	28	5	4	2021-09-19 18:26:26	2021-09-19 18:26:26
136	A faire	29	1	0	2021-10-01 09:07:53	2021-10-01 09:07:53
137	En blocage	29	2	1	2021-10-01 09:07:54	2021-10-01 09:07:54
138	En cours	29	3	2	2021-10-01 09:07:54	2021-10-01 09:07:54
139	En contr??le	29	4	3	2021-10-01 09:07:54	2021-10-01 09:07:54
140	Achev??e(s)	29	5	4	2021-10-01 09:07:54	2021-10-01 09:07:54
\.


--
-- Data for Name: statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statuses (id, title, inserted_at, updated_at) FROM stdin;
1	A faire	2021-04-27 18:47:25	2021-04-27 18:47:25
3	En cours	2021-04-27 18:47:50	2021-04-27 18:47:50
4	En contr??le	2021-04-27 18:48:15	2021-04-27 18:48:15
5	Achev??e(s)	2021-04-27 18:49:44	2021-04-27 18:49:44
2	En blocage	2021-04-27 18:47:36	2021-04-27 18:47:36
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, progression, date_start, date_end, estimated_duration, performed_duration, deadline, parent_id, project_id, contributor_id, status_id, priority_id, inserted_at, updated_at, attributor_id, achieved_at, hidden, without_control) FROM stdin;
41	date_insert	0	2021-05-27	\N	6	0	2021-05-28	\N	14	54	5	2	2021-05-27 14:25:57	2021-06-24 14:41:56	57	2021-06-23 14:41:56	f	f
3	une nouvelle	0	2021-04-29	\N	2	0	2021-04-30	\N	14	54	5	1	2021-04-29 06:27:21	2021-06-14 16:55:19	52	2021-06-14 16:55:19	f	f
1	Vraie t??che	0	2021-04-28	\N	48	0	2021-04-30	\N	14	54	5	3	2021-04-28 19:36:58	2021-06-16 18:36:15	52	2021-06-16 18:36:15	f	f
38	notif2	0	2021-05-23	2021-05-25	5	0	2021-05-12	33	15	56	4	3	2021-05-23 14:15:08	2021-06-14 21:57:15	57	2021-06-09 16:20:36	f	f
36	TACHE POUR MATTHIEU	0	2021-05-17	\N	24	0	2021-05-18	\N	15	54	2	2	2021-05-17 13:52:18	2021-06-21 21:03:18	57	2021-06-13 22:49:12	f	f
55	Handleinfo 	0	2021-06-22	\N	6	0	2021-06-24	\N	14	54	5	2	2021-06-22 10:38:43	2021-06-26 20:32:55	57	2021-06-26 20:32:55	f	f
24	children_length_test	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	2	4	2021-05-11 12:22:08	2021-06-14 21:57:20	57	2021-06-09 16:02:32	f	f
88	t??che sans contr??le	0	2021-08-31	\N	10	0	2021-09-05	\N	18	54	5	2	2021-08-31 11:03:39	2021-09-01 12:13:34	57	\N	f	t
10	second_task	0	2021-05-03	\N	10	0	2021-05-04	\N	15	56	1	2	2021-05-03 10:18:08	2021-06-13 19:54:21	57	2021-06-13 22:48:44	f	f
7	kanban	0	2021-05-01	\N	3	0	2021-05-08	\N	14	54	5	1	2021-05-01 13:07:10	2021-06-26 23:00:17	52	2021-06-26 23:00:17	f	f
62	t??che sans d??but 2	0	2021-08-18	\N	2	0	2021-08-22	\N	19	\N	1	2	2021-08-18 16:27:54	2021-08-18 13:27:54	57	\N	f	f
64	snd without dt start	0	2021-08-18	\N	1	0	2021-05-18	36	15	54	1	2	2021-08-18 16:44:54	2021-08-18 13:44:54	57	\N	f	f
51	alpine	0	2021-06-19	\N	21	0	2021-06-20	\N	14	\N	1	2	2021-06-19 00:07:16	2021-06-19 08:57:26	57	\N	t	f
47	cerise2	0	2021-06-09	2021-06-12	16	0	2021-05-12	33	15	54	5	2	2021-06-09 16:14:09	2021-06-28 22:15:29	57	2021-06-28 22:15:29	f	f
33	cerise sur le g??teau	25	2021-05-12	\N	8	0	2021-05-12	\N	15	54	1	2	2021-05-12 14:19:24	2021-06-28 19:15:29	57	2021-06-13 22:50:12	f	f
6	pubsub	0	2021-05-01	\N	50	0	2021-05-08	\N	14	54	4	2	2021-05-01 13:00:55	2021-06-22 11:08:40	52	\N	f	f
42	date_insert2	0	2021-05-27	\N	6	0	2021-05-28	\N	14	\N	5	4	2021-05-27 17:28:06	2021-06-16 18:37:13	57	2021-06-16 18:36:30	f	f
50	test date	0	2021-06-14	\N	8	0	2021-06-15	\N	14	54	2	2	2021-06-14 15:45:37	2021-08-11 09:08:40	57	\N	t	f
83	subdemo2	0	2021-08-23	\N	10	0	2021-08-25	59	18	54	5	2	2021-08-23 14:17:11	2021-09-01 12:11:39	57	\N	f	f
46	Cr??ation interface Accueil	100	2021-06-08	\N	0	0	2021-06-11	\N	16	56	5	3	2021-06-08 19:48:28	2021-06-15 18:03:23	57	2021-06-15 18:03:23	f	f
20	task_children	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	3	2	2021-05-11 10:39:51	2021-06-13 22:49:38	57	2021-06-13 22:48:47	f	f
5	cinqui??me	0	2021-04-30	\N	48	0	2021-05-01	\N	14	54	1	2	2021-04-29 08:37:56	2021-06-19 16:30:15	52	2021-05-28 21:35:13	f	f
49	tache 	0	2021-05-05	\N	3	0	2223-02-05	\N	16	\N	4	2	2021-06-11 15:31:20	2021-07-05 10:36:20	57	2021-06-14 22:37:44	f	f
66	sous demo	0	2021-08-19	\N	8	0	2021-08-20	59	18	57	5	2	2021-08-19 11:08:55	2021-09-01 12:11:39	57	\N	f	f
59	T??che d??mo	100	2021-08-11	\N	8	0	2021-08-14	\N	18	54	5	2	2021-08-11 10:30:46	2021-09-01 12:11:39	57	2021-09-01 12:11:38	f	f
44	new_one	0	2021-06-06	\N	6	0	2021-06-07	\N	14	\N	5	2	2021-06-05 13:54:41	2021-06-16 18:36:13	57	2021-06-16 18:36:13	f	f
32	89	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	3	2	2021-05-12 13:59:05	2021-06-21 06:25:38	57	2021-06-13 22:49:15	f	f
11	EXEMPLE	0	2021-05-07	\N	45	0	2021-05-08	\N	14	54	4	2	2021-05-07 14:49:09	2021-06-11 19:14:07	57	\N	f	f
72	my_task	12	2021-08-23	\N	5	0	2021-08-31	\N	18	\N	1	2	2021-08-23 11:40:11	2021-09-01 09:14:54	57	\N	f	f
92	notif_test	0	2021-09-19	\N	5	0	2021-09-22	\N	18	54	1	2	2021-09-19 21:43:56	2021-09-19 18:43:56	57	\N	f	f
8	CHECK	0	2021-05-01	\N	2	0	2021-05-08	\N	14	54	5	2	2021-05-01 13:10:32	2021-06-04 18:37:14	52	2021-06-04 18:37:14	f	f
53	t??che urgente	0	2021-06-22	\N	6	0	2021-06-23	\N	14	54	1	2	2021-06-22 00:01:46	2021-06-22 11:30:19	57	\N	f	f
2	Seconde t??che	0	2021-04-29	\N	24	0	2021-04-30	\N	14	54	5	1	2021-04-29 06:25:23	2021-06-04 18:37:15	52	2021-06-04 18:37:15	f	f
97	prim4	0	2021-09-21	\N	9	0	2021-09-24	\N	22	56	1	2	2021-09-21 18:55:15	2021-09-21 15:55:15	57	\N	f	f
4	4eme	2	2021-05-01	\N	24	0	2021-04-30	\N	14	54	3	3	2021-04-29 08:37:15	2021-06-11 19:21:49	52	2021-05-28 21:34:54	f	f
95	prim2	0	2021-09-21	\N	9	0	2021-09-23	\N	22	56	5	2	2021-09-21 13:42:51	2021-09-21 20:13:06	57	2021-09-21 20:13:06	f	f
57	t??che test	100	2021-07-05	\N	5	0	2021-07-10	\N	17	62	2	3	2021-07-05 10:52:30	2021-09-22 11:04:13	57	2021-09-01 09:26:28	f	f
93	T??che du mardi	0	2021-09-21	\N	5	0	2021-09-23	\N	23	54	5	3	2021-09-21 13:15:40	2021-09-22 11:29:23	57	2021-09-22 11:29:23	f	f
60	Second test	0	2021-08-13	\N	12	0	2021-08-15	\N	18	54	5	3	2021-08-13 10:20:46	2021-08-13 10:22:38	57	2021-08-13 10:20:58	f	f
74	my_subtask1	0	2021-08-23	\N	5	0	2021-08-28	72	18	57	1	2	2021-08-23 11:42:27	2021-08-23 08:42:27	57	\N	f	f
61	t??che sans d??but	0	2021-08-18	\N	8	0	2021-08-22	\N	19	\N	1	2	2021-08-18 16:26:20	2021-08-18 16:27:21	57	\N	f	f
76	subtask11	0	2021-08-23	\N	6	0	2021-08-29	72	18	\N	1	2	2021-08-23 11:50:54	2021-08-23 08:50:54	57	\N	f	f
77	sub22	0	2021-08-23	\N	8	0	2021-08-29	72	18	\N	1	2	2021-08-23 12:11:33	2021-08-23 09:11:33	57	\N	f	f
78	subsub	0	2021-08-23	\N	5	0	2021-08-29	72	18	\N	1	2	2021-08-23 14:01:51	2021-08-23 11:01:51	57	\N	f	f
79	subbus	0	2021-08-23	\N	8	0	2021-08-24	72	18	\N	1	2	2021-08-23 14:02:29	2021-08-23 11:02:29	57	\N	f	f
81	subreal2	0	2021-08-23	\N	8	0	2021-08-30	72	18	54	1	2	2021-08-23 14:04:48	2021-08-23 11:04:48	57	\N	f	f
86	w_attrib	0	2021-08-23	\N	12	0	2021-08-29	\N	18	54	1	2	2021-08-23 14:37:34	2021-08-23 11:37:34	57	\N	f	f
71	New two	0	2021-08-19	\N	9	0	2021-08-26	\N	18	\N	1	2	2021-08-19 11:46:59	2021-08-31 16:13:56	57	\N	f	f
68	new one two	0	2021-08-19	\N	5	0	2021-08-20	67	18	\N	2	2	2021-08-19 11:30:43	2021-08-23 19:03:34	57	\N	f	f
69	new one three	0	2021-08-19	\N	6	0	2021-08-22	67	18	57	1	2	2021-08-19 11:45:07	2021-08-23 19:03:34	57	\N	f	f
87	t??che	0	2021-08-27	\N	20	0	2021-08-28	\N	20	\N	5	2	2021-08-27 10:10:55	2021-08-27 10:12:50	57	2021-08-27 10:12:50	f	f
85	wo_attrib	0	2021-08-23	\N	12	0	2021-08-29	\N	18	\N	2	2	2021-08-23 14:37:00	2021-08-31 16:13:01	57	\N	f	f
19	work	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	1	1	2021-05-11 10:08:44	2021-06-13 22:54:43	57	2021-06-13 22:48:45	f	f
43	t??che test	0	2021-05-31	\N	5	0	2021-06-01	\N	15	\N	4	2	2021-05-31 22:27:05	2021-06-13 22:49:35	57	2021-06-13 22:48:40	f	f
12	t??che secondaire pour first task	0	2021-05-10	\N	10	0	2021-05-04	9	15	56	1	4	2021-05-10 11:04:55	2021-06-13 22:54:44	57	2021-06-09 16:02:16	f	f
26	test_append	0	2021-05-21	2021-05-22	5	0	2021-05-04	9	15	56	3	4	2021-05-11 12:34:43	2021-06-21 15:33:23	57	2021-06-09 16:02:36	f	f
31	primaire	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	4	2	2021-05-12 11:02:47	2021-06-21 15:34:56	57	2021-06-13 22:48:48	f	f
40	tache notif	0	2021-05-23	\N	6	0	2021-05-24	\N	15	\N	2	2	2021-05-23 14:19:32	2021-06-21 15:35:49	57	2021-06-13 22:49:14	f	f
52	olana be	0	2021-06-19	\N	9	0	2021-06-20	\N	14	54	5	1	2021-06-19 01:11:13	2021-06-26 22:46:39	41	2021-06-26 22:46:39	f	f
54	R??daction	0	2021-06-22	\N	24	0	2021-06-29	\N	14	54	5	3	2021-06-22 00:02:59	2021-06-26 22:47:36	57	2021-06-26 22:47:36	f	f
39	notifs_length	0	2021-05-23	2021-05-24	5	0	2021-05-12	33	15	56	3	2	2021-05-23 14:17:54	2021-06-13 22:52:26	57	2021-06-13 22:46:42	f	f
56	Update task	0	2021-06-22	\N	9	0	2021-06-25	\N	14	54	5	4	2021-06-22 10:44:48	2021-06-26 22:47:42	57	2021-06-26 22:47:42	f	f
70	sous demo 2 	0	2021-08-19	\N	6	0	2021-08-23	59	18	54	5	2	2021-08-19 11:45:42	2021-09-01 12:11:39	57	\N	f	f
18	tacheee	0	2021-05-20	\N	55	0	2021-05-22	\N	15	56	2	3	2021-05-10 23:26:33	2021-06-19 10:02:05	57	2021-06-13 22:48:43	f	f
84	subdemo3	0	2021-08-23	\N	6	0	2021-08-24	59	18	62	5	2	2021-08-23 14:26:33	2021-09-01 12:11:39	57	\N	f	f
80	sub_real	0	2021-08-23	\N	8	0	2021-08-23	72	18	54	1	2	2021-08-23 14:03:08	2021-08-23 11:03:08	57	\N	f	f
37	notification_secondaire	0	2021-05-23	2021-05-24	2	0	2021-05-04	10	15	56	4	2	2021-05-23 14:13:06	2021-06-13 22:54:21	57	2021-05-31 22:25:26	f	f
48	cerise3	0	2021-06-09	2021-06-10	5	0	2021-05-12	33	15	54	2	2	2021-06-09 16:21:35	2021-06-21 21:03:16	57	2021-06-13 22:49:41	f	f
82	sub_demo	0	2021-08-23	\N	6	0	2021-08-24	59	18	54	5	2	2021-08-23 14:16:08	2021-09-01 12:11:39	57	\N	f	f
89	sous-t??che sans contr??le	0	2021-08-31	\N	5	0	2021-09-05	72	18	54	5	2	2021-08-31 15:31:21	2021-09-01 12:14:54	57	\N	f	t
91	Second test d'aujourd'hui	0	2021-09-19	\N	6	0	2021-09-22	\N	23	54	4	2	2021-09-19 21:29:14	2021-09-24 10:10:20	57	2021-09-24 10:10:15	f	f
27	append%2==1	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	4	4	2021-05-11 12:35:49	2021-06-13 22:54:34	57	2021-06-09 14:28:01	f	f
29	half_append	0	2021-05-11	2021-05-12	6	0	2021-05-04	9	15	56	5	1	2021-05-11 12:42:06	2021-06-14 21:57:05	57	2021-06-13 22:54:59	f	f
30	assoc2nde	0	2021-05-12	2021-05-12	6	0	2021-05-11	16	15	56	5	2	2021-05-11 21:12:50	2021-06-14 21:57:10	57	2021-06-13 22:55:09	f	f
14	sans dt de fin	0	2021-05-10	\N	25	0	2021-05-13	\N	15	\N	2	2	2021-05-10 15:26:00	2021-06-21 06:25:36	57	2021-06-13 22:48:31	t	f
23	cinqui??me t??che secondaire pour first	0	2021-05-12	2021-05-13	5	0	2021-05-04	9	15	56	3	4	2021-05-11 12:12:04	2021-06-13 22:48:38	57	2021-06-09 16:05:49	f	f
9	first_task	16	2021-05-03	\N	24	0	2021-05-04	\N	15	56	1	4	2021-05-03 10:07:31	2021-06-19 20:09:53	57	2021-06-13 22:48:38	f	f
63	second without dt_start	0	2021-08-18	2021-08-19	6	0	2021-05-18	36	15	54	1	2	2021-08-18 16:32:11	2021-08-18 13:32:11	57	\N	f	f
65	sous tache oue	0	2021-08-18	\N	9	0	2021-08-19	36	15	54	1	2	2021-08-18 17:07:44	2021-08-18 14:07:44	57	\N	f	f
16	ectoassoc	100	2021-05-11	\N	5	0	2021-05-11	\N	15	56	3	1	2021-05-10 23:15:14	2021-06-21 15:33:20	57	2021-06-12 00:08:41	f	f
35	doudousy2	0	2021-05-14	\N	6	0	2021-05-15	\N	15	\N	4	2	2021-05-13 21:42:44	2021-06-13 22:49:21	57	2021-06-13 22:49:16	f	f
98	prim5	0	2021-09-21	\N	95	0	2021-09-24	\N	22	56	1	2	2021-09-21 19:09:01	2021-09-21 16:09:01	57	\N	f	f
90	T??che de test	0	2021-09-19	\N	5	0	2021-09-22	\N	23	54	5	1	2021-09-19 21:27:11	2021-09-21 19:25:09	57	2021-09-21 13:16:14	f	f
96	prim3	0	2021-09-21	\N	5	0	2021-09-22	\N	22	56	1	3	2021-09-21 13:48:10	2021-09-21 20:25:58	57	\N	f	f
99	Nouvelle t??che pour aujou'd'hui	0	2021-09-21	\N	9	0	2021-09-22	\N	22	56	1	2	2021-09-21 20:50:13	2021-09-21 17:50:13	57	\N	f	f
94	prim	0	2021-09-21	\N	6	0	2021-09-22	\N	22	56	5	1	2021-09-21 13:41:46	2021-09-21 20:51:47	57	2021-09-21 20:51:47	f	f
58	sous-t??che1	0	2021-07-05	2021-07-08	2	0	2021-07-10	57	17	62	5	2	2021-07-05 11:14:08	2021-09-01 11:06:29	57	2021-09-01 11:06:29	f	f
67	new one	100	2021-08-19	\N	9	0	2021-08-22	\N	18	\N	5	2	2021-08-19 11:22:02	2021-08-23 19:03:34	57	2021-08-23 19:03:34	f	f
34	dodosy	0	2021-05-15	\N	6	0	2021-05-16	\N	15	\N	4	3	2021-05-13 21:36:00	2021-06-13 22:49:33	57	2021-06-13 22:48:42	f	f
73	my_task2	0	2021-08-23	\N	3	0	2021-08-23	\N	18	54	1	2	2021-08-23 11:40:34	2021-08-30 08:21:26	57	\N	t	f
75	my_subtask2	0	2021-08-23	\N	8	0	2021-08-28	73	18	54	1	2	2021-08-23 11:43:12	2021-08-30 08:21:26	57	\N	t	f
101	T??che pour faire la d??monstration	0	2021-09-22	\N	5	0	2021-09-23	\N	23	54	5	2	2021-09-22 12:19:29	2021-09-24 10:10:08	57	2021-09-24 10:10:08	f	f
100	ationt??che de pr??-d??monstr	0	2021-09-22	\N	8	0	2021-09-23	\N	23	54	4	2	2021-09-22 11:25:27	2021-09-30 20:45:37	57	2021-09-24 10:10:13	f	f
103	Non planifi??e	0	2021-10-08	\N	6	0	2021-10-10	\N	24	\N	2	2	2021-10-08 11:39:49	2021-10-09 09:15:17	57	\N	f	f
104	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	3	2	2021-10-08 12:00:00	2021-10-09 09:15:18	57	\N	f	f
105	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	3	2	2021-10-08 12:00:00	2021-10-09 09:15:19	57	\N	f	f
106	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	4	2	2021-10-08 12:00:00	2021-10-09 09:15:20	57	\N	f	f
107	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	4	2	2021-10-08 12:00:00	2021-10-09 09:15:21	57	\N	f	f
108	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	4	2	2021-10-08 12:00:00	2021-10-09 09:15:23	57	\N	f	f
109	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	2	2	2021-10-08 12:00:00	2021-10-09 09:15:24	57	\N	f	f
110	T??che planifi??e 2	0	2021-10-08	\N	6	0	2021-10-08	\N	24	\N	3	2	2021-10-08 12:00:00	2021-10-09 09:15:25	57	\N	f	f
111	Plan Test	0	2021-10-08	\N	2	0	2021-10-08	\N	24	\N	4	2	2021-10-08 15:30:00	2021-10-09 09:15:27	57	\N	f	f
112	Plan Test	0	2021-10-08	\N	2	0	2021-10-08	\N	24	\N	4	2	2021-10-08 15:30:00	2021-10-09 09:15:30	57	\N	f	f
102	T??chee	0	2021-10-08	\N	5	0	2021-10-08	\N	24	\N	2	2	2021-10-08 11:00:01	2021-10-09 09:15:16	57	\N	f	f
113	T??che du 16:35	0	2021-10-08	\N	5	0	2021-10-08	\N	24	\N	2	2	2021-10-08 16:35:00	2021-10-09 09:15:27	57	\N	f	f
114	T??che du 16:35	0	2021-10-08	\N	5	0	2021-10-08	\N	24	\N	3	2	2021-10-08 16:35:00	2021-10-09 09:15:28	57	\N	f	f
115	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:08	57	\N	f	f
116	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	3	2	2021-10-09 09:20:00	2021-10-09 09:30:09	57	\N	f	f
117	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	4	2	2021-10-09 09:20:00	2021-10-09 09:30:10	57	\N	f	f
118	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:11	57	\N	f	f
119	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	3	2	2021-10-09 09:20:00	2021-10-09 09:30:12	57	\N	f	f
120	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:12	57	\N	f	f
121	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:13	57	\N	f	f
122	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:13	57	\N	f	f
123	Samedi 9:20	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:20:00	2021-10-09 09:30:14	57	\N	f	f
124	9:33	0	2021-10-09	\N	1	0	2021-10-09	\N	24	\N	2	2	2021-10-09 09:33:00	2021-10-09 10:11:03	57	\N	f	f
125	9:33	0	2021-10-09	\N	1	0	2021-10-09	\N	24	\N	3	2	2021-10-09 09:33:00	2021-10-09 10:11:03	57	\N	f	f
126	10:13	0	2021-10-09	\N	1	0	2021-10-09	\N	24	\N	1	2	2021-10-09 10:13:00	2021-10-09 07:13:00	57	\N	f	f
127	T??che planifi??e 3	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	1	2	2021-10-09 12:00:00	2021-10-09 09:00:00	57	\N	f	f
128	T??che planifi??e 1	0	2021-10-09	\N	5	0	2021-10-09	\N	24	\N	1	2	2021-10-09 12:00:00	2021-10-09 09:00:00	57	\N	f	f
129	13:03	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	1	2	2021-10-09 13:03:00	2021-10-09 10:03:00	52	\N	f	f
130	13:05	0	2021-10-09	\N	2	0	2021-10-09	\N	24	\N	1	2	2021-10-09 13:05:00	2021-10-09 10:05:00	52	\N	f	f
131	9:33	0	2021-10-11	\N	1	0	2021-10-11	\N	24	\N	1	2	2021-10-11 09:33:00	2021-10-11 06:33:00	57	\N	f	f
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, profile_picture, email, password, right_id, inserted_at, updated_at) FROM stdin;
64	client3	images/profiles/default_profile_pic.png	client3@gmail.com	$2b$12$c3diaef5qYrq/shcAB/SB.hV3FKJx7v4T/C96/mR6oAXlAoa4BhS.	5	2021-08-24 14:26:14	2021-08-24 14:26:14
65	client4	images/profiles/default_profile_pic.png	client4@gmail.com	$2b$12$W.7bN24lIxFz1VHryd31iuBfvg8rAl.9QwCXOA3z1DltEcw7HlOqi	4	2021-08-24 14:34:55	2021-08-24 14:34:55
66	client5	images/profiles/default_profile_pic.png	client5@gmail.com	$2b$12$MgZiOeNrcRt3hrAdUV6I/.f5qeI/S80R5gWXOGPLHrpItzvta385i	4	2021-08-24 14:37:57	2021-08-24 14:37:57
33	Eric	images/profiles/Eric-profile.png	eric@soc	$2b$12$aK2fjkTDZh6ULSz5GmZCh.vA0OOWhnSI0quNwDOavdCN831CNg7uq	4	2021-03-26 06:37:02	2021-06-08 07:45:45
25	Profilnonattribu??	images/profiles/Profilnonattribu??-profile.png	profilnonattribue@mgbi.com	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	5	2021-03-25 11:09:44	2021-06-08 14:45:27
53	Attributeur	images/profiles/Attributeur-profile.png	attributeur@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	2	2021-04-13 11:30:16	2021-06-12 09:58:51
67	client6	images/profiles/default_profile_pic.png	client6@gmail.com	$2b$12$B3X0xy1H3gpZMYae6Hww2e/LOVG99mFscEkGGSTdYazp8y8OTIVPC	4	2021-08-24 14:41:14	2021-08-24 14:41:14
58	Marc	images/profiles/Marc-profile.png	marc@comp	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	4	2021-05-02 13:24:25	2021-06-04 15:06:15
54	Mgbi1	images/profiles/Mgbi1-profile.png	contributeur@mgbi	$2b$12$sxaYg4bRhFyE7RDn0gaXcOlDkEnhOoPFpB./8Ir.RDNKR85vsv6nK	3	2021-04-13 11:38:03	2021-06-04 15:06:48
56	Mgbi2	images/profiles/Mgbi2-profile.png	contributeur2@mgbi	$2b$12$xjnYOEvFZyi6ky2vB8HGCO//zHlN8lqg56hBeGE/ezDgqB/z01Z8a	3	2021-05-01 18:12:11	2021-06-04 15:07:05
68	client7	images/profiles/default_profile_pic.png	client7@gmail.com	$2b$12$bFZDNR2imYKkg1VFc2VikutKVNkRtkqQh/BhvHQLzb1H1JkRt.n32	4	2021-08-27 07:01:04	2021-08-27 07:01:04
41	Test	images/profiles/Test-profile.png	test@test	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	1	2021-03-30 18:00:03	2021-06-04 15:12:36
52	Admin	images/profiles/Admin-profile.png	admin@myadmin	$2b$12$3yngeegsjEEifTOEZDSfAeOXnuyBOkCfjGUN.7GdIW1A57mD6tKqO	1	2021-04-13 08:28:09	2021-06-04 15:13:25
57	Mgbi	images/profiles/Mgbi-profile.png	admin@admin.mgbi	$2b$12$ppF6QKRLMia3lvzr1XY3C.fXB0Qv5WB4M8a.o6Pe96TI3Sxw1ETbC	1	2021-05-01 21:28:30	2021-06-16 07:47:04
59	Nouveau	images/profiles/default_profile_pic.png	nouveau@mgbi	$2b$12$uLv4bNisBinwwPPtFBBOYu67tC3.X.ROPHzoLxQsggHo4YU8FtWc2	5	2021-06-08 17:54:58	2021-06-18 20:00:29
55	Jesuisarchiv??	images/profiles/Jesuisarchiv??-profile.png	archiv??@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	100	2021-04-13 11:46:26	2021-06-18 22:08:44
62	ContributeurMGBI	images/profiles/default_profile_pic.png	contrbuteur_mgbi@mgbi.com	$2b$12$UfFDknShAZ1iwKV2RdrS/eVAvU7YepyJ0.7SpGv00dNxaNMkC0VYi	3	2021-07-05 07:40:23	2021-07-05 07:40:52
63	client2	images/profiles/default_profile_pic.png	client@gmail.com	$2b$12$2hzENwFn7ZYFTKLMrCyD/uL/ko73chK7j9bxwqWpaYCrJISCgxgle	4	2021-08-24 14:15:16	2021-08-24 14:18:10
\.


--
-- Name: active_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_clients_id_seq', 14, true);


--
-- Name: assist_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assist_contracts_id_seq', 11, true);


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.boards_id_seq', 29, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 134, true);


--
-- Name: clients_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_requests_id_seq', 29, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 95, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 9, true);


--
-- Name: editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editors_id_seq', 12, true);


--
-- Name: licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licenses_id_seq', 6, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 3391, true);


--
-- Name: planified_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planified_id_seq', 17, true);


--
-- Name: priorities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priorities_id_seq', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 24, true);


--
-- Name: rights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rights_id_seq', 31, true);


--
-- Name: softwares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.softwares_id_seq', 4, true);


--
-- Name: stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stages_id_seq', 140, true);


--
-- Name: statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statuses_id_seq', 5, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 131, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 68, true);


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
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: planified planified_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planified
    ADD CONSTRAINT planified_pkey PRIMARY KEY (id);


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
-- Name: assist_contracts_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX assist_contracts_title_index ON public.assist_contracts USING btree (title);


--
-- Name: cards_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cards_position_index ON public.cards USING btree ("position");


--
-- Name: clients_requests_active_client_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clients_requests_active_client_id_index ON public.clients_requests USING btree (active_client_id);


--
-- Name: clients_requests_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX clients_requests_title_index ON public.clients_requests USING btree (title);


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
-- Name: editors_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX editors_title_index ON public.editors USING btree (title);


--
-- Name: licenses_company_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX licenses_company_id_index ON public.licenses USING btree (company_id);


--
-- Name: licenses_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX licenses_title_index ON public.licenses USING btree (title);


--
-- Name: notifications_receiver_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_receiver_id_index ON public.notifications USING btree (receiver_id);


--
-- Name: notifications_sender_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_sender_id_index ON public.notifications USING btree (sender_id);


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
-- Name: softwares_title_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX softwares_title_index ON public.softwares USING btree (title);


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
-- Name: notifications notifications_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: notifications notifications_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


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

