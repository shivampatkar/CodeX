package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    public static String dbURL;
    public static String dbUser;
    public static String dbPassword;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection con = null;

        try {
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch(SQLException e) {
            e.printStackTrace();
        }

        return con;
    }
}
