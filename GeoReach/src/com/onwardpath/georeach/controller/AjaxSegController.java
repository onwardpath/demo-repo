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
public class AjaxSegController extends HttpServlet {

	private String id;
	private String value;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AjaxSegController() {
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

			String location = request.getParameter("segtype");
			String behaviour = request.getParameter("segbev");
			System.out.println("output="+location+behaviour);

			String offset = request.getParameter("offset");
			String limit = request.getParameter("limit");
			
			String Segquery = "select segment.id as segmentid,segment.name as segmentname,segment.geography as seg_geography,CONCAT(user.firstname, ' ', user.lastname) as name from user,segment where user.org_id = ?  and segment.org_id =? and (segment.geography like ? or segment.geography like ? ) limit ?, ?  ";

		    value = SegmentAllValues(tmp_org_id, location, behaviour, Segquery,offset,limit);
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
	public String SegmentAllValues(String tmp_org_id, String location,  String behaviour,String Segquery, String offset, String limit)
			throws SQLException, JsonGenerationException, JsonMappingException, IOException, JSONException {

		Connection con = Database.getConnection();
		JSONArray jarray = new JSONArray();

		String[] segment_names;
		String[] segment_ids;
		String segments = "";
		String display = "";
		String tmp_org_ids = tmp_org_id;
		int offsets = Integer.parseInt(offset); 
		int limits = Integer.parseInt(limit);
		String seg_loc = location;
		String seg_beh = behaviour;
		System.out.println("seg_loc="+seg_loc); System.out.println("seg_beh="+seg_beh);
		 
		String ExpAllValues = Segquery;
		System.out.println("ExpAllValues="+Segquery);
		try {

			PreparedStatement prepStatement = con.prepareStatement(ExpAllValues);
			
			prepStatement.setString(1, tmp_org_ids);
			prepStatement.setString(2, tmp_org_ids);
			prepStatement.setString(3, seg_loc+ "%"); 
			prepStatement.setString(4, seg_beh+ "%");
			prepStatement.setInt(5, offsets); 
			prepStatement.setInt(6, limits);

			ResultSet rst = prepStatement.executeQuery();

			if (rst != null) {
				while (rst.next()) {
					/*
					 * int seg_id = rst.getInt(1); System.out.println("seg_id");
					 */
					JSONObject json = new JSONObject();
					

					
					  String ExpAllCount = "select count(*) as tot_count from user,segment where user.org_id = ? and segment.org_id = ? and (segment.geography like ? or segment.geography like ? )   " ;
					  
					  prepStatement = con.prepareStatement(ExpAllCount); 
					  prepStatement.setString(1, tmp_org_ids); 
					  prepStatement.setString(2, tmp_org_ids); 
					  prepStatement.setString(3, seg_loc+ "%"); 
					  prepStatement.setString(4, seg_beh+ "%"); 
					  ResultSet ExpCount = prepStatement.executeQuery();
		
					  if (ExpCount.next())
					  { 
						  json.put("SegCount", ExpCount.getString("tot_count"));
					  } 
					
					  String segmentRules = rst.getString(3);
					  if (segmentRules.indexOf("}") !=0) {
							int beginIndex = segmentRules.indexOf("{")+1;
							int endIndex = segmentRules.indexOf("}");											
							segmentRules = segmentRules.substring(beginIndex, endIndex);
							System.out.println("segmentrules="+segmentRules);
						}
						String [] rule = segmentRules.split("\\|"); 
						for(String a:rule) {
							String[] criteria = a.split(":");
							System.out.println("criteria="+criteria[0]+criteria[2]);
							
							if (criteria[0].startsWith("include")) {												
								display = criteria[2] +",";	
								System.out.println("criteria2="+criteria[2]);
							} 
							String temp = display;
							System.out.println("temp==="+temp);
							
						}
					json.put("Seg_id", rst.getInt(1));
					json.put("segment", rst.getString(2));
					json.put("geography",  rst.getString(3));
					
					/*
					 * json.put("status", rst.getString(3)); json.put("type", rst.getString(4));
					 * json.put("segments", segments); // json.put("segments_id",rst.getString(6));
					 * json.put("org_id", tmp_org_ids);
					 */
					json.put("name", rst.getString(4));
				//	json.put("url", rst.getString(9));
					
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

	
	  protected void doPost(HttpServletRequest request, HttpServletResponse
	  response) throws JsonGenerationException, JsonMappingException, IOException {
		  PrintWriter out = response.getWriter(); 
			response.setHeader("Access-Control-Allow-Origin", "*");
			HttpSession session = request.getSession();
			int userId = (Integer) session.getAttribute("user_id");
			int orgId = (Integer) session.getAttribute("org_id");
			System.out.println("session" + userId + orgId);
			String tmp_org_id = String.valueOf(orgId);

			String location = request.getParameter("segtype");
			String behaviour = request.getParameter("segbev");
			System.out.println("output="+location+behaviour);

		
			String limit = request.getParameter("limit");
			String searchvalue = request.getParameter("search");
			System.out.println("search="+searchvalue);
	  
	  String contents = ""; 
	  try {

	  String Segquery = "select segment.id as segmentid,segment.name as segmentname,segment.geography as seg_geography,CONCAT(user.firstname, ' ', user.lastname) as name from user,segment where user.org_id = ? and segment.org_id = ?   and (segment.geography like ? or segment.geography like ? ) and (segment.geography like ? or segment.name like ? ) limit ? " ;
	  
	  value = SearchSegmentValues(tmp_org_id, location, behaviour, Segquery,searchvalue,limit);
	  System.out.println("post value="+value);
	  
	  //jarray.put(value); 
	  contents = value;
	  System.out.println("PostValue"+contents); 
	  
	  
	  
	  // response.getWriter().write(jarray.toString().toString());
	  out.println(contents.toString());
	  
	  } catch (Exception e) 
	  { e.printStackTrace(); // TODO: Return error message in
	 }
	  
	  } // Code for Toggle ON and OFF and setting in DB tables -- END --
	  
	  public String SearchSegmentValues(String tmp_org_id, String location,  String behaviour,String Segquery, String searchvalue, String limit)throws SQLException, JsonGenerationException,
	  JsonMappingException, IOException, JSONException {
	  
		  Connection con = Database.getConnection();
			JSONArray jarray = new JSONArray();

			String[] segment_names;
			String[] segment_ids;
			String segments = "";
			String display = "";
			String tmp_org_ids = tmp_org_id;
		
			int limits = Integer.parseInt(limit);
			String seg_loc = location;
			String seg_beh = behaviour;
			String searchvalues = searchvalue;
			System.out.println("seg_loc="+seg_loc); System.out.println("seg_beh="+seg_beh);
			 
			String ExpAllValues = Segquery;
			System.out.println("ExpAllValues="+Segquery);
			try {

				PreparedStatement prepStatement = con.prepareStatement(ExpAllValues);
				
				prepStatement.setString(1, tmp_org_ids);
				prepStatement.setString(2, tmp_org_ids);
				prepStatement.setString(3, seg_loc+ "%"); 
				prepStatement.setString(4, seg_beh+ "%");
				prepStatement.setString(5,"%"+ searchvalue+ "%"); 
				prepStatement.setString(6,"%"+ searchvalue+ "%"); 
				prepStatement.setInt(7, limits);

				ResultSet rst = prepStatement.executeQuery();

				if (rst != null) {
					while (rst.next()) {
						/*
						 * int seg_id = rst.getInt(1); System.out.println("seg_id");
						 */
						JSONObject json = new JSONObject();
						

						
						  String ExpAllCount = "select count(*) as tot_count from user,segment where user.org_id = ? and segment.org_id = ?  and (segment.geography like ? or segment.geography like ? )   " ;
						  
						  prepStatement = con.prepareStatement(ExpAllCount); 
						  prepStatement.setString(1, tmp_org_ids);
						  prepStatement.setString(2, tmp_org_ids);
						  prepStatement.setString(3, seg_loc+ "%"); 
						  prepStatement.setString(4, seg_beh+ "%"); 
						  ResultSet ExpCount = prepStatement.executeQuery();
			
						  if (ExpCount.next())
						  { 
							  json.put("SegCount", ExpCount.getString("tot_count"));
						  } 
						
						  String segmentRules = rst.getString(3);
						  if (segmentRules.indexOf("}") !=0) {
								int beginIndex = segmentRules.indexOf("{")+1;
								int endIndex = segmentRules.indexOf("}");											
								segmentRules = segmentRules.substring(beginIndex, endIndex);
								System.out.println("segmentrules="+segmentRules);
							}
							String [] rule = segmentRules.split("\\|"); 
							for(String a:rule) {
								String[] criteria = a.split(":");
								System.out.println("criteria="+criteria[0]+criteria[2]);
								
								if (criteria[0].startsWith("include")) {												
									display = criteria[2] +",";	
									System.out.println("criteria2="+criteria[2]);
								} 
								String temp = display;
								System.out.println("temp==="+temp);
								
							}
						json.put("Seg_id", rst.getInt(1));
						json.put("segment", rst.getString(2));
						json.put("geography",  rst.getString(3));
						
						/*
						 * json.put("status", rst.getString(3)); json.put("type", rst.getString(4));
						 * json.put("segments", segments); // json.put("segments_id",rst.getString(6));
						 * json.put("org_id", tmp_org_ids);
						 */
						json.put("name", rst.getString(4));
					//	json.put("url", rst.getString(9));
						
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
		} 
	 
}
