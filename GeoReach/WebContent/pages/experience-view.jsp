
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<%@ page import="java.util.Map" %>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
		<%
			//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
			SegmentRepository segmentRepository = new SegmentRepository();
			UserRepository userRepository = new UserRepository();
			int org_id = (Integer)session.getAttribute("org_id");
			Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegments(org_id);
			
			if (orgSegments.size() == 0) {
				%>
				<div class="alert alert-light alert-elevate" role="alert">
					<div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
						<div class="alert-text">
						No Segments Available for your Organization. Create a new segment <a class="kt-link kt-font-bold" href="?view=segment-create.jsp">here</a>.
					</div>
				</div>
				<%
					
			} else {
				%>
				<div class="kt-portlet kt-portlet--mobile">
						<div class="kt-portlet__head">
							<div class="kt-portlet__head-label">
								<h3 class="kt-portlet__head-title">
									Your Segments
								</h3>
							</div>
						</div>
						
						<div class="kt-portlet__body">			
							<!--begin: Datatable -->
							<table class="table table-striped- table-bordered table-hover table-checkable" id="kt_table_1">
								<thead>
									<tr>
										<th>Name</th>
										<th>Geography</th>
										<th>Created By</th>
										<th>Create Date</th>
										<th>Last Updated By</th>
										<th>Last Updated Date</th>										
										<th>Status</th>										
										<th>Actions</th>
									</tr>
								</thead>								
								<%
								for ( Map.Entry<Integer, Segment> entry : orgSegments.entrySet()) {
									Integer key = entry.getKey();
									Segment val = entry.getValue();
									User user = userRepository.getUser(val.getUser_id());
								    %>
				    			<tbody>
									<tr>
										<td><%=val.getName()%></td>
										<td><%=val.getGeography()%></td>
										<td><%=user.getFirstname()%>&nbsp;<%=user.getLastname()%></td>
										<td>1/2/2019</td>
										<td>123</td>
										<td>123</td>
										<td>Active</td>
										<td nowrap></td>
									</tr>
								</tbody>
								<%
								}
								%>																				
							</table>
							<!--end: Datatable -->
						</div>
					</div>
				    <%				    				   					
			}			
		%>
	
</div>
<!-- end:: Content -->	