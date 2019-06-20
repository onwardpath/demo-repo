<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<script type="text/javascript">
function add(){
	//var segmentName = document.getElementById("segment-name").value;
	//alert(segmentName);
	
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
		x.innerHTML += '<button id="'+geoloc+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;';
	} else {		
		x.innerHTML += '<button id="'+geoloc+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('+geoloc+','+index+')">'+geoloc+'<i class="la la-close"></i></button>&nbsp;';
	}	
	x.style.display = "block";	
	//alert(segmentName);	
	document.getElementById("geoloc").focus();
	//document.getElementById("segment-name").value = segmentName;
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
	//alert("going to submit....");
	//var segment = document.getElementById("segment-name").value;
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
    //alert(txt);
    //alert(document.getElementById("segment-form"));
    //document.getElementById("segmentName").value = segment;    
	document.getElementById("segmentRules").value = txt;	
	document.getElementById("segment-form").method = "post";
	document.getElementById("segment-form").action = "SegmentController";
	document.getElementById("segment-form").submit();
}
</script>

<!--begin::Content-->

<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
	
	<%
	String message = (String) session.getAttribute("message");	
	if (message != null && !message.equals("")) {
		String icon = "flaticon-placeholder-3"; 
		if (message.startsWith("Error"))
			icon = "flaticon-warning";
		%>
		<div class="row">
		    <div class="col">
		        <div class="alert alert-light alert-elevate fade show" role="alert">
		            <div class="alert-icon"><i class="<%=icon%> kt-font-brand"></i></div>		            		           
		            <div class="alert-text">
		                <%=message%>
		            </div>
		        </div>
		    </div>
		</div>	
		<%
		session.setAttribute("message", "");
	}																
	%>	
	
	
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
				<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
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
				<label class="col-form-label col-lg-3 col-sm-12">Area Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="geoloc" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Name" autofocus>						
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
		</form>
		
		<form class="kt-form kt-form--label-right" id="segment-form">
			<div class="kt-portlet__body">	
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment Name</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="segmentName" id="segmentName" type="text" class="form-control" aria-describedby="emailHelp" placeholder="Name">	
							<span class="form-text text-muted">Give a name for this segment</span>					
						</div>
				</div>
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">							
								<input type="hidden" name="pageName" value="segment-create">
								<!-- input type="hidden" id = "segmentName" name="segmentName"  -->
								<input type="hidden" id = "segmentRules" name="segmentRules" >
								<select id="dynamic-select" size="2"></select>																																																					
							</div>											
							<button type="reset" class="btn btn-primary" onclick="saveSegment();">Save</button>
							<button type="reset" class="btn btn-secondary">Cancel</button>
						</div>
					
				</div>										
			</div>
		</form>
		
	</div>

</div>
<!--end::Content-->