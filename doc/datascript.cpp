#include <iostream>
#include <vector>
#include <fstream>
#include <algorithm>
#include <string>
#include <cstdlib>
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
    int resultSelect= rand()%17; if (resultSelect < 6) {matchResult="TEAMA";} else if (resultSelect < 12) {matchResult="TEAMB";} else if (resultSelect < 14) {matchResult="DRAW";} else if (resultSelect < 6) {matchResult="NORESULT";} else {matchResult="TIE";};
    
    writer << "INSERT INTO Match (Date) VALUES ('12-mar-" << year << "');" << endl;
    
    int matchID= matchTeamAList.size();
    
    //SUNO NA JUNTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
    
    int venueID= venueIndex+1; // VENUE ID DAALNA HAI JUNTAAAAAAAAAA!
    
    //SUNO NA JUNTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!
    
    writer << "INSERT INTO MatchAward (MatchID, PlayerID, AwardName) VALUES (" << matchID << "," << teamAPlayers[5] << ",'Man of the Match')" << endl;
    
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
            int numWickets= rand()%11;
            int numOvers= 30 + rand()%20;
            int inningsRuns= 100 + rand()%338;
            vector<int> *squad;
            squad = (i==0) ? &teamAPlayers : &teamBPlayers;
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
                
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << (rand()%temp) << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-=10;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO ODIBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
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
            int numWickets= rand()%11;
            int numOvers= 12 + rand()%8;
            int inningsRuns= 100 + rand()%80;
            vector<int> *squad;
            squad = (i==0) ? &teamAPlayers : &teamBPlayers;
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
                
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << (rand()%temp) << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-=4;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO T20BowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
            }
        }
    }
    
    else if (matchType=="Test")
    {
        writer << "INSERT INTO TestMatch (ID, Date, Result, DayVersusDayNight, Umpire1, Umpire2, Umpire3, TossWonBy, TeamA, TeamB, VenueID, TeamACaptainID, TeamBCaptainID, TeamAWKID, TeamBWKID) VALUES (";
        writer << matchID << ",'12-mar-" << year << "','" << matchResult << "'," << ((rand()%2==0) ? "'DAY',":"'DAYNIGHT',");
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
            int numWickets= rand()%11;
            int numOvers= 100 + rand()%80;
            int inningsRuns= 100 + rand()%400;
            vector<int> *squad;
            squad = (i==0) ? &teamAPlayers : &teamBPlayers;
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
                
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << ",";
                writer << (rand()%oversBowled)/3 << ",";
                writer << (rand()%temp) << ",";
                writer << rand()%2 + 1 << ",";
                writer << runsBowler/(oversBowled+0.000001) << ");" << endl;
                
                bowlerIndex--; numOvers-= 30;
            }
            
            if (numOvers > 0)
            {
                int oversBowled= numOvers; int runsBowler= (rand()%(inningsRuns/5));
                writer << "INSERT INTO TestBowlingScoreCard (MatchID, InningNum, BowlerID, OversBowled, MaidenOvers, Runs, Wickets, EconomyRate) VALUES (";
                writer << matchID << "," << (i+1) << "," << (*squad)[bowlerIndex] << "," << oversBowled << "," << (rand()%oversBowled)/3 << "," << runsBowler << "," << rand()%2 + 1 << "," << runsBowler/(oversBowled+0.00001) << ");" << endl;
            }
        }
    }
    
    writer << endl;
    
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
            if (teamName=="Ireland") {testTeam.push_back(false);} else {testTeam.push_back(true);}
        }
    }
    
    string coachName= teamName + " Coach";
    wicketKeeper.push_back(false); bowler.push_back(false); batsman.push_back(false); teamNames.push_back(teamName); umpire.push_back(false);
    coach.push_back(true); cricketPersonName.push_back(coachName);
    if (teamName!= "Ireland") {testTeam.push_back(true);} else {testTeam.push_back(false);}
    
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
                    int BestInningsTestPerformanceWickets= 2 + rand()%8, BestInningsTestPerformanceRuns= 50 + rand()%30, BestMatchTestPerformanceWickets= 6 + rand()%8, BestMatchTestPerformanceRuns= 140 + rand()%80, Test5WHauls= TestWickets/100;
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
    writer << endl << endl << "/*Now filling in umpires*/" << endl << endl;
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
    writer << endl << "/*Creating random venues*/" << endl << endl;
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO VENUE (Name, Capacity, City, Country) VALUES ('" << countryNames[i] << " Stadium'," << 10000+(rand()%3)*5000 << ",'Nowhere','" << countryNames[i] << "');" << endl;
    }
    writer << endl;
}

