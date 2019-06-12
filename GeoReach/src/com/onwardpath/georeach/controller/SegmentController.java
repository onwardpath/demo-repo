package com.onwardpath.georeach.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.onwardpath.georeach.repository.SegmentRepository;
import com.onwardpath.georeach.repository.UserRepository;

@SuppressWarnings("serial")
public class SegmentController extends HttpServlet {
	private SegmentRepository segmentRepository;
		 
	private static String SAVE_SUCCESS = "segments.jsp";
	private static String SAVE_FAILURE = "failure.jsp";

	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public SegmentController() {
	      super();
	      segmentRepository = new SegmentRepository();
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
	      
	      if (segmentRepository != null) {
	          if (pageName.equals("segments")) {
	              if (segmentRepository.findBySegmentName(request .getParameter("segmentName"))) {
	                  request.setAttribute("message", "Segment Name exists. Try another name");
	                  forward = SAVE_FAILURE;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }
	              //String name, String geography, int user_id, int org_id
	              HttpSession session = request.getSession();
	              int userId = Integer.parseInt((String)session.getAttribute("user_id"));
	              int orgId = Integer.parseInt((String)session.getAttribute("org_id"));
	              
	              segmentRepository.save(request.getParameter("segmentName"),
	                      request.getParameter("segmentRules"),
	                      userId,
	                      orgId);
	              forward = SAVE_SUCCESS;
	          }          
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
}
