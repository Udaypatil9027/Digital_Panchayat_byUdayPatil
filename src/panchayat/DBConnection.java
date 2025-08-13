package panchayat;
import java.sql.*;
public class DBConnection {
	public static final String url = "jdbc:mysql://localhost:3306/panchayatdb";
	public static final String name = "root";
	public static final String pass = "";
	public static Connection connect(){
		
		
		Connection con = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}catch(ClassNotFoundException e){
			System.out.println(e.getMessage());
		}try{
		 con = DriverManager.getConnection(url,name,pass);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		
		return con;
	}
}



