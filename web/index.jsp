<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.sql.*" %>
<%@page import="query.*,JDBC.Functions,JDBC.JDBC"%>

<%!
            Functions f;
            ArrayList<String> countries=new ArrayList<String>();
            ArrayList<String> players=new ArrayList<String>();
            ArrayList<String> venues=new ArrayList<String>();
            public void jspInit() {

                    f=new Functions();
                    try{
                        f.connect();
                        countries=new ArrayList<String>();
                        venues=new ArrayList<String>();
                        countries.add("Any");
                        ResultSet s;
                        s=f.sampleQuery("Select CountryName from Team");
                        while(s.next()){
                            countries.add(s.getString(1));
                        }
                        s=f.sampleQuery("Select Name from CricketPerson CP where"
                                + " exists(select * from Player P where P.ID=CP.ID)");
                        while(s.next()){
                            players.add(s.getString(1));
                        }
                        s=f.sampleQuery("Select Name from Venue");
                        while(s.next()){
                            venues.add(s.getString(1));
                        }


                    }
                    catch(SQLException e){
                        System.out.println(e.getMessage());
                    }

                }
                
                
%>
<%! 
            public void jspDestroy() {
                f.close();
            }
%>
<% if(!f.connectStatus){
    out.println("Sorry ! Connection to database failed ! ");
    return;
}%>
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
            <datalist id="playerList">
            <%
                for(String player:players){
                    out.println("<option value='"+player+"'>");
                }
            %>
            </datalist>
            <datalist id="countryList">
            <%
                for(String country:countries){
                    out.println("<option value='"+country+"'>");
                }
            %>
            </datalist>
            <datalist id="venueList">
            <%
                for(String venue:venues){
                    out.println("<option value='"+venue+"'>");
                }
            %>
            </datalist>            
		<div class="container" style = "margin-top:30px;">	
			<h1> <a href = "#">CricQ</a></h1>
			<div class="navbar">
				<div class="navbar-inner ">
					<div class="container">
						<ul class="nav nav-tabs ">
							<li class="active" style = "width:100px;margin-left:300px; text-align:right;"><a href="#" id="odi-button">ODI Stats</a></li>
							<li style = "width:100px; text-align:center;"><a href="#" id="t20-button">T20I stats</a></li>
							<li style = "width:100px; text-align:left;"><a href="#" id="test-button">Test stats</a></li>

						</ul>
					</div>
				</div>
			</div>
			<div class="navbar  navbar-inverse">
				<div class="navbar-inner ">
					<div class="container">
						<ul class="nav nav-pills ">
							<li class="active" style = "width:295px; text-align:center;"><a href="#" id="match-button">Match Details</a></li>
							<li style = "width:295px; text-align:center;"><a href="#" id="batting-button">Batting Performances</a></li>
							<li style = "width:295px; text-align:center;"><a href="#" id="bowling-button">Bowling Performances</a></li>

						</ul>
					</div>
				</div>
			</div>
			<form action="query.jsp" id="form1" class="form-horizontal" method ="post" autocomplete="off">
				<input id="matchType" name="matchType" type="hidden" value="ODI">
				<input id="queryType" name="queryType" type="hidden" value="match">
				<div class="accordion" id="accordion2">
					<div class="bowling-content accordion-group">
						<div class=" accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapsebowlerperf">
								<div>
									<h3>Bowler Details</h3>
								</div>
							</a>
						</div>
						<div id="collapsebowlerperf" class="accordion-body  collapse in" >
							<div class="accordion-inner">

								<div class = "form-group" style = "padding:2px;margin-top:-10px;">
									<label class="control-label"><strong>Name of Bowler</strong></label>							    
									<input list="playerList" type="text" list="playerList" id="batsmanName" name = "bowlerName" class = "form-control" style = "margin:5px;">				
								</div>												

								<div class = "form-group"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Number of wickets</strong></label>							
									<input type="number" list="playerList" id="batsmanScoreAtleast" name = "bowlerWicketAtleast"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0" value = "0" max = "10">
									and
									<input type="number" id="batsmanScoredAtmost" name = "bowlerWicketAtmost"  class = "inline"style = "margin-left:20px;" min = "0" value="10" max = "10">
								</div>

                                                            <br>
								<div class = "form-group" style = "padding:2px;">
									<label class="control-label"><strong>Economy</strong></label>							    
									<input type="text" name = "bowlerEconomy" class = "form-control" style = "margin:5px;">				
								</div>												
						
							
								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Innings(of the team)</strong></label>							
									<select id ="bowlerInningsTeam" name="bowlerInningsTeam"class = "form-control" style = "margin-left:5px;">
										<option value = "" selected >Either</option>
										<option value = "1"  >First</option>
										<option value = "2" >Second</option>
									</select>

								</div>

								<div class = "form-group showLimitedMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Innings(of the match)</strong></label>							
									<select id ="bowlerInningsMatch" name="bowlerInningsMatch" class = "form-control" style = "margin-left:5px;">
										<option value = "" selected >Either</option>
										<option value = "1"  >First</option>
										<option value = "2" >Second</option>
									</select>

								</div>
						
							
							</div>
						</div>		
					</div>



					<div class="batting-content accordion-group">
						<div class=" accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapsebatsmanperf">
								<div>
									<h3>Batsman Details</h3>
								</div>
							</a>
						</div>
						<div id="collapsebatsmanperf" class="accordion-body  collapse in " >
							<div class="accordion-inner">
								<div class = "form-group" style = "padding:2px;margin-top:-10px;">

									<label class="control-label"><strong>Name of Batsman</strong></label>							    
                                                                        <input list="playerList" type="text" id="batsmanName" name = "batsmanName" class = "form-control" style = "margin:5px;">					

								</div>												
								
								<div class = "form-group"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Score of batsman</strong></label>							
									<input type="number" id="batsmanScoreAtleast" name = "batsmanScoreAtleast"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0" value = "0" max = "450">
									and
									<input type="number" id="batsmanScoredAtmost" name = "batsmanScoreAtmost"  class = "inline"style = "margin-left:20px;" min = "0" value="450" max = "450">
								</div>



								<div class = "form-group"	style = "padding:2px;" >
									<label for="result" class = "control-label"><strong>Batting position</strong></label>							

									<select id ="hah" name="batsmanPosition" class = "form-control" style = "margin-left:5px;">
										<option value = "" selected >Any position</option>
										<option value = "1" >1</option>
										<option value = "2" >2</option>
										<option value = "3" >3</option>
										<option value = "4" >4</option>
										<option value = "5" >5</option>
										<option value = "6" >6</option>
										<option value = "7" >7</option>
										<option value = "8" >8</option>
										<option value = "9" >9</option>
										<option value = "10">10</option>
										<option value = "11">11</option>
									</select>

								</div>

								<div class = "form-group"	style = "padding:2px;" >
									<label for="batfirst" class = "control-label"><strong>Batting Style</strong></label>						

									<select id ="batsmanPlayingStyle" name="batsmanPlayingStyle" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Either</option>
										<option value = "first"  >Left-handed</option>
										<option value = "second" >Right-handed</option>
									</select>

								</div>
								
								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Innings(of the team)</strong></label>							
									<select id ="batsmanInnings" name="batsmanInningsTeam"class = "form-control" style = "margin-left:5px;">
										<option value = "" selected >Either</option>
										<option value = "1"  >First</option>
										<option value = "2" >Second</option>
									</select>
								</div>

								<div class = "form-group showLimitedMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Innings(of the match)</strong></label>							
									<select id ="batsmanInnings" name="batsmanInningsMatch"class = "form-control" style = "margin-left:5px;">
										<option value = "" selected >Either</option>
										<option value = "1"  >First</option>
										<option value = "2" >Second</option>
									</select>
								</div>

							</div>
						</div>		
					</div>







					<div class="common-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse1">
								<div>
									<h3>Match Details</h3>
								</div>
							</a>
						</div>
						<div id="collapse1" class="accordion-body  collapse" >
							<div class="accordion-inner">
                                                            
								<div class = "from-group"	style = "padding:2px;" >
									<label for="team" class="control-label"><strong>Team</strong></label>							    
									<input type="text" list="countryList" id="team" name = "team" class = "form-control" style = "margin-left:5px;">   
								</div>
								<div class = "form-group" style = "padding:2px;">

									<label for="oppsition" class="control-label"><strong>Opposition</strong></label>							    
									<input type="text" list="countryList" id="oppsition" name = "opposition" class = "form-control" style = "margin-left:5px;">							    
								</div>
								
								<div class = "showLimitedMatch form-group"	style = "padding:2px;" >
									<label for="daynight" class = "control-label"><strong>Day or D/N</strong></label>							

									<select id ="daynight" name="daynight" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Either</option>
										<option value = "DAY"  >Day</option>
										<option value = "DAYNIGHT"  >Day/Night</option>
									</select>
								</div>
								
								<div class = "form-group" style = "padding:2px;">
									<label for="tournament" class="control-label"><strong>Tournament Name</strong></label>							    
									<input type="text" id="tournament_name" name = "tournament_name" class = "form-control" style = "margin-left:5px;">			    
								</div>

							</div>
						</div>
					</div>
					<div class="common-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse2">
								<div>
									<h3>When & Where</h3>
								</div>
							</a>
						</div>
						<div id="collapse2" class="accordion-body  collapse" >
							<div class="accordion-inner">
								<div class = "form-group" style = "padding:2px;margin-top:-10px;">

									<label for="matchplayedin" class="control-label"><strong>Match Played in</strong></label>							    
									<input type="text" id="matchplayedin" list="countryList" name = "matchplayedin" class = "form-control" style = "margin-left:5px;">							    
								</div>
								<div class = "form-group" style = "padding:2px;margin-top:-10px;">

									<label for="matchnotplayedin" class="control-label"><strong>Match Not Played in</strong></label>							    
									<input type="text" list="countryList" id="matchnotplayedin" name = "matchnotplayedin" class = "form-control" style = "margin-left:5px;">							    
								</div>



								<br>
								<div class = "form-group" style = "padding:2px;margin-top:-10px;">

									<label for="ground" class="control-label"><strong>Ground</strong></label>							    
									<input type="text" list="venueList" id="ground" name = "ground" class = "form-control" style = "margin-left:5px;">							    
								</div>

								<div class = "form-group" style = "padding:2px;">
									<label for="startdate" class="control-label"><strong>Starting date</strong></label>							    
									<input type="date" id="startdate" name = "match_startdate" class = "form-control" style = "margin-left:5px;">			    
								</div>
								<div class = "form-group" style = "padding:2px;">
									<label for="enddate" class="control-label"><strong>Ending date</strong></label>							    
									<input type="date" id="enddate" name = "match_enddate" class = "form-control" style = "margin-left:5px;">			    
								</div>


							</div>
						</div>		
					</div>



					<div class="common-content accordion-group">
						<div class=" accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse3">
								<div>
									<h3>Scores & Results</h3>
								</div>
							</a>
						</div>
						<div id="collapse3" class="accordion-body  collapse" >
							<div class="accordion-inner">
								<div class = "form-group"	style = "padding:2px;" >
									<label for="result" class = "control-label"><strong>Match Result</strong></label>							

									<select id ="result" name="result" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Either</option>
										<option value = "TEAMA"  >TeamA Won</option>
										<option value = "TEAMB"  >TeamB Won</option>
										<option value = "DRAW" >Draw</option>
										<option value = "NORESULT" >No Result</option>
									</select>

								</div>

								<div class = "form-group"	style = "padding:2px;" >
									<label for="batfirst" class = "control-label"><strong>Bat/Bowl First </strong></label>						

									<select id ="batbowl" name="batbowl" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Either</option>
										<option value = "TeamA"  >TeamA Batting</option>
										<option value = "TeamB" >TeamB Batting</option>
									</select>

								</div>

								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Team Scored b/w (first Innings)</strong></label>							
									<input type="number" id="scored_atleast" name = "team_scored_atleast_1"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0"  max = "800">
									and
									<input type="number" id="scored_atmost" name = "team_scored_atmost_1"  class = "inline"style = "margin-left:20px;" min = "0" max = "800">
								</div>


								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Team Scored b/w (Second Innings)</strong></label>							
									<input type="number" id="scored_atleast" name = "team_scored_atleast_2"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0" max = "800">
									and
									<input type="number" id="scored_atmost" name = "team_scored_atmost_2"  class = "inline"style = "margin-left:20px;" min = "0" max = "800">
								</div>


								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Opposition Scored b/w(First innings)</strong></label>							
									<input type="number" id="scored_atleast" name = "opp_scored_atleast_1"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0"  max = "800">
									and
									<input type="number" id="scored_atmost" name = "opp_scored_atmost_1"  class = "inline"style = "margin-left:20px;" min = "0" max = "800">
								</div>

								<div class = "form-group showTestMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Opposition Scored b/w (2nd Innings)</strong></label>							
									<input type="number" id="scored_atleast" name = "opp_scored_atleast_2"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0"  max = "800">
									and
									<input type="number" id="scored_atmost" name = "opp_scored_atmost_2"  class = "inline"style = "margin-left:20px;" min = "0"  max = "800">
								</div>
								

								<div class = "form-group showLimitedMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Team Scored b/w</strong></label>							
									<input type="number" id="scored_atleast" name = "TeamA1l"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0" value = "0" max = "450">
									and
									<input type="number" id="scored_atmost" name = "TeamA1h"  class = "inline"style = "margin-left:20px;" min = "0" value="450" max = "450">
								</div>

								<div class = "form-group showLimitedMatch"	style = "padding:2px;" >
									<label  class = "control-label"><strong>Opposition Scored b/w</strong></label>							
									<input type="number" id="conceded_atleast" name = "TeamB1l"  class = "inline"style = "margin-left:5px;margin-right:20px;" min = "0" value = "0" max = "450">
									and
									<input type="number" id="conceded_atmost" name = "TeamB1h"  class = "inline"style = "margin-left:20px;" min = "0" value="450" max = "450">
								</div>
							</div>
						</div>		
					</div>





					
					<div class="match-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse4">
								<div>
									<h3>Players</h3>
								</div>
							</a>
						</div>
						<div id="collapse4" class="accordion-body  collapse" >
							<div class="accordion-inner">

								<div class = "form-group" style = "padding:2px;" >

									<label class="control-label"><strong>Including Players</strong></label>							    
									<div style = "float:left; width:80%" id="Players">
										<input type="text" list="playerList" placeholder="player1" name = "player1" class = "form-control" style = "margin-left:5px;">									 
										<button class="btn-info btn btn-small" type="button" onclick="addPlayer()" >+</button><br>

									</div>


								</div>												
								<br>					
								<br>
								<div class = "form-group" style = "padding:2px;margin-top:-10px;">

									<label class="control-label"><strong>Including Captains</strong></label>							    
									<input type="text" list="playerList" id="captain" name = "captain" class = "form-control" style = "margin:5px;">					

								</div>												
								<div class = "form-group" style = "padding:2px;">

									<label class="control-label"><strong>Including Wicket Keepers</strong></label>							    
									<input type="text" list="playerList" id="wk1" name = "wicketkeeper" class = "form-control" style = "margin-left:5px;">					

								</div>												
							</div>
						</div>		
					</div>



					<div class="match-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse5">
								<div>
									<h3>Query Type</h3>
								</div>
							</a>
						</div>
						<div id="collapse5" class="accordion-body  collapse" >
							<div class="accordion-inner">

								<div class = "form-group"	style = "padding:2px;" >
									<label for="result" class = "control-label"><strong>Sort the results by</strong></label>							

									<select id ="result" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Date (latest match first)</option>
										<option value = "either" selected >Date (first match first)</option>
									</select>

								</div>



							</div>
						</div>		
					</div>

					<div class="batting-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse6">
								<div>
									<h3>Query Type</h3>
								</div>
							</a>
						</div>
						<div id="collapse6" class="accordion-body  collapse" >
							<div class="accordion-inner">


								<div class="form-group"> 

									<strong>Group the result by </strong>



									<label class=" radio">
										<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
										No Grouping
									</label>
									<label class="radio">
										<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
										Players
									</label>
									<label class="radio">
										<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
										Team
									</label>


								</div>

								<div class = "form-group"	style = "padding:2px;" >
									<label for="result" class = "control-label"><strong>Sort the results by</strong></label>							

									<select id ="result" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Runs</option>
										<option value = "either" selected >Strike Rate</option>
									</select>

								</div>


							</div>
						</div>		
					</div>


					<div class="bowling-content accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse7">
								<div>
									<h3>Query Type</h3>
								</div>
							</a>
						</div>
						<div id="collapse7" class="accordion-body  collapse" >
							<div class="accordion-inner">


								<div class="form-group"> 

									<strong>Group the result by </strong>



									<label class=" radio">
										<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
										No Grouping
									</label>
									<label class="radio">
										<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
										Players
									</label>
									<label class="radio">
										<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
										Team
									</label>


								</div>

								<div class = "form-group"	style = "padding:2px;" >
									<label for="result" class = "control-label"><strong>Sort the results by</strong></label>							

									<select id ="result" class = "form-control" style = "margin-left:5px;">
										<option value = "either" selected >Wickets</option>
										<option value = "either" selected >Economy</option>
									</select>

								</div>


							</div>
						</div>		
					</div>

					</div >
					<div style = "text-align:center;">
						<input  type = "submit" class="btn btn-large btn-success container" value = "Submit Query">
					</div>

				</form>
			</div>

		</body>

	</html>
