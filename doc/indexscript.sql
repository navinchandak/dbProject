DROP INDEX IF EXISTS ODIMatch_TeamA_Hash_Index;
CREATE INDEX ODIMatch_TeamA_Hash_Index ON ODIMatch USING hash (TeamA);
DROP INDEX IF EXISTS ODIMatch_TeamB_Hash_Index;
CREATE INDEX ODIMatch_TeamB_Hash_Index ON ODIMatch USING hash (TeamB);
DROP INDEX IF EXISTS T20Match_TeamA_Hash_Index;
CREATE INDEX T20Match_TeamA_Hash_Index ON T20Match USING hash (TeamA);
DROP INDEX IF EXISTS T20Match_TeamB_Hash_Index;
CREATE INDEX T20Match_TeamB_Hash_Index ON T20Match USING hash (TeamB);
DROP INDEX IF EXISTS TestMatch_TeamA_Hash_Index;
CREATE INDEX TestMatch_TeamA_Hash_Index ON TestMatch USING hash (TeamA);
DROP INDEX IF EXISTS TestMatch_TeamB_Hash_Index;
CREATE INDEX TestMatch_TeamB_Hash_Index ON TestMatch USING hash (TeamB);

DROP INDEX IF EXISTS Venue_Country_Hash_Index;
CREATE INDEX Venue_Country_Hash_Index ON Venue USING hash (Country);
DROP INDEX IF EXISTS Venue_Name_Hash_Index;
CREATE INDEX Venue_Name_Hash_Index ON Venue USING hash (Name);

DROP INDEX IF EXISTS ODIMatch_Date_BTree_Index;
CREATE INDEX ODIMatch_Date_BTree_Index ON ODIMatch USING btree (Date);
DROP INDEX IF EXISTS T20Match_Date_BTree_Index;
CREATE INDEX T20Match_Date_BTree_Index ON T20Match USING btree (Date);
DROP INDEX IF EXISTS TestMatch_Date_BTree_Index;
CREATE INDEX TestMatch_Date_BTree_Index ON TestMatch USING btree (Date);

DROP INDEX IF EXISTS ODIMatch_TeamAWKID_Hash_Index;
CREATE INDEX ODIMatch_TeamAWKID_Hash_Index ON ODIMatch USING hash (TeamAWKID);
DROP INDEX IF EXISTS ODIMatch_TeamBWKID_Hash_Index;
CREATE INDEX ODIMatch_TeamBWKID_Hash_Index ON ODIMatch USING hash (TeamBWKID);
DROP INDEX IF EXISTS ODIMatch_TeamACaptainID_Hash_Index;
CREATE INDEX ODIMatch_TeamACaptainID_Hash_Index ON ODIMatch USING hash (TeamACaptainID);
DROP INDEX IF EXISTS ODIMatch_TeamBCaptainID_Hash_Index;
CREATE INDEX ODIMatch_TeamBCaptainID_Hash_Index ON ODIMatch USING hash (TeamBCaptainID);
DROP INDEX IF EXISTS T20Match_TeamAWKID_Hash_Index;
CREATE INDEX T20Match_TeamAWKID_Hash_Index ON T20Match USING hash (TeamAWKID);
DROP INDEX IF EXISTS T20Match_TeamBWKID_Hash_Index;
CREATE INDEX T20Match_TeamBWKID_Hash_Index ON T20Match USING hash (TeamBWKID);
DROP INDEX IF EXISTS T20Match_TeamACaptainID_Hash_Index;
CREATE INDEX T20Match_TeamACaptainID_Hash_Index ON T20Match USING hash (TeamACaptainID);
DROP INDEX IF EXISTS T20Match_TeamBCaptainID_Hash_Index;
CREATE INDEX T20Match_TeamBCaptainID_Hash_Index ON T20Match USING hash (TeamBCaptainID);
DROP INDEX IF EXISTS TestMatch_TeamAWKID_Hash_Index;
CREATE INDEX TestMatch_TeamAWKID_Hash_Index ON TestMatch USING hash (TeamAWKID);
DROP INDEX IF EXISTS TestMatch_TeamBWKID_Hash_Index;
CREATE INDEX TestMatch_TeamBWKID_Hash_Index ON TestMatch USING hash (TeamBWKID);
DROP INDEX IF EXISTS TestMatch_TeamACaptainID_Hash_Index;
CREATE INDEX TestMatch_TeamACaptainID_Hash_Index ON TestMatch USING hash (TeamACaptainID);
DROP INDEX IF EXISTS TestMatch_TeamBCaptainID_Hash_Index;
CREATE INDEX TestMatch_TeamBCaptainID_Hash_Index ON TestMatch USING hash (TeamBCaptainID);

