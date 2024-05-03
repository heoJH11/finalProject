<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
 body { background-color: #f5f7ff; }
 
 @font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
 
.reDeProfile{
	width: 34px;
	height: 34px;
	border-radius: 17px;
	margin-right:8px;
}
.starRx{
	display: inline-block;
	width: 30px;
	height: 30px;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
	font-size: 1.8em;
	box-sizing: border-box;
	cursor: pointer;
}
.starRok{
	display: inline-block;
	width: 30px;
	height: 30px;
	color: transparent;
	text-shadow: 0 0 0 #4B49AC;
	font-size: 1.8em;
	box-sizing: border-box;
	cursor: pointer;
}
.starRxTit{
	display: inline-block;
	width: 15px;
	height: 15px;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
	font-size: 1.1em;
	box-sizing: border-box;
	cursor: pointer;
}
.starRokTit{
	display: inline-block;
	width: 15px;
	height: 15px;
	color: transparent;
	text-shadow: 0 0 0 #4B49AC;
	font-size: 1.1em;
	box-sizing: border-box;
	cursor: pointer;
}
.modalThumb{
	width: 150px;
	height: 150px;
}
.innerDiv {
	height: auto;
/* 	text-align: center; */
}
.centerDiv{
	height: auto;
 	text-align: center;
}
.hrDiv {
	height: 30px;
	text-align: center;
}
tr{
	font-family: 'GmarketSansMedium';
	width:auto;
	height: auto;
}

td,h3,h2,h1,h4,p{
	 font-family: 'GmarketSansMedium';
}

button{
	font-family: 'GmarketSansMedium';
	margin-right:10px;
}
.photoFile{
	width: 200px;
	height: 200px;
}
.profile{
	width: 40px;
	height: 40px;
	border-radius: 20px;
}
</style>
<script>
// function reDeFunc(ondyclNo){
// 	// console.log("여기요 제발");
// 	$("#reviewDetailModal").modal();
// 	$.ajax({
// 		url : "/onedayClass/reviewList?ondyclNo="+ondyclNo,
// 		success : function(res){
// 			let str = "";
// 			let headStr = "<h3 class='modal-title'>리뷰 자세히보기</h3>";
// 			headStr += "<button type='button' class='close' data-dismiss='modal' style='float:right;'>×</button>";
// 			$("#reDeTbody").html("");
// 			$("#reModalHead").html(headStr);
// 			// console.log("모달쪽 성공",res);
// 			$.each(res, function (idx, reviewMberVO) {
// 				str += `<div class="starRev">`;
// 				console.log("foreach res",res);
// 				if(reviewMberVO.mberProflPhoto == null || reviewMberVO.mberProflPhoto == ''){
// 					str += "<img class='reDeProfile' src='/images/2024/profile.jpg'>"+reviewMberVO.mberNcnm + "<br>";
// 				}else{
// 					str += "<img class='reDeProfile' src='"+reviewMberVO.mberProflPhoto+"'>"+reviewMberVO.mberNcnm + "<br>";
// 				}
// 				str += starColor(reviewMberVO.ondyclReScore);
// 				str += "<textarea rows='5' readonly class='form-control' style='margin-top:10px;'>"+reviewMberVO.ondyclReCn+"</textarea>";
// 			});
// 			$("#reDeTbody").append(str);
// 		}
// 	});
// }
function starColor(num){
	let str = "";
	console.log("별점"+num);
	for(let i=1; i<=num; i++){
		str += `<span class="starRok">⭐</span>`;
	}
	for(let j=1;j<=5-num;j++){
		str += `<span class="starRx">⭐</span>`;
	}
	return str;
}
function starTitColor(num){
	let str = "";
	console.log("별점"+num);
	for(let i=1; i<=num; i++){
		str += `<span class="starRokTit">⭐</span>`;
	}
	for(let j=1;j<=5-num;j++){
		str += `<span class="starRxTit">⭐</span>`;
	}
	return str;
}
$(function(){
	if(${vOndyclProUsersVO.dayCheck}){
		// console.log("과연" + ${vOndyclProUsersVO.dayCheck});
		//끝난 클래스들 리뷰 리스트 출력
		let ondyclNo = $("#classNo").val();
		// console.log("여기??" + ondyclNo);
		$.ajax({
			url : "/onedayClass/reviewList?ondyclNo="+ondyclNo,
			success : function(res){
				let str = "";
				console.log("res:",res);
				$("#reviewTbody").html("");

				if(res.length == 0){
					str += `				<tr>
					<td colspan="4" style="text-align: center;">
						<img src="../resources/images/우는모양.png" style="width: 60px; height: 60px; margin: 20px 0;" />
						<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">아직 리뷰가 없어요!</h3>
					</td>
				</tr>`;
				}else{
					$.each(res, function (idx, reviewMberVO) {
						str += "<tr style=\"cursor: pointer;\">";
						console.log("res : ", res);
						str += "<td onclick='reDeFunc("+reviewMberVO.ondyclNo+")'>" + starTitColor(reviewMberVO.ondyclReScore) + "</td>";
						str += "<td onclick='reDeFunc("+reviewMberVO.ondyclNo+")' style='overflow: hidden; white-space: normal; display : block; text-overflow: ellipsis;'>" + reviewMberVO.ondyclReCn + "</td>";
						str += "<td onclick='reDeFunc("+reviewMberVO.ondyclNo+")'>";
						if(reviewMberVO.mberProflPhoto == null || reviewMberVO.mberProflPhoto == ''){
							str += "<img class='reDeProfile' src='/images/2024/profile.jpg'>";
						}else{
							str += "<img class='reDeProfile' src='"+reviewMberVO.mberProflPhoto+"'>";
						}
						str += reviewMberVO.mberNcnm + "</td>";
						str += "<td onclick='reDeFunc("+reviewMberVO.ondyclNo+")'>" + reviewMberVO.ondyclReWrDt + "</td>";
						str += "</tr>";
					});
				}

				$("#reviewTbody").append(str);
			}
		});
	}

	$("#backBtn").on("click",function(){
		location.href="/onedayClass/main";
	})
	
	$("#goMain").on('click',function(){
		location.href="/main";
	})
	
	$("#backMberMyClassList").on("click",function(){
		let sessionUserId = $("#sessionUserId").val();
		if('${param.startPoint}' == 'myClass'){
			// console.log("회원 아이디 : " +sessionUserId);
			location.href="/member/memberOndyclList?mberId=" + sessionUserId;
		}else if('${param.startPoint}' == 'proMyClass'){
			// console.log("회원 아이디 : " +sessionUserId);
			location.href="/pro/proMyClassList?mberId=" + sessionUserId;
		}
	})
	$("#backProMyClassList").on("click",function(){
		let sessionUserId = $("#sessionUserId").val();
		console.log("회원 아이디 : " +sessionUserId);
		location.href="/pro/proMyClassList?proId=" + sessionUserId;
	})
	
	const sessionId = $("#sessionId").val();
	const classId = $("#classId").val();
	const str = `
		<button type="button" id="updateBtn" class="btn btn-inverse-primary btn-fw" style="float:right;">수정</button>
		<button type="button" id="deleteBtn" class="btn btn-inverse-dark btn-fw" style="float:right;">삭제</button>
	`;
	console.log("참거짓 " + ${vOndyclProUsersVO.dayCheck});
	if(sessionId == classId && !${vOndyclProUsersVO.dayCheck}){
		$("#buyDelBtn").append(str)
	}
	
	//원데이클래스 업데이트
	$("#updateBtn").on("click",function(){
		$("#updateForm").submit();
	})
	
	//원데이클래스 삭제
	$("#deleteBtn").on("click",function(){
		const classNo = $("#classNo").val();
		const fileNo = $("#fileNo").val();
		let today = new Date();
		let classDay = $("#classDay").val();

		let year = today.getFullYear(); // 년도
		let month = (today.getMonth() + 1).toString();  // 월
		if(month.length == 1){
			month = "0" + month;
		}
		
		let date = today.getDate();  // 날짜
		let sysdate = year+month+date;
		
		if(Number(sysdate) >= (Number(classDay)-3)){
			wal.fire({
				content: "input",
				title: "클래스 시작 3일전에는 클래스 삭제를 진행할 수 없습니다.",
				icon: 'error',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인',
				dangerMode: true,
			})
		} else {
			Swal.fire({
				content: "input",
				title: "원데이 클래스를 삭제하시겠습니까?",
				text: "삭제를 진행하려면 아래 '삭제진행' 을 입력해주세요.",
				input: 'text',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
				// dangerMode: true
			}).then((result) => {
				if (result.value == "삭제진행") { //삭제 진행 가능
					$.ajax({
						url: "/onedayClass/deleteClass?classNo=" + classNo,
						type: "get",
						success: function (res) {
							Swal.fire({
								title: '원데이클래스가 삭제되었습니다.',
								icon: 'success',
								showCancelButton: false,
								confirmButtonColor: '#7066e0',
								confirmButtonText: '확인'
							}).then((result) => {
								if (result.isConfirmed) {
// 									window.history.back();
// 									location.reload(true);
									location.href="/onedayClass/main";
								}
							});
						}
					})
				} else if (result.isDismissed) {
					Swal.fire("원데이클래스 삭제 취소");
				} else { //인증번호 틀리면
					Swal.fire({
						title: '입력텍스트가 일치하지 않습니다.',
						text: '입력텍스트가 일치하지 않으면 삭제를 진행하지 않습니다.',
						icon: 'error',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					})
				}
			});
		}
	}) //원데이클래스 삭제 끝
	
	$(document).on("click",".slideDiv button",function() {
        let slideDirection = $(this).attr("aria-label");
        if (slideDirection === "Previous slide") {
            plusSlides(-1); // 이전 슬라이드로 이동
        } else if (slideDirection === "Next slide") {
            plusSlides(1); // 다음 슬라이드로 이동
        }
    });
	
	// 슬라이드 쇼 함수
	let slideIndex = 0;
	showSlides();

	function plusSlides(n) {
		slideIndex += n;
		showSlides();
	}

	function showSlides() {
		let slides = document.querySelectorAll(".slideDiv img");

		if (slideIndex >= slides.length) {
			slideIndex = 0
		}
		if (slideIndex < 0) {
			slideIndex = slides.length - 1
		}
		for (let i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		if (slides[slideIndex]) {
			slides[slideIndex].style.display = "block";
		} else {
		}
	}
})
$(document).ready(function(){
	//결제 시작
	var IMP = window.IMP; 
	IMP.init("imp67011510");	// 테스트용 가맹점ID(변경 X)

	var today = new Date();
	var year = today.getFullYear().toString();
	var month = today.getMonth().toString();
	var day = today.getDate().toString();
	var hours = today.getHours().toString(); // 시
	var minutes = today.getMinutes().toString();  // 분
	var seconds = today.getSeconds().toString();  // 초
	var milliseconds = today.getMilliseconds().toString();
	var makeMerchantUid = year + month + day + hours +  minutes + seconds + milliseconds;
	
	let ondyclNm = $("#ondyclNm").val();
	let ondyclPc = $("#ondyclPc").val();
	let email = $("#email").val();
	let userNm = $("#userNm").val();
	let proMbtlnum = $("#proMbtlnum").val();
	let adres = $("#adres").val();
	let detailAdres = $("#detailAdres").val();
	let zip = $("#zip").val();
	let mberId = "${memSession.userId}";
	let ondyclSchdulNo = "${vOndyclProUsersVO.ondyclSchdulNo}";
	let ondyclNo = "${vOndyclProUsersVO.ondyclNo}";

	$("#buyClassBtn").on("click", function () {
		IMP.request_pay({
			pg: 'kakaopay',
			pay_method: 'card',
			merchant_uid: makeMerchantUid,  // 주문번호
			name: '상품명 : ' + ondyclNm,							// 상품명
			amount: ondyclPc,							// 가격(결제 금액)
			buyer_email: email,
			buyer_name: userNm,
			buyer_tel: proMbtlnum,
			buyer_addr: adres + " " + detailAdres,
			buyer_postcode: zip,
		}, function (rsp) {
			if (rsp.success) {
				// 서버 결제 API 성공시 로직
				let data = {
					"setleNo":makeMerchantUid,
					"resveTpprice":ondyclPc,
					"mberId":mberId,
					"ondyclSchdulNo":ondyclSchdulNo,
					"ondyclNo":ondyclNo
				}
				// console.log(rsp);
				$.ajax({
					url: "/onedayClass/buyClass",
					type: "post",
					data:JSON.stringify(data),
					contentType:"application/json;charset=utf-8",
					success:function(res){
						Swal.fire({
							title: '결제가 성공하였습니다.',
							icon: 'success',
							showCancelButton: false,
							confirmButtonColor: '#7066e0',
							confirmButtonText: '확인'
						}).then((result)=>{
// 							$("#buyModal").modal('hide');
							location.href="/onedayClass/onedayClassDetail?ondyclNo="+ondyclNo+"&mberId="+mberId;
						})
					}
				})
			} else {
				Swal.fire({
					title: '결제가 취소되었습니다.',
					icon: 'error',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				})
			}
		});
	})//결제 끝
	
	$("#putShoppingCart").on("click",function(){
		let mberId = '${memSession.userId}';
		let ondyclSchdulNo = '${vOndyclProUsersVO.ondyclSchdulNo}';
		let ondyclNo = '${vOndyclProUsersVO.ondyclNo}';
		let prdPc = '${vOndyclProUsersVO.ondyclPc}'
		
		console.log("장바구니 담기 " + mberId + "/" + ondyclNo + "/" + ondyclSchdulNo + "/" + prdPc);
		
		let data = {
				"mberId":mberId,
				"ondyclSchdulNo":ondyclSchdulNo,
				"ondyclNo":ondyclNo,
				"prdPc":prdPc
		}
		Swal.fire({
			title: '해당 상품을 장바구니에 담으시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				$.ajax({
					url:'/onedayClass/putShoppingCart',
					data:data,
					type:'post',
					success:function(res){
						Swal.fire({
							title: '장바구니 담기 성공!!',
							icon: 'success',
							showCancelButton: false,
							confirmButtonColor: '#7066e0',
							confirmButtonText: '확인'
						}).then((result)=>{
							location.reload(true);
						})
					}
				})
			}else{
				Swal.fire({
					title: '장바구니 담기가 취소되었습니다.',
					icon: 'error',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인',
				})
			}
		})
	})
	
	$("#notifybtn").on('click',function(){
		Swal.fire({
			title: '해당 클래스를 신고하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				Swal.fire({
					title: '신고가 성공적으로 진행되었습니다.',
					icon: 'success',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인',
				})
			}
		})
	})
	
	$(".backBtnClass").on('click',function(){
		history.back();
	})
})
</script>
<div class="container col-lg-10" style="padding:0px;">
	<!-- 제목 -->
		<div >
			<img alt="원데이클래스" src="../resources/images/클래스.png" style="width:100px; height:auto; margin:0 0 20px 500px;">
			<h2 id="ondayTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">${vOndyclProUsersVO.userNcnm}님의 원데이클래스</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 300px 0 300px;">
			<br><br><br>
		</div>
	
	
	<div class="col-12">
		<c:choose>
			<c:when test="${param.startPoint eq 'myClass'}">
				<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">돌아가기</button>
			</c:when>
			<c:when test="${param.mainck eq 'main'}">
				<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">돌아가기</button>
			</c:when>
			<c:when test="${param.startPoint eq 'proMyClass'}">
				<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">돌아가기</button>
			</c:when>
			<c:when test="${param.startPoint eq 'myBundle'}">
				<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">돌아가기</button>
			</c:when>
			<c:when test="${memSession != null && proSession == null}">
				<c:choose>
					<c:when test="${vOndyclProUsersVO.dayCheck}">
