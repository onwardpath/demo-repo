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
public class ImageRepository {
	  private Connection dbConnection;
	  
	  public ImageRepository() {
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
	}
