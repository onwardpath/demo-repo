package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import java.util.Map;
import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.georeach.model.User;
import com.onwardpath.georeach.repository.ConfigRepository;
import com.onwardpath.georeach.repository.ExperienceRepository;
import com.onwardpath.georeach.util.Database;

import org.apache.log4j.Logger;
import org.apache.log4j.MDC;

@SuppressWarnings("serial")
public class ExperienceController extends HttpServlet {
	private ExperienceRepository experienceRepository;	
		 
	private static String SAVE_SUCCESS = "?view=pages/experience-create-enable.jsp";
	private static String SAVE_FAILURE = "?view=pages/experience-create-content.jsp";		
	final static Logger logger =  Logger.getLogger(ExperienceController.class);		
	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public ExperienceController() {
	      super();	      	     
	  }

	  /**
	   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
	      String forward = SAVE_SUCCESS;
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
	  
	  private void addContent(int experience_id,HttpServletRequest request) throws IOException, SQLException {
		  String experienceDetails = request.getParameter("experienceDetails");	
		  ObjectMapper mapper = new ObjectMapper();	            		  
   		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
   		  System.out.println(map);	            		  
   		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
   			  int segment_id = Integer.parseInt(entry.getKey());
   			  String content = entry.getValue();
   			  experienceRepository.saveContent(experience_id, segment_id, content);	
   		  }	
	  }
	   
	  private void updateconfig(int experience_id,HttpServletRequest request,int user_id) throws IOException, SQLException {
	  //String experience_name = request.getParameter("experience_name");
      String configDetails = request.getParameter("urlList");	            		
      ConfigRepository configRepository = new ConfigRepository();
	 configRepository.delete(experience_id);
		
      ObjectMapper mapper = new ObjectMapper();	            		  
      @SuppressWarnings("unchecked")
		Map<String, String> map = mapper.readValue(configDetails, Map.class);
      System.out.println(map);	            		  
      for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
      	String url = entry.getValue();
      	configRepository.save(experience_id, url, user_id);	            			  	            			 
      }	
      
	  }

	  /**
	   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
		  experienceRepository = new ExperienceRepository();
		  
	      String pageName = request.getParameter("pageName");
	      System.out.println(Database.getTimestamp()+" @ExperienceController.doPost>pageName: "+pageName);
	      String forward = "";        	      
	  	  HttpSession session = request.getSession();
	      int org_id = (Integer)session.getAttribute("org_id");
    	  int user_id = (Integer)session.getAttribute("user_id");
    	  User user = (User) session.getAttribute("user");
    	  String username = user.getFirstname() + " " + user.getLastname();
    	  String orgname = user.getOrganization_domain();
    	  MDC.put("user", user_id);
    	  MDC.put("org", orgname);
	      if (experienceRepository != null) {
	          if (pageName.equals("create-experience")) {		        	  	        	 
	        	  try {
	        		  String name = request.getParameter("name");	        	  	        	  	        	 
		              if (experienceRepository.nameExists(name, org_id)) {	                  
		                  session.setAttribute("message", "Error: Experience with name <b>"+name+"</b> already exist. Try another name.");
		                  forward = SAVE_FAILURE;
		                  RequestDispatcher view = request .getRequestDispatcher(forward);
		                  view.forward(request, response);
		                  return;
		              }	
		              
		              //1. Save to Experience table, get the id (name, type, org_id, user_id, create_time)
	            	  String type = request.getParameter("type");
	            	  
	            	  int experience_id = experienceRepository.save(name, type, "on", request.getParameter("schedule_start"), request.getParameter("schedule_end"), 
	            			  											request.getParameter("header_code"), request.getParameter("body_code"), org_id, user_id);
	            	  
	            	  
	            	  
	            	  //2. Save multiple entries to Image/Content table (experience_id, segment_id, url/content, create_time)
	            	  if (type.contentEquals("redirect")) {	
	            		  String allsubpage = request.getParameter("subpage");
	            		  String popevents = request.getParameter("subpagepopup");
	            		  String popuptime = request.getParameter("popuptime");
	            		  
						  String experienceDetails = request.getParameter("experienceDetails");
						  ObjectMapper mapper = new ObjectMapper(); 
						  Map<String, String> map = mapper.readValue(experienceDetails, Map.class); 
						  System.out.println(map); 
						  for(Map.Entry<String, String> entry : map.entrySet()) { 
							  int segment_id = Integer.parseInt(entry.getKey()); 
							  String url = entry.getValue();
						 System.out.println("Segment ID = " + segment_id + ", URL = " + url.substring(1, 2));
						 experienceRepository.saveredirect(experience_id,url,segment_id,allsubpage,popevents,popuptime,username,username); 
						 logger.info("Save Sucesss");
						 }  
						  SAVE_FAILURE = "?view=pages/experience-create-image.jsp";
						           
	            	  }  
	            	   
	            	  else if (type.contentEquals("image")) {	            		  
	            		  String experienceDetails = request.getParameter("experienceDetails");	            		  	            		 
	            		  ObjectMapper mapper = new ObjectMapper();	            		  
	            		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
	            		  System.out.println(map);	            		  
	            		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
	            			  int segment_id = Integer.parseInt(entry.getKey());
	            			  String url = entry.getValue();
	            			  System.out.println("Segment ID = " + segment_id + ", URL = " + url);
	            			  experienceRepository.saveImage(experience_id, segment_id, url);	            			  	            			 
	            		  }		            		  
	            		  SAVE_FAILURE = "?view=pages/experience-create-image.jsp";
	            	  } else if (type.equals("content") || type.equals("link")) {	            	  	            		 
	            		  String experienceDetails = request.getParameter("experienceDetails");	            		  	            		 
	            		  ObjectMapper mapper = new ObjectMapper();	            		  
	            		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
	            		  System.out.println(map);	            		  
	            		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
	            			  int segment_id = Integer.parseInt(entry.getKey());
	            			  String content = entry.getValue();
	            			  System.out.println("Segment ID = " + segment_id + ", Content = " + content);
	            			  String exactContentElem = type.equals("link")? content.split("#")[0] :content; 
	            			  experienceRepository.saveContent(experience_id, segment_id, exactContentElem);
	            			  if(type.equals("link")) {
	            				  experienceRepository.saveLink(content.split("#")[1], content.split("#")[2],content.split("#")[3],content.split("#")[4]);
	            			  }
	            		  }		            		  
	            		  SAVE_FAILURE = "?view=pages/experience-create-link.jsp";	            		  
	            	  }else if (type.equals("bar")) {
	            		  System.out.println("coming");
	            		  String experienceDetails = request.getParameter("experienceDetails");	
	            		  ObjectMapper mapper = new ObjectMapper();	            		  
	               		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
	               		  System.out.println(map);	            		  
	               		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
	               			  int segment_id = Integer.parseInt(entry.getKey());
	               			  System.out.println("map="+entry.getKey());
	               			  String content = entry.getValue();
	               			  experienceRepository.saveContent(experience_id, segment_id, content);	
	               		  }	
	               		 SAVE_FAILURE = "?view=pages/experience-create-bar.jsp";	
	            	  }else if (type.equals("popup")) {
	            		  
	            		  String pop_events = request.getParameter("page_events");
	            		  String pop_cookie = request.getParameter("popup_cookie");
	            		  String pop_delay = request.getParameter("popup_delay");
	            		  experienceRepository.savePopupDetails(experience_id, pop_events, pop_cookie, pop_delay);
	            		  
	            		  String experienceDetails = request.getParameter("experienceDetails");	            		  	            		 
	            		  ObjectMapper mapper = new ObjectMapper();	            		  
	            		  Map<String, String> map = mapper.readValue(experienceDetails, Map.class);
	            		  System.out.println(map);	            		  
	            		  for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
	            			  int segment_id = Integer.parseInt(entry.getKey());
	            			  String content = entry.getValue();
	            			  System.out.println("Segment ID = " + segment_id + ", Content = " + content);
	            			  experienceRepository.saveContent(experience_id, segment_id, content);	            			  	            			 
	            		  }		            		  
	            		  SAVE_FAILURE = "?view=pages/experience-create-popup.jsp";	            		  
	            	  }
	            	  	            	  
	            	  //3. Generate header_code & body_code and save to Experience table
	            	  String header_code = "<javascript></javascript>";
	            	  String body_code = "<div id=''></div>";	            	  
	            	  experienceRepository.update(experience_id, 1, "header_code", header_code);
	            	  experienceRepository.update(experience_id, 1, "body_code", body_code);
	            	  
	            	  //4. Save schedule_start, schedule_start & status
	              	  //TODO: Save schedule
	            	  	            	  			              	            	  		              
		              session.setAttribute("message", "Experience <b>"+name+"</b> saved. You can now configure the pages for this experience. #n="+name+"#e="+experience_id+"#o="+org_id); 
		              forward = SAVE_SUCCESS;	        		  
	        	  } catch (SQLException e) {
	        		  session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");
	                  forward = SAVE_FAILURE;
	        	  }        	                	             	              	              	              	           	             	              	              	   	                         
	          }	 
	          else if (pageName.equals("edit-experience")) {
	        	  
	        	  
		        	 try {
		        		 // update the experience name
		        		 int experience_id = Integer.parseInt(request.getParameter("expid"));
			        	 String name = request.getParameter("expName");
			        	 experienceRepository.update(experience_id, 1, "name", name);
			        	// Update  Content Table 
			        	 experienceRepository.deleteContent(experience_id);
			        	 addContent(experience_id, request);           		  	            		 
			        	// Update  config Table 
	           		  	updateconfig(experience_id, request,user_id);
			        	  
	           		 session.setAttribute("message", "Experience " +name+ " has been updated Successfully"); 
		        	  forward = "?view=pages/experience-view-content.jsp";   
					} catch (SQLException e) { 
						// TODO Auto-generated catch block
						session.setAttribute("message", "Update Fail.Please try later or contact the administrator"); 
						e.printStackTrace(); 
					}
		        	  
		        	  
		          }
	      }	      
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }	  	 
}
