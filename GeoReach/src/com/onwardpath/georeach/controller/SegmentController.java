package com.onwardpath.georeach.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import com.onwardpath.georeach.repository.SegmentRepository;
import com.onwardpath.georeach.util.Database;

@SuppressWarnings("serial")
public class SegmentController extends HttpServlet {
	
	private SegmentRepository segmentRepository;		 	
	private static String SAVE_SUCCESS = "?view=pages/segment-create.jsp";
	private static String SAVE_FAILURE = "?view=pages/segment-create.jsp";
	
	  /**
	   * @see HttpServlet#HttpServlet()
	   */
	  public SegmentController() {
	      super();	      
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
		  segmentRepository = new SegmentRepository();
		  
	      String pageName = request.getParameter("pageName");	      	      
	      System.out.println(Database.getTimestamp()+" @SegmentController.doPost>pageName: "+pageName);
	      String forward = "";
	      HttpSession session = request.getSession();	      
	      if (segmentRepository != null) {
	          if (pageName.equals("segment-create")) {
	        	  System.out.println("@SegmentController.doPost called from page:segment-create");
	        	  try {
	        		  int userId = (Integer)session.getAttribute("user_id");	              
		              int orgId = (Integer)session.getAttribute("org_id");
		              String segmentName = request.getParameter("segmentName");
		              String segmentRules = request.getParameter("segmentRules");		              
		              System.out.println("segmentName: "+segmentName);
		              System.out.println("segmentRules: "+segmentRules);
		              if (segmentRepository.findBySegmentNameInOrg(segmentName ,orgId)) {	                  
		                  session.setAttribute("message", "Error: Segment name "+segmentName+" already exist. Try another name.");
		                  forward = SAVE_FAILURE;
		                  RequestDispatcher view = request .getRequestDispatcher(forward);
		                  view.forward(request, response);	      
		                  return;
		              }		              	             		              		              		              		              		           		              		              
		              segmentRepository.save(segmentName, segmentRules, userId, orgId);
		              session.setAttribute("message", "Info: Segment <b>"+segmentName+"</b> Saved.");		              
		              forward = SAVE_SUCCESS;  
	        	  } catch (SQLException e) {
	        		  session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");
	        		  forward = SAVE_FAILURE;
	        	  }	        	  
	          } 
	      }
	      RequestDispatcher view = request.getRequestDispatcher(forward);
	      view.forward(request, response);	     
	  }	  	 
}