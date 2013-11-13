--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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

--
-- Name: daytype; Type: TYPE; Schema: public; Owner: postgres
--

/*CREATE TYPE daytype AS ENUM (
    'DAY',
    'DAYNIGHT'
);*/


ALTER TYPE public.daytype OWNER TO postgres;

--
-- Name: resulttype; Type: TYPE; Schema: public; Owner: postgres
--

/*CREATE TYPE resulttype AS ENUM (
    'TEAMA',
    'TEAMB',
    'DRAW',
    'TIE',
    'NORESULT'
);*/


ALTER TYPE public.resulttype OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: coach; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coach (
    id integer NOT NULL
);


ALTER TABLE public.coach OWNER TO postgres;

--
-- Name: cricketperson; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cricketperson (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    dob date NOT NULL
);


ALTER TABLE public.cricketperson OWNER TO postgres;

--
-- Name: cricketperson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cricketperson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cricketperson_id_seq OWNER TO postgres;

--
-- Name: cricketperson_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cricketperson_id_seq OWNED BY cricketperson.id;


--
-- Name: inoditournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE inoditournament (
    matchid integer NOT NULL,
    tournamentname character varying(30) NOT NULL,
    year integer NOT NULL,
    stage character varying(20)
);


ALTER TABLE public.inoditournament OWNER TO postgres;

--
-- Name: int20tournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE int20tournament (
    matchid integer NOT NULL,
    tournamentname character varying(30) NOT NULL,
    year integer NOT NULL,
    stage character varying(20)
);


ALTER TABLE public.int20tournament OWNER TO postgres;

--
-- Name: intesttournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE intesttournament (
    matchid integer NOT NULL,
    tournamentname character varying(30) NOT NULL,
    year integer NOT NULL,
    stage character varying(20)
);


ALTER TABLE public.intesttournament OWNER TO postgres;

