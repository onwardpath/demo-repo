<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.onwardpath.georeach.repository.SegmentRepository" %>
<%@ page import="java.util.Map" %>
<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}

function addOption(){
	var geotype = document.getElementById("geotype").value;
	var rule = document.getElementById("rule").value;
	var geolocation = document.getElementById("geolocation").value;	
	var geocondition = rule+":"+geotype+":"+geolocation;
		
	var select = document.getElementById("dynamic-select");
	select.options[select.options.length] = new Option(geocondition, geocondition);
	document.getElementById("geolocation").value = "";
	
	var x = document.getElementById("geobucket");	
	x.style.display = "block";	
}

function removeOption(){
	var select = document.getElementById("dynamic-select");
	select.options[select.options.length - 1] = null;
	if (select.options.length == 0) {
		var x = document.getElementById("geobucket");
		x.style.display = "none";		
	}	
}

function removeAllOptions(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("geobucket");
	x.style.display = "none";	
}

function  saveSegment() {			
	var x = document.getElementById("dynamic-select");
    var txt = "";
    var i;
    for (i = 0; i < x.length; i++) {
    	if (i == 0) {
    		txt = x.options[i].text;
    	} else {
    		txt = txt + "|" + x.options[i].text;	
    	}    	        
    }
    
	document.getElementById("segmentRules").value=txt;	
	document.getElementById("segment-form").method = "post";
	document.getElementById("segment-form").action = "SegmentController";
	document.getElementById("segment-form").submit();
}
</script>
<!-- begin:: Content -->
<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="row">
		<div class="col-lg-12">
			<!--begin::Portlet-->
			<div class="kt-portlet">
				<div class="kt-portlet__head">
					<div class="kt-portlet__head-label">
						<h3 class="kt-portlet__head-title">Create New Experience</h3>
					</div>
				</div>
				<!--begin::Form-->
				<form class="kt-form">
					<div class="kt-portlet__body">
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">Name</label>
							<div class="col-6">																				
								<input type="text" class="form-control" placeholder="Experience Name" id="name">
								<span class="form-text text-muted">Give a name to this Experience</span>
							</div>
						</div>
						
						<div class="kt-separator kt-separator--border-dashed"></div>
						<div class="kt-separator kt-separator--space-sm"></div>
						
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">Segment</label>
							<div class="col-6">		
								<select class="form-control" id="segment">	
								<%
								SegmentRepository segmentRepository = new SegmentRepository();
								int org_id = (Integer)session.getAttribute("org_id");
								Map<Integer,String> segments = segmentRepository.getOrgSegments(org_id);
								for ( Map.Entry<Integer, String> entry : segments.entrySet()) {
									Integer key = entry.getKey();
								    String val = entry.getValue();	     	   
								    out.println("<option value="+key+">"+val+"</option>");
								}	
								%>
								</select>														
								<span class="form-text text-muted">Choose the Segment for this experience</span>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">Type of Experience</label>
							<div class="col-6">		
								<select class="form-control" id="type"><option value="image">Image</option><option value="content">Content</option></select>													
								<span class="form-text text-muted">Specify if this is an Image or Content experience</span>
							</div>
						</div>
																																																							
						<!-- BEGIN::REPEATER -->
						<div class="form-group row">
							<label class="col-lg-3 col-form-label">Image</label>
							<div class="col-lg-6">
								<div class="kt-repeater">
									<div data-repeater-list="demo1">
										<div data-repeater-item class="kt-repeater__item">
											<div class="input-group">
												<div class="input-group-prepend"><span class="input-group-text"><i class="la la-chain"></i></span></div>
												<input type="text" class="form-control" placeholder="Image URL" id="url">													
												<span class="form-text text-muted">Choose the Image to be served for the selected Segment</span>
												<div class="input-group-append">
													<button data-repeater-delete="" class="btn btn-danger btn-icon">
														<i class="la la-close kt-font-light"></i>
													</button>
												</div>
											</div>	
											<div class="kt-separator kt-separator--space-sm"></div>
										</div>
									</div>
									<div class="kt-repeater__add-data">
										<span data-repeater-create="" class="btn btn-info btn-sm">
											<i class="la la-plus"></i> Add
										</span>
									</div>
								</div>
							</div>
						</div>		
						<!-- END::REPEATER -->
																	
						<div class="kt-separator kt-separator--border-dashed"></div>
						<div class="kt-separator kt-separator--space-sm"></div>
						
		            </div>
		            <div class="kt-portlet__foot">
						<div class="kt-form__actions kt-form__actions--right">
							<div class="row">
								<div class="col-lg-9 offset-lg-3">
									<div class="kt-align-left">
										<button type="reset" class="btn btn-brand">Save</button>
										<button type="reset" class="btn btn-secondary">Cancel</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!--end::Form-->
			</div>
			<!--end::Portlet-->
		</div>
	</div>
</div>
<!-- end:: Content -->