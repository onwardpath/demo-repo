var dataJSONArray = {};

jQuery(document).ready(function() {
	
	test();
	
	  
});

/*Custom Pagination for Datatables*/

$(window).ready(function() {
	

	    $('ul.pagination').on('click', 'a', function() {
	    	console.log("total_page="+ localStorage.getItem("totalpage"));
	    	var total_page = localStorage.getItem("totalpage");
	    	   if($(this).hasClass('active')) return false;
	    	    
	    	    var active_elm = $('ul.pagination a.active');
	    	    var page_id = $(this).attr("data-pageid")//on click call ajax controller(check page-id not equals to undefined)
	    	    
	    	    if(page_id == null)
	    	    	{
	    	   // 	console.log("page_id="+page_id);
	    	    	}else
	    	    		{
	    	    		
	    	    		page(page_id);
	    	    		}
	    	    var new_id = "";
	    	    var custom_id = "";
	    	   
	    	    if(this.id == 'next'){
	    	      var _next = active_elm.parent().next().children('a');
	    	      var page_idn = $(_next).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
	    	      if(page_idn == null)
	    	    	{
	    	    //	console.log("page_idn="+page_idn);
	    	    	}
	    	      else
	    	    	  {
	    	    	  
	    	    	  page(page_idn);
	    	    	  }
	    	      if($(_next).attr('id') == 'next') {
	    	    	  var page_idns = $(_next).attr('data-pageid');
	    	        // appending next button if reach end
	    	  //      var num = parseInt($('a.active').text())+1;
	    	        var testing = $('a.active').last();
	    	        var count = (testing.prevObject[0].dataset.pageid);
	    	        var num = parseInt(count) + 1;
	    	        
	    	        if(num <= total_page){
	    	        	var nums = 'test'+num;
	    	        active_elm.removeClass('active');
	    	        $('.three_links').first().remove();
	    	  			$('.three_links').last().after('<li class="three_links"><a id="'+nums+'" data-pageid="'+num+'" class="active" >'+num+'</a></li>');
	    	  			var new_element = $('.three_links').last();
	    		//		new_id = new_element[0].textContent;//on move of newly created element call ajax controller(check page-id not equals to undefined)
	    				var n = new_element[0].innerHTML;
	    				new_id = n.substring(27,28);
	    				
	    				page(new_id);
	    				
	    				
	    	        }
	    	  			return; 
	    	      }
	    	      _next.addClass('active');   
	    	      
	    	      
	    	      
	    	      
	    	    }
	    	    
	    	    else if(this.id == 'prev') {
	    	        var _prev = active_elm.parent().prev().children('a');
	    	        var page_idp = $(_prev).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
	    	        if(page_idp == null)
	    	    	{
	    	//    	console.log("page_idp="+page_idp);
	    	    	}
	    	        else
	    	        	{
	    	        	
	    	        	page(page_idp);
	    	        	}
	    	        if($(_prev).attr('id') == 'prev'){
	    	        	var page_idps = $(_prev).attr('data-pageid');
	    	     //   	var num = parseInt($('a.active').text())-1;
	    	        	 var testing = $('a.active').first();
	 	    	        var count = (testing.prevObject[0].dataset.pageid);
	 	    	        var num = parseInt(count) - 1;
	 	    	       
	    	          if(num > 0){
	    	        	  var nums = 'test'+num;
	    	            active_elm.removeClass('active');
	    	          	$('.three_links').last().remove();
	    	    				$('.three_links').first().before('<li class="three_links"><a id="'+nums+'" data-pageid="'+num+'" class="active" >'+num+'</a></li>');
	    	    				var new_element = $('.three_links').first();
	    	    		//		new_idp = new_element[0].textContent;//on move of newly created element call ajax controller(check page-id not equals to undefined)
	    	    				var r = new_element[0].innerHTML;
	    	    				new_idp = r.substring(27,28);
	    	    				
	    	    				page(new_idp);
	    	    				
	    	    				
	    	          }
	    	          return;
	    	        }
	    	        _prev.addClass('active');   
	    	      }
	    	    else {
	    	        $(this).addClass('active');
	    	      }
	    	      active_elm.removeClass('active');
	    	 
	    	       
	        
	    });
	 
});

/*Ajax Call for Custom Pagination*/

