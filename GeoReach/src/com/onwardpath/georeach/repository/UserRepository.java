package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.onwardpath.georeach.util.DbUtil;

public class UserRepository {
	  private Connection dbConnection;
	  
	  public UserRepository() {
	      dbConnection = DbUtil.getConnection();
	  }
	  
	  /**
	   * User registration for new Organization. Collect Organization details and User details and save to Organization and User table
	   * 
	   * @param orgName
	   * @param domain
	   * @param logoUrl
	   * @param firstName
	   * @param lastName
	   * @param email
	   * @param phone
	   * @param password
	   * @param role
	   * @throws SQLException
	   */
	  public void saveUserandOrg (String orgName, String domain, String logoUrl, String firstName, String lastName, String email, String phone, String password, int role) throws SQLException {		  		 
		  //1. Save Organization
		  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into organization (name, domain, logo) values (?, ?, ?)");
		  prepStatement.setString(1, orgName);
          prepStatement.setString(2, domain);
          prepStatement.setString(3, logoUrl);
          prepStatement.executeUpdate();
          //Get the org_id
          prepStatement = dbConnection.prepareStatement("select last_insert_id()");
          ResultSet orgResult = prepStatement.executeQuery();
          orgResult.next();
          int org_id = orgResult.getInt(1);
          
          //2. Save User
          prepStatement = dbConnection.prepareStatement("insert into user (org_id, firstname, lastname, email, phone1, login, password, role_id) values (?, ?, ?, ?, ?, ?, ?, ?)");
          prepStatement.setInt(1, org_id);
          prepStatement.setString(2, firstName);
          prepStatement.setString(3, lastName);
          prepStatement.setString(4, email);
          prepStatement.setString(5, phone);
          prepStatement.setString(6, email);
          prepStatement.setString(7, password);	          
          prepStatement.setInt(8, role); //1=Administrator, 2=User
          prepStatement.executeUpdate();          	        		  	        				  
	  }
	  
	  /**
	   * User registration for existing Organization. Find org_id using domain and add user to the Organization
	   * 
	   * @param domain
	   * @param firstName
	   * @param lastName
	   * @param email
	   * @param phone
	   * @param password
	   * @param role
	   * @throws SQLException
	   */
	  public void saveUserInOrg (String domain, String firstName, String lastName, String email, String phone, String password, int role) throws SQLException {			 		  
		  //1. Find Organization ID from given domain name		  		                     		          	                                                                                                    
          PreparedStatement prepStatement = dbConnection.prepareStatement("select id from organization where domain = ?");
          prepStatement.setString(1, domain);
          ResultSet orgResult = prepStatement.executeQuery();
          orgResult.next();
          int org_id = orgResult.getInt(1);
          
          //2. Save User
          prepStatement = dbConnection.prepareStatement("insert into user (org_id, firstname, lastname, email, phone1, login, password, role_id) values (?, ?, ?, ?, ?, ?, ?, ?)");
          prepStatement.setInt(1, org_id);
          prepStatement.setString(2, firstName);
          prepStatement.setString(3, lastName);
          prepStatement.setString(4, email);
          prepStatement.setString(5, phone);
          prepStatement.setString(6, email);
          prepStatement.setString(7, password);	          
          prepStatement.setInt(8, role); //1=Administrator, 2=User
          prepStatement.executeUpdate();                    	        		  	        				 
	  }
	  
	  
	  /**
	   * Check if an Organization exists based on domain
	   * 
	   * @param domain
	   * @return
	   */
	  public boolean orgExists (String domain) {
		  try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from organization where domain = ?");
	          prepStatement.setString(1, domain);   
	                      
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
	  	  
	  /**
	   * Check if user exists (by login/email name)
	   * 
	   * @param login
	   * @return
	   */
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
	  
	  /**
	   * Validate user login/password combination
	   * 
	   * @param login
	   * @param password
	   * @return
	   */
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
	   * Find a users org_id. To be called after user is successfully authenticated
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
	   * Find user_id (Primary Key in User table) from login (email/login name). To be called after user is successfully authenticated
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
