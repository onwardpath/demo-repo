<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<script type="text/javascript">
function add(){	
	var rule = document.getElementById("rule").value;
	var type = document.getElementById("type").value;
	var criteria = document.getElementById("criteria").value;
	var rulevalue = document.getElementById("rulevalue").value;
	var pageurl = document.getElementById("pageurl").value;	
	var interest = rule+":"+type+":"+criteria+":"+rulevalue+":"+pageurl;	
	var buttonlabel = interest.replace(/:/g, "");
	buttonlabel = buttonlabel.replace(".", "");	
	var select = document.getElementById("dynamic-select");
	var index = select.options.length;
	select.options[index] = new Option(interest, interest);			
	document.getElementById("rule").reset;
	document.getElementById("type").reset;
	document.getElementById("criteria").reset;
	document.getElementById("rulevalue").value = ""; //Clear the Text Field
	document.getElementById("pageurl").value = "";//Clear the Text Field	
	var x = document.getElementById("interestbucket");		
	if(rule == "include") {		
		x.innerHTML += '<button id="'+buttonlabel+'" type="button" class="btn btn-outline-info btn-pill" onclick="remove('+buttonlabel+','+index+')">'+buttonlabel+'<i class="la la-close"></i></button>&nbsp;';		
	} else {		
		x.innerHTML += '<button id="'+buttonlabel+'" type="button" class="btn btn-outline-danger btn-pill" onclick="remove('+buttonlabel+','+index+')">'+buttonlabel+'<i class="la la-close"></i></button>&nbsp;';		
	}	
	x.style.display = "block";			
	document.getElementById("rule").focus();	
}
function remove(element, index){		
	var select = document.getElementById("dynamic-select");
	select.remove(index);		
	element.style.display = "none";		
}
function removeAll(){
	var select = document.getElementById("dynamic-select");
	select.options.length = 0;
	var x = document.getElementById("interestbucket");
	x.style.display = "none";	
}
function saveSegment() {	
	//TODO: Validate Rules and display error for conflicting/invalid rules
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
    txt = "int{"+txt+"}";      
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
		String icon = "fa fa-chart-pie"; 
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
				<h3 class="kt-portlet__head-title">Create Interest Segment</h3>				   															
			</div>												
		</div>
		<div class="kt-portlet__body">
			<div class="kt-portlet__content">
				Create segments based on visitors interest. For example, you can create a <span class="badge badge-warning">Packer Fan</span> segment with Criteria
				<span class="badge badge-secondary">Visits</span>
				<span class="badge badge-secondary">More than</span>
				<span class="badge badge-secondary">0</span> 
				on Page
				<span class="badge badge-secondary">mywebsite.com/packers-story</span>				
			</div>
		</div>					
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="dummy-form"> 
			<div class="kt-portlet__body">
																			 				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Criteria</label>
					<div class="col-lg-4 col-md-9 col-sm-12">		
						<select id="rule" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="include">Include</option>
							<option value="exclude">Exclude</option>														
						</select>																		
						<select id="type" class="form-control form-control--fixed kt_selectpicker" data-width="150">
							<option value="visit">Visits</option>
							<option value="session">Session Duration</option>														
						</select>																	
						<select id="criteria" class="form-control form-control--fixed kt_selectpicker" data-width="120">
							<option value="equals">Equals</option>
							<option value="more">More than</option>
							<option value="less">Less than</option>							
						</select>																															
					</div>
				</div>
																	
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">Number/Duration in Seconds</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="rulevalue" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="0 to 10">						
					</div>
				</div>
				
				<div class="form-group row">
				<label class="col-form-label col-lg-3 col-sm-12">On Page</label>
					<div class="col-lg-4 col-md-9 col-sm-12">															
						<input id="pageurl" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Page URL">						
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
								
				<div id="interestbucket" style="display: none;">																					
					<div class="kt-section__content kt-section__content--border">																																						
					</div>																																							
				</div>
																	
			</div>
		</form>
		<!--end::Form-->
		
		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="segment-form">
			<div class="kt-portlet__body">	
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Segment Name</label>
						<div class="col-lg-4 col-md-9 col-sm-12">															
							<input name="segmentName" id="segmentName" type="text" class="form-control col-lg-9 col-sm-12" aria-describedby="emailHelp" placeholder="Name">	
							<span class="form-text text-muted">Give a name for this segment</span>					
						</div>
				</div>
						
				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>					
						<div class="col-lg-4 col-md-9 col-sm-12">
							<div id="hidden-form" style="display: none;">							
								<input type="hidden" name="pageName" value="segment-create-interest.jsp">
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
		<!--end::Form-->		
	</div>
	<!--begin::Portlet-->
</div>
<!--end::Content-->