var expDetailsObj = {};
var cfgDetailsObj = {};
var index = 0;
var segment = null;	
var segment_id = null;	
var segment_name = null;
var content = null;
var url_id = null;
let segName =null;

function selectIndex()
{
	var realVal = document.getElementById("realValue"); 
    if (realVal.value=="Update")
        realVal.value = "Add";
        realVal.innerHTML = "Add";  
	segment = document.getElementById("segment");
	segment_id = segment.value;	
	segment_name = segment.options[segment.selectedIndex].innerHTML;
	content = document.getElementById("content").value;	
	
}
function add(event){	
       selectIndex();       
	   if (segment_id in expDetailsObj) {
		   if (content.length > 0){
		   	expDetailsObj[segment_id] = content;
		   }else{
			   alert("Please enter any content")
		   }
		} else {
			
			if(content.length > 0)
			{		
				expDetailsObj[segment_id] = content;				
				var stage = document.getElementById("stages");
				stage.innerHTML += '<div id="'+segment_name+'" class="card-body">Edit Data&nbsp;'+
					'<button type="button" class="btn btn-outline-info btn-pill" onclick="edit( \''+segment_id+')" > '+
					'<i class="kt-menu__link-icon la flaticon2-edit"><span></span></i> </button> &nbsp;'+
					'<button type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''+segment_name+'\','+segment_id+')">'+segment_name+'<i class="la la-close"></i>'+
					'</button></div>';
					stage.style.display = "block";
			}
			else{
				alert("Please enter any content");
			}
		}  
}  

function addEx(){
	
	var realVal = document.getElementById("urladdname"); 
    if (realVal.value=="Update")
        realVal.value = "Add";
        realVal.innerHTML = "Add";  	 
	var pageurl = document.getElementById("url").value;
	
	if (url_id in cfgDetailsObj) {
		if (pageurl.length > 0){
		
		cfgDetailsObj[url_id] = pageurl;
		var closeButton = '<i class="la la-close"></i>'
		document.getElementById("button_remove_"+url_id).innerHTML=(pageurl + closeButton);
		//document.getElementById("button_remove_"+url_id).value=pageurl+closeButton;
		url_id=null;
		}else{
			alert("Please enter an URL")
		}
		
	} else {
		if (pageurl.length > 0){
			url_id=index+'_new';
			cfgDetailsObj[url_id] = pageurl;
			var stage = document.getElementById("sta");
			stage.innerHTML += '<div id="'+url_id+'" class="card-body">Edit Data&nbsp;'+
			'<button type="button" class="btn btn-outline-info btn-pill" onclick="editurl(\''+url_id+'\')"> '+
			'<i class="kt-menu__link-icon la flaticon2-edit"><span></span></i> </button> &nbsp;'+
			'<button id="button_remove_'+url_id +'" type="button" class="btn btn-outline-info btn-pill" onclick="removeurl(\''+url_id+'\')">'+pageurl+'<i class="la la-close"></i>'+
			'</button></div>';
			
			stage.style.display = "block";
			index++;	
		}else{
			alert("Please enter an URL")
		}
	}	    
}  

function remove(element, segment_id){		
	var displayElement = document.getElementById(element);	
	delete expDetailsObj[segment_id];	
	displayElement.style.display = "none";		
}
function removeurl(id){
	console.log(id)
	var displayElement = document.getElementById(id);	
	delete cfgDetailsObj[id];	
	displayElement.style.display = "none";		
}

function edit(segment_id){
	document.getElementById("segment").value=segment_id;
	document.getElementById("content").value= expDetailsObj[segment_id];	 	
	var realVal = document.getElementById("realValue"); 
    if (realVal.value=="Add")
        realVal.value = "Update";
        realVal.innerHTML = "Update";          
}    
   
function editurl(urlid){
	url_id = urlid;	
	document.getElementById("url").value=cfgDetailsObj[urlid];
	var realVals = document.getElementById("urladdname"); 
	if (realVals.value=="Add")
        realVals.value = "Update";
        realVals.innerHTML = "Update";	
}  
function cancelOperation() {	
	location.replace("/GeoReach?view=pages/experience-view-content.jsp")
   
} 
function saveExperience(){
	var finalexp_name =  document.getElementById("nameExp").value;
	if (finalexp_name){
		document.getElementById("form-expname").value=finalexp_name;
	
		if (JSON.stringify(expDetailsObj)!=='{}'){
			
			document.getElementById("form-contentdetails").value=JSON.stringify(expDetailsObj);	
			document.getElementById("form-urldetails").value=JSON.stringify(cfgDetailsObj); 
			//alert("1"+JSON.stringify(expDetailsObj))     
			//alert("2"+JSON.stringify(cfgDetailsObj)) 
			document.getElementById("experience-form").method = "post";
			document.getElementById("experience-form").action = "ExperienceController";
			document.getElementById("experience-form").submit();   
		}else{
			alert("Please enter atleast one content for this Experience")
		}
	}else{
		alert("Please enter a value for  Experience Name")
	}
	 	
}