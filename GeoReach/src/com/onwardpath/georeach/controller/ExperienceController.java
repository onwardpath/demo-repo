package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;
import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.onwardpath.georeach.repository.ExperienceRepository;

@SuppressWarnings("serial")
public class ExperienceController extends HttpServlet {
	private ExperienceRepository experienceRepository;	
		 
	private static String SAVE_SUCCESS = "?view=pages/experience-create.jsp";
	private static String SAVE_FAILURE = "?view=pages/experience-create.jsp";
		
	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public ExperienceController() {
	      super();
	      experienceRepository = new ExperienceRepository();	      
	  }

	  /**
	   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
	      String forward = SAVE_SUCCESS;
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }

	  /**
	   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String pageName = request.getParameter("pageName");
	      String forward = "";        
	      
	  	  HttpSession session = request.getSession();
	      int org_id = (Integer)session.getAttribute("org_id");
    	  int user_id = (Integer)session.getAttribute("user_id");
    	  
	      if (experienceRepository != null) {
	          if (pageName.equals("create-experience")) {	      	        	 
	        	  String name = request.getParameter("name");	        	  	        	  	        	 
	              if (experienceRepository.nameExists(name, org_id)) {	                  
	                  session.setAttribute("message", "Experience Name exists. Try another name.");
	                  forward = SAVE_FAILURE;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }	              	             	              	              	              	           	             
	              	              	   
	              try {	            	  	            	  	            	  	            	  	            	   	         
	            	  //1. Save to Experience table, get the id (name, type, org_id, user_id, create_time)
	            	  String type = request.getParameter("type");
	            	  int experience_id = experienceRepository.save(name, type, "off", request.getParameter("schedule_start"), request.getParameter("schedule_end"), 
	            			  request.getParameter("header_code"), request.getParameter("body_code"), org_id, user_id);
	            	  
	            	  //2. Save multiple entries to Image table (experience_id, segment_id, url, create_time)
	            	  if (type.contentEquals("image")) {
	            		  
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
	            	  } else if (type.equals("content")) {
		            	  //TODO: NEED TO RECEIVE AND STORE MULTIPLE CONTENTE EXPERIENCE
	            		  //experienceRepository.saveContent(experience_id, Integer.parseInt(request.getParameter("segment_id")),request.getParameter("content"));
	            	  }
	            	  	            	  
	            	  //3. Generate header_code & body_code and save to Experience table
	            	  String header_code = "<javascript></javascript>";
	            	  String body_code = "<div id=''></div>";	            	  
	            	  experienceRepository.update(experience_id, 1, "header_code", header_code);
	            	  experienceRepository.update(experience_id, 1, "body_code", body_code);
	            	  
	            	  //4. Save schedule_start, schedule_start & status
	              	  //TODO: Save schedule
	            	  	            	  			              	            	  
		              //session.setAttribute("message", "Experience <b>"+name+"</b> saved. <a href=\"#\" onClick=\"MyWindow=window.open('viewcode.jsp?n="+name+"&e="+experience_id+"&o="+org_id+"','MyWindow',width=600,height=300); return false;\">View Code</a>");
		              session.setAttribute("message", "Experience <b>"+name+"</b> saved.#n="+name+"#e="+experience_id+"#o="+org_id); 
		              forward = SAVE_SUCCESS;
	              } catch (SQLException e) {
	            	  session.setAttribute("message", e.getMessage()+". Please try later or contact the administrator.");
	                  forward = SAVE_FAILURE;
	              }	              
	          } 
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
}
