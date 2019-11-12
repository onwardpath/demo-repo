package com.onwardpath.georeach.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.onwardpath.georeach.model.Experience;
import com.onwardpath.georeach.util.Database;

@SuppressWarnings("serial")
public class AjaxExpController extends HttpServlet {

	private String id;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AjaxExpController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			String value = ExperienceAllValues();
			// ExperienceConfigValues();

			response.getWriter().write(value.toString());

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: Return error message in JSON format to caller
		} 
 
	}
	
//	Code for Populating Datatables values  -- START --
	private String ExperienceAllValues() throws SQLException,
			JsonGenerationException, JsonMappingException, IOException,
			JSONException {

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();
		String[] segment_names;
		String[] segment_ids;
		String segments = "";

		String ExpAllValues = "select  experience.id as id, experience.name as name, experience.type as type, experience.status as status, GROUP_CONCAT(DISTINCT segment.name) as segmentname,GROUP_CONCAT(DISTINCT segment.id) as segment_id, experience.create_time as create_time from experience, segment, content ,config where experience.id = content.experience_id and experience.id = config.experience_id and experience.org_id = ? and content.segment_id = segment.id GROUP BY experience.id";
		try {

			PreparedStatement prepStatement = con
					.prepareStatement(ExpAllValues);
			prepStatement.setString(1, "1");

			ResultSet rst = prepStatement.executeQuery();

			if (rst != null) {
				while (rst.next()) {
					int exp_id = rst.getInt(1);
					String tmp_exp_id = String.valueOf(exp_id);
					String GetExpPageCountQuery = "select count(url) from config where experience_id = ?";
					JSONObject json = new JSONObject();
					prepStatement = con.prepareStatement(GetExpPageCountQuery);
					prepStatement.setString(1, tmp_exp_id);

					ResultSet URLCount = prepStatement.executeQuery();

					if (URLCount.next()) {
						json.put("pages", URLCount.getInt(1));
					}
					if (rst.getString(6).contains(",")) {
						segment_names = rst.getString(5).split(",");
						segment_ids = rst.getString(6).split(",");
						
						
						
						for (int i = 0; i < segment_ids.length; i++) {
							segments += segment_ids[i] + ":" + segment_names[i]
									+ ",";
							
							int temp = segments.lastIndexOf(",");	
							
							
						}

					}
					
					else
										
   					segments = rst.getString(6) + ":" + rst.getString(5)+",";
					
					json.put("id", rst.getInt(1));
					json.put("experience", rst.getString(2));
					json.put("status", rst.getString(3));
					json.put("type", rst.getString(4));
					json.put("segments", segments);
					// json.put("segments_id",rst.getString(6));

					jarray.put(json);
					
					segments = "";
				}

				System.out.println("jarray" + jarray.toString());
			}
			prepStatement.close();
			rst.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return jarray.toString();
	} //  Code for Populating Datatables values -- END --
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException {

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();
		String service = request.getParameter("service");
		String tmp_seg_id = String.valueOf(service);
		String exp_id  = request.getParameter("expid");
		String tmp_exp_id = String.valueOf(exp_id);
		String experience = request.getParameter("exper");
		String tmp_status = service;
		
		String content = "";
		try {
			
		//	Code for Modal Popup getting Content from DB Tables -- START -- 
			if(experience.equals( "content"))
			{
				System.out.println("exper="+experience);
			if((service != null)&&(exp_id != null))
			{
			String contentvalues = "select content from content where content.experience_id = ? and content.segment_id = ?";
			PreparedStatement prepStatement = con
					.prepareStatement(contentvalues);
			prepStatement.setString(1, tmp_exp_id);
			prepStatement.setString(2, tmp_seg_id);

			ResultSet rst = prepStatement.executeQuery();
			if (rst != null) {
				while (rst.next()) {
					JSONObject json = new JSONObject();
					json.put("content",rst.getString(1));
					jarray.put(json);
				}
				
				content = jarray.toString();
			}
			prepStatement.close();
			rst.close();
			}
		} // Code for Modal Popup getting Content from DB Tables -- END -- 
			
			
		//	Code for Toggle ON and OFF and setting in DB tables -- START --
			else if(experience.equals("status"))
				
			{
			
				if(tmp_status.equals("true"))
				{
				System.out.println("status="+tmp_status);
				String experience_status = "update experience set status = ? where id = ?";
				PreparedStatement prepStatement = con
						.prepareStatement(experience_status);
				prepStatement.setString(1, "on");
				prepStatement.setString(2, exp_id);
				prepStatement.executeUpdate();
				}
				else if(tmp_status.equals("false"))
				{
				String experience_status = "update experience set status = ? where id = ?";
				PreparedStatement prepStatement = con
						.prepareStatement(experience_status);
				prepStatement.setString(1, "off");
				prepStatement.setString(2, exp_id);
				prepStatement.executeUpdate();
				}
			}
				
			
			response.getWriter().write(jarray.toString().toString());

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: Return error message in JSON format to caller
		}

	} //	Code for Toggle ON and OFF and setting in DB tables -- END --

}
