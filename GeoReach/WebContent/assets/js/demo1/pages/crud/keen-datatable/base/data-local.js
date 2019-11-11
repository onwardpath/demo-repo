'use strict';
// Class definition

var response = "";






window.onclick = myFunction;
function myFunction() {
	/*Code for Toggle ON and OFF*/	
	var stat = document.getElementsByClassName("stat");
	for(var i = 0; i < stat.length; i++) {
        var stats = stat[i];
        stats.onclick = function() {
        //	alert("toggle"+$(this).attr("temp").checked)
        	
        	var exp_id = this.id;
        	var status = document.getElementById(exp_id).checked;
        	console.log("status="+status+exp_id);
        	var statexp = document.getElementsByName('statexp');
			for (var i = 0; i <= statexp.length; i++) {
				var stexp = statexp[i];
				console.log("stexp"+stexp.checked);
		
		   		 var url	 = "http://localhost:8080/GeoReach/AjaxExpController"
	   			 var params = "service="+status+"&expid="+exp_id+"&exper=status";
	   			  var response = "";
	   		 
	   				
	   				var xhttp = new XMLHttpRequest(); 
	   				
	   				xhttp.onreadystatechange = function() {
	   				if (this.readyState == 4 && this.status == 200
	   							&& this.response != "null") {
	   						
	   						response = this.response; 
	   						/*var json = JSON.parse(response);
	   						var temp = json[0];
	   					//	KTDatatableDataLocalDemo.init(response);
	   						document.getElementById("popover-element").innerHTML = temp.content;
	   						
	   						$('#myModal').modal('show');*/
	   						 
	   						
	   						
	   						
	   				}};
	   				xhttp.open("POST", url+"?"+params);
	   				
	   				xhttp.send();
	   				return response;
					}
    	
    }
    }
	/*Code for Modal Popup*/
	var anchors = document.getElementsByClassName("hover")
  
    	  for(var i = 0; i < anchors.length; i++) {
    	        var anchor = anchors[i];
    	        anchor.onclick = function() {
    	        	
	        	var segment_id	=	this.id;
	        	
	        	console.log("segment=="+segment_id);
	    		var exp_id		=	$(this).attr("data-expid");
	    		var seg_name    =   $(this).attr("data-segname");
	    		var xContents = $(this).html();
	    		var lastCommaPos = xContents.lastIndexOf(',');
	    		console.log("seg_name="+xContents);
	    		 var url	 = "http://localhost:8080/GeoReach/AjaxExpController"
	    			 var params = "service="+segment_id+"&expid="+exp_id+"&exper=content";
	    		 	  var response = "";
	    		 
	    				
	    				var xhttp = new XMLHttpRequest(); 
	    				
	    				xhttp.onreadystatechange = function() {
	    				if (this.readyState == 4 && this.status == 200
	    							&& this.response != "null") {
	    						
	    						response = this.response; 
	    						var json = JSON.parse(response);
	    						var temp = json[0];
	    					//	KTDatatableDataLocalDemo.init(response);
	    						document.getElementById("popover-element").innerHTML = temp.content;
	    						document.getElementById("segment-element").innerHTML = seg_name;
	    						$('#myModal').modal('show');
	    						 
	    						
	    						
	    						
	    				}};
	    				xhttp.open("POST", url+"?"+params);
	    				
	    				xhttp.send();
	    				return response;
	        }
	    }
    

 
}
/*Code for Populating Datatable Values*/
function test()
{	
	
	var response = "";

			
		var xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200
					&& this.response != "null") {
				
				response = this.response;
				KTDatatableDataLocalDemo.init(response);
				
				var json_len = JSON.parse(response);
				console.log("json_length"+json_len.length)
				var recordsPerPage = 10;
				var page_display = Math.ceil(json_len.length/recordsPerPage); 
				console.log("page=="+page_display);
				/*var mydiv = document.getElementById("page");
				var aTag = document.createElement('a');
				aTag.setAttribute('href',"");
				aTag.setAttribute('class',"kt-datatable__pager-link kt-datatable__pager-link-number");
				
				mydiv.appendChild(aTag);
				for(var i = 1; i <= page_display; i++) {
					var mydiv = document.getElementById("page");
					var list = document.createElement('ul');
					list.setAttribute('class',"kt-datatable__pager-nav");
					var aTag = document.createElement('a');
					
					aTag.setAttribute('href',"");
					aTag.setAttribute('data-page',i);
					aTag.setAttribute('class',"kt-datatable__pager-link kt-datatable__pager-link-number");
					aTag.innerText = i;
					mydiv.appendChild(aTag);
					
				}*/
		}};
		xhttp.open("GET", "http://localhost:8080/GeoReach/AjaxExpController");
		
		xhttp.send();
		return response;
		
		
		} 

