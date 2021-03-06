<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.model.User" %>
<!-- begin:: Header Menu -->
<button class="kt-header-menu-wrapper-close" id="kt_header_menu_mobile_close_btn"><i class="la la-close"></i></button>
<div class="kt-header-menu-wrapper" id="kt_header_menu_wrapper">
    <div id="kt_header_menu" class="kt-header-menu kt-header-menu-mobile kt-header-menu--layout-default">
    	<ul class="kt-menu__nav ">
    		<li class="kt-menu__item kt-menu__item--submenu kt-menu__item--rel kt-menu__item--active" data-ktmenu-submenu-toggle="click" aria-haspopup="true">
    		<a href="javascript:;" class="kt-menu__link kt-menu__toggle">
    			<span class="kt-menu__link-text">
    	    	<%
	            if (session.getAttribute("user") != null) {
	            	String orgName = ((User) session.getAttribute("user")).getOrganization_name();
	                if (orgName != null) {%>
	                	<%=orgName%>	                            
	            	<%}   
	            }
	            %>   		
    			</span>
    			<!-- i class="kt-menu__hor-arrow la la-angle-down"></i><i class="kt-menu__ver-arrow la la-angle-right"></i -->
   			</a>
    		</li>
    	</ul>        
    </div>
</div>
<!-- end:: Header Menu -->