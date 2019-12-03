<%@page import="com.onwardpath.georeach.repository.SegmentRepository"
%><%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
%><%@ page import="java.util.Map, com.onwardpath.georeach.helper.ExperienceHelper" 
%><%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" 
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" 
%>

<%

pageContext.setAttribute("newLineChar", "\n");
String id= request.getParameter("id");
ExperienceHelper expHelper = new ExperienceHelper();
SegmentRepository segmentRepository = new SegmentRepository();
int org_id = (Integer)session.getAttribute("org_id");
%>
<script>
var expDetailsObj 	= 	{};
var cfgDetailsObj 	= 	{};
</script>
 
<script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
<script src="/GeoReach/js/experience-edit.js" type="text/javascript"></script> 
<c:set var="all_segements" value="<%=segmentRepository.getOrgSegments(org_id) %>" />
<c:set var="experience_contents" value="<%=expHelper.experienceContent(id) %>" />
<c:set var="experience_name" value="<%=expHelper.getexperienceName(id) %>" />
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Edit Content Experience </h3>
			</div>
		</div>
		<div class="kt-portlet__body">
		<form class="kt-form kt-form--label-right" id="experience-form" >
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
				<div class="col-lg-4 col-md-9 col-sm-12">															
					<input type="text"		id="form-expname"			name="expName"   class="form-control" aria-describedby="Experience Name"  placeholder="Expereince Name"  value='${experience_name}'>
					<input type="hidden" 	id="form-contentdetails"	name="experienceDetails"  />
					<input type="hidden"	id="form-urldetails"		name="urlList"   />
					
					<input type="hidden"	name="pageName"  value="edit-experience"  />
					<input type="hidden"	name="expid"  value="<%=id%>"  />
				</div> 
			</div>
			<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
				<div class="kt-portlet__body">
					<div class="kt-section">
						<div class="kt-section__content kt-section__content--border" style="width:490px;">
							<ul class="list-group" id="addonContent">
							<c:forEach items="${experience_contents}" var="content"  varStatus="counter">
							<c:if test ="${not empty content.segmentName }">
								<li class="list-group-item" id="segmentlist-${content.id}">
									<span style="width:60%" id="segment-${content.id}-namespan"> ${content.segmentName} </span>
									<span style="float:right;width:32%" >
									<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#segment_modal" onclick="setupModal('edit','${content.id}')">
										<i class="fa fa-edit"><span></span></i>
									</button>
									<button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('segment','${content.id}')" >
										<i class="flaticon2-trash" ><span></span></i>
									</button>
								</span>
								</li>
                         <script> expDetailsObj[escape('${content.id}')]= '${fn:replace(content.content, newLineChar, " ")}' ; </script>
                        </c:if>
                        </c:forEach> 
                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#segment_modal" onclick="setupModal('add','')">Add</a>
                     
                     <div class="modal fade show" id="segment_modal" role="dialog" aria-labelledby="" style="display:none;padding-right: 16px;top:20%" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">New Segment</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>
                              
                              <div class="modal-body">
                                 <div class="form-group row kt-margin-t-20">
                                    <label class="col-form-label col-lg-3 col-sm-12">Segment</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12">
                                       <select id="segment" class="form-control kt-select2 select2-hidden-accessible" name="segment-dropdown" style="width: 75%">
                                          <c:forEach items="${all_segements}" var="segment" >
							                      <option value="${segment.key}">${segment.value} </option>
						                    </c:forEach>	
                                       </select> 
                                    </div>
                                 </div>
                                 <div class="form-group row kt-margin-t-20" >
                                    <label class="col-form-label col-lg-3 col-sm-12">Content</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12" >
                                       <textarea id="content" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Enter Text" rows="" cols="" style="height:200px"></textarea>
                                    </div>
                                 </div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addContent()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
         <div class="form-group row">
            <label class="col-form-label col-lg-3 col-sm-12">Pages</label>
            <div class="kt-portlet__body">
               <div class="kt-section">
                  <div class="kt-section__content kt-section__content--border" style="width:490px;">
                     <ul class="list-group" id="addonurl">
                     <c:forEach items="${experience_contents}" var="content" varStatus="counter">
			              <c:if test ="${empty content.segmentName }">
                        <li class="list-group-item" id="urllist-${counter.count}">
                        	<span style="width:60%" id="url-${counter.count}-namespan"> ${content.content} </span>
                        	 
							<span style="float:right;width:32%" >
								<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#PageURL_Modal"  onclick="contenturl('${counter.count}')">
									<i class="fa fa-edit"><span></span></i>
								</button>
								<button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('url','${counter.count}')" >
									<i class="flaticon2-trash"><span></span></i>
								</button>
								
							</span>
                        </li> 
                         <script> cfgDetailsObj[index++]= '${fn:replace(content.content, newLineChar, " ")}' ; </script>
                        </c:if>
                        </c:forEach>
                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#PageURL_Modal" onclick="contenturl('')">Add</a>
                     
                     <div class="modal fade show" id="PageURL_Modal" role="dialog" aria-labelledby="" style="display: none; padding-right: 16px; top:25%" aria-modal="true">
                        <div class="modal-dialog modal-lg" role="document" >
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="">Page</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true" class="la la-remove"></span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <div class="form-group row kt-margin-t-20" >
                                    <label class="col-form-label col-lg-3 col-sm-12">URL</label>
                                    <div class="col-lg-9 col-md-9 col-sm-12" >
                                       <input name="url" id="pageurl" type="text" class="form-control" aria-describedby="url"  style="width: 75%" >
                                    </div>
                                 </div> 
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-brand" data-dismiss="modal">Close</button>
                                 <button type="button" class="btn btn-secondary" onclick="addUrl()">Submit</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!--end::PortletPages-->
         	
         <div class="kt-portlet__body">
            <div class="form-group row">
               <label class="col-form-label col-lg-3 col-sm-12"></label>					
               <div class="col-lg-4 col-md-9 col-sm-12">
                  <button type="button" class="btn btn-primary" onclick="saveExperience()">Save</button>&nbsp;
                  <button type="button" class="btn btn-secondary" onclick="cancelOperation()">Cancel</button>
               </div>
            </div>
         </div>
        
      </form>
   </div>
</div>
</div>