function page(id)
{
	var page_id = id;
	var page_end = "";
	var page_count = localStorage.getItem("pagecount");
	var offset  = "";
	var limit =  "";

page_id  = page_id-1 ;
if(page_id != '0'){
offset = (page_id * 10) + 1;
page_end = offset+9;
limit = 10;
}
/*else if(page_id == page_count )
	{
	
	}*/
else
	{
offset = 0; 
limit =  10;
page_end = offset+10;
	}
/*console.log("pageid="+page_id);
console.log("offset="+offset);
console.log("limt="+limit);
console.log("page_end"+page_end)*/

 		var url	 = "/GeoReach/AjaxExpController"
 		var params = "offset="+offset+"&limit="+limit+"&load=next";
 		var response = "";
 		document.getElementById("spin").style.display= "block";
 		document.getElementById("spin").style.position= "relative";
 		document.getElementById("spin").style.top= "50%";
 		document.getElementById("spin").style.left= "40%"; 
 		document.getElementById("local_data").style.display= "none";
 		document.getElementById("count").style.display = "none";
		
		var xhttp = new XMLHttpRequest(); 
		
		xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200
					&& this.response != "null") {
			document.getElementById("spin").style.display= "none";
			document.getElementById("local_data").style.display= "block";
			document.getElementById("count").style.display = "block";
				response = this.response; 
				
				dataJSONArray = JSON.parse(response);
				var table = $('.kt_datatable');
				c = table.KTDatatable();

				c.originalDataSet = dataJSONArray;

				c.reload();
				if(page_id != '0')
					{
					document.getElementById("count").innerHTML= 'Showing '+offset+' - '+page_end+' of '+page_count+'';
					}
				
				else
					{
					document.getElementById("count").innerHTML= 'Showing 1 - '+page_end+' of '+page_count+''
					}
				
				
				
		}};
		xhttp.open("GET", url+"?"+params);
		
		xhttp.send();
		return response;
}

/*Custom Search for Datatables*/

var timer;
function search() {
	
	document.getElementById("spin").style.display= "block";
	document.getElementById("spin").style.position= "relative";
	document.getElementById("spin").style.top= "50%";
	document.getElementById("spin").style.left= "40%"; 
	document.getElementById("local_data").style.display= "none";
	document.getElementById("page").style.display = "none";
	document.getElementById("count").style.display = "none";
    clearTimeout(timer) // clear the request from the previous event
    timer = setTimeout(function() {
     	var values =  document.getElementById("generalSearch").value;
    	 
        if (values.length >= 3 && values != null && values != '' ) {
		  
        document.getElementById("delete").innerHTML='\
			  <label id="find" type="text" class="col-2 col-form-label">'+values+' </label>\
				<span id="clear" class="kt-input-icon__icon kt-input-icon__icon--right">\
			  <span></span>\
			  <a href="#" class="kt-demo-panel__close" id="kt_demo_panel_close">\
			 <i style="margin-left: 50px;" class="flaticon2-delete"></i>\
			  </a>\
			  </span>\
 			  ';
      
		var url	 = "/GeoReach/AjaxExpController"
		var params = "search="+values+"&limit=10"+"&exper=search";
  		var response = "";
	   		 
	   				
			var xhttp = new XMLHttpRequest(); 
			
			xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200
						&& this.response != "null") {
					document.getElementById("page").style.display = "none";
					document.getElementById("spin").style.display= "none";
					document.getElementById("count").style.display = "none";
					document.getElementById("local_data").style.display= "block";
					
					response = this.response; 
					
				
					dataJSONArray = JSON.parse((response));
					var table = $('.kt_datatable');
					c = table.KTDatatable();

					c.originalDataSet = dataJSONArray;
                    
					c.reload();
					
					
					
					
			}};
			xhttp.open("POST", url+"?"+params);
			
			xhttp.send();
			return response;
	  }
    }, 5000);
}



