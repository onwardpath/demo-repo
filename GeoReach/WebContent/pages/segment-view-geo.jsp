<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
 <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> 
<%@page import="java.util.*" session ="true" %>
<!-- Modified by Gurujegan - Segment Geo Edit feature --Start-->

<script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
<script type="text/javascript"> 
function edit(id)
{
	var form = document.getElementById("form-"+id);
	sessionStorage.setItem('seg_id', form.seg_id.value);
	sessionStorage.setItem('seg_rule', form.seg_rule.value);
	sessionStorage.setItem('seg_name',  form.seg_name.value);
	form.method = "post";
	form.action = "/GeoReach?view=pages/segment-edit-geo.jsp";
	form.submit();
}
function showmodal(deletemodalid){
	
}

function getsegmentname(id){
	var form = document.getElementById("form-"+id);
	document.getElementById("segmentTitle").innerHTML=form.seg_name.value;
	 
} 

function deletesegment(id){
	

	var form = document.getElementById("form-"+id);
	//sessionStorage.setItem('seg_id', form.seg_id.value);  
	form.method = "POST"; 
	form.action = "/GeoReach/DeleteController";   
	form.submit();                
}    

 
</script>


<!-- Modified by Gurujegan - Segment Geo Edit feature --End-->

<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
		<%
			//TODO: Resolve DataTable issue -- https://datatables.net/forums/discussion/32575/uncaught-typeerror-cannot-set-property-dt-cellindex-of-undefined
			SegmentRepository segmentRepository = new SegmentRepository();
			UserRepository userRepository = new UserRepository();
			int org_id = (Integer)session.getAttribute("org_id");
			//Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegments(org_id);
			Map<Integer,Segment> orgSegments = segmentRepository.loadOrgSegmentsByType(org_id,"loc");
			
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
				
				
				 <c:if test='<%=session.getAttribute("experienceName")!=null %>' >
				 		  
				 		  <c:set var="dependantexperiences" value='<%=session.getAttribute("experienceName")%>'></c:set>
				 		   <div class="modal fade" id="showdependantexperience" tabindex="-1" role="dialog" aria-labelledby="Dependant Experience Title" aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="ModalCenterTitle">This Segment cannot be deleted as it is used in the following Experiences. Please remove the segment from these experiences and then try again</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<ul>
										<c:forEach items="${dependantexperiences}" var="experience" varStatus="counter" >
											<li> <h6>${experience} </h6> </li>
										</c:forEach>
										</ul>
										
									</div>
									    
								</div>
							</div>
						</div>
						<%session.removeAttribute("experienceName");%>
						<c:remove var="dependantexperiences"/>
						    
				</c:if>
				<div class="kt-portlet kt-portlet--mobile">
						<div class="kt-portlet__head">
							<div class="kt-portlet__head-label">
								<h3 class="kt-portlet__head-title">
									Your Geo Segments
								</h3>
							</div>
						</div>
						
						<div class="kt-portlet__body">			
							<!--begin: Datatable -->
						<div class="row">
      						<div class="col-sm-12">
         						<table class="table table-striped- table-bordered table-hover table-checkable kt_table_1" id="kt_table_1">
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
								     <tr role="row" class="odd">
					<td tabindex="0" class="sorting_1"><%=segment.getName()%></td>
					<td><%
					String segmentRules = segment.getGeography();
										//Remove "loc{" and "}"
										if (segmentRules.indexOf("}") !=0) {
											int beginIndex = segmentRules.indexOf("{")+1;
											int endIndex = segmentRules.indexOf("}");											
											segmentRules = segmentRules.substring(beginIndex, endIndex);
										}
										String [] rule = segmentRules.split("\\|"); 
										for(String a:rule) {
											String[] criteria = a.split(":");
											String display = "";
											if (criteria[0].startsWith("include")) {												
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-info btn-pill'>"+criteria[2]+"&nbsp;<i class='fa fa-map-marker-alt'></i></button>";	
											} else {
												display = "<button id='"+segment.getId()+"' type='button' class='btn btn-outline-danger btn-pill'>"+criteria[2]+"&nbsp;<i class='fa fa-map-marker-alt'></i></button>";
											}																				
											%>											
											<%=display%>
										<%}%>
										<!-- 
										include:City:Test2|include:City:Test3										
										 -->									
					</td>
					<td><%=user.getFirstname()%>&nbsp;<%=user.getLastname()%></td>
					<td>1/9/2019</td>										
					<td nowrap>
					<!-- Modified by Gurujegan - Segment Geo Edit feature --Start-->
					<form id="form-<%=key%>">
					<input type="hidden" name="seg_id" value="<%=segment.getId()%>"/>
					<input type="hidden" name="seg_rule" value="<%=segment.getGeography()%>"/>
					<input type="hidden" name="seg_name" value="<%=segment.getName()%>"/>
					<input type="hidden" name="result_page" value="pages/segment-view-geo.jsp"/>
					<button type="button" class="btn btn-outline-secondary btn-icon" onclick="javascript:edit(<%=segment.getId()%>)"><i class="fa fa-tools"></i></button>&nbsp;
					<!-- <button type="button" class="btn btn-outline-secondary btn-icon"><i class="fa fa-trash-alt"></i></button> -->
					  <%-- <button type="button" class="btn btn-outline-secondary btn-icon" onclick="javascript:deletesegment(<%=segment.getId()%>)"><i class="fa fa-tools"></i></button>&nbsp; --%>
						<!-- Button trigger modal -->   
						<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target='<%="#modal-"+key %>'  onclick="getsegmentname(<%=segment.getId()%>)">
							<i class="fa fa-trash-alt"></i>
						</button> 
						<div class="modal fade" id='<%="modal-"+key%>' tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalCenterTitle">Are you sure to delete Segment</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<p id="segmentTitle"><b><%=segment.getName()%></b></p> 
									</div> 
									 
									<div class="modal-footer">
										<button type="button" class="btn btn-outline-brand"  id="segmentId"   name="kv"  value="<%=segment.getId()%>" onclick="deletesegment('<%=key%>')">Yes</button>
										<button type="button" class="btn btn-outline-brand" data-dismiss="modal">No</button>     
									</div>     
									    
								</div>
							</div>
						</div>   
					      
					</form>    
					<!-- Modified by Gurujegan - Segment Geo Edit feature --End-->										
					</td>
				</tr>	<%
								}
								%>
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