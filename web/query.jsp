<%-- 
    Document   : action
    Created on : Oct 29, 2013, 7:39:31 PM
    Author     : mohit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,java.sql.*" %>
<%
String TeamA = request.getParameter("team");
String TeamB= request.getParameter("opposition");
String matchplayedin= request.getParameter("matchplayedin");
String matchnotplayedin= request.getParameter("matchnotplayedin");
String ground= request.getParameter("ground");
String tournament= request.getParameter("tournament_name");
String startDate= request.getParameter("match_startdate");
String endDate= request.getParameter("match_enddate");
String daynight= request.getParameter("daynight");
String result= request.getParameter("result");
String batbowl= request.getParameter("batbowl");
String TeamA1l= request.getParameter("TeamA1l");
String TeamA1h= request.getParameter("TeamA1h");
String TeamB1l= request.getParameter("TeamB1l");
String TeamB1h= request.getParameter("TeamB1h");
String Player1= request.getParameter("player1");
String WK= request.getParameter("wicketkeeper");
String Captain= request.getParameter("captain");

String query;
String format = "ODI";
query = "Select * from "+format+"Match ";
int flag = 0;

if(TeamA != "")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query += "( TeamA = '"+TeamA+"' or TeamB = '"+TeamA+"')";
	flag=1;
}
if(TeamB != "")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query += "( TeamA = '"+TeamB+"' or TeamB = '"+TeamB+"')";
	flag=1;
}

if(matchplayedin!="" && matchnotplayedin!="" && ground!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.Country = '"+ matchplayedin+ "' and  g.Country <> '"+matchnotplayedin+  "'  and  g.Name = '"+ground+"' )");
	flag=1;
}

else if(matchplayedin!="" && matchnotplayedin!="" )
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin+ 				"' )");
	flag=1;
}
else if(matchnotplayedin!="" && ground!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= ("exists (select * from Venue g where  g.ID = VenueID  and   and  g.country <> '"+matchnotplayedin
				+ "'  and  g.Name = '"+ground+"' )");
	flag=1;
}
else if(matchplayedin!="" && ground!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "'  and  g.Name = '"+ground+"' )");
	flag=1;
}
else if(matchplayedin!="" && matchnotplayedin!="" && ground!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=( "exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin	+ "' and  g.Name = '"+ground+"' )");
	flag=1;
}


else if(matchplayedin != "")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin + "')");
	flag=1;
}

else if(matchnotplayedin != "")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= (" not exists (select * from Venue g where  g.ID = VenueID  and  g.country '"+ matchnotplayedin+"' )");
	flag=1;
}

else if(ground != "")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= (" not exists (select * from Venue g where  g.ID = VenueID  and  g.Name '"+ ground +"')");
	flag=1;
}
if(tournament!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= (" exists (select * from Tournament t where  t.ID = tournament  and  t.Name ='"+ tournament +"')");
	flag=1;
}
if(startDate!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "Date >=" + startDate; 
	flag=1;
}
if(endDate!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "Date <=" + endDate; 
	flag=1;
}
if(daynight!="either")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "DayVersusDayNight = '" + daynight+"'"; 
	flag=1;
}

if(result!="either")
{
    out.println("result is '"+ result + "'");
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	if(result == "TeamA" && TeamA!="")
	{
		query+="((Result = 'TeamA' and TeamA = '"+ TeamA + "') or (Result = 'TeamB' and TeamB = '"+ TeamA+"'))";
	}
	else if( result =="TeamB" && TeamB!="")
		query+="((Result = 'TeamA' and TeamA = '"+ TeamB + "') or (Result = 'TeamB' and TeamB = '"+ TeamB+"'))";
	else 
		query+="Result = '"+result+"'";
	flag=1;
}
if(batbowl!="either")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	if(batbowl == "TeamA" && TeamA!="")
            query+="exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName '" + TeamA + "' and t.InningNum = 1 )";
	else if( batbowl =="TeamB" && TeamB!="")
            query+="exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName '" + TeamB + "' and t.InningNum = 1 )";
	flag=1;
}
if(TeamA1l!="0" && TeamA1h!="450")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
}
else if(TeamA1l!="0" )
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+ " )";
}
else if(TeamA1h!="450")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.score <= "+ TeamA1h + " )";
}
if(TeamB1l!="0" && TeamB1h!="450")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
}
else if(TeamB1l!="0" )
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+ " )";
}
else if(TeamB1h!="450")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.score <= "+ TeamB1h + " )";
}
if(Player1!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "exists (select * from PlayedInODI t where t.MatchID = ID and t.PlayerID = (select c.ID from CricketPerson where c.Name = '"+Player1+"'))";
	
}
if(WK!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "exists (select c.ID from CricketPerson where c.Name = '"+WK+"' and (c.ID = TeamAWKID or c.ID = TeamBWKID))";	
}
if(Captain!="")
{
	if(flag ==0)
	query+=(" where ");
	else query+=("  and ");
	query+= "exists (select c.ID from CricketPerson where c.Name = '"+Captain+"' and (c.ID = TeamACaptainID or c.ID = TeamBCaptainID))";	
}

out.println(query);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
