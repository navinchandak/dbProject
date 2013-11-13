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
    public Functions(){
        conn = JDBC.connect();
        try {
            stmt = conn.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }        
    }
    public ResultSet sampleQuery(String query) throws SQLException{
        System.out.println(query);
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
    public String deleteMovie(String movie){
        try{
        String query="Delete from movieawards where moviename=\'"+movie+"\'";
        sampleUpdate(query);        
        query="Delete from castings where moviename=\'"+movie+"\'";
        sampleUpdate(query);
        query="Delete from movie where moviename=\'"+movie+"\'";
        sampleUpdate(query);
        return "Movie Deleted from database";
        }catch(SQLException e){
            return e.getMessage();
        }
    }
    public ResultSet movieDetails(String movie)  throws Exception{     
            String query = "SELECT * FROM movie where moviename=\'" + movie + "\'";
            return sampleQuery(query);
    }
    public String addMovie(String movie,String year,String producer,String director){
        String query=JDBC.setString(movie)+JDBC.setInt(year)+JDBC.setString(producer)+JDBC.setString(director);
        query=query.substring(0,query.length()-1);
        query="insert into movie values("+query+");";
        try{
            sampleUpdate(query);
        }
        catch(SQLException e){
            e.printStackTrace();
            return e.getMessage();
        }
        return movie+" added to database";
    }
    public String addActorToMovie(String movie,String actor){
        String query=JDBC.setString(movie)+JDBC.setString(actor);
        query=query.substring(0,query.length()-1);
        query="insert into castings values("+query+");";
        try{
            sampleUpdate(query);
        }catch(SQLException e){
            return e.getMessage();
        }
        
        return actor+" added as an actor to "+movie;
    }
    public String addAward(String movie,String year,String award){
        String query=JDBC.setString(movie)+JDBC.setInt(year)+JDBC.setString(award);
        query=query.substring(0,query.length()-1);
        query="insert into movieawards values("+query+");";
        try{
            sampleUpdate(query);
        }catch(SQLException e){
            return e.getMessage();
        }
        return award+" added to the award-list of "+movie;
    }

    public ResultSet actorsOf(String movie) throws Exception{     
        String query = "SELECT * FROM castings where moviename=\'" + movie + "\'";
        return sampleQuery(query);
    }
    public ResultSet movieAwards(String movie) throws Exception{     
        String query = "SELECT * FROM movieawards where moviename=\'" + movie + "\'";
        return sampleQuery(query);            
    }   
    public ResultSet actorToMovies(String movie) throws Exception{     
        String query = "SELECT * FROM castings where actor=\'" + movie + "\'";
        return sampleQuery(query);            
    }   

    public void close(){
        try{
            conn.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
