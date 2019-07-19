
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
		<%
			//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
			SegmentRepository segmentRepository = new SegmentRepository();
			UserRepository userRepository = new UserRepository();
			int org_id = (Integer)session.getAttribute("org_id");
			//Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegments(org_id);
			Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegmentsByType(org_id,"int");
			
			if (orgSegments.size() == 0) {
				%>
				<div class="alert alert-light alert-elevate" role="alert">
					<div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
						<div class="alert-text">
						No Segments Available for your Organization. Create a new segment <a class="kt-link kt-font-bold" href="?view=pages/segment-create-geo.jsp">here</a>.
					</div>
				</div>
				<%
					
			} else {
				%>
				<div class="kt-portlet kt-portlet--mobile">
						<div class="kt-portlet__head">
							<div class="kt-portlet__head-label">
								<h3 class="kt-portlet__head-title">
									Your Interest Segments
								</h3>
							</div>
						</div>
						
						<div class="kt-portlet__body">			
							<!--begin: Datatable -->
							<table class="table table-striped- table-bordered table-hover table-checkable" id="kt_table_1">
								<thead>
									<tr>
										<th>Name</th>
										<th>Interest</th>
										<th>Created By</th>
										<th>Created On</th>																
										<th>Actions</th>
									</tr>
								</thead>								
								<%
								for ( Map.Entry<Integer, Segment> entry : orgSegments.entrySet()) {
									Integer key = entry.getKey();
									Segment segment = entry.getValue();
									User user = userRepository.getUser(segment.getUser_id());
								    %>
				    			<tbody>
									<tr>
										<td><%=segment.getName()%></td>
										<td>
										<%	
										//TODO: Update to include new format 																													
										//int{include:visit:equals:1:onwardpath.com/packers-info}
										
										
										//<option value="include">Include</option>
										//<option value="exclude">Exclude</option>
										
										//<option value="visit">Visits</option>
										//<option value="session">Session Duration</option>
										
										//<option value="equals">Equals</option>
										//<option value="more">More than</option>
										//<option value="less">Less than</option>
										
										String segmentRules = segment.getGeography(); 
										//Remove "int{" and "}"
										if (segmentRules.indexOf("}") !=0) {
											int beginIndex = segmentRules.indexOf("{")+1;
											int endIndex = segmentRules.indexOf("}");											
											segmentRules = segmentRules.substring(beginIndex, endIndex);
										}
										String [] rule = segmentRules.split("\\|"); 
										for(String a:rule) {
											String[] criteria = a.split(":");
											String display = "";
											String label = criteria[4];
											
											if (criteria[0].startsWith("include")) {												
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-info btn-pill'><i class='fab fa-gratipay'></i>"+label+"&nbsp;</button>";	
											} else {
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-danger btn-pill'><i class='fab fa-gratipay'></i>"+label+"&nbsp;</button>";
											}																				
											%>											
											<%=display%>
										<%}%>
										<!-- 
										include:City:Test2|include:City:Test3										
										 -->										
										</td>
										<td><%=user.getFirstname()%>&nbsp;<%=user.getLastname()%></td>
										<td>1/2/2019</td>										
										<td nowrap>																				
										<button type='button' class="btn btn-outline-secondary btn-icon"><i class="fa fa-tools"></i></button>&nbsp;
										<button type='button' class="btn btn-outline-secondary btn-icon"><i class="fa fa-trash-alt"></i></button>																																					
										</td>
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