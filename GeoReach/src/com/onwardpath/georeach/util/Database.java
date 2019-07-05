package com.onwardpath.georeach.util;

import java.io.InputStream;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * A singleton class to create database connection
 * 
 * @author Pandyan Ramar
 *
 */
public class Database {
	
	private static Connection dbConnection = null;
	
	/**
	 * Get a Database Connection 
	 * 
	 * @return Connection
	 */
	public static Connection getConnection() {
		System.out.println(getTimestamp()+" @Database.getConnection");
		try {
			if (dbConnection == null || !dbConnection.isValid(1) || dbConnection.isClosed()) {
				InputStream inputStream = Database.class.getClassLoader().getResourceAsStream("db.properties");
				Properties properties = new Properties();
				if (properties != null) {
					properties.load(inputStream);
					String dbDriver = properties.getProperty("driver");
					String connectionUrl = properties.getProperty("url");
					String userName = properties.getProperty("username");
					String password = properties.getProperty("password");
					Class.forName(dbDriver).newInstance();
					dbConnection = DriverManager.getConnection(connectionUrl, userName, password);
					System.out.println(getTimestamp()+" @Database.getConnection>New Connection Created");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
        }
		return dbConnection;
	}
	  
	
	/**
	 * Close Database Connection
	 * 
	 * Note: Usually you do not have to close the connection explicitly.
	 */
	public static void closeConnection() {
		 System.out.println(getTimestamp()+" @Database.closeConnection");
		 if (dbConnection != null) {
			 try {
				 dbConnection.close();
				 dbConnection = null;
			 } catch (Exception e) {
				 e.printStackTrace();
			 }			  
	     }
	}
	 
	/**
	 * Get the current timestamp
	 * 
	 * @return
	 */
	public static String getTimestamp() {
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	     return timestamp.toString();	 
	}

}
