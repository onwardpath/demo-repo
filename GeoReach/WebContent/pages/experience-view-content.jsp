<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.onwardpath.georeach.util.Database"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Map,com.onwardpath.georeach.repository.*,com.onwardpath.georeach.model.*" %>
<!DOCTYPE html>


<html lang="en">

	<!-- begin::Head -->
	<head>

		
		<meta charset="utf-8" />
		<title>Keen | Local Data</title>
		<meta name="description" content="Initialized with local json data">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />

		<!--begin::Fonts -->
		<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.16/webfont.js"></script>
		<script>
			WebFont.load({
				google: {
					"families": ["Poppins:300,400,500,600,700"]
				},
				active: function() {
					sessionStorage.fonts = true;
				}
			});
		</script>

		<!--end::Fonts -->

		<!--begin:: Global Mandatory Vendors -->
		<link href="/GeoReach/assets/vendors/general/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<link href="/GeoReach/assets/vendors/general/tether/dist/css/tether.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-datetime-picker/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-timepicker/css/bootstrap-timepicker.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-select/dist/css/bootstrap-select.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/nouislider/distribute/nouislider.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/owl.carousel/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/owl.carousel/dist/assets/owl.theme.default.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/dropzone/dist/dropzone.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/summernote/dist/summernote.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/bootstrap-markdown/css/bootstrap-markdown.min.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/animate.css/animate.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/toastr/build/toastr.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/morris.js/morris.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/sweetalert2/dist/sweetalert2.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/socicon/css/socicon.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/custom/vendors/line-awesome/css/line-awesome.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/custom/vendors/flaticon/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/custom/vendors/flaticon2/flaticon.css" rel="stylesheet" type="text/css" />
		<link href="/GeoReach/assets/vendors/general/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Styles(used by all pages) -->
		

		<!--end::Global Theme Styles -->

		

		<!--end::Layout Skins -->
		<link rel="shortcut icon" href="/GeoReach/assets/media/logos/favicon.ico" />
	</head>