int main()
{
    writer.open("script.sql");

    countryNames.push_back("India"); 
    countryNames.push_back("Australia"); 
    countryNames.push_back("South Africa"); 
    countryNames.push_back("England"); 
    countryNames.push_back("New Zealand"); 
    countryNames.push_back("Pakistan"); 
    countryNames.push_back("Sri Lanka"); 
    countryNames.push_back("West Indies"); 
    countryNames.push_back("Bangladesh"); 
    countryNames.push_back("Ireland"); 
    
    writer << "/*Inserting teams with random number of matches played */" << endl << endl;
    
    
    //INSERTING TEAM NAMES WITH RANDOM NUMBER OF MATCHES 
    
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO Team VALUES ('"+ countryNames[i] + "');"<<endl;
        int ODIsPlayed= rand()%100 + 50;
        int ODIsWon= ODIsPlayed/2, ODIsDrawn= ODIsPlayed/6;
        writer << "INSERT INTO ODITeam (CountryName, MatchesPlayed, MatchesWon, MatchesDrawn) VALUES ('" + countryNames[i] + "'," << ODIsPlayed << "," << ODIsWon << "," << ODIsDrawn << ");" << endl;
        int testsPlayed= rand()%60 + 40;
        int testsWon= testsPlayed/4, testsDrawn= testsPlayed/2;
        if (countryNames[i] != "Ireland")
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
    
    writer << "/*Now ranking data for teams*/" << endl << endl;
    
    for (int i=0; i<countryNames.size(); i++)
    {
        writer << "INSERT INTO ODIRanking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << ODIPoints[i] << ");" << endl;
        writer << "INSERT INTO T20Ranking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << T20Points[i] << ");" << endl;
        if (countryNames[i]!="Ireland")
        {
             writer << "INSERT INTO TestRanking (CountryName, Rank, Points) VALUES ('" + countryNames[i] + "'," << i+1 << "," << TestPoints[i] << ");" << endl;
        }
    }
    
    //NOW AN INDEX TO STORE THE PLAYER DATA FOR EACH TEAM'S GENERATED PLAYERS
    
    vector<string> IndiaFirstNames;
    vector<string> IndiaLastNames;
    IndiaFirstNames.push_back("Virender"); IndiaFirstNames.push_back("Sachin"); IndiaFirstNames.push_back("Virat"); IndiaFirstNames.push_back("Suresh");IndiaFirstNames.push_back("Ishant"); IndiaFirstNames.push_back("Vinay");  IndiaFirstNames.push_back("Yuvraj"); IndiaFirstNames.push_back("Divyam");  IndiaFirstNames.push_back("Shikhar"); IndiaFirstNames.push_back("Sourav"); 
    IndiaLastNames.push_back("Sehwag"); IndiaLastNames.push_back("Tendulkar"); IndiaLastNames.push_back("Kohli"); IndiaLastNames.push_back("Raina"); IndiaLastNames.push_back("Sharma"); IndiaLastNames.push_back("Kumar"); IndiaLastNames.push_back("Singh"); IndiaLastNames.push_back("Bansal"); IndiaLastNames.push_back("Dhawan"); IndiaLastNames.push_back("Ganguly");
    teamVectorFiller(0, "India", IndiaFirstNames, IndiaLastNames);
    
    vector<string> AustraliaFirstNames;
    vector<string> AustraliaLastNames;
    AustraliaFirstNames.push_back("Adam"); AustraliaFirstNames.push_back("Matthew"); AustraliaFirstNames.push_back("Brett"); AustraliaFirstNames.push_back("Glenn"); AustraliaFirstNames.push_back("Ricky"); AustraliaFirstNames.push_back("Andrew"); AustraliaFirstNames.push_back("Shane"); AustraliaFirstNames.push_back("George");  AustraliaFirstNames.push_back("Michael"); AustraliaFirstNames.push_back("Mitchell"); 
    AustraliaLastNames.push_back("Gilchrist"); AustraliaLastNames.push_back("Hayden"); AustraliaLastNames.push_back("Lee"); AustraliaLastNames.push_back("Maxwell"); AustraliaLastNames.push_back("Ponting"); AustraliaLastNames.push_back("Symonds"); AustraliaLastNames.push_back("Warne"); AustraliaLastNames.push_back("Bailey"); AustraliaLastNames.push_back("Clarke"); AustraliaLastNames.push_back("Johnson");
    teamVectorFiller(1, "Australia", AustraliaFirstNames, AustraliaLastNames);

    vector<string> SouthAfricaFirstNames;
    vector<string> SouthAfricaLastNames;
    SouthAfricaFirstNames.push_back("Jacques"); SouthAfricaFirstNames.push_back("Dale"); SouthAfricaFirstNames.push_back("Morne"); SouthAfricaFirstNames.push_back("Hashim"); SouthAfricaFirstNames.push_back("Greame"); SouthAfricaFirstNames.push_back("Imran"); SouthAfricaFirstNames.push_back("Wayne"); SouthAfricaFirstNames.push_back("Jean-Paul");  SouthAfricaFirstNames.push_back("Colin"); SouthAfricaFirstNames.push_back("Shaun"); 
    SouthAfricaLastNames.push_back("Kallis"); SouthAfricaLastNames.push_back("Steyn"); SouthAfricaLastNames.push_back("Morkel"); SouthAfricaLastNames.push_back("Amla"); SouthAfricaLastNames.push_back("Smith"); SouthAfricaLastNames.push_back("Tahir"); SouthAfricaLastNames.push_back("Parnell"); SouthAfricaLastNames.push_back("Duminy"); SouthAfricaLastNames.push_back("Ingram"); SouthAfricaLastNames.push_back("Pollock");
    teamVectorFiller(2, "South Africa", SouthAfricaFirstNames, SouthAfricaLastNames);

    vector<string> EnglandFirstNames;
    vector<string> EnglandLastNames;
    EnglandFirstNames.push_back("Andrew"); EnglandFirstNames.push_back("Ian"); EnglandFirstNames.push_back("Jonathan"); EnglandFirstNames.push_back("Greame"); EnglandFirstNames.push_back("James"); EnglandFirstNames.push_back("Steven"); EnglandFirstNames.push_back("Tim"); EnglandFirstNames.push_back("Kevin");  EnglandFirstNames.push_back("Struart"); EnglandFirstNames.push_back("Matt"); 
    EnglandLastNames.push_back("Strauss"); EnglandLastNames.push_back("Bell"); EnglandLastNames.push_back("Trott"); EnglandLastNames.push_back("Swann"); EnglandLastNames.push_back("Anderson"); EnglandLastNames.push_back("Finn"); EnglandLastNames.push_back("Bresnan"); EnglandLastNames.push_back("Pietersen"); EnglandLastNames.push_back("Broad"); EnglandLastNames.push_back("Prior");
    teamVectorFiller(3, "England", EnglandFirstNames, EnglandLastNames);
    
    vector<string> NewZealandFirstNames;
    vector<string> NewZealandLastNames;
    NewZealandFirstNames.push_back("Stephen"); NewZealandFirstNames.push_back("Shane"); NewZealandFirstNames.push_back("Daniel"); NewZealandFirstNames.push_back("Ross"); NewZealandFirstNames.push_back("Martin"); NewZealandFirstNames.push_back("Brendon"); NewZealandFirstNames.push_back("Jacob"); NewZealandFirstNames.push_back("Kyle");  NewZealandFirstNames.push_back("James"); NewZealandFirstNames.push_back("Jeetan"); 
    NewZealandLastNames.push_back("Fleming"); NewZealandLastNames.push_back("Bond"); NewZealandLastNames.push_back("Vettori"); NewZealandLastNames.push_back("Taylor"); NewZealandLastNames.push_back("Guptill"); NewZealandLastNames.push_back("McCullum"); NewZealandLastNames.push_back("Oram"); NewZealandLastNames.push_back("Mills"); NewZealandLastNames.push_back("Franklin"); NewZealandLastNames.push_back("Patel");
    teamVectorFiller(4, "New Zealand", NewZealandFirstNames, NewZealandLastNames);
    
    vector<string> PakistanFirstNames;
    vector<string> PakistanLastNames;
    PakistanFirstNames.push_back("Mohammed"); PakistanFirstNames.push_back("Shoaib"); PakistanFirstNames.push_back("Sohail"); PakistanFirstNames.push_back("Moin"); PakistanFirstNames.push_back("Kamran"); PakistanFirstNames.push_back("Umar"); PakistanFirstNames.push_back("Shahid"); PakistanFirstNames.push_back("Saeed");  PakistanFirstNames.push_back("Zaheer"); PakistanFirstNames.push_back("Wasim"); 
    PakistanLastNames.push_back("Hafeez"); PakistanLastNames.push_back("Malik"); PakistanLastNames.push_back("Tanvir"); PakistanLastNames.push_back("Khan"); PakistanLastNames.push_back("Akmal"); PakistanLastNames.push_back("Gul"); PakistanLastNames.push_back("Afridi"); PakistanLastNames.push_back("Ajmal"); PakistanLastNames.push_back("Abbas"); PakistanLastNames.push_back("Akram");
    teamVectorFiller(5, "Pakistan", PakistanFirstNames, PakistanLastNames);
    
    vector<string> SriLankaFirstNames;
    vector<string> SriLankaLastNames;
    SriLankaFirstNames.push_back("Sanath"); SriLankaFirstNames.push_back("Lasith"); SriLankaFirstNames.push_back("Kumar"); SriLankaFirstNames.push_back("Mahela"); SriLankaFirstNames.push_back("Chaminda"); SriLankaFirstNames.push_back("Muttiah"); SriLankaFirstNames.push_back("Angelo"); SriLankaFirstNames.push_back("Tillakaratne");  SriLankaFirstNames.push_back("Thisara"); SriLankaFirstNames.push_back("Dilhara"); 
    SriLankaLastNames.push_back("Jayasuriya"); SriLankaLastNames.push_back("Malinga"); SriLankaLastNames.push_back("Sangakkara"); SriLankaLastNames.push_back("Jayawardane"); SriLankaLastNames.push_back("Vaas"); SriLankaLastNames.push_back("Muralidharan"); SriLankaLastNames.push_back("Mathews"); SriLankaLastNames.push_back("Dilshan"); SriLankaLastNames.push_back("Perera"); SriLankaLastNames.push_back("Fernando");
    teamVectorFiller(6, "Sri Lanka", SriLankaFirstNames, SriLankaLastNames);
    
    vector<string> WestIndiesFirstNames;
    vector<string> WestIndiesLastNames;
    WestIndiesFirstNames.push_back("Brian"); WestIndiesFirstNames.push_back("Darren"); WestIndiesFirstNames.push_back("Kemar"); WestIndiesFirstNames.push_back("Marlon"); WestIndiesFirstNames.push_back("Andy"); WestIndiesFirstNames.push_back("Vivian"); WestIndiesFirstNames.push_back("Clive"); WestIndiesFirstNames.push_back("Chris");  WestIndiesFirstNames.push_back("Kieron"); WestIndiesFirstNames.push_back("Sunil"); 
    WestIndiesLastNames.push_back("Lara"); WestIndiesLastNames.push_back("Sammy"); WestIndiesLastNames.push_back("Roach"); WestIndiesLastNames.push_back("Samuels"); WestIndiesLastNames.push_back("Roberts"); WestIndiesLastNames.push_back("Richards"); WestIndiesLastNames.push_back("Lloyd"); WestIndiesLastNames.push_back("Gayle"); WestIndiesLastNames.push_back("Pollard"); WestIndiesLastNames.push_back("Narine");
    teamVectorFiller(7, "West Indies", WestIndiesFirstNames, WestIndiesLastNames);
    
    vector<string> BangladeshFirstNames;
    vector<string> BangladeshLastNames;
    BangladeshFirstNames.push_back("Tamim"); BangladeshFirstNames.push_back("Mashrafe"); BangladeshFirstNames.push_back("Rubel"); BangladeshFirstNames.push_back("Habibul"); BangladeshFirstNames.push_back("Imrul"); BangladeshFirstNames.push_back("Elias"); BangladeshFirstNames.push_back("Sohag"); BangladeshFirstNames.push_back("Shahadat");  BangladeshFirstNames.push_back("Alok"); BangladeshFirstNames.push_back("Mushfiqur"); 
    BangladeshLastNames.push_back("Iqbal"); BangladeshLastNames.push_back("Mortaza"); BangladeshLastNames.push_back("Hossain"); BangladeshLastNames.push_back("Bashar"); BangladeshLastNames.push_back("Kayes"); BangladeshLastNames.push_back("Sunny"); BangladeshLastNames.push_back("Gazi"); BangladeshLastNames.push_back("Hossain"); BangladeshLastNames.push_back("Kapali"); BangladeshLastNames.push_back("Rahim");
    teamVectorFiller(8, "Bangladesh", BangladeshFirstNames, BangladeshLastNames);
    
    vector<string> IrelandFirstNames;
    vector<string> IrelandLastNames;
    IrelandFirstNames.push_back("Trent"); IrelandFirstNames.push_back("William"); IrelandFirstNames.push_back("Ed"); IrelandFirstNames.push_back("Max"); IrelandFirstNames.push_back("George"); IrelandFirstNames.push_back("John"); IrelandFirstNames.push_back("Tim"); IrelandFirstNames.push_back("Andrew");  IrelandFirstNames.push_back("Paul"); IrelandFirstNames.push_back("Alex"); 
    IrelandLastNames.push_back("Johnston"); IrelandLastNames.push_back("Porterfield"); IrelandLastNames.push_back("Joyce"); IrelandLastNames.push_back("Sorensen"); IrelandLastNames.push_back("Dockrell"); IrelandLastNames.push_back("Mooney"); IrelandLastNames.push_back("Murtagh"); IrelandLastNames.push_back("White"); IrelandLastNames.push_back("Stirling"); IrelandLastNames.push_back("Cusack");
    teamVectorFiller(9, "Ireland", IrelandFirstNames, IrelandLastNames);
    
    writer << endl << endl << "/*Teamwise player and coach data*/" << endl << endl;
    
    teamFiller();
    venueFiller();
    umpireFiller(40);

    writer << endl << endl << "/*Now bilateral series details*/" << endl << endl;
    
    //Now to generate 3 bilateral series (ODI, Test, T20) between each pair of teams, home as well as away
    for (int i=0; i<10; i++)//home team ka loop
    {
        for (int j=0; j<10; j++)//away team ka loop
        {
            if (i==j) continue;
            bilateralSeriesGenerator(i, j, "ODI", 1999+rand()%14);
            bilateralSeriesGenerator(i, j, "T20", 1999+rand()%14);
            bilateralSeriesGenerator(i, j, "Test", 1999+rand()%14);
        }
    }

    writer.close();
    return 0;
}