DROP INDEX IF EXISTS ODIInnings_Score_BTree_Index;
CREATE INDEX ODIInnings_Score_BTree_Index ON ODIInnings USING btree (Score);
DROP INDEX IF EXISTS ODIInnings_BattingTeamName_Hash_Index;
CREATE INDEX ODIInnings_BattingTeamName_Hash_Index ON ODIInnings USING hash (BattingTeamName);
DROP INDEX IF EXISTS TestInnings_Score_BTree_Index;
CREATE INDEX TestInnings_Score_BTree_Index ON TestInnings USING btree (Score);
DROP INDEX IF EXISTS TestInnings_BattingTeamName_Hash_Index;
CREATE INDEX TestInnings_BattingTeamName_Hash_Index ON TestInnings USING hash (BattingTeamName);
DROP INDEX IF EXISTS T20Innings_Score_BTree_Index;
CREATE INDEX T20Innings_Score_BTree_Index ON T20Innings USING btree (Score);
DROP INDEX IF EXISTS T20Innings_BattingTeamName_Hash_Index;
CREATE INDEX T20Innings_BattingTeamName_Hash_Index ON T20Innings USING hash (BattingTeamName);

DROP INDEX IF EXISTS CricketPerson_Name_Hash_Index;
CREATE INDEX CricketPerson_Name_Hash_Index ON CricketPerson USING hash (Name);
DROP INDEX IF EXISTS CricketPerson_ID_Hash_Index;
CREATE INDEX CricketPerson_ID_Hash_Index ON CricketPerson USING hash (ID);

DROP INDEX IF EXISTS PlayedInODI_MatchID_Hash_Index;
CREATE INDEX PlayedInODI_MatchID_Hash_Index ON PlayedInODI USING hash (MatchID);
DROP INDEX IF EXISTS PlayedInT20_MatchID_Hash_Index;
CREATE INDEX PlayedInT20_MatchID_Hash_Index ON PlayedInT20 USING hash (MatchID);
DROP INDEX IF EXISTS PlayedInTest_MatchID_Hash_Index;
CREATE INDEX PlayedInTest_MatchID_Hash_Index ON PlayedInTest USING hash (MatchID);

DROP INDEX IF EXISTS PlayedInODI_PlayerID_Hash_Index;
CREATE INDEX PlayedInODI_PlayerID_Hash_Index ON PlayedInODI USING hash (PlayerID);
DROP INDEX IF EXISTS PlayedInT20_PlayerID_Hash_Index;
CREATE INDEX PlayedInT20_PlayerID_Hash_Index ON PlayedInT20 USING hash (PlayerID);
DROP INDEX IF EXISTS PlayedInTest_PlayerID_Hash_Index;
CREATE INDEX PlayedInTest_PlayerID_Hash_Index ON PlayedInTest USING hash (PlayerID);

