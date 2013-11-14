ALTER TABLE TestBowler ADD CHECK (BestMatchPerformanceWickets >= BestInningsPerformanceWickets);

ALTER TABLE ODIBattingScoreCard ADD FOREIGN KEY (MatchID, BatsmanID) REFERENCES PlayedInODI(MatchID, PlayerID);
ALTER TABLE TestBattingScoreCard ADD FOREIGN KEY (MatchID, BatsmanID) REFERENCES PlayedInTest(MatchID, PlayerID);
ALTER TABLE T20BattingScoreCard ADD FOREIGN KEY (MatchID, BatsmanID) REFERENCES PlayedInT20(MatchID, PlayerID);

ALTER TABLE T20BowlingScoreCard ADD FOREIGN KEY (MatchID, BowlerID) REFERENCES PlayedInT20(MatchID, PlayerID);
ALTER TABLE ODIBowlingScoreCard ADD FOREIGN KEY (MatchID, BowlerID) REFERENCES PlayedInODI(MatchID, PlayerID);
ALTER TABLE TestBowlingScoreCard ADD FOREIGN KEY (MatchID, BowlerID) REFERENCES PlayedInTest(MatchID, PlayerID);

ALTER TABLE ODIPartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman1ID) REFERENCES PlayedInODI(MatchID, PlayerID);
ALTER TABLE ODIPartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman2ID) REFERENCES PlayedInODI(MatchID, PlayerID);
ALTER TABLE T20PartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman1ID) REFERENCES PlayedInT20(MatchID, PlayerID);
ALTER TABLE T20PartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman2ID) REFERENCES PlayedInT20(MatchID, PlayerID);
ALTER TABLE TestPartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman1ID) REFERENCES PlayedInTest(MatchID, PlayerID);
ALTER TABLE TestPartnershipScoreCard ADD FOREIGN KEY (MatchID, Batsman2ID) REFERENCES PlayedInTest(MatchID, PlayerID);


DROP TRIGGER IF EXISTS validmatchaward ON MatchAward;
CREATE OR REPLACE FUNCTION validmatchawardfunction() RETURNS TRIGGER AS $validmatchaward$
BEGIN
IF NOT EXISTS (SELECT * FROM PlayedInODI M1 WHERE M1.MatchID = NEW.MatchID AND M1.PlayerID = NEW.PlayerID) 
AND NOT EXISTS (SELECT * FROM PlayedInT20 M2 WHERE M2.MatchID = NEW.MatchID AND M2.PlayerID = NEW.PlayerID)  
AND NOT EXISTS (SELECT * FROM PlayedInTest M3 WHERE M3.MatchID = NEW.MatchID AND M3.PlayerID = NEW.PlayerID) THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'Invalid match award- player seems to have not played the game in question';
END IF;
RETURN NEW;
END;
$validmatchaward$ LANGUAGE plpgsql;
CREATE TRIGGER validmatchaward BEFORE INSERT ON MatchAward FOR EACH ROW EXECUTE PROCEDURE validmatchawardfunction();


DROP TRIGGER IF EXISTS validoditournamentaward ON ODITournamentAward;
CREATE OR REPLACE FUNCTION validoditournamentawardfunction() RETURNS TRIGGER AS $validoditournamentaward$
BEGIN
IF  
NOT EXISTS (SELECT * FROM InODITournament E1 
WHERE E1.TournamentName = NEW.Name AND E1.Year = NEW.Year AND 
EXISTS (SELECT * FROM PlayedInODI AS E2 WHERE
NEW.PlayerID = E2.PlayerID AND 
E1.MatchID = E2.MatchID))
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'Invalid tournament award- player seems to have not played any game in the tournament in question';
END IF;
RETURN NEW;
END;
$validoditournamentaward$ LANGUAGE plpgsql;
CREATE TRIGGER validoditournamentaward BEFORE INSERT ON ODITournamentAward FOR EACH ROW EXECUTE PROCEDURE validoditournamentawardfunction();


