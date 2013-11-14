package JDBC;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 *
 * @author navin
 */
public class Functions {
    Connection conn;
    Statement stmt;
    String error;
    public boolean connectStatus;
    public Functions(){
        error=new String();
    }
    public String getErrorMesssage(){
        if(connectStatus){
            return error;
        }
        else
            return "";
    }
    public void retryConnection()throws SQLException,ClassNotFoundException{
        connect();
    }
    public void connect() throws SQLException,ClassNotFoundException{
        try{
            conn = JDBC.connect();
            connectStatus=true;
        }
        catch(SQLException e){
            connectStatus=false;
            error="Connection to database couldnot be established!";
            throw e;
        }
        catch(ClassNotFoundException e1){
            error="Postgres jar file couldnt be found!";
            connectStatus=false;
            throw e1;
        }
        stmt = conn.createStatement();
    }
    public ResultSet sampleQuery(String query) throws SQLException{
        System.out.println("Query run on db:"+query);
        ResultSet resultSet=null;
        resultSet = stmt.executeQuery(query);
        return resultSet;
        
    }    
    public int sampleUpdate(String query) throws SQLException{
        int resultSet=0;
        System.out.println(query);
        stmt.executeUpdate(query);
        return resultSet;
    }
    public String getSummarizedScore(String format,int matchID,int inningsNum){
        try{
            String query="Select Score,Wickets,Overs from "+format+"Innings where MatchId="+matchID+" and InningNum="+inningsNum;
            ResultSet r=sampleQuery(query);
            r.next();
            String res=r.getString("Score")+"/"+r.getString("Wickets")+" ("+r.getString("Overs")+")";
            return res;
        }catch(SQLException e){
            return "Score Not Found";
        }
    }
    public String getVenue(int venueID){
        try{
            String query="Select Name,Country from Venue where ID="+venueID;
            ResultSet r=sampleQuery(query);
            r.next();
            String res=r.getString("Name")+","+r.getString("Country");
            return res;
        }catch(SQLException e){
            return "Venue Not Found! Maybe Connection to database failed";
        }
    }
    public String shortMatchDesc(String format,int matchID){
        try{
            String query=" Select TeamA,TeamB,Date from "+format+"Match where ID="+matchID+" ";
            ResultSet r=sampleQuery(query);
            r.next();
            String res=r.getString("TeamA")+" vs "+r.getString("TeamB")+"("+r.getString("Date")+")";
            return res;
        }catch(SQLException e){
            return "Match Desc Not Found! Maybe Connection to database failed";
        }
    }
    public void close(){
        try{
            if(connectStatus){
            conn.close();
            }
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
