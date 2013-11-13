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
    static public String query(String matchType,String TeamA,String TeamB,String matchplayedin,String matchnotplayedin,String ground,String tournament,
        String startDate,String endDate,String daynight,String result,String batbowl,
        String TeamA1l,String TeamA1h,String TeamB1l,String TeamB1h,
        String bowlerName,String bowlerl,String bowlerh,String bowlerEconomy,String bowlerInnings){
        
        int flag=0;
        String query="Select * from "+matchType+"BowlingScoreCard as bowlSC ";

        if(!bowlerName.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" '"+bowlerName+"'= (Select * from CricketPerson as CP "
                    + "where CP.ID=bowlSC.bowlerID) ");
            flag=1;
        }
        if(!bowlerl.isEmpty() && !bowlerl.equals("0")){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" bowlSC.Wickets>="+bowlerl+" ");
            flag=1;
        }
        if(!bowlerh.isEmpty() && !bowlerh.equals("10")){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" bowlSC.Wickets<="+bowlerh+" ");
            flag=1;
        }
        if(!bowlerEconomy.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" bowlSC.Economy<="+bowlerEconomy+" ");
            flag=1;
        }
        if(!bowlerInnings.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" bowlSC.InningNum="+bowlerInnings+" ");
            flag=1;
        }
        if(true){
            if(flag==0) query+=" where ";
            else query+=" and ";
            String matchQuery=MatchQuery.query("bowlSC.MatchId",matchType,TeamA,TeamB,
                    matchplayedin,matchnotplayedin,ground,tournament,
                    startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
                    new ArrayList<String>(),new String(),new String());        
            query+=" exists( "+matchQuery+")";
            flag=1;
        }
        return query;
    }
}
