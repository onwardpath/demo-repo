package com.onwardpath.georeach.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.onwardpath.georeach.util.Database;

/**
 * Servlet implementation class DisplayImageController
 */

public class DisplayImageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayImageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		     
		try {
			String id = request.getParameter("id");
			String sql = "SELECT * FROM user WHERE org_id=?";
		Connection   dbConnection = Database.getConnection();
		PreparedStatement prepStatement = dbConnection.prepareStatement(sql);
		prepStatement.setString(1,id);
		ResultSet result = prepStatement.executeQuery();
		result.next() ;
		Blob b = result.getBlob("profile_pic");
		response.setContentType("image/jpeg");
		response.setContentLength((int) b.length());
		InputStream is = b.getBinaryStream();
		OutputStream os = response.getOutputStream();
		byte buf[] = new byte[(int) b.length()];
		is.read(buf);
		os.write(buf);	
		prepStatement.close();
		dbConnection.close();
		}catch (SQLException e) {
			System.out.println("Something went wrong in Display Image Controller."+ e.getMessage());
	    }
	}   

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
