<!-- Owner:Gurujegan --Implementing this page for Popup functionality-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.Map, com.onwardpath.georeach.repository.SegmentRepository"%>
<script type="text/javascript">
	var expDetailsObj = {};
	var segment = null;
	var segment_id = null;
	var segment_name = null;
	var content = null;

	function selectIndex() {
		segment = document.getElementById("segment");
		segment_id = segment.value;
		segment_name = segment.options[segment.selectedIndex].innerHTML;
		content = document.getElementById("content").value;

	}
	function add(event) {
		selectIndex();
		if (segment_id in expDetailsObj) {
			alert("Segment " + segment_name
					+ " already added. Select a different segment.");
		} else {
			if (content.length > 0) {
				expDetailsObj[segment_id] = content;
				var stage = document.getElementById("stage");
				stage.innerHTML += '<div id="'+segment_name+'" class="card-body">'
						+ content
						+ '&nbsp;<button type="button" class="btn btn-outline-info btn-pill" onclick="remove(\''
						+ segment_name
						+ '\','
						+ segment_id
						+ ')">'
						+ segment_name
						+ '<i class="la la-close"></i></button></div>';
				stage.style.display = "block";
			} else
				alert("Please enter any content");
		}

	}
	function remove(element, segment_id) {
		var displayElement = document.getElementById(element);
		delete expDetailsObj[segment_id];
		displayElement.style.display = "none";
	}
	function saveExperience() {
		var name = document.getElementById('name').value;
		var type = "content";
		document.getElementById("experience-form").type.value = type;
		document.getElementById("experience-form").experienceDetails.value = JSON
				.stringify(expDetailsObj);
		document.getElementById("experience-form").method = "post";
		document.getElementById("experience-form").action = "ExperienceController";
		document.getElementById("experience-form").submit();

	}
	function showChild(event) {
		var el = document.getElementById(event.target.id);
		var opt_val = el.options[el.selectedIndex].value;
		var opt_text = el.options[el.selectedIndex].text;

		var el_htm = document.getElementById("for-html");
		var el_ifr = document.getElementById("for-iframe");

		if (opt_val === "html") {
			el_htm.style.display = "flex";
			el_ifr.style.display = "none";
		} else {
			el_htm.style.display = "none";
			el_ifr.style.display = "flex";
		}
	}
	
	function changeIcon(event)
	{
		var icon_el = event.target.children[0];
		icon_el.setAttribute("class","flaticon-folder-1");
				
	}

	window.addEventListener("load", function() {
		selectIndex();

	});
</script>

