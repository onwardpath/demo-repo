package com.onwardpath.georeach.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Timestamp;
import java.util.Properties;

public class DbUtil {
	  private static Connection dbConnection = null;

	  public static Connection getConnection() {
		  try {
			  if (dbConnection == null || !dbConnection.isValid(1)) {		    	  		          		      		    
		          InputStream inputStream = DbUtil.class.getClassLoader().getResourceAsStream("db.properties");
		          Properties properties = new Properties();
		          if (properties != null) {
		              properties.load(inputStream);		
		              String dbDriver = properties.getProperty("dbDriver");
		              String connectionUrl = properties.getProperty("connectionUrl");
		              String userName = properties.getProperty("userName");
		              String password = properties.getProperty("password");			              
		              //Class.forName(dbDriver).newInstance(); 		              		              
		              dbConnection = DriverManager.getConnection(connectionUrl, userName, password);
		          }	           
			  }		      			 
		  } catch (Exception e) {
              e.printStackTrace();
          }
		  return dbConnection;
	 }
	  
	 public static void closeConnection() {
		  if (dbConnection != null) {
			  try {
				  dbConnection.close();
				  dbConnection = null;
			  } catch (Exception e) {
				  e.printStackTrace();
			  }			  
	      }
	 }
	 
	 public static String getTimestamp() {
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	     return timestamp.toString();	 
	 }
}