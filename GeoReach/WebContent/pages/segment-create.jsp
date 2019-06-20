<script type="text/javascript">
function add(){
	var geotype = document.getElementById("geotype").value;
	var georule = document.getElementById("georule").value;
	var geoloc = document.getElementById("geoloc").value;		
	var geocondition = georule+":"+geotype+":"+geoloc;
		
	var select = document.getElementById("dynamic-select");
	var index = select.options.length;
	select.options[index] = new Option(geocondition, geocondition);
	document.getElementById("geoloc").value = ""; //Clear the Text Field
				
	var x = document.getElementById("geobucket");
	//Remove white space before displaying. Note: We are using the name as-is while saving the locations to segment table.
	geoloc = geoloc.replace(/\s+/g, '');
	
	if(georule == "include") {	
		//alert('<button id="'+geoloc+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;');
		x.innerHTML += '<button id="'+geoloc+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;';
	} else {
		//alert('<button id="'+geoloc+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;');
		x.innerHTML += '<button id="'+geoloc+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;';
	}	
	x.style.display = "block";	
}

function remove(element, index){
	//alert(element);
	var select = document.getElementById("dynamic-select");
	select.remove(index);		
	element.style.display = "none";		
}

function removeAll(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("geobucket");
	x.style.display = "none";	
}

function  saveSegment() {		
	alert("going to submit....");
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
    alert(txt);
	document.getElementById("segmentRules").value = txt;	
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
						<button type="reset" class="btn btn-accent" onclick="javascript:add()">Add</button>
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
					<form id="segment-form">
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">							
							<input type="hidden" name="pageName" value="segment-create">
							<input type="hidden" id = "segmentRules" name="segmentRules" >
							<select id="dynamic-select" size="2"></select>																																																					
						</div>											
						<button type="reset" class="btn btn-primary" onclick="saveSegment();">Save</button>
						<button type="reset" class="btn btn-secondary">Cancel</button>
					</div>
					</form>
				</div>										
			</div>
		</form>
		
	</div>

</div>
<!--end::Content-->