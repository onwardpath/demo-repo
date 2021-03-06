
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>


<!-- begin::Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
		<%
			//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
			SegmentRepository segmentRepository = new SegmentRepository();
			UserRepository userRepository = new UserRepository();
			int org_id = (Integer)session.getAttribute("org_id");
			//Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegments(org_id);
			Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegmentsByType(org_id,"beh");
			
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
									Your Behavior Segments
								</h3>
							</div>
						</div>
						
						<div class="kt-portlet__body">
						<div class="row">
      						<div class="col-sm-12">
         						<table class="table table-striped- table-bordered table-hover table-checkable kt_table_1" id="kt_table_2">			
							<!--begin: Datatable -->
						
								<thead>
									<tr role="row">
										<th class="sorting_asc" tabindex="0" aria-controls="kt_table_1" aria-sort="ascending">Name</th>
										<th class="sorting" tabindex="0" aria-controls="kt_table_1">Geography</th>
										<th class="sorting"tabindex="0" aria-controls="kt_table_1">Created By</th>
										<th class="sorting" tabindex="0" aria-controls="kt_table_1">Created On</th>																
										<th class="sorting_disabled" tabindex="0" aria-controls="kt_table_1">Actions</th>
									</tr>
								</thead>								
								
				    			<tbody>
				    			<%
								for ( Map.Entry<Integer, Segment> entry : orgSegments.entrySet()) {
									Integer key = entry.getKey();
									Segment segment = entry.getValue();
									User user = userRepository.getUser(segment.getUser_id());
								    %>
									<tr>
										<td><%=segment.getName()%></td>
										<td>
										<%	
										//TODO: Update to include new format 																				
										//beh{include:visit:equals:10|include:session:equals:60}
										//beh{include:visit:equals:10|include:session:equals:60}
										
										//<option value="equals">Equals</option>
										//<option value="more">More than</option>
										//<option value="less">Less than</option>
										
										
										String segmentRules = segment.getGeography(); 
										//Remove "beh{" and "}"
										if (segmentRules.indexOf("}") !=0) {
											int beginIndex = segmentRules.indexOf("{")+1;
											int endIndex = segmentRules.indexOf("}");											
											segmentRules = segmentRules.substring(beginIndex, endIndex);
										}
										String [] rule = segmentRules.split("\\|"); 
										for(String a:rule) {
											String[] criteria = a.split(":");
											String display = "";
											String label = criteria[1]+" "+criteria[2]+" "+criteria[3];
											
											if (criteria[0].startsWith("include")) {												
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-info btn-pill'><i class='fa fa-user-clock'></i>"+label+"&nbsp;</button>";	
											} else {
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-danger btn-pill'><i class='fa fa-user-clock'></i>"+label+"&nbsp;</button>";
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
										<form id="form-<%=key%>">
					                    <input type="hidden" name="seg_id" value="<%=segment.getId()%>"/>
					                    <input type="hidden" name="seg_name" value="<%=segment.getName()%>"/>
					                    <input type="hidden" name="result_page" value="pages/segment-view-behavior.jsp"/>																				
										<button type='button' class="btn btn-outline-secondary btn-icon"><i class="fa fa-tools"></i></button>&nbsp;
										<button type='button' class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter" onclick="getsegmentname(<%=segment.getId()%>)"><i class="fa fa-trash-alt"></i></button>
										  
										<!-- Modal -->
						<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalCenterTitle">Are you sure to delete Segment</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">�</span>
										</button>
									</div>
									<div class="modal-body">
										<p id="segmentTitle"><b><%=segment.getName()%></b></p> 
									</div>
									 
									<div class="modal-footer">
										<button type="button" class="btn btn-outline-brand"  id="segmentId"  value="<%=segment.getId()%>" onclick="deletesegment(<%=segment.getId()%>)">Yes</button>
										<button type="button" class="btn btn-outline-brand" data-dismiss="modal">No</button>     
									</div>     
									     
								</div>
							</div>
						</div>
					 
										</form>																																				
										</td>
									</tr>
									<%}%>
								</tbody>
																												
							</table>
							<!--end: Datatable -->
						</div>
					</div>
				    <%				    				   					
			}			
		%>
	
</div>
</div>
</div>
<!-- end:: Content -->	