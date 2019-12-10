var dataJSONArray = {};

jQuery(document).ready(function() {

test();
	/*console.log(document.getElementById('popoverData').getAttribute('data-content'));
	var myInput = document.getElementById('popoverData');
	var sec = myInput.getAttribute('data-content');
	myInput.setAttribute('data-content', 'custom-value');
	console.log(myInput.setAttribute('data-content', 'custom-value'));*/
	$('#popoverData').popover(); 
	
	  
});

function loading(){
	if(document.getElementById('user').className == "kt-header__topbar-item kt-header__topbar-item--user")
	{
	document.getElementById('user').className = "kt-header__topbar-item kt-header__topbar-item--user show ";

	
	var myInput = document.getElementById('expand');
	var sec = myInput.getAttribute('aria-expanded');
	myInput.setAttribute('aria-expanded', 'true');
	document.getElementById('show').className = "dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm show";
}
else
	{
	document.getElementById('user').className = "kt-header__topbar-item kt-header__topbar-item--user ";
	var myInput = document.getElementById('expand');
	var sec = myInput.getAttribute('aria-expanded');
	myInput.setAttribute('aria-expanded', 'false');
	document.getElementById('show').className = "dropdown-menu dropdown-menu-fit dropdown-menu-right dropdown-menu-anim dropdown-menu-top-unround dropdown-menu-sm ";
	}
}

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
    				/*var n = new_element[0].innerHTML;
    				new_id = n.substring(27,28);*/
    				
    				page(num);
    				
    				
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
    	    			/*	var r = new_element[0].innerHTML;
    	    				new_idp = r.substring(27,28);*/
    	    				
    	    				page(num);
    	    				
    	    				
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

else
	{
offset = 0; 
limit =  10;
page_end = offset+10;
	}


 		var url	 = "/GeoReach/AjaxSegController"
 		var params = "offset="+offset+"&limit="+limit+"&load=next&segtype=loc&segbev=beh";
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
			 <i style="margin-left: 100px;" class="flaticon2-delete"></i>\
			  </a>\
			  </span>\
 			  ';
      
		var url	 = "/GeoReach/AjaxSegController"
 		var params = "search="+values+"&limit=10"+"&segtype=loc&segbev=beh";
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


document.body.onclick= function(e){
e=window.event? event.srcElement: e.target;
if(e.className && e.className.indexOf('flaticon2-delete')!=-1)
		{
				 
        	
        	console.log("clear console true")
        	document.getElementById("delete").style.display = "none";
        	window.location.reload(true);
				        
				 
				
		}
}


