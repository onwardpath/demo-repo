<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.model.*" %>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">			
	<%	
	int org_id = (Integer)session.getAttribute("org_id");
	User user = (User) session.getAttribute("user");
	%>	
	<div class="kt-portlet kt-portlet--mobile"><!-- begin::portlet -->
		<div class="kt-portlet__head"><!-- begin::portlet-head -->
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">
					Settings
				</h3>
			</div>
		</div><!-- end::portlet-head -->				
		<div class="kt-portlet__body"><!-- begin::portlet-body -->
			<form class="kt-form kt-form--label-right" id="dummy-form">
			
				<!-- Organization Settings -->							
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Organization</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input type="text" class="form-control" aria-describedby="emailHelp" placeholder="<%=user.getOrganization_name()%>" readonly>
					</div>
				</div>
							
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Domain</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input type="text" class="form-control" aria-describedby="emailHelp" placeholder="<%=user.getOrganization_domain()%>" readonly>
					</div>
				</div>
									
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Embed Code</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<code>&lt;script&gt;function geo() { 
							var u = new URL(window.location.href); 
						    var c = u.searchParams.get("simulate"); 
						    var s = "http://demo.onwardpath.com/GeoTargetService/a/g/g?o=1&simulate="+c+"&url="+u.toString(); 
						    var x = new XMLHttpRequest(); 
						    console.log(s); 
						    x.responseType = 'json'; 
						    x.onreadystatechange = function() { 
							    if (this.readyState == 4 && this.status == 200) {
							        let data = this.response;
							   		var length = x.getResponseHeader("X-Json-Length");
							       	for(var i = 1; i <= length; i++) {
							       		var e=document.getElementById(data[i].divid);
							       		if (e != null)	 
							            	e.innerHTML = data[i].embedCode; 
							       	}
							    } 
							}; 
							x.open("GET", s);
							x.send(); 
						} 
						window.onload = geo;&lt;/script&gt;</code>
						<br><br><button type="button" class="btn btn-outline-brand">Copy</button>
					</div>
					
				</div>	
				
				<!-- User Settings -->																																																																							
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">First Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input type="text" class="form-control" aria-describedby="emailHelp" placeholder="<%=user.getFirstname()%>">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Last Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input type="text" class="form-control" aria-describedby="emailHelp" placeholder="<%=user.getLastname()%>">
					</div>
				</div>	
				
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Profile Picture</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<img alt="Pic" src="<%=user.getProfile_pic()%>"/>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Email</label>
					<div class="col-lg-4 col-md-9 col-sm-12">																								
						<input type="text" class="form-control" aria-describedby="emailHelp" placeholder="<%=user.getEmail()%>" readonly>
					</div>
				</div>
										
			</form>
																																																																																																																	
			</div><!-- end::portlet-body -->
		</div>					
</div>
<!-- end:: Content -->	