DROP INDEX IF EXISTS ODIInnings_MatchID_Hash_Index;
CREATE INDEX ODIInnings_MatchID_Hash_Index ON ODIInnings USING hash (MatchID);
DROP INDEX IF EXISTS T20Innings_MatchID_Hash_Index;
CREATE INDEX T20Innings_MatchID_Hash_Index ON T20Innings USING hash (MatchID);
DROP INDEX IF EXISTS TestInnings_MatchID_Hash_Index;
CREATE INDEX TestInnings_MatchID_Hash_Index ON TestInnings USING hash (MatchID);

DROP INDEX IF EXISTS PlayedInODI_MatchID_Hash_Index;
CREATE INDEX PlayedInODI_MatchID_Hash_Index ON PlayedInODI USING hash (MatchID);
DROP INDEX IF EXISTS PlayedInT20_MatchID_Hash_Index;
CREATE INDEX PlayedInT20_MatchID_Hash_Index ON PlayedInT20 USING hash (MatchID);
DROP INDEX IF EXISTS PlayedInTest_MatchID_Hash_Index;
CREATE INDEX PlayedInTest_MatchID_Hash_Index ON PlayedInTest USING hash (MatchID);

DROP INDEX IF EXISTS PlayedInODI_PlayerID_Hash_Index;
CREATE INDEX PlayedInODI_PlayerID_Hash_Index ON PlayedInODI USING hash (PlayerID);
DROP INDEX IF EXISTS PlayedInT20_PlayerID_Hash_Index;
CREATE INDEX PlayedInT20_PlayerID_Hash_Index ON PlayedInT20 USING hash (PlayerID);
DROP INDEX IF EXISTS PlayedInTest_PlayerID_Hash_Index;
CREATE INDEX PlayedInTest_PlayerID_Hash_Index ON PlayedInTest USING hash (PlayerID);

DROP INDEX IF EXISTS ODIMatch_ID_Hash_Index;
CREATE INDEX ODIMatch_ID_Hash_Index ON ODIMatch USING hash (ID);
DROP INDEX IF EXISTS TestMatch_ID_Hash_Index;
CREATE INDEX TestMatch_ID_Hash_Index ON TestMatch USING hash (ID);
DROP INDEX IF EXISTS T20Match_ID_Hash_Index;
CREATE INDEX T20Match_ID_Hash_Index ON T20Match USING hash (ID);

DROP INDEX IF EXISTS ODIBattingScoreCard_RunsScored_BTree_Index;
CREATE INDEX ODIBattingScoreCard_RunsScored_BTree_Index ON ODIBattingScoreCard USING btree (RunsScored);
DROP INDEX IF EXISTS T20BattingScoreCard_RunsScored_BTree_Index;
CREATE INDEX T20BattingScoreCard_RunsScored_BTree_Index ON T20BattingScoreCard USING btree (RunsScored);
DROP INDEX IF EXISTS TestBattingScoreCard_RunsScored_BTree_Index;
CREATE INDEX TestBattingScoreCard_RunsScored_BTree_Index ON TestBattingScoreCard USING btree (RunsScored);

DROP INDEX IF EXISTS ODIBowlingScoreCard_Wickets_BTree_Index;
CREATE INDEX ODIBowlingScoreCard_Wickets_BTree_Index ON ODIBowlingScoreCard USING btree (Wickets);
DROP INDEX IF EXISTS T20BowlingScoreCard_Wickets_BTree_Index;
CREATE INDEX T20BowlingScoreCard_Wickets_BTree_Index ON T20BowlingScoreCard USING btree (Wickets);
DROP INDEX IF EXISTS TestBowlingScoreCard_Wickets_BTree_Index;
CREATE INDEX TestBowlingScoreCard_Wickets_BTree_Index ON TestBowlingScoreCard USING btree (Wickets);

