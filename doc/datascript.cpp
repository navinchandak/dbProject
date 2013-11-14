#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>
#include <string>
#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
using namespace std;

string BattingStyles[]= {"Left-handed", "Right-handed"};
string BowlingStyles[]= {"Right-arm fast", "Right-arm medium", "Left-arm fast", "Left-arm medium", "Slow left arm", "Off spin", "Leg spin"};

//VECTORS TO STORE CRICKET PERSON DATA
vector<string> cricketPersonName;
vector<bool> batsman;
vector<bool> bowler;
vector<bool> wicketKeeper;
vector<bool> coach;
vector<bool> umpire;
vector<string> teamNames;
vector<bool> testTeam;
ofstream writer;
vector<string> countryNames;

vector< vector<int> > teamWicketKeepers(10, vector<int> (0,0));
vector< vector<int> > teamBatsmen(10, vector<int> (0,0));
vector< vector<int> > teamBowlers(10, vector<int> (0,0));
vector< vector<int> > teamAllRounders(10, vector<int> (0,0));
vector<int> umpires;

//VECTORS TO STORE MATCH DATA

//kuch to daalna hai yahan :P
vector<string> matchTeamAList, matchTeamBList, matchResultList;


pair<int, int> matchGenerator(int teamID1, int teamID2, string matchType, int year, int venueIndex)
{
    vector<int> teamAPlayers, teamBPlayers, matchUmpires;
    
    while (teamAPlayers.size() < 4) // SELECT 4 BATSMEN from team A TO PLAY GAME
    {
        int batsmanToSelect= teamBatsmen[teamID1][rand()%(teamBatsmen[teamID1].size())];
        if (find(teamAPlayers.begin(), teamAPlayers.end(), batsmanToSelect) == teamAPlayers.end())
        {teamAPlayers.push_back(batsmanToSelect);}
    }
    
    while (teamBPlayers.size() < 4) // SELECT 4 BATSMEN from team B TO PLAY GAME
    {
        int batsmanToSelect= teamBatsmen[teamID2][rand()%(teamBatsmen[teamID2].size())];
        if (find(teamBPlayers.begin(), teamBPlayers.end(), batsmanToSelect) == teamBPlayers.end())
        {teamBPlayers.push_back(batsmanToSelect);}
    }
    
    while (teamAPlayers.size() < 5) // SELECT a wicketkeeper TO PLAY GAME
    {
        int wicketKeeperToSelect= teamWicketKeepers[teamID1][rand()%(teamWicketKeepers[teamID1].size())];
        if (find(teamAPlayers.begin(), teamAPlayers.end(), wicketKeeperToSelect) == teamAPlayers.end())
        {teamAPlayers.push_back(wicketKeeperToSelect);}
    }
    
    while (teamBPlayers.size() < 5) // SELECT a wicketkeeper TO PLAY GAME
    {
        int wicketKeeperToSelect= teamWicketKeepers[teamID2][rand()%(teamWicketKeepers[teamID2].size())];
        if (find(teamBPlayers.begin(), teamBPlayers.end(), wicketKeeperToSelect) == teamBPlayers.end())
        {teamBPlayers.push_back(wicketKeeperToSelect);}
    }
    
    while (teamAPlayers.size() < 7) // SELECT 2 Allrounders TO PLAY GAME
    {
        int allRounderToSelect= teamAllRounders[teamID1][rand()%(teamAllRounders[teamID1].size())];
        if (find(teamAPlayers.begin(), teamAPlayers.end(), allRounderToSelect) == teamAPlayers.end())
        {teamAPlayers.push_back(allRounderToSelect);}
    }
    
    while (teamBPlayers.size() < 7) // SELECT 2 Allrounders TO PLAY GAME
    {
        int allRounderToSelect= teamAllRounders[teamID2][rand()%(teamAllRounders[teamID2].size())];
        if (find(teamBPlayers.begin(), teamBPlayers.end(), allRounderToSelect) == teamBPlayers.end())
        {teamBPlayers.push_back(allRounderToSelect);}
    }
    
    while (teamAPlayers.size() < 11) // SELECT 4 Bowlers TO PLAY GAME
    {
        int bowlerToSelect= teamBowlers[teamID1][rand()%(teamBowlers[teamID1].size())];
        if (find(teamAPlayers.begin(), teamAPlayers.end(), bowlerToSelect) == teamAPlayers.end())
        {teamAPlayers.push_back(bowlerToSelect);}
    }
    
    while (teamBPlayers.size() < 11) // SELECT 4 Bowlers TO PLAY GAME
    {
        int bowlerToSelect= teamBowlers[teamID2][rand()%(teamBowlers[teamID2].size())];
        if (find(teamBPlayers.begin(), teamBPlayers.end(), bowlerToSelect) == teamBPlayers.end())
        {teamBPlayers.push_back(bowlerToSelect);}
    }
    
    while (matchUmpires.size() < 3) // SELECT 3 umpires for the GAME
    {
        int umpireToSelect= umpires[rand()%(umpires.size())];
        if (find(matchUmpires.begin(), matchUmpires.end(), umpireToSelect) == matchUmpires.end())
        {matchUmpires.push_back(umpireToSelect);}
    }

    //AT THIS POINT, TEAM AND UMPIRES SELECTED TO PLAY THE GAME
    
    matchTeamAList.push_back(countryNames[teamID1]);
    matchTeamBList.push_back(countryNames[teamID2]);
    string matchResult;
    int resultSelect= rand()%30; if (resultSelect < 12) {matchResult="TEAMA";} else if (resultSelect < 24) {matchResult="TEAMB";} else if (resultSelect < 26) {matchResult="DRAW";} else if (resultSelect < 28) {matchResult="NORESULT";} else {matchResult="TIE";};
    
    writer << "INSERT INTO Match (Date) VALUES ('12-mar-" << year << "');" << endl;
    
    int matchID= matchTeamAList.size();
    
    //SUNO NA JUNTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
    
    int venueID= venueIndex+1; // VENUE ID DAALNA HAI JUNTAAAAAAAAAA!
    
    //SUNO NA JUNTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
    
    if (matchType=="ODI")
    {
        writer << "INSERT INTO ODIMatch (ID, Date, Result, DayVersusDayNight, Umpire1, Umpire2, Umpire3, TossWonBy, TeamA, TeamB, VenueID, TeamACaptainID, TeamBCaptainID, TeamAWKID, TeamBWKID) VALUES (";
        writer << matchID << ",'12-mar-" << year << "','" << matchResult << "'," << ((rand()%2==0) ? "'DAY',":"'DAYNIGHT',");
        writer << matchUmpires[0] << "," << matchUmpires[1] << "," << matchUmpires[2] << ",'" << ((rand()%2==0) ? countryNames[teamID1] : countryNames[teamID2]) << "',";
        writer << "'" << countryNames[teamID1] << "','" << countryNames[teamID2] << "'," << venueID << ",";
        writer << teamAPlayers[rand()%11] << "," << teamBPlayers[rand()%11] << "," << teamAPlayers[10] << "," << teamBPlayers[10] << ");" << endl;
        //ye pura was to insert into ODIMatch
        
        for (int i=0; i<11; i++)//to insert match playing squads
        {
            writer << "INSERT INTO PlayedInODI (MatchID, PlayerID) VALUES (" << matchID << "," << teamAPlayers[i] << ");" << endl;
            writer << "INSERT INTO PlayedInODI (MatchID, PlayerID) VALUES (" << matchID << "," << teamBPlayers[i] << ");" << endl;
        }
        
        for (int i=0; i<2; i++) //two innings per ODI
        {
            int numWickets= rand()%6;
            int numOvers= 30 + rand()%20;
            int inningsRuns= 100 + rand()%338;
            vector<int> *squad;
            vector<int> *bowlingSquad;
            squad = (i==0) ? &teamAPlayers : &teamBPlayers;
            bowlingSquad = (i==0) ? &teamBPlayers : &teamAPlayers;
            writer << "INSERT INTO ODIInnings (MatchID, InningNum, Score, Wickets, Overs, BattingTeamName) VALUES (";
            writer << matchID << "," << (i+1) << "," << inningsRuns << "," << numWickets << "," << numOvers << ",'" << countryNames[((i==0)?teamID1:teamID2)] << "');" << endl;
    
            for (int j=0; j<numWickets + 2 && j < 11; j++) // Batting ScoreCard entry
            {
                int runsBatsman= 20 + rand()%50;
                int ballsBatsman= 20 + rand()%40;
                
                writer << "INSERT INTO ODIBattingScoreCard (MatchID, InningNum, BatsmanID, RunsScored, BallsFaced, Fours, Sixes, StrikeRate, BattingPosition) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j] << "," << runsBatsman << "," << ballsBatsman << "," << runsBatsman/30 << "," << runsBatsman/40 << "," << 100*runsBatsman/(ballsBatsman + 0.000001) << "," << j+1 << ");" << endl;
            }
            
            int runCounter= 0;
            
            for (int j=1; j <= numWickets + 1 && j <= 10; j++) // Partnership ScoreCard entry
            {
                int partnershipRuns= rand()%40;
                writer << "INSERT INTO ODIPartnershipScoreCard (MatchID, InningNum, Batsman1ID, Batsman2ID, WicketNumber, IncomingRuns, PartnershipRuns) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j-1] << "," << (*squad)[j] << "," << j << "," << runCounter << "," << partnershipRuns << ");" << endl;
                runCounter+= partnershipRuns;
            }
            
            //cout << "Step 1 ";
            
            int bowlerIndex= 10;
            while (numOvers > 10)
            {
                int oversBowled= 10, temp= inningsRuns/5;
                int runsBowler= rand()%temp;
                int numW= numWickets;
                writer << "INSERT INTO ODIBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << runsBowler << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-=10;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO ODIBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
            }
        }
    }
    
    else if (matchType=="T20")
    {
        writer << "INSERT INTO T20Match (ID, Date, Result, DayVersusDayNight, Umpire1, Umpire2, Umpire3, TossWonBy, TeamA, TeamB, VenueID, TeamACaptainID, TeamBCaptainID, TeamAWKID, TeamBWKID) VALUES (";
        writer << matchID << ",'12-mar-" << year << "','" << matchResult << "'," << ((rand()%2==0) ? "'DAY',":"'DAYNIGHT',");
        writer << matchUmpires[0] << "," << matchUmpires[1] << "," << matchUmpires[2] << ",'" << ((rand()%2==0) ? countryNames[teamID1] : countryNames[teamID2]) << "',";
        writer << "'" << countryNames[teamID1] << "','" << countryNames[teamID2] << "'," << venueID << ",";
        writer << teamAPlayers[rand()%11] << "," << teamBPlayers[rand()%11] << "," << teamAPlayers[10] << "," << teamBPlayers[10] << ");" << endl;
        //ye pura was to insert into T20Match
        
        for (int i=0; i<11; i++)//to insert match playing squads
        {
            writer << "INSERT INTO PlayedInT20 (MatchID, PlayerID) VALUES (" << matchID << "," << teamAPlayers[i] << ");" << endl;
            writer << "INSERT INTO PlayedInT20 (MatchID, PlayerID) VALUES (" << matchID << "," << teamBPlayers[i] << ");" << endl;
        }
        
        for (int i=0; i<2; i++) //two innings per T20
        {
            int numWickets= rand()%6;
            int numOvers= 12 + rand()%8;
            int inningsRuns= 100 + rand()%80;
            vector<int> *squad;
            vector<int> *bowlingSquad;
            squad = (i==0) ? &teamAPlayers : &teamBPlayers;
            bowlingSquad = (i==0) ? &teamBPlayers : &teamAPlayers;
            writer << "INSERT INTO T20Innings (MatchID, InningNum, Score, Wickets, Overs, BattingTeamName) VALUES (";
            writer << matchID << "," << (i+1) << "," << inningsRuns << "," << numWickets << "," << numOvers << ",'" << countryNames[((i==0)?teamID1:teamID2)] << "');" << endl;
    
            for (int j=0; j<numWickets + 2 && j < 11; j++) // Batting ScoreCard entry
            {
                int runsBatsman= 10 + rand()%50;
                int ballsBatsman= 20 + rand()%40;
                
                writer << "INSERT INTO T20BattingScoreCard (MatchID, InningNum, BatsmanID, RunsScored, BallsFaced, Fours, Sixes, StrikeRate, BattingPosition) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j] << "," << runsBatsman << "," << ballsBatsman << "," << runsBatsman/30 << "," << runsBatsman/40 << "," << 100*runsBatsman/(ballsBatsman + 0.000001) << "," << j+1 << ");" << endl;
            }
            
            int runCounter= 0;
            
            for (int j=1; j <= numWickets + 1 && j <= 10; j++) // Partnership ScoreCard entry
            {
                int partnershipRuns= rand()%20;
                writer << "INSERT INTO T20PartnershipScoreCard (MatchID, InningNum, Batsman1ID, Batsman2ID, WicketNumber, IncomingRuns, PartnershipRuns) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j-1] << "," << (*squad)[j] << "," << j << "," << runCounter << "," << partnershipRuns << ");" << endl;
                runCounter+= partnershipRuns;
            }
            
            //cout << "Step 1 ";
            
            int bowlerIndex= 10;
            while (numOvers > 10)
            {
                int oversBowled= 4, temp= inningsRuns/5;
                int runsBowler= rand()%temp;
                int numW= numWickets;
                writer << "INSERT INTO T20BowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << runsBowler << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-=4;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO T20BowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
            }
        }
    }
    
    else if (matchType=="Test")
    {
        writer << "INSERT INTO TestMatch (ID, Date, Result, Umpire1, Umpire2, Umpire3, TossWonBy, TeamA, TeamB, VenueID, TeamACaptainID, TeamBCaptainID, TeamAWKID, TeamBWKID) VALUES (";
        writer << matchID << ",'12-mar-" << year << "','" << matchResult << "',";
        writer << matchUmpires[0] << "," << matchUmpires[1] << "," << matchUmpires[2] << ",'" << ((rand()%2==0) ? countryNames[teamID1] : countryNames[teamID2]) << "',";
        writer << "'" << countryNames[teamID1] << "','" << countryNames[teamID2] << "'," << venueID << ",";
        writer << teamAPlayers[rand()%11] << "," << teamBPlayers[rand()%11] << "," << teamAPlayers[10] << "," << teamBPlayers[10] << ");" << endl;
        //ye pura was to insert into TestMatch
        
        for (int i=0; i<11; i++)//to insert match playing squads
        {
            writer << "INSERT INTO PlayedInTest (MatchID, PlayerID) VALUES (" << matchID << "," << teamAPlayers[i] << ");" << endl;
            writer << "INSERT INTO PlayedInTest (MatchID, PlayerID) VALUES (" << matchID << "," << teamBPlayers[i] << ");" << endl;
        }
        
        for (int i=0; i<4; i++) //4 innings per Test
        {
            int numWickets= rand()%6;
            int numOvers= 100 + rand()%80;
            int inningsRuns= 100 + rand()%400;
            vector<int> *squad;
            vector<int> *bowlingSquad;
            squad = (i%2==0) ? &teamAPlayers : &teamBPlayers;
            bowlingSquad = (i%2==0) ? &teamBPlayers : &teamAPlayers;
            writer << "INSERT INTO TestInnings (MatchID, InningNum, Score, Wickets, Overs, BattingTeamName) VALUES (";
            writer << matchID << "," << (i+1) << "," << inningsRuns << "," << numWickets << "," << numOvers << ",'" << countryNames[((i==0)?teamID1:teamID2)] << "');" << endl;
    
            for (int j=0; j<numWickets + 2 && j < 11; j++) // Batting ScoreCard entry
            {
                int runsBatsman= 40 + rand()%90;
                int ballsBatsman= 80 + rand()%90;
                
                writer << "INSERT INTO TestBattingScoreCard (MatchID, InningNum, BatsmanID, RunsScored, BallsFaced, Fours, Sixes, StrikeRate, BattingPosition) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j] << "," << runsBatsman << "," << ballsBatsman << "," << runsBatsman/30 << "," << runsBatsman/40 << "," << 100*runsBatsman/(ballsBatsman + 0.000001) << "," << j+1 << ");" << endl;
            }
            
            int runCounter= 0;
            
            for (int j=1; j <= numWickets + 1 && j <= 10; j++) // Partnership ScoreCard entry
            {
                int partnershipRuns= rand()%50;
                writer << "INSERT INTO TestPartnershipScoreCard (MatchID, InningNum, Batsman1ID, Batsman2ID, WicketNumber, IncomingRuns, PartnershipRuns) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[j-1] << "," << (*squad)[j] << "," << j << "," << runCounter << "," << partnershipRuns << ");" << endl;
                runCounter+= partnershipRuns;
            }
            
            int bowlerIndex= 10;
            while (numOvers > 10) // Bowling ScoreCard entry
            {
                int oversBowled= 30, temp= inningsRuns/4;
                int runsBowler= rand()%temp;
                int numW= numWickets;
                writer << "INSERT INTO TestBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << runsBowler << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-= 30;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO TestBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*bowlingSquad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
            }
        }
    }
    
    writer << "INSERT INTO MatchAward (MatchID, PlayerID, AwardName) VALUES (" << matchID << "," << teamAPlayers[5] << ",'Man of the Match');" << endl;
    
    return make_pair(matchID,teamAPlayers[5]);
}


