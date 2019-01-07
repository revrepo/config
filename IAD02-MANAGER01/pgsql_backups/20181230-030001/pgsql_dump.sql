--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases
--

DROP DATABASE infradb;




--
-- Drop roles
--

DROP ROLE infradb;
DROP ROLE moty;
DROP ROLE nagios;
DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE infradb;
ALTER ROLE infradb WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION PASSWORD 'md5511656f709285190be4107f213ce58aa';
CREATE ROLE moty;
ALTER ROLE moty WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION;
CREATE ROLE nagios;
ALTER ROLE nagios WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION PASSWORD 'md52fb17f77d0fb6792dab3e7d66188769a';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION;






--
-- Database creation
--

CREATE DATABASE infradb WITH TEMPLATE = template0 OWNER = moty;
REVOKE ALL ON DATABASE infradb FROM PUBLIC;
REVOKE ALL ON DATABASE infradb FROM moty;
GRANT ALL ON DATABASE infradb TO moty;
GRANT CONNECT,TEMPORARY ON DATABASE infradb TO PUBLIC;
GRANT ALL ON DATABASE infradb TO infradb;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect infradb

SET default_transaction_read_only = off;

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO infradb;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO infradb;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO infradb;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO infradb;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO infradb;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO infradb;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO infradb;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO infradb;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO infradb;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO infradb;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO infradb;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO infradb;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO infradb;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO infradb;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO infradb;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO infradb;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO infradb;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO infradb;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO infradb;

--
-- Name: servers_category; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE servers_category (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    code character varying(10) NOT NULL
);


ALTER TABLE public.servers_category OWNER TO infradb;

--
-- Name: servers_category_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE servers_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_category_id_seq OWNER TO infradb;

--
-- Name: servers_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE servers_category_id_seq OWNED BY servers_category.id;


