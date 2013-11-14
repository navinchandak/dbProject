<%-- 
    Document   : action
    Created on : Oct 29, 2013, 7:39:31 PM
    Author     : mohit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                catch(SQLException e){
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
<% if(!f.connectStatus)  {
    out.println("Connection to database failed");
    return;
} %>
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
String querytype=request.getParameter("queryType");
String matchtype=request.getParameter("matchType");
String query=new String();
out.println(" QueryType "+querytype+"</br>");
if(querytype.equals("match")){
    ArrayList<String> playerList=new ArrayList<String> ();
    int index=1;
    while(true){
        String Player= request.getParameter("player"+index);
        if(Player!=null && !Player.isEmpty()) {
            playerList.add(Player); index++;
        }
        else break;
    }
    String WK= request.getParameter("wicketkeeper");
    String Captain= request.getParameter("captain");
    query=MatchQuery.query("",matchtype,TeamA,TeamB,matchplayedin,matchnotplayedin,ground,tournament,
    startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,playerList,WK,Captain);

}
else if(querytype.equals("batting")){
    String batsmanName=request.getParameter("batsmanName");
    String batsmanl=request.getParameter("batsmanScoreAtleast");
    String batsmanh=request.getParameter("batsmanScoreAtmost");
    String batsmanPosition=request.getParameter("batsmanPosition");
    String batsmanInnings=request.getParameter("batsmanInningsMatch");
    //out.println(batsmanName+" "+batsmanPosition);
    query=BattingQuery.query(matchtype,TeamA,TeamB,matchplayedin,matchnotplayedin,ground,tournament,
            startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
            batsmanName,batsmanl,batsmanh,batsmanPosition,batsmanInnings);   
}
else if(querytype.equals("bowling")){
    String bowlerName=request.getParameter("bowlerName");
    String bowlerl=request.getParameter("bowlerWicketAtleast");
    String bowlerh=request.getParameter("bowlerWicketAtmost");
    String bowlerEconomy=request.getParameter("bowlerEconomy");
    String bowlerInnings=request.getParameter("bowlerInningsMatch");
    query=BowlingQuery.query(matchtype,TeamA,TeamB,matchplayedin,matchnotplayedin,ground,tournament,
            startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
            bowlerName,bowlerl,bowlerh,bowlerEconomy,bowlerInnings);   
    
}
out.println(query);
%>
<a href="index.jsp"> Go back to the query page </a>
</br>
<table class='table table-striped table-bordered'>
<%
if(querytype.equals("match")){
    try{
        ResultSet resultSet=f.sampleQuery(query+";");
        ResultSet r=resultSet;
        int resultSize=0;
        ResultSetMetaData rsmd = resultSet.getMetaData();
        int columnCount = rsmd.getColumnCount();
        out.println("<tr>"
                + "<td>Date</td>"
                + "<td>Venue</td>"
                + "<td>TeamA</td>"
                + "<td>Score</td>"
                + "<td>TeamB</td>"
                + "<td>Score</td>"
                + "<td>Result</td>"
                + "</tr>"
                );
        while(resultSet.next()){
            resultSize++;
            String teamA=resultSet.getString("TeamA");
            String teamB=resultSet.getString("TeamB");
            String scoreA=ftemp.getSummarizedScore(matchtype,Integer.parseInt(r.getString("ID")),1);
            String scoreB=ftemp.getSummarizedScore(matchtype,Integer.parseInt(r.getString("ID")),2);
            
            String winEnum=resultSet.getString("Result");
            String winners=new String();
            if(winEnum.equals("TEAMA"))
                winners=teamA+ " wins";
            else if(winEnum.equals("TEAMB"))
                winners=teamB+" wins";
            else
                winners=winEnum;
            out.println("<tr>"+
                    "<td>"+resultSet.getString("Date") +
                    "<td>"+ftemp.getVenue(Integer.parseInt(resultSet.getString("VenueID"))) +
                    "</td><td>"+teamA +
                    "</td><td>"+scoreA +
                    "</td><td>"+teamB +
                    "</td><td>"+scoreB +
                    "</td><td>"+winners +
                    "</td></tr>"
                    );
        }
        out.println("Query Run Successfully and num results "+resultSize+"</br>");
    }
    catch(SQLException e){
        out.println(e.getMessage());
        e.printStackTrace();
    }
}   
else if(querytype.equals("batting")){
    try{
        ResultSet resultSet=f.sampleQuery(query+";");
        int resultSize=0;
        ResultSetMetaData rsmd = resultSet.getMetaData();
        int columnCount = rsmd.getColumnCount();
        out.println("<tr>"
                + "<td>Batsman Name</td>"
                + "<td>Score</td>"
                + "<td>Balls</td>"
                + "<td>Fours</td>"
                + "<td>Sixes</td>"
                + "<td>Strike Rate</td>"
                + "<td>Innings of match</td>"
                + "<td>Batting Position</td>"
                + "<td>In Match</td>"
                + "</tr>"
                );
        while(resultSet.next()){
            String matchDesc=ftemp.shortMatchDesc(matchtype, Integer.parseInt(resultSet.getString("matchID")));
            resultSize++;
            out.println("<tr>"+
                    "<td>"+resultSet.getString("Name") +
                    "</td><td>"+resultSet.getString("RunsScored") +
                    "</td><td>"+resultSet.getString("BallsFaced") +
                    "</td><td>"+resultSet.getString("Fours") +
                    "</td><td>"+resultSet.getString("Sixes") +
                    "</td><td>"+resultSet.getString("StrikeRate") +
                    "</td><td>"+resultSet.getString("InningNum") +
                    "</td><td>"+resultSet.getString("BattingPosition") +
                    "</td><td>"+"<a href='matchDetails.jsp/?id="+resultSet.getString("matchID")+"'> "+matchDesc +"</a>"+
                    "</td></tr>"
                    );
        }
        out.println("Query Run Successfully and num results "+resultSize+"</br>");
    }
    catch(SQLException e){
        out.println(e.getMessage());
        e.printStackTrace();
    }
}   
else if(querytype.equals("bowling")){
    try{
        ResultSet resultSet=f.sampleQuery(query+";");
        int resultSize=0;
        ResultSetMetaData rsmd = resultSet.getMetaData();
        int columnCount = rsmd.getColumnCount();
        out.println("<tr>"
                + "<td>Bowler Name</td>"
                + "<td>Overs</td>"
                + "<td>Maidens</td>"
                + "<td>Runs</td>"
                + "<td>Wickets</td>"
                + "<td>Economy Rate</td>"
                + "<td>Innings of match</td>"
                + "</tr>"
                );
        while(resultSet.next()){
            resultSize++;
            out.println("<tr>"+
                    "<td>"+resultSet.getString("Name") +
                    "</td><td>"+resultSet.getString("OversBowled") +
                    "</td><td>"+resultSet.getString("MaidenOvers") +
                    "</td><td>"+resultSet.getString("Runs") +
                    "</td><td>"+resultSet.getString("Wickets") +
                    "</td><td>"+resultSet.getString("EconomyRate") +
                    "</td><td>"+resultSet.getString("InningNum") +
                    "</td></tr>"
                    );
        }
        out.println("Query Run Successfully and num results "+resultSize+"</br>");
    }
    catch(SQLException e){
        out.println(e.getMessage());
        e.printStackTrace();
    }
}   
%>
</table>






    </body>
</html>
