var dataJSONArray = {};

jQuery(document).ready(function() {
	
	var offset = 0;
	var limit = 10;  
	var record = 10;

	test(offset,limit,record); 
	
	localStorage.setItem("pageload", "onload");
	
	/*$('#popoverData').popover(); 
	container: 'body'*/
	 
});
/*$(document).on('mouseenter', '.hover', function () {
	$("[data-toggle=popover]").popover();
})*/
$(document).on('mouseenter', '.flaticon-eye', function () {
    //do
	//alert("coming true="+this.id);
	var segment_id	=	$(this).attr('id');
	/*var theID = $(this).attr('id');
	var myInput = $('#' + theID );
	var sec = myInput.attr('data-content', 'custom-data');

	$('#' + theID ).popover(); */
	
	console.log("segment=="+segment_id);
	var exp_id		=	$(this).attr('data-expid')
	var seg_name    =   $(this).attr('data-segname');
	var exp_type	=	$(this).attr('data-exptype');
	
	 var url	 = "/GeoReach/AjaxExpController"
		 var params = "service="+segment_id+"&expid="+exp_id+"&exper="+exp_type+"";
	 	  var response = "";
	 
			
			var xhttp = new XMLHttpRequest(); 
			
			xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200
						&& this.response != "null") {
					
					response = this.response; 
					var json = JSON.parse(response);
					var temp = json[0]; 
				//	KTDatatableDataLocalDemo.init(response);
					console.log("content="+temp.content);
					document.getElementById("popover-element").innerHTML = temp.content;
					document.getElementById("segment-element").innerHTML = seg_name;
					$('#myModal').modal('show');
			/*//		$('#popover-element').popover();
					var theID = $(this).attr('id');
					var myInput = $('#' + segment_id );
					var sec = myInput.attr('data-content', temp.content);
					myInput.popover();*/ 
					
					
					
					
			}};
			xhttp.open("POST", url+"?"+params);
			
			xhttp.send();
			return response;
}).on('mouseleave', '.dynamic', function () {
    console.log("leave ");
});


/*$('.hover').mouseover(function() {
	   var theID = $(this).attr('data-expid');
	   $('#' + theID + '#myModal').modal('show');
	});*/

