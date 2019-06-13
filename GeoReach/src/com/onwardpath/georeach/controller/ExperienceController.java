package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import java.io.IOException;

import com.onwardpath.georeach.repository.ExperienceRepository;

@SuppressWarnings("serial")
public class ExperienceController extends HttpServlet {
	private ExperienceRepository experienceRepository;
		 
	private static String SAVE_SUCCESS = "experience-wiz2.jsp";
	private static String SAVE_FAILURE = "experience-wiz1.jsp";

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
	          if (pageName.equals("create-wizard1")) {	      	        	 
	        	  String name = request.getParameter("name");	        	  	        	  	        	 
	              if (experienceRepository.nameExists(name, org_id)) {	                  
	                  session.setAttribute("message", "Experience Name exists. Try another name.");
	                  forward = SAVE_FAILURE;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }	              	             	              	              	              	           	             
	              	              	   
	              try {
	            	  
	            	  /**

	            	  EXPERIENCE
	            		--id
	            		name
	            		type
	            		-status
	            		schedule_start
	            		schedule_end
	            		-header_code
	            		-body_code
	            		org_id
	            		user_id
	            		--create_time
	            		
	            		IMAGE
	            		--id
	            		experience_id
	            		segment_id
	            		url
	            		--create_time 	            	
	            	   */
	            	  	            	  	            	   	            	
	            	  //1. Save to Experience table, get the id
	            	  // name, type, org_id, user_id, create_time
	            	  int experience_id = experienceRepository.save(name, request.getParameter("type"), request.getParameter("status"), null, null, null, null, org_id, user_id);
	            	  
	            	  //2. Save multiple entries to Image table
	            	  // experience_id, segment_id, url, create_time
	            	  // (there will be multiple segment_id --> url)
	            	  
	            	  //3. Generate header_code & body_code and save to Experience table
	            	  //4. Save schedule_start, schedule_start & status
	            	  	            	  
		              session.setAttribute("message", "Experience "+name+" Saved.");	              
		              forward = SAVE_SUCCESS;
	              } catch (SQLException e) {
	            	  session.setAttribute("message", e.getMessage()+" Please try later or contact the administrator.");
	                  forward = SAVE_FAILURE;
	              }	              
	          } else if (pageName.equals("create-wizard2")) {	        	  
	        	  String schedule_start = request.getParameter("schedule_start");
	        	  String schedule_end = request.getParameter("schedule_end");
	        	  String header_code = request.getParameter("header_code");
	        	  String body_code = request.getParameter("body_code");
	        	  if (schedule_start.equals("")) schedule_start = null;	        	  
	        	  if (schedule_end.equals("")) schedule_end = null;	        	  
	        	  if (header_code.equals("")) header_code = null;	        	  
	        	  if (body_code.equals("")) body_code = null;
	          }
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
}
