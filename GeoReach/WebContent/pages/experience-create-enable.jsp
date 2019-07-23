<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.repository.SegmentRepository" %>    
<script type="text/javascript">

var cfgDetailsObj = {};
var index = 0;

function add(){	
	var pageurl = document.getElementById("url").value;		
	var buttonid = pageurl.replace(/:/g, "");
	buttonid = buttonid.replace(".", "");		
	if (pageurl in cfgDetailsObj) {
		alert("Page "+url+" already added. Add a different page.");	
	} else {					
		cfgDetailsObj[index] = pageurl;
		index++;
		var stage = document.getElementById("stage");	
		stage.innerHTML += '<button id = '+buttonid+' type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''+buttonid+'\','+index+')">'+pageurl+'<i class="la la-close"></i></button>&nbsp;';
		stage.style.display = "block";		
	}	
}
function remove(element, index){		
	var displayElement = document.getElementById(element);	
	delete cfgDetailsObj[index];	
	displayElement.style.display = "none";		
}
function saveConfig(){				
	document.getElementById("config-form").urlList.value=JSON.stringify(cfgDetailsObj);	
	document.getElementById("config-form").method = "post";
	document.getElementById("config-form").action = "ConfigController";
	document.getElementById("config-form").submit();
}
function preview() {
	alert("Under Development");
}
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");		
	int org_id = (Integer)session.getAttribute("org_id");
	String name = "";
	String experience = "";
	String organization = "";
	
	SegmentRepository segmentRepository = new SegmentRepository();
	Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
	if (segments.size() == 0) {
		message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";	
	}
	
	if (message != null && !message.equals("")) {
		String icon = "fa fa-cocktail"; 
		boolean displayCode = false;
		
		if (message.startsWith("Error"))
			icon = "flaticon-warning";		
						
		if (message.contains("#")) {			
			String codeConstructor = message.substring(message.indexOf("#")+1);			
			message = message.substring(0,message.indexOf("#"));			
			String[] decoder = codeConstructor.split("#");
			name = decoder[0].substring(decoder[0].indexOf("=")+1);			
			experience = decoder[1].substring(decoder[0].indexOf("=")+1);			
			organization = decoder[2].substring(decoder[0].indexOf("=")+1);
			
		}
		
		if (message.startsWith("Page"))
			displayCode = true;
		%>
		<div class="row">
		    <div class="col">
		        <div class="alert alert-light alert-elevate fade show" role="alert">
		            <div class="alert-icon"><i class="<%=icon%> kt-font-brand"></i></div>		            		           
		            <div class="alert-text">
		                <%=message%>
		                <%
		                if (displayCode) {
		                	%>
		                	<!-- Button trigger modal -->		                	
		                	You can now embed the following code in the pages:
		                	<br><br>
							<button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter">
								View Code
							</button>
		                	<%		                		
		                }
		                %>		            			            
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
							<h5 class="modal-title" id="exampleModalCenterTitle">
							Embed below code in the body section of your page where <span class="badge badge-secondary"><%=name%></span> experience should appear
							</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">														 							 							
							<code>&lt;div id="G-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;</code>
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
				<h3 class="kt-portlet__head-title">Enable Experience</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 																
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
						<button type="reset" class="btn btn-accent" onclick="javascript:add()">Add</button>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				<div class="kt-section__content kt-section__content--border">				
					<div id="stage" style="display: none;">																																																																																																										
					</div>
				</div>													
																	
			</div>
		</form>
		<!--end::Form-->
		
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="config-form">
			<div class="kt-portlet__body">															
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">																	
								<input type="hidden" name="pageName" value="experience-create-enable.jsp">								
								<input type="hidden" name="experience_id" value="<%=experience%>">
								<input type="hidden" name="experience_name" value="<%=name%>">								
								<input type="hidden" name="urlList">																																																																																																			
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveConfig();">Save</button>
							<button type="reset" class="btn btn-secondary">Cancel</button>
						</div>					
				</div>										
			</div>
		</form>
		<!--end::Form-->		
	</div>
	<!--begin::Portlet-->
</div>
<!--end::Content-->