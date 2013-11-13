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
        
        int flag=0;
        String query="Select * from "+matchType+"BattingScoreCard as batSC ";
        if(!batsmanName.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" '"+batsmanName+"'= (Select * from CricketPerson as CP "
                    + "where CP.ID=batSC.BatsmanID) ");
            flag=1;
        }
        if(!batsmanl.isEmpty() && !batsmanl.equals("0")){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" batSC.RunsScored>="+batsmanl+" ");
            flag=1;
        }
        if(!batsmanh.isEmpty() && !batsmanh.equals("450")){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" batSC.RunsScored<="+batsmanh+" ");
            flag=1;
        }
        if(!batsmanPosition.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" batSC.BattingPosition="+batsmanPosition+" ");
            flag=1;
        }
        if(!batsmanInnings.isEmpty()){
            if(flag==0) query+=(" where ");
            else query+=" and ";
            query+=(" batSC.InningNum="+batsmanInnings+" ");
            flag=1;
        }
        if(true){
            if(flag==0) query+=" where ";
            else query+=" and ";
            String matchQuery=MatchQuery.query("batSC.MatchId",matchType,TeamA,TeamB,
                    matchplayedin,matchnotplayedin,ground,tournament,
                    startDate,endDate,daynight,result,batbowl,TeamA1l,TeamA1h,TeamB1l,TeamB1h,
                    new ArrayList<String>(),new String(),new String());        
            query+=" exists( "+matchQuery+")";
            flag=1;
        }
            
        
        return query;
    }
    
}
