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
public class BowlingQuery {
    static public String query(String matchType,String TeamA,String TeamB,String matchplayedin,String matchnotplayedin,
        String ground,String tournament,
        String startDate,String endDate,String daynight,String result,String batbowl,
        String TeamA1l,String TeamA1h,String TeamB1l,String TeamB1h,
        String bowlerName,String bowlerl,String bowlerh,String bowlerEconomy,String bowlerInnings,
        String sortCriteria, String grouping){
        
       
        String query="Select * from "+matchType+"BowlingScoreCard as bowlSC,CricketPerson CP where CP.ID=bowlSC.bowlerID ";
        if(!TeamA.isEmpty() && !TeamA.equals("Any")){
            query+=(" and ('"+TeamA+"'= (Select I.Country from IsInTeam I where  "
                    + "I.ID=bowlSC.BatsmanID)) ");
        }

        if(!TeamB.isEmpty() && !TeamB.equals("Any")){
            query+=(" and not('"+TeamB+"'= (Select I.Country from IsInTeam I where  "
                    + "I.ID=bowlSC.BatsmanID)) ");
        }
        if(!bowlerName.isEmpty()){
            query+=("and '"+bowlerName+"'= (Select CP.Name from CricketPerson as CP "
                    + "where CP.ID=bowlSC.bowlerID) ");
        }
        if(!bowlerl.isEmpty() && !bowlerl.equals("0")){
            query+=("and bowlSC.Wickets>="+bowlerl+" ");
        }
        if(!bowlerh.isEmpty() && !bowlerh.equals("10")){
            query+=("and bowlSC.Wickets<="+bowlerh+" ");
        }
        if(!bowlerEconomy.isEmpty()){
            query+=("and bowlSC.EconomyRate<="+bowlerEconomy+" ");
        }
        if(!bowlerInnings.isEmpty()){
            query+=("and bowlSC.InningNum="+bowlerInnings+" ");
        }
        if(true){
            String matchQuery=MatchQuery.query("bowlSC.MatchId",matchType,TeamA,TeamB,
                    matchplayedin,matchnotplayedin,ground,tournament,
                    startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
                    new ArrayList<String>(),new String(),new String(),new String());        
            query+="and exists( "+matchQuery+")";
        }
        if(!sortCriteria.equals("none")){
            if(sortCriteria.equals("wicketA")){
                query+=" order by Wickets asc ";
            }
            else if(sortCriteria.equals("wicketD")){
                query+=" order by Wickets desc ";
            }
            else if(sortCriteria.equals("economyA")){
                query+=" order by EconomyRate asc ";
            }
            else if(sortCriteria.equals("economyD")){
                query+=" order by EconomyRate desc ";
            }
            else if(sortCriteria.equals("players")){
                query+=" order by BowlerID ";
            }
            
        }
        if(!grouping.equals("none")){
            if(grouping.equals("player")){
                query="Select Name,sum(OversBowled) as SO,sum(MaidenOvers) as SM,sum(Runs) as SR,sum(Wickets) as SW, "
                        + "sum(Runs)*1.0/sum(OversBowled) as AE,count(*) as SI from ("+query+") as q "
                        + "group by Name";
            }
        }
        return query;
    }
}