function test()
	{
document.getElementById("spin").style.display= "block";
document.getElementById("spin").style.position= "relative";
document.getElementById("spin").style.top= "50%";
document.getElementById("spin").style.left= "40%"; 
document.getElementById("local_data").style.display= "none";
var seg_geo = "loc";
var seg_beh = "beh";

		$.ajax({
            type : "GET", 
           
            url : "/GeoReach/AjaxSegController",
            contentType: "application/json; charset=utf-8", 
            data: { 
            	'segtype':seg_geo, 
            	'segbev':seg_beh,
            	offset: 0, 
            	limit:10
            	
              },
          
            async: true,
          
            success : function(data) {    
            	document.getElementById("local_data").style.display= "block";
            	document.getElementById("spin").style.display= "none";
            	
                dataJSONArray = JSON.parse(data) ;
                ktDATA();
                var count = dataJSONArray[0];
            	var tot_segment = count.SegCount;
				var recordsPerPage = 10;
				var seg_display = Math.ceil(tot_segment/recordsPerPage); 
				console.log("seg=="+seg_display);
				localStorage.setItem("totalpage", seg_display);
				localStorage.setItem("pagecount", tot_segment);
				var mydiv = document.getElementById("page");
				/*var ul = document.createElement('ul');
				ul.setAttribute('class',"pagination");
				ul.setAttribute('id',"lists");
				ul.setAttribute("onclick","paginate();")*/
				var list=document.createElement('li');
				list.innerHTML='<a class="flaticon2-back"  id="prev"  data-page = "previous" >' + ""  + '</a>';
				mydiv.appendChild(list);

				var x = document.getElementsByClassName("page-link");
				for(var i = 1; i <= seg_display; i++) 
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
					li.innerHTML='<a  class="active" id="test'+i+'"  data-pageid='+i+' data-page = "'+seg_display+'" >' + i  + '</a>';
					
					console.log("true="+i);
					}
					else
						{
						li.innerHTML='<a id="test'+i+'" data-pageid='+i+'  data-page = "'+seg_display+'" >' + i  + '</a>';	
						}
					mydiv.appendChild(li);
						
						}
					
				}
				var lists=document.createElement('li');
				lists.innerHTML='<a class="flaticon2-next" id="next"  data-page = "next" >' + ""  + '</a>';
				mydiv.appendChild(lists);

				document.getElementById("count").innerHTML= 'Showing 1 - 10 of '+tot_segment+''
               
				
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

        		/*	search: {
        				input: $('#generalSearch'),
        			},
*/
        			// columns definition
        			columns: [
        				{
        					
        					field: 'Seg_id',
        					title: '#',
        					sortable: false,
        					width: 20,
        					type: 'number',
        					selector: {class: 'kt-checkbox--solid'},
        					textAlign: 'center',
        				}, {
        					field: 'segment',
        					title: 'Segment',
        				}, {
        					field: '',
        					title: 'Rule',
        					template: function(row) {
        						
        						var geo = row.geography; 
        						var r = "";
        						if (geo.indexOf("}") !=0) {
									var beginIndex = geo.indexOf("{")+1;
									var endIndex = geo.indexOf("}");											
									geo = geo.substring(beginIndex, endIndex);
									console.log("segmentrules="+geo);
								}
        						var rule = geo.split("|");
        						for(var i = 0;i<rule.length ;i++)
        							{
        							var criteria = rule[i].split(":");
        							var label = criteria[1]+" "+criteria[2]+" "+criteria[3];
        							
        							if (criteria[0].startsWith("include")) {
        								if((criteria[1].startsWith("State"))||(criteria[1].startsWith("state"))||(criteria[1].startsWith("city"))||(criteria[1].startsWith("country")))
        									{
										r += "<button  type='button' class='btn btn-outline-info btn-pill'>"+criteria[2]+"&nbsp;<i class='fa fa-map-marker-alt'></i></button>";	
        									}
        								
        								else
    									{
        								r += "<button  type='button' class='btn btn-outline-info btn-pill'><i class='fa fa-user-clock'></i>"+label+"&nbsp;</button>";
    									}
									}
        							
        							}
        						
        		
        							return r;
        				//	var segmentRules =row.geography;
        					/*if (segmentRules.indexOf("}") !=0) {
								var beginIndex = segmentRules.indexOf("{")+1;
								var endIndex = segmentRules.indexOf("}");											
								segmentRules = segmentRules.substring(beginIndex, endIndex);
								console.log("segmentrules="+segmentRules);
							}
        					var rule = segmentRules.split("\\|"); 
							
								for(var i=0;i<rule.length;++i){
								var criteria = rule[i].split(":");
								console.log("criteria="+criteria[0]+criteria[2]);
								var display = "";
								if (criteria[0].startsWith("include")) {												
									display = "<button  type='button' class='btn btn-outline-info btn-pill'>"+criteria[2]+"&nbsp;<i class='fa fa-map-marker-alt'></i></button>";	
									console.log("criteria2="+criteria[2]);
								} else {
									display = "<button  type='button' class='btn btn-outline-danger btn-pill'>"+criteria[2]+"&nbsp;<i class='fa fa-map-marker-alt'></i></button>";
									console.log("criteria2s="+criteria[2]);
								}	
							}*/
        					}
        				},/*{
        					field: 'segment',
        					title: 'Geography',
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
        				}, */ /*{
        					field: 'statuss',
        					title: 'Embed Code', 
        					template:function(row)
        					{
        					
        		 				var exp_id = row.id;
        		 				var exp_name = row.experience;
        						var r = "";
        						 
        						r+= '<button  id="myBtn"  dat-seg=""  onclick="javascript:embed(this)" data-ids="'+exp_id+'" data-expname="'+exp_name+'" class="btn btn-outline-brand btn-pill" >View</button>'
        							return r;
        					}
        				}, */ {
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
        						<a <a href="/GeoReach?view=pages/experience-edit-content.jsp class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Edit details">\
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
	