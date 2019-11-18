var dataJSONArray = {};

jQuery(document).ready(function() {
	
	test();
});

$("#myBtn").click(function(){
    /*$('#myModals').modal('show');*/
	console.log("jquery");
});

window.onclick = myFunction;
function myFunction() {
	
	
	
	
	
	var anchor = document.getElementsByClassName("page-link")
	  
	  for(var i = 0; i < anchor.length; i++) {
	        var anchors = anchor[i];
	        
	        anchors.addEventListener("click", function() {
	        	  var current = document.getElementsByClassName("active");
	        	  if (current.length > 0) { 
	        		    current[0].className = current[0].className.replace(" active", "");
	        		  }
	        		  this.className += " active";
	        		  });
	        
	        anchors.onclick = function() {
	        	visiblePages: 5;
	        	var page_id = $(this).attr("data-page");
	        	var offset = ((page_id-1) * 10) + 1;
	        	var limit =  10;
	        	
	        	console.log("pageid="+page_id);
	        	console.log("pageid="+offset);
	        	console.log("limt="+limit);
	        	
	        	 var url	 = "/GeoReach/AjaxExpController"
	    			 var params = "offset="+offset+"&limit="+limit+"&load=next";
	    		 	  var response = "";
	    		 
	    				
	    				var xhttp = new XMLHttpRequest(); 
	    				
	    				xhttp.onreadystatechange = function() {
	    				if (this.readyState == 4 && this.status == 200
	    							&& this.response != "null") {
	    						
	    						response = this.response; 
	    						
	    						/*KTDatatableDataLocalDemo.init(response);
	    						console.log("responsenew="+response);*/
	    						dataJSONArray = JSON.parse(response);
	    						var table = $('.kt_datatable');
	    						c = table.KTDatatable();

	    						c.originalDataSet = dataJSONArray;

	    						c.reload();
	    						
	    						
	    						
	    						
	    				}};
	    				xhttp.open("GET", url+"?"+params);
	    				
	    				xhttp.send();
	    				return response;
	        }
	  }
	
	
	
	/*Code for Toggle ON and OFF*/	
	var stat = document.getElementsByClassName("stat");
	for(var i = 0; i < stat.length; i++) {
        var stats = stat[i];
        stats.onclick = function() {
        //	alert("toggle"+$(this).attr("temp").checked)
        	
        	var exp_id = this.id;
        	var status = document.getElementById(exp_id).checked;
        	console.log("status="+status+exp_id);
        	
		
		   		 var url	 = "/GeoReach/AjaxExpController"
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
	    		 var url	 = "/GeoReach/AjaxExpController"
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
	    						window.stop();
	    						
	    						
	    						
	    				}};
	    				xhttp.open("POST", url+"?"+params);
	    				
	    				xhttp.send();
	    				return response;
	        }
	    }
    
	var button = document.getElementsByClassName("btn btn-outline-brand btn-pill")
	  
	  for(var i = 0; i < button.length; i++) {
	        var buttons = button[i];
	        buttons.onclick = function() {
	        	console.log("coming");
	        	var exp_id		=	$(this).attr("data-ids");
	        	var exp_name	=	$(this).attr("data-expname");
	       
	        	document.getElementById("popover-elements").innerHTML = '<code>&lt;div id="G-"'+exp_name+'"-"'+exp_id+'"&gt;&lt;/div&gt;</code>';
				document.getElementById("experience-element").innerHTML = 'Embed Code for <span class="badge badge-secondary">"'+exp_name+'"</span>';
				$('#myModals').modal('show');
				 
	        }
	  }
 
}


function test()
	{

		$.ajax({
             type : "GET", 
            url : "/GeoReach/AjaxExpController",
            contentType: "application/json; charset=utf-8", 
            data: { 
            	offset: 1, 
            	limit: 10 
            	
              },
          
            async: true,
            success : function(data) {                
                dataJSONArray = JSON.parse(data) ;
                
                ktDATA();
                var expcount = dataJSONArray[0];
            	var exp = expcount.ExpCount;
				var recordsPerPage = 10;
				var page_display = Math.ceil(exp/recordsPerPage); 
				console.log("page=="+page_display);
				var mydiv = document.getElementById("page");
				var ul = document.createElement('ul');
				ul.setAttribute('class',"pagination");
				var list=document.createElement('li');
				list.innerHTML='<a class="page-link"   data-page = "previous" >' + "Previous"  + '</a>';
				ul.appendChild(list);
				
				for(var i = 1; i <= page_display; i++) {
					var mydiv = document.getElementById("page");
					
					
					var li=document.createElement('li');
					
			        li.innerHTML='<a class="page-link "   data-page = "'+i+'" >' + i  + '</a>';
			        
			        ul.appendChild(li);

					
				}
				var lists=document.createElement('li');
				lists.innerHTML='<a class="page-link"   data-page = "next" >' + "Next"  + '</a>';
				ul.appendChild(lists);
				document.getElementById('page').appendChild(ul);
            }
        });
                
	}
	
	function ktDATA()
	{
	 
                var datatable = $('.kt_datatable').KTDatatable({
        			// datasource definition
        				
        			data: {
        				type: 'local',
        				source: dataJSONArray,
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

        			pagination: false,

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
        					
        						var exp_name = row.experience;
        						var segArray = row.segments.split(",");
        						segArray = segArray.slice(0,segArray.lastIndexOf(","));
        					
        						
        						var s = "";
        						var seg	=	"";
        						for(var i=0;i<segArray.length;++i)
        							{  
        							
        							var segname = segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length); 
        							s += '<a href="" class="hover" data-expname="'+exp_name+'" data-toggle="modal"  title="Experience contents" data-segname="'+segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length)+'"  data-expid="'+exp_id+'" id="' + segArray[i].slice(0,segArray[i].lastIndexOf(":")) + '" >' + segname +",  " + '</a>';
        							
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
        						experid = row.id;
        						expname = row.experience;
        					
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
        					
        				
        				},{
        					field: 'statuss',
        					title: 'Page URL', 
        					template:function(row)
        					{
        					
        		 				var exp_id = row.id;
        		 				var exp_name = row.experience;
        						var r = "";
        						 
        						r+= '<button  id="myBtn" data-ids="'+exp_id+'" data-expname="'+exp_name+'" class="btn btn-outline-brand btn-pill" >View code</button>'
        							return r;
        					}
        				},  {
        					field: 'name',
        					title: 'Created By',
        				},{
        					field: 'Actions',
        					title: 'Actions',
        					sortable: false,
        					width: 110,
        					overflow: 'visible',
        					autoHide: false,
        					template: function() {
        						return '\
        						<a <a href="/GeoReach?view=pages/experience-edit-content.jsp&id='+experid+'&exp_name='+expname+'" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Edit details">\
        							<i class="la la-edit"></i>\
        						</a>\
        						<a href="javascript:;" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Delete">\
        							<i class="la la-trash"></i>\
        						</a>\
        					';
        					},
        				}],
        		});
	}
	
	