void bilateralSeriesGenerator(int homeTeamIndex, int awayTeamIndex, string seriesType, int year)
{
    int numberOfMatches = 3 + (rand()%3)*2;
    vector<int> manOfMatches;
    string tournamentName= countryNames[awayTeamIndex] + " " + seriesType + " tour of " + countryNames[homeTeamIndex];
    writer << "INSERT INTO Tournament (Name, Year) VALUES ('"<< tournamentName << "'," << year << ");" << endl;
    
    string tournamentWinner= (rand()%14 > 7) ? countryNames[awayTeamIndex] : countryNames[homeTeamIndex];
    
    writer << "INSERT INTO " << ((seriesType=="ODI")?"ODITournament":((seriesType=="T20")?"T20Tournament":"TestTournament")) << " (Name, Year, Result) VALUES ('" << tournamentName << "'," << year << ",'" << tournamentWinner << "');" << endl;
    
    for (int i=0; i< numberOfMatches; i++) 
    {
        pair<int,int> matchData= matchGenerator(homeTeamIndex, awayTeamIndex, seriesType, year, homeTeamIndex);
        int matchID= matchData.first;
        int MoM= matchData.second;
        manOfMatches.push_back(MoM);
        writer << "INSERT INTO " << ((seriesType=="ODI")?"InODITournament":((seriesType=="T20")?"InT20Tournament":"InTestTournament")) << " (MatchID, TournamentName, Year, Stage) VALUES (";
        writer << matchID << ",'" << tournamentName << "'," << year << ",'Group');" << endl;
    }
    
    writer << "INSERT INTO " << ((seriesType=="ODI")?"ODITournamentAward":((seriesType=="T20")?"T20TournamentAward":"TestTournamentAward")) << " (Name, Year, PlayerID, AwardName) VALUES (";
    writer << "'" << tournamentName << "'," << year << "," << manOfMatches[(rand()%manOfMatches.size())] << ",'Man of the Series');" << endl;
    
}


