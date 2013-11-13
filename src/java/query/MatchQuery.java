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
        ArrayList<String> playerList,String WK,String Captain){
        
        String query;
        String format = matchType;
        query = "Select * from "+format+"Match ";
        int flag = 0;
        if(!idField.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" ID="+idField+" ");
            flag=1;
        }
        if(!TeamA.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query += "( TeamA = '"+TeamA+"' or TeamB = '"+TeamA+"')";
                flag=1;
        }
        if(!TeamB.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query += "( TeamA = '"+TeamB+"' or TeamB = '"+TeamB+"')";
                flag=1;
        }

        if(!matchplayedin.isEmpty() && !matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.Country = '"+ matchplayedin+ "' and  g.Country <> '"+matchnotplayedin+  "'  and  g.Name = '"+ground+"' )");
                flag=1;
        }

        else if(!"".equals(matchplayedin) && !"".equals(matchnotplayedin) )
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin+ "' )");
                flag=1;
        }
        else if(!matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= ("exists (select * from Venue g where  g.ID = VenueID  and   and  g.country <> '"+matchnotplayedin
                                        + "'  and  g.Name = '"+ground+"' )");
                flag=1;
        }
        else if(!matchplayedin.isEmpty() && !ground.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "'  and  g.Name = '"+ground+"' )");
                flag=1;
        }
        else if(!matchplayedin.isEmpty() && !matchnotplayedin.isEmpty() && !ground.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=( "exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin+ "' and  g.country <> '"+matchnotplayedin	+ "' and  g.Name = '"+ground+"' )");
                flag=1;
        }


        else if(!matchplayedin.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= ("exists (select * from Venue g where  g.ID = VenueID  and  g.country = '"+ matchplayedin + "')");
                flag=1;
        }

        else if(!matchnotplayedin.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= (" not exists (select * from Venue g where  g.ID = VenueID  and  g.country ='"+ matchnotplayedin+"' )");
                flag=1;
        }

        else if(!ground.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= (" not exists (select * from Venue g where  g.ID = VenueID  and  g.Name= '"+ ground +"')");
                flag=1;
        }
        if(!tournament.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= (" exists (select * from In"+format+"Tournament t where  t.MatchID = ID  and  t.TournamentName ='"+ tournament +"')");
                flag=1;
        }
        if(!startDate.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= "Date >='" + startDate+"'"; 
                flag=1;
        }
        if(!endDate.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= "Date <='" + endDate+"'"; 
                flag=1;
        }
        if(!"either".equals(daynight))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= "DayVersusDayNight = '" + daynight+"'"; 
                flag=1;
        }

        if(     !"either".equals(result))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                if( "TeamA".equals(result) && !"".equals(TeamA))
                {
                        query+="((Result = 'TEAMA' and TeamA = '"+ TeamA + "') or (Result = 'TEAMB' and TeamB = '"+ TeamA+"'))";
                }
                else if( "TeamB".equals(result) && !"".equals(TeamB))
                        query+="((Result = 'TEAMA' and TeamA = '"+ TeamB + "') or (Result = 'TEAMB' and TeamB = '"+ TeamB+"'))";
                else 
                        query+="Result = '"+result+"'";
                flag=1;
        }
        if(     !"either".equals(batbowl))
        {
                if( "TeamA".equals(batbowl) && !"".equals(TeamA)){
                    if(flag ==0)
                    query+=(" where ");
                    else query+=("  and ");
                    query+="exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName ='" + TeamA + "' and t.InningNum = 1 )";
                }

                else if( "TeamB".equals(batbowl) && !"".equals(TeamB)){
                    if(flag ==0)
                    query+=(" where ");
                    else query+=("  and ");
                    query+="exists (select * from "+ format + "Innings t where t.MatchID = ID and t.BattingTeamName= '" + TeamB + "' and t.InningNum = 1 )";
                }
                flag=1;
        }
        if(     !"0".equals(TeamA1l) && !"450".equals(TeamA1h))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+" and x.score <= "+ TeamA1h + " )";
        }
        else if(!"0".equals(TeamA1l) )
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.Score >= "+TeamA1l+ " )";
        }
        else if(!"450".equals(TeamA1h))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamA + "' and x.score <= "+ TeamA1h + " )";
        }
        if(     !"0".equals(TeamB1l) && !"450".equals(TeamB1h))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+" and x.score <= "+ TeamB1h + " )";
        }
        else if(!"0".equals(TeamB1l) )
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.Score >= "+TeamB1l+ " )";
        }
        else if(!"450".equals(TeamB1h))
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+=	"exists (select * from "+format+"Innings x where x.MatchID = ID and x.BattingTeamName = '"+TeamB + "' and x.score <= "+ TeamB1h + " )";
        }
        for(String player:playerList){
                if(flag ==0) query+=(" where ");
                else query+=("  and ");
                query+= "exists (select * from PlayedIn"+format+" t where t.MatchID = ID and t.PlayerID = "
                        + "(select c.ID from CricketPerson c where c.Name = '"+player+"'))";
                flag=1;

        }
        if(     !WK.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= "exists (select c.ID from CricketPerson c where c.Name = '"+WK+"' and (c.ID = TeamAWKID or c.ID = TeamBWKID))";	
        }
        if(!Captain.isEmpty())
        {
                if(flag ==0)
                query+=(" where ");
                else query+=("  and ");
                query+= "exists (select c.ID from CricketPerson c where c.Name = '"+Captain+"' and (c.ID = TeamACaptainID or c.ID = TeamBCaptainID))";	
        }

        return query;

    }
    
}
