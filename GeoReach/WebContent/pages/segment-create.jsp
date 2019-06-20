<script type="text/javascript">
function submitform()
{
  document.logout.submit();
}

function addOption(){
	var geotype = document.getElementById("geotype").value;
	var georule = document.getElementById("georule").value;
	var geoloc = document.getElementById("geoloc").value;	
	var geocondition = georule+":"+geotype+":"+geoloc;
		
	var select = document.getElementById("dynamic-select");
	select.options[select.options.length] = new Option(geocondition, geocondition);
	document.getElementById("geoloc").value = "";
			
	//<button type="button" class="btn btn-outline-danger btn-pill">Wisconsin <i class="la la-remove"></i></button>&nbsp;										
	var x = document.getElementById("geobucket");
	if(georule == "include") {		
		x.innerHTML += '<button type="button" class="btn btn-outline-info btn-pill">'+geoloc+'<i class="la la-remove"></i></button>&nbsp;';
	} else {
		x.innerHTML += '<button type="button" class="btn btn-outline-danger btn-pill">'+geoloc+'<i class="la la-remove"></i></button>&nbsp;';
	}	
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

<!--begin::Content-->

<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	<div class="row">
	    <div class="col">
	        <div class="alert alert-light alert-elevate fade show" role="alert">
	            <div class="alert-icon"><i class="flaticon-warning kt-font-brand"></i></div>
	            <div class="alert-text">
	                The jQuery plugin that brings select elements into the 21st century with intuitive multiselection, searching, and much more.
	                <br>
	                For more info please visit the plugin's <a class="kt-link kt-font-bold" href="https://developer.snapappointments.com/bootstrap-select/examples/" target="_blank">Demo Page</a> or <a class="kt-link kt-font-bold" href="https://github.com/snapappointments/bootstrap-select" target="_blank">Github Repo</a>.
	            </div>
	        </div>
	    </div>
	</div>
	
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Segment</h3>
			</div>
		</div>
		
		
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right">
			<div class="kt-portlet__body">
								
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Segment Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input name="segmentName" id="segment-name" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name">	
						<span class="form-text text-muted">Give a name for this segment</span>					
					</div>
				</div>
							 						
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Criteria & Location Type</label>
					<div class="col-lg-4 col-md-9 col-sm-12">											
						<select id="georule" class="form-control form-control--fixed kt_selectpicker" data-width="100">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>							
						</select>											
						<select id="geotype" class="form-control form-control--fixed kt_selectpicker" data-width="120">
							<option value="city">City</option>
							<option value="state">State</option>
							<option value="country">Country</option>							
						</select>																															
					</div>
				</div>
											
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Location Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="geoloc" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Name">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">																					
						<button type="reset" class="btn btn-accent" onclick="javascript:addOption()">Add</button>
					</div>
				</div>
				
				<div class="kt-separator kt-separator--border-dashed"></div>
				<div class="kt-separator kt-separator--height-sm"></div>
				
				
				<div id="geobucket" style="display: none;">																					
					<div class="kt-section__content kt-section__content--border">																			
																					
					</div>																																							
				</div>
																	
			</div>
			
			<div class="kt-portlet__body">
			
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">
							<form id="segment-form">
								<input type="hidden" name="pageName" value="segments">
								<input type="hidden" id = "segmentRules" name="segmentRules" >
								<select id="dynamic-select" size="2"></select>																																				
							</form>										
						</div>											
						<button type="reset" class="btn btn-primary" onclick="saveSegment();">Save Segment</button>
						<button type="reset" class="btn btn-secondary">Cancel</button>
					</div>
				</div>
				
				<!-- 
				<div class="kt-repeater">
						<div class="kt-repeater__data-set">
							<div data-repeater-list="demo3-list2">
								<div data-repeater-item="" class="kt-repeater__item">
									<div class="kt-repeater__close kt-repeater__close--align-right form-group">
										
									</div>
									<div class="form-group row">
										<label class="col-lg-3 col-form-label">Holder:</label>
										<div class="col-lg-6">
											<input type="email" class="form-control" placeholder="Enter full name">
											<span class="form-text text-muted">Please enter your account holder</span>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-lg-3 col-form-label">Contact</label>
										<div class="col-lg-6">
											<div class="input-group">
												<div class="input-group-prepend"><span class="input-group-text"><i class="la la-chain"></i></span></div>
												<input type="text" class="form-control" placeholder="Phone number">
											</div>	
										</div>
									</div>							
									<div class="form-group row">
										<label class="col-lg-3 col-form-label">Communication:</label>
										<div class="col-lg-6">
											<div class="kt-checkbox-inline">
												<label class="kt-checkbox">
						                           	<input type="checkbox"> Email 
						                            <span></span>
						                        </label>
						                        <label class="kt-checkbox">
						                           	<input type="checkbox"> SMS 
						                            <span></span>
						                        </label>
						                        <label class="kt-checkbox">
						                           	<input type="checkbox"> Phone 
						                            <span></span>
						                        </label>
						                    </div>
					                   </div>
					                </div>
									<div class="kt-separator kt-separator--border-dashed"></div>
									<div class="kt-separator kt-separator--height-sm"></div>
								</div>
							</div>
						</div>
						<div class="kt-repeater__add-data">
							<span data-repeater-create="" class="btn btn-info btn-sm">
								<i class="la la-plus"></i> Add Customer Account
							</span>
						</div>
					</div>
				
				
				
				<div class="kt-repeater">
						<div class="kt-repeater__data-set">
							<div data-repeater-list="demo3-list2">
								<div data-repeater-item="" class="kt-repeater__item">
									<div class="kt-repeater__close kt-repeater__close--align-right form-group">										
									</div>
									<div class="form-group row">
									<label class="col-form-label col-lg-3 col-sm-12">Location Criteria & Type</label>
										<div class="col-lg-4 col-md-9 col-sm-12">						
											<select class="form-control form-control--fixed kt_selectpicker" data-width="100">
												<option>Include</option>
												<option>Exclude</option>							
											</select>											
											<select class="form-control form-control--fixed kt_selectpicker" data-width="150">
												<option>City</option>
												<option>State</option>
												<option>Country</option>							
											</select>																
										</div>
									</div>																
									<div class="form-group row">
									<label class="col-form-label col-lg-3 col-sm-12">Location Name</label>
										<div class="col-lg-4 col-md-9 col-sm-12">																				
											<input type="text" class="form-control col-lg-3 col-sm-12" aria-describedby="emailHelp" placeholder="Name">											
										</div>
									</div>
									<div class="kt-separator kt-separator--border-dashed"></div>
									<div class="kt-separator kt-separator--height-sm"></div>
								</div>
							</div>
						</div>
						<div class="kt-repeater__add-data">
							<span data-repeater-create="" class="btn btn-info btn-sm">
								<i class="la la-plus"></i> Add Location
							</span>
						</div>
					</div>
				
				-->
				
			</div>
		</form>
		
	</div>

</div>
<!--end::Content-->