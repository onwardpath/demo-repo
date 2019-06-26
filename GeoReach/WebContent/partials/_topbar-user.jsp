<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.model.User" %>
<!--begin: User Bar -->
<div class="kt-header__topbar-item kt-header__topbar-item--user">
    <div class="kt-header__topbar-wrapper" data-toggle="dropdown" data-offset="0px, 0px">
        <div class="kt-header__topbar-user">
            <span class="kt-header__topbar-welcome kt-hidden-mobile">Hi,</span> 
            <span class="kt-header__topbar-username kt-hidden-mobile">
            <%
            if (session != null) {
            	String username = ((User) session.getAttribute("user")).getFirstname();
                if (username != null) {%>
                	<%=username%>	                            
            	<%}   
            }
            %>         
            </span> 
            <img alt="Pic" src="./assets/media/users/300_25.jpg" />
            <!--use below badge element instead the user avatar to display username's first letter(remove kt-hidden class to display it) -->
            <span class="kt-badge kt-badge--username kt-badge--lg kt-badge--brand kt-hidden kt-badge--bold">S</span> 
        </div>
    </div>
    <div class="dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm">
        <jsp:include page="_dropdown-user-solid.jsp" />
    </div>
</div>
<!--end: User Bar -->