/*$('.hover').mouseover(function() {
	 
	});
*/
$(document).on("change","#mySelect", function() {
	 let clickedOption = $(this).val();
	 console.log("cliock="+clickedOption);
	 console.log("value="+$(this).val());
	 localStorage.setItem("pageload", "onclick");
	 var tot_page = localStorage.getItem("pagecount");
	 console.l

	 var offset = 0;
	 var limit = $(this).val();
	 var record = $(this).val();
		
		document.getElementById("spin").style.display= "block";
		document.getElementById("spin").style.position= "relative";
		document.getElementById("spin").style.top= "50%";
		document.getElementById("spin").style.left= "40%"; 
		document.getElementById("local_data").style.display= "none";
		document.getElementById("mySelect").style.display = "none";
		document.getElementById("count").style.display = "none";
			$.ajax({
	            type : "GET", 
	           
	            url : "/GeoReach/AjaxExpController",
	            contentType: "application/json; charset=utf-8", 
	            data: { 
	            	offset: offset, 
	            	limit:limit  
	            	
	              },
	          
	            async: true,
	          
	            success : function(data) {    
	            	document.getElementById("local_data").style.display= "block";
	            	document.getElementById("spin").style.display= "none";
	            	document.getElementById("mySelect").style.display = "unset";
	            	document.getElementById("count").style.display = "unset";
	                /*dataJSONArray = JSON.parse(data) ;
	                ktDATA();*/
	                
	                response = this.response; 
					
					dataJSONArray = JSON.parse(data);
					var table = $('.kt_datatable');
					c = table.KTDatatable();

					c.originalDataSet = dataJSONArray;

					c.reload();
	                var expcount = dataJSONArray[0];
	            	var exp = expcount.ExpCount;
					var recordsPerPage = record;
					var page_display = Math.ceil(exp/recordsPerPage); 
					console.log("page=="+page_display);
					localStorage.setItem("totalpage", page_display);
					localStorage.setItem("pagecount", exp);
					localStorage.setItem("pagelimit", record);
					$('#page').empty();
					paginate(page_display,exp,limit);

					
	            }
	        });
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
/*Custom Pagination for Datatables*/
$(window).ready(function() {
	

	    $('ul.pagination').on('click', 'a', function() {
	    	console.log("total_paged="+ localStorage.getItem("totalpage"));
	    	var total_page = localStorage.getItem("totalpage");
	    //	localStorage.setItem("pageload", "onlick");
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
	    	    
	    	    var l_total_page = $(this).attr("data-load");//on click call ajax controller(check page-id not equals to undefined)
	    	    var l_next = $(this).attr("data-page");
	    	    var load = localStorage.getItem("pageload");
	    	    var c_page = $(this).attr("data-pageid");
	    	    if((load != "onload"))
	    	    	{
	    	  
	    	    if((total_page == l_total_page) && (l_next == "last_next")&& (total_page >= 6) )
	    	    	{
	    	    	console.log("page_id="+l_total_page);
	    	    	
	    	    	 var page_i = total_page - 4;
	    	    	 var page_e = total_page - 1;
	    	    	  for(var i=page_i,j=1,numt=page_i;i<=total_page;i++) 
	    	    						{
	    	    						j++;
	    	    						var num = numt++;
	    	    						 num = parseInt(num) ;	
	    	    						var nums = 'test'+num;
	    	    						if( i == total_page)
	    	    							{
	    	    							active_elm.removeClass('active');
	    	    							var list = document.createElement("li");
	    	    							list.setAttribute('class',"three_links");
	    	    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
	    	    			    	    	
	    	    							}
	    	    						else
	    	    							{
	    	    						var list = document.createElement("li");
	    	    						list.setAttribute('class',"three_links");
	    	    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
	    	    							}
	    	    	  var item = document.getElementById("page");
	    	    	  item.replaceChild(list, item.childNodes[j]);
	    	    	  
	    	    	  
	    	    						}
	    	    	  if(total_page == l_total_page)
	    	    		  {
	    	    		  document.getElementById("next").style.pointerEvents  = "none";
	  	    	    	  document.getElementById("last").style.pointerEvents  = "none";
	    	    		  }
	    	    	  
	    	    	page(total_page);
	    	    	}
	    
	    	    else if((total_page == l_total_page) && (l_next == "last_previous")&& (total_page >= 6))
	    	    {
	    	    	console.log("page_id="+l_total_page);
	    	    	
	    	    	 
	    	    	  for(var i=1,j=1,numt=1;i<=5;i++) 
    						{
	    	    		  var id = 1;
    						j++;
    						var num = numt++;
	   						num = parseInt(num) ;	
	   						var nums = 'test'+num;
    						if( i == 1)
    							{
    							 
    							var list = document.createElement("li");
    							list.setAttribute('class',"three_links");
    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
    			    	    	document.getElementById("last").className="";  
    							}
    						else
    							{
    						var list = document.createElement("li");
    						list.setAttribute('class',"three_links");
    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
    							}
					    	  var item = document.getElementById("page");
					    	  item.replaceChild(list, item.childNodes[j]);
    	  
    						}
    	  
    	page(id);
    	}
	    	    	}
	    	    else
	    	    	{
	    	    	 if((total_page == l_total_page) && (l_next == "last_next") && (total_page > 6))
		    	    	{
		    	    	console.log("page_id="+l_total_page);
		    	    	
		    	    	 var page_i = total_page - 4;
		    	    	 var page_e = total_page - 1;
		    	    	  for(var i=page_i,j=2,numt=page_i;i<=total_page;i++) 
		    	    						{
		    	    						j++;
		    	    						var num = numt++;
		    	    						 num = parseInt(num) ;	
		    	    						var nums = 'test'+num;
		    	    						if( i == total_page)
		    	    							{
		    	    							active_elm.removeClass('active');
		    	    							var list = document.createElement("li");
		    	    							list.setAttribute('class',"three_links");
		    	    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
		    	    			    	    	
		    	    							}
		    	    						else
		    	    							{
		    	    						var list = document.createElement("li");
		    	    						list.setAttribute('class',"three_links");
		    	    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
		    	    							}
		    	    	  var item = document.getElementById("page");
		    	    	  item.replaceChild(list, item.childNodes[j]);
		    	    	  
		    	    	  
		    	    						}
		    	    	  /*if(total_page == l_total_page)
	    	    		  {
	    	    		  document.getElementById("next").style.pointerEvents  = "none";
	  	    	    	  document.getElementById("last").style.pointerEvents  = "none";
	    	    		  }*/
		    	    	page(total_page);
		    	    	
		    	    	}
		    	    else if((total_page == l_total_page) && (l_next == "last_previous") && (total_page > 6))
		    	    {
		    	    	console.log("page_id="+l_total_page);
		    	    	
		    	    	 
		    	    	  for(var i=1,j=2,numt=1;i<=5;i++) 
	    						{
		    	    		  var id = 1;
	    						j++;
	    						var num = numt++;
		   						num = parseInt(num) ;	
		   						var nums = 'test'+num;
	    						if( i == 1)
	    							{
	    							 
	    							var list = document.createElement("li");
	    							list.setAttribute('class',"three_links");
	    			    	    	list.innerHTML='<a class="active"  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
	    			    	    	document.getElementById("last").className="";  
	    							}
	    						else
	    							{
	    						var list = document.createElement("li");
	    						list.setAttribute('class',"three_links");
	    						list.innerHTML='<a class=""  id="'+nums+'" data-pageid="'+num+'" >' + i  + '</a>';
	    							}
	    	  var item = document.getElementById("page");
	    	  item.replaceChild(list, item.childNodes[j]);
	    	  
	    						}
	    	  
	    	page(id);
	    	}
	    	    	
	    	    	}
	    	    var new_id = "";
	    	    var custom_id = "";
	    	  
	    	    if(this.id == 'next'){
	    	      var _next = active_elm.parent().next().children('a');
	    	      var page_idn = $(_next).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
	    	      var next = true;
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
	    	        var next_num = num;
	    	        
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
	    				
	    				if((next_num == total_page))
		    	    	{
		    	    	document.getElementById("next").style.pointerEvents  = "none";
		    	    	document.getElementById("last").style.pointerEvents  = "none";
		    	    	}
	    				
	    				
	    	        }
	    	  			return; 
	    	      }
	    	      _next.addClass('active');   
	    	      
	    	    
	    	      
	    	    }
	    	    
	    	    else if(this.id == 'prev') {
	    	        var _prev = active_elm.parent().prev().children('a');
	    	        var page_idp = $(_prev).attr('data-pageid');//on move  call ajax controller(check page-id not equals to undefined)
	    	        localStorage.setItem("page_idp", page_idp);
	    	        var prev = true;
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
	 	    	        var prev_num = num;
	 	    	       
	    	          if(num > 0){
	    	        	  var nums = 'test'+num;
	    	            active_elm.removeClass('active');
	    	          	$('.three_links').last().remove();
	    	    				$('.three_links').first().before('<li class="three_links"><a id="'+nums+'" data-pageid="'+num+'" class="active" >'+num+'</a></li>');
	    	    				var new_element = $('.three_links').first();
	    	    		//		new_idp = new_element[0].textContent;//on move of newly created element call ajax controller(check page-id not equals to undefined)
	    	    			/*	var r = new_element[0].innerHTML;
	    	    				new_idp = r.substring(27,28);*/
	    	    				
	    	    				if((prev_num == 1))
	    		    	    	{
    	    					document.getElementById("prev").style.pointerEvents  = "none";
    			    	    	document.getElementById("first").style.pointerEvents  = "none";	
	    		    	    	}
	    	    				
	    	    				page(num);
	    	    				
	    	    				
	    	          }
	    	          return;
	    	        }
	    	        _prev.addClass('active');   
	    	      }
	    	    else {
	    	        $(this).addClass('active');
	    	        document.getElementById("last").className="flaticon2-fast-next";
		    	    document.getElementById("first").className="flaticon2-fast-back";
		    	    if(((total_page == l_total_page) && (l_next == "last_next")) && (total_page >= 6))
  	    		  {
		    	    document.getElementById("next").style.pointerEvents  = "none";
	    	    	document.getElementById("last").style.pointerEvents  = "none";
	    	    	document.getElementById("prev").style.pointerEvents  = "unset";
	    	    	document.getElementById("first").style.pointerEvents  = "unset";	
  	    		  }
		    	    else if(((total_page == l_total_page) &&(l_next == "last_previous"))&& (total_page >= 6))
		    	    {
	    	    	document.getElementById("prev").style.pointerEvents  = "none";
	    	    	document.getElementById("first").style.pointerEvents  = "none";	
	    	    	document.getElementById("next").style.pointerEvents  = "unset";
		    	    document.getElementById("last").style.pointerEvents  = "unset";
		    	    }
		    	    else if(total_page >= 6)
		    	    	{
		    	    	document.getElementById("next").style.pointerEvents  = "unset";
		    	    	document.getElementById("last").style.pointerEvents  = "unset";
		    	    	document.getElementById("prev").style.pointerEvents  = "unset";
		    	    	document.getElementById("first").style.pointerEvents  = "unset";	
		    	    	console.log("previous page")
		    	    	}
		    	    
	    	      }
	    	    
	    	      active_elm.removeClass('active');
	    	      localStorage.getItem("page_idp", page_idp);
	    	      if((page_idn == total_page) && (total_page >= 6))//onclick disable last_next adn next button
		    	     {
		    	    	document.getElementById("next").style.pointerEvents  = "none";
		    	    	document.getElementById("last").style.pointerEvents  = "none";
		    	     }
	    	      else if(((page_idp == 1) ||(page_id == 1))&& (total_page >= 6))
	    	    	  {
	    	    	  	document.getElementById("prev").style.pointerEvents  = "none";
		    	    	document.getElementById("first").style.pointerEvents  = "none";	
	    	    	  }
	    	      else if((page_id == total_page )&& (total_page >= 6))
		    	  {
			    	  document.getElementById("next").style.pointerEvents  = "none";
			    	  document.getElementById("last").style.pointerEvents  = "none";
		    	  }
	    	      else if((prev)&& (total_page >= 6))
	    	    	  {
	    	    	  document.getElementById("next").style.pointerEvents  = "unset";
		    	      document.getElementById("last").style.pointerEvents  = "unset";
	    	    	  }
	    	      else if((next)&& (total_page >= 6))
    	    	  {
	    	    	document.getElementById("prev").style.pointerEvents  = "unset";
		    	    document.getElementById("first").style.pointerEvents  = "unset";	
    	    	  }
	    	       
	        
	    });
	 
});

