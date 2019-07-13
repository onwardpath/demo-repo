package com.onwardpath.georeach.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Attribute;
import org.jsoup.nodes.Attributes;
import org.jsoup.nodes.DataNode;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.safety.Whitelist;
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
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {																		
		    //response.setContentType("text/plain");
			//response.setContentType("application/json");			
		    //response.setContentType("text/html;charset=UTF-8");
			//response.setCharacterEncoding("UTF-8");
			//response.getWriter().print(html);
			//response.getWriter().flush();		    
		    //final ObjectMapper mapper = new ObjectMapper();		    
		    //mapper.writeValue(response.getWriter(), message);		    
		}

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		  
			String service = request.getParameter("service");
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
			String controls = "<a href='javascript:window.history.back()'>Back</a>";
			String html = "<html><head>"+head+"</head><body>"+controls+"<br>"+body+"</body></html>";
			//html = Jsoup.clean(html, Whitelist.basic());
			HttpSession session = request.getSession();
			session.setAttribute("content", html); //passing as parameter is not working										
			RequestDispatcher view = request.getRequestDispatcher("/preview.jsp");
			view.forward(request, response);					
		}			
}