<!-- 						<button type="button" class="btn btn-inverse-primary btn-fw" style="float:left;" data-toggle="modal" data-target="#buyModal">연습용 구매버튼</button> -->
						<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">목록으로</button>
						<p style="float:left; font-family: 'GmarketSansMedium'; margin-top:15px; margin-left:10px;">종료된 클래스입니다.</p>
					</c:when>
					<c:when test="${resveCheck eq 1}">
<!-- 						<button type="button" class="btn btn-inverse-primary btn-fw" style="float:left;" data-toggle="modal" data-target="#buyModal">연습용 구매버튼</button> -->
						<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">목록으로</button>
						<p style="float:left; font-family: 'GmarketSansMedium'; margin-top:15px; margin-left:10px; color:red;">이미 구매한 클래스입니다.</p>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${vOndyclProUsersVO.peopleCheck}">
								<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">목록으로</button>
<!-- 								<button type="button" class="btn btn-inverse-primary btn-fw" style="float:left;" data-toggle="modal" data-target="#buyModal">연습용 구매버튼</button> -->
								<p style="float:left; font-family: 'GmarketSansMedium'; margin-top:15px; margin-left:10px;">마감된 클래스 입니다.</p>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-inverse-primary btn-fw" style="float:left;" data-toggle="modal" data-target="#buyModal">구매</button>
								<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:left;">목록으로</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-inverse-dark btn-fw backBtnClass" style="float:right;">목록으로</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${memSession != null && proSession == null}">
				<img id="notifybtn" src="../resources/images/사이렌2.png" style="width: 25px; margin: 5px 0px 5px 5px; display: inline; float:right;">
