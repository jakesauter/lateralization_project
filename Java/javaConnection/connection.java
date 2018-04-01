import java.sql.*;

public class connection
{
	public static void main(String[] args)
	{
		MysqlDataSource dataSource = new MysqlDataSource();
		dataSource.setUser("a7410589_iDCIAO");
		dataSource.setPassword("1234qwer");
		dataSource.setServerName("mysql7.000webhost.com");
		Connection conn = dataSource.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT ID FROM USERS");
		rs.close();
		stmt.close();
		conn.close();	
	}
}
