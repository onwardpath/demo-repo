<%
String view = request.getParameter("view");
%>
<jsp:include page="partials/_header-base-mobile.jsp" />
<!-- begin:: Root -->
<div class="kt-grid kt-grid--hor kt-grid--root">
    <!-- begin:: Page -->
    <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--ver kt-page">
        <jsp:include page="partials/_aside-base.jsp" />
        <!-- begin:: Wrapper -->
        <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor kt-wrapper" id="kt_wrapper">
            <jsp:include page="partials/_header-base.jsp" />
            <div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">
                <jsp:include page="partials/_subheader-subheader-v1.jsp" />                
                <jsp:include page="partials/_content-base.jsp" />                
                <% if(view != null && !view.equals("index")) { %>      
                	<jsp:include page="<%=view%>" />   
                <% } %>             	
            </div>
            <jsp:include page="partials/_footer-base.jsp" />
        </div>
        <!-- end:: Wrapper -->
    </div>
    <!-- end:: Page -->
</div>
<!-- end:: Root -->
<!-- begin:: Topbar Offcanvas Panels -->
<jsp:include page="partials/_offcanvas-quick-actions.jsp" />
<!-- end:: Topbar Offcanvas Panels -->
<jsp:include page="partials/_layout-quick-panel.jsp" />
<jsp:include page="partials/_layout-scrolltop.jsp" />
<!-- jsp:include page="partials/_layout-toolbar.jsp" / -->
<!-- jsp:include page="partials/_layout-demo-panel.jsp" / -->