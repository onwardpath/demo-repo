package com.onwardpath.georeach.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.SQLException;
import com.onwardpath.georeach.repository.UserRepository;

@SuppressWarnings("serial")
public class UserController extends HttpServlet {
	private UserRepository userRepository;

	private static String USER_SIGNUP = "signup.jsp";
	private static String USER_LOGIN = "index.jsp";	  
	private static String LOGIN_SUCCESS = "home.jsp";
	private static String LOGIN_FAILURE = "failure.jsp";

	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public UserController() {
	      super();
	      userRepository = new UserRepository();
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
	      String pageName = request.getParameter("pageName");
	      String forward = "";        
	      
	      if (userRepository != null) {
	          if (pageName.equals("signup")) {
	        	  String emailName = request.getParameter("email");	        	  
	              if (userRepository.findByUserName(emailName)) {
	                  request.setAttribute("message", "User "+emailName+" alredy exist. <a href='index.jsp'>Click here</a> to login");
	                  forward = USER_SIGNUP;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }	              
	              
	              try {	
	            	  //Check if the domain already exist. If so, add user to existing Organization
	            	  if (userRepository.orgExists(request.getParameter("domain"))) {
	            		  userRepository.saveUserInOrg(request.getParameter("domain"), request.getParameter("firstName"), request.getParameter("lastName"), 
	            				  request.getParameter("email"), request.getParameter("phone"), request.getParameter("password"), Integer.parseInt(request.getParameter("role"))); 
	            	  } else {
	            		  //If domain does not exist, create a new Organization and add user
	            		  userRepository.saveUserandOrg(request.getParameter("orgName"), request.getParameter("domain"), request.getParameter("logoUrl"), 
			            		  request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("email"), request.getParameter("phone"), 
			            		  request.getParameter("password"), Integer.parseInt(request.getParameter("role")));  
	            	  }	            	  	            	  		            
		              forward = USER_LOGIN;		              
	              } catch (SQLException e) {
	            	  request.setAttribute("message", e.getMessage()+" Unexpected error!. Please try again later or contact the administrator");
	                  forward = USER_SIGNUP;
	              }	              	             
	          } else if (pageName.equals("login")) {
	              boolean result = userRepository.findByLogin( request.getParameter("userName"), request.getParameter("password"));	               
	              if (result == true) {	    
	            	  int user_id = userRepository.findUserId(request.getParameter("userName"));	            	  	            	  
	            	  int org_id = userRepository.findOrgId(request.getParameter("userName"));
	            	  
	            	  HttpSession session = request.getSession();
	            	  session.setAttribute("user_id", user_id);
	            	  session.setAttribute("org_id", org_id);	            	  	            	  	            	  
	                  forward = LOGIN_SUCCESS;	                  
	              } else {
	                  forward = LOGIN_FAILURE;
	              }
	          } else if (pageName.equals("logout")) {
	        	  HttpSession session = request.getSession(false);
	        	  if(session != null)
	        	      session.invalidate();
	              forward = USER_LOGIN;	              
	          }	         
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
}
