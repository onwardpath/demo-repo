package com.onwardpath.georeach.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.onwardpath.georeach.model.Experience;
import com.onwardpath.georeach.repository.ExperienceRepository;
import com.onwardpath.georeach.repository.SegmentRepository;
import com.onwardpath.georeach.util.Database;

/**
 * Servlet implementation class DeleteController
 */
  
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
    
	
	  /**
	   * Method to Deleted a Segment by id
	   * @param id
	   */
	  public void delete(String id) throws SQLException {
		  
		Connection  dbConnection = Database.getConnection();
        PreparedStatement prepStatement = dbConnection.prepareStatement("delete from segment where id = ?");
        prepStatement.setString(1, id);
        prepStatement.executeUpdate();
        System.out.println(Database.getTimestamp()+" @SegmentRepository.delete>Segement Deleted");
        prepStatement.close();
        dbConnection.close();
	  }  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		SegmentRepository segmentRepository = new SegmentRepository();
		String resultPage = request.getParameter("result_page");
		try {
		String assetId = request.getParameter("seg_id");
		ExperienceRepository exp = new ExperienceRepository();
		List expname =exp.experienceName(assetId);
		if(expname.isEmpty()) {
			delete(assetId);	
		}else {
		
			session.setAttribute("experienceName", expname); 
			System.out.println("expname"+ expname + " & session  variable : " + session.getAttribute("experienceName") + "& assetId:"+assetId);
		}
	   }catch (SQLException e) {
		System.out.println("Something went wrong in Delete Controller."+ e.getMessage());
	     }
		  response.sendRedirect("/GeoReach?view="+resultPage);
	} 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		 
		
	}
  
}
