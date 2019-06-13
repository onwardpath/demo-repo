package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.onwardpath.georeach.util.DbUtil;

public class UserRepository {
	  private Connection dbConnection;
	  
	  public UserRepository() {
	      dbConnection = DbUtil.getConnection();
	  }
	  
	  //TODO: Update SQL query appropriately
	  public void save(String userName, String password, String firstName, String lastName, String dateOfBirth, String emailAddress) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("insert into user(userName, password, firstName, lastName, dateOfBirth, emailAddress) values (?, ?, ?, ?, ?, ?)");
	          prepStatement.setString(1, userName);
	          prepStatement.setString(2, password);
	          prepStatement.setString(3, firstName);
	          prepStatement.setString(4, lastName);
	          prepStatement.setDate(5, new java.sql.Date(new SimpleDateFormat("MM/dd/yyyy")
	          .parse(dateOfBirth.substring(0, 10)).getTime()));
	          prepStatement.setString(6, emailAddress);
	          
	          prepStatement.executeUpdate();
	      } catch (SQLException e) {
	          e.printStackTrace();
	      } catch (ParseException e) {            
	          e.printStackTrace();
	      }
	  }
	  
	  public boolean findByUserName(String login) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from user where login = ?");
	          prepStatement.setString(1, login);   
	                      
	          ResultSet result = prepStatement.executeQuery();
	          if (result != null) {   
	              while (result.next()) {
	                  if (result.getInt(1) == 1) {
	                      return true;
	                  }               
	              }
	          }
	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	      return false;
	  }
	  
	  public boolean findByLogin(String login, String password) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select password from user where login = ?");
	          prepStatement.setString(1, login);           
	          
	          ResultSet result = prepStatement.executeQuery();
	          if (result != null) {
	              while (result.next()) {
	                  if (result.getString(1).equals(password)) {
	                      return true;
	                  }
	              }               
	          }           
	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	      return false;
	  }
	  
	  /**
	   * To be called after user is successfully authenticated
	   * 
	   * @param login
	   * @return org_id
	   */
	  public int findOrgId(String login) {
		  int org_id = 0;
		  try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select org_id from user where login = ?");
	          prepStatement.setString(1, login);           
	          
	          ResultSet result = prepStatement.executeQuery();
	          if (result != null && result.next()) {	              
	              org_id = result.getInt(1);	                             
	          }           
	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	      return org_id;
	  }
	  
	  /**
	   * To be called after user is successfully authenticated
	   * 
	   * @param login
	   * @return user_id
	   */
	  public int findUserId(String login) {
		  int user_id = 0;
		  try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select id from user where login = ?");
	          prepStatement.setString(1, login);           
	          
	          ResultSet result = prepStatement.executeQuery();
	          if (result != null && result.next()) {	              
	        	  user_id = result.getInt(1);	                             
	          }           
	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	      return user_id;
	  }
	  
	}
