<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
if (null == session.getAttribute("authenticated") || session.getAttribute("authenticated").equals("") || !session.getAttribute("authenticated").equals("true")) { 	
	response.sendRedirect("/GeoReach/login.jsp");
    return;
}
%>  
<!DOCTYPE html>
<html lang="en" >
    <!-- begin::Head -->
    <head>
        <meta charset="utf-8"/>
        <title>GeoReach</title>
        <meta name="description" content="Latest updates and statistic charts">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!--begin::Fonts -->
        <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
        <script>
        WebFont.load({
                google: {
					"families":["Poppins:300,400,500,600,700"]
        		},
                active: function() {
                    sessionStorage.fonts = true;                
                }            
		});        
        </script>
        <!--end::Fonts -->
        <!--begin::Page Vendors Styles(used by this page) -->
        <link href="./assets/vendors/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Page Vendors Styles -->
        <!--begin::Global Theme Styles(used by all pages) -->
        <link href="./assets/vendors/global/vendors.bundle.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/demo1/style.bundle.css" rel="stylesheet" type="text/css" />
        <!--end::Global Theme Styles -->
        <!--begin::Layout Skins(used by all pages) -->
        <link href="./assets/css/demo1/skins/header/base/light.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/demo1/skins/header/menu/light.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/demo1/skins/brand/brand.css" rel="stylesheet" type="text/css" />
        <link href="./assets/css/demo1/skins/aside/navy.css" rel="stylesheet" type="text/css" />
        <!--end::Layout Skins -->
        <!-- link rel="shortcut icon" href="./assets/media/logos/favicon.ico" / -->
    </head>
    <!-- end::Head -->
    <!-- begin::Body -->
    <body class="kt-quick-panel--right kt-demo-panel--right kt-offcanvas-panel--right kt-header--fixed kt-header-mobile--fixed kt-subheader--enabled kt-subheader--transparent kt-aside--enabled kt-aside--fixed kt-page--loading" >        
        <jsp:include page="_layout.jsp" />                    
        <!-- begin::Global Config(global config for global JS sciprts) -->
        <script>            
        var KTAppOptions = {
    		"colors": {
	        	"state": {
		            "brand": "#5d78ff",
		            "metal": "#c4c5d6",
		            "light": "#ffffff",
		            "accent": "#00c5dc",
		            "primary": "#5867dd",
		            "success": "#34bfa3",
		            "info": "#36a3f7",
		            "warning": "#ffb822",
		            "danger": "#fd3995",
		            "focus": "#9816f4"        
        		},
        		"base": {
	            	"label": [
		                "#c5cbe3",
		                "#a1a8c3",
		                "#3d4465",
		                "#3e4466"            
	                ],
	            	"shape": [
		                "#f0f3ff",
		                "#d9dffa",
		                "#afb4d4",
		                "#646c9a"            
		            ]        
        		}    
        	}
        };        
        </script>
        <!-- end::Global Config -->
        <!--begin::Global Theme Bundle(used by all pages) -->
        <script src="./assets/vendors/global/vendors.bundle.js" type="text/javascript"></script>
        <script src="./assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>
        <!--end::Global Theme Bundle -->
        <!--begin::Page Vendors(used by this page) -->
        <script src="./assets/vendors/custom/fullcalendar/fullcalendar.bundle.js" type="text/javascript"></script>
        <!-- using below causes issues with bootstrap-select components -->
        <!-- script src="./assets/vendors/custom/datatables/datatables.bundle.js" type="text/javascript"></script -->        
        <!--end::Page Vendors -->
        <!--begin::Page Scripts(used by this page) -->
        <script src="./assets/js/demo1/pages/dashboard.js" type="text/javascript"></script>
        <script src="./assets/js/demo1/pages/crud/forms/layouts/repeater.js" type="text/javascript"></script>
        <script src="./assets/js/demo1/pages/crud/forms/widgets/bootstrap-select.js" type="text/javascript"></script>
        <!-- using below causes issues with bootstrap-select components -->        
        <!-- script src="./assets/js/demo1/pages/crud/datatables/data-sources/html.js" type="text/javascript"></script>        
        <script src="./assets/js/demo1/pages/crud/datatables/advanced/multiple-controls.js" type="text/javascript"></script -->
        <!--end::Page Scripts -->
    </body>
    <!-- end::Body -->
</html>