int teamVectorFiller (int teamNum, string teamName, vector<string>& firstNames, vector<string>& lastNames)
{    
    for (int i=0; i<firstNames.size(); i++)
    {
        for (int j=0; j<lastNames.size(); j++)
        {
            string playerName= firstNames[i]+" "+lastNames[j];
            int wkBool = (rand()%8 > 6) ? 1 : 0;
            int bowlerBool = (rand()%5 > 2) ? 1 : 0;
            int batsmanBool = (rand()%6 > 2) ? 1 : 0;
            
            if (bowlerBool+batsmanBool < 1) batsmanBool = 1;
            
            if (wkBool == 1) {bowlerBool=0; batsmanBool= 1;}
            
            cricketPersonName.push_back(playerName);
            
            if (bowlerBool == 1) {bowler.push_back(true);} else {bowler.push_back(false);}
            
            if (batsmanBool == 1) {batsman.push_back(true);} else {batsman.push_back(false);}
            
            if (wkBool == 1) 
            {wicketKeeper.push_back(true);} 
            else {wicketKeeper.push_back(false);}
            
            if (wkBool==1) {teamWicketKeepers[teamNum].push_back(cricketPersonName.size());}
            
            else if (batsmanBool==1 && bowlerBool==1) 
            {
                teamAllRounders[teamNum].push_back(cricketPersonName.size());
            }
            
            else if (batsmanBool==1)
            {
                teamBatsmen[teamNum].push_back(cricketPersonName.size());
            }
            
            else if (bowlerBool==1)
            {
                teamBowlers[teamNum].push_back(cricketPersonName.size());
            }
            
            coach.push_back(false);
            umpire.push_back(false);
            teamNames.push_back(teamName);
            if (teamName=="Ire") {testTeam.push_back(false);} else {testTeam.push_back(true);}
        }
    }
    
    string coachName= teamName + " Coach";
    wicketKeeper.push_back(false); bowler.push_back(false); batsman.push_back(false); teamNames.push_back(teamName); umpire.push_back(false);
    coach.push_back(true); cricketPersonName.push_back(coachName);
    if (teamName!= "Ire") {testTeam.push_back(true);} else {testTeam.push_back(false);}
    
    return (firstNames.size()*lastNames.size() + 1);
}