window.onclick = myFunction;
function myFunction() {
	
	
	
	
	
	var anchor = document.getElementsByClassName("page-link")
	  
	  for(var i = 0; i < anchor.length; i++) {
	        var anchors = anchor[i];
	        
	      
	        	  
	        
	        anchors.onclick = function() {
	        	var previuos_page_id = "";
	        	var total_pages = "";
	        	var current_value = "";
	        	 if(this.id != 'next' )
	        		 {
	        	var current = document.getElementsByClassName("active");
	        	  if (current.length > 0) { 
	        		    current[0].className = current[0].className.replace(" active", "");
	        		  }
	        		  this.className += " active";
	        		 }
	        	  
	        	  var id = this.id;
	        	  
	        	  var active_elm = $('ul.pagination a.active');
	        	  
	        	  if(this.id == 'next' && active_elm[0].text <= 5)
	        	  {
	        		  
	        		  var current = document.getElementsByClassName("active");
		        	  if (current.length > 0) 
		        	  { 
		        		    current[0].className = current[0].className.replace(" active", "");
		        		  }
	        		  var _next = active_elm.parent().next().children('a');
	        		  _next.addClass('active');
	        		  previuos_page_id = _next.prevObject["prevObject"].prevObject[0].text;
	        		  total_pages = _next[0].dataset.page;
	        		  current_value = _next[0].text;
	        		 /* var li = document.getElementById("lists");
	        		  li.removeChild(li.childNodes[1]);*/
	        		
	        	   if ((current_value == 'Next') && (active_elm[0].text >= 5) ) 
	        		  
	        			{
	        			var li = document.getElementById("lists");
	        			var page_value = previuos_page_id + 1; 
	        			var NewElement = document.createElement('li');
	        			NewElement.innerHTML = '<a class="page-link " id="test'+page_value+'"  data-pageid='+page_value+' data-page = "'+total_pages+'"   >' + page_value  + '</a>';;
	        			
	        			/*new code for next element creation*/
	        			 var current = document.getElementsByClassName("active");
			        	  if (current.length > 0) { 
			        		    current[0].className = current[0].className.replace(" active", "");
			        		  }
		        		  var _next = active_elm.parent().next().children('a');
		        		  _next.addClass('active');
		        		  previuos_page_id = _next.prevObject["prevObject"].prevObject[0].text;
		        		  total_pages = _next[0].dataset.page;
		        		  current_value = _next[0].text;
	        			
	        			
	        			var li = document.getElementById("lists");
	        			li.removeChild(li.childNodes[1]);
	        			}
	        	  }
	        	  /*if(this.id == 'prev'){
	        		  var li = document.getElementById("lists");
	        		  li.removeChild(li.childNodes[5]);
	        		 
	        	  }*/
	        	  else
	        		  {
	        	  var page_id = $(this).attr("data-pageid")
	        	previuos_page_id  = page_id-1 ; 
	        		  }
	        	var offset = (previuos_page_id * 10) + 1;
	        	var limit =  10;
	        	
	        	
	        	
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
	       
	        	document.getElementById("popover-elements").innerHTML = '<code>&lt;div id="G-'+exp_name+'-'+exp_id+'"&gt;&lt;/div&gt;</code>';
				document.getElementById("experience-element").innerHTML = 'Embed Code for <span class="badge badge-secondary">'+exp_name+'</span>';
				$('#myModals').modal('show');
				 
	        }
	  }
	
	var clear = document.getElementsByClassName("kt-demo-panel__close")
	
	 for(var i = 0; i < clear.length; i++) {
	        var clears = clear[i];
	        clears.onclick = function() {
	        	
	        	console.log("clear console true")
	        	document.getElementById("delete").style.display = "none";
	        	window.location.reload(true);
	        }
	 }
	
 
}


function test()
	{
	document.getElementById("spin").style.display= "block";
	document.getElementById("spin").style.position= "relative";
	document.getElementById("spin").style.top= "50%";
	document.getElementById("spin").style.left= "40%"; 
	document.getElementById("local_data").style.display= "none";
		$.ajax({
            type : "GET", 
           
            url : "/GeoReach/AjaxExpController",
            contentType: "application/json; charset=utf-8", 
            data: { 
            	offset: 0, 
            	limit:10  
            	
              },
          
            async: true,
          
            success : function(data) {    
            	document.getElementById("local_data").style.display= "block";
            	document.getElementById("spin").style.display= "none";
                dataJSONArray = JSON.parse(data) ;
                ktDATA();
                var expcount = dataJSONArray[0];
            	var exp = expcount.ExpCount;
				var recordsPerPage = 10;
				var page_display = Math.ceil(exp/recordsPerPage); 
				console.log("page=="+page_display);
				localStorage.setItem("totalpage", page_display);
				localStorage.setItem("pagecount", exp);
				var mydiv = document.getElementById("page");
				/*var ul = document.createElement('ul');
				ul.setAttribute('class',"pagination");
				ul.setAttribute('id',"lists");
				ul.setAttribute("onclick","paginate();")*/
				var list=document.createElement('li');
				list.innerHTML='<a class="flaticon2-back"  id="prev"  data-page = "previous" >' + ""  + '</a>';
				mydiv.appendChild(list);
				
				var x = document.getElementsByClassName("page-link");
				for(var i = 1; i <= page_display; i++) 
				{
				
					if(i > 5)
					{
					for (var p = 5; p < x.length; p++) {
					document.getElementsByClassName("three_links")[p].style.display = 'none';
					}
					}
					else
						{
					var mydiv = document.getElementById("page");
					
					
					var li=document.createElement('li');
					li.setAttribute('class',"three_links");
					
					if(i == 1)
					{
			        li.innerHTML='<a  class="active" id="test'+i+'"  data-pageid='+i+' data-page = "'+page_display+'" >' + i  + '</a>';
					
					console.log("true="+i);
					}
					else
			 			{
						li.innerHTML='<a id="test'+i+'" data-pageid='+i+'  data-page = "'+page_display+'" >' + i  + '</a>';	
						}
					mydiv.appendChild(li);
						
						}
					
				}
				var lists=document.createElement('li');
				lists.innerHTML='<a class="flaticon2-next" id="next"  data-page = "next" >' + ""  + '</a>';
				mydiv.appendChild(lists);
				
				document.getElementById("count").innerHTML= 'Showing 1 - 10 of '+exp+''
				
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
        			
        			searching: false,

        			/*search: {
        				input: $('#generalSearch'),
        			},*/

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
        					title: 'Embed Code', 
        					template:function(row)
        					{
        					
        		 				var exp_id = row.id;
        		 				var exp_name = row.experience;
        						var r = "";
        						 
        						r+= '<button  id="myBtn" data-ids="'+exp_id+'" data-expname="'+exp_name+'" class="btn btn-outline-brand btn-pill" >View</button>'
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
	
	