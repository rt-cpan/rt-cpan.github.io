#!/opt/OV/bin/Perl/bin/perl
use strict;
use warnings;

BEGIN {
    $ENV{CLASSPATH} .= '/opt/ovaa/tomcat/common/lib/ojdbc14.jar';
}

use Inline Java => "DATA";

my $driver = 'oracle.jdbc.driver.OracleDriver';
my $url    = 'jdbc:oracle:thin:@localhost:1521:ORAOPVD1';
my $user   = 'opc_report';
my $passwd = 'fr334a11';
my $query =  'select distinct name from opc_user_data';

my $db = new db_conn($driver,$url,$user,$passwd);
my $result = $db->query($query);

print "Got result $result";
#while ($result->next) {
        #print $result->getString(1);
#}

1;

__DATA__
__Java__
import java.sql.*;

public class db_conn {

    Connection conn;

    public db_conn(String driver,String url,String user,String passwd) throws Exception {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, passwd);
        System.out.println("connect: After Connection " + conn);
    }

    //public String[] query(String query) throws Exception {
    public ResultSet query(String query) throws Exception {

        Statement stmt = conn.createStatement();
        ResultSet result = stmt.executeQuery(query);

        while (result.next()) {
        System.out.println(result.getString(1));
        }

        return result;

        //String[] results;
        //results = new String[100];

        //int index = 0;
        //while (result.next()) {
            //results[index] = result.getString(1);
            //index++;
        //}

        //return results;
    }
}



