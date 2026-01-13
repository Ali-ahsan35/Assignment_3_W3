--
-- PostgreSQL database dump
--

\restrict GBfd6GmuffsaqHXFSK0quwmkPzmlF8y3zPASQmPaPmMrmiEGbXrwwbwKuJp76Fx

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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
-- Name: attractions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attractions (
    id integer NOT NULL,
    attraction_name character varying(255) NOT NULL,
    attraction_slug character varying(255),
    additional_info text,
    cancellation_policy text,
    images jsonb,
    price numeric(10,2),
    whats_included text,
    country character varying(100),
    city character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.attractions OWNER TO postgres;

--
-- Name: attractions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attractions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attractions_id_seq OWNER TO postgres;

--
-- Name: attractions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attractions_id_seq OWNED BY public.attractions.id;


--
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flights (
    id integer NOT NULL,
    flight_name character varying(255) NOT NULL,
    arrival_airport character varying(255),
    departure_airport character varying(255),
    arrival_time timestamp without time zone,
    departure_time timestamp without time zone,
    flight_logo text,
    fare numeric(10,2),
    location_country character varying(100),
    additional_info jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flights OWNER TO postgres;

--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_id_seq OWNER TO postgres;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    location_name character varying(255) NOT NULL,
    country_code character varying(10),
    country character varying(100),
    additional_info jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: attractions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attractions ALTER COLUMN id SET DEFAULT nextval('public.attractions_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Data for Name: attractions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attractions (id, attraction_name, attraction_slug, additional_info, cancellation_policy, images, price, whats_included, country, city, created_at) FROM stdin;
1	The Taj Mahal Tower, Mumbai	attraction--2092174-0	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/31204963.jpg?k=90c11832231c37a814e9631123bd28820e8ad8cd983b78ad529ea139791653d1&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/31204963.jpg?k=90c11832231c37a814e9631123bd28820e8ad8cd983b78ad529ea139791653d1&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/31204963.jpg?k=90c11832231c37a814e9631123bd28820e8ad8cd983b78ad529ea139791653d1&o="]	277.27		India	Mumbai	2026-01-12 12:01:18.484105
2	Trident Nariman Point	attraction--2092174-1	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/604298804.jpg?k=cce8e6992a6c78904e7a67b9611da9a34ed490aada9e82aa865b70f308200755&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/604298804.jpg?k=cce8e6992a6c78904e7a67b9611da9a34ed490aada9e82aa865b70f308200755&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/604298804.jpg?k=cce8e6992a6c78904e7a67b9611da9a34ed490aada9e82aa865b70f308200755&o="]	232.91		India	Mumbai	2026-01-12 12:01:18.494027
3	hotel Sunrise Residency	attraction--2092174-2	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/794039251.jpg?k=ea9470847a9c7077e39b52af35d17253c201c4c8845cd045b894d1d40927d6e7&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/794039251.jpg?k=ea9470847a9c7077e39b52af35d17253c201c4c8845cd045b894d1d40927d6e7&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/794039251.jpg?k=ea9470847a9c7077e39b52af35d17253c201c4c8845cd045b894d1d40927d6e7&o="]	31.05		India	Mumbai	2026-01-12 12:01:18.496673
4	Ginger Mumbai Airport	attraction--2092174-3	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/533708472.jpg?k=bacaaddc4d3b8ff3bdec7814f7999335f0fc437c087e74ddcd2bef20a4c8a7c7&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/533708472.jpg?k=bacaaddc4d3b8ff3bdec7814f7999335f0fc437c087e74ddcd2bef20a4c8a7c7&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/533708472.jpg?k=bacaaddc4d3b8ff3bdec7814f7999335f0fc437c087e74ddcd2bef20a4c8a7c7&o="]	83.17		India	Mumbai	2026-01-12 12:01:18.500501
5	Aurika, Mumbai International Airport - Luxury by Lemon Tree Hotels	attraction--2092174-4	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/530661047.jpg?k=d782b16d5d3862daac3568e3f0fd1ea8f8fae182f694fb4f5cf80602baa4452e&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/530661047.jpg?k=d782b16d5d3862daac3568e3f0fd1ea8f8fae182f694fb4f5cf80602baa4452e&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/530661047.jpg?k=d782b16d5d3862daac3568e3f0fd1ea8f8fae182f694fb4f5cf80602baa4452e&o="]	177.45		India	Mumbai	2026-01-12 12:01:18.504191
6	ICONIQA Hotel Mumbai International Airport	attraction--2092174-5	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/702463188.jpg?k=f26718c424ba64e8875a24c7c87fd6715fdd86a3d278810e8bb701ca7558f3d2&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/702463188.jpg?k=f26718c424ba64e8875a24c7c87fd6715fdd86a3d278810e8bb701ca7558f3d2&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/702463188.jpg?k=f26718c424ba64e8875a24c7c87fd6715fdd86a3d278810e8bb701ca7558f3d2&o="]	117.84		India	Mumbai	2026-01-12 12:01:18.50794
7	Hotel Harbour View Colaba	attraction--2092174-6	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/121529259.jpg?k=9b0697e413fbef7ace2f65808ab63979cd80dab424f42289c2eadf925c46e831&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/121529259.jpg?k=9b0697e413fbef7ace2f65808ab63979cd80dab424f42289c2eadf925c46e831&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/121529259.jpg?k=9b0697e413fbef7ace2f65808ab63979cd80dab424f42289c2eadf925c46e831&o="]	105.36		India	Mumbai	2026-01-12 12:01:18.512209
8	The Royal Orchid Hotel, Chembur	attraction--2092174-7	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/130009356.jpg?k=dd7b5c021228eff0e4205e042d6867d41b9efd36d826c38ea588a10c89067321&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/130009356.jpg?k=dd7b5c021228eff0e4205e042d6867d41b9efd36d826c38ea588a10c89067321&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/130009356.jpg?k=dd7b5c021228eff0e4205e042d6867d41b9efd36d826c38ea588a10c89067321&o="]	36.60		India	Mumbai	2026-01-12 12:01:18.51565
9	ibis Mumbai BKC	attraction--2092174-8	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/800586050.jpg?k=4e614467bdaaf0eae30d9edb8efd2f9843fa11b47bbe47974199b6a2f6ffabb3&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/800586050.jpg?k=4e614467bdaaf0eae30d9edb8efd2f9843fa11b47bbe47974199b6a2f6ffabb3&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/800586050.jpg?k=4e614467bdaaf0eae30d9edb8efd2f9843fa11b47bbe47974199b6a2f6ffabb3&o="]	104.31		India	Mumbai	2026-01-12 12:01:18.519128
10	The Leela Mumbai	attraction--2092174-9	Details not available	Check with provider	["https://cf.bstatic.com/xdata/images/hotel/square500/47218682.jpg?k=57487efa48599f844940e0af3543cde0e52730156ad386cd2c5362227fc99502&o=", "https://cf.bstatic.com/xdata/images/hotel/square1024/47218682.jpg?k=57487efa48599f844940e0af3543cde0e52730156ad386cd2c5362227fc99502&o=", "https://cf.bstatic.com/xdata/images/hotel/square2000/47218682.jpg?k=57487efa48599f844940e0af3543cde0e52730156ad386cd2c5362227fc99502&o="]	244.55		India	Mumbai	2026-01-12 12:01:18.523772
11	Amsterdam Drugs Tour (Self-Guided, Amsterdam City Centre)	prx8uuqpnfxl-amsterdam-drugs-tour-self-guided-amsterdam-city-centre	Experience this tour at any time, through the convenience of downloading the tour to your mobile phone.The tour starts and ends at Amsterdam Central Station and takes you through the Zeedijk, the Red Light District and via the Dam to the Spuistraat. Discover the city's hidden drug history: the Red Light areas, the places where overdose and murder were rife, as well as the safe spaces that people who used drugs created for themselves.	Not specified	[]	0.00	Not specified	nl	Amsterdam	2026-01-13 10:42:12.90186
12	Amsterdam’s Ghostly Experiences	prpnlvtaihxe-amsterdams-ghostly-experiences	GHOSTS OF AMSTERDAM\nThe dark history of almost 800 years hangs heavily over Amsterdam, and the past is lurking down every dark alley and street corner. Ancient souls wander Amsterdam’s many streets and buildings, endlessly searching, but for what? We do not know. \nBloody tales of murder, betrayal and even madness driven by love and jealousy flow through the many stories of troubled shadows that appear, mainly at night. Yet most locals will tell you they do not believe in ghosts…\nEXPLORE DARK ALLEYS\nWith a lantern by their side, our guide will take you on a quest to uncover the darker side of Amsterdam as we hear tales full of darkness and treachery. On this fun tour, our guide will share some of the history of Amsterdam, along with some of the spookier stories from the city. Whilst the focus of this tour is very much on fun, our guide will share some of the darker tales of the city.\nSEE THE CITY AT NIGHT\nThe city looks magical at night, with the lights on the bridges and reflections in the canals, so this tour isn't all darkness. Although, who knows who or what we may discover as we explore the city in the darkest depths of night? On these tours, the spirits have a way of making their presence felt…\nOur tours in Amsterdam are small-scale and personal with a maximum of 15 people per guide.\nGuides\nOur guides have all lived in Amsterdam for a long time and know the city like the back of their hand. During the tours they will show you both the highlights and the hidden secrets of the city.	Not specified	[]	0.00	Not specified	nl	Amsterdam	2026-01-13 10:42:14.386774
13	Private Transfer from Amsterdam to Cruise Port Amsterdam	prfz1nfmp2sy-private-transfer-from-amsterdam-to-cruise-port-amsterdam	We only employs professional drivers. In our fleet you will find various Mercedes Benz vehicles. All our vehicles are not older than 5 years and are clean at all times. You will also find a lot of comfort in our vehicles. You will find free Wi-Fi and bottled water in all our vehicles.	Not specified	[]	0.00	Not specified	nl	Amsterdam	2026-01-13 10:42:16.111421
14	Private One way Transfer Amsterdam Airport to Amsterdam	prxnif5xotrk-private-one-way-transfer-amsterdam-airport-to-amsterdam	We understand the importance of ensuring a hassle-free transfer experience. Our private airport transfer service allows you just that. Book our private airport transfer service and enjoy a safe, reliable, comfortable, and convenient journey from Amsterdam Airport Schiphol (AMS) to your accommodation in Amsterdam. Let us take care of your transportation needs, allowing you to focus on enjoying your trip to the fullest.	Not specified	[]	0.00	Not specified	nl	Amsterdam	2026-01-13 10:42:17.704622
15	Private Transfer From Amsterdam City To Amsterdam Airport	prqdqbxb4jaj-private-transfer-from-amsterdam-city-to-amsterdam-airport	Your transfer will be provided with a nice and comfortable Mercedes Minivan with air conditioner. There will be free water on board.\nThis is a private transfer, which means that you will only travel with your family or friends. \nYou will get a professional English speaking driver.	Not specified	[]	0.00	Not specified	nl	Amsterdam	2026-01-13 10:42:19.197778
16	Dubai Airport to Dubai Hotel Transfers	pribx30s4rp5-dubai-airport-to-dubai-hotel-transfers	As you land at Dubai International Airport, you’ll be welcomed by a friendly driver. He’ll escort you to the vehicle and assist you with all your baggage \n\nOur Airport Representative will hold your name Placard at waiting Area	Not specified	[]	0.00	Not specified	ae	Dubai	2026-01-13 10:42:22.830908
17	Dubai Airport Transfer to Dubai Hotel	prccs9nut4z9-dubai-airport-transfer-to-dubai-hotel	Enjoy a simple transfer to your location from the Dubai Airport with Efficient Tourism. A friendly driver will be there to welcome you and help you with your bags when you arrive. A personalized sign featuring your name will glitter, and you will be expertly escorted to your private vehicle for a luxurious transfer experience. Allow yourself to be transported in elegance from the busy airport to your peaceful hotel.	Not specified	[]	0.00	Not specified	ae	Dubai	2026-01-13 10:42:24.443535
18	Dubai Premium Transfer from Dubai city centre to Dubai airport	prdytbm0gwny-dubai-premium-transfer-from-dubai-city-centre-to-dubai-airport	Take the worry out for your departure to Dubai Airport (DXB) and pre-book a private transfer to suit your group size (up to 7 people). Avoid the long lines for taxis, and travel in the comfort of a Premium / Luxury car or minivan.	Not specified	[]	0.00	Not specified	ae	Dubai	2026-01-13 10:42:25.953296
19	Dubai Old Dubai Walking Tour	pruasm1chehb-dubai-old-dubai-walking-tour	Book your Old Dubai City Tour with Travel Saga Tourism. With this Heritage walk in Old Dubai you can gain a better understanding of the history and culture of the Old part of Dubai. Furthermore, on this historic Old Dubai walking tour you will get to know the markets and landmarks a little better, as you will be exploring this part of the city on foot. After picking you up from the hotel, you will be walking for 4 hours to explore landmarks, markets, and cafes in the old Dubai area. Thus, contact us today to get more info about the Dubai Old Town Walking Tour.	Not specified	[]	0.00	Not specified	ae	Dubai	2026-01-13 10:42:58.259166
20	Dubai Helicopter Tour: Experience Dubai’s Iconic Landmarks	pryoe6uaqqgi-dubai-helicopter-tour-experience-dubais-iconic-landmarks	Take to the skies with a thrilling Dubai Helicopter Tour and witness the city's iconic landmarks from a breathtaking perspective. Fly over world-famous attractions like the Burj Khalifa, Palm Jumeirah, and the Burj Al Arab as you enjoy panoramic views of the stunning skyline and coastline. Perfect for adventure seekers and photographers, this unforgettable experience lets you capture Dubai’s beauty like never before. Make your trip to Dubai truly special with this high-flying adventure!\n\nHighlights:\n\nThrilling helicopter ride over Dubai’s top landmarks.\nSee the Burj Khalifa, Palm Jumeirah, and Burj Al Arab from the sky.\nSpectacular panoramic views of Dubai’s skyline and coastline.\nPerfect for adventure lovers and photographers.\nUnforgettable way to experience Dubai’s beauty.	Not specified	[]	0.00	Not specified	ae	Dubai	2026-01-13 10:43:00.072649
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flights (id, flight_name, arrival_airport, departure_airport, arrival_time, departure_time, flight_logo, fare, location_country, additional_info, created_at) FROM stdin;
1	AJET	Dubai	Schiphol Airport	2026-01-14 02:45:00	2026-01-13 13:35:00	https://r-xx.bstatic.com/data/airlines_logo/VF.png	212.42	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_0VQbW-qMBT-NfqtpQVEXNLcMECnF7jy", "currency": "USD", "total_time": 36600, "cabin_class": "ECONOMY", "flight_number": 2}	2026-01-13 07:09:33.68633
2	Pegasus Airlines	Dubai	Schiphol Airport	2026-01-14 04:15:00	2026-01-13 15:55:00	https://r-xx.bstatic.com/data/airlines_logo/PC.png	335.36	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_0WRbW-bMBSFf03yzcbmvZWsiQHpQsAk", "currency": "USD", "total_time": 33600, "cabin_class": "ECONOMY", "flight_number": 1254}	2026-01-13 07:09:33.69888
3	Pegasus Airlines	Dubai	Schiphol Airport	2026-01-14 06:00:00	2026-01-13 15:55:00	https://r-xx.bstatic.com/data/airlines_logo/PC.png	335.36	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_y1Ra2-yMBT-NfqtpUVQtqR5w7gsIBfl", "currency": "USD", "total_time": 39900, "cabin_class": "ECONOMY", "flight_number": 1254}	2026-01-13 07:09:33.700799
4	AJET	Dubai	Schiphol Airport	2026-01-14 02:10:00	2026-01-13 13:35:00	https://r-xx.bstatic.com/data/airlines_logo/VF.png	453.91	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_z1QW4-iMBT-NeNbS1sZwEmaDQOojICK", "currency": "USD", "total_time": 34500, "cabin_class": "ECONOMY", "flight_number": 2}	2026-01-13 07:09:33.702387
5	Kuwait Airways Corp	Dubai	Schiphol Airport	2026-01-14 03:30:00	2026-01-13 14:25:00	https://r-xx.bstatic.com/data/airlines_logo/KU.png	469.63	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_y1RW4-iMBT-NfrWQuW6kzQbFlhhBLy1", "currency": "USD", "total_time": 36300, "cabin_class": "ECONOMY", "flight_number": 128}	2026-01-13 07:09:33.704387
6	Emirates Airlines	Dubai	Schiphol Airport	2026-01-14 00:15:00	2026-01-13 14:40:00	https://r-xx.bstatic.com/data/airlines_logo/EK.png	760.24	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_y2QW2-CMBiGf43etbSAgibNgoAO5aCI", "currency": "USD", "total_time": 23700, "cabin_class": "ECONOMY", "flight_number": 148}	2026-01-13 07:09:33.705963
7	Saudi Arabian Airlines	Dubai	Schiphol Airport	2026-01-14 04:55:00	2026-01-13 15:20:00	https://r-xx.bstatic.com/data/airlines_logo/SV.png	488.58	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_y1QW4-iMBT-NfrW0srNmaTZILCuDhdH", "currency": "USD", "total_time": 38100, "cabin_class": "ECONOMY", "flight_number": 214}	2026-01-13 07:09:33.707454
8	Emirates Airlines	Dubai	Schiphol Airport	2026-01-13 23:25:00	2026-01-13 13:40:00	https://r-xx.bstatic.com/data/airlines_logo/EK.png	760.24	United Arab Emirates	{"route": "Amsterdam → Dubai", "token": "d6a1f_H4sIAAAAAAAA_y2QW2-CMBiGf43etbSAgCbNgoAbykER", "currency": "USD", "total_time": 24300, "cabin_class": "ECONOMY", "flight_number": 146}	2026-01-13 07:09:33.70909
9	Transavia Airlines	Schiphol Airport	Dubai	2026-01-13 23:20:00	2026-01-13 17:30:00	https://r-xx.bstatic.com/data/airlines_logo/HV.png	341.61	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_y2Q2W6jMBSGnya5szFLgVayRhRoQ4Yd", "currency": "USD", "total_time": 31800, "cabin_class": "ECONOMY", "flight_number": 6902}	2026-01-13 07:09:33.711685
10	flyadeal	Schiphol Airport	Dubai	2026-01-14 10:40:00	2026-01-13 23:05:00	https://r-xx.bstatic.com/data/airlines_logo/F3.png	346.18	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_01RbY-iMBD-Neu3FkpB2E2aCwuoqKBC", "currency": "USD", "total_time": 52500, "cabin_class": "ECONOMY", "flight_number": 526}	2026-01-13 07:09:33.714499
11	Royal Jordanian	Schiphol Airport	Dubai	2026-01-14 14:05:00	2026-01-13 22:45:00	https://r-xx.bstatic.com/data/airlines_logo/RJ.png	344.50	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_y1RW4-qMBD-NfrWQgEBN2lOOFwWXEEs", "currency": "USD", "total_time": 66000, "cabin_class": "ECONOMY", "flight_number": 615}	2026-01-13 07:09:33.716156
12	flyadeal	Schiphol Airport	Dubai	2026-01-14 10:40:00	2026-01-13 21:30:00	https://r-xx.bstatic.com/data/airlines_logo/F3.png	346.18	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_02Rb4-iMBDGP42-K1AKgps0FxZQ8U9V", "currency": "USD", "total_time": 58200, "cabin_class": "ECONOMY", "flight_number": 512}	2026-01-13 07:09:33.717389
13	flynas	Schiphol Airport	Dubai	2026-01-14 10:40:00	2026-01-13 21:35:00	https://r-xx.bstatic.com/data/airlines_logo/XY.png	351.78	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_01RW5OaMBT-NfqWYLgYdmcyHRZQ8RIV", "currency": "USD", "total_time": 57900, "cabin_class": "ECONOMY", "flight_number": 210}	2026-01-13 07:09:33.718553
14	flyadeal	Schiphol Airport	Dubai	2026-01-14 10:40:00	2026-01-13 20:50:00	https://r-xx.bstatic.com/data/airlines_logo/F3.png	346.18	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_01RbY-iMBD-NfqthVIQdpPmwgIqilWh", "currency": "USD", "total_time": 60600, "cabin_class": "ECONOMY", "flight_number": 508}	2026-01-13 07:09:33.719804
15	flynas	Schiphol Airport	Dubai	2026-01-14 18:35:00	2026-01-13 23:50:00	https://r-xx.bstatic.com/data/airlines_logo/XY.png	294.21	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_0VRbY-iMBD-Neu3FgtIcZPmglBcVMBD", "currency": "USD", "total_time": 78300, "cabin_class": "ECONOMY", "flight_number": 248}	2026-01-13 07:09:33.721337
16	flynas	Schiphol Airport	Dubai	2026-01-14 18:35:00	2026-01-13 23:50:00	https://r-xx.bstatic.com/data/airlines_logo/XY.png	294.21	Netherlands	{"route": "Dubai → Amsterdam", "token": "d6a1f_H4sIAAAAAAAA_0VRW4-iMBT-NeNbi-XuJM2GgaIooIug", "currency": "USD", "total_time": 78300, "cabin_class": "ECONOMY", "flight_number": 248}	2026-01-13 07:09:33.723138
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, location_name, country_code, country, additional_info, created_at) FROM stdin;
4	Mumbai	in	India	{"dest_id": "-2092174", "dest_type": "city"}	2026-01-12 12:01:16.772227
5	Dubai	ae	United Arab Emirates	{"region": "Dubai Emirate", "dest_id": "-782831", "dest_type": "city"}	2026-01-13 07:59:55.951079
6	Paris	fr	France	{"region": "Ile de France", "dest_id": "-1456928", "dest_type": "city"}	2026-01-13 07:59:57.241849
\.


--
-- Name: attractions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attractions_id_seq', 20, true);


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flights_id_seq', 16, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 6, true);


--
-- Name: attractions attractions_attraction_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attractions
    ADD CONSTRAINT attractions_attraction_slug_key UNIQUE (attraction_slug);


--
-- Name: attractions attractions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attractions
    ADD CONSTRAINT attractions_pkey PRIMARY KEY (id);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: idx_attractions_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attractions_city ON public.attractions USING btree (city);


--
-- Name: idx_attractions_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attractions_country ON public.attractions USING btree (country);


--
-- Name: idx_flights_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_flights_location ON public.flights USING btree (location_country);


--
-- Name: idx_locations_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_locations_name ON public.locations USING btree (location_name);


--
-- PostgreSQL database dump complete
--

\unrestrict GBfd6GmuffsaqHXFSK0quwmkPzmlF8y3zPASQmPaPmMrmiEGbXrwwbwKuJp76Fx

