package com.onwardpath.georeach.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
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
	              if (userRepository.findByUserName(request .getParameter("userName"))) {
	                  request.setAttribute("message", "User Name exists. Try another user name");
	                  forward = USER_SIGNUP;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }

	              userRepository.save(request.getParameter("userName"),
	                      request.getParameter("password"),
	                      request.getParameter("firstName"),
	                      request.getParameter("lastName"),
	                      request.getParameter("dateOfBirth"),
	                      request.getParameter("emailAddress"));
	              forward = USER_LOGIN;
	          } else if (pageName.equals("login")) {
	              boolean result = userRepository.findByLogin( request.getParameter("userName"), request.getParameter("password"));
	              if (result == true) {
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