<!-- 				<button type="button" id="putShoppingCart" class="btn btn-inverse-primary btn-fw" style="float:right;"><i class="mdi mdi-cart-plus icon-lg"></i>연습용 장바구니 추가</button> -->
				<input type="hidden" value="${memSession.userId}" id="sessionUserId">
				<c:choose>
					<c:when test="${!vOndyclProUsersVO.dayCheck}">
						<c:choose>
							<c:when test="${param.startPoint eq 'myClass'}">
								<button type="button" disabled class="btn btn-success btn-fw" style="float:right;"><i class="mdi mdi-checkbox-marked-circle-outline icon-lg"></i></button>
							</c:when>
							<c:when test="${classBundleCk eq 1}">
								<button type="button" disabled class="btn btn-success btn-fw" style="float:right;"><i class="mdi mdi-checkbox-marked-circle-outline icon-lg"></i></button>
							</c:when>
							<c:when test="${resveCheck eq 1}">
								<button type="button" disabled class="btn btn-success btn-fw" style="float:right;"><i class="mdi mdi-checkbox-marked-circle-outline icon-lg"></i></button>
							</c:when>
							<c:otherwise>
								<button type="button" id="putShoppingCart" class="btn btn-inverse-primary btn-fw" style="float:right;"><i class="mdi mdi-cart-plus icon-lg"></i></button>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${memSession == null && proSession != null}">
				<input type="hidden" value="${proSession.userId}" id="sessionUserId">
			</c:when>
		</c:choose>
	</div>
	
	
