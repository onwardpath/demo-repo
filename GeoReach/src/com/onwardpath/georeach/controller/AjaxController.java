package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.onwardpath.georeach.util.Database;

@SuppressWarnings("serial")
public class AjaxController extends HttpServlet {
					 		
		/**
		 * @see HttpServlet#HttpServlet()
		 */
		public AjaxController() {
			super();	      	     
		}

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		//Updated By Poovarasan 
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String service_name = request.getParameter("service");
			if(!service_name.isEmpty() && service_name !=null) {
			String selectionValues = service_name.equals("city_suggestions") ? "city" : "state";
				String geoloc = request.getParameter("geoloc");
				try {
					String jsonString = SuggestionListValues(geoloc,selectionValues);
					System.out.println("jsonString ::"+jsonString);
					response.getWriter().write(jsonString);
				} catch (Exception e) {
					e.printStackTrace();
					//TODO: Return error message in JSON format to caller
				}												    
		}
	}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
			String service = request.getParameter("service");
			
			if (service.equalsIgnoreCase("preview")) {
				String pageUrl = request.getParameter("pageUrl");
				System.out.println(Database.getTimestamp()+" @AjaxController.doPost>service: "+service);								
				System.out.println(Database.getTimestamp()+" @AjaxController.doPost>pageUrl: "+pageUrl);			
				Document doc = Jsoup.connect(pageUrl).get();
				
				//Convert all src/href attributes for image, style-sheet and script elements to absolute path
				Elements media = doc.select("img[src]");
				for (Element e1 : media) {
					e1.attr("src", e1.absUrl("src"));
				}
				
				Elements style = doc.getElementsByTag("link");
				for (Element e2 :style ){
					e2.attr("href",e2.absUrl("href"));
				}
				
				Elements script = doc.select("script[src]");
				for (Element e3 : script) {
					e3.attr("src", e3.absUrl("src"));
				}
														
				String head = doc.head().html();
				String body = doc.body().html();				
				String html = "<html><head>"+head+"</head><body>"+body+"</body></html>";
				//html = Jsoup.clean(html, Whitelist.basic());
				HttpSession session = request.getSession();
				session.setAttribute("content", html); //passing as parameter is not working										
				RequestDispatcher view = request.getRequestDispatcher("/preview.jsp");
				view.forward(request, response);									
			}			
		}
		
		/* Commited by Poovarsan for Auto Complete Query change (26-Jul-19)*/
		private String SuggestionListValues(String startsWith,String filterBy) throws SQLException, JsonGenerationException, JsonMappingException, IOException {
			final StringWriter sw = new StringWriter();
			final ObjectMapper mapper = new ObjectMapper();
			Connection con = Database.getConnection();
			ArrayList<String> citieslist = new ArrayList<String>();
			String LOVCityValues = "select city.name,state.name,country.code from city join state join country on city.state_id = state.id where state.country_id = country.id AND city.name like ?  ORDER BY city.name,state.name ASC LIMIT 10";
			String LOVStatesValues = "select st.name,ctry.code from state st,country ctry where st.name like ? and st.country_id = ctry.id";  
			try {
				System.out.println("filter by value :"+filterBy.equals("city"));
				String sql_query = filterBy.equals("city") ? LOVCityValues : LOVStatesValues;
				PreparedStatement prepStatement = con.prepareStatement(sql_query);
				prepStatement.setString(1, startsWith + "%");
				ResultSet rst = prepStatement.executeQuery();
				while (rst.next()) {
					String concatValues = rst.getString(1) + ", " + rst.getString(2); 
					if(filterBy.equals("city"))  concatValues += ", " +rst.getString(3);
					citieslist.add(concatValues) ;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			mapper.writeValue(sw, citieslist);
			System.out.println(sw.toString());// use toString() to convert to JSON
			String jsonstring = sw.toString();
			sw.close();
			
			if (citieslist.size() == 0) {
				jsonstring = "null";
			}
			
			return jsonstring;
		}
}
