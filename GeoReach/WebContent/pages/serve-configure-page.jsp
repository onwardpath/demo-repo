<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.model.Experience, com.onwardpath.georeach.repository.ExperienceRepository" %>
<!-- script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script -->
<script src="./assets/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

var expDetailsObj = {};
function add(){		
	var experience = document.getElementById("experience");	
	var experience_id = experience.value;	
	var experience_name = experience.options[experience.selectedIndex].innerHTML;
	var pageurl = document.getElementById("pageurl").value;
			
	var stage = document.getElementById("stage");	
	//stage.innerHTML += '<object type="text/html" data="'+pageurl+'" width="100%" height="800px" style="overflow:auto;border:2px ridge blue" onmouseover="preview(event,\'previewdiv\')" onmouseout="preview(event,\'previewdiv\')"></object>';
	stage.innerHTML += '<object type="text/html" data="'+pageurl+'" width="100%" height="800px" style="overflow:auto;border:2px ridge blue"></object>';
	stage.style.display = "block";
	
	var mousePosition;
	var offset = [0,0];
	var isDown = false;
	
	var previewdiv = document.getElementById("previewdiv");
	previewdiv.style.display = "block";
	previewdiv.style.cursor = "move";
	previewdiv.style.right = "300px";
	previewdiv.style.top = "300px";
	previewdiv.style.width = "500px";
	previewdiv.style.height = "100px";
	
	
	previewdiv.addEventListener('mousedown', function(e) {
	    isDown = true;
	    offset = [
	    	previewdiv.offsetLeft - e.clientX,
	    	previewdiv.offsetTop - e.clientY
	    ];
	}, true);

	document.addEventListener('mouseup', function() {
	    isDown = false;
	}, true);

	document.addEventListener('mousemove', function(event) {
	    event.preventDefault();
	    if (isDown) {
	        mousePosition = {	    
	            x : event.clientX,
	            y : event.clientY	    
	        };
	        previewdiv.style.left = (mousePosition.x + offset[0]) + 'px';
	        previewdiv.style.top  = (mousePosition.y + offset[1]) + 'px';
	    }
	}, true);
}
function remove(element, segment_id){		
	var displayElement = document.getElementById(element);	
	delete expDetailsObj[segment_id];	
	displayElement.style.display = "none";		
}
function saveExperience(){	
	var name = document.getElementById('name').value;
	var type = "content";					
	document.getElementById("experience-form").type.value=type;	
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(expDetailsObj);	
	//document.getElementById("experience-form").method = "post";
	//document.getElementById("experience-form").action = "ConfigController";
	//document.getElementById("experience-form").submit();
}
//function preview(e,divid){ 
//	var left = e.clientX + "px"; 
//	var top = e.clientY + "px"; 
//	$("#"+divid).css('left',left); 
//	$("#"+divid).css('top',top); 
//	$("#"+divid).css('position','fixed'); 
//	$("#"+divid).toggle(); 
//	return false; 
//}
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
	ExperienceRepository experienceRepository = new ExperienceRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	Map<Integer,Experience> experiences = experienceRepository.getOrgExperiences(org_id);
	if (experiences.size() == 0) {
		message = "Error: No Experiences are configured. Create an Experience <a class='kt-link kt-font-bold' href='?view=pages/experience-create-content.jsp'>here</a>";	
	}
				
	if (message != null && !message.equals("")) {
		String icon = "flaticon-paper-plane"; 
		if (message.startsWith("Error"))
			icon = "flaticon-warning";		
		
		String name = "";
		String experience = "";
		String organization = "";		
		if (message.contains("#")) {			
			String codeConstructor = message.substring(message.indexOf("#")+1);
			
			message = message.substring(0,message.indexOf("#"));
			String[] decoder = codeConstructor.split("#");
			name = decoder[0].substring(decoder[0].indexOf("=")+1);
			experience = decoder[1].substring(decoder[0].indexOf("=")+1);
			organization = decoder[2].substring(decoder[0].indexOf("=")+1);
		}			 							 							 					
		%>
		<div class="row">
		    <div class="col">
		        <div class="alert alert-light alert-elevate fade show" role="alert">
		            <div class="alert-icon"><i class="<%=icon%> kt-font-brand"></i></div>		            		           
		            <div class="alert-text">
		                <%=message%>		            
			            <!-- Button trigger modal -->
						<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter">
							View Code
						</button>
					</div>
		        </div>
		    </div>
		</div>	
		
		<!-- begin::modal -->		
		<div class="kt-section__content kt-section__content--border">			
			<!-- Modal -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" style="display: none;">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">						
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalCenterTitle">Embed Code for: <%=name%></h5>
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
								      var serviceURL= "http://lab01.onwardpath.com/GeoTargetService/app/georeach/get?id=<%=experience%>&org_id=<%=org_id%>&s=";
								      var geoElement = document.getElementById("Geo-<%=name%>-<%=experience%>");
								      var url = new URL(window.location.href);
								      var c = url.searchParams.get("s");
								      serviceURL += c;
								      console.log(serviceURL);
								
								      var xhttp = new XMLHttpRequest();
								      xhttp.responseType = 'json';
								      xhttp.onreadystatechange = function() 
								      {
										if (this.readyState == 4 && this.status == 200)
										{
											let data = this.response;
											geoElement.innerHTML = data[1].embedCode;
										}
								      };
								      xhttp.open("GET", serviceURL);
								      xhttp.send();
								 }								
								window.onload = geo;
								&lt;/script&gt;  
								&lt;!-- End::GeoSmart-Header --&gt;
							</code>
							<h3>Body</h3>
							<code>
								&lt;!-- Begin::GeoSmart-Body --&gt;
								&lt;div id="Geo-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;
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
		<%
		session.setAttribute("message", "");
	}																
	%>			
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Serve Experience on Page</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Experience</label>
					<div class="col-lg-4 col-md-9 col-sm-12">											
						<select id="experience" class="form-control form-control--fixed kt_selectpicker" data-width="300">
							<%
							for ( Map.Entry<Integer, Experience> entry : experiences.entrySet()) {
								Integer id = entry.getKey();
							    Experience exp = entry.getValue();	     	   
							    out.println("<option value='"+id+"'>"+exp.getName()+"</option>");
							}
							%>													
						</select>																																							
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Page Address</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="pageurl" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="URL">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:add()">Preview</button>
					</div>
				</div>
											
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				<div id="previewdiv" style="position: fixed; display: none;">										
				<h1 style="color:#008733; text-align: center;">Welcome To Acme Inc</h1>
 				<p>The transition of People Energy Wisconsin branches to Acme Inc is complete. You can now conduct your business at any Acme Inc! We're excited to work with you! </p>
				</div>
				
				<div class="kt-section__content kt-section__content--border">				
					<div id="stage" style="display: none;">																																																																																																										
					</div>
				</div>													
																	
			</div>
		</form>
		<!--end::Form-->
							
	</div>
	<!--begin::Portlet-->
</div>
<!--end::Content-->