DROP TRIGGER IF EXISTS validtesttournamentaward ON testTournamentAward;
CREATE OR REPLACE FUNCTION validtesttournamentawardfunction() RETURNS TRIGGER AS $validtesttournamentaward$
BEGIN
IF  
NOT EXISTS (SELECT * FROM IntestTournament E1 
WHERE E1.TournamentName = NEW.Name AND E1.Year = NEW.Year AND 
EXISTS (SELECT * FROM PlayedIntest AS E2 WHERE
NEW.PlayerID = E2.PlayerID AND 
E1.MatchID = E2.MatchID))
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'Invalid tournament award- player seems to have not played any game in the tournament in question';
END IF;
RETURN NEW;
END;
$validtesttournamentaward$ LANGUAGE plpgsql;
CREATE TRIGGER validtesttournamentaward BEFORE INSERT ON testTournamentAward FOR EACH ROW EXECUTE PROCEDURE validtesttournamentawardfunction();


DROP TRIGGER IF EXISTS validt20tournamentaward ON t20TournamentAward;
CREATE OR REPLACE FUNCTION validt20tournamentawardfunction() RETURNS TRIGGER AS $validt20tournamentaward$
BEGIN
IF  
NOT EXISTS (SELECT * FROM Int20Tournament E1 
WHERE E1.TournamentName = NEW.Name AND E1.Year = NEW.Year AND 
EXISTS (SELECT * FROM PlayedInt20 AS E2 WHERE
NEW.PlayerID = E2.PlayerID AND 
E1.MatchID = E2.MatchID))
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'Invalid tournament award- player seems to have not played any game in the tournament in question';
END IF;
RETURN NEW;
END;
$validt20tournamentaward$ LANGUAGE plpgsql;
CREATE TRIGGER validt20tournamentaward BEFORE INSERT ON t20TournamentAward FOR EACH ROW EXECUTE PROCEDURE validt20tournamentawardfunction();


DROP TRIGGER IF EXISTS correctteamforodimatchplayers ON PlayedInODI;
CREATE OR REPLACE FUNCTION correctteamforodimatchplayersfunction() RETURNS TRIGGER AS $correctteamforodimatchplayers$
BEGIN
IF  
EXISTS (SELECT * FROM ODIMatch E1 WHERE E1.ID = NEW.MatchID AND 
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamA AND
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamB)
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'The player doesn''t belong to either team playing the match';
END IF;
RETURN NEW;
END;
$correctteamforodimatchplayers$ LANGUAGE plpgsql;
CREATE TRIGGER correctteamforodimatchplayers BEFORE INSERT ON PlayedInODI 
FOR EACH ROW EXECUTE PROCEDURE correctteamforodimatchplayersfunction();


DROP TRIGGER IF EXISTS correctteamfort20matchplayers ON PlayedInt20;
CREATE OR REPLACE FUNCTION correctteamfort20matchplayersfunction() RETURNS TRIGGER AS $correctteamfort20matchplayers$
BEGIN
IF  
EXISTS (SELECT * FROM t20Match E1 WHERE E1.ID = NEW.MatchID AND 
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamA AND
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamB)
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'The player doesn''t belong to either team playing the match';
END IF;
RETURN NEW;
END;
$correctteamfort20matchplayers$ LANGUAGE plpgsql;
CREATE TRIGGER correctteamfort20matchplayers BEFORE INSERT ON PlayedInt20 
FOR EACH ROW EXECUTE PROCEDURE correctteamfort20matchplayersfunction();


DROP TRIGGER IF EXISTS correctteamfortestmatchplayers ON PlayedIntest;
CREATE OR REPLACE FUNCTION correctteamfortestmatchplayersfunction() RETURNS TRIGGER AS $correctteamfortestmatchplayers$
BEGIN
IF  
EXISTS (SELECT * FROM testMatch E1 WHERE E1.ID = NEW.MatchID AND 
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamA AND
       (SELECT Country FROM IsInTeam E2 WHERE NEW.PlayerID = E2.ID) <> E1.TeamB)
THEN
--DELETE FROM MatchAward MA WHERE MA.MatchID = NEW.MatchID AND MA.PlayerID = NEW.PlayerID;
raise exception 'The player doesn''t belong to either team playing the match';
END IF;
RETURN NEW;
END;
$correctteamfortestmatchplayers$ LANGUAGE plpgsql;
CREATE TRIGGER correctteamfortestmatchplayers BEFORE INSERT ON PlayedIntest 
FOR EACH ROW EXECUTE PROCEDURE correctteamfortestmatchplayersfunction();
