package com.onwardpath.georeach.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.onwardpath.georeach.repository.SegmentRepository;

@SuppressWarnings("serial")
public class SegmentController extends HttpServlet {
	private SegmentRepository segmentRepository;
		 
	//private static String SAVE_SUCCESS = "pages/segment-create.jsp";
	//private static String SAVE_FAILURE = "pages/segment-create.jsp";
	private static String SAVE_SUCCESS = "?view=pages/segment-create.jsp";
	private static String SAVE_FAILURE = "?view=pages/segment-create.jsp";
	

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
	      System.out.println("@SegmentController.doPost::pageName="+pageName);
	      	      
	      String forward = "";        
	      
	      if (segmentRepository != null) {
	          if (pageName.equals("segment-create")) {
	        	  HttpSession session = request.getSession();
	        	  System.out.println("@SegmentController.doPost called from page:segment-create");
	              if (segmentRepository.findBySegmentName(request.getParameter("segmentName"))) {	                  
	                  session.setAttribute("message", "Error: Segment name already exist. Try another name.");
	                  forward = SAVE_FAILURE;
	                  RequestDispatcher view = request .getRequestDispatcher(forward);
	                  view.forward(request, response);	      
	                  return;
	              }
	              	             
	              int userId = (Integer)session.getAttribute("user_id");	              
	              int orgId = (Integer)session.getAttribute("org_id");
	              
	              String segmentName = request.getParameter("segmentName");
	              String segmentRules = request.getParameter("segmentRules");
	              
	              System.out.println("segmentName: "+segmentName);
	              System.out.println("segmentRules: "+segmentRules);
	              
	              segmentRepository.save(segmentName, segmentRules, userId, orgId);
	              session.setAttribute("message", "Info: Segment <b>"+segmentName+"</b> Saved.");
	              
	              forward = SAVE_SUCCESS;
	          }          
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);
	      
	  }
}