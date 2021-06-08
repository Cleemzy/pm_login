--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-1.pgdg18.04+1)

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
    achieved_at timestamp(0) without time zone
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
1	CONT/SOC/001	2021-06-09	2021-06-12	1	2021-06-01 22:03:42	2021-06-01 22:03:42
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
22	tacheee	42	0	2021-05-10 23:26:33	2021-05-28 18:34:25	18
9	cinquième	38	0	2021-04-29 08:37:56	2021-05-28 18:36:27	5
7	une nouvelle	38	1	2021-04-29 06:27:21	2021-05-28 18:36:29	3
16	tâche secondaire pour first task	44	3	2021-05-10 11:04:55	2021-05-27 08:27:45	12
24	task_children	45	8	2021-05-11 10:39:51	2021-06-08 07:58:45	20
14	second_task	45	7	2021-05-03 10:18:08	2021-06-08 07:58:48	10
41	notification_secondaire	45	6	2021-05-23 14:13:06	2021-05-31 19:25:26	37
47	tâche test	45	5	2021-05-31 19:27:05	2021-06-08 07:58:57	43
44	tache notif	45	4	2021-05-23 14:19:32	2021-05-31 19:09:02	40
18	sans dt de fin	45	3	2021-05-10 15:26:00	2021-06-08 07:59:02	14
42	notif2	43	4	2021-05-23 14:15:08	2021-05-23 14:39:35	38
33	half_append	43	3	2021-05-11 12:42:06	2021-06-08 07:58:40	29
30	test_append	42	1	2021-05-11 12:34:43	2021-06-04 15:13:56	26
20	ectoassoc	45	9	2021-05-10 23:15:14	2021-06-08 07:59:04	16
36	89	43	1	2021-05-12 13:59:05	2021-06-04 15:13:59	32
12	CHECK	40	0	2021-05-01 13:10:32	2021-06-04 15:37:14	8
31	append%2==1	44	2	2021-05-11 12:35:49	2021-05-17 13:55:19	27
23	work	44	1	2021-05-11 10:08:44	2021-05-28 18:33:26	19
37	cerise sur le gâteau	43	0	2021-05-12 14:19:24	2021-05-31 19:29:16	33
10	pubsub	39	0	2021-05-01 13:00:55	2021-05-28 18:36:12	6
6	Seconde tâche	40	1	2021-04-29 06:25:23	2021-06-04 15:37:15	2
48	new_one	38	2	2021-06-05 10:54:41	2021-06-05 10:54:57	44
28	children_length_test	41	3	2021-05-11 12:22:08	2021-05-31 19:19:44	24
43	notifs_length	41	4	2021-05-23 14:17:54	2021-05-31 19:19:45	39
34	assoc2nde	41	2	2021-05-11 21:12:51	2021-05-23 15:07:48	30
27	cinquième tâche secondaire pour first	41	1	2021-05-11 12:12:04	2021-05-25 17:22:30	23
40	TACHE POUR MATTHIEU	41	0	2021-05-17 13:52:19	2021-06-05 12:32:16	36
1	Vraie tâche	36	0	2021-04-28 19:36:59	2021-05-28 18:36:50	1
13	first_task	44	0	2021-05-03 10:07:31	2021-05-28 18:33:31	9
8	4eme	37	0	2021-04-29 08:37:15	2021-06-05 20:39:15	4
11	kanban	37	1	2021-05-01 13:07:10	2021-05-28 18:36:42	7
35	primaire	45	0	2021-05-12 11:02:47	2021-05-28 18:33:36	31
45	date_insert	37	2	2021-05-27 14:25:58	2021-06-04 15:37:09	41
15	EXEMPLE	36	2	2021-05-07 14:49:09	2021-06-04 15:23:44	11
38	dodosy	45	1	2021-05-13 21:36:00	2021-05-28 18:33:37	34
46	date_insert2	36	1	2021-05-27 14:28:06	2021-06-05 20:39:20	42
39	doudousy2	45	2	2021-05-13 21:42:44	2021-05-28 18:33:41	35
\.


