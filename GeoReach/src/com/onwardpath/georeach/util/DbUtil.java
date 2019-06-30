package com.onwardpath.georeach.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DbUtil {
	
	private static DbUtil instance = new DbUtil();
	public static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";
    private String URL, USER, PASSWORD = null;
    
    /*
    dbDriver=com.mysql.jdbc.Driver
	#connectionUrl=jdbc:mysql://localhost:3306/georeachdb
	connectionUrl=jdbc:mysql://107.180.70.27:3306/georeachdb
	userName=root
	password=onwardAdmin1
	*/
		
    private DbUtil() {       
    }
    
    private void loadProperties() throws IOException {    	    		    	
		InputStream inputStream = DbUtil.class.getClassLoader().getResourceAsStream("db.properties");
        Properties properties = new Properties();
        if (properties != null) {
        	properties.load(inputStream);		
        	//String dbDriver = properties.getProperty("dbDriver");
        	URL = properties.getProperty("connectionUrl");
        	URL += "?autoReconnect=true";
        	USER = properties.getProperty("userName");
        	PASSWORD = properties.getProperty("password");			              
        	//Class.forName(dbDriver).newInstance(); 		              		                          
        }		          	            
    }
    
	private Connection createConnection() throws SQLException {
		System.out.println(getTimestamp()+" @DbUtil.createConnection");
		Connection connection = null;
		connection = DriverManager.getConnection(instance.URL, instance.USER, instance.PASSWORD);
	    return connection;
	} 
	
	public static Connection getConnection() {
		Connection connection = null;
		System.out.println(getTimestamp()+" @DbUtil.getConnection");
		try {
			instance.loadProperties();
			connection = instance.createConnection();
		} catch (IOException ioe) {
			System.out.println(ioe.getMessage());
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return connection;
	}
	  	
	public static String getTimestamp() {
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		return timestamp.toString();	 
	}
}