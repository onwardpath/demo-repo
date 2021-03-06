<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.model.User" %>



<%
String username = "";
String profilepic = "";	
 
	
int ids = ((User) session.getAttribute("user")).getOrganization_id();

    
   
  

if ((User) session.getAttribute("user") != null) {
	username = ((User) session.getAttribute("user")).getFirstname();
	profilepic = ((User)session.getAttribute("user")).getProfile_pic();
}
%>
<!--begin: User Bar -->


<div id="user" class="kt-header__topbar-item kt-header__topbar-item--user">
    <div id="expand" class="kt-header__topbar-wrapper" data-toggle="dropdown" data-offset="0px, 0px">
        <div class="kt-header__topbar-user" onclick="loading()"> 
            <span class="kt-header__topbar-welcome kt-hidden-mobile">Hi,</span> 
            <span class="kt-header__topbar-username kt-hidden-mobile">              
                <%=username%>	                                        	                   
            </span>   
            <%  
            if (!username.equals("") && profilepic.equals("")) {
            	%>
            	<!--use below badge element instead the user avatar to display username's first letter(remove kt-hidden class to display it) -->
            	<span class="kt-badge kt-badge--username kt-badge--lg kt-badge--brand kt-badge--bold">
            	<%=username.charAt(0)%>
            	</span>
            	<%	
            } else if(!profilepic.equals("")) {
            	%>
            	<img alt="Pic" src='/GeoReach/DisplayImageController?id=<%=session.getAttribute("user_id")%>'/>
            	<% 
            }            
            %>                                    
        </div> 
    </div>
    <div id="show" class="dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm">
        <jsp:include page="_dropdown-user-solid.jsp" />
    </div>
</div>

<!--end: User Bar -->