void teamFiller()
{
    for (int i=0; i<cricketPersonName.size(); i++)
    {
        int ID= i+1;
        writer << endl <<  "INSERT INTO CricketPerson(Name, DoB) VALUES ('" << cricketPersonName[i] << "','12-mar-2013');"<< endl;
        if (coach[i])
        {
            writer << "INSERT INTO Coach VALUES (" << ID << ");" << endl;
            writer << "INSERT INTO ODICoach (CountryName, CoachID, Role) VALUES ('" << teamNames[i] << "'," << ID << ",'Overall');" << endl;
            writer << "INSERT INTO T20Coach (CountryName, CoachID, Role) VALUES ('" << teamNames[i] << "'," << ID << ",'Overall');" << endl;
            if (testTeam[i]) 
            {
                writer << "INSERT INTO TestCoach (CountryName, CoachID, Role) VALUES ('" << teamNames[i] << "'," << ID << ",'Overall');" << endl;
            }
        }
        
        
        else if (batsman[i] or bowler[i] or wicketKeeper[i])
        {
            int numODIs = 25 + rand()%80;
            int numTests = 20 + rand()%50;
            int numT20s = 15 + rand()%32;
            

            writer << "INSERT INTO Player(ID, BattingStyle, BowlingStyle) VALUES (" << ID << ",'" << BattingStyles[rand()%2] << "','" << BowlingStyles[rand()%7] << "');" << endl;
            writer << "INSERT INTO IsInTeam (Country, ID) VALUES ('" << teamNames[i] << "'," << ID << ");" << endl;
            writer << "INSERT INTO ODIPlayer (ID, NumMatches, NumCatches) VALUES (" << ID << "," << numODIs << "," << 2*(rand()%numODIs) << ");" << endl;
            writer << "INSERT INTO T20Player (ID, NumMatches, NumCatches) VALUES (" << ID << "," << numT20s << "," << 2*(rand()%numT20s) << ");" << endl;
            if (testTeam[i])
            {
                writer << "INSERT INTO TestPlayer (ID, NumMatches, NumCatches) VALUES (" << ID << "," << numTests << "," << 4*(rand()%numTests) << ");" << endl;
            }
            
            if (batsman[i])
            {
                int ODIInnings= 4*numODIs/7, ODINotOuts= numODIs/7, runs= 1000 + rand()%6000, highScore= 20 + rand()%180;
                float average= runs/(ODIInnings - ODINotOuts + 0.000001), strikeRate= 60 + rand()%50;
                int fifties= runs/400, hundreds= runs/2000, fours= runs/700, sixes = runs/800;
                writer << "INSERT INTO ODIBatsman(ID, NumInnings, NumNotOuts, Runs, HighScore, Average, StrikeRate, Fifties, Hundreds, Fours, Sixes) VALUES (";
                writer << ID << "," << ODIInnings << "," << ODINotOuts << "," << runs << "," << highScore << "," << average << "," << strikeRate << "," << fifties << "," << hundreds << "," << fours << "," << sixes << ");"<<endl;
                
                int T20Innings= 4*numT20s/7, T20NotOuts= numT20s/7;
                runs= 700 + rand()%3000; highScore= 40 + rand()%90;
                average= runs/(T20Innings - T20NotOuts + 0.000001); strikeRate= 80 + rand()%60;
                fifties= runs/400; hundreds= runs/2000; fours= runs/700; sixes = runs/800;
                writer << "INSERT INTO T20Batsman(ID, NumInnings, NumNotOuts, Runs, HighScore, Average, StrikeRate, Fifties, Hundreds, Fours, Sixes) VALUES (";
                writer << ID << "," << T20Innings << "," << T20NotOuts << "," << runs << "," << highScore << "," << average << "," << strikeRate << "," << fifties << "," << hundreds << "," << fours << "," << sixes << ");"<<endl;
                
                if (testTeam[i])
                {
                    int TestInnings= 8*numTests/7, TestNotOuts= 2*numTests/7;
                    runs= 2000 + rand()%7000; highScore= 60 + rand()%120;
                    average= runs/(TestInnings - TestNotOuts + 0.000001); strikeRate= 40 + rand()%20;
                    fifties= runs/400; hundreds= runs/2000; fours= runs/700; sixes = runs/800;
                    writer << "INSERT INTO TestBatsman(ID, NumInnings, NumNotOuts, Runs, HighScore, Average, StrikeRate, Fifties, Hundreds, Fours, Sixes) VALUES (";
                    writer << ID << "," << TestInnings << "," << TestNotOuts << "," << runs << "," << highScore << "," << average << "," << strikeRate << "," << fifties << "," << hundreds << "," << fours << "," << sixes << ");"<<endl;
                }
            }
            
            if (bowler[i])
            {
                int ODIInnings= 5*numODIs/7, ODIBalls= 48*ODIInnings, ODIRuns= 2000 + rand()%2000, ODIWickets= 80 + rand()%120;
                int BestODIPerformanceWickets= 2 + rand()%3, BestODIPerformanceRuns= 10 + rand()%20, ODI5WHauls= ODIWickets/100;
                float ODIAverage= ODIRuns/(ODIWickets+0.00001), ODIEconomy= ODIRuns/(ODIBalls/6 + 0.00001), ODIStrikeRate= ODIBalls/(ODIWickets+0.00001);
                
                writer << "INSERT INTO ODIBowler(ID, NumInnings, NumBalls, Runs, Wickets, BestPerformanceWickets, BestPerformanceRuns, Average, Economy, StrikeRate, Num5W) VALUES (";
                writer << ID << "," << ODIInnings << "," << ODIBalls << "," << ODIRuns << "," << ODIWickets << "," << BestODIPerformanceWickets << "," << BestODIPerformanceRuns << "," << ODIAverage << "," << ODIEconomy << "," << ODIStrikeRate << "," << ODI5WHauls << ");" << endl;

                int T20Innings= 5*numT20s/7, T20Balls= 24*T20Innings, T20Runs= 1000 + rand()%1000, T20Wickets= 40 + rand()%30;
                int BestT20PerformanceWickets= 2 + rand()%3, BestT20PerformanceRuns= 10 + rand()%20, T205WHauls= T20Wickets/60;
                float T20Average= T20Runs/(T20Wickets+0.00001), T20Economy= T20Runs/(T20Balls/6 + 0.00001), T20StrikeRate= T20Balls/(T20Wickets+0.00001);
                
                writer << "INSERT INTO T20Bowler(ID, NumInnings, NumBalls, Runs, Wickets, BestPerformanceWickets, BestPerformanceRuns, Average, Economy, StrikeRate, Num5W) VALUES (";
                writer << ID << "," << T20Innings << "," << T20Balls << "," << T20Runs << "," << T20Wickets << "," << BestT20PerformanceWickets << "," << BestT20PerformanceRuns << "," << T20Average << "," << T20Economy << "," << T20StrikeRate << "," << T205WHauls << ");" << endl;

                if (testTeam[i])
                {
                    int TestInnings= 5*numTests/7, TestBalls= 120*TestInnings, TestRuns= 3000 + rand()%2000, TestWickets= 140 + rand()%120;
                    int BestInningsTestPerformanceWickets= 2 + rand()%8, BestInningsTestPerformanceRuns= 50 + rand()%30, BestMatchTestPerformanceWickets= 1.5 * BestInningsTestPerformanceWickets, BestMatchTestPerformanceRuns= 140 + rand()%80, Test5WHauls= TestWickets/100;
                    float TestAverage= TestRuns/(TestWickets+0.00001), TestEconomy= TestRuns/(TestBalls/6 + 0.00001), TestStrikeRate= TestBalls/(TestWickets+0.00001);
                    
                    writer << "INSERT INTO TestBowler(ID, NumInnings, NumBalls, Runs, Wickets, BestInningsPerformanceWickets, BestInningsPerformanceRuns, BestMatchPerformanceWickets, BestMatchPerformanceRuns, Average, Economy, StrikeRate, Num5W) VALUES (";
                    writer << ID << "," << TestInnings << "," << TestBalls << "," << TestRuns << "," << TestWickets << "," << BestInningsTestPerformanceWickets << "," << BestInningsTestPerformanceRuns << "," << BestMatchTestPerformanceWickets << "," << BestMatchTestPerformanceRuns << "," << TestAverage << "," << TestEconomy << "," << TestStrikeRate << "," << Test5WHauls << ");" << endl;
                }
            }
            
            if (wicketKeeper[i])
            {
                int ODIStumpings= rand()%(2*numODIs);
                int T20Stumpings= rand()%(2*numT20s);
                int TestStumpings= rand()%(3*numTests);
                writer << "INSERT INTO ODIWicketKeeper (ID, Stumpings) VALUES (" << ID << "," << ODIStumpings << ");" << endl;
                writer << "INSERT INTO T20WicketKeeper (ID, Stumpings) VALUES (" << ID << "," << T20Stumpings << ");" << endl;
                if (testTeam[i]) {writer << "INSERT INTO TestWicketKeeper (ID, Stumpings) VALUES (" << ID << "," << TestStumpings << ");" << endl;}
            }
        }
    }
}

