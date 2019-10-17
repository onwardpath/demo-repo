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
		String pageName = request.getParameter("pageName");	      
	    RequestDispatcher view = request.getRequestDispatcher("?view=pages/"+pageName);
	    view.forward(request, response);
	}

	/**
	* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		segmentRepository = new SegmentRepository();
		  
	    String pageName = request.getParameter("pageName");	      	      
	    System.out.println(Database.getTimestamp()+" @SegmentController.doPost>pageName: "+pageName);
	    HttpSession session = request.getSession();	      
	    if (segmentRepository != null) {	          
	    	if (pageName.startsWith("segment-create")) {
	    		System.out.println("@SegmentController.doPost called from page:"+pageName);
	        	try {
	        		int userId = (Integer)session.getAttribute("user_id");	              
		            int orgId = (Integer)session.getAttribute("org_id");
		            String segmentName = request.getParameter("segmentName");
		            String segmentRules = request.getParameter("segmentRules");		              
		            System.out.println("segmentName: "+segmentName);
		            System.out.println("segmentRules: "+segmentRules);
		            if (segmentRepository.findBySegmentNameInOrg(segmentName ,orgId)) {	                  
		            	session.setAttribute("message", "Error: Segment name "+segmentName+" already exist. Try another name.");
		                RequestDispatcher view = request .getRequestDispatcher("?view=pages/"+pageName);
		                view.forward(request, response);	      
		                return;
		            }		              	             		              		              		              		              		           		              		              
		            segmentRepository.save(segmentName, segmentRules, userId, orgId);
		            session.setAttribute("message", "Segment <b>"+segmentName+"</b> Saved.");		                
	        	} catch (SQLException e) {
	        		session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");
	        	}	        	  
	       }
	    	//Added by Gurujegan for Segment Geo Update --Start-- 
	    	else if (pageName.startsWith("segment-edit")) {
	    		System.out.println("@SegmentController.doPost called from page:"+pageName);
	        	try {
	        		int userId = (Integer)session.getAttribute("user_id");	              
		            int orgId = (Integer)session.getAttribute("org_id");
		            String segmentName = request.getParameter("segmentName");
		            String segmentRules = request.getParameter("segmentRules");
		            String segmentId = request.getParameter("segmentId");
		            System.out.println("segmentName: "+segmentName);
		            System.out.println("segmentRules: "+segmentRules);
		            segmentRepository.update(segmentName,segmentRules, segmentId, orgId);
		            session.setAttribute("message", "Segment <b>"+segmentName+"</b> Saved.");		                
	        	} catch (SQLException e) {
	        		session.setAttribute("message", "Error: "+e.getMessage()+". Please try later or contact the administrator.");
	        	}	        	  
	       }
	    	//Added by Gurujegan for Segment Geo Update --End-- 
	    }
	    RequestDispatcher view = request.getRequestDispatcher("?view=pages/"+pageName);
	    view.forward(request, response);	     
	}	  	 
}