DROP INDEX IF EXISTS ODIBowlingScoreCard_EconomyRate_BTree_Index;
CREATE INDEX ODIBowlingScoreCard_EconomyRate_BTree_Index ON ODIBowlingScoreCard USING btree (EconomyRate);
DROP INDEX IF EXISTS T20BowlingScoreCard_EconomyRate_BTree_Index;
CREATE INDEX T20BowlingScoreCard_EconomyRate_BTree_Index ON T20BowlingScoreCard USING btree (EconomyRate);
DROP INDEX IF EXISTS TestBowlingScoreCard_EconomyRate_BTree_Index;
CREATE INDEX TestBowlingScoreCard_EconomyRate_BTree_Index ON TestBowlingScoreCard USING btree (EconomyRate);

DROP INDEX IF EXISTS ODIBastman_Runs_BTree_Index;
CREATE INDEX ODIBastman_Runs_BTree_Index ON ODIBatsman USING btree (Runs);
DROP INDEX IF EXISTS ODIBastman_Average_BTree_Index;
CREATE INDEX ODIBastman_Average_BTree_Index ON ODIBatsman USING btree (Average);
DROP INDEX IF EXISTS ODIBastman_StrikeRate_BTree_Index;
CREATE INDEX ODIBastman_StrikeRate_BTree_Index ON ODIBatsman USING btree (StrikeRate);
DROP INDEX IF EXISTS TestBastman_Runs_BTree_Index;
CREATE INDEX TestBastman_Runs_BTree_Index ON TestBatsman USING btree (Runs);
DROP INDEX IF EXISTS TestBastman_Average_BTree_Index;
CREATE INDEX TestBastman_Average_BTree_Index ON TestBatsman USING btree (Average);
DROP INDEX IF EXISTS TestBastman_StrikeRate_BTree_Index;
CREATE INDEX TestBastman_StrikeRate_BTree_Index ON TestBatsman USING btree (StrikeRate);
DROP INDEX IF EXISTS T20Bastman_Runs_BTree_Index;
CREATE INDEX T20Bastman_Runs_BTree_Index ON T20Batsman USING btree (Runs);
DROP INDEX IF EXISTS T20Bastman_Average_BTree_Index;
CREATE INDEX T20Bastman_Average_BTree_Index ON T20Batsman USING btree (Average);
DROP INDEX IF EXISTS T20Bastman_StrikeRate_BTree_Index;
CREATE INDEX T20Bastman_StrikeRate_BTree_Index ON T20Batsman USING btree (StrikeRate);

DROP INDEX IF EXISTS ODIBastman_Wickets_BTree_Index;
CREATE INDEX ODIBastman_Wickets_BTree_Index ON ODIBowler USING btree (Wickets);
DROP INDEX IF EXISTS ODIBastman_Average_BTree_Index;
CREATE INDEX ODIBastman_Average_BTree_Index ON ODIBowler USING btree (Average);
DROP INDEX IF EXISTS ODIBastman_Economy_BTree_Index;
CREATE INDEX ODIBastman_Economy_BTree_Index ON ODIBowler USING btree (Economy);
DROP INDEX IF EXISTS TestBastman_Wickets_BTree_Index;
CREATE INDEX TestBastman_Wickets_BTree_Index ON TestBowler USING btree (Wickets);
DROP INDEX IF EXISTS TestBastman_Average_BTree_Index;
CREATE INDEX TestBastman_Average_BTree_Index ON TestBowler USING btree (Average);
DROP INDEX IF EXISTS TestBastman_Economy_BTree_Index;
CREATE INDEX TestBastman_Economy_BTree_Index ON TestBowler USING btree (Economy);
DROP INDEX IF EXISTS T20Bastman_Wickets_BTree_Index;
CREATE INDEX T20Bastman_Wickets_BTree_Index ON T20Bowler USING btree (Wickets);
DROP INDEX IF EXISTS T20Bastman_Average_BTree_Index;
CREATE INDEX T20Bastman_Average_BTree_Index ON T20Bowler USING btree (Average);
DROP INDEX IF EXISTS T20Bastman_Economy_BTree_Index;
CREATE INDEX T20Bastman_Economy_BTree_Index ON T20Bowler USING btree (Economy);