--
-- Data for Name: clients_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients_requests (id, content, date_post, active_client_id, inserted_at, updated_at, title, seen, ongoing, done, file_urls) FROM stdin;
14	3eme requête	2021-06-05 18:14:45	1	2021-06-05 15:14:45	2021-06-05 15:14:45	Requête 3	f	f	f	{}
26	ceci est une collection de fonds d'écran	2021-06-08 11:04:07	1	2021-06-08 08:04:07	2021-06-08 08:04:38	Fond d'écran	f	f	f	{/uploads/1361846e69b9740-e234-494e-ae88-6383904579d0.jpg,/uploads/SBKjnxm4e3aa22e-f0b5-4229-8cb4-5192c6325dd3.jpg}
15	ceci est une requête flash	2021-06-05 21:01:44	1	2021-06-05 18:01:44	2021-06-05 18:55:16	Requête flash	f	f	f	{}
13	deuxième requête 	2021-06-05 18:13:24	1	2021-06-05 15:13:24	2021-06-05 18:56:19	Requête 2	f	f	f	{}
12	Voici la première requête	2021-06-05 17:39:41	1	2021-06-05 14:39:41	2021-06-07 14:41:16	Requête 1	t	f	f	{}
21	samurai pictures	2021-06-07 20:44:26	1	2021-06-07 17:44:26	2021-06-07 17:44:27	Samuraï	f	f	f	{/uploads/136201116337dd3-836b-44e6-a5fa-cf2cd07416b8.jpg,/uploads/winter_samuraiea311a63-ef6c-4184-8329-32dd542f488e.jpg}
22	des fichiers	2021-06-07 20:59:51	1	2021-06-07 17:59:51	2021-06-07 17:59:51	Fichiers	f	f	f	{/uploads/cert-21413040-107362b713fa-34ee-4193-80f3-af48536efc2d.pdf,"/uploads/cert-21413040-1024 (copy)qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7e55d38a-a14a-43ce-adeb-7153f5d79c2a.pdf"}
23	ceci est un fichier texte	2021-06-07 21:16:55	1	2021-06-07 18:16:55	2021-06-07 18:16:55	Fichier texte	f	f	f	{/uploads/test1703fef2-905a-4e5f-9396-067124e1eaaa.txt}
25	Êtes-vous notifié de cette requête?	2021-06-07 23:43:47	1	2021-06-07 20:43:47	2021-06-07 20:43:47	Notification?	f	f	f	{}
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
10	is it scrolling on the bottom now?	9	57	2021-05-09 11:12:36	2021-05-09 11:12:36
11	or?	9	57	2021-05-09 11:15:50	2021-05-09 11:15:50
12	and now?	9	57	2021-05-09 11:16:06	2021-05-09 11:16:06
13	oii	9	57	2021-05-09 11:16:13	2021-05-09 11:16:13
14	oii	9	57	2021-05-09 11:16:17	2021-05-09 11:16:17
15	oii	9	57	2021-05-09 11:16:18	2021-05-09 11:16:18
16	premier commentaire pour cette tâche	10	57	2021-05-09 11:16:38	2021-05-09 11:16:38
17	Mais est-ce que çà scroll bien ? 	10	57	2021-05-09 11:17:03	2021-05-09 11:17:03
18	Mais est-ce que çà scroll bien ? Oui?	10	57	2021-05-09 11:17:06	2021-05-09 11:17:06
19	Je ne sais pas	10	57	2021-05-09 11:17:13	2021-05-09 11:17:13
20	oiii	10	57	2021-05-09 11:17:20	2021-05-09 11:17:20
21	sans hooks	10	57	2021-05-09 11:18:24	2021-05-09 11:18:24
22	avec hooks	10	57	2021-05-09 11:18:34	2021-05-09 11:18:34
23	update?	10	57	2021-05-09 11:20:28	2021-05-09 11:20:28
24	up	10	57	2021-05-09 11:20:37	2021-05-09 11:20:37
25	oi	10	57	2021-05-09 11:23:00	2021-05-09 11:23:00
26	oui??	10	57	2021-05-09 11:23:05	2021-05-09 11:23:05
27	çà ne marche pas avec hendle-info	10	57	2021-05-09 11:23:59	2021-05-09 11:23:59
28	mais avec post oui	10	57	2021-05-09 11:24:33	2021-05-09 11:24:33
29	before update?	10	57	2021-05-09 11:26:15	2021-05-09 11:26:15
30	en train de marcher ?	10	57	2021-05-09 11:26:25	2021-05-09 11:26:25
31	e sais pas 	10	57	2021-05-09 11:26:51	2021-05-09 11:26:51
32	oii	10	57	2021-05-09 11:26:55	2021-05-09 11:26:55
33	oii	9	57	2021-05-09 11:29:37	2021-05-09 11:29:37
34	oii	9	57	2021-05-09 11:29:59	2021-05-09 11:29:59
35	pus?hed	9	57	2021-05-09 11:40:51	2021-05-09 11:40:51
36	Bien sûuuur	9	57	2021-05-09 11:41:01	2021-05-09 11:41:01
37	without handle_info?	9	57	2021-05-09 11:41:31	2021-05-09 11:41:31
38	with handle_info	9	57	2021-05-09 11:41:45	2021-05-09 11:41:45
39	cas isolé	9	57	2021-05-09 12:57:16	2021-05-09 12:57:16
40	bam	9	57	2021-05-09 12:59:41	2021-05-09 12:59:41
41	hoii	9	57	2021-05-09 13:00:13	2021-05-09 13:00:13
42	holaa	9	57	2021-05-09 13:01:14	2021-05-09 13:01:14
43	alors?	9	56	2021-05-09 13:01:20	2021-05-09 13:01:20
44	postingggg	9	57	2021-05-09 13:25:05	2021-05-09 13:25:05
45	pogt	9	57	2021-05-09 13:25:13	2021-05-09 13:25:13
46	de aona?	9	56	2021-05-09 15:44:04	2021-05-09 15:44:04
47	kaiza	9	57	2021-05-09 20:24:57	2021-05-09 20:24:57
48	yoo	9	57	2021-05-09 21:18:38	2021-05-09 21:18:38
49	oii	9	57	2021-05-09 21:18:58	2021-05-09 21:18:58
50	oii	9	57	2021-05-09 21:19:06	2021-05-09 21:19:06
51	popopo	9	57	2021-05-09 21:29:06	2021-05-09 21:29:06
52	ary zao?	9	57	2021-05-09 22:44:15	2021-05-09 22:44:15
53	çàmarche	9	57	2021-05-09 22:46:41	2021-05-09 22:46:41
54	ouais	9	57	2021-05-09 22:46:49	2021-05-09 22:46:49
55	houlz	10	57	2021-05-09 22:47:11	2021-05-09 22:47:11
56	gg	9	56	2021-05-09 23:16:26	2021-05-09 23:16:26
57	bien sur que oui	9	56	2021-05-09 23:16:50	2021-05-09 23:16:50
58	hello	9	56	2021-05-09 23:17:31	2021-05-09 23:17:31
59	çà va ? 	9	57	2021-05-09 23:17:43	2021-05-09 23:17:43
60	ouioui	9	56	2021-05-09 23:17:48	2021-05-09 23:17:48
61	assssssssssssssssssssssssssoooooooooooooooooooooocccccccccccccccccccccccc	16	57	2021-05-20 20:12:37	2021-05-20 20:12:37
62	today ? 	32	57	2021-05-27 13:24:11	2021-05-27 13:24:11
63	is the date correct ?	32	57	2021-05-27 17:06:40	2021-05-27 14:06:40
64	date date	9	57	2021-06-05 14:13:32	2021-06-05 11:13:32
65	datuu	9	57	2021-06-05 16:17:05	2021-06-05 13:17:05
66	amor fati	9	57	2021-06-05 16:21:15	2021-06-05 13:21:15
67	commentaire de test	9	41	2021-06-07 18:32:54	2021-06-07 15:32:54
68	réponse test	9	57	2021-06-07 18:33:09	2021-06-07 15:33:09
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, inserted_at, updated_at, logo) FROM stdin;
1	SOC	2021-04-13 13:35:40	2021-04-13 13:35:40	images/company_logos/company_default_logo.png
2	COMP	2021-05-03 07:27:29	2021-05-03 07:27:29	images/company_logos/company_default_logo.png
6	SOCIETAM	2021-05-14 13:08:49	2021-05-14 13:08:49	images/company_logos/company_default_logo.png
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
17	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	53	2021-05-20 20:01:51	2021-05-20 20:01:51
20	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 06:17:41	2021-05-21 06:17:41
23	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 06:17:43	2021-05-21 06:17:43
26	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 06:17:46	2021-05-21 06:17:46
29	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 06:17:48	2021-05-21 06:17:48
32	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:19:34	2021-05-21 06:19:34
35	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:19:36	2021-05-21 06:19:36
1	Notification 1	t	56	57	2021-05-18 11:31:52	2021-05-18 11:31:52
2	Notification 2	t	56	57	2021-05-18 11:32:03	2021-05-18 11:32:03
3	Notification 3	t	56	57	2021-05-18 11:32:06	2021-05-18 13:36:29
38	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:15	2021-05-21 06:20:15
5	test date	t	56	57	2021-05-19 21:08:34	2021-05-19 21:08:34
41	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:18	2021-05-21 06:20:18
44	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:27	2021-05-21 06:20:27
47	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:30	2021-05-21 06:20:30
50	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:39	2021-05-21 06:20:39
53	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:42	2021-05-21 06:20:42
56	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:20:52	2021-05-21 06:20:52
59	Tâche "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 06:20:55	2021-05-21 06:20:55
308	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	f	53	52	2021-05-25 17:22:30	2021-05-25 17:22:30
16	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	57	2021-05-20 20:01:51	2021-05-20 20:01:51
4	Notification 1	t	57	56	2021-05-18 11:39:55	2021-05-18 11:39:55
309	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	t	53	57	2021-05-25 17:22:30	2021-05-25 17:22:30
311	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-26 20:16:28	2021-05-26 20:16:28
312	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-26 20:16:28	2021-05-26 20:16:28
314	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 08:27:38	2021-05-27 08:27:38
42	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:18	2021-05-21 06:20:18
45	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:27	2021-05-21 06:20:27
48	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:30	2021-05-21 06:20:30
51	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:39	2021-05-21 06:20:39
54	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:42	2021-05-21 06:20:42
57	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:52	2021-05-21 06:20:52
60	Tâche "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 06:20:55	2021-05-21 06:20:55
18	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En cours " par Admin	t	52	41	2021-05-20 20:01:51	2021-05-20 20:01:51
21	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 06:17:41	2021-05-21 06:17:41
24	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 06:17:43	2021-05-21 06:17:43
27	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 06:17:46	2021-05-21 06:17:46
30	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 06:17:48	2021-05-21 06:17:48
33	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:19:34	2021-05-21 06:19:34
36	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:19:36	2021-05-21 06:19:36
39	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:20:15	2021-05-21 06:20:15
315	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 08:27:38	2021-05-27 08:27:38
332	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:15	2021-05-27 14:34:15
333	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:15	2021-05-27 14:34:15
371	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:54	2021-05-27 14:36:54
372	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:54	2021-05-27 14:36:54
671	Le projet "Premier test" a été mise à jour par Mgbi	f	57	53	2021-06-01 19:58:39	2021-06-01 19:58:39
65	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:21:13	2021-05-21 06:21:13
68	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:21:18	2021-05-21 06:21:18
71	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-21 06:21:25	2021-05-21 06:21:25
74	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:21:27	2021-05-21 06:21:27
77	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 06:22:33	2021-05-21 06:22:33
80	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 06:22:36	2021-05-21 06:22:36
83	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 06:22:47	2021-05-21 06:22:47
40	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:18	2021-05-21 06:20:18
43	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:27	2021-05-21 06:20:27
46	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:30	2021-05-21 06:20:30
49	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:39	2021-05-21 06:20:39
52	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:42	2021-05-21 06:20:42
55	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:52	2021-05-21 06:20:52
58	Tâche "second_task"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 06:20:55	2021-05-21 06:20:55
61	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:20:57	2021-05-21 06:20:57
19	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 06:17:41	2021-05-21 06:17:41
22	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 06:17:43	2021-05-21 06:17:43
25	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 06:17:46	2021-05-21 06:17:46
28	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 06:17:48	2021-05-21 06:17:48
31	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:19:34	2021-05-21 06:19:34
34	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:19:36	2021-05-21 06:19:36
37	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:20:15	2021-05-21 06:20:15
64	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:21:13	2021-05-21 06:21:13
67	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:21:18	2021-05-21 06:21:18
70	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-21 06:21:25	2021-05-21 06:21:25
73	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-21 06:21:27	2021-05-21 06:21:27
76	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 06:22:33	2021-05-21 06:22:33
79	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 06:22:36	2021-05-21 06:22:36
82	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 06:22:47	2021-05-21 06:22:47
85	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	52	2021-05-21 06:22:50	2021-05-21 06:22:50
86	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	53	2021-05-21 06:22:50	2021-05-21 06:22:50
89	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	53	2021-05-21 07:40:31	2021-05-21 07:40:31
92	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	53	2021-05-21 07:41:33	2021-05-21 07:41:33
95	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Admin	t	52	53	2021-05-21 08:12:09	2021-05-21 08:12:09
62	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-21 06:20:57	2021-05-21 06:20:57
63	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:20:57	2021-05-21 06:20:57
66	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:21:13	2021-05-21 06:21:13
94	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Admin	t	52	57	2021-05-21 08:12:09	2021-05-21 08:12:09
317	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 08:27:45	2021-05-27 08:27:45
318	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 08:27:45	2021-05-27 08:27:45
383	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:08	2021-05-27 14:37:08
384	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:08	2021-05-27 14:37:08
389	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:15	2021-05-27 14:37:15
390	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:15	2021-05-27 14:37:15
398	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:21	2021-05-27 14:37:21
399	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:21	2021-05-27 14:37:21
319	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 08:27:45	2021-05-27 08:27:45
98	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Admin	t	52	53	2021-05-21 08:12:11	2021-05-21 08:12:11
101	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 08:33:37	2021-05-21 08:33:37
104	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 08:33:40	2021-05-21 08:33:40
107	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:56:59	2021-05-21 11:56:59
110	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:02	2021-05-21 11:57:02
113	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:03	2021-05-21 11:57:03
116	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:57:06	2021-05-21 11:57:06
119	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:16	2021-05-21 11:57:16
122	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:57:19	2021-05-21 11:57:19
125	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:57:21	2021-05-21 11:57:21
128	Tâche "tacheee"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:30	2021-05-21 11:57:30
131	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:31	2021-05-21 11:57:31
134	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:31	2021-05-21 11:57:31
320	Tâche nouvellement créee du nom de date_insert par Mgbi dans le projet Premier test.	f	57	52	2021-05-27 14:25:58	2021-05-27 14:25:58
321	Tâche nouvellement créee du nom de date_insert par Mgbi dans le projet Premier test.	f	57	53	2021-05-27 14:25:58	2021-05-27 14:25:58
99	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Admin	t	52	41	2021-05-21 08:12:11	2021-05-21 08:12:11
102	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 08:33:37	2021-05-21 08:33:37
105	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 08:33:40	2021-05-21 08:33:40
108	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:56:59	2021-05-21 11:56:59
111	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:02	2021-05-21 11:57:02
114	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:03	2021-05-21 11:57:03
117	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:57:06	2021-05-21 11:57:06
120	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:16	2021-05-21 11:57:16
123	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:57:19	2021-05-21 11:57:19
126	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:57:21	2021-05-21 11:57:21
129	Tâche "tacheee"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:30	2021-05-21 11:57:30
132	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:31	2021-05-21 11:57:31
135	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:31	2021-05-21 11:57:31
138	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:33	2021-05-21 11:57:33
141	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:33	2021-05-21 11:57:33
144	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:34	2021-05-21 11:57:34
97	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Admin	t	52	57	2021-05-21 08:12:11	2021-05-21 08:12:11
137	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:33	2021-05-21 11:57:33
140	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:33	2021-05-21 11:57:33
143	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:34	2021-05-21 11:57:34
326	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:28:10	2021-05-27 14:28:10
327	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:28:10	2021-05-27 14:28:10
344	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:34:38	2021-05-27 14:34:38
345	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:34:38	2021-05-27 14:34:38
375	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:01	2021-05-27 14:37:01
425	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:39:53	2021-05-27 14:39:53
426	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:39:53	2021-05-27 14:39:53
440	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 17:54:08	2021-05-27 17:54:08
441	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 17:54:08	2021-05-27 17:54:08
322	Tâche nouvellement créee du nom de date_insert par Mgbi dans le projet Premier test.	t	57	41	2021-05-27 14:25:58	2021-05-27 14:25:58
328	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
163	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:26	2021-05-21 11:58:26
147	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:35	2021-05-21 11:57:35
165	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:26	2021-05-21 11:58:26
146	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:35	2021-05-21 11:57:35
164	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:26	2021-05-21 11:58:26
323	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	52	2021-05-27 14:28:06	2021-05-27 14:28:06
324	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	53	2021-05-27 14:28:06	2021-05-27 14:28:06
395	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:19	2021-05-27 14:37:19
396	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:19	2021-05-27 14:37:19
401	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:22	2021-05-27 14:37:22
402	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:22	2021-05-27 14:37:22
518	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:31	2021-05-28 18:33:31
519	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:31	2021-05-28 18:33:31
552	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:13	2021-05-28 18:35:13
555	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:16	2021-05-28 18:35:16
582	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:55	2021-05-28 18:35:55
594	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:12	2021-05-28 18:36:12
603	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:15	2021-05-28 18:36:15
609	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:17	2021-05-28 18:36:17
612	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
647	Tâche "tache notif"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-31 19:09:02	2021-05-31 19:09:02
648	Tâche "tache notif"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-31 19:09:02	2021-05-31 19:09:02
650	Tâche "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-31 19:19:44	2021-05-31 19:19:44
651	Tâche "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-05-31 19:19:44	2021-05-31 19:19:44
653	Tâche "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-31 19:19:45	2021-05-31 19:19:45
654	Tâche "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	53	2021-05-31 19:19:45	2021-05-31 19:19:45
656	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-31 19:25:26	2021-05-31 19:25:26
657	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-31 19:25:26	2021-05-31 19:25:26
659	Tâche nouvellement créee du nom de tâche test par Mgbi dans le projet mon_projet.	f	57	52	2021-05-31 19:27:05	2021-05-31 19:27:05
553	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:35:13	2021-05-28 18:35:13
556	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:35:16	2021-05-28 18:35:16
397	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:19	2021-05-27 14:37:19
403	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:22	2021-05-27 14:37:22
442	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 17:54:08	2021-05-27 17:54:08
520	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:33:31	2021-05-28 18:33:31
325	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	t	57	41	2021-05-27 14:28:06	2021-05-27 14:28:06
554	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:35:16	2021-05-28 18:35:16
581	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:55	2021-05-28 18:35:55
593	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:12	2021-05-28 18:36:12
602	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:15	2021-05-28 18:36:15
608	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:17	2021-05-28 18:36:17
611	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
148	Tâche "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:15	2021-05-21 11:58:15
151	Tâche "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:16	2021-05-21 11:58:16
154	Tâche "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:58:17	2021-05-21 11:58:17
157	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:25	2021-05-21 11:58:25
166	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:58:33	2021-05-21 11:58:33
172	Tâche "work"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:58:36	2021-05-21 11:58:36
175	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:41	2021-05-21 11:58:41
150	Tâche "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:15	2021-05-21 11:58:15
153	Tâche "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:16	2021-05-21 11:58:16
156	Tâche "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-21 11:58:17	2021-05-21 11:58:17
159	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:25	2021-05-21 11:58:25
168	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:58:33	2021-05-21 11:58:33
174	Tâche "work"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:58:36	2021-05-21 11:58:36
177	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:41	2021-05-21 11:58:41
149	Tâche "work"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:15	2021-05-21 11:58:15
152	Tâche "dodosy"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:16	2021-05-21 11:58:16
155	Tâche "doudousy2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-21 11:58:17	2021-05-21 11:58:17
158	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:25	2021-05-21 11:58:25
167	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:58:33	2021-05-21 11:58:33
173	Tâche "work"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:58:36	2021-05-21 11:58:36
176	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:41	2021-05-21 11:58:41
329	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:28:10	2021-05-27 14:28:10
330	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:28:10	2021-05-27 14:28:10
443	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:58:51	2021-05-27 17:58:51
444	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:58:51	2021-05-27 17:58:51
470	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:14:38	2021-05-27 18:14:38
471	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:14:38	2021-05-27 18:14:38
491	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:36:09	2021-05-27 23:36:09
492	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:36:09	2021-05-27 23:36:09
500	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:20:04	2021-05-28 18:20:04
501	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:20:04	2021-05-28 18:20:04
524	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:37	2021-05-28 18:33:37
525	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:37	2021-05-28 18:33:37
558	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:27	2021-05-28 18:35:27
567	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:38	2021-05-28 18:35:38
630	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:33	2021-05-28 18:36:33
636	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:42	2021-05-28 18:36:42
559	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:35:27	2021-05-28 18:35:27
400	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:21	2021-05-27 14:37:21
445	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 17:58:51	2021-05-27 17:58:51
331	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
557	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:35:27	2021-05-28 18:35:27
566	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:38	2021-05-28 18:35:38
629	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:33	2021-05-28 18:36:33
635	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:42	2021-05-28 18:36:42
160	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:25	2021-05-21 11:58:25
184	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:45	2021-05-21 11:58:45
162	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:25	2021-05-21 11:58:25
186	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:45	2021-05-21 11:58:45
161	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:25	2021-05-21 11:58:25
185	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:45	2021-05-21 11:58:45
335	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:34:23	2021-05-27 14:34:23
336	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:34:23	2021-05-27 14:34:23
407	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:24	2021-05-27 14:37:24
408	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:24	2021-05-27 14:37:24
446	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:59:07	2021-05-27 17:59:07
447	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:59:07	2021-05-27 17:59:07
473	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:15:03	2021-05-27 18:15:03
474	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:15:03	2021-05-27 18:15:03
482	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 23:14:48	2021-05-27 23:14:48
483	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 23:14:48	2021-05-27 23:14:48
485	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:34:43	2021-05-27 23:34:43
486	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:34:43	2021-05-27 23:34:43
503	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:20:06	2021-05-28 18:20:06
504	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:20:06	2021-05-28 18:20:06
530	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:23	2021-05-28 18:34:23
531	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:23	2021-05-28 18:34:23
546	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:08	2021-05-28 18:35:08
561	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:28	2021-05-28 18:35:28
579	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:49	2021-05-28 18:35:49
585	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:56	2021-05-28 18:35:56
600	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:14	2021-05-28 18:36:14
621	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:27	2021-05-28 18:36:27
645	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:50	2021-05-28 18:36:50
580	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:35:49	2021-05-28 18:35:49
532	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:23	2021-05-28 18:34:23
547	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:08	2021-05-28 18:35:08
562	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:35:28	2021-05-28 18:35:28
409	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:24	2021-05-27 14:37:24
448	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 17:59:07	2021-05-27 17:59:07
475	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 18:15:03	2021-05-27 18:15:03
484	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 23:14:48	2021-05-27 23:14:48
337	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:34:23	2021-05-27 14:34:23
545	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:08	2021-05-28 18:35:08
560	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:35:28	2021-05-28 18:35:28
578	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:35:49	2021-05-28 18:35:49
584	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:56	2021-05-28 18:35:56
599	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:14	2021-05-28 18:36:14
169	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:58:35	2021-05-21 11:58:35
178	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
171	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:58:35	2021-05-21 11:58:35
180	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
170	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:58:35	2021-05-21 11:58:35
179	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
338	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:25	2021-05-27 14:34:25
339	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:25	2021-05-27 14:34:25
341	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:37	2021-05-27 14:34:37
342	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:37	2021-05-27 14:34:37
419	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:36	2021-05-27 14:37:36
420	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:36	2021-05-27 14:37:36
449	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 17:59:09	2021-05-27 17:59:09
450	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 17:59:09	2021-05-27 17:59:09
461	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:27	2021-05-27 18:04:27
462	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:27	2021-05-27 18:04:27
506	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:12	2021-05-28 18:33:12
507	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:12	2021-05-28 18:33:12
533	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:25	2021-05-28 18:34:25
534	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:25	2021-05-28 18:34:25
564	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:37	2021-05-28 18:35:37
573	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:41	2021-05-28 18:35:41
597	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:13	2021-05-28 18:36:13
606	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:16	2021-05-28 18:36:16
615	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
618	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:22	2021-05-28 18:36:22
627	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:32	2021-05-28 18:36:32
642	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:48	2021-05-28 18:36:48
565	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:37	2021-05-28 18:35:37
535	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:25	2021-05-28 18:34:25
421	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-05-27 14:37:36	2021-05-27 14:37:36
451	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 17:59:09	2021-05-27 17:59:09
463	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 18:04:27	2021-05-27 18:04:27
508	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:33:12	2021-05-28 18:33:12
340	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:34:25	2021-05-27 14:34:25
343	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:34:37	2021-05-27 14:34:37
563	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:37	2021-05-28 18:35:37
572	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:35:41	2021-05-28 18:35:41
596	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:13	2021-05-28 18:36:13
605	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:16	2021-05-28 18:36:16
614	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
181	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
183	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
182	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
347	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:36:43	2021-05-27 14:36:43
348	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:36:43	2021-05-27 14:36:43
365	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:52	2021-05-27 14:36:52
366	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:52	2021-05-27 14:36:52
386	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:11	2021-05-27 14:37:11
387	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:11	2021-05-27 14:37:11
392	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:18	2021-05-27 14:37:18
393	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:18	2021-05-27 14:37:18
413	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:27	2021-05-27 14:37:27
414	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:27	2021-05-27 14:37:27
428	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:43:54	2021-05-27 14:43:54
429	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:43:54	2021-05-27 14:43:54
452	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:04:08	2021-05-27 18:04:08
453	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:04:08	2021-05-27 18:04:08
464	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:04:29	2021-05-27 18:04:29
465	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:04:29	2021-05-27 18:04:29
488	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 23:36:07	2021-05-27 23:36:07
489	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 23:36:07	2021-05-27 23:36:07
509	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:18	2021-05-28 18:33:18
510	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:18	2021-05-28 18:33:18
536	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:26	2021-05-28 18:34:26
537	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:26	2021-05-28 18:34:26
540	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:34:51	2021-05-28 18:34:51
543	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:34:54	2021-05-28 18:34:54
570	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:40	2021-05-28 18:35:40
576	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:48	2021-05-28 18:35:48
591	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:36:04	2021-05-28 18:36:04
538	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-28 18:34:26	2021-05-28 18:34:26
541	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:34:51	2021-05-28 18:34:51
349	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:36:43	2021-05-27 14:36:43
367	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:52	2021-05-27 14:36:52
388	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:37:11	2021-05-27 14:37:11
539	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:34:51	2021-05-28 18:34:51
542	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:34:54	2021-05-28 18:34:54
569	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:35:40	2021-05-28 18:35:40
575	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:35:48	2021-05-28 18:35:48
590	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:36:04	2021-05-28 18:36:04
350	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:46	2021-05-27 14:36:46
88	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	52	2021-05-21 07:40:31	2021-05-21 07:40:31
91	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	52	2021-05-21 07:41:33	2021-05-21 07:41:33
100	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 08:33:37	2021-05-21 08:33:37
103	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 08:33:40	2021-05-21 08:33:40
106	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:56:59	2021-05-21 11:56:59
109	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:02	2021-05-21 11:57:02
112	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:03	2021-05-21 11:57:03
115	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:57:06	2021-05-21 11:57:06
118	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:16	2021-05-21 11:57:16
121	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:57:19	2021-05-21 11:57:19
124	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	52	2021-05-21 11:57:21	2021-05-21 11:57:21
127	Tâche "tacheee"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:30	2021-05-21 11:57:30
130	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:31	2021-05-21 11:57:31
133	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:31	2021-05-21 11:57:31
136	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:33	2021-05-21 11:57:33
139	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:33	2021-05-21 11:57:33
142	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:34	2021-05-21 11:57:34
145	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:57:35	2021-05-21 11:57:35
187	Tâche "89"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:45	2021-05-21 11:58:45
190	Tâche "task_children"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-21 12:00:28	2021-05-21 12:00:28
351	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:46	2021-05-27 14:36:46
69	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:21:18	2021-05-21 06:21:18
72	Tâche "second_task"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-21 06:21:25	2021-05-21 06:21:25
75	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-21 06:21:27	2021-05-21 06:21:27
78	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 06:22:33	2021-05-21 06:22:33
81	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 06:22:36	2021-05-21 06:22:36
84	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 06:22:47	2021-05-21 06:22:47
87	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-21 06:22:50	2021-05-21 06:22:50
90	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-21 07:40:31	2021-05-21 07:40:31
93	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-21 07:41:33	2021-05-21 07:41:33
96	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Admin	t	52	41	2021-05-21 08:12:09	2021-05-21 08:12:09
189	Tâche "89"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:45	2021-05-21 11:58:45
192	Tâche "task_children"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 12:00:28	2021-05-21 12:00:28
193	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:08	2021-05-22 10:07:08
196	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:10	2021-05-22 10:07:10
362	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:51	2021-05-27 14:36:51
199	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
363	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:51	2021-05-27 14:36:51
202	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
205	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:13	2021-05-22 10:07:13
374	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:01	2021-05-27 14:37:01
195	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:08	2021-05-22 10:07:08
198	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:10	2021-05-22 10:07:10
208	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
209	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:14	2021-05-22 10:07:14
353	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:48	2021-05-27 14:36:48
354	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:48	2021-05-27 14:36:48
404	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:23	2021-05-27 14:37:23
405	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:23	2021-05-27 14:37:23
416	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:34	2021-05-27 14:37:34
417	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:34	2021-05-27 14:37:34
422	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:38:25	2021-05-27 14:38:25
423	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:38:25	2021-05-27 14:38:25
431	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 16:33:39	2021-05-27 16:33:39
432	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 16:33:39	2021-05-27 16:33:39
458	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:22	2021-05-27 18:04:22
459	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:22	2021-05-27 18:04:22
476	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:15:28	2021-05-27 18:15:28
477	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:15:28	2021-05-27 18:15:28
497	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 23:38:11	2021-05-27 23:38:11
498	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 23:38:11	2021-05-27 23:38:11
512	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:22	2021-05-28 18:33:22
513	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:22	2021-05-28 18:33:22
527	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:41	2021-05-28 18:33:41
528	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:41	2021-05-28 18:33:41
549	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:09	2021-05-28 18:35:09
588	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:36:01	2021-05-28 18:36:01
624	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:29	2021-05-28 18:36:29
633	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:35	2021-05-28 18:36:35
639	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:44	2021-05-28 18:36:44
670	Le projet "Premier test" a été mise à jour par Mgbi	f	57	52	2021-06-01 19:58:39	2021-06-01 19:58:39
529	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-28 18:33:41	2021-05-28 18:33:41
550	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:09	2021-05-28 18:35:09
355	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:48	2021-05-27 14:36:48
406	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:37:23	2021-05-27 14:37:23
418	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-05-27 14:37:34	2021-05-27 14:37:34
424	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:38:25	2021-05-27 14:38:25
433	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 16:33:39	2021-05-27 16:33:39
210	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
548	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:35:09	2021-05-28 18:35:09
587	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:36:01	2021-05-28 18:36:01
623	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:29	2021-05-28 18:36:29
632	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:35	2021-05-28 18:36:35
638	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	t	52	57	2021-05-28 18:36:44	2021-05-28 18:36:44
356	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:49	2021-05-27 14:36:49
357	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:49	2021-05-27 14:36:49
377	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:02	2021-05-27 14:37:02
378	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:02	2021-05-27 14:37:02
434	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 16:59:29	2021-05-27 16:59:29
220	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:16	2021-05-22 10:07:16
223	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:17	2021-05-22 10:07:17
226	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
229	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
211	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
214	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
217	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
232	Tâche "children_length_test"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-22 16:50:00	2021-05-22 16:50:00
435	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 16:59:29	2021-05-27 16:59:29
235	Tâche "children_length_test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-22 16:50:03	2021-05-22 16:50:03
238	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-22 16:50:10	2021-05-22 16:50:10
467	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:31	2021-05-27 18:04:31
241	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-22 16:50:12	2021-05-22 16:50:12
468	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:31	2021-05-27 18:04:31
244	Tâche "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 19:29:05	2021-05-22 19:29:05
247	Tâche "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
479	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:18:43	2021-05-27 18:18:43
250	Tâche "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
480	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:18:43	2021-05-27 18:18:43
253	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:19	2021-05-22 21:01:19
256	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:23	2021-05-22 21:01:23
494	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 23:38:08	2021-05-27 23:38:08
495	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 23:38:08	2021-05-27 23:38:08
213	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
216	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
219	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
222	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:16	2021-05-22 10:07:16
225	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:17	2021-05-22 10:07:17
259	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:24	2021-05-22 21:01:24
262	Tâche "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 13:49:26	2021-05-23 13:49:26
265	Tâche "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:38	2021-05-23 13:49:38
268	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:42	2021-05-23 13:49:42
271	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:44	2021-05-23 13:49:44
274	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-23 13:49:48	2021-05-23 13:49:48
280	Tâche nouvellement créee du nom de tache notif par Mgbi dans le projet mon_projet.	f	57	52	2021-05-23 14:19:32	2021-05-23 14:19:32
283	Tâche "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 14:39:34	2021-05-23 14:39:34
286	Tâche "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-23 14:39:35	2021-05-23 14:39:35
289	Tâche "tache notif"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-23 14:39:36	2021-05-23 14:39:36
292	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-23 14:44:31	2021-05-23 14:44:31
359	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:50	2021-05-27 14:36:50
360	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:50	2021-05-27 14:36:50
368	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:53	2021-05-27 14:36:53
277	Une tâche fille de votre tâche primaire second_task du nom de notification_secondaire a été créee par Mgbi2	t	56	57	2021-05-23 14:13:06	2021-05-23 14:13:06
278	Une tâche fille de votre tâche primaire cerise sur le gâteau du nom de notif2 a été créee par Mgbi2 dans le projet mon_projet	t	56	57	2021-05-23 14:15:08	2021-05-23 14:15:08
279	Une tâche fille de votre tâche primaire cerise sur le gâteau du nom de notifs_length a été créee par Mgbi2 dans le projet mon_projet	t	56	57	2021-05-23 14:17:54	2021-05-23 14:17:54
296	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	53	2021-05-23 15:04:22	2021-05-23 15:04:22
299	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	53	2021-05-23 15:04:29	2021-05-23 15:04:29
302	Tâche "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	53	2021-05-23 15:07:37	2021-05-23 15:07:37
305	Tâche "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	53	2021-05-23 15:07:48	2021-05-23 15:07:48
284	Tâche "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-23 14:39:34	2021-05-23 14:39:34
287	Tâche "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-23 14:39:35	2021-05-23 14:39:35
290	Tâche "tache notif"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-23 14:39:36	2021-05-23 14:39:36
293	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-23 14:44:31	2021-05-23 14:44:31
269	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:42	2021-05-23 13:49:42
272	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:44	2021-05-23 13:49:44
275	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-23 13:49:48	2021-05-23 13:49:48
281	Tâche nouvellement créee du nom de tache notif par Mgbi dans le projet mon_projet.	t	57	53	2021-05-23 14:19:32	2021-05-23 14:19:32
260	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:24	2021-05-22 21:01:24
263	Tâche "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-23 13:49:26	2021-05-23 13:49:26
266	Tâche "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-23 13:49:38	2021-05-23 13:49:38
258	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:23	2021-05-22 21:01:23
295	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	57	2021-05-23 15:04:22	2021-05-23 15:04:22
298	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-05-23 15:04:29	2021-05-23 15:04:29
301	Tâche "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	57	2021-05-23 15:07:37	2021-05-23 15:07:37
304	Tâche "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	57	2021-05-23 15:07:48	2021-05-23 15:07:48
188	Tâche "89"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:45	2021-05-21 11:58:45
191	Tâche "task_children"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 12:00:28	2021-05-21 12:00:28
194	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:08	2021-05-22 10:07:08
197	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:10	2021-05-22 10:07:10
200	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:12	2021-05-22 10:07:12
203	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:12	2021-05-22 10:07:12
206	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:13	2021-05-22 10:07:13
212	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:14	2021-05-22 10:07:14
215	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:15	2021-05-22 10:07:15
218	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:15	2021-05-22 10:07:15
221	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:16	2021-05-22 10:07:16
224	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:17	2021-05-22 10:07:17
227	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:18	2021-05-22 10:07:18
230	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 10:07:18	2021-05-22 10:07:18
233	Tâche "children_length_test"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-22 16:50:00	2021-05-22 16:50:00
236	Tâche "children_length_test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-22 16:50:03	2021-05-22 16:50:03
239	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-22 16:50:10	2021-05-22 16:50:10
242	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-22 16:50:12	2021-05-22 16:50:12
245	Tâche "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 19:29:05	2021-05-22 19:29:05
248	Tâche "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 21:01:17	2021-05-22 21:01:17
251	Tâche "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:17	2021-05-22 21:01:17
254	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	53	2021-05-22 21:01:19	2021-05-22 21:01:19
257	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	53	2021-05-22 21:01:23	2021-05-22 21:01:23
307	Mgbi vous a assigné à la tâche tacheee.	t	57	56	2021-05-25 05:23:16	2021-05-25 05:23:16
369	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:53	2021-05-27 14:36:53
380	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:03	2021-05-27 14:37:03
381	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:03	2021-05-27 14:37:03
410	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:25	2021-05-27 14:37:25
411	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:25	2021-05-27 14:37:25
437	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:53:57	2021-05-27 17:53:57
438	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:53:57	2021-05-27 17:53:57
455	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:04:19	2021-05-27 18:04:19
456	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:04:19	2021-05-27 18:04:19
515	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:26	2021-05-28 18:33:26
516	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:26	2021-05-28 18:33:26
521	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:36	2021-05-28 18:33:36
522	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:36	2021-05-28 18:33:36
551	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	57	2021-05-28 18:35:13	2021-05-28 18:35:13
660	Tâche nouvellement créee du nom de tâche test par Mgbi dans le projet mon_projet.	f	57	53	2021-05-31 19:27:05	2021-05-31 19:27:05
662	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi2	f	56	52	2021-05-31 19:29:01	2021-05-31 19:29:01
663	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi2	f	56	53	2021-05-31 19:29:01	2021-05-31 19:29:01
665	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi2	t	56	57	2021-05-31 19:29:01	2021-05-31 19:29:01
661	Tâche nouvellement créee du nom de tâche test par Mgbi dans le projet mon_projet.	t	57	41	2021-05-31 19:27:05	2021-05-31 19:27:05
664	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi2	t	56	41	2021-05-31 19:29:01	2021-05-31 19:29:01
666	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	f	56	52	2021-05-31 19:29:16	2021-05-31 19:29:16
667	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	f	56	53	2021-05-31 19:29:16	2021-05-31 19:29:16
644	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	t	52	57	2021-05-28 18:36:50	2021-05-28 18:36:50
641	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	t	52	57	2021-05-28 18:36:48	2021-05-28 18:36:48
669	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	t	56	57	2021-05-31 19:29:16	2021-05-31 19:29:16
668	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En cours " par Mgbi2	t	56	41	2021-05-31 19:29:16	2021-05-31 19:29:16
673	Le projet "Premier test" a été mise à jour par Mgbi	f	57	52	2021-06-01 21:03:38	2021-06-01 21:03:38
674	Le projet "Premier test" a été mise à jour par Mgbi	f	57	53	2021-06-01 21:03:38	2021-06-01 21:03:38
676	Le projet "Premier test" a été mise à jour par Mgbi	f	57	52	2021-06-01 21:04:02	2021-06-01 21:04:02
677	Le projet "Premier test" a été mise à jour par Mgbi	f	57	53	2021-06-01 21:04:02	2021-06-01 21:04:02
679	Le projet "Premier test" a été mise à jour par Mgbi	f	57	52	2021-06-01 21:10:32	2021-06-01 21:10:32
680	Le projet "Premier test" a été mise à jour par Mgbi	f	57	53	2021-06-01 21:10:32	2021-06-01 21:10:32
682	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-03 20:06:05	2021-06-03 20:06:05
683	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-03 20:06:05	2021-06-03 20:06:05
685	Tâche "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	55	2021-06-04 15:13:59	2021-06-04 15:13:59
686	Tâche "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-04 15:13:59	2021-06-04 15:13:59
688	Tâche "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-04 15:13:59	2021-06-04 15:13:59
689	Tâche "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	55	2021-06-04 15:23:45	2021-06-04 15:23:45
690	Tâche "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-04 15:23:45	2021-06-04 15:23:45
692	Tâche "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-04 15:23:45	2021-06-04 15:23:45
693	Mgbi vous a assigné à la tâche EXEMPLE.	f	57	54	2021-06-04 15:24:08	2021-06-04 15:24:08
694	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	55	2021-06-04 15:37:09	2021-06-04 15:37:09
695	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-04 15:37:09	2021-06-04 15:37:09
697	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-04 15:37:09	2021-06-04 15:37:09
698	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	55	2021-06-04 15:37:15	2021-06-04 15:37:15
699	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-04 15:37:15	2021-06-04 15:37:15
701	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-04 15:37:15	2021-06-04 15:37:15
702	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	55	2021-06-04 15:37:15	2021-06-04 15:37:15
703	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-04 15:37:15	2021-06-04 15:37:15
705	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-04 15:37:15	2021-06-04 15:37:15
706	Mgbi vous a assigné à la tâche date_insert.	f	57	54	2021-06-04 15:43:53	2021-06-04 15:43:53
707	Tâche nouvellement créee du nom de new_one par Mgbi dans le projet Premier test.	f	57	55	2021-06-05 10:54:41	2021-06-05 10:54:41
708	Tâche nouvellement créee du nom de new_one par Mgbi dans le projet Premier test.	f	57	53	2021-06-05 10:54:41	2021-06-05 10:54:41
710	Tâche nouvellement créee du nom de new_one par Mgbi dans le projet Premier test.	f	57	52	2021-06-05 10:54:41	2021-06-05 10:54:41
712	Tâche "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-06-05 10:54:57	2021-06-05 10:54:57
714	Tâche "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-06-05 10:54:57	2021-06-05 10:54:57
717	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	f	54	53	2021-06-05 12:32:16	2021-06-05 12:32:16
719	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	f	54	52	2021-06-05 12:32:16	2021-06-05 12:32:16
721	La requête Requête 2 est en cours	t	57	33	2021-06-05 18:51:10	2021-06-05 18:51:10
720	La requête Requête 2 a été mise en vu	t	57	33	2021-06-05 18:50:53	2021-06-05 18:50:53
722	La requête Requête 1 est en cours	t	57	33	2021-06-05 18:51:28	2021-06-05 18:51:28
723	La requête Requête flash a été mise en vu	t	57	33	2021-06-05 18:51:47	2021-06-05 18:51:47
724	La requête Requête flash a été non vue	t	57	33	2021-06-05 18:55:16	2021-06-05 18:55:16
725	La requête Requête 2 n'est pas en cours	t	57	33	2021-06-05 18:56:13	2021-06-05 18:56:13
715	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	57	2021-06-05 12:32:16	2021-06-05 12:32:16
704	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-06-04 15:37:15	2021-06-04 15:37:15
672	Le projet "Premier test" a été mise à jour par Mgbi	t	57	41	2021-06-01 19:58:39	2021-06-01 19:58:39
675	Le projet "Premier test" a été mise à jour par Mgbi	t	57	41	2021-06-01 21:03:38	2021-06-01 21:03:38
678	Le projet "Premier test" a été mise à jour par Mgbi	t	57	41	2021-06-01 21:04:02	2021-06-01 21:04:02
681	Le projet "Premier test" a été mise à jour par Mgbi	t	57	41	2021-06-01 21:10:32	2021-06-01 21:10:32
684	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-06-03 20:06:05	2021-06-03 20:06:05
711	Tâche "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	55	2021-06-05 10:54:57	2021-06-05 10:54:57
716	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	55	2021-06-05 12:32:16	2021-06-05 12:32:16
728	La requête Requête 1 n'est pas en cours	t	57	33	2021-06-05 18:56:34	2021-06-05 18:56:34
726	La requête Requête 2 a été non vue	t	57	33	2021-06-05 18:56:20	2021-06-05 18:56:20
727	La requête Requête 1 a été non vue	t	57	33	2021-06-05 18:56:24	2021-06-05 18:56:24
709	Tâche nouvellement créee du nom de new_one par Mgbi dans le projet Premier test.	t	57	41	2021-06-05 10:54:41	2021-06-05 10:54:41
713	Tâche "new_one"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-06-05 10:54:57	2021-06-05 10:54:57
718	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi1	t	54	41	2021-06-05 12:32:16	2021-06-05 12:32:16
583	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:55	2021-05-28 18:35:55
595	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:12	2021-05-28 18:36:12
604	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:15	2021-05-28 18:36:15
610	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:17	2021-05-28 18:36:17
613	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
649	Tâche "tache notif"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-31 19:09:02	2021-05-31 19:09:02
652	Tâche "children_length_test"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-31 19:19:44	2021-05-31 19:19:44
655	Tâche "notifs_length"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-31 19:19:45	2021-05-31 19:19:45
658	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-31 19:25:26	2021-05-31 19:25:26
568	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:38	2021-05-28 18:35:38
631	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:33	2021-05-28 18:36:33
586	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:35:56	2021-05-28 18:35:56
601	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:14	2021-05-28 18:36:14
622	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:27	2021-05-28 18:36:27
637	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:42	2021-05-28 18:36:42
574	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:35:41	2021-05-28 18:35:41
598	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:13	2021-05-28 18:36:13
607	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:16	2021-05-28 18:36:16
616	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
619	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	41	2021-05-28 18:36:22	2021-05-28 18:36:22
628	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:32	2021-05-28 18:36:32
643	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	t	52	41	2021-05-28 18:36:48	2021-05-28 18:36:48
571	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:35:40	2021-05-28 18:35:40
577	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:35:48	2021-05-28 18:35:48
589	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:36:01	2021-05-28 18:36:01
592	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:36:04	2021-05-28 18:36:04
625	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	t	52	41	2021-05-28 18:36:29	2021-05-28 18:36:29
634	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:35	2021-05-28 18:36:35
640	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	t	52	41	2021-05-28 18:36:44	2021-05-28 18:36:44
646	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	t	52	41	2021-05-28 18:36:50	2021-05-28 18:36:50
687	Tâche "89"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-06-04 15:13:59	2021-06-04 15:13:59
691	Tâche "EXEMPLE"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	41	2021-06-04 15:23:45	2021-06-04 15:23:45
696	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-06-04 15:37:09	2021-06-04 15:37:09
700	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-06-04 15:37:15	2021-06-04 15:37:15
544	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	t	52	41	2021-05-28 18:34:54	2021-05-28 18:34:54
373	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:54	2021-05-27 14:36:54
385	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:37:08	2021-05-27 14:37:08
391	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:37:15	2021-05-27 14:37:15
376	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:01	2021-05-27 14:37:01
427	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 14:39:53	2021-05-27 14:39:53
472	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:14:38	2021-05-27 18:14:38
493	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-27 23:36:09	2021-05-27 23:36:09
502	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:20:04	2021-05-28 18:20:04
526	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-28 18:33:37	2021-05-28 18:33:37
487	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-27 23:34:43	2021-05-27 23:34:43
505	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-28 18:20:06	2021-05-28 18:20:06
394	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:18	2021-05-27 14:37:18
415	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:37:27	2021-05-27 14:37:27
430	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:43:54	2021-05-27 14:43:54
454	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:04:08	2021-05-27 18:04:08
466	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 18:04:29	2021-05-27 18:04:29
490	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 23:36:07	2021-05-27 23:36:07
511	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:33:18	2021-05-28 18:33:18
352	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:46	2021-05-27 14:36:46
364	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:51	2021-05-27 14:36:51
460	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 18:04:22	2021-05-27 18:04:22
478	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	t	57	41	2021-05-27 18:15:28	2021-05-27 18:15:28
499	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 23:38:11	2021-05-27 23:38:11
514	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:33:22	2021-05-28 18:33:22
358	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:49	2021-05-27 14:36:49
379	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:02	2021-05-27 14:37:02
436	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 16:59:29	2021-05-27 16:59:29
469	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 18:04:31	2021-05-27 18:04:31
481	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 18:18:43	2021-05-27 18:18:43
496	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 23:38:08	2021-05-27 23:38:08
361	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:50	2021-05-27 14:36:50
370	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:36:53	2021-05-27 14:36:53
382	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:37:03	2021-05-27 14:37:03
412	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	41	2021-05-27 14:37:25	2021-05-27 14:37:25
439	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 17:53:57	2021-05-27 17:53:57
457	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 18:04:19	2021-05-27 18:04:19
517	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-28 18:33:26	2021-05-28 18:33:26
523	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-28 18:33:36	2021-05-28 18:33:36
310	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	t	53	41	2021-05-25 17:22:30	2021-05-25 17:22:30
313	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-26 20:16:28	2021-05-26 20:16:28
316	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 08:27:38	2021-05-27 08:27:38
334	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	t	57	41	2021-05-27 14:34:15	2021-05-27 14:34:15
346	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-27 14:34:38	2021-05-27 14:34:38
201	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
204	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
207	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:13	2021-05-22 10:07:13
228	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
231	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
234	Tâche "children_length_test"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-22 16:50:00	2021-05-22 16:50:00
237	Tâche "children_length_test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-22 16:50:03	2021-05-22 16:50:03
240	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-22 16:50:10	2021-05-22 16:50:10
243	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-22 16:50:12	2021-05-22 16:50:12
246	Tâche "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 19:29:05	2021-05-22 19:29:05
249	Tâche "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
252	Tâche "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
255	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-22 21:01:19	2021-05-22 21:01:19
261	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-22 21:01:24	2021-05-22 21:01:24
264	Tâche "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-23 13:49:26	2021-05-23 13:49:26
267	Tâche "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:38	2021-05-23 13:49:38
270	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:42	2021-05-23 13:49:42
273	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	41	2021-05-23 13:49:44	2021-05-23 13:49:44
276	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-23 13:49:48	2021-05-23 13:49:48
282	Tâche nouvellement créee du nom de tache notif par Mgbi dans le projet mon_projet.	t	57	41	2021-05-23 14:19:32	2021-05-23 14:19:32
285	Tâche "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	41	2021-05-23 14:39:34	2021-05-23 14:39:34
288	Tâche "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	t	57	41	2021-05-23 14:39:35	2021-05-23 14:39:35
291	Tâche "tache notif"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-23 14:39:36	2021-05-23 14:39:36
294	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-23 14:44:31	2021-05-23 14:44:31
297	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	41	2021-05-23 15:04:22	2021-05-23 15:04:22
300	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	41	2021-05-23 15:04:29	2021-05-23 15:04:29
303	Tâche "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	t	52	41	2021-05-23 15:07:37	2021-05-23 15:07:37
306	Tâche "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	t	52	41	2021-05-23 15:07:48	2021-05-23 15:07:48
730	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-06-05 20:39:15	2021-06-05 20:39:15
731	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-06-05 20:39:15	2021-06-05 20:39:15
732	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-06-05 20:39:15	2021-06-05 20:39:15
734	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-06-05 20:39:20	2021-06-05 20:39:20
735	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-06-05 20:39:20	2021-06-05 20:39:20
736	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-06-05 20:39:20	2021-06-05 20:39:20
729	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Mgbi	t	57	55	2021-06-05 20:39:15	2021-06-05 20:39:15
733	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	t	57	55	2021-06-05 20:39:20	2021-06-05 20:39:20
737	La requête Requête 1 a été vue	f	57	33	2021-06-07 14:41:08	2021-06-07 14:41:08
738	La requête Requête 1 est en cours	f	57	33	2021-06-07 14:41:13	2021-06-07 14:41:13
739	La requête Requête 1 n'est pas en cours	f	57	33	2021-06-07 14:41:16	2021-06-07 14:41:16
620	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:27	2021-05-28 18:36:27
617	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	t	52	57	2021-05-28 18:36:22	2021-05-28 18:36:22
626	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	t	52	57	2021-05-28 18:36:32	2021-05-28 18:36:32
743	Le client Eric de la société SOC a envoyé une requête intitulée "Notification?".	f	33	57	2021-06-07 20:43:47	2021-06-07 20:43:47
744	Le client Eric de la société SOC a envoyé une requête intitulée "Notification?".	f	33	41	2021-06-07 20:43:47	2021-06-07 20:43:47
745	Le client Eric de la société SOC a envoyé une requête intitulée "Notification?".	f	33	52	2021-06-07 20:43:47	2021-06-07 20:43:47
746	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:58:03	2021-06-08 07:58:03
747	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:58:03	2021-06-08 07:58:03
748	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:58:03	2021-06-08 07:58:03
749	Tâche "tâche test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-06-08 07:58:35	2021-06-08 07:58:35
750	Tâche "tâche test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-06-08 07:58:35	2021-06-08 07:58:35
751	Tâche "tâche test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-06-08 07:58:35	2021-06-08 07:58:35
752	Tâche "half_append"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:58:37	2021-06-08 07:58:37
753	Tâche "half_append"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:58:37	2021-06-08 07:58:37
754	Tâche "half_append"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:58:37	2021-06-08 07:58:37
755	Tâche "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-06-08 07:58:40	2021-06-08 07:58:40
756	Tâche "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-06-08 07:58:40	2021-06-08 07:58:40
757	Tâche "half_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-06-08 07:58:40	2021-06-08 07:58:40
758	Tâche "task_children"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:58:45	2021-06-08 07:58:45
759	Tâche "task_children"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:58:45	2021-06-08 07:58:45
760	Tâche "task_children"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:58:45	2021-06-08 07:58:45
761	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:58:48	2021-06-08 07:58:48
762	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:58:48	2021-06-08 07:58:48
763	Tâche "second_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:58:48	2021-06-08 07:58:48
764	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:58:57	2021-06-08 07:58:57
765	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:58:57	2021-06-08 07:58:57
766	Tâche "tâche test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:58:57	2021-06-08 07:58:57
767	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:59:02	2021-06-08 07:59:02
768	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:59:02	2021-06-08 07:59:02
769	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:59:02	2021-06-08 07:59:02
770	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-06-08 07:59:04	2021-06-08 07:59:04
771	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-06-08 07:59:04	2021-06-08 07:59:04
772	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-06-08 07:59:04	2021-06-08 07:59:04
773	Le client Eric de la société SOC a envoyé une requête intitulée "Fond d'écran".	f	33	57	2021-06-08 08:04:07	2021-06-08 08:04:07
774	Le client Eric de la société SOC a envoyé une requête intitulée "Fond d'écran".	f	33	41	2021-06-08 08:04:07	2021-06-08 08:04:07
775	Le client Eric de la société SOC a envoyé une requête intitulée "Fond d'écran".	f	33	52	2021-06-08 08:04:07	2021-06-08 08:04:07
776	La requête Fond d'écran est en cours	f	57	33	2021-06-08 08:04:26	2021-06-08 08:04:26
777	La requête Fond d'écran n'est pas en cours	f	57	33	2021-06-08 08:04:27	2021-06-08 08:04:27
781	La requête Fond d'écran a été non vue	f	57	33	2021-06-08 08:04:38	2021-06-08 08:04:38
778	La requête Fond d'écran a été vue	f	57	33	2021-06-08 08:04:30	2021-06-08 08:04:30
779	La requête Fond d'écran a été non vue	f	57	33	2021-06-08 08:04:32	2021-06-08 08:04:32
780	La requête Fond d'écran a été vue	f	57	33	2021-06-08 08:04:37	2021-06-08 08:04:37
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
14	Premier test	Kanbans test	9	2021-04-28	2021-04-30	48	0	2021-04-30	1	1	2021-04-28 13:17:31	2021-06-05 10:54:41	9
15	mon_projet	projet test pour afficher flash	51	2021-05-03	2021-05-03	24	0	2021-05-04	1	1	2021-05-03 09:59:21	2021-06-08 07:59:04	10
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

