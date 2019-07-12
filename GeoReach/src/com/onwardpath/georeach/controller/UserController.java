package com.onwardpath.georeach.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.SQLException;

import com.onwardpath.georeach.model.User;
import com.onwardpath.georeach.repository.UserRepository;
import com.onwardpath.georeach.util.Database;

@SuppressWarnings("serial")
public class UserController extends HttpServlet {
	private UserRepository userRepository;

	private static String USER_SIGNUP = "signup.jsp";
	private static String USER_LOGIN = "login.jsp";	  
	private static String LOGIN_SUCCESS = "index.jsp";
	private static String LOGIN_FAILURE = "login.jsp";

	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public UserController() {
	      super();	      
	  }

	  /**
	   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
	      String forward = USER_SIGNUP;
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }

	  /**
	   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  userRepository = new UserRepository();
		  
		  String pageName = request.getParameter("pageName");	      
	      System.out.println(Database.getTimestamp()+" @UserController.doPost>pageName: "+pageName);
	      String forward = "";        
	      HttpSession session = request.getSession();	      
	      if (userRepository != null) {
	    	  try {
	    		  if (pageName.equals("signup")) {
		        	  String emailName = request.getParameter("email");	        	  
		              if (userRepository.findByUserName(emailName)) {
		                  //request.setAttribute("message", "User "+emailName+" alredy exist. <a href='index.jsp'>Click here</a> to login");
		                  session.setAttribute("message", "Error. User "+emailName+" alredy exist. <a href='index.jsp'>Click here</a> to login");
		                  forward = USER_SIGNUP;
		                  RequestDispatcher view = request .getRequestDispatcher(forward);
		                  view.forward(request, response);
		                  return;
		              }	              		              		              
	            	  //Check if the domain already exist. If so, add user to existing Organization
	            	  String orgDomain = request.getParameter("domain");
	            	  if (userRepository.orgExists(orgDomain)) {
	            		  System.out.println("orgDomain already exist: "+orgDomain);
	            		  userRepository.saveUserInOrg(request.getParameter("domain"), request.getParameter("firstName"), request.getParameter("lastName"), 
	            				  request.getParameter("email"), request.getParameter("phone"), request.getParameter("password"), Integer.parseInt(request.getParameter("role")),""); 
	            		  System.out.println("New User from existing organization");
	            	  } else {
	            		  System.out.println("orgDomain is new: "+orgDomain);
	            		  //If domain does not exist, create a new Organization and add user
	            		  userRepository.saveUserandOrg(request.getParameter("orgName"), request.getParameter("domain"), request.getParameter("logoUrl"), 
			            		  request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("email"), request.getParameter("phone"), 
			            		  request.getParameter("password"), Integer.parseInt(request.getParameter("role")),"");
	            		  System.out.println("New User from new organization");
	            	  }	            	  	            	  		            
		              forward = USER_LOGIN;		              	              	             
		          } else if (pageName.equals("login")) {
		              boolean result = userRepository.findByLogin( request.getParameter("userName"), request.getParameter("password"));	               
		              if (result == true) {	    
		            	  int user_id = userRepository.findUserId(request.getParameter("userName"));	            	  	            	  
		            	  int org_id = userRepository.findOrgId(request.getParameter("userName"));
		            	  User user = userRepository.getUser(user_id);
		            	  session.setAttribute("authenticated","true");
		            	  session.setAttribute("user", user);
		            	  session.setAttribute("user_id", user_id);
		            	  session.setAttribute("org_id", org_id);	            	  	            	  	            	  
		                  forward = LOGIN_SUCCESS;	                  
		              } else {
		            	  session.setAttribute("message", "Error: Login failed. Try again with valid login & password.");
		                  forward = LOGIN_FAILURE;
		              }
		          } else if (pageName.equals("logout")) {	        	  
		        	  if(session != null) {
		        		  session.invalidate();
		        	  }	        	      
		              forward = USER_LOGIN;	              
		          }		    		  
	    	  } catch (SQLException e) {
	    		  System.out.println(e.getMessage());;            	  
            	  session.setAttribute("message", "Error: "+e.getMessage()+" Please try again later or contact the administrator");
            	  if (pageName.equals("signup")) 
            		  forward = USER_LOGIN;
            	  else if (pageName.equals("login") || pageName.equals("login"))
            		  forward = LOGIN_FAILURE;            	             		 
	    	  }	    	  	    	  	    	  	    	  	    	  	    	  	    	  	             
	      }
	      //userRepository.close();
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }	  	 
}
