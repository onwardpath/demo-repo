package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.HashMap;
import com.onwardpath.georeach.util.Database;
import com.onwardpath.georeach.model.Segment;

/**
 * Allows Insert, Update and Select queries to Save, Edit and Load Segment Details. Will use Segment bean object.
 * Methods: save, edit, load
 * 
 * @author Pandyan Ramar
 * @date 5 July 2019
 *
 */
public class SegmentRepository {
	  private Connection dbConnection;
	  
	  public SegmentRepository() {
	      dbConnection = Database.getConnection();
	  }
	  
	  /**
	   * Save the Segment to segment table
	   * @param name
	   * @param geography
	   * @param user_id
	   * @param org_id
	   * @throws SQLException
	   */
	  public void save(String name, String geography, int user_id, int org_id) throws SQLException {
          PreparedStatement prepStatement = dbConnection.prepareStatement("insert into segment(name, geography, user_id, org_id) values (?,?,?,?)");	          	        	       
          prepStatement.setString(1, name);
          prepStatement.setString(2, geography);
          prepStatement.setInt(3, user_id);
          prepStatement.setInt(4, org_id);
          System.out.println(Database.getTimestamp()+" @SegmentRepository.save>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();
	  }
	  
	  /**
	   * Update the Segment to segment table
	   * 
	   * @author Gurujegan
	   * @date 4 Oct 2019
	   * @param name
	   * @param geography
	   * @param user_id
	   * @param org_id
	   * @throws SQLException
	   */
	  public void update(String name,String geography,String id, int org_id) throws SQLException {
          PreparedStatement prepStatement = dbConnection.prepareStatement("UPDATE segment SET name = ?, geography = ? WHERE id = ? AND org_id = ?");
          prepStatement.setString(1, name);
          prepStatement.setString(2, geography);
          prepStatement.setString(3, id);
          prepStatement.setInt(4, org_id);
          System.out.println("12345");
          System.out.println(Database.getTimestamp()+" @SegmentRepository.save>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();
	  }
	  
	  
	  /**
	   * Method to find a Segment by Name
	   * 
	   * @param name
	   * @return boolean
	   */
	  public boolean findBySegmentName(String name) throws SQLException {
	      boolean segmentExist = false;
          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from segment where name = ?");
          prepStatement.setString(1, name);   
          System.out.println(Database.getTimestamp()+" @SegmentRepository.findBySegmentName>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                	  segmentExist = true;
                	  break;
                  }               
              }
          }	      
          prepStatement.close();
          result.close();
	      return segmentExist;
	  }
	  
	  /**
	   * Method to find a Segment by Name for an Organization 
	   * 
	   * @param name
	   * @return boolean
	   */
	  public boolean findBySegmentNameInOrg(String name, int org_id) throws SQLException {
	      boolean segmentExist = false;
          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from segment where name = ? and org_id = ?");
          prepStatement.setString(1, name);   
          prepStatement.setInt(2, org_id);
          System.out.println(Database.getTimestamp()+" @SegmentRepository.findBySegmentNameInOrg>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                	  segmentExist = true;
                	  break;
                  }               
              }
          }	      
          prepStatement.close();
          result.close();
	      return segmentExist;
	  }
	  
	  	  
	  /**
	   * Method to get id and name of all segments of an organization 
	   * 
	   * @param org_id
	   * @return Map containing id and name of Segments
	   */
	  public Map<Integer,String> getOrgSegments(int org_id) throws SQLException {
		  Map<Integer, String> segments = new HashMap<Integer, String>();	      
          PreparedStatement prepStatement = dbConnection.prepareStatement("select id, name from segment where org_id = ?");
          prepStatement.setInt(1, org_id); 
          System.out.println(Database.getTimestamp()+" @SegmentRepository.getOrgSegments>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
            	  segments.put(result.getInt("id"), result.getString("name"));	           	                      	                              
              }
          }	          	          
          prepStatement.close();
          result.close();
	      return segments;
	  }
	  
	  /**
	   * Method to get all segment objects of an organization 
	   * 
	   * @param org_id
	   * @return Map containing id and segment objects
	   */
	  public Map<Integer, Segment> loadOrgSegments(int org_id) throws SQLException {
		  Map<Integer, Segment> orgSegments = new HashMap<Integer, Segment>();
		  PreparedStatement prepStatement = dbConnection.prepareStatement("select * from segment where org_id = ?");
          prepStatement.setInt(1, org_id); 
          System.out.println(Database.getTimestamp()+" @SegmentRepository.loadOrgSegments>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
            	  Segment segment = new Segment();
            	  segment.setId(result.getInt("id"));
            	  segment.setName(result.getString("name"));
            	  segment.setGeography(result.getString("geography"));
            	  segment.setUser_id(result.getInt("user_id"));             	  
            	  segment.setOrg_id(result.getInt("org_id"));
            	  orgSegments.put(result.getInt("id"), segment);
              }
          }	
          prepStatement.close();
          result.close();
          return orgSegments;
	  }	
	  
	  /**
	   * Method to get all segment objects of a particular type (loc/beh/int/ref) of an organization 
	   * 
	   * @param org_id
	   * @return Map containing id and segment objects
	   */   
	  public Map<Integer, Segment> loadOrgSegmentsByType(int org_id, String type) throws SQLException {
		  //TODO: Check if type is only one of the following: loc/beh/int/ref
		  Map<Integer, Segment> orgSegments = new HashMap<Integer, Segment>();
		  PreparedStatement prepStatement = dbConnection.prepareStatement("select * from segment  where org_id = ? and geography like ? ");
          prepStatement.setInt(1, org_id);
          //prepStatement.setString(2, type); 
          prepStatement.setString(2, type + "%");
          System.out.println(Database.getTimestamp()+" @SegmentRepository.loadOrgSegments>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
            	  Segment segment = new Segment();
            	  segment.setId(result.getInt("id"));
            	  segment.setName(result.getString("name"));
            	  segment.setGeography(result.getString("geography"));
            	  segment.setUser_id(result.getInt("user_id"));             	  
            	  segment.setOrg_id(result.getInt("org_id"));
            	  orgSegments.put(result.getInt("id"), segment);
              }
          }	
          prepStatement.close();
          result.close();
          return orgSegments;
	  }
	  
	  /**
	   * Close the database connection used by this Experience Repository instance. Usually you dont have to close the connection.
	   * 
	   */
	  public void close() {
		  //System.out.println(Database.getTimestamp()+" @SegmentRepository.close>Closing Database Connection");
		  //Database.closeConnection();
	  }
	  
	  /**
	   * Object destroyer to free up database connection. To be called by Garbage Collector
	   * 
	   */
	  public void finalize() {
		  //System.out.println(Database.getTimestamp()+" @SegmentRepository.finalize>Closing Database Connection");
		  //Database.closeConnection();
	  }
}
