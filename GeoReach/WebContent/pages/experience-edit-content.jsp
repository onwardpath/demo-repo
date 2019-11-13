<%@page import="com.onwardpath.georeach.repository.SegmentRepository"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.helper.ExperienceHelper" %>
 <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
 %>
 
<script src="./js/experience-edit.js"></script>  
<% pageContext.setAttribute("newLineChar", "\n");
String id= request.getParameter("id");
ExperienceHelper expHelper = new ExperienceHelper();

SegmentRepository segmentRepository = new SegmentRepository();
int org_id = (Integer)session.getAttribute("org_id");

%>
<c:set var="all_segements" value="<%=segmentRepository.getOrgSegments(org_id) %>" />
<c:set var="experience_contents" value="<%=expHelper.experienceContent(id) %>" />
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
 
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Edit Content Experience</h3>
			</div>
		</div>
		<div class="kt-portlet__body">
			
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
				<div class="col-lg-4 col-md-9 col-sm-12">															
					<input name="name" id="nameExp" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name" value='<%=request.getParameter("exp_name")%>'>	
					<!-- <script>document.getElementById("nameExp").value =sessionStorage.getItem("exp_name");</script> -->
					 
					<!-- <span class="form-text text-muted">Name for this experience</span> -->					
				</div>
			</div>
			 <form class="kt-form kt-form--label-right" id="experience-form" >
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
				<div class="col-lg-4 col-md-9 col-sm-12">											
					<select id="segment" class="custom-select form-control" data-width="300" onchange="javascript:selectIndex()">
						 <c:forEach items="${all_segements}" var="segment" >
							<option value="${segment.key}">${segment.value} </option>
						</c:forEach>								
					</select>																																							
				</div>
			</div> 
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Content (Text/HTML)</label>
				<div class="col-lg-4 col-md-9 col-sm-12">																								
					<textarea id="content" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Enter Text" rows="" cols=""></textarea>
					
				</div>
			</div>
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
				<div class="col-lg-4 col-md-9 col-sm-12">																					
					<button type="reset" id="realValue" class="btn btn-accent" onclick="javascript:add(event)" value="Add" >Add</button>
				</div>
			</div>     
			<c:forEach items="${experience_contents}" var="content">
			<c:if test ="${not empty content.segmentName }">
			<div id="${content.segmentName}" class="card-body">Edit Data&nbsp;
				<button type="button" id="changeText" class="btn btn-outline-info btn-pill" onclick="edit('${content.id}')" > 
					<i class="kt-menu__link-icon la flaticon2-edit"><span></span></i> 
				</button> &nbsp;
				<button type="button" class="btn btn-outline-info btn-pill" onclick="remove('${content.segmentName}','${content.id}')">${content.segmentName}<i class="la la-close"></i></button>
				<script> expDetailsObj[escape('${content.id}')]= '${fn:replace(content.content, newLineChar, " ")}'</script> 
			</div>
			</c:if>
			</c:forEach>	
 
			<div class="kt-separator kt-separator--border-dashed"></div>
			<div class="kt-separator kt-separator--height-sm"></div>
			
			<div class="kt-section__content kt-section__content--border">				
				<div id="stages" style="display: none;">																																																																																																										
				</div>
			</div>
					
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Page Address</label>
				<div class="col-lg-4 col-md-9 col-sm-12">															
					<input name="url" id="url" type="text" class="form-control" aria-describedby="url" placeholder="URL">	
					<span class="form-text text-muted">Enter the URL of the page that will display this experience</span>					
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
				<div class="col-lg-4 col-md-9 col-sm-12">																					
					<button type="reset" class="btn btn-accent" onclick="javascript:preview()">Preview</button>																									
					<button type="reset" class="btn btn-accent" id="urladdname" onclick="javascript:addEx()" value="Add">Add</button>
				</div>
			</div>
					
					
			<c:forEach items="${experience_contents}" var="content">
			<c:if test ="${empty content.segmentName }">
			<div id="${content.id}" class="card-body">Edit Data&nbsp;
				<button type="button" id="changeText" class="btn btn-outline-info btn-pill" onclick="editurl('${content.id}')" > 
					<i class="kt-menu__link-icon la flaticon2-edit"><span></span></i> 
				</button> &nbsp;
				<button type="button" id="button_remove_${content.id}" class="btn btn-outline-info btn-pill" onclick="removeurl('${content.id}')">${content.content}
					<i class="la la-close"></i>
				</button>
			</div>
			<script> cfgDetailsObj['${content.id}']= '${content.content}'</script>
			</c:if>
			</c:forEach>
			<div class="kt-separator kt-separator--border-dashed"></div>
			<div class="kt-separator kt-separator--height-sm"></div>
			
			<div class="kt-section__content kt-section__content--border">				
				<div id="sta" style="display: none;">																																																																																																										
				</div>
			</div>

			<div class="kt-portlet__body">															
			<div class="form-group row"> 
			
			 
				<label class="col-form-label col-lg-3 col-sm-12"></label>					
				<div class="col-lg-4 col-md-9 col-sm-12">
					<input type="hidden" id="form-pagename" name="pageName" value="edit-experience">
					<input type="hidden" id="form-contentdetails" name="experienceDetails">
					<input type="hidden" id="form-urldetails" name="urlList">
					<input type="hidden" id="form-expname" name="expName">  
					<input type="hidden" id="form-expid" name="expid" value='<%=id%>'>		
					<button type="button" class="btn btn-primary" onclick="saveExperience()">Save</button>&nbsp;
					<button type="button" class="btn btn-secondary" onclick="cancelOperation()">Cancel</button>
				</div>  
				 </div>
				 </div> 
			</form>							
		</div>										
	</div>
</div>	

 