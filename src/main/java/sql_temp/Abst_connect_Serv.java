package sql_temp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;


public abstract class Abst_connect_Serv extends HttpServlet{
	private static final long serialVersionUID = 1L;
    
	final protected String driverName = 
			"oracle.jdbc.driver.OracleDriver";
	final protected String url = 
			"jdbc:oracle:thin:@192.168.54.222:1521/r07sysdev";
	final protected String id = 
			"r07sysdev";
	final protected String pass = 
			"R07SysDev";
	
	protected  ResultSet connectDB(String sql) 
			throws ClassNotFoundException, SQLException{
		
			Class.forName(driverName);
			Connection connection=
					DriverManager.getConnection(url,id,pass);
			PreparedStatement st = 
					connection.prepareStatement(sql);
			
			ResultSet rs = st.executeQuery();
		
		return rs;
	}
}