int umpireFiller(int numUmpires)
{
    writer << endl << endl << "--Now filling in umpires//" << endl << endl;
    for (int i=0; i<numUmpires; i++)
    {
        string umpireName= "Umpire "+i;
        writer << "INSERT INTO CricketPerson(Name, DoB) VALUES ('Umpire " << i << "','12-mar-2013');" << endl;
        wicketKeeper.push_back(false); bowler.push_back(false); batsman.push_back(false); wicketKeeper.push_back(false); umpire.push_back(true);
        coach.push_back(false); cricketPersonName.push_back(umpireName); testTeam.push_back(false);
        int umpireID= cricketPersonName.size(); // index starts at 1
        writer << "INSERT INTO Umpire (ID, NumODIs, NumTests, NumT20s) VALUES (" << umpireID << "," << rand()%50 + 100 << "," << rand()%40 + 70 << "," << rand()%20 + 50 << ");" << endl; 
        umpires.push_back(umpireID);
    }
    return numUmpires;
}

int venueFiller()
{
    writer << endl << "--Creating random venues " << endl << endl;
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO VENUE (Name, Capacity, City, Country) VALUES ('" << countryNames[i] << " Stadium'," << 10000+(rand()%3)*5000 << ",'Nowhere','" << countryNames[i] << "');" << endl;
    }
    writer << endl;
}

