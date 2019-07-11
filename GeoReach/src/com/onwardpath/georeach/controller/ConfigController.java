package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import java.io.IOException;
import com.onwardpath.georeach.repository.ConfigRepository;
import com.onwardpath.georeach.util.Database;

@SuppressWarnings("serial")
public class ConfigController extends HttpServlet {
		private ConfigRepository configRepository;	
		 			
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
			RequestDispatcher view = request.getRequestDispatcher(pageName);
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
	  	  	if (configRepository != null) {
	  	  		if (pageName.equals("create-experience")) {		        	  	        	 
	  	  			try {
	  	  				String name = request.getParameter("name");	 
		  	  			String url = request.getParameter("url");
			            int experience_id = Integer.parseInt(request.getParameter("experience_id"));		              
			            System.out.println("url: "+url);
			            System.out.println("experience_id: "+experience_id);			            	              	             		              		              		              		              		           		              		             
			            configRepository.save(experience_id, url, user_id);
			            session.setAttribute("message", "Info: Cofiguration for <b>"+url+"</b> Saved.");
	        	  } catch (SQLException e) {
	        		  session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");	                  
	        	  }        	                	             	              	              	              	           	             	              	              	   	                         
	          }	          
	      }
	      RequestDispatcher view = request.getRequestDispatcher(pageName);
	      view.forward(request, response);
	  }	  	 
}
