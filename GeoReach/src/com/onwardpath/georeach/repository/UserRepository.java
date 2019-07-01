package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import com.onwardpath.georeach.util.DbUtil;
import com.onwardpath.georeach.util.Database;
import com.onwardpath.georeach.model.User;

public class UserRepository {
	  private Connection dbConnection;
	  
	  public UserRepository() {
	      //dbConnection = DbUtil.getConnection();
		  dbConnection = Database.getConnection();
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
          System.out.println(Database.getTimestamp()+" @UserRepository.saveUserandOrg>prepStatement1: "+prepStatement.toString());                   
          prepStatement.executeUpdate();
          //Get the org_id
          prepStatement = dbConnection.prepareStatement("select last_insert_id()");
          System.out.println(Database.getTimestamp()+" @UserRepository.saveUserandOrg>prepStatement2: "+prepStatement.toString());
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
          System.out.println(Database.getTimestamp()+" @UserRepository.saveUserandOrg>prepStatement3: "+prepStatement.toString());
          prepStatement.executeUpdate();              
          prepStatement.close();
          orgResult.close();
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
          System.out.println(Database.getTimestamp()+" @UserRepository.saveUserInOrg>prepStatement1: "+prepStatement.toString());
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
          System.out.println(Database.getTimestamp()+" @UserRepository.saveUserInOrg>prepStatement2: "+prepStatement.toString());
          prepStatement.executeUpdate(); 
          prepStatement.close();
          orgResult.close();
	  }
	  
	  
	  /**
	   * Check if an Organization exists based on domain
	   * 
	   * @param domain
	   * @return
	   */
	  public boolean orgExists (String domain) throws SQLException {	
		  boolean orgExist = false;
          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from organization where domain = ?");
          prepStatement.setString(1, domain);   
          System.out.println(Database.getTimestamp()+" @UserRepository.orgExists>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                	  orgExist = true;
                	  break;                			                       
                  }               
              }
          }
          prepStatement.close();
          result.close();          
	      return orgExist;
	  }
	  	  
	  /**
	   * Check if user exists (by login/email name)
	   * 
	   * @param login
	   * @return
	   */
	  public boolean findByUserName(String login) throws SQLException {
		  boolean userExist = false;
          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from user where login = ?");
          prepStatement.setString(1, login);    
          System.out.println(Database.getTimestamp()+" @UserRepository.findByUserName>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                	  userExist = true;
                	  break;
                      
                  }               
              }
          }
          prepStatement.close();
          result.close(); 
	      return userExist;
	  }
	  
	  /**
	   * Validate user login/password combination
	   * 
	   * @param login
	   * @param password
	   * @return
	   */
	  public boolean findByLogin(String login, String password) throws SQLException {
		  boolean userAuthenticated = false;	      
          PreparedStatement prepStatement = dbConnection.prepareStatement("select password from user where login = ?");
          prepStatement.setString(1, login);  
          System.out.println(Database.getTimestamp()+" @UserRepository.findByLogin>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {
              while (result.next()) {
                  if (result.getString(1).equals(password)) {
                	  userAuthenticated = true;
                	  break;
                      
                  }
              }               
          }
          prepStatement.close();
          result.close(); 
	      return userAuthenticated;
	  }
	  
	  public User getUser(int id) throws SQLException {
		  User user = new User();		  			  
		  String query = "select user.org_id as org_id, user.firstname as firstname, user.lastname as lastname, " +
		  		"user.login as login, user.email as email, user.phone1 as phone1, organization.name as orgname " + 
		  		"from user, organization " + 
		  		"where user.org_id = organization.id and " + 
		  		"user.id = ?";		  		  		          
		  PreparedStatement prepStatement = dbConnection.prepareStatement(query);
          prepStatement.setInt(1, id); 
          System.out.println(Database.getTimestamp()+" @UserRepository.getUser>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null && result.next()) {
              String firstname = result.getString("firstname");
              String lastname = result.getString("lastname");
              String login = result.getString("login");
              String email = result.getString("email");
              String phone1 = result.getString("phone1");
              int organization_id = Integer.parseInt(result.getString("org_id"));
              String organization_name = result.getString("orgname");
              user.setFirstname(firstname);
              user.setLastname(lastname);
              user.setEmail(email);
              user.setOrganization_id(organization_id);
              user.setOrganization_name(organization_name);
              user.setPhone1(phone1);                  	                            
          }           
          prepStatement.close();
          result.close(); 
	      return user;
	  }	 	 
	  
	  /**
	   * Find a users org_id. To be called after user is successfully authenticated
	   * 
	   * @param login
	   * @return org_id
	   */
	  public int findOrgId(String login) throws SQLException {
		  int org_id = 0;
          PreparedStatement prepStatement = dbConnection.prepareStatement("select org_id from user where login = ?");
          prepStatement.setString(1, login);           
          System.out.println(Database.getTimestamp()+" @UserRepository.findOrgId>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null && result.next()) {	              
              org_id = result.getInt(1);	                             
          }       
          prepStatement.close();
          result.close(); 
	      return org_id;
	  }
	  
	  /**
	   * Find user_id (Primary Key in User table) from login (email/login name). To be called after user is successfully authenticated
	   * 
	   * @param login
	   * @return user_id
	   */
	  public int findUserId(String login) throws SQLException {
		  int user_id = 0;		  
          PreparedStatement prepStatement = dbConnection.prepareStatement("select id from user where login = ?");
          prepStatement.setString(1, login);  
          System.out.println(Database.getTimestamp()+" @UserRepository.findUserId>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null && result.next()) {	              
        	  user_id = result.getInt(1);	                             
          }
          prepStatement.close();
          result.close();
	      return user_id;
	  }	
	  
	  public void close() {
		  System.out.println(Database.getTimestamp()+" @UserRepository.close>Closing Database Connection");
		  Database.closeConnection();
	  }
	  
	  public void finalize() {
		  System.out.println(Database.getTimestamp()+" @UserRepository.finalize>Closing Database Connection");
		  Database.closeConnection();
	  }
}
