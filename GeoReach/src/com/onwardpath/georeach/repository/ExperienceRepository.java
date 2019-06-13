package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.onwardpath.georeach.model.Experience;
import com.onwardpath.georeach.util.DbUtil;

/**
 * Allows Insert, Update and Select queries to Save, Edit and Load Experience Details. Will use Experience bean object.
 * Methods: save, edit, load
 * 
 * @author pandyan
 *
 */
public class ExperienceRepository {
	  private Connection dbConnection;
	  
	  public ExperienceRepository() {
	      dbConnection = DbUtil.getConnection();
	  }
	  
	  /**
	   * Save the experience to Experience table
	   * 
	   * @param name
	   * @param type
	   * @param status
	   * @param schedule_start
	   * @param schedule_end
	   * @param header_code
	   * @param body_code
	   * @param org_id
	   * @param user_id
	   * @throws SQLException
	   * 
	   * @return id
	   */
	  public int save(String name, String type, String status, String schedule_start, String schedule_end, String header_code, String body_code, int org_id, int user_id) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.experience (name, type, status, schedule_start, schedule_end, header_code, body_code, org_id, user_id, create_time) values (?,?,?,?,?,?,?,?,?,now())");
          prepStatement.setString(1, name);
          prepStatement.setString(2, type);
          prepStatement.setString(3, status);
          prepStatement.setString(4, schedule_start);
          prepStatement.setString(5, schedule_end);
          prepStatement.setString(6, header_code);
          prepStatement.setString(7, body_code);
          prepStatement.setInt(8, org_id);
          prepStatement.setInt(9, user_id);
          //prepStatement.setDate(5, new java.sql.Date(new SimpleDateFormat("MM/dd/yyyy").parse(dateOfBirth.substring(0, 10)).getTime()));	          	          
          prepStatement.executeUpdate();
          prepStatement = dbConnection.prepareStatement("select last_insert_id()");
          ResultSet result = prepStatement.executeQuery();
          return result.getInt(1);                  
	  }
	  
	  public void edit(int experience_id) {	
		  //TODO
	  }
	  
	  /**
	   * To be called after checking experience exists by id
	   * 
	   * @param id
	   * @return
	   */
	  public Experience load(int id) throws SQLException {	
		  Experience experience = new Experience();
          PreparedStatement prepStatement = dbConnection.prepareStatement("select * from experience where id = ?");
          prepStatement.setInt(1, id);                     
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {
              while (result.next()) {	            	              	  
            	  experience.setName(result.getString("name"));            	  
            	  experience.setType(result.getString("type"));            	  
            	  experience.setStatus(result.getString("status"));            	  
            	  experience.setSchedule_start(result.getString("schedule_start"));            	  
            	  experience.setSchedule_end(result.getString("schedule_end"));            	  
            	  experience.setHeader_code(result.getString("header_code"));            	  
            	  experience.setBody_code(result.getString("body_code"));            	  
            	  experience.setOrg_id(result.getInt("org_id"));            	  
            	  experience.setUser_id(result.getInt("user_id"));            	  
            	  experience.setCreate_time(result.getString("create_time"));            	              	              	  	               
              }               
          }
          return experience;		   	     
	  }
	  	  	 
	  /**
	   * Check weather an experience exists
	   * @param id
	   * @return true if exists, false otherwise
	   */
	  public boolean exists(int id) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from experience where id = ?");
	          prepStatement.setInt(1, id);   
	                      
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
	   * Checks if an Experience name already exists for an organization
	   * 
	   * @param name
	   * @param org_id
	   * @return
	   */
	  public boolean nameExists (String name, int org_id) {
		  try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from experience where name = ? and org_id = ?");
	          prepStatement.setString(1, name);
	          prepStatement.setInt(2, org_id);
	                      
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
	}