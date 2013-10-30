import java.io.*;
import java.sql.*;
public class JDBC{
	public static String setString(String a){
		return "\'"+a+"\',";
	}
	public static String setInt(String a){
		return a+",";
	}
	public Connection connect(){
	
	


	
		try{
			Class.forName("com.mysql.jdbc.Driver");

		} catch (ClassNotFoundException cnfe){
			System.out.println("Could not find the JDBC driver!");
			cnfe.printStackTrace();
			System.exit(1);
		}
		System.out.println("MySQL JDBC Driver Registered!");
		//Enter the connection details
		String hostname = "localhost:3306";	// If PostgreSQL is running on some other machine enter the IP address of the machine here	
		String username = "root"; // Enter your PostgreSQL username
		String password = "navin"; // Enter your PostgreSQL password
		String dbName = "test"; // Enter the name of the database that has the university tables.
		String connectionUrl = "jdbc:mysql://" + hostname +  "/" + dbName+"?allowMultiQuery=true";
		Connection conn = null;
		Statement stmt=null;

		//Connect to the database
		try {
			conn = DriverManager.getConnection(connectionUrl,username, password);
			//System.out.println("Connected successfullly");
			stmt=conn.createStatement();
		} catch (SQLException sqle) {
			System.out.println("Connection failed");
			// Uncomment the below line for a more detailed stack trace
			sqle.printStackTrace();
			System.exit(1);
		}
		return conn;

	}
}