</div>
<br />
<div class="container col-lg-10" style="margin-top:50px;">
	<hr>
	<br>
	<form action="/onedayClass/updateClass" method="post" id="updateForm">
		<c:if test="${not empty proSession}">
			<input type="hidden" id="sessionId" value="${proSession.userId}">
		</c:if>
		<input type="hidden" id="classId" name="proId" value="${vOndyclProUsersVO.proId}">
		<input type="hidden" id="classNo" name="ondyclNo" value="${vOndyclProUsersVO.ondyclNo}">
		<input type="hidden" id="fileNo" name="sprviseAtchmnflNo" value="${vOndyclProUsersVO.sprviseAtchmnflNo}">
		<input type="hidden" id="classDay" name="ondyclSchdulDe" value="${vOndyclProUsersVO.ondyclSchdulDe}">
		<input type="hidden" id="ondyclSchdulNo" name="ondyclSchdulNo" value="${vOndyclProUsersVO.ondyclSchdulNo}">
		<input type="hidden" id="ondyclNm" name="ondyclNm" value="${vOndyclProUsersVO.ondyclNm}">
		<input type="hidden" id="ondyclCn" name="ondyclCn" value="${vOndyclProUsersVO.ondyclCn}">
		<input type="hidden" id="ondyclPc" name="ondyclPc" value="${vOndyclProUsersVO.ondyclPc}">
		<input type="hidden" id="ondyclPsncpa" name="ondyclPsncpa" value="${vOndyclProUsersVO.ondyclPsncpa}">
		<input type="hidden" id="ondyclResvpa" name="ondyclResvpa" value="${vOndyclProUsersVO.ondyclResvpa}">
		<input type="hidden" id="ondyclThumbPhoto" name="ondyclThumbPhoto" value="${vOndyclProUsersVO.ondyclThumbPhoto}">
		<input type="hidden" id="ondyclSchdulBeginTime" name="ondyclSchdulBeginTime" value="${vOndyclProUsersVO.ondyclSchdulBeginTime}">
		<input type="hidden" id="ondyclSchdulEndTime" name="ondyclSchdulEndTime" value="${vOndyclProUsersVO.ondyclSchdulEndTime}">
		<input type="hidden" id="ondyclAdres" name="ondyclAdres" value="${vOndyclProUsersVO.ondyclAdres}">
		<input type="hidden" id="ondyclDetailAdres" name="ondyclDetailAdres" value="${vOndyclProUsersVO.ondyclDetailAdres}">
		<input type="hidden" id="ondyclZip" name="ondyclZip" value="${vOndyclProUsersVO.ondyclZip}">
	</form>
	<div class="row">
		<div class="innerDiv col-7">
			<div class="centerDiv co-10">
				<div class="slideDiv">
					<ul id="ulPrt">
						<c:choose>
							<c:when test="${not empty sprviseAtchmnflVOList[0].atchmnflCours}">
								<c:choose>
									<c:when test="${not empty sprviseAtchmnflVOList[1].atchmnflCours}">
										<li style="list-style-type: none; display: inline-block;">
											<button type="button" aria-label="Previous slide"
													style="background: none; margin-left: -15px; border: none; position: absolute; top: 18%;">
												<i class="mdi mdi-arrow-left-drop-circle-outline"
													style="font-size: 35px;"></i>
											</button>
										</li>
											<c:forEach var="imgFile" items="${sprviseAtchmnflVOList}" varStatus="stat">
												<li style='list-style-type: none; display: inline-block;'>
													<img src='${imgFile.atchmnflCours}'
														style='width: 400px; height: 400px; margin-left: 25px; border-radius:40px'>
												</li>
											</c:forEach>
										<li style='list-style-type: none; display: inline-block;'>
											<button type='button' aria-label='Next slide'
												style='background: none; margin-left: 5px; border: none; position: absolute; top: 18%;'>
												<i class='mdi mdi-arrow-right-drop-circle-outline'
													style='font-size: 35px;'></i>
											</button>
										</li>
									</c:when>
									<c:otherwise>
										<li style='list-style-type: none; display: inline-block;'>
											<img src='${sprviseAtchmnflVOList[0].atchmnflCours}'
												style='width: 400px; height: 400px; margin-left: 35px;'>
										</li>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<li style='list-style-type: none; display: inline-block;'>
									<img src='/images/2024/no_image.gif'
										style='width: 200px; height: 200px; margin-left: 35px;'>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
			<div class="innerDiv co-10" style="font-family: 'GmarketSansMedium'; padding:50px 70px;">
			<h3 style="position: relative; z-index: 1; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">✏️ 원데이 클래스 상세 설명</h3>
			<hr style="border: 0; border-top: 10px solid #fbecbe; position: relative; z-index: 0; margin-top:-20px;">
				<br>
				<h5 style='width:100%; max-width:1100px; height:500px; padding:10px; overflow-y: auto; word-wrap: break-word; position: relative; z-index: 1;'>${vOndyclProUsersVO.ondyclCn}</h5>
			</div>
		</div>
		<div class="innerDiv col-5">
			<div class="innerDiv co-10">
				<table class="table table-hover">
					<tbody>
						<tr>
							<td colspan='2' style="border-top: none;">
								<h3>
									<c:if test="${empty vOndyclProUsersVO.proProflPhoto}">
										<img class="profile" src="/images/2024/profile.jpg">
									</c:if>
									<c:if test="${not empty vOndyclProUsersVO.proProflPhoto}">
										<img class="profile" src="${vOndyclProUsersVO.proProflPhoto}">
									</c:if>
									&nbsp;<c:out value="${vOndyclProUsersVO.userNcnm}"></c:out>
								</h3>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><c:out value="${vOndyclProUsersVO.ondyclNm}"></c:out></td>
						</tr>
						<tr>
							<th>전문분야</th>
							<td><c:out value="${vOndyclProUsersVO.spcltyRealmNm}"></c:out></td>
						</tr>
						<tr>
							<th>시작일</th>
							<td><c:out value="${vOndyclProUsersVO.ondyclSchdulDe}"></c:out></td>
						</tr>
						<tr>
							<th>시간</th>
							<td><c:out value="${vOndyclProUsersVO.ondyclSchdulBeginTime}~${vOndyclProUsersVO.ondyclSchdulEndTime}"></c:out></td>
						</tr>
						<tr>
							<th>정원</th>
							<td><c:out value="${vOndyclProUsersVO.ondyclResvpa} / ${vOndyclProUsersVO.ondyclPsncpa}"></c:out></td>
						</tr>
						<tr>
							<th>가격</th>
							<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${vOndyclProUsersVO.ondyclPc}" />원</td>
						</tr>
						<tr>
							<td colspan='2' class="btnPlus">
								<div class="col-12" style="padding-top:15px">
									<h3 style="text-align:center; position: relative; z-index: 1; margin-top:20px; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">🙋‍♀️ 참여자 명단</h3>
									<hr style="border: 0; border-top: 10px solid #bedffb; position: relative; z-index: 0; margin-top:-20px;">
									
									<c:if test="${empty userNcnmMberPhotoVOList}">
										<div style="text-align: center;">
											<img src="../resources/images/우는모양.png" style="width: 60px; height: 60px; margin: 20px 0 " />
											<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">
												아직 참여한 회원이 없어요!
											</h3>
										</div>
									</c:if>
									
									<c:forEach var="userNcnmMberPhotoVO" items="${userNcnmMberPhotoVOList}" varStatus="stat">
										<div style="margin-bottom:10px;">
											<c:choose>
												<c:when test="${not empty userNcnmMberPhotoVO.mberProflPhoto}">
													<img src="${userNcnmMberPhotoVO.mberProflPhoto}" style='margin-right:10px;'>${userNcnmMberPhotoVO.userNcnm}
												</c:when>
												<c:otherwise>
													<img src="/images/2024/profile.jpg" style='margin-right:10px;'>${userNcnmMberPhotoVO.userNcnm}
												</c:otherwise>
											</c:choose>
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<input type="hidden" id="email" name="email" value="${vOndyclProUsersVO.email}">
			<input type="hidden" id="userNm" name="userNm" value="${vOndyclProUsersVO.userNm}">
			<input type="hidden" id="proMbtlnum" name="proMbtlnum" value="${vOndyclProUsersVO.proMbtlnum}">
			<input type="hidden" id="adres" name="adres" value="${vOndyclProUsersVO.adres}">
			<input type="hidden" id="detailAdres" name="detailAdres" value="${vOndyclProUsersVO.detailAdres}">
			<input type="hidden" id="zip" name="zip" value="${vOndyclProUsersVO.zip}">
			<div class="hrDiv co-10"></div>
			
			<div id="map" style="width:450px;height:350px; border-radius: 30px;">
				<!-- 카카오맵 위치할 부분 -->
			</div>
			
			<div class="hrDiv co-10" style="font-family: 'GmarketSansMedium'; text-align: center; margin: 10px;">🚩  ${vOndyclProUsersVO.ondyclAdres} ${vOndyclProUsersVO.ondyclDetailAdres}</div>
			<!-- 원래있던곳 -->
		</div>
	</div>
