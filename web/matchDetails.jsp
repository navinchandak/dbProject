<%-- 
    Document   : matchDetails
    Created on : 14 Nov, 2013, 8:40:08 AM
    Author     : navin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@page import="query.*,JDBC.Functions,JDBC.JDBC"%>
<html>
<!DOCTYPE html>
<script src="js/jquery-1.10.1.min.js"></script>
<script src="js/net.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/functions.js">
</script>

	<head>	
		<meta charset="utf-8"> 
		<title>CricQ</title>
		<link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
	</head>
    <body>
        <div class="container" style = "margin-top:30px;">	
			<h1> <a href = "#">CricQ</a></h1>
<%!
            Functions f;
            Functions ftemp;
            public void jspInit() {
                f=new Functions();
                ftemp=new Functions();
                try{
                    f.connect();
                    ftemp.connect();
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }
%>
<%! 
            public void jspDestroy() {
                f.close();
                ftemp.close();
            }
%>
<% if(!f.connectStatus || !ftemp.connectStatus)  {
    try{
        f.retryConnection();
        ftemp.retryConnection();
    }
    catch(Exception e){
        out.println("Connection to database failed");
        return;
    }
} %>
<%
int matchID = Integer.parseInt(request.getParameter("matchID"));
String matchtype = request.getParameter("matchType");
String query="Select * from "+matchtype+"Match where ID="+matchID;
ResultSet resultSet=f.sampleQuery(query);
resultSet.next();
String teamA=resultSet.getString("TeamA");
String teamB=resultSet.getString("TeamB");
String scoreA=ftemp.getSummarizedScore(matchtype,Integer.parseInt(resultSet.getString("ID")),1);
String scoreB=ftemp.getSummarizedScore(matchtype,Integer.parseInt(resultSet.getString("ID")),2);

String winEnum=resultSet.getString("Result");
String winners=new String();
if(winEnum.equals("TEAMA"))
    winners=teamA+ " wins";
else if(winEnum.equals("TEAMB"))
    winners=teamB+" wins";
else
    winners=winEnum;
if(!matchtype.equals("test"))
{
        out.println("<table class='table table-striped table-bordered'>");
out.println("<tr>"+
        "<td>"+resultSet.getString("Date") +
        "</td><td>"+ftemp.getVenue(Integer.parseInt(resultSet.getString("VenueID"))) +
        "</td><td>"+teamA +
        "</td><td>"+scoreA +
        "</td><td>"+teamB +
        "</td><td>"+scoreB +
        "</td><td>"+winners +
        "</td></tr>"
        );
out.println("</table>");
}
out.println("<h2>"+teamA+" 1st Innings Batting ScoreCard"+"</h2>");
query = "select A.battingposition as Batting_Position, c.name as Name,A.runsscored as Runs, A.ballsfaced as Balls,A.fours as Fours,A.sixes as Sixes, A.strikerate as SR from  cricketperson c,(select * from "+matchtype+"battingscorecard where matchid= "+matchID+" and InningNum = 1 ) as A where A.batsmanid = c.id order by batting_position asc";
resultSet=f.sampleQuery(query+";");
int resultSize=0;
ResultSetMetaData rsmd = resultSet.getMetaData();
int columnCount = rsmd.getColumnCount();
out.println("<table class='table table-striped table-bordered'>");
out.println("<tr>");
for(int i=1;i<=columnCount;i++)
{
    String columntitle = rsmd.getColumnName(i);
    out.println("<td>"+columntitle+"</td>");
}
out.println("</tr>");
while(resultSet.next()){
        resultSize++;
        out.println("<tr>");
        for(int i=1;i<=columnCount;i++)
        {
            out.println("<td>"+resultSet.getString(i)+"</td>");
        }
        out.println("</tr>");
}
out.println("</table>");
out.println("<h3> Bowling </h3>");
query = "select c.name as Name,A.Oversbowled as Overs, A.maidenovers as Maiden,A.runs as runs,A.wickets as Wickets, A.economyrate as Economy_Rate from  cricketperson c,(select * from "+matchtype+"bowlingscorecard where matchid="+matchID+" and InningNum =1) as A where A.bowlerid = c.id";
resultSet=f.sampleQuery(query+";");
resultSize=0;
rsmd = resultSet.getMetaData();
columnCount = rsmd.getColumnCount();
out.println("<table class='table table-striped table-bordered'>");
out.println("<tr>");
for(int i=1;i<=columnCount;i++)
{
    String columntitle = rsmd.getColumnName(i);
    out.println("<td>"+columntitle+"</td>");
}
out.println("</tr>");
while(resultSet.next()){
        resultSize++;
        out.println("<tr>");
        for(int i=1;i<=columnCount;i++)
        {
            out.println("<td>"+resultSet.getString(i)+"</td>");
        }
        out.println("</tr>");
}
out.println("</table>");
out.println("<h2>"+teamB+" 1st Innings Batting ScoreCard"+"</h2>");
query = "select A.battingposition as Batting_Position, c.name as Name,A.runsscored as Runs, A.ballsfaced as Balls,A.fours as Fours,A.sixes as Sixes, A.strikerate as SR from  cricketperson c,(select * from "+matchtype+"battingscorecard where matchid= "+matchID+" and InningNum = 2 ) as A where A.batsmanid = c.id order by batting_position asc";
resultSet=f.sampleQuery(query+";");
resultSize=0;
rsmd = resultSet.getMetaData();
columnCount = rsmd.getColumnCount();
out.println("<table class='table table-striped table-bordered'>");
out.println("<tr>");
for(int i=1;i<=columnCount;i++)
{
    String columntitle = rsmd.getColumnName(i);
    out.println("<td>"+columntitle+"</td>");
}
out.println("</tr>");
while(resultSet.next()){
        resultSize++;
        out.println("<tr>");
        for(int i=1;i<=columnCount;i++)
        {
            out.println("<td>"+resultSet.getString(i)+"</td>");
        }
        out.println("</tr>");
}
out.println("</table>");       
out.println("<h3> Bowling </h3>");
query = "select c.name as Name,A.Oversbowled as Overs, A.maidenovers as Maiden,A.runs as runs,A.wickets as Wickets, A.economyrate as Economy_Rate from  cricketperson c,(select * from "+matchtype+"bowlingscorecard where matchid="+matchID+" and InningNum =2) as A where A.bowlerid = c.id";
out.println("<table class='table table-striped table-bordered'>");
resultSet=f.sampleQuery(query+";");
resultSize=0;
rsmd = resultSet.getMetaData();
columnCount = rsmd.getColumnCount();
out.println("<tr>");
for(int i=1;i<=columnCount;i++)
{
    String columntitle = rsmd.getColumnName(i);
    out.println("<td>"+columntitle+"</td>");
}
out.println("</tr>");
while(resultSet.next()){
        resultSize++;
        out.println("<tr>");
        for(int i=1;i<=columnCount;i++)
        {
            out.println("<td>"+resultSet.getString(i)+"</td>");
        }
        out.println("</tr>");
}
out.println("</table>");

if(matchtype.equals("test"))
{
    out.println("<h2>"+teamA+" 2nd Innings Batting ScoreCard"+"</h2>");
    query = "select A.battingposition as Batting_Position, c.name as Name,A.runsscored as Runs, A.ballsfaced as Balls,A.fours as Fours,A.sixes as Sixes, A.strikerate as SR from  cricketperson c,(select * from "+matchtype+"battingscorecard where matchid= "+matchID+" and InningNum = 3 ) as A where A.batsmanid = c.id order by batting_position asc";
    resultSet=f.sampleQuery(query+";");
     resultSize=0;
    rsmd = resultSet.getMetaData();
    columnCount = rsmd.getColumnCount();
    out.println("<table class='table table-striped table-bordered'>");
    out.println("<tr>");
    for(int i=1;i<=columnCount;i++)
    {
        String columntitle = rsmd.getColumnName(i);
        out.println("<td>"+columntitle+"</td>");
    }
    out.println("</tr>");
    while(resultSet.next()){
            resultSize++;
            out.println("<tr>");
            for(int i=1;i<=columnCount;i++)
            {
                out.println("<td>"+resultSet.getString(i)+"</td>");
            }
            out.println("</tr>");
    }
    out.println("</table>");
    out.println("<h3> Bowling </h3>");
    query = "select c.name as Name,A.Oversbowled as Overs, A.maidenovers as Maiden,A.runs as runs,A.wickets as Wickets, A.economyrate as Economy_Rate from  cricketperson c,(select * from "+matchtype+"bowlingscorecard where matchid="+matchID+" and InningNum =3) as A where A.bowlerid = c.id";
    resultSet=f.sampleQuery(query+";");
    resultSize=0;
    rsmd = resultSet.getMetaData();
    columnCount = rsmd.getColumnCount();
    out.println("<table class='table table-striped table-bordered'>");
    out.println("<tr>");
    for(int i=1;i<=columnCount;i++)
    {
        String columntitle = rsmd.getColumnName(i);
        out.println("<td>"+columntitle+"</td>");
    }
    out.println("</tr>");
    while(resultSet.next()){
            resultSize++;
            out.println("<tr>");
            for(int i=1;i<=columnCount;i++)
            {
                out.println("<td>"+resultSet.getString(i)+"</td>");
            }
            out.println("</tr>");
    }
    out.println("</table>");
    out.println("<h2>"+teamB+" 2nd Innings Batting ScoreCard"+"</h2>");
    query = "select A.battingposition as Batting_Position, c.name as Name,A.runsscored as Runs, A.ballsfaced as Balls,A.fours as Fours,A.sixes as Sixes, A.strikerate as SR from  cricketperson c,(select * from "+matchtype+"battingscorecard where matchid= "+matchID+" and InningNum = 4 ) as A where A.batsmanid = c.id order by batting_position asc";
    resultSet=f.sampleQuery(query+";");
    resultSize=0;
    rsmd = resultSet.getMetaData();
    columnCount = rsmd.getColumnCount();
    out.println("<table class='table table-striped table-bordered'>");
    out.println("<tr>");
    for(int i=1;i<=columnCount;i++)
    {
        String columntitle = rsmd.getColumnName(i);
        out.println("<td>"+columntitle+"</td>");
    }
    out.println("</tr>");
    while(resultSet.next()){
            resultSize++;
            out.println("<tr>");
            for(int i=1;i<=columnCount;i++)
            {
                out.println("<td>"+resultSet.getString(i)+"</td>");
            }
            out.println("</tr>");
    }
    out.println("</table>");       
    out.println("<h3> Bowling </h3>");
    query = "select c.name as Name,A.Oversbowled as Overs, A.maidenovers as Maiden,A.runs as runs,A.wickets as Wickets, A.economyrate as Economy_Rate from  cricketperson c,(select * from "+matchtype+"bowlingscorecard where matchid="+matchID+" and InningNum =4) as A where A.bowlerid = c.id";
    out.println("<table class='table table-striped table-bordered'>");
    resultSet=f.sampleQuery(query+";");
    resultSize=0;
    rsmd = resultSet.getMetaData();
    columnCount = rsmd.getColumnCount();
    out.println("<tr>");
    for(int i=1;i<=columnCount;i++)
    {
        String columntitle = rsmd.getColumnName(i);
        out.println("<td>"+columntitle+"</td>");
    }
    out.println("</tr>");
    while(resultSet.next()){
            resultSize++;
            out.println("<tr>");
            for(int i=1;i<=columnCount;i++)
            {
                out.println("<td>"+resultSet.getString(i)+"</td>");
            }
            out.println("</tr>");
    }
    out.println("</table>");
}
%>
}
<a href="index.jsp"> Go back to the query page </a>
</br>






    </body>
</html>