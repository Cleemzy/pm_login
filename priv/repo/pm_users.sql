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
15	EXEMPLE	40	0	2021-05-07 14:49:09	2021-05-27 18:04:31	11
45	date_insert	40	1	2021-05-27 14:25:58	2021-05-27 18:18:43	41
10	pubsub	39	2	2021-05-01 13:00:55	2021-05-28 18:36:12	6
22	tacheee	42	1	2021-05-10 23:26:33	2021-05-28 18:34:25	18
40	TACHE POUR MATTHIEU	42	6	2021-05-17 13:52:19	2021-05-28 18:34:23	36
28	children_length_test	42	4	2021-05-11 12:22:08	2021-05-23 13:49:26	24
43	notifs_length	42	5	2021-05-23 14:17:54	2021-05-23 14:39:34	39
14	second_task	42	3	2021-05-03 10:18:08	2021-05-22 21:01:22	10
37	cerise sur le gâteau	42	2	2021-05-12 14:19:24	2021-05-28 18:34:26	33
33	half_append	43	5	2021-05-11 12:42:06	2021-05-21 09:53:45	29
42	notif2	43	4	2021-05-23 14:15:08	2021-05-23 14:39:35	38
20	ectoassoc	43	3	2021-05-10 23:15:14	2021-05-27 23:36:09	16
6	Seconde tâche	39	1	2021-04-29 06:25:23	2021-05-28 18:36:18	2
12	CHECK	39	0	2021-05-01 13:10:32	2021-05-28 18:36:21	8
9	cinquième	38	0	2021-04-29 08:37:56	2021-05-28 18:36:27	5
7	une nouvelle	38	1	2021-04-29 06:27:21	2021-05-28 18:36:29	3
46	date_insert2	37	0	2021-05-27 14:28:06	2021-05-28 18:36:35	42
11	kanban	37	1	2021-05-01 13:07:10	2021-05-28 18:36:42	7
8	4eme	36	0	2021-04-29 08:37:15	2021-05-28 18:36:48	4
1	Vraie tâche	36	1	2021-04-28 19:36:59	2021-05-28 18:36:50	1
36	89	42	0	2021-05-12 13:59:05	2021-05-25 17:22:22	32
34	assoc2nde	41	1	2021-05-11 21:12:51	2021-05-23 15:07:48	30
27	cinquième tâche secondaire pour first	41	0	2021-05-11 12:12:04	2021-05-25 17:22:30	23
18	sans dt de fin	44	3	2021-05-10 15:26:00	2021-05-21 11:58:41	14
24	task_children	43	2	2021-05-11 10:39:51	2021-05-22 21:01:17	20
31	append%2==1	44	2	2021-05-11 12:35:49	2021-05-17 13:55:19	27
30	test_append	43	0	2021-05-11 12:34:43	2021-05-26 20:14:51	26
23	work	44	1	2021-05-11 10:08:44	2021-05-28 18:33:26	19
13	first_task	44	0	2021-05-03 10:07:31	2021-05-28 18:33:31	9
35	primaire	45	0	2021-05-12 11:02:47	2021-05-28 18:33:36	31
38	dodosy	45	1	2021-05-13 21:36:00	2021-05-28 18:33:37	34
44	tache notif	44	4	2021-05-23 14:19:32	2021-05-23 14:39:36	40
41	notification_secondaire	44	5	2021-05-23 14:13:06	2021-05-27 08:27:38	37
16	tâche secondaire pour first task	44	6	2021-05-10 11:04:55	2021-05-27 08:27:45	12
39	doudousy2	45	2	2021-05-13 21:42:44	2021-05-28 18:33:41	35
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
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.licenses (id, title, date_start, date_end, company_id, inserted_at, updated_at) FROM stdin;
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
310	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	f	53	41	2021-05-25 17:22:30	2021-05-25 17:22:30
4	Notification 1	t	57	56	2021-05-18 11:39:55	2021-05-18 11:39:55
309	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Attributeur	t	53	57	2021-05-25 17:22:30	2021-05-25 17:22:30
311	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-26 20:16:28	2021-05-26 20:16:28
312	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-26 20:16:28	2021-05-26 20:16:28
313	Tâche "first_task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-26 20:16:28	2021-05-26 20:16:28
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
316	Tâche "notification_secondaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 08:27:38	2021-05-27 08:27:38
332	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:15	2021-05-27 14:34:15
333	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:15	2021-05-27 14:34:15
334	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:34:15	2021-05-27 14:34:15
371	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:54	2021-05-27 14:36:54
372	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:54	2021-05-27 14:36:54
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
319	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 08:27:45	2021-05-27 08:27:45
373	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:54	2021-05-27 14:36:54
383	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:08	2021-05-27 14:37:08
384	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:08	2021-05-27 14:37:08
385	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:37:08	2021-05-27 14:37:08
389	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:15	2021-05-27 14:37:15
390	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:15	2021-05-27 14:37:15
391	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:37:15	2021-05-27 14:37:15
398	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:21	2021-05-27 14:37:21
399	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:21	2021-05-27 14:37:21
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
322	Tâche nouvellement créee du nom de date_insert par Mgbi dans le projet Premier test.	f	57	41	2021-05-27 14:25:58	2021-05-27 14:25:58
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
328	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
344	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:34:38	2021-05-27 14:34:38
345	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:34:38	2021-05-27 14:34:38
346	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:34:38	2021-05-27 14:34:38
375	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:01	2021-05-27 14:37:01
376	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:01	2021-05-27 14:37:01
425	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:39:53	2021-05-27 14:39:53
426	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:39:53	2021-05-27 14:39:53
427	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 14:39:53	2021-05-27 14:39:53
440	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 17:54:08	2021-05-27 17:54:08
441	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 17:54:08	2021-05-27 17:54:08
163	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:26	2021-05-21 11:58:26
147	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:57:35	2021-05-21 11:57:35
165	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:26	2021-05-21 11:58:26
146	Tâche "sans dt de fin"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:57:35	2021-05-21 11:57:35
164	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:26	2021-05-21 11:58:26
323	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	52	2021-05-27 14:28:06	2021-05-27 14:28:06
324	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	53	2021-05-27 14:28:06	2021-05-27 14:28:06
325	Tâche nouvellement créee du nom de date_insert2 par Mgbi dans le projet Premier test.	f	57	41	2021-05-27 14:28:06	2021-05-27 14:28:06
395	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:19	2021-05-27 14:37:19
396	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:19	2021-05-27 14:37:19
397	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:19	2021-05-27 14:37:19
401	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:22	2021-05-27 14:37:22
402	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:22	2021-05-27 14:37:22
403	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 14:37:22	2021-05-27 14:37:22
442	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 17:54:08	2021-05-27 17:54:08
518	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:31	2021-05-28 18:33:31
519	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:31	2021-05-28 18:33:31
520	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:33:31	2021-05-28 18:33:31
552	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:13	2021-05-28 18:35:13
553	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:35:13	2021-05-28 18:35:13
554	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:35:16	2021-05-28 18:35:16
555	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:16	2021-05-28 18:35:16
556	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:35:16	2021-05-28 18:35:16
581	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:55	2021-05-28 18:35:55
582	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:55	2021-05-28 18:35:55
583	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:55	2021-05-28 18:35:55
593	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:12	2021-05-28 18:36:12
594	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:12	2021-05-28 18:36:12
595	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:12	2021-05-28 18:36:12
602	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:15	2021-05-28 18:36:15
603	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:15	2021-05-28 18:36:15
604	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:15	2021-05-28 18:36:15
608	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:17	2021-05-28 18:36:17
609	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:17	2021-05-28 18:36:17
610	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:17	2021-05-28 18:36:17
611	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
612	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
613	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
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
331	Tâche "date_insert"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-05-27 14:28:10	2021-05-27 14:28:10
400	Tâche "pubsub"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:21	2021-05-27 14:37:21
443	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:58:51	2021-05-27 17:58:51
444	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:58:51	2021-05-27 17:58:51
445	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 17:58:51	2021-05-27 17:58:51
470	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:14:38	2021-05-27 18:14:38
471	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:14:38	2021-05-27 18:14:38
472	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 18:14:38	2021-05-27 18:14:38
491	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:36:09	2021-05-27 23:36:09
492	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:36:09	2021-05-27 23:36:09
493	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-27 23:36:09	2021-05-27 23:36:09
500	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:20:04	2021-05-28 18:20:04
501	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:20:04	2021-05-28 18:20:04
502	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:20:04	2021-05-28 18:20:04
524	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:37	2021-05-28 18:33:37
525	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:37	2021-05-28 18:33:37
526	Tâche "dodosy"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-28 18:33:37	2021-05-28 18:33:37
557	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:35:27	2021-05-28 18:35:27
558	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:27	2021-05-28 18:35:27
559	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:35:27	2021-05-28 18:35:27
566	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:38	2021-05-28 18:35:38
567	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:38	2021-05-28 18:35:38
568	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:38	2021-05-28 18:35:38
629	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:36:33	2021-05-28 18:36:33
630	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:33	2021-05-28 18:36:33
631	Tâche "kanban"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:36:33	2021-05-28 18:36:33
635	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	f	52	57	2021-05-28 18:36:42	2021-05-28 18:36:42
636	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:42	2021-05-28 18:36:42
160	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:25	2021-05-21 11:58:25
184	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:45	2021-05-21 11:58:45
162	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:25	2021-05-21 11:58:25
186	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:45	2021-05-21 11:58:45
161	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:25	2021-05-21 11:58:25
185	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:45	2021-05-21 11:58:45
335	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:34:23	2021-05-27 14:34:23
336	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:34:23	2021-05-27 14:34:23
337	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:34:23	2021-05-27 14:34:23
407	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:24	2021-05-27 14:37:24
408	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:24	2021-05-27 14:37:24
409	Tâche "date_insert2"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 14:37:24	2021-05-27 14:37:24
446	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:59:07	2021-05-27 17:59:07
447	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:59:07	2021-05-27 17:59:07
448	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 17:59:07	2021-05-27 17:59:07
473	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:15:03	2021-05-27 18:15:03
474	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:15:03	2021-05-27 18:15:03
475	Tâche "date_insert"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 18:15:03	2021-05-27 18:15:03
482	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 23:14:48	2021-05-27 23:14:48
483	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 23:14:48	2021-05-27 23:14:48
484	Tâche "ectoassoc"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 23:14:48	2021-05-27 23:14:48
485	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-27 23:34:43	2021-05-27 23:34:43
486	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	53	2021-05-27 23:34:43	2021-05-27 23:34:43
487	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-27 23:34:43	2021-05-27 23:34:43
503	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:20:06	2021-05-28 18:20:06
504	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:20:06	2021-05-28 18:20:06
505	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-28 18:20:06	2021-05-28 18:20:06
530	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:23	2021-05-28 18:34:23
531	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:23	2021-05-28 18:34:23
532	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-28 18:34:23	2021-05-28 18:34:23
545	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:08	2021-05-28 18:35:08
546	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:08	2021-05-28 18:35:08
547	Tâche "cinquième"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:08	2021-05-28 18:35:08
560	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:35:28	2021-05-28 18:35:28
561	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:35:28	2021-05-28 18:35:28
562	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:35:28	2021-05-28 18:35:28
578	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	f	52	57	2021-05-28 18:35:49	2021-05-28 18:35:49
579	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:49	2021-05-28 18:35:49
580	Tâche "pubsub"\n          du projet Premier test mise dans " En attente " par Admin	f	52	41	2021-05-28 18:35:49	2021-05-28 18:35:49
584	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:56	2021-05-28 18:35:56
585	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:56	2021-05-28 18:35:56
586	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:56	2021-05-28 18:35:56
599	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:14	2021-05-28 18:36:14
600	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:14	2021-05-28 18:36:14
601	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:14	2021-05-28 18:36:14
620	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:36:27	2021-05-28 18:36:27
621	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:27	2021-05-28 18:36:27
622	Tâche "cinquième"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:36:27	2021-05-28 18:36:27
637	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Admin	f	52	41	2021-05-28 18:36:42	2021-05-28 18:36:42
644	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	f	52	57	2021-05-28 18:36:50	2021-05-28 18:36:50
645	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:50	2021-05-28 18:36:50
169	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	52	2021-05-21 11:58:35	2021-05-21 11:58:35
178	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
171	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	41	2021-05-21 11:58:35	2021-05-21 11:58:35
180	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
170	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	t	57	53	2021-05-21 11:58:35	2021-05-21 11:58:35
179	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
338	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:25	2021-05-27 14:34:25
339	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:25	2021-05-27 14:34:25
340	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:34:25	2021-05-27 14:34:25
341	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:34:37	2021-05-27 14:34:37
342	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:34:37	2021-05-27 14:34:37
343	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:34:37	2021-05-27 14:34:37
419	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:36	2021-05-27 14:37:36
420	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:36	2021-05-27 14:37:36
421	Tâche "pubsub"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-05-27 14:37:36	2021-05-27 14:37:36
449	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 17:59:09	2021-05-27 17:59:09
450	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 17:59:09	2021-05-27 17:59:09
451	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 17:59:09	2021-05-27 17:59:09
461	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:27	2021-05-27 18:04:27
462	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:27	2021-05-27 18:04:27
463	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 18:04:27	2021-05-27 18:04:27
506	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:12	2021-05-28 18:33:12
507	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:12	2021-05-28 18:33:12
508	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:33:12	2021-05-28 18:33:12
533	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:25	2021-05-28 18:34:25
534	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:25	2021-05-28 18:34:25
535	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-28 18:34:25	2021-05-28 18:34:25
563	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:37	2021-05-28 18:35:37
564	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:37	2021-05-28 18:35:37
565	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:37	2021-05-28 18:35:37
572	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:35:41	2021-05-28 18:35:41
573	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:41	2021-05-28 18:35:41
574	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:35:41	2021-05-28 18:35:41
596	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:13	2021-05-28 18:36:13
597	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:13	2021-05-28 18:36:13
598	Tâche "date_insert2"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:13	2021-05-28 18:36:13
605	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:16	2021-05-28 18:36:16
606	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:16	2021-05-28 18:36:16
607	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:16	2021-05-28 18:36:16
614	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:18	2021-05-28 18:36:18
615	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:18	2021-05-28 18:36:18
616	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:18	2021-05-28 18:36:18
617	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:36:22	2021-05-28 18:36:22
618	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:36:22	2021-05-28 18:36:22
619	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:36:22	2021-05-28 18:36:22
626	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:36:32	2021-05-28 18:36:32
627	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:32	2021-05-28 18:36:32
628	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:36:32	2021-05-28 18:36:32
641	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	f	52	57	2021-05-28 18:36:48	2021-05-28 18:36:48
642	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	f	52	53	2021-05-28 18:36:48	2021-05-28 18:36:48
643	Tâche "4eme"\n          du projet Premier test mise dans " A faire " par Admin	f	52	41	2021-05-28 18:36:48	2021-05-28 18:36:48
181	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	52	2021-05-21 11:58:43	2021-05-21 11:58:43
183	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	41	2021-05-21 11:58:43	2021-05-21 11:58:43
182	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	t	57	53	2021-05-21 11:58:43	2021-05-21 11:58:43
347	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:36:43	2021-05-27 14:36:43
348	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:36:43	2021-05-27 14:36:43
349	Tâche "CHECK"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:36:43	2021-05-27 14:36:43
365	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:52	2021-05-27 14:36:52
366	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:52	2021-05-27 14:36:52
367	Tâche "une nouvelle"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:52	2021-05-27 14:36:52
386	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:37:11	2021-05-27 14:37:11
387	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:37:11	2021-05-27 14:37:11
388	Tâche "Vraie tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:37:11	2021-05-27 14:37:11
392	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:18	2021-05-27 14:37:18
393	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:18	2021-05-27 14:37:18
394	Tâche "4eme"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:18	2021-05-27 14:37:18
413	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:27	2021-05-27 14:37:27
414	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:27	2021-05-27 14:37:27
415	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-05-27 14:37:27	2021-05-27 14:37:27
428	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:43:54	2021-05-27 14:43:54
429	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:43:54	2021-05-27 14:43:54
430	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:43:54	2021-05-27 14:43:54
452	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:04:08	2021-05-27 18:04:08
453	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:04:08	2021-05-27 18:04:08
454	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 18:04:08	2021-05-27 18:04:08
464	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:04:29	2021-05-27 18:04:29
465	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:04:29	2021-05-27 18:04:29
466	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 18:04:29	2021-05-27 18:04:29
488	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 23:36:07	2021-05-27 23:36:07
489	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 23:36:07	2021-05-27 23:36:07
490	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 23:36:07	2021-05-27 23:36:07
509	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:18	2021-05-28 18:33:18
510	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:18	2021-05-28 18:33:18
511	Tâche "dodosy"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:33:18	2021-05-28 18:33:18
536	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-28 18:34:26	2021-05-28 18:34:26
537	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	53	2021-05-28 18:34:26	2021-05-28 18:34:26
538	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-28 18:34:26	2021-05-28 18:34:26
539	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:34:51	2021-05-28 18:34:51
540	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:34:51	2021-05-28 18:34:51
541	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:34:51	2021-05-28 18:34:51
542	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:34:54	2021-05-28 18:34:54
543	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:34:54	2021-05-28 18:34:54
544	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:34:54	2021-05-28 18:34:54
569	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:35:40	2021-05-28 18:35:40
570	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:35:40	2021-05-28 18:35:40
571	Tâche "kanban"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:35:40	2021-05-28 18:35:40
575	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	57	2021-05-28 18:35:48	2021-05-28 18:35:48
576	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:35:48	2021-05-28 18:35:48
577	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	41	2021-05-28 18:35:48	2021-05-28 18:35:48
590	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:36:04	2021-05-28 18:36:04
591	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:36:04	2021-05-28 18:36:04
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
352	Tâche "CHECK"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:46	2021-05-27 14:36:46
195	Tâche "test_append"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:08	2021-05-22 10:07:08
196	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:10	2021-05-22 10:07:10
362	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:51	2021-05-27 14:36:51
198	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:10	2021-05-22 10:07:10
199	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
363	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:51	2021-05-27 14:36:51
201	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
202	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-22 10:07:12	2021-05-22 10:07:12
364	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:51	2021-05-27 14:36:51
204	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:12	2021-05-22 10:07:12
205	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 10:07:13	2021-05-22 10:07:13
374	Tâche "Vraie tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:01	2021-05-27 14:37:01
207	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:13	2021-05-22 10:07:13
210	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
208	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
209	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	53	2021-05-22 10:07:14	2021-05-22 10:07:14
353	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:48	2021-05-27 14:36:48
354	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:48	2021-05-27 14:36:48
355	Tâche "4eme"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:48	2021-05-27 14:36:48
404	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 14:37:23	2021-05-27 14:37:23
405	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 14:37:23	2021-05-27 14:37:23
406	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 14:37:23	2021-05-27 14:37:23
416	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	52	2021-05-27 14:37:34	2021-05-27 14:37:34
417	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	53	2021-05-27 14:37:34	2021-05-27 14:37:34
418	Tâche "date_insert2"\n          du projet Premier test mise dans " A faire " par Mgbi	f	57	41	2021-05-27 14:37:34	2021-05-27 14:37:34
422	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:38:25	2021-05-27 14:38:25
423	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:38:25	2021-05-27 14:38:25
424	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:38:25	2021-05-27 14:38:25
431	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 16:33:39	2021-05-27 16:33:39
432	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 16:33:39	2021-05-27 16:33:39
433	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 16:33:39	2021-05-27 16:33:39
458	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:22	2021-05-27 18:04:22
459	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:22	2021-05-27 18:04:22
460	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 18:04:22	2021-05-27 18:04:22
476	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	52	2021-05-27 18:15:28	2021-05-27 18:15:28
477	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	53	2021-05-27 18:15:28	2021-05-27 18:15:28
478	Tâche "date_insert"\n          du projet Premier test mise dans " En cours " par Mgbi	f	57	41	2021-05-27 18:15:28	2021-05-27 18:15:28
497	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 23:38:11	2021-05-27 23:38:11
498	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 23:38:11	2021-05-27 23:38:11
499	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 23:38:11	2021-05-27 23:38:11
512	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:22	2021-05-28 18:33:22
513	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:22	2021-05-28 18:33:22
514	Tâche "doudousy2"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:33:22	2021-05-28 18:33:22
527	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:41	2021-05-28 18:33:41
528	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:41	2021-05-28 18:33:41
529	Tâche "doudousy2"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-28 18:33:41	2021-05-28 18:33:41
548	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	57	2021-05-28 18:35:09	2021-05-28 18:35:09
549	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	53	2021-05-28 18:35:09	2021-05-28 18:35:09
550	Tâche "une nouvelle"\n          du projet Premier test mise dans " En contrôle " par Admin	f	52	41	2021-05-28 18:35:09	2021-05-28 18:35:09
587	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:36:01	2021-05-28 18:36:01
588	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	53	2021-05-28 18:36:01	2021-05-28 18:36:01
589	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:36:01	2021-05-28 18:36:01
592	Tâche "date_insert2"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	41	2021-05-28 18:36:04	2021-05-28 18:36:04
623	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	f	52	57	2021-05-28 18:36:29	2021-05-28 18:36:29
624	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	f	52	53	2021-05-28 18:36:29	2021-05-28 18:36:29
625	Tâche "une nouvelle"\n          du projet Premier test mise dans " En cours " par Admin	f	52	41	2021-05-28 18:36:29	2021-05-28 18:36:29
632	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	57	2021-05-28 18:36:35	2021-05-28 18:36:35
633	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:35	2021-05-28 18:36:35
634	Tâche "date_insert2"\n          du projet Premier test mise dans " En attente " par Admin	f	52	41	2021-05-28 18:36:35	2021-05-28 18:36:35
638	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	f	52	57	2021-05-28 18:36:44	2021-05-28 18:36:44
639	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	f	52	53	2021-05-28 18:36:44	2021-05-28 18:36:44
640	Tâche "4eme"\n          du projet Premier test mise dans " En attente " par Admin	f	52	41	2021-05-28 18:36:44	2021-05-28 18:36:44
646	Tâche "Vraie tâche"\n          du projet Premier test mise dans " A faire " par Admin	f	52	41	2021-05-28 18:36:50	2021-05-28 18:36:50
356	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:49	2021-05-27 14:36:49
213	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:14	2021-05-22 10:07:14
357	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:49	2021-05-27 14:36:49
216	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
358	Tâche "pubsub"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:49	2021-05-27 14:36:49
219	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:15	2021-05-22 10:07:15
377	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:02	2021-05-27 14:37:02
222	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:16	2021-05-22 10:07:16
378	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:02	2021-05-27 14:37:02
225	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:17	2021-05-22 10:07:17
379	Tâche "kanban"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:02	2021-05-27 14:37:02
228	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
434	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 16:59:29	2021-05-27 16:59:29
231	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 10:07:18	2021-05-22 10:07:18
220	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:16	2021-05-22 10:07:16
223	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:17	2021-05-22 10:07:17
226	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
229	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:18	2021-05-22 10:07:18
211	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:14	2021-05-22 10:07:14
214	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
217	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Mgbi	t	57	52	2021-05-22 10:07:15	2021-05-22 10:07:15
232	Tâche "children_length_test"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-22 16:50:00	2021-05-22 16:50:00
435	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 16:59:29	2021-05-27 16:59:29
234	Tâche "children_length_test"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-22 16:50:00	2021-05-22 16:50:00
235	Tâche "children_length_test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-22 16:50:03	2021-05-22 16:50:03
436	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 16:59:29	2021-05-27 16:59:29
237	Tâche "children_length_test"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-22 16:50:03	2021-05-22 16:50:03
238	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-22 16:50:10	2021-05-22 16:50:10
467	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:04:31	2021-05-27 18:04:31
240	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-22 16:50:10	2021-05-22 16:50:10
241	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-22 16:50:12	2021-05-22 16:50:12
468	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:04:31	2021-05-27 18:04:31
243	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-22 16:50:12	2021-05-22 16:50:12
244	Tâche "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 19:29:05	2021-05-22 19:29:05
469	Tâche "EXEMPLE"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 18:04:31	2021-05-27 18:04:31
246	Tâche "test_append"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-22 19:29:05	2021-05-22 19:29:05
247	Tâche "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
479	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 18:18:43	2021-05-27 18:18:43
249	Tâche "task_children"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
250	Tâche "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:17	2021-05-22 21:01:17
480	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 18:18:43	2021-05-27 18:18:43
252	Tâche "89"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 21:01:17	2021-05-22 21:01:17
253	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-22 21:01:19	2021-05-22 21:01:19
481	Tâche "date_insert"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 18:18:43	2021-05-27 18:18:43
255	Tâche "ectoassoc"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-22 21:01:19	2021-05-22 21:01:19
256	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:23	2021-05-22 21:01:23
494	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 23:38:08	2021-05-27 23:38:08
495	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 23:38:08	2021-05-27 23:38:08
496	Tâche "primaire"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 23:38:08	2021-05-27 23:38:08
258	Tâche "second_task"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 21:01:23	2021-05-22 21:01:23
259	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-22 21:01:24	2021-05-22 21:01:24
261	Tâche "tacheee"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-22 21:01:24	2021-05-22 21:01:24
262	Tâche "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 13:49:26	2021-05-23 13:49:26
264	Tâche "children_length_test"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-23 13:49:26	2021-05-23 13:49:26
265	Tâche "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:38	2021-05-23 13:49:38
267	Tâche "tacheee"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-23 13:49:38	2021-05-23 13:49:38
268	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:42	2021-05-23 13:49:42
270	Tâche "cerise sur le gâteau"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-23 13:49:42	2021-05-23 13:49:42
271	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	52	2021-05-23 13:49:44	2021-05-23 13:49:44
273	Tâche "TACHE POUR MATTHIEU"\n          du projet mon_projet mise dans " A faire " par Mgbi	f	57	41	2021-05-23 13:49:44	2021-05-23 13:49:44
274	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-23 13:49:48	2021-05-23 13:49:48
276	Tâche "first_task"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-23 13:49:48	2021-05-23 13:49:48
280	Tâche nouvellement créee du nom de tache notif par Mgbi dans le projet mon_projet.	f	57	52	2021-05-23 14:19:32	2021-05-23 14:19:32
282	Tâche nouvellement créee du nom de tache notif par Mgbi dans le projet mon_projet.	f	57	41	2021-05-23 14:19:32	2021-05-23 14:19:32
283	Tâche "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	52	2021-05-23 14:39:34	2021-05-23 14:39:34
285	Tâche "notifs_length"\n          du projet mon_projet mise dans " En attente " par Mgbi	f	57	41	2021-05-23 14:39:34	2021-05-23 14:39:34
286	Tâche "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	52	2021-05-23 14:39:35	2021-05-23 14:39:35
288	Tâche "notif2"\n          du projet mon_projet mise dans " En cours " par Mgbi	f	57	41	2021-05-23 14:39:35	2021-05-23 14:39:35
289	Tâche "tache notif"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-23 14:39:36	2021-05-23 14:39:36
291	Tâche "tache notif"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-23 14:39:36	2021-05-23 14:39:36
292	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-23 14:44:31	2021-05-23 14:44:31
294	Tâche "tâche secondaire pour first task"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-23 14:44:31	2021-05-23 14:44:31
359	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:50	2021-05-27 14:36:50
297	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " A faire " par Admin	f	52	41	2021-05-23 15:04:22	2021-05-23 15:04:22
360	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-27 14:36:50	2021-05-27 14:36:50
300	Tâche "cinquième tâche secondaire pour first"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	41	2021-05-23 15:04:29	2021-05-23 15:04:29
361	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:50	2021-05-27 14:36:50
303	Tâche "assoc2nde"\n          du projet mon_projet mise dans " En attente " par Admin	f	52	41	2021-05-23 15:07:37	2021-05-23 15:07:37
368	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-27 14:36:53	2021-05-27 14:36:53
306	Tâche "assoc2nde"\n          du projet mon_projet mise dans " A faire " par Admin	f	52	41	2021-05-23 15:07:48	2021-05-23 15:07:48
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
370	Tâche "Seconde tâche"\n          du projet Premier test mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-27 14:36:53	2021-05-27 14:36:53
380	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 14:37:03	2021-05-27 14:37:03
381	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 14:37:03	2021-05-27 14:37:03
382	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 14:37:03	2021-05-27 14:37:03
410	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	52	2021-05-27 14:37:25	2021-05-27 14:37:25
411	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	53	2021-05-27 14:37:25	2021-05-27 14:37:25
412	Tâche "kanban"\n          du projet Premier test mise dans " En attente " par Mgbi	f	57	41	2021-05-27 14:37:25	2021-05-27 14:37:25
437	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 17:53:57	2021-05-27 17:53:57
438	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 17:53:57	2021-05-27 17:53:57
439	Tâche "Seconde tâche"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 17:53:57	2021-05-27 17:53:57
455	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	52	2021-05-27 18:04:19	2021-05-27 18:04:19
456	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	53	2021-05-27 18:04:19	2021-05-27 18:04:19
457	Tâche "EXEMPLE"\n          du projet Premier test mise dans " En contrôle " par Mgbi	f	57	41	2021-05-27 18:04:19	2021-05-27 18:04:19
515	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	52	2021-05-28 18:33:26	2021-05-28 18:33:26
516	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	53	2021-05-28 18:33:26	2021-05-28 18:33:26
517	Tâche "work"\n          du projet mon_projet mise dans " En contrôle " par Mgbi	f	57	41	2021-05-28 18:33:26	2021-05-28 18:33:26
521	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	52	2021-05-28 18:33:36	2021-05-28 18:33:36
522	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	53	2021-05-28 18:33:36	2021-05-28 18:33:36
523	Tâche "primaire"\n          du projet mon_projet mise dans " Achevée(s) " par Mgbi	f	57	41	2021-05-28 18:33:36	2021-05-28 18:33:36
551	Tâche "cinquième"\n          du projet Premier test mise dans " Achevée(s) " par Admin	f	52	57	2021-05-28 18:35:13	2021-05-28 18:35:13
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
15	mon_projet	projet test pour afficher flash	21	2021-05-03	2021-05-03	24	0	2021-05-04	1	1	2021-05-03 09:59:21	2021-05-28 18:33:41	10
14	Premier test	Kanbans test	19	2021-04-28	2021-04-30	48	0	2021-04-30	1	1	2021-04-28 13:17:31	2021-05-28 18:36:22	9
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