--
-- Name: servers_hostingprovider; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE servers_hostingprovider (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.servers_hostingprovider OWNER TO infradb;

--
-- Name: servers_hostingprovider_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE servers_hostingprovider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_hostingprovider_id_seq OWNER TO infradb;

--
-- Name: servers_hostingprovider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE servers_hostingprovider_id_seq OWNED BY servers_hostingprovider.id;


--
-- Name: servers_location; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE servers_location (
    id integer NOT NULL,
    address1 character varying(64) NOT NULL,
    address2 character varying(64) NOT NULL,
    city character varying(64) NOT NULL,
    country character varying(64) NOT NULL,
    airport_code character varying(3) NOT NULL,
    hosting character varying(64) NOT NULL,
    comment character varying(512) NOT NULL,
    state character varying(64) NOT NULL,
    code character varying(10) NOT NULL
);


ALTER TABLE public.servers_location OWNER TO infradb;

--
-- Name: servers_location_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE servers_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_location_id_seq OWNER TO infradb;

--
-- Name: servers_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE servers_location_id_seq OWNED BY servers_location.id;


--
-- Name: servers_server; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE servers_server (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    status character varying(7) NOT NULL,
    comment character varying(512) NOT NULL,
    "IP" inet NOT NULL,
    location_id integer NOT NULL,
    type_id integer NOT NULL,
    hostingprovider_id integer NOT NULL,
    kernel_version character varying(20) NOT NULL,
    proxy_software_version character varying(20) NOT NULL,
    revsw_module_version character varying(20) NOT NULL
);


ALTER TABLE public.servers_server OWNER TO infradb;

--
-- Name: servers_server_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE servers_server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_server_id_seq OWNER TO infradb;

--
-- Name: servers_server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE servers_server_id_seq OWNED BY servers_server.id;


--
-- Name: servers_type; Type: TABLE; Schema: public; Owner: infradb; Tablespace: 
--

CREATE TABLE servers_type (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    category_id integer NOT NULL,
    code character varying(10) NOT NULL
);


ALTER TABLE public.servers_type OWNER TO infradb;

--
-- Name: servers_type_id_seq; Type: SEQUENCE; Schema: public; Owner: infradb
--

CREATE SEQUENCE servers_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_type_id_seq OWNER TO infradb;

--
-- Name: servers_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: infradb
--

ALTER SEQUENCE servers_type_id_seq OWNED BY servers_type.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_category ALTER COLUMN id SET DEFAULT nextval('servers_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_hostingprovider ALTER COLUMN id SET DEFAULT nextval('servers_hostingprovider_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_location ALTER COLUMN id SET DEFAULT nextval('servers_location_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_server ALTER COLUMN id SET DEFAULT nextval('servers_server_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_type ALTER COLUMN id SET DEFAULT nextval('servers_type_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add location	1	add_location
2	Can change location	1	change_location
3	Can delete location	1	delete_location
4	Can add category	2	add_category
5	Can change category	2	change_category
6	Can delete category	2	delete_category
7	Can add type	3	add_type
8	Can change type	3	change_type
9	Can delete type	3	delete_type
10	Can add server	4	add_server
11	Can change server	4	change_server
12	Can delete server	4	delete_server
13	Can add log entry	5	add_logentry
14	Can change log entry	5	change_logentry
15	Can delete log entry	5	delete_logentry
16	Can add permission	6	add_permission
17	Can change permission	6	change_permission
18	Can delete permission	6	delete_permission
19	Can add group	7	add_group
20	Can change group	7	change_group
21	Can delete group	7	delete_group
22	Can add user	8	add_user
23	Can change user	8	change_user
24	Can delete user	8	delete_user
25	Can add content type	9	add_contenttype
26	Can change content type	9	change_contenttype
27	Can delete content type	9	delete_contenttype
28	Can add session	10	add_session
29	Can change session	10	change_session
30	Can delete session	10	delete_session
31	Can add hosting provider	11	add_hostingprovider
32	Can change hosting provider	11	change_hostingprovider
33	Can delete hosting provider	11	delete_hostingprovider
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_permission_id_seq', 33, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	pbkdf2_sha256$12000$a2l7yDRnXbMn$7zQdhiXlrPG5IlPsmyw35K2JtmWIKMhMYkOeJBiwTGE=	2014-09-25 18:17:14+00	f	apiro				f	t	2014-09-25 18:17:14+00
1	pbkdf2_sha256$12000$lXK5AU12ieVf$HRsFyxyo2bh1jBBodx28vb0HB5KXeq295WDQAEpP2aU=	2014-12-05 02:22:33.396868+00	t	moty			motykosh@gmail.com	t	t	2014-09-23 00:41:58.284267+00
7	pbkdf2_sha256$12000$xiExOLgRqOqB$6BfLDOYLoOgsdvl1DsD0vpMtEcqpm9lIxb1+dOaUTjw=	2018-09-13 21:02:56.865747+00	t	jon				t	t	2018-08-04 00:33:47+00
5	pbkdf2_sha256$12000$nIuNwY9iBLKB$pmkRR1JisP6+FN84RzkkakwvFs01rpMF+cmCBNEKgEM=	2017-08-07 17:44:47+00	t	yura	Yura	K.	djkobraz@gmail.com	t	t	2017-08-05 01:46:01+00
2	pbkdf2_sha256$12000$LKpuztLpuVw0$vh635mcBs9E+YEE8doXPvCmFUYCcXG5Z007FP5F8Pe8=	2018-12-16 05:44:59.517014+00	t	victor	Victor	Gartvich	victor@revsw.com	t	t	2014-09-23 01:22:11+00
4	pbkdf2_sha256$12000$Wb1b2lyPmOag$O4vTxNWd1t9dRaAjQDd28/fEa7cgXDqcuWtjGbbNWEk=	2017-12-05 18:56:38.700202+00	t	alex	Alex	Petrov	alexus.petrov@gmail.com	t	t	2015-01-02 22:20:35+00
6	pbkdf2_sha256$12000$wEXdbrRkyNPE$OeU5z3eX8aFhPH2clIDwvOTanIE/IepgVkHGUwPpQwk=	2018-01-03 01:51:59.840748+00	f	apiuser				f	t	2018-01-03 01:51:59.840784+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_user_id_seq', 7, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2014-09-23 00:44:12.842855+00	1	IAD02	1		1	1
2	2014-09-23 00:44:29.08295+00	1	Management	1		2	1
3	2014-09-23 00:44:34.27074+00	1	Install, Management	1		3	1
4	2014-09-23 00:45:14.222442+00	1	IAD02-INSTALL01	1		4	1
5	2014-09-23 00:45:48.261101+00	2	Monitor, Management	1		3	1
6	2014-09-23 00:46:17.536901+00	2	IAD02-MONITOR01	1		4	1
7	2014-09-23 00:46:50.826655+00	3	Graphite, Management	1		3	1
8	2014-09-23 00:47:12.929251+00	3	IAD02-GRAPHITE01	1		4	1
9	2014-09-23 00:47:51.587332+00	4	Manager, Management	1		3	1
10	2014-09-23 00:48:13.452148+00	4	IAD02-MANAGER01	1		4	1
11	2014-09-23 00:48:32.276448+00	3	IAD02-GRAPHITE01	2	Changed comment.	4	1
12	2014-09-23 00:48:49.023864+00	4	IAD02-MANAGER01	2	Changed comment.	4	1
13	2014-09-23 00:49:15.384313+00	2	SJC02	1		1	1
14	2014-09-23 00:49:36.602085+00	5	SJC02-MONITOR02	1		4	1
15	2014-09-23 00:49:51.984567+00	5	SJC02-MONITOR02	2	Changed comment.	4	1
16	2014-09-23 00:50:31.322409+00	5	Portal, Management	1		3	1
17	2014-09-23 00:50:58.417229+00	6	IAD02-PORTAL01	1		4	1
18	2014-09-23 00:51:34.037862+00	6	Cmdb, Management	1		3	1
19	2014-09-23 00:51:55.75702+00	7	IAD02-CMDB01	1		4	1
20	2014-09-23 00:52:54.94931+00	2	Edge	1		2	1
21	2014-09-23 00:52:58.488376+00	7	Browser Proxy, Edge	1		3	1
22	2014-09-23 00:53:19.528894+00	8	SJC02-BP01	1		4	1
23	2014-09-23 00:54:04.254059+00	8	CO, Edge	1		3	1
24	2014-09-23 00:54:28.517495+00	9	SJC02-CO01	1		4	1
25	2014-09-23 00:55:01.613503+00	3	SEA02	1		1	1
26	2014-09-23 00:55:18.410403+00	10	SEA02-BP01	1		4	1
27	2014-09-23 00:55:52.29209+00	4	LAX02	1		1	1
28	2014-09-23 00:56:10.352766+00	11	LAX02-CO01	1		4	1
29	2014-09-23 00:56:45.244493+00	12	LAX02-BP01	1		4	1
30	2014-09-23 00:57:12.175566+00	5	DFW02	1		1	1
31	2014-09-23 00:57:39.207764+00	13	DFW02-CO01	1		4	1
32	2014-09-23 00:58:14.124882+00	14	DFW02-BP01	1		4	1
33	2014-09-23 00:58:43.827619+00	15	IAD02-BP01	1		4	1
34	2014-09-23 00:59:20.163695+00	16	IAD02-CO01	1		4	1
35	2014-09-23 00:59:46.305993+00	6	LGA02	1		1	1
36	2014-09-23 01:00:02.972832+00	17	LGA02-BP01	1		4	1
37	2014-09-23 01:00:38.904462+00	18	LGA02-BP02	1		4	1
38	2014-09-23 01:01:10.458927+00	19	LGA02-CO01	1		4	1
39	2014-09-23 01:01:34.725345+00	7	LON02	1		1	1
40	2014-09-23 01:01:49.070981+00	20	LON02-CO01	1		4	1
41	2014-09-23 01:02:23.0914+00	21	LON02-BP01	1		4	1
42	2014-09-23 01:02:52.374491+00	8	PHX02	1		1	1
43	2014-09-23 01:03:15.604047+00	22	PHX02-CO01	1		4	1
44	2014-09-23 01:03:44.363838+00	9	MAA02	1		1	1
45	2014-09-23 01:04:01.879547+00	23	MAA02-BP01	1		4	1
46	2014-09-23 01:04:28.191689+00	10	ORD02	1		1	1
47	2014-09-23 01:04:44.271557+00	24	ORD02-CO01	1		4	1
48	2014-09-23 01:05:21.647169+00	25	ORD02-BP01	1		4	1
49	2014-09-23 01:05:50.810968+00	11	HKG02	1		1	1
50	2014-09-23 01:06:10.495436+00	26	HKG02-BP01	1		4	1
51	2014-09-23 01:06:39.371111+00	27	HKG02-CO01	1		4	1
52	2014-09-23 01:06:58.415388+00	12	AMS02	1		1	1
53	2014-09-23 01:07:14.167674+00	28	AMS02-BP01	1		4	1
54	2014-09-23 01:07:41.010577+00	29	AMS02-CO01	1		4	1
55	2014-09-23 01:08:03.539927+00	13	PAR02	1		1	1
56	2014-09-23 01:08:21.157007+00	30	PAR02-BP01	1		4	1
57	2014-09-23 01:09:05.292468+00	14	MIA02	1		1	1
58	2014-09-23 01:09:31.917908+00	31	MIA02-BP01	1		4	1
59	2014-09-23 01:10:27.312161+00	15	SAO02	1		1	1
60	2014-09-23 01:10:46.359442+00	32	SAO02-BP01	1		4	1
61	2014-09-23 01:11:10.72927+00	16	TYO02	1		1	1
62	2014-09-23 01:11:25.27208+00	33	TYO02-BP01	1		4	1
63	2014-09-23 01:11:54.033229+00	17	SYD02	1		1	1
64	2014-09-23 01:12:12.614194+00	34	SYD02-BP01	1		4	1
65	2014-09-23 01:12:40.737787+00	18	SIN02	1		1	1
66	2014-09-23 01:13:00.110567+00	35	SIN02-BP01	1		4	1
67	2014-09-23 01:13:50.920577+00	19	FRA02	1		1	1
68	2014-09-23 01:14:07.173573+00	36	FRA02-BP01	1		4	1
69	2014-09-23 01:14:26.404741+00	20	LAX03	1		1	1
70	2014-09-23 01:14:42.289978+00	37	LAX03-BP01	1		4	1
71	2014-09-23 01:15:03.334349+00	21	YYZ02	1		1	1
72	2014-09-23 01:15:20.081671+00	38	YYZ02-BP01	1		4	1
73	2014-09-23 01:15:42.502307+00	22	DEN02	1		1	1
74	2014-09-23 01:16:01.520512+00	39	DEN02-BP01	1		4	1
75	2014-09-23 01:16:53.466111+00	40	PHX02-BP01	1		4	1
76	2014-09-23 01:17:19.209545+00	23	LAX20	1		1	1
77	2014-09-23 01:17:36.066707+00	41	LAX20-CO01	1		4	1
78	2014-09-23 01:18:04.376223+00	24	DFW20	1		1	1
79	2014-09-23 01:18:21.020629+00	42	DFW20-CO01	1		4	1
80	2014-09-23 01:18:48.562216+00	25	SJC20	1		1	1
81	2014-09-23 01:19:58.197322+00	43	SJC20-CO01	1		4	1
82	2014-09-23 01:20:32.055243+00	7	BP, Edge	2	Changed name.	3	1
83	2014-09-23 01:22:11.892107+00	2	victor	1		8	1
84	2014-09-23 01:23:04.227445+00	2	victor	2	Changed first_name, last_name, email and is_superuser.	8	1
85	2014-09-23 01:34:10.591723+00	2	victor	2	Changed is_staff.	8	1
86	2014-09-23 05:26:27.754287+00	44	sdgfasdgasd	1		4	2
87	2014-09-23 05:26:40.642139+00	44	sdgfasdgasd	3		4	2
88	2014-09-25 18:17:14.751316+00	3	apiro	1		8	1
89	2014-09-25 18:17:22.341426+00	3	apiro	2	No fields changed.	8	1
90	2014-09-25 21:21:14.509951+00	43	SJC20-BP01	2	Changed name, type, comment and IP.	4	2
91	2014-09-25 21:21:43.637139+00	43	SJC20-BP01	2	Changed status.	4	2
92	2014-09-26 06:26:35.072776+00	2	victor	2	Changed password.	8	1
93	2014-10-05 19:03:32.538928+00	26	ATL02	1		1	2
94	2014-10-05 19:03:38.852907+00	19	FRA02	2	No fields changed.	1	2
95	2014-10-05 19:04:40.383881+00	45	ATL02-BP01	1		4	2
96	2014-10-05 19:05:08.070502+00	37	LAX03-BP01	2	Changed comment.	4	2
97	2014-10-21 04:49:33.42733+00	1	IAD02-INSTALL01	2	Changed IP.	4	2
98	2014-10-22 01:47:55.280201+00	9	API, Management	1		3	2
99	2014-10-22 01:48:41.288615+00	46	IAD02-API01	1		4	2
100	2014-10-24 05:42:16.425887+00	47	IAD02-API02	1		4	2
101	2014-10-25 01:28:28.900761+00	10	BACKUP, Management	1		3	2
102	2014-10-25 01:29:04.457277+00	48	SJC02-BACKUP01	1		4	2
103	2014-10-26 05:13:53.593108+00	49	SJC02-MANAGER01	1		4	2
104	2014-10-26 06:07:11.222061+00	4	MANAGER, Management	2	Changed name.	3	2
105	2014-10-28 01:00:07.975025+00	11	RMDB, Management	1		3	2
106	2014-10-28 01:00:28.47428+00	12	RUM, Management	1		3	2
107	2014-10-28 01:00:40.289943+00	13	CUBE, Management	1		3	2
108	2014-10-28 01:01:15.048048+00	50	IAD02-RMDB01	1		4	2
109	2014-10-28 01:03:14.108874+00	51	IAD02-RUM01	1		4	2
110	2014-10-28 01:11:31.704581+00	52	IAD02-CUBE01	1		4	2
111	2014-10-28 20:29:21.240188+00	53	IAD02-PORTAL02	1		4	2
112	2014-10-29 00:05:17.619225+00	50	IAD02-RMDB01	2	Changed IP.	4	2
113	2014-10-29 00:10:43.643284+00	51	IAD02-RUM01	2	Changed IP.	4	2
114	2014-10-29 17:44:28.029894+00	54	IAD02-RUM02	1		4	2
115	2014-10-29 18:11:32.655326+00	55	IAD02-CUBE02	1		4	2
116	2014-10-31 19:24:10.267935+00	3	Home IP addresses for remote SSH access	1		2	2
117	2014-10-31 19:26:00.509212+00	14	HOMEIP, Home IP addresses for remote SSH access	1		3	2
118	2014-10-31 19:26:51.443075+00	56	VICTOR-HOME-IP	1		4	2
119	2014-10-31 19:29:29.816942+00	57	MOTY-HOME-IP1	1		4	2
120	2014-10-31 19:29:48.613094+00	58	MOTY-HOME-IP2	1		4	2
121	2014-10-31 19:30:18.444472+00	59	PRASHANT-HOME-IP	1		4	2
122	2014-11-03 23:32:42.857939+00	60	IAD02-CMDB02	1		4	2
123	2014-11-03 23:34:00.037611+00	61	IAD02-CMDB03	1		4	2
124	2014-11-03 23:35:37.689093+00	62	IAD02-RMDB02	1		4	2
125	2014-11-03 23:36:49.919446+00	63	IAD02-RMDB03	1		4	2
126	2014-11-04 18:58:53.462256+00	64	IAD02-API03	1		4	2
127	2014-11-04 20:19:35.464744+00	65	IAD02-CUBE03	1		4	2
128	2014-11-04 21:50:47.991511+00	66	MOTY-HOME-IP3	1		4	2
129	2014-11-04 23:46:11.105724+00	67	IAD02-RUM03	1		4	2
130	2014-11-06 07:02:33.879844+00	67	IAD02-RUM03	2	Changed IP.	4	2
131	2014-11-06 07:07:45.982957+00	68	IAD02-PORTAL03	1		4	2
132	2014-11-11 06:12:30.900379+00	69	TYO02-BP02	1		4	2
133	2014-11-11 22:39:06.389302+00	70	IAD02-CO02	1		4	2
134	2014-11-12 00:13:02.549683+00	71	HKG02-BP02	1		4	2
135	2014-11-12 00:13:40.968987+00	72	HKG02-CO02	1		4	2
136	2014-11-12 01:14:45.734697+00	73	SIN02-BP02	1		4	2
137	2014-11-12 02:17:09.677517+00	74	SYD02-BP02	1		4	2
138	2014-11-12 18:08:55.352599+00	33	TYO02-BP01	3		4	2
139	2014-11-12 21:29:11.568513+00	75	IAD02-BP02	1		4	2
140	2014-11-14 20:01:21.132835+00	76	MOTY-HOME-IP4	1		4	2
141	2014-11-17 00:40:03.770364+00	77	MOTY-HOME-IP5	1		4	2
142	2014-11-17 18:50:28.589614+00	35	SIN02-BP01	3		4	2
143	2014-11-17 18:50:28.594867+00	34	SYD02-BP01	3		4	2
144	2014-11-17 18:50:28.59642+00	27	HKG02-CO01	3		4	2
145	2014-11-17 18:50:28.598009+00	26	HKG02-BP01	3		4	2
146	2014-11-17 18:50:28.599595+00	16	IAD02-CO01	3		4	2
147	2014-11-17 18:50:28.601398+00	15	IAD02-BP01	3		4	2
148	2014-11-19 07:26:34.134071+00	15	WEBSITE, Management	1		3	2
149	2014-11-19 07:26:59.285454+00	78	IAD02-WEBSITE01	1		4	2
150	2014-11-19 20:29:33.648305+00	79	SJC02-WEBSITE01	1		4	2
151	2014-11-19 22:53:37.507344+00	77	MOTY-HOME-IP5	3		4	1
152	2014-11-19 22:53:37.510415+00	76	MOTY-HOME-IP4	3		4	1
153	2014-11-19 22:53:37.512252+00	66	MOTY-HOME-IP3	3		4	1
154	2014-11-19 22:53:37.513987+00	58	MOTY-HOME-IP2	3		4	1
155	2014-11-19 22:54:04.271296+00	57	MOTY-HOME-IP1	2	Changed IP.	4	1
156	2014-11-20 17:12:36.538456+00	80	IAD02-WEBSITE02	1		4	2
157	2014-11-22 01:36:17.82776+00	81	YYZ02-BP02	1		4	2
158	2014-11-27 00:28:34.765091+00	1	Host Virtual	1		11	2
159	2014-11-27 00:28:46.453617+00	2	AWS EC2	1		11	2
160	2014-11-27 00:28:57.404248+00	3	SoftLayer	1		11	2
161	2014-11-27 00:29:06.051907+00	4	Codero	1		11	2
162	2014-11-27 00:35:06.335722+00	5	Colosseum	1		11	2
163	2014-11-27 00:35:09.533422+00	81	YYZ02-BP02	2	Changed hostingprovider.	4	2
164	2014-11-27 00:35:49.721025+00	80	IAD02-WEBSITE02	2	Changed hostingprovider.	4	2
165	2014-11-27 00:36:01.594907+00	79	SJC02-WEBSITE01	2	Changed hostingprovider.	4	2
166	2014-11-27 00:36:08.322863+00	78	IAD02-WEBSITE01	2	Changed hostingprovider.	4	2
167	2014-11-27 00:36:18.586838+00	75	IAD02-BP02	2	Changed hostingprovider.	4	2
168	2014-11-27 00:37:12.030181+00	6	Vultr.com	1		11	2
169	2014-11-27 00:37:14.490691+00	74	SYD02-BP02	2	Changed hostingprovider.	4	2
170	2014-11-27 00:37:35.648389+00	73	SIN02-BP02	2	Changed hostingprovider.	4	2
171	2014-11-27 00:37:55.108881+00	72	HKG02-CO02	2	Changed hostingprovider.	4	2
172	2014-11-27 00:38:01.594438+00	71	HKG02-BP02	2	Changed hostingprovider.	4	2
173	2014-11-27 00:38:07.418916+00	70	IAD02-CO02	2	Changed hostingprovider.	4	2
174	2014-11-27 00:38:40.60799+00	69	TYO02-BP02	2	Changed hostingprovider.	4	2
175	2014-11-27 00:38:47.453605+00	68	IAD02-PORTAL03	2	Changed hostingprovider.	4	2
176	2014-11-27 00:38:53.074657+00	67	IAD02-RUM03	2	Changed hostingprovider.	4	2
177	2014-11-27 00:38:59.971127+00	65	IAD02-CUBE03	2	Changed hostingprovider.	4	2
178	2014-11-27 00:39:05.285579+00	64	IAD02-API03	2	Changed hostingprovider.	4	2
179	2014-11-27 00:39:11.401345+00	63	IAD02-RMDB03	2	Changed hostingprovider.	4	2
180	2014-11-27 00:39:20.494284+00	62	IAD02-RMDB02	2	Changed hostingprovider.	4	2
181	2014-11-27 00:39:25.456677+00	61	IAD02-CMDB03	2	Changed hostingprovider.	4	2
182	2014-11-27 00:39:30.158936+00	60	IAD02-CMDB02	2	Changed hostingprovider.	4	2
183	2014-11-27 00:40:40.770622+00	1	IAD02-INSTALL01	2	Changed hostingprovider.	4	2
184	2014-11-27 00:40:46.23968+00	55	IAD02-CUBE02	2	Changed hostingprovider.	4	2
185	2014-11-27 00:40:51.694174+00	54	IAD02-RUM02	2	Changed hostingprovider.	4	2
186	2014-11-27 00:40:56.475405+00	53	IAD02-PORTAL02	2	Changed hostingprovider.	4	2
187	2014-11-27 00:41:04.20883+00	52	IAD02-CUBE01	2	Changed hostingprovider.	4	2
188	2014-11-27 00:41:10.289394+00	51	IAD02-RUM01	2	Changed hostingprovider.	4	2
189	2014-11-27 00:41:15.56548+00	50	IAD02-RMDB01	2	Changed hostingprovider.	4	2
190	2014-11-27 00:41:21.975713+00	49	SJC02-MANAGER01	2	Changed hostingprovider.	4	2
191	2014-11-27 00:41:28.087608+00	48	SJC02-BACKUP01	2	Changed hostingprovider.	4	2
192	2014-11-27 00:41:33.672984+00	47	IAD02-API02	2	Changed hostingprovider.	4	2
193	2014-11-27 00:41:38.785716+00	46	IAD02-API01	2	Changed hostingprovider.	4	2
194	2014-11-27 00:42:09.974401+00	7	VPSLAND.COM	1		11	2
195	2014-11-27 00:42:12.342221+00	45	ATL02-BP01	2	Changed hostingprovider.	4	2
196	2014-11-27 00:42:20.990137+00	40	PHX02-BP01	2	Changed hostingprovider.	4	2
197	2014-11-27 00:42:38.355398+00	8	LeaseWeb	1		11	2
198	2014-11-27 00:42:40.049382+00	36	FRA02-BP01	2	Changed hostingprovider.	4	2
199	2014-11-27 00:42:45.848485+00	32	SAO02-BP01	2	Changed hostingprovider.	4	2
200	2014-11-27 00:42:52.161259+00	22	PHX02-CO01	2	Changed hostingprovider.	4	2
201	2014-11-27 00:42:58.473031+00	7	IAD02-CMDB01	2	Changed hostingprovider.	4	2
202	2014-11-27 00:43:03.856097+00	6	IAD02-PORTAL01	2	Changed hostingprovider.	4	2
203	2014-11-27 00:43:10.417864+00	5	SJC02-MONITOR02	2	Changed hostingprovider.	4	2
204	2014-11-27 00:43:16.014033+00	4	IAD02-MANAGER01	2	Changed hostingprovider.	4	2
205	2014-11-27 00:43:22.81552+00	3	IAD02-GRAPHITE01	2	Changed hostingprovider.	4	2
206	2014-11-27 00:43:29.539982+00	2	IAD02-MONITOR01	2	Changed hostingprovider.	4	2
207	2014-11-27 00:44:59.43599+00	9	Home IP - No provider	1		11	2
208	2014-11-27 00:45:01.56006+00	59	PRASHANT-HOME-IP	2	Changed hostingprovider.	4	2
209	2014-11-27 00:45:09.721053+00	57	MOTY-HOME-IP1	2	Changed hostingprovider.	4	2
210	2014-11-27 00:45:16.163909+00	56	VICTOR-HOME-IP	2	Changed hostingprovider.	4	2
211	2014-11-27 00:45:23.201171+00	64	IAD02-API03	2	Changed hostingprovider.	4	2
212	2014-12-05 00:28:04.159593+00	16	ElasticSearch, Management	1		3	2
213	2014-12-05 00:29:05.117892+00	82	IAD02-ES01	1		4	2
214	2014-12-05 00:29:33.145246+00	83	IAD02-ES02	1		4	2
215	2014-12-05 01:36:28.489788+00	84	SEA02-CO01	1		4	2
216	2014-12-05 02:22:49.094946+00	57	MOTY-HOME-IP1	2	Changed IP.	4	1
217	2014-12-05 22:26:56.979229+00	85	IAD02-ES03	1		4	2
218	2014-12-07 18:35:38.220959+00	86	DFW02-BP02	1		4	2
219	2014-12-11 20:33:00.258847+00	87	SEA02-CO02	1		4	2
220	2014-12-18 20:02:40.344119+00	17	ElasticSearch Aggregation, Management	1		3	2
221	2014-12-18 20:03:23.269937+00	88	IAD02-ESAGG01	1		4	2
222	2014-12-18 22:24:35.61808+00	89	IAD02-CUBE04	1		4	2
223	2014-12-19 02:26:12.452705+00	18	RMDBDEBUG, Management	1		3	2
224	2014-12-19 02:26:39.487592+00	90	IAD02-RMDB04	1		4	2
225	2014-12-28 03:49:12.799781+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
226	2015-01-02 22:20:35.638375+00	4	ajit	1		8	2
227	2015-01-02 22:20:56.39235+00	4	ajit	2	Changed first_name, email and is_staff.	8	2
228	2015-01-02 22:23:25.939273+00	4	ajit	2	Changed is_superuser.	8	2
229	2015-02-28 00:38:36.106647+00	91	VICTOR-YOSEMITO-IP	1		4	2
230	2015-03-20 06:49:45.244081+00	92	PAR02-BP02	1		4	2
231	2015-03-20 06:51:49.05331+00	91	VICTOR-YOSEMITO-IP	3		4	2
232	2015-03-20 06:55:39.483621+00	86	DFW02-BP02	3		4	2
233	2015-03-20 06:55:39.486282+00	37	LAX03-BP01	3		4	2
234	2015-03-20 22:11:39.001758+00	93	TYO02-BP01	1		4	2
235	2015-03-23 16:28:53.218632+00	94	IP-HOME-VICTOR-ISRAEL1	1		4	2
236	2015-03-24 10:09:07.199608+00	95	IP-HOME-VICTOR-ISRAEL2	1		4	2
237	2015-03-27 08:33:58.7732+00	27	MOW02	1		1	2
238	2015-03-27 08:34:40.378913+00	10	Pallada Web Services	1		11	2
239	2015-03-27 08:36:00.484123+00	96	MOW02-BP01	1		4	2
240	2015-03-29 07:42:52.835507+00	96	MOW02-BP01	2	Changed IP.	4	2
241	2015-03-29 11:39:25.179002+00	97	FRA02-BP02	1		4	2
242	2015-03-29 19:44:35.192437+00	98	PAR02-BP03	1		4	2
243	2015-03-31 06:43:30.80186+00	95	IP-HOME-VICTOR-ISRAEL2	2	Changed IP.	4	2
244	2015-04-01 18:46:23.015877+00	28	WAW02	1		1	2
245	2015-04-01 18:46:49.149784+00	11	EDIS	1		11	2
246	2015-04-01 18:47:11.523077+00	99	WAW02-BP01	1		4	2
247	2015-04-03 12:37:13.993811+00	94	IP-HOME-VICTOR-ISRAEL1	3		4	2
248	2015-04-03 12:37:24.398071+00	95	IP-HOME-VICTOR-ISRAEL2	2	Changed IP.	4	2
249	2015-04-06 12:39:11.908801+00	29	TLV02	1		1	2
250	2015-04-06 12:39:38.644686+00	100	TLV02-BP01	1		4	2
251	2015-04-06 21:59:11.610461+00	30	MAD02	1		1	2
252	2015-04-06 21:59:32.544148+00	101	MAD02-BP01	1		4	2
253	2015-04-17 22:24:17.594902+00	12	EdgeConneX	1		11	2
254	2015-04-17 22:27:09.986204+00	102	ATL02-BP02	1		4	2
255	2015-04-17 22:27:50.792296+00	103	SEA02-CO03	1		4	2
256	2015-04-18 04:45:38.897428+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
257	2015-04-18 04:46:20.263587+00	95	IP-HOME-VICTOR-ISRAEL2	3		4	2
258	2015-04-20 17:52:35.632856+00	104	LGA02-BP03	1		4	2
259	2015-04-20 23:00:08.045482+00	105	SJC02-BP03	1		4	2
260	2015-04-20 23:06:19.376356+00	106	DFW02-BP03	1		4	2
261	2015-04-25 03:33:25.805337+00	13	NetDepot	1		11	2
262	2015-04-25 03:33:48.753806+00	107	ATL02-BP03	1		4	2
263	2015-04-30 20:26:41.163011+00	14	Unmetered.com	1		11	2
264	2015-04-30 20:27:43.678121+00	31	SXB02	1		1	2
265	2015-04-30 20:38:04.84656+00	108	SXB02-BP03	1		4	2
266	2015-05-01 16:02:18.192756+00	32	STL02	1		1	2
267	2015-05-01 16:03:44.806646+00	109	STL02-BP03	1		4	2
268	2015-05-01 21:54:06.695099+00	110	IAD02-BP01	1		4	2
269	2015-05-19 18:13:48.906061+00	111	SJC02-BP04	1		4	2
270	2015-05-19 18:32:51.439632+00	112	MIA02-BP04	1		4	2
271	2015-05-19 18:36:22.057425+00	113	AMS02-BP04	1		4	2
272	2015-05-20 21:36:19.518545+00	110	IAD02-BP01-OLD	2	Changed name.	4	2
273	2015-05-20 21:36:44.331842+00	114	IAD02-BP01	1		4	2
274	2015-05-23 21:06:12.81679+00	115	IAD02-ESAPI01	1		4	2
275	2015-05-24 19:48:39.156549+00	15	Digital Ocean	1		11	2
276	2015-05-24 19:49:26.23103+00	116	SIN02-BP04	1		4	2
277	2015-05-27 00:44:44.665115+00	88	IAD02-ESAGG01	3		4	2
278	2015-05-27 00:44:44.671937+00	115	IAD02-ESAPI01	3		4	2
279	2015-05-27 00:45:04.208664+00	117	IAD02-ES04	1		4	2
280	2015-05-31 07:20:27.637817+00	118	SAO02-BP02	1		4	2
281	2015-06-05 21:39:10.33747+00	107	ATL02-BP03	2	Changed hostingprovider and IP.	4	2
282	2015-06-08 01:07:51.753502+00	33	KNA02	1		1	2
283	2015-06-08 01:08:12.144695+00	119	KNA02-BP01	1		4	2
284	2015-06-10 21:53:28.990771+00	120	AMS02-BP02	1		4	2
285	2015-07-07 21:00:09.947881+00	121	TLV02-CO01	1		4	2
286	2015-09-18 22:23:24.658051+00	19	CSS, Management	1		3	2
287	2015-09-18 22:23:32.389291+00	19	CDS, Management	2	Changed name.	3	2
288	2015-09-18 22:24:04.929432+00	122	IAD02-CDS01	1		4	2
289	2015-09-24 21:55:34.938825+00	123	YYZ02-BP03	1		4	2
290	2015-10-08 18:17:15.278199+00	59	DMITRY-HOME-IP	2	Changed name and IP.	4	2
291	2015-10-30 04:16:29.077534+00	20	ElasticSearch URL, Management	1		3	2
292	2015-10-30 04:17:29.658296+00	124	LGA02-ESURL01.REVSW.NET	1		4	2
293	2015-11-23 02:08:44.400861+00	125	LGA02-CO05	1		4	2
294	2015-11-23 02:11:48.766993+00	126	LGA02-BP05	1		4	2
295	2015-11-23 02:13:02.445959+00	127	LGA02-CO06	1		4	2
296	2015-11-23 02:14:47.902522+00	128	LGA02-BP06	1		4	2
297	2015-11-27 17:12:45.128473+00	36	FRA02-BP01	2	Changed hostingprovider and IP.	4	2
298	2015-12-01 01:50:00.674433+00	106	DFW02-BP02	2	Changed name and IP.	4	2
299	2015-12-02 23:50:19.171835+00	129	LAX02-BP02	1		4	2
300	2015-12-14 19:56:45.759514+00	21	SDK Stats API Service, Management	1		3	2
301	2015-12-14 19:57:27.805933+00	130	IAD02-STATSAPI01	1		4	2
302	2015-12-14 19:59:07.319121+00	130	IAD02-STATSAPI01	2	Changed type.	4	2
303	2015-12-18 19:18:28.687362+00	57	JON-SD-HOME-IP1	2	Changed name and IP.	4	2
304	2015-12-28 19:04:57.650114+00	57	JON-SD-HOME-IP1	2	Changed IP.	4	2
305	2016-01-08 22:51:45.750875+00	17	LGA02-BP01	2	Changed hostingprovider and IP.	4	2
306	2016-01-09 22:01:58.62122+00	127	LGA02-CO06	3		4	2
307	2016-01-09 22:01:58.625235+00	125	LGA02-CO05	3		4	2
308	2016-01-09 22:01:58.626756+00	121	TLV02-CO01	3		4	2
309	2016-01-09 22:01:58.628258+00	103	SEA02-CO03	3		4	2
310	2016-01-09 22:01:58.629756+00	87	SEA02-CO02	3		4	2
311	2016-01-09 22:01:58.631235+00	84	SEA02-CO01	3		4	2
312	2016-01-09 22:01:58.632735+00	72	HKG02-CO02	3		4	2
313	2016-01-09 22:01:58.634177+00	70	IAD02-CO02	3		4	2
314	2016-01-09 22:01:58.635568+00	42	DFW20-CO01	3		4	2
315	2016-01-09 22:01:58.636986+00	41	LAX20-CO01	3		4	2
316	2016-01-09 22:01:58.638451+00	29	AMS02-CO01	3		4	2
317	2016-01-09 22:01:58.639849+00	24	ORD02-CO01	3		4	2
318	2016-01-09 22:01:58.641388+00	22	PHX02-CO01	3		4	2
319	2016-01-09 22:01:58.643163+00	20	LON02-CO01	3		4	2
320	2016-01-09 22:01:58.644626+00	19	LGA02-CO01	3		4	2
321	2016-01-09 22:01:58.646059+00	13	DFW02-CO01	3		4	2
322	2016-01-09 22:02:32.737883+00	11	LAX02-CO01	3		4	2
323	2016-01-09 22:02:32.740936+00	9	SJC02-CO01	3		4	2
324	2016-01-09 22:11:47.849955+00	110	IAD02-BP01-OLD	3		4	2
325	2016-01-09 22:11:47.853352+00	105	SJC02-BP03	3		4	2
326	2016-01-09 22:11:47.854949+00	104	LGA02-BP03	3		4	2
327	2016-01-09 22:11:47.856539+00	98	PAR02-BP03	3		4	2
328	2016-01-09 22:11:47.858117+00	93	TYO02-BP01	3		4	2
329	2016-01-09 22:11:47.859638+00	81	YYZ02-BP02	3		4	2
330	2016-01-09 22:11:47.861116+00	75	IAD02-BP02	3		4	2
331	2016-01-09 22:11:47.862525+00	57	JON-SD-HOME-IP1	3		4	2
332	2016-01-09 22:11:47.863958+00	45	ATL02-BP01	3		4	2
333	2016-01-09 22:11:47.865383+00	43	SJC20-BP01	3		4	2
334	2016-01-09 22:11:47.866816+00	32	SAO02-BP01	3		4	2
335	2016-01-09 22:11:47.868278+00	30	PAR02-BP01	3		4	2
336	2016-01-09 22:11:47.869666+00	28	AMS02-BP01	3		4	2
337	2016-01-09 22:11:47.871028+00	14	DFW02-BP01	3		4	2
338	2016-01-09 22:11:47.872341+00	12	LAX02-BP01	3		4	2
339	2016-01-10 00:18:35.24503+00	97	FRA02-BP02	3		4	2
340	2016-01-12 20:04:58.988201+00	131	JON-HOME-IP	1		4	2
341	2016-02-01 22:52:26.869627+00	132	YURA-HOME-IP	1		4	2
342	2016-05-06 22:31:36.465472+00	16	Azure Cloud	1		11	2
343	2016-05-06 22:33:09.92277+00	133	IAD02-ES05	1		4	2
344	2016-05-07 00:42:14.146441+00	134	IAD02-ESURL01	1		4	2
345	2016-05-07 03:01:32.999222+00	135	IAD02-ES07	1		4	2
346	2016-05-07 03:02:14.99501+00	136	IAD02-ES06	1		4	2
347	2016-05-31 02:39:30.078548+00	22	Log Shipping Servers, Management	1		3	2
348	2016-05-31 02:40:12.056186+00	137	IAD02-LS01	1		4	2
349	2016-06-01 19:00:43.531329+00	34	PDX02	1		1	2
350	2016-06-01 19:01:24.727412+00	138	PDX02-BP01	1		4	2
351	2016-06-02 04:57:23.523279+00	35	SEL02	1		1	2
352	2016-06-02 04:58:00.593735+00	139	SEL02-BP01	1		4	2
353	2016-06-02 21:54:41.734106+00	17	Sadecehosting Turkey	1		11	2
354	2016-06-02 21:55:04.779252+00	36	IST02	1		1	2
355	2016-06-02 21:55:47.764583+00	140	IST02-BP01	1		4	2
356	2016-06-03 16:42:37.362334+00	37	MIL02	1		1	2
357	2016-06-03 16:43:10.782397+00	141	MIL02-BP01.REVSW.NET	1		4	2
358	2016-06-03 17:19:38.701508+00	141	MIL02-BP01	2	Changed name.	4	2
359	2016-06-04 05:27:00.177541+00	38	STO02	1		1	2
360	2016-06-04 05:27:28.460697+00	142	STO02-BP01	1		4	2
361	2016-06-04 16:52:42.63971+00	18	GalaxyData Ekaterinburg, Russia	1		11	2
362	2016-06-04 16:53:12.983969+00	39	SVX02	1		1	2
363	2016-06-04 16:53:48.428287+00	143	SVX02-BP01	1		4	2
364	2016-06-10 22:36:19.029049+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
365	2016-06-12 17:47:54.715949+00	144	MIA02-BP02	1		4	2
366	2016-06-12 18:57:52.515237+00	145	LON02-BP02	1		4	2
367	2016-06-15 23:55:09.993999+00	146	SEA02-BP02	1		4	2
368	2016-06-16 17:25:18.939343+00	147	IAD02-BP05	1		4	2
369	2016-06-16 19:01:45.98625+00	148	SJC02-BP02	1		4	2
370	2016-06-24 19:00:17.275398+00	4	Fremont Dev Environment	1		2	2
371	2016-06-24 19:01:13.981534+00	19	HE Fremont 2 Facility	1		11	2
372	2016-06-24 19:02:38.793208+00	40	HEF2	1		1	2
373	2016-06-24 19:03:28.789861+00	23	Fremont Dev Environment, Fremont Dev Environment	1		3	2
374	2016-06-24 19:03:37.533921+00	149	DEV-GATEWAY	1		4	2
375	2016-08-24 20:56:44.314616+00	150	VICTOR2-HOME-IP	1		4	2
376	2016-08-28 01:48:51.876996+00	150	VICTOR2-HOME-IP	2	Changed hostingprovider.	4	2
377	2016-08-28 01:49:05.808682+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
378	2016-12-01 06:06:10.61159+00	20	Kamatera	1		11	2
379	2016-12-01 06:07:11.589071+00	151	HKG02-BP01	1		4	2
380	2016-12-01 19:49:36.444657+00	41	JNB02	1		1	2
381	2016-12-01 19:50:07.599422+00	21	Host1Plus	1		11	2
382	2016-12-01 19:50:44.051417+00	152	JNB02-BP01	1		4	2
383	2016-12-04 03:59:09.261887+00	22	Versaweb Cloud	1		11	2
384	2016-12-04 03:59:34.002904+00	42	LAS02	1		1	2
385	2016-12-04 04:00:02.670754+00	153	LAS02-BP01	1		4	2
386	2016-12-17 04:46:08.894416+00	43	BLR02	1		1	2
387	2016-12-17 04:46:33.231919+00	154	BLR02-BP01	1		4	2
388	2016-12-19 15:59:53.286626+00	44	DEL02	1		1	2
389	2016-12-19 16:01:12.843728+00	23	Go2Hosting	1		11	2
390	2016-12-19 16:14:28.781461+00	155	DEL02-BP01	1		4	2
391	2017-01-10 19:20:06.088549+00	143	SVX02-BP01	2	Changed IP.	4	2
392	2017-03-13 19:48:45.758357+00	150	VICTOR2-HOME-IP	2	Changed IP.	4	2
393	2017-03-13 22:27:17.300585+00	156	BLR02-BP02	1		4	2
394	2017-03-13 22:27:40.831948+00	157	BLR02-BP03	1		4	2
395	2017-03-13 22:28:06.609885+00	158	BLR02-BP04	1		4	2
396	2017-03-15 02:09:15.520958+00	159	SIN02-BP01	1		4	2
397	2017-03-15 05:50:39.794616+00	160	BLR02-BP05.REVSW.NET	1		4	2
398	2017-03-18 01:50:24.579471+00	73	SIN02-BP02	2	Changed hostingprovider and IP.	4	2
399	2017-04-26 04:06:31.084917+00	161	BLR02-BP06	1		4	2
400	2017-05-01 18:48:53.680066+00	162	BLR02-BP07	1		4	2
401	2017-05-01 18:50:10.706852+00	163	BLR02-BP08	1		4	2
402	2017-05-01 18:51:08.077802+00	164	BLR02-BP09	1		4	2
403	2017-05-01 18:52:55.950902+00	165	BLR02-BP10	1		4	2
404	2017-05-01 19:15:09.050351+00	166	SIN02-BP03	1		4	2
405	2017-05-01 19:18:12.422804+00	167	SIN02-BP06	1		4	2
406	2017-05-01 19:19:22.345867+00	168	SIN02-BP05	1		4	2
407	2017-05-22 16:11:21.315883+00	45	BOM02	1		1	2
408	2017-05-22 16:11:45.422155+00	169	BOM02-BP01	1		4	2
409	2017-05-31 18:18:55.213448+00	46	VIE02	1		1	2
410	2017-05-31 18:20:19.687311+00	170	VIE02-BP01	1		4	2
411	2017-06-15 19:27:17.297103+00	171	IAD02-ES08	1		4	2
412	2017-06-24 02:42:27.312469+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
413	2017-06-24 02:42:54.7534+00	160	BLR02-BP05	2	Changed name.	4	2
414	2017-06-24 02:43:04.468347+00	124	LGA02-ESURL01	2	Changed name.	4	2
415	2017-06-25 19:41:54.807464+00	172	LGA02-BP07	1		4	2
416	2017-07-02 09:08:23.474572+00	150	VICTOR2-HOME-IP	2	Changed IP.	4	2
417	2017-07-04 15:11:10.447803+00	173	JON2-HOME-IP	1		4	2
418	2017-07-12 16:55:51.604676+00	150	VICTOR2-HOME-IP	2	Changed IP.	4	2
419	2017-07-13 11:35:55.662481+00	174	VIE02-BP02	1		4	2
420	2017-07-14 05:39:15.207888+00	175	VIE02-BP03	1		4	2
421	2017-07-16 08:27:07.27389+00	176	VIE02-BP04.REVSW.NET	1		4	2
422	2017-07-18 14:55:14.744503+00	177	VIE02-BP05	1		4	2
423	2017-07-18 14:55:24.942409+00	176	VIE02-BP04	2	Changed name.	4	2
424	2017-07-18 14:56:39.623166+00	178	VIE02-BP06	1		4	2
425	2017-07-18 14:57:07.096523+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
426	2017-07-19 22:11:46.471582+00	179	LAX02-BP01	1		4	2
427	2017-07-19 22:15:07.119504+00	8	SJC02-BP01	2	Changed hostingprovider and IP.	4	2
428	2017-07-23 13:41:15.961784+00	180	VIE02-BP10	1		4	2
429	2017-07-23 13:43:37.950556+00	181	VIE02-BP09	1		4	2
430	2017-07-23 13:44:42.787176+00	182	VIE02-BP08	1		4	2
431	2017-07-23 13:47:05.72419+00	183	VIE02-BP07	1		4	2
432	2017-07-24 03:32:47.574049+00	184	LGA02-BP03	1		4	2
433	2017-07-24 16:28:08.271359+00	185	FRA02-BP02	1		4	2
434	2017-07-25 18:02:55.834964+00	186	FRA02-BP03	1		4	2
435	2017-07-25 18:03:18.078881+00	187	FRA02-BP04	1		4	2
436	2017-07-25 18:03:44.1056+00	188	FRA02-BP05	1		4	2
437	2017-07-27 00:49:02.921147+00	189	IAD02-ES09	1		4	2
438	2017-07-27 00:49:52.906638+00	190	IAD02-ES10	1		4	2
439	2017-07-27 05:06:37.190264+00	191	DFW02-BP01	1		4	2
440	2017-07-28 04:07:51.08045+00	192	IAD02-ES11	1		4	2
441	2017-07-28 04:08:05.067015+00	189	IAD02-ES09	2	Changed IP.	4	2
442	2017-07-28 05:39:46.788377+00	193	IAD02-ES12	1		4	2
443	2017-08-03 06:19:55.925404+00	47	ORD03	1		1	2
444	2017-08-03 06:20:35.174859+00	194	ORD03-LS01	1		4	2
445	2017-08-05 00:08:49.058437+00	195	TIM-HOME-IP	1		4	2
446	2017-08-05 01:46:01.560637+00	5	tim	1		8	2
447	2017-08-05 02:43:27.931731+00	5	tim	2	Changed first_name, last_name, email, is_staff and is_superuser.	8	2
448	2017-08-07 17:44:51.6647+00	48	GRZ02	1		1	2
449	2017-08-07 17:49:32.044512+00	196	IAD02-BP02	1		4	2
450	2017-08-07 17:50:06.743914+00	197	GRZ02-BP01	1		4	2
451	2017-08-11 22:54:07.033422+00	24	AlibabaCloud	1		11	2
452	2017-08-11 22:54:34.236481+00	151	HKG02-BP01	2	Changed hostingprovider and IP.	4	2
453	2017-08-20 22:04:17.84537+00	198	ORD02-BP02	1		4	2
454	2017-08-21 22:58:05.956969+00	24	Servers running revsw-webtest package, Management	1		3	2
455	2017-08-21 23:15:50.367639+00	199	SJC02-WT01	1		4	2
456	2017-08-26 03:47:37.836851+00	25	WPT-SERVER Linux box driving Windows WPT servers, Management	1		3	2
457	2017-08-26 03:47:49.718237+00	25	WPTSERVER Linux box driving Windows WPT servers, Management	2	Changed name.	3	2
458	2017-08-26 03:48:28.080231+00	200	SJC02-WPT-SERVER01	1		4	2
459	2017-08-26 04:26:56.67687+00	26	WPT Windows box, Management	1		3	2
460	2017-08-26 04:27:43.343787+00	201	SJC02-WPT01	1		4	2
461	2017-09-06 18:31:13.712467+00	183	VIE02-BP07	3		4	2
462	2017-09-06 18:31:13.720902+00	182	VIE02-BP08	3		4	2
463	2017-09-06 18:31:13.722394+00	181	VIE02-BP09	3		4	2
464	2017-09-06 18:31:13.723941+00	180	VIE02-BP10	3		4	2
465	2017-09-06 18:31:13.72545+00	178	VIE02-BP06	3		4	2
466	2017-09-06 18:31:13.72885+00	177	VIE02-BP05	3		4	2
467	2017-09-06 18:31:13.730406+00	176	VIE02-BP04	3		4	2
468	2017-09-06 18:31:13.731923+00	175	VIE02-BP03	3		4	2
469	2017-09-06 22:42:44.966921+00	5	yura	2	Changed username, first_name, last_name and email.	8	2
470	2017-09-06 22:43:28.079515+00	5	yura	2	Changed password.	8	2
471	2017-09-06 22:45:03.572287+00	113	AMS02-BP01	2	Changed name and IP.	4	2
472	2017-09-08 18:34:43.385959+00	131	JON-HOME-IP	2	Changed IP.	4	2
473	2017-09-11 23:21:04.570339+00	102	ATL02-BP02	3		4	2
474	2017-09-11 23:24:47.814205+00	140	IST02-BP01	3		4	2
475	2017-09-11 23:24:47.817794+00	31	MIA02-BP01	3		4	2
476	2017-09-11 23:24:47.819485+00	112	MIA02-BP04	3		4	2
477	2017-09-11 23:26:55.102036+00	111	SJC02-BP04	3		4	2
478	2017-09-11 23:26:55.104542+00	109	STL02-BP03	3		4	2
479	2017-09-11 23:26:55.106243+00	108	SXB02-BP03	3		4	2
480	2017-09-11 23:26:55.107999+00	99	WAW02-BP01	3		4	2
481	2017-09-11 23:26:55.10971+00	38	YYZ02-BP01	3		4	2
482	2017-09-11 23:56:38.690331+00	10	SEA02-BP01	3		4	2
483	2017-10-06 17:53:27.955445+00	202	IAD02-ESURL02	1		4	2
484	2017-10-10 23:20:10.707115+00	173	JON2-HOME-IP	2	Changed IP.	4	2
485	2017-10-12 20:40:24.504949+00	203	MIA02-BP01	1		4	2
486	2017-10-18 16:36:16.325226+00	204	SJC02-WPT02	1		4	2
487	2017-10-25 18:52:57.885131+00	59	JON-OFFICE-IP	2	Changed name and IP.	4	2
488	2017-11-02 15:27:39.000376+00	4	alex	2	Changed username, first_name, last_name and email.	8	2
489	2017-11-02 15:30:46.868794+00	4	alex	2	Changed password.	8	2
490	2017-11-07 16:14:23.834072+00	205	ATL02-BP05	1		4	2
491	2017-11-13 21:33:15.16943+00	206	TLV02-WPT01	1		4	2
492	2017-11-13 21:33:52.168352+00	207	ATL02-BP01	1		4	2
493	2017-11-13 21:34:16.85074+00	208	ATL02-BP02	1		4	2
494	2017-11-13 21:34:38.157793+00	209	ATL02-BP04	1		4	2
495	2017-11-15 20:37:47.842991+00	210	MOW02-BP02	1		4	2
496	2017-11-15 21:16:09.718011+00	211	TLV02-BP02	1		4	2
497	2017-11-22 19:23:46.668197+00	212	AMS02-WPT01	1		4	2
498	2017-12-04 00:59:53.103286+00	186	FRA02-BP03	2	Changed hostingprovider and IP.	4	2
499	2017-12-13 04:30:14.971119+00	150	VICTOR2-HOME-IP	2	Changed IP.	4	2
500	2017-12-13 04:31:12.881904+00	150	VICTOR2-HOME-IP	3		4	2
501	2017-12-13 04:31:27.248237+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
502	2018-01-03 01:51:59.898067+00	6	apiuser	1		8	2
503	2018-01-03 16:59:09.432123+00	205	ATL02-BP05	3		4	2
504	2018-01-04 08:32:21.858399+00	202	IAD02-ESURL02	2	Changed IP.	4	2
505	2018-01-05 01:59:04.711867+00	25	Linode	1		11	2
506	2018-01-05 04:06:37.187921+00	26	Oneprovider	1		11	2
507	2018-01-05 06:16:47.267256+00	49	QRO02	1		1	2
508	2018-01-07 00:38:27.149061+00	224	MAA02-WPT01	1		4	2
509	2018-01-18 19:13:42.173604+00	27	TARANTOOL, Edge	1		3	2
510	2018-01-18 19:14:27.521484+00	228	ATL02-TARANTOOL01	1		4	2
511	2018-01-19 18:46:32.175235+00	8	CO, Edge	3		3	2
512	2018-01-24 03:37:08.745948+00	232	SJC02-TARANTOOL01	1		4	2
513	2018-01-24 19:23:38.819602+00	233	AMS02-TARANTOOL01	1		4	2
514	2018-01-30 15:56:07.031212+00	50	PTY02	1		1	2
515	2018-01-30 16:01:34.323676+00	27	OffshoreRacks	1		11	2
516	2018-01-30 16:03:00.640005+00	50	PTY02	2	Changed city.	1	2
517	2018-01-30 18:50:43.436654+00	28	CCIHosting	1		11	2
518	2018-02-02 05:11:19.589173+00	29	Panamaservers.com	1		11	2
519	2018-02-03 01:41:33.906609+00	155	DEL02-BP01	3		4	2
520	2018-02-03 20:36:03.619297+00	146	SEA02-BP02	3		4	2
521	2018-02-06 04:36:18.691464+00	243	DFW02-BP06.REVSW.NET	2	Changed hostingprovider.	4	2
522	2018-02-06 04:36:26.353803+00	242	DFW02-BP05.REVSW.NET	2	Changed hostingprovider.	4	2
523	2018-02-06 04:36:32.610213+00	241	DFW02-BP04.REVSW.NET	2	Changed hostingprovider.	4	2
524	2018-02-06 04:36:39.800399+00	240	DFW02-BP03.REVSW.NET	2	Changed hostingprovider.	4	2
525	2018-02-07 17:44:49.620518+00	147	IAD02-BP05.REVSW.NET	2	Changed name.	4	2
526	2018-02-07 18:52:58.657226+00	51	PUS02	1		1	2
527	2018-02-08 02:20:39.867462+00	139	SEL02-BP01	3		4	2
528	2018-02-09 18:57:34.605162+00	25	ORD02-BP01	3		4	2
529	2018-02-09 19:44:09.6244+00	21	LON02-BP01	3		4	2
530	2018-02-28 05:34:53.276166+00	255	SEA02-TARANTOOL01	1		4	2
531	2018-02-28 05:36:20.508235+00	256	ORD02-TARANTOOL01	1		4	2
532	2018-02-28 05:38:59.142121+00	257	LGA02-TARANTOOL01	1		4	2
533	2018-02-28 06:26:49.266572+00	258	DFW02-TARANTOOL01	1		4	2
534	2018-02-28 06:34:37.466811+00	259	SIN02-TARANTOOL01	1		4	2
535	2018-03-03 19:07:52.788584+00	187	FRA02-BP04	3		4	2
536	2018-03-03 19:07:52.802702+00	188	FRA02-BP05	3		4	2
537	2018-03-03 19:07:52.804172+00	82	IAD02-ES01	3		4	2
538	2018-03-03 19:07:52.805743+00	83	IAD02-ES02	3		4	2
539	2018-03-03 19:07:52.807376+00	85	IAD02-ES03	3		4	2
540	2018-03-03 19:07:52.808955+00	117	IAD02-ES04	3		4	2
541	2018-03-03 19:07:52.810452+00	133	IAD02-ES05	3		4	2
542	2018-03-03 19:07:52.811889+00	136	IAD02-ES06	3		4	2
543	2018-03-03 19:07:52.813359+00	135	IAD02-ES07	3		4	2
544	2018-03-03 21:49:46.133777+00	260	IAD02-TARANTOOL01	1		4	2
545	2018-03-04 05:05:14.29566+00	261	FRA02-TARANTOOL01	1		4	2
546	2018-03-24 04:00:14.907434+00	195	TIM-HOME-IP	3		4	2
547	2018-03-24 04:00:14.912078+00	132	YURA-HOME-IP	3		4	2
548	2018-03-25 00:11:09.449143+00	173	JON2-HOME-IP	2	Changed comment and IP.	4	2
549	2018-03-25 00:12:17.613511+00	131	JON-HOME-IP	3		4	2
550	2018-03-25 00:12:17.61584+00	59	JON-OFFICE-IP	3		4	2
551	2018-03-25 00:27:16.83189+00	262	SYD02-TARANTOOL01.REVSW.NET	1		4	2
552	2018-04-03 13:58:46.602958+00	264	JON-HOME-IP-COMCAST	1		4	2
553	2018-04-03 13:59:17.322434+00	265	JON-HOME-IP-SONIC	1		4	2
554	2018-05-02 06:04:10.833252+00	165	BLR02-BP10	3		4	2
555	2018-05-02 06:04:10.836552+00	164	BLR02-BP09	3		4	2
556	2018-05-02 06:04:10.838063+00	163	BLR02-BP08	3		4	2
557	2018-05-26 11:23:05.947829+00	56	VICTOR-HOME-IP	2	Changed IP.	4	2
558	2018-05-31 16:39:40.75028+00	173	JON2-HOME-IP	2	No fields changed.	4	2
559	2018-08-04 00:33:47.956223+00	7	jon	1		8	2
560	2018-08-04 00:34:23.050766+00	7	jon	2	No fields changed.	8	2
561	2018-08-04 00:35:01.668033+00	7	jon	2	Changed is_staff and is_superuser.	8	2
562	2018-08-08 00:19:10.440448+00	265	JON-HOME-IP-SONIC	2	Changed IP.	4	7
563	2018-09-19 03:23:16.102527+00	52	PEK02	1		1	2
564	2018-09-19 03:23:42.855276+00	30	East Elm	1		11	2
565	2018-09-19 03:24:49.429701+00	30	Elm East	2	Changed code and name.	11	2
566	2018-09-19 04:58:54.43023+00	53	ZUH02	1		1	2
567	2018-11-12 07:18:50.810529+00	221	SYD02-BP01.REVSW.NET	2	Changed IP.	4	2
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 567, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	location	servers	location
2	category	servers	category
3	type	servers	type
4	server	servers	server
5	log entry	admin	logentry
6	permission	auth	permission
7	group	auth	group
8	user	auth	user
9	content type	contenttypes	contenttype
10	session	sessions	session
11	hosting provider	servers	hostingprovider
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('django_content_type_id_seq', 11, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2014-09-23 00:41:05.534266+00
2	auth	0001_initial	2014-09-23 00:41:05.641479+00
3	admin	0001_initial	2014-09-23 00:41:05.68548+00
4	servers	0001_initial	2014-09-23 00:41:05.759751+00
5	servers	0002_auto_20140922_1157	2014-09-23 00:41:05.828717+00
6	servers	0003_remove_server_category	2014-09-23 00:41:05.862441+00
7	servers	0004_auto_20140922_1302	2014-09-23 00:41:05.934415+00
8	sessions	0001_initial	2014-09-23 00:41:05.951081+00
9	servers	0005_auto_20141127_0027	2014-11-27 00:27:07.523508+00
10	servers	0006_server_hostingprovider	2014-11-27 00:30:15.048516+00
11	servers	0007_auto_20141127_0103	2014-11-27 01:03:13.055379+00
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('django_migrations_id_seq', 11, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
185uhh5z8y85ye6qyphvt8olojl4yoxi	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-09 18:11:54.022971+00
kx412rwvwwxtch2jcz0kcaut93b0fqyx	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-09 18:12:35.700597+00
i49r16dk6yn7z0k87vr88vjyrgmh37dq	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-09 18:23:35.336268+00
xzp1sjhy1605k6jnkgbgujb5pnrz602r	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-09 18:37:20.212715+00
n4mmk1bawtt2qnsjjtjz7f970zx7w1fy	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-10-10 16:42:25.706924+00
2h51a4oa6lqv2rkmwsyjvevwz3apgl9n	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-10-19 19:03:03.101319+00
lyvwvncj9l06ayw4jasg1v3vqej0rfaz	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-28 20:18:39.275547+00
belcipsxy85gl2xonsbgpkh9fd87s9yv	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-28 21:31:37.956337+00
2heho6n1r25cwnrfcq49wxcmuk5l9hq5	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-10-28 21:56:33.681716+00
x0zjgcge59200lc3kww1y03bnrfsm500	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-11-04 04:49:07.194062+00
kaqe2ylp6qr3w00tm1hny3kx181vt147	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-11-18 18:58:20.778305+00
0sr6euo9jggbykqn8dxk1uhetpv4clmz	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-12-03 07:26:06.74972+00
by8qrf3hpjyuy7q7c22epp9uyexai39n	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-12-03 22:51:05.32666+00
1jr021f83bj8d8c1cs32g66ih543jd6u	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2014-12-19 00:27:34.069691+00
9fxg7vj4y0k9x8bbx2qczsyfw2u8fcvl	ZTM4YjBhMDk2OTdhNzk4ZTUyYzQyMjg2NGExMDM1Zjk2ZjI5OWNkMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjZmMTJjYjhjNzJhMjk5MWVkOWMzNDI1Y2YwNGI2NmZlY2ExYjdkOTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9	2014-12-19 02:22:33.399259+00
lnq8lgiopz1hfoqo1npzzfxttfegf5f2	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-01-02 02:25:37.743891+00
rxfkk0pnslu607ut6ocfawsv5kt6iosf	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-01-16 22:19:12.00635+00
c1kvtved3di2ulsia05tbojigc32s309	ODhiOTMzYWY5ZGI0NDQ1NjVkNzg0NDBmZGNhYzQ1OTU5YTYxOTIyZjp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0MDNhNjYzMGJhZGJmMjFiYjIzNjRjNGZmN2JlZWQ2MTM3NTRjMTYiLCJfYXV0aF91c2VyX2lkIjo0LCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9	2015-01-16 22:27:56.246349+00
6vbhu6ptmo9krcap5g4vq0vywbposzua	MTliZDFhMmU0MTU2Zjk1MDU3MWU1MGYyYzM2YjkzMGRhYmNiMjQyNDp7fQ==	2015-01-18 23:40:25.540378+00
n5vj82hwy7dqov7dpmbzzf9voywmccc0	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-03-14 00:36:55.34951+00
b1037nn6fw2vfzfk282ab36makzcyzlc	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-04-02 20:25:33.245777+00
hrdowhactk9nxxpq5ylf89s0gijy9ofa	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-04-17 12:36:44.779813+00
x2j2fww6wqqvnkwjhtaww0iyfxztu66f	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-05-01 22:23:47.804485+00
2xpryret6dhh0tare2pm5039ufdy6si2	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-06-02 18:12:45.357521+00
9ze8zi6vp20afu7jwdnk2ph2dckzn4hu	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-06-19 21:35:50.76303+00
564nlfriadps1ajbmkbh998dpywi94ss	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-07-21 06:49:31.101496+00
mg4tlf6tptsmyoyfuht89qotji99bf0q	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-10-02 22:23:02.872897+00
0wr4f7m9b7w5gy3j1j84oy2rugn22pct	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-10-22 18:15:28.095341+00
iz7pvrunka4lhm87yeoygpvnsjh2b6tj	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-11-13 04:15:38.248003+00
0segeo73egk47mg7r2wqc4n6l66yuuxa	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-12-07 02:04:47.638144+00
ne6q3mlgw5wudkgao5uobzdl93e7t7vu	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2015-12-28 19:56:08.791461+00
ums8xoagamm7axeybrba331tb7m8mmie	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-01-19 08:51:07.380353+00
cemncjrphct9hinjew2qcf1l2umxrxja	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-02-15 22:51:36.899378+00
80ay4op7jmzadrni1czd8koe2pdaglcx	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-03-19 02:11:56.582104+00
mi7whwoany3xidft0vhos3zd45n0mmr1	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-04-24 17:18:04.818381+00
iww4k7qgrh9it8c1i3fgkw1ljb4zengj	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-05-20 22:31:08.164531+00
lt2k0m1v06sydn5kbkcc1hcfrwq8dqqb	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-06-14 02:38:05.887595+00
ai91qqbu5zwxpst189137evqwr6vdymr	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-06-29 23:54:00.387423+00
3d6z0798xr1xojaqnvcp3bhm5dg8dmcp	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-09-07 20:54:53.367012+00
r12drr6ss02budtw1mc3foylv90vx4ky	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-09-22 16:10:00.149768+00
q3vue7l6lv0hju3isujqpuw90539z5ne	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-12-15 06:05:33.676555+00
ekdvn5clg8kknvase8f44wnmlsrz0pmd	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2016-12-31 04:43:58.403084+00
7w2sokntkdsdg8mf44jinzlv6vh9dqfz	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-01-24 19:19:40.783182+00
pq6br6xvgzl7lta4gu04yqst5w17c0l0	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-02-17 18:23:15.464046+00
ctt8incgce5mvsb50m94d91dqlx21n86	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-03-27 19:48:00.815199+00
t0vl9x3en3jlloyrs9s7lrqcoye89uw8	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-04-13 22:07:04.53388+00
i6snyaac93x59wb9scm8r3rlt67juakj	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-05-10 04:05:57.454579+00
l7c1mx1hg5j5a7jsce6a3re8off18ldh	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-06-05 16:10:39.561421+00
kulkal7p3skk06jdwkxswxa8dfzusgcl	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-06-29 19:26:40.514463+00
45pebh3tyx387jdkfkoi6msl6wxbu3go	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-07-16 09:07:44.978749+00
amade5uk8549c8uvql0evw6zv0mvf89w	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-08-01 14:54:51.001393+00
q6s7ulg2pw14hkyzubus1ku4cp6pny1s	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-08-17 06:18:32.274067+00
o1nizmzueshkb31edd3pvxjaid4rzmj6	ZDQyYWUyZTljNzUwZjFmMzA1MzY4NDM2ODk0ZTAyNDBjODNjZjhkNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImNhMjU2NGM2M2QwMzU5YjU2NjgxNDdkODliOTY5MjRlNzBjZDNjOWIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjV9	2017-08-21 17:44:47.18892+00
m8fl3jlj1qctdmdb4whs1jot97cipjyk	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-09-03 22:03:21.322752+00
hb44v93fmrgluaaobkucru2u3d9chvaj	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-01-17 16:42:39.416409+00
qiyb9xb3e4mcdgao9vv35grcggpqb9nw	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-09-19 18:20:22.938422+00
m8iwvmlneipdvu4lugymjgmqueg042w9	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-02-01 01:06:16.070159+00
iqcm78kxpzfpclps5zci16npdijvep2j	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-10-01 00:52:18.69304+00
p8o4ovlwb9l41os2jj8tib9dsw7n04fn	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-02-16 05:11:02.404166+00
e5e0badcr00svsq7cr0afr279wr1kjgd	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-10-19 20:36:13.117662+00
9o38z3gxz0h9fzx8ipobaz27pr9pb69b	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-11-08 18:52:27.68276+00
k6h0ekjb9dyry7cpifywneisnq6u90f7	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-03-14 05:34:12.258215+00
6x9951p1s65fe93e1v875lx1yquobc60	MTAyZGU4MDkxN2VhYTNlZGViMGE5NDU2NmI1N2I4MDAzNGM0ZmJjMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0ZjJmYzc1ZDZhODIyMjNlYmFmOTJmYjBlMDA2MDcxODUxNDJkY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjR9	2017-11-16 15:31:00.14973+00
dom60wdo9u9q6yeweworhd4mq6qo7l4o	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-04-07 03:52:16.767314+00
mhpdiy286kdeczk8lgkzhx9z557k4n6l	MTAyZGU4MDkxN2VhYTNlZGViMGE5NDU2NmI1N2I4MDAzNGM0ZmJjMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0ZjJmYzc1ZDZhODIyMjNlYmFmOTJmYjBlMDA2MDcxODUxNDJkY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjR9	2017-11-16 15:31:26.723038+00
mwggm10oh7s0uck4y1vqfwvb6s45p7tk	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-05-03 20:27:20.453408+00
k2hi26toh5hr3u5l58jjzy7ij7k470s3	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-05-19 06:04:40.360888+00
fs4g5wlfk2z9xcp3dzrnkp7f128a9hdi	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-06-05 13:24:25.757366+00
12uqnxsoh3adxdk87m6ka4n4nbm36zmp	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-11-23 02:10:50.329386+00
qirwgs39oevhrx93cteeau0fb5zjx6l3	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-06-13 00:02:21.243538+00
f5j8mww48g5c7ad8r7zbxpaz7hkxw6h7	MTAyZGU4MDkxN2VhYTNlZGViMGE5NDU2NmI1N2I4MDAzNGM0ZmJjMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0ZjJmYzc1ZDZhODIyMjNlYmFmOTJmYjBlMDA2MDcxODUxNDJkY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjR9	2017-12-05 10:10:18.388621+00
5ep6ejg0rg1sq7915elc2q3yj7vgimuk	MTAyZGU4MDkxN2VhYTNlZGViMGE5NDU2NmI1N2I4MDAzNGM0ZmJjMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0ZjJmYzc1ZDZhODIyMjNlYmFmOTJmYjBlMDA2MDcxODUxNDJkY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjR9	2017-12-12 13:31:14.182414+00
bc8mducslhcogll87tel8hhjagy4ywyv	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2017-12-18 00:57:42.88466+00
03htn41j74sglv6knbh1cnk93vk24j2i	MTAyZGU4MDkxN2VhYTNlZGViMGE5NDU2NmI1N2I4MDAzNGM0ZmJjMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA0ZjJmYzc1ZDZhODIyMjNlYmFmOTJmYjBlMDA2MDcxODUxNDJkY2EiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjR9	2017-12-19 18:56:38.702836+00
xns8ehktj23tf9sw00bi6c314y3a6xdc	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-06-27 17:18:46.815035+00
66vipbhzc1r7xoaw3z08us2jwq1izl13	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-07-24 05:31:54.135297+00
kk8xvh9lrmj5pupe0900vr2yuyju29oq	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-08-18 00:32:40.445937+00
v7gzg5hs0wowbsbcznghqhbaackvmbr3	Zjg5ZDM3OGJkN2I4NTM2OTNlMDMyMDg5NzAwZTRhMjgyYTdmODM0ZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImJiYTdiNjdkMmY4MWZmZDc1YzU4ZDc1ZmI2ZjMzMDE5ODBiNDVhYTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjd9	2018-08-21 23:54:15.773136+00
6rozdixa9g0vntccnnohqt016lwplry5	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-09-01 04:11:40.28385+00
p59r3c2od1fpypal8yirmpsl0wnb1l3w	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-09-25 15:55:04.150988+00
f7cyc2jegilaj1tjmct4jxceoegs98i9	Zjg5ZDM3OGJkN2I4NTM2OTNlMDMyMDg5NzAwZTRhMjgyYTdmODM0ZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImJiYTdiNjdkMmY4MWZmZDc1YzU4ZDc1ZmI2ZjMzMDE5ODBiNDVhYTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjd9	2018-09-27 21:02:56.868433+00
r1z61tlbh4ryqbalq4qhxczzspapd70n	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-10-13 04:25:36.552261+00
muey8lt63j9nkgcc22yeegq0hpatful2	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-10-27 04:27:27.983459+00
opjtjnjqx0uzk53d40g3hyo6vuc6k3av	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-11-21 07:08:11.272294+00
up1cgwlx1f3n4lymeutogokvqq4jey6b	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-12-11 06:57:13.498764+00
fxehk4nb2lvfzrasin2eoqdaxb8ikzkq	ZWVjZWNlMjQxYWQ3NTlkYTBiNGZlMmJlMDMwOGI0NzI3NzE3ODU1Nzp7Il9hdXRoX3VzZXJfaGFzaCI6ImRkMjA3ZDU4MmUwZTIzOGVjOTliOWQ2OTNmNGJmMmJiMjljYjc3M2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjJ9	2018-12-30 05:44:59.519144+00
\.


--
-- Data for Name: servers_category; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY servers_category (id, name, code) FROM stdin;
1	Management	MANAGEMENT
2	Edge	EDGE
3	Home IP addresses for remote SSH access	HOMEIP
4	Fremont Dev Environment	TESTSJC20
\.


--
-- Name: servers_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('servers_category_id_seq', 4, true);


--
-- Data for Name: servers_hostingprovider; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY servers_hostingprovider (id, code, name) FROM stdin;
1	HOSTVIRTUAL	Host Virtual
2	EC2	AWS EC2
3	SOFTLAYER	SoftLayer
4	CODERO	Codero
5	COLOSSEUM	Colosseum
6	VULTR	Vultr.com
7	VPSLAND	VPSLAND.COM
8	LEASEWEB	LeaseWeb
9	HOMEIP	Home IP - No provider
10	PALLADA	Pallada Web Services
11	EDIS	EDIS
12	EDGECONNEX	EdgeConneX
13	NETDEPOT	NetDepot
14	UNMETERED	Unmetered.com
15	DIGIOCEAN	Digital Ocean
16	AZURE	Azure Cloud
17	SH	Sadecehosting Turkey
18	GALAXYDATA	GalaxyData Ekaterinburg, Russia
19	HEF2	HE Fremont 2 Facility
20	KAMATERA	Kamatera
21	HOST1PLUS	Host1Plus
22	VERSAWEB	Versaweb Cloud
23	GO2HOSTING	Go2Hosting
24	ALICLOUD	AlibabaCloud
25	LINODE	Linode
26	ONEPROVIDER	Oneprovider
27	OFFSHORERACKS	OffshoreRacks
28	CCIHOSTING	CCIHosting
29	PANAMASERVERS	Panamaservers.com
30	ELMEAST	Elm East
\.


--
-- Name: servers_hostingprovider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('servers_hostingprovider_id_seq', 30, true);


--
-- Data for Name: servers_location; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY servers_location (id, address1, address2, city, country, airport_code, hosting, comment, state, code) FROM stdin;
1					IAD				IAD02
2					SJC				SJC02
3					SEA				SEA02
4					LAX				LAX02
5					DFW				DFW02
6					LGA				LGA02
7					LON				LON02
8					PHX				PHX02
9					MAA				MAA02
10					ORD				ORD02
11					HKG				HKG02
12					AMS				AMS02
13					PAR				PAR02
14					MIA				MIA02
15					SAO				SAO02
16					TYO				TYO02
17					SYD				SYD02
18					SIN				SIN02
20					LAX				LAX03
21					YYZ				YYZ02
22					DEN				DEN02
23					LAX				LAX20
24					DFW				DFW20
25					SJC				SJC20
26					ATL				ATL02
19					FRA				FRA02
27					MOW				MOW02
28			Warsaw	Poland	WAW				WAW02
29					TLV				TLV02
30					MAD				MAD02
31			Strasbourg	France	SXB				SXB02
32			St. Louis	USA	STL			MO	STL02
33					KNA				KNA02
34					PDX		EC2 West 2 (Oregon)		PDX02
35					SEL		Seul, South Korea		SEL02
36					IST				IST02
37					MIL		Milan, Italy		MIL02
38					STO		Stockholm, Sweden		STO02
39					SVX		Ekaterinburg, Russia		SVX02
40					SJC		HE Fremont 2 Facility		HEF2
41			Johannesburg	South Africa	JNB				JNB02
42			Las Vegas		LAS			Nevada	LAS02
43			Bangalore	India	BLR				BLR02
44			New Delhi	India	DEL				DEL02
45			Mumbai	India	BOM				BOM02
46			Vienna	Austria	VIE				VIE02
47					ORD		Azure North Central US region	Illinois	ORD03
48			Graz	Austria	GRZ				GRZ02
49			Querétaro City	Mexico	QRO			Querétaro	QRO02
50			Panama City	Panama	PTY				PTY02
51			Busan	South Korea	PUS				PUS02
52			Bijing	China	PEK				PEK02
53			Zhuhai	China	ZUH				ZUH02
\.


--
-- Name: servers_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('servers_location_id_seq', 53, true);


--
-- Data for Name: servers_server; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY servers_server (id, name, status, comment, "IP", location_id, type_id, hostingprovider_id, kernel_version, proxy_software_version, revsw_module_version) FROM stdin;
207	ATL02-BP01	ONLINE		45.32.215.96	26	7	6			
209	ATL02-BP04	ONLINE		108.61.193.90	26	7	6			
211	TLV02-BP02	ONLINE		185.162.124.117	29	7	20			
18	LGA02-BP02	ONLINE		209.177.145.102	6	7	1			
219	SEA02-BP01.REVSW.NET	ONLINE		45.76.243.51	3	7	6	1	1	1
23	MAA02-BP01	ONLINE		103.6.87.246	9	7	1			
227	ATL02-BP05.REVSW.NET	ONLINE		45.32.217.93	26	7	6	1	1	1
229	LGA02-BP08.REVSW.NET	ONLINE		207.148.19.47	6	7	6	1	1	1
231	SJC02-BP03.REVSW.NET	ONLINE		45.32.130.205	2	7	6	1	1	1
233	AMS02-TARANTOOL01	ONLINE		188.166.73.82	12	27	15			
39	DEN02-BP01	ONLINE		192.73.242.94	22	7	1			
235	AMS02-BP03.REVSW.NET	ONLINE		188.166.67.240	12	7	15	1	1	1
80	IAD02-WEBSITE02	ONLINE		54.174.17.23	1	15	2			
79	SJC02-WEBSITE01	ONLINE		54.67.55.175	2	15	2			
78	IAD02-WEBSITE01	ONLINE		54.165.244.7	1	15	2			
74	SYD02-BP02	ONLINE		108.61.169.23	17	7	6			
247	SEA02-BP02.REVSW.NET	ONLINE		104.238.156.56	3	7	6	1	1	1
71	HKG02-BP02	ONLINE		119.81.166.58	11	7	3			
69	TYO02-BP02	ONLINE		108.61.182.158	16	7	6			
68	IAD02-PORTAL03	ONLINE		54.164.145.187	1	5	2			
67	IAD02-RUM03	ONLINE		54.172.30.224	1	12	2			
65	IAD02-CUBE03	ONLINE		54.172.75.42	1	13	2			
63	IAD02-RMDB03	ONLINE		54.85.218.223	1	11	2			
62	IAD02-RMDB02	ONLINE		54.172.87.141	1	11	2			
61	IAD02-CMDB03	ONLINE		54.173.56.218	1	6	2			
60	IAD02-CMDB02	ONLINE		54.165.240.160	1	6	2			
1	IAD02-INSTALL01	ONLINE	Puppet master server	54.84.208.124	1	1	2			
55	IAD02-CUBE02	ONLINE		54.173.83.181	1	13	2			
54	IAD02-RUM02	ONLINE		54.86.35.32	1	12	2			
53	IAD02-PORTAL02	ONLINE		54.173.43.143	1	5	2			
52	IAD02-CUBE01	ONLINE		54.165.6.24	1	13	2			
51	IAD02-RUM01	ONLINE		54.172.236.206	1	12	2			
50	IAD02-RMDB01	ONLINE		54.165.210.42	1	11	2			
49	SJC02-MANAGER01	ONLINE		54.193.28.160	2	4	2			
48	SJC02-BACKUP01	ONLINE	Amanda Backup Server	54.183.60.157	2	10	2			
47	IAD02-API02	ONLINE		54.88.69.242	1	9	2			
46	IAD02-API01	ONLINE		54.165.134.123	1	9	2			
249	ORD02-BP03.REVSW.NET	ONLINE		207.148.15.246	10	7	6	1	1	1
40	PHX02-BP01	ONLINE		216.55.176.207	8	7	4			
253	IAD02-BP03.REVSW.NET	ONLINE		207.244.104.51	1	7	8	1	1	1
255	SEA02-TARANTOOL01	ONLINE		45.76.242.136	3	27	6			
7	IAD02-CMDB01	ONLINE		54.164.33.195	1	6	2			
6	IAD02-PORTAL01	ONLINE		54.86.57.22	1	5	2			
5	SJC02-MONITOR02	ONLINE	Nagios monitoring server to monitor primary server IAD02-MANAGER01	54.193.118.76	2	2	2			
4	IAD02-MANAGER01	ONLINE	General-purpose management service (configuration provisioning, SSH jump host)	54.84.12.149	1	4	2			
3	IAD02-GRAPHITE01	ONLINE	Graphite server	54.88.166.168	1	3	2			
2	IAD02-MONITOR01	ONLINE	Primary Nagios/logcheck monitoring server	54.88.56.156	1	2	2			
257	LGA02-TARANTOOL01	ONLINE		159.65.232.100	6	27	15			
259	SIN02-TARANTOOL01	ONLINE		128.199.233.174	18	27	15			
64	IAD02-API03	ONLINE		54.165.8.28	1	9	2			
261	FRA02-TARANTOOL01	ONLINE		185.17.144.70	19	27	8			
263	YYZ02-BP01.REVSW.NET	ONLINE		159.89.126.113	21	7	15	1	1	1
267	FRA02-BP05.REVSW.NET	ONLINE		185.17.146.151	19	7	8	1	1	1
269	FRA02-BP07.REVSW.NET	ONLINE		185.17.146.153	19	7	8	1	1	1
89	IAD02-CUBE04	ONLINE		54.175.52.161	1	13	2			
90	IAD02-RMDB04	ONLINE		54.174.225.29	1	18	2			
56	VICTOR-HOME-IP	ONLINE		73.223.31.210	1	14	9			
271	SEL02-BP01.REVSW.NET	ONLINE		52.79.218.223	35	7	2	1	1	1
92	PAR02-BP02	ONLINE		108.61.176.153	13	7	6			
265	JON-HOME-IP-SONIC	ONLINE		157.131.200.6	1	14	9			
273	PEK02-BP01.REVSW.NET	ONLINE		124.126.126.93	52	7	30	1	1	1
221	SYD02-BP01.REVSW.NET	ONLINE		139.99.178.74	17	7	26	1	1	1
96	MOW02-BP01	ONLINE		37.0.121.199	27	7	10			
100	TLV02-BP01	ONLINE		193.182.144.67	29	7	11			
101	MAD02-BP01	ONLINE		151.236.23.223	30	7	11			
114	IAD02-BP01	ONLINE		199.38.183.15	1	7	1			
116	SIN02-BP04	ONLINE		128.199.105.76	18	7	15			
118	SAO02-BP02	ONLINE		148.163.220.73	15	7	1			
107	ATL02-BP03	ONLINE		108.61.252.22	26	7	6			
119	KNA02-BP01	ONLINE		37.235.52.136	33	7	11			
120	AMS02-BP02	ONLINE		108.61.199.207	12	7	6			
36	FRA02-BP01	ONLINE		104.238.158.63	19	7	6			
106	DFW02-BP02	ONLINE		104.238.145.141	5	7	6			
17	LGA02-BP01	ONLINE		104.207.134.117	6	7	6			
8	SJC02-BP01	ONLINE		45.63.93.77	2	7	6			
73	SIN02-BP02	ONLINE		139.59.233.43	18	7	15			
113	AMS02-BP01	ONLINE		45.32.186.40	12	7	6			
206	TLV02-WPT01	ONLINE		185.162.124.210	29	26	20			
122	IAD02-CDS01	ONLINE		52.20.185.21	1	19	2			
123	YYZ02-BP03	ONLINE		159.203.9.138	21	7	15			
208	ATL02-BP02	ONLINE		45.76.248.177	26	7	6			
210	MOW02-BP02	ONLINE		213.183.56.23	27	7	11			
212	AMS02-WPT01	ONLINE		52.232.2.133	12	26	16			
126	LGA02-BP05	ONLINE		104.156.250.76	6	7	6			
186	FRA02-BP03	ONLINE		46.165.253.72	19	7	8			
128	LGA02-BP06	ONLINE		45.63.15.243	6	7	6			
129	LAX02-BP02	ONLINE		104.207.155.94	4	7	6			
130	IAD02-STATSAPI01	ONLINE		52.1.122.69	1	9	2			
134	IAD02-ESURL01	ONLINE		40.76.47.69	1	20	16			
137	IAD02-LS01	ONLINE		40.76.90.119	1	22	16			
138	PDX02-BP01	ONLINE		52.40.96.154	34	7	2			
216	TYO02-BP01.REVSW.NET	ONLINE		45.76.199.222	16	7	6	1	1	1
141	MIL02-BP01	ONLINE		149.154.157.189	37	7	11			
142	STO02-BP01	ONLINE		178.73.210.197	38	7	11			
144	MIA02-BP02	ONLINE		104.207.146.230	14	7	6			
145	LON02-BP02	ONLINE		108.61.197.157	7	7	6			
148	SJC02-BP02	ONLINE		45.32.128.84	2	7	6			
149	DEV-GATEWAY	ONLINE		184.105.140.178	40	23	19			
202	IAD02-ESURL02	ONLINE		13.90.210.162	1	20	16			
152	JNB02-BP01	ONLINE		154.127.60.162	41	7	21			
153	LAS02-BP01	ONLINE		104.238.198.22	42	7	22			
154	BLR02-BP01	ONLINE		139.59.11.9	43	7	15			
143	SVX02-BP01	ONLINE		185.173.178.66	39	7	18			
156	BLR02-BP02	ONLINE		139.59.42.75	43	7	15			
157	BLR02-BP03	ONLINE		139.59.42.168	43	7	15			
158	BLR02-BP04	ONLINE		139.59.38.233	43	7	15			
159	SIN02-BP01	ONLINE		128.199.95.18	18	7	15			
220	LON02-BP03.REVSW.NET	ONLINE		139.162.253.101	7	7	25	1	1	1
161	BLR02-BP06	ONLINE		139.59.60.109	43	7	15			
162	BLR02-BP07	ONLINE		139.59.17.121	43	7	15			
166	SIN02-BP03	ONLINE		128.199.115.161	18	7	15			
167	SIN02-BP06	ONLINE		139.59.97.27	18	7	15			
168	SIN02-BP05	ONLINE		139.59.116.185	18	7	15			
169	BOM02-BP01	ONLINE		52.66.166.83	45	7	2			
170	VIE02-BP01	ONLINE		158.255.211.3	46	7	11			
171	IAD02-ES08	ONLINE		52.179.186.250	1	16	16			
160	BLR02-BP05	ONLINE		139.59.15.4	43	7	15			
124	LGA02-ESURL01	ONLINE		45.63.6.120	6	20	6			
172	LGA02-BP07	ONLINE		45.63.4.39	6	7	6			
268	FRA02-BP06.REVSW.NET	ONLINE		46.165.252.121	19	7	8	1	1	1
174	VIE02-BP02	ONLINE		149.154.152.46	46	7	11			
224	MAA02-WPT01	ONLINE		13.71.121.136	9	26	16			
228	ATL02-TARANTOOL01	ONLINE		45.32.212.76	26	27	6			
230	LGA02-BP09.REVSW.NET	ONLINE		207.148.25.109	6	7	6	1	1	1
179	LAX02-BP01	ONLINE		45.77.68.109	4	7	6			
232	SJC02-TARANTOOL01	ONLINE		45.77.187.69	2	27	6			
236	BLR02-BP03.REVSW.NET	ONLINE		139.59.42.168	43	7	15	1	1	1
184	LGA02-BP03	ONLINE		67.205.184.172	6	7	15			
185	FRA02-BP02	ONLINE		149.154.159.169	19	7	11			
190	IAD02-ES10	ONLINE		52.177.187.178	1	16	16			
191	DFW02-BP01	ONLINE		45.76.232.233	5	7	6			
192	IAD02-ES11	ONLINE		52.179.159.77	1	16	16			
189	IAD02-ES09	ONLINE		52.179.136.136	1	16	16			
193	IAD02-ES12	ONLINE		52.225.128.250	1	16	16			
194	ORD03-LS01	ONLINE		52.240.145.54	47	22	16			
196	IAD02-BP02	ONLINE		207.244.68.192	1	7	8			
197	GRZ02-BP01	ONLINE		151.236.30.26	48	7	11			
151	HKG02-BP01	ONLINE		47.52.75.193	11	7	24			
198	ORD02-BP02	ONLINE		45.76.28.203	10	7	6			
199	SJC02-WT01	ONLINE		40.83.145.95	2	24	16			
200	SJC02-WPT-SERVER01	ONLINE		13.64.159.148	2	25	16			
201	SJC02-WPT01	ONLINE		13.64.79.16	2	26	16			
270	FRA02-BP08.REVSW.NET	ONLINE		185.17.146.150	19	7	8	1	1	1
203	MIA02-BP01	ONLINE		45.77.162.26	14	7	6			
204	SJC02-WPT02	ONLINE		13.91.2.9	2	26	16			
256	ORD02-TARANTOOL01	ONLINE		45.63.65.149	10	27	6			
258	DFW02-TARANTOOL01	ONLINE		23.239.29.32	5	27	25			
260	IAD02-TARANTOOL01	ONLINE		207.244.103.147	1	27	8			
262	SYD02-TARANTOOL01.REVSW.NET	ONLINE		207.148.83.228	17	27	6			
264	JON-HOME-IP-COMCAST	ONLINE		98.207.92.71	1	14	9			
266	FRA02-BP04.REVSW.NET	ONLINE		185.17.146.152	19	7	8	1	1	1
173	JON2-HOME-IP	ONLINE	Jon's folks in San Diego	72.199.237.160	1	14	9			
272	PHX02-BP02.REVSW.NET	ONLINE		69.64.74.182	8	7	4	1	1	1
274	ZUH02-BP01.REVSW.NET	ONLINE		183.61.10.145	53	7	30	1	1	1
\.


--
-- Name: servers_server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('servers_server_id_seq', 274, true);


--
-- Data for Name: servers_type; Type: TABLE DATA; Schema: public; Owner: infradb
--

COPY servers_type (id, name, category_id, code) FROM stdin;
1	Install	1	INSTALL
2	Monitor	1	MONITOR
3	Graphite	1	GRAPHITE
5	Portal	1	PORTAL
6	Cmdb	1	CMDB
7	BP	2	BP
9	API	1	API
10	BACKUP	1	BACKUP
4	MANAGER	1	MANAGER
11	RMDB	1	RMDB
12	RUM	1	RUM
13	CUBE	1	CUBE
14	HOMEIP	3	HOMEIP
15	WEBSITE	1	WEBSITE
16	ElasticSearch	1	ES
17	ElasticSearch Aggregation	1	ESAGG
18	RMDBDEBUG	1	RMDBDEBUG
19	CDS	1	CDS
20	ElasticSearch URL	1	ESURL
21	SDK Stats API Service	1	STATSAPI
22	Log Shipping Servers	1	LS
23	Fremont Dev Environment	4	DEV
24	Servers running revsw-webtest package	1	WT
25	WPTSERVER Linux box driving Windows WPT servers	1	WPTSERVER
26	WPT Windows box	1	WPT
27	TARANTOOL	2	TARANTOOL
\.


--
-- Name: servers_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: infradb
--

SELECT pg_catalog.setval('servers_type_id_seq', 27, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_45f3b1d93ec8c61c_uniq; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_45f3b1d93ec8c61c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: servers_category_code_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_category
    ADD CONSTRAINT servers_category_code_key UNIQUE (code);


--
-- Name: servers_category_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_category
    ADD CONSTRAINT servers_category_pkey PRIMARY KEY (id);


--
-- Name: servers_hostingprovider_code_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_hostingprovider
    ADD CONSTRAINT servers_hostingprovider_code_key UNIQUE (code);


--
-- Name: servers_hostingprovider_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_hostingprovider
    ADD CONSTRAINT servers_hostingprovider_pkey PRIMARY KEY (id);


--
-- Name: servers_location_code_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_location
    ADD CONSTRAINT servers_location_code_key UNIQUE (code);


--
-- Name: servers_location_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_location
    ADD CONSTRAINT servers_location_pkey PRIMARY KEY (id);


--
-- Name: servers_server_name_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_server
    ADD CONSTRAINT servers_server_name_key UNIQUE (name);


--
-- Name: servers_server_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_server
    ADD CONSTRAINT servers_server_pkey PRIMARY KEY (id);


--
-- Name: servers_type_code_key; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_type
    ADD CONSTRAINT servers_type_code_key UNIQUE (code);


--
-- Name: servers_type_pkey; Type: CONSTRAINT; Schema: public; Owner: infradb; Tablespace: 
--

ALTER TABLE ONLY servers_type
    ADD CONSTRAINT servers_type_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: servers_server_94757cae; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX servers_server_94757cae ON servers_server USING btree (type_id);


--
-- Name: servers_server_a3661362; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX servers_server_a3661362 ON servers_server USING btree (hostingprovider_id);


--
-- Name: servers_server_e274a5da; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX servers_server_e274a5da ON servers_server USING btree (location_id);


--
-- Name: servers_type_b583a629; Type: INDEX; Schema: public; Owner: infradb; Tablespace: 
--

CREATE INDEX servers_type_b583a629 ON servers_type USING btree (category_id);


--
-- Name: auth_content_type_id_508cf46651277a81_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_508cf46651277a81_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_689710a9a73b7457_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_384b62483d7071f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_7f0938558328534a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: d9e3e571e3878fa370c035749bdb4494; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_server
    ADD CONSTRAINT d9e3e571e3878fa370c035749bdb4494 FOREIGN KEY (hostingprovider_id) REFERENCES servers_hostingprovider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_697914295151027a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_697914295151027a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: servers_ser_location_id_5b65cb92778df0c9_fk_servers_location_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_server
    ADD CONSTRAINT servers_ser_location_id_5b65cb92778df0c9_fk_servers_location_id FOREIGN KEY (location_id) REFERENCES servers_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: servers_server_type_id_5973360121d8008a_fk_servers_type_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_server
    ADD CONSTRAINT servers_server_type_id_5973360121d8008a_fk_servers_type_id FOREIGN KEY (type_id) REFERENCES servers_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: servers_typ_category_id_3eadfb4453fd6ff3_fk_servers_category_id; Type: FK CONSTRAINT; Schema: public; Owner: infradb
--

ALTER TABLE ONLY servers_type
    ADD CONSTRAINT servers_typ_category_id_3eadfb4453fd6ff3_fk_servers_category_id FOREIGN KEY (category_id) REFERENCES servers_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

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
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

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
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

