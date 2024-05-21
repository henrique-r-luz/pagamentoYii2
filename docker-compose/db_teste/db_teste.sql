--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6 (Debian 12.6-1.pgdg100+1)
-- Dumped by pg_dump version 12.6 (Debian 12.6-1.pgdg100+1)

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
-- Name: categoria_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categoria_enum AS ENUM (
    'Renda Fixa',
    'Renda Variável'
);


ALTER TYPE public.categoria_enum OWNER TO postgres;

--
-- Name: tipo_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_enum AS ENUM (
    'Tesouro Direto',
    'Fundos de Investimentos',
    'CDB',
    'Debêntures',
    'Ações',
    'Criptomoeda',
    'Dollar',
    'Ouro',
    'Prata',
    'ETFs',
    'FIIs'
);


ALTER TYPE public.tipo_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acao_bolsa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acao_bolsa (
    id integer NOT NULL,
    nome text NOT NULL,
    codigo character varying(5) NOT NULL,
    setor text NOT NULL,
    cnpj text NOT NULL
);


ALTER TABLE public.acao_bolsa OWNER TO postgres;

--
-- Name: acao_bolsa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.acao_bolsa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acao_bolsa_id_seq OWNER TO postgres;

--
-- Name: acao_bolsa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.acao_bolsa_id_seq OWNED BY public.acao_bolsa.id;


--
-- Name: ativo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ativo (
    id integer NOT NULL,
    nome text NOT NULL,
    codigo text NOT NULL,
    acao_bolsa_id integer,
    categoria public.categoria_enum,
    tipo public.tipo_enum,
    pais character varying(2) DEFAULT 'BR'::character varying NOT NULL,
    classe_atualiza_id integer
);


ALTER TABLE public.ativo OWNER TO postgres;

--
-- Name: ativo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ativo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ativo_id_seq OWNER TO postgres;

--
-- Name: ativo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ativo_id_seq OWNED BY public.ativo.id;


--
-- Name: atualiza_acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atualiza_acoes (
    id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    ativo_atualizado jsonb,
    status text NOT NULL
);


ALTER TABLE public.atualiza_acoes OWNER TO postgres;

--
-- Name: atualiza_acoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atualiza_acoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atualiza_acoes_id_seq OWNER TO postgres;

--
-- Name: atualiza_acoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atualiza_acoes_id_seq OWNED BY public.atualiza_acoes.id;


--
-- Name: atualiza_ativo_manual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atualiza_ativo_manual (
    id integer NOT NULL,
    itens_ativo_id integer NOT NULL
);


ALTER TABLE public.atualiza_ativo_manual OWNER TO postgres;

--
-- Name: atualiza_ativo_manual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atualiza_ativo_manual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atualiza_ativo_manual_id_seq OWNER TO postgres;

--
-- Name: atualiza_ativo_manual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atualiza_ativo_manual_id_seq OWNED BY public.atualiza_ativo_manual.id;


--
-- Name: atualiza_nu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atualiza_nu (
    id integer NOT NULL,
    valor_bruto_antigo numeric NOT NULL,
    valor_liquido_antigo numeric NOT NULL,
    operacoes_import_id integer NOT NULL,
    itens_ativo_id integer NOT NULL
);


ALTER TABLE public.atualiza_nu OWNER TO postgres;

--
-- Name: atualiza_nu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atualiza_nu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atualiza_nu_id_seq OWNER TO postgres;

--
-- Name: atualiza_nu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atualiza_nu_id_seq OWNED BY public.atualiza_nu.id;


--
-- Name: atualiza_operacoes_manual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atualiza_operacoes_manual (
    id integer NOT NULL,
    valor_bruto numeric NOT NULL,
    valor_liquido numeric NOT NULL,
    atualiza_ativo_manual_id integer NOT NULL,
    data timestamp without time zone NOT NULL
);


ALTER TABLE public.atualiza_operacoes_manual OWNER TO postgres;

--
-- Name: atualiza_operacoes_manual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atualiza_operacoes_manual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.atualiza_operacoes_manual_id_seq OWNER TO postgres;

--
-- Name: atualiza_operacoes_manual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atualiza_operacoes_manual_id_seq OWNED BY public.atualiza_operacoes_manual.id;


--
-- Name: auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria (
    id integer NOT NULL,
    model text NOT NULL,
    operacao text NOT NULL,
    changes jsonb NOT NULL,
    user_id integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.auditoria OWNER TO postgres;

--
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_id_seq OWNER TO postgres;

--
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_id_seq OWNED BY public.auditoria.id;


--
-- Name: auth_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_assignment (
    item_name character varying(64) NOT NULL,
    user_id integer NOT NULL,
    created_at integer
);


ALTER TABLE public.auth_assignment OWNER TO postgres;

--
-- Name: auth_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_item (
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    description text,
    rule_name character varying(64),
    data bytea,
    created_at integer,
    updated_at integer
);


ALTER TABLE public.auth_item OWNER TO postgres;

--
-- Name: auth_item_child; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_item_child (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


ALTER TABLE public.auth_item_child OWNER TO postgres;

--
-- Name: auth_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_rule (
    name character varying(64) NOT NULL,
    data bytea,
    created_at integer,
    updated_at integer
);


ALTER TABLE public.auth_rule OWNER TO postgres;

--
-- Name: classes_operacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes_operacoes (
    id integer NOT NULL,
    nome character varying(255) NOT NULL
);


ALTER TABLE public.classes_operacoes OWNER TO postgres;

--
-- Name: classes_operacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_operacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classes_operacoes_id_seq OWNER TO postgres;

--
-- Name: classes_operacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_operacoes_id_seq OWNED BY public.classes_operacoes.id;


--
-- Name: investidor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investidor (
    id integer NOT NULL,
    cpf character varying(11) NOT NULL,
    nome text NOT NULL
);


ALTER TABLE public.investidor OWNER TO postgres;

--
-- Name: investidor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.investidor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.investidor_id_seq OWNER TO postgres;

--
-- Name: investidor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.investidor_id_seq OWNED BY public.investidor.id;


--
-- Name: itens_ativo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens_ativo (
    id integer NOT NULL,
    ativo_id integer NOT NULL,
    investidor_id integer NOT NULL,
    quantidade numeric,
    valor_compra numeric,
    valor_liquido numeric,
    valor_bruto numeric,
    ativo boolean
);


ALTER TABLE public.itens_ativo OWNER TO postgres;

--
-- Name: itens_ativo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itens_ativo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itens_ativo_id_seq OWNER TO postgres;

--
-- Name: itens_ativo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itens_ativo_id_seq OWNED BY public.itens_ativo.id;


--
-- Name: migration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration (
    version character varying(180) NOT NULL,
    apply_time integer
);


ALTER TABLE public.migration OWNER TO postgres;

--
-- Name: operacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operacao (
    id integer NOT NULL,
    quantidade numeric NOT NULL,
    valor numeric,
    data timestamp without time zone NOT NULL,
    tipo integer NOT NULL,
    itens_ativos_id integer,
    preco_medio numeric
);


ALTER TABLE public.operacao OWNER TO postgres;

--
-- Name: operacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operacao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operacao_id_seq OWNER TO postgres;

--
-- Name: operacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operacao_id_seq OWNED BY public.operacao.id;


--
-- Name: operacoes_import; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operacoes_import (
    id integer NOT NULL,
    investidor_id integer NOT NULL,
    arquivo text NOT NULL,
    extensao text NOT NULL,
    tipo_arquivo text NOT NULL,
    hash_nome text NOT NULL,
    data timestamp without time zone NOT NULL,
    lista_operacoes_criadas_json text
);


ALTER TABLE public.operacoes_import OWNER TO postgres;

--
-- Name: operacoes_import_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operacoes_import_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operacoes_import_id_seq OWNER TO postgres;

--
-- Name: operacoes_import_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operacoes_import_id_seq OWNED BY public.operacoes_import.id;


--
-- Name: preco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preco (
    id integer NOT NULL,
    valor numeric NOT NULL,
    ativo_id integer,
    data timestamp(0) without time zone NOT NULL,
    atualiza_acoes_id integer
);


ALTER TABLE public.preco OWNER TO postgres;

--
-- Name: preco_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.preco_id_seq OWNER TO postgres;

--
-- Name: preco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preco_id_seq OWNED BY public.preco.id;


--
-- Name: proventos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proventos (
    id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    valor real NOT NULL,
    itens_ativos_id integer,
    movimentacao integer
);


ALTER TABLE public.proventos OWNER TO postgres;

--
-- Name: proventos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proventos_id_seq OWNER TO postgres;

--
-- Name: proventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proventos_id_seq OWNED BY public.proventos.id;


--
-- Name: site_acoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_acoes (
    ativo_id integer NOT NULL,
    url text NOT NULL
);


ALTER TABLE public.site_acoes OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password text NOT NULL,
    authkey text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: xpath_bot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xpath_bot (
    id integer NOT NULL,
    site_acao_id integer NOT NULL,
    data date NOT NULL,
    xpath text NOT NULL
);


ALTER TABLE public.xpath_bot OWNER TO postgres;

--
-- Name: xpath_bot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.xpath_bot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xpath_bot_id_seq OWNER TO postgres;

--
-- Name: xpath_bot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.xpath_bot_id_seq OWNED BY public.xpath_bot.id;


--
-- Name: acao_bolsa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acao_bolsa ALTER COLUMN id SET DEFAULT nextval('public.acao_bolsa_id_seq'::regclass);


--
-- Name: ativo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ativo ALTER COLUMN id SET DEFAULT nextval('public.ativo_id_seq'::regclass);


--
-- Name: atualiza_acoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_acoes ALTER COLUMN id SET DEFAULT nextval('public.atualiza_acoes_id_seq'::regclass);


--
-- Name: atualiza_ativo_manual id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_ativo_manual ALTER COLUMN id SET DEFAULT nextval('public.atualiza_ativo_manual_id_seq'::regclass);


--
-- Name: atualiza_nu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_nu ALTER COLUMN id SET DEFAULT nextval('public.atualiza_nu_id_seq'::regclass);


--
-- Name: atualiza_operacoes_manual id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_operacoes_manual ALTER COLUMN id SET DEFAULT nextval('public.atualiza_operacoes_manual_id_seq'::regclass);


--
-- Name: auditoria id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria ALTER COLUMN id SET DEFAULT nextval('public.auditoria_id_seq'::regclass);


--
-- Name: classes_operacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes_operacoes ALTER COLUMN id SET DEFAULT nextval('public.classes_operacoes_id_seq'::regclass);


--
-- Name: investidor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investidor ALTER COLUMN id SET DEFAULT nextval('public.investidor_id_seq'::regclass);


--
-- Name: itens_ativo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_ativo ALTER COLUMN id SET DEFAULT nextval('public.itens_ativo_id_seq'::regclass);


--
-- Name: operacao id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacao ALTER COLUMN id SET DEFAULT nextval('public.operacao_id_seq'::regclass);


--
-- Name: operacoes_import id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacoes_import ALTER COLUMN id SET DEFAULT nextval('public.operacoes_import_id_seq'::regclass);


--
-- Name: preco id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco ALTER COLUMN id SET DEFAULT nextval('public.preco_id_seq'::regclass);


--
-- Name: proventos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proventos ALTER COLUMN id SET DEFAULT nextval('public.proventos_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: xpath_bot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpath_bot ALTER COLUMN id SET DEFAULT nextval('public.xpath_bot_id_seq'::regclass);


--
-- Data for Name: acao_bolsa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acao_bolsa (id, nome, codigo, setor, cnpj) FROM stdin;
7	Aliansce	ALSC	Shoppings	06.082.980/0001-03
26	BR Pharma	BPHA	Produtos Farmacêuticos	11.395.624/0001-71
29	Brasil Insurance	BRIN	Seguros	11.721.921/0001-60
89	Itautec	ITEC	Tecnologia Bancária	54.526.082/0001-31
12	Azul	AZUL	Aéreo	09.305.994/0001-29
187	Excelsior	BAUH	Carnes e Derivados	95.426.862/0001-97
207	Cedro Têxtil	CEDO	Têxtil	17.245.234/0001-00
40	Ceg	CEGR	Gás	33.938.119/0001-69
211	Celpe	CEPE	Energia	10.835.932/0001-08
118	Multiplus	MPLU	Programas de Fidelidade	11.094.546/0001-75
150	Somos Educação	SEDU	Educação	02.541.982/0001-54
158	Sierra Brasil	SSBR	Shoppings	05.878.397/0001-32
32	Biosev	BSEV	Açúcar e Álcool	15.527.906/0001-36
201	Banco de Brasília	BSLI	Bancos	00.000.208/0001-00
33	B2W Digital	BTOW	Comércio Varejista	00.776.574/0001-56
202	Battistella	BTTL	Holding	42.331.462/0001-31
203	Adolpho Lindenberg	CALI	Construção Civil	61.022.042/0001-18
204	Cambuci	CAMB	Calçados	61.088.894/0001-08
34	Camil	CAML	Alimentos	64.904.295/0001-03
35	CSU Cardsystem	CARD	Software	01.896.779/0001-38
205	Casan	CASN	Saneamento	82.508.433/0001-17
36	Ampla Energia	CBEE	Energia	33.050.071/0001-58
37	Cyrela Commercial	CCPR	Exploração de Imóveis	08.801.621/0001-86
38	CCR	CCRO	Exploração de Rodovias	02.846.056/0001-97
39	CCX Carvão	CCXC	Mineração	07.950.674/0001-04
206	Cia Energética de Brasília	CEBR	Energia	00.070.698/0001-11
208	Coelba	CEEB	Energia	15.139.629/0001-94
209	CEEE	CEED	Energia	08.467.115/0001-00
210	Celpa	CELP	Energia	04.895.728/0001-80
259	Mendes Júnior	MEND	Construção Civil	17.162.082/0001-73
239	Forja Taurus	FJTA	Armas e Equipamentos	92.781.335/0001-02
96	Kroton	KROT	Educação	02.800.026/0001-40
296	Tectoy	TOYB	Brinquedos e Jogos	22.770.366/0001-82
2	Banco ABC	ABCB	Bancos	28.195.667/0001-06
1	Alliar	AALR	Medicina Diagnóstica	42.771.949/0001-35
3	Ambev	ABEV	Bebidas	07.526.557/0001-00
4	Advanced Digital Health	ADHM	Medicina Diagnóstica	10.345.009/0001-98
5	Afluente T	AFLT	Energia	10.338.320/0001-00
6	BrasilAgro	AGRO	Agricultura	07.628.528/0001-59
182	São Paulo Turismo	AHEB	Eventos e Shows	62.002.886/0001-60
183	Alpargatas	ALPA	Calçados	61.079.117/0001-05
184	Alupar	ALUP	Energia	08.364.948/0001-38
8	Lojas Marisa	AMAR	Vestuário	61.189.288/0001-89
9	Anima	ANIM	Educação	09.288.252/0001-32
10	Arezzo	ARZZ	Calçados	16.590.234/0001-76
11	Atom	ATOM	Mesa Proprietária de Traders	00.359.742/0001-08
185	Azevedo Travassos	AZEV	Construção Civil	61.351.532/0001-68
13	B3	B3SA	Bolsa de Valores	09.346.601/0001-25
14	Bahema	BAHI	Educação	45.987.245/0001-92
186	Baumer	BALM	Implantes Ortopédicos	61.374.161/0001-30
15	Banco da Amazônia	BAZA	Bancos	04.902.979/0001-44
16	Banco do Brasil	BBAS	Bancos	00.000.000/0001-91
188	Banco Bradesco	BBDC	Bancos	60.746.948/0001-12
17	Brasil Brokers	BBRK	Exploração de Imóveis	08.613.550/0001-98
190	Banestes	BEES	Bancos	28.127.603/0001-78
20	Banco Inter	BIDI	Bancos	00.416.968/0001-01
200	Banrisul	BRSR	Bancos	92.702.067/0001-96
212	Cesp	CESP	Energia	60.933.603/0001-78
213	Comgás	CGAS	Gás	61.856.571/0001-17
214	Grazziotin	CGRA	Vestuário	92.012.467/0001-70
41	Cielo	CIEL	Meios de Pagamento	01.027.058/0001-91
215	Celesc	CLSC	Energia	83.878.892/0001-55
216	Cemig	CMIG	Energia	17.155.730/0001-64
42	Centauro	CNTO	Vestuário	13.217.485/0001-11
217	Coelce	COCE	Energia	07.047.251/0001-70
43	CPFL Energia	CPFE	Energia	02.429.144/0001-93
218	Copel	CPLE	Energia	76.483.817/0001-20
18	BB Seguridade	BBSE	Seguros	17.344.597/0001-94
189	Bardella	BDLL	Máquinas e Equipamentos	60.851.615/0001-53
19	Minerva	BEEF	Carnes e Derivados	67.620.377/0001-14
191	Banese	BGIP	Bancos	13.009.717/0001-46
21	Biomm	BIOM	Medicamentos	04.752.991/0001-10
22	Burger King	BKBR	Restaurantes	13.574.594/0001-96
192	Banco Mercantil	BMEB	Bancos	17.184.037/0001-10
193	Mercantil Investimentos	BMIN	Bancos	34.169.557/0001-72
23	Monark	BMKS	Bicicletas	56.992.423/0001-90
25	Banco Pan	BPAN	Bancos	59.285.411/0001-13
30	BR Malls	BRML	Shoppings	06.977.745/0001-91
31	BRProperties	BRPR	Exploração de Imóveis	06.977.751/0001-49
44	CPFL Renováveis	CPRE	Energia	08.439.659/0001-50
45	CR2	CRDE	Construção Civil	07.820.907/0001-46
46	Carrefour	CRFB	Comércio Varejista	75.315.333/0001-09
219	Alfa Financeira	CRIV	Financeira	17.167.412/0001-13
220	Cristal	CRPG	Químicos	15.115.504/0001-24
221	Seguro Aliança	CSAB	Seguros	15.144.017/0001-90
47	Cosan	CSAN	Petróleo, Gás e Biocombustíveis	50.746.577/0001-15
48	Copasa	CSMG	Saneamento	17.281.106/0001-03
49	CSN	CSNA	Siderurgia	33.042.730/0001-04
222	Cosern	CSRN	Energia	08.324.196/0001-81
223	Karsten	CTKA	Têxtil	82.640.558/0001-04
224	Coteminas	CTNM	Têxtil	22.677.520/0001-76
225	Santanense	CTSA	Têxtil	21.255.567/0001-89
50	CVC	CVCB	Viagens e Turismo	10.760.260/0001-19
51	Cyrela Realty	CYRE	Construção Civil	73.178.600/0001-18
52	Dasa	DASA	Medicina Diagnóstica	61.486.650/0001-83
53	Direcional	DIRR	Construção Civil	16.614.075/0001-00
54	Dommo	DMMO	Petróleo, Gás e Biocombustíveis	08.926.302/0001-05
226	Dohler	DOHL	Têxtil	84.683.408/0001-03
227	DTCOM	DTCY	Educação	03.303.999/0001-36
55	Duratex	DTEX	Produtos para Construção Civil	97.837.181/0001-47
228	Electro Aço Altona	EALT	Máquinas e Equipamentos	82.643.537/0001-34
56	Ecorodovias	ECOR	Exploração de Rodovias	04.149.454/0001-80
229	CEEE-GT	EEEL	Energia	92.715.812/0001-31
57	Engie	EGIE	Energia	02.474.103/0001-19
230	Elektro	EKTR	Energia	02.328.280/0001-97
231	Elekeiroz	ELEK	Químicos	13.788.120/0001-47
232	Eletrobras	ELET	Energia	00.001.180/0001-26
58	Eletropaulo	ELPL	Energia	61.695.227/0001-93
233	Emae	EMAE	Energia	02.302.101/0001-42
59	Embraer	EMBR	Produção de Aerovanes	07.689.002/0001-89
60	Enauta	ENAT	Petróleo, Gás e Biocombustíveis	11.669.021/0001-10
66	Even	EVEN	Construção Civil	43.470.988/0001-65
67	Eztec	EZTC	Construção Civil	08.312.229/0001-73
238	Ferbasa	FESA	Siderurgia	15.141.799/0001-03
68	Heringer	FHER	Fertilizantes	22.266.175/0001-88
69	Fleury	FLRY	Medicina Diagnóstica	60.840.055/0001-31
70	Fras-le	FRAS	Material Rodoviário	88.610.126/0001-29
71	Metalfrio	FRIO	Máquinas e Equipamentos	04.821.041/0001-08
72	Pomi Frutas	FRTA	Agricultura	86.550.951/0001-50
240	Paranapanema Energia	GEPA	Energia	02.998.301/0001-81
74	Gafisa	GFSA	Construção Civil	01.545.826/0001-07
241	Gerdau	GGBR	Siderurgia	33.611.500/0001-19
75	NotreDame Intermédica	GNDI	Seguros	19.853.511/0001-84
242	Metalúrgica Gerdau	GOAU	Siderurgia	92.690.783/0001-09
61	Energias do Brasil	ENBR	Energia	03.983.431/0001-03
62	Eneva	ENEV	Energia	04.423.567/0001-21
234	Energisa	ENGI	Energia	00.864.214/0001-06
235	Energisa MT	ENMT	Energia	03.467.321/0001-99
63	Equatorial	EQTL	Energia	03.220.438/0001-73
236	Estrela	ESTR	Brinquedos e Jogos	61.082.004/0001-50
65	Eternit	ETER	Produtos para Construção Civil	61.092.037/0001-81
237	Eucatex	EUCA	Madeira	56.643.018/0001-66
243	Gol	GOLL	Aéreo	06.164.253/0001-87
76	Celg	GPAR	Energia	08.560.444/0001-93
244	GPC	GPCP	Químicos	02.193.750/0001-52
78	Grendene	GRND	Calçados	89.850.341/0001-60
79	General Shopping	GSHP	Shoppings	08.764.621/0001-53
80	Guararapes	GUAR	Vestuário	08.402.943/0001-52
245	Haga	HAGA	Produtos para Construção Civil	30.540.991/0001-66
81	Hapvida	HAPV	Seguros	05.197.443/0001-38
82	Helbor	HBOR	Construção Civil	49.263.189/0001-02
246	Habitasul	HBTS	Exploração de Imóveis	87.762.563/0001-03
247	Hercules	HETA	Utensílios Pessoais e Domésticos	92.749.225/0001-63
83	Cia Hering	HGTX	Vestuário	78.876.950/0001-71
248	Hotéis Othon	HOOT	Hotelaria	33.200.049/0001-47
84	Hypera Pharma	HYPE	Medicamentos	02.932.074/0001-91
85	Ideiasnet	IDNT	Holding	02.365.069/0001-44
249	Banco Indusval	IDVL	Bancos	61.024.352/0001-71
86	IGB Eletrônica	IGBR	Eletrodomésticos	43.185.362/0001-07
87	Iguatemi	IGTA	Shoppings	51.218.147/0001-93
250	Inepar	INEP	Máquinas e Equipamentos	76.627.504/0001-06
88	IRB Brasil	IRBR	Seguros	33.376.989/0001-91
251	Itaúsa	ITSA	Holding	61.532.644/0001-15
252	Banco Itaú	ITUB	Bancos	60.872.504/0001-23
253	JB Duarte	JBDU	Holding	60.637.238/0001-54
90	JBS	JBSS	Carnes e Derivados	02.916.265/0001-60
91	João Fortes	JFEN	Construção Civil	33.035.536/0001-00
92	JHSF	JHSF	Shoppings e Hotelaria	08.294.224/0001-65
254	Josapar	JOPA	Alimentos	87.456.562/0001-22
93	Jereissati	JPSA	Exploração de Imóveis	60.543.816/0001-93
94	JSL	JSLG	Logísitica e Rodoviário	52.548.435/0001-79
105	Log-in	LOGN	Hidroviário	42.278.291/0001-24
106	Lopes Brasil	LPSB	Exploração de Imóveis	08.078.847/0001-09
107	Lojas Renner	LREN	Vestuário	92.754.738/0001-62
108	Lupatech	LUPA	Equipamentos e Petróleo	89.463.822/0001-12
257	Trevisa	LUXM	Fertilizantes	92.660.570/0001-26
258	Cemepe Investimentos	MAPT	Holding	93.828.986/0001-73
109	M.Dias Branco	MDIA	Alimentos	07.206.816/0001-15
110	International Meal	MEAL	Restaurantes	17.314.329/0001-20
260	Mercantil Financeira	MERC	Financeira	33.040.601/0001-87
261	Magnels	MGEL	Siderurgia	61.065.298/0001-02
111	Magazine Luiza	MGLU	Comércio Varejista	47.960.950/0001-21
112	Mills	MILS	Construção e Engenharia	27.093.558/0001-15
113	MMX Miner	MMXM	Mineração	02.762.115/0001-49
114	Mundial	MNDL	Utensílios Pessoais e Domésticos	88.610.191/0001-54
115	Minupar	MNPR	Carnes e Derivados	90.076.886/0001-40
116	Monteiro Aranha	MOAR	Holding	33.102.476/0001-92
117	Movida	MOVI	Aluguel e Venda de Carros	21.314.559/0001-66
119	Marfrig	MRFG	Carnes e Derivados	03.853.896/0001-40
120	MRV Engenharia	MRVE	Construção Civil	08.343.492/0001-20
262	Melhoramentos SP	MSPA	Papel e Celulose e Editorial	60.730.348/0001-66
263	Metalgráfica Iguaçu	MTIG	Embalagens	80.227.184/0001-66
264	Metisa	MTSA	Máquinas e Equipamentos	86.375.425/0001-09
121	Multiplan	MULT	Shoppings	07.816.890/0001-53
265	Wetzel	MWET	Automotivo	84.683.671/0001-94
122	Iochpe-Maxion	MYPK	Automotivo	61.156.113/0001-75
123	Natura	NATU	Cosméticos	71.673.990/0001-77
124	Nordon	NORD	Máquinas e Equipamentos	60.884.319/0001-59
266	Oderich	ODER	Alimentos	97.191.902/0001-94
125	Odontoprev	ODPV	Seguros	58.119.199/0001-51
126	Ouro Fino	OFSA	Medicamentos	20.258.278/0001-70
267	Oi	OIBR	Telecomunicações	76.535.764/0001-43
127	Omega Geração	OMGE	Energia	09.149.503/0001-06
199	Braskem	BRKM	Químicos	42.150.391/0001-70
128	OSX Brasil	OSXB	Petróleo, Gás e Biocombustíveis	09.112.685/0001-32
129	Hermes Pardini	PARD	Medicina Diagnóstica	19.378.769/0001-76
268	Panatlântica	PATI	Siderurgia	92.693.019/0001-89
269	Pão de Açucar	PCAR	Comércio Varejista	47.508.411/0001-56
130	PDG Realty	PDGR	Construção Civil	02.950.811/0001-89
270	Participações Aliança	PEAB	Holding	01.938.783/0001-11
271	Petrobras	PETR	Petróleo, Gás e Biocombustíveis	33.000.167/0001-01
131	Profarma	PFRM	Produtos Farmacêuticos	45.453.214/0001-51
272	Banco Pine	PINE	Bancos	62.144.175/0001-20
132	Plascar	PLAS	Automotivo	51.928.174/0001-50
133	Paranapanema	PMAM	Siderurgia	60.398.369/0004-79
273	Dimed	PNVL	Medicamentos	92.665.611/0001-77
274	Marcopolo	POMO	Material Rodoviário	88.611.835/0001-29
134	Positivo	POSI	Hardware	81.243.735/0001-48
135	Petrorio	PRIO	Petróleo, Gás e Biocombustíveis	10.629.105/0001-68
136	Porto Seguro	PSSA	Seguros	02.149.205/0001-69
137	Portobello	PTBL	Cerâmicos	83.475.913/0001-91
148	Sabesp	SBSP	Saneamento	43.776.517/0001-80
149	São Carlos	SCAR	Exploração de Imóveis	29.780.061/0001-09
151	SER Educacional	SEER	Educação	04.986.320/0001-13
152	Springs Global	SGPS	Têxtil	07.718.269/0001-57
153	Time For Fun	SHOW	Eventos e Shows	02.860.694/0001-62
284	Schulz	SHUL	Automotivo e Compressores	84.693.183/0001-68
154	SLC Agrícola	SLCE	Agricultura	89.096.457/0001-55
285	Saraiva	SLED	Comércio Varejista	60.500.139/0001-26
286	Smart Fit	SMFT	Academias	07.594.978/0001-78
155	Smiles	SMLS	Programas de Fidelidade	05.730.375/0001-20
156	São Martinho	SMTO	Açúcar e Álcool	51.466.860/0001-56
287	Sondotécnica	SOND	Consultoria e Engenharia	33.386.210/0001-19
288	Springer	SPRI	Eletrodomésticos	92.929.520/0001-00
157	Sinqia	SQIA	Software	04.065.791/0001-99
159	Santos Brasil	STBP	Logística e Portuário	02.762.121/0001-04
289	Sulamerica	SULA	Seguros	29.978.814/0001-87
160	Suzano Papel	SUZB	Papel e Celulose	16.404.287/0001-55
290	Taesa	TAEE	Energia	07.859.971/0001-30
291	Tecnosolo	TCNO	Consultoria e Engenharia	33.111.246/0001-90
161	Tecnisa	TCSA	Construção Civil	08.065.557/0001-12
162	Technos	TECN	Relógios	09.295.063/0001-97
292	Teka	TEKA	Têxtil	82.636.986/0001-55
293	Telebrás	TELB	Telecomunicações	00.336.701/0001-04
163	Tenda	TEND	Construção Civil	71.476.527/0001-35
164	Terra Santa	TESA	Agricultura	05.799.312/0001-20
165	Tegma	TGMA	Automotivo e Logística	02.351.144/0001-18
294	AES Tietê	TIET	Energia	04.128.563/0001-10
166	TIM	TIMP	Telecomunicações	02.558.115/0001-21
295	Tekno	TKNO	Siderurgia	33.467.572/0001-34
167	Totvs	TOTS	Software	53.113.791/0001-22
168	Triunfo	TPIS	Exploração de Rodovias	03.014.553/0001-91
169	Trisul	TRIS	Construção Civil	08.811.643/0001-27
297	Trans Paulista	TRPL	Energia	02.998.611/0001-04
171	Tupy	TUPY	Material Rodoviário	84.683.374/0001-49
298	Renauxview	TXRX	Vestuário	82.982.075/0001-80
172	Unicasa	UCAS	Móveis	90.441.460/0001-48
173	Ultrapar	UGPA	Petróleo, Gás e Biocombustíveis	33.256.439/0001-39
299	Unipar	UNIP	Soda, Cloro e Derivados	33.958.695/0001-78
275	Pettenati	PTNT	Têxtil	88.613.658/0001-10
138	Qualicorp	QUAL	Seguros	11.992.680/0001-93
139	RaiaDrogasil	RADL	Produtos Farmacêuticos	61.585.865/0001-51
140	Rumo Log	RAIL	Logística e Ferroviário	02.387.241/0001-60
276	Celulose Irani	RANI	Papel e Celulose	92.791.243/0001-03
277	Randon	RAPT	Material Rodoviário	89.086.144/0001-16
278	Recrusul	RCSL	Material Rodoviário	91.333.666/0001-17
141	RNI	RDNI	Construção Civil	67.010.660/0001-24
142	Rede Energia	REDE	Petróleo, Gás e Biocombustíveis	61.584.140/0001-49
143	Localiza	RENT	Aluguel e Venda de Carros	16.670.085/0001-55
144	Cosan Logística	RLOG	Logística e Ferroviário	17.346.997/0001-39
279	Renova	RNEW	Energia	08.534.605/0001-74
145	Indústrias Romi	ROMI	Máquinas e Equipamentos	56.720.428/0001-63
280	Alfa Holdings	RPAD	Holding	17.167.396/0001-69
146	PET Manguinhos	RPMG	Petróleo, Gás e Biocombustíveis	33.412.081/0001-96
147	Rossi	RSID	Construção Civil	61.065.751/0001-80
281	Riosulense	RSUL	Metalurgia	85.778.074/0001-06
282	Santander	SANB	Bancos	90.400.888/0001-42
283	Sanepar	SAPR	Saneamento	76.484.013/0001-45
300	Usiminas	USIM	Siderurgia	60.894.730/0001-05
174	Vale	VALE	Mineração	33.592.510/0001-54
175	Viver	VIVR	Construção Civil	67.571.414/0001-41
301	Telefônica	VIVT	Telecomunicações	02.558.157/0001-62
176	Valid	VLID	Documentos de Segurança	33.113.309/0001-47
177	Vulcabras	VULC	Calçados	50.926.955/0001-42
178	Via Varejo	VVAR	Comércio Varejista	33.041.260/0652-90
179	Weg	WEGE	Motores e Compressores	84.429.695/0001-11
302	Whirlpool	WHRL	Eletrodomésticos	59.105.999/0001-86
180	WIZ Soluções	WIZS	Seguros	42.278.473/0001-03
303	WLM	WLMM	Automotivo e Agropecuário	33.228.024/0001-51
170	Tarpon	TRPN	Gestão de Recursos	05.341.549/0001-63
24	Banco do Nordeste	BNBR	Bancos	07.237.373/0001-20
194	Bombril	BOBR	Produtos de Limpeza	50.564.053/0001-03
195	Banco BTG Pactual	BPAC	Bancos	30.306.294/0001-45
196	Bradespar	BRAP	Holding	03.847.461/0001-92
27	BR Distribuidora	BRDT	Petróleo, Gás e Biocombustíveis	34.274.233/0001-02
28	BRF	BRFS	Carnes e Derivados	01.838.723/0001-27
197	Alfa Consórcio	BRGE	Seguros	17.193.806/0001-46
198	Banco Alfa	BRIV	Bancos	60.770.336/0001-65
95	Kepler	KEPL	Máquinas e Equipamentos	91.983.056/0001-69
255	Klabin	KLBN	Papel e Celulose	89.637.490/0001-45
256	Lojas Americanas	LAME	Comércio Varejista	33.014.556/0001-96
97	Locamérica	LCAM	Aluguel e Venda de Carros	10.215.988/0001-60
98	Mahle Metal Leve	LEVE	Peças para Motores	60.476.884/0001-87
99	Light	LIGT	Energia	03.378.521/0001-75
100	Linx	LINX	Software	06.948.969/0001-75
101	Eletropar	LIPR	Energia	01.104.937/0001-70
102	Liq	LIQO	Consultoria	04.032.433/0001-80
103	Le Lis Blanc	LLIS	Vestuário	49.669.856/0001-43
104	Log CP	LOGG	Construção Civil	09.041.168/0001-10
307	Amazon	AMZN	Specialty Retail	911646860
308	Visa	V	Credit Services	260267673
309	Alphabet(Google)	GOOGL	Internet Content & Information	611767919
310	Microsoft	MSFT	Software - Infrastructure	911144442
311	Accenture	ACN	Information Technology Services	980627530
312	Novo Nordisk	NVO	Biotechnology	16.921.603/0001
\.


--
-- Data for Name: ativo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ativo (id, nome, codigo, acao_bolsa_id, categoria, tipo, pais, classe_atualiza_id) FROM stdin;
13	ALASKA BLACK FIC FIA II	ALASKA BLACK FIC FIA II	\N	Renda Variável	Fundos de Investimentos	BR	1
15	Itausa	ITSA4	\N	Renda Variável	Ações	BR	1
24	M.Dias Branco	MDIA3	109	Renda Variável	Ações	BR	1
25	Odonto Prev	ODPV3	125	Renda Variável	Ações	BR	1
38	CSHG Logística	HGLG11	\N	Renda Variável	FIIs	BR	1
39	XP Logística	XPLG11	\N	Renda Variável	FIIs	BR	1
40	XP Malls	XPML11	\N	Renda Variável	FIIs	BR	1
42	Fator Verita	VRTA11	\N	Renda Variável	FIIs	BR	1
31	Visa	V	308	Renda Variável	Ações	US	1
14	Banco inter	BIDI4	20	Renda Variável	Ações	BR	1
20	fleury	FLRY3	69	Renda Variável	Ações	BR	1
16	Itausa	ITSA3	251	Renda Variável	Ações	BR	1
21	weg	WEGE3	179	Renda Variável	Ações	BR	1
17	ambev	ABEV3	3	Renda Variável	Ações	BR	1
18	B3	B3SA3	13	Renda Variável	Ações	BR	1
19	engie	EGIE3	57	Renda Variável	Ações	BR	1
23	Grendene	GRND3	78	Renda Variável	Ações	BR	1
29	Amazon	AMZN	307	Renda Variável	Ações	US	1
30	Google	GOOGL	309	Renda Variável	Ações	US	1
32	Microsoft	MSFT	310	Renda Variável	Ações	US	1
34	Accenture	ACN	311	Renda Variável	Ações	US	1
35	Novo Nordisk	NVO	312	Renda Variável	Ações	US	1
37	BlackRock Institutional Trust Company N.A. - BTC iShares Gold Trust	IAU	\N	Renda Variável	Ouro	US	1
49	TG Ativo Real	TGAR11	\N	Renda Variável	FIIs	BR	1
50	Meta Platforms	FB	\N	Renda Variável	Ações	US	1
51	Bitcoin	BTC	\N	Renda Variável	Criptomoeda	BR	1
53	Kilima Suno 30	KISU11	\N	Renda Variável	FIIs	BR	1
54	Prologis Inc	PLD	\N	Renda Variável	Ações	US	1
55	REALTY INCOME CORP 	O	\N	Renda Variável	Ações	US	1
33	Cdb banco inter liquides diário	CDB_BANCO_INTER_LIQ_DIARIA	\N	Renda Fixa	CDB	BR	2
56	Dollar	DOLLAR	\N	Renda Variável	Dollar	US	1
57	Tesouro Selic 2019	Tesouro Selic 2029-SELIC-01/03/2029	\N	Renda Fixa	Tesouro Direto	BR	3
36	Tesouro IPCA+ 2026 - 15/08/2026	Tesouro IPCA+ 2026-IPCA-15/08/2026	\N	Renda Fixa	Tesouro Direto	BR	3
41	Tesouro-Selic-2027-SELIC+0,3183	Tesouro-Selic-2027-SELIC+0,3183	\N	Renda Fixa	Tesouro Direto	BR	3
5	BANCO AGIBANK - 121.50% - 20/04/2020	BANCO AGIBANK-121,50% do CDI-20/04/2020	\N	Renda Fixa	CDB	BR	3
4	Tesouro Selic 2025	Tesouro Selic 2025-SELIC-01/03/2025	\N	Renda Fixa	Tesouro Direto	BR	3
1	Tesouro Selic 2023	Tesouro Selic 2023-SELIC-01/03/2023	\N	Renda Fixa	Tesouro Direto	BR	3
7	CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,70%-15/02/2021	CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,70%-15/02/2021	\N	Renda Fixa	Debêntures	BR	3
2	CMDT23 - CEMIG DISTRIBUICAO S.A  IPC-A + 9.15%	CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,15%-15/02/2021	\N	Renda Fixa	Debêntures	BR	3
26	Tesouro ipca 2035	Tesouro IPCA+ 2035-IPCA-15/05/2035	\N	Renda Fixa	Tesouro Direto	BR	3
9	Banco Maxima - 121% CDI	BANCO MASTER-121% do CDI-30/01/2023	\N	Renda Fixa	CDB	BR	3
10	Banco Maxima - 128% CDI - 21/07/2023	BANCO MASTER-128% do CDI-21/07/2023	\N	Renda Fixa	CDB	BR	3
11	Banco Maxima - 128% CDI - 28/01/2026	BANCO MASTER-128% do CDI-28/01/2026	\N	Renda Fixa	CDB	BR	3
3	Tesouro IPCA+ 2024	Tesouro IPCA+ 2024-IPCA-15/08/2024	\N	Renda Fixa	Tesouro Direto	BR	3
52	Tesouro Selic 2027-SELIC +  0,1640  -01/03/2027	Tesouro Selic 2027-SELIC-01/03/2027	\N	Renda Fixa	Tesouro Direto	BR	3
\.


--
-- Data for Name: atualiza_acoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atualiza_acoes (id, data, ativo_atualizado, status) FROM stdin;
\.


--
-- Data for Name: atualiza_ativo_manual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atualiza_ativo_manual (id, itens_ativo_id) FROM stdin;
1	40
\.


--
-- Data for Name: atualiza_nu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atualiza_nu (id, valor_bruto_antigo, valor_liquido_antigo, operacoes_import_id, itens_ativo_id) FROM stdin;
1	1313.88	1313.88	130	20
2	12660.88	12660.88	130	21
3	1067.19	1067.19	130	22
4	32440.57	32440.57	130	47
5	6952.45	6952.45	130	53
\.


--
-- Data for Name: atualiza_operacoes_manual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atualiza_operacoes_manual (id, valor_bruto, valor_liquido, atualiza_ativo_manual_id, data) FROM stdin;
1	22223.10	21704.82	1	2023-02-06 20:30:55
2	20270.46	19774.39	1	2023-03-07 18:35:18
3	19406.43	18928.01	1	2023-03-14 18:10:46
4	18205.01	17748.57	1	2023-03-26 17:40:19
\.


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditoria (id, model, operacao, changes, user_id, created_at) FROM stdin;
10143	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": 984.95}	2	1687099025
10144	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 317, "valor_bruto": "2428.6", "valor_compra": 2565.677596439169, "investidor_id": 1, "valor_liquido": 2565.677596439169}	2	1687099025
10145	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": 32934.780000000006}	2	1687099025
10146	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": 1033.09}	2	1687099025
10147	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": 1912.6799999999998}	2	1687099025
10148	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": 9008.13}	2	1687099025
10149	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": 1012.86}	2	1687099025
10150	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": 8385.16}	2	1687099025
10151	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": 2342.8399999999997}	2	1687099025
10152	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.678203181342, "investidor_id": 1, "valor_liquido": 1517.678203181342}	2	1687099025
10153	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": 171.02}	2	1687099025
10154	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": 373}	2	1687099025
10155	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": 2387.24}	2	1687099025
10156	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": 15093.679979999995}	2	1687099025
10157	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": 2783.3500000000004}	2	1687099025
10158	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": 195.19}	2	1687099025
10159	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": 365.53999999999996}	2	1687099025
10160	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": 2434.7699999999995}	2	1687099025
10161	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": 4350.53}	2	1687099025
10162	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 11, "valor_bruto": "1124.31", "valor_compra": 1053.18, "investidor_id": 2, "valor_liquido": 1053.18}	2	1687099025
10163	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": 1022}	2	1687099025
10164	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": 376.96000000000004}	2	1687099025
10165	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": 5180.159999999999}	2	1687099025
10166	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": 277}	2	1687099025
10167	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": 2111.97}	2	1687099025
10168	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 66, "valor_bruto": "1875.72", "valor_compra": 2137.349577464789, "investidor_id": 1, "valor_liquido": 2137.349577464789}	2	1687099025
10169	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.14144144144, "investidor_id": 1, "valor_liquido": 3712.14144144144}	2	1687099025
10170	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": 4473.49}	2	1687099025
10171	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.1575510204075, "investidor_id": 1, "valor_liquido": 3667.1575510204075}	2	1687099025
10172	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": 4831.209999999999}	2	1687099025
10173	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": 5110.2303999999995}	2	1687099025
10174	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": 18020.090099999998}	2	1687099025
10175	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.378039215686, "investidor_id": 1, "valor_liquido": 8095.378039215686}	2	1687099025
10176	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": 2187}	2	1687099025
10177	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": 181.78}	2	1687099025
10178	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": 2006.81}	2	1687099025
10179	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": 380.8}	2	1687099025
10180	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 63814.1396576398, "investidor_id": 1, "valor_liquido": 63814.1396576398}	2	1687099025
10181	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": 1000}	2	1687099025
10182	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9557966101697, "investidor_id": 1, "valor_liquido": 1509.9557966101697}	2	1687099025
10183	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": 7963.17}	2	1687099025
10184	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.83443139785, "investidor_id": 1, "valor_liquido": 7105.83443139785}	2	1687099025
10185	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "8176.80", "valor_compra": 8406.587307692309, "investidor_id": 1, "valor_liquido": 8406.587307692309}	2	1687099025
10186	app\\models\\financas\\Ativo	update	{"id": 57, "nome": "Tesouro Selic 2019", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro Selic 2029-SELIC-01/03/2029", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10187	app\\models\\financas\\Ativo	update	{"id": 36, "nome": "Tesouro IPCA+ 2026 - 15/08/2026", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro IPCA+ 2026-IPCA-15/08/2026", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10188	app\\models\\financas\\Ativo	update	{"id": 41, "nome": "Tesouro-Selic-2027-SELIC+0,3183", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro-Selic-2027-SELIC+0,3183", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10189	app\\models\\financas\\Ativo	update	{"id": 5, "nome": "BANCO AGIBANK - 121.50% - 20/04/2020", "pais": "BR", "tipo": "CDB", "codigo": "BANCO AGIBANK-121,50% do CDI-20/04/2020", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10190	app\\models\\financas\\Ativo	update	{"id": 4, "nome": "Tesouro Selic 2025", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro Selic 2025-SELIC-01/03/2025", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10191	app\\models\\financas\\Ativo	update	{"id": 1, "nome": "Tesouro Selic 2023", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro Selic 2023-SELIC-01/03/2023", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10192	app\\models\\financas\\Ativo	update	{"id": 7, "nome": "CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,70%-15/02/2021", "pais": "BR", "tipo": "Debêntures", "codigo": "CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,70%-15/02/2021", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10193	app\\models\\financas\\Ativo	update	{"id": 2, "nome": "CMDT23 - CEMIG DISTRIBUICAO S.A  IPC-A + 9.15%", "pais": "BR", "tipo": "Debêntures", "codigo": "CMDT23 - CEMIG DISTRIBUICAO S.A-IPC-A + 9,15%-15/02/2021", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10194	app\\models\\financas\\Ativo	update	{"id": 26, "nome": "Tesouro ipca 2035", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro IPCA+ 2035-IPCA-15/05/2035", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10195	app\\models\\financas\\Ativo	update	{"id": 9, "nome": "Banco Maxima - 121% CDI", "pais": "BR", "tipo": "CDB", "codigo": "BANCO MASTER-121% do CDI-30/01/2023", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10196	app\\models\\financas\\Ativo	update	{"id": 10, "nome": "Banco Maxima - 128% CDI - 21/07/2023", "pais": "BR", "tipo": "CDB", "codigo": "BANCO MASTER-128% do CDI-21/07/2023", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10197	app\\models\\financas\\Ativo	update	{"id": 11, "nome": "Banco Maxima - 128% CDI - 28/01/2026", "pais": "BR", "tipo": "CDB", "codigo": "BANCO MASTER-128% do CDI-28/01/2026", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10198	app\\models\\financas\\Ativo	update	{"id": 3, "nome": "Tesouro IPCA+ 2024", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro IPCA+ 2024-IPCA-15/08/2024", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10199	app\\models\\financas\\Ativo	update	{"id": 52, "nome": "Tesouro Selic 2027-SELIC +  0,1640  -01/03/2027", "pais": "BR", "tipo": "Tesouro Direto", "codigo": "Tesouro Selic 2027-SELIC-01/03/2027", "categoria": "Renda Fixa", "acao_bolsa_id": null, "classe_atualiza_id": 3}	2	1687100001
10200	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": "427", "valor_bruto": "3744.79", "valor_compra": "5110.2304", "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687100025
10201	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": "288", "valor_bruto": "4066.56", "valor_compra": "4473.49", "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687100025
10202	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": "306", "valor_bruto": "3552.66", "valor_compra": "5180.16", "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687100025
10203	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": "85", "valor_bruto": "3485.85", "valor_compra": "3712.1414414414", "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687100025
10204	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": "174", "valor_bruto": "2510.82", "valor_compra": "4350.53", "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687100025
10205	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": "71", "valor_bruto": "2904.61", "valor_compra": "1509.9557966102", "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687100025
10206	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": "616", "valor_bruto": "5001.92", "valor_compra": "4831.21", "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687100025
10207	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": "66", "valor_bruto": "1875.72", "valor_compra": "2137.3495774648", "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687100025
10208	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": "253", "valor_bruto": "2532.53", "valor_compra": "3667.1575510204", "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687100025
10209	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": "1.339", "valor_bruto": "141.35823", "valor_compra": "195.19", "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687100025
10210	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": "17.2086", "valor_bruto": "1816.711902", "valor_compra": "2783.35", "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687100025
10211	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": "21.2842", "valor_bruto": "2275.068138", "valor_compra": "2111.97", "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687100025
10212	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": "2.94893", "valor_bruto": "315.2111277", "valor_compra": "376.96", "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687100025
10213	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": "10.22714", "valor_bruto": "3121.1185852", "valor_compra": "2434.77", "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687100025
10214	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": "1.33286", "valor_bruto": "406.7622148", "valor_compra": "365.54", "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687100025
10215	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": "8.75256", "valor_bruto": "2411.7679080", "valor_compra": "2342.84", "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687100025
10216	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": "1.61888", "valor_bruto": "270.7900576", "valor_compra": "171.02", "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687100025
10217	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": "21.3964", "valor_bruto": "3578.975828", "valor_compra": "1517.6782031813", "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687100025
10218	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": "70.21576", "valor_bruto": "2649.2406248", "valor_compra": "2387.24", "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687100025
10219	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": "10.82491", "valor_bruto": "408.4238543", "valor_compra": "373", "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687100025
10220	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": "48", "valor_bruto": "7799.52", "valor_compra": "8095.3780392157", "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687100026
10221	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": "80", "valor_bruto": "8176.80", "valor_compra": "8406.5873076923", "investidor_id": 1, "valor_liquido": "8176.80"}	2	1687100026
10222	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": "11", "valor_bruto": "1124.31", "valor_compra": "1053.18", "investidor_id": 2, "valor_liquido": "1124.31"}	2	1687100026
10556	app\\models\\financas\\Operacao	insert	{"id": 836, "data": "2023-06-25 12:10:56", "tipo": "1", "valor": "10000", "quantidade": "100", "itens_ativos_id": "14"}	2	1687705976
10223	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": "69", "valor_bruto": "7112.52", "valor_compra": "7105.8344313978", "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687100026
10224	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": "10", "valor_bruto": "1030.80", "valor_compra": "1022", "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687100026
10225	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": "174", "valor_bruto": "14414.16", "valor_compra": "18020.0901", "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687100026
10226	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": "129", "valor_bruto": "14490.57", "valor_compra": "15093.67998", "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687100026
10227	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": "1.35168", "valor_bruto": "320.0643072", "valor_compra": "277", "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687100026
10228	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": "0.01867941", "valor_bruto": "2753.04616344", "valor_compra": "2187", "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687100026
10229	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": "317", "valor_bruto": "2472.60", "valor_compra": "2565.6775964392", "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687100026
10230	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": "16.726", "valor_bruto": "2081.55070", "valor_compra": "2006.81", "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687100026
10231	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": "1.61444", "valor_bruto": "200.9170580", "valor_compra": "181.78", "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687100026
10232	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": "6.13338", "valor_bruto": "384.5015922", "valor_compra": "380.8", "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687100026
10233	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": "28.52771", "valor_bruto": "1788.4021399", "valor_compra": "1912.68", "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687100026
10234	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": 984.95}	2	1687561447
10235	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": 32934.780000000006}	2	1687561447
10236	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": 1033.09}	2	1687561447
10237	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": 9008.13}	2	1687561447
10238	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": 1012.86}	2	1687561447
10239	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": 8385.16}	2	1687561447
10240	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9557966101697, "investidor_id": 1, "valor_liquido": 1509.9557966101697}	2	1687561447
10241	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": 4831.209999999999}	2	1687561447
10242	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 66, "valor_bruto": "1875.72", "valor_compra": 2137.349577464789, "investidor_id": 1, "valor_liquido": 2137.349577464789}	2	1687561447
10243	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.1575510204075, "investidor_id": 1, "valor_liquido": 3667.1575510204075}	2	1687561447
10244	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": 195.19}	2	1687561447
10245	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": 16686.979999999996}	2	1687561447
10246	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": 1000}	2	1687561447
10247	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": 7963.17}	2	1687561447
10248	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": 5110.2303999999995}	2	1687561447
10249	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": 4473.49}	2	1687561447
10250	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": 5180.159999999999}	2	1687561447
10251	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.14144144144, "investidor_id": 1, "valor_liquido": 3712.14144144144}	2	1687561447
10252	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": 4350.53}	2	1687561447
10253	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": 2783.3500000000004}	2	1687561447
10254	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": 2111.97}	2	1687561447
10255	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": 376.96000000000004}	2	1687561447
10256	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": 2434.7699999999995}	2	1687561447
10257	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": 365.53999999999996}	2	1687561447
10258	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": 2342.8399999999997}	2	1687561447
10259	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": 171.02}	2	1687561447
10260	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.678203181342, "investidor_id": 1, "valor_liquido": 1517.678203181342}	2	1687561447
10261	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": 2387.24}	2	1687561447
10262	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": 373}	2	1687561447
10263	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.378039215686, "investidor_id": 1, "valor_liquido": 8095.378039215686}	2	1687561447
10264	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "8176.80", "valor_compra": 8406.587307692309, "investidor_id": 1, "valor_liquido": 8406.587307692309}	2	1687561447
10265	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 11, "valor_bruto": "1124.31", "valor_compra": 1053.18, "investidor_id": 2, "valor_liquido": 1053.18}	2	1687561447
10266	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.83443139785, "investidor_id": 1, "valor_liquido": 7105.83443139785}	2	1687561447
10267	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": 1022}	2	1687561447
10268	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": 18020.090099999998}	2	1687561447
10269	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": 15093.679979999995}	2	1687561447
10270	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": 277}	2	1687561447
10271	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": 2187}	2	1687561447
10272	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 317, "valor_bruto": "2472.60", "valor_compra": 2565.677596439169, "investidor_id": 1, "valor_liquido": 2565.677596439169}	2	1687561447
10273	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": 2006.81}	2	1687561447
10274	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": 181.78}	2	1687561447
10275	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": 380.8}	2	1687561447
10276	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": 1912.6799999999998}	2	1687561447
10277	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": "427", "valor_bruto": "3744.79", "valor_compra": "5110.2304", "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687561454
10278	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": "288", "valor_bruto": "4066.56", "valor_compra": "4473.49", "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687561454
10279	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": "306", "valor_bruto": "3552.66", "valor_compra": "5180.16", "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687561454
10280	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": "85", "valor_bruto": "3485.85", "valor_compra": "3712.1414414414", "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687561454
10281	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": "174", "valor_bruto": "2510.82", "valor_compra": "4350.53", "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687561454
10282	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": "71", "valor_bruto": "2904.61", "valor_compra": "1509.9557966102", "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687561454
10283	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": "616", "valor_bruto": "5001.92", "valor_compra": "4831.21", "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687561454
10284	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": "66", "valor_bruto": "1875.72", "valor_compra": "2137.3495774648", "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687561454
10285	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": "253", "valor_bruto": "2532.53", "valor_compra": "3667.1575510204", "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687561454
10286	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": "1.339", "valor_bruto": "141.35823", "valor_compra": "195.19", "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687561454
10287	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": "17.2086", "valor_bruto": "1816.711902", "valor_compra": "2783.35", "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687561454
10288	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": "21.2842", "valor_bruto": "2275.068138", "valor_compra": "2111.97", "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687561454
10289	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": "2.94893", "valor_bruto": "315.2111277", "valor_compra": "376.96", "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687561454
10290	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": "10.22714", "valor_bruto": "3121.1185852", "valor_compra": "2434.77", "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687561454
10291	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": "1.33286", "valor_bruto": "406.7622148", "valor_compra": "365.54", "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687561454
10292	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": "8.75256", "valor_bruto": "2411.7679080", "valor_compra": "2342.84", "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687561454
10293	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": "1.61888", "valor_bruto": "270.7900576", "valor_compra": "171.02", "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687561454
10294	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": "21.3964", "valor_bruto": "3578.975828", "valor_compra": "1517.6782031813", "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687561454
10295	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": "70.21576", "valor_bruto": "2649.2406248", "valor_compra": "2387.24", "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687561454
10296	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": "10.82491", "valor_bruto": "408.4238543", "valor_compra": "373", "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687561454
10297	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": "48", "valor_bruto": "7799.52", "valor_compra": "8095.3780392157", "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687561454
10298	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": "80", "valor_bruto": "8176.80", "valor_compra": "8406.5873076923", "investidor_id": 1, "valor_liquido": "8176.80"}	2	1687561454
10299	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": "11", "valor_bruto": "1124.31", "valor_compra": "1053.18", "investidor_id": 2, "valor_liquido": "1124.31"}	2	1687561454
10300	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": "69", "valor_bruto": "7112.52", "valor_compra": "7105.8344313978", "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687561454
10301	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": "10", "valor_bruto": "1030.80", "valor_compra": "1022", "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687561454
10302	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": "174", "valor_bruto": "14414.16", "valor_compra": "18020.0901", "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687561454
10303	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": "129", "valor_bruto": "14490.57", "valor_compra": "15093.67998", "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687561454
10304	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": "1.35168", "valor_bruto": "320.0643072", "valor_compra": "277", "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687561454
10305	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": "0.01867941", "valor_bruto": "2753.04616344", "valor_compra": "2187", "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687561454
10306	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": "317", "valor_bruto": "2472.60", "valor_compra": "2565.6775964392", "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687561454
10307	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": "16.726", "valor_bruto": "2081.55070", "valor_compra": "2006.81", "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687561454
10308	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": "1.61444", "valor_bruto": "200.9170580", "valor_compra": "181.78", "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687561454
10309	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": "6.13338", "valor_bruto": "384.5015922", "valor_compra": "380.8", "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687561454
10310	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": "28.52771", "valor_bruto": "1788.4021399", "valor_compra": "1912.68", "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687561454
10311	app\\models\\financas\\Operacao	insert	{"id": 817, "data": "2023-06-21 20:05:11", "tipo": "2", "valor": 0, "quantidade": "7", "itens_ativos_id": "48"}	2	1687561643
10312	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": "2565.6775964392", "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687561643
10313	app\\models\\financas\\Operacao	insert	{"id": 818, "data": "2023-06-21 17:05:07", "tipo": "3", "valor": 0, "quantidade": "7", "itens_ativos_id": "8"}	2	1687561764
10314	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": "2137.3495774648", "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687561764
10557	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 111, "valor_bruto": 11345.31, "valor_compra": 11053.18, "investidor_id": 2, "valor_liquido": 11345.31}	2	1687705976
10558	app\\models\\financas\\Operacao	insert	{"id": 837, "data": "2023-06-25 12:15:43", "tipo": "0", "valor": "1100", "quantidade": "10", "itens_ativos_id": "14"}	2	1687706065
10559	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 101, "valor_bruto": 10323.21, "valor_compra": 10057.398018018019, "investidor_id": 2, "valor_liquido": 10323.21}	2	1687706066
10560	app\\models\\financas\\Operacao	insert	{"id": 838, "data": "2023-06-25 12:20:06", "tipo": "2", "valor": 0, "quantidade": "100", "itens_ativos_id": "14"}	2	1687706136
10561	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 201, "valor_bruto": "10323.21", "valor_compra": "10057.398018018", "investidor_id": 2, "valor_liquido": "10323.21"}	2	1687706136
10562	app\\models\\financas\\Operacao	insert	{"id": 839, "data": "2023-06-25 12:25:28", "tipo": "0", "valor": "1500", "quantidade": "15", "itens_ativos_id": "14"}	2	1687706228
10563	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 186, "valor_bruto": 19011.059999999998, "valor_compra": 9271.626927970607, "investidor_id": 2, "valor_liquido": 19011.059999999998}	2	1687706228
10564	app\\models\\financas\\Operacao	insert	{"id": 840, "data": "2023-06-25 12:30:56", "tipo": "3", "valor": 0, "quantidade": "100", "itens_ativos_id": "14"}	2	1687706302
10565	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 86, "valor_bruto": "19011.06", "valor_compra": "9271.6269279706", "investidor_id": 2, "valor_liquido": "19011.06"}	2	1687706302
10566	app\\models\\financas\\Operacao	insert	{"id": 841, "data": "2023-06-25 12:35:33", "tipo": "1", "valor": "1274", "quantidade": "13", "itens_ativos_id": "11"}	2	1687706368
10567	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 93, "valor_bruto": 9505.529999999999, "valor_compra": 9680.5873076923, "investidor_id": 1, "valor_liquido": 9505.529999999999}	2	1687706368
10568	app\\models\\financas\\Operacao	update	{"id": 841, "data": "2023-06-25 12:35:33", "tipo": "1", "valor": "1274", "quantidade": "13", "itens_ativos_id": "14"}	2	1687706452
10569	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "19011.06", "valor_compra": 10580.845927121152, "investidor_id": 2, "valor_liquido": 10580.845927121152}	2	1687706452
10570	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": "99", "valor_bruto": "10118.79", "valor_compra": "10580.845927121", "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687706452
10571	app\\models\\financas\\Operacao	update	{"id": 837, "data": "2023-06-25 12:15:43", "tipo": "1", "valor": "1100", "quantidade": "10", "itens_ativos_id": "14"}	2	1687710358
10572	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 119, "valor_bruto": "10118.79", "valor_compra": 12602.303529411765, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687710358
10573	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": "119", "valor_bruto": "12162.99", "valor_compra": "12602.303529412", "investidor_id": 2, "valor_liquido": "12162.99"}	2	1687710358
10574	app\\models\\financas\\Operacao	update	{"id": 837, "data": "2023-06-25 12:15:43", "tipo": "0", "valor": "1100", "quantidade": "10", "itens_ativos_id": "14"}	2	1687710427
10575	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "12162.99", "valor_compra": 10580.845927121152, "investidor_id": 2, "valor_liquido": "12162.99"}	2	1687710427
10576	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": "99", "valor_bruto": "10118.79", "valor_compra": "10580.845927121", "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687710427
10577	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": "984.95"}	2	1687712119
10578	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": "32934.78"}	2	1687712119
10579	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": "1033.09"}	2	1687712119
10580	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": "9008.13"}	2	1687712119
10581	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": "1012.86"}	2	1687712119
10582	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": "8385.16"}	2	1687712119
10583	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1687712119
10584	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": "1000"}	2	1687712119
10585	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": "7963.17"}	2	1687712119
10586	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687712119
10587	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9400000000003, "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687712120
10588	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687712120
10589	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687712120
10590	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687712120
10591	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687712120
10592	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.199999999998, "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687712120
10593	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.5799999999995, "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687712120
10594	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687712120
10595	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687712120
10596	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687712120
10597	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687712120
10598	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687712120
10599	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687712120
10600	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687712120
10601	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687712120
10602	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.69, "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687712120
10603	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687712120
10604	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687712120
10605	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.279999999999, "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687712120
10606	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.800039999999, "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687712120
10607	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687712120
10608	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687712120
10609	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687712120
10610	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687712120
10611	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687712120
10612	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687712120
10613	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687712120
10614	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687712120
10615	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687712120
10616	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.7499999999995, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712120
10617	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.3600000000006, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687712120
10618	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.570000000002, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687712120
10619	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "10118.79", "valor_compra": 10580.78, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687712120
10620	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.7499999999995, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712356
10621	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.3600000000006, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687712356
10622	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.570000000002, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687712356
10623	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "10118.79", "valor_compra": 10580.78, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687712356
10624	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": "984.95"}	2	1687712356
10625	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": "32934.78"}	2	1687712356
10626	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": "1033.09"}	2	1687712356
10627	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": "9008.13"}	2	1687712356
10628	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": "1012.86"}	2	1687712356
10629	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": "8385.16"}	2	1687712356
10630	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1687712356
10631	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": "1000"}	2	1687712356
10632	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": "7963.17"}	2	1687712356
10633	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687712356
10634	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9400000000003, "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687712356
10635	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687712356
10636	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687712356
10637	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687712356
10638	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687712356
10639	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.199999999998, "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687712356
10640	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.5799999999995, "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687712356
10641	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687712356
10642	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687712356
10643	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687712356
10644	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687712356
10645	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687712356
10646	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687712356
10647	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687712356
10648	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687712356
10649	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.69, "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687712356
10650	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687712356
10651	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687712356
10652	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.279999999999, "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687712356
10653	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.800039999999, "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687712356
10654	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687712356
10655	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687712356
10656	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687712356
10657	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687712356
10658	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687712356
10659	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687712356
10660	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687712356
10661	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687712356
10662	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687712356
10663	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687712403
10664	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.677596439169, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712403
10665	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.349577464789, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687712403
10666	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.587307692309, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687712403
10667	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "10118.79", "valor_compra": 10580.845927121152, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687712403
10668	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": "984.95"}	2	1687712403
10669	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": "32934.78"}	2	1687712403
10670	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": "1033.09"}	2	1687712403
10671	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": "9008.13"}	2	1687712403
10672	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": "1012.86"}	2	1687712403
10673	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": "8385.16"}	2	1687712403
10674	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1687712403
10675	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": "1000"}	2	1687712403
10676	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": "7963.17"}	2	1687712403
10677	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687712403
10678	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9557966101697, "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687712403
10679	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687712403
10680	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687712403
10681	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687712403
10682	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687712403
10683	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.14144144144, "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687712403
10684	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.1575510204075, "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687712403
10685	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687712403
10686	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687712403
10687	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687712403
10688	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687712403
10689	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687712403
10690	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687712403
10691	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687712403
10692	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687712403
10693	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.678203181342, "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687712403
10694	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687712404
10695	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687712404
10696	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.378039215686, "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687712404
10697	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.83443139785, "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687712404
10698	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687712404
10699	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687712404
10700	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687712404
10701	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687712404
10702	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687712404
10703	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687712404
10704	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687712404
10705	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687712404
10706	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687712570
10707	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.677596439169, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712570
10708	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.349577464789, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687712570
10709	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.587307692309, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687712570
10710	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.7499999999995, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712612
10711	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.3600000000006, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687712612
10712	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.570000000002, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687712612
10713	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.7499999999995, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687712651
10714	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "10118.79", "valor_compra": 10580.845927121152, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1687715068
10715	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": "984.95"}	2	1687715068
10716	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.8000000000000003, "valor_bruto": "35593.75", "valor_compra": 32934.780000000006, "investidor_id": 1, "valor_liquido": "32934.78"}	2	1687715068
10717	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.08, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": "1033.09"}	2	1687715068
10718	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": "9008.13"}	2	1687715068
10719	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": "1012.86"}	2	1687715068
10720	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.7299999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": "8385.16"}	2	1687715068
10721	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1687715068
10722	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": "1000"}	2	1687715068
10723	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": "7963.17"}	2	1687715068
10724	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": "2510.82"}	2	1687715068
10725	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.9557966101697, "investidor_id": 1, "valor_liquido": "2904.61"}	2	1687715068
10726	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": "5001.92"}	2	1687715068
10727	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.2303999999995, "investidor_id": 1, "valor_liquido": "3744.79"}	2	1687715068
10728	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": "4066.56"}	2	1687715068
10729	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": "3552.66"}	2	1687715068
10730	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.14144144144, "investidor_id": 1, "valor_liquido": "3485.85"}	2	1687715068
10731	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.1575510204075, "investidor_id": 1, "valor_liquido": "2532.53"}	2	1687715068
10732	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": "141.35823"}	2	1687715068
10733	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1687715068
10734	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1687715068
10735	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1687715068
10736	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1687715068
10737	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1687715068
10738	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1687715068
10739	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1687715068
10740	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.678203181342, "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1687715068
10741	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1687715069
10742	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1687715069
10743	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.378039215686, "investidor_id": 1, "valor_liquido": "7799.52"}	2	1687715069
10744	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.83443139785, "investidor_id": 1, "valor_liquido": "7112.52"}	2	1687715069
10745	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": "1030.80"}	2	1687715069
10746	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.090099999998, "investidor_id": 1, "valor_liquido": "14414.16"}	2	1687715069
10747	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679979999995, "investidor_id": 1, "valor_liquido": "14490.57"}	2	1687715069
10748	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1687715069
10749	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1687715069
10750	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1687715069
10751	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1687715069
10752	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1687715069
10753	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.349577464789, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1687715069
10754	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.587307692309, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1687715069
10755	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.677596439169, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1687715069
10756	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1687715069
10757	app\\models\\financas\\Operacao	insert	{"id": 842, "data": "2023-06-28 11:30:13", "tipo": "2", "valor": 0, "quantidade": "0.02", "itens_ativos_id": "55"}	2	1687962705
10758	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.1, "valor_bruto": "1033.09", "valor_compra": "1033.09", "investidor_id": 2, "valor_liquido": "1033.09"}	2	1687962705
10759	app\\models\\financas\\Operacao	insert	{"id": 843, "data": "2023-06-28 11:30:41", "tipo": "0", "valor": "1500", "quantidade": "0.08", "itens_ativos_id": "47"}	2	1687962811
10760	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.7199999999999998, "valor_bruto": 34093.75, "valor_compra": 31993.786285714283, "investidor_id": 1, "valor_liquido": 31434.78}	2	1687962811
10761	app\\models\\financas\\Operacao	insert	{"id": 844, "data": "2023-06-28 11:35:48", "tipo": "3", "valor": 0, "quantidade": "0.08", "itens_ativos_id": "23"}	2	1687963101
10762	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.65, "valor_bruto": "8385.16", "valor_compra": "8385.16", "investidor_id": 2, "valor_liquido": "8385.16"}	2	1687963101
15784	app\\models\\financas\\Operacao	update	{"id": 742, "data": "2022-11-04 10:50:16", "tipo": 1, "valor": "191.05", "quantidade": "3.05", "preco_medio": 62.64, "itens_ativos_id": 50}	2	1709001028
15785	app\\models\\financas\\Operacao	update	{"id": 800, "data": "2023-03-06 10:00:00", "tipo": 1, "valor": "189.75", "quantidade": "3.08338", "preco_medio": 62.09, "itens_ativos_id": 50}	2	1709001028
15786	app\\models\\financas\\ItensAtivo	update	{"id": 50, "ativo": true, "ativo_id": 55, "quantidade": 6.13338, "valor_bruto": "384.5015922", "valor_compra": 380.8, "investidor_id": 2, "valor_liquido": "384.5015922"}	2	1709001028
15787	app\\models\\financas\\Operacao	update	{"id": 31, "data": "2019-08-02 00:00:00", "tipo": 1, "valor": "513.24", "quantidade": "13", "preco_medio": 39.48, "itens_ativos_id": 8}	2	1709001028
15788	app\\models\\financas\\Operacao	update	{"id": 72, "data": "2019-08-16 00:00:00", "tipo": 1, "valor": "297.36", "quantidade": "8", "preco_medio": 38.6, "itens_ativos_id": 8}	2	1709001028
15789	app\\models\\financas\\Operacao	update	{"id": 83, "data": "2019-09-03 00:00:00", "tipo": 1, "valor": "321.12", "quantidade": "9", "preco_medio": 37.72, "itens_ativos_id": 8}	2	1709001028
15790	app\\models\\financas\\Operacao	update	{"id": 89, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "74.1", "quantidade": "2", "preco_medio": 37.68, "itens_ativos_id": 8}	2	1709001028
15791	app\\models\\financas\\Operacao	update	{"id": 105, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "209.64", "quantidade": "6", "preco_medio": 37.25, "itens_ativos_id": 8}	2	1709001028
15792	app\\models\\financas\\Operacao	update	{"id": 134, "data": "2019-12-05 10:02:24", "tipo": 1, "valor": "367.18", "quantidade": "11", "preco_medio": 36.38, "itens_ativos_id": 8}	2	1709001028
15793	app\\models\\financas\\Operacao	update	{"id": 275, "data": "2020-04-02 10:35:55", "tipo": 1, "valor": "138.2", "quantidade": "5", "preco_medio": 35.57, "itens_ativos_id": 8}	2	1709001028
15794	app\\models\\financas\\Operacao	update	{"id": 316, "data": "2020-09-02 13:00:00", "tipo": 1, "valor": "147.96", "quantidade": "4", "preco_medio": 35.67, "itens_ativos_id": 8}	2	1709001028
15795	app\\models\\financas\\Operacao	update	{"id": 366, "data": "2021-01-05 11:04:51", "tipo": 1, "valor": "132.12", "quantidade": "4", "preco_medio": 35.5, "itens_ativos_id": 8}	2	1709001029
15796	app\\models\\financas\\Operacao	update	{"id": 379, "data": "2021-01-28 13:54:59", "tipo": 1, "valor": "999.04", "quantidade": "32", "preco_medio": 34.04, "itens_ativos_id": 8}	2	1709001029
15797	app\\models\\financas\\Operacao	update	{"id": 491, "data": "2021-03-18 11:24:09", "tipo": 1, "valor": "123.28", "quantidade": "4", "preco_medio": 33.91, "itens_ativos_id": 8}	2	1709001029
15798	app\\models\\financas\\Operacao	update	{"id": 496, "data": "2021-03-22 12:39:04", "tipo": 1, "valor": "31.68", "quantidade": "1", "preco_medio": 33.89, "itens_ativos_id": 8}	2	1709001029
15799	app\\models\\financas\\Operacao	update	{"id": 502, "data": "2021-03-25 13:44:51", "tipo": 1, "valor": "92.1", "quantidade": "3", "preco_medio": 33.79, "itens_ativos_id": 8}	2	1709001029
15800	app\\models\\financas\\Operacao	update	{"id": 508, "data": "2021-03-29 10:05:22", "tipo": 1, "valor": "122", "quantidade": "4", "preco_medio": 33.67, "itens_ativos_id": 8}	2	1709001029
15801	app\\models\\financas\\Operacao	update	{"id": 515, "data": "2021-04-01 10:34:14", "tipo": 1, "valor": "28.87", "quantidade": "1", "preco_medio": 33.63, "itens_ativos_id": 8}	2	1709001029
15802	app\\models\\financas\\Operacao	update	{"id": 525, "data": "2021-04-08 11:01:55", "tipo": 1, "valor": "1000.65", "quantidade": "35", "preco_medio": 32.38, "itens_ativos_id": 8}	2	1709001029
15803	app\\models\\financas\\Operacao	update	{"id": 729, "data": "2022-10-04 13:54:23", "tipo": 0, "valor": "963.7", "quantidade": "23", "preco_medio": 32.38, "itens_ativos_id": 8}	2	1709001029
15804	app\\models\\financas\\Operacao	update	{"id": 747, "data": "2022-11-09 14:16:46", "tipo": 0, "valor": "976.12", "quantidade": "23", "preco_medio": 32.38, "itens_ativos_id": 8}	2	1709001029
15805	app\\models\\financas\\Operacao	update	{"id": 785, "data": "2023-02-13 13:40:02", "tipo": 0, "valor": "1020", "quantidade": "30", "preco_medio": 32.38, "itens_ativos_id": 8}	2	1709001029
15806	app\\models\\financas\\Operacao	update	{"id": 818, "data": "2023-06-21 17:05:07", "tipo": 3, "valor": 0, "quantidade": "7", "preco_medio": 36.23, "itens_ativos_id": 8}	2	1709001029
15807	app\\models\\financas\\ItensAtivo	update	{"id": 8, "ativo": true, "ativo_id": 24, "quantidade": 59, "valor_bruto": "1875.72", "valor_compra": 2137.6600000000003, "investidor_id": 1, "valor_liquido": "1875.72"}	2	1709001029
15808	app\\models\\financas\\Operacao	update	{"id": 459, "data": "2021-02-24 14:10:48", "tipo": 1, "valor": "969.44", "quantidade": "8", "preco_medio": 121.18, "itens_ativos_id": 11}	2	1709001029
15809	app\\models\\financas\\Operacao	update	{"id": 479, "data": "2021-03-12 10:57:40", "tipo": 1, "valor": "115.89", "quantidade": "1", "preco_medio": 120.59, "itens_ativos_id": 11}	2	1709001029
15810	app\\models\\financas\\Operacao	update	{"id": 488, "data": "2021-03-17 13:26:11", "tipo": 1, "valor": "907.2", "quantidade": "8", "preco_medio": 117.21, "itens_ativos_id": 11}	2	1709001029
15811	app\\models\\financas\\Operacao	update	{"id": 494, "data": "2021-03-19 11:50:00", "tipo": 1, "valor": "907.12", "quantidade": "8", "preco_medio": 115.99, "itens_ativos_id": 11}	2	1709001029
15812	app\\models\\financas\\Operacao	update	{"id": 503, "data": "2021-03-25 13:43:03", "tipo": 1, "valor": "904.64", "quantidade": "8", "preco_medio": 115.28, "itens_ativos_id": 11}	2	1709001029
15813	app\\models\\financas\\Operacao	update	{"id": 511, "data": "2021-03-30 10:43:46", "tipo": 1, "valor": "919.99", "quantidade": "8", "preco_medio": 115.23, "itens_ativos_id": 11}	2	1709001029
15814	app\\models\\financas\\Operacao	update	{"id": 532, "data": "2021-04-12 13:11:23", "tipo": 1, "valor": "928.48", "quantidade": "8", "preco_medio": 115.36, "itens_ativos_id": 11}	2	1709001029
15815	app\\models\\financas\\Operacao	update	{"id": 551, "data": "2021-04-22 11:04:20", "tipo": 1, "valor": "918.4", "quantidade": "8", "preco_medio": 115.28, "itens_ativos_id": 11}	2	1709001029
15816	app\\models\\financas\\Operacao	update	{"id": 568, "data": "2021-04-29 16:15:40", "tipo": 1, "valor": "919.12", "quantidade": "8", "preco_medio": 115.24, "itens_ativos_id": 11}	2	1709001029
15817	app\\models\\financas\\Operacao	update	{"id": 570, "data": "2021-04-30 12:08:36", "tipo": 1, "valor": "115.38", "quantidade": "1", "preco_medio": 115.24, "itens_ativos_id": 11}	2	1709001029
15818	app\\models\\financas\\Operacao	update	{"id": 584, "data": "2021-05-05 14:06:53", "tipo": 1, "valor": "918.97", "quantidade": "8", "preco_medio": 115.2, "itens_ativos_id": 11}	2	1709001029
15819	app\\models\\financas\\Operacao	update	{"id": 626, "data": "2021-10-15 10:18:05", "tipo": 1, "valor": "512.7", "quantidade": "5", "preco_medio": 114.4, "itens_ativos_id": 11}	2	1709001029
15820	app\\models\\financas\\Operacao	update	{"id": 628, "data": "2021-11-04 13:05:18", "tipo": 1, "valor": "958", "quantidade": "10", "preco_medio": 112.31, "itens_ativos_id": 11}	2	1709001029
15821	app\\models\\financas\\Operacao	update	{"id": 633, "data": "2021-11-16 14:02:00", "tipo": 1, "valor": "179.64", "quantidade": "2", "preco_medio": 111.81, "itens_ativos_id": 11}	2	1709001029
15822	app\\models\\financas\\Operacao	update	{"id": 805, "data": "2021-11-29 10:50:00", "tipo": 1, "valor": "177.36", "quantidade": "2", "preco_medio": 111.32, "itens_ativos_id": 11}	2	1709001029
15823	app\\models\\financas\\Operacao	update	{"id": 635, "data": "2021-12-06 12:10:00", "tipo": 1, "valor": "919", "quantidade": "10", "preco_medio": 109.43, "itens_ativos_id": 11}	2	1709001029
15824	app\\models\\financas\\Operacao	update	{"id": 675, "data": "2022-04-14 15:27:11", "tipo": 1, "valor": "97.91", "quantidade": "1", "preco_medio": 109.32, "itens_ativos_id": 11}	2	1709001029
15825	app\\models\\financas\\Operacao	update	{"id": 697, "data": "2022-06-17 10:23:53", "tipo": 0, "valor": "4265.55", "quantidade": "45", "preco_medio": 109.32, "itens_ativos_id": 11}	2	1709001029
15826	app\\models\\financas\\Operacao	update	{"id": 710, "data": "2022-07-26 11:06:44", "tipo": 1, "valor": "95.27", "quantidade": "1", "preco_medio": 109.09, "itens_ativos_id": 11}	2	1709001029
15827	app\\models\\financas\\Operacao	update	{"id": 757, "data": "2022-12-15 13:50:02", "tipo": 1, "valor": "192.16", "quantidade": "2", "preco_medio": 108.67, "itens_ativos_id": 11}	2	1709001029
15828	app\\models\\financas\\Operacao	update	{"id": 766, "data": "2023-01-17 14:01:55", "tipo": 1, "valor": "93.17", "quantidade": "1", "preco_medio": 108.42, "itens_ativos_id": 11}	2	1709001029
14630	app\\models\\financas\\Operacao	update	{"id": 331, "data": "2020-09-02 14:35:00", "tipo": "1", "valor": "20604.98", "quantidade": "100", "preco_medio": null, "itens_ativos_id": "40"}	2	1709000515
14631	app\\models\\financas\\Operacao	update	{"id": 331, "data": "2020-09-02 14:35:00", "tipo": 1, "valor": "20604.98", "quantidade": "100", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14632	app\\models\\financas\\Operacao	update	{"id": 375, "data": "2021-01-26 14:00:00", "tipo": 1, "valor": "10000", "quantidade": "100", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14633	app\\models\\financas\\Operacao	update	{"id": 549, "data": "2021-04-22 08:25:00", "tipo": 1, "valor": "15000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14634	app\\models\\financas\\Operacao	update	{"id": 576, "data": "2021-05-03 11:30:00", "tipo": 1, "valor": "1000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14635	app\\models\\financas\\Operacao	update	{"id": 588, "data": "2021-05-26 21:00:00", "tipo": 1, "valor": "3000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14636	app\\models\\financas\\Operacao	update	{"id": 662, "data": "2022-01-04 09:25:26", "tipo": 1, "valor": "7000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14637	app\\models\\financas\\Operacao	update	{"id": 684, "data": "2022-05-27 17:20:09", "tipo": 1, "valor": "1100", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14638	app\\models\\financas\\Operacao	update	{"id": 730, "data": "2022-10-07 14:35:21", "tipo": 1, "valor": "200", "quantidade": "0.001", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14639	app\\models\\financas\\Operacao	update	{"id": 737, "data": "2022-10-21 08:25:29", "tipo": 1, "valor": "6597", "quantidade": "0.1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14640	app\\models\\financas\\Operacao	update	{"id": 773, "data": "2023-02-02 09:25:20", "tipo": 1, "valor": "598", "quantidade": "0.1", "preco_medio": null, "itens_ativos_id": 40}	2	1709000515
14641	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1709000515
15829	app\\models\\financas\\Operacao	update	{"id": 781, "data": "2023-02-13 13:42:34", "tipo": 1, "valor": "1089.84", "quantidade": "12", "preco_medio": 105.6, "itens_ativos_id": 11}	2	1709001029
15830	app\\models\\financas\\Operacao	update	{"id": 811, "data": "2023-04-24 16:09:46", "tipo": 1, "valor": "486.29", "quantidade": "5", "preco_medio": 105.08, "itens_ativos_id": 11}	2	1709001029
15831	app\\models\\financas\\ItensAtivo	update	{"id": 11, "ativo": true, "ativo_id": 39, "quantidade": 80, "valor_bruto": "9505.53", "valor_compra": 8406.570000000002, "investidor_id": 1, "valor_liquido": "9505.53"}	2	1709001029
15832	app\\models\\financas\\Operacao	update	{"id": 714, "data": "2022-08-15 13:19:32", "tipo": 1, "valor": "47.76", "quantidade": "6", "preco_medio": 7.96, "itens_ativos_id": 48}	2	1709001029
15833	app\\models\\financas\\Operacao	update	{"id": 716, "data": "2022-08-25 14:12:51", "tipo": 1, "valor": "65.36", "quantidade": "8", "preco_medio": 8.08, "itens_ativos_id": 48}	2	1709001029
15834	app\\models\\financas\\Operacao	update	{"id": 718, "data": "2022-08-31 13:17:08", "tipo": 1, "valor": "457.6", "quantidade": "55", "preco_medio": 8.27, "itens_ativos_id": 48}	2	1709001029
15835	app\\models\\financas\\Operacao	update	{"id": 721, "data": "2022-09-15 10:11:51", "tipo": 1, "valor": "16.58", "quantidade": "2", "preco_medio": 8.27, "itens_ativos_id": 48}	2	1709001029
15836	app\\models\\financas\\Operacao	update	{"id": 723, "data": "2022-09-26 14:43:06", "tipo": 1, "valor": "50.22", "quantidade": "6", "preco_medio": 8.28, "itens_ativos_id": 48}	2	1709001029
15837	app\\models\\financas\\Operacao	update	{"id": 725, "data": "2022-10-04 14:00:54", "tipo": 1, "valor": "75.51", "quantidade": "9", "preco_medio": 8.29, "itens_ativos_id": 48}	2	1709001029
15838	app\\models\\financas\\Operacao	update	{"id": 733, "data": "2022-10-14 13:39:40", "tipo": 1, "valor": "69.2", "quantidade": "8", "preco_medio": 8.32, "itens_ativos_id": 48}	2	1709001029
15839	app\\models\\financas\\Operacao	update	{"id": 735, "data": "2022-10-17 14:04:32", "tipo": 1, "valor": "85.9", "quantidade": "10", "preco_medio": 8.35, "itens_ativos_id": 48}	2	1709001029
15840	app\\models\\financas\\Operacao	update	{"id": 743, "data": "2022-11-09 14:19:07", "tipo": 1, "valor": "74.79", "quantidade": "9", "preco_medio": 8.34, "itens_ativos_id": 48}	2	1709001029
15841	app\\models\\financas\\Operacao	update	{"id": 750, "data": "2022-11-28 10:37:33", "tipo": 1, "valor": "113.12", "quantidade": "14", "preco_medio": 8.32, "itens_ativos_id": 48}	2	1709001029
15842	app\\models\\financas\\Operacao	update	{"id": 751, "data": "2022-12-13 15:27:25", "tipo": 1, "valor": "31.64", "quantidade": "4", "preco_medio": 8.3, "itens_ativos_id": 48}	2	1709001029
15843	app\\models\\financas\\Operacao	update	{"id": 756, "data": "2022-12-15 13:50:35", "tipo": 1, "valor": "55.86", "quantidade": "7", "preco_medio": 8.29, "itens_ativos_id": 48}	2	1709001029
15844	app\\models\\financas\\Operacao	update	{"id": 758, "data": "2022-12-29 10:41:00", "tipo": 1, "valor": "81.7", "quantidade": "10", "preco_medio": 8.28, "itens_ativos_id": 48}	2	1709001029
15845	app\\models\\financas\\Operacao	update	{"id": 761, "data": "2023-01-12 14:12:21", "tipo": 1, "valor": "63.84", "quantidade": "8", "preco_medio": 8.26, "itens_ativos_id": 48}	2	1709001029
15846	app\\models\\financas\\Operacao	update	{"id": 764, "data": "2023-01-17 14:03:39", "tipo": 1, "valor": "15.98", "quantidade": "2", "preco_medio": 8.26, "itens_ativos_id": 48}	2	1709001029
15847	app\\models\\financas\\Operacao	update	{"id": 772, "data": "2023-01-25 10:22:09", "tipo": 1, "valor": "56.98", "quantidade": "7", "preco_medio": 8.25, "itens_ativos_id": 48}	2	1709001029
15848	app\\models\\financas\\Operacao	update	{"id": 775, "data": "2023-02-08 11:13:40", "tipo": 1, "valor": "167.79", "quantidade": "21", "preco_medio": 8.22, "itens_ativos_id": 48}	2	1709001029
15849	app\\models\\financas\\Operacao	update	{"id": 780, "data": "2023-02-13 13:44:13", "tipo": 1, "valor": "930.15", "quantidade": "117", "preco_medio": 8.12, "itens_ativos_id": 48}	2	1709001029
15850	app\\models\\financas\\Operacao	update	{"id": 787, "data": "2023-02-22 16:31:29", "tipo": 1, "valor": "16.02", "quantidade": "2", "preco_medio": 8.12, "itens_ativos_id": 48}	2	1709001029
15851	app\\models\\financas\\Operacao	update	{"id": 790, "data": "2023-02-28 17:00:09", "tipo": 1, "valor": "47.82", "quantidade": "6", "preco_medio": 8.12, "itens_ativos_id": 48}	2	1709001029
15852	app\\models\\financas\\Operacao	update	{"id": 796, "data": "2023-03-15 10:19:43", "tipo": 1, "valor": "71.37", "quantidade": "9", "preco_medio": 8.11, "itens_ativos_id": 48}	2	1709001029
15853	app\\models\\financas\\Operacao	update	{"id": 802, "data": "2023-03-28 14:11:59", "tipo": 1, "valor": "55.02", "quantidade": "7", "preco_medio": 8.1, "itens_ativos_id": 48}	2	1709001029
15854	app\\models\\financas\\Operacao	update	{"id": 810, "data": "2023-04-24 16:10:13", "tipo": 1, "valor": "23.37", "quantidade": "3", "preco_medio": 8.1, "itens_ativos_id": 48}	2	1709001029
15855	app\\models\\financas\\Operacao	update	{"id": 812, "data": "2023-04-26 16:22:59", "tipo": 1, "valor": "53.97", "quantidade": "7", "preco_medio": 8.09, "itens_ativos_id": 48}	2	1709001029
15856	app\\models\\financas\\Operacao	update	{"id": 816, "data": "2023-05-23 09:55:35", "tipo": 0, "valor": "200", "quantidade": "20", "preco_medio": 8.09, "itens_ativos_id": 48}	2	1709001029
15857	app\\models\\financas\\Operacao	update	{"id": 817, "data": "2023-06-21 20:05:11", "tipo": 2, "valor": 0, "quantidade": "7", "preco_medio": 7.92, "itens_ativos_id": 48}	2	1709001029
15858	app\\models\\financas\\ItensAtivo	update	{"id": 48, "ativo": true, "ativo_id": 53, "quantidade": 324, "valor_bruto": "2472.60", "valor_compra": 2565.7499999999995, "investidor_id": 1, "valor_liquido": "2472.60"}	2	1709001029
15859	app\\models\\financas\\Operacao	update	{"id": 769, "data": "2023-01-17 14:25:54", "tipo": 1, "valor": "1300", "quantidade": "19.40347", "preco_medio": 67, "itens_ativos_id": 52}	2	1709001029
15860	app\\models\\financas\\Operacao	update	{"id": 778, "data": "2023-02-08 11:35:17", "tipo": 1, "valor": "612.68", "quantidade": "9.12424", "preco_medio": 67.05, "itens_ativos_id": 52}	2	1709001029
15861	app\\models\\financas\\ItensAtivo	update	{"id": 52, "ativo": true, "ativo_id": 55, "quantidade": 28.52771, "valor_bruto": "1788.4021399", "valor_compra": 1912.6799999999998, "investidor_id": 1, "valor_liquido": "1788.4021399"}	2	1709001029
15862	app\\models\\financas\\Operacao	update	{"id": 629, "data": "2021-11-05 14:25:00", "tipo": 1, "valor": "1053.18", "quantidade": "11", "preco_medio": 95.74, "itens_ativos_id": 14}	2	1709001029
15863	app\\models\\financas\\Operacao	update	{"id": 836, "data": "2023-06-25 12:10:56", "tipo": 1, "valor": "10000", "quantidade": "100", "preco_medio": 99.58, "itens_ativos_id": 14}	2	1709001029
15864	app\\models\\financas\\Operacao	update	{"id": 837, "data": "2023-06-25 12:15:43", "tipo": 0, "valor": "1100", "quantidade": "10", "preco_medio": 99.58, "itens_ativos_id": 14}	2	1709001029
15865	app\\models\\financas\\Operacao	update	{"id": 838, "data": "2023-06-25 12:20:06", "tipo": 2, "valor": 0, "quantidade": "100", "preco_medio": 50.04, "itens_ativos_id": 14}	2	1709001029
15866	app\\models\\financas\\Operacao	update	{"id": 839, "data": "2023-06-25 12:25:28", "tipo": 0, "valor": "1500", "quantidade": "15", "preco_medio": 50.04, "itens_ativos_id": 14}	2	1709001029
15867	app\\models\\financas\\Operacao	update	{"id": 840, "data": "2023-06-25 12:30:56", "tipo": 3, "valor": 0, "quantidade": "100", "preco_medio": 108.22, "itens_ativos_id": 14}	2	1709001029
15868	app\\models\\financas\\Operacao	update	{"id": 841, "data": "2023-06-25 12:35:33", "tipo": 1, "valor": "1274", "quantidade": "13", "preco_medio": 106.88, "itens_ativos_id": 14}	2	1709001029
15869	app\\models\\financas\\ItensAtivo	update	{"id": 14, "ativo": true, "ativo_id": 39, "quantidade": 99, "valor_bruto": "10118.79", "valor_compra": 10580.78, "investidor_id": 2, "valor_liquido": "10118.79"}	2	1709001029
15870	app\\models\\financas\\Operacao	update	{"id": 415, "data": "2021-02-18 12:05:00", "tipo": 1, "valor": "984.95", "quantidade": "0.33", "preco_medio": 2984.7, "itens_ativos_id": 22}	2	1709001029
15871	app\\models\\financas\\ItensAtivo	update	{"id": 22, "ativo": true, "ativo_id": 36, "quantidade": 0.33, "valor_bruto": "1068.21", "valor_compra": 984.95, "investidor_id": 1, "valor_liquido": "984.95"}	2	1709001029
15872	app\\models\\financas\\Operacao	update	{"id": 774, "data": "2023-02-02 09:30:54", "tipo": 1, "valor": "6952.45", "quantidade": "0.55", "preco_medio": 12640.82, "itens_ativos_id": 53}	2	1709001029
15873	app\\models\\financas\\Operacao	update	{"id": 793, "data": "2023-03-06 13:25:24", "tipo": 1, "valor": "1022.59", "quantidade": "0.08", "preco_medio": 12658.79, "itens_ativos_id": 53}	2	1709001029
15874	app\\models\\financas\\Operacao	update	{"id": 803, "data": "2023-04-04 13:50:20", "tipo": 1, "valor": "1033.09", "quantidade": "0.08", "preco_medio": 12687.51, "itens_ativos_id": 53}	2	1709001029
15875	app\\models\\financas\\ItensAtivo	update	{"id": 53, "ativo": true, "ativo_id": 57, "quantidade": 0.71, "valor_bruto": "7992.3", "valor_compra": 9008.13, "investidor_id": 1, "valor_liquido": "9008.13"}	2	1709001029
15876	app\\models\\financas\\Operacao	update	{"id": 776, "data": "2023-02-02 11:20:02", "tipo": 1, "valor": "1012.86", "quantidade": "0.08", "preco_medio": 12660.75, "itens_ativos_id": 54}	2	1709001029
15877	app\\models\\financas\\ItensAtivo	update	{"id": 54, "ativo": true, "ativo_id": 52, "quantidade": 0.08, "valor_bruto": "1012.86", "valor_compra": 1012.86, "investidor_id": 2, "valor_liquido": "1012.86"}	2	1709001029
15878	app\\models\\financas\\Operacao	update	{"id": 19, "data": "2019-06-06 00:00:00", "tipo": 1, "valor": "1000", "quantidade": "1", "preco_medio": 1000, "itens_ativos_id": 20}	2	1709001029
15879	app\\models\\financas\\ItensAtivo	update	{"id": 20, "ativo": true, "ativo_id": 11, "quantidade": 1, "valor_bruto": "1372.36", "valor_compra": 1000, "investidor_id": 1, "valor_liquido": "1000"}	2	1709001029
15880	app\\models\\financas\\Operacao	update	{"id": 10, "data": "2019-06-20 00:00:00", "tipo": 1, "valor": "7399.46", "quantidade": "3.35", "preco_medio": 2208.79, "itens_ativos_id": 21}	2	1709001029
15881	app\\models\\financas\\Operacao	update	{"id": 230, "data": "2019-08-13 10:25:00", "tipo": 1, "valor": "56.32", "quantidade": "0.02", "preco_medio": 2212.4, "itens_ativos_id": 21}	2	1709001029
15882	app\\models\\financas\\Operacao	update	{"id": 229, "data": "2020-02-04 10:15:00", "tipo": 1, "valor": "507.39", "quantidade": "0.17", "preco_medio": 2249.48, "itens_ativos_id": 21}	2	1709001029
15883	app\\models\\financas\\ItensAtivo	update	{"id": 21, "ativo": true, "ativo_id": 3, "quantidade": 3.54, "valor_bruto": "12899.76", "valor_compra": 7963.17, "investidor_id": 1, "valor_liquido": "7963.17"}	2	1709001029
15884	app\\models\\financas\\Operacao	update	{"id": 25, "data": "2019-07-24 00:00:00", "tipo": 1, "valor": "928.98", "quantidade": "39", "preco_medio": 23.82, "itens_ativos_id": 25}	2	1709001029
15885	app\\models\\financas\\Operacao	update	{"id": 81, "data": "2019-09-03 00:00:00", "tipo": 1, "valor": "120.3", "quantidade": "5", "preco_medio": 23.85, "itens_ativos_id": 25}	2	1709001029
15886	app\\models\\financas\\Operacao	update	{"id": 92, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "141.42", "quantidade": "6", "preco_medio": 23.81, "itens_ativos_id": 25}	2	1709001029
15887	app\\models\\financas\\Operacao	update	{"id": 98, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "25.27", "quantidade": "1", "preco_medio": 23.84, "itens_ativos_id": 25}	2	1709001029
15888	app\\models\\financas\\Operacao	update	{"id": 113, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "206.08", "quantidade": "8", "preco_medio": 24.1, "itens_ativos_id": 25}	2	1709001029
15889	app\\models\\financas\\Operacao	update	{"id": 278, "data": "2020-04-02 10:34:36", "tipo": 1, "valor": "444.4", "quantidade": "22", "preco_medio": 23.04, "itens_ativos_id": 25}	2	1709001029
15890	app\\models\\financas\\Operacao	update	{"id": 292, "data": "2020-05-05 11:27:19", "tipo": 1, "valor": "44.26", "quantidade": "2", "preco_medio": 23.02, "itens_ativos_id": 25}	2	1709001029
15891	app\\models\\financas\\Operacao	update	{"id": 307, "data": "2020-07-02 11:55:59", "tipo": 1, "valor": "24.86", "quantidade": "1", "preco_medio": 23.04, "itens_ativos_id": 25}	2	1709001029
15892	app\\models\\financas\\Operacao	update	{"id": 312, "data": "2020-07-30 12:55:00", "tipo": 1, "valor": "425.34", "quantidade": "17", "preco_medio": 23.38, "itens_ativos_id": 25}	2	1709001029
15893	app\\models\\financas\\Operacao	update	{"id": 413, "data": "2021-02-18 11:52:14", "tipo": 1, "valor": "973.35", "quantidade": "35", "preco_medio": 24.52, "itens_ativos_id": 25}	2	1709001029
15894	app\\models\\financas\\Operacao	update	{"id": 547, "data": "2021-04-20 14:19:31", "tipo": 1, "valor": "994.92", "quantidade": "37", "preco_medio": 25.02, "itens_ativos_id": 25}	2	1709001029
15895	app\\models\\financas\\Operacao	update	{"id": 625, "data": "2021-10-15 10:18:26", "tipo": 1, "valor": "21.35", "quantidade": "1", "preco_medio": 25, "itens_ativos_id": 25}	2	1709001029
15896	app\\models\\financas\\ItensAtivo	update	{"id": 25, "ativo": true, "ativo_id": 20, "quantidade": 174, "valor_bruto": "2510.82", "valor_compra": 4350.53, "investidor_id": 1, "valor_liquido": "2510.82"}	2	1709001029
15897	app\\models\\financas\\Operacao	update	{"id": 24, "data": "2019-07-24 00:00:00", "tipo": 1, "valor": "991.58", "quantidade": "43", "preco_medio": 23.06, "itens_ativos_id": 27}	2	1709001029
15898	app\\models\\financas\\Operacao	update	{"id": 79, "data": "2019-09-03 00:00:00", "tipo": 1, "valor": "91.28", "quantidade": "4", "preco_medio": 23.04, "itens_ativos_id": 27}	2	1709001029
15899	app\\models\\financas\\Operacao	update	{"id": 90, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "115.85", "quantidade": "5", "preco_medio": 23.05, "itens_ativos_id": 27}	2	1709001029
15900	app\\models\\financas\\Operacao	update	{"id": 103, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "72.42", "quantidade": "3", "preco_medio": 23.11, "itens_ativos_id": 27}	2	1709001029
15901	app\\models\\financas\\Operacao	update	{"id": 110, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "78.63", "quantidade": "3", "preco_medio": 23.27, "itens_ativos_id": 27}	2	1709001029
15902	app\\models\\financas\\Operacao	update	{"id": 232, "data": "2020-02-04 12:55:24", "tipo": 1, "valor": "41.29", "quantidade": "1", "preco_medio": 23.58, "itens_ativos_id": 27}	2	1709001029
15903	app\\models\\financas\\Operacao	update	{"id": 320, "data": "2020-11-12 13:05:00", "tipo": 0, "valor": "1055.34", "quantidade": "13", "preco_medio": 23.58, "itens_ativos_id": 27}	2	1709001029
15904	app\\models\\financas\\Operacao	update	{"id": 452, "data": "2021-02-22 12:40:46", "tipo": 1, "valor": "82.49", "quantidade": "1", "preco_medio": 24.83, "itens_ativos_id": 27}	2	1709001029
15905	app\\models\\financas\\Operacao	update	{"id": 529, "data": "2021-04-09 11:08:18", "tipo": 1, "valor": "970.84", "quantidade": "13", "preco_medio": 35.63, "itens_ativos_id": 27}	2	1709001029
15906	app\\models\\financas\\Operacao	update	{"id": 577, "data": "2021-04-28 11:35:00", "tipo": 2, "valor": 0, "quantidade": "60", "preco_medio": 17.82, "itens_ativos_id": 27}	2	1709001029
15907	app\\models\\financas\\Operacao	update	{"id": 575, "data": "2021-05-03 11:24:34", "tipo": 1, "valor": "1012.39", "quantidade": "29", "preco_medio": 21.14, "itens_ativos_id": 27}	2	1709001029
15908	app\\models\\financas\\Operacao	update	{"id": 614, "data": "2021-09-16 13:39:05", "tipo": 1, "valor": "39.78", "quantidade": "1", "preco_medio": 21.27, "itens_ativos_id": 27}	2	1709001029
15909	app\\models\\financas\\Operacao	update	{"id": 728, "data": "2022-10-04 13:56:16", "tipo": 0, "valor": "959.61", "quantidade": "29", "preco_medio": 21.27, "itens_ativos_id": 27}	2	1709001029
15910	app\\models\\financas\\Operacao	update	{"id": 746, "data": "2022-11-09 14:17:42", "tipo": 0, "valor": "989.24", "quantidade": "24", "preco_medio": 21.27, "itens_ativos_id": 27}	2	1709001029
15911	app\\models\\financas\\Operacao	update	{"id": 783, "data": "2023-02-13 13:41:36", "tipo": 0, "valor": "1007.24", "quantidade": "26", "preco_medio": 21.27, "itens_ativos_id": 27}	2	1709001029
15912	app\\models\\financas\\ItensAtivo	update	{"id": 27, "ativo": true, "ativo_id": 21, "quantidade": 71, "valor_bruto": "2904.61", "valor_compra": 1509.6800000000003, "investidor_id": 1, "valor_liquido": "2904.61"}	2	1709001029
15913	app\\models\\financas\\Operacao	update	{"id": 30, "data": "2019-07-25 00:00:00", "tipo": 1, "valor": "201.5", "quantidade": "26", "preco_medio": 7.75, "itens_ativos_id": 31}	2	1709001029
15914	app\\models\\financas\\Operacao	update	{"id": 32, "data": "2019-08-02 00:00:00", "tipo": 1, "valor": "435", "quantidade": "58", "preco_medio": 7.58, "itens_ativos_id": 31}	2	1709001029
15915	app\\models\\financas\\Operacao	update	{"id": 73, "data": "2019-08-16 00:00:00", "tipo": 1, "valor": "7.3", "quantidade": "1", "preco_medio": 7.57, "itens_ativos_id": 31}	2	1709001029
15916	app\\models\\financas\\Operacao	update	{"id": 76, "data": "2019-08-26 00:00:00", "tipo": 1, "valor": "36.95", "quantidade": "5", "preco_medio": 7.56, "itens_ativos_id": 31}	2	1709001029
15917	app\\models\\financas\\Operacao	update	{"id": 84, "data": "2019-09-03 00:00:00", "tipo": 1, "valor": "380.24", "quantidade": "49", "preco_medio": 7.63, "itens_ativos_id": 31}	2	1709001029
15918	app\\models\\financas\\Operacao	update	{"id": 77, "data": "2019-09-03 00:00:01", "tipo": 1, "valor": "7.81", "quantidade": "1", "preco_medio": 7.63, "itens_ativos_id": 31}	2	1709001029
15919	app\\models\\financas\\Operacao	update	{"id": 88, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "64", "quantidade": "8", "preco_medio": 7.65, "itens_ativos_id": 31}	2	1709001029
15920	app\\models\\financas\\Operacao	update	{"id": 95, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "8.48", "quantidade": "1", "preco_medio": 7.66, "itens_ativos_id": 31}	2	1709001029
15921	app\\models\\financas\\Operacao	update	{"id": 101, "data": "2019-10-02 00:00:01", "tipo": 1, "valor": "59.36", "quantidade": "7", "preco_medio": 7.7, "itens_ativos_id": 31}	2	1709001029
15922	app\\models\\financas\\Operacao	update	{"id": 131, "data": "2019-12-05 10:05:34", "tipo": 1, "valor": "56.05", "quantidade": "5", "preco_medio": 7.81, "itens_ativos_id": 31}	2	1709001029
15923	app\\models\\financas\\Operacao	update	{"id": 129, "data": "2019-12-05 10:09:23", "tipo": 1, "valor": "11.32", "quantidade": "1", "preco_medio": 7.83, "itens_ativos_id": 31}	2	1709001029
15924	app\\models\\financas\\Operacao	update	{"id": 239, "data": "2020-03-03 13:47:13", "tipo": 1, "valor": "140.42", "quantidade": "14", "preco_medio": 8, "itens_ativos_id": 31}	2	1709001029
15925	app\\models\\financas\\Operacao	update	{"id": 277, "data": "2020-04-02 10:35:12", "tipo": 1, "valor": "231.04", "quantidade": "32", "preco_medio": 7.88, "itens_ativos_id": 31}	2	1709001029
15926	app\\models\\financas\\Operacao	update	{"id": 295, "data": "2020-05-05 11:25:32", "tipo": 1, "valor": "193.32", "quantidade": "27", "preco_medio": 7.8, "itens_ativos_id": 31}	2	1709001029
15927	app\\models\\financas\\Operacao	update	{"id": 306, "data": "2020-07-02 12:12:19", "tipo": 1, "valor": "424.05", "quantidade": "55", "preco_medio": 7.78, "itens_ativos_id": 31}	2	1709001029
15928	app\\models\\financas\\Operacao	update	{"id": 318, "data": "2020-10-07 13:05:00", "tipo": 1, "valor": "7.84", "quantidade": "1", "preco_medio": 7.78, "itens_ativos_id": 31}	2	1709001029
15929	app\\models\\financas\\Operacao	update	{"id": 367, "data": "2021-01-05 11:22:51", "tipo": 1, "valor": "8.12", "quantidade": "1", "preco_medio": 7.78, "itens_ativos_id": 31}	2	1709001029
15930	app\\models\\financas\\Operacao	update	{"id": 382, "data": "2021-02-01 14:35:18", "tipo": 1, "valor": "93.36", "quantidade": "12", "preco_medio": 7.78, "itens_ativos_id": 31}	2	1709001029
15931	app\\models\\financas\\Operacao	update	{"id": 385, "data": "2021-02-02 13:20:31", "tipo": 1, "valor": "15.8", "quantidade": "2", "preco_medio": 7.78, "itens_ativos_id": 31}	2	1709001029
15932	app\\models\\financas\\Operacao	update	{"id": 396, "data": "2021-02-08 16:15:03", "tipo": 1, "valor": "747.45", "quantidade": "99", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15933	app\\models\\financas\\Operacao	update	{"id": 391, "data": "2021-02-08 16:18:59", "tipo": 1, "valor": "7.55", "quantidade": "1", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15934	app\\models\\financas\\Operacao	update	{"id": 450, "data": "2021-02-22 12:41:41", "tipo": 1, "valor": "7.49", "quantidade": "1", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15935	app\\models\\financas\\Operacao	update	{"id": 461, "data": "2021-02-25 14:23:11", "tipo": 1, "valor": "29.56", "quantidade": "4", "preco_medio": 7.72, "itens_ativos_id": 31}	2	1709001029
15936	app\\models\\financas\\Operacao	update	{"id": 490, "data": "2021-03-18 11:24:37", "tipo": 1, "valor": "8.11", "quantidade": "1", "preco_medio": 7.72, "itens_ativos_id": 31}	2	1709001029
15937	app\\models\\financas\\Operacao	update	{"id": 507, "data": "2021-03-29 10:06:07", "tipo": 1, "valor": "23.4", "quantidade": "3", "preco_medio": 7.72, "itens_ativos_id": 31}	2	1709001029
15938	app\\models\\financas\\Operacao	update	{"id": 512, "data": "2021-03-31 11:00:58", "tipo": 1, "valor": "55.23", "quantidade": "7", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15939	app\\models\\financas\\Operacao	update	{"id": 514, "data": "2021-04-01 10:34:33", "tipo": 1, "valor": "8", "quantidade": "1", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15940	app\\models\\financas\\Operacao	update	{"id": 519, "data": "2021-04-06 10:49:55", "tipo": 1, "valor": "8.1", "quantidade": "1", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15941	app\\models\\financas\\Operacao	update	{"id": 521, "data": "2021-04-07 14:38:42", "tipo": 1, "valor": "8.33", "quantidade": "1", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15942	app\\models\\financas\\Operacao	update	{"id": 524, "data": "2021-04-08 11:02:27", "tipo": 1, "valor": "25.14", "quantidade": "3", "preco_medio": 7.73, "itens_ativos_id": 31}	2	1709001029
15943	app\\models\\financas\\Operacao	update	{"id": 528, "data": "2021-04-09 11:22:59", "tipo": 1, "valor": "33.36", "quantidade": "4", "preco_medio": 7.74, "itens_ativos_id": 31}	2	1709001029
15944	app\\models\\financas\\Operacao	update	{"id": 531, "data": "2021-04-12 13:12:04", "tipo": 1, "valor": "66.8", "quantidade": "8", "preco_medio": 7.75, "itens_ativos_id": 31}	2	1709001029
15945	app\\models\\financas\\Operacao	update	{"id": 533, "data": "2021-04-13 10:59:15", "tipo": 1, "valor": "8.47", "quantidade": "1", "preco_medio": 7.75, "itens_ativos_id": 31}	2	1709001029
15946	app\\models\\financas\\Operacao	update	{"id": 537, "data": "2021-04-15 10:29:29", "tipo": 1, "valor": "8.66", "quantidade": "1", "preco_medio": 7.75, "itens_ativos_id": 31}	2	1709001029
15947	app\\models\\financas\\Operacao	update	{"id": 540, "data": "2021-04-16 11:33:09", "tipo": 1, "valor": "8.8", "quantidade": "1", "preco_medio": 7.76, "itens_ativos_id": 31}	2	1709001029
15948	app\\models\\financas\\Operacao	update	{"id": 543, "data": "2021-04-19 10:53:41", "tipo": 1, "valor": "26.82", "quantidade": "3", "preco_medio": 7.77, "itens_ativos_id": 31}	2	1709001029
15949	app\\models\\financas\\Operacao	update	{"id": 546, "data": "2021-04-20 14:19:49", "tipo": 1, "valor": "8.94", "quantidade": "1", "preco_medio": 7.77, "itens_ativos_id": 31}	2	1709001029
15950	app\\models\\financas\\Operacao	update	{"id": 550, "data": "2021-04-22 11:04:49", "tipo": 1, "valor": "89.8", "quantidade": "10", "preco_medio": 7.79, "itens_ativos_id": 31}	2	1709001029
15951	app\\models\\financas\\Operacao	update	{"id": 554, "data": "2021-04-23 16:37:00", "tipo": 1, "valor": "137.19", "quantidade": "17", "preco_medio": 7.8, "itens_ativos_id": 31}	2	1709001029
15952	app\\models\\financas\\Operacao	update	{"id": 558, "data": "2021-04-26 12:14:07", "tipo": 1, "valor": "40.4", "quantidade": "5", "preco_medio": 7.81, "itens_ativos_id": 31}	2	1709001029
15953	app\\models\\financas\\Operacao	update	{"id": 561, "data": "2021-04-27 11:24:51", "tipo": 1, "valor": "790", "quantidade": "100", "preco_medio": 7.82, "itens_ativos_id": 31}	2	1709001029
15954	app\\models\\financas\\Operacao	update	{"id": 560, "data": "2021-04-27 11:26:11", "tipo": 1, "valor": "213.3", "quantidade": "27", "preco_medio": 7.83, "itens_ativos_id": 31}	2	1709001029
15955	app\\models\\financas\\Operacao	update	{"id": 569, "data": "2021-04-30 12:08:55", "tipo": 1, "valor": "15.82", "quantidade": "2", "preco_medio": 7.83, "itens_ativos_id": 31}	2	1709001029
15956	app\\models\\financas\\Operacao	update	{"id": 574, "data": "2021-05-03 11:24:51", "tipo": 1, "valor": "16.24", "quantidade": "2", "preco_medio": 7.83, "itens_ativos_id": 31}	2	1709001029
15957	app\\models\\financas\\Operacao	update	{"id": 582, "data": "2021-05-05 14:08:24", "tipo": 1, "valor": "26.4", "quantidade": "3", "preco_medio": 7.83, "itens_ativos_id": 31}	2	1709001029
15958	app\\models\\financas\\Operacao	update	{"id": 622, "data": "2021-07-23 13:55:00", "tipo": 1, "valor": "10.99", "quantidade": "1", "preco_medio": 7.84, "itens_ativos_id": 31}	2	1709001029
15959	app\\models\\financas\\Operacao	update	{"id": 610, "data": "2021-08-27 10:20:41", "tipo": 1, "valor": "10.79", "quantidade": "1", "preco_medio": 7.84, "itens_ativos_id": 31}	2	1709001029
15960	app\\models\\financas\\Operacao	update	{"id": 806, "data": "2022-01-03 00:00:00", "tipo": 1, "valor": "8.11", "quantidade": "1", "preco_medio": 7.84, "itens_ativos_id": 31}	2	1709001029
15961	app\\models\\financas\\ItensAtivo	update	{"id": 31, "ativo": true, "ativo_id": 23, "quantidade": 616, "valor_bruto": "5001.92", "valor_compra": 4831.209999999999, "investidor_id": 1, "valor_liquido": "5001.92"}	2	1709001029
15962	app\\models\\financas\\Operacao	update	{"id": 23, "data": "2019-07-10 00:00:00", "tipo": 1, "valor": "1358", "quantidade": "100", "preco_medio": 13.58, "itens_ativos_id": 26}	2	1709001029
15963	app\\models\\financas\\Operacao	update	{"id": 85, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "12.97", "quantidade": "1", "preco_medio": 13.57, "itens_ativos_id": 26}	2	1709001029
15964	app\\models\\financas\\Operacao	update	{"id": 99, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "38.13", "quantidade": "3", "preco_medio": 13.55, "itens_ativos_id": 26}	2	1709001029
15965	app\\models\\financas\\Operacao	update	{"id": 111, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "83.34", "quantidade": "6", "preco_medio": 13.57, "itens_ativos_id": 26}	2	1709001029
15966	app\\models\\financas\\Operacao	update	{"id": 133, "data": "2019-12-05 10:03:17", "tipo": 1, "valor": "164.28", "quantidade": "12", "preco_medio": 13.58, "itens_ativos_id": 26}	2	1709001029
15967	app\\models\\financas\\Operacao	update	{"id": 240, "data": "2020-03-03 13:46:50", "tipo": 1, "valor": "298.77", "quantidade": "23", "preco_medio": 13.49, "itens_ativos_id": 26}	2	1709001029
15968	app\\models\\financas\\Operacao	update	{"id": 293, "data": "2020-05-05 11:26:14", "tipo": 1, "valor": "21.06", "quantidade": "2", "preco_medio": 13.45, "itens_ativos_id": 26}	2	1709001029
15969	app\\models\\financas\\Operacao	update	{"id": 303, "data": "2020-06-02 10:56:15", "tipo": 1, "valor": "280.02", "quantidade": "26", "preco_medio": 13.04, "itens_ativos_id": 26}	2	1709001029
15970	app\\models\\financas\\Operacao	update	{"id": 308, "data": "2020-07-02 11:54:57", "tipo": 1, "valor": "227.2", "quantidade": "20", "preco_medio": 12.87, "itens_ativos_id": 26}	2	1709001029
15971	app\\models\\financas\\Operacao	update	{"id": 315, "data": "2020-09-02 13:00:00", "tipo": 1, "valor": "385.2", "quantidade": "36", "preco_medio": 12.53, "itens_ativos_id": 26}	2	1709001029
15972	app\\models\\financas\\Operacao	update	{"id": 394, "data": "2021-02-08 16:17:07", "tipo": 1, "valor": "1149.94", "quantidade": "99", "preco_medio": 12.25, "itens_ativos_id": 26}	2	1709001029
15973	app\\models\\financas\\Operacao	update	{"id": 485, "data": "2021-03-16 10:30:47", "tipo": 1, "valor": "11.06", "quantidade": "1", "preco_medio": 12.25, "itens_ativos_id": 26}	2	1709001029
15974	app\\models\\financas\\Operacao	update	{"id": 541, "data": "2021-04-16 11:32:47", "tipo": 1, "valor": "993.6", "quantidade": "90", "preco_medio": 11.99, "itens_ativos_id": 26}	2	1709001029
15975	app\\models\\financas\\Operacao	update	{"id": 553, "data": "2021-04-23 16:37:33", "tipo": 1, "valor": "11.11", "quantidade": "1", "preco_medio": 11.99, "itens_ativos_id": 26}	2	1709001029
15976	app\\models\\financas\\Operacao	update	{"id": 611, "data": "2021-08-27 10:19:55", "tipo": 1, "valor": "57.05", "quantidade": "5", "preco_medio": 11.98, "itens_ativos_id": 26}	2	1709001029
15977	app\\models\\financas\\Operacao	update	{"id": 807, "data": "2022-01-03 00:00:00", "tipo": 1, "valor": "18.5", "quantidade": "2", "preco_medio": 11.97, "itens_ativos_id": 26}	2	1709001029
15978	app\\models\\financas\\ItensAtivo	update	{"id": 26, "ativo": true, "ativo_id": 16, "quantidade": 427, "valor_bruto": "3744.79", "valor_compra": 5110.23, "investidor_id": 1, "valor_liquido": "3744.79"}	2	1709001029
15979	app\\models\\financas\\Operacao	update	{"id": 26, "data": "2019-07-24 00:00:00", "tipo": 1, "valor": "995.5", "quantidade": "55", "preco_medio": 18.1, "itens_ativos_id": 28}	2	1709001029
15980	app\\models\\financas\\Operacao	update	{"id": 91, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "132.58", "quantidade": "7", "preco_medio": 18.19, "itens_ativos_id": 28}	2	1709001029
15981	app\\models\\financas\\Operacao	update	{"id": 96, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "18.93", "quantidade": "1", "preco_medio": 18.21, "itens_ativos_id": 28}	2	1709001029
15982	app\\models\\financas\\Operacao	update	{"id": 104, "data": "2019-10-02 00:00:01", "tipo": 1, "valor": "132.51", "quantidade": "7", "preco_medio": 18.28, "itens_ativos_id": 28}	2	1709001029
15983	app\\models\\financas\\Operacao	update	{"id": 109, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "295.62", "quantidade": "17", "preco_medio": 18.11, "itens_ativos_id": 28}	2	1709001029
15984	app\\models\\financas\\Operacao	update	{"id": 242, "data": "2020-03-03 13:45:40", "tipo": 1, "valor": "595.6", "quantidade": "40", "preco_medio": 17.09, "itens_ativos_id": 28}	2	1709001029
15985	app\\models\\financas\\Operacao	update	{"id": 238, "data": "2020-03-03 13:48:26", "tipo": 1, "valor": "14.87", "quantidade": "1", "preco_medio": 17.08, "itens_ativos_id": 28}	2	1709001029
15986	app\\models\\financas\\Operacao	update	{"id": 294, "data": "2020-05-05 11:25:54", "tipo": 1, "valor": "156.26", "quantidade": "13", "preco_medio": 16.61, "itens_ativos_id": 28}	2	1709001029
15987	app\\models\\financas\\Operacao	update	{"id": 291, "data": "2020-05-05 11:27:56", "tipo": 1, "valor": "12.01", "quantidade": "1", "preco_medio": 16.58, "itens_ativos_id": 28}	2	1709001029
15988	app\\models\\financas\\Operacao	update	{"id": 311, "data": "2020-07-30 12:50:00", "tipo": 1, "valor": "94.14", "quantidade": "6", "preco_medio": 16.54, "itens_ativos_id": 28}	2	1709001029
15989	app\\models\\financas\\Operacao	update	{"id": 314, "data": "2020-09-02 12:55:00", "tipo": 1, "valor": "493.62", "quantidade": "39", "preco_medio": 15.73, "itens_ativos_id": 28}	2	1709001029
15990	app\\models\\financas\\Operacao	update	{"id": 369, "data": "2021-01-12 12:28:20", "tipo": 1, "valor": "16.53", "quantidade": "1", "preco_medio": 15.73, "itens_ativos_id": 28}	2	1709001029
15991	app\\models\\financas\\Operacao	update	{"id": 392, "data": "2021-02-08 16:18:23", "tipo": 1, "valor": "209.3", "quantidade": "14", "preco_medio": 15.68, "itens_ativos_id": 28}	2	1709001029
15992	app\\models\\financas\\Operacao	update	{"id": 483, "data": "2021-03-16 10:28:26", "tipo": 1, "valor": "75.95", "quantidade": "5", "preco_medio": 15.67, "itens_ativos_id": 28}	2	1709001029
15993	app\\models\\financas\\Operacao	update	{"id": 500, "data": "2021-03-24 10:21:43", "tipo": 1, "valor": "135.54", "quantidade": "9", "preco_medio": 15.64, "itens_ativos_id": 28}	2	1709001029
15994	app\\models\\financas\\Operacao	update	{"id": 504, "data": "2021-03-25 13:46:27", "tipo": 1, "valor": "14.97", "quantidade": "1", "preco_medio": 15.64, "itens_ativos_id": 28}	2	1709001029
15995	app\\models\\financas\\Operacao	update	{"id": 505, "data": "2021-03-26 11:28:00", "tipo": 1, "valor": "30.64", "quantidade": "2", "preco_medio": 15.64, "itens_ativos_id": 28}	2	1709001029
15996	app\\models\\financas\\Operacao	update	{"id": 520, "data": "2021-04-06 10:49:22", "tipo": 1, "valor": "1002.54", "quantidade": "66", "preco_medio": 15.53, "itens_ativos_id": 28}	2	1709001029
15997	app\\models\\financas\\Operacao	update	{"id": 613, "data": "2021-09-16 13:40:25", "tipo": 1, "valor": "16.18", "quantidade": "1", "preco_medio": 15.54, "itens_ativos_id": 28}	2	1709001029
15998	app\\models\\financas\\Operacao	update	{"id": 666, "data": "2022-03-29 11:02:14", "tipo": 1, "valor": "30.2", "quantidade": "2", "preco_medio": 15.53, "itens_ativos_id": 28}	2	1709001029
15999	app\\models\\financas\\ItensAtivo	update	{"id": 28, "ativo": true, "ativo_id": 17, "quantidade": 288, "valor_bruto": "4066.56", "valor_compra": 4473.49, "investidor_id": 1, "valor_liquido": "4066.56"}	2	1709001029
16000	app\\models\\financas\\Operacao	update	{"id": 27, "data": "2019-07-24 00:00:00", "tipo": 1, "valor": "1000.08", "quantidade": "24", "preco_medio": 41.67, "itens_ativos_id": 29}	2	1709001029
16001	app\\models\\financas\\Operacao	update	{"id": 97, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "42.96", "quantidade": "1", "preco_medio": 41.72, "itens_ativos_id": 29}	2	1709001029
16002	app\\models\\financas\\Operacao	update	{"id": 107, "data": "2019-10-02 00:00:01", "tipo": 1, "valor": "257.88", "quantidade": "6", "preco_medio": 41.97, "itens_ativos_id": 29}	2	1709001029
16003	app\\models\\financas\\Operacao	update	{"id": 241, "data": "2020-03-03 13:46:22", "tipo": 1, "valor": "347.9", "quantidade": "7", "preco_medio": 43.39, "itens_ativos_id": 29}	2	1709001029
16004	app\\models\\financas\\Operacao	update	{"id": 276, "data": "2020-04-02 10:35:32", "tipo": 1, "valor": "174.6", "quantidade": "5", "preco_medio": 42.41, "itens_ativos_id": 29}	2	1709001029
16005	app\\models\\financas\\Operacao	update	{"id": 393, "data": "2021-02-08 16:17:39", "tipo": 1, "valor": "1244.28", "quantidade": "20", "preco_medio": 48.69, "itens_ativos_id": 29}	2	1709001029
16006	app\\models\\financas\\Operacao	update	{"id": 451, "data": "2021-02-22 12:41:22", "tipo": 1, "valor": "54.35", "quantidade": "1", "preco_medio": 48.78, "itens_ativos_id": 29}	2	1709001029
16007	app\\models\\financas\\Operacao	update	{"id": 535, "data": "2021-04-13 10:58:24", "tipo": 1, "valor": "943.67", "quantidade": "17", "preco_medio": 50.19, "itens_ativos_id": 29}	2	1709001029
16008	app\\models\\financas\\Operacao	update	{"id": 534, "data": "2021-04-13 10:58:37", "tipo": 1, "valor": "55.5", "quantidade": "1", "preco_medio": 50.26, "itens_ativos_id": 29}	2	1709001029
16009	app\\models\\financas\\Operacao	update	{"id": 564, "data": "2021-04-28 10:44:44", "tipo": 1, "valor": "956.7", "quantidade": "18", "preco_medio": 50.78, "itens_ativos_id": 29}	2	1709001029
16010	app\\models\\financas\\Operacao	update	{"id": 579, "data": "2021-05-04 16:43:52", "tipo": 1, "valor": "50.55", "quantidade": "1", "preco_medio": 50.78, "itens_ativos_id": 29}	2	1709001029
16011	app\\models\\financas\\Operacao	update	{"id": 583, "data": "2021-05-05 14:07:28", "tipo": 1, "valor": "51.69", "quantidade": "1", "preco_medio": 50.79, "itens_ativos_id": 29}	2	1709001029
16012	app\\models\\financas\\Operacao	update	{"id": 587, "data": "2021-05-17 08:55:00", "tipo": 2, "valor": 0, "quantidade": "204", "preco_medio": 16.93, "itens_ativos_id": 29}	2	1709001029
16013	app\\models\\financas\\ItensAtivo	update	{"id": 29, "ativo": true, "ativo_id": 18, "quantidade": 306, "valor_bruto": "3552.66", "valor_compra": 5180.159999999999, "investidor_id": 1, "valor_liquido": "3552.66"}	2	1709001029
16014	app\\models\\financas\\Operacao	update	{"id": 28, "data": "2019-07-24 00:00:00", "tipo": 1, "valor": "989.52", "quantidade": "21", "preco_medio": 47.12, "itens_ativos_id": 30}	2	1709001029
16015	app\\models\\financas\\Operacao	update	{"id": 82, "data": "2019-09-03 00:00:00", "tipo": 1, "valor": "133.68", "quantidade": "3", "preco_medio": 46.8, "itens_ativos_id": 30}	2	1709001029
16016	app\\models\\financas\\Operacao	update	{"id": 78, "data": "2019-09-03 00:00:01", "tipo": 1, "valor": "44.5", "quantidade": "1", "preco_medio": 46.71, "itens_ativos_id": 30}	2	1709001029
16017	app\\models\\financas\\Operacao	update	{"id": 106, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "220.05", "quantidade": "5", "preco_medio": 46.26, "itens_ativos_id": 30}	2	1709001029
16018	app\\models\\financas\\Operacao	update	{"id": 112, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "92.32", "quantidade": "2", "preco_medio": 46.25, "itens_ativos_id": 30}	2	1709001029
16019	app\\models\\financas\\Operacao	update	{"id": 132, "data": "2019-12-05 10:04:08", "tipo": 1, "valor": "140.22", "quantidade": "3", "preco_medio": 46.29, "itens_ativos_id": 30}	2	1709001029
16020	app\\models\\financas\\Operacao	update	{"id": 234, "data": "2020-02-04 12:54:17", "tipo": 1, "valor": "53.02", "quantidade": "1", "preco_medio": 46.48, "itens_ativos_id": 30}	2	1709001029
16021	app\\models\\financas\\Operacao	update	{"id": 274, "data": "2020-04-02 10:37:53", "tipo": 1, "valor": "76.48", "quantidade": "2", "preco_medio": 46.05, "itens_ativos_id": 30}	2	1709001029
16022	app\\models\\financas\\Operacao	update	{"id": 296, "data": "2020-05-05 11:25:10", "tipo": 1, "valor": "196.35", "quantidade": "5", "preco_medio": 45.26, "itens_ativos_id": 30}	2	1709001029
16023	app\\models\\financas\\Operacao	update	{"id": 309, "data": "2020-07-02 11:54:35", "tipo": 1, "valor": "344.72", "quantidade": "8", "preco_medio": 44.92, "itens_ativos_id": 30}	2	1709001029
16024	app\\models\\financas\\Operacao	update	{"id": 317, "data": "2020-10-07 13:05:00", "tipo": 1, "valor": "40.29", "quantidade": "1", "preco_medio": 44.83, "itens_ativos_id": 30}	2	1709001029
16025	app\\models\\financas\\Operacao	update	{"id": 386, "data": "2021-02-02 13:19:24", "tipo": 1, "valor": "986.48", "quantidade": "22", "preco_medio": 44.83, "itens_ativos_id": 30}	2	1709001029
16026	app\\models\\financas\\Operacao	update	{"id": 476, "data": "2021-03-10 10:29:13", "tipo": 1, "valor": "39.02", "quantidade": "1", "preco_medio": 44.76, "itens_ativos_id": 30}	2	1709001029
16027	app\\models\\financas\\Operacao	update	{"id": 487, "data": "2021-03-17 13:26:47", "tipo": 1, "valor": "83.64", "quantidade": "2", "preco_medio": 44.68, "itens_ativos_id": 30}	2	1709001029
16028	app\\models\\financas\\Operacao	update	{"id": 510, "data": "2021-03-30 10:44:56", "tipo": 1, "valor": "82.1", "quantidade": "2", "preco_medio": 44.59, "itens_ativos_id": 30}	2	1709001029
16029	app\\models\\financas\\Operacao	update	{"id": 516, "data": "2021-04-01 10:33:48", "tipo": 1, "valor": "125.79", "quantidade": "3", "preco_medio": 44.49, "itens_ativos_id": 30}	2	1709001029
16030	app\\models\\financas\\Operacao	update	{"id": 523, "data": "2021-04-07 14:37:49", "tipo": 1, "valor": "953.58", "quantidade": "23", "preco_medio": 43.83, "itens_ativos_id": 30}	2	1709001029
16031	app\\models\\financas\\Operacao	update	{"id": 522, "data": "2021-04-07 14:38:14", "tipo": 1, "valor": "41.46", "quantidade": "1", "preco_medio": 43.8, "itens_ativos_id": 30}	2	1709001029
16032	app\\models\\financas\\Operacao	update	{"id": 563, "data": "2021-04-28 10:45:05", "tipo": 1, "valor": "41.49", "quantidade": "1", "preco_medio": 43.78, "itens_ativos_id": 30}	2	1709001029
16033	app\\models\\financas\\Operacao	update	{"id": 567, "data": "2021-04-29 16:16:01", "tipo": 1, "valor": "83.36", "quantidade": "2", "preco_medio": 43.74, "itens_ativos_id": 30}	2	1709001029
16034	app\\models\\financas\\Operacao	update	{"id": 598, "data": "2021-06-01 12:22:26", "tipo": 1, "valor": "40.19", "quantidade": "1", "preco_medio": 43.71, "itens_ativos_id": 30}	2	1709001029
16035	app\\models\\financas\\Operacao	update	{"id": 621, "data": "2021-07-23 13:55:00", "tipo": 1, "valor": "39.36", "quantidade": "1", "preco_medio": 43.67, "itens_ativos_id": 30}	2	1709001029
16036	app\\models\\financas\\Operacao	update	{"id": 786, "data": "2023-02-13 13:39:17", "tipo": 0, "valor": "1001.52", "quantidade": "26", "preco_medio": 43.67, "itens_ativos_id": 30}	2	1709001029
16037	app\\models\\financas\\ItensAtivo	update	{"id": 30, "ativo": true, "ativo_id": 19, "quantidade": 85, "valor_bruto": "3485.85", "valor_compra": 3712.199999999998, "investidor_id": 1, "valor_liquido": "3485.85"}	2	1709001029
16038	app\\models\\financas\\Operacao	update	{"id": 66, "data": "2019-08-13 00:00:00", "tipo": 1, "valor": "48.72", "quantidade": "3", "preco_medio": 16.24, "itens_ativos_id": 9}	2	1709001029
16039	app\\models\\financas\\Operacao	update	{"id": 70, "data": "2019-08-16 00:00:00", "tipo": 1, "valor": "897.6", "quantidade": "55", "preco_medio": 16.32, "itens_ativos_id": 9}	2	1709001029
16040	app\\models\\financas\\Operacao	update	{"id": 94, "data": "2019-09-10 00:00:00", "tipo": 1, "valor": "252.96", "quantidade": "16", "preco_medio": 16.21, "itens_ativos_id": 9}	2	1709001029
16041	app\\models\\financas\\Operacao	update	{"id": 87, "data": "2019-09-10 00:00:01", "tipo": 1, "valor": "126.8", "quantidade": "8", "preco_medio": 16.17, "itens_ativos_id": 9}	2	1709001029
16042	app\\models\\financas\\Operacao	update	{"id": 804, "data": "2019-09-10 09:45:00", "tipo": 1, "valor": "126.8", "quantidade": "8", "preco_medio": 16.14, "itens_ativos_id": 9}	2	1709001029
16043	app\\models\\financas\\Operacao	update	{"id": 100, "data": "2019-10-02 00:00:00", "tipo": 1, "valor": "47.16", "quantidade": "3", "preco_medio": 16.13, "itens_ativos_id": 9}	2	1709001029
16044	app\\models\\financas\\Operacao	update	{"id": 114, "data": "2019-11-04 00:00:00", "tipo": 1, "valor": "215.04", "quantidade": "14", "preco_medio": 16.03, "itens_ativos_id": 9}	2	1709001029
16045	app\\models\\financas\\Operacao	update	{"id": 297, "data": "2020-05-05 11:24:41", "tipo": 1, "valor": "207.2", "quantidade": "14", "preco_medio": 15.89, "itens_ativos_id": 9}	2	1709001029
16046	app\\models\\financas\\Operacao	update	{"id": 304, "data": "2020-06-02 10:55:20", "tipo": 1, "valor": "357.76", "quantidade": "26", "preco_medio": 15.51, "itens_ativos_id": 9}	2	1709001029
16047	app\\models\\financas\\Operacao	update	{"id": 313, "data": "2020-07-30 12:55:00", "tipo": 1, "valor": "486.75", "quantidade": "33", "preco_medio": 15.37, "itens_ativos_id": 9}	2	1709001029
16048	app\\models\\financas\\Operacao	update	{"id": 319, "data": "2020-10-07 13:00:00", "tipo": 1, "valor": "25.04", "quantidade": "2", "preco_medio": 15.34, "itens_ativos_id": 9}	2	1709001029
16049	app\\models\\financas\\Operacao	update	{"id": 395, "data": "2021-02-08 16:16:35", "tipo": 1, "valor": "1109.7", "quantidade": "81", "preco_medio": 14.83, "itens_ativos_id": 9}	2	1709001029
16050	app\\models\\financas\\Operacao	update	{"id": 475, "data": "2021-03-10 10:30:17", "tipo": 1, "valor": "12.58", "quantidade": "1", "preco_medio": 14.83, "itens_ativos_id": 9}	2	1709001029
16051	app\\models\\financas\\Operacao	update	{"id": 538, "data": "2021-04-15 10:29:05", "tipo": 1, "valor": "1031.03", "quantidade": "77", "preco_medio": 14.5, "itens_ativos_id": 9}	2	1709001029
16052	app\\models\\financas\\Operacao	update	{"id": 607, "data": "2021-08-03 15:01:52", "tipo": 1, "valor": "26.54", "quantidade": "2", "preco_medio": 14.49, "itens_ativos_id": 9}	2	1709001029
16053	app\\models\\financas\\Operacao	update	{"id": 784, "data": "2023-02-13 13:40:55", "tipo": 0, "valor": "1076.4", "quantidade": "90", "preco_medio": 14.49, "itens_ativos_id": 9}	2	1709001029
16054	app\\models\\financas\\ItensAtivo	update	{"id": 9, "ativo": true, "ativo_id": 25, "quantidade": 253, "valor_bruto": "2532.53", "valor_compra": 3667.5799999999995, "investidor_id": 1, "valor_liquido": "2532.53"}	2	1709001029
16055	app\\models\\financas\\Operacao	update	{"id": 664, "data": "2022-03-15 15:28:00", "tipo": 1, "valor": "195.19", "quantidade": "0.06695", "preco_medio": 2915.46, "itens_ativos_id": 45}	2	1709001029
16056	app\\models\\financas\\Operacao	update	{"id": 689, "data": "2022-06-11 10:10:00", "tipo": 2, "valor": 0, "quantidade": "1.27205", "preco_medio": 145.77, "itens_ativos_id": 45}	2	1709001029
16057	app\\models\\financas\\ItensAtivo	update	{"id": 45, "ativo": true, "ativo_id": 29, "quantidade": 1.339, "valor_bruto": "141.35823", "valor_compra": 195.19, "investidor_id": 2, "valor_liquido": "141.35823"}	2	1709001029
16058	app\\models\\financas\\Operacao	update	{"id": 324, "data": "2020-08-06 10:41:00", "tipo": 1, "valor": "221.8", "quantidade": "0.0696", "preco_medio": 3186.78, "itens_ativos_id": 32}	2	1709001029
16059	app\\models\\financas\\Operacao	update	{"id": 328, "data": "2020-11-17 12:35:00", "tipo": 1, "valor": "191.06", "quantidade": "0.0607", "preco_medio": 3168.53, "itens_ativos_id": 32}	2	1709001029
16060	app\\models\\financas\\Operacao	update	{"id": 387, "data": "2021-02-03 14:50:00", "tipo": 1, "valor": "180.14", "quantidade": "0.053", "preco_medio": 3235.13, "itens_ativos_id": 32}	2	1709001029
16061	app\\models\\financas\\Operacao	update	{"id": 414, "data": "2021-02-18 11:55:00", "tipo": 1, "valor": "182.81", "quantidade": "0.0554", "preco_medio": 3250.15, "itens_ativos_id": 32}	2	1709001029
16062	app\\models\\financas\\Operacao	update	{"id": 464, "data": "2021-02-26 12:55:00", "tipo": 1, "valor": "180.38", "quantidade": "0.0585", "preco_medio": 3217.33, "itens_ativos_id": 32}	2	1709001029
16063	app\\models\\financas\\Operacao	update	{"id": 472, "data": "2021-03-05 14:05:00", "tipo": 1, "valor": "299.38", "quantidade": "0.1024", "preco_medio": 3142.07, "itens_ativos_id": 32}	2	1709001029
16064	app\\models\\financas\\Operacao	update	{"id": 486, "data": "2021-03-16 14:25:00", "tipo": 1, "valor": "298.35", "quantidade": "0.096", "preco_medio": 3135.43, "itens_ativos_id": 32}	2	1709001029
16065	app\\models\\financas\\Operacao	update	{"id": 527, "data": "2021-04-09 11:05:00", "tipo": 1, "valor": "190.45", "quantidade": "0.0574", "preco_medio": 3154.38, "itens_ativos_id": 32}	2	1709001029
16066	app\\models\\financas\\Operacao	update	{"id": 548, "data": "2021-04-20 14:20:00", "tipo": 1, "valor": "173.3", "quantidade": "0.052", "preco_medio": 3169.7, "itens_ativos_id": 32}	2	1709001029
16067	app\\models\\financas\\Operacao	update	{"id": 566, "data": "2021-04-29 16:15:00", "tipo": 1, "valor": "184.5", "quantidade": "0.0533", "preco_medio": 3193.33, "itens_ativos_id": 32}	2	1709001029
16068	app\\models\\financas\\Operacao	update	{"id": 586, "data": "2021-05-07 11:25:00", "tipo": 1, "valor": "180.98", "quantidade": "0.05458", "preco_medio": 3202.71, "itens_ativos_id": 32}	2	1709001029
16069	app\\models\\financas\\Operacao	update	{"id": 627, "data": "2021-10-28 10:50:00", "tipo": 1, "valor": "246.19", "quantidade": "0.07257", "preco_medio": 3220.24, "itens_ativos_id": 32}	2	1709001029
16070	app\\models\\financas\\Operacao	update	{"id": 638, "data": "2021-12-29 12:45:00", "tipo": 1, "valor": "254.01", "quantidade": "0.07498", "preco_medio": 3234.84, "itens_ativos_id": 32}	2	1709001029
16071	app\\models\\financas\\Operacao	update	{"id": 688, "data": "2022-06-11 10:00:20", "tipo": 2, "valor": 0, "quantidade": "16.34817", "preco_medio": 161.74, "itens_ativos_id": 32}	2	1709001029
16072	app\\models\\financas\\ItensAtivo	update	{"id": 32, "ativo": true, "ativo_id": 29, "quantidade": 17.2086, "valor_bruto": "1816.711902", "valor_compra": 2783.3500000000004, "investidor_id": 1, "valor_liquido": "1816.711902"}	2	1709001029
16073	app\\models\\financas\\Operacao	update	{"id": 323, "data": "2020-08-04 10:33:00", "tipo": 1, "valor": "186.86", "quantidade": "0.1255", "preco_medio": 1488.92, "itens_ativos_id": 33}	2	1709001029
16074	app\\models\\financas\\Operacao	update	{"id": 325, "data": "2020-10-05 10:33:00", "tipo": 1, "valor": "174.71", "quantidade": "0.1192", "preco_medio": 1477.61, "itens_ativos_id": 33}	2	1709001029
16075	app\\models\\financas\\Operacao	update	{"id": 376, "data": "2021-01-27 14:00:00", "tipo": 1, "valor": "182.13", "quantidade": "0.0996", "preco_medio": 1579.15, "itens_ativos_id": 33}	2	1709001029
16076	app\\models\\financas\\Operacao	update	{"id": 457, "data": "2021-02-24 14:30:00", "tipo": 1, "valor": "179.8", "quantidade": "0.0865", "preco_medio": 1679.43, "itens_ativos_id": 33}	2	1709001029
16077	app\\models\\financas\\Operacao	update	{"id": 469, "data": "2021-03-03 11:40:00", "tipo": 1, "valor": "172.62", "quantidade": "0.0839", "preco_medio": 1741.05, "itens_ativos_id": 33}	2	1709001029
16078	app\\models\\financas\\Operacao	update	{"id": 477, "data": "2021-03-10 11:40:00", "tipo": 1, "valor": "300.42", "quantidade": "0.1463", "preco_medio": 1810.2, "itens_ativos_id": 33}	2	1709001029
16079	app\\models\\financas\\Operacao	update	{"id": 495, "data": "2021-03-22 12:25:00", "tipo": 1, "valor": "308.1", "quantidade": "0.1521", "preco_medio": 1850.5, "itens_ativos_id": 33}	2	1709001029
16080	app\\models\\financas\\Operacao	update	{"id": 545, "data": "2021-04-19 10:55:00", "tipo": 1, "valor": "173.06", "quantidade": "0.0753", "preco_medio": 1888.45, "itens_ativos_id": 33}	2	1709001029
16081	app\\models\\financas\\Operacao	update	{"id": 578, "data": "2021-05-03 11:40:00", "tipo": 1, "valor": "184.32", "quantidade": "0.0775", "preco_medio": 1927.76, "itens_ativos_id": 33}	2	1709001029
16082	app\\models\\financas\\Operacao	update	{"id": 643, "data": "2022-01-25 13:40:00", "tipo": 1, "valor": "249.95", "quantidade": "0.09831", "preco_medio": 1984.54, "itens_ativos_id": 33}	2	1709001029
16083	app\\models\\financas\\Operacao	update	{"id": 708, "data": "2022-07-24 11:50:14", "tipo": 2, "valor": 0, "quantidade": "20.21999", "preco_medio": 99.23, "itens_ativos_id": 33}	2	1709001029
16084	app\\models\\financas\\ItensAtivo	update	{"id": 33, "ativo": true, "ativo_id": 30, "quantidade": 21.2842, "valor_bruto": "2275.068138", "valor_compra": 2111.97, "investidor_id": 1, "valor_liquido": "2275.068138"}	2	1709001029
16085	app\\models\\financas\\Operacao	update	{"id": 637, "data": "2021-12-07 12:15:00", "tipo": 1, "valor": "172.97", "quantidade": "0.05867", "preco_medio": 2948.18, "itens_ativos_id": 41}	2	1709001029
16086	app\\models\\financas\\Operacao	update	{"id": 706, "data": "2022-07-08 16:30:22", "tipo": 1, "valor": "203.99", "quantidade": "0.08879", "preco_medio": 2556.35, "itens_ativos_id": 41}	2	1709001029
16087	app\\models\\financas\\Operacao	update	{"id": 709, "data": "2022-07-24 11:55:05", "tipo": 2, "valor": 0, "quantidade": "2.80147", "preco_medio": 127.83, "itens_ativos_id": 41}	2	1709001029
16088	app\\models\\financas\\ItensAtivo	update	{"id": 41, "ativo": true, "ativo_id": 30, "quantidade": 2.9489300000000003, "valor_bruto": "315.2111277", "valor_compra": 376.96000000000004, "investidor_id": 2, "valor_liquido": "315.2111277"}	2	1709001029
16089	app\\models\\financas\\Operacao	update	{"id": 321, "data": "2020-08-03 10:48:00", "tipo": 1, "valor": "214.5", "quantidade": "1", "preco_medio": 214.5, "itens_ativos_id": 34}	2	1709001029
16090	app\\models\\financas\\Operacao	update	{"id": 327, "data": "2020-11-13 11:32:00", "tipo": 1, "valor": "269.54", "quantidade": "1.2466", "preco_medio": 215.45, "itens_ativos_id": 34}	2	1709001029
16091	app\\models\\financas\\Operacao	update	{"id": 388, "data": "2021-02-05 14:35:00", "tipo": 1, "valor": "178.09", "quantidade": "0.7365", "preco_medio": 221.96, "itens_ativos_id": 34}	2	1709001029
16092	app\\models\\financas\\Operacao	update	{"id": 455, "data": "2021-02-23 11:40:00", "tipo": 1, "valor": "179.18", "quantidade": "0.782", "preco_medio": 223.45, "itens_ativos_id": 34}	2	1709001029
16093	app\\models\\financas\\Operacao	update	{"id": 468, "data": "2021-03-03 11:40:00", "tipo": 1, "valor": "169.27", "quantidade": "0.7316", "preco_medio": 224.74, "itens_ativos_id": 34}	2	1709001029
16094	app\\models\\financas\\Operacao	update	{"id": 474, "data": "2021-03-09 12:00:00", "tipo": 1, "valor": "300.52", "quantidade": "1.285", "preco_medio": 226.77, "itens_ativos_id": 34}	2	1709001029
16095	app\\models\\financas\\Operacao	update	{"id": 493, "data": "2021-03-18 13:45:00", "tipo": 1, "valor": "298.39", "quantidade": "1.2809", "preco_medio": 227.89, "itens_ativos_id": 34}	2	1709001029
16096	app\\models\\financas\\Operacao	update	{"id": 542, "data": "2021-04-16 11:30:00", "tipo": 1, "valor": "167.54", "quantidade": "0.644", "preco_medio": 230.59, "itens_ativos_id": 34}	2	1709001029
16097	app\\models\\financas\\Operacao	update	{"id": 565, "data": "2021-04-28 10:45:00", "tipo": 1, "valor": "172.39", "quantidade": "0.6751", "preco_medio": 232.58, "itens_ativos_id": 34}	2	1709001029
16098	app\\models\\financas\\Operacao	update	{"id": 581, "data": "2021-05-04 16:45:00", "tipo": 1, "valor": "180.35", "quantidade": "0.7295", "preco_medio": 233.75, "itens_ativos_id": 34}	2	1709001029
16099	app\\models\\financas\\Operacao	update	{"id": 678, "data": "2022-04-26 14:48:00", "tipo": 1, "valor": "305", "quantidade": "1.11594", "preco_medio": 238.07, "itens_ativos_id": 34}	2	1709001029
16100	app\\models\\financas\\ItensAtivo	update	{"id": 34, "ativo": true, "ativo_id": 32, "quantidade": 10.22714, "valor_bruto": "3121.1185852", "valor_compra": 2434.7699999999995, "investidor_id": 1, "valor_liquido": "3121.1185852"}	2	1709001029
16101	app\\models\\financas\\Operacao	update	{"id": 624, "data": "2021-10-08 16:25:00", "tipo": 1, "valor": "179", "quantidade": "0.60641", "preco_medio": 295.18, "itens_ativos_id": 39}	2	1709001029
16102	app\\models\\financas\\Operacao	update	{"id": 719, "data": "2022-09-02 10:35:49", "tipo": 1, "valor": "186.54", "quantidade": "0.72645", "preco_medio": 274.25, "itens_ativos_id": 39}	2	1709001029
16103	app\\models\\financas\\ItensAtivo	update	{"id": 39, "ativo": true, "ativo_id": 32, "quantidade": 1.3328600000000002, "valor_bruto": "406.7622148", "valor_compra": 365.53999999999996, "investidor_id": 2, "valor_liquido": "406.7622148"}	2	1709001029
16104	app\\models\\financas\\Operacao	update	{"id": 381, "data": "2021-01-29 13:50:00", "tipo": 1, "valor": "179.08", "quantidade": "0.7243", "preco_medio": 247.25, "itens_ativos_id": 35}	2	1709001029
16105	app\\models\\financas\\Operacao	update	{"id": 383, "data": "2021-02-01 16:00:00", "tipo": 1, "valor": "176.18", "quantidade": "0.7101", "preco_medio": 247.67, "itens_ativos_id": 35}	2	1709001029
16106	app\\models\\financas\\Operacao	update	{"id": 384, "data": "2021-02-02 13:05:00", "tipo": 1, "valor": "177.62", "quantidade": "0.709", "preco_medio": 248.61, "itens_ativos_id": 35}	2	1709001029
16107	app\\models\\financas\\Operacao	update	{"id": 406, "data": "2021-02-11 11:30:00", "tipo": 1, "valor": "170.88", "quantidade": "0.6618", "preco_medio": 250.88, "itens_ativos_id": 35}	2	1709001029
16108	app\\models\\financas\\Operacao	update	{"id": 460, "data": "2021-02-25 11:50:00", "tipo": 1, "valor": "178.91", "quantidade": "0.6936", "preco_medio": 252.28, "itens_ativos_id": 35}	2	1709001029
16109	app\\models\\financas\\Operacao	update	{"id": 471, "data": "2021-03-04 11:55:00", "tipo": 1, "valor": "168.15", "quantidade": "0.6691", "preco_medio": 252.12, "itens_ativos_id": 35}	2	1709001029
16110	app\\models\\financas\\Operacao	update	{"id": 478, "data": "2021-03-11 11:30:00", "tipo": 1, "valor": "300.38", "quantidade": "1.147", "preco_medio": 254.23, "itens_ativos_id": 35}	2	1709001029
16111	app\\models\\financas\\Operacao	update	{"id": 501, "data": "2021-03-24 11:20:00", "tipo": 1, "valor": "175.9", "quantidade": "0.6572", "preco_medio": 255.71, "itens_ativos_id": 35}	2	1709001029
16112	app\\models\\financas\\Operacao	update	{"id": 536, "data": "2021-04-13 11:00:00", "tipo": 1, "valor": "176.23", "quantidade": "0.6149", "preco_medio": 258.59, "itens_ativos_id": 35}	2	1709001029
16113	app\\models\\financas\\Operacao	update	{"id": 552, "data": "2021-04-22 11:05:00", "tipo": 1, "valor": "176.03", "quantidade": "0.6038", "preco_medio": 261.36, "itens_ativos_id": 35}	2	1709001029
16114	app\\models\\financas\\Operacao	update	{"id": 572, "data": "2021-04-30 12:10:00", "tipo": 1, "valor": "178.36", "quantidade": "0.6148", "preco_medio": 263.62, "itens_ativos_id": 35}	2	1709001029
16115	app\\models\\financas\\Operacao	update	{"id": 603, "data": "2021-06-14 11:20:00", "tipo": 1, "valor": "285.12", "quantidade": "0.94696", "preco_medio": 267.67, "itens_ativos_id": 35}	2	1709001029
16116	app\\models\\financas\\ItensAtivo	update	{"id": 35, "ativo": true, "ativo_id": 34, "quantidade": 8.75256, "valor_bruto": "2411.7679080", "valor_compra": 2342.8399999999997, "investidor_id": 1, "valor_liquido": "2411.7679080"}	2	1709001029
16117	app\\models\\financas\\Operacao	update	{"id": 640, "data": "2022-01-04 12:00:00", "tipo": 1, "valor": "171.02", "quantidade": "1.61888", "preco_medio": 105.64, "itens_ativos_id": 42}	2	1709001029
16118	app\\models\\financas\\ItensAtivo	update	{"id": 42, "ativo": true, "ativo_id": 35, "quantidade": 1.61888, "valor_bruto": "270.7900576", "valor_compra": 171.02, "investidor_id": 2, "valor_liquido": "270.7900576"}	2	1709001029
16119	app\\models\\financas\\Operacao	update	{"id": 390, "data": "2021-02-08 12:35:00", "tipo": 1, "valor": "180.05", "quantidade": "2.5413", "preco_medio": 70.85, "itens_ativos_id": 36}	2	1709001029
16120	app\\models\\financas\\Operacao	update	{"id": 397, "data": "2021-02-09 13:25:00", "tipo": 1, "valor": "178.95", "quantidade": "2.4983", "preco_medio": 71.24, "itens_ativos_id": 36}	2	1709001029
16121	app\\models\\financas\\Operacao	update	{"id": 398, "data": "2021-02-10 14:20:00", "tipo": 1, "valor": "181.76", "quantidade": "2.56", "preco_medio": 71.16, "itens_ativos_id": 36}	2	1709001029
16122	app\\models\\financas\\Operacao	update	{"id": 407, "data": "2021-02-11 11:35:00", "tipo": 1, "valor": "192.42", "quantidade": "2.6141", "preco_medio": 71.78, "itens_ativos_id": 36}	2	1709001029
16123	app\\models\\financas\\Operacao	update	{"id": 465, "data": "2021-03-01 13:35:00", "tipo": 1, "valor": "178.06", "quantidade": "2.4472", "preco_medio": 71.97, "itens_ativos_id": 36}	2	1709001029
16124	app\\models\\financas\\Operacao	update	{"id": 470, "data": "2021-03-04 11:55:00", "tipo": 1, "valor": "176.19", "quantidade": "2.5042", "preco_medio": 71.71, "itens_ativos_id": 36}	2	1709001029
16125	app\\models\\financas\\Operacao	update	{"id": 481, "data": "2021-03-12 15:50:00", "tipo": 1, "valor": "298.13", "quantidade": "4.2091", "preco_medio": 71.52, "itens_ativos_id": 36}	2	1709001029
16126	app\\models\\financas\\Operacao	update	{"id": 498, "data": "2021-03-23 10:50:00", "tipo": 1, "valor": "176.12", "quantidade": "2.5458", "preco_medio": 71.24, "itens_ativos_id": 36}	2	1709001029
16127	app\\models\\financas\\Operacao	update	{"id": 518, "data": "2021-04-06 10:45:00", "tipo": 1, "valor": "342.4", "quantidade": "5.0271", "preco_medio": 70.66, "itens_ativos_id": 36}	2	1709001029
16128	app\\models\\financas\\Operacao	update	{"id": 557, "data": "2021-04-26 12:15:00", "tipo": 1, "valor": "181.05", "quantidade": "2.4493", "preco_medio": 70.93, "itens_ativos_id": 36}	2	1709001029
16129	app\\models\\financas\\Operacao	update	{"id": 777, "data": "2023-02-08 11:30:35", "tipo": 0, "valor": "1126.8", "quantidade": "8", "preco_medio": 70.93, "itens_ativos_id": 36}	2	1709001029
16130	app\\models\\financas\\ItensAtivo	update	{"id": 36, "ativo": true, "ativo_id": 35, "quantidade": 21.396400000000003, "valor_bruto": "3578.975828", "valor_compra": 1517.69, "investidor_id": 1, "valor_liquido": "3578.975828"}	2	1709001029
16131	app\\models\\financas\\Operacao	update	{"id": 416, "data": "2021-02-19 15:40:00", "tipo": 1, "valor": "179", "quantidade": "10.5294", "preco_medio": 17, "itens_ativos_id": 37}	2	1709001029
16132	app\\models\\financas\\Operacao	update	{"id": 454, "data": "2021-02-22 13:00:00", "tipo": 1, "valor": "181.09", "quantidade": "10.5047", "preco_medio": 17.12, "itens_ativos_id": 37}	2	1709001029
16133	app\\models\\financas\\Operacao	update	{"id": 456, "data": "2021-02-23 11:40:00", "tipo": 1, "valor": "170.65", "quantidade": "9.9272", "preco_medio": 17.14, "itens_ativos_id": 37}	2	1709001029
16134	app\\models\\financas\\Operacao	update	{"id": 458, "data": "2021-02-24 14:30:00", "tipo": 1, "valor": "179.09", "quantidade": "10.4312", "preco_medio": 17.15, "itens_ativos_id": 37}	2	1709001029
16135	app\\models\\financas\\Operacao	update	{"id": 463, "data": "2021-02-26 12:55:00", "tipo": 1, "valor": "174.69", "quantidade": "10.6007", "preco_medio": 17.01, "itens_ativos_id": 37}	2	1709001029
16136	app\\models\\financas\\Operacao	update	{"id": 466, "data": "2021-03-02 12:10:00", "tipo": 1, "valor": "187.05", "quantidade": "11.3856", "preco_medio": 16.91, "itens_ativos_id": 37}	2	1709001029
16137	app\\models\\financas\\Operacao	update	{"id": 482, "data": "2021-03-15 11:40:00", "tipo": 1, "valor": "298.13", "quantidade": "18.0914", "preco_medio": 16.81, "itens_ativos_id": 37}	2	1709001029
16138	app\\models\\financas\\Operacao	update	{"id": 530, "data": "2021-04-12 13:00:00", "tipo": 1, "valor": "169.35", "quantidade": "10.2518", "preco_medio": 16.78, "itens_ativos_id": 37}	2	1709001029
16139	app\\models\\financas\\Operacao	update	{"id": 556, "data": "2021-04-23 16:40:00", "tipo": 1, "valor": "179.99", "quantidade": "10.6383", "preco_medio": 16.79, "itens_ativos_id": 37}	2	1709001029
16140	app\\models\\financas\\Operacao	update	{"id": 585, "data": "2021-05-05 14:15:00", "tipo": 1, "valor": "180.2", "quantidade": "10.6007", "preco_medio": 16.81, "itens_ativos_id": 37}	2	1709001029
16141	app\\models\\financas\\Operacao	update	{"id": 596, "data": "2021-05-27 11:05:00", "tipo": 3, "valor": 0, "quantidade": "56.4805", "preco_medio": 33.63, "itens_ativos_id": 37}	2	1709001029
16142	app\\models\\financas\\Operacao	update	{"id": 605, "data": "2021-07-06 10:00:00", "tipo": 1, "valor": "194", "quantidade": "5.62483", "preco_medio": 33.7, "itens_ativos_id": 37}	2	1709001029
16143	app\\models\\financas\\Operacao	update	{"id": 668, "data": "2022-03-29 10:58:00", "tipo": 1, "valor": "294", "quantidade": "8.11043", "preco_medio": 34, "itens_ativos_id": 37}	2	1709001029
16144	app\\models\\financas\\ItensAtivo	update	{"id": 37, "ativo": true, "ativo_id": 37, "quantidade": 70.21576000000002, "valor_bruto": "2649.2406248", "valor_compra": 2387.24, "investidor_id": 1, "valor_liquido": "2649.2406248"}	2	1709001029
16145	app\\models\\financas\\Operacao	update	{"id": 606, "data": "2021-07-21 12:00:00", "tipo": 1, "valor": "183", "quantidade": "5.34308", "preco_medio": 34.25, "itens_ativos_id": 38}	2	1709001029
16146	app\\models\\financas\\Operacao	update	{"id": 682, "data": "2022-05-16 16:41:00", "tipo": 1, "valor": "190", "quantidade": "5.48183", "preco_medio": 34.46, "itens_ativos_id": 38}	2	1709001029
16147	app\\models\\financas\\ItensAtivo	update	{"id": 38, "ativo": true, "ativo_id": 37, "quantidade": 10.82491, "valor_bruto": "408.4238543", "valor_compra": 373, "investidor_id": 2, "valor_liquido": "408.4238543"}	2	1709001029
16148	app\\models\\financas\\Operacao	update	{"id": 453, "data": "2021-02-22 12:40:10", "tipo": 1, "valor": "882.95", "quantidade": "5", "preco_medio": 176.59, "itens_ativos_id": 10}	2	1709001029
16149	app\\models\\financas\\Operacao	update	{"id": 480, "data": "2021-03-12 10:54:13", "tipo": 1, "valor": "883.3", "quantidade": "5", "preco_medio": 176.63, "itens_ativos_id": 10}	2	1709001029
16150	app\\models\\financas\\Operacao	update	{"id": 492, "data": "2021-03-18 11:22:34", "tipo": 1, "valor": "876.23", "quantidade": "5", "preco_medio": 176.17, "itens_ativos_id": 10}	2	1709001029
16151	app\\models\\financas\\Operacao	update	{"id": 499, "data": "2021-03-24 10:12:50", "tipo": 1, "valor": "863.15", "quantidade": "5", "preco_medio": 175.28, "itens_ativos_id": 10}	2	1709001029
16152	app\\models\\financas\\Operacao	update	{"id": 509, "data": "2021-03-29 10:03:38", "tipo": 1, "valor": "852.5", "quantidade": "5", "preco_medio": 174.33, "itens_ativos_id": 10}	2	1709001029
16153	app\\models\\financas\\Operacao	update	{"id": 517, "data": "2021-04-01 10:33:02", "tipo": 1, "valor": "1913.56", "quantidade": "11", "preco_medio": 174.21, "itens_ativos_id": 10}	2	1709001029
16154	app\\models\\financas\\Operacao	update	{"id": 555, "data": "2021-04-23 16:36:32", "tipo": 1, "valor": "859.56", "quantidade": "5", "preco_medio": 173.93, "itens_ativos_id": 10}	2	1709001029
16155	app\\models\\financas\\Operacao	update	{"id": 571, "data": "2021-04-30 12:08:15", "tipo": 1, "valor": "864.15", "quantidade": "5", "preco_medio": 173.81, "itens_ativos_id": 10}	2	1709001029
16156	app\\models\\financas\\Operacao	update	{"id": 600, "data": "2021-06-01 12:21:12", "tipo": 1, "valor": "847.75", "quantidade": "5", "preco_medio": 173.4, "itens_ativos_id": 10}	2	1709001029
16157	app\\models\\financas\\Operacao	update	{"id": 694, "data": "2022-06-15 13:50:38", "tipo": 0, "valor": "3264.8", "quantidade": "20", "preco_medio": 173.4, "itens_ativos_id": 10}	2	1709001029
16158	app\\models\\financas\\Operacao	update	{"id": 782, "data": "2023-02-13 13:42:07", "tipo": 1, "valor": "2079.22", "quantidade": "13", "preco_medio": 169.42, "itens_ativos_id": 10}	2	1709001029
16159	app\\models\\financas\\Operacao	update	{"id": 789, "data": "2023-02-22 16:30:30", "tipo": 1, "valor": "160.37", "quantidade": "1", "preco_medio": 169.22, "itens_ativos_id": 10}	2	1709001029
16160	app\\models\\financas\\Operacao	update	{"id": 797, "data": "2023-03-15 10:19:10", "tipo": 1, "valor": "480.54", "quantidade": "3", "preco_medio": 168.65, "itens_ativos_id": 10}	2	1709001029
16161	app\\models\\financas\\ItensAtivo	update	{"id": 10, "ativo": true, "ativo_id": 38, "quantidade": 48, "valor_bruto": "7799.52", "valor_compra": 8095.279999999999, "investidor_id": 1, "valor_liquido": "7799.52"}	2	1709001029
16162	app\\models\\financas\\Operacao	update	{"id": 462, "data": "2021-02-26 10:19:13", "tipo": 1, "valor": "987.73", "quantidade": "9", "preco_medio": 109.75, "itens_ativos_id": 12}	2	1709001029
16163	app\\models\\financas\\Operacao	update	{"id": 484, "data": "2021-03-16 10:27:43", "tipo": 1, "valor": "947.07", "quantidade": "9", "preco_medio": 107.49, "itens_ativos_id": 12}	2	1709001029
16164	app\\models\\financas\\Operacao	update	{"id": 497, "data": "2021-03-22 12:38:10", "tipo": 1, "valor": "1255.56", "quantidade": "12", "preco_medio": 106.35, "itens_ativos_id": 12}	2	1709001029
16165	app\\models\\financas\\Operacao	update	{"id": 506, "data": "2021-03-26 11:27:23", "tipo": 1, "valor": "1033.1", "quantidade": "10", "preco_medio": 105.59, "itens_ativos_id": 12}	2	1709001029
16166	app\\models\\financas\\Operacao	update	{"id": 513, "data": "2021-03-31 10:59:53", "tipo": 1, "valor": "944.93", "quantidade": "9", "preco_medio": 105.48, "itens_ativos_id": 12}	2	1709001029
16167	app\\models\\financas\\Operacao	update	{"id": 544, "data": "2021-04-19 10:53:14", "tipo": 1, "valor": "964.53", "quantidade": "9", "preco_medio": 105.74, "itens_ativos_id": 12}	2	1709001029
16168	app\\models\\financas\\Operacao	update	{"id": 559, "data": "2021-04-26 12:13:44", "tipo": 1, "valor": "952.83", "quantidade": "9", "preco_medio": 105.76, "itens_ativos_id": 12}	2	1709001029
16169	app\\models\\financas\\Operacao	update	{"id": 580, "data": "2021-05-04 16:42:34", "tipo": 1, "valor": "946.08", "quantidade": "9", "preco_medio": 105.68, "itens_ativos_id": 12}	2	1709001029
16170	app\\models\\financas\\Operacao	update	{"id": 599, "data": "2021-06-01 12:21:46", "tipo": 1, "valor": "525.7", "quantidade": "5", "preco_medio": 105.65, "itens_ativos_id": 12}	2	1709001029
16171	app\\models\\financas\\Operacao	update	{"id": 634, "data": "2021-11-26 10:05:00", "tipo": 1, "valor": "867.95", "quantidade": "10", "preco_medio": 103.58, "itens_ativos_id": 12}	2	1709001029
16172	app\\models\\financas\\Operacao	update	{"id": 636, "data": "2021-12-14 12:15:00", "tipo": 1, "valor": "185.06", "quantidade": "2", "preco_medio": 103.34, "itens_ativos_id": 12}	2	1709001029
16173	app\\models\\financas\\Operacao	update	{"id": 702, "data": "2022-06-24 15:16:05", "tipo": 0, "valor": "3850.06", "quantidade": "40", "preco_medio": 103.34, "itens_ativos_id": 12}	2	1709001029
16174	app\\models\\financas\\Operacao	update	{"id": 705, "data": "2022-07-08 13:33:34", "tipo": 1, "valor": "91.75", "quantidade": "1", "preco_medio": 103.12, "itens_ativos_id": 12}	2	1709001029
16175	app\\models\\financas\\Operacao	update	{"id": 744, "data": "2022-11-09 14:18:46", "tipo": 1, "valor": "1044.4", "quantidade": "10", "preco_medio": 103.33, "itens_ativos_id": 12}	2	1709001029
16176	app\\models\\financas\\Operacao	update	{"id": 752, "data": "2022-12-13 15:26:53", "tipo": 1, "valor": "295.38", "quantidade": "3", "preco_medio": 103.11, "itens_ativos_id": 12}	2	1709001029
16177	app\\models\\financas\\Operacao	update	{"id": 765, "data": "2023-01-17 14:03:21", "tipo": 1, "valor": "99.37", "quantidade": "1", "preco_medio": 103.06, "itens_ativos_id": 12}	2	1709001029
16178	app\\models\\financas\\Operacao	update	{"id": 788, "data": "2023-02-22 16:31:08", "tipo": 1, "valor": "97.96", "quantidade": "1", "preco_medio": 102.98, "itens_ativos_id": 12}	2	1709001029
16179	app\\models\\financas\\ItensAtivo	update	{"id": 12, "ativo": true, "ativo_id": 40, "quantidade": 69, "valor_bruto": "7112.52", "valor_compra": 7105.8, "investidor_id": 1, "valor_liquido": "7112.52"}	2	1709001029
16180	app\\models\\financas\\Operacao	update	{"id": 609, "data": "2021-08-04 10:50:00", "tipo": 1, "valor": "1022", "quantidade": "10", "preco_medio": 102.2, "itens_ativos_id": 17}	2	1709001029
16181	app\\models\\financas\\ItensAtivo	update	{"id": 17, "ativo": true, "ativo_id": 40, "quantidade": 10, "valor_bruto": "1030.80", "valor_compra": 1022, "investidor_id": 2, "valor_liquido": "1030.80"}	2	1709001029
16182	app\\models\\financas\\Operacao	update	{"id": 604, "data": "2021-06-24 16:52:18", "tipo": 1, "valor": "1448.2", "quantidade": "13", "preco_medio": 111.4, "itens_ativos_id": 13}	2	1709001029
16183	app\\models\\financas\\Operacao	update	{"id": 623, "data": "2021-07-23 13:55:00", "tipo": 1, "valor": "897.32", "quantidade": "8", "preco_medio": 111.69, "itens_ativos_id": 13}	2	1709001029
16184	app\\models\\financas\\Operacao	update	{"id": 608, "data": "2021-08-03 15:01:04", "tipo": 1, "valor": "989.64", "quantidade": "9", "preco_medio": 111.17, "itens_ativos_id": 13}	2	1709001029
16185	app\\models\\financas\\Operacao	update	{"id": 612, "data": "2021-08-27 10:17:01", "tipo": 1, "valor": "1618.7", "quantidade": "15", "preco_medio": 110.09, "itens_ativos_id": 13}	2	1709001029
16186	app\\models\\financas\\Operacao	update	{"id": 615, "data": "2021-09-16 13:38:12", "tipo": 1, "valor": "2386.9", "quantidade": "22", "preco_medio": 109.56, "itens_ativos_id": 13}	2	1709001029
16187	app\\models\\financas\\Operacao	update	{"id": 619, "data": "2021-10-08 13:37:12", "tipo": 1, "valor": "1085.8", "quantidade": "10", "preco_medio": 109.44, "itens_ativos_id": 13}	2	1709001029
16188	app\\models\\financas\\Operacao	update	{"id": 632, "data": "2021-11-12 10:25:00", "tipo": 1, "valor": "101.81", "quantidade": "1", "preco_medio": 109.34, "itens_ativos_id": 13}	2	1709001029
16189	app\\models\\financas\\Operacao	update	{"id": 651, "data": "2021-12-22 13:45:46", "tipo": 1, "valor": "105.17", "quantidade": "1", "preco_medio": 109.29, "itens_ativos_id": 13}	2	1709001029
16190	app\\models\\financas\\Operacao	update	{"id": 639, "data": "2021-12-29 12:50:00", "tipo": 1, "valor": "105", "quantidade": "1", "preco_medio": 109.23, "itens_ativos_id": 13}	2	1709001029
16191	app\\models\\financas\\Operacao	update	{"id": 808, "data": "2022-01-03 00:00:00", "tipo": 1, "valor": "208.68", "quantidade": "2", "preco_medio": 109.11, "itens_ativos_id": 13}	2	1709001029
16192	app\\models\\financas\\Operacao	update	{"id": 641, "data": "2022-01-19 17:35:00", "tipo": 1, "valor": "209.6", "quantidade": "2", "preco_medio": 109.01, "itens_ativos_id": 13}	2	1709001029
16193	app\\models\\financas\\Operacao	update	{"id": 644, "data": "2022-01-25 13:50:00", "tipo": 1, "valor": "105.8", "quantidade": "1", "preco_medio": 108.97, "itens_ativos_id": 13}	2	1709001029
16194	app\\models\\financas\\Operacao	update	{"id": 649, "data": "2022-02-02 14:30:00", "tipo": 1, "valor": "1044.1", "quantidade": "10", "preco_medio": 108.49, "itens_ativos_id": 13}	2	1709001029
16195	app\\models\\financas\\Operacao	update	{"id": 667, "data": "2022-03-29 11:00:52", "tipo": 1, "valor": "104.14", "quantidade": "1", "preco_medio": 108.45, "itens_ativos_id": 13}	2	1709001029
16196	app\\models\\financas\\Operacao	update	{"id": 669, "data": "2022-04-04 15:49:39", "tipo": 1, "valor": "103.75", "quantidade": "1", "preco_medio": 108.4, "itens_ativos_id": 13}	2	1709001029
16197	app\\models\\financas\\Operacao	update	{"id": 676, "data": "2022-04-14 15:26:51", "tipo": 1, "valor": "205.96", "quantidade": "2", "preco_medio": 108.29, "itens_ativos_id": 13}	2	1709001029
16198	app\\models\\financas\\Operacao	update	{"id": 679, "data": "2022-05-05 11:25:51", "tipo": 1, "valor": "499.65", "quantidade": "5", "preco_medio": 107.89, "itens_ativos_id": 13}	2	1709001029
16199	app\\models\\financas\\Operacao	update	{"id": 692, "data": "2022-06-15 13:52:41", "tipo": 1, "valor": "99", "quantidade": "1", "preco_medio": 107.8, "itens_ativos_id": 13}	2	1709001029
16200	app\\models\\financas\\Operacao	update	{"id": 696, "data": "2022-06-17 10:25:06", "tipo": 1, "valor": "4166.4", "quantidade": "42", "preco_medio": 105.34, "itens_ativos_id": 13}	2	1709001029
16201	app\\models\\financas\\Operacao	update	{"id": 695, "data": "2022-06-17 10:25:43", "tipo": 1, "valor": "99", "quantidade": "1", "preco_medio": 105.3, "itens_ativos_id": 13}	2	1709001029
16202	app\\models\\financas\\Operacao	update	{"id": 722, "data": "2022-09-15 10:11:34", "tipo": 1, "valor": "282.09", "quantidade": "3", "preco_medio": 105.08, "itens_ativos_id": 13}	2	1709001029
16203	app\\models\\financas\\Operacao	update	{"id": 724, "data": "2022-09-26 14:42:41", "tipo": 1, "valor": "287.4", "quantidade": "3", "preco_medio": 104.9, "itens_ativos_id": 13}	2	1709001029
16204	app\\models\\financas\\Operacao	update	{"id": 726, "data": "2022-10-04 13:59:07", "tipo": 1, "valor": "732", "quantidade": "8", "preco_medio": 104.24, "itens_ativos_id": 13}	2	1709001029
16205	app\\models\\financas\\Operacao	update	{"id": 734, "data": "2022-10-14 13:39:11", "tipo": 1, "valor": "94.98", "quantidade": "1", "preco_medio": 104.18, "itens_ativos_id": 13}	2	1709001029
16206	app\\models\\financas\\Operacao	update	{"id": 745, "data": "2022-11-09 14:18:12", "tipo": 1, "valor": "949.8", "quantidade": "10", "preco_medio": 103.65, "itens_ativos_id": 13}	2	1709001029
16207	app\\models\\financas\\Operacao	update	{"id": 767, "data": "2023-01-17 14:01:34", "tipo": 1, "valor": "89.2", "quantidade": "1", "preco_medio": 103.56, "itens_ativos_id": 13}	2	1709001029
16208	app\\models\\financas\\ItensAtivo	update	{"id": 13, "ativo": true, "ativo_id": 42, "quantidade": 174, "valor_bruto": "14414.16", "valor_compra": 18020.089999999997, "investidor_id": 1, "valor_liquido": "14414.16"}	2	1709001029
16209	app\\models\\financas\\Operacao	update	{"id": 648, "data": "2022-02-02 14:30:00", "tipo": 1, "valor": "2252.43", "quantidade": "19", "preco_medio": 118.55, "itens_ativos_id": 43}	2	1709001029
16210	app\\models\\financas\\Operacao	update	{"id": 653, "data": "2022-02-18 14:49:12", "tipo": 1, "valor": "455.58", "quantidade": "4", "preco_medio": 117.74, "itens_ativos_id": 43}	2	1709001029
16211	app\\models\\financas\\Operacao	update	{"id": 659, "data": "2022-03-03 10:21:27", "tipo": 1, "valor": "111.6", "quantidade": "1", "preco_medio": 117.48, "itens_ativos_id": 43}	2	1709001029
16212	app\\models\\financas\\Operacao	update	{"id": 663, "data": "2022-03-15 11:40:26", "tipo": 1, "valor": "327.9", "quantidade": "3", "preco_medio": 116.57, "itens_ativos_id": 43}	2	1709001029
16213	app\\models\\financas\\Operacao	update	{"id": 665, "data": "2022-03-18 19:30:13", "tipo": 1, "valor": "111.28", "quantidade": "1", "preco_medio": 116.39, "itens_ativos_id": 43}	2	1709001029
16214	app\\models\\financas\\Operacao	update	{"id": 673, "data": "2022-04-08 13:14:21", "tipo": 1, "valor": "119.05", "quantidade": "1", "preco_medio": 116.48, "itens_ativos_id": 43}	2	1709001029
16215	app\\models\\financas\\Operacao	update	{"id": 677, "data": "2022-04-14 15:14:42", "tipo": 1, "valor": "236.8", "quantidade": "2", "preco_medio": 116.6, "itens_ativos_id": 43}	2	1709001029
16216	app\\models\\financas\\Operacao	update	{"id": 681, "data": "2022-05-13 10:05:01", "tipo": 1, "valor": "232.4", "quantidade": "2", "preco_medio": 116.58, "itens_ativos_id": 43}	2	1709001029
16217	app\\models\\financas\\Operacao	update	{"id": 680, "data": "2022-05-13 10:07:13", "tipo": 1, "valor": "116.2", "quantidade": "1", "preco_medio": 116.57, "itens_ativos_id": 43}	2	1709001029
16218	app\\models\\financas\\Operacao	update	{"id": 683, "data": "2022-05-25 16:33:29", "tipo": 1, "valor": "114.95", "quantidade": "1", "preco_medio": 116.52, "itens_ativos_id": 43}	2	1709001029
16219	app\\models\\financas\\Operacao	update	{"id": 686, "data": "2022-06-02 10:10:27", "tipo": 1, "valor": "463.16", "quantidade": "4", "preco_medio": 116.44, "itens_ativos_id": 43}	2	1709001029
16220	app\\models\\financas\\Operacao	update	{"id": 690, "data": "2022-06-13 13:06:43", "tipo": 1, "valor": "114.69", "quantidade": "1", "preco_medio": 116.4, "itens_ativos_id": 43}	2	1709001029
16221	app\\models\\financas\\Operacao	update	{"id": 691, "data": "2022-06-14 14:51:40", "tipo": 1, "valor": "114.86", "quantidade": "1", "preco_medio": 116.36, "itens_ativos_id": 43}	2	1709001029
16222	app\\models\\financas\\Operacao	update	{"id": 693, "data": "2022-06-15 13:51:54", "tipo": 1, "valor": "3320.5", "quantidade": "29", "preco_medio": 115.59, "itens_ativos_id": 43}	2	1709001029
16223	app\\models\\financas\\Operacao	update	{"id": 701, "data": "2022-06-24 15:17:07", "tipo": 1, "valor": "3805.89", "quantidade": "33", "preco_medio": 115.51, "itens_ativos_id": 43}	2	1709001029
16224	app\\models\\financas\\Operacao	update	{"id": 700, "data": "2022-06-24 15:17:39", "tipo": 1, "valor": "115.33", "quantidade": "1", "preco_medio": 115.51, "itens_ativos_id": 43}	2	1709001029
16225	app\\models\\financas\\Operacao	update	{"id": 704, "data": "2022-07-08 13:31:03", "tipo": 1, "valor": "115.12", "quantidade": "1", "preco_medio": 115.5, "itens_ativos_id": 43}	2	1709001029
16226	app\\models\\financas\\Operacao	update	{"id": 707, "data": "2022-07-18 10:20:21", "tipo": 1, "valor": "355.39", "quantidade": "3", "preco_medio": 115.58, "itens_ativos_id": 43}	2	1709001029
16227	app\\models\\financas\\Operacao	update	{"id": 712, "data": "2022-08-08 14:50:03", "tipo": 1, "valor": "119.23", "quantidade": "1", "preco_medio": 115.62, "itens_ativos_id": 43}	2	1709001029
16228	app\\models\\financas\\Operacao	update	{"id": 713, "data": "2022-08-15 13:08:46", "tipo": 1, "valor": "244.3", "quantidade": "2", "preco_medio": 115.74, "itens_ativos_id": 43}	2	1709001029
16229	app\\models\\financas\\Operacao	update	{"id": 720, "data": "2022-09-09 13:33:42", "tipo": 1, "valor": "127.13", "quantidade": "1", "preco_medio": 115.84, "itens_ativos_id": 43}	2	1709001029
16230	app\\models\\financas\\Operacao	update	{"id": 727, "data": "2022-10-04 13:58:38", "tipo": 1, "valor": "1134.23", "quantidade": "9", "preco_medio": 116.6, "itens_ativos_id": 43}	2	1709001029
16231	app\\models\\financas\\Operacao	update	{"id": 731, "data": "2022-10-10 10:30:53", "tipo": 1, "valor": "249.4", "quantidade": "2", "preco_medio": 116.73, "itens_ativos_id": 43}	2	1709001029
16232	app\\models\\financas\\Operacao	update	{"id": 748, "data": "2022-11-09 14:15:28", "tipo": 1, "valor": "126.65", "quantidade": "1", "preco_medio": 116.81, "itens_ativos_id": 43}	2	1709001029
16233	app\\models\\financas\\Operacao	update	{"id": 749, "data": "2022-11-16 10:13:02", "tipo": 1, "valor": "246.92", "quantidade": "2", "preco_medio": 116.91, "itens_ativos_id": 43}	2	1709001029
16234	app\\models\\financas\\Operacao	update	{"id": 759, "data": "2022-12-29 10:40:36", "tipo": 1, "valor": "242.56", "quantidade": "2", "preco_medio": 116.98, "itens_ativos_id": 43}	2	1709001029
16235	app\\models\\financas\\Operacao	update	{"id": 762, "data": "2023-01-12 14:11:44", "tipo": 1, "valor": "120.13", "quantidade": "1", "preco_medio": 117.01, "itens_ativos_id": 43}	2	1709001029
16236	app\\models\\financas\\ItensAtivo	update	{"id": 43, "ativo": true, "ativo_id": 49, "quantidade": 129, "valor_bruto": "14490.57", "valor_compra": 15093.679999999995, "investidor_id": 1, "valor_liquido": "14490.57"}	2	1709001029
16237	app\\models\\financas\\Operacao	update	{"id": 658, "data": "2022-02-23 11:36:00", "tipo": 1, "valor": "277", "quantidade": "1.35168", "preco_medio": 204.93, "itens_ativos_id": 44}	2	1709001029
16238	app\\models\\financas\\ItensAtivo	update	{"id": 44, "ativo": true, "ativo_id": 50, "quantidade": 1.35168, "valor_bruto": "320.0643072", "valor_compra": 277, "investidor_id": 1, "valor_liquido": "320.0643072"}	2	1709001029
16239	app\\models\\financas\\Operacao	update	{"id": 685, "data": "2022-05-29 16:15:48", "tipo": 1, "valor": "187", "quantidade": "0.00119476", "preco_medio": 156516.79, "itens_ativos_id": 46}	2	1709001029
16240	app\\models\\financas\\Operacao	update	{"id": 703, "data": "2022-06-28 12:55:51", "tipo": 1, "valor": "1400", "quantidade": "0.01272254", "preco_medio": 114030.74, "itens_ativos_id": 46}	2	1709001029
16241	app\\models\\financas\\Operacao	update	{"id": 711, "data": "2022-07-29 13:15:59", "tipo": 1, "valor": "600", "quantidade": "0.00476211", "preco_medio": 117080.79, "itens_ativos_id": 46}	2	1709001029
16242	app\\models\\financas\\ItensAtivo	update	{"id": 46, "ativo": true, "ativo_id": 51, "quantidade": 0.01867941, "valor_bruto": "2753.04616344", "valor_compra": 2187, "investidor_id": 1, "valor_liquido": "2753.04616344"}	2	1709001029
16243	app\\models\\financas\\Operacao	update	{"id": 732, "data": "2022-10-11 14:55:00", "tipo": 1, "valor": "301", "quantidade": "3.01241", "preco_medio": 99.92, "itens_ativos_id": 49}	2	1709001029
16244	app\\models\\financas\\Operacao	update	{"id": 770, "data": "2023-01-17 14:25:36", "tipo": 1, "valor": "1191.69", "quantidade": "9.75678", "preco_medio": 116.9, "itens_ativos_id": 49}	2	1709001029
16245	app\\models\\financas\\Operacao	update	{"id": 779, "data": "2023-02-08 11:35:53", "tipo": 1, "valor": "514.12", "quantidade": "3.95681", "preco_medio": 119.98, "itens_ativos_id": 49}	2	1709001029
16246	app\\models\\financas\\ItensAtivo	update	{"id": 49, "ativo": true, "ativo_id": 54, "quantidade": 16.726, "valor_bruto": "2081.55070", "valor_compra": 2006.81, "investidor_id": 1, "valor_liquido": "2081.55070"}	2	1709001029
16247	app\\models\\financas\\Operacao	update	{"id": 763, "data": "2023-01-05 14:15:42", "tipo": 1, "valor": "181.78", "quantidade": "1.61444", "preco_medio": 112.6, "itens_ativos_id": 51}	2	1709001029
16248	app\\models\\financas\\ItensAtivo	update	{"id": 51, "ativo": true, "ativo_id": 54, "quantidade": 1.61444, "valor_bruto": "200.9170580", "valor_compra": 181.78, "investidor_id": 2, "valor_liquido": "200.9170580"}	2	1709001029
16249	app\\models\\financas\\Operacao	update	{"id": 809, "data": "2023-04-04 08:55:28", "tipo": 1, "valor": "1033.09", "quantidade": "0.08", "preco_medio": 12913.63, "itens_ativos_id": 55}	2	1709001029
16250	app\\models\\financas\\Operacao	update	{"id": 842, "data": "2023-06-28 11:30:13", "tipo": 2, "valor": 0, "quantidade": "0.02", "preco_medio": 10330.9, "itens_ativos_id": 55}	2	1709001029
16251	app\\models\\financas\\ItensAtivo	update	{"id": 55, "ativo": true, "ativo_id": 57, "quantidade": 0.1, "valor_bruto": "1033.09", "valor_compra": 1033.09, "investidor_id": 2, "valor_liquido": "1033.09"}	2	1709001029
16252	app\\models\\financas\\Operacao	update	{"id": 699, "data": "2022-06-17 11:25:59", "tipo": 1, "valor": "29959.9", "quantidade": "2.56", "preco_medio": 11703.09, "itens_ativos_id": 47}	2	1709001029
16253	app\\models\\financas\\Operacao	update	{"id": 739, "data": "2022-10-24 18:35:34", "tipo": 1, "valor": "980.27", "quantidade": "0.08", "preco_medio": 11719.76, "itens_ativos_id": 47}	2	1709001029
16254	app\\models\\financas\\Operacao	update	{"id": 740, "data": "2022-11-04 17:05:07", "tipo": 1, "valor": "492.23", "quantidade": "0.04", "preco_medio": 11728.51, "itens_ativos_id": 47}	2	1709001030
16255	app\\models\\financas\\Operacao	update	{"id": 754, "data": "2022-12-07 18:25:06", "tipo": 1, "valor": "497.58", "quantidade": "0.04", "preco_medio": 11738.96, "itens_ativos_id": 47}	2	1709001030
16256	app\\models\\financas\\Operacao	update	{"id": 760, "data": "2023-01-04 10:20:23", "tipo": 1, "valor": "1004.82", "quantidade": "0.08", "preco_medio": 11762.43, "itens_ativos_id": 47}	2	1709001030
16257	app\\models\\financas\\Operacao	update	{"id": 843, "data": "2023-06-28 11:30:41", "tipo": 0, "valor": "1500", "quantidade": "0.08", "preco_medio": 11762.43, "itens_ativos_id": 47}	2	1709001030
16258	app\\models\\financas\\ItensAtivo	update	{"id": 47, "ativo": true, "ativo_id": 52, "quantidade": 2.72, "valor_bruto": "34093.75", "valor_compra": 31993.805600000003, "investidor_id": 1, "valor_liquido": "31434.78"}	2	1709001030
16259	app\\models\\financas\\Operacao	update	{"id": 602, "data": "2021-06-11 15:20:00", "tipo": 1, "valor": "961.29", "quantidade": "0.09", "preco_medio": 10681, "itens_ativos_id": 23}	2	1709001030
16260	app\\models\\financas\\Operacao	update	{"id": 617, "data": "2021-09-06 12:05:00", "tipo": 1, "valor": "1298.46", "quantidade": "0.12", "preco_medio": 10760.71, "itens_ativos_id": 23}	2	1709001030
16261	app\\models\\financas\\Operacao	update	{"id": 650, "data": "2022-02-02 19:00:00", "tipo": 1, "valor": "1008.17", "quantidade": "0.09", "preco_medio": 10893.07, "itens_ativos_id": 23}	2	1709001030
16262	app\\models\\financas\\Operacao	update	{"id": 674, "data": "2022-04-04 09:45:51", "tipo": 1, "valor": "1028.33", "quantidade": "0.09", "preco_medio": 11016.03, "itens_ativos_id": 23}	2	1709001030
16263	app\\models\\financas\\Operacao	update	{"id": 687, "data": "2022-06-02 20:05:49", "tipo": 1, "valor": "1047.71", "quantidade": "0.09", "preco_medio": 11133.25, "itens_ativos_id": 23}	2	1709001030
16264	app\\models\\financas\\Operacao	update	{"id": 715, "data": "2022-08-03 16:20:53", "tipo": 1, "valor": "951.56", "quantidade": "0.08", "preco_medio": 11242, "itens_ativos_id": 23}	2	1709001030
16265	app\\models\\financas\\Operacao	update	{"id": 738, "data": "2022-10-05 18:35:19", "tipo": 1, "valor": "1095.45", "quantidade": "0.09", "preco_medio": 11370.72, "itens_ativos_id": 23}	2	1709001030
16266	app\\models\\financas\\Operacao	update	{"id": 755, "data": "2022-12-05 19:25:23", "tipo": 1, "valor": "994.19", "quantidade": "0.08", "preco_medio": 11486.52, "itens_ativos_id": 23}	2	1709001030
16267	app\\models\\financas\\Operacao	update	{"id": 844, "data": "2023-06-28 11:35:48", "tipo": 3, "valor": 0, "quantidade": "0.08", "preco_medio": 12900.25, "itens_ativos_id": 23}	2	1709001030
16268	app\\models\\financas\\ItensAtivo	update	{"id": 23, "ativo": true, "ativo_id": 41, "quantidade": 0.6499999999999999, "valor_bruto": "8385.16", "valor_compra": 8385.16, "investidor_id": 2, "valor_liquido": "8385.16"}	2	1709001030
16269	app\\models\\financas\\Operacao	update	{"id": 331, "data": "2020-09-02 14:35:00", "tipo": 1, "valor": "20604.98", "quantidade": "100", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16270	app\\models\\financas\\Operacao	update	{"id": 375, "data": "2021-01-26 14:00:00", "tipo": 1, "valor": "10000", "quantidade": "100", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16271	app\\models\\financas\\Operacao	update	{"id": 549, "data": "2021-04-22 08:25:00", "tipo": 1, "valor": "15000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16272	app\\models\\financas\\Operacao	update	{"id": 576, "data": "2021-05-03 11:30:00", "tipo": 1, "valor": "1000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16273	app\\models\\financas\\Operacao	update	{"id": 588, "data": "2021-05-26 21:00:00", "tipo": 1, "valor": "3000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16274	app\\models\\financas\\Operacao	update	{"id": 662, "data": "2022-01-04 09:25:26", "tipo": 1, "valor": "7000", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16275	app\\models\\financas\\Operacao	update	{"id": 684, "data": "2022-05-27 17:20:09", "tipo": 1, "valor": "1100", "quantidade": "1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16276	app\\models\\financas\\Operacao	update	{"id": 730, "data": "2022-10-07 14:35:21", "tipo": 1, "valor": "200", "quantidade": "0.001", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16277	app\\models\\financas\\Operacao	update	{"id": 737, "data": "2022-10-21 08:25:29", "tipo": 1, "valor": "6597", "quantidade": "0.1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16278	app\\models\\financas\\Operacao	update	{"id": 773, "data": "2023-02-02 09:25:20", "tipo": 1, "valor": "598", "quantidade": "0.1", "preco_medio": null, "itens_ativos_id": 40}	2	1709001030
16279	app\\models\\financas\\ItensAtivo	update	{"id": 40, "ativo": true, "ativo_id": 33, "quantidade": 200.19100000000006, "valor_bruto": "18205.01", "valor_compra": 16686.979999999996, "investidor_id": 1, "valor_liquido": "16686.98"}	2	1709001030
\.


--
-- Data for Name: auth_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_assignment (item_name, user_id, created_at) FROM stdin;
admin	2	\N
\.


--
-- Data for Name: auth_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_item (name, type, description, rule_name, data, created_at, updated_at) FROM stdin;
admin	1	papel do administrador	\N	\N	\N	\N
\.


--
-- Data for Name: auth_item_child; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_item_child (parent, child) FROM stdin;
\.


--
-- Data for Name: auth_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_rule (name, data, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: classes_operacoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes_operacoes (id, nome) FROM stdin;
1	app\\lib\\config\\atualizaAtivos\\rendaVariavel\\CalculaPorMediaPreco
2	app\\lib\\config\\atualizaAtivos\\rendaFixa\\cdbInter\\CalculaAritimeticaCDBInter
3	app\\lib\\config\\atualizaAtivos\\rendaFixa\\normais\\CalculaAritimetica
\.


--
-- Data for Name: investidor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investidor (id, cpf, nome) FROM stdin;
1	91999375599	anderson mota
2	99979974699	ana vitoria
\.


--
-- Data for Name: itens_ativo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itens_ativo (id, ativo_id, investidor_id, quantidade, valor_compra, valor_liquido, valor_bruto, ativo) FROM stdin;
2	5	1	0	0	0	0	f
16	26	1	0.00	-69.5199	0	0	f
19	10	1	0	-162.78003	1188	1188	f
7	2	1	0.0	142.90002	0	0	f
5	15	1	0	-100	0	0	f
1	13	1	0	-892.9099	0	0	f
3	4	1	0.00	-2797.4414	0	0	f
4	1	1	0.00	-343.8401	0	0	f
24	14	1	0	-3986.0999	0	0	f
18	9	1	0	-248.84009	2268	2268	f
6	7	1	0.0	167.09009	0	0	f
15	31	1	0.00000	-58.370117	0.0000000	0.0000000	f
47	52	1	2.72	31993.8056	31434.78	34093.75	t
23	41	2	0.65	8385.16	8385.16	8385.16	t
40	33	1	200.191	16686.98	16686.98	18205.01	t
50	55	2	6.13338	380.8	384.5015922	384.5015922	t
8	24	1	59	2137.66	1875.72	1875.72	t
11	39	1	80	8406.57	9505.53	9505.53	t
48	53	1	324	2565.75	2472.60	2472.60	t
52	55	1	28.52771	1912.68	1788.4021399	1788.4021399	t
14	39	2	99	10580.78	10118.79	10118.79	t
22	36	1	0.33	984.95	984.95	1068.21	t
53	57	1	0.71	9008.13	9008.13	7992.3	t
54	52	2	0.08	1012.86	1012.86	1012.86	t
20	11	1	1	1000	1000	1372.36	t
21	3	1	3.54	7963.17	7963.17	12899.76	t
25	20	1	174	4350.53	2510.82	2510.82	t
27	21	1	71	1509.68	2904.61	2904.61	t
31	23	1	616	4831.21	5001.92	5001.92	t
26	16	1	427	5110.23	3744.79	3744.79	t
28	17	1	288	4473.49	4066.56	4066.56	t
29	18	1	306	5180.16	3552.66	3552.66	t
30	19	1	85	3712.2	3485.85	3485.85	t
9	25	1	253	3667.58	2532.53	2532.53	t
45	29	2	1.339	195.19	141.35823	141.35823	t
32	29	1	17.2086	2783.35	1816.711902	1816.711902	t
33	30	1	21.2842	2111.97	2275.068138	2275.068138	t
41	30	2	2.94893	376.96	315.2111277	315.2111277	t
34	32	1	10.22714	2434.77	3121.1185852	3121.1185852	t
39	32	2	1.33286	365.54	406.7622148	406.7622148	t
35	34	1	8.75256	2342.84	2411.7679080	2411.7679080	t
42	35	2	1.61888	171.02	270.7900576	270.7900576	t
36	35	1	21.3964	1517.69	3578.975828	3578.975828	t
37	37	1	70.21576	2387.24	2649.2406248	2649.2406248	t
38	37	2	10.82491	373	408.4238543	408.4238543	t
10	38	1	48	8095.28	7799.52	7799.52	t
12	40	1	69	7105.8	7112.52	7112.52	t
17	40	2	10	1022	1030.80	1030.80	t
13	42	1	174	18020.09	14414.16	14414.16	t
43	49	1	129	15093.68	14490.57	14490.57	t
44	50	1	1.35168	277	320.0643072	320.0643072	t
46	51	1	0.01867941	2187	2753.04616344	2753.04616344	t
49	54	1	16.726	2006.81	2081.55070	2081.55070	t
51	54	2	1.61444	181.78	200.9170580	200.9170580	t
55	57	2	0.1	1033.09	1033.09	1033.09	t
\.


--
-- Data for Name: migration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration (version, apply_time) FROM stdin;
m000000_000000_base	1560091597
app\\migrations\\m190609_143226_inicio	1560092072
app\\migrations\\m190703_143226_dados_acao	1562509809
app\\migrations\\m190818_143226_campo_ativo	1566155358
app\\migrations\\m190818_163226_link_empresa_bolsa	1566157644
app\\migrations\\m190909_163226_balanco_empresa_bolsa	1575978125
app\\migrations\\m191210_163226_atualiza_compras_clear	1575978125
app\\migrations\\m191210_173226_uniqui_data_ativo_compras_clear	1575979461
app\\migrations\\m200202_173226_ajuste_tabela_fundamentos	1580653840
app\\migrations\\m200208_173226_unique_data_empresa_balanco	1583585767
app\\migrations\\m200224_173226_cria_enuns	1583585767
app\\migrations\\m200307_173226_remove_table_categoria	1583586173
app\\migrations\\m200307_183226_ajusta_tipo	1583673524
app\\migrations\\m200310_203226_ajusta_balanco	1583881740
app\\migrations\\m200315_203226_rank	1584300128
app\\migrations\\m200321_113226_notificacao	1584806784
yii\\queue\\db\\migrations\\M161119140200Queue	1585168594
yii\\queue\\db\\migrations\\M170307170300Later	1585168594
yii\\queue\\db\\migrations\\M170509001400Retry	1585168594
yii\\queue\\db\\migrations\\M170601155600Priority	1585168594
app\\migrations\\m200507_113226_add_tipo_criptomoedas	1588854236
app\\migrations\\m200507_133226_add_muda_tipo_quantidade_operacao	1588855960
app\\migrations\\m200507_143226_add_muda_tipo_quantidade_ativo	1588856684
app\\migrations\\m200801_143226_altera_cidogo_acao_empresa	1608120541
app\\migrations\\m200801_143227_insere_pais_ativo	1608120541
app\\migrations\\m210206_113226_add_tipo_metais	1612621919
app\\migrations\\m210206_113227_add_tipo_ETFs	1612628757
app\\migrations\\m210211_113227_add_atualiza_acao	1613055337
app\\migrations\\m210220_113227_add_tipo_FIIs	1613825282
app\\migrations\\m210220_113228_proventos	1613827645
app\\migrations\\m210220_113230_arvore	1615474235
app\\migrations\\m210612_090230_investidos	1623502444
app\\migrations\\m210612_095630_popula_ativo	1623502918
app\\migrations\\m210721_114530_unique_ativo	1626879564
app\\migrations\\m211115_104530_insere_itens_ativo	1639251011
app\\migrations\\m211115_114530_reestrutura_banco	1639251012
yii\\queue\\db\\migrations\\M211218163000JobQueueSize	1645144215
app\\migrations\\m211229_141830_upload_operacao	1645144216
app\\migrations\\m220212_113330_altera_tipo_dados_ativo	1645144216
app\\migrations\\m140506_102106_rbac_init	1649453824
app\\migrations\\m170907_052038_rbac_add_index_on_auth_assignment_user_id	1649453824
app\\migrations\\m180523_151638_rbac_updates_indexes_without_prefix	1649453824
app\\migrations\\m180609_110543_rbac_update_mssql_trigger	1649453824
app\\migrations\\m220306_200630_ativos_atualizar_import	1649453824
app\\migrations\\m220328_203730_user	1649453824
app\\migrations\\m220403_192930_popula_user	1654468965
app\\migrations\\m220409_143630_auditoria	1654468965
app\\migrations\\m220508_133630_altera_tipo_auth	1654468965
app\\migrations\\m220531_202830_add_movimentacao_proventos	1654468965
app\\migrations\\m220611_133400_add_FK_operacoes	1675725568
app\\migrations\\m221213_173400_classes_operacoes	1675725568
app\\migrations\\m221229_143400_insere_classes_operacoes	1675725568
app\\migrations\\m221230_103400_tabela_preco_media	1675725568
app\\migrations\\m230108_153400_insere_classes_operacoes	1675725568
app\\migrations\\m230121_203400_atualiza_nu	1675725568
app\\migrations\\m230128_143400_atualiza_manual	1675725568
app\\migrations\\m230212_093400_nome_config	1676212149
app\\migrations\\m230523_103400_remove_tabela_preco_medio	1684849779
app\\migrations\\m230601_153627_add_site_acoes	1687100001
app\\migrations\\m230603_101327_add_atualizaAcoes	1687100001
app\\migrations\\m230604_192427_alteraClassOperacoes	1687100001
app\\migrations\\m230702_142327_remove_coluna_acao_bolsa	1708888035
app\\migrations\\m230831_192327_corrige_import_proventos	1708888035
app\\migrations\\m231119_133227_crud_xpath	1708888035
app\\migrations\\m240202_143227_add_preco_medio	1708888035
\.


--
-- Data for Name: operacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operacao (id, quantidade, valor, data, tipo, itens_ativos_id, preco_medio) FROM stdin;
3	100	1241	2019-06-04 00:00:00	1	5	\N
15	1	1217.93	2017-02-13 00:00:00	1	6	\N
16	1	1198.49	2017-04-24 00:00:00	1	7	\N
17	2	2000	2019-02-18 00:00:00	1	18	\N
18	1	1000	2018-08-16 00:00:00	1	19	\N
9	1.04	10433.1	2019-06-20 00:00:00	1	3	\N
8	0.36	3501.51	2019-06-20 00:00:00	1	4	\N
2	48	531.2	2019-06-04 00:00:00	1	24	\N
21	0.02	202	2019-07-04 00:00:00	1	3	\N
11	1	3000	2019-06-20 00:00:00	1	1	\N
29	1	3892.91	2019-07-19 00:00:00	0	1	\N
80	5	100.8	2019-09-03 00:00:00	1	24	\N
86	5	87.8	2019-09-10 00:00:00	1	24	\N
102	4	70.2	2019-10-02 00:00:00	1	24	\N
108	14	238.42	2019-11-04 00:00:00	1	24	\N
93	11	193.16	2019-09-10 00:00:01	1	24	\N
130	18	280.26	2019-12-05 10:08:38	1	24	\N
22	100	1341	2019-07-10 00:00:00	0	5	\N
135	0.12	1255.76	2020-01-03 10:05:00	1	3	\N
136	0.09	941.5	2019-12-30 10:50:00	1	3	\N
137	0.05	521.29	2019-12-03 10:10:00	1	3	\N
196	0.09	945.38	2020-02-04 05:30:00	1	3	\N
235	0.5	555.86	2020-02-17 08:50:00	0	6	\N
236	0.5	555.86	2020-02-17 08:50:00	0	7	\N
237	0.54	1100.12	2020-02-21 10:30:00	1	16	\N
243	0.05	89.29	2020-03-16 21:25:00	1	16	\N
244	0.02	210.87	2020-03-13 21:30:00	1	3	\N
288	0.03	317.41	2020-04-17 12:25:00	1	3	\N
290	0.21	2222.23	2020-04-20 20:35:00	1	3	\N
305	0.24	428.2	2020-06-02 08:35:00	1	16	\N
322	1	191.8	2020-08-03 10:48:00	1	15	\N
326	0.8558	169.66	2020-11-05 14:11:00	1	15	\N
329	1.67	19847	2020-09-15 14:25:00	0	3	\N
330	0.36	3845.35	2020-09-28 14:30:00	0	4	\N
360	1	500	2020-12-28 09:05:00	0	40	\N
31	13	513.24	2019-08-02 00:00:00	1	8	39.48
368	0.8679	188.98	2021-01-05 11:45:00	1	15	\N
370	1	750	2021-01-16 10:55:00	0	40	\N
375	100	10000	2021-01-26 14:00:00	1	40	\N
389	85	4469.14	2021-02-08 12:31:03	0	24	\N
408	0.8581	180.02	2021-02-12 15:00:00	1	15	\N
411	0.5	499.73	2021-02-17 07:00:00	0	7	\N
412	0.5	494.98	2021-02-17 07:00:00	0	6	\N
467	0.8298	179.39	2021-03-02 12:10:00	1	15	\N
473	1.3369	298.66	2021-03-08 15:00:00	1	15	\N
489	1.3295	298.71	2021-03-17 13:25:00	1	15	\N
526	0.7844	174	2021-04-08 11:05:00	1	15	\N
539	0.7602	171.36	2021-04-15 10:35:00	1	15	\N
549	1	15000	2021-04-22 08:25:00	1	40	\N
562	0.7706	177.64	2021-04-27 11:25:00	1	15	\N
576	1	1000	2021-05-03 11:30:00	1	40	\N
588	1	3000	2021-05-26 21:00:00	1	40	\N
597	40	0	2021-05-30 11:15:00	2	24	\N
601	0.45194	105.01	2021-06-08 13:30:00	1	15	\N
616	0.83	1687.13	2021-09-14 17:10:00	0	16	\N
618	1.249	279.99	2021-09-28 19:30:00	1	15	\N
620	60	1018.8	2021-10-08 13:35:21	0	24	\N
646	2	2248.84	2022-02-02 14:15:00	0	18	\N
647	1	1162.78	2022-02-02 14:20:00	0	19	\N
660	1	2451	2022-01-20 06:05:56	0	40	\N
661	1	4500	2022-02-08 11:10:12	0	40	\N
662	1	7000	2022-01-04 09:25:26	1	40	\N
684	1	1100	2022-05-27 17:20:09	1	40	\N
698	0.1	30000	2022-06-17 10:50:12	0	40	\N
717	0.01	800	2022-08-29 09:45:27	0	40	\N
730	0.001	200	2022-10-07 14:35:21	1	40	\N
737	0.1	6597	2022-10-21 08:25:29	1	40	\N
753	0.1	3000	2022-12-07 10:30:44	0	40	\N
768	11.09414	2473.59	2023-01-17 14:25:58	0	15	\N
771	0.1	2192	2023-01-11 10:20:16	0	40	\N
773	0.1	598	2023-02-02 09:25:20	1	40	\N
791	0.1	700	2023-02-28 12:25:25	0	40	\N
792	0.1	1360	2023-02-20 17:25:20	0	40	\N
801	0.1	400	2023-03-22 17:35:56	0	40	\N
798	0.1	600	2023-03-14 08:20:24	0	40	\N
799	0.1	250	2023-03-18 08:20:52	0	40	\N
795	0.1	360	2023-03-11 18:10:00	0	40	\N
794	0.1	550	2023-03-09 18:10:23	0	40	\N
331	100	20604.98	2020-09-02 14:35:00	1	40	\N
742	3.05	191.05	2022-11-04 10:50:16	1	50	62.64
800	3.08338	189.75	2023-03-06 10:00:00	1	50	62.09
729	23	963.7	2022-10-04 13:54:23	0	8	32.38
747	23	976.12	2022-11-09 14:16:46	0	8	32.38
785	30	1020	2023-02-13 13:40:02	0	8	32.38
818	7	0	2023-06-21 17:05:07	3	8	36.23
805	2	177.36	2021-11-29 10:50:00	1	11	111.32
710	1	95.27	2022-07-26 11:06:44	1	11	109.09
757	2	192.16	2022-12-15 13:50:02	1	11	108.67
72	8	297.36	2019-08-16 00:00:00	1	8	38.6
83	9	321.12	2019-09-03 00:00:00	1	8	37.72
89	2	74.1	2019-09-10 00:00:00	1	8	37.68
105	6	209.64	2019-10-02 00:00:00	1	8	37.25
134	11	367.18	2019-12-05 10:02:24	1	8	36.38
275	5	138.2	2020-04-02 10:35:55	1	8	35.57
316	4	147.96	2020-09-02 13:00:00	1	8	35.67
366	4	132.12	2021-01-05 11:04:51	1	8	35.5
379	32	999.04	2021-01-28 13:54:59	1	8	34.04
491	4	123.28	2021-03-18 11:24:09	1	8	33.91
496	1	31.68	2021-03-22 12:39:04	1	8	33.89
502	3	92.1	2021-03-25 13:44:51	1	8	33.79
508	4	122	2021-03-29 10:05:22	1	8	33.67
515	1	28.87	2021-04-01 10:34:14	1	8	33.63
525	35	1000.65	2021-04-08 11:01:55	1	8	32.38
459	8	969.44	2021-02-24 14:10:48	1	11	121.18
479	1	115.89	2021-03-12 10:57:40	1	11	120.59
488	8	907.2	2021-03-17 13:26:11	1	11	117.21
494	8	907.12	2021-03-19 11:50:00	1	11	115.99
503	8	904.64	2021-03-25 13:43:03	1	11	115.28
511	8	919.99	2021-03-30 10:43:46	1	11	115.23
532	8	928.48	2021-04-12 13:11:23	1	11	115.36
551	8	918.4	2021-04-22 11:04:20	1	11	115.28
568	8	919.12	2021-04-29 16:15:40	1	11	115.24
570	1	115.38	2021-04-30 12:08:36	1	11	115.24
584	8	918.97	2021-05-05 14:06:53	1	11	115.2
626	5	512.7	2021-10-15 10:18:05	1	11	114.4
628	10	958	2021-11-04 13:05:18	1	11	112.31
633	2	179.64	2021-11-16 14:02:00	1	11	111.81
635	10	919	2021-12-06 12:10:00	1	11	109.43
675	1	97.91	2022-04-14 15:27:11	1	11	109.32
697	45	4265.55	2022-06-17 10:23:53	0	11	109.32
766	1	93.17	2023-01-17 14:01:55	1	11	108.42
781	12	1089.84	2023-02-13 13:42:34	1	11	105.6
811	5	486.29	2023-04-24 16:09:46	1	11	105.08
714	6	47.76	2022-08-15 13:19:32	1	48	7.96
716	8	65.36	2022-08-25 14:12:51	1	48	8.08
718	55	457.6	2022-08-31 13:17:08	1	48	8.27
721	2	16.58	2022-09-15 10:11:51	1	48	8.27
723	6	50.22	2022-09-26 14:43:06	1	48	8.28
725	9	75.51	2022-10-04 14:00:54	1	48	8.29
733	8	69.2	2022-10-14 13:39:40	1	48	8.32
735	10	85.9	2022-10-17 14:04:32	1	48	8.35
743	9	74.79	2022-11-09 14:19:07	1	48	8.34
750	14	113.12	2022-11-28 10:37:33	1	48	8.32
751	4	31.64	2022-12-13 15:27:25	1	48	8.3
756	7	55.86	2022-12-15 13:50:35	1	48	8.29
758	10	81.7	2022-12-29 10:41:00	1	48	8.28
761	8	63.84	2023-01-12 14:12:21	1	48	8.26
764	2	15.98	2023-01-17 14:03:39	1	48	8.26
772	7	56.98	2023-01-25 10:22:09	1	48	8.25
775	21	167.79	2023-02-08 11:13:40	1	48	8.22
780	117	930.15	2023-02-13 13:44:13	1	48	8.12
787	2	16.02	2023-02-22 16:31:29	1	48	8.12
790	6	47.82	2023-02-28 17:00:09	1	48	8.12
796	9	71.37	2023-03-15 10:19:43	1	48	8.11
802	7	55.02	2023-03-28 14:11:59	1	48	8.1
810	3	23.37	2023-04-24 16:10:13	1	48	8.1
812	7	53.97	2023-04-26 16:22:59	1	48	8.09
816	20	200	2023-05-23 09:55:35	0	48	8.09
817	7	0	2023-06-21 20:05:11	2	48	7.92
769	19.40347	1300	2023-01-17 14:25:54	1	52	67
778	9.12424	612.68	2023-02-08 11:35:17	1	52	67.05
629	11	1053.18	2021-11-05 14:25:00	1	14	95.74
836	100	10000	2023-06-25 12:10:56	1	14	99.58
837	10	1100	2023-06-25 12:15:43	0	14	99.58
838	100	0	2023-06-25 12:20:06	2	14	50.04
839	15	1500	2023-06-25 12:25:28	0	14	50.04
840	100	0	2023-06-25 12:30:56	3	14	108.22
841	13	1274	2023-06-25 12:35:33	1	14	106.88
415	0.33	984.95	2021-02-18 12:05:00	1	22	2984.7
774	0.55	6952.45	2023-02-02 09:30:54	1	53	12640.82
793	0.08	1022.59	2023-03-06 13:25:24	1	53	12658.79
803	0.08	1033.09	2023-04-04 13:50:20	1	53	12687.51
776	0.08	1012.86	2023-02-02 11:20:02	1	54	12660.75
19	1	1000	2019-06-06 00:00:00	1	20	1000
10	3.35	7399.46	2019-06-20 00:00:00	1	21	2208.79
230	0.02	56.32	2019-08-13 10:25:00	1	21	2212.4
229	0.17	507.39	2020-02-04 10:15:00	1	21	2249.48
25	39	928.98	2019-07-24 00:00:00	1	25	23.82
81	5	120.3	2019-09-03 00:00:00	1	25	23.85
92	6	141.42	2019-09-10 00:00:00	1	25	23.81
98	1	25.27	2019-10-02 00:00:00	1	25	23.84
113	8	206.08	2019-11-04 00:00:00	1	25	24.1
278	22	444.4	2020-04-02 10:34:36	1	25	23.04
292	2	44.26	2020-05-05 11:27:19	1	25	23.02
307	1	24.86	2020-07-02 11:55:59	1	25	23.04
312	17	425.34	2020-07-30 12:55:00	1	25	23.38
413	35	973.35	2021-02-18 11:52:14	1	25	24.52
547	37	994.92	2021-04-20 14:19:31	1	25	25.02
625	1	21.35	2021-10-15 10:18:26	1	25	25
24	43	991.58	2019-07-24 00:00:00	1	27	23.06
79	4	91.28	2019-09-03 00:00:00	1	27	23.04
90	5	115.85	2019-09-10 00:00:00	1	27	23.05
103	3	72.42	2019-10-02 00:00:00	1	27	23.11
110	3	78.63	2019-11-04 00:00:00	1	27	23.27
232	1	41.29	2020-02-04 12:55:24	1	27	23.58
320	13	1055.34	2020-11-12 13:05:00	0	27	23.58
452	1	82.49	2021-02-22 12:40:46	1	27	24.83
529	13	970.84	2021-04-09 11:08:18	1	27	35.63
577	60	0	2021-04-28 11:35:00	2	27	17.82
575	29	1012.39	2021-05-03 11:24:34	1	27	21.14
614	1	39.78	2021-09-16 13:39:05	1	27	21.27
728	29	959.61	2022-10-04 13:56:16	0	27	21.27
746	24	989.24	2022-11-09 14:17:42	0	27	21.27
783	26	1007.24	2023-02-13 13:41:36	0	27	21.27
30	26	201.5	2019-07-25 00:00:00	1	31	7.75
32	58	435	2019-08-02 00:00:00	1	31	7.58
73	1	7.3	2019-08-16 00:00:00	1	31	7.57
76	5	36.95	2019-08-26 00:00:00	1	31	7.56
84	49	380.24	2019-09-03 00:00:00	1	31	7.63
77	1	7.81	2019-09-03 00:00:01	1	31	7.63
88	8	64	2019-09-10 00:00:00	1	31	7.65
95	1	8.48	2019-10-02 00:00:00	1	31	7.66
101	7	59.36	2019-10-02 00:00:01	1	31	7.7
131	5	56.05	2019-12-05 10:05:34	1	31	7.81
129	1	11.32	2019-12-05 10:09:23	1	31	7.83
239	14	140.42	2020-03-03 13:47:13	1	31	8
277	32	231.04	2020-04-02 10:35:12	1	31	7.88
295	27	193.32	2020-05-05 11:25:32	1	31	7.8
306	55	424.05	2020-07-02 12:12:19	1	31	7.78
318	1	7.84	2020-10-07 13:05:00	1	31	7.78
367	1	8.12	2021-01-05 11:22:51	1	31	7.78
382	12	93.36	2021-02-01 14:35:18	1	31	7.78
385	2	15.8	2021-02-02 13:20:31	1	31	7.78
396	99	747.45	2021-02-08 16:15:03	1	31	7.73
391	1	7.55	2021-02-08 16:18:59	1	31	7.73
450	1	7.49	2021-02-22 12:41:41	1	31	7.73
461	4	29.56	2021-02-25 14:23:11	1	31	7.72
490	1	8.11	2021-03-18 11:24:37	1	31	7.72
507	3	23.4	2021-03-29 10:06:07	1	31	7.72
512	7	55.23	2021-03-31 11:00:58	1	31	7.73
514	1	8	2021-04-01 10:34:33	1	31	7.73
519	1	8.1	2021-04-06 10:49:55	1	31	7.73
521	1	8.33	2021-04-07 14:38:42	1	31	7.73
524	3	25.14	2021-04-08 11:02:27	1	31	7.73
528	4	33.36	2021-04-09 11:22:59	1	31	7.74
531	8	66.8	2021-04-12 13:12:04	1	31	7.75
533	1	8.47	2021-04-13 10:59:15	1	31	7.75
537	1	8.66	2021-04-15 10:29:29	1	31	7.75
540	1	8.8	2021-04-16 11:33:09	1	31	7.76
543	3	26.82	2021-04-19 10:53:41	1	31	7.77
546	1	8.94	2021-04-20 14:19:49	1	31	7.77
550	10	89.8	2021-04-22 11:04:49	1	31	7.79
554	17	137.19	2021-04-23 16:37:00	1	31	7.8
558	5	40.4	2021-04-26 12:14:07	1	31	7.81
561	100	790	2021-04-27 11:24:51	1	31	7.82
560	27	213.3	2021-04-27 11:26:11	1	31	7.83
569	2	15.82	2021-04-30 12:08:55	1	31	7.83
574	2	16.24	2021-05-03 11:24:51	1	31	7.83
582	3	26.4	2021-05-05 14:08:24	1	31	7.83
622	1	10.99	2021-07-23 13:55:00	1	31	7.84
610	1	10.79	2021-08-27 10:20:41	1	31	7.84
806	1	8.11	2022-01-03 00:00:00	1	31	7.84
23	100	1358	2019-07-10 00:00:00	1	26	13.58
85	1	12.97	2019-09-10 00:00:00	1	26	13.57
99	3	38.13	2019-10-02 00:00:00	1	26	13.55
111	6	83.34	2019-11-04 00:00:00	1	26	13.57
133	12	164.28	2019-12-05 10:03:17	1	26	13.58
240	23	298.77	2020-03-03 13:46:50	1	26	13.49
293	2	21.06	2020-05-05 11:26:14	1	26	13.45
303	26	280.02	2020-06-02 10:56:15	1	26	13.04
308	20	227.2	2020-07-02 11:54:57	1	26	12.87
315	36	385.2	2020-09-02 13:00:00	1	26	12.53
394	99	1149.94	2021-02-08 16:17:07	1	26	12.25
485	1	11.06	2021-03-16 10:30:47	1	26	12.25
541	90	993.6	2021-04-16 11:32:47	1	26	11.99
553	1	11.11	2021-04-23 16:37:33	1	26	11.99
611	5	57.05	2021-08-27 10:19:55	1	26	11.98
807	2	18.5	2022-01-03 00:00:00	1	26	11.97
26	55	995.5	2019-07-24 00:00:00	1	28	18.1
91	7	132.58	2019-09-10 00:00:00	1	28	18.19
96	1	18.93	2019-10-02 00:00:00	1	28	18.21
104	7	132.51	2019-10-02 00:00:01	1	28	18.28
109	17	295.62	2019-11-04 00:00:00	1	28	18.11
242	40	595.6	2020-03-03 13:45:40	1	28	17.09
238	1	14.87	2020-03-03 13:48:26	1	28	17.08
294	13	156.26	2020-05-05 11:25:54	1	28	16.61
291	1	12.01	2020-05-05 11:27:56	1	28	16.58
311	6	94.14	2020-07-30 12:50:00	1	28	16.54
314	39	493.62	2020-09-02 12:55:00	1	28	15.73
369	1	16.53	2021-01-12 12:28:20	1	28	15.73
392	14	209.3	2021-02-08 16:18:23	1	28	15.68
483	5	75.95	2021-03-16 10:28:26	1	28	15.67
500	9	135.54	2021-03-24 10:21:43	1	28	15.64
504	1	14.97	2021-03-25 13:46:27	1	28	15.64
505	2	30.64	2021-03-26 11:28:00	1	28	15.64
520	66	1002.54	2021-04-06 10:49:22	1	28	15.53
613	1	16.18	2021-09-16 13:40:25	1	28	15.54
666	2	30.2	2022-03-29 11:02:14	1	28	15.53
27	24	1000.08	2019-07-24 00:00:00	1	29	41.67
97	1	42.96	2019-10-02 00:00:00	1	29	41.72
107	6	257.88	2019-10-02 00:00:01	1	29	41.97
241	7	347.9	2020-03-03 13:46:22	1	29	43.39
276	5	174.6	2020-04-02 10:35:32	1	29	42.41
393	20	1244.28	2021-02-08 16:17:39	1	29	48.69
451	1	54.35	2021-02-22 12:41:22	1	29	48.78
535	17	943.67	2021-04-13 10:58:24	1	29	50.19
534	1	55.5	2021-04-13 10:58:37	1	29	50.26
564	18	956.7	2021-04-28 10:44:44	1	29	50.78
579	1	50.55	2021-05-04 16:43:52	1	29	50.78
583	1	51.69	2021-05-05 14:07:28	1	29	50.79
587	204	0	2021-05-17 08:55:00	2	29	16.93
28	21	989.52	2019-07-24 00:00:00	1	30	47.12
82	3	133.68	2019-09-03 00:00:00	1	30	46.8
78	1	44.5	2019-09-03 00:00:01	1	30	46.71
106	5	220.05	2019-10-02 00:00:00	1	30	46.26
112	2	92.32	2019-11-04 00:00:00	1	30	46.25
132	3	140.22	2019-12-05 10:04:08	1	30	46.29
234	1	53.02	2020-02-04 12:54:17	1	30	46.48
274	2	76.48	2020-04-02 10:37:53	1	30	46.05
296	5	196.35	2020-05-05 11:25:10	1	30	45.26
309	8	344.72	2020-07-02 11:54:35	1	30	44.92
317	1	40.29	2020-10-07 13:05:00	1	30	44.83
386	22	986.48	2021-02-02 13:19:24	1	30	44.83
476	1	39.02	2021-03-10 10:29:13	1	30	44.76
487	2	83.64	2021-03-17 13:26:47	1	30	44.68
510	2	82.1	2021-03-30 10:44:56	1	30	44.59
516	3	125.79	2021-04-01 10:33:48	1	30	44.49
523	23	953.58	2021-04-07 14:37:49	1	30	43.83
522	1	41.46	2021-04-07 14:38:14	1	30	43.8
563	1	41.49	2021-04-28 10:45:05	1	30	43.78
567	2	83.36	2021-04-29 16:16:01	1	30	43.74
598	1	40.19	2021-06-01 12:22:26	1	30	43.71
621	1	39.36	2021-07-23 13:55:00	1	30	43.67
786	26	1001.52	2023-02-13 13:39:17	0	30	43.67
66	3	48.72	2019-08-13 00:00:00	1	9	16.24
70	55	897.6	2019-08-16 00:00:00	1	9	16.32
94	16	252.96	2019-09-10 00:00:00	1	9	16.21
87	8	126.8	2019-09-10 00:00:01	1	9	16.17
804	8	126.8	2019-09-10 09:45:00	1	9	16.14
100	3	47.16	2019-10-02 00:00:00	1	9	16.13
114	14	215.04	2019-11-04 00:00:00	1	9	16.03
297	14	207.2	2020-05-05 11:24:41	1	9	15.89
304	26	357.76	2020-06-02 10:55:20	1	9	15.51
313	33	486.75	2020-07-30 12:55:00	1	9	15.37
319	2	25.04	2020-10-07 13:00:00	1	9	15.34
395	81	1109.7	2021-02-08 16:16:35	1	9	14.83
475	1	12.58	2021-03-10 10:30:17	1	9	14.83
538	77	1031.03	2021-04-15 10:29:05	1	9	14.5
607	2	26.54	2021-08-03 15:01:52	1	9	14.49
784	90	1076.4	2023-02-13 13:40:55	0	9	14.49
664	0.06695	195.19	2022-03-15 15:28:00	1	45	2915.46
689	1.27205	0	2022-06-11 10:10:00	2	45	145.77
324	0.0696	221.8	2020-08-06 10:41:00	1	32	3186.78
328	0.0607	191.06	2020-11-17 12:35:00	1	32	3168.53
387	0.053	180.14	2021-02-03 14:50:00	1	32	3235.13
414	0.0554	182.81	2021-02-18 11:55:00	1	32	3250.15
464	0.0585	180.38	2021-02-26 12:55:00	1	32	3217.33
472	0.1024	299.38	2021-03-05 14:05:00	1	32	3142.07
486	0.096	298.35	2021-03-16 14:25:00	1	32	3135.43
527	0.0574	190.45	2021-04-09 11:05:00	1	32	3154.38
548	0.052	173.3	2021-04-20 14:20:00	1	32	3169.7
566	0.0533	184.5	2021-04-29 16:15:00	1	32	3193.33
586	0.05458	180.98	2021-05-07 11:25:00	1	32	3202.71
627	0.07257	246.19	2021-10-28 10:50:00	1	32	3220.24
638	0.07498	254.01	2021-12-29 12:45:00	1	32	3234.84
688	16.34817	0	2022-06-11 10:00:20	2	32	161.74
323	0.1255	186.86	2020-08-04 10:33:00	1	33	1488.92
325	0.1192	174.71	2020-10-05 10:33:00	1	33	1477.61
376	0.0996	182.13	2021-01-27 14:00:00	1	33	1579.15
457	0.0865	179.8	2021-02-24 14:30:00	1	33	1679.43
469	0.0839	172.62	2021-03-03 11:40:00	1	33	1741.05
477	0.1463	300.42	2021-03-10 11:40:00	1	33	1810.2
495	0.1521	308.1	2021-03-22 12:25:00	1	33	1850.5
545	0.0753	173.06	2021-04-19 10:55:00	1	33	1888.45
578	0.0775	184.32	2021-05-03 11:40:00	1	33	1927.76
643	0.09831	249.95	2022-01-25 13:40:00	1	33	1984.54
708	20.21999	0	2022-07-24 11:50:14	2	33	99.23
637	0.05867	172.97	2021-12-07 12:15:00	1	41	2948.18
706	0.08879	203.99	2022-07-08 16:30:22	1	41	2556.35
709	2.80147	0	2022-07-24 11:55:05	2	41	127.83
321	1	214.5	2020-08-03 10:48:00	1	34	214.5
327	1.2466	269.54	2020-11-13 11:32:00	1	34	215.45
388	0.7365	178.09	2021-02-05 14:35:00	1	34	221.96
455	0.782	179.18	2021-02-23 11:40:00	1	34	223.45
468	0.7316	169.27	2021-03-03 11:40:00	1	34	224.74
474	1.285	300.52	2021-03-09 12:00:00	1	34	226.77
493	1.2809	298.39	2021-03-18 13:45:00	1	34	227.89
542	0.644	167.54	2021-04-16 11:30:00	1	34	230.59
565	0.6751	172.39	2021-04-28 10:45:00	1	34	232.58
581	0.7295	180.35	2021-05-04 16:45:00	1	34	233.75
678	1.11594	305	2022-04-26 14:48:00	1	34	238.07
624	0.60641	179	2021-10-08 16:25:00	1	39	295.18
719	0.72645	186.54	2022-09-02 10:35:49	1	39	274.25
381	0.7243	179.08	2021-01-29 13:50:00	1	35	247.25
383	0.7101	176.18	2021-02-01 16:00:00	1	35	247.67
384	0.709	177.62	2021-02-02 13:05:00	1	35	248.61
406	0.6618	170.88	2021-02-11 11:30:00	1	35	250.88
460	0.6936	178.91	2021-02-25 11:50:00	1	35	252.28
471	0.6691	168.15	2021-03-04 11:55:00	1	35	252.12
478	1.147	300.38	2021-03-11 11:30:00	1	35	254.23
501	0.6572	175.9	2021-03-24 11:20:00	1	35	255.71
536	0.6149	176.23	2021-04-13 11:00:00	1	35	258.59
552	0.6038	176.03	2021-04-22 11:05:00	1	35	261.36
572	0.6148	178.36	2021-04-30 12:10:00	1	35	263.62
603	0.94696	285.12	2021-06-14 11:20:00	1	35	267.67
640	1.61888	171.02	2022-01-04 12:00:00	1	42	105.64
390	2.5413	180.05	2021-02-08 12:35:00	1	36	70.85
397	2.4983	178.95	2021-02-09 13:25:00	1	36	71.24
398	2.56	181.76	2021-02-10 14:20:00	1	36	71.16
407	2.6141	192.42	2021-02-11 11:35:00	1	36	71.78
465	2.4472	178.06	2021-03-01 13:35:00	1	36	71.97
470	2.5042	176.19	2021-03-04 11:55:00	1	36	71.71
481	4.2091	298.13	2021-03-12 15:50:00	1	36	71.52
498	2.5458	176.12	2021-03-23 10:50:00	1	36	71.24
518	5.0271	342.4	2021-04-06 10:45:00	1	36	70.66
557	2.4493	181.05	2021-04-26 12:15:00	1	36	70.93
777	8	1126.8	2023-02-08 11:30:35	0	36	70.93
416	10.5294	179	2021-02-19 15:40:00	1	37	17
454	10.5047	181.09	2021-02-22 13:00:00	1	37	17.12
456	9.9272	170.65	2021-02-23 11:40:00	1	37	17.14
458	10.4312	179.09	2021-02-24 14:30:00	1	37	17.15
463	10.6007	174.69	2021-02-26 12:55:00	1	37	17.01
466	11.3856	187.05	2021-03-02 12:10:00	1	37	16.91
482	18.0914	298.13	2021-03-15 11:40:00	1	37	16.81
530	10.2518	169.35	2021-04-12 13:00:00	1	37	16.78
556	10.6383	179.99	2021-04-23 16:40:00	1	37	16.79
585	10.6007	180.2	2021-05-05 14:15:00	1	37	16.81
596	56.4805	0	2021-05-27 11:05:00	3	37	33.63
605	5.62483	194	2021-07-06 10:00:00	1	37	33.7
668	8.11043	294	2022-03-29 10:58:00	1	37	34
606	5.34308	183	2021-07-21 12:00:00	1	38	34.25
682	5.48183	190	2022-05-16 16:41:00	1	38	34.46
453	5	882.95	2021-02-22 12:40:10	1	10	176.59
480	5	883.3	2021-03-12 10:54:13	1	10	176.63
492	5	876.23	2021-03-18 11:22:34	1	10	176.17
499	5	863.15	2021-03-24 10:12:50	1	10	175.28
509	5	852.5	2021-03-29 10:03:38	1	10	174.33
517	11	1913.56	2021-04-01 10:33:02	1	10	174.21
555	5	859.56	2021-04-23 16:36:32	1	10	173.93
571	5	864.15	2021-04-30 12:08:15	1	10	173.81
600	5	847.75	2021-06-01 12:21:12	1	10	173.4
694	20	3264.8	2022-06-15 13:50:38	0	10	173.4
782	13	2079.22	2023-02-13 13:42:07	1	10	169.42
789	1	160.37	2023-02-22 16:30:30	1	10	169.22
797	3	480.54	2023-03-15 10:19:10	1	10	168.65
462	9	987.73	2021-02-26 10:19:13	1	12	109.75
484	9	947.07	2021-03-16 10:27:43	1	12	107.49
497	12	1255.56	2021-03-22 12:38:10	1	12	106.35
506	10	1033.1	2021-03-26 11:27:23	1	12	105.59
513	9	944.93	2021-03-31 10:59:53	1	12	105.48
544	9	964.53	2021-04-19 10:53:14	1	12	105.74
559	9	952.83	2021-04-26 12:13:44	1	12	105.76
580	9	946.08	2021-05-04 16:42:34	1	12	105.68
599	5	525.7	2021-06-01 12:21:46	1	12	105.65
634	10	867.95	2021-11-26 10:05:00	1	12	103.58
636	2	185.06	2021-12-14 12:15:00	1	12	103.34
702	40	3850.06	2022-06-24 15:16:05	0	12	103.34
705	1	91.75	2022-07-08 13:33:34	1	12	103.12
744	10	1044.4	2022-11-09 14:18:46	1	12	103.33
752	3	295.38	2022-12-13 15:26:53	1	12	103.11
765	1	99.37	2023-01-17 14:03:21	1	12	103.06
788	1	97.96	2023-02-22 16:31:08	1	12	102.98
609	10	1022	2021-08-04 10:50:00	1	17	102.2
604	13	1448.2	2021-06-24 16:52:18	1	13	111.4
623	8	897.32	2021-07-23 13:55:00	1	13	111.69
608	9	989.64	2021-08-03 15:01:04	1	13	111.17
612	15	1618.7	2021-08-27 10:17:01	1	13	110.09
615	22	2386.9	2021-09-16 13:38:12	1	13	109.56
619	10	1085.8	2021-10-08 13:37:12	1	13	109.44
632	1	101.81	2021-11-12 10:25:00	1	13	109.34
651	1	105.17	2021-12-22 13:45:46	1	13	109.29
639	1	105	2021-12-29 12:50:00	1	13	109.23
808	2	208.68	2022-01-03 00:00:00	1	13	109.11
641	2	209.6	2022-01-19 17:35:00	1	13	109.01
644	1	105.8	2022-01-25 13:50:00	1	13	108.97
649	10	1044.1	2022-02-02 14:30:00	1	13	108.49
667	1	104.14	2022-03-29 11:00:52	1	13	108.45
669	1	103.75	2022-04-04 15:49:39	1	13	108.4
676	2	205.96	2022-04-14 15:26:51	1	13	108.29
679	5	499.65	2022-05-05 11:25:51	1	13	107.89
692	1	99	2022-06-15 13:52:41	1	13	107.8
696	42	4166.4	2022-06-17 10:25:06	1	13	105.34
695	1	99	2022-06-17 10:25:43	1	13	105.3
722	3	282.09	2022-09-15 10:11:34	1	13	105.08
724	3	287.4	2022-09-26 14:42:41	1	13	104.9
726	8	732	2022-10-04 13:59:07	1	13	104.24
734	1	94.98	2022-10-14 13:39:11	1	13	104.18
745	10	949.8	2022-11-09 14:18:12	1	13	103.65
767	1	89.2	2023-01-17 14:01:34	1	13	103.56
648	19	2252.43	2022-02-02 14:30:00	1	43	118.55
653	4	455.58	2022-02-18 14:49:12	1	43	117.74
659	1	111.6	2022-03-03 10:21:27	1	43	117.48
663	3	327.9	2022-03-15 11:40:26	1	43	116.57
665	1	111.28	2022-03-18 19:30:13	1	43	116.39
673	1	119.05	2022-04-08 13:14:21	1	43	116.48
677	2	236.8	2022-04-14 15:14:42	1	43	116.6
681	2	232.4	2022-05-13 10:05:01	1	43	116.58
680	1	116.2	2022-05-13 10:07:13	1	43	116.57
683	1	114.95	2022-05-25 16:33:29	1	43	116.52
686	4	463.16	2022-06-02 10:10:27	1	43	116.44
690	1	114.69	2022-06-13 13:06:43	1	43	116.4
691	1	114.86	2022-06-14 14:51:40	1	43	116.36
693	29	3320.5	2022-06-15 13:51:54	1	43	115.59
701	33	3805.89	2022-06-24 15:17:07	1	43	115.51
700	1	115.33	2022-06-24 15:17:39	1	43	115.51
704	1	115.12	2022-07-08 13:31:03	1	43	115.5
707	3	355.39	2022-07-18 10:20:21	1	43	115.58
712	1	119.23	2022-08-08 14:50:03	1	43	115.62
713	2	244.3	2022-08-15 13:08:46	1	43	115.74
720	1	127.13	2022-09-09 13:33:42	1	43	115.84
727	9	1134.23	2022-10-04 13:58:38	1	43	116.6
731	2	249.4	2022-10-10 10:30:53	1	43	116.73
748	1	126.65	2022-11-09 14:15:28	1	43	116.81
749	2	246.92	2022-11-16 10:13:02	1	43	116.91
759	2	242.56	2022-12-29 10:40:36	1	43	116.98
762	1	120.13	2023-01-12 14:11:44	1	43	117.01
658	1.35168	277	2022-02-23 11:36:00	1	44	204.93
685	0.00119476	187	2022-05-29 16:15:48	1	46	156516.79
703	0.01272254	1400	2022-06-28 12:55:51	1	46	114030.74
711	0.00476211	600	2022-07-29 13:15:59	1	46	117080.79
732	3.01241	301	2022-10-11 14:55:00	1	49	99.92
770	9.75678	1191.69	2023-01-17 14:25:36	1	49	116.9
779	3.95681	514.12	2023-02-08 11:35:53	1	49	119.98
763	1.61444	181.78	2023-01-05 14:15:42	1	51	112.6
809	0.08	1033.09	2023-04-04 08:55:28	1	55	12913.63
842	0.02	0	2023-06-28 11:30:13	2	55	10330.9
699	2.56	29959.9	2022-06-17 11:25:59	1	47	11703.09
739	0.08	980.27	2022-10-24 18:35:34	1	47	11719.76
740	0.04	492.23	2022-11-04 17:05:07	1	47	11728.51
754	0.04	497.58	2022-12-07 18:25:06	1	47	11738.96
760	0.08	1004.82	2023-01-04 10:20:23	1	47	11762.43
843	0.08	1500	2023-06-28 11:30:41	0	47	11762.43
602	0.09	961.29	2021-06-11 15:20:00	1	23	10681
617	0.12	1298.46	2021-09-06 12:05:00	1	23	10760.71
650	0.09	1008.17	2022-02-02 19:00:00	1	23	10893.07
674	0.09	1028.33	2022-04-04 09:45:51	1	23	11016.03
687	0.09	1047.71	2022-06-02 20:05:49	1	23	11133.25
715	0.08	951.56	2022-08-03 16:20:53	1	23	11242
738	0.09	1095.45	2022-10-05 18:35:19	1	23	11370.72
755	0.08	994.19	2022-12-05 19:25:23	1	23	11486.52
844	0.08	0	2023-06-28 11:35:48	3	23	12900.25
\.


--
-- Data for Name: operacoes_import; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operacoes_import (id, investidor_id, arquivo, extensao, tipo_arquivo, hash_nome, data, lista_operacoes_criadas_json) FROM stdin;
1	1	Exportar_custodia_2022-02-17.csv	csv	NU	a509f3583497bd68bc78563c2a68c65d1da37dc9c7084601b1bcb2a18795aa01885a8e4b86ccfa2e9f8dc0279b1b6cd1c6972a167d6886beb646ccc8e11583d4	2022-02-18 19:00:54	null
8	1	orders-2022.02.18-14 49 20.csv	csv	Operações Clear	b74b928ba5c3537af2afef58b7fe7a7fbb821f4ab23001574e177f80c821f6724c28c87a5e37a3de510952afdd2ebb2b60e95f56b6416142655e87e577c796fd	2022-02-18 19:19:54	{"operacoes_id":[653]}
11	1	Extrato de Investimentos Simplificado.pdf	pdf	Operações Inter	9fe8e6f6dfd8e32e28dd0fd82ebb2115c730f7a65184e708ab7997bf48d95f8dd9ccf32f796fb5e4df7fc3f940393afc6c4661cc6e509bdd1cba720ba277daa9	2022-02-18 20:00:29	null
13	1	report-statement-BR_2022_02_23.csv	csv	Operações Avenue	a2fe06cd4bc57571bc9d5c1515e150bb1d93f073730d5d6c3dd2392d283fea4a23849aada7f06598aa853eb855444d4825c7535035f1f5763443a33a5806f861	2022-02-23 18:56:50	{"operacoes_id":[658]}
14	1	orders-2022.03.03-10 22 09.csv	csv	Operações Clear	d0bb2cfa81ccdfdc47e3d2f854de88203a4e5744bfb0f0b4749e98b952be4675214cd56c155f647ef1479b831738df7d730ba4e3c17fa63fe271e9abbd101076	2022-03-06 10:57:25	{"operacoes_id":[659]}
15	1	orders-2022.03.15-11 40 32.csv	csv	Operações Clear	aab95fce177212ba6d1d9f9989e138fa8b4401a796afb9e74f80e9558f348df8de4a136728b66091a256a3e278c8c1d2b5863e43fdd1aec8d693b503af213066	2022-03-15 21:24:56	{"operacoes_id":[663]}
17	2	avenue 03.22.csv	csv	Operações Avenue	3832979fe9328904d9b6b07d6de298ab0d37a8e960c49180013782317fda02481c05a5af06eaad17578515c7416dec020ef5454791c017b4368a5746196dff39	2022-03-15 21:42:56	{"operacoes_id":[664]}
19	1	orders-2022.03.29-11 02 50.csv	csv	Operações Clear	302137704b5be31ab3f24958e4225b24257762da99288e7febfb1ca92a37bc8afdc4e76bef1482d3e979224f58b07ede203645d9c7d89094ef50fe11b23de74a	2022-04-02 10:53:45	{"operacoes_id":[666,667]}
20	1	report-statement-BR.csv	csv	Operações Avenue	048525bfa7e389da5b4a129f3a9fa7ac6e97e78d6761a54e63c6169c58ab0b94e19bac2d18fa7d48dc19a75a6a84e413a49fe5287526b87ee46f7e70011476e3	2022-04-02 10:58:46	{"operacoes_id":[668]}
21	1	orders-2022.04.04-15 49 51.csv	csv	Operações Clear	e74201a56733f21fceff2eaa76fe99f5c9df0606178540c21ba9e75723d080eb0ffdd7b288e51e956a104f72d5bb3e0de03a1a1eace74d7d14b9f930a793d0d9	2022-04-04 20:22:32	{"operacoes_id":[669]}
22	1	Exportar_custodia_2022-04-04.csv	csv	NU	fef8fc17ccb4249c073e487f0aa856346278e75b1c7397566e7542a542428ec7d7d65a6ea812a64a7722c60d4c392dc56cbb79495e9509b1e46bf037ff1b009d	2022-04-04 20:25:35	null
26	1	Extrato de Investimentos Simplificado.pdf	pdf	Operações Inter	1ed2b8528fe23739635be49e4b4108a0a4671a8e8c1d6fdfc719b63616ead606509c3457561f5b1a06c00a29c9def46f5ee8d5f3b345299e34f7d22f62ac9ebe	2022-04-09 09:32:39	null
27	1	orders-2022.04.08-13 14 26.csv	csv	Operações Clear	ef8328bae355db607b12cbf406e3b2fb9a48c3f95fd52b91db2df92661ce9b8e832781f54ed2a97e89948c25e7e68d8b36e7c3704efe1b22300c54e594c8decd	2022-04-09 09:35:14	{"operacoes_id":[673]}
28	1	orders-2022.04.14-15 28 02.csv	csv	Operações Clear	da255612437a9cca007f3ad0342a0bdaed845cd27c6806e1d20385e78a6dbf4d923add7fe1c31432b29cdbefa6b4d2bc6513c2795cb5ba0d93f903bda9c38714	2022-04-14 15:31:11	{"operacoes_id":[675,676,677]}
29	1	report-statement-BR.csv	csv	Operações Avenue	0e61c777bc63be0bca5315e7f7cb9bb5b625afc7470497337745929d03cd94c299dc30d43e41a4b6738975f9034326c2590419caa79903938d505c8ab00b2ca1	2022-04-26 20:27:51	{"operacoes_id":[678]}
30	1	orders-2022.05.05-11 26 20.csv	csv	Operações Clear	f0e52b16ee60b437ace613b84e3a19fc76ea1210a9d207008103244727eeb862c25b746c73b7bfc96d8fd7686d2a9341a5ab2b1d7bc2a9f53de3b3134a5be2f6	2022-05-05 11:27:22	{"operacoes_id":[679]}
31	1	orders-2022.05.13-10 07 29.csv	csv	Operações Clear	b2271b17b44056fe0a5a7e51cbd8bbc40cf82ec9f5855f3d68ec43fef5e8bb800de2318997db24dc0bdbc04eb29bc1c27fab26380d9efdf04f10e4682ff046eb	2022-05-13 10:08:15	{"operacoes_id":[680,681]}
32	2	avenue 5.22.csv	csv	Operações Avenue	390d8d2654973be8339277e599aae264fdf3bc5fdb57ce538cdd0161d51d9be5ceda6c47cbf9a6d09540b4cae9d6d1b77540eac1f9988e8a8728433841621fc5	2022-05-18 18:15:00	{"operacoes_id":[682]}
33	1	orders-2022.05.25-16 33 36.csv	csv	Operações Clear	ce09df65ec96d0e85e6b7fc1e8addd8c1d7451b60236a3920e2c678399df964d4de9f432885dc8ae3b1a01fd0ffe1b44fdf1dc95fb26de9f931aaff5234b8c06	2022-05-25 16:36:24	{"operacoes_id":[683]}
34	1	Extrato de Investimentos Simplificado.pdf	pdf	Operações Inter	d74c1187892217e78a981fd62514d98d8fa995b9dc0657efd6e1749d21ebf878192cd41e5037ab6da440739b79804a0c91bf01e19003352897d533f81eb8899d	2022-05-27 17:40:02	null
35	1	orders-2022.06.02-10 10 38.csv	csv	Operações Clear	0ca54e4c8d4968f291cdc0ff44f884895a82905e0cd0e86e771d8540231007d0f633a545306dcd5e696372be0656f1466db8f8013e969e2e81b5ab5c77ea19fa	2022-06-02 11:22:58	{"operacoes_id":[686]}
36	1	movimentacao-2022-06-05-19-50-57.csv	csv	Proventos	ff7011152add929517bb2d19b1175c70ba0070c5d4dc6b7ba683ebcea0e9387ec4eb20a89d3a508d4814322ce143bb20007bafcace78f5a39dc4594e12de408f	2022-06-05 19:53:58	{"operacoes_id":[184,185,186,187,188,189,190,191,192]}
37	1	orders-2022.06.13-13 06 50.csv	csv	Operações Clear	8f99c43507161fd0983c9934fcc626dac47b86e33e107703d3d91a0d6dfca6d630fbd89480195d0afec153b3227311ae54627dd64a2807f097abe33145c0c54b	2022-06-13 13:21:21	{"operacoes_id":[690]}
38	1	orders-2022.06.14-14 51 51.csv	csv	Operações Clear	f2a13acf3cc11f2dc1958e7f8df4a300b59e75d41c2936c34f06ca979bfc06c42586d2084e62df4fbb2bad4c84b36ab8486780db6bed0c536afdbba110e01cbc	2022-06-14 14:54:45	{"operacoes_id":[691]}
39	1	orders-2022.06.15-13 52 53.csv	csv	Operações Clear	55191455aebd360e737b71eab4f0a86a31b737761abdccfcda562ca8ec4406457f716289f3b744a238ee13f089d20bb334778f640a6df5dff901d25f01bd774d	2022-06-15 13:54:55	{"operacoes_id":[692,693,694]}
40	1	orders-2022.06.17-10 26 00.csv	csv	Operações Clear	daaa6a9de68e3d2b3cda190d00621db112041a9cda9331157b6ade0e1d9aa6a85cac1c2e4c06420506ce913735138baed84cf11db3f711b4fce71b1a925d16f0	2022-06-17 10:26:33	{"operacoes_id":[695,696,697]}
41	1	Exportar_custodia_2022-06-21.csv	csv	NU	374a3289c59e2fac308d0a210699d04515336f92a329bca9f7fc42162e3403a1210b8a49531da0a39837d98e4f78fff29b75772e4b27c00f991fca8b6dd4ea88	2022-06-21 10:23:18	null
42	1	Extrato de Investimentos Simplificado.pdf	pdf	Operações Inter	037f492f8439eb91acda1609273aafeeeef3e48c430e192707fde1fc5588884a2e67b02d646ec965f2cc8e04ad2b5dfdd00c9b0bcefaf6f3a42bb3af3ae36be3	2022-06-21 10:27:40	null
43	1	orders-2022.06.24-15 17 46.csv	csv	Operações Clear	774a87d0869cb2e2e3df21830c439add23b726176f1e1214424cb6c026dc725522ab953ac9aeb1cbca1d3dc9bdcb799eebcf827200cf222a1fd3e60992fa3dc5	2022-06-24 15:18:13	{"operacoes_id":[700,701,702]}
47	1	proventos-recebidos-07-2022.csv	csv	Proventos	245c88b91a70e9e6339dd3c5e69e3c03f12130225e866eaed693c653b84b68ffab2a28604e04e60a5c666b1c9f61b8f9f84c82c6b7f2e2700564c961aea51eb3	2022-07-01 15:40:21	{"operacoes_id":[193,194,195,196,197,198]}
48	1	orders-2022.07.08-13 31 37.csv	csv	Operações Clear	11a19e2ab659a485ba18e63afae4a0e199f4bc13462df799d2e594b9c69c901b15d1e173d290822eb212878d12a9666b99aae46eff69eb8d7cb8114daeb28220	2022-07-08 13:32:18	{"operacoes_id":[704]}
49	1	orders-2022.07.08-13 34 04.csv	csv	Operações Clear	534558601d9e0b29f8221267f8641b748dc0ed11d810b2788d5fe1b0936d6ea6be84990b1d579ad3a1f3a9e59bca880e8291851bf7e4152efc01ec733cfd51f5	2022-07-08 13:34:31	{"operacoes_id":[705]}
51	1	orders-2022.07.18-10 21 01.csv	csv	Operações Clear	7bf6e8e59024e432018e94cd0f7186dbb9f3531d4d4fc79a5d2d4dbb916abdb80bd2786a53230ce9fe005e7e8cb53da6e2c9003649c179290c9b8e49b3b42a40	2022-07-18 10:21:46	{"operacoes_id":[707]}
52	1	orders-2022.07.26-11 06 50.csv	csv	Operações Clear	2c2ebbd42cb099796be99c912baeb988a7a6035376ce403b6608294b95aae379c5bf77fc5a4c4e9ddee6e5fba235b4fff6e46407d711ab664a654b1a7317c9a3	2022-07-26 11:07:52	{"operacoes_id":[710]}
53	1	Exportar_custodia_2022-07-29.csv	csv	NU	f12d8341ea90a6cad5621e4afbd61f37cd481ab358fb8fab67c782d7a04af668af4d326cae4bf6e3f1a231ea5f55741e4f1ad92a555e2d059e9fedf7ee436b1e	2022-07-29 13:22:30	null
54	1	proventos-recebidos-2022-08-01-08-25-17.csv	csv	Proventos	83062647b88a653b6f71788f5948036f309c8d6246718a3677a97dba254542421e9429b03cb31e819b01ea572b82d8894bc90feca773ee9c9b83b276efd6d993	2022-08-01 08:27:28	{"operacoes_id":[199,200,201,202,203,204,205,206,207,208]}
62	1	orders-2022.08.31-14 27 51.csv	csv	Operações Clear	c093da3de3fee1c3e3e6ac33630a9dbe3fb22d52ccf6c059c6492fd552fe714e9c4bfedee9bda0d190ebf328806ba8708aeb99a61eef335672dd16d534f54b31	2022-08-31 14:29:16	{"operacoes_id":[718]}
56	1	orders-2022.08.08-14 50 12.csv	csv	Operações Clear	f0c3c74cd674da354318cdf2b30c0eb1d5b5b7d13a9a9c5ae9759e2c2f400cc8ded5826139854c53816585de51600dfdf68be349b78fcf91771f7d933998a690	2022-08-08 14:52:22	{"operacoes_id":[712]}
57	1	orders-2022.08.15-13 08 52.csv	csv	Operações Clear	8feb18d4bd4a92357d9b74504e7c2d1a89b80eb02408ab7f060e910bc1f6eb2229371478f31f59eedf5ceba1ac140712cf6ab574f76851b6cec914cdaf2762aa	2022-08-15 13:10:30	{"operacoes_id":[713]}
58	1	orders-2022.08.15-13 20 06.csv	csv	Operações Clear	2a14bd4c956b7778802223a9c64e507eb282788a16e3a24ca5ed7fdb7dca7440ebed8f343a94bae3d1e842d49c594c026735b343e34345a2a5a6df71d7969b11	2022-08-15 13:22:16	{"operacoes_id":[714]}
59	1	orders-2022.08.25-14 12 58.csv	csv	Operações Clear	05af18631d94d2291bbcc9ea1c92384590f819fdef9c6ecef19225c0338ee98e414a0325e1696c4c47f5a6e7cdaa950c7bdfa4ee514353ff6c602ede74ca5c1d	2022-08-25 14:14:32	{"operacoes_id":[716]}
61	1	proventos-recebidos-2022-08-29-09-51-23.csv	csv	Proventos	25f609439cc722cabfe3d08ebcf23f9f5fe876e6fe18276895f2ff52cc6525422ddb148d15778b076bfc9fad82e8ee1e0a90a29cd0288a6ad94dc5fc1141c244	2022-08-29 10:20:10	{"operacoes_id":[212,213,214,215,216,217,218]}
70	1	orders-2022.10.10-10 30 57.csv	csv	Operações Clear	94dd4c6e612085c9063b5ee694489eeb52d70307f9d00dd74e1408e8efd31a0740ce027d169aef5cfa59f9baa8f7932251949439e568b29c19e2591df0ee9c39	2022-10-10 10:32:09	{"operacoes_id":[731]}
64	1	proventos-recebidos-2022-09-01-12-35-19.csv	csv	Proventos	5d70cb61263325c21c3432f71094e6f1ae0d3c50c1eea5aa44cb9993e14b438040a3e9fd88938f54c4a7926d438fae1afb00525f5d4b1899e71b9d6e55bbc4f5	2022-09-01 12:40:06	{"operacoes_id":[219,220,221]}
65	1	orders-2022.09.09-13 43 08.csv	csv	Operações Clear	736df08747c8ded9ec0003576c9019856f4861d80986f2ab69429c193669aed65768ee63b3edd6f8f3145e4afd109b4f3f9185812e3e39f5e2fe8332c7036629	2022-09-09 13:46:25	{"operacoes_id":[720]}
66	1	orders-2022.09.15-10 13 38.csv	csv	Operações Clear	2fe0653041e84bd1818e24db041e8fbf8ac7bfab8b29c8a2811b598b353568e1b69355024d302673d852c9f85bd153a26d29a6b1b82abf59ef875bccc719db71	2022-09-15 10:16:46	{"operacoes_id":[721,722]}
67	1	orders-2022.09.26-14 43 22.csv	csv	Operações Clear	13758b4ff1c2967d30faa4cc370fbb8b485bbaa016ac7f0dd27da4cdcc68c6974f58fef2f3d6ac65f462283153badb2e758b5120b8c55b1e0148d6237a8c30d7	2022-09-26 14:45:15	{"operacoes_id":[723,724]}
68	1	proventos-recebidos-2022-10-03-22-31-45.csv	csv	Proventos	923f9ce384bd7de9579064050feaeeb1e06e834a5111c56b8027cc8bba0ada8a8826799cfc4d4b6cb851308d26a54e75c0af25f2016a50cd4fcce7f25e4325be	2022-10-03 22:34:52	{"operacoes_id":[222,223,224,225,226,227,228]}
69	1	orders-2022.10.04-14 01 38.csv	csv	Operações Clear	61e365f8b546a2b59e5f8f90ca6f62ad31ef05698858fc659b54f74b6259941189449e4870e80a5c9f3256998de02f7e45f3c7467f0f9a1221b087bfa12ac9c6	2022-10-04 14:02:11	{"operacoes_id":[725,726,727,728,729]}
72	1	report-statement-BR.csv	csv	Operações Avenue	b4da9170257ab509bc6d8ed7207f6006f51a658f362f131a3c4c4697a5ac486125a51e27d8bd49dbf23b0da79158de304f8f8f2ad3c90008d97864ce29d182f6	2022-10-11 15:06:55	{"operacoes_id":[732]}
73	1	orders-2022.10.14-13 40 00.csv	csv	Operações Clear	3cc28b268edb3ba3a96796d8543af0e397171eada9b96742ccaae983488bfc41675249d2d9b83b236e55b4e2d9ee1cd34bb62a775a3fc8910bbf22abdcec89da	2022-10-14 13:40:22	{"operacoes_id":[733,734]}
74	1	Exportar_custodia_2022-10-15.csv	csv	NU	fa3b2c1fd85e8f3b84eff42509215ecedfc691d67605130b88f405db6cd3618d07f63e612cb35468910b734ad44e760cbd0766f6d3b58c812d46319d49816f90	2022-10-15 16:15:55	null
107	1	orders-2022.10.17-14 04 39.csv	csv	Operações Clear	b915051a98c20230bb483d3ad48177bac3e9e8877fc70aa9531c28e38dfb636456010f6ad8c1099f8d9308ff7a1f77e5e51f0165d555dd65b3adb62c6ce9f376	2022-10-17 14:07:11	{"operacoes_id":[735]}
113	1	proventos-recebidos-2022-11-01-18-03-10.csv	csv	Proventos	fe8a6177363062da16b13bf9b7978a8172d5c9b5596ae29c91d0a9b7f666df2a3ea475bd88e5a43b26d73d6a5a07952d3a243d6217848e02fe2e06c53f0f6f64	2022-11-01 18:18:19	{"operacoes_id":[265,266,267,268,269,270,271,272,273,274]}
114	1	Exportar_custodia_2022-11-01.csv	csv	NU	9a371eb39d61a480b60081a25757e80dcb6cdeb032ec5c6bbdc7521e8c5676409766f50f3688b20dcbb953eb85a19fb5d628d6aed3aab9eebb0e6630a40e6727	2022-11-01 18:28:45	null
115	1	orders-2022.11.09-14 19 24.csv	csv	Operações Clear	fd951c353d71ccc9e75e4e6860f83d052d64b33030a9c87c2d2381b0f9ca819f0c50b4915eae49ce58192d679df851eb093ee65785502f5e469da89f5aad5fe7	2022-11-09 14:20:51	{"operacoes_id":[743,744,745,746,747,748]}
116	1	orders-2022.11.16-10 13 18.csv	csv	Operações Clear	088695269ca135c00c5efb2a6a0c252bcec20d9c45d1c2015a1170bb847d3fe576c11ca1070dc82e69495191dce248888e4dd571baf71a1d806e214c53b344cf	2022-11-16 10:19:59	{"operacoes_id":[749]}
117	1	orders-2022.11.28-10 37 40.csv	csv	Operações Clear	e1e84cb8fc6dfccf689864b0841bdd53a01576fed2cf61944accce6f05b8314626a1ff14560d42601e196ad20525f5df94672ffa0e3e4b23b8260de6bd2c1564	2022-11-30 08:35:49	{"operacoes_id":[750]}
118	1	proventos-recebidos-2022-12-01-13-22-40.csv	csv	Proventos	dab1a483d9990edeb7c412172a3fde2bfef1987ed4e892e86ae5858aafb25cbc45a8ba3e4fd868af5e651e55590eb3b0188d48d68a4bbeb31a03e94833c845b8	2022-12-01 13:24:37	{"operacoes_id":[275,276,277,278,279,280,281,282]}
119	1	orders-2022.12.13-15 27 41.csv	csv	Operações Clear	73109f6d07cda834282438d3d02445900025f932e938f6ba8adca18c4c66a17a665c65e10b40bf74edffd0f5a20418c9ff3db455536c527f710345307c6a4985	2022-12-13 15:32:04	{"operacoes_id":[751,752]}
120	1	orders-2022.12.15-13 50 59.csv	csv	Operações Clear	23950a9dbbfad91dd74ee7034cee357d409c833c84c99baffba5a9255e1e41aea39a4945c0e64246d47a133424cc5971f5a221725b44bb518f95cc7536f4b52b	2022-12-17 09:25:48	{"operacoes_id":[756,757]}
121	1	orders-2022.12.29-10 41 16.csv	csv	Operações Clear	1083b299becc98344906e2389a24aca225f1fb9e75e3961d046941d0d52079348c0e9eb703a991cf8cd42f4879944948620e1ae0721778f911f3331c6dce693d	2022-12-31 16:56:01	{"operacoes_id":[758,759]}
123	1	proventos-recebidos-2022-12-04-a-2022-12-31.csv	csv	Proventos	36d03928738f7df5c1656ab06bc715d98f7055c51dc267bf02946feaffaf685b30d605387202b2be21d7d83c9de20a951480d5f81aeb99232a63db2f38aea791	2023-01-04 14:50:23	{"operacoes_id":[288,289,290,291,292,293,294,295,296,297,298,299,300]}
124	1	orders-2023.01.12-14 12 41.csv	csv	Operações Clear	ac55b81ebc0430ec61e8fe3a052e8d082b709ef98904aef6df3239098e14dcecd52740d79c566296169cc8eb1db329b1c9564f860f30f387bad3d5c41101f178	2023-01-12 14:14:43	{"operacoes_id":[761,762]}
125	1	orders-2023.01.17-14 04 49.csv	csv	Operações Clear	8cae3bf6184fd610d189aea41148b08cde50db302304f9f33216e9f21daa6562611a8d5bc4995e5bbf8edb65a2d0f6b9693889700c5b96b82de4acafbce05302	2023-01-17 14:07:18	{"operacoes_id":[764,765,766,767]}
134	1	orders-2023.02.28-17 00 17.csv	csv	Operações Clear	30c05893408d6ebc949fafdb4cf6d40549b89dca0ec3b0db440b436f6fde1c6ab75012f2ffad18b253eabe722ac212b343f9577168a02a5dcc8f5c12c01322af	2023-02-28 17:27:58	{"operacoes_id":[790]}
128	1	orders-2023.01.25-10 22 14.csv	csv	Operações Clear	4a2f48ccae50c0a4eef78c9c2967f256e9396a1e8be29a355a8ea82e4d652cbf7e0a89feca72c87414b715a99ee2a6bd2ba4c79cc05a872365c037e5ba203ff3	2023-01-25 10:27:15	{"operacoes_id":[772]}
129	1	proventos-recebidos-2023-01-04-a-2023-02-03.csv	csv	Proventos	dd15abd16ca3c75952bab9c2b154f21e8bfa6aec7db803c3564aa354e6fd6aa39e65ee09f33e2599d54973adf1892067e44ce1aed7d58453b9adfff433845ded	2023-02-06 20:35:26	{"operacoes_id":[301,302,303,304,305,306,307]}
130	1	Exportar_custodia_2023-02-06.csv	csv	NU	1e0634da1316c6c6c8b70eef49c06a51018b8baf231121a6b58e56fade3a1f04154e02ac7e0e9211efb082837f4c65e2ff547061d27773f13c24b99192a5d410	2023-02-06 20:45:56	null
131	1	orders-2023.02.08-11 15 45.csv	csv	Operações Clear	d983194c0bb2dc0dc4c56d3c0d730d22a320de353a181fe93ec5a81bbff2d2e3d28a1b00ab5fbef63b43542a73f525725930de98be2513556430fb070d4c826a	2023-02-08 11:17:10	{"operacoes_id":[775]}
132	1	orders-2023.02.13-13 44 22.csv	csv	Operações Clear	463f4f28ceebfff0e2fd7ea17528e20a8e52f0bd2295ec3f000b595f6e897f2a31926f59ff81875547d7db9e03cf1297470ed7b5866a1bd9d7b437d23787ae78	2023-02-13 13:45:22	{"operacoes_id":[780,781,782,783,784,785,786]}
133	1	orders-2023.02.22-16 31 40.csv	csv	Operações Clear	eb022a69bbbb9e07ed4fa8d32894189458e409fdb97ff2e5d8c3c3d3e9b8b33965e69cf2857ddbdfe597c70e408f2160ba4bcda69054fd90407bbf206b5a0313	2023-02-22 16:32:51	{"operacoes_id":[787,788,789]}
136	1	proventos-recebidos-2023-01-28-a-2023-02-27.csv	csv	Proventos	ceaee077a5d76271801928a51a2062ccd7cc69b315bd0981b5940d2549a8ce435164a83433f7874fa0f94377191a4adbc6616e43be05891f0ed971e5060e1c8a	2023-02-28 17:56:50	{"operacoes_id":[308,309,310,311,312,313]}
137	1	orders-2023.03.15-10 20 10.csv	csv	Operações Clear	f9259d1f7a0eab2b93613529fc9169f169b0b8738b31dc6b6d5c7cd7326fb429bcdf81e3385569bc50f1741044649c561d2adb23841576987c2296b99c636ea1	2023-03-15 10:20:54	{"operacoes_id":[796,797]}
138	1	orders-2023.03.28-14 12 02.csv	csv	Operações Clear	f8e7e09e842c61177483de072f6a71ef99185db76ad66734f9bd94041529e4fc5cb22315ef09ea8b9a52d585803c8f9fd65c5a943bbfe404ae47855112d033b4	2023-03-28 17:40:15	{"operacoes_id":[802]}
140	1	proventos-recebidos-2023-03-01-a-2023-03-30.csv	csv	Proventos	c7467bf9b5058a40fda0be36b11d6f8121ff8acb58b9b8bc84279d3edfd600ec5bc6d4d8a9e9b18f13c7b7a72818e76129a606d8122bb8f3f714fbc16c8b20eb	2023-03-31 15:05:07	{"operacoes_id":[318,319,320,321,322,323,324,325,326]}
141	1	orders-2023.04.24-16 10 25.csv	csv	Operações Clear	8c4bbf259c6989abd68939090deda6389ae5b66d3c023248dbeabd2c86ce7abd79b43a3299ea7dc7caa7a039620f5a453987c19cf4127e98772e848f5eedb6f7	2023-04-24 16:11:27	{"operacoes_id":[810,811]}
142	1	orders-2023.04.26-16 23 05.csv	csv	Operações Clear	5933db4cc39cc1ee05191639eafcbe9eae5d6738ca08f815e04101a844287ad8c8054b32c1eb77221b6fccd033c08222b836dfa4aedf0ea30e9ccad6c18c807f	2023-04-28 16:30:49	{"operacoes_id":[812]}
\.


--
-- Data for Name: preco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preco (id, valor, ativo_id, data, atualiza_acoes_id) FROM stdin;
1	14.84	20	2023-02-06 20:22:37	\N
2	8.52	16	2023-02-06 20:22:37	\N
3	37.25	21	2023-02-06 20:22:37	\N
4	13.00	17	2023-02-06 20:22:37	\N
5	12.11	18	2023-02-06 20:22:37	\N
6	38.19	19	2023-02-06 20:22:37	\N
7	6.37	23	2023-02-06 20:22:37	\N
8	33.59	24	2023-02-06 20:22:37	\N
9	11.41	25	2023-02-06 20:22:37	\N
10	229.44	31	2023-02-06 20:22:37	\N
11	102.46	29	2023-02-06 20:22:37	\N
12	102.90	30	2023-02-06 20:22:37	\N
13	256.77	32	2023-02-06 20:22:37	\N
14	284.24	34	2023-02-06 20:22:37	\N
15	138.07	35	2023-02-06 20:22:37	\N
16	35.45	37	2023-02-06 20:22:37	\N
17	161.82	38	2023-02-06 20:22:37	\N
18	90.45	39	2023-02-06 20:22:37	\N
19	87.25	42	2023-02-06 20:22:37	\N
20	117.00	49	2023-02-06 20:22:37	\N
21	186.06	50	2023-02-06 20:22:37	\N
22	119935	51	2023-02-06 20:22:37	\N
23	7.96	53	2023-02-06 20:22:37	\N
24	131.44	54	2023-02-06 20:22:37	\N
25	67.73	55	2023-02-06 20:22:37	\N
26	5.1504	56	2023-02-06 20:22:37	\N
27	14.84	20	2023-02-06 20:40:25	\N
28	8.56	16	2023-02-06 20:40:25	\N
29	37.57	21	2023-02-06 20:40:25	\N
30	13.02	17	2023-02-06 20:40:25	\N
31	12.11	18	2023-02-06 20:40:25	\N
32	38.19	19	2023-02-06 20:40:25	\N
33	6.37	23	2023-02-06 20:40:25	\N
34	33.55	24	2023-02-06 20:40:25	\N
35	11.57	25	2023-02-06 20:40:25	\N
36	229.44	31	2023-02-06 20:40:25	\N
37	102.18	29	2023-02-06 20:40:25	\N
38	103.12	30	2023-02-06 20:40:25	\N
39	256.77	32	2023-02-06 20:40:25	\N
40	284.48	34	2023-02-06 20:40:25	\N
41	138.07	35	2023-02-06 20:40:25	\N
42	35.45	37	2023-02-06 20:40:25	\N
43	161.80	38	2023-02-06 20:40:25	\N
44	90.45	39	2023-02-06 20:40:25	\N
45	87.25	42	2023-02-06 20:40:25	\N
46	117.00	49	2023-02-06 20:40:25	\N
47	186.06	50	2023-02-06 20:40:25	\N
48	117580	51	2023-02-06 20:40:25	\N
49	7.96	53	2023-02-06 20:40:25	\N
50	131.44	54	2023-02-06 20:40:25	\N
51	67.18	55	2023-02-06 20:40:25	\N
52	5.1469	56	2023-02-06 20:40:25	\N
53	14.97	20	2023-02-08 11:24:35	\N
54	8.66	16	2023-02-08 11:24:35	\N
55	38.05	21	2023-02-08 11:24:35	\N
56	13.05	17	2023-02-08 11:24:35	\N
57	12.08	18	2023-02-08 11:24:35	\N
58	37.57	19	2023-02-08 11:24:35	\N
59	6.41	23	2023-02-08 11:24:35	\N
60	33.72	24	2023-02-08 11:24:35	\N
61	11.61	25	2023-02-08 11:24:35	\N
62	231.32	31	2023-02-08 11:24:35	\N
63	102.00	29	2023-02-08 11:24:35	\N
64	107.64	30	2023-02-08 11:24:35	\N
65	267.56	32	2023-02-08 11:24:35	\N
66	287.82	34	2023-02-08 11:24:35	\N
67	139.59	35	2023-02-08 11:24:35	\N
68	35.48	37	2023-02-08 11:24:35	\N
69	160.38	38	2023-02-08 11:24:35	\N
70	90.91	39	2023-02-08 11:24:36	\N
71	88.02	42	2023-02-08 11:24:36	\N
72	116.60	49	2023-02-08 11:24:36	\N
73	191.62	50	2023-02-08 11:24:36	\N
74	120324	51	2023-02-08 11:24:36	\N
75	7.99	53	2023-02-08 11:24:36	\N
76	130.27	54	2023-02-08 11:24:36	\N
77	67.37	55	2023-02-08 11:24:36	\N
78	5.1882	56	2023-02-08 11:24:36	\N
79	14.50	20	2023-02-12 11:29:45	\N
80	8.67	16	2023-02-12 11:29:45	\N
81	38.60	21	2023-02-12 11:29:45	\N
82	12.86	17	2023-02-12 11:29:45	\N
83	11.80	18	2023-02-12 11:29:45	\N
84	38.03	19	2023-02-12 11:29:45	\N
85	6.33	23	2023-02-12 11:29:45	\N
86	33.99	24	2023-02-12 11:29:45	\N
87	12.00	25	2023-02-12 11:29:45	\N
88	227.20	31	2023-02-12 11:29:45	\N
89	97.61	29	2023-02-12 11:29:45	\N
90	94.57	30	2023-02-12 11:29:45	\N
91	263.10	32	2023-02-12 11:29:45	\N
92	283.96	34	2023-02-12 11:29:45	\N
93	139.54	35	2023-02-12 11:29:45	\N
94	35.35	37	2023-02-12 11:29:46	\N
95	160.19	38	2023-02-12 11:29:46	\N
96	90.50	39	2023-02-12 11:29:46	\N
97	87.20	42	2023-02-12 11:29:46	\N
98	115.95	49	2023-02-12 11:29:46	\N
99	174.15	50	2023-02-12 11:29:46	\N
100	114621	51	2023-02-12 11:29:46	\N
101	8.00	53	2023-02-12 11:29:46	\N
102	128.09	54	2023-02-12 11:29:46	\N
103	66.85	55	2023-02-12 11:29:46	\N
104	5.2156	56	2023-02-12 11:29:46	\N
105	14.50	20	2023-02-12 11:31:48	\N
106	8.67	16	2023-02-12 11:31:48	\N
107	38.60	21	2023-02-12 11:31:48	\N
108	12.86	17	2023-02-12 11:31:48	\N
109	11.80	18	2023-02-12 11:31:48	\N
110	38.03	19	2023-02-12 11:31:48	\N
111	6.33	23	2023-02-12 11:31:48	\N
112	33.99	24	2023-02-12 11:31:48	\N
113	12.00	25	2023-02-12 11:31:48	\N
114	227.20	31	2023-02-12 11:31:48	\N
115	97.61	29	2023-02-12 11:31:48	\N
116	94.57	30	2023-02-12 11:31:48	\N
117	263.10	32	2023-02-12 11:31:48	\N
118	283.96	34	2023-02-12 11:31:48	\N
119	139.54	35	2023-02-12 11:31:48	\N
120	35.35	37	2023-02-12 11:31:48	\N
121	160.19	38	2023-02-12 11:31:48	\N
122	90.50	39	2023-02-12 11:31:48	\N
123	87.20	42	2023-02-12 11:31:48	\N
124	115.95	49	2023-02-12 11:31:48	\N
125	174.15	50	2023-02-12 11:31:48	\N
126	114783	51	2023-02-12 11:31:48	\N
127	8.00	53	2023-02-12 11:31:48	\N
128	128.09	54	2023-02-12 11:31:48	\N
129	66.85	55	2023-02-12 11:31:48	\N
130	5.2156	56	2023-02-12 11:31:48	\N
131	14.72	20	2023-02-13 13:47:42	\N
132	8.88	16	2023-02-13 13:47:42	\N
133	38.76	21	2023-02-13 13:47:42	\N
134	12.93	17	2023-02-13 13:47:42	\N
135	11.79	18	2023-02-13 13:47:42	\N
136	38.56	19	2023-02-13 13:47:42	\N
137	6.22	23	2023-02-13 13:47:42	\N
138	34.03	24	2023-02-13 13:47:42	\N
139	11.98	25	2023-02-13 13:47:42	\N
140	229.00	31	2023-02-13 13:47:42	\N
141	99.29	29	2023-02-13 13:47:42	\N
142	94.25	30	2023-02-13 13:47:42	\N
143	274.23	32	2023-02-13 13:47:42	\N
144	286.26	34	2023-02-13 13:47:42	\N
145	143.28	35	2023-02-13 13:47:42	\N
146	35.16	37	2023-02-13 13:47:42	\N
147	159.94	38	2023-02-13 13:47:42	\N
148	90.93	39	2023-02-13 13:47:42	\N
149	88.27	42	2023-02-13 13:47:43	\N
150	115.54	49	2023-02-13 13:47:43	\N
151	180.24	50	2023-02-13 13:47:43	\N
152	112030	51	2023-02-13 13:47:43	\N
153	7.93	53	2023-02-13 13:47:43	\N
154	129.15	54	2023-02-13 13:47:43	\N
155	67.06	55	2023-02-13 13:47:43	\N
156	5.1708	56	2023-02-13 13:47:43	\N
157	14.50	20	2023-02-22 16:33:52	\N
158	8.67	16	2023-02-22 16:33:52	\N
159	38.60	21	2023-02-22 16:33:52	\N
160	12.86	17	2023-02-22 16:33:52	\N
161	11.80	18	2023-02-22 16:33:52	\N
162	38.03	19	2023-02-22 16:33:52	\N
163	6.33	23	2023-02-22 16:33:52	\N
164	33.99	24	2023-02-22 16:33:52	\N
165	12.00	25	2023-02-22 16:33:52	\N
166	227.20	31	2023-02-22 16:33:52	\N
167	97.61	29	2023-02-22 16:33:52	\N
168	94.57	30	2023-02-22 16:33:52	\N
169	263.10	32	2023-02-22 16:33:52	\N
170	283.96	34	2023-02-22 16:33:52	\N
171	139.54	35	2023-02-22 16:33:52	\N
172	35.35	37	2023-02-22 16:33:52	\N
173	160.19	38	2023-02-22 16:33:52	\N
174	90.50	39	2023-02-22 16:33:52	\N
175	87.20	42	2023-02-22 16:33:52	\N
176	115.95	49	2023-02-22 16:33:52	\N
177	174.15	50	2023-02-22 16:33:52	\N
178	114621	51	2023-02-22 16:33:52	\N
179	8.00	53	2023-02-22 16:33:52	\N
180	128.09	54	2023-02-22 16:33:52	\N
181	66.85	55	2023-02-22 16:33:52	\N
182	5.2156	56	2023-02-22 16:33:52	\N
183	14.98	20	2023-02-22 16:35:36	\N
184	8.76	16	2023-02-22 16:35:36	\N
185	38.89	21	2023-02-22 16:35:36	\N
186	13.20	17	2023-02-22 16:35:36	\N
187	10.80	18	2023-02-22 16:35:36	\N
188	39.14	19	2023-02-22 16:35:36	\N
189	6.48	23	2023-02-22 16:35:36	\N
190	33.23	24	2023-02-22 16:35:36	\N
191	13.01	25	2023-02-22 16:35:36	\N
192	220.24	31	2023-02-22 16:35:36	\N
193	96.19	29	2023-02-22 16:35:36	\N
194	91.79	30	2023-02-22 16:35:37	\N
195	252.67	32	2023-02-22 16:35:37	\N
196	270.20	34	2023-02-22 16:35:37	\N
197	142.74	35	2023-02-22 16:35:37	\N
198	34.63	37	2023-02-22 16:35:37	\N
199	160.28	38	2023-02-22 16:35:37	\N
200	93.55	39	2023-02-22 16:35:37	\N
201	88.28	42	2023-02-22 16:35:37	\N
202	116.03	49	2023-02-22 16:35:37	\N
203	170.97	50	2023-02-22 16:35:37	\N
204	123767	51	2023-02-22 16:35:37	\N
205	8.01	53	2023-02-22 16:35:37	\N
206	123.28	54	2023-02-22 16:35:37	\N
207	66.05	55	2023-02-22 16:35:37	\N
208	5.1537	56	2023-02-22 16:35:37	\N
209	14.37	20	2023-02-28 17:32:19	\N
210	8.43	16	2023-02-28 17:32:19	\N
211	39.31	21	2023-02-28 17:32:19	\N
212	13.54	17	2023-02-28 17:32:19	\N
213	10.55	18	2023-02-28 17:32:19	\N
214	39.66	19	2023-02-28 17:32:19	\N
215	6.58	23	2023-02-28 17:32:19	\N
216	33.42	24	2023-02-28 17:32:19	\N
217	11.24	25	2023-02-28 17:32:19	\N
218	220.17	31	2023-02-28 17:32:19	\N
219	93.43	29	2023-02-28 17:32:19	\N
220	90.52	30	2023-02-28 17:32:19	\N
221	249.37	32	2023-02-28 17:32:19	\N
222	265.55	34	2023-02-28 17:32:19	\N
223	141.17	35	2023-02-28 17:32:19	\N
224	34.66	37	2023-02-28 17:32:19	\N
225	162.06	38	2023-02-28 17:32:19	\N
226	93.58	39	2023-02-28 17:32:19	\N
227	89.57	42	2023-02-28 17:32:19	\N
228	115.47	49	2023-02-28 17:32:19	\N
229	177.21	50	2023-02-28 17:32:19	\N
230	121972	51	2023-02-28 17:32:19	\N
231	7.97	53	2023-02-28 17:32:19	\N
232	124.00	54	2023-02-28 17:32:19	\N
233	64.51	55	2023-02-28 17:32:19	\N
234	5.2238	56	2023-02-28 17:32:19	\N
235	14.11	20	2023-03-06 16:17:58	\N
236	8.33	16	2023-03-06 16:17:58	\N
237	39.22	21	2023-03-06 16:17:58	\N
238	13.45	17	2023-03-06 16:17:58	\N
239	11.05	18	2023-03-06 16:17:58	\N
240	39.54	19	2023-03-06 16:17:58	\N
241	6.99	23	2023-03-06 16:17:58	\N
242	31.23	24	2023-03-06 16:17:58	\N
243	11.56	25	2023-03-06 16:17:58	\N
244	226.94	31	2023-03-06 16:17:58	\N
245	94.68	29	2023-03-06 16:17:58	\N
246	95.35	30	2023-03-06 16:17:58	\N
247	258.08	32	2023-03-06 16:17:58	\N
248	270.77	34	2023-03-06 16:17:58	\N
249	144.56	35	2023-03-06 16:17:58	\N
250	35.01	37	2023-03-06 16:17:58	\N
251	159.95	38	2023-03-06 16:17:58	\N
252	91.42	39	2023-03-06 16:17:58	\N
253	86.94	42	2023-03-06 16:17:58	\N
254	115.85	49	2023-03-06 16:17:58	\N
255	189.25	50	2023-03-06 16:17:58	\N
256	117029	51	2023-03-06 16:17:58	\N
257	7.99	53	2023-03-06 16:17:58	\N
258	127.10	54	2023-03-06 16:17:58	\N
259	64.41	55	2023-03-06 16:17:58	\N
260	5.1651	56	2023-03-06 16:17:58	\N
261	14.17	20	2023-03-07 18:14:50	\N
262	8.36	16	2023-03-07 18:14:50	\N
263	39.64	21	2023-03-07 18:14:50	\N
264	13.38	17	2023-03-07 18:14:50	\N
265	11.25	18	2023-03-07 18:14:50	\N
266	40.36	19	2023-03-07 18:14:50	\N
267	7.25	23	2023-03-07 18:14:50	\N
268	31.73	24	2023-03-07 18:14:50	\N
269	11.93	25	2023-03-07 18:14:50	\N
270	223.21	31	2023-03-07 18:14:50	\N
271	93.55	29	2023-03-07 18:14:50	\N
272	93.86	30	2023-03-07 18:14:50	\N
273	254.15	32	2023-03-07 18:14:50	\N
274	264.20	34	2023-03-07 18:14:50	\N
275	143.90	35	2023-03-07 18:14:50	\N
276	34.39	37	2023-03-07 18:14:50	\N
277	159.88	38	2023-03-07 18:14:50	\N
278	91.63	39	2023-03-07 18:14:50	\N
279	85.70	42	2023-03-07 18:14:50	\N
280	116.42	49	2023-03-07 18:14:50	\N
281	184.51	50	2023-03-07 18:14:50	\N
282	114826	51	2023-03-07 18:14:50	\N
283	8.00	53	2023-03-07 18:14:50	\N
284	123.83	54	2023-03-07 18:14:50	\N
285	63.88	55	2023-03-07 18:14:50	\N
286	5.1900	56	2023-03-07 18:14:50	\N
287	14.50	20	2023-03-10 19:11:59	\N
288	8.31	16	2023-03-10 19:11:59	\N
289	39.66	21	2023-03-10 19:11:59	\N
290	13.51	17	2023-03-10 19:11:59	\N
291	11.21	18	2023-03-10 19:11:59	\N
292	41.16	19	2023-03-10 19:11:59	\N
293	7.34	23	2023-03-10 19:11:59	\N
294	31.67	24	2023-03-10 19:11:59	\N
295	11.51	25	2023-03-10 19:11:59	\N
296	216.14	31	2023-03-10 19:11:59	\N
297	90.73	29	2023-03-10 19:11:59	\N
298	90.63	30	2023-03-10 19:11:59	\N
299	248.59	32	2023-03-10 19:11:59	\N
300	252.95	34	2023-03-10 19:11:59	\N
301	141.29	35	2023-03-10 19:11:59	\N
302	35.46	37	2023-03-10 19:11:59	\N
303	160.49	38	2023-03-10 19:11:59	\N
304	93.24	39	2023-03-10 19:11:59	\N
305	85.70	42	2023-03-10 19:11:59	\N
306	115.51	49	2023-03-10 19:11:59	\N
307	182.89	50	2023-03-10 19:11:59	\N
308	105469	51	2023-03-10 19:11:59	\N
309	7.94	53	2023-03-10 19:11:59	\N
310	116.98	54	2023-03-10 19:11:59	\N
311	61.38	55	2023-03-10 19:11:59	\N
312	5.2145	56	2023-03-10 19:11:59	\N
313	14.50	20	2023-03-10 19:13:41	\N
314	8.33	16	2023-03-10 19:13:41	\N
315	39.60	21	2023-03-10 19:13:41	\N
316	13.65	17	2023-03-10 19:13:41	\N
317	11.26	18	2023-03-10 19:13:41	\N
318	40.93	19	2023-03-10 19:13:41	\N
319	7.29	23	2023-03-10 19:13:41	\N
320	31.57	24	2023-03-10 19:13:41	\N
321	11.51	25	2023-03-10 19:13:41	\N
322	216.14	31	2023-03-10 19:13:41	\N
323	90.73	29	2023-03-10 19:13:41	\N
324	91.98	30	2023-03-10 19:13:41	\N
325	250.58	32	2023-03-10 19:13:41	\N
326	252.95	34	2023-03-10 19:13:41	\N
327	141.29	35	2023-03-10 19:13:41	\N
328	35.46	37	2023-03-10 19:13:41	\N
329	160.36	38	2023-03-10 19:13:41	\N
330	93.24	39	2023-03-10 19:13:41	\N
331	85.70	42	2023-03-10 19:13:41	\N
332	115.51	49	2023-03-10 19:13:41	\N
333	180.74	50	2023-03-10 19:13:41	\N
334	105608	51	2023-03-10 19:13:41	\N
335	7.92	53	2023-03-10 19:13:41	\N
336	116.98	54	2023-03-10 19:13:41	\N
337	61.38	55	2023-03-10 19:13:41	\N
338	5.2159	56	2023-03-10 19:13:41	\N
339	14.41	20	2023-03-14 18:16:30	\N
340	8.21	16	2023-03-14 18:16:30	\N
341	40.20	21	2023-03-14 18:16:30	\N
342	13.97	17	2023-03-14 18:16:30	\N
343	11.39	18	2023-03-14 18:16:30	\N
344	41.59	19	2023-03-14 18:16:30	\N
345	7.47	23	2023-03-14 18:16:30	\N
346	31.47	24	2023-03-14 18:16:30	\N
347	11.12	25	2023-03-14 18:16:30	\N
348	218.60	31	2023-03-14 18:16:30	\N
349	94.88	29	2023-03-14 18:16:30	\N
350	93.97	30	2023-03-14 18:16:30	\N
351	260.79	32	2023-03-14 18:16:30	\N
352	252.48	34	2023-03-14 18:16:30	\N
353	142.92	35	2023-03-14 18:16:30	\N
354	36.08	37	2023-03-14 18:16:30	\N
355	160.21	38	2023-03-14 18:16:30	\N
356	94.33	39	2023-03-14 18:16:30	\N
357	85.40	42	2023-03-14 18:16:30	\N
358	113.70	49	2023-03-14 18:16:30	\N
359	194.02	50	2023-03-14 18:16:30	\N
360	127850	51	2023-03-14 18:16:30	\N
361	7.94	53	2023-03-14 18:16:30	\N
362	119.78	54	2023-03-14 18:16:30	\N
363	63.20	55	2023-03-14 18:16:30	\N
364	5.2541	56	2023-03-14 18:16:30	\N
365	14.51	20	2023-03-17 18:46:59	\N
366	8.20	16	2023-03-17 18:46:59	\N
367	39.79	21	2023-03-17 18:46:59	\N
368	14.22	17	2023-03-17 18:46:59	\N
369	11.30	18	2023-03-17 18:46:59	\N
370	40.40	19	2023-03-17 18:46:59	\N
371	7.32	23	2023-03-17 18:46:59	\N
372	31.45	24	2023-03-17 18:46:59	\N
373	11.00	25	2023-03-17 18:46:59	\N
374	217.39	31	2023-03-17 18:46:59	\N
375	98.95	29	2023-03-17 18:46:59	\N
376	100.87	30	2023-03-17 18:46:59	\N
377	279.43	32	2023-03-17 18:46:59	\N
378	249.07	34	2023-03-17 18:46:59	\N
379	139.44	35	2023-03-17 18:46:59	\N
380	36.98	37	2023-03-17 18:46:59	\N
381	159.73	38	2023-03-17 18:46:59	\N
382	94.36	39	2023-03-17 18:46:59	\N
383	86.43	42	2023-03-17 18:46:59	\N
384	114.56	49	2023-03-17 18:46:59	\N
385	198.41	50	2023-03-17 18:46:59	\N
386	140368	51	2023-03-17 18:46:59	\N
387	7.89	53	2023-03-17 18:46:59	\N
388	116.03	54	2023-03-17 18:46:59	\N
389	61.93	55	2023-03-17 18:46:59	\N
390	5.2799	56	2023-03-17 18:46:59	\N
391	14.60	20	2023-03-26 17:47:51	\N
392	8.13	16	2023-03-26 17:47:51	\N
393	40.51	21	2023-03-26 17:47:51	\N
394	13.89	17	2023-03-26 17:47:51	\N
395	10.56	18	2023-03-26 17:47:51	\N
396	39.80	19	2023-03-26 17:47:51	\N
397	7.08	23	2023-03-26 17:47:51	\N
398	24.08	24	2023-03-26 17:47:51	\N
399	10.98	25	2023-03-26 17:47:51	\N
400	221.04	31	2023-03-26 17:47:51	\N
401	98.13	29	2023-03-26 17:47:51	\N
402	105.44	30	2023-03-26 17:47:51	\N
403	280.57	32	2023-03-26 17:47:51	\N
404	272.00	34	2023-03-26 17:47:51	\N
405	152.75	35	2023-03-26 17:47:51	\N
406	37.46	37	2023-03-26 17:47:51	\N
407	159.88	38	2023-03-26 17:47:51	\N
408	91.82	39	2023-03-26 17:47:51	\N
409	86.50	42	2023-03-26 17:47:51	\N
410	115.90	49	2023-03-26 17:47:51	\N
411	206.01	50	2023-03-26 17:47:51	\N
412	147190	51	2023-03-26 17:47:51	\N
413	7.84	53	2023-03-26 17:47:51	\N
414	117.03	54	2023-03-26 17:47:51	\N
415	61.04	55	2023-03-26 17:47:51	\N
416	5.2475	56	2023-03-26 17:47:51	\N
417	8.18	16	2023-03-28 18:20:29	\N
418	41.69	21	2023-03-28 18:20:29	\N
419	14.59	17	2023-03-28 18:20:29	\N
420	10.58	18	2023-03-28 18:20:29	\N
421	40.08	19	2023-03-28 18:20:29	\N
422	7.13	23	2023-03-28 18:20:29	\N
423	24.55	24	2023-03-28 18:20:29	\N
424	11.20	25	2023-03-28 18:20:29	\N
425	220.33	31	2023-03-28 18:20:30	\N
426	97.24	29	2023-03-28 18:20:30	\N
427	101.03	30	2023-03-28 18:20:30	\N
428	272.52	32	2023-03-28 18:20:30	\N
429	275.00	34	2023-03-28 18:20:30	\N
430	155.32	35	2023-03-28 18:20:30	\N
431	37.43	37	2023-03-28 18:20:30	\N
432	159.92	38	2023-03-28 18:20:30	\N
433	91.92	39	2023-03-28 18:20:30	\N
434	87.28	42	2023-03-28 18:20:30	\N
435	115.96	49	2023-03-28 18:20:30	\N
436	200.68	50	2023-03-28 18:20:30	\N
437	141621	51	2023-03-28 18:20:30	\N
438	7.85	53	2023-03-28 18:20:30	\N
439	116.65	54	2023-03-28 18:20:30	\N
440	61.06	55	2023-03-28 18:20:30	\N
441	5.1638	56	2023-03-28 18:20:30	\N
442	14.52	20	2023-04-02 09:58:27	\N
443	8.33	16	2023-04-02 09:58:27	\N
444	40.55	21	2023-04-02 09:58:27	\N
445	14.33	17	2023-04-02 09:58:27	\N
446	10.35	18	2023-04-02 09:58:27	\N
447	40.17	19	2023-04-02 09:58:27	\N
448	7.19	23	2023-04-02 09:58:27	\N
449	25.22	24	2023-04-02 09:58:27	\N
450	11.00	25	2023-04-02 09:58:27	\N
451	225.46	31	2023-04-02 09:58:27	\N
452	103.29	29	2023-04-02 09:58:27	\N
453	103.73	30	2023-04-02 09:58:27	\N
454	289.27	32	2023-04-02 09:58:27	\N
455	285.81	34	2023-04-02 09:58:27	\N
456	159.14	35	2023-04-02 09:58:27	\N
457	37.37	37	2023-04-02 09:58:27	\N
458	160.47	38	2023-04-02 09:58:27	\N
459	94.38	39	2023-04-02 09:58:27	\N
460	95.49	40	2023-04-02 09:58:27	\N
461	85.46	42	2023-04-02 09:58:27	\N
462	113.45	49	2023-04-02 09:58:27	\N
463	211.94	50	2023-04-02 09:58:27	\N
464	144703	51	2023-04-02 09:58:27	\N
465	7.75	53	2023-04-02 09:58:27	\N
466	124.77	54	2023-04-02 09:58:28	\N
467	63.32	55	2023-04-02 09:58:28	\N
468	5.0637	56	2023-04-02 09:58:28	\N
469	8.77	16	2023-04-16 11:35:11	\N
470	38.76	21	2023-04-16 11:35:11	\N
471	14.65	17	2023-04-16 11:35:11	\N
472	11.97	18	2023-04-16 11:35:11	\N
473	41.04	19	2023-04-16 11:35:11	\N
474	7.72	23	2023-04-16 11:35:11	\N
475	27.13	24	2023-04-16 11:35:11	\N
476	10.60	25	2023-04-16 11:35:11	\N
477	234.02	31	2023-04-16 11:35:11	\N
478	102.51	29	2023-04-16 11:35:11	\N
479	108.87	30	2023-04-16 11:35:11	\N
480	286.14	32	2023-04-16 11:35:11	\N
481	279.25	34	2023-04-16 11:35:11	\N
482	168.60	35	2023-04-16 11:35:11	\N
483	38.01	37	2023-04-16 11:35:11	\N
484	162.00	38	2023-04-16 11:35:11	\N
485	95.20	39	2023-04-16 11:35:11	\N
486	98.85	40	2023-04-16 11:35:11	\N
487	81.89	42	2023-04-16 11:35:11	\N
488	108.60	49	2023-04-16 11:35:11	\N
489	221.49	50	2023-04-16 11:35:11	\N
490	151181	51	2023-04-16 11:35:11	\N
491	7.60	53	2023-04-16 11:35:11	\N
492	119.76	54	2023-04-16 11:35:11	\N
493	60.77	55	2023-04-16 11:35:11	\N
494	4.9078	56	2023-04-16 11:35:11	\N
495	14.24	20	2023-04-21 08:57:17	\N
496	103.81	29	2023-04-21 08:57:17	\N
497	286.11	32	2023-04-21 08:57:17	\N
498	165.37	35	2023-04-21 08:57:17	\N
499	37.98	37	2023-04-21 08:57:17	\N
500	109.88	49	2023-04-21 08:57:17	\N
501	142944	51	2023-04-21 08:57:17	\N
502	123.25	54	2023-04-21 08:57:17	\N
503	5.0493	56	2023-04-21 08:57:17	\N
504	14.24	20	2023-04-21 09:02:39	\N
505	8.62	16	2023-04-21 09:02:39	\N
506	40.25	21	2023-04-21 09:02:39	\N
507	14.60	17	2023-04-21 09:02:39	\N
508	11.66	18	2023-04-21 09:02:39	\N
509	41.48	19	2023-04-21 09:02:39	\N
510	7.79	23	2023-04-21 09:02:39	\N
511	25.94	24	2023-04-21 09:02:39	\N
512	10.35	25	2023-04-21 09:02:39	\N
513	234.60	31	2023-04-21 09:02:39	\N
514	103.81	29	2023-04-21 09:02:39	\N
515	105.29	30	2023-04-21 09:02:39	\N
516	286.11	32	2023-04-21 09:02:39	\N
517	275.55	34	2023-04-21 09:02:39	\N
518	165.37	35	2023-04-21 09:02:39	\N
519	37.98	37	2023-04-21 09:02:39	\N
520	162.19	38	2023-04-21 09:02:39	\N
521	96.54	39	2023-04-21 09:02:39	\N
522	99.62	40	2023-04-21 09:02:39	\N
523	82.90	42	2023-04-21 09:02:39	\N
524	109.88	49	2023-04-21 09:02:39	\N
525	213.07	50	2023-04-21 09:02:39	\N
526	142396	51	2023-04-21 09:02:39	\N
527	7.85	53	2023-04-21 09:02:39	\N
528	123.25	54	2023-04-21 09:02:39	\N
529	61.93	55	2023-04-21 09:02:39	\N
530	5.0493	56	2023-04-21 09:02:39	\N
531	14.43	20	2023-04-28 16:31:58	\N
532	8.77	16	2023-04-28 16:31:58	\N
533	40.91	21	2023-04-28 16:31:58	\N
534	14.12	17	2023-04-28 16:31:58	\N
535	11.61	18	2023-04-28 16:31:58	\N
536	41.01	19	2023-04-28 16:31:58	\N
537	8.12	23	2023-04-28 16:31:58	\N
538	28.42	24	2023-04-28 16:31:58	\N
539	10.01	25	2023-04-28 16:31:58	\N
540	233.04	31	2023-04-28 16:31:58	\N
541	105.57	29	2023-04-28 16:31:58	\N
542	106.89	30	2023-04-28 16:31:58	\N
543	305.18	32	2023-04-28 16:31:58	\N
544	167.27	35	2023-04-28 16:31:58	\N
545	37.73	37	2023-04-28 16:31:58	\N
546	162.49	38	2023-04-28 16:31:58	\N
547	102.21	39	2023-04-28 16:31:58	\N
548	103.08	40	2023-04-28 16:31:58	\N
549	82.84	42	2023-04-28 16:31:58	\N
550	112.33	49	2023-04-28 16:31:58	\N
551	236.79	50	2023-04-28 16:31:58	\N
552	147384	51	2023-04-28 16:31:58	\N
553	7.80	53	2023-04-28 16:31:58	\N
554	124.45	54	2023-04-28 16:31:58	\N
555	62.69	55	2023-04-28 16:31:58	\N
556	4.9903	56	2023-04-28 16:31:58	\N
\.


--
-- Data for Name: proventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proventos (id, data, valor, itens_ativos_id, movimentacao) FROM stdin;
184	2022-05-26 00:00:00	31.88	31	1
185	2022-05-26 00:00:00	21.48	31	2
186	2022-05-26 00:00:00	63.24	12	3
187	2022-05-19 00:00:00	0.15	31	1
188	2022-05-19 00:00:00	42.37	31	2
189	2022-05-14 00:00:00	56.1	10	3
190	2022-05-14 00:00:00	118.8	13	3
191	2022-05-14 00:00:00	68.64	11	3
192	2022-05-10 00:00:00	44.64	43	3
327	2023-03-31 15:05:20	2.81	8	2
1	2019-08-01 00:00:00	1.43	31	1
2	2019-08-01 11:05:00	34.05	26	1
3	2019-08-01 00:00:00	3.83	27	1
4	2019-10-01 00:00:00	6.94	29	1
5	2019-10-01 00:00:00	1.07	24	1
6	2019-10-01 00:00:00	6.64	25	1
9	2019-11-01 00:00:00	16.22	31	1
10	2019-12-01 00:00:00	36.28	28	1
11	2019-12-01 00:00:00	4.19	9	1
12	2020-01-01 00:00:00	1.62	24	1
13	2020-01-01 00:00:00	2.2	26	1
14	2020-01-01 00:00:00	2.26	9	1
15	2020-01-01 00:00:00	35.03	30	1
16	2020-01-01 00:00:00	5.64	25	1
17	2020-01-01 00:00:00	10.08	29	1
8	2019-10-01 00:00:00	1.96	9	1
7	2019-10-01 00:00:00	2	26	1
18	2020-03-01 00:00:00	50.74	26	1
19	2020-03-01 00:00:00	13.58	27	1
20	2020-04-01 00:00:00	2.07	24	1
21	2020-04-01 00:00:00	10.44	8	1
22	2020-04-01 00:00:00	2.44	26	1
23	2020-04-01 00:00:00	11.03	29	1
24	2020-04-01 00:00:00	2.2	9	1
25	2020-05-01 00:00:00	12.08	29	1
26	2020-05-01 00:00:00	29.5	31	1
27	2020-07-01 00:00:00	9.69	9	1
28	2020-07-01 00:00:00	2.94	26	1
29	2020-07-01 00:00:00	11.8	30	1
30	2020-08-01 00:00:00	3.86	26	1
31	2020-08-01 00:00:00	5.37	29	1
32	2020-08-01 00:00:00	3	24	1
33	2020-08-01 00:00:00	10.92	27	1
34	2020-10-10 00:00:00	3.86	26	1
35	2020-10-01 00:00:00	33.29	29	1
36	2020-10-01 00:00:00	35.69	9	1
37	2020-11-01 00:00:00	6.94	31	1
38	2020-12-01 00:00:00	65.76	28	1
39	2020-12-01 00:00:00	36.83	25	1
40	2020-12-01 00:00:00	23.8	9	1
41	2021-01-01 00:00:00	77.68	30	1
42	2021-01-01 00:00:00	14.41	28	1
43	2021-01-01 00:00:00	4.58	26	1
44	2021-01-01 00:00:00	3.47	9	1
45	2021-01-01 00:00:00	23.02	29	1
47	2020-09-11 00:00:00	0.36	34	1
46	2020-09-02 00:00:00	0.21	15	1
48	2020-12-30 14:10:00	0.88	34	1
49	2020-12-30 14:10:00	0.41	15	1
50	2021-03-31 13:15:00	0.23	24	1
51	2021-03-31 13:15:00	3.9	10	1
53	2021-03-31 13:15:00	4.5	12	1
54	2021-03-31 13:15:00	20.15	25	1
55	2021-03-31 13:20:00	4.64	11	1
56	2021-03-31 13:20:00	19.58	27	1
52	2021-03-31 13:15:00	23.83	26	1
57	2021-03-01 09:05:00	1.17	34	1
58	2021-03-11 09:10:00	0.61	15	1
59	2021-04-01 09:20:00	7.35	12	1
60	2021-04-01 09:25:00	6.56	26	1
61	2021-04-01 09:25:00	24.19	11	1
62	2021-04-01 09:25:00	31.39	29	1
63	2021-04-01 09:25:00	19.5	10	1
64	2021-04-01 09:25:00	5.33	9	1
65	2021-04-01 09:25:00	9.48	30	1
66	2021-04-01 09:25:00	67.23	25	1
67	2021-04-01 09:25:00	4.55	8	1
68	2021-05-03 11:05:00	279.74	31	1
69	2021-05-04 11:05:00	22.54	8	1
70	2021-05-13 11:05:00	22.8	12	1
71	2021-05-03 11:05:00	39.6	11	1
72	2021-05-03 11:05:00	37.48	29	1
73	2021-05-03 11:05:00	35.88	10	1
74	2021-06-02 10:30:00	46	10	1
75	2021-06-03 10:55:00	32.4	12	1
76	2021-06-03 10:55:00	45.14	11	1
107	2021-07-05 12:10:00	8.4	26	1
108	2021-07-05 12:10:00	63.56	29	1
109	2021-07-06 12:10:00	112.2	10	1
110	2021-07-06 12:10:00	42.12	12	1
111	2021-07-06 13:15:00	13.26	13	1
112	2021-07-15 12:15:00	45.14	11	1
113	2021-07-15 12:15:00	116.51	9	1
114	2021-07-14 12:15:00	81.43	30	1
115	2021-08-04 09:15:00	45.88	11	1
116	2021-08-11 14:15:00	0.62	24	1
117	2021-08-03 09:15:00	48.6	12	1
118	2021-08-10 13:15:00	19.68	25	1
119	2021-08-10 13:15:00	27.51	27	1
120	2021-08-10 12:15:00	56.1	10	1
121	2021-08-11 12:20:00	22.93	31	1
122	2021-08-11 12:20:00	22.47	13	1
123	2021-08-11 12:20:00	37.15	26	1
124	2021-09-07 14:00:00	45.9	13	1
125	2021-09-08 14:00:00	56.1	10	1
126	2021-09-14 14:05:00	6.04	8	1
127	2021-09-07 09:05:00	46.17	12	1
128	2021-09-07 09:30:00	45.88	11	1
129	2021-10-04 15:25:00	57.52	29	1
130	2021-10-11 15:25:00	45.88	11	1
131	2021-10-04 15:25:00	8.5	26	1
132	2021-10-12 15:25:00	73.7	13	1
133	2021-10-05 15:25:00	56.1	10	1
134	2021-10-12 15:25:00	46.17	12	1
135	2021-10-12 15:25:00	7.37	9	1
136	2021-12-15 12:50:00	97.5	13	1
137	2021-12-14 12:50:00	56.1	10	1
138	2021-12-14 12:55:00	59.52	11	1
139	2021-11-29 12:55:00	107.4	30	1
141	2021-11-24 13:00:00	91.79	31	1
140	2021-11-25 12:55:00	40.5	12	1
142	2021-11-16 13:00:00	56.1	10	1
143	2021-11-16 13:00:00	50.56	11	1
144	2021-11-12 13:00:00	92.4	13	1
145	2021-12-23 11:00:00	51.5	12	1
146	2021-12-28 11:00:00	48.85	31	1
147	2021-12-30 11:05:00	6.75	9	1
148	2021-12-30 11:05:00	6.04	8	1
149	2021-12-30 11:05:00	14.02	25	1
150	2021-12-30 11:05:00	45.73	29	1
151	2021-12-30 11:05:00	152.45	28	1
154	2022-01-14 16:25:00	89.25	10	1
155	2022-01-14 16:25:00	95.4	13	1
156	2022-01-14 16:30:00	65.92	11	1
157	2022-01-07 16:30:00	12.95	29	1
153	2022-01-25 16:25:00	79.05	12	1
158	2022-02-25 11:30:25	55.8	12	1
159	2022-02-18 11:30:54	210.82	8	1
160	2022-02-15 11:30:22	105.4	13	1
161	2022-02-14 11:30:35	56.1	10	1
162	2022-02-14 11:30:18	65.92	11	1
163	2022-03-04 10:05:25	2.62	26	1
164	2022-03-09 10:05:50	28.06	43	1
165	2022-03-11 10:05:20	50.8	26	1
166	2022-03-11 10:10:01	55.89	26	1
167	2022-03-15 10:10:39	56.1	10	1
168	2022-03-15 10:10:27	118.75	13	1
169	2022-03-16 10:10:02	2.64	27	1
170	2022-03-16 10:10:38	4.08	27	1
171	2022-03-16 10:10:12	30.78	27	1
172	2022-03-17 10:10:43	86.88	30	1
173	2022-03-17 10:10:09	6.94	30	1
174	2022-03-15 10:15:11	67.98	11	1
175	2022-04-25 07:55:36	61.38	12	1
176	2022-04-14 07:55:36	56.1	10	1
177	2022-04-14 07:55:30	110.4	13	1
178	2022-04-14 07:55:53	67.98	11	1
179	2022-04-08 07:55:23	40.14	29	1
180	2022-04-08 07:55:52	13.09	29	1
181	2022-04-08 07:55:16	35.56	43	1
182	2022-04-04 07:55:59	123.5	25	1
183	2022-04-01 08:00:45	8.5	26	1
193	2022-07-01 00:00:00	6.04	8	2
194	2022-06-25 00:00:00	63.24	12	3
195	2022-06-16 00:00:00	130	13	3
196	2022-06-15 00:00:00	56.1	10	3
197	2022-06-15 00:00:00	70.72	11	3
198	2022-06-09 00:00:00	53.55	43	3
199	2022-07-26 00:00:00	37.26	12	3
200	2022-07-16 00:00:00	179.08	13	3
201	2022-07-15 00:00:00	102.3	10	3
202	2022-07-15 00:00:00	41.3	11	3
203	2022-07-13 00:00:00	74.79	30	1
204	2022-07-09 00:00:00	15.84	29	2
205	2022-07-09 00:00:00	21.38	29	1
206	2022-07-09 00:00:00	163.28	43	3
207	2022-07-07 00:00:00	9.09	9	2
208	2022-07-02 00:00:00	8.96	26	2
212	2022-08-26 00:00:00	37.8	12	3
213	2022-08-18 00:00:00	19.79	27	1
214	2022-08-18 00:00:00	10.21	27	2
215	2022-08-16 00:00:00	162.8	13	3
216	2022-08-13 00:00:00	34.1	10	3
217	2022-08-13 00:00:00	43.2	11	3
218	2022-08-09 00:00:00	170.64	43	3
219	2022-09-01 00:00:00	5.22	31	1
220	2022-09-01 00:00:00	10.45	31	2
221	2022-08-31 00:00:00	47.09	26	2
222	2022-10-01 00:00:00	6.04	8	2
223	2022-09-24 00:00:00	39.42	12	3
224	2022-09-16 00:00:00	34.1	10	3
225	2022-09-16 00:00:00	4.83	48	3
226	2022-09-16 00:00:00	162.8	13	3
227	2022-09-16 00:00:00	43.2	11	3
228	2022-09-10 00:00:00	176.49	43	3
265	2022-10-26 00:00:00	40.5	12	3
266	2022-10-18 00:00:00	34.1	10	3
267	2022-10-18 00:00:00	5.77	48	3
268	2022-10-18 00:00:00	44.4	11	3
269	2022-10-15 00:00:00	154	13	3
270	2022-10-11 00:00:00	178.08	43	3
271	2022-10-08 00:00:00	8.6	29	1
272	2022-10-08 00:00:00	14.24	29	2
273	2022-10-06 00:00:00	65.93	9	1
274	2022-10-04 00:00:00	8.96	26	2
275	2022-11-26 00:00:00	48	12	3
276	2022-11-24 00:00:00	19.74	31	2
277	2022-11-24 00:00:00	40.35	31	1
278	2022-11-17 00:00:00	34.1	10	3
279	2022-11-17 00:00:00	7.8	48	3
280	2022-11-17 00:00:00	44.4	11	3
281	2022-11-15 00:00:00	163	13	3
282	2022-11-10 00:00:00	190.65	43	3
288	2022-12-30 00:00:00	186.61	28	2
289	2022-12-30 00:00:00	7.4	29	1
290	2022-12-30 00:00:00	43.55	25	2
291	2022-12-30 00:00:00	4.08	8	2
292	2022-12-28 00:00:00	19.96	9	2
293	2022-12-24 00:00:00	51.59	12	3
294	2022-12-22 00:00:00	9.92	9	2
295	2022-12-16 00:00:00	155.7	13	3
296	2022-12-15 00:00:00	34.1	10	3
297	2022-12-15 00:00:00	9.52	48	3
298	2022-12-15 00:00:00	44.4	11	3
299	2022-12-13 00:00:00	142.93	30	1
300	2022-12-09 00:00:00	189	43	3
301	2023-01-26 00:00:00	61.2	12	3
302	2023-01-14 00:00:00	16.64	29	2
303	2023-01-14 00:00:00	68.2	10	3
304	2023-01-14 00:00:00	13.32	48	3
305	2023-01-14 00:00:00	155.699	13	3
306	2023-01-14 00:00:00	45.88	11	3
307	2023-01-10 00:00:00	166.4	43	3
308	2023-02-25 00:00:00	52.359	12	3
309	2023-02-16 00:00:00	174	13	3
310	2023-02-15 00:00:00	34.1	10	3
311	2023-02-15 00:00:00	12.369	48	3
312	2023-02-15 00:00:00	46.619	11	3
313	2023-02-09 00:00:00	167.699	43	3
318	2023-03-25 00:00:00	53.82	12	3
319	2023-03-16 00:00:00	165.3	13	3
320	2023-03-16 00:00:00	16.06	27	1
321	2023-03-16 00:00:00	10.1	27	2
322	2023-03-15 00:00:00	49.5	10	3
323	2023-03-15 00:00:00	23.32	48	3
324	2023-03-15 00:00:00	168.99	43	3
325	2023-03-15 00:00:00	55.5	11	3
326	2023-03-11 00:00:00	59.06	26	2
\.


--
-- Data for Name: site_acoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_acoes (ativo_id, url) FROM stdin;
20	https://br.investing.com/equities/fleury-on-nm
16	https://br.investing.com/equities/itausa-on-ej-n1
21	https://br.investing.com/equities/weg-on-ej-nm
17	https://br.investing.com/equities/ambev-pn
18	https://br.investing.com/equities/bmfbovespa-on-nm
19	https://br.investing.com/equities/tractebel-on-nm
23	https://br.investing.com/equities/grendene-on-nm
24	https://br.investing.com/equities/m.diasbranco-on-ej-nm
25	https://br.investing.com/equities/odontoprev-on-ej-nm
31	https://br.investing.com/equities/visa-inc
29	https://br.investing.com/equities/amazon-com-inc
30	https://br.investing.com/equities/google-inc
32	https://br.investing.com/equities/microsoft-corp
34	https://br.investing.com/equities/accenture-ltd
35	https://br.investing.com/equities/novo-nordis
37	https://br.investing.com/etfs/ishares-comex-gold-trust
38	https://br.investing.com/equities/fii-cshg-log
39	https://br.investing.com/equities/xp-log-fdo-inv-imob-cf
40	https://br.investing.com/equities/xp-malls-fdo-inv-imob-fii
42	https://br.investing.com/equities/fii-fator-ve
49	https://br.investing.com/equities/fii-tg-ativo-real
50	https://br.investing.com/equities/facebook-inc
51	https://br.investing.com/crypto/bitcoin/btc-brl
53	https://br.investing.com/equities/kilima-fundos-imob-suno-30
54	https://br.investing.com/equities/prologis
55	https://br.investing.com/equities/realty-income
56	https://br.investing.com/currencies/usd-brl
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, password, authkey) FROM stdin;
2	admin	$2y$13$7IJhzQz16h97RiQIU0HuWOn8QLOSbBjMkGVAzuQjgXzvtD.yI.FZ6	\N
\.


--
-- Data for Name: xpath_bot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.xpath_bot (id, site_acao_id, data, xpath) FROM stdin;
\.


--
-- Name: acao_bolsa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.acao_bolsa_id_seq', 316, true);


--
-- Name: ativo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ativo_id_seq', 62, true);


--
-- Name: atualiza_acoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atualiza_acoes_id_seq', 1, false);


--
-- Name: atualiza_ativo_manual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atualiza_ativo_manual_id_seq', 1, true);


--
-- Name: atualiza_nu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atualiza_nu_id_seq', 5, true);


--
-- Name: atualiza_operacoes_manual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atualiza_operacoes_manual_id_seq', 4, true);


--
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditoria_id_seq', 16279, true);


--
-- Name: classes_operacoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_operacoes_id_seq', 8, true);


--
-- Name: investidor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.investidor_id_seq', 9, true);


--
-- Name: itens_ativo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itens_ativo_id_seq', 60, true);


--
-- Name: operacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operacao_id_seq', 960, true);


--
-- Name: operacoes_import_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operacoes_import_id_seq', 142, true);


--
-- Name: preco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preco_id_seq', 556, true);


--
-- Name: proventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proventos_id_seq', 330, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 7, true);


--
-- Name: xpath_bot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.xpath_bot_id_seq', 1, false);


--
-- Name: acao_bolsa acao_bolsa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acao_bolsa
    ADD CONSTRAINT acao_bolsa_pkey PRIMARY KEY (id);


--
-- Name: ativo ativo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ativo
    ADD CONSTRAINT ativo_pkey PRIMARY KEY (id);


--
-- Name: site_acoes atualiza_acao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_acoes
    ADD CONSTRAINT atualiza_acao_pkey PRIMARY KEY (ativo_id);


--
-- Name: atualiza_acoes atualiza_acoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_acoes
    ADD CONSTRAINT atualiza_acoes_pkey PRIMARY KEY (id);


--
-- Name: atualiza_ativo_manual atualiza_ativo_manual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_ativo_manual
    ADD CONSTRAINT atualiza_ativo_manual_pkey PRIMARY KEY (id);


--
-- Name: atualiza_nu atualiza_nu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_nu
    ADD CONSTRAINT atualiza_nu_pkey PRIMARY KEY (id);


--
-- Name: atualiza_operacoes_manual atualiza_operacoes_manual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_operacoes_manual
    ADD CONSTRAINT atualiza_operacoes_manual_pkey PRIMARY KEY (id);


--
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);


--
-- Name: auth_assignment auth_assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT auth_assignment_pkey PRIMARY KEY (item_name, user_id);


--
-- Name: auth_item_child auth_item_child_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_pkey PRIMARY KEY (parent, child);


--
-- Name: auth_item auth_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT auth_item_pkey PRIMARY KEY (name);


--
-- Name: auth_rule auth_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_pkey PRIMARY KEY (name);


--
-- Name: classes_operacoes classes_operacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes_operacoes
    ADD CONSTRAINT classes_operacoes_pkey PRIMARY KEY (id);


--
-- Name: investidor investidor_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investidor
    ADD CONSTRAINT investidor_cpf_key UNIQUE (cpf);


--
-- Name: investidor investidor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investidor
    ADD CONSTRAINT investidor_pkey PRIMARY KEY (id);


--
-- Name: itens_ativo itens_ativo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_ativo
    ADD CONSTRAINT itens_ativo_pkey PRIMARY KEY (id);


--
-- Name: migration migration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration
    ADD CONSTRAINT migration_pkey PRIMARY KEY (version);


--
-- Name: operacao operacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacao
    ADD CONSTRAINT operacao_pkey PRIMARY KEY (id);


--
-- Name: operacoes_import operacoes_import_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacoes_import
    ADD CONSTRAINT operacoes_import_pkey PRIMARY KEY (id);


--
-- Name: preco preco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco
    ADD CONSTRAINT preco_pkey PRIMARY KEY (id);


--
-- Name: proventos proventos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proventos
    ADD CONSTRAINT proventos_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: xpath_bot xpath_bot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpath_bot
    ADD CONSTRAINT xpath_bot_pkey PRIMARY KEY (id);


--
-- Name: bolsa_acao_codigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX bolsa_acao_codigo ON public.acao_bolsa USING btree (codigo);


--
-- Name: classe_operacoes_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX classe_operacoes_unique ON public.classes_operacoes USING btree (nome);


--
-- Name: idx-auth_assignment-user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx-auth_assignment-user_id" ON public.auth_assignment USING btree (user_id);


--
-- Name: idx-auth_item-type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx-auth_item-type" ON public.auth_item USING btree (type);


--
-- Name: intes_ativo_unique_investidor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX intes_ativo_unique_investidor ON public.itens_ativo USING btree (investidor_id, ativo_id);


--
-- Name: unique_atualiza_ativo_manual; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_atualiza_ativo_manual ON public.atualiza_ativo_manual USING btree (itens_ativo_id);


--
-- Name: unique_atualiza_operacoes_manual; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_atualiza_operacoes_manual ON public.atualiza_operacoes_manual USING btree (atualiza_ativo_manual_id, data);


--
-- Name: unique_cnpj; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_cnpj ON public.acao_bolsa USING btree (cnpj);


--
-- Name: unique_hash_investido; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_hash_investido ON public.operacoes_import USING btree (investidor_id, hash_nome);


--
-- Name: unique_mv_data_ativo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_mv_data_ativo ON public.proventos USING btree (data, itens_ativos_id, movimentacao);


--
-- Name: unique_operacoes_import_ativo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_operacoes_import_ativo ON public.atualiza_nu USING btree (operacoes_import_id, itens_ativo_id);


--
-- Name: unique_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_user ON public."user" USING btree (username);


--
-- Name: ativo ativo_acao_bolsa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ativo
    ADD CONSTRAINT ativo_acao_bolsa_id_fkey FOREIGN KEY (acao_bolsa_id) REFERENCES public.acao_bolsa(id);


--
-- Name: preco ativo_preco_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco
    ADD CONSTRAINT ativo_preco_id_fk FOREIGN KEY (ativo_id) REFERENCES public.ativo(id);


--
-- Name: site_acoes atualiza_acao_ativo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_acoes
    ADD CONSTRAINT atualiza_acao_ativo_id_fkey FOREIGN KEY (ativo_id) REFERENCES public.ativo(id);


--
-- Name: preco atualiza_acoes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preco
    ADD CONSTRAINT atualiza_acoes_id_fk FOREIGN KEY (atualiza_acoes_id) REFERENCES public.atualiza_acoes(id);


--
-- Name: atualiza_ativo_manual atualiza_ativo_manual_itens_ativo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_ativo_manual
    ADD CONSTRAINT atualiza_ativo_manual_itens_ativo_id_fk FOREIGN KEY (itens_ativo_id) REFERENCES public.itens_ativo(id);


--
-- Name: atualiza_nu atualiza_nu_itens_ativo_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_nu
    ADD CONSTRAINT atualiza_nu_itens_ativo_pk FOREIGN KEY (itens_ativo_id) REFERENCES public.itens_ativo(id);


--
-- Name: atualiza_nu atualiza_nu_operacoes_import_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_nu
    ADD CONSTRAINT atualiza_nu_operacoes_import_pk FOREIGN KEY (operacoes_import_id) REFERENCES public.operacoes_import(id);


--
-- Name: atualiza_operacoes_manual atualiza_operacoes_manual_atualiza_ativo_manual_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atualiza_operacoes_manual
    ADD CONSTRAINT atualiza_operacoes_manual_atualiza_ativo_manual_id_fk FOREIGN KEY (atualiza_ativo_manual_id) REFERENCES public.atualiza_ativo_manual(id);


--
-- Name: auditoria auditoria_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria
    ADD CONSTRAINT auditoria_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: auth_assignment auth_assignment_item_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_assignment
    ADD CONSTRAINT auth_assignment_item_name_fkey FOREIGN KEY (item_name) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_child_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_child_fkey FOREIGN KEY (child) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item_child auth_item_child_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item_child
    ADD CONSTRAINT auth_item_child_parent_fkey FOREIGN KEY (parent) REFERENCES public.auth_item(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_item auth_item_rule_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_item
    ADD CONSTRAINT auth_item_rule_name_fkey FOREIGN KEY (rule_name) REFERENCES public.auth_rule(name) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ativo classe_atualiza_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ativo
    ADD CONSTRAINT classe_atualiza_id_fk FOREIGN KEY (classe_atualiza_id) REFERENCES public.classes_operacoes(id);


--
-- Name: operacao fk_itens_ativos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacao
    ADD CONSTRAINT fk_itens_ativos FOREIGN KEY (itens_ativos_id) REFERENCES public.itens_ativo(id);


--
-- Name: itens_ativo itens_ativo_ativo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_ativo
    ADD CONSTRAINT itens_ativo_ativo_id_fkey FOREIGN KEY (ativo_id) REFERENCES public.ativo(id);


--
-- Name: itens_ativo itens_ativo_investidor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_ativo
    ADD CONSTRAINT itens_ativo_investidor_id_fkey FOREIGN KEY (investidor_id) REFERENCES public.investidor(id);


--
-- Name: proventos itens_ativos_proventos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proventos
    ADD CONSTRAINT itens_ativos_proventos_fk FOREIGN KEY (itens_ativos_id) REFERENCES public.itens_ativo(id);


--
-- Name: operacoes_import operacoes_import_investidor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operacoes_import
    ADD CONSTRAINT operacoes_import_investidor_id_fkey FOREIGN KEY (investidor_id) REFERENCES public.investidor(id);


--
-- Name: xpath_bot xpath_invest_site_acao_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xpath_bot
    ADD CONSTRAINT xpath_invest_site_acao_id_fk FOREIGN KEY (site_acao_id) REFERENCES public.site_acoes(ativo_id);


--
-- PostgreSQL database dump complete
--

