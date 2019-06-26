
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<%@ page import="java.util.Map" %>
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
				No Content Experience Available for your Organization. Create a new Content Experience <a class="kt-link kt-font-bold" href="?view=pages/experience-content-create.jsp">here</a>.
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
						<h3><%=experience.getName()%></h3>
						<!--strong><mark><%=experience.getType()%></mark></strong -->	
						Created By: <%=user.getFirstname()%>&nbsp;<%=user.getLastname()%>								
						<div class="custom-control custom-switch">
						  <input type="checkbox" class="custom-control-input" id="customSwitch1">
						  <label class="custom-control-label" for="customSwitch1"><%=experience.getStatus()%></label>
						</div>
						Edit|Delete|Add Segment|View Code	
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
								      <h5 class="card-title">Segment: <%=content.getSegmentName()%></h5>
								    </div>
								</div>		
						  	</div><!-- end::card -->						  																		
						<%}%>						
						<br><br>																																													
						</div><!-- end::cards-container -->						
					<%}%>																															
			</div><!-- end::portlet-body -->
		</div>
	<%}%>					
</div>
<!-- end:: Content -->	