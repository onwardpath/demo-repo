package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
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
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String service = request.getParameter("service");
			System.out.println(Database.getTimestamp()+" @AjaxController.doGet>service: "+service);
			
			String message = "";
			if (service.equals("renderUrl")) {
				try {
					message = renderUrl(request);
				} catch (IOException e) {
					message = e.getMessage();
				}				
			}
								
			//message = message.replaceAll("<", "&lt;"); //convert < to &lt;
			//message = message.replaceAll(">", "&gt;"); //convert > to &gt;
			
		    response.setContentType("text/plain");  
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(message);
			response.getWriter().flush();
		    //response.setContentType("application/json");			
		    //response.setContentType("text/html;charset=UTF-8");
		    //final ObjectMapper mapper = new ObjectMapper();		    
		    //mapper.writeValue(response.getWriter(), message);		    
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
			
		}
		
		private String renderUrl(HttpServletRequest request) throws IOException {
			String html = "";
			String pageUrl = request.getParameter("pageUrl");
			System.out.println(Database.getTimestamp()+" @AjaxController.renderUrl>pageUrl: "+pageUrl);
			                                  
            html = Jsoup.connect(pageUrl).get().html();
            //System.out.println(html);
            
			return html;
		}
}