</div>

<div>
<h3 style="margin-top:20px ; text-align:center; position: relative; z-index: 1; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;"><b>🧾 REVIEW</b></h3>
<hr style="margin:-10px 400px 0 400px; border: 0; border-top: 10px solid #e5d7ff; position: relative; z-index: 0; margin-top:-20px;">
<c:if test="${!vOndyclProUsersVO.dayCheck}">
	<div class="innerDiv co-10 table-responsive" style="margin:15px 0 0 130px; width:1100px;">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th style="width: 20%;">별점</th>
					<th style="width: 60%;">한줄평</th>
					<th style="width: 20%;">작성자</th>
					<th style="width: 10%;">작성날짜</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="4" style="text-align: center;">
						<img src="../resources/images/우는모양.png" style="width: 60px; height: 60px; margin: 20px 0;" />
						<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">아직 리뷰가 없어요!</h3>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>

<c:if test="${vOndyclProUsersVO.dayCheck}">
	<div class="innerDiv co-10 table-responsive" style="margin:15px 0 0 130px; width:1100px;">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th style="width: 20%;">별점</th>
					<th style="width: 60%;">한줄평</th>
					<th style="width: 20%;">작성자</th>
					<th style="width: 10%;">작성날짜</th>
				</tr>
			</thead>
			<tbody id="reviewTbody">
				<!-- 리뷰리스트가 표시되는 부분 -->
			</tbody>
		</table>
	</div>
