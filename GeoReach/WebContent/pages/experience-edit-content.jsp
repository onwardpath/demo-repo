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
<script src="https://code.jquery.com/jquery-3.3.1.js" type="text/javascript"></script>
<%-- Add these to the script file  --%>
<script>
var expDetailsObj = {};
var cfgDetailsObj = {};
var index=0;
var url_id = null;
function delete_exp_content(type,id){
	var title = "Are you sure you want to delete the segment";
	var text = document.getElementById(id+"-namespan").innerHTML
	var listId = "#"+type+"list-"+id;
	var deleteConfirmation = "Deleted";
	if ("url"===type){
		title = "Are you sure you want to delete the Page URL";
		text = cfgDetailsObj[id];
		deleteConfirmation = "Page URL Deleted"
	}
 	swal.fire({
		title: title,
		text: text,
		type: "warning",
		showCancelButton: !0,
		confirmButtonText: "Yes",
		cancelButtonText: "No",
		reverseButtons: !0
	}).then(function(e) {
			if (e.value){
				swal.fire(deleteConfirmation, text, "success")
				$(listId).remove();
				if ("url"===type){
					delete cfgDetailsObj[id];
				}else{
					delete expDetailsObj[id];
				}
			}else{
				 "cancel" === e.dismiss;
				 swal.fire("Cancelled", "Delete "+type, "error");
			}
	});
} 

function setupModal(action,action_id){
    var segment = document.getElementById("segment");
    if (action==="edit"){
        segment.value=action_id;
        document.getElementById("content").value=expDetailsObj[action_id];        
    }else{
    
        document.getElementById("content").value="";
    }
}

function addContent(){
    var segment = document.getElementById("segment");
    var segementContent = document.getElementById("content").value
     if (segementContent.length > 0){
         var _segid = segment.value;
         if (!(_segid in expDetailsObj)){
             segment_name = segment.options[segment.selectedIndex].innerHTML;
             addtoSegment(_segid,segment_name);
         }  
         expDetailsObj[_segid] = segementContent;
         $("#segment_modal").modal("hide");  
     }else{
    	 swal.fire("Content required for the Segment");
     } 
}

function addtoSegment(segment_id,segment_name){
    var addsegment = document.getElementById("addonContent");
      addsegment.innerHTML +='<li class="list-group-item"  id="segmentlist-'+segment_id+'">'+    
       '<span style="width:60% vertical-align: midauto" id="'+segment_id+'-namespan"> '+segment_name+'</span>'+
       '<span style="float:right;width:32%" >'+
       '<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#segment_modal" onclick="setupModal(\'edit\',\''+segment_id+'\')" >'+
       '<i class="fa fa-edit"><span></span></i>'+
       '</button>&nbsp;'+
       '<button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content(\'segment\',\''+segment_id+'\')">'+
       '<i class="flaticon2-trash"><span></span></i>'+
       '</button>'+
       '</span>'+
'</li>';
}

function setupModalPage(action,action_id){
    var page = document.getElementById("pageurl");
    url_id = action_id;	 
    if (action==="edit"){
    	
    	page.value=action_id;
        document.getElementById("pageurl").value=cfgDetailsObj[action_id];
        
    }else{
    
        document.getElementById("pageurl").value="";
     
       
    }
}
  
