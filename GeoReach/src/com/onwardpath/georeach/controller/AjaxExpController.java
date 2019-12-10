package com.onwardpath.georeach.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

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
	private String value;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			PrintWriter out = response.getWriter();
			response.setHeader("Access-Control-Allow-Origin", "*");
			HttpSession session = request.getSession();
			int userId = (Integer) session.getAttribute("user_id");
			int orgId = (Integer) session.getAttribute("org_id");
			System.out.println("session" + userId + orgId);
			String tmp_org_id = String.valueOf(orgId);

			String offset = request.getParameter("offset");
			String limit = request.getParameter("limit");
			/*
			 * String load = request.getParameter("load"); System.out.println("load"+load);
			 */
			String Expquery = "select  experience.id as id, experience.name as name, experience.type as type, experience.status as status, GROUP_CONCAT( distinct concat(segment.id ,':',segment.name) separator ',') as segmentname, experience.create_time as create_time, CONCAT(user.firstname, ' ', user.lastname) as name from user, experience, segment, content ,config where experience.id = content.experience_id and  content.segment_id = segment.id and user.org_id = ? and experience.org_id = ? GROUP BY experience.id ORDER BY experience.create_time DESC limit ?, ?  ";

		    value = ExperienceAllValues(tmp_org_id, offset, limit, Expquery);
			// ExperienceConfigValues();

			// response.getWriter().write(value.toString());
			System.out.println("getvalue=" + (value.toString()));
			out.println(value.toString());

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: Return error message in JSON format to caller
		}

	}

