package com.onwardpath.georeach.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TimeZone;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.onwardpath.georeach.model.Experience;
import com.onwardpath.georeach.model.Image;
import com.onwardpath.georeach.model.Content;
import com.onwardpath.georeach.util.Database;


/**
 * Allows Insert, Update and Select queries to Save, Edit and Load Experience Details. Will use Experience bean object.
 * Methods: save, edit, load
 * 
 * @author Pandyan Ramar
 * @date 5 July 2019
 *
 */
public class ExperienceRepository {
	  private Connection dbConnection;
	  
	  public ExperienceRepository() {
	      dbConnection = Database.getConnection();
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
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.experience (name, type, status, schedule_start, header_code, body_code, org_id, user_id, create_time) values (?,?,?,now(),?,?,?,?,now())");
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
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.save>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement = dbConnection.prepareStatement("select last_insert_id()");
          ResultSet result = prepStatement.executeQuery();          
          result.next();
          int id = result.getInt(1);           
          prepStatement.close();
          result.close();
          return id;                           
	  }
	  
	  /**
	   * Save the experience to Experience table
	   * 
	   * @param pop_expid
	   * @param pop_events
	   * @param pop_cookie
	   * @param pop_delay
	   * @throws SQLException
	   * @author Gurujegan
	   * 
	   */
	  public void savePopupDetails(int pop_expid, String pop_events, String pop_cookie, String pop_delay) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.popup (experience_id,events,cookie,delay) values (?,?,?,?)");
          prepStatement.setInt(1, pop_expid);
          prepStatement.setString(2, pop_events);
          prepStatement.setString(3, pop_cookie);          
          prepStatement.setString(4, pop_delay);
         //prepStatement.setDate(5, new java.sql.Date(new SimpleDateFormat("MM/dd/yyyy").parse(dateOfBirth.substring(0, 10)).getTime()));	
          System.out.println(Database.getTimestamp()+" @ExperienceRepositoryPopUp.save>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();
	  }
	  	  
