<%@ page import="com.onwardpath.georeach.model.User" %>
<%
	String fname = ((User) session.getAttribute("user")).getFirstname();
	String lname = ((User) session.getAttribute("user")).getLastname();
%>
<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}
</script>            
<div class="kt-user-card kt-margin-b-40 kt-margin-b-30-tablet-and-mobile" style="background-image: url(./assets/media/misc/head_bg_sm.jpg)">
    <div class="kt-user-card__wrapper">
        <div class="kt-user-card__pic">
            <img alt="Pic" src="./assets/media/users/300_21.jpg" />
        </div>
        <div class="kt-user-card__details">
            <div class="kt-user-card__name"><%=fname%> <%=lname%></div>
            <div class="kt-user-card__position"></div>
        </div>
    </div>
</div>
<ul class="kt-nav kt-margin-b-10">
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-calendar-3"></i></span>
            <span class="kt-nav__link-text">My Profile</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-browser-2"></i></span>
            <span class="kt-nav__link-text">My Tasks</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-mail"></i></span>
            <span class="kt-nav__link-text">Messages</span> 
        </a>
    </li>
    <li class="kt-nav__item">
        <a href="?page=custom/user/profile-v1" class="kt-nav__link">
            <span class="kt-nav__link-icon"><i class="flaticon2-gear"></i></span>
            <span class="kt-nav__link-text">Settings</span> 
        </a>
    </li>
    <li class="kt-nav__item kt-nav__item--custom kt-margin-t-15">
    	<form name="logout" action="UserController" method="post">
		<input type="hidden" name="pageName" value="logout">
		</form>
    	<a href="javascript:submitform()" class="btn btn-label-brand btn-upper btn-sm btn-bold">Sign Out</a>     	
    </li>
</ul>