/*Ajax Call for Custom Pagination*/
function page(id)
{
	var page_id = id;
	var page_end = "";
	var page_count = localStorage.getItem("pagecount");
	
	var offset  = "";
	var limit =  localStorage.getItem("pagelimit");
	var offset_l = "";

//page_id  = page_id-1 ;

if(limit == 20){
	
if(page_id != '1'){

offset = (page_id * 20) - 19;

page_end = offset+19;
limit = limit;
}

else
	{
offset = 0; 
limit =  limit;
page_end = limit;
	}
}

else if(limit == 50){
	
if(page_id != '0'){

offset = (page_id * 50) - 49;

page_end = offset+49;
limit = limit;
}

else
	{
offset = 0; 
limit =  limit;
page_end = limit;
	}
}
else if(limit == 100){
	
if(page_id != '0'){

offset = (page_id * 100) - 99;

page_end = offset+99;
limit = limit;
}

else
	{
offset = 0; 
limit =  limit;
page_end = limit;
	}
}
else if(limit == 10)
{
page_id  = page_id-1 ;
if(page_id != '0'){

offset = (page_id * 10) + 1;

page_end = offset+9;
limit = limit;
}

else
	{
offset = 0; 
limit =  limit;
page_end = limit;
	}
}



 		var url	 = "/GeoReach/AjaxExpController"
 		var params = "offset="+offset+"&limit="+limit+"&load=next";
 		var response = "";
 		document.getElementById("spin").style.display= "block";
 		document.getElementById("spin").style.position= "relative";
 		document.getElementById("spin").style.top= "50%";
 		document.getElementById("spin").style.left= "40%"; 
 		document.getElementById("local_data").style.display= "none";
 		document.getElementById("count").style.display = "none";
 		document.getElementById("mySelect").style.display = "none";
 		
		var xhttp = new XMLHttpRequest(); 
		
		xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200
					&& this.response != "null") {
			document.getElementById("spin").style.display= "none";
			document.getElementById("local_data").style.display= "block";
			document.getElementById("count").style.display = "unset";
			document.getElementById("mySelect").style.display = "unset";
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
	document.getElementById("mySelect").style.display = "none";
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
					document.getElementById("mySelect").style.display = "none";
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
	   
	   
   
	   if(e.className && e.className.indexOf('fa fa-inverse fa-stack-1x')!=-1)
	   {
	   
		   var url		=	e.getAttribute("data-seg");
	   	   var exp_name	=	e.getAttribute("data-expname");
	   	   var url_count = 	e.getAttribute("data-count");
	   	   var s = "";
	   	   
	   	   if(url_count == 0)
	   		   {
	   		   console.log("working for zero");
	   		/*document.getElementById("popurl-elements").innerHTML = '<span class="fa fa-info-circle">Experience Enabled on the following pages <br><br></span><div id = "url" class="kt-demo-icon__class" style=" margin-top: 11px;">No URL Configured</div>';
	   		document.getElementById("experience-elements").innerHTML = exp_name;
			$('#modalurls').modal('show');*/
			return false;
	   		   }
	   	   if(url.includes(",") == true)
	   		   {
	   		   var r = url.split(",");
	   		   for(var i = 0;i<r.length;i++)
	   		   {
	   		 s+= r[i]+"<br>  ";/* document.getElementById("popurl-elements").innerHTML = 'Experience created for following URL <br><br>'+r[i]+"<br>  " + '';*/
	   		   
	   		   } 
	   		document.getElementById("popurl-elements").innerHTML = '<span class="fa fa-info-circle">Experience Enabled on the following pages <br><br></span><div id = "url" class="kt-demo-icon__class" style=" margin-top: 11px;">'+s+ '</div>'
	   		document.getElementById("experience-elements").innerHTML = exp_name;
			$('#modalurls').modal('show');
	   		   }
	   	   else
	   		   {
	   		document.getElementById("popurl-elements").innerHTML = '<span class="fa fa-info-circle">Experience Enabled on the following pages <br><br></span><div id = "url" class="kt-demo-icon__class" style=" margin-top: 11px;">'+url+"<br>  " + '</div>';
	   		document.getElementById("experience-elements").innerHTML = exp_name;
			$('#modalurls').modal('show');
	   		   }
	   
	   }
	   if(e.className && e.className.indexOf('btn btn-outline-brand btn-pill')!=-1)
	   {
		   /*alert('hohoho');*/
		   console.log("view");
		   
			console.log("coming");
        	var exp_id		=	e.getAttribute("data-ids");
        	var exp_name	=	e.getAttribute("data-expname");
       
        	document.getElementById("popover-elements").innerHTML = '<code>&lt;div id="G-'+exp_name+'-'+exp_id+'"&gt;&lt;/div&gt;</code>';
			document.getElementById("experience-element").innerHTML = 'Embed Code for <span class="badge badge-secondary">'+exp_name+'</span>';
			$('#myModals').modal('show');
	   }
	   if(e.className && e.className.indexOf('flaticon-eye')!=-1)
	   {
		   
   		
   		var segment_id	=	e.getAttribute("id");
    	
    	console.log("segment=="+segment_id);
		var exp_id		=	e.getAttribute("data-expid");
		var seg_name    =   e.getAttribute("data-segname");
		
		
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
						console.log("content="+temp.content);
						document.getElementById("popover-element").innerHTML = temp.content;
						document.getElementById("segment-element").innerHTML = seg_name;
						$('#myModal').modal('show');
				//		$('#popover-element').popover(); 
						
						
						
				}};
				xhttp.open("POST", url+"?"+params);
				
				xhttp.send();
				return response;
   		
   		
	   }
	   
	   if(e.className && e.className.indexOf('flaticon2-delete')!=-1)
	   {
			 
			        	
			        	console.log("clear console true")
			        	document.getElementById("delete").style.display = "none";
			        	window.location.reload(true);
			        
			 
			
	   }
	   
	   /*if(e.className && e.className.indexOf('select')!=-1)
	   {
		   var select = document.getElementById("mySelect");
			var selectedText = select.options[select.selectedIndex].text;
			console.log("onclick select text="+selectedText);
			
			
	   }*/
	}