</c:if>
</div>
<div id="buyDelBtn" class="col-11" style="margin-top:20px; "></div>


<!-- 결제 모달 -->
<div class="modal" id="buyModal" tabindex="-1"
	data-backdrop="static" aria-labelledby="#buyModalLabel"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title">⭐ 원데이클래스 결제하기</h3>
				<button type="button" class="close" id="buyModalClose" data-dismiss="modal">x</button>
			</div>
			<div class="modal-body" id="buyModalBody">
				<div id="codeDiv" class="container">
					<div class="innerDiv col-12">
						<c:if test="${empty vOndyclProUsersVO.ondyclThumbPhoto}">
							<img src="/images/profile.jpg" class="modalThumb" style="margin: 0 0 20px 130px; border-radius:70%;">
						</c:if>
						<c:if test="${not empty vOndyclProUsersVO.ondyclThumbPhoto}">
							<img src="${vOndyclProUsersVO.ondyclThumbPhoto}" class="modalThumb" style="margin: 0 0 20px 130px; border-radius:70%;">
						</c:if>
					</div>
					<div class="innerDiv col-12">
						<table class="table">
							<tr>
								<th colspan='2'><b><c:out value="${vOndyclProUsersVO.ondyclNm}"></c:out></b></th>
							</tr>
							<tr>
								<th><c:out value="${vOndyclProUsersVO.ondyclSchdulDe}"></c:out></th>
								<td><c:out value="${vOndyclProUsersVO.ondyclSchdulBeginTime} ~ ${vOndyclProUsersVO.ondyclSchdulEndTime}"></c:out></td>
							</tr>
							<tr>
								<td>${vOndyclProUsersVO.ondyclPc}원</td>
								<td><c:out value="${vOndyclProUsersVO.ondyclAdres}"></c:out></td>
							</tr>
						</table>
					</div>
					<div class="row container" style="margin:20px 0 0 120px;">
						<c:choose>
							<c:when test="${resveCheck eq 1}">
								<button type="button" class="btn btn-secondary"  data-dismiss="modal">취소</button>
								<p style="margin-top:15px; color:red;">이미 구매한 상품입니다.</p>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary" id="buyClassBtn" style="float:right;">결제</button>
								<button type="button" class="btn btn-secondary"  data-dismiss="modal" style="float:right;">취소</button>
							</c:otherwise>
						</c:choose>
					</div>
            	</div>
			</div>
		</div>
	</div>
