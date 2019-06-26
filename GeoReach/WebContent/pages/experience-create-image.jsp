<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map, com.onwardpath.georeach.repository.SegmentRepository" %>    
<script type="text/javascript">

var expDetailsObj = {};

function add(){		
	var segment = document.getElementById("segment");	
	var segment_id = segment.value;	
	var segment_name = segment.options[segment.selectedIndex].innerHTML;
	if (segment_id in expDetailsObj) {
		alert("Segment "+segment_name+" already added. Select a different segment.");	
	} else {
		var url = document.getElementById("url").value;				
		expDetailsObj[segment_id] = url;				
		var stage = document.getElementById("stage");	
		stage.innerHTML += '<div id="'+segment_name+'" class="card-body"><img src="'+url+'" class="rounded">&nbsp;<button type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''+segment_name+'\','+segment_id+')">'+segment_name+'<i class="la la-close"></i></button></div>';
		stage.style.display = "block";		
	}	
}
function remove(element, segment_id){	
	//alert(element);
	var displayElement = document.getElementById(element);
	//alert(displayElement);
	//alert(segment_id);
	delete expDetailsObj[segment_id];	
	displayElement.style.display = "none";		
}
function saveExperience() 
{	
	var name = document.getElementById('name').value;
	var type = "image";			
	//alert("name: "+name);
	//alert("type: "+type);	
	//alert("experienceDetails: "+JSON.stringify(expDetailsObj));		
	document.getElementById("experience-form").type.value=type;	
	document.getElementById("experience-form").experienceDetails.value=JSON.stringify(expDetailsObj);	
	document.getElementById("experience-form").method = "post";
	document.getElementById("experience-form").action = "ExperienceController";
	document.getElementById("experience-form").submit();
}
</script>

<!-- 
https://www.associatedbank.com/content/image/mobile_upgrade_img_banking
https://www.associatedbank.com/content/image/mobile_upgrade_img_mobile
https://cdn.oectours.com/media/cds/banks/5231/59750.png
https://cdn.oectours.com/media/cds/banks/5231/81461.png
https://www.associatedbank.com/content/image/OLB_LP_Image
https://x7i5t7v9.ssl.hwcdn.net/cds/banks/5231/81626.png
 -->
 
<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">	
	<%	
	String message = (String) session.getAttribute("message");
	
	SegmentRepository segmentRepository = new SegmentRepository();
	int org_id = (Integer)session.getAttribute("org_id");
	Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
	if (segments.size() == 0) {
		message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create.jsp'>here</a>";	
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
			            &nbsp;&nbsp;
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
								&lt;!-- GeoSmart --&gt;
								&lt;script&gt;
								(function(i,s,o,g,r,a,m){i['GeoSmartObject']=r;i[r]=i[r]||function(){
								(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
								m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
								})(window,document,'script','https://lab01.onwardpath.com/geoservice?e=<%=experience%>&o=<%=organization%>','ga');								
								ga('create', 'UA-XXXXX-Y', 'auto');
								ga('send', 'pageview');
								&lt;/script&gt;
								&lt;!-- End GeoSmart --&gt
							</code>
							<h3>Body</h3>
							<code>
								&lt;!-- GeoSmart --&gt;
								&lt;div id="Geo-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;
								&lt;!-- End GeoSmart --&gt;
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
				<h3 class="kt-portlet__head-title">Create Image Experience</h3>
			</div>
		</div>
				
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
					<div class="col-lg-4 col-md-9 col-sm-12">											
						<select id="segment" class="form-control form-control--fixed kt_selectpicker" data-width="300">
							<%
							for ( Map.Entry<Integer, String> entry : segments.entrySet()) {
								Integer key = entry.getKey();
							    String val = entry.getValue();	     	   
							    out.println("<option value='"+key+"'>"+val+"</option>");
							}
							%>													
						</select>																																							
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Image</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="url" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="URL" data-width="100">	
						Enter Image URL or <a href="image-gallery.jsp">Pick from library</a>					
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
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
		<form class="kt-form kt-form--label-right" id="experience-form">
			<div class="kt-portlet__body">	
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience Name</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="name" id="name" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name">	
							<span class="form-text text-muted">Give a name for this experience</span>					
						</div>
				</div>
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">																	
								<input type="hidden" name="pageName" value="create-experience">								
								<input type="hidden" name="type">
								<input type="hidden" name="experienceDetails">
								<input type="hidden" name="segment_id">
								<input type="hidden" name="url">																																																																																				
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveExperience();">Save</button>
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