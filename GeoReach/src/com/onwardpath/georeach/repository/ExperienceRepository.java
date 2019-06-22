package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.experience (name, type, status, schedule_start, schedule_end, header_code, body_code, org_id, user_id, create_time) values (?,?,?,now(),now(),?,?,?,?,now())");
          prepStatement.setString(1, name);
          prepStatement.setString(2, type);
          prepStatement.setString(3, status);          
          //prepStatement.setNull(4, java.sql.Types.DATE);//TODO: INSERT RECIEVED DATE
          //prepStatement.setNull(5, java.sql.Types.DATE);//TODO: INSERT RECIEVED DATE
          prepStatement.setString(4, header_code);
          prepStatement.setString(5, body_code);
          prepStatement.setInt(6, org_id);
          prepStatement.setInt(7, user_id);
          //prepStatement.setDate(5, new java.sql.Date(new SimpleDateFormat("MM/dd/yyyy").parse(dateOfBirth.substring(0, 10)).getTime()));	          	          
          prepStatement.executeUpdate();
          prepStatement = dbConnection.prepareStatement("select last_insert_id()");
          ResultSet result = prepStatement.executeQuery();
          result.next();
          return result.getInt(1);                  
	  }
	  
	  
	  //Pass columnType = 0 for int value
	  public void update (int id, int columnType, String colunmName, String value) throws SQLException {
		  String updateSql = "update experience set "+colunmName+" = ";
		  if (columnType == 0) {
			  updateSql+= value+", where id = "+id;
		  } else
			  updateSql+= "'"+value+"' where id = "+id;	
		  //System.out.println("updateSql: "+updateSql);
    	  PreparedStatement prepStatement = dbConnection.prepareStatement(updateSql);          	          
          prepStatement.executeUpdate();                  
	  }
	  
	  
	  public void  saveImage(int experience_id, int segment_id, String url) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.image (experience_id, segment_id, url, create_time) values (?,?,?,now())");                    
          prepStatement.setInt(1, experience_id);
          prepStatement.setInt(2, segment_id);
          prepStatement.setString(3, url);          	          	         
          prepStatement.executeUpdate();                          
	  }	
	  
	  public void saveCode(int experience_id, int org_id) {
		  
	  }
	  	  	 
	  /**
	   * To be called after checking experience exists by id
	   * 
	   * @param id
	   * @return
	   */
	  public Experience get(int id) throws SQLException {	
		  Experience experience = new Experience(id);
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
          
          //Load image experiences
          prepStatement = dbConnection.prepareStatement("select * from image where id = ?");
          return experience;		   	     
	  }
	  
	  public void getOrgExperience (int org_id) throws SQLException {
		  String query = "select experience.id as experienceid, experience.name as experiencename, experience.type as experiencetype, "
		  		+ "experience.create_time as experiencecreatedon, segment.name as segmentname, image.url as url, image.create_time as imagecreatedon "
		  		+ "from"
		  		+ "	experience, segment, image"
		  		+ "where"		  		
		  		+ "experience.id = image.experience_id and"
		  		+ "image.segment_id = segment.id and"
		  		+ "experience.org_id = ?";
		  PreparedStatement prepStatement = dbConnection.prepareStatement(query);
		  prepStatement.setInt(1, org_id);                     
          ResultSet result = prepStatement.executeQuery();
                    
          //EXP.ID	EXP.NAME				EXP.YPE	EXP.CREATEDATA			SEGMENT.NAME	IMAGE.URL															IMAGE.CREATEDATA
          //1		Team Affinity Image		Image	2019-06-12 18:40:45		Wisconsin		https://www.associatedbank.com/content/image/brewers-cc-slide-btn	2019-06-12 18:48:24
          //1		Team Affinity Image		Image	2019-06-12 18:40:45		Minnesota		https://www.associatedbank.com/content/image/wild-cc-slide-btn		2019-06-12 18:49:26
          //9		Home5					image	2019-06-13 18:49:16		Wisconsin		https://x7i5t7v9.ssl.hwcdn.net/cds/banks/5231/81626.png				2019-06-13 18:49:16
          //10		Home6					image	2019-06-13 18:50:49		Wisconsin		https://x7i5t7v9.ssl.hwcdn.net/cds/banks/5231/81626.png				2019-06-13 18:50:49
        		  
          
          if (result != null) {
              while (result.next()) {	            	              	  
            	  //Construct the Experience object with Map of Image objects
              }               
          }
		  
		  
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