--
-- Name: isinteam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE isinteam (
    country character varying(20) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.isinteam OWNER TO postgres;

--
-- Name: match; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE match (
    id integer NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.match OWNER TO postgres;

--
-- Name: match_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE match_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.match_id_seq OWNER TO postgres;

--
-- Name: match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE match_id_seq OWNED BY match.id;


--
-- Name: matchaward; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE matchaward (
    matchid integer NOT NULL,
    playerid integer NOT NULL,
    awardname character varying(30)
);


ALTER TABLE public.matchaward OWNER TO postgres;

--
-- Name: odiallrounderranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odiallrounderranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.odiallrounderranking OWNER TO postgres;

--
-- Name: odibatsman; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibatsman (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numnotouts integer NOT NULL,
    runs integer NOT NULL,
    highscore integer NOT NULL,
    average real NOT NULL,
    strikerate real NOT NULL,
    fifties integer NOT NULL,
    hundreds integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    CONSTRAINT odibatsman_check CHECK ((runs >= ((4 * fours) + (6 * sixes)))),
    CONSTRAINT odibatsman_check1 CHECK ((numnotouts <= numinnings))
);


ALTER TABLE public.odibatsman OWNER TO postgres;

--
-- Name: odibatsmanranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibatsmanranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.odibatsmanranking OWNER TO postgres;

--
-- Name: odibattingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibattingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsmanid integer NOT NULL,
    runsscored integer NOT NULL,
    ballsfaced integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    strikerate real,
    battingposition integer NOT NULL,
    CONSTRAINT odibattingscorecard_battingposition_check CHECK (((battingposition < 12) AND (battingposition > 0)))
);


ALTER TABLE public.odibattingscorecard OWNER TO postgres;

--
-- Name: odibowler; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibowler (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numballs integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    bestperformancewickets integer NOT NULL,
    bestperformanceruns integer NOT NULL,
    average real NOT NULL,
    economy real NOT NULL,
    strikerate real,
    num5w integer NOT NULL,
    CONSTRAINT odibowler_bestperformancewickets_check CHECK ((bestperformancewickets < 11))
);


ALTER TABLE public.odibowler OWNER TO postgres;

--
-- Name: odibowlerranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibowlerranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.odibowlerranking OWNER TO postgres;

--
-- Name: odibowlingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odibowlingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    bowlerid integer NOT NULL,
    oversbowled real NOT NULL,
    maidenovers integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    economyrate real NOT NULL,
    CONSTRAINT odibowlingscorecard_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.odibowlingscorecard OWNER TO postgres;

--
-- Name: odicoach; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odicoach (
    countryname character varying(20),
    coachid integer NOT NULL,
    role character varying(20) NOT NULL
);


ALTER TABLE public.odicoach OWNER TO postgres;

--
-- Name: odiinnings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odiinnings (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    score integer NOT NULL,
    wickets integer NOT NULL,
    overs integer NOT NULL,
    battingteamname character varying(30),
    CONSTRAINT odiinnings_inningnum_check CHECK (((inningnum < 3) AND (inningnum > 0))),
    CONSTRAINT odiinnings_overs_check CHECK ((overs <= 50)),
    CONSTRAINT odiinnings_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.odiinnings OWNER TO postgres;

--
-- Name: odimatch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odimatch (
    id integer NOT NULL,
    date date NOT NULL,
    result resulttype,
    dayversusdaynight daytype,
    umpire1 integer,
    umpire2 integer,
    umpire3 integer,
    tosswonby character varying(20),
    teama character varying(20),
    teamb character varying(20),
    venueid integer,
    teamacaptainid integer,
    teambcaptainid integer,
    teamawkid integer,
    teambwkid integer,
    CONSTRAINT odimatch_check CHECK ((((teama)::text <> (teamb)::text) AND (((tosswonby)::text = (teama)::text) OR ((tosswonby)::text = (teamb)::text)))),
    CONSTRAINT odimatch_check1 CHECK ((((umpire1 <> umpire2) AND (umpire2 <> umpire3)) AND (umpire3 <> umpire1)))
);


ALTER TABLE public.odimatch OWNER TO postgres;

--
-- Name: odipartnershipscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odipartnershipscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsman1id integer,
    batsman2id integer,
    wicketnumber integer NOT NULL,
    incomingruns integer NOT NULL,
    partnershipruns integer NOT NULL,
    CONSTRAINT odipartnershipscorecard_check CHECK ((batsman1id <> batsman2id)),
    CONSTRAINT odipartnershipscorecard_wicketnumber_check CHECK (((wicketnumber < 11) AND (wicketnumber > 0)))
);


ALTER TABLE public.odipartnershipscorecard OWNER TO postgres;

--
-- Name: odiplayer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odiplayer (
    id integer NOT NULL,
    nummatches integer NOT NULL,
    numcatches integer NOT NULL,
    CONSTRAINT odiplayer_check CHECK (((10 * nummatches) >= numcatches))
);


ALTER TABLE public.odiplayer OWNER TO postgres;

--
-- Name: odiranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odiranking (
    countryname character varying(20) NOT NULL,
    rank integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public.odiranking OWNER TO postgres;

--
-- Name: oditeam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oditeam (
    countryname character varying(20) NOT NULL,
    matchesplayed integer,
    matcheswon integer,
    matchesdrawn integer,
    CONSTRAINT oditeam_check CHECK ((matchesplayed >= (matcheswon + matchesdrawn)))
);


ALTER TABLE public.oditeam OWNER TO postgres;

--
-- Name: oditournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oditournament (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    result character varying(30)
);


ALTER TABLE public.oditournament OWNER TO postgres;

--
-- Name: oditournamentaward; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oditournamentaward (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    playerid integer NOT NULL,
    awardname character varying(30)
);


ALTER TABLE public.oditournamentaward OWNER TO postgres;

--
-- Name: oditournamentwinner; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oditournamentwinner (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    countryname character varying(20) NOT NULL
);


ALTER TABLE public.oditournamentwinner OWNER TO postgres;

--
-- Name: odiwicketkeeper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE odiwicketkeeper (
    id integer NOT NULL,
    stumpings integer NOT NULL
);


ALTER TABLE public.odiwicketkeeper OWNER TO postgres;

--
-- Name: playedinodi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE playedinodi (
    matchid integer NOT NULL,
    playerid integer NOT NULL
);


ALTER TABLE public.playedinodi OWNER TO postgres;

--
-- Name: playedint20; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE playedint20 (
    matchid integer NOT NULL,
    playerid integer NOT NULL
);


ALTER TABLE public.playedint20 OWNER TO postgres;

--
-- Name: playedintest; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE playedintest (
    matchid integer NOT NULL,
    playerid integer NOT NULL
);


ALTER TABLE public.playedintest OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE player (
    id integer NOT NULL,
    battingstyle character varying(30),
    bowlingstyle character varying(30)
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_id_seq OWNER TO postgres;

--
-- Name: player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE player_id_seq OWNED BY player.id;


--
-- Name: t20allrounderranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20allrounderranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.t20allrounderranking OWNER TO postgres;

--
-- Name: t20batsman; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20batsman (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numnotouts integer NOT NULL,
    runs integer NOT NULL,
    highscore integer NOT NULL,
    average real NOT NULL,
    strikerate real NOT NULL,
    fifties integer NOT NULL,
    hundreds integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    CONSTRAINT t20batsman_check CHECK ((runs >= ((4 * fours) + (6 * sixes)))),
    CONSTRAINT t20batsman_check1 CHECK ((numnotouts <= numinnings))
);


ALTER TABLE public.t20batsman OWNER TO postgres;

--
-- Name: t20batsmanranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20batsmanranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.t20batsmanranking OWNER TO postgres;

--
-- Name: t20battingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20battingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsmanid integer NOT NULL,
    runsscored integer NOT NULL,
    ballsfaced integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    strikerate real,
    battingposition integer NOT NULL,
    CONSTRAINT t20battingscorecard_battingposition_check CHECK (((battingposition < 12) AND (battingposition > 0)))
);


ALTER TABLE public.t20battingscorecard OWNER TO postgres;

--
-- Name: t20bowler; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20bowler (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numballs integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    bestperformancewickets integer NOT NULL,
    bestperformanceruns integer NOT NULL,
    average real NOT NULL,
    economy real NOT NULL,
    strikerate real,
    num5w integer NOT NULL,
    CONSTRAINT t20bowler_bestperformancewickets_check CHECK ((bestperformancewickets < 11))
);


ALTER TABLE public.t20bowler OWNER TO postgres;

--
-- Name: t20bowlerranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20bowlerranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.t20bowlerranking OWNER TO postgres;

--
-- Name: t20bowlingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20bowlingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    bowlerid integer NOT NULL,
    oversbowled real NOT NULL,
    maidenovers integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    economyrate real NOT NULL,
    CONSTRAINT t20bowlingscorecard_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.t20bowlingscorecard OWNER TO postgres;

--
-- Name: t20coach; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20coach (
    countryname character varying(20),
    coachid integer NOT NULL,
    role character varying(20) NOT NULL
);


ALTER TABLE public.t20coach OWNER TO postgres;

--
-- Name: t20innings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20innings (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    score integer NOT NULL,
    wickets integer NOT NULL,
    overs integer NOT NULL,
    battingteamname character varying(20),
    CONSTRAINT t20innings_inningnum_check CHECK (((inningnum < 3) AND (inningnum > 0))),
    CONSTRAINT t20innings_overs_check CHECK ((overs <= 20)),
    CONSTRAINT t20innings_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.t20innings OWNER TO postgres;

--
-- Name: t20match; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20match (
    id integer NOT NULL,
    date date NOT NULL,
    result resulttype,
    dayversusdaynight daytype,
    umpire1 integer,
    umpire2 integer,
    umpire3 integer,
    tosswonby character varying(20),
    teama character varying(20),
    teamb character varying(20),
    venueid integer,
    teamacaptainid integer,
    teambcaptainid integer,
    teamawkid integer,
    teambwkid integer,
    CONSTRAINT t20match_check CHECK ((((teama)::text <> (teamb)::text) AND (((tosswonby)::text = (teama)::text) OR ((tosswonby)::text = (teamb)::text)))),
    CONSTRAINT t20match_check1 CHECK ((((umpire1 <> umpire2) AND (umpire2 <> umpire3)) AND (umpire3 <> umpire1)))
);


ALTER TABLE public.t20match OWNER TO postgres;

--
-- Name: t20partnershipscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20partnershipscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsman1id integer,
    batsman2id integer,
    wicketnumber integer NOT NULL,
    incomingruns integer NOT NULL,
    partnershipruns integer NOT NULL,
    CONSTRAINT t20partnershipscorecard_check CHECK ((batsman1id <> batsman2id)),
    CONSTRAINT t20partnershipscorecard_wicketnumber_check CHECK (((wicketnumber < 11) AND (wicketnumber > 0)))
);


ALTER TABLE public.t20partnershipscorecard OWNER TO postgres;

--
-- Name: t20player; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20player (
    id integer NOT NULL,
    nummatches integer NOT NULL,
    numcatches integer NOT NULL,
    CONSTRAINT t20player_check CHECK (((10 * nummatches) >= numcatches))
);


ALTER TABLE public.t20player OWNER TO postgres;

--
-- Name: t20ranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20ranking (
    countryname character varying(20) NOT NULL,
    rank integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public.t20ranking OWNER TO postgres;

--
-- Name: t20team; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20team (
    countryname character varying(20) NOT NULL,
    matchesplayed integer,
    matcheswon integer,
    matchesdrawn integer,
    CONSTRAINT t20team_check CHECK ((matchesplayed >= (matcheswon + matchesdrawn)))
);


ALTER TABLE public.t20team OWNER TO postgres;

--
-- Name: t20tournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20tournament (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    result character varying(30)
);


ALTER TABLE public.t20tournament OWNER TO postgres;

--
-- Name: t20tournamentaward; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20tournamentaward (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    playerid integer NOT NULL,
    awardname character varying(30)
);


ALTER TABLE public.t20tournamentaward OWNER TO postgres;

--
-- Name: t20tournamentwinner; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20tournamentwinner (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    countryname character varying(20) NOT NULL
);


ALTER TABLE public.t20tournamentwinner OWNER TO postgres;

--
-- Name: t20wicketkeeper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE t20wicketkeeper (
    id integer NOT NULL,
    stumpings integer NOT NULL
);


ALTER TABLE public.t20wicketkeeper OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE team (
    countryname character varying(20) NOT NULL
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: testallrounderranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testallrounderranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.testallrounderranking OWNER TO postgres;

--
-- Name: testbatsman; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbatsman (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numnotouts integer NOT NULL,
    runs integer NOT NULL,
    highscore integer NOT NULL,
    average real NOT NULL,
    strikerate real NOT NULL,
    fifties integer NOT NULL,
    hundreds integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    CONSTRAINT testbatsman_check CHECK ((runs >= ((4 * fours) + (6 * sixes)))),
    CONSTRAINT testbatsman_check1 CHECK ((numnotouts <= numinnings))
);


ALTER TABLE public.testbatsman OWNER TO postgres;

--
-- Name: testbatsmanranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbatsmanranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.testbatsmanranking OWNER TO postgres;

--
-- Name: testbattingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbattingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsmanid integer NOT NULL,
    runsscored integer NOT NULL,
    ballsfaced integer NOT NULL,
    fours integer NOT NULL,
    sixes integer NOT NULL,
    strikerate real,
    battingposition integer NOT NULL,
    CONSTRAINT testbattingscorecard_battingposition_check CHECK (((battingposition < 12) AND (battingposition > 0)))
);


ALTER TABLE public.testbattingscorecard OWNER TO postgres;

--
-- Name: testbowler; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbowler (
    id integer NOT NULL,
    numinnings integer NOT NULL,
    numballs integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    bestinningsperformancewickets integer NOT NULL,
    bestinningsperformanceruns integer NOT NULL,
    bestmatchperformancewickets integer NOT NULL,
    bestmatchperformanceruns integer NOT NULL,
    average real NOT NULL,
    economy real NOT NULL,
    strikerate real,
    num5w integer NOT NULL,
    CONSTRAINT testbowler_bestinningsperformancewickets_check CHECK ((bestinningsperformancewickets < 11)),
    CONSTRAINT testbowler_bestmatchperformancewickets_check CHECK ((bestmatchperformancewickets < 21))
);


ALTER TABLE public.testbowler OWNER TO postgres;

--
-- Name: testbowlerranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbowlerranking (
    id integer NOT NULL,
    rank integer,
    points integer
);


ALTER TABLE public.testbowlerranking OWNER TO postgres;

--
-- Name: testbowlingscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testbowlingscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    bowlerid integer NOT NULL,
    oversbowled real NOT NULL,
    maidenovers integer NOT NULL,
    runs integer NOT NULL,
    wickets integer NOT NULL,
    economyrate real NOT NULL,
    CONSTRAINT testbowlingscorecard_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.testbowlingscorecard OWNER TO postgres;

--
-- Name: testcoach; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testcoach (
    countryname character varying(20),
    coachid integer NOT NULL,
    role character varying(20) NOT NULL
);


ALTER TABLE public.testcoach OWNER TO postgres;

--
-- Name: testinnings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testinnings (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    score integer NOT NULL,
    wickets integer NOT NULL,
    overs integer NOT NULL,
    battingteamname character varying(30),
    CONSTRAINT testinnings_inningnum_check CHECK (((inningnum < 5) AND (inningnum > 0))),
    CONSTRAINT testinnings_wickets_check CHECK ((wickets < 11))
);


ALTER TABLE public.testinnings OWNER TO postgres;

--
-- Name: testmatch; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testmatch (
    id integer NOT NULL,
    date date NOT NULL,
    result resulttype,
    umpire1 integer,
    umpire2 integer,
    umpire3 integer,
    tosswonby character varying(20),
    teama character varying(20),
    teamb character varying(20),
    venueid integer,
    teamacaptainid integer,
    teambcaptainid integer,
    teamawkid integer,
    teambwkid integer,
    CONSTRAINT testmatch_check CHECK ((((teama)::text <> (teamb)::text) AND (((tosswonby)::text = (teama)::text) OR ((tosswonby)::text = (teamb)::text)))),
    CONSTRAINT testmatch_check1 CHECK ((((umpire1 <> umpire2) AND (umpire2 <> umpire3)) AND (umpire3 <> umpire1)))
);


ALTER TABLE public.testmatch OWNER TO postgres;

--
-- Name: testpartnershipscorecard; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testpartnershipscorecard (
    matchid integer NOT NULL,
    inningnum integer NOT NULL,
    batsman1id integer,
    batsman2id integer,
    wicketnumber integer NOT NULL,
    incomingruns integer NOT NULL,
    partnershipruns integer NOT NULL,
    CONSTRAINT testpartnershipscorecard_check CHECK ((batsman1id <> batsman2id)),
    CONSTRAINT testpartnershipscorecard_wicketnumber_check CHECK (((wicketnumber < 11) AND (wicketnumber > 0)))
);


ALTER TABLE public.testpartnershipscorecard OWNER TO postgres;

--
-- Name: testplayer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testplayer (
    id integer NOT NULL,
    nummatches integer NOT NULL,
    numcatches integer NOT NULL,
    CONSTRAINT testplayer_check CHECK (((20 * nummatches) >= numcatches))
);


ALTER TABLE public.testplayer OWNER TO postgres;

--
-- Name: testranking; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testranking (
    countryname character varying(20) NOT NULL,
    rank integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public.testranking OWNER TO postgres;

--
-- Name: testteam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testteam (
    countryname character varying(20) NOT NULL,
    matchesplayed integer,
    matcheswon integer,
    matchesdrawn integer,
    CONSTRAINT testteam_check CHECK ((matchesplayed >= (matcheswon + matchesdrawn)))
);


ALTER TABLE public.testteam OWNER TO postgres;

--
-- Name: testtournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testtournament (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    result character varying(30)
);


ALTER TABLE public.testtournament OWNER TO postgres;

--
-- Name: testtournamentaward; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testtournamentaward (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    playerid integer NOT NULL,
    awardname character varying(30)
);


ALTER TABLE public.testtournamentaward OWNER TO postgres;

--
-- Name: testtournamentwinner; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testtournamentwinner (
    name character varying(30) NOT NULL,
    year integer NOT NULL,
    countryname character varying(20) NOT NULL
);


ALTER TABLE public.testtournamentwinner OWNER TO postgres;

--
-- Name: testwicketkeeper; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE testwicketkeeper (
    id integer NOT NULL,
    stumpings integer NOT NULL
);


ALTER TABLE public.testwicketkeeper OWNER TO postgres;

--
-- Name: tournament; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tournament (
    name character varying(30) NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.tournament OWNER TO postgres;

--
-- Name: umpire; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE umpire (
    id integer NOT NULL,
    numodis integer NOT NULL,
    numtests integer NOT NULL,
    numt20s integer NOT NULL
);


ALTER TABLE public.umpire OWNER TO postgres;

--
-- Name: venue; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE venue (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    capacity integer NOT NULL,
    city character varying(20) NOT NULL,
    country character varying(20) NOT NULL
);


ALTER TABLE public.venue OWNER TO postgres;

--
-- Name: venue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE venue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venue_id_seq OWNER TO postgres;

--
-- Name: venue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE venue_id_seq OWNED BY venue.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cricketperson ALTER COLUMN id SET DEFAULT nextval('cricketperson_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY match ALTER COLUMN id SET DEFAULT nextval('match_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player ALTER COLUMN id SET DEFAULT nextval('player_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY venue ALTER COLUMN id SET DEFAULT nextval('venue_id_seq'::regclass);


--
-- Name: coach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coach
    ADD CONSTRAINT coach_pkey PRIMARY KEY (id);


--
-- Name: cricketperson_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cricketperson
    ADD CONSTRAINT cricketperson_pkey PRIMARY KEY (id);


--
-- Name: inoditournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inoditournament
    ADD CONSTRAINT inoditournament_pkey PRIMARY KEY (matchid, tournamentname, year);


--
-- Name: int20tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY int20tournament
    ADD CONSTRAINT int20tournament_pkey PRIMARY KEY (matchid, tournamentname, year);


--
-- Name: intesttournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intesttournament
    ADD CONSTRAINT intesttournament_pkey PRIMARY KEY (matchid, tournamentname, year);


--
-- Name: isinteam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY isinteam
    ADD CONSTRAINT isinteam_pkey PRIMARY KEY (country, id);


--
-- Name: match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY match
    ADD CONSTRAINT match_pkey PRIMARY KEY (id);


--
-- Name: matchaward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY matchaward
    ADD CONSTRAINT matchaward_pkey PRIMARY KEY (matchid, playerid);


--
-- Name: odiallrounderranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odiallrounderranking
    ADD CONSTRAINT odiallrounderranking_pkey PRIMARY KEY (id);


--
-- Name: odibatsman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibatsman
    ADD CONSTRAINT odibatsman_pkey PRIMARY KEY (id);


--
-- Name: odibatsmanranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibatsmanranking
    ADD CONSTRAINT odibatsmanranking_pkey PRIMARY KEY (id);


--
-- Name: odibattingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibattingscorecard
    ADD CONSTRAINT odibattingscorecard_pkey PRIMARY KEY (matchid, inningnum, batsmanid);


--
-- Name: odibowler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibowler
    ADD CONSTRAINT odibowler_pkey PRIMARY KEY (id);


--
-- Name: odibowlerranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibowlerranking
    ADD CONSTRAINT odibowlerranking_pkey PRIMARY KEY (id);


--
-- Name: odibowlingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odibowlingscorecard
    ADD CONSTRAINT odibowlingscorecard_pkey PRIMARY KEY (matchid, inningnum, bowlerid);


--
-- Name: odicoach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odicoach
    ADD CONSTRAINT odicoach_pkey PRIMARY KEY (coachid);


--
-- Name: odiinnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odiinnings
    ADD CONSTRAINT odiinnings_pkey PRIMARY KEY (matchid, inningnum);


--
-- Name: odimatch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_pkey PRIMARY KEY (id);


--
-- Name: odipartnershipscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odipartnershipscorecard
    ADD CONSTRAINT odipartnershipscorecard_pkey PRIMARY KEY (matchid, inningnum, wicketnumber);


--
-- Name: odiplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odiplayer
    ADD CONSTRAINT odiplayer_pkey PRIMARY KEY (id);


--
-- Name: odiranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odiranking
    ADD CONSTRAINT odiranking_pkey PRIMARY KEY (countryname);


--
-- Name: oditeam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oditeam
    ADD CONSTRAINT oditeam_pkey PRIMARY KEY (countryname);


--
-- Name: oditournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oditournament
    ADD CONSTRAINT oditournament_pkey PRIMARY KEY (name, year);


--
-- Name: oditournamentaward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oditournamentaward
    ADD CONSTRAINT oditournamentaward_pkey PRIMARY KEY (name, year, playerid);


--
-- Name: oditournamentwinner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oditournamentwinner
    ADD CONSTRAINT oditournamentwinner_pkey PRIMARY KEY (name, year, countryname);


--
-- Name: odiwicketkeeper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY odiwicketkeeper
    ADD CONSTRAINT odiwicketkeeper_pkey PRIMARY KEY (id);


--
-- Name: playedinodi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY playedinodi
    ADD CONSTRAINT playedinodi_pkey PRIMARY KEY (matchid, playerid);


--
-- Name: playedint20_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY playedint20
    ADD CONSTRAINT playedint20_pkey PRIMARY KEY (matchid, playerid);


--
-- Name: playedintest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY playedintest
    ADD CONSTRAINT playedintest_pkey PRIMARY KEY (matchid, playerid);


--
-- Name: player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- Name: t20allrounderranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20allrounderranking
    ADD CONSTRAINT t20allrounderranking_pkey PRIMARY KEY (id);


--
-- Name: t20batsman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20batsman
    ADD CONSTRAINT t20batsman_pkey PRIMARY KEY (id);


--
-- Name: t20batsmanranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20batsmanranking
    ADD CONSTRAINT t20batsmanranking_pkey PRIMARY KEY (id);


--
-- Name: t20battingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20battingscorecard
    ADD CONSTRAINT t20battingscorecard_pkey PRIMARY KEY (matchid, inningnum, batsmanid);


--
-- Name: t20bowler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20bowler
    ADD CONSTRAINT t20bowler_pkey PRIMARY KEY (id);


--
-- Name: t20bowlerranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20bowlerranking
    ADD CONSTRAINT t20bowlerranking_pkey PRIMARY KEY (id);


--
-- Name: t20bowlingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20bowlingscorecard
    ADD CONSTRAINT t20bowlingscorecard_pkey PRIMARY KEY (matchid, inningnum, bowlerid);


--
-- Name: t20coach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20coach
    ADD CONSTRAINT t20coach_pkey PRIMARY KEY (coachid);


--
-- Name: t20innings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20innings
    ADD CONSTRAINT t20innings_pkey PRIMARY KEY (matchid, inningnum);


--
-- Name: t20match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_pkey PRIMARY KEY (id);


--
-- Name: t20partnershipscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20partnershipscorecard
    ADD CONSTRAINT t20partnershipscorecard_pkey PRIMARY KEY (matchid, inningnum, wicketnumber);


--
-- Name: t20player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20player
    ADD CONSTRAINT t20player_pkey PRIMARY KEY (id);


--
-- Name: t20ranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20ranking
    ADD CONSTRAINT t20ranking_pkey PRIMARY KEY (countryname);


--
-- Name: t20team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20team
    ADD CONSTRAINT t20team_pkey PRIMARY KEY (countryname);


--
-- Name: t20tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20tournament
    ADD CONSTRAINT t20tournament_pkey PRIMARY KEY (name, year);


--
-- Name: t20tournamentaward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20tournamentaward
    ADD CONSTRAINT t20tournamentaward_pkey PRIMARY KEY (name, year, playerid);


--
-- Name: t20tournamentwinner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20tournamentwinner
    ADD CONSTRAINT t20tournamentwinner_pkey PRIMARY KEY (name, year, countryname);


--
-- Name: t20wicketkeeper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY t20wicketkeeper
    ADD CONSTRAINT t20wicketkeeper_pkey PRIMARY KEY (id);


--
-- Name: team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_pkey PRIMARY KEY (countryname);


--
-- Name: testallrounderranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testallrounderranking
    ADD CONSTRAINT testallrounderranking_pkey PRIMARY KEY (id);


--
-- Name: testbatsman_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbatsman
    ADD CONSTRAINT testbatsman_pkey PRIMARY KEY (id);


--
-- Name: testbatsmanranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbatsmanranking
    ADD CONSTRAINT testbatsmanranking_pkey PRIMARY KEY (id);


--
-- Name: testbattingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbattingscorecard
    ADD CONSTRAINT testbattingscorecard_pkey PRIMARY KEY (matchid, inningnum, batsmanid);


--
-- Name: testbowler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbowler
    ADD CONSTRAINT testbowler_pkey PRIMARY KEY (id);


--
-- Name: testbowlerranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbowlerranking
    ADD CONSTRAINT testbowlerranking_pkey PRIMARY KEY (id);


--
-- Name: testbowlingscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testbowlingscorecard
    ADD CONSTRAINT testbowlingscorecard_pkey PRIMARY KEY (matchid, inningnum, bowlerid);


--
-- Name: testcoach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testcoach
    ADD CONSTRAINT testcoach_pkey PRIMARY KEY (coachid);


--
-- Name: testinnings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testinnings
    ADD CONSTRAINT testinnings_pkey PRIMARY KEY (matchid, inningnum);


--
-- Name: testmatch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_pkey PRIMARY KEY (id);


--
-- Name: testpartnershipscorecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testpartnershipscorecard
    ADD CONSTRAINT testpartnershipscorecard_pkey PRIMARY KEY (matchid, inningnum, wicketnumber);


--
-- Name: testplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testplayer
    ADD CONSTRAINT testplayer_pkey PRIMARY KEY (id);


--
-- Name: testranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testranking
    ADD CONSTRAINT testranking_pkey PRIMARY KEY (countryname);


--
-- Name: testteam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testteam
    ADD CONSTRAINT testteam_pkey PRIMARY KEY (countryname);


--
-- Name: testtournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testtournament
    ADD CONSTRAINT testtournament_pkey PRIMARY KEY (name, year);


--
-- Name: testtournamentaward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testtournamentaward
    ADD CONSTRAINT testtournamentaward_pkey PRIMARY KEY (name, year, playerid);


--
-- Name: testtournamentwinner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testtournamentwinner
    ADD CONSTRAINT testtournamentwinner_pkey PRIMARY KEY (name, year, countryname);


--
-- Name: testwicketkeeper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY testwicketkeeper
    ADD CONSTRAINT testwicketkeeper_pkey PRIMARY KEY (id);


--
-- Name: tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (name, year);


--
-- Name: umpire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY umpire
    ADD CONSTRAINT umpire_pkey PRIMARY KEY (id);


--
-- Name: venue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY venue
    ADD CONSTRAINT venue_pkey PRIMARY KEY (id);


--
-- Name: coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coach
    ADD CONSTRAINT coach_id_fkey FOREIGN KEY (id) REFERENCES cricketperson(id);


--
-- Name: inoditournament_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inoditournament
    ADD CONSTRAINT inoditournament_matchid_fkey FOREIGN KEY (matchid) REFERENCES odimatch(id);


--
-- Name: inoditournament_tournamentname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inoditournament
    ADD CONSTRAINT inoditournament_tournamentname_fkey FOREIGN KEY (tournamentname, year) REFERENCES oditournament(name, year);


--
-- Name: int20tournament_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY int20tournament
    ADD CONSTRAINT int20tournament_matchid_fkey FOREIGN KEY (matchid) REFERENCES t20match(id);


--
-- Name: int20tournament_tournamentname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY int20tournament
    ADD CONSTRAINT int20tournament_tournamentname_fkey FOREIGN KEY (tournamentname, year) REFERENCES t20tournament(name, year);


--
-- Name: intesttournament_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intesttournament
    ADD CONSTRAINT intesttournament_matchid_fkey FOREIGN KEY (matchid) REFERENCES testmatch(id);


--
-- Name: intesttournament_tournamentname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intesttournament
    ADD CONSTRAINT intesttournament_tournamentname_fkey FOREIGN KEY (tournamentname, year) REFERENCES testtournament(name, year);


--
-- Name: isinteam_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isinteam
    ADD CONSTRAINT isinteam_country_fkey FOREIGN KEY (country) REFERENCES team(countryname);


--
-- Name: isinteam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY isinteam
    ADD CONSTRAINT isinteam_id_fkey FOREIGN KEY (id) REFERENCES player(id);


--
-- Name: matchaward_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY matchaward
    ADD CONSTRAINT matchaward_matchid_fkey FOREIGN KEY (matchid) REFERENCES match(id);


--
-- Name: matchaward_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY matchaward
    ADD CONSTRAINT matchaward_playerid_fkey FOREIGN KEY (playerid) REFERENCES player(id);


--
-- Name: odibatsman_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibatsman
    ADD CONSTRAINT odibatsman_id_fkey FOREIGN KEY (id) REFERENCES odiplayer(id);


--
-- Name: odibatsmanranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibatsmanranking
    ADD CONSTRAINT odibatsmanranking_id_fkey FOREIGN KEY (id) REFERENCES odibatsman(id);


--
-- Name: odibattingscorecard_batsmanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibattingscorecard
    ADD CONSTRAINT odibattingscorecard_batsmanid_fkey FOREIGN KEY (batsmanid) REFERENCES odibatsman(id);


--
-- Name: odibattingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibattingscorecard
    ADD CONSTRAINT odibattingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES odiinnings(matchid, inningnum);


--
-- Name: odibowler_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibowler
    ADD CONSTRAINT odibowler_id_fkey FOREIGN KEY (id) REFERENCES odiplayer(id);


--
-- Name: odibowlerranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibowlerranking
    ADD CONSTRAINT odibowlerranking_id_fkey FOREIGN KEY (id) REFERENCES odibowler(id);


--
-- Name: odibowlingscorecard_bowlerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibowlingscorecard
    ADD CONSTRAINT odibowlingscorecard_bowlerid_fkey FOREIGN KEY (bowlerid) REFERENCES odibowler(id);


--
-- Name: odibowlingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odibowlingscorecard
    ADD CONSTRAINT odibowlingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES odiinnings(matchid, inningnum);


--
-- Name: odicoach_coachid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odicoach
    ADD CONSTRAINT odicoach_coachid_fkey FOREIGN KEY (coachid) REFERENCES coach(id);


--
-- Name: odicoach_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odicoach
    ADD CONSTRAINT odicoach_countryname_fkey FOREIGN KEY (countryname) REFERENCES oditeam(countryname);


--
-- Name: odiinnings_battingteamname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odiinnings
    ADD CONSTRAINT odiinnings_battingteamname_fkey FOREIGN KEY (battingteamname) REFERENCES oditeam(countryname);


--
-- Name: odiinnings_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odiinnings
    ADD CONSTRAINT odiinnings_matchid_fkey FOREIGN KEY (matchid) REFERENCES odimatch(id);


--
-- Name: odimatch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_id_fkey FOREIGN KEY (id) REFERENCES match(id);


--
-- Name: odimatch_teama_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teama_fkey FOREIGN KEY (teama) REFERENCES oditeam(countryname);


--
-- Name: odimatch_teamacaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teamacaptainid_fkey FOREIGN KEY (teamacaptainid) REFERENCES odiplayer(id);


--
-- Name: odimatch_teamawkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teamawkid_fkey FOREIGN KEY (teamawkid) REFERENCES odiplayer(id);


--
-- Name: odimatch_teamb_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teamb_fkey FOREIGN KEY (teamb) REFERENCES oditeam(countryname);


--
-- Name: odimatch_teambcaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teambcaptainid_fkey FOREIGN KEY (teambcaptainid) REFERENCES odiplayer(id);


--
-- Name: odimatch_teambwkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_teambwkid_fkey FOREIGN KEY (teambwkid) REFERENCES odiplayer(id);


--
-- Name: odimatch_tosswonby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_tosswonby_fkey FOREIGN KEY (tosswonby) REFERENCES oditeam(countryname);


--
-- Name: odimatch_umpire1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_umpire1_fkey FOREIGN KEY (umpire1) REFERENCES umpire(id);


--
-- Name: odimatch_umpire2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_umpire2_fkey FOREIGN KEY (umpire2) REFERENCES umpire(id);


--
-- Name: odimatch_umpire3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_umpire3_fkey FOREIGN KEY (umpire3) REFERENCES umpire(id);


--
-- Name: odimatch_venueid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odimatch
    ADD CONSTRAINT odimatch_venueid_fkey FOREIGN KEY (venueid) REFERENCES venue(id);


--
-- Name: odipartnershipscorecard_batsman1id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odipartnershipscorecard
    ADD CONSTRAINT odipartnershipscorecard_batsman1id_fkey FOREIGN KEY (batsman1id) REFERENCES odibatsman(id);


--
-- Name: odipartnershipscorecard_batsman2id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odipartnershipscorecard
    ADD CONSTRAINT odipartnershipscorecard_batsman2id_fkey FOREIGN KEY (batsman2id) REFERENCES odibatsman(id);


--
-- Name: odipartnershipscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odipartnershipscorecard
    ADD CONSTRAINT odipartnershipscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES odiinnings(matchid, inningnum);


--
-- Name: odiplayer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odiplayer
    ADD CONSTRAINT odiplayer_id_fkey FOREIGN KEY (id) REFERENCES player(id);


--
-- Name: odiranking_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odiranking
    ADD CONSTRAINT odiranking_countryname_fkey FOREIGN KEY (countryname) REFERENCES oditeam(countryname);


--
-- Name: oditeam_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditeam
    ADD CONSTRAINT oditeam_countryname_fkey FOREIGN KEY (countryname) REFERENCES team(countryname);


--
-- Name: oditournament_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditournament
    ADD CONSTRAINT oditournament_name_fkey FOREIGN KEY (name, year) REFERENCES tournament(name, year);


--
-- Name: oditournamentaward_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditournamentaward
    ADD CONSTRAINT oditournamentaward_name_fkey FOREIGN KEY (name, year) REFERENCES oditournament(name, year);


--
-- Name: oditournamentaward_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditournamentaward
    ADD CONSTRAINT oditournamentaward_playerid_fkey FOREIGN KEY (playerid) REFERENCES odiplayer(id);


--
-- Name: oditournamentwinner_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditournamentwinner
    ADD CONSTRAINT oditournamentwinner_countryname_fkey FOREIGN KEY (countryname) REFERENCES oditeam(countryname);


--
-- Name: oditournamentwinner_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oditournamentwinner
    ADD CONSTRAINT oditournamentwinner_name_fkey FOREIGN KEY (name, year) REFERENCES oditournament(name, year);


--
-- Name: odiwicketkeeper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY odiwicketkeeper
    ADD CONSTRAINT odiwicketkeeper_id_fkey FOREIGN KEY (id) REFERENCES odiplayer(id);


--
-- Name: playedinodi_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedinodi
    ADD CONSTRAINT playedinodi_matchid_fkey FOREIGN KEY (matchid) REFERENCES odimatch(id);


--
-- Name: playedinodi_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedinodi
    ADD CONSTRAINT playedinodi_playerid_fkey FOREIGN KEY (playerid) REFERENCES odiplayer(id);


--
-- Name: playedint20_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedint20
    ADD CONSTRAINT playedint20_matchid_fkey FOREIGN KEY (matchid) REFERENCES t20match(id);


--
-- Name: playedint20_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedint20
    ADD CONSTRAINT playedint20_playerid_fkey FOREIGN KEY (playerid) REFERENCES t20player(id);


--
-- Name: playedintest_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedintest
    ADD CONSTRAINT playedintest_matchid_fkey FOREIGN KEY (matchid) REFERENCES testmatch(id);


--
-- Name: playedintest_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY playedintest
    ADD CONSTRAINT playedintest_playerid_fkey FOREIGN KEY (playerid) REFERENCES testplayer(id);


--
-- Name: player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY player
    ADD CONSTRAINT player_id_fkey FOREIGN KEY (id) REFERENCES cricketperson(id);


--
-- Name: t20batsman_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20batsman
    ADD CONSTRAINT t20batsman_id_fkey FOREIGN KEY (id) REFERENCES t20player(id);


--
-- Name: t20batsmanranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20batsmanranking
    ADD CONSTRAINT t20batsmanranking_id_fkey FOREIGN KEY (id) REFERENCES t20batsman(id);


--
-- Name: t20battingscorecard_batsmanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20battingscorecard
    ADD CONSTRAINT t20battingscorecard_batsmanid_fkey FOREIGN KEY (batsmanid) REFERENCES t20batsman(id);


--
-- Name: t20battingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20battingscorecard
    ADD CONSTRAINT t20battingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES t20innings(matchid, inningnum);


--
-- Name: t20bowler_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20bowler
    ADD CONSTRAINT t20bowler_id_fkey FOREIGN KEY (id) REFERENCES t20player(id);


--
-- Name: t20bowlerranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20bowlerranking
    ADD CONSTRAINT t20bowlerranking_id_fkey FOREIGN KEY (id) REFERENCES t20bowler(id);


--
-- Name: t20bowlingscorecard_bowlerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20bowlingscorecard
    ADD CONSTRAINT t20bowlingscorecard_bowlerid_fkey FOREIGN KEY (bowlerid) REFERENCES t20bowler(id);


--
-- Name: t20bowlingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20bowlingscorecard
    ADD CONSTRAINT t20bowlingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES t20innings(matchid, inningnum);


--
-- Name: t20coach_coachid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20coach
    ADD CONSTRAINT t20coach_coachid_fkey FOREIGN KEY (coachid) REFERENCES coach(id);


--
-- Name: t20coach_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20coach
    ADD CONSTRAINT t20coach_countryname_fkey FOREIGN KEY (countryname) REFERENCES t20team(countryname);


--
-- Name: t20innings_battingteamname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20innings
    ADD CONSTRAINT t20innings_battingteamname_fkey FOREIGN KEY (battingteamname) REFERENCES t20team(countryname);


--
-- Name: t20innings_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20innings
    ADD CONSTRAINT t20innings_matchid_fkey FOREIGN KEY (matchid) REFERENCES t20match(id);


--
-- Name: t20match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_id_fkey FOREIGN KEY (id) REFERENCES match(id);


--
-- Name: t20match_teama_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teama_fkey FOREIGN KEY (teama) REFERENCES t20team(countryname);


--
-- Name: t20match_teamacaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teamacaptainid_fkey FOREIGN KEY (teamacaptainid) REFERENCES t20player(id);


--
-- Name: t20match_teamawkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teamawkid_fkey FOREIGN KEY (teamawkid) REFERENCES t20player(id);


--
-- Name: t20match_teamb_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teamb_fkey FOREIGN KEY (teamb) REFERENCES t20team(countryname);


--
-- Name: t20match_teambcaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teambcaptainid_fkey FOREIGN KEY (teambcaptainid) REFERENCES t20player(id);


--
-- Name: t20match_teambwkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_teambwkid_fkey FOREIGN KEY (teambwkid) REFERENCES t20player(id);


--
-- Name: t20match_tosswonby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_tosswonby_fkey FOREIGN KEY (tosswonby) REFERENCES t20team(countryname);


--
-- Name: t20match_umpire1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_umpire1_fkey FOREIGN KEY (umpire1) REFERENCES umpire(id);


--
-- Name: t20match_umpire2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_umpire2_fkey FOREIGN KEY (umpire2) REFERENCES umpire(id);


--
-- Name: t20match_umpire3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_umpire3_fkey FOREIGN KEY (umpire3) REFERENCES umpire(id);


--
-- Name: t20match_venueid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20match
    ADD CONSTRAINT t20match_venueid_fkey FOREIGN KEY (venueid) REFERENCES venue(id);


--
-- Name: t20partnershipscorecard_batsman1id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20partnershipscorecard
    ADD CONSTRAINT t20partnershipscorecard_batsman1id_fkey FOREIGN KEY (batsman1id) REFERENCES t20batsman(id);


--
-- Name: t20partnershipscorecard_batsman2id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20partnershipscorecard
    ADD CONSTRAINT t20partnershipscorecard_batsman2id_fkey FOREIGN KEY (batsman2id) REFERENCES t20batsman(id);


--
-- Name: t20partnershipscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20partnershipscorecard
    ADD CONSTRAINT t20partnershipscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES t20innings(matchid, inningnum);


--
-- Name: t20player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20player
    ADD CONSTRAINT t20player_id_fkey FOREIGN KEY (id) REFERENCES player(id);


--
-- Name: t20ranking_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20ranking
    ADD CONSTRAINT t20ranking_countryname_fkey FOREIGN KEY (countryname) REFERENCES t20team(countryname);


--
-- Name: t20team_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20team
    ADD CONSTRAINT t20team_countryname_fkey FOREIGN KEY (countryname) REFERENCES team(countryname);


--
-- Name: t20tournament_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20tournament
    ADD CONSTRAINT t20tournament_name_fkey FOREIGN KEY (name, year) REFERENCES tournament(name, year);


--
-- Name: t20tournamentaward_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20tournamentaward
    ADD CONSTRAINT t20tournamentaward_name_fkey FOREIGN KEY (name, year) REFERENCES t20tournament(name, year);


--
-- Name: t20tournamentaward_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20tournamentaward
    ADD CONSTRAINT t20tournamentaward_playerid_fkey FOREIGN KEY (playerid) REFERENCES t20player(id);


--
-- Name: t20tournamentwinner_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20tournamentwinner
    ADD CONSTRAINT t20tournamentwinner_countryname_fkey FOREIGN KEY (countryname) REFERENCES t20team(countryname);


--
-- Name: t20tournamentwinner_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20tournamentwinner
    ADD CONSTRAINT t20tournamentwinner_name_fkey FOREIGN KEY (name, year) REFERENCES t20tournament(name, year);


--
-- Name: t20wicketkeeper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY t20wicketkeeper
    ADD CONSTRAINT t20wicketkeeper_id_fkey FOREIGN KEY (id) REFERENCES t20player(id);


--
-- Name: testbatsman_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbatsman
    ADD CONSTRAINT testbatsman_id_fkey FOREIGN KEY (id) REFERENCES testplayer(id);


--
-- Name: testbatsmanranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbatsmanranking
    ADD CONSTRAINT testbatsmanranking_id_fkey FOREIGN KEY (id) REFERENCES testbatsman(id);


--
-- Name: testbattingscorecard_batsmanid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbattingscorecard
    ADD CONSTRAINT testbattingscorecard_batsmanid_fkey FOREIGN KEY (batsmanid) REFERENCES testbatsman(id);


--
-- Name: testbattingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbattingscorecard
    ADD CONSTRAINT testbattingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES testinnings(matchid, inningnum);


--
-- Name: testbowler_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbowler
    ADD CONSTRAINT testbowler_id_fkey FOREIGN KEY (id) REFERENCES testplayer(id);


--
-- Name: testbowlerranking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbowlerranking
    ADD CONSTRAINT testbowlerranking_id_fkey FOREIGN KEY (id) REFERENCES testbowler(id);


--
-- Name: testbowlingscorecard_bowlerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbowlingscorecard
    ADD CONSTRAINT testbowlingscorecard_bowlerid_fkey FOREIGN KEY (bowlerid) REFERENCES testbowler(id);


--
-- Name: testbowlingscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testbowlingscorecard
    ADD CONSTRAINT testbowlingscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES testinnings(matchid, inningnum);


--
-- Name: testcoach_coachid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testcoach
    ADD CONSTRAINT testcoach_coachid_fkey FOREIGN KEY (coachid) REFERENCES coach(id);


--
-- Name: testcoach_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testcoach
    ADD CONSTRAINT testcoach_countryname_fkey FOREIGN KEY (countryname) REFERENCES testteam(countryname);


--
-- Name: testinnings_battingteamname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testinnings
    ADD CONSTRAINT testinnings_battingteamname_fkey FOREIGN KEY (battingteamname) REFERENCES testteam(countryname);


--
-- Name: testinnings_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testinnings
    ADD CONSTRAINT testinnings_matchid_fkey FOREIGN KEY (matchid) REFERENCES testmatch(id);


--
-- Name: testmatch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_id_fkey FOREIGN KEY (id) REFERENCES match(id);


--
-- Name: testmatch_teama_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teama_fkey FOREIGN KEY (teama) REFERENCES testteam(countryname);


--
-- Name: testmatch_teamacaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teamacaptainid_fkey FOREIGN KEY (teamacaptainid) REFERENCES testplayer(id);


--
-- Name: testmatch_teamawkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teamawkid_fkey FOREIGN KEY (teamawkid) REFERENCES testplayer(id);


--
-- Name: testmatch_teamb_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teamb_fkey FOREIGN KEY (teamb) REFERENCES testteam(countryname);


--
-- Name: testmatch_teambcaptainid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teambcaptainid_fkey FOREIGN KEY (teambcaptainid) REFERENCES testplayer(id);


--
-- Name: testmatch_teambwkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_teambwkid_fkey FOREIGN KEY (teambwkid) REFERENCES testplayer(id);


--
-- Name: testmatch_tosswonby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_tosswonby_fkey FOREIGN KEY (tosswonby) REFERENCES testteam(countryname);


--
-- Name: testmatch_umpire1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_umpire1_fkey FOREIGN KEY (umpire1) REFERENCES umpire(id);


--
-- Name: testmatch_umpire2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_umpire2_fkey FOREIGN KEY (umpire2) REFERENCES umpire(id);


--
-- Name: testmatch_umpire3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_umpire3_fkey FOREIGN KEY (umpire3) REFERENCES umpire(id);


--
-- Name: testmatch_venueid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testmatch
    ADD CONSTRAINT testmatch_venueid_fkey FOREIGN KEY (venueid) REFERENCES venue(id);


--
-- Name: testpartnershipscorecard_batsman1id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testpartnershipscorecard
    ADD CONSTRAINT testpartnershipscorecard_batsman1id_fkey FOREIGN KEY (batsman1id) REFERENCES testbatsman(id);


--
-- Name: testpartnershipscorecard_batsman2id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testpartnershipscorecard
    ADD CONSTRAINT testpartnershipscorecard_batsman2id_fkey FOREIGN KEY (batsman2id) REFERENCES testbatsman(id);


--
-- Name: testpartnershipscorecard_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testpartnershipscorecard
    ADD CONSTRAINT testpartnershipscorecard_matchid_fkey FOREIGN KEY (matchid, inningnum) REFERENCES testinnings(matchid, inningnum);


--
-- Name: testplayer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testplayer
    ADD CONSTRAINT testplayer_id_fkey FOREIGN KEY (id) REFERENCES player(id);


--
-- Name: testranking_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testranking
    ADD CONSTRAINT testranking_countryname_fkey FOREIGN KEY (countryname) REFERENCES testteam(countryname);


--
-- Name: testteam_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testteam
    ADD CONSTRAINT testteam_countryname_fkey FOREIGN KEY (countryname) REFERENCES team(countryname);


--
-- Name: testtournament_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testtournament
    ADD CONSTRAINT testtournament_name_fkey FOREIGN KEY (name, year) REFERENCES tournament(name, year);


--
-- Name: testtournamentaward_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testtournamentaward
    ADD CONSTRAINT testtournamentaward_name_fkey FOREIGN KEY (name, year) REFERENCES testtournament(name, year);


--
-- Name: testtournamentaward_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testtournamentaward
    ADD CONSTRAINT testtournamentaward_playerid_fkey FOREIGN KEY (playerid) REFERENCES testplayer(id);


--
-- Name: testtournamentwinner_countryname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testtournamentwinner
    ADD CONSTRAINT testtournamentwinner_countryname_fkey FOREIGN KEY (countryname) REFERENCES testteam(countryname);


--
-- Name: testtournamentwinner_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testtournamentwinner
    ADD CONSTRAINT testtournamentwinner_name_fkey FOREIGN KEY (name, year) REFERENCES testtournament(name, year);


--
-- Name: testwicketkeeper_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testwicketkeeper
    ADD CONSTRAINT testwicketkeeper_id_fkey FOREIGN KEY (id) REFERENCES testplayer(id);


--
-- Name: umpire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY umpire
    ADD CONSTRAINT umpire_id_fkey FOREIGN KEY (id) REFERENCES cricketperson(id);


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

