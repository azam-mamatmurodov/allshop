--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_client; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_client (
    id integer NOT NULL,
    address text,
    delivery_address_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.account_client OWNER TO allshop;

--
-- Name: account_client_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_client_id_seq OWNER TO allshop;

--
-- Name: account_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_client_id_seq OWNED BY public.account_client.id;


--
-- Name: account_deliveryaddress; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_deliveryaddress (
    id integer NOT NULL,
    address text NOT NULL,
    email character varying(60) NOT NULL,
    phone character varying(60) NOT NULL,
    is_default boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_deliveryaddress OWNER TO allshop;

--
-- Name: account_deliveryaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_deliveryaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_deliveryaddress_id_seq OWNER TO allshop;

--
-- Name: account_deliveryaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_deliveryaddress_id_seq OWNED BY public.account_deliveryaddress.id;


--
-- Name: account_files; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_files (
    id integer NOT NULL,
    file character varying(100) NOT NULL
);


ALTER TABLE public.account_files OWNER TO allshop;

--
-- Name: account_files_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_files_id_seq OWNER TO allshop;

--
-- Name: account_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_files_id_seq OWNED BY public.account_files.id;


--
-- Name: account_merchant; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_merchant (
    id integer NOT NULL,
    merchant_type integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_merchant OWNER TO allshop;

--
-- Name: account_merchant_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_merchant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_merchant_id_seq OWNER TO allshop;

--
-- Name: account_merchant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_merchant_id_seq OWNED BY public.account_merchant.id;


--
-- Name: account_paymentcards; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_paymentcards (
    id integer NOT NULL,
    card_holder character varying(60) NOT NULL,
    cart_number character varying(60) NOT NULL,
    expiration_date date NOT NULL,
    billing_address text,
    is_default boolean NOT NULL,
    holder_id integer NOT NULL
);


ALTER TABLE public.account_paymentcards OWNER TO allshop;

--
-- Name: account_paymentcards_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_paymentcards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_paymentcards_id_seq OWNER TO allshop;

--
-- Name: account_paymentcards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_paymentcards_id_seq OWNED BY public.account_paymentcards.id;


--
-- Name: account_user; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_staff boolean NOT NULL,
    phone character varying(12) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    is_active boolean NOT NULL,
    email character varying(254),
    avatar_id integer
);


ALTER TABLE public.account_user OWNER TO allshop;

--
-- Name: account_user_groups; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.account_user_groups OWNER TO allshop;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_groups_id_seq OWNER TO allshop;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_user_groups_id_seq OWNED BY public.account_user_groups.id;


--
-- Name: account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_id_seq OWNER TO allshop;

--
-- Name: account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_user_id_seq OWNED BY public.account_user.id;


--
-- Name: account_user_user_permissions; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.account_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.account_user_user_permissions OWNER TO allshop;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.account_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_user_permissions_id_seq OWNER TO allshop;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.account_user_user_permissions_id_seq OWNED BY public.account_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO allshop;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO allshop;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO allshop;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO allshop;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO allshop;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO allshop;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: basic_banner; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_banner (
    id integer NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.basic_banner OWNER TO allshop;

--
-- Name: basic_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_banner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_banner_id_seq OWNER TO allshop;

--
-- Name: basic_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_banner_id_seq OWNED BY public.basic_banner.id;


--
-- Name: basic_banner_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_banner_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    image character varying(100) NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_banner_translation OWNER TO allshop;

--
-- Name: basic_banner_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_banner_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_banner_translation_id_seq OWNER TO allshop;

--
-- Name: basic_banner_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_banner_translation_id_seq OWNED BY public.basic_banner_translation.id;


--
-- Name: basic_customermenu; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_customermenu (
    id integer NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.basic_customermenu OWNER TO allshop;

--
-- Name: basic_customermenu_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_customermenu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_customermenu_id_seq OWNER TO allshop;

--
-- Name: basic_customermenu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_customermenu_id_seq OWNED BY public.basic_customermenu.id;


--
-- Name: basic_customermenu_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_customermenu_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_customermenu_translation OWNER TO allshop;

--
-- Name: basic_customermenu_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_customermenu_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_customermenu_translation_id_seq OWNER TO allshop;

--
-- Name: basic_customermenu_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_customermenu_translation_id_seq OWNED BY public.basic_customermenu_translation.id;


--
-- Name: basic_menu; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_menu (
    id integer NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.basic_menu OWNER TO allshop;

--
-- Name: basic_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_menu_id_seq OWNER TO allshop;

--
-- Name: basic_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_menu_id_seq OWNED BY public.basic_menu.id;


--
-- Name: basic_menu_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_menu_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_menu_translation OWNER TO allshop;

--
-- Name: basic_menu_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_menu_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_menu_translation_id_seq OWNER TO allshop;

--
-- Name: basic_menu_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_menu_translation_id_seq OWNED BY public.basic_menu_translation.id;


--
-- Name: basic_static; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_static (
    id integer NOT NULL
);


ALTER TABLE public.basic_static OWNER TO allshop;

--
-- Name: basic_static_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_static_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_static_id_seq OWNER TO allshop;

--
-- Name: basic_static_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_static_id_seq OWNED BY public.basic_static.id;


--
-- Name: basic_static_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_static_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    image character varying(100),
    body text NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_static_translation OWNER TO allshop;

--
-- Name: basic_static_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_static_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_static_translation_id_seq OWNER TO allshop;

--
-- Name: basic_static_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_static_translation_id_seq OWNED BY public.basic_static_translation.id;


--
-- Name: basic_staticfooterpage; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_staticfooterpage (
    id integer NOT NULL,
    menu_type integer
);


ALTER TABLE public.basic_staticfooterpage OWNER TO allshop;

--
-- Name: basic_staticfooterpage_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_staticfooterpage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_staticfooterpage_id_seq OWNER TO allshop;

--
-- Name: basic_staticfooterpage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_staticfooterpage_id_seq OWNED BY public.basic_staticfooterpage.id;


--
-- Name: basic_staticfooterpage_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_staticfooterpage_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    body text NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_staticfooterpage_translation OWNER TO allshop;

--
-- Name: basic_staticfooterpage_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_staticfooterpage_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_staticfooterpage_translation_id_seq OWNER TO allshop;

--
-- Name: basic_staticfooterpage_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_staticfooterpage_translation_id_seq OWNED BY public.basic_staticfooterpage_translation.id;


--
-- Name: basic_usermenu; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_usermenu (
    id integer NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.basic_usermenu OWNER TO allshop;

--
-- Name: basic_usermenu_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_usermenu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_usermenu_id_seq OWNER TO allshop;

--
-- Name: basic_usermenu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_usermenu_id_seq OWNED BY public.basic_usermenu.id;


--
-- Name: basic_usermenu_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.basic_usermenu_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(60) NOT NULL,
    master_id integer
);


ALTER TABLE public.basic_usermenu_translation OWNER TO allshop;

--
-- Name: basic_usermenu_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.basic_usermenu_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basic_usermenu_translation_id_seq OWNER TO allshop;

--
-- Name: basic_usermenu_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.basic_usermenu_translation_id_seq OWNED BY public.basic_usermenu_translation.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO allshop;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO allshop;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO allshop;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO allshop;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO allshop;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO allshop;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO allshop;

--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.easy_thumbnails_source OWNER TO allshop;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.easy_thumbnails_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_source_id_seq OWNER TO allshop;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.easy_thumbnails_source_id_seq OWNED BY public.easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE public.easy_thumbnails_thumbnail OWNER TO allshop;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.easy_thumbnails_thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnail_id_seq OWNER TO allshop;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.easy_thumbnails_thumbnail_id_seq OWNED BY public.easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnaildimensions; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);


ALTER TABLE public.easy_thumbnails_thumbnaildimensions OWNER TO allshop;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnaildimensions_id_seq OWNER TO allshop;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq OWNED BY public.easy_thumbnails_thumbnaildimensions.id;


--
-- Name: filer_clipboard; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_clipboard (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.filer_clipboard OWNER TO allshop;

--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_clipboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_clipboard_id_seq OWNER TO allshop;

--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_clipboard_id_seq OWNED BY public.filer_clipboard.id;


--
-- Name: filer_clipboarditem; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_clipboarditem (
    id integer NOT NULL,
    clipboard_id integer NOT NULL,
    file_id integer NOT NULL
);


ALTER TABLE public.filer_clipboarditem OWNER TO allshop;

--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_clipboarditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_clipboarditem_id_seq OWNER TO allshop;

--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_clipboarditem_id_seq OWNED BY public.filer_clipboarditem.id;


--
-- Name: filer_file; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_file (
    id integer NOT NULL,
    file character varying(255),
    _file_size bigint,
    sha1 character varying(40) NOT NULL,
    has_all_mandatory_data boolean NOT NULL,
    original_filename character varying(255),
    name character varying(255) NOT NULL,
    description text,
    uploaded_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    is_public boolean NOT NULL,
    folder_id integer,
    owner_id integer,
    polymorphic_ctype_id integer
);


ALTER TABLE public.filer_file OWNER TO allshop;

--
-- Name: filer_file_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_file_id_seq OWNER TO allshop;

--
-- Name: filer_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_file_id_seq OWNED BY public.filer_file.id;


--
-- Name: filer_folder; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_folder (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    owner_id integer,
    parent_id integer,
    CONSTRAINT filer_folder_level_check CHECK ((level >= 0)),
    CONSTRAINT filer_folder_lft_check CHECK ((lft >= 0)),
    CONSTRAINT filer_folder_rght_check CHECK ((rght >= 0)),
    CONSTRAINT filer_folder_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.filer_folder OWNER TO allshop;

--
-- Name: filer_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_folder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_folder_id_seq OWNER TO allshop;

--
-- Name: filer_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_folder_id_seq OWNED BY public.filer_folder.id;


--
-- Name: filer_folderpermission; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_folderpermission (
    id integer NOT NULL,
    type smallint NOT NULL,
    everybody boolean NOT NULL,
    can_edit smallint,
    can_read smallint,
    can_add_children smallint,
    folder_id integer,
    group_id integer,
    user_id integer
);


ALTER TABLE public.filer_folderpermission OWNER TO allshop;

--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_folderpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_folderpermission_id_seq OWNER TO allshop;

--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_folderpermission_id_seq OWNED BY public.filer_folderpermission.id;


--
-- Name: filer_image; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_image (
    file_ptr_id integer NOT NULL,
    _height integer,
    _width integer,
    date_taken timestamp with time zone,
    default_alt_text character varying(255),
    default_caption character varying(255),
    author character varying(255),
    must_always_publish_author_credit boolean NOT NULL,
    must_always_publish_copyright boolean NOT NULL,
    subject_location character varying(64) NOT NULL
);


ALTER TABLE public.filer_image OWNER TO allshop;

--
-- Name: filer_thumbnailoption; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.filer_thumbnailoption (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    crop boolean NOT NULL,
    upscale boolean NOT NULL
);


ALTER TABLE public.filer_thumbnailoption OWNER TO allshop;

--
-- Name: filer_thumbnailoption_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.filer_thumbnailoption_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filer_thumbnailoption_id_seq OWNER TO allshop;

--
-- Name: filer_thumbnailoption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.filer_thumbnailoption_id_seq OWNED BY public.filer_thumbnailoption.id;


--
-- Name: order_cart; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.order_cart (
    id integer NOT NULL,
    session_key character varying(255) NOT NULL,
    count integer NOT NULL,
    status boolean NOT NULL,
    total_price numeric(10,2) NOT NULL,
    order_id integer,
    variation_id integer NOT NULL
);


ALTER TABLE public.order_cart OWNER TO allshop;

--
-- Name: order_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.order_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_cart_id_seq OWNER TO allshop;

--
-- Name: order_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.order_cart_id_seq OWNED BY public.order_cart.id;


--
-- Name: order_order; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.order_order (
    id integer NOT NULL,
    client_name character varying(60) NOT NULL,
    phone character varying(12) NOT NULL,
    shipping_address text NOT NULL,
    created timestamp with time zone NOT NULL,
    order_unique_id character varying(120),
    products text,
    total_weight integer NOT NULL,
    delivery_price double precision NOT NULL,
    porter_work_price double precision NOT NULL,
    products_price double precision,
    total_price numeric(10,2),
    shipping_time timestamp with time zone,
    need_porter boolean NOT NULL,
    state integer NOT NULL,
    customer_id integer,
    payment_id integer
);


ALTER TABLE public.order_order OWNER TO allshop;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_order_id_seq OWNER TO allshop;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public.order_order.id;


--
-- Name: order_paymentmethod; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.order_paymentmethod (
    id integer NOT NULL,
    title character varying(60) NOT NULL,
    method character varying(40) NOT NULL,
    logo_id integer
);


ALTER TABLE public.order_paymentmethod OWNER TO allshop;

--
-- Name: order_paymentmethod_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.order_paymentmethod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_paymentmethod_id_seq OWNER TO allshop;

--
-- Name: order_paymentmethod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.order_paymentmethod_id_seq OWNED BY public.order_paymentmethod.id;


--
-- Name: order_paymentmethod_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.order_paymentmethod_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    description text,
    master_id integer
);


ALTER TABLE public.order_paymentmethod_translation OWNER TO allshop;

--
-- Name: order_paymentmethod_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.order_paymentmethod_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_paymentmethod_translation_id_seq OWNER TO allshop;

--
-- Name: order_paymentmethod_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.order_paymentmethod_translation_id_seq OWNED BY public.order_paymentmethod_translation.id;


--
-- Name: payment_paycomtransaction; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.payment_paycomtransaction (
    id integer NOT NULL,
    paycom_transaction_id character varying(255) NOT NULL,
    paycom_time character varying(15) NOT NULL,
    paycom_time_datetime timestamp with time zone NOT NULL,
    create_time timestamp with time zone NOT NULL,
    perform_time timestamp with time zone,
    cancel_time timestamp with time zone,
    amount character varying(50) NOT NULL,
    state integer NOT NULL,
    reason integer,
    receivers text,
    order_id integer NOT NULL
);


ALTER TABLE public.payment_paycomtransaction OWNER TO allshop;

--
-- Name: payment_paycomtransaction_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.payment_paycomtransaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_paycomtransaction_id_seq OWNER TO allshop;

--
-- Name: payment_paycomtransaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.payment_paycomtransaction_id_seq OWNED BY public.payment_paycomtransaction.id;


--
-- Name: product_brands; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_brands (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    logo character varying(100) NOT NULL,
    category_id integer
);


ALTER TABLE public.product_brands OWNER TO allshop;

--
-- Name: product_brands_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_brands_id_seq OWNER TO allshop;

--
-- Name: product_brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_brands_id_seq OWNED BY public.product_brands.id;


--
-- Name: product_category; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_category (
    id integer NOT NULL,
    "order" integer NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    mptt_level integer NOT NULL,
    parent_id integer,
    CONSTRAINT product_category_lft_check CHECK ((lft >= 0)),
    CONSTRAINT product_category_mptt_level_check CHECK ((mptt_level >= 0)),
    CONSTRAINT product_category_rght_check CHECK ((rght >= 0)),
    CONSTRAINT product_category_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.product_category OWNER TO allshop;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_category_id_seq OWNER TO allshop;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- Name: product_category_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_category_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(50) NOT NULL,
    master_id integer
);


ALTER TABLE public.product_category_translation OWNER TO allshop;

--
-- Name: product_category_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_category_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_category_translation_id_seq OWNER TO allshop;

--
-- Name: product_category_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_category_translation_id_seq OWNED BY public.product_category_translation.id;


--
-- Name: product_color; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_color (
    id integer NOT NULL,
    color character varying(18) NOT NULL
);


ALTER TABLE public.product_color OWNER TO allshop;

--
-- Name: product_color_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_color_id_seq OWNER TO allshop;

--
-- Name: product_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_color_id_seq OWNED BY public.product_color.id;


--
-- Name: product_color_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_color_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    master_id integer
);


ALTER TABLE public.product_color_translation OWNER TO allshop;

--
-- Name: product_color_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_color_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_color_translation_id_seq OWNER TO allshop;

--
-- Name: product_color_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_color_translation_id_seq OWNED BY public.product_color_translation.id;


--
-- Name: product_feature; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_feature (
    id integer NOT NULL
);


ALTER TABLE public.product_feature OWNER TO allshop;

--
-- Name: product_feature_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_feature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_feature_id_seq OWNER TO allshop;

--
-- Name: product_feature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_feature_id_seq OWNED BY public.product_feature.id;


--
-- Name: product_feature_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_feature_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    slug character varying(50) NOT NULL,
    master_id integer
);


ALTER TABLE public.product_feature_translation OWNER TO allshop;

--
-- Name: product_feature_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_feature_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_feature_translation_id_seq OWNER TO allshop;

--
-- Name: product_feature_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_feature_translation_id_seq OWNED BY public.product_feature_translation.id;


--
-- Name: product_product; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_product (
    updated date NOT NULL,
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    description text,
    characters text,
    available_in_stock boolean NOT NULL,
    is_recommended boolean NOT NULL,
    price numeric(10,2),
    is_top boolean NOT NULL,
    default_image character varying(60) NOT NULL,
    brand_id integer NOT NULL,
    category_id integer NOT NULL,
    feature_id integer,
    image_0_id integer,
    image_1_id integer,
    image_2_id integer,
    owner_id integer NOT NULL,
    volume_id integer NOT NULL
);


ALTER TABLE public.product_product OWNER TO allshop;

--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_product_id_seq OWNER TO allshop;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product_product.id;


--
-- Name: product_productimage; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_productimage (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.product_productimage OWNER TO allshop;

--
-- Name: product_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_productimage_id_seq OWNER TO allshop;

--
-- Name: product_productimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_productimage_id_seq OWNED BY public.product_productimage.id;


--
-- Name: product_review; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_review (
    created_at timestamp with time zone NOT NULL,
    id integer NOT NULL,
    reviewer character varying(120) NOT NULL,
    reviewer_location character varying(120),
    subject character varying(60) NOT NULL,
    text text NOT NULL,
    is_approved boolean NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.product_review OWNER TO allshop;

--
-- Name: product_review_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_review_id_seq OWNER TO allshop;

--
-- Name: product_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_review_id_seq OWNED BY public.product_review.id;


--
-- Name: product_variation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_variation (
    id integer NOT NULL,
    name character varying(60) NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    color_id integer,
    product_id integer NOT NULL
);


ALTER TABLE public.product_variation OWNER TO allshop;

--
-- Name: product_variation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_variation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_variation_id_seq OWNER TO allshop;

--
-- Name: product_variation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_variation_id_seq OWNED BY public.product_variation.id;


--
-- Name: product_volumetype; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_volumetype (
    id integer NOT NULL
);


ALTER TABLE public.product_volumetype OWNER TO allshop;

--
-- Name: product_volumetype_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_volumetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_volumetype_id_seq OWNER TO allshop;

--
-- Name: product_volumetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_volumetype_id_seq OWNED BY public.product_volumetype.id;


--
-- Name: product_volumetype_translation; Type: TABLE; Schema: public; Owner: allshop
--

CREATE TABLE public.product_volumetype_translation (
    id integer NOT NULL,
    language_code character varying(15) NOT NULL,
    name character varying(60) NOT NULL,
    master_id integer
);


ALTER TABLE public.product_volumetype_translation OWNER TO allshop;

--
-- Name: product_volumetype_translation_id_seq; Type: SEQUENCE; Schema: public; Owner: allshop
--

CREATE SEQUENCE public.product_volumetype_translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_volumetype_translation_id_seq OWNER TO allshop;

--
-- Name: product_volumetype_translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: allshop
--

ALTER SEQUENCE public.product_volumetype_translation_id_seq OWNED BY public.product_volumetype_translation.id;


--
-- Name: account_client id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_client ALTER COLUMN id SET DEFAULT nextval('public.account_client_id_seq'::regclass);


--
-- Name: account_deliveryaddress id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_deliveryaddress ALTER COLUMN id SET DEFAULT nextval('public.account_deliveryaddress_id_seq'::regclass);


--
-- Name: account_files id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_files ALTER COLUMN id SET DEFAULT nextval('public.account_files_id_seq'::regclass);


--
-- Name: account_merchant id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_merchant ALTER COLUMN id SET DEFAULT nextval('public.account_merchant_id_seq'::regclass);


--
-- Name: account_paymentcards id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_paymentcards ALTER COLUMN id SET DEFAULT nextval('public.account_paymentcards_id_seq'::regclass);


--
-- Name: account_user id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user ALTER COLUMN id SET DEFAULT nextval('public.account_user_id_seq'::regclass);


--
-- Name: account_user_groups id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_groups ALTER COLUMN id SET DEFAULT nextval('public.account_user_groups_id_seq'::regclass);


--
-- Name: account_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.account_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: basic_banner id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner ALTER COLUMN id SET DEFAULT nextval('public.basic_banner_id_seq'::regclass);


--
-- Name: basic_banner_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_banner_translation_id_seq'::regclass);


--
-- Name: basic_customermenu id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu ALTER COLUMN id SET DEFAULT nextval('public.basic_customermenu_id_seq'::regclass);


--
-- Name: basic_customermenu_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_customermenu_translation_id_seq'::regclass);


--
-- Name: basic_menu id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu ALTER COLUMN id SET DEFAULT nextval('public.basic_menu_id_seq'::regclass);


--
-- Name: basic_menu_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_menu_translation_id_seq'::regclass);


--
-- Name: basic_static id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static ALTER COLUMN id SET DEFAULT nextval('public.basic_static_id_seq'::regclass);


--
-- Name: basic_static_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_static_translation_id_seq'::regclass);


--
-- Name: basic_staticfooterpage id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage ALTER COLUMN id SET DEFAULT nextval('public.basic_staticfooterpage_id_seq'::regclass);


--
-- Name: basic_staticfooterpage_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_staticfooterpage_translation_id_seq'::regclass);


--
-- Name: basic_usermenu id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu ALTER COLUMN id SET DEFAULT nextval('public.basic_usermenu_id_seq'::regclass);


--
-- Name: basic_usermenu_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu_translation ALTER COLUMN id SET DEFAULT nextval('public.basic_usermenu_translation_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: easy_thumbnails_source id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_source_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnail id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: easy_thumbnails_thumbnaildimensions id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('public.easy_thumbnails_thumbnaildimensions_id_seq'::regclass);


--
-- Name: filer_clipboard id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboard ALTER COLUMN id SET DEFAULT nextval('public.filer_clipboard_id_seq'::regclass);


--
-- Name: filer_clipboarditem id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboarditem ALTER COLUMN id SET DEFAULT nextval('public.filer_clipboarditem_id_seq'::regclass);


--
-- Name: filer_file id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_file ALTER COLUMN id SET DEFAULT nextval('public.filer_file_id_seq'::regclass);


--
-- Name: filer_folder id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folder ALTER COLUMN id SET DEFAULT nextval('public.filer_folder_id_seq'::regclass);


--
-- Name: filer_folderpermission id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folderpermission ALTER COLUMN id SET DEFAULT nextval('public.filer_folderpermission_id_seq'::regclass);


--
-- Name: filer_thumbnailoption id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_thumbnailoption ALTER COLUMN id SET DEFAULT nextval('public.filer_thumbnailoption_id_seq'::regclass);


--
-- Name: order_cart id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_cart ALTER COLUMN id SET DEFAULT nextval('public.order_cart_id_seq'::regclass);


--
-- Name: order_order id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_order ALTER COLUMN id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- Name: order_paymentmethod id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod ALTER COLUMN id SET DEFAULT nextval('public.order_paymentmethod_id_seq'::regclass);


--
-- Name: order_paymentmethod_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod_translation ALTER COLUMN id SET DEFAULT nextval('public.order_paymentmethod_translation_id_seq'::regclass);


--
-- Name: payment_paycomtransaction id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.payment_paycomtransaction ALTER COLUMN id SET DEFAULT nextval('public.payment_paycomtransaction_id_seq'::regclass);


--
-- Name: product_brands id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_brands ALTER COLUMN id SET DEFAULT nextval('public.product_brands_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- Name: product_category_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category_translation ALTER COLUMN id SET DEFAULT nextval('public.product_category_translation_id_seq'::regclass);


--
-- Name: product_color id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color ALTER COLUMN id SET DEFAULT nextval('public.product_color_id_seq'::regclass);


--
-- Name: product_color_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color_translation ALTER COLUMN id SET DEFAULT nextval('public.product_color_translation_id_seq'::regclass);


--
-- Name: product_feature id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature ALTER COLUMN id SET DEFAULT nextval('public.product_feature_id_seq'::regclass);


--
-- Name: product_feature_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation ALTER COLUMN id SET DEFAULT nextval('public.product_feature_translation_id_seq'::regclass);


--
-- Name: product_product id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product ALTER COLUMN id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- Name: product_productimage id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_productimage ALTER COLUMN id SET DEFAULT nextval('public.product_productimage_id_seq'::regclass);


--
-- Name: product_review id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_review ALTER COLUMN id SET DEFAULT nextval('public.product_review_id_seq'::regclass);


--
-- Name: product_variation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_variation ALTER COLUMN id SET DEFAULT nextval('public.product_variation_id_seq'::regclass);


--
-- Name: product_volumetype id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype ALTER COLUMN id SET DEFAULT nextval('public.product_volumetype_id_seq'::regclass);


--
-- Name: product_volumetype_translation id; Type: DEFAULT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype_translation ALTER COLUMN id SET DEFAULT nextval('public.product_volumetype_translation_id_seq'::regclass);


--
-- Data for Name: account_client; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_client (id, address, delivery_address_id, user_id) FROM stdin;
\.


--
-- Name: account_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_client_id_seq', 1, false);


--
-- Data for Name: account_deliveryaddress; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_deliveryaddress (id, address, email, phone, is_default, user_id) FROM stdin;
\.


--
-- Name: account_deliveryaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_deliveryaddress_id_seq', 1, false);


--
-- Data for Name: account_files; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_files (id, file) FROM stdin;
\.


--
-- Name: account_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_files_id_seq', 1, false);


--
-- Data for Name: account_merchant; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_merchant (id, merchant_type, user_id) FROM stdin;
1	2	1
\.


--
-- Name: account_merchant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_merchant_id_seq', 1, true);


--
-- Data for Name: account_paymentcards; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_paymentcards (id, card_holder, cart_number, expiration_date, billing_address, is_default, holder_id) FROM stdin;
\.


--
-- Name: account_paymentcards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_paymentcards_id_seq', 1, false);


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_user (id, password, last_login, is_superuser, is_staff, phone, first_name, last_name, date_joined, is_active, email, avatar_id) FROM stdin;
1	pbkdf2_sha256$36000$vxTIBwsUZu6J$UH+ryA8lXb4NKuFrdYCl88YPfdYjXumFNQWIAdXQyQ0=	2018-09-11 00:27:25.336147+05	t	t	admin	Admin		2018-09-11 00:23:05.999758+05	t	\N	\N
\.


--
-- Data for Name: account_user_groups; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: account_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_user_groups_id_seq', 1, false);


--
-- Name: account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_user_id_seq', 1, true);


--
-- Data for Name: account_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.account_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.account_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add source	6	add_source
17	Can change source	6	change_source
18	Can delete source	6	delete_source
19	Can add thumbnail	7	add_thumbnail
20	Can change thumbnail	7	change_thumbnail
21	Can delete thumbnail	7	delete_thumbnail
22	Can add thumbnail dimensions	8	add_thumbnaildimensions
23	Can change thumbnail dimensions	8	change_thumbnaildimensions
24	Can delete thumbnail dimensions	8	delete_thumbnaildimensions
25	Can add clipboard	9	add_clipboard
26	Can change clipboard	9	change_clipboard
27	Can delete clipboard	9	delete_clipboard
28	Can add clipboard item	10	add_clipboarditem
29	Can change clipboard item	10	change_clipboarditem
30	Can delete clipboard item	10	delete_clipboarditem
31	Can add file	11	add_file
32	Can change file	11	change_file
33	Can delete file	11	delete_file
34	Can add Folder	12	add_folder
35	Can change Folder	12	change_folder
36	Can delete Folder	12	delete_folder
37	Can use directory listing	12	can_use_directory_listing
38	Can add folder permission	13	add_folderpermission
39	Can change folder permission	13	change_folderpermission
40	Can delete folder permission	13	delete_folderpermission
41	Can add image	14	add_image
42	Can change image	14	change_image
43	Can delete image	14	delete_image
44	Can add thumbnail option	15	add_thumbnailoption
45	Can change thumbnail option	15	change_thumbnailoption
46	Can delete thumbnail option	15	delete_thumbnailoption
47	Can add User	16	add_user
48	Can change User	16	change_user
49	Can delete User	16	delete_user
50	Can add client	17	add_client
51	Can change client	17	change_client
52	Can delete client	17	delete_client
53	Can add delivery address	18	add_deliveryaddress
54	Can change delivery address	18	change_deliveryaddress
55	Can delete delivery address	18	delete_deliveryaddress
56	Can add File	19	add_files
57	Can change File	19	change_files
58	Can delete File	19	delete_files
59	Can add merchant	20	add_merchant
60	Can change merchant	20	change_merchant
61	Can delete merchant	20	delete_merchant
62	Can add Payment method	21	add_paymentcards
63	Can change Payment method	21	change_paymentcards
64	Can delete Payment method	21	delete_paymentcards
65	Can add banner	22	add_banner
66	Can change banner	22	change_banner
67	Can delete banner	22	delete_banner
68	Can add customer menu	24	add_customermenu
69	Can change customer menu	24	change_customermenu
70	Can delete customer menu	24	delete_customermenu
71	Can add menu	26	add_menu
72	Can change menu	26	change_menu
73	Can delete menu	26	delete_menu
74	Can add static	28	add_static
75	Can change static	28	change_static
76	Can delete static	28	delete_static
77	Can add static footer page	29	add_staticfooterpage
78	Can change static footer page	29	change_staticfooterpage
79	Can delete static footer page	29	delete_staticfooterpage
80	Can add user menu	32	add_usermenu
81	Can change user menu	32	change_usermenu
82	Can delete user menu	32	delete_usermenu
83	Can add Cart item	34	add_cart
84	Can change Cart item	34	change_cart
85	Can delete Cart item	34	delete_cart
86	Can add order	35	add_order
87	Can change order	35	change_order
88	Can delete order	35	delete_order
89	Can add payment method	36	add_paymentmethod
90	Can change payment method	36	change_paymentmethod
91	Can delete payment method	36	delete_paymentmethod
92	Can add paycom transaction	38	add_paycomtransaction
93	Can change paycom transaction	38	change_paycomtransaction
94	Can delete paycom transaction	38	delete_paycomtransaction
95	Can add Brand	39	add_brands
96	Can change Brand	39	change_brands
97	Can delete Brand	39	delete_brands
98	Can add Category	40	add_category
99	Can change Category	40	change_category
100	Can delete Category	40	delete_category
101	Can add Color	42	add_color
102	Can change Color	42	change_color
103	Can delete Color	42	delete_color
104	Can add Feature	44	add_feature
105	Can change Feature	44	change_feature
106	Can delete Feature	44	delete_feature
107	Can add Product	46	add_product
108	Can change Product	46	change_product
109	Can delete Product	46	delete_product
110	Can add product image	47	add_productimage
111	Can change product image	47	change_productimage
112	Can delete product image	47	delete_productimage
113	Can add review	48	add_review
114	Can change review	48	change_review
115	Can delete review	48	delete_review
116	Can add Variation	49	add_variation
117	Can change Variation	49	change_variation
118	Can delete Variation	49	delete_variation
119	Can add volume type	50	add_volumetype
120	Can change volume type	50	change_volumetype
121	Can delete volume type	50	delete_volumetype
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 121, true);


--
-- Data for Name: basic_banner; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_banner (id, "order") FROM stdin;
\.


--
-- Name: basic_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_banner_id_seq', 1, false);


--
-- Data for Name: basic_banner_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_banner_translation (id, language_code, name, slug, image, master_id) FROM stdin;
\.


--
-- Name: basic_banner_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_banner_translation_id_seq', 1, false);


--
-- Data for Name: basic_customermenu; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_customermenu (id, "order") FROM stdin;
\.


--
-- Name: basic_customermenu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_customermenu_id_seq', 1, false);


--
-- Data for Name: basic_customermenu_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_customermenu_translation (id, language_code, name, slug, master_id) FROM stdin;
\.


--
-- Name: basic_customermenu_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_customermenu_translation_id_seq', 1, false);


--
-- Data for Name: basic_menu; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_menu (id, "order") FROM stdin;
\.


--
-- Name: basic_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_menu_id_seq', 1, false);


--
-- Data for Name: basic_menu_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_menu_translation (id, language_code, name, slug, master_id) FROM stdin;
\.


--
-- Name: basic_menu_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_menu_translation_id_seq', 1, false);


--
-- Data for Name: basic_static; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_static (id) FROM stdin;
\.


--
-- Name: basic_static_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_static_id_seq', 1, false);


--
-- Data for Name: basic_static_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_static_translation (id, language_code, name, slug, image, body, master_id) FROM stdin;
\.


--
-- Name: basic_static_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_static_translation_id_seq', 1, false);


--
-- Data for Name: basic_staticfooterpage; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_staticfooterpage (id, menu_type) FROM stdin;
\.


--
-- Name: basic_staticfooterpage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_staticfooterpage_id_seq', 1, false);


--
-- Data for Name: basic_staticfooterpage_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_staticfooterpage_translation (id, language_code, name, slug, body, master_id) FROM stdin;
\.


--
-- Name: basic_staticfooterpage_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_staticfooterpage_translation_id_seq', 1, false);


--
-- Data for Name: basic_usermenu; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_usermenu (id, "order") FROM stdin;
\.


--
-- Name: basic_usermenu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_usermenu_id_seq', 1, false);


--
-- Data for Name: basic_usermenu_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.basic_usermenu_translation (id, language_code, name, slug, master_id) FROM stdin;
\.


--
-- Name: basic_usermenu_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.basic_usermenu_translation_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-09-11 00:33:18.963052+05	1	Кг	1	[{"added": {}}]	50	1
2	2018-09-11 00:39:07.079382+05	1	Телефон	1	[{"added": {}}]	40	1
3	2018-09-11 00:40:00.23244+05	1	АйФон	1	[{"added": {}}]	39	1
4	2018-09-11 00:43:53.58874+05	1	Admin	1	[{"added": {}}]	20	1
5	2018-09-11 00:43:58.276377+05	1	Admin	2	[{"changed": {"fields": ["merchant_type"]}}]	20	1
6	2018-09-11 00:50:59.344478+05	6	dnsdknskdjnsjlkdnsjdnsjlkd	3		46	1
7	2018-09-11 00:52:55.339935+05	1	Красная	1	[{"added": {}}]	42	1
8	2018-09-11 00:56:00.96442+05	7	12asasa	3		46	1
9	2018-09-11 00:59:44.253921+05	8	12asasa	3		46	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 9, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	easy_thumbnails	source
7	easy_thumbnails	thumbnail
8	easy_thumbnails	thumbnaildimensions
9	filer	clipboard
10	filer	clipboarditem
11	filer	file
12	filer	folder
13	filer	folderpermission
14	filer	image
15	filer	thumbnailoption
16	account	user
17	account	client
18	account	deliveryaddress
19	account	files
20	account	merchant
21	account	paymentcards
22	basic	banner
23	basic	bannertranslation
24	basic	customermenu
25	basic	customermenutranslation
26	basic	menu
27	basic	menutranslation
28	basic	static
29	basic	staticfooterpage
30	basic	staticfooterpagetranslation
31	basic	statictranslation
32	basic	usermenu
33	basic	usermenutranslation
34	order	cart
35	order	order
36	order	paymentmethod
37	order	paymentmethodtranslation
38	payment	paycomtransaction
39	product	brands
40	product	category
41	product	categorytranslation
42	product	color
43	product	colortranslation
44	product	feature
45	product	featuretranslation
46	product	product
47	product	productimage
48	product	review
49	product	variation
50	product	volumetype
51	product	volumetypetranslation
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 51, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-09-11 00:22:24.131178+05
2	contenttypes	0002_remove_content_type_name	2018-09-11 00:22:24.496749+05
3	auth	0001_initial	2018-09-11 00:22:25.195755+05
4	auth	0002_alter_permission_name_max_length	2018-09-11 00:22:25.237703+05
5	auth	0003_alter_user_email_max_length	2018-09-11 00:22:25.266868+05
6	auth	0004_alter_user_username_opts	2018-09-11 00:22:25.300072+05
7	auth	0005_alter_user_last_login_null	2018-09-11 00:22:25.334657+05
8	auth	0006_require_contenttypes_0002	2018-09-11 00:22:25.349396+05
9	auth	0007_alter_validators_add_error_messages	2018-09-11 00:22:25.376391+05
10	auth	0008_alter_user_username_max_length	2018-09-11 00:22:25.412311+05
11	account	0001_initial	2018-09-11 00:22:26.648663+05
12	admin	0001_initial	2018-09-11 00:22:26.891149+05
13	admin	0002_logentry_remove_auto_add	2018-09-11 00:22:26.957698+05
14	basic	0001_initial	2018-09-11 00:22:29.199628+05
15	easy_thumbnails	0001_initial	2018-09-11 00:22:29.784406+05
16	easy_thumbnails	0002_thumbnaildimensions	2018-09-11 00:22:29.928643+05
17	filer	0001_initial	2018-09-11 00:22:31.481568+05
18	filer	0002_auto_20150606_2003	2018-09-11 00:22:31.603307+05
19	filer	0003_thumbnailoption	2018-09-11 00:22:31.702787+05
20	filer	0004_auto_20160328_1434	2018-09-11 00:22:31.757715+05
21	filer	0005_auto_20160623_1425	2018-09-11 00:22:31.968834+05
22	filer	0006_auto_20160623_1627	2018-09-11 00:22:32.046385+05
23	filer	0007_auto_20161016_1055	2018-09-11 00:22:32.09299+05
24	filer	0008_auto_20171117_1313	2018-09-11 00:22:32.15309+05
25	filer	0009_auto_20171220_1635	2018-09-11 00:22:32.424206+05
26	filer	0010_auto_20180414_2058	2018-09-11 00:22:32.511375+05
27	product	0001_initial	2018-09-11 00:22:35.650093+05
28	order	0001_initial	2018-09-11 00:22:36.87907+05
29	payment	0001_initial	2018-09-11 00:22:37.177414+05
30	sessions	0001_initial	2018-09-11 00:22:37.387861+05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 30, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
gr0o3ea36v4yukpr5hq9x7thqo8578ac	YTFkNThmN2UxMDY5NTNmMmE2NTdjMjJlNWZkMmM2NDk0YzAzY2NjMDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmQ4MGIzNDU1ZDhiN2ZhZDliZmRiMTJmOTllZmVlNTc2ODVkMjVlIiwiZmlsZXJfbGFzdF9mb2xkZXJfaWQiOm51bGx9	2018-09-25 00:41:35.583064+05
\.


--
-- Data for Name: easy_thumbnails_source; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.easy_thumbnails_source (id, storage_hash, name, modified) FROM stdin;
3	f9bde26a1556cd667f742bd34ec7c55e	filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg	2018-09-11 00:41:34.577799+05
1	f9bde26a1556cd667f742bd34ec7c55e	filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg	2018-09-11 00:41:34.585037+05
2	f9bde26a1556cd667f742bd34ec7c55e	filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg	2018-09-11 00:41:34.607623+05
4	f9bde26a1556cd667f742bd34ec7c55e	filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg	2018-09-11 00:41:35.026477+05
\.


--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.easy_thumbnails_source_id_seq', 4, true);


--
-- Data for Name: easy_thumbnails_thumbnail; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.easy_thumbnails_thumbnail (id, storage_hash, name, modified, source_id) FROM stdin;
1	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg__16x16_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.592274+05	3
2	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg__16x16_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.603775+05	1
3	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg__16x16_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.638224+05	2
4	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg__32x32_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.64885+05	3
5	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg__32x32_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.664018+05	1
6	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg__48x48_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.699575+05	3
7	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg__32x32_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.706909+05	2
8	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg__48x48_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.71674+05	1
9	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg__64x64_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.75685+05	3
10	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg__48x48_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.776191+05	2
11	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg__64x64_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.778228+05	1
12	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg__180x180_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.836784+05	3
13	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg__64x64_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.851034+05	2
14	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg__180x180_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.86908+05	1
15	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg__180x180_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:34.956947+05	2
16	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg__16x16_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:35.046645+05	4
17	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg__32x32_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:35.103324+05	4
18	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg__48x48_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:35.16037+05	4
19	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg__64x64_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:35.213256+05	4
20	f9bde26a1556cd667f742bd34ec7c55e	filer_public_thumbnails/filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg__180x180_q85_crop_subsampling-2_upscale.jpg	2018-09-11 00:41:35.280204+05	4
\.


--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.easy_thumbnails_thumbnail_id_seq', 20, true);


--
-- Data for Name: easy_thumbnails_thumbnaildimensions; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.easy_thumbnails_thumbnaildimensions (id, thumbnail_id, width, height) FROM stdin;
\.


--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.easy_thumbnails_thumbnaildimensions_id_seq', 1, false);


--
-- Data for Name: filer_clipboard; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_clipboard (id, user_id) FROM stdin;
1	1
\.


--
-- Name: filer_clipboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_clipboard_id_seq', 1, true);


--
-- Data for Name: filer_clipboarditem; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_clipboarditem (id, clipboard_id, file_id) FROM stdin;
\.


--
-- Name: filer_clipboarditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_clipboarditem_id_seq', 1, false);


--
-- Data for Name: filer_file; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_file (id, file, _file_size, sha1, has_all_mandatory_data, original_filename, name, description, uploaded_at, modified_at, is_public, folder_id, owner_id, polymorphic_ctype_id) FROM stdin;
1	filer_public/4f/dc/4fdce0a1-2554-4278-a857-1faaf2b0c776/64004_564888026906750_1756100687_n.jpg	37185	f661b04622d35f6ffb5425f8b4f868c0112f6112	f	64004_564888026906750_1756100687_n.jpg		\N	2018-09-11 00:41:34.504861+05	2018-09-11 00:41:34.504925+05	t	\N	1	14
2	filer_public/ec/80/ec80db7a-5021-441c-b5f1-f04c151d6e13/562582_366523656743189_2076864488_n.jpg	72548	e56834fc61543096da6aeae1ea23691fc038060c	f	562582_366523656743189_2076864488_n.jpg		\N	2018-09-11 00:41:34.510789+05	2018-09-11 00:41:34.510867+05	t	\N	1	14
3	filer_public/7a/de/7ade2907-584f-4939-8994-e09c19ab772d/522930_322585751136980_1114591616_n.jpg	35195	065e42daf6ab5a9238a2a5a4929251988a167386	f	522930_322585751136980_1114591616_n.jpg		\N	2018-09-11 00:41:34.51888+05	2018-09-11 00:41:34.518942+05	t	\N	1	14
4	filer_public/19/aa/19aa4d8e-6dba-4fcd-94bd-c64b84b6b1ad/600589_564887363573483_974802216_n.jpg	42440	9eb4ab3682c3ce268494c13cb7081c099c1ac32f	f	600589_564887363573483_974802216_n.jpg		\N	2018-09-11 00:41:34.970584+05	2018-09-11 00:41:34.970658+05	t	\N	1	14
\.


--
-- Name: filer_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_file_id_seq', 4, true);


--
-- Data for Name: filer_folder; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_folder (id, name, uploaded_at, created_at, modified_at, lft, rght, tree_id, level, owner_id, parent_id) FROM stdin;
\.


--
-- Name: filer_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_folder_id_seq', 1, false);


--
-- Data for Name: filer_folderpermission; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_folderpermission (id, type, everybody, can_edit, can_read, can_add_children, folder_id, group_id, user_id) FROM stdin;
\.


--
-- Name: filer_folderpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_folderpermission_id_seq', 1, false);


--
-- Data for Name: filer_image; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_image (file_ptr_id, _height, _width, date_taken, default_alt_text, default_caption, author, must_always_publish_author_credit, must_always_publish_copyright, subject_location) FROM stdin;
1	402	604	2018-09-11 00:41:34.425372+05	\N	\N	\N	f	f	
2	442	604	2018-09-11 00:41:34.480796+05	\N	\N	\N	f	f	
3	315	473	2018-09-11 00:41:34.477075+05	\N	\N	\N	f	f	
4	604	485	2018-09-11 00:41:34.939603+05	\N	\N	\N	f	f	
\.


--
-- Data for Name: filer_thumbnailoption; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.filer_thumbnailoption (id, name, width, height, crop, upscale) FROM stdin;
\.


--
-- Name: filer_thumbnailoption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.filer_thumbnailoption_id_seq', 1, false);


--
-- Data for Name: order_cart; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.order_cart (id, session_key, count, status, total_price, order_id, variation_id) FROM stdin;
\.


--
-- Name: order_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.order_cart_id_seq', 1, false);


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.order_order (id, client_name, phone, shipping_address, created, order_unique_id, products, total_weight, delivery_price, porter_work_price, products_price, total_price, shipping_time, need_porter, state, customer_id, payment_id) FROM stdin;
\.


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.order_order_id_seq', 1, false);


--
-- Data for Name: order_paymentmethod; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.order_paymentmethod (id, title, method, logo_id) FROM stdin;
\.


--
-- Name: order_paymentmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.order_paymentmethod_id_seq', 1, false);


--
-- Data for Name: order_paymentmethod_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.order_paymentmethod_translation (id, language_code, description, master_id) FROM stdin;
\.


--
-- Name: order_paymentmethod_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.order_paymentmethod_translation_id_seq', 1, false);


--
-- Data for Name: payment_paycomtransaction; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.payment_paycomtransaction (id, paycom_transaction_id, paycom_time, paycom_time_datetime, create_time, perform_time, cancel_time, amount, state, reason, receivers, order_id) FROM stdin;
\.


--
-- Name: payment_paycomtransaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.payment_paycomtransaction_id_seq', 1, false);


--
-- Data for Name: product_brands; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_brands (id, name, logo, category_id) FROM stdin;
1	АйФон	brands/11760201_1659941137571769_263151806332074444_n.jpg	1
\.


--
-- Name: product_brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_brands_id_seq', 1, true);


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_category (id, "order", lft, rght, tree_id, mptt_level, parent_id) FROM stdin;
1	0	1	2	1	0	\N
\.


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_category_id_seq', 1, true);


--
-- Data for Name: product_category_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_category_translation (id, language_code, name, slug, master_id) FROM stdin;
1	ru	Телефон	telefon	1
\.


--
-- Name: product_category_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_category_translation_id_seq', 1, true);


--
-- Data for Name: product_color; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_color (id, color) FROM stdin;
1	#FF0000
\.


--
-- Name: product_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_color_id_seq', 1, true);


--
-- Data for Name: product_color_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_color_translation (id, language_code, name, master_id) FROM stdin;
1	ru	Красная	1
\.


--
-- Name: product_color_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_color_translation_id_seq', 1, true);


--
-- Data for Name: product_feature; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_feature (id) FROM stdin;
\.


--
-- Name: product_feature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_feature_id_seq', 1, false);


--
-- Data for Name: product_feature_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_feature_translation (id, language_code, name, slug, master_id) FROM stdin;
\.


--
-- Name: product_feature_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_feature_translation_id_seq', 1, false);


--
-- Data for Name: product_product; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_product (updated, id, name, description, characters, available_in_stock, is_recommended, price, is_top, default_image, brand_id, category_id, feature_id, image_0_id, image_1_id, image_2_id, owner_id, volume_id) FROM stdin;
2018-09-11	9	12asasa			t	t	\N	t	image_0	1	1	\N	3	\N	\N	1	1
2018-09-11	10	12asasa2	<p>Предназначена для наржной окраски зданий и сооружений, по кирпичным и бетонным, деревянным и другим пористым покрытиям по загрунтованной поверхности металла</p>	<p>Test info</p>	t	f	\N	t	image_0	1	1	\N	2	\N	\N	1	1
2018-09-11	11	12asasa3			t	t	\N	f	image_0	1	1	\N	4	\N	\N	1	1
2018-09-11	12	12asasa4			t	f	\N	f	image_0	1	1	\N	1	\N	\N	1	1
2018-09-11	13	12asasa5	<p>Предназначена для отделочных работ внутри помещения (стен и потолков) и для нанесения по дереву, картону и другим пористым поверхностям.</p>		t	f	\N	f	image_0	1	1	\N	3	\N	\N	1	1
2018-09-11	14	12asasa6			t	f	\N	f	image_0	1	1	\N	2	\N	\N	1	1
2018-09-11	15	12asasa7			t	f	\N	f	image_0	1	1	\N	4	\N	\N	1	1
2018-09-11	16	12asasa8			t	f	\N	f	image_0	1	1	\N	1	\N	\N	1	1
\.


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_product_id_seq', 16, true);


--
-- Data for Name: product_productimage; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_productimage (id, image, product_id) FROM stdin;
\.


--
-- Name: product_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_productimage_id_seq', 1, false);


--
-- Data for Name: product_review; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_review (created_at, id, reviewer, reviewer_location, subject, text, is_approved, product_id) FROM stdin;
\.


--
-- Name: product_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_review_id_seq', 1, false);


--
-- Data for Name: product_variation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_variation (id, name, price, quantity, color_id, product_id) FROM stdin;
4	LL	2500.00	2	1	9
5	LS	3400.00	3	1	10
6	XX	4300.00	1	1	11
7	XL	5200.00	3	1	12
8	VII	6100.00	4	1	13
9	LS	7000.00	2	1	14
10	XX	7900.00	4	1	15
11	XL	8800.00	5	1	16
\.


--
-- Name: product_variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_variation_id_seq', 11, true);


--
-- Data for Name: product_volumetype; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_volumetype (id) FROM stdin;
1
\.


--
-- Name: product_volumetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_volumetype_id_seq', 1, true);


--
-- Data for Name: product_volumetype_translation; Type: TABLE DATA; Schema: public; Owner: allshop
--

COPY public.product_volumetype_translation (id, language_code, name, master_id) FROM stdin;
1	ru	Кг	1
\.


--
-- Name: product_volumetype_translation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: allshop
--

SELECT pg_catalog.setval('public.product_volumetype_translation_id_seq', 1, true);


--
-- Name: account_client account_client_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_client
    ADD CONSTRAINT account_client_pkey PRIMARY KEY (id);


--
-- Name: account_client account_client_user_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_client
    ADD CONSTRAINT account_client_user_id_key UNIQUE (user_id);


--
-- Name: account_deliveryaddress account_deliveryaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_deliveryaddress
    ADD CONSTRAINT account_deliveryaddress_pkey PRIMARY KEY (id);


--
-- Name: account_files account_files_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_files
    ADD CONSTRAINT account_files_pkey PRIMARY KEY (id);


--
-- Name: account_merchant account_merchant_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_merchant
    ADD CONSTRAINT account_merchant_pkey PRIMARY KEY (id);


--
-- Name: account_merchant account_merchant_user_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_merchant
    ADD CONSTRAINT account_merchant_user_id_key UNIQUE (user_id);


--
-- Name: account_paymentcards account_paymentcards_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_paymentcards
    ADD CONSTRAINT account_paymentcards_pkey PRIMARY KEY (id);


--
-- Name: account_user account_user_avatar_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_avatar_id_key UNIQUE (avatar_id);


--
-- Name: account_user_groups account_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_pkey PRIMARY KEY (id);


--
-- Name: account_user_groups account_user_groups_user_id_group_id_4d09af3e_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_group_id_4d09af3e_uniq UNIQUE (user_id, group_id);


--
-- Name: account_user account_user_phone_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_phone_key UNIQUE (phone);


--
-- Name: account_user account_user_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_pkey PRIMARY KEY (id);


--
-- Name: account_user_user_permissions account_user_user_permis_user_id_permission_id_48bdd28b_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permis_user_id_permission_id_48bdd28b_uniq UNIQUE (user_id, permission_id);


--
-- Name: account_user_user_permissions account_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: basic_banner basic_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner
    ADD CONSTRAINT basic_banner_pkey PRIMARY KEY (id);


--
-- Name: basic_banner_translation basic_banner_translation_language_code_master_id_ebed20c6_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner_translation
    ADD CONSTRAINT basic_banner_translation_language_code_master_id_ebed20c6_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_banner_translation basic_banner_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner_translation
    ADD CONSTRAINT basic_banner_translation_pkey PRIMARY KEY (id);


--
-- Name: basic_customermenu basic_customermenu_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu
    ADD CONSTRAINT basic_customermenu_pkey PRIMARY KEY (id);


--
-- Name: basic_customermenu_translation basic_customermenu_trans_language_code_master_id_9d2c8b2d_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu_translation
    ADD CONSTRAINT basic_customermenu_trans_language_code_master_id_9d2c8b2d_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_customermenu_translation basic_customermenu_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu_translation
    ADD CONSTRAINT basic_customermenu_translation_pkey PRIMARY KEY (id);


--
-- Name: basic_menu basic_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu
    ADD CONSTRAINT basic_menu_pkey PRIMARY KEY (id);


--
-- Name: basic_menu_translation basic_menu_translation_language_code_master_id_c1c28a2f_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu_translation
    ADD CONSTRAINT basic_menu_translation_language_code_master_id_c1c28a2f_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_menu_translation basic_menu_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu_translation
    ADD CONSTRAINT basic_menu_translation_pkey PRIMARY KEY (id);


--
-- Name: basic_static basic_static_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static
    ADD CONSTRAINT basic_static_pkey PRIMARY KEY (id);


--
-- Name: basic_static_translation basic_static_translation_language_code_master_id_e1ae062c_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static_translation
    ADD CONSTRAINT basic_static_translation_language_code_master_id_e1ae062c_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_static_translation basic_static_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static_translation
    ADD CONSTRAINT basic_static_translation_pkey PRIMARY KEY (id);


--
-- Name: basic_staticfooterpage basic_staticfooterpage_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage
    ADD CONSTRAINT basic_staticfooterpage_pkey PRIMARY KEY (id);


--
-- Name: basic_staticfooterpage_translation basic_staticfooterpage_t_language_code_master_id_02a3de5c_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage_translation
    ADD CONSTRAINT basic_staticfooterpage_t_language_code_master_id_02a3de5c_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_staticfooterpage_translation basic_staticfooterpage_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage_translation
    ADD CONSTRAINT basic_staticfooterpage_translation_pkey PRIMARY KEY (id);


--
-- Name: basic_usermenu basic_usermenu_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu
    ADD CONSTRAINT basic_usermenu_pkey PRIMARY KEY (id);


--
-- Name: basic_usermenu_translation basic_usermenu_translati_language_code_master_id_f8996302_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu_translation
    ADD CONSTRAINT basic_usermenu_translati_language_code_master_id_f8996302_uniq UNIQUE (language_code, master_id);


--
-- Name: basic_usermenu_translation basic_usermenu_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu_translation
    ADD CONSTRAINT basic_usermenu_translation_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source easy_thumbnails_source_storage_hash_name_481ce32d_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_name_481ce32d_uniq UNIQUE (storage_hash, name);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnai_storage_hash_name_source_fb375270_uniq UNIQUE (storage_hash, name, source_id);


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thumbnaildimensions_thumbnail_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);


--
-- Name: filer_clipboard filer_clipboard_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboard
    ADD CONSTRAINT filer_clipboard_pkey PRIMARY KEY (id);


--
-- Name: filer_clipboarditem filer_clipboarditem_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboarditem
    ADD CONSTRAINT filer_clipboarditem_pkey PRIMARY KEY (id);


--
-- Name: filer_file filer_file_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_file
    ADD CONSTRAINT filer_file_pkey PRIMARY KEY (id);


--
-- Name: filer_folder filer_folder_parent_id_name_bc773258_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folder
    ADD CONSTRAINT filer_folder_parent_id_name_bc773258_uniq UNIQUE (parent_id, name);


--
-- Name: filer_folder filer_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folder
    ADD CONSTRAINT filer_folder_pkey PRIMARY KEY (id);


--
-- Name: filer_folderpermission filer_folderpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_pkey PRIMARY KEY (id);


--
-- Name: filer_image filer_image_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_image
    ADD CONSTRAINT filer_image_pkey PRIMARY KEY (file_ptr_id);


--
-- Name: filer_thumbnailoption filer_thumbnailoption_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_thumbnailoption
    ADD CONSTRAINT filer_thumbnailoption_pkey PRIMARY KEY (id);


--
-- Name: order_cart order_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_pkey PRIMARY KEY (id);


--
-- Name: order_order order_order_order_unique_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_order_unique_id_key UNIQUE (order_unique_id);


--
-- Name: order_order order_order_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_pkey PRIMARY KEY (id);


--
-- Name: order_paymentmethod order_paymentmethod_method_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod
    ADD CONSTRAINT order_paymentmethod_method_key UNIQUE (method);


--
-- Name: order_paymentmethod order_paymentmethod_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod
    ADD CONSTRAINT order_paymentmethod_pkey PRIMARY KEY (id);


--
-- Name: order_paymentmethod_translation order_paymentmethod_tran_language_code_master_id_47d4f0f0_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod_translation
    ADD CONSTRAINT order_paymentmethod_tran_language_code_master_id_47d4f0f0_uniq UNIQUE (language_code, master_id);


--
-- Name: order_paymentmethod_translation order_paymentmethod_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod_translation
    ADD CONSTRAINT order_paymentmethod_translation_pkey PRIMARY KEY (id);


--
-- Name: payment_paycomtransaction payment_paycomtransaction_paycom_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.payment_paycomtransaction
    ADD CONSTRAINT payment_paycomtransaction_paycom_transaction_id_key UNIQUE (paycom_transaction_id);


--
-- Name: payment_paycomtransaction payment_paycomtransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.payment_paycomtransaction
    ADD CONSTRAINT payment_paycomtransaction_pkey PRIMARY KEY (id);


--
-- Name: product_brands product_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_brands
    ADD CONSTRAINT product_brands_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_category_translation product_category_transla_language_code_master_id_1bce2cc3_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category_translation
    ADD CONSTRAINT product_category_transla_language_code_master_id_1bce2cc3_uniq UNIQUE (language_code, master_id);


--
-- Name: product_category_translation product_category_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category_translation
    ADD CONSTRAINT product_category_translation_pkey PRIMARY KEY (id);


--
-- Name: product_category_translation product_category_translation_slug_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category_translation
    ADD CONSTRAINT product_category_translation_slug_key UNIQUE (slug);


--
-- Name: product_color product_color_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color
    ADD CONSTRAINT product_color_pkey PRIMARY KEY (id);


--
-- Name: product_color_translation product_color_translation_language_code_master_id_07a38616_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color_translation
    ADD CONSTRAINT product_color_translation_language_code_master_id_07a38616_uniq UNIQUE (language_code, master_id);


--
-- Name: product_color_translation product_color_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color_translation
    ADD CONSTRAINT product_color_translation_pkey PRIMARY KEY (id);


--
-- Name: product_feature product_feature_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature
    ADD CONSTRAINT product_feature_pkey PRIMARY KEY (id);


--
-- Name: product_feature_translation product_feature_translat_language_code_master_id_b23bc99f_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation
    ADD CONSTRAINT product_feature_translat_language_code_master_id_b23bc99f_uniq UNIQUE (language_code, master_id);


--
-- Name: product_feature_translation product_feature_translation_name_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation
    ADD CONSTRAINT product_feature_translation_name_key UNIQUE (name);


--
-- Name: product_feature_translation product_feature_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation
    ADD CONSTRAINT product_feature_translation_pkey PRIMARY KEY (id);


--
-- Name: product_feature_translation product_feature_translation_slug_key; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation
    ADD CONSTRAINT product_feature_translation_slug_key UNIQUE (slug);


--
-- Name: product_product product_product_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_pkey PRIMARY KEY (id);


--
-- Name: product_productimage product_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_productimage
    ADD CONSTRAINT product_productimage_pkey PRIMARY KEY (id);


--
-- Name: product_review product_review_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_pkey PRIMARY KEY (id);


--
-- Name: product_variation product_variation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_pkey PRIMARY KEY (id);


--
-- Name: product_volumetype product_volumetype_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype
    ADD CONSTRAINT product_volumetype_pkey PRIMARY KEY (id);


--
-- Name: product_volumetype_translation product_volumetype_trans_language_code_master_id_569d8d35_uniq; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype_translation
    ADD CONSTRAINT product_volumetype_trans_language_code_master_id_569d8d35_uniq UNIQUE (language_code, master_id);


--
-- Name: product_volumetype_translation product_volumetype_translation_pkey; Type: CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype_translation
    ADD CONSTRAINT product_volumetype_translation_pkey PRIMARY KEY (id);


--
-- Name: account_client_delivery_address_id_4a3a3378; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_client_delivery_address_id_4a3a3378 ON public.account_client USING btree (delivery_address_id);


--
-- Name: account_deliveryaddress_user_id_56c12f86; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_deliveryaddress_user_id_56c12f86 ON public.account_deliveryaddress USING btree (user_id);


--
-- Name: account_paymentcards_holder_id_a97da170; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_paymentcards_holder_id_a97da170 ON public.account_paymentcards USING btree (holder_id);


--
-- Name: account_user_groups_group_id_6c71f749; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_user_groups_group_id_6c71f749 ON public.account_user_groups USING btree (group_id);


--
-- Name: account_user_groups_user_id_14345e7b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_user_groups_user_id_14345e7b ON public.account_user_groups USING btree (user_id);


--
-- Name: account_user_phone_1704cc19_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_user_phone_1704cc19_like ON public.account_user USING btree (phone varchar_pattern_ops);


--
-- Name: account_user_user_permissions_permission_id_66c44191; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_user_user_permissions_permission_id_66c44191 ON public.account_user_user_permissions USING btree (permission_id);


--
-- Name: account_user_user_permissions_user_id_cc42d270; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX account_user_user_permissions_user_id_cc42d270 ON public.account_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: basic_banner_translation_language_code_27b6a2c2; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_banner_translation_language_code_27b6a2c2 ON public.basic_banner_translation USING btree (language_code);


--
-- Name: basic_banner_translation_language_code_27b6a2c2_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_banner_translation_language_code_27b6a2c2_like ON public.basic_banner_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_banner_translation_master_id_08d0868d; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_banner_translation_master_id_08d0868d ON public.basic_banner_translation USING btree (master_id);


--
-- Name: basic_banner_translation_slug_64098c09; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_banner_translation_slug_64098c09 ON public.basic_banner_translation USING btree (slug);


--
-- Name: basic_banner_translation_slug_64098c09_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_banner_translation_slug_64098c09_like ON public.basic_banner_translation USING btree (slug varchar_pattern_ops);


--
-- Name: basic_customermenu_translation_language_code_0f34d834; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_customermenu_translation_language_code_0f34d834 ON public.basic_customermenu_translation USING btree (language_code);


--
-- Name: basic_customermenu_translation_language_code_0f34d834_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_customermenu_translation_language_code_0f34d834_like ON public.basic_customermenu_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_customermenu_translation_master_id_11f3f9a8; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_customermenu_translation_master_id_11f3f9a8 ON public.basic_customermenu_translation USING btree (master_id);


--
-- Name: basic_customermenu_translation_slug_03967593; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_customermenu_translation_slug_03967593 ON public.basic_customermenu_translation USING btree (slug);


--
-- Name: basic_customermenu_translation_slug_03967593_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_customermenu_translation_slug_03967593_like ON public.basic_customermenu_translation USING btree (slug varchar_pattern_ops);


--
-- Name: basic_menu_translation_language_code_6b460a10; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_menu_translation_language_code_6b460a10 ON public.basic_menu_translation USING btree (language_code);


--
-- Name: basic_menu_translation_language_code_6b460a10_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_menu_translation_language_code_6b460a10_like ON public.basic_menu_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_menu_translation_master_id_26be8ecc; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_menu_translation_master_id_26be8ecc ON public.basic_menu_translation USING btree (master_id);


--
-- Name: basic_menu_translation_slug_da5edf45; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_menu_translation_slug_da5edf45 ON public.basic_menu_translation USING btree (slug);


--
-- Name: basic_menu_translation_slug_da5edf45_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_menu_translation_slug_da5edf45_like ON public.basic_menu_translation USING btree (slug varchar_pattern_ops);


--
-- Name: basic_static_translation_language_code_5ea177ab; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_static_translation_language_code_5ea177ab ON public.basic_static_translation USING btree (language_code);


--
-- Name: basic_static_translation_language_code_5ea177ab_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_static_translation_language_code_5ea177ab_like ON public.basic_static_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_static_translation_master_id_beb20683; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_static_translation_master_id_beb20683 ON public.basic_static_translation USING btree (master_id);


--
-- Name: basic_static_translation_slug_389e371e; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_static_translation_slug_389e371e ON public.basic_static_translation USING btree (slug);


--
-- Name: basic_static_translation_slug_389e371e_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_static_translation_slug_389e371e_like ON public.basic_static_translation USING btree (slug varchar_pattern_ops);


--
-- Name: basic_staticfooterpage_translation_language_code_64987bea; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_staticfooterpage_translation_language_code_64987bea ON public.basic_staticfooterpage_translation USING btree (language_code);


--
-- Name: basic_staticfooterpage_translation_language_code_64987bea_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_staticfooterpage_translation_language_code_64987bea_like ON public.basic_staticfooterpage_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_staticfooterpage_translation_master_id_1bd6966c; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_staticfooterpage_translation_master_id_1bd6966c ON public.basic_staticfooterpage_translation USING btree (master_id);


--
-- Name: basic_staticfooterpage_translation_slug_2b17551e; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_staticfooterpage_translation_slug_2b17551e ON public.basic_staticfooterpage_translation USING btree (slug);


--
-- Name: basic_staticfooterpage_translation_slug_2b17551e_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_staticfooterpage_translation_slug_2b17551e_like ON public.basic_staticfooterpage_translation USING btree (slug varchar_pattern_ops);


--
-- Name: basic_usermenu_translation_language_code_6e742096; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_usermenu_translation_language_code_6e742096 ON public.basic_usermenu_translation USING btree (language_code);


--
-- Name: basic_usermenu_translation_language_code_6e742096_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_usermenu_translation_language_code_6e742096_like ON public.basic_usermenu_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: basic_usermenu_translation_master_id_0c2f880b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_usermenu_translation_master_id_0c2f880b ON public.basic_usermenu_translation USING btree (master_id);


--
-- Name: basic_usermenu_translation_slug_82dc0c6b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_usermenu_translation_slug_82dc0c6b ON public.basic_usermenu_translation USING btree (slug);


--
-- Name: basic_usermenu_translation_slug_82dc0c6b_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX basic_usermenu_translation_slug_82dc0c6b_like ON public.basic_usermenu_translation USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_name_5fe0edc6; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6 ON public.easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_name_5fe0edc6_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6_like ON public.easy_thumbnails_source USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9 ON public.easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9_like ON public.easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31 ON public.easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31_like ON public.easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_source_id_5b57bc77; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_thumbnail_source_id_5b57bc77 ON public.easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49 ON public.easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49_like ON public.easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);


--
-- Name: filer_clipboard_user_id_b52ff0bc; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_clipboard_user_id_b52ff0bc ON public.filer_clipboard USING btree (user_id);


--
-- Name: filer_clipboarditem_clipboard_id_7a76518b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_clipboarditem_clipboard_id_7a76518b ON public.filer_clipboarditem USING btree (clipboard_id);


--
-- Name: filer_clipboarditem_file_id_06196f80; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_clipboarditem_file_id_06196f80 ON public.filer_clipboarditem USING btree (file_id);


--
-- Name: filer_file_folder_id_af803bbb; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_file_folder_id_af803bbb ON public.filer_file USING btree (folder_id);


--
-- Name: filer_file_owner_id_b9e32671; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_file_owner_id_b9e32671 ON public.filer_file USING btree (owner_id);


--
-- Name: filer_file_polymorphic_ctype_id_f44903c1; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_file_polymorphic_ctype_id_f44903c1 ON public.filer_file USING btree (polymorphic_ctype_id);


--
-- Name: filer_folder_level_b631d28a; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_level_b631d28a ON public.filer_folder USING btree (level);


--
-- Name: filer_folder_lft_2c2b69f1; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_lft_2c2b69f1 ON public.filer_folder USING btree (lft);


--
-- Name: filer_folder_owner_id_be530fb4; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_owner_id_be530fb4 ON public.filer_folder USING btree (owner_id);


--
-- Name: filer_folder_parent_id_308aecda; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_parent_id_308aecda ON public.filer_folder USING btree (parent_id);


--
-- Name: filer_folder_rght_34946267; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_rght_34946267 ON public.filer_folder USING btree (rght);


--
-- Name: filer_folder_tree_id_b016223c; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folder_tree_id_b016223c ON public.filer_folder USING btree (tree_id);


--
-- Name: filer_folderpermission_folder_id_5d02f1da; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folderpermission_folder_id_5d02f1da ON public.filer_folderpermission USING btree (folder_id);


--
-- Name: filer_folderpermission_group_id_8901bafa; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folderpermission_group_id_8901bafa ON public.filer_folderpermission USING btree (group_id);


--
-- Name: filer_folderpermission_user_id_7673d4b6; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX filer_folderpermission_user_id_7673d4b6 ON public.filer_folderpermission USING btree (user_id);


--
-- Name: order_cart_order_id_93de4ce2; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_cart_order_id_93de4ce2 ON public.order_cart USING btree (order_id);


--
-- Name: order_cart_variation_id_ab07705d; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_cart_variation_id_ab07705d ON public.order_cart USING btree (variation_id);


--
-- Name: order_order_customer_id_5bbbd957; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_order_customer_id_5bbbd957 ON public.order_order USING btree (customer_id);


--
-- Name: order_order_order_unique_id_0cc70ba6_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_order_order_unique_id_0cc70ba6_like ON public.order_order USING btree (order_unique_id varchar_pattern_ops);


--
-- Name: order_order_payment_id_d8fb3a38; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_order_payment_id_d8fb3a38 ON public.order_order USING btree (payment_id);


--
-- Name: order_paymentmethod_logo_id_5361227f; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_paymentmethod_logo_id_5361227f ON public.order_paymentmethod USING btree (logo_id);


--
-- Name: order_paymentmethod_method_b18060c6_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_paymentmethod_method_b18060c6_like ON public.order_paymentmethod USING btree (method varchar_pattern_ops);


--
-- Name: order_paymentmethod_translation_language_code_ba58193f; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_paymentmethod_translation_language_code_ba58193f ON public.order_paymentmethod_translation USING btree (language_code);


--
-- Name: order_paymentmethod_translation_language_code_ba58193f_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_paymentmethod_translation_language_code_ba58193f_like ON public.order_paymentmethod_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: order_paymentmethod_translation_master_id_4e85623e; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX order_paymentmethod_translation_master_id_4e85623e ON public.order_paymentmethod_translation USING btree (master_id);


--
-- Name: payment_paycomtransaction_order_id_8061c1ba; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX payment_paycomtransaction_order_id_8061c1ba ON public.payment_paycomtransaction USING btree (order_id);


--
-- Name: payment_paycomtransaction_paycom_transaction_id_a9016909_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX payment_paycomtransaction_paycom_transaction_id_a9016909_like ON public.payment_paycomtransaction USING btree (paycom_transaction_id varchar_pattern_ops);


--
-- Name: product_brands_category_id_1006c3f1; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_brands_category_id_1006c3f1 ON public.product_brands USING btree (category_id);


--
-- Name: product_category_lft_3708054f; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_lft_3708054f ON public.product_category USING btree (lft);


--
-- Name: product_category_mptt_level_cc645f72; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_mptt_level_cc645f72 ON public.product_category USING btree (mptt_level);


--
-- Name: product_category_parent_id_f6860923; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_parent_id_f6860923 ON public.product_category USING btree (parent_id);


--
-- Name: product_category_rght_fcbf9e79; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_rght_fcbf9e79 ON public.product_category USING btree (rght);


--
-- Name: product_category_translation_language_code_704d2cf7; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_translation_language_code_704d2cf7 ON public.product_category_translation USING btree (language_code);


--
-- Name: product_category_translation_language_code_704d2cf7_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_translation_language_code_704d2cf7_like ON public.product_category_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: product_category_translation_master_id_131bf4b0; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_translation_master_id_131bf4b0 ON public.product_category_translation USING btree (master_id);


--
-- Name: product_category_translation_slug_a1fbff65_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_translation_slug_a1fbff65_like ON public.product_category_translation USING btree (slug varchar_pattern_ops);


--
-- Name: product_category_tree_id_f3c46461; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_category_tree_id_f3c46461 ON public.product_category USING btree (tree_id);


--
-- Name: product_color_translation_language_code_d252c5cd; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_color_translation_language_code_d252c5cd ON public.product_color_translation USING btree (language_code);


--
-- Name: product_color_translation_language_code_d252c5cd_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_color_translation_language_code_d252c5cd_like ON public.product_color_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: product_color_translation_master_id_3d80fbb5; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_color_translation_master_id_3d80fbb5 ON public.product_color_translation USING btree (master_id);


--
-- Name: product_feature_translation_language_code_b0332d18; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_feature_translation_language_code_b0332d18 ON public.product_feature_translation USING btree (language_code);


--
-- Name: product_feature_translation_language_code_b0332d18_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_feature_translation_language_code_b0332d18_like ON public.product_feature_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: product_feature_translation_master_id_9cd4b0f5; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_feature_translation_master_id_9cd4b0f5 ON public.product_feature_translation USING btree (master_id);


--
-- Name: product_feature_translation_name_dc674799_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_feature_translation_name_dc674799_like ON public.product_feature_translation USING btree (name varchar_pattern_ops);


--
-- Name: product_feature_translation_slug_ec7dd9d3_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_feature_translation_slug_ec7dd9d3_like ON public.product_feature_translation USING btree (slug varchar_pattern_ops);


--
-- Name: product_product_brand_id_fcf1b3f3; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_brand_id_fcf1b3f3 ON public.product_product USING btree (brand_id);


--
-- Name: product_product_category_id_0c725779; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_category_id_0c725779 ON public.product_product USING btree (category_id);


--
-- Name: product_product_feature_id_a57f6a33; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_feature_id_a57f6a33 ON public.product_product USING btree (feature_id);


--
-- Name: product_product_image_0_id_38584b59; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_image_0_id_38584b59 ON public.product_product USING btree (image_0_id);


--
-- Name: product_product_image_1_id_a03ca83b; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_image_1_id_a03ca83b ON public.product_product USING btree (image_1_id);


--
-- Name: product_product_image_2_id_12e4881a; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_image_2_id_12e4881a ON public.product_product USING btree (image_2_id);


--
-- Name: product_product_owner_id_af246414; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_owner_id_af246414 ON public.product_product USING btree (owner_id);


--
-- Name: product_product_volume_id_8175b3e7; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_product_volume_id_8175b3e7 ON public.product_product USING btree (volume_id);


--
-- Name: product_productimage_product_id_544084bb; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_productimage_product_id_544084bb ON public.product_productimage USING btree (product_id);


--
-- Name: product_review_product_id_428b0c5c; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_review_product_id_428b0c5c ON public.product_review USING btree (product_id);


--
-- Name: product_variation_color_id_bd8668fd; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_variation_color_id_bd8668fd ON public.product_variation USING btree (color_id);


--
-- Name: product_variation_product_id_c2273cd9; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_variation_product_id_c2273cd9 ON public.product_variation USING btree (product_id);


--
-- Name: product_volumetype_translation_language_code_011cfc27; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_volumetype_translation_language_code_011cfc27 ON public.product_volumetype_translation USING btree (language_code);


--
-- Name: product_volumetype_translation_language_code_011cfc27_like; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_volumetype_translation_language_code_011cfc27_like ON public.product_volumetype_translation USING btree (language_code varchar_pattern_ops);


--
-- Name: product_volumetype_translation_master_id_94076b55; Type: INDEX; Schema: public; Owner: allshop
--

CREATE INDEX product_volumetype_translation_master_id_94076b55 ON public.product_volumetype_translation USING btree (master_id);


--
-- Name: account_client account_client_delivery_address_id_4a3a3378_fk_account_d; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_client
    ADD CONSTRAINT account_client_delivery_address_id_4a3a3378_fk_account_d FOREIGN KEY (delivery_address_id) REFERENCES public.account_deliveryaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_client account_client_user_id_b7da2004_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_client
    ADD CONSTRAINT account_client_user_id_b7da2004_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_deliveryaddress account_deliveryaddress_user_id_56c12f86_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_deliveryaddress
    ADD CONSTRAINT account_deliveryaddress_user_id_56c12f86_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_merchant account_merchant_user_id_02539462_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_merchant
    ADD CONSTRAINT account_merchant_user_id_02539462_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_paymentcards account_paymentcards_holder_id_a97da170_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_paymentcards
    ADD CONSTRAINT account_paymentcards_holder_id_a97da170_fk_account_user_id FOREIGN KEY (holder_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user account_user_avatar_id_bfb1a6ef_fk_account_files_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_avatar_id_bfb1a6ef_fk_account_files_id FOREIGN KEY (avatar_id) REFERENCES public.account_files(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups account_user_groups_group_id_6c71f749_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_group_id_6c71f749_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups account_user_groups_user_id_14345e7b_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_14345e7b_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_permission_id_66c44191_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_permission_id_66c44191_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_user_id_cc42d270_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_user_id_cc42d270_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_banner_translation basic_banner_translation_master_id_08d0868d_fk_basic_banner_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_banner_translation
    ADD CONSTRAINT basic_banner_translation_master_id_08d0868d_fk_basic_banner_id FOREIGN KEY (master_id) REFERENCES public.basic_banner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_customermenu_translation basic_customermenu_t_master_id_11f3f9a8_fk_basic_cus; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_customermenu_translation
    ADD CONSTRAINT basic_customermenu_t_master_id_11f3f9a8_fk_basic_cus FOREIGN KEY (master_id) REFERENCES public.basic_customermenu(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_menu_translation basic_menu_translation_master_id_26be8ecc_fk_basic_menu_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_menu_translation
    ADD CONSTRAINT basic_menu_translation_master_id_26be8ecc_fk_basic_menu_id FOREIGN KEY (master_id) REFERENCES public.basic_menu(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_static_translation basic_static_translation_master_id_beb20683_fk_basic_static_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_static_translation
    ADD CONSTRAINT basic_static_translation_master_id_beb20683_fk_basic_static_id FOREIGN KEY (master_id) REFERENCES public.basic_static(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_staticfooterpage_translation basic_staticfooterpa_master_id_1bd6966c_fk_basic_sta; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_staticfooterpage_translation
    ADD CONSTRAINT basic_staticfooterpa_master_id_1bd6966c_fk_basic_sta FOREIGN KEY (master_id) REFERENCES public.basic_staticfooterpage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basic_usermenu_translation basic_usermenu_trans_master_id_0c2f880b_fk_basic_use; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.basic_usermenu_translation
    ADD CONSTRAINT basic_usermenu_trans_master_id_0c2f880b_fk_basic_use FOREIGN KEY (master_id) REFERENCES public.basic_usermenu(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnail easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thum_source_id_5b57bc77_fk_easy_thum FOREIGN KEY (source_id) REFERENCES public.easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_thumbnaildimensions easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thum_thumbnail_id_c3a0c549_fk_easy_thum FOREIGN KEY (thumbnail_id) REFERENCES public.easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipboard filer_clipboard_user_id_b52ff0bc_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboard
    ADD CONSTRAINT filer_clipboard_user_id_b52ff0bc_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipboarditem filer_clipboarditem_clipboard_id_7a76518b_fk_filer_clipboard_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboarditem
    ADD CONSTRAINT filer_clipboarditem_clipboard_id_7a76518b_fk_filer_clipboard_id FOREIGN KEY (clipboard_id) REFERENCES public.filer_clipboard(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_clipboarditem filer_clipboarditem_file_id_06196f80_fk_filer_file_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_clipboarditem
    ADD CONSTRAINT filer_clipboarditem_file_id_06196f80_fk_filer_file_id FOREIGN KEY (file_id) REFERENCES public.filer_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_file filer_file_folder_id_af803bbb_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_file
    ADD CONSTRAINT filer_file_folder_id_af803bbb_fk_filer_folder_id FOREIGN KEY (folder_id) REFERENCES public.filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_file filer_file_owner_id_b9e32671_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_file
    ADD CONSTRAINT filer_file_owner_id_b9e32671_fk_account_user_id FOREIGN KEY (owner_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_file filer_file_polymorphic_ctype_id_f44903c1_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_file
    ADD CONSTRAINT filer_file_polymorphic_ctype_id_f44903c1_fk_django_co FOREIGN KEY (polymorphic_ctype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folder filer_folder_owner_id_be530fb4_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folder
    ADD CONSTRAINT filer_folder_owner_id_be530fb4_fk_account_user_id FOREIGN KEY (owner_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folder filer_folder_parent_id_308aecda_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folder
    ADD CONSTRAINT filer_folder_parent_id_308aecda_fk_filer_folder_id FOREIGN KEY (parent_id) REFERENCES public.filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermission filer_folderpermission_folder_id_5d02f1da_fk_filer_folder_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_folder_id_5d02f1da_fk_filer_folder_id FOREIGN KEY (folder_id) REFERENCES public.filer_folder(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermission filer_folderpermission_group_id_8901bafa_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_group_id_8901bafa_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_folderpermission filer_folderpermission_user_id_7673d4b6_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_folderpermission
    ADD CONSTRAINT filer_folderpermission_user_id_7673d4b6_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: filer_image filer_image_file_ptr_id_3e21d4f0_fk_filer_file_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.filer_image
    ADD CONSTRAINT filer_image_file_ptr_id_3e21d4f0_fk_filer_file_id FOREIGN KEY (file_ptr_id) REFERENCES public.filer_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_cart order_cart_order_id_93de4ce2_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_order_id_93de4ce2_fk_order_order_id FOREIGN KEY (order_id) REFERENCES public.order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_cart order_cart_variation_id_ab07705d_fk_product_variation_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_cart
    ADD CONSTRAINT order_cart_variation_id_ab07705d_fk_product_variation_id FOREIGN KEY (variation_id) REFERENCES public.product_variation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_customer_id_5bbbd957_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_customer_id_5bbbd957_fk_account_user_id FOREIGN KEY (customer_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order order_order_payment_id_d8fb3a38_fk_order_paymentmethod_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_order
    ADD CONSTRAINT order_order_payment_id_d8fb3a38_fk_order_paymentmethod_id FOREIGN KEY (payment_id) REFERENCES public.order_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_paymentmethod_translation order_paymentmethod__master_id_4e85623e_fk_order_pay; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod_translation
    ADD CONSTRAINT order_paymentmethod__master_id_4e85623e_fk_order_pay FOREIGN KEY (master_id) REFERENCES public.order_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_paymentmethod order_paymentmethod_logo_id_5361227f_fk_filer_file_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.order_paymentmethod
    ADD CONSTRAINT order_paymentmethod_logo_id_5361227f_fk_filer_file_id FOREIGN KEY (logo_id) REFERENCES public.filer_file(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payment_paycomtransaction payment_paycomtransaction_order_id_8061c1ba_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.payment_paycomtransaction
    ADD CONSTRAINT payment_paycomtransaction_order_id_8061c1ba_fk_order_order_id FOREIGN KEY (order_id) REFERENCES public.order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_brands product_brands_category_id_1006c3f1_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_brands
    ADD CONSTRAINT product_brands_category_id_1006c3f1_fk_product_category_id FOREIGN KEY (category_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_category product_category_parent_id_f6860923_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_parent_id_f6860923_fk_product_category_id FOREIGN KEY (parent_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_category_translation product_category_tra_master_id_131bf4b0_fk_product_c; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_category_translation
    ADD CONSTRAINT product_category_tra_master_id_131bf4b0_fk_product_c FOREIGN KEY (master_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_color_translation product_color_transl_master_id_3d80fbb5_fk_product_c; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_color_translation
    ADD CONSTRAINT product_color_transl_master_id_3d80fbb5_fk_product_c FOREIGN KEY (master_id) REFERENCES public.product_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_feature_translation product_feature_tran_master_id_9cd4b0f5_fk_product_f; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_feature_translation
    ADD CONSTRAINT product_feature_tran_master_id_9cd4b0f5_fk_product_f FOREIGN KEY (master_id) REFERENCES public.product_feature(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_brand_id_fcf1b3f3_fk_product_brands_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_brand_id_fcf1b3f3_fk_product_brands_id FOREIGN KEY (brand_id) REFERENCES public.product_brands(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_category_id_0c725779_fk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_category_id_0c725779_fk_product_category_id FOREIGN KEY (category_id) REFERENCES public.product_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_feature_id_a57f6a33_fk_product_feature_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_feature_id_a57f6a33_fk_product_feature_id FOREIGN KEY (feature_id) REFERENCES public.product_feature(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_image_0_id_38584b59_fk_filer_image_file_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_image_0_id_38584b59_fk_filer_image_file_ptr_id FOREIGN KEY (image_0_id) REFERENCES public.filer_image(file_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_image_1_id_a03ca83b_fk_filer_image_file_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_image_1_id_a03ca83b_fk_filer_image_file_ptr_id FOREIGN KEY (image_1_id) REFERENCES public.filer_image(file_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_image_2_id_12e4881a_fk_filer_image_file_ptr_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_image_2_id_12e4881a_fk_filer_image_file_ptr_id FOREIGN KEY (image_2_id) REFERENCES public.filer_image(file_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_owner_id_af246414_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_owner_id_af246414_fk_account_user_id FOREIGN KEY (owner_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_product product_product_volume_id_8175b3e7_fk_product_volumetype_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_product
    ADD CONSTRAINT product_product_volume_id_8175b3e7_fk_product_volumetype_id FOREIGN KEY (volume_id) REFERENCES public.product_volumetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_productimage product_productimage_product_id_544084bb_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_productimage
    ADD CONSTRAINT product_productimage_product_id_544084bb_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_review product_review_product_id_428b0c5c_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_product_id_428b0c5c_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_variation product_variation_color_id_bd8668fd_fk_product_color_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_color_id_bd8668fd_fk_product_color_id FOREIGN KEY (color_id) REFERENCES public.product_color(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_variation product_variation_product_id_c2273cd9_fk_product_product_id; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_product_id_c2273cd9_fk_product_product_id FOREIGN KEY (product_id) REFERENCES public.product_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_volumetype_translation product_volumetype_t_master_id_94076b55_fk_product_v; Type: FK CONSTRAINT; Schema: public; Owner: allshop
--

ALTER TABLE ONLY public.product_volumetype_translation
    ADD CONSTRAINT product_volumetype_t_master_id_94076b55_fk_product_v FOREIGN KEY (master_id) REFERENCES public.product_volumetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