/*document.body.onclick= function(e){
	   e=window.event? event.srcElement: e.target;
	   
	}*/

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
        	console.log("status="+status);
        	
        	
		
		   		 var url	 = "/GeoReach/AjaxExpController"
	   			 var params = "service="+status+"&expid="+exp_id+"&exper=status";
	   			  var response = "";
	   		 
	   				
	   				var xhttp = new XMLHttpRequest(); 
	   				 
	   				xhttp.onreadystatechange = function() {
	   				if (this.readyState == 4 && this.status == 200
	   							&& this.response != "null") {
	   						
	   						response = this.response; 
	   				
	   				}};
	   				xhttp.open("POST", url+"?"+params);
	   				
	   				xhttp.send();
	   				return response;
					
    	
    }
    }
	

 
}
function paginate(page_display,exp,limit)
{
	var mydiv = document.getElementById("page");
	var load = localStorage.getItem("pageload");
	var limit = limit;
	/*var ul = document.createElement('ul');
	ul.setAttribute('class',"pagination");
	ul.setAttribute('id',"lists");
	ul.setAttribute("onclick","paginate();")*/
	var total_page = localStorage.getItem("totalpage");
	var lists=document.createElement('li');
	lists.innerHTML='<a class="flaticon2-fast-back" id="first"  data-load = "'+page_display+'"  data-page = "last_previous" >' + ""  + '</a>';
	mydiv.appendChild(lists);
	
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
	var list_next=document.createElement('li');
	list_next.innerHTML='<a class="flaticon2-fast-next" id="last"  data-load = "'+page_display+'"  data-page = "last_next" >' + ""  + '</a>';
	mydiv.appendChild(list_next);
	

	  if(total_page < 5)
	{
	document.getElementById("first").style.pointerEvents  = "none";
	document.getElementById("last").style.pointerEvents  = "none";
	}
	 if(((load == "onload")|| (load == "onclick")) &&(total_page >= 6))
		 {
		 document.getElementById("prev").style.pointerEvents  = "none";
	     document.getElementById("first").style.pointerEvents  = "none";	
		 }
	
	document.getElementById("count").innerHTML= 'Showing 1 - '+limit+' of '+exp+''	
	
}