<!-- begin:: Content -->

		<div class="kt-portlet kt-portlet--mobile"><!-- begin::portlet -->
		
			
			
			<!-- end::portlet-body -->
			
			

	

		<!-- begin:: Root -->
		<div class="kt-grid kt-grid--hor kt-grid--root">

			<!-- begin:: Page -->
			

				<!-- begin:: Aside -->
				<button class="kt-aside-close " id="kt_aside_close_btn"><i class="la la-close"></i></button>
				

				<!-- end:: Aside -->

				<!-- begin:: Wrapper -->
				

					<!-- begin:: Header -->
				

					<!-- end:: Header -->
					<div class="kt-grid__item kt-grid__item--fluid kt-grid kt-grid--hor">

						<!-- begin:: Subheader -->
						

						<!-- end:: Subheader -->

						<!-- begin:: Content -->
						<div class="kt-content  kt-grid__item kt-grid__item--fluid" id="kt_content">
							
							<div class="kt-portlet kt-portlet--mobile">
								
								<div class="kt-portlet__body">

									<!--begin: Search Form -->
									<div class="kt-form kt-fork--label-right kt-margin-t-20 kt-margin-b-10">
										<div class="row align-items-center">
											<div class="col-xl-8 order-2 order-xl-1">
												<div class="row align-items-center">
													<div class="col-md-4 kt-margin-b-20-tablet-and-mobile">
														<div class="kt-input-icon kt-input-icon--left">
															<input type="text" class="form-control" placeholder="Search..." id="generalSearch">
															<span class="kt-input-icon__icon kt-input-icon__icon--left">
																<span><i class="la la-search"></i></span>
															</span>
														</div>
													</div>
													
												</div>
											</div>
											<div class="col-xl-4 order-1 order-xl-2 kt-align-right">
												<a href="#" class="btn btn-default kt-hidden">
													<i class="la la-cart-plus"></i> New Order
												</a>
												<div class="kt-separator kt-separator--border-dashed kt-separator--space-lg d-xl-none"></div>
											</div>
										</div>
									</div>

									<!--end: Search Form -->
								</div>
							
						<!-- modal popup  -->
						
						  <div class="modal" id="myModal" role="document">
						    <div class="modal-dialog ">
						      <div class="modal-content">
						      
						        <!-- Modal Header -->
						        <div  class="modal-header">
						          <h4 id="segment-element" class="modal-title">Modal Heading</h4>
						          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">×</span>
								  </button>
						        </div>
						        
						        <!-- Modal body -->
						        <div id="popover-element" class="modal-body">
						          Modal body..
						        </div>
						        
						        <!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="button" class="btn btn-outline-brand" data-dismiss="modal">Close</button>
						        </div>
						        
						      </div>
						    </div>
						  </div>
								
								
								
								<div class="kt-portlet__body kt-portlet__body--fit">

									<!--begin: Datatable -->
									<div class="kt_datatable" id="local_data"></div>
									
			

									<!--end: Datatable -->
								</div>
							</div>
						</div>

						<!-- end:: Content -->
					</div>

					<!-- begin:: Footer -->
				

					<!-- end:: Footer -->
				

				<!-- end:: Wrapper -->
			

			<!-- end:: Page -->
		</div>

		<!-- end:: Root -->


		<!-- begin::Demo Panel -->
		

		<!-- end::Demo Panel -->

		<!-- begin::Global Config(global config for global JS sciprts) -->
		<script>
			var KTAppOptions = {
				"colors": {
					"state": {
						"brand": "#5d78ff",
						"metal": "#c4c5d6",
						"light": "#ffffff",
						"accent": "#00c5dc",
						"primary": "#5867dd",
						"success": "#34bfa3",
						"info": "#36a3f7",
						"warning": "#ffb822",
						"danger": "#fd3995",
						"focus": "#9816f4"
					},
					"base": {
						"label": [
							"#c5cbe3",
							"#a1a8c3",
							"#3d4465",
							"#3e4466"
						],
						"shape": [
							"#f0f3ff",
							"#d9dffa",
							"#afb4d4",
							"#646c9a"
						]
					}
				}
			};
		</script>

		<!-- end::Global Config -->

		<!--begin:: Global Mandatory Vendors -->
		<script src="/GeoReach/assets/vendors/general/jquery/dist/jquery.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/popper.js/dist/umd/popper.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/js-cookie/src/js.cookie.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/moment/min/moment.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/tooltip.js/dist/umd/tooltip.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/perfect-scrollbar/dist/perfect-scrollbar.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/sticky-js/dist/sticky.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/wnumb/wNumb.js" type="text/javascript"></script>

		<!--end:: Global Mandatory Vendors -->

		<!--begin:: Global Optional Vendors -->
		<script src="/GeoReach/assets/vendors/general/jquery-form/dist/jquery.form.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/block-ui/jquery.blockUI.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/js/vendors/bootstrap-datepicker.init.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-datetime-picker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/js/vendors/bootstrap-timepicker.init.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-maxlength/src/bootstrap-maxlength.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/vendors/bootstrap-multiselectsplitter/bootstrap-multiselectsplitter.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-select/dist/js/bootstrap-select.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/typeahead.js/dist/typeahead.bundle.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/handlebars/dist/handlebars.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/inputmask/dist/jquery.inputmask.bundle.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/inputmask/dist/inputmask/inputmask.date.extensions.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/inputmask/dist/inputmask/inputmask.numeric.extensions.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/nouislider/distribute/nouislider.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/owl.carousel/dist/owl.carousel.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/autosize/dist/autosize.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/clipboard/dist/clipboard.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/dropzone/dist/dropzone.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/summernote/dist/summernote.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/markdown/lib/markdown.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/bootstrap-markdown/js/bootstrap-markdown.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/js/vendors/bootstrap-markdown.init.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/jquery-validation/dist/jquery.validate.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/jquery-validation/dist/additional-methods.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/js/vendors/jquery-validation.init.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/toastr/build/toastr.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/raphael/raphael.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/morris.js/morris.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/chart.js/dist/Chart.bundle.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/vendors/bootstrap-session-timeout/dist/bootstrap-session-timeout.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/vendors/jquery-idletimer/idle-timer.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/waypoints/lib/jquery.waypoints.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/counterup/jquery.counterup.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/es6-promise-polyfill/promise.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/sweetalert2/dist/sweetalert2.min.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/custom/js/vendors/sweetalert2.init.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/jquery.repeater/src/lib.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/jquery.repeater/src/jquery.input.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/jquery.repeater/src/repeater.js" type="text/javascript"></script>
		<script src="/GeoReach/assets/vendors/general/dompurify/dist/purify.js" type="text/javascript"></script>

		<!--end:: Global Optional Vendors -->

		<!--begin::Global Theme Bundle(used by all pages) -->
		<script src="/GeoReach/assets/js/demo1/scripts.bundle.js" type="text/javascript"></script>
		<!-- <script src="/GeoReach/assets/plugins/global/plugins.bundle.js" type="text/javascript"></script> -->

		<!--end::Global Theme Bundle -->

		<!--begin::Page Scripts(used by this page) -->
				<script src="/GeoReach/assets/js/demo1/pages/components/base/popovers.js" type="text/javascript"></script>
		<!-- <script src="/GeoReach/assets/js/demo1/pages/crud/keen-datatable/base/data-local.js" type="text/javascript"></script>
		 -->
		<script src="/GeoReach/assets/js/demo1/pages/crud/keen-datatable/base/data-local.js" type="text/javascript"></script>
       
  
		<!--end::Page Scripts -->
		
		<div id ="page">
		
		</div>
	</body>
			
			
		</div>
						

<!-- end:: Content -->	