function addUrl(){
    var pageUrl = document.getElementById("pageurl").value;
	/* var buttonid = pageUrl.replace(/:/g, "");
	buttonid = buttonid.replace(".", ""); */
	 
	if (url_id in cfgDetailsObj) {
		if (pageUrl.length > 0){
		
		cfgDetailsObj[url_id] = pageUrl;
		document.getElementById(url_id+'\-namespan').innerHTML=pageUrl;
		$("#PageURL_Modal").modal("hide");
		url_id=null;
		}else{
			swal.fire("Please enter an URL")
		}
		  
	} else {
    if (pageUrl.length > 0){
     //var trimpagurl =pageUrl.substr(0, 15);
            url_id=index+'_new';
			cfgDetailsObj[url_id] = pageUrl;
     	 var addurl = document.getElementById("addonurl");
         addurl.innerHTML +='<li class="list-group-item" id="urllist-'+url_id+'>'+
         '<span style="width:60% vertical-align: midauto" id="'+url_id+'-namespan"> '+pageUrl+'</span>'+
         '<span style="float:right;width:32%" >'+
         '<button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#PageURL_Modal" onclick="setupModalPage(\'edit\',\''+url_id+'\')" >'+
         '<i class="fa fa-edit"><span></span></i>'+
         '</button>'+
         '<button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content(\'url\',\''+url_id+'\')">'+
         '<i class="flaticon2-trash"><span></span></i>'+
         '</button>'+
         '</span>'+
          '</li>';
          $("#PageURL_Modal").modal("hide");	 
          index++;
     }else{
    	 swal.fire("Please enter an URL") 
     }    
	}                         
} 
              
function saveExperience(){
	var finalexp_name =  document.getElementById("nameExp").value;
	if (finalexp_name){
		document.getElementById("form-expname").value=finalexp_name;	
		if (JSON.stringify(expDetailsObj)!=='{}'){			
			document.getElementById("form-contentdetails").value=JSON.stringify(expDetailsObj);	
			document.getElementById("form-urldetails").value=JSON.stringify(cfgDetailsObj); 
			document.getElementById("experience-form").method = "post";
			document.getElementById("experience-form").action = "ExperienceController";
			document.getElementById("experience-form").submit();   
		}else{
			swal.fire("Segmenet cannot be empty")
		}
	}else{
		swal.fire("Please enter a value for  Experience Name")
	}
	 	
}
    
function cancelOperation() {	
	location.replace("/GeoReach?view=pages/experience-view-content.jsp")
   
} 

</script>

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
               <input name="name" id="nameExp" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name"  value='${experience_name}'>  
            </div> 
         </div>
         <!--begin::PortletSegment-->
         <div class="form-group row">
            <label class="col-form-label col-lg-3 col-sm-12">Segment</label>
            <div class="kt-portlet__body">
               <div class="kt-section">
                  <div class="kt-section__content kt-section__content--border" style="width:490px;">
                     <ul class="list-group" id="addonContent">
                     <c:forEach items="${experience_contents}" var="content">
                        <c:if test ="${not empty content.segmentName }">
                        <li class="list-group-item" id="segmentlist-${content.id}">
                        <span style="width:60% vertical-align: midauto" id="${content.id}-namespan"> ${content.segmentName} </span>
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
                                 <h5 class="modal-title" id="">Segment</h5>
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
                                       <textarea id="content" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Enter Text" rows="" cols=""  style="height:200px"></textarea>
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
                     <c:forEach items="${experience_contents}" var="content">
                          <c:if test ="${empty content.segmentName }">
                        <li class="list-group-item" id="urllist-${content.id}">
                            <span style="width:60% vertical-align: midauto" id="${content.id}-namespan"> ${fn:substring(content.content, 0, 15)}</span>
                             
                            <span style="float:right;width:32%" >
                                <button type="button" class="btn btn-outline-info btn-pill" data-toggle="modal" data-target="#PageURL_Modal"  onclick="setupModalPage('edit','${content.id}')">
                                    <i class="fa fa-edit"><span></span></i>
                                </button>
                                <button type="button" class="btn btn-outline-info btn-pill" onclick="delete_exp_content('url','${content.id}')" >
                                    <i class="flaticon2-trash"><span></span></i>
                                </button>
                                
                            </span>
                        </li> 
                         <script> cfgDetailsObj['${content.id}']= '${content.content}'</script>
                        </c:if>
                        </c:forEach>
                     </ul>
                     <br/>
                     <a href="" class="btn btn-success btn-pill" data-toggle="modal" data-target="#PageURL_Modal" onclick="setupModalPage('add','')">Add</a>
                      
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