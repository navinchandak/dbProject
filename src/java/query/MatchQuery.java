/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package query;
import java.util.ArrayList;

/**
 *
 * @author navin
 */
public class MatchQuery {
    public static String query(String idField,String matchType,String TeamA,String TeamB,String matchplayedin,String matchnotplayedin,
            String ground,String tournament,
        String startDate,String endDate,String daynight,String result,String batbowl,
        String TeamA1l,String TeamA1h,String TeamB1l,String TeamB1h,
        ArrayList<String> playerList,String WK,String Captain,
        String sortCriteria){
        
       
        String query;
        String format = matchType;
        query = "Select * from "+format+"Match ";
        
        query += " where true ";
        if(!idField.isEmpty()){
        
            query+=(" and ID="+idField+" ");
        
        }
        if(TeamA.equals("Any"))
            TeamA = "";
        if(TeamB.equals("Any"))
            TeamB = "";
        if(!TeamA.isEmpty())
        {
            query += " and ( TeamA = '"+TeamA+"' or TeamB = '"+TeamA+"')";
        
        }
        if(!TeamB.isEmpty())
        {
        
                query += " and ( TeamA = '"+TeamB+"' or TeamB = '"+TeamB+"')";
        
        }

        if(!matchplayedin.isEmpty() && !matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
        
                query+= (" and exists (select * from Venue g where  g.ID = VenueID  and  g.Country = '"+ matchplayedin+ "' and  g.Country <> '"+matchnotplayedin+  "'  and  g.Name = '"+ground+"' )");
        
        }

        else if(!"".equals(matchplayedin) && !"".equals(matchnotplayedin) )
        {
        
                query+= (" and exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin+ "' )");
        
        }
        else if(!matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
        
                query+= (" and exists (select * from Venue g where  g.ID = VenueID  and   and  g.country <> '"+matchnotplayedin
                                        + "'  and  g.Name = '"+ground+"' )");
        
        }
        else if(!matchplayedin.isEmpty() && !ground.isEmpty())
        {
        
                query+= (" and exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "'  and  g.Name = '"+ground+"' )");
        
        }
        else if(!matchplayedin.isEmpty() && !matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
                
                query+=( " and exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin	+ "' and  g.Name = '"+ground+"' )");
                
        }


        else if(!matchplayedin.isEmpty())
        {
                
                query+= (" and exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin + "')");
                
        }

        else if(!matchnotplayedin.isEmpty())
        {
                
                query+= (" and not exists (select * from Venue g where  g.ID = VenueID  and  g.country ='"+ matchnotplayedin+"' )");
                
        }

        else if(!ground.isEmpty())
        {
                
                query+= (" and  not exists (select * from Venue g where  g.ID = VenueID  and  g.Name= '"+ ground +"')");
                
        }
        if(!tournament.isEmpty())
        {
                
                query+= (" and  exists (select * from In"+format+"Tournament t where  t.MatchID = ID  and  t.TournamentName ='"+ tournament +"')");
                
        }
        if(!startDate.isEmpty())
        {
                
                query+=" and Date >='" + startDate+"'"; 
                
        }
        if(!endDate.isEmpty())
        {
                
                query+=" and Date <='" + endDate+"'"; 
                
        }
        if(!"either".equals(daynight))
        {
                
                query+=" and DayVersusDayNight = '" + daynight+"'"; 
                
        }

        if(!"".equals(TeamA) && !"".equals(TeamB))
        {
            if(!"either".equals(result))
            {
                
                    if( "TeamA".equals(result))
                        query+=" and ((Result = 'TEAMA' and TeamA = '"+ TeamA + "') or (Result = 'TEAMB' and TeamB = '"+ TeamA+"'))";
                    else if( "TeamB".equals(result) )
                            query+=" and ((Result = 'TEAMA' and TeamA = '"+ TeamB + "') or (Result = 'TEAMB' and TeamB = '"+ TeamB+"'))";
                    else 
                            query+=" and Result = '"+result+"'";
                
            }
            if(!"either".equals(batbowl))
            {
                    if( "TeamA".equals(batbowl) ){
                
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamA + "' and (t.InningNum = 1 or t.InningNum = 2))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamA + "' and t.InningNum = 1)";
                    }

                    else {
                
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and (t.InningNum = 1 or t.InningNum = 2))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and t.InningNum = 1)";
                    }

                
            }
            if(     !"0".equals(TeamA1l) && !"450".equals(TeamA1h))
            {
                
                    query+=" and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
            }
            else if(!"0".equals(TeamA1l) )
            {
                
                    query+= " and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+ " )";
            }
            else if(!"450".equals(TeamA1h))
            {
                
                    query+= " and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.score <= "+ TeamA1h + " )";
            }
            if(     !"0".equals(TeamB1l) && !"450".equals(TeamB1h))
            {
                
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
            }
            else if(!"0".equals(TeamB1l) )
            {
                
                    query+= " and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+ " )";
            }
            else if(!"450".equals(TeamB1h))
            {
                
                    query+= " and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.score <= "+ TeamB1h + " )";
            }            
        }
        else if(!"".equals(TeamA))
        {
            if(!"either".equals(result))
            {
            
                    if( "TeamA".equals(result))
                        query+=" and ((Result = 'TEAMA' and TeamA = '"+ TeamA + "') or (Result = 'TEAMB' and TeamB = '"+ TeamA+"'))";
                    else if( "TeamB".equals(result) )
                            query+=" and ((Result = 'TEAMA' and TeamA <> '"+ TeamA + "') or (Result = 'TEAMB' and TeamB <> '"+ TeamA+"'))";
                    else 
                            query+=" and Result = '"+result+"'";
            
            }
            if(!"either".equals(batbowl))
            {
                    if( "TeamA".equals(batbowl) ){
            
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamA + "' and (t.InningNum = 1 or t.InningNum = 2))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamA + "' and t.InningNum = 1)";
                    }

                    else 
                    {
            
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and (t.InningNum = 3 or t.InningNum = 4))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and t.InningNum = 2)";
                    }

            
            }
            if(     !"0".equals(TeamA1l) && !"450".equals(TeamA1h))
            {
            
                    query+=" and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
            }
            else if(!"0".equals(TeamA1l) )
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+ " )";
            }
            else if(!"450".equals(TeamA1h))
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.score <= "+ TeamA1h + " )";
            }
            if(     !"0".equals(TeamB1l) && !"450".equals(TeamB1h))
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamA + "' and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
            }
            else if(!"0".equals(TeamB1l) )
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamA + "' and x.Score >= "+TeamB1l+ " )";
            }
            else if(!"450".equals(TeamB1h))
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamA + "' and x.score <= "+ TeamB1h + " )";
            }                        
        }
        else if(!"".equals(TeamB))
        {
            if(!"either".equals(result))
            {
            
                    if( "TeamA".equals(result))
                        query+=" and ((Result = 'TEAMA' and TeamA <> '"+ TeamB + "') or (Result = 'TEAMB' and TeamB <> '"+ TeamB+"'))";
                    else if( "TeamB".equals(result) )
                            query+=" and ((Result = 'TEAMA' and TeamA = '"+ TeamB + "') or (Result = 'TEAMB' and TeamB = '"+ TeamB+"'))";
                    else 
                            query+=" and Result = '"+result+"'";
            
            }
            if(!"either".equals(batbowl))
            {
                    if( "TeamA".equals(batbowl) ){
            
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and (t.InningNum = 3 or t.InningNum = 4))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and t.InningNum = 2)";
                    }

                    else 
                    {
            
                        if(format.equals("test"))
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and (t.InningNum = 3 or t.InningNum = 4))";
                        else
                            query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamB + "' and t.InningNum = 2)";
                    }

            
            }
            if(     !"0".equals(TeamA1l) && !"450".equals(TeamA1h))
            {
            
                    query+=" and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamB + "' and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
            }
            else if(!"0".equals(TeamA1l) )
            {
            
                    query+="  and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamB + "' and x.Score >= "+TeamA1l+ " )";
            }
            else if(!"450".equals(TeamA1h))
            {
            
                    query+="  and exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName <> '"+TeamB + "' and x.score <= "+ TeamA1h + " )";
            }
            if(     !"0".equals(TeamB1l) && !"450".equals(TeamB1h))
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
            }
            else if(!"0".equals(TeamB1l) )
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+ " )";
            }
            else if(!"450".equals(TeamB1h))
            {
            
                    query+=" and  exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName  '"+TeamB + "' and x.score <= "+ TeamB1h + " )";
            }
        }
        else if("TEAMA".equals(result) || "TEAMB".equals(result))
        {
            
            if(!"either".equals(batbowl))
            {
                if(batbowl == result)
                {
            
                    if(format.equals("test"))
                        query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and ((t.BattingTeamName = teamA and result = 'TEAMA') or (t.BattingTeamName = teamB and result = 'TEAMB')) and (t.InningNum = 1 or t.InningNum = 2))";
                    else
                        query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and ((t.BattingTeamName = teamA and result = 'TEAMA') or (t.BattingTeamName = teamB and result = 'TEAMB')) and t.InningNum = 1)";
                }
                else
                {
            
                    if(format.equals("test"))
                        query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and ((t.BattingTeamName = teamA and result = 'TEAMA') or (t.BattingTeamName = teamB and result = 'TEAMB')) and (t.InningNum = 3 or t.InningNum = 4))";
                    else
                        query+=" and exists (select * from "+ format + "Innings t where t.MatchID = ID and ((t.BattingTeamName = teamA and result = 'TEAMA') or (t.BattingTeamName = teamB and result = 'TEAMB')) and t.InningNum = 2)";
                }                    
            
            }
            if("TEAMA".equals(result))
            {
                
            
                query+=" and exists (select * from "+format+"Innings x where x.MatchID = ID and ((x.BattingTeamName = teamA and result = 'TEAMA') or (x.BattingTeamName = teamB and result = 'TEAMB')) and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
                
            
            
                query+=	" and  exists (select * from "+format+"Innings x where x.MatchID = ID and ((x.BattingTeamName = teamA and result = 'TEAMB') or (x.BattingTeamName = teamB and result = 'TEAMA')) and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";

                
            }
             else
            {
                
            
                query+=" and exists (select * from "+format+"Innings x where x.MatchID = ID and ((x.BattingTeamName = teamB and result = 'TEAMA') or (x.BattingTeamName = teamA and result = 'TEAMB')) and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
          
 
            
                query+=	" and  exists (select * from "+format+"Innings x where x.MatchID = ID and ((x.BattingTeamName = teamA and result = 'TEAMA') or (x.BattingTeamName = teamB and result = 'TEAMB')) and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
                
            }
        }
        else if("TeamA".equals(batbowl))
        {
          
          query += " and  exists (select * from " + format + "Innings x where x.MatchID = ID and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " and x.inningnum = 1)" ;
          
          

          
          query += " and  exists (select * from " + format + "Innings x where x.MatchID = ID and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " and x.inningnum = 2)" ;

          
        }
        else if("TeamB".equals(batbowl))
        {
          
          query += "  and exists (select * from " + format + "Innings x where x.MatchID = ID and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " and x.inningnum = 2)" ;
          
          
          query += "  and exists (select * from " + format + "Innings x where x.MatchID = ID and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " and x.inningnum = 1)" ;

          
        }
        else
        {
          
            query += "  and exists (select * from " + format + "Innings x where x.MatchID = ID  and (x.score >= " + TeamA1l + " and x.score <= " + TeamA1h+ " ) and " + " exists (select * from " + format + "Innings y where y.MatchID = ID  and (y.score >= " + TeamA1l + " and y.score <= " + TeamA1h+ " ) and y.inningnum <> x.inningnum))";
          
        }    
        for(String player:playerList){
          
                query+=" and  exists (select * from PlayedIn"+format+" t where t.MatchID = ID and t.PlayerID = "
                        + "(select c.ID from CricketPerson c where c.Name = '"+player+"'))";
          

        }
        if(     !WK.isEmpty())
        {
          
                query+=" and  exists (select c.ID from CricketPerson c where c.Name = '"+WK+"' and (c.ID = TeamAWKID or c.ID = TeamBWKID))";	
        }
        if(!Captain.isEmpty())
        {
          
                query+=" and  exists (select c.ID from CricketPerson c where c.Name = '"+Captain+"' and (c.ID = TeamACaptainID or c.ID = TeamBCaptainID))";	
        }
        if(!sortCriteria.equals("none")){
            if(sortCriteria.equals("dateD")){
                query+=" order by Date desc ";
            }
            else if(sortCriteria.equals("dateA")){
                query+=" order by Date asc ";
            }
            else if(sortCriteria.equals("teamA")){
                query+=" order by TeamA asc ";
            }
            else if(sortCriteria.equals("teamB")){
                query+=" order by TeamB asc ";
            }
        }

        return query;

    }
    
}