COPY public.tasks (id, title, progression, date_start, date_end, estimated_duration, performed_duration, deadline, parent_id, project_id, contributor_id, status_id, priority_id, inserted_at, updated_at, attributor_id, achieved_at) FROM stdin;
23	cinquième tâche secondaire pour first	0	2021-05-12	2021-05-13	5	0	2021-05-04	9	15	56	1	4	2021-05-11 12:12:04	2021-05-25 17:22:30	57	\N
41	date_insert	0	2021-05-27	\N	6	0	2021-05-28	\N	14	54	2	2	2021-05-27 14:25:57	2021-06-04 18:43:53	57	2021-05-27 21:18:43
5	cinquième	0	2021-04-30	\N	48	0	2021-05-01	\N	14	54	3	2	2021-04-29 08:37:56	2021-05-28 21:36:27	52	2021-05-28 21:35:13
3	une nouvelle	0	2021-04-29	\N	2	0	2021-04-30	\N	14	54	3	1	2021-04-29 06:27:21	2021-05-28 21:36:29	52	2021-05-28 21:35:16
30	assoc2nde	0	2021-05-12	2021-05-12	6	0	2021-05-11	16	15	56	1	1	2021-05-11 21:12:50	2021-05-25 03:27:25	57	\N
39	notifs_length	0	2021-05-23	2021-05-24	5	0	2021-05-12	33	15	56	1	2	2021-05-23 14:17:54	2021-05-31 22:19:45	57	\N
42	date_insert2	0	2021-05-27	\N	6	0	2021-05-28	\N	14	\N	1	2	2021-05-27 17:28:06	2021-06-05 23:39:20	57	2021-05-28 21:36:04
7	kanban	0	2021-05-01	\N	3	0	2021-05-08	\N	14	54	2	1	2021-05-01 13:07:10	2021-05-28 21:36:42	52	2021-05-28 21:35:40
44	new_one	0	2021-06-06	\N	6	0	2021-06-07	\N	14	\N	3	2	2021-06-05 13:54:41	2021-06-05 13:54:57	57	\N
1	Vraie tâche	0	2021-04-28	\N	48	0	2021-04-30	\N	14	54	1	3	2021-04-28 19:36:58	2021-05-28 21:36:50	52	2021-05-28 21:35:41
40	tache notif	0	2021-05-23	\N	6	0	2021-05-24	\N	15	\N	5	2	2021-05-23 14:19:32	2021-05-31 22:09:02	57	2021-05-31 22:09:02
37	notification_secondaire	0	2021-05-23	2021-05-24	2	0	2021-05-04	10	15	56	5	2	2021-05-23 14:13:06	2021-05-31 22:25:26	57	2021-05-31 22:25:26
12	tâche secondaire pour first task	0	2021-05-10	\N	10	0	2021-05-04	9	15	56	4	4	2021-05-10 11:04:55	2021-05-27 08:27:45	57	\N
26	test_append	0	2021-05-21	2021-05-22	5	0	2021-05-04	9	15	56	2	4	2021-05-11 12:34:43	2021-06-04 18:13:56	57	\N
24	children_length_test	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	1	4	2021-05-11 12:22:08	2021-05-31 22:19:44	57	\N
33	cerise sur le gâteau	0	2021-05-12	\N	8	0	2021-05-12	\N	15	56	3	2	2021-05-12 14:19:24	2021-05-31 22:29:16	57	\N
32	89	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	3	2	2021-05-12 13:59:05	2021-06-04 18:13:59	57	\N
36	TACHE POUR MATTHIEU	0	2021-05-17	\N	24	0	2021-05-18	\N	15	54	1	2	2021-05-17 13:52:18	2021-06-05 15:32:16	57	\N
11	EXEMPLE	0	2021-05-07	\N	45	0	2021-05-08	\N	14	54	1	2	2021-05-07 14:49:09	2021-06-04 18:24:08	57	\N
19	work	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	4	1	2021-05-11 10:08:44	2021-05-28 21:33:26	57	\N
10	second_task	100	2021-05-03	\N	10	0	2021-05-04	\N	15	56	5	2	2021-05-03 10:18:08	2021-06-08 10:58:48	57	2021-06-08 10:58:48
8	CHECK	0	2021-05-01	\N	2	0	2021-05-08	\N	14	54	5	2	2021-05-01 13:10:32	2021-06-04 18:37:14	52	2021-06-04 18:37:14
2	Seconde tâche	0	2021-04-29	\N	24	0	2021-04-30	\N	14	54	5	1	2021-04-29 06:25:23	2021-06-04 18:37:15	52	2021-06-04 18:37:15
31	primaire	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	5	2	2021-05-12 11:02:47	2021-05-28 21:33:36	57	2021-05-28 21:33:36
43	tâche test	0	2021-05-31	\N	5	0	2021-06-01	\N	15	\N	5	2	2021-05-31 22:27:05	2021-06-08 10:58:57	57	2021-06-08 10:58:57
34	dodosy	0	2021-05-15	\N	6	0	2021-05-16	\N	15	\N	5	3	2021-05-13 21:36:00	2021-05-28 21:33:37	57	2021-05-28 21:33:37
35	doudousy2	0	2021-05-14	\N	6	0	2021-05-15	\N	15	\N	5	2	2021-05-13 21:42:44	2021-05-28 21:33:41	57	2021-05-28 21:33:41
38	notif2	0	2021-05-23	2021-05-25	5	0	2021-05-12	33	15	56	3	2	2021-05-23 14:15:08	2021-05-23 14:39:35	57	\N
14	sans dt de fin	0	2021-05-10	\N	25	0	2021-05-13	\N	15	\N	5	2	2021-05-10 15:26:00	2021-06-08 10:59:02	57	2021-06-08 10:59:02
18	tacheee	0	2021-05-20	\N	55	0	2021-05-22	\N	15	56	2	3	2021-05-10 23:26:33	2021-06-05 15:45:26	57	\N
4	4eme	2	2021-05-01	\N	24	0	2021-04-30	\N	14	54	2	3	2021-04-29 08:37:15	2021-06-05 23:39:15	52	2021-05-28 21:34:54
27	append%2==1	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	4	4	2021-05-11 12:35:49	2021-05-17 13:55:19	57	\N
29	half_append	0	2021-05-11	2021-05-12	6	0	2021-05-04	9	15	56	3	4	2021-05-11 12:42:06	2021-06-08 10:58:40	57	2021-06-08 10:58:37
9	first_task	0	2021-05-03	\N	24	0	2021-05-04	\N	15	56	4	4	2021-05-03 10:07:31	2021-06-08 07:58:40	57	\N
20	task_children	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	5	2	2021-05-11 10:39:51	2021-06-08 10:58:45	57	2021-06-08 10:58:45
16	ectoassoc	0	2021-05-11	\N	5	0	2021-05-11	\N	15	56	5	1	2021-05-10 23:15:14	2021-06-08 10:59:04	57	2021-06-08 10:59:04
6	pubsub	0	2021-05-01	\N	50	0	2021-05-08	\N	14	54	4	3	2021-05-01 13:00:55	2021-05-28 21:36:12	52	2021-05-28 21:36:01
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, profile_picture, email, password, right_id, inserted_at, updated_at) FROM stdin;
57	Mgbi	images/profiles/Mgbi-profile.png	admin@mgbi	$2b$12$ppF6QKRLMia3lvzr1XY3C.fXB0Qv5WB4M8a.o6Pe96TI3Sxw1ETbC	1	2021-05-01 21:28:30	2021-06-08 07:37:42
33	Eric	images/profiles/Eric-profile.png	eric@soc	$2b$12$aK2fjkTDZh6ULSz5GmZCh.vA0OOWhnSI0quNwDOavdCN831CNg7uq	4	2021-03-26 06:37:02	2021-06-08 07:45:45
58	Marc	images/profiles/Marc-profile.png	marc@comp	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	4	2021-05-02 13:24:25	2021-06-04 15:06:15
54	Mgbi1	images/profiles/Mgbi1-profile.png	contributeur@mgbi	$2b$12$sxaYg4bRhFyE7RDn0gaXcOlDkEnhOoPFpB./8Ir.RDNKR85vsv6nK	3	2021-04-13 11:38:03	2021-06-04 15:06:48
56	Mgbi2	images/profiles/Mgbi2-profile.png	contributeur2@mgbi	$2b$12$xjnYOEvFZyi6ky2vB8HGCO//zHlN8lqg56hBeGE/ezDgqB/z01Z8a	3	2021-05-01 18:12:11	2021-06-04 15:07:05
53	Attributeur	images/profiles/Attributeur-profile.png	mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	2	2021-04-13 11:30:16	2021-06-04 15:11:40
41	Test	images/profiles/Test-profile.png	test@test	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	1	2021-03-30 18:00:03	2021-06-04 15:12:36
52	Admin	images/profiles/Admin-profile.png	admin@myadmin	$2b$12$3yngeegsjEEifTOEZDSfAeOXnuyBOkCfjGUN.7GdIW1A57mD6tKqO	1	2021-04-13 08:28:09	2021-06-04 15:13:25
55	Jesuisarchivé	images/profiles/Jesuisarchivé-profile.png	archivé@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	100	2021-04-13 11:46:26	2021-06-05 21:00:52
25	Profilnonattribué	images/profiles/Profilnonattribué-profile.png	nonattribuée@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	5	2021-03-25 11:09:44	2021-06-05 21:01:06
\.


--
-- Name: active_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_clients_id_seq', 7, true);


--
-- Name: assist_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assist_contracts_id_seq', 7, true);


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.boards_id_seq', 10, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 48, true);


--
-- Name: clients_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_requests_id_seq', 26, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 68, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 9, true);


--
-- Name: editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editors_id_seq', 7, true);


--
-- Name: licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licenses_id_seq', 5, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 781, true);


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

SELECT pg_catalog.setval('public.softwares_id_seq', 4, true);


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

SELECT pg_catalog.setval('public.tasks_id_seq', 44, true);


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
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


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
