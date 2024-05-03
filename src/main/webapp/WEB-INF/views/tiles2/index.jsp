<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>누네띠네</title>
<!-- plugins:css -->
<link rel="stylesheet" href="/resources/skydash/vendors/feather/feather.css">
<link rel="stylesheet" href="/resources/skydash/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" href="/resources/skydash/vendors/css/vendor.bundle.base.css">
<!-- endinject -->
<!-- Plugin css for this page -->
<link rel="stylesheet" href="/resources/skydash/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
<link rel="stylesheet" href="/resources/skydash/vendors/ti-icons/css/themify-icons.css">
<link rel="stylesheet" type="text/css" href="/resources/skydash/js/select.dataTables.min.css">
<!-- End plugin css for this page -->
<!-- inject:css -->
<link rel="stylesheet" href="/resources/skydash/css/vertical-layout-light/style.css">
<!-- endinject -->
<link rel="shortcut icon" href="/resources/images/누네띠네.png" />
<!-- <script src="/resources/chat/chat.js"></script> -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="/resources/chat/chat.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/chat/chat.css">

<

</head>

<body>
	<div class="container-scroller">
<!-- Navbar /////////////////////////////////////// header 시작 /////////////////////////////////////// -->
<tiles:insertAttribute name="header" />
<!-- /navbar /////////////////////////////////////// header 끝 /////////////////////////////////////// -->

<!--  -->
<!--  -->

<%-- <jsp:include page="../chat/chat/chat.jsp">
	<jsp:param value="${roomNo}" name="roomNo"/>
</jsp:include> --%>


<%-- <jsp:include page="../chat/chat/chat.jsp"> --%>
<%-- 	<jsp:param value="${roomNo}" name="roomNo"/> --%>
<%-- </jsp:include> --%>

		<div class="container-fluid page-body-wrapper" style="
    padding-top: 0px;">
<!-- partial:partials/_settings-panel.html -->
<!-- 			<div class="theme-setting-wrapper"> -->
<!-- 				<div id="settings-trigger"> -->
<!-- 					<i class="ti-settings"></i> -->
<!-- 				</div> -->
<!-- 				<div id="theme-settings" class="settings-panel" style="max-height: 500px; overflow-x: auto; overflow-y: auto;"> -->
<%-- 					<tiles:insertAttribute name="sidebar" /> --%>
					<!-- /chat/join2?roomNo=173 -->
<%-- 					<jsp:include page="../tiles/sidebar.jsp"> --%>
<%-- 						<jsp:param value="${roomNo}" name="roomNo"/> --%>
<%-- 					</jsp:include> --%>
<!-- 					<div id="theme-settings-sub"> style="max-height: 700px; overflow-x: auto; overflow-y: auto;" -->
					
<!-- 					<div class="container"> -->
<!-- 						<div class="col-6"> -->
<!-- 								<div id="msgArea" class="col"></div> -->
<!-- 									<div class="col-6"> -->
<!-- 										<div class="input-group mb-3"> -->
<!-- 										<input type="text" id="msg" class="form-control"> -->
<!-- 										</div> -->
<!-- 										<button class="btn btn-outline-secondary" type="submit" id="button-send">전송</button> -->
<!-- 									</div> -->
<!-- 							</div> -->
<!-- 					</div> -->
<!-- 						</div> -->
<!-- 							<i class="settings-close ti-close"></i> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- /////////////////////////////////////// 모달끝 /////////////////////////////////////// -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 				</div> -->
<!-- 			</div> -->

			<!-- ///// aside 시작 //////// -->
			<tiles:insertAttribute name="aside" />
			<!-- ///// aside 시작 //////// -->

			<div class="main-panel" >
				<!-- ///// body 시작 //////// -->
				<div class="content-wrapper" >
					<br>
					<tiles:insertAttribute name="body" />
				</div>
<!-- /////////////////////////////////////// body끝 /////////////////////////////////////// -->

<!-- /////////////////////////////////////// footer시작 /////////////////////////////////////// -->
				<tiles:insertAttribute name="footer" />
<!-- /////////////////////////////////////// footer끝 /////////////////////////////////////// -->
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->

	<!-- plugins:js -->
	<script src="/resources/skydash/vendors/js/vendor.bundle.base.js"></script>
	<!-- endinject -->
	<!-- Plugin js for this page -->
	<script src="/resources/skydash/vendors/chart.js/Chart.min.js"></script>
	<script
		src="/resources/skydash/vendors/datatables.net/jquery.dataTables.js"></script>
	<script
		src="/resources/skydash/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
	<script src="/resources/skydash/js/dataTables.select.min.js"></script>

	<!-- End plugin js for this page -->
	<!-- inject:js -->
	<script src="/resources/skydash/js/off-canvas.js"></script>
	<script src="/resources/skydash/js/hoverable-collapse.js"></script>
	<script src="/resources/skydash/js/template.js"></script>
	<script src="/resources/skydash/js/settings.js"></script>
	<!-- endinject -->
	<!-- Custom js for this page-->
	<script src="/resources/skydash/js/dashboard.js"></script>
	<script src="/resources/skydash/js/file-upload.js"></script>
	
	<!--  -->

	<!-- <script src="/resources/chat/chatFFF/bundle.js"></script>
	<script src="/resources/chat/chatFFF/app.js"></script>
||||||| .r401071
=======
<!-- 	<script src="/resources/chat/chatFFF/bundle.js"></script> -->
<!-- 	<script src="/resources/chat/chatFFF/app.js"></script> -->

	

	<!-- End custom js for this page-->
</body>

</html>

