package com.onwardpath.georeach.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import com.onwardpath.georeach.model.User;
import com.onwardpath.georeach.repository.UserRepository;
import com.onwardpath.georeach.util.Database;
import com.onwardpath.georeach.util.MatomoUtil;

@SuppressWarnings("serial")
@MultipartConfig(maxFileSize = 16177215)
public class UserController extends HttpServlet {
	private UserRepository userRepository;
	private MatomoRepository MatamoRepository;
 
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
		  String pageName = request.getParameter("pageName");
		  System.out.println(Database.getTimestamp()+" @UserController.doGet>pageName: "+pageName);
		  String forward = USER_SIGNUP;
		  
		  if ("logout".equals(pageName)) {
			  HttpSession session = request.getSession();
			  if(session != null) {
        		  session.invalidate();
        	  }	
			  forward = USER_LOGIN;
		  }	else {
			  forward="index.jsp?view=pages/profile-view-myprofile.jsp";
		  }
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
	    	  System.out.println("First coming here");
	    	  InputStream inputStream = null;
    		  Part filePart = request.getPart("photo");
    		  if (filePart != null) {
    	            // prints out some information for debugging
    	            System.out.println(filePart.getName());
    	            System.out.println(filePart.getSize());
    	            if (filePart.getSize()>0) {
    	            	inputStream = filePart.getInputStream();
    	            }
    	            System.out.println(filePart.getContentType());
    	             
    	            // obtains input stream of the upload file
    	            
    	        }
    		     
	    	  try {
	    		  if (pageName.equals("signup")) {
		        	  String emailName = request.getParameter("email");	        	  
		              if (userRepository.findByUserName(emailName)) {
		                  //request.setAttribute("message", "User "+emailName+" alredy exist. <a href='index.jsp'>Click here</a> to login");
		                  session.setAttribute("message", "Error. User "+emailName+" already exist. <a href='index.jsp'>Click here</a> to login");
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
	            				  request.getParameter("email"), request.getParameter("phone"), request.getParameter("password"), Integer.parseInt(request.getParameter("role")),inputStream); 
	            		  System.out.println("New User from existing organization");
	            	  } else {
	            		  System.out.println("orgDomain is new: "+orgDomain);
	            		     
	            		  //If domain does not exist, create a new Organization and add 

	            		  
	            		 
	            		  userRepository.saveUserandOrg(request.getParameter("orgName"), request.getParameter("domain"), "logoUrl", 
			            		  request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("email"), request.getParameter("phone"), 
			            		  request.getParameter("password"),Integer.parseInt(request.getParameter("role")),inputStream );
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
		        	  System.out.println("User logged out");
		        	  if(session != null) {
		        		  session.invalidate();
		        	  }	        	      
		              forward = USER_LOGIN;	              
				} 
					  else if (pageName.equals("profile")) {
						  String orgid = request.getParameter("orgid");
							 int idorg = Integer.parseInt(orgid);
							  
							 userRepository.updateUser( request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("phone"), request.getParameter("password"), Integer.parseInt(request.getParameter("role")), inputStream, idorg);
							 int userid = (int) session.getAttribute("user_id");
							 User user = userRepository.getUser(userid);
			            	  session.setAttribute("authenticated","true");
			            	  session.setAttribute("user", user);
			            	  session.setAttribute("message", "Update Success");
							  System.out.println(session.getAttribute("message")); 
							 forward="?view=pages/profile-view-myprofile.jsp";
					 } else if(pageName.equals("profilesetting")) {
						 System.out.println("coming here");
						 String orgid = request.getParameter("orgId");
						 int idorg = Integer.parseInt(orgid);								 
						 userRepository.updateOrg(request.getParameter("org"), request.getParameter("domain"),idorg);
						 int userid = (int) session.getAttribute("user_id");
						 User user = userRepository.getUser(userid);
		            	  session.setAttribute("authenticated","true");
		            	  session.setAttribute("user", user);
		            	  session.setAttribute("message", "Update Success");
						  System.out.println(session.getAttribute("message"));
						 forward="?view=pages/profile-view-settings.jsp";
						  
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