COPY public.tasks (id, title, progression, date_start, date_end, estimated_duration, performed_duration, deadline, parent_id, project_id, contributor_id, status_id, priority_id, inserted_at, updated_at, attributor_id, achieved_at) FROM stdin;
29	half_append	0	2021-05-11	2021-05-12	6	0	2021-05-04	9	15	56	3	4	2021-05-11 12:42:06	2021-05-12 13:57:27	57	\N
23	cinquième tâche secondaire pour first	0	2021-05-12	2021-05-13	5	0	2021-05-04	9	15	56	1	4	2021-05-11 12:12:04	2021-05-25 17:22:30	57	\N
11	EXEMPLE	0	2021-05-07	\N	45	0	2021-05-08	\N	14	\N	5	2	2021-05-07 14:49:09	2021-05-27 21:04:31	57	\N
8	CHECK	0	2021-05-01	\N	2	0	2021-05-08	\N	14	54	4	2	2021-05-01 13:10:32	2021-05-28 21:36:21	52	2021-05-28 21:34:51
5	cinquième	0	2021-04-30	\N	48	0	2021-05-01	\N	14	54	3	2	2021-04-29 08:37:56	2021-05-28 21:36:27	52	2021-05-28 21:35:13
3	une nouvelle	0	2021-04-29	\N	2	0	2021-04-30	\N	14	54	3	1	2021-04-29 06:27:21	2021-05-28 21:36:29	52	2021-05-28 21:35:16
30	assoc2nde	0	2021-05-12	2021-05-12	6	0	2021-05-11	16	15	56	1	1	2021-05-11 21:12:50	2021-05-25 03:27:25	57	\N
42	date_insert2	0	2021-05-27	\N	6	0	2021-05-28	\N	14	\N	2	2	2021-05-27 17:28:06	2021-05-28 21:36:35	57	2021-05-28 21:36:04
33	cerise sur le gâteau	0	2021-05-12	\N	8	0	2021-05-12	\N	15	56	2	2	2021-05-12 14:19:24	2021-05-28 21:34:26	57	\N
7	kanban	0	2021-05-01	\N	3	0	2021-05-08	\N	14	54	2	1	2021-05-01 13:07:10	2021-05-28 21:36:42	52	2021-05-28 21:35:40
14	sans dt de fin	0	2021-05-10	\N	25	0	2021-05-13	\N	15	\N	4	2	2021-05-10 15:26:00	2021-05-21 11:58:41	57	\N
4	4eme	2	2021-05-01	\N	24	0	2021-04-30	\N	14	54	1	2	2021-04-29 08:37:15	2021-05-28 21:36:48	52	2021-05-28 21:34:54
1	Vraie tâche	0	2021-04-28	\N	48	0	2021-04-30	\N	14	54	1	3	2021-04-28 19:36:58	2021-05-28 21:36:50	52	2021-05-28 21:35:41
37	notification_secondaire	0	2021-05-23	2021-05-24	2	0	2021-05-04	10	15	56	4	2	2021-05-23 14:13:06	2021-05-27 08:27:38	57	\N
12	tâche secondaire pour first task	0	2021-05-10	\N	10	0	2021-05-04	9	15	56	4	4	2021-05-10 11:04:55	2021-05-27 08:27:45	57	\N
41	date_insert	0	2021-05-27	\N	6	0	2021-05-28	\N	14	\N	5	3	2021-05-27 14:25:57	2021-05-27 21:18:43	57	2021-05-27 21:18:43
19	work	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	4	1	2021-05-11 10:08:44	2021-05-28 21:33:26	57	\N
16	ectoassoc	0	2021-05-11	\N	5	0	2021-05-11	\N	15	56	3	1	2021-05-10 23:15:14	2021-05-28 02:39:33	57	2021-05-28 02:14:48
9	first_task	0	2021-05-03	\N	24	0	2021-05-04	\N	15	56	4	4	2021-05-03 10:07:31	2021-05-28 21:33:31	57	\N
26	test_append	0	2021-05-21	2021-05-22	5	0	2021-05-04	9	15	56	3	4	2021-05-11 12:34:43	2021-05-22 19:29:05	57	\N
31	primaire	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	5	2	2021-05-12 11:02:47	2021-05-28 21:33:36	57	2021-05-28 21:33:36
20	task_children	0	2021-05-12	\N	5	0	2021-05-13	\N	15	\N	3	2	2021-05-11 10:39:51	2021-05-22 21:01:17	57	\N
34	dodosy	0	2021-05-15	\N	6	0	2021-05-16	\N	15	\N	5	3	2021-05-13 21:36:00	2021-05-28 21:33:37	57	2021-05-28 21:33:37
39	notifs_length	0	2021-05-23	2021-05-24	5	0	2021-05-12	33	15	56	2	2	2021-05-23 14:17:54	2021-05-23 14:39:34	57	\N
32	89	0	2021-05-12	\N	6	0	2021-05-13	\N	15	\N	2	2	2021-05-12 13:59:05	2021-05-22 21:01:17	57	\N
35	doudousy2	0	2021-05-14	\N	6	0	2021-05-15	\N	15	\N	5	2	2021-05-13 21:42:44	2021-05-28 21:33:41	57	2021-05-28 21:33:41
10	second_task	0	2021-05-03	\N	10	0	2021-05-04	\N	15	56	2	2	2021-05-03 10:18:08	2021-05-22 21:01:23	57	\N
38	notif2	0	2021-05-23	2021-05-25	5	0	2021-05-12	33	15	56	3	2	2021-05-23 14:15:08	2021-05-23 14:39:35	57	\N
36	TACHE POUR MATTHIEU	0	2021-05-17	\N	24	0	2021-05-18	\N	15	54	2	2	2021-05-17 13:52:18	2021-05-28 21:34:23	57	\N
24	children_length_test	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	2	4	2021-05-11 12:22:08	2021-05-23 13:49:26	57	\N
18	tacheee	0	2021-05-20	\N	55	0	2021-05-22	\N	15	56	2	3	2021-05-10 23:26:33	2021-05-28 21:34:25	57	\N
27	append%2==1	0	2021-05-11	2021-05-12	5	0	2021-05-04	9	15	56	4	4	2021-05-11 12:35:49	2021-05-17 13:55:19	57	\N
40	tache notif	0	2021-05-23	\N	6	0	2021-05-24	\N	15	\N	4	2	2021-05-23 14:19:32	2021-05-23 14:39:36	57	\N
2	Seconde tâche	0	2021-04-29	\N	24	0	2021-04-30	\N	14	54	4	1	2021-04-29 06:25:23	2021-05-28 21:36:18	52	\N
6	pubsub	0	2021-05-01	\N	50	0	2021-05-08	\N	14	54	4	3	2021-05-01 13:00:55	2021-05-28 21:36:12	52	2021-05-28 21:36:01
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, profile_picture, email, password, right_id, inserted_at, updated_at) FROM stdin;
52	Admin	images/profiles/admin-profile.jpg	admin@myadmin	$2b$12$3yngeegsjEEifTOEZDSfAeOXnuyBOkCfjGUN.7GdIW1A57mD6tKqO	1	2021-04-13 08:28:09	2021-04-13 08:54:00
57	Mgbi	images/profiles/default_profile_pic.png	admin@mgbi	$2b$12$0LWzPAdYxEQyl2BX3UL7tev4jk1Ty0jLKK7kFhHkiilAaT7ShOo3.	1	2021-05-01 21:28:30	2021-05-01 21:28:46
54	Mgbi1	images/profiles/default_profile_pic.png	contributeur@mgbi	$2b$12$sxaYg4bRhFyE7RDn0gaXcOlDkEnhOoPFpB./8Ir.RDNKR85vsv6nK	3	2021-04-13 11:38:03	2021-04-13 11:38:19
56	Mgbi2	images/profiles/default_profile_pic.png	contributeur2@mgbi	$2b$12$xjnYOEvFZyi6ky2vB8HGCO//zHlN8lqg56hBeGE/ezDgqB/z01Z8a	3	2021-05-01 18:12:11	2021-05-01 18:13:32
53	Attributeur	images/profiles/default_profile_pic.png	mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	2	2021-04-13 11:30:16	2021-04-13 11:35:15
55	Jesuisarchivé	images/profiles/default_profile_pic.png	archivé@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	100	2021-04-13 11:46:26	2021-04-19 14:20:31
41	Test	images/profiles/test-profile.jpg	test@test	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	1	2021-03-30 18:00:03	2021-03-30 18:01:54
33	Eric	images/profiles/default_profile_pic.png	eric@soc	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	4	2021-03-26 06:37:02	2021-04-22 08:20:01
58	Marc	images/profiles/default_profile_pic.png	marc@comp	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	4	2021-05-02 13:24:25	2021-05-02 13:24:38
25	Profilnonattribué	images/profiles/Nora-profile.png	nonattribuée@mgbi	$2b$12$LHa8.ujlAJ4BbBd1b/M3XeNmsJ6SATtA9KDm3Wwa71IZBc.Jz2GV6	5	2021-03-25 11:09:44	2021-05-24 16:06:51
\.


--
-- Name: active_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_clients_id_seq', 7, true);


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

SELECT pg_catalog.setval('public.cards_id_seq', 46, true);


--
-- Name: clients_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_requests_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 63, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 8, true);


--
-- Name: editors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.editors_id_seq', 1, false);


--
-- Name: licenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.licenses_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 646, true);


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

SELECT pg_catalog.setval('public.tasks_id_seq', 42, true);


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
