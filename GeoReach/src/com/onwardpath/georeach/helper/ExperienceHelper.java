package com.onwardpath.georeach.helper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



import com.onwardpath.georeach.model.ExperienceContent;
import com.onwardpath.georeach.util.Database;

public class ExperienceHelper {
	
private Connection dbConnection;
	
	public ExperienceHelper() {
		dbConnection = Database.getConnection();
	}
	
	public  String getexperienceName(String id){
		String name =null;
		try {
		PreparedStatement prepStatement = dbConnection.prepareStatement("select name from experience where id = ?");
		prepStatement.setString(1, id);
		ResultSet result = prepStatement.executeQuery();          
        result.next();
         name = result.getString(1);           
        prepStatement.close();
        result.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return name;	
	}
	
	public List<ExperienceContent> experienceContent(String id) {
	
		StringBuffer sb = new StringBuffer();
		sb.append("select datatable.id") .append(" id,")
		 .append("datatable.url").append(" content,")
		  .append("''  segmentname, exp.name experience_name")
		  .append(" from config datatable,experience exp")
		  .append(" where datatable.experience_id = exp.id and exp.id=?")
		  .append(" union all")
		  .append(" select datatable.segment_id").append(" id,")
		  .append("datatable.content").append(" content,")
		  .append("seg.name  segmentname, exp.name experience_name")
		  .append(" from content datatable ,experience exp,segment seg")
		  .append(" where datatable.experience_id = exp.id and seg.id=datatable.segment_id and exp.id=?");
			List<ExperienceContent> returnlist = new ArrayList<ExperienceContent>();
		try {
			PreparedStatement prepStatement = dbConnection.prepareStatement(sb.toString());
			prepStatement.setString(1, id);
	        prepStatement.setString(2, id);
	        ResultSet result = prepStatement.executeQuery();          
	        System.out.println("Row count  " +result.getRow() );    
	        if (result != null) {   
	              while (result.next()) {
	            	  ExperienceContent content = new ExperienceContent();
	            	  //content.setContent(result.getString("content"));
	            	  String contents = result.getString("content");
                      if (contents!=null){
                        contents = contents.replace("'", "\\'");
                      }                        
                      content.setContent(contents);
	            	  content.setId(result.getInt("id"));
	            	  content.setExperienceName(result.getString("experience_name"));
	            	  content.setSegmentName(result.getString("segmentname"));
	            	  returnlist.add(content);         
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
	
	
	public List<ExperienceContent> scheduleDate(String id) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT status,schedule_start,schedule_end,timezone_id")
		   .append(" from experience where id =?");
		  List<ExperienceContent> returnlist = new ArrayList<ExperienceContent>();
		try {
			PreparedStatement prepStatement = dbConnection.prepareStatement(sb.toString());
			prepStatement.setString(1, id);
	        ResultSet result = prepStatement.executeQuery();          
	        System.out.println("Row count  " +result.getRow() );    
	        if (result != null) {   
	              while (result.next()) {
	            	  ExperienceContent content = new ExperienceContent();
	            	  //content.setContent(result.getString("content"));
	            	  content.setStatus(result.getString("status"));
	            	  content.setStartDate(result.getString("schedule_start"));
	            	  content.setEndDate(result.getString("schedule_end"));
	            	  content.setTimeZonevalue(result.getString("timezone_id"));
	            	  returnlist.add(content);         
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
	
public List<ExperienceContent> experienceImage(String id) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("select datatable.id") .append(" id,")
		 .append("datatable.url").append(" content,")
		  .append("''  segmentname, exp.name experience_name")
		  .append(" from config datatable,experience exp")
		  .append(" where datatable.experience_id = exp.id and exp.id=?")
		  .append(" union all")
		  .append(" select datatable.segment_id").append(" id,")
		  .append("datatable.url").append(" url,")
		  .append("seg.name  segmentname, exp.name experience_name")
		  .append(" from image datatable ,experience exp,segment seg")
		  .append(" where datatable.experience_id = exp.id and seg.id=datatable.segment_id and exp.id=?");
			List<ExperienceContent> returnlist = new ArrayList<ExperienceContent>();
		try {
			PreparedStatement prepStatement = dbConnection.prepareStatement(sb.toString());
			prepStatement.setString(1, id);
	        prepStatement.setString(2, id);
	        ResultSet result = prepStatement.executeQuery();          
	        System.out.println("Row count  " +result.getRow() );    
	        if (result != null) {   
	              while (result.next()) {
	            	  ExperienceContent content = new ExperienceContent();
	            	  //content.setContent(result.getString("content"));
	            	  String contents = result.getString("content");
                      if (contents!=null){
                        contents = contents.replace("'", "\\'");
                      }                        
                      content.setContent(contents);
	            	  content.setId(result.getInt("id"));
	            	  content.setExperienceName(result.getString("experience_name"));
	            	  content.setSegmentName(result.getString("segmentname"));
	            	  returnlist.add(content);         
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
	
	
public List<ExperienceContent> experiencestyle(String id) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("select datatable.id") .append(" id,")
		 .append("datatable.url").append(" content,")
		  .append("''  segmentname, exp.name experience_name,")
		  .append("'' allsubpagevalue")
		  .append(" from config datatable,experience exp")
		  .append(" where datatable.experience_id = exp.id and exp.id=?")
		  .append(" union all")
		  .append(" select datatable.segment_id").append(" id,")
		  .append("datatable.csslink").append(" csslink,")
		  .append("seg.name  segmentname,exp.name experience_name,datatable.allsubpage allsubpagevalue")
		  .append(" from style datatable ,experience exp,segment seg")
		  .append(" where datatable.experience_id = exp.id and seg.id=datatable.segment_id and exp.id=?");
			List<ExperienceContent> returnlist = new ArrayList<ExperienceContent>();
		try {
			System.out.println("Hello" + sb.toString());
			PreparedStatement prepStatement = dbConnection.prepareStatement(sb.toString());
			prepStatement.setString(1, id);
	        prepStatement.setString(2, id);
	          
	        ResultSet result = prepStatement.executeQuery();          
	        System.out.println("Row count  " +result.getRow() );    
	        if (result != null) {   
	              while (result.next()) {
	            	  ExperienceContent content = new ExperienceContent();
	            	  //content.setContent(result.getString("content"));
	            	  String contents = result.getString("content");
                      if (contents!=null){
                        contents = contents.replace("'", "\\'");
                      }                        
                      content.setContent(contents);
                      content.setCheckboxvalue(result.getString("allsubpagevalue"));
	            	  content.setId(result.getInt("id"));
	            	  content.setExperienceName(result.getString("experience_name"));
	            	  content.setSegmentName(result.getString("segmentname"));
	            	  returnlist.add(content);         
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


public List<ExperienceContent> experienceredirect(String id) {
	
	StringBuffer sb = new StringBuffer();
	sb.append("select datatable.id") .append(" id,")
	 .append("datatable.url").append(" content,")
	  .append("''  segmentname, exp.name experience_name,")
	  .append("'' allsubpagevalue,'' popuptext,'' popuptimes")
	  .append(" from config datatable,experience exp")
	  .append(" where datatable.experience_id = exp.id and exp.id=?")
	  .append(" union all")
	  .append(" select datatable.segment_id").append(" id,")
	  .append("datatable.redirect_url").append(" redirect_url,")
	  .append("seg.name  segmentname,exp.name experience_name,datatable.allsubpage allsubpagevalue,datatable.popup popuptext, datatable.popuptime popuptimes")
	  .append(" from redirect datatable ,experience exp,segment seg")
	  .append(" where datatable.experience_id = exp.id and seg.id=datatable.segment_id and exp.id=?");
		List<ExperienceContent> returnlist = new ArrayList<ExperienceContent>();
	try {
		System.out.println("Hello" + sb.toString());
		PreparedStatement prepStatement = dbConnection.prepareStatement(sb.toString());
		prepStatement.setString(1, id);
        prepStatement.setString(2, id);
          
        ResultSet result = prepStatement.executeQuery();          
        System.out.println("Row count  " +result.getRow() );    
        if (result != null) {   
              while (result.next()) {
            	  ExperienceContent content = new ExperienceContent();
            	  //content.setContent(result.getString("content"));
            	  String contents = result.getString("content");
                  if (contents!=null){
                    contents = contents.replace("'", "\\'");
                  }                        
                  content.setContent(contents);
                  content.setCheckboxvalue(result.getString("allsubpagevalue"));
                  content.setPopupText(result.getString("popuptext"));
                  content.setPopupTime(result.getString("popuptimes"));
            	  content.setId(result.getInt("id"));
            	  content.setExperienceName(result.getString("experience_name"));
            	  content.setSegmentName(result.getString("segmentname"));
            	  returnlist.add(content);         
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
	public static void main (String [] a) {
		ExperienceHelper expHelper = new ExperienceHelper();
		List Test = expHelper.scheduleDate("495");
		System.out.println("size : " + Test); 
	}
}
