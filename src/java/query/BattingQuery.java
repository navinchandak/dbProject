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
public class BattingQuery {
    static public String query(String matchType,String TeamA,String TeamB,String matchplayedin,String matchnotplayedin,String ground,String tournament,
        String startDate,String endDate,String daynight,String result,String batbowl,
        String TeamA1l,String TeamA1h,String TeamB1l,String TeamB1h,
        String batsmanName,String batsmanl,String batsmanh,String batsmanPosition,String batsmanInnings){
        
        
        String query="Select * from "+matchType+"BattingScoreCard as batSC,CricketPerson CP where CP.ID=batSC.BatsmanID ";
        if(!TeamA.isEmpty() && !TeamA.equals("Any")){
            query+=(" and ('"+TeamA+"'= (Select I.Country from IsInTeam I where  "
                    + "I.ID=batSC.BatsmanID)) ");
        }

        if(!TeamB.isEmpty() && !TeamB.equals("Any")){
            query+=(" and not('"+TeamB+"'= (Select I.Country from IsInTeam I where  "
                    + "I.ID=batSC.BatsmanID)) ");
        }
        if(!batsmanName.isEmpty()){
            query+=("and '"+batsmanName+"'= (Select CP.Name from CricketPerson as CP "
                    + "where CP.ID=batSC.BatsmanID) ");
        }
        if(!batsmanl.isEmpty() && !batsmanl.equals("0")){
            query+=("and batSC.RunsScored>="+batsmanl+" ");
        }
        if(!batsmanh.isEmpty() && !batsmanh.equals("450")){
            query+=("and batSC.RunsScored<="+batsmanh+" ");
        }
        if(!batsmanPosition.isEmpty()){
            query+=("and batSC.BattingPosition="+batsmanPosition+" ");
        }
        if(!batsmanInnings.isEmpty()){
            query+=("and batSC.InningNum="+batsmanInnings+" ");
        }
        if(true){
            String matchQuery=MatchQuery.query("batSC.MatchId",matchType,TeamA,TeamB,
                    matchplayedin,matchnotplayedin,ground,tournament,
                    startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
                    new ArrayList<String>(),new String(),new String());        
            query+="and exists( "+matchQuery+")";
        }
        return query;
    }
    
}