</div>

<!-- 리뷰 디테일 모달 -->
<div class="modal fade" id="reviewDetailModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- Modal body -->
			<div class="modal-header" id="reModalHead">
			</div>
			<div class="modal-body" id="reDeTbody">
				
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"  data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0d1a87a8b79ab995c3af3dd75086b670&libraries=services"></script>
<script>
var container = document.getElementById('map');
var options = {
	center: new kakao.maps.LatLng(36.32478497698163, 127.4087523203049),
	level: 3 // 지도의 확대 레벨
};
//지도를 생성합니다    
var map = new kakao.maps.Map(container, options);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
var adres = '${vOndyclProUsersVO.ondyclAdres}';
geocoder.addressSearch(adres, function(result, status) {
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        
        // 결과값으로 받은 위치를 마커로 표시합니다
        var markerImage = new kakao.maps.MarkerImage(
            '/resources/images/지도마커.png', // 마커 이미지 URL
            new kakao.maps.Size(50, 50), // 마커 이미지 크기
            { offset: new kakao.maps.Point(25, 50) } // 마커 이미지의 좌표 설정
        );
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords,
            clickable: true, // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
            image: markerImage
        });
     	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
        var iwContent = '<div style="padding:5px;">${vOndyclProUsersVO.ondyclDetailAdres}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content : iwContent,
            removable : iwRemoveable
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
              // 마커 위에 인포윈도우를 표시합니다
              infowindow.open(map, marker);  
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
//         var infowindow = new kakao.maps.InfoWindow({
//             content: '<div style="width:150px;text-align:center;padding:6px 0;">${vOndyclProUsersVO.ondyclDetailAdres}</div>'
// //         	content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
//         });
//         infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    }else{
    	console.log("지도 검색 실패")
    }
});    
</script>	
