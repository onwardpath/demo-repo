package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.MDC;

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
import org.apache.log4j.MDC;

@SuppressWarnings("serial")
public class ConfigController extends HttpServlet {
		private ConfigRepository configRepository;
		private ExperienceRepository expController;
		 			
		/**
		 * @see HttpServlet#HttpServlet()
		 */
		public ConfigController() {
			super();	      	     
		}

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String pageName = request.getParameter("pageName");			
			RequestDispatcher view = request.getRequestDispatcher("?view=pages/"+pageName);
			view.forward(request, response);
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
			configRepository = new ConfigRepository();		  
			String pageName = request.getParameter("pageName");
			System.out.println(Database.getTimestamp()+" @ConfigController.doPost>pageName: "+pageName);			        	     
	  	  	HttpSession session = request.getSession();
	  	  	int org_id = (Integer)session.getAttribute("org_id");
	  	  	int user_id = (Integer)session.getAttribute("user_id");
	  	  User user = (User) session.getAttribute("user");
	  	  String orgname = user.getOrganization_domain();
    	  MDC.put("user", user_id);
    	  MDC.put("org", orgname);
	  	  	if (configRepository != null) {
	  	  		if (pageName.startsWith("experience-create-enable")) {		        	  	        	 
	  	  			try {	  	  				
			            int experience_id = Integer.parseInt(request.getParameter("experience_id"));
			            String experience_name = request.getParameter("experience_name");
			            String configDetails = request.getParameter("urlList");	            		
			            
			            ObjectMapper mapper = new ObjectMapper();	            		  
			            @SuppressWarnings("unchecked")
						Map<String, String> map = mapper.readValue(configDetails, Map.class);
			            System.out.println(map);	            		  
			            for (Map.Entry<String, String> entry : map.entrySet()) {	            			  
			            	int index = Integer.parseInt(entry.getKey());
			            	String url = entry.getValue();
			            	System.out.println("index = " + index + ", URL = " + url);
			            	configRepository.save(experience_id, url, user_id);	            			  	            			 
			            }
			            /* Update Schedule startdate and endate for experience table */
			            //System.out.println("Startdate in config controler ::"+request.getParameter("startdate"));
			            expController = new ExperienceRepository();
			            if(request.getParameter("status")!=null && request.getParameter("status") !="") {
			            	expController.update(experience_id, 3, "status",request.getParameter("status"));
			            	if(request.getParameter("startdate") != null && request.getParameter("startdate") !="") {
			            		expController.update(experience_id, 4, "schedule_start",request.getParameter("startdate"));	
			            	}
			            	if(request.getParameter("enddate") != null && request.getParameter("enddate") !="") {
			            		expController.update(experience_id, 5, "schedule_end",request.getParameter("enddate"));	
			            	}
			            	if(request.getParameter("timezoneval") != null && request.getParameter("timezoneval") !="") {
			            		expController.update(experience_id, 6, "timezone_id",request.getParameter("timezoneval"));	
			            	}
			            }
			     
			            System.out.println(Database.getTimestamp()+"Page configuration for <b>"+experience_name+"</b> saved succesfully.#n="+experience_name+"#e="+experience_id+"#o="+org_id);
			            
			            session.setAttribute("message", "Page configuration for <b>"+experience_name+"</b> saved succesfully.#n="+experience_name+"#e="+experience_id+"#o="+org_id);
	        	  } catch (SQLException e) {
	        		  session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");	                  
	        	  }        	                	             	              	              	              	           	             	              	              	   	                         
	          }	          
	      }
	      RequestDispatcher view = request.getRequestDispatcher("?view=pages/"+pageName);
	      view.forward(request, response);
	  }	  	 
}
