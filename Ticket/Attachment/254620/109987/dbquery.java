import java.sql.*;

public class dbquery 
{
    public static void main(String[] args) throws Exception 
    {
        String url    = "jdbc:oracle:thin:@localhost:1521:ORAOPVD1";
        String user   = "opc_report";
        String passwd = "fr334a11";
        String query  = "select distinct name from opc_user_data";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection(url, user, passwd);
           
        System.out.println("connect: After Connection " + conn);

        Statement stmt = conn.createStatement();
        ResultSet result = stmt.executeQuery(query);
        
        while (result.next()) {
            System.out.println(result.getString(1));
        }
    }
}