int main(int argc, char* argv[])
{
    if(argc != 2)
    {
        cout << "Usage <executable> <sqrt of number of series to generate>" << endl;
        return 0;
    }

    int numSeries = atoi(argv[1]);
    writer.open("insertscript.sql");

    countryNames.push_back("Ind"); 
    countryNames.push_back("Aus"); 
    countryNames.push_back("RSA"); 
    countryNames.push_back("Eng"); 
    countryNames.push_back("NZ"); 
    countryNames.push_back("Pak"); 
    countryNames.push_back("SL"); 
    countryNames.push_back("WI"); 
    countryNames.push_back("Ban"); 
    countryNames.push_back("Ire"); 
    
    writer << "--Inserting teams with random number of matches played  " << endl << endl;
    
    
    //INSERTING TEAM NAMES WITH RANDOM NUMBER OF MATCHES 
    
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO Team VALUES ('"+ countryNames[i] + "');"<<endl;
        int ODIsPlayed= rand()%100 + 50;
        int ODIsWon= ODIsPlayed/2, ODIsDrawn= ODIsPlayed/6;
        writer << "INSERT INTO ODITeam (CountryName, MatchesPlayed, MatchesWon, MatchesDrawn) VALUES ('" + countryNames[i] + "'," << ODIsPlayed << "," << ODIsWon << "," << ODIsDrawn << ");" << endl;
        int testsPlayed= rand()%60 + 40;
        int testsWon= testsPlayed/4, testsDrawn= testsPlayed/2;
        if (countryNames[i] != "Ire")
        {
            writer << "INSERT INTO TestTeam (CountryName, MatchesPlayed, MatchesWon, MatchesDrawn) VALUES ('" + countryNames[i] + "'," << testsPlayed << "," << testsWon << "," << testsDrawn << ");" << endl;
        }
        int T20sPlayed= rand()%40 + 30;
        int T20sWon= T20sPlayed/2, T20sDrawn= T20sPlayed/20;
        writer << "INSERT INTO T20Team (CountryName, MatchesPlayed, MatchesWon, MatchesDrawn) VALUES ('" + countryNames[i] + "'," << T20sPlayed << "," << T20sWon << "," << T20sDrawn << ");" << endl;
        writer << endl;
    }
    
    //INSERTING RANKINGS....FIXED ORDER OF TEAMS...INDIA..INDIA!
    
    vector<int> ODIPoints, TestPoints, T20Points;
    for (int i=0; i<countryNames.size(); i++) 
    {
        ODIPoints.push_back(rand()%200 + 300);
        TestPoints.push_back(rand()%150 + 200);
        T20Points.push_back(rand()%200 + 100);
    }
    sort(ODIPoints.rbegin(), ODIPoints.rend());
    sort(TestPoints.rbegin(), TestPoints.rend());
    sort(T20Points.rbegin(), T20Points.rend());
    
    writer << "--Now ranking data for teams " << endl << endl;
    
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO ODIRanking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << ODIPoints[i] << ");" << endl;
        writer << "INSERT INTO T20Ranking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << T20Points[i] << ");" << endl;
        if (countryNames[i]!="Ire")
        {
             writer << "INSERT INTO TestRanking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << TestPoints[i] << ");" << endl;
        }
    }
    
    //NOW AN INDEX TO STORE THE PLAYER DATA FOR EACH TEAM'S GENERATED PLAYERS
    
    vector<string> IndFirstNames;
    vector<string> IndLastNames;
    IndFirstNames.push_back("Virender"); IndFirstNames.push_back("Sachin"); IndFirstNames.push_back("Virat"); IndFirstNames.push_back("Suresh");IndFirstNames.push_back("Ishant"); IndFirstNames.push_back("Vinay");  IndFirstNames.push_back("Yuvraj"); IndFirstNames.push_back("Divyam");  IndFirstNames.push_back("Shikhar"); IndFirstNames.push_back("Sourav"); 
    IndLastNames.push_back("Sehwag"); IndLastNames.push_back("Tendulkar"); IndLastNames.push_back("Kohli"); IndLastNames.push_back("Raina"); IndLastNames.push_back("Sharma"); IndLastNames.push_back("Kumar"); IndLastNames.push_back("Singh"); IndLastNames.push_back("Bansal"); IndLastNames.push_back("Dhawan"); IndLastNames.push_back("Ganguly");
    teamVectorFiller(0, "Ind", IndFirstNames, IndLastNames);
    
    vector<string> AusFirstNames;
    vector<string> AusLastNames;
    AusFirstNames.push_back("Adam"); AusFirstNames.push_back("Matthew"); AusFirstNames.push_back("Brett"); AusFirstNames.push_back("Glenn"); AusFirstNames.push_back("Ricky"); AusFirstNames.push_back("Andrew"); AusFirstNames.push_back("Shane"); AusFirstNames.push_back("George");  AusFirstNames.push_back("Michael"); AusFirstNames.push_back("Mitchell"); 
    AusLastNames.push_back("Gilchrist"); AusLastNames.push_back("Hayden"); AusLastNames.push_back("Lee"); AusLastNames.push_back("Maxwell"); AusLastNames.push_back("Ponting"); AusLastNames.push_back("Symonds"); AusLastNames.push_back("Warne"); AusLastNames.push_back("Bailey"); AusLastNames.push_back("Clarke"); AusLastNames.push_back("Johnson");
    teamVectorFiller(1, "Aus", AusFirstNames, AusLastNames);

    vector<string> RSAFirstNames;
    vector<string> RSALastNames;
    RSAFirstNames.push_back("Jacques"); RSAFirstNames.push_back("Dale"); RSAFirstNames.push_back("Morne"); RSAFirstNames.push_back("Hashim"); RSAFirstNames.push_back("Greame"); RSAFirstNames.push_back("Imran"); RSAFirstNames.push_back("Wayne"); RSAFirstNames.push_back("Jean-Paul");  RSAFirstNames.push_back("Colin"); RSAFirstNames.push_back("Shaun"); 
    RSALastNames.push_back("Kallis"); RSALastNames.push_back("Steyn"); RSALastNames.push_back("Morkel"); RSALastNames.push_back("Amla"); RSALastNames.push_back("Smith"); RSALastNames.push_back("Tahir"); RSALastNames.push_back("Parnell"); RSALastNames.push_back("Duminy"); RSALastNames.push_back("Ingram"); RSALastNames.push_back("Pollock");
    teamVectorFiller(2, "RSA", RSAFirstNames, RSALastNames);

    vector<string> EngFirstNames;
    vector<string> EngLastNames;
    EngFirstNames.push_back("Andrew"); EngFirstNames.push_back("Ian"); EngFirstNames.push_back("Jonathan"); EngFirstNames.push_back("Greame"); EngFirstNames.push_back("James"); EngFirstNames.push_back("Steven"); EngFirstNames.push_back("Tim"); EngFirstNames.push_back("Kevin");  EngFirstNames.push_back("Struart"); EngFirstNames.push_back("Matt"); 
    EngLastNames.push_back("Strauss"); EngLastNames.push_back("Bell"); EngLastNames.push_back("Trott"); EngLastNames.push_back("Swann"); EngLastNames.push_back("Anderson"); EngLastNames.push_back("Finn"); EngLastNames.push_back("Bresnan"); EngLastNames.push_back("Pietersen"); EngLastNames.push_back("Broad"); EngLastNames.push_back("Prior");
    teamVectorFiller(3, "Eng", EngFirstNames, EngLastNames);
    
    vector<string> NZFirstNames;
    vector<string> NZLastNames;
    NZFirstNames.push_back("Stephen"); NZFirstNames.push_back("Shane"); NZFirstNames.push_back("Daniel"); NZFirstNames.push_back("Ross"); NZFirstNames.push_back("Martin"); NZFirstNames.push_back("Brendon"); NZFirstNames.push_back("Jacob"); NZFirstNames.push_back("Kyle");  NZFirstNames.push_back("James"); NZFirstNames.push_back("Jeetan"); 
    NZLastNames.push_back("Fleming"); NZLastNames.push_back("Bond"); NZLastNames.push_back("Vettori"); NZLastNames.push_back("Taylor"); NZLastNames.push_back("Guptill"); NZLastNames.push_back("McCullum"); NZLastNames.push_back("Oram"); NZLastNames.push_back("Mills"); NZLastNames.push_back("Franklin"); NZLastNames.push_back("Patel");
    teamVectorFiller(4, "NZ", NZFirstNames, NZLastNames);
    
    vector<string> PakFirstNames;
    vector<string> PakLastNames;
    PakFirstNames.push_back("Mohammed"); PakFirstNames.push_back("Shoaib"); PakFirstNames.push_back("Sohail"); PakFirstNames.push_back("Moin"); PakFirstNames.push_back("Kamran"); PakFirstNames.push_back("Umar"); PakFirstNames.push_back("Shahid"); PakFirstNames.push_back("Saeed");  PakFirstNames.push_back("Zaheer"); PakFirstNames.push_back("Wasim"); 
    PakLastNames.push_back("Hafeez"); PakLastNames.push_back("Malik"); PakLastNames.push_back("Tanvir"); PakLastNames.push_back("Khan"); PakLastNames.push_back("Akmal"); PakLastNames.push_back("Gul"); PakLastNames.push_back("Afridi"); PakLastNames.push_back("Ajmal"); PakLastNames.push_back("Abbas"); PakLastNames.push_back("Akram");
    teamVectorFiller(5, "Pak", PakFirstNames, PakLastNames);
    
    vector<string> SLFirstNames;
    vector<string> SLLastNames;
    SLFirstNames.push_back("Sanath"); SLFirstNames.push_back("Lasith"); SLFirstNames.push_back("Kumar"); SLFirstNames.push_back("Mahela"); SLFirstNames.push_back("Chaminda"); SLFirstNames.push_back("Muttiah"); SLFirstNames.push_back("Angelo"); SLFirstNames.push_back("Tillakaratne");  SLFirstNames.push_back("Thisara"); SLFirstNames.push_back("Dilhara"); 
    SLLastNames.push_back("Jayasuriya"); SLLastNames.push_back("Malinga"); SLLastNames.push_back("Sangakkara"); SLLastNames.push_back("Jayawardane"); SLLastNames.push_back("Vaas"); SLLastNames.push_back("Muralidharan"); SLLastNames.push_back("Mathews"); SLLastNames.push_back("Dilshan"); SLLastNames.push_back("Perera"); SLLastNames.push_back("Fernando");
    teamVectorFiller(6, "SL", SLFirstNames, SLLastNames);
    
    vector<string> WIFirstNames;
    vector<string> WILastNames;
    WIFirstNames.push_back("Brian"); WIFirstNames.push_back("Darren"); WIFirstNames.push_back("Kemar"); WIFirstNames.push_back("Marlon"); WIFirstNames.push_back("Andy"); WIFirstNames.push_back("Vivian"); WIFirstNames.push_back("Clive"); WIFirstNames.push_back("Chris");  WIFirstNames.push_back("Kieron"); WIFirstNames.push_back("Sunil"); 
    WILastNames.push_back("Lara"); WILastNames.push_back("Sammy"); WILastNames.push_back("Roach"); WILastNames.push_back("Samuels"); WILastNames.push_back("Roberts"); WILastNames.push_back("Richards"); WILastNames.push_back("Lloyd"); WILastNames.push_back("Gayle"); WILastNames.push_back("Pollard"); WILastNames.push_back("Narine");
    teamVectorFiller(7, "WI", WIFirstNames, WILastNames);
    
    vector<string> BanFirstNames;
    vector<string> BanLastNames;
    BanFirstNames.push_back("Tamim"); BanFirstNames.push_back("Mashrafe"); BanFirstNames.push_back("Rubel"); BanFirstNames.push_back("Habibul"); BanFirstNames.push_back("Imrul"); BanFirstNames.push_back("Elias"); BanFirstNames.push_back("Sohag"); BanFirstNames.push_back("Shahadat");  BanFirstNames.push_back("Alok"); BanFirstNames.push_back("Mushfiqur"); 
    BanLastNames.push_back("Iqbal"); BanLastNames.push_back("Mortaza"); BanLastNames.push_back("Hossain"); BanLastNames.push_back("Bashar"); BanLastNames.push_back("Kayes"); BanLastNames.push_back("Sunny"); BanLastNames.push_back("Gazi"); BanLastNames.push_back("Hossain"); BanLastNames.push_back("Kapali"); BanLastNames.push_back("Rahim");
    teamVectorFiller(8, "Ban", BanFirstNames, BanLastNames);
    
    vector<string> IreFirstNames;
    vector<string> IreLastNames;
    IreFirstNames.push_back("Trent"); IreFirstNames.push_back("William"); IreFirstNames.push_back("Ed"); IreFirstNames.push_back("Max"); IreFirstNames.push_back("George"); IreFirstNames.push_back("John"); IreFirstNames.push_back("Tim"); IreFirstNames.push_back("Andrew");  IreFirstNames.push_back("Paul"); IreFirstNames.push_back("Alex"); 
    IreLastNames.push_back("Johnston"); IreLastNames.push_back("Porterfield"); IreLastNames.push_back("Joyce"); IreLastNames.push_back("Sorensen"); IreLastNames.push_back("Dockrell"); IreLastNames.push_back("Mooney"); IreLastNames.push_back("Murtagh"); IreLastNames.push_back("White"); IreLastNames.push_back("Stirling"); IreLastNames.push_back("Cusack");
    teamVectorFiller(9, "Ire", IreFirstNames, IreLastNames);
    
    writer << endl << endl << "--Teamwise player and coach data " << endl << endl;
    
    teamFiller();
    venueFiller();
    umpireFiller(40);

    writer << endl << endl << "--Now bilateral series details " << endl << endl;
    
    //Now to generate 3 bilateral series (ODI, Test, T20) between each pair of teams, home as well as away
    for (int i=0; i<numSeries; i++)//home team ka loop
    {
        for (int j=0; j<numSeries; j++)//away team ka loop
        {
            if (i==j) continue;
            bilateralSeriesGenerator(i, j, "ODI", 1999+rand()%14);
            bilateralSeriesGenerator(i, j, "T20", 1999+rand()%14);
            if (i!= 9 && j!=9) {bilateralSeriesGenerator(i, j, "Test", 1999+rand()%14);}
        }
    }
    //~ int i = 8, j = 9;
    //~ bilateralSeriesGenerator(i, j, "ODI", 1999+rand()%14);
    //~ i =9; j = 8;
    //~ bilateralSeriesGenerator(i, j, "T20", 1999+rand()%14);

    writer.close();
    return 0;
}
