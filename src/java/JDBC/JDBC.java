package JDBC;
import java.io.*;
import java.sql.*;
public class JDBC{
	public static String setString(String a){
		return "\'"+a+"\',";
	}
	public static String setInt(String a){
		return a+",";
	}
	public static Connection connect(){
		try{
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException cnfe){
			System.out.println("Could not find the JDBC driver!");
			System.exit(1);
		}
		//Enter the connection details
		String hostname = "localhost:5432";	// If PostgreSQL is running on some other machine enter the IP address of the machine here
		String username = "postgres"; // Enter your PostgreSQL username
		String password = "postgres"; // Enter your PostgreSQL password
		String dbName = "cricq"; // Enter the name of the database that has the university tables.
		String connectionUrl = "jdbc:postgresql://" + hostname +  "/" + dbName;
		Connection conn = null;
		Statement stmt=null;

		//Connect to the database
		try {
			conn = DriverManager.getConnection(connectionUrl,username, password);
			System.out.println("Connected successfullly "+conn.toString());
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
