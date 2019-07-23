<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map,com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
	ExperienceRepository experienceRepository = new ExperienceRepository();
	UserRepository userRepository = new UserRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	Map<Integer,Experience> orgContentExperiences = experienceRepository.getOrgContentExperiences(org_id);
	
	if (orgContentExperiences.size() == 0) {%>
		<div class="alert alert-light alert-elevate" role="alert">
			<div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
				<div class="alert-text">
				No Content Experience Available for your Organization. Create a new Content Experience <a class="kt-link kt-font-bold" href="?view=pages/experience-create-content.jsp">here</a>.
			</div>
		</div>
	<%} else {%>
		<div class="kt-portlet kt-portlet--mobile"><!-- begin::portlet -->
			<div class="kt-portlet__head"><!-- begin::portlet-head -->
				<div class="kt-portlet__head-label">
					<h3 class="kt-portlet__head-title">
						Your Content Experiences
					</h3>
				</div>
			</div><!-- end::portlet-head -->				
			<div class="kt-portlet__body"><!-- begin::portlet-body -->												
					<%for ( Map.Entry<Integer, Experience> eentry : orgContentExperiences.entrySet()) {
						Integer id = eentry.getKey();
						Experience experience = eentry.getValue();
						User user = userRepository.getUser(experience.getUser_id());
						Map<Integer,Content> contents = experience.getContents();								
						%>																																																		
						<div class="row">							
						    <div class="col">
						        <div class="alert alert-light alert-elevate fade show" role="alert">						            		            		          
						            <div class="alert-text">						            	
					            		<i class="fa fa-cocktail kt-font-brand"></i>
						            	<h3><%=experience.getName()%></h3>							            
										<img alt="Pic" src="<%=user.getProfile_pic()%>" class="rounded-circle" style="width: 50px;"/>
										<%=user.getFirstname()%>&nbsp;<%=user.getLastname()%>
										<br><br>																				
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
					    				<div><!-- begin::cards-container -->							
										<%for ( Map.Entry<Integer, Content> ientry : contents.entrySet()) {
											Integer key = ientry.getKey();
											Content content = ientry.getValue();
											%>							
											<!-- begin::card -->
											<div class="d-inline-block">	
												<div class="card">
													<div class="card-body">																							    		
											    		<%=content.getContent()%>			    					    	
											  		</div>
											  		<div class="card-footer">
												      <h5 class="card-title"><%=content.getSegmentName()%></h5>
												    </div>
												</div>		
										  	</div><!-- end::card -->						  																		
										<%}%>						
										<br><br>																																																						
										</div><!-- end::cards-container -->																	                		          
							            <!-- begin::Button trigger modal -->
							            &nbsp;&nbsp;
										<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter<%=id%>">
											View Code
										</button>
										<button type="button" class="btn btn-outline-brand">
											Edit
										</button>
										<!-- end::Button trigger modal -->
									</div>
						        </div>
						    </div>						    						    						    						    						
						</div>							
						<!-- begin::modal -->		
						<div class="kt-section__content kt-section__content--border">			
							<!-- Modal -->
							<div class="modal fade" id="exampleModalCenter<%=id%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">						
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalCenterTitle">
											Embed Code for <span class="badge badge-secondary"><%=experience.getName()%></span>											
											</h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">×</span>
											</button>
										</div>
										<div class="modal-body">														 											 
											<code>&lt;div id="G-<%=experience.getName()%>-<%=id%>"&gt;&lt;/div&gt;</code>											
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