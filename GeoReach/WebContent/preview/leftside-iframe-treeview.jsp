<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String html = (String) session.getAttribute("content");
    String tree_data = (String) session.getAttribute("tree_data");
%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="/GeoReach/test/jqtree.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="/GeoReach/test/tree.jquery.js"></script>
	<script type="text/template" id="tree_data">	
   <%=tree_data%>
	</script>
</head>
<script>
	var data = tree_data.innerText.replace(/\\/g, '');
	console.log(data);
	$(function() {
		$('#tree1').tree({
			data : JSON.parse(data),
			saveState : true,
			selectable: true,
			autoOpen : true,
			onDragMove : handleMove,
			onCreateLi : function(node, $li, is_selected) {
				// Add 'icon' span before title
				//  debugger;
				//  $li.find('.jqtree-title').before('<span class="icon"></span>');
				if (!(node.parent.name == "")) {
					c = $li.find('.jqtree-title');
					c[0].draggable = "true";
					c[0].setAttribute("ondragstart","onDragStart(event);");
					
				}
			}

		});
		
		function handleMove(node, e) {
			console.log("DFG");
		}

		console.log($('#tree1').tree('getSelectedNode'));
	});
</script>
 <script>
         function toggleevent(evt)
         {
         var allnodes_true = document.querySelectorAll('[contenteditable=true]');
         var allnodes_false = document.querySelectorAll('[contenteditable=false]');
         
         var nodes = "";
         var is_edit = ""; 
         
         	if(allnodes_true.length > 0)
         	{
         	nodes = allnodes_true;
         	is_edit = true;
         	evt.target.textContent = "Enable ContentEditable";
         	}
         	else if(allnodes_false.length > 0)
         	{
         	nodes = allnodes_false;
         	is_edit = false;
         	evt.target.textContent = "Disable ContentEditable";
         	}
         
         
         for(i=0;i<nodes.length;i++)
         {
         	if(is_edit)
         	{
         		nodes[i].contentEditable = "false";
         		
         	}
         	else
         	{
         	    nodes[i].contentEditable = "true";
         	}
         
         }
         }
         	
        
         function onDrop(event) {
             event
             .dataTransfer
             .clearData();
           
         }
         
         function onDragStart(event) {
         
        // let v = '<img alt="Element getting dragged with no dropzone" data-original="https://d33wubrfki0l68.cloudfront.net/6c8a12cc7be91b8682bbfa4c0bbbdfc3161cf7d6/e3d26/images/js/drag-and-drop-vanilla-js/dragnodrop.gif" class="loaded" src="https://d33wubrfki0l68.cloudfront.net/6c8a12cc7be91b8682bbfa4c0bbbdfc3161cf7d6/e3d26/images/js/drag-and-drop-vanilla-js/dragnodrop.gif">';
        let v = '<div id="xy4kyueFt0aa7c7sdi3Fyw" class="a-cardui fluid-fat-image-link fluid-card fluid-fat-image-link" data-a-card-type="basic"><div class="a-cardui-header"><h2 class="a-color-base headline truncate-2line">Explore mirrorless cameras</h2></div><div class="a-cardui-body"><a class="a-link-normal center-image aok-block image-window" href="/b?node=17432892031&amp;pf_rd_p=38f8e32d-26d5-4c1f-a28d-2c6f1ceef3f3&amp;pf_rd_r=QH9GZGS9GG41MQ91RZKS"><div class="a-section a-spacing-none fluid-image-container"><img alt="Mirrorless cameras" src="https://images-eu.ssl-images-amazon.com/images/G/31/img19/Cameras/Gateway/Sony_Cat_Card_1x._SY304_CB448539687_.jpg" class="landscape-image" data-a-hires="https://images-eu.ssl-images-amazon.com/images/G/31/img19/Cameras/Gateway/Sony_Cat_Card_2X._SY608_CB448539687_.jpg"></div></a></div><div class="a-cardui-footer"><a class="a-link-normal see-more truncate-1line" href="/b?node=1388977031&amp;pf_rd_p=38f8e32d-26d5-4c1f-a28d-2c6f1ceef3f3&amp;pf_rd_r=QH9GZGS9GG41MQ91RZKS">See more</a></div></div>';
         
         var newdiv_elem = document.createElement("DIV");
         newdiv_elem.innerHTML = v;
         newdiv_elem.className = "test";
         newdiv_elem.id = "test";
         	
           event
             .dataTransfer
             .setData('text/html', newdiv_elem.outerHTML);
         
           //event.currentTarget.style.backgroundColor = 'yellow';
          
         
         
         }
         function onDragOver(event) {
         	  var get = event.dataTransfer.getData('text/html');
              
         	  event.preventDefault();
         }
       //  document.addEventListener('DOMContentLoaded', (event) => {
        	// var iframe = document.getElementById('ifrm');
        //	 var content = document.getElementById("iframeContent").innerHTML;
        	
        	
        //	 var frameDoc = iframe.document;
        //	 if (iframe.contentWindow)
        //			frameDoc = iframe.contentWindow.document;
        //     	frameDoc.open();
        //		frameDoc.writeln(content);
        //	    frameDoc.close();
        //		document.getElementById("iframeContent").remove();
     	//});
               
      </script>
 

<body>
	<div class="row">
		 <div class="col-xs-11">
         <button type="button" name="toggleContentEditable" onclick="toggleevent(event)">Disable Contenteditable</button>
    		Experiences Root
		<div id="tree1" style="all:initial;"></div>
	<script src="/GeoReach/test/tree.jquery.js"></script>
</body>
</html>
