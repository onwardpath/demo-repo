<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map,com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
	ExperienceRepository experienceRepository = new ExperienceRepository();
	UserRepository userRepository = new UserRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	Map<Integer,Experience> orgImageExperiences = experienceRepository.getOrgImageExperiences(org_id);
	
	if (orgImageExperiences.size() == 0) {%>
		<div class="alert alert-light alert-elevate" role="alert">
			<div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
				<div class="alert-text">
				No Image Experience Available for your Organization. Create a new Image Experience <a class="kt-link kt-font-bold" href="?view=pages/experience-create.jsp">here</a>.
			</div>
		</div>
	<%} else {%>
		<div class="kt-portlet kt-portlet--mobile"><!-- begin::portlet -->
			<div class="kt-portlet__head"><!-- begin::portlet-head -->
				<div class="kt-portlet__head-label">
					<h3 class="kt-portlet__head-title">
						Your Image Experiences
					</h3>
				</div>
			</div><!-- end::portlet-head -->				
			<div class="kt-portlet__body"><!-- begin::portlet-body -->												
					<%for ( Map.Entry<Integer, Experience> eentry : orgImageExperiences.entrySet()) {
						Integer id = eentry.getKey();
						Experience experience = eentry.getValue();
						User user = userRepository.getUser(experience.getUser_id());
						Map<Integer,Image> images = experience.getImages();								
						%>																																																		
						<div class="row">
							<!-- begin::view code -->
						    <div class="col">
						        <div class="alert alert-light alert-elevate fade show" role="alert">
						            <div class="alert-icon"></div>		            		           
						            <div class="alert-text">
						            	<div class="d-inline-block">
						            		<i class="flaticon-paper-plane kt-font-brand"></i>
							            	<h3><%=experience.getName()%></h3>							            
											<!--strong><mark><%=experience.getType()%></mark></strong -->											
											<div>						            																				
												<span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--success">
													<label>
													<%String status = experience.getStatus();
													if (status.equalsIgnoreCase("on")) {%>
														<input type="checkbox" checked="checked" name="">
													<%} else {%>
														<input type="checkbox" name="">
													<%}%>												
													<span></span>
													</label>
												</span>
											</div>
										</div>										
										<div class="kt-user-card" style="border-bottom-style: solid; border-width: 1px; border-color: lightgrey;">
											<div class="kt-user-card__wrapper">
										        <div class="kt-user-card__pic">
										            <img alt="Pic" src="<%=user.getProfile_pic()%>" />
										        </div> 
										        <div class="kt-user-card__details">
										            <div class="kt-user-card__name" style="color: green;"><%=user.getFirstname()%>&nbsp;<%=user.getLastname()%></div>
										            <div class="kt-user-card__position"></div>
										        </div>
										    </div>
										</div>																																	            																																			
					    				<div><!-- begin::cards-container -->							
										<%for ( Map.Entry<Integer, Image> ientry : images.entrySet()) {
											Integer key = ientry.getKey();
											Image image = ientry.getValue();
											%>							
											<!-- begin::card -->
											<div class="d-inline-block">	
												<div class="card">
													<div class="card-body">																							    		
											    		<img src="<%=image.getUrl()%>" class="rounded" >			    					    	
											  		</div>
											  		<div class="card-footer">
												      <h5 class="card-title"><%=image.getSegmentName()%></h5>
												    </div>
												</div>		
										  	</div><!-- end::card -->						  																		
										<%}%>						
										<br><br>																																																						
										</div><!-- end::cards-container -->																	                		          
							            <!-- Button trigger modal -->
							            &nbsp;&nbsp;
										<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter<%=id%>">
											View Code
										</button>
										<button type="button" class="btn btn-outline-brand">
											Edit
										</button>
									</div>
						        </div>
						    </div><!-- end:: view code -->
						    						    						    						    						 
						</div>							
						<!-- begin::modal -->		
						<div class="kt-section__content kt-section__content--border">			
							<!-- Modal -->
							<div class="modal fade" id="exampleModalCenter<%=id%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">						
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalCenterTitle">Embed Code for: <%=experience.getName()%></h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">×</span>
											</button>
										</div>
										<div class="modal-body">														 
											 <h3>Header</h3>
											 <code>
												&lt;!-- Begin::GeoSmart-Header --&gt; 
												&lt;script&gt; 
												function geo() 
												{ 
													var serviceURL = "http://lab01.onwardpath.com/GeoTargetService/app/georeach/get?id=<%=id%>&org_id=<%=org_id%>&s="; 
													var geoElement = document.getElementById("Geo-<%=experience.getName()%>-<%=id%>"); 	
													var url = new URL(window.location.href); 
													var c = url.searchParams.get("s"); 
													serviceURL += c; 
													console.log(serviceURL); 
													var xhttp = new XMLHttpRequest(); 
													xhttp.responseType = 'json'; 
													xhttp.onreadystatechange = function () { 
														if (this.readyState == 4 && this.status == 200) 
														{ 
															var locationbasedImage_element = geoElement.getElementsByTagName('img')[0]; 
															let data = this.response; 
															locationbasedImage_element.src = data[1].url; 
															locationbasedImage_element.parentElement.href = data[1].url; 
														} 
													}; xhttp.open("GET", serviceURL); 
													xhttp.send(); 
												} window.onload = geo; 
												&lt;/script&gt; 
												&lt;!-- End::GeoSmart-Header --&gt;
											</code>
											<h3>Body</h3>
											<code>
												&lt;!-- Begin::GeoSmart-Body --&gt;
												&lt;div id="Geo-<%=experience.getName()%>-<%=id%>"&gt;&lt;/div&gt;
												&lt;!-- End::GeoSmart-Body --&gt;
											</code>
										</div>
										<div class="modal-footer">							
											<button type="button" class="btn btn-outline-brand">Copy</button>
											<button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</div>	
						<!-- end::modal -->																																																										
					<%}%>																															
			</div><!-- end::portlet-body -->
		</div>
	<%}%>					
</div>
<!-- end:: Content -->	