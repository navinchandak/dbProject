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
            public void jspInit() {
                f=new Functions();
                try{
                    f.connect();
                }
                catch(SQLException e){
                    e.printStackTrace();
                }
            }
%>
<%! 
            public void jspDestroy() {
                f.close();
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
<table>
<%
if(querytype.equals("match")){
    try{
        ResultSet resultSet=f.sampleQuery(query+";");
        int resultSize=0;
        ResultSetMetaData rsmd = resultSet.getMetaData();
        int columnCount = rsmd.getColumnCount();
        out.println("<table class='table table-striped table-bordered'><tr>"
                + "<td>Date</td>"
                + "<td>TeamA</td>"
                + "<td>TeamB</td>"
                + "<td>Result</td>"
                + "</tr>"
                );
        while(resultSet.next()){
            resultSize++;
            out.println("<tr>"+
                    "<td>"+resultSet.getString("Date") +
                    "</td><td>"+resultSet.getString("TeamA") +
                    "</td><td>"+resultSet.getString("TeamB") +
                    "</td><td>"+resultSet.getString("Result") +
                    "</td></tr>"
                    );
        }
        out.println("</table>");
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