/*Code for JSON Data Formation*/
var KTDatatableDataLocalDemo = function() {
	
	var demo = function(response) {
		
		
		var dataJSON		  = JSON.parse(response);
		var dataJSONArray = JSON.parse(response);
		
			var datatable = $('.kt_datatable').KTDatatable({
			// datasource definition
			data: {
				type: 'local',
				source: dataJSONArray,
				pageSize: 10,
			},
			data: {
				type: 'local',
				source: dataJSON,
				pageSize: 10,
			},

			// layout definition
			layout: {
				scroll: false, // enable/disable datatable scroll both horizontal and vertical when needed.
				// height: 450, // datatable's body's fixed height
				footer: false, // display/hide footer
			},

			// column sorting
			sortable: true,

			pagination: true,

			search: {
				input: $('#generalSearch'),
			},

			// columns definition
			columns: [
				{
					
					field: 'id',
					title: '#',
					sortable: false,
					width: 20,
					type: 'number',
					selector: {class: 'kt-checkbox--solid'},
					textAlign: 'center',
				}, {
					field: 'experience',
					title: 'Experience',
				}, {
					field: 'segment',
					title: 'Segments',
					template: function(row) {
						var exp_id = row.id;
						
						var segArray = row.segments.split(",");
						segArray = segArray.slice(0,segArray.lastIndexOf(","));
					
						
						var s = "";
						var seg	=	"";
						for(var i=0;i<segArray.length;++i)
							{  
							
							var segname = segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length); 
							s += '<a href="" class="hover" data-toggle="modal"  title="Experience contents" data-segname="'+segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length)+'"  data-expid="'+exp_id+'" id="' + segArray[i].slice(0,segArray[i].lastIndexOf(":")) + '" >' + segname +"," + '</a>';
							
							}
						
						return s.slice(0,s.lastIndexOf(",")) ;
					
					},
				}, {
					field: 'pages',
					title: 'Pages',
				}, {
					field: 'status',
					title: 'Type',
					// callback function support for column rendering
				}, {
					field: 'type',
					title: 'Status',
					template:function(row)
					{
					
						var exp_id = row.id;
					
						if ((row.type == 'on') ) 
						{
						  return '\
						  <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--success">\
							<label> <input id="'+exp_id+'" name="statexp" class="stat"  type="checkbox"  checked="checked" name="">\
						  <span></span>\
						  </label>\
						  </span>\
						  ';
						  
						
						} 
						else if ((row.type == 'off') ) 
							{
							
							  return '\
							  <span class="kt-switch kt-switch--outline kt-switch--icon kt-switch--success">\
								<label> <input id="'+exp_id+'" name="statexp" class="stat"  type="checkbox"  name="">\
							  <span></span>\
							  </label>\
							  </span>\
							  ';
							  
							
							
							}
					},
					
				
				}, {
					field: 'Actions',
					title: 'Actions',
					sortable: false,
					width: 110,
					overflow: 'visible',
					autoHide: false,
					template: function() {
						return '\
						<div class="dropdown">\
							<a href="javascript:;" class="btn btn-sm btn-clean btn-icon btn-icon-md" data-toggle="dropdown">\
                                <i class="la la-cog"></i>\
                            </a>\
						  	<div class="dropdown-menu dropdown-menu-right">\
						    	<a class="dropdown-item" href="#"><i class="la la-edit"></i> Edit Details</a>\
						    	<a class="dropdown-item" href="#"><i class="la la-leaf"></i> Update Status</a>\
						    	<a class="dropdown-item" href="#"><i class="la la-print"></i> Generate Report</a>\
						  	</div>\
						</div>\
						<a href="javascript:;" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Edit details">\
							<i class="la la-edit"></i>\
						</a>\
						<a href="javascript:;" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Delete">\
							<i class="la la-trash"></i>\
						</a>\
					';
					},
				}],
		});

		$('#kt_form_status').on('change', function() {
			datatable.search($(this).val().toLowerCase(), 'status');
		});

		$('#kt_form_type').on('change', function() {
			datatable.search($(this).val().toLowerCase(), 'type');
		});

		$('#kt_form_status,#kt_form_type').selectpicker();

	};

	return {
		// Public functions
		init: function(response) {
			
			// init dmeo
			demo(response);
		}
	};
}();



	jQuery(document).ready(function() {
	
	test();
	
		
		
	});