<!--begin::Content-->
<div class="kt-content  kt-grid__item kt-grid__item--fluid"
	id="kt_content">
	<%
		String message = (String) session.getAttribute("message");

		SegmentRepository segmentRepository = new SegmentRepository();
		int org_id = (Integer) session.getAttribute("org_id");
		Map<Integer, String> segments = segmentRepository.getOrgSegments(org_id);
		if (segments.size() == 0) {
			message = "Error: No Segments are configured. Create a Segment <a class='kt-link kt-font-bold' href='?view=pages/segment-create-geo.jsp'>here</a>";
		}

		if (message != null && !message.equals("")) {
			String icon = "fa fa-cocktail";
			if (message.startsWith("Error"))
				icon = "flaticon-warning";

			String name = "";
			String experience = "";
			String organization = "";
			if (message.contains("#")) {
				String codeConstructor = message.substring(message.indexOf("#") + 1);
				message = message.substring(0, message.indexOf("#"));
				String[] decoder = codeConstructor.split("#");
				name = decoder[0].substring(decoder[0].indexOf("=") + 1);
				experience = decoder[1].substring(decoder[0].indexOf("=") + 1);
				organization = decoder[2].substring(decoder[0].indexOf("=") + 1);
			}
	%>
	<div class="row">
		<div class="col">
			<div class="alert alert-light alert-elevate fade show" role="alert">
				<div class="alert-icon">
					<i class="<%=icon%> kt-font-brand"></i>
				</div>
				<div class="alert-text">
					<%=message%>
					<!-- Button trigger modal -->
					<!-- button type="button" class="btn btn-outline-brand" data-toggle="modal" data-target="#exampleModalCenter">
							View Code
						</button -->
				</div>
			</div>
		</div>
	</div>

	<!-- begin::modal -->
	<div class="kt-section__content kt-section__content--border">
		<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalCenterTitle">
							Embed Code for:
							<%=name%></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">
						<h3>Header</h3>
						<code>
							&lt;!-- Begin::GeoSmart-Header --&gt; &lt;script&gt; function
							geo() { var serviceURL=
							"http://lab01.onwardpath.com/GeoTargetService/app/georeach/get?id=<%=experience%>&org_id=<%=org_id%>&s=";
							var geoElement = document.getElementById("Geo-<%=name%>-<%=experience%>");
							var url = new URL(window.location.href); var c =
							url.searchParams.get("s"); serviceURL += c;
							console.log(serviceURL); var xhttp = new XMLHttpRequest();
							xhttp.responseType = 'json'; xhttp.onreadystatechange =
							function() { if (this.readyState == 4 && this.status == 200) {
							let data = this.response; geoElement.innerHTML =
							data[1].embedCode; } }; xhttp.open("GET", serviceURL);
							xhttp.send(); } window.onload = geo; &lt;/script&gt; &lt;!--
							End::GeoSmart-Header --&gt;
						</code>
						<h3>Body</h3>
						<code>
							&lt;!-- Begin::GeoSmart-Body --&gt; &lt;div id="G-<%=name%>-<%=experience%>"&gt;&lt;/div&gt;
							&lt;!-- End::GeoSmart-Body --&gt;
						</code>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-brand">Copy</button>
						<button type="button" class="btn btn-outline-brand"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end::modal -->
	<%
		session.setAttribute("message", "");
		}
	%>
	<!--begin::Portlet-->
	<div class="kt-portlet">
		<div class="kt-portlet__head">
			<div class="kt-portlet__head-label">
				<h3 class="kt-portlet__head-title">Create Popup Experience</h3>
			</div>
		</div>
		<!--begin::Accordion-->
		<div class="accordion accordion-outline" id="accordionExample3">
			<div class="card">
				<div class="card-header" id="headingOne3">
				
					<div class="card-title" data-toggle="collapse"
						data-target="#basic" aria-expanded="true"
						aria-controls="collapseOne3">Basic Settings</div>
				</div>
				<div id="basic" class="card-body-wrapper collapse show" aria-labelledby="headingOne3"
					data-parent="#accordionExample3" style="">
					<div class="card-body">
					<!--begin::Form-->
					<form class="kt-form kt-form--label-right" id="dummy-form">
						<div class="kt-portlet__body">

							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12">Segment</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<select id="segment" class="custom-select form-control"
										data-width="300" onchange="javascript:selectIndex()">
										<%
											for (Map.Entry<Integer, String> entry : segments.entrySet()) {
												Integer key = entry.getKey();
												String val = entry.getValue();
												out.println("<option value='" + key + "'>" + val + "</option>");
											}
										%>
									</select>
								</div>
							</div>

							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12">Popup
									Type</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<select id="popup" class="custom-select form-control"
										data-width="300" onchange="showChild(event)">
										<option value="html">HTML Code</option>
										<option value="iframe">Iframe</option>
									</select>
								</div>
							</div>

							<div class="form-group row" id="for-html">
								<label class="col-form-label col-lg-3 col-sm-12">Content
									(Text/HTML)</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<textarea id="content" type="text"
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" placeholder="Enter Text"
										rows="10" cols="10"></textarea>
								</div>
							</div>

							<div class="form-group row" id="for-iframe"
								style="display: none;">
								<label class="col-form-label col-lg-3 col-sm-12">External
									URL</label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<input id="iframe-url" type="text"
										class="form-control col-lg-9 col-sm-12"
										aria-describedby="emailHelp" data-toggle="tooltip"
										data-original-title="Tooltip on bottom"
										placeholder="Enter or Paste URL">
								</div>
							</div>

							<div class="form-group row">
								<label class="col-form-label col-lg-3 col-sm-12"></label>
								<div class="col-lg-4 col-md-9 col-sm-12">
									<button type="reset" class="btn btn-accent"
										onclick="javascript:add(event)">Add</button>
								</div>
							</div>

							<div class="kt-separator kt-separator--border-dashed"></div>
							<div class="kt-separator kt-separator--height-sm"></div>

							<div class="kt-section__content kt-section__content--border">
								<div id="stage" style="display: none;"></div>
							</div>

						</div>
					</form>
					<!--end::Form-->
					</div>
				</div>
			</div>
			<div class="card">
				<div class="card-header" id="headingThree3">
					<div class="card-title collapsed" data-toggle="collapse"
						data-target="#collapseThree3" aria-expanded="false"
						aria-controls="collapseThree3">Advanced Settings</div>
				</div>
				<div id="collapseThree3" class="card-body-wrapper collapse"
					aria-labelledby="headingThree3" data-parent="#accordionExample3"
					style="">
					<div class="card-body">Anim pariatur cliche reprehenderit,
						enim eiusmod high life accusamus terry richardson ad squid. 3 wolf
						moon officia aute, non cupidatat skateboard dolor brunch. Food
						truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
						sunt aliqua put a bird on it squid single-origin coffee nulla
						assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer
						labore wes anderson cred nesciunt sapiente ea proident. Ad vegan
						excepteur butcher vice lomo. Leggings occaecat craft beer
						farm-to-table, raw denim aesthetic synth nesciunt you probably
						haven't heard of them accusamus labore sustainable VHS.</div>
				</div>
			</div>
		</div>
		<!--end::Accordion-->



		<!--begin::Form-->
		<form class="kt-form kt-form--label-right" id="experience-form">
			<div class="kt-portlet__body">

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12">Experience
						Name</label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<input name="name" id="name" type="text" class="form-control"
							aria-describedby="emailHelp" placeholder="Name"> <span
							class="form-text text-muted">Give a name for this
							experience</span>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-form-label col-lg-3 col-sm-12"></label>
					<div class="col-lg-4 col-md-9 col-sm-12">
						<div id="hidden-form" style="display: none;">
							<input type="hidden" name="pageName" value="create-experience">
							<input type="hidden" name="type"> <input type="hidden"
								name="experienceDetails"> <input type="hidden"
								name="segment_id"> <input type="hidden" name="url">
						</div>
						<button type="reset" class="btn btn-primary"
							onclick="saveExperience();">Save</button>
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