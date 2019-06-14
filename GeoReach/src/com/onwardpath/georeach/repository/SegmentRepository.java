package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.HashMap;

import com.onwardpath.georeach.util.DbUtil;

public class SegmentRepository {
	  private Connection dbConnection;
	  
	  public SegmentRepository() {
	      dbConnection = DbUtil.getConnection();
	  }
	  
	  
	  public void save(String name, String geography, int user_id, int org_id) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("insert into segment(name, geography, user_id, org_id) values (?,?,?,?)");
	          	        	       
	          prepStatement.setString(1, name);
	          prepStatement.setString(2, geography);
	          prepStatement.setInt(3, user_id);
	          prepStatement.setInt(4, org_id);
	          	          
	          prepStatement.executeUpdate();
	      } catch (SQLException e) {
	          e.printStackTrace();
	      } 
	  }
	  
	  /**
	   * Method to find a Segment by Name
	   * @param name
	   * @return true if Segment exists, false otherwise
	   */
	  public boolean findBySegmentName(String name) {
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from segment where name = ?");
	          prepStatement.setString(1, name);   
	                      
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
	   * Method to get all segments of an organization 
	   * 
	   * @param org_id
	   * @return list of Segments
	   */
	  public Map<Integer,String> getOrgSegments(int org_id) {
		  Map<Integer, String> segments = new HashMap<Integer, String>();
	      try {
	          PreparedStatement prepStatement = dbConnection.prepareStatement("select id, name from segment where org_id = ?");
	          prepStatement.setInt(1, org_id);
	                     	          
	          ResultSet result = prepStatement.executeQuery();
	          if (result != null) {   
	              while (result.next()) {
	            	  segments.put(result.getInt("id"), result.getString("name"));	           	                      	                              
	              }
	          }	          	          
	      } catch (SQLException e) {
	          e.printStackTrace();
	      }
	      return segments;
	  }

	}