function test(offset,limit,record)
	{
	var offset = offset;
	var limit = limit;
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
            	offset: offset, 
            	limit:limit  
            	
              },
          
            async: true,
          
            success : function(data) {    
            	document.getElementById("local_data").style.display= "block";
            	document.getElementById("spin").style.display= "none";
            	document.getElementById("mySelect").style.visibility = "visible";
            	document.getElementById("mySelect").style.display = "unset";
            	document.getElementById("search").style.display = "block";
            	console.log("string data="+JSON.stringify(data));
            	console.log("parse data="+JSON.parse(data));
                dataJSONArray = JSON.parse(data) ;
                console.log("data="+JSON.stringify(data));
                ktDATA();
                var expcount = dataJSONArray[0];
            	var exp = expcount.ExpCount;
				var recordsPerPage = record;
				var page_display = Math.ceil(exp/recordsPerPage); 
				console.log("page=="+page_display);
				localStorage.setItem("totalpage", page_display);
				localStorage.setItem("pagecount", exp);
				localStorage.setItem("pagelimit", limit);
				
				var tot_page = localStorage.getItem("pagecount");
				if(tot_page <= 10)
				 {
				 $('option[value=20]').prop('disabled', true);
				 $('option[value=50]').prop('disabled', true);
				 $('option[value=100]').prop('disabled', true);
				 }
			 else if(tot_page <= 20)
				 {
				 $('option[value=50]').prop('disabled', true);
				 $('option[value=100]').prop('disabled', true);
				 }
			 else if(tot_page <= 50)
				 {
				 $('option[value=100]').prop('disabled', true);
				 }

				paginate(page_display,exp,limit);

				
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
    				},{
    					field: 'status', 
    					title: 'Type',
    					// callback function support for column rendering
    					template:function(exp)
    					{
    						if((exp.status == 'content')) 
							{
							return '\
							  <i class="flaticon2-paper" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 2px;"></i>\
							  ';
							}
    						if((exp.status == 'image') || ((exp.status == 'Image')))
							{
							return '\
							  <i class="fa fa-file-image" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'popup'))
							{
							return '\
							  <i class="fas fa-external-link-alt" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'link'))
							{
							return '\
							  <i class="fa fa-link" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'bar'))
							{
							return '\
							  <i class="fa fa-bars" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'redirect'))
							{
							return '\
							  <i class="fa fa-mail-forward" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'block'))
							{
							return '\
							  <i class="fa fa-ban" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    						if((exp.status == 'style'))
							{
							return '\
							  <i class="fa fa-border-style" style="vertical-align: middle;font-size: 2.5rem!important;margin-left: 5px;"></i>\
							  ';
							}
    				},
    				}, {
    					field: 'experience',
    					title: 'Experience/Created By',
    					template: function(row) {
    						var exp_name = row.experience;
    						var create_name = row.name;
    						
    						return '\
   						 	 <span>\
							 <span style="font-weight: bold;">'+exp_name+'</span>\
							 <div style="margin-left: 30px;font-style: italic;font color: blue;color: darkturquoise;">'+create_name+'\
							 </div></span>\
   						  ';
    						 
    					}, 
    				}, {
    					field: 'pages',
    					title: 'Pages',
    					template:function(row)
    					{ 
    					
    		 				var exp_id = row.id;
    		 				var exp_name = row.experience;
    		 				var page_url = row.url;
    		 				var page_url_count = row.pages;
    		 				
    		 				var url_count = row.pages;
    		 				console.log("page URL="+page_url);
    						var r = "";
    						 
    						r+= '<a  href="javascript:void(0); class="page" ><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i  href="javascript:void(0); data-toggle="modal"  data-count="'+page_url_count+'" data-seg="'+page_url+'"  data-ids="'+exp_id+'" data-expname="'+exp_name+'"  class="fa fa-inverse fa-stack-1x" style="cursor: pointer;">'+url_count+'</i></span></a>'
    							return r;
    					}
    				},{
    					field: 'segment',
    					title: 'Segments',
    					template: function(row) {
    						var exp_id = row.id;
    						var pagetype ="";   
    						var exp_name = row.experience;
    						var exp_type = row.status;
    						var segArray = row.segments.split(",");
    						segArray = segArray.slice(0,segArray.lastIndexOf(","));
    					
    						
    						var s = "";
    						var seg	=	"";
    						for(var i=0;(i<segArray.length);++i)
    							{  
    							
    							var segname = segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length); 
    							s += '<div  class="hover"  >' + segname +'<i class="flaticon-eye" data-exptype="'+exp_type+'" data-expname="'+exp_name+'" data-toggle="modal"      title="Experience contents" data-segname="'+segArray[i].slice(segArray[i].indexOf(":")+1,segArray[i].length)+'"  data-expid="'+exp_id+'" id="' + segArray[i].slice(0,segArray[i].lastIndexOf(":")) + '" style="line-height: 0;vertical-align: middle;cursor: pointer;margin-left: 5px;"></i>'+",  " + '</div>';		  
    							
    							}
    						
    						return s.slice(0,s.lastIndexOf(",")) ;
    					
    					},
    				},   {
    					field: 'type',
    					title: 'Status',
    					template:function(row)
    					{
    						pagetype =row.status
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
    						else if ((row.type == 'scheduled') ) 
							{
							  return '\
							  <i class="flaticon-time" style="line-height: 0;vertical-align: middle;font-size: 2.5rem!important;margin-left: 10px;"></i>\
							  ';
							}
    						
    					
    					},
    					
    				
    				},/*{
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
    				},  {
    					field: 'name',
    					title: 'Created By',
    				},*/{
    					field: 'Actions',
    					title: 'Actions',
    					sortable: false,
    					width: 110,
    					overflow: 'visible',
    					autoHide: false,
    					template: function() {
    						return '\
    						<a <a href="/GeoReach?view=pages/experience-edit-'+pagetype+'.jsp&id='+experid+'" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="Edit details">\
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
