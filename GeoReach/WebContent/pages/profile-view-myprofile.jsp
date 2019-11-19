<%@page import="com.onwardpath.georeach.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<%
	User user = (User) session.getAttribute("user");
	System.out.println("heyssss:"+user.getOrganization_id());     
     %>
     
    
      <script type="text/javascript">
      $(document).ready(function(){
      $('#password, #confirm_password').on('keyup', function () {
    	  if ($('#password').val() == $('#confirm_password').val()) {
    	    $('#message').html('Matching').css('color', 'green');
    	  } else 
    	    $('#message').html('Not Matching').css('color', 'red'); 
    	});
        
      $(".toggle-password").click(function() {

		  $(this).toggleClass("fa-eye fa-eye-slash");
		  var input = $($(this).attr("toggle"));
		  if (input.attr("type") == "password") {
		    input.attr("type", "text");
		  } else {
		    input.attr("type", "password");
		  }
		});    
      });
      
       var loadFile = function(event) {
    		var image = document.getElementById('output');
    		image.src = URL.createObjectURL(event.target.files[0]);
    	};  
    	
    	

    	function validatePassword(){
    		var password = document.getElementById("passwords")
       	    var confirm_password = document.getElementById("confirm_password"); 
    		
    	  if(password.value != confirm_password.value) {
    	    confirm_password.setCustomValidity("Passwords Don't Match");
    	  } else {
    		if (password){
    		 document.getElementById("password").value=password
    		}
    	    confirm_password.setCustomValidity('');
    	  }
    	} 
      	  	
</script>                

	
					<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
					<%
		String message = (String) session.getAttribute("message");
		if (message != null && !message.equals("")) {
			String icon = "la la-thumbs-up";
			if (message.startsWith("Error"))
				icon = "flaticon-warning";
	%>
	<div class="row">
		<div class="col">
			<div class="alert alert-light alert-elevate fade show" role="alert">
				<div class="alert-icon">
					<i class="<%=icon%> kt-font-brand"></i>
				</div>
				<div class="alert-text">
					<%=message%>
				</div>
			</div>
		</div>
	</div>
	<%
		session.setAttribute("message", "");
		}
	%>  
						<div class="row">
						<div class="col-lg-12">
							<!--begin::Portlet-->
							<form class="kt-form" id="kt_form" action="UserController" method="post" class="needs-validation" enctype="multipart/form-data">
							<input type="hidden" name="pageName" value="profile">
							 <input type="hidden" name="role" value="1">  
							    <input type="hidden" name="orgid" value="<%=user.getOrganization_id()%>">  
								<div class="kt-portlet__body">																																		
										<div class="row">
											<div class="col-xl-2"></div>
											<div class="col-xl-8">
												<div class="kt-section kt-section--first">
													<div class="kt-section__body">
														<h3 class="kt-section__title kt-section__title-lg">Profile Info:</h3>
																																																																			
													
															
															
																																													
															<div class="kt-separator kt-separator--border-dashed kt-separator--space-lg"></div>
															
															<!-- USER DETAILS -->																													
															<div class="form-group row">
																<label class="col-3 col-form-label">First Name</label>
																<div class="col-9">
																	<input class="form-control" type="text" name="firstName" placeholder="First Name" required  value="<%=user.getFirstname()%>">
																</div>
															</div>
															<div class="form-group row">
																<label class="col-3 col-form-label">Last Name</label>
																<div class="col-9">
																	<input class="form-control" type="text" name="lastName" placeholder="Last Name" required value="<%=user.getLastname()%>">
																</div>
															</div>
																 																												
															<div class="form-group row">
																<label class="col-3 col-form-label">Contact Phone</label>
																<div class="col-9">
																	<div class="input-group">
																		<div class="input-group-prepend"><span class="input-group-text"><i class="la la-phone"></i></span></div>
																		<input type="text" class="form-control" name="phone" placeholder="Phone" aria-describedby="basic-addon1" value="<%=user.getPhone1()%>">
																	</div>																	
																</div>
															</div>
																
															<div class="form-group row">
																<label class="col-3 col-form-label">Email Address</label>
																<div class="col-9">
																	<div class="input-group">
																		<div class="input-group-prepend"><span class="input-group-text"><i class="la la-at"></i></span></div>
																		<input type="text" class="form-control" name="email" placeholder="Email" aria-describedby="basic-addon1" required value="<%=user.getEmail()%>" disabled="disabled">
																	</div>
																</div>
															</div>
															 
															 
															<div class="form-group row">
																<label class="col-3 col-form-label">Profile Photo</label>
																<div class="col-9">
																	<div class="input-group">
																		
																		<input type="file" class="form-control"  name="photo"  aria-describedby="basic-addon1" accept="image/*"  onchange="loadFile(event)" >
																		<img alt="Pic" id ="output" src='/GeoReach/DisplayImageController?id=<%=session.getAttribute("user_id")%>' height="100" width="100"/>
																	</div>
																</div>
																 
															</div> 
															 
															<div class="form-group row">
																<label class="col-3 col-form-label">Password</label>
																<div class="col-9">
																<div class="input-group">
																	<input class="form-control" id="password-field" type="password" name="password" required value="<%=user.getPassword()%>"  disabled="disabled" >
																	</br></br><span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
																	</div>
																	
																</div> 
																
															</div>	
															
															<div class="form-group row">
																<label class="col-3 col-form-label">New Password</label>
																<div class="col-9">
																	<div class="input-group">
																		
																		 <input id="passwords"  type="password" class="form-control" name="password" >
                                                                         
																	</div>																	
																</div>
															</div>
															 
															<div class="form-group row">
																<label class="col-3 col-form-label">Confirm Password</label>
																<div class="col-9">
																	<div class="input-group">
																		
																		 <input id="confirm_password" type="password" class="form-control" name="password" >
                                                                          
																	</div>																	
																</div>
															</div> 
															  
															<div class="form-group form-group-last row"> 
																
																<button type="submit" class="btn btn-primary" onclick="validatePassword()">Update</button>&nbsp;
					                          
															</div>	   																																																																																																																																																																																																																											
													</div>
												</div>																							
											</div>
											<div class="col-xl-2"></div>
										</div>
										
									</form>
								</div>
							</div>
							<!--end::Portlet-->
						</div>  
					

		