//	Code for Populating Datatables values  -- START --
	public String ExperienceAllValues(String tmp_org_id, String offset, String limit,String Expquery)
			throws SQLException, JsonGenerationException, JsonMappingException, IOException, JSONException {

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();

		String[] segment_names;
		String[] segment_ids;
		String segments = "";
		String tmp_org_ids = tmp_org_id;
		int offsets = Integer.parseInt(offset); 
		int limits = Integer.parseInt(limit);
		System.out.println("org="+tmp_org_ids);
		System.out.println("offsets="+offsets); System.out.println("limits="+limits);
		 
		String ExpAllValues = Expquery;
		try {

			PreparedStatement prepStatement = con.prepareStatement(ExpAllValues);
			
			prepStatement.setString(1, tmp_org_ids);
			prepStatement.setString(2, tmp_org_ids);
			prepStatement.setInt(3, offsets); 
			prepStatement.setInt(4, limits);
			

			ResultSet rst = prepStatement.executeQuery();

			if (rst != null) {
				while (rst.next()) {
					int exp_id = rst.getInt(1);
					String tmp_exp_id = String.valueOf(exp_id);
					String GetExpPageCountQuery = "select Group_concat(DISTINCT config.url) AS url,count as pageurl_count from config where experience_id = ?";
					JSONObject json = new JSONObject();
					prepStatement = con.prepareStatement(GetExpPageCountQuery);
					prepStatement.setString(1, tmp_exp_id);

					ResultSet URLCount = prepStatement.executeQuery();

					if (URLCount.next()) {
						json.put("url", URLCount.getString(1));
						json.put("pages", URLCount.getInt(2));
					}

					String ExpAllCount = "select count from user, experience, segment, content  where experience.id = content.experience_id  and content.segment_id = segment.id and user.org_id =  ? and experience.org_id = ?  GROUP BY experience.id ORDER BY experience.create_time DESC ";

					prepStatement = con.prepareStatement(ExpAllCount);
					prepStatement.setString(1, tmp_org_ids);
					prepStatement.setString(2, tmp_org_ids);

					ResultSet ExpCount = prepStatement.executeQuery();

					ExpCount.last();
					int rows = ExpCount.getRow();
					ExpCount.beforeFirst();
					json.put("ExpCount", rows);

					if (rst.getString(6).contains(",")) {
						segment_names = rst.getString(5).split(",");
						

						for (int i = 0; i < segment_names.length; i++) {
							segments +=  segment_names[i] + ",";

							int temp = segments.lastIndexOf(",");

						}

					}

					else

						segments =  rst.getString(5) + ",";

					json.put("id", rst.getInt(1));
					json.put("experience", rst.getString(2));
					json.put("status", rst.getString(3));
					json.put("type", rst.getString(4));
					json.put("segments", segments);
					// json.put("segments_id",rst.getString(6));
					json.put("org_id", tmp_org_ids);
					json.put("name", rst.getString(7));
					
					
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
	} // Code for Populating Datatables values -- END --

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws JsonGenerationException, JsonMappingException, IOException {
		PrintWriter out = response.getWriter();
		response.setHeader("Access-Control-Allow-Origin", "*");

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();
		String service = request.getParameter("service");
		String tmp_seg_id = String.valueOf(service);
		String exp_id = request.getParameter("expid");
		String tmp_exp_id = String.valueOf(exp_id);
		String experience = request.getParameter("exper");
		System.out.println("experience="+experience);
		String tmp_status = service;

		String contents = "";
		try {

			// Code for Modal Popup getting Content from DB Tables -- START --
			if (experience.equals("content")) {
				System.out.println("exper=" + experience);
				if ((service != null) && (exp_id != null)) {
					String contentvalues = "select content from content where content.experience_id = ? and content.segment_id = ?";
					PreparedStatement prepStatement = con.prepareStatement(contentvalues);
					prepStatement.setString(1, tmp_exp_id);
					prepStatement.setString(2, tmp_seg_id);

					ResultSet rst = prepStatement.executeQuery();
					if (rst != null) {
						while (rst.next()) {
							JSONObject json = new JSONObject();
							json.put("content", rst.getString(1));
							jarray.put(json);
						}

						contents = jarray.toString();
					}
					prepStatement.close();
					rst.close();
				}
			} // Code for Modal Popup getting Content from DB Tables -- END --

			// Code for Toggle ON and OFF and setting in DB tables -- START --
			else if (experience.equals("status"))    

			{

				if (tmp_status.equals("true")) {
					System.out.println("status=" + tmp_status);
		 			String experience_status = "update experience set status = ? where id = ?";
					PreparedStatement prepStatement = con.prepareStatement(experience_status);
					prepStatement.setString(1, "on");
					prepStatement.setString(2, exp_id);
					prepStatement.executeUpdate();
				} else if (tmp_status.equals("false")) {
					String experience_status = "update experience set status = ? where id = ?";
					PreparedStatement prepStatement = con.prepareStatement(experience_status);
					prepStatement.setString(1, "off");
					prepStatement.setString(2, exp_id);
					prepStatement.executeUpdate();
				}
			}
			
			else if(experience.equals("search"))
			{
				String searchvalue = request.getParameter("search");
				System.out.println("value="+searchvalue);
				
				
				HttpSession session = request.getSession();
				int userId = (Integer) session.getAttribute("user_id");
				int orgId = (Integer) session.getAttribute("org_id");
				System.out.println("session" + userId + orgId);
				String tmp_org_id = String.valueOf(orgId);

			
				String limit = request.getParameter("limit");
				
				String Expquery = "select  experience.id as id, experience.name as name, experience.type as type, experience.status as status, GROUP_CONCAT( distinct concat(segment.id ,':',segment.name) separator ',') as segmentname, experience.create_time as create_time, CONCAT(user.firstname, ' ', user.lastname) as name from user, experience, segment, content  where experience.id = content.experience_id  and content.segment_id = segment.id and user.org_id = ? and experience.org_id = ? and (experience.name  LIKE ? or segment.name LIKE ?) GROUP BY experience.id limit ?  ";

				value = SearchExperienceValues(tmp_org_id, searchvalue, limit, Expquery);
				System.out.println("post value="+value);
				
				//jarray.put(value);
				contents = value;
				System.out.println("PostValue"+contents);
			}

			
		//	response.getWriter().write(jarray.toString().toString());
			out.println(contents.toString());

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: Return error message in JSON format to caller
		}

	} // Code for Toggle ON and OFF and setting in DB tables -- END -- 
	
	public String SearchExperienceValues(String tmp_org_id, String searchvalue, String limit,String Expquery)
			throws SQLException, JsonGenerationException, JsonMappingException, IOException, JSONException {

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();

		String[] segment_names;
		String[] segment_ids;
		String segments = "";
		String tmp_org_ids = tmp_org_id;
		String searchvalues = searchvalue;
		int limits = Integer.parseInt(limit);
		System.out.println("org="+tmp_org_ids);
		System.out.println("offsets="+searchvalues); System.out.println("limits="+limits);
		 
		String ExpAllValues = Expquery;
		try {

			PreparedStatement prepStatement = con.prepareStatement(ExpAllValues);
			
			prepStatement.setString(1, tmp_org_ids);
			prepStatement.setString(2, tmp_org_ids);
			prepStatement.setString(3,"%"+ searchvalues + "%"); 
			prepStatement.setString(4,"%"+ searchvalues + "%");
			
			prepStatement.setInt(5, limits);
			
			 

			ResultSet rst = prepStatement.executeQuery();

			if (rst != null) {
				while (rst.next()) {
					int exp_id = rst.getInt(1);
					String tmp_exp_id = String.valueOf(exp_id);
					String GetExpPageCountQuery = "select Group_concat(DISTINCT config.url) AS url,count as pageurl_count from config where experience_id = ?";
					JSONObject json = new JSONObject();
					prepStatement = con.prepareStatement(GetExpPageCountQuery);
					prepStatement.setString(1, tmp_exp_id);

					ResultSet URLCount = prepStatement.executeQuery();

					if (URLCount.next()) {
						json.put("url", URLCount.getString(1));
						json.put("pages", URLCount.getInt(2));
					}

					String ExpAllCount = "select count from user, experience, segment, content  where experience.id = content.experience_id  and content.segment_id = segment.id and user.org_id =  ? and experience.org_id = ? GROUP BY experience.id ORDER BY experience.create_time DESC ";

					prepStatement = con.prepareStatement(ExpAllCount);
					prepStatement.setString(1, tmp_org_ids);
					prepStatement.setString(2, tmp_org_ids);
					ResultSet ExpCount = prepStatement.executeQuery();

					ExpCount.last();
					int rows = ExpCount.getRow();
					ExpCount.beforeFirst();
					json.put("ExpCount", rows);

					if (rst.getString(6).contains(",")) {
						segment_names = rst.getString(5).split(",");
						

						for (int i = 0; i < segment_names.length; i++) {
							segments +=  segment_names[i] + ",";

							int temp = segments.lastIndexOf(",");

						}

					}

					else

						segments =  rst.getString(5) + ",";

					json.put("id", rst.getInt(1));
					json.put("experience", rst.getString(2));
					json.put("status", rst.getString(3));
					json.put("type", rst.getString(4));
					json.put("segments", segments);
					// json.put("segments_id",rst.getString(6));
					json.put("org_id", tmp_org_ids);
					json.put("name", rst.getString(7));
					
					
					jarray.put(json);

					segments = "";
				}


				System.out.println("jarray=" + jarray.toString());
			}
			prepStatement.close();
			rst.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return jarray.toString();
	} 

}
