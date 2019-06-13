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
	private static String SAVE_FAILURE = "segments.jsp";

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
	        	  HttpSession session = request.getSession();
	        	  
	              if (segmentRepository.findBySegmentName(request .getParameter("segmentName"))) {
	                  //request.setAttribute("message", "Segment Name exists. Try another name");
	                  session.setAttribute("message", "Segment Name exists. Try another name.");
	                  forward = SAVE_FAILURE;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);
	                  return;
	              }

	              	              
	              int userId = (Integer)session.getAttribute("user_id");	              
	              int orgId = (Integer)session.getAttribute("org_id");
	              
	              String segmentName = request.getParameter("segmentName");
	              String segmentRules = request.getParameter("segmentRules");
	              //System.out.println("segmentRules: "+segmentRules);
	              
	              segmentRepository.save(segmentName, segmentRules, userId, orgId);
	              session.setAttribute("message", "Segment "+segmentName+" Saved.");
	              //request.setAttribute("message", "Segment Saved.");
	              forward = SAVE_SUCCESS;
	          }          
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	  }
}