	  /**
	   * Update experience table single column data
	   * 
	   * @param id
	   * @param columnType Pass columnType = 0 for int value
	   * @param colunmName
	   * @param value
	   * @throws SQLException
	   */
	  public void update (int id, int columnType, String colunmName, String value) throws SQLException {
		  String updateSql = "update experience set "+colunmName+" = ";
		  if (columnType == 0) {
			  updateSql+= value+", where id = "+id;
		  } else
			  updateSql+= "'"+value+"' where id = "+id;			  
    	  PreparedStatement prepStatement = dbConnection.prepareStatement(updateSql); 
    	  System.out.println(Database.getTimestamp()+" @ExperienceRepository.update>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();          
	  }
	  
	  /**
	   * Save a Image experience detail to the Image table
	   * 
	   * @param experience_id
	   * @param segment_id
	   * @param url
	   * @throws SQLException
	   */
	  public void saveImage(int experience_id, int segment_id, String url) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.image (experience_id, segment_id, url, create_time) values (?,?,?,now())");                    
          prepStatement.setInt(1, experience_id);
          prepStatement.setInt(2, segment_id);
          prepStatement.setString(3, url);
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.saveImage>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();          
	  }	
	  
	  
	  public void saveredirect(int experience_id, String url ,int segment_id , String allsubpage ,String popuptext , String popuptime, String username, String usernam) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.redirect (experience_id,redirect_url,segment_id,allsubpage,popup,popuptime,create_by,mod_by,create_time,mod_time) values (?,?,?,?,?,?,?,?,now(),now())");                    
          prepStatement.setInt(1, experience_id);
          prepStatement.setString(2, url);
          prepStatement.setInt(3, segment_id); 
          prepStatement.setString(4, allsubpage);
          prepStatement.setString(5, popuptext);
          prepStatement.setString(6, popuptime); 
          prepStatement.setString(7, username);
          prepStatement.setString(8, usernam);
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.saveImage>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();          
	  }	  
	  
	  /**
	   * Save a Content experience detail to the Content table
	   * 
	   * @param experience_id
	   * @param segment_id
	   * @param content
	   * @throws SQLException
	   */
	  public void saveContent(int experience_id, int segment_id, String content) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.content (experience_id, segment_id, content, create_time) values (?,?,?,now())");                    
          prepStatement.setInt(1, experience_id);
          prepStatement.setInt(2, segment_id);
          prepStatement.setString(3, content);   
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.saveContent>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();          
	  }
	  
	  /**
	   * Save a Link experience detail to the Link table
	   * 
	   * @param experience_id
	   * @param segment_id
	   * @param content
	   * @param text
	   * @param targeturl
	   * @param imageurl
	   * @throws SQLException
	   */
	  public void saveLink(String linktype,String text,String targeturl,String imgurl) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("insert into georeachdb.link (type,text,targeturl,imageurl) values (?,?,?,?)");                    
          prepStatement.setString(1,linktype);
          prepStatement.setString(2, text);
          prepStatement.setString(3, targeturl);
          prepStatement.setString(4, imgurl);
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.saveLink>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();
          
          
          
	  }
	  
	  
	  /**
	   * Check weather an experience exists
	   * 
	   * @param id
	   * @return boolean 
	   */
	  public boolean exists(int id) throws SQLException {		  	     
		  PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from experience where id = ?");
          prepStatement.setInt(1, id);  
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.exists>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                      return true;
                  }               
              }
          }      
    	  prepStatement.close();
          result.close();	      	      
	      return false;
	  }	
	  
	  /**
	   * Checks if an Experience name already exists for an organization
	   * 
	   * @param name
	   * @param org_id
	   * @return boolean
	   */
	  public boolean nameExists(String name, int org_id) throws SQLException {
          PreparedStatement prepStatement = dbConnection.prepareStatement("select count(*) from experience where name = ? and org_id = ?");
          prepStatement.setString(1, name);
          prepStatement.setInt(2, org_id); 
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.nameExists>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();
          if (result != null) {   
              while (result.next()) {
                  if (result.getInt(1) == 1) {
                      return true;
                  }               
              }
          }	      
          prepStatement.close();
          result.close();	    
	      return false;
	  }
	  
	  public List<String> experienceName(String id) {
	    	
			String query = "SELECT exp.name FROM georeachdb.content seg, georeachdb.experience exp where seg.segment_id = ? and exp.id = seg.experience_id";
				List<String> returnlist = new ArrayList<String>();
			try {
				Connection  dbConnection = Database.getConnection();
				PreparedStatement prepStatement = dbConnection.prepareStatement(query);
				prepStatement.setString(1, id); 
		        ResultSet result = prepStatement.executeQuery();            
		        if (result != null) {   
		              while (result.next()) {
		            	  returnlist.add(result.getString("name"));         
		              }   
		          }      
		          
		        prepStatement.close();
		        result.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return returnlist;
			
		}
	  
	  public void deleteContent(int experience_id) throws SQLException {	      	         
    	  PreparedStatement prepStatement = dbConnection.prepareStatement("delete from georeachdb.content where experience_id =?");                    
          prepStatement.setInt(1, experience_id);   
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.saveContent>prepStatement: "+prepStatement.toString());
          prepStatement.executeUpdate();
          prepStatement.close();          
	  }
	  	    	  	  	  
	  /**
	   * Get a single Experience Object. To be called after checking experience exists by id
	   * 
	   * @param id
	   * @return Experience object
	   */
	  public Experience get(int id) throws SQLException {	
		  Experience experience = new Experience(id);
          PreparedStatement prepStatement = dbConnection.prepareStatement("select * from experience where id = ?");
          prepStatement.setInt(1, id);  
          System.out.println(Database.getTimestamp()+" @ExperienceRepository.get>prepStatement: "+prepStatement.toString());
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
          prepStatement.close();
          result.close();
          return experience;		   	     
	  }
	  
	  /**
	   * Gets all experiences configured for an organization
	   * 
	   * @param org_id
	   * @return Map containing Experience objects
	   */
	  public Map<Integer, Experience> getOrgExperiences(int org_id) throws SQLException {
		  Map<Integer,Experience> orgExp = new HashMap<Integer,Experience>();
		  orgExp.putAll(getOrgImageExperiences(org_id));
		  orgExp.putAll(getOrgContentExperiences(org_id));
		  return orgExp;
	  }
	  
	  /**
	   * Gets all image experiences configured for an organization
	   * 
	   * @param org_id
	   * @return Map containing Image Experience objects
	   */
	  public Map<Integer,Experience> getOrgImageExperiences (int org_id) throws SQLException {
		  Map<Integer,Experience> orgImageExp = new HashMap<Integer,Experience>();		  
		  String query = "select experience.id as id, experience.name as name, experience.type as type, experience.status as status, "
		  		+ "experience.schedule_start as schedule_start, experience.schedule_end as schedule_end, experience.user_id as user_id, experience.create_time as create_time, "
		  		+ "segment.name as segmentname, image.id as image_id, image.url as url "
		  		+ "from "
		  		+ "experience, segment, image "
		  		+ "where "		  		
		  		+ "experience.id = image.experience_id and "
		  		+ "image.segment_id = segment.id and "
		  		+ "experience.org_id = ? "
		  		+ "order by create_time desc";
		  //System.out.println(Database.getTimestamp()+" @ExperienceRepository.getOrgImageExperiences>query: "+query);//TODO: ORDER_BY DESC IS NOT WORKING.
		  PreparedStatement prepStatement = dbConnection.prepareStatement(query);
		  prepStatement.setInt(1, org_id);   
		  System.out.println(Database.getTimestamp()+" @ExperienceRepository.getOrgImageExperiences>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();                            
          if (result != null) {        	  
              while (result.next()) {	            	              	  
            	  //Construct the Experience object with Map of Image objects
            	  int experience_id = result.getInt("id");
            	  if (orgImageExp.containsKey(experience_id)) {
            		  //Add Image object to Experience object from the HashMap            		  
            		  int image_id = result.getInt("image_id");
                	  Image image = new Image(image_id);
                	  image.setUrl(result.getString("url"));
                	  image.setSegmentName(result.getString("segmentname"));
                	  orgImageExp.get(experience_id).addImage(image_id, image);                	  
            	  } else {
            		  //Create new Experience Object;
            		  Experience experience = new Experience(experience_id);
            		  experience.setName(result.getString("name"));            	  
                	  experience.setType(result.getString("type"));            	  
                	  experience.setStatus(result.getString("status"));            	  
                	  experience.setSchedule_start(result.getString("schedule_start"));            	  
                	  experience.setSchedule_end(result.getString("schedule_end"));            	                  	  	 
                	  experience.setUser_id(result.getInt("user_id"));            	  
                	  experience.setCreate_time(result.getString("create_time"));
                	  int image_id = result.getInt("image_id");
                	  Image image = new Image(image_id);
                	  image.setUrl(result.getString("url"));
                	  image.setSegmentName(result.getString("segmentname"));
                	  experience.addImage(image_id, image);                	  
            		  orgImageExp.put(experience_id, experience);
            	  }
              }               
          }		  		 
          prepStatement.close();
          result.close();
          return orgImageExp;
	  }
	  
	  /**
	   * Gets all content experiences configured for an organization
	   * 
	   * @param org_id
	   * @return Map containing Content Experience objects
	   */
	  public Map<Integer,Experience> getOrgContentExperiences (int org_id) throws SQLException {
		  Map<Integer,Experience> orgContentExp = new HashMap<Integer,Experience>();		  
		  String query = "select experience.id as id, experience.name as name, experience.type as type, experience.status as status, "
		  		+ "experience.schedule_start as schedule_start, experience.schedule_end as schedule_end, experience.user_id as user_id, experience.create_time as create_time, "
		  		+ "segment.name as segmentname, content.id as content_id, content.content as content "
		  		+ "from "
		  		+ "experience, segment, content "
		  		+ "where "		  		
		  		+ "experience.id = content.experience_id and "
		  		+ "content.segment_id = segment.id and "
		  		+ "experience.org_id = ? "
		  		+ "order by create_time desc";
		  //System.out.println(Database.getTimestamp()+" @ExperienceRepository.getOrgContentExperiences>query: "+query);//TODO: ORDER_BY DESC IS NOT WORKING.
		  PreparedStatement prepStatement = dbConnection.prepareStatement(query);
		  prepStatement.setInt(1, org_id);                     
		  System.out.println(Database.getTimestamp()+" @ExperienceRepository.getOrgContentExperiences>prepStatement: "+prepStatement.toString());
          ResultSet result = prepStatement.executeQuery();                           
          if (result != null) {        	  
              while (result.next()) {	            	              	  
            	  //Construct the Experience object with Map of Image objects
            	  int experience_id = result.getInt("id");
            	  if (orgContentExp.containsKey(experience_id)) {
            		  //Add Content object to Experience object from the HashMap            		  
            		  int content_id = result.getInt("content_id");
                	  Content content = new Content(content_id);
                	  content.setContent(result.getString("content"));
                	  content.setSegmentName(result.getString("segmentname"));
                	  orgContentExp.get(experience_id).addContent(content_id, content);                	  
            	  } else {
            		  //Create new Experience Object;
            		  Experience experience = new Experience(experience_id);
            		  experience.setName(result.getString("name"));            	  
                	  experience.setType(result.getString("type"));            	  
                	  experience.setStatus(result.getString("status"));            	  
                	  experience.setSchedule_start(result.getString("schedule_start"));            	  
                	  experience.setSchedule_end(result.getString("schedule_end"));            	                  	  	 
                	  experience.setUser_id(result.getInt("user_id"));            	  
                	  experience.setCreate_time(result.getString("create_time"));
                	  int content_id = result.getInt("content_id");
                	  Content content = new Content(content_id);
                	  content.setContent(result.getString("content"));
                	  content.setSegmentName(result.getString("segmentname"));
                	  experience.addContent(content_id, content);                	  
                	  orgContentExp.put(experience_id, experience);
            	  }
              }               
          }		  		 
          prepStatement.close();
          result.close();
          return orgContentExp;
	  }
	  	  	 	  	 
	  /**
	   * Close the database connection used by this Experience Repository instance. Usually you dont have to close the connection.
	   * 
	   */
	  public void close() {
		  //System.out.println(Database.getTimestamp()+" @ExperienceRepository.close>Closing Database Connection");
		  //Database.closeConnection();
	  }
	  
	  /**
	   * Object destroyer to free up database connection. To be called by Garbage Collector
	   * 
	   */
	  public void finalize() {
		  //System.out.println(Database.getTimestamp()+" @ExperienceRepository.finalize>Closing Database Connection");
		  //Database.closeConnection();
	  }
}
