<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
	font-family: 'GmarketSansLight';
}
#balloon{
	margin : -184px 0px -238px 379px;
	z-index : 1;
}

#lbrtybbsctt{
	font-family: 'seolleimcool-SemiBold'; 
	color:#4e4c7c; 
	text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;
	margin: 54px 0 -122px 557px;
	position : relative;
	z-index: 2;
}
.starR{
  display: inline-block;
  width: 30px;
  height: 30px;
  color: transparent;
  text-shadow: 0 0 0 #f0f0f0;
  font-size: 1.8em;
  box-sizing: border-box;
  cursor: pointer;
}

/* 별 이모지에 마우스 오버 시 */
.starR:hover {
  text-shadow: 0 0 0 #ccc;
}

/* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
.starR.on{
  text-shadow: 0 0 0 #4B49AC;
}
.star {
  position: relative;
  font-size: 2rem;
  color: lightgray;
}

.star input {
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0;
  opacity: 0;
  cursor: pointer;
}

.star span {
  width: 0;
  position: absolute; 
  left: 0;
  color: #4B49AC;
  overflow: hidden;
  pointer-events: none;
}
#ondyclReCn{
	width:100%;
}
#reviewModalClose{
	background-color:transparent;
	border:none;
}
/* 네비게이션 메뉴 */
.sidenav {
  width: 200px;
  position: fixed;
  z-index: 1;
  font-size: 18px;
  top: 153px;
  left: 70px;
  border-bottom: 1px solid lightgray;
  overflow-x: hidden;
  padding: 15px 0;
  text-align: center;
}
.sidenav p {
  padding: 6px 8px 6px 8px; /*주희 수정 왼쪽 패딩 맞춤*/
  text-decoration: none;
  font-size: 18px;
  display: block;
  color: #000;
}
.sidenav a, .sidenav a:link {
  padding: 6px 8px 6px 8px; /*주희 수정 왼쪽 패딩 맞춤*/
  text-decoration: none;
  font-size: 18px;
  color: #000;
  display: block;
  color: #000;
  font-family: 'GmarketSansLight';
  position: relative;
  overflow: hidden;
}
.sidenav a::after {
  content: '';
  display: block;
  position: absolute;
  bottom: 2px; /*주희 수정 hover시 아래로 치우침 맞춤*/
  left: 50%; /* 배경의 시작 위치를 텍스트 중앙으로 설정 */
  transform: translateX(-50%); /* 가로 방향으로 이동시킴 */
  z-index: -1;
  width: 0; /* 초기 가로 크기를 0으로 설정 */
  height: 90%; /* 주희 수정 hover 간격 띄우기*/
  background: rgba(208, 207, 251, 0.5); /* 주희수정 색상 누네로 톤 맞춤 */
  transition: width .3s;
}
.sidenav a:hover::after {
	width: 90%; /* 호버 시 가로 크기를 100%로 확장 */
}

.main {
	margin-left: 140px; /* Same width as the sidebar + left position in px */
	font-size: 10px; /* Increased text to enable scrolling */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidenav {padding-top: 15px;}
	.sidenav a {font-size: 10px;}
}
</style>
<script>
function pagingList(data){
	$.ajax({
		url : "/onedayClass/memberOndyclListAjax",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(res){
// 			console.log("res:",res);
			if(res.total == 0){
				$("#myClassTbody").html("<tr><td colspan='4' style='text-align:center;'>검색결과가 없습니다.</td></tr>");
			}
			let date = new Date();
			let today = date.getFullYear().toString() +"."+ String(date.getMonth() + 1).padStart(2,"0") +"."+ String(date.getDate()).padStart(2,"0");
			let threeDay = new Date(date.setDate(date.getDate() + 3));
			let thirdDate = date.getFullYear().toString() +"."+ String(date.getMonth() + 1).padStart(2,"0") +"."+ String(date.getDate()).padStart(2,"0");
			let str = "";
			
			$.each(res.content,function(idx, vOndyclProUsersVO){
// 				console.log(vOndyclProUsersVO.ondyclDelType);
				if(vOndyclProUsersVO.dayCheck){
					$("#myClassTbody").html("");
					str += "<tr style=\"cursor: pointer;\">";   
					if(vOndyclProUsersVO.canclAt != 1){
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.rnum+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.ondyclNm+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
						if(vOndyclProUsersVO.ondyclReNo == null || vOndyclProUsersVO.ondyclReNo == ""){
							str += "<td><button type='button' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='createReview(this)' class='btn btn-success btn-rounded btn-fw btn-sm'>리뷰쓰기</button></td>";
						}else{
							str += "<td><button type='button' class='btn btn-success btn-rounded btn-fw btn-sm' disabled>리뷰작성완료</button></td>";
						}
					}
					str += "</tr>";
					$("#myClassTbody").append(str);
					$("#divPagingArea").html(res.pagingArea);
				}else{
					$("#myClassTbody").html("");
					if(vOndyclProUsersVO.canclAt != 1){
						str += "<tr style=\"cursor: pointer;\">";   
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.rnum+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.ondyclNm+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=myClass'\">"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
						if(vOndyclProUsersVO.dayCheck){ //시간 지남.
							if(vOndyclProUsersVO.ondyclReNo == null || vOndyclProUsersVO.ondyclReNo == ""){
								str += "<td><button type='button' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='createReview(this)' class='btn btn-success btn-rounded btn-fw btn-sm'>리뷰쓰기</button></td>";
							}else{
								str += "<td><button type='button' class='btn btn-success btn-rounded btn-fw btn-sm' disabled>리뷰작성완료</button></td>";
							}
						}else{ //시간 지나기 전
							if(thirdDate >= vOndyclProUsersVO.ondyclSchdulDe){
								str += "<td><button type='button' id='"+vOndyclProUsersVO.ondyclNo+"' disabled onclick='cancelClass(this)' class='btn btn-outline-danger btn-fw'>취소</button></td>";
							}else{
								str += "<td><button type='button' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='cancelClass(this)' class='btn btn-outline-danger btn-fw'>취소</button></td>";
							}
						}
						str += "</tr>";
					}else{
						str += "<tr style=\"cursor: pointer;\">";   
						str += "<td style='text-decoration:line-through; color:lightgray'>"+vOndyclProUsersVO.rnum+"</td>";
						str += "<td style='text-decoration:line-through; color:lightgray'>"+vOndyclProUsersVO.ondyclNm+"</td>";
						str += "<td style='text-decoration:line-through; color:lightgray'>"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
						str += "<td style='text-decoration:line-through; color:lightgray'>취소한 클래스입니다.</td>";
						str += "</tr>";
					}
					$("#myClassTbody").append(str);
					$("#divPagingArea").html(res.pagingArea);
				}
			});
			
		}
	});
}
$(function(){
	//검색조건 제목
	$("#title").on("click",function(){
		const btnElement = document.getElementById('searchCategory');
		btnElement.innerText = '제목';
		$('#keyword').attr("type", "text");
		$("#searchKeyword").val("title");
		$("#keyword").val("");
	})
	//검색조건 날짜
	$("#date").on("click",function(){
		const btnElement = document.getElementById('searchCategory');
		btnElement.innerText = '날짜';
		$('#keyword').attr("type", "date");
		$("#searchKeyword").val("date");
		$("#keyword").val("");
	})
	
	let searchKeyword = $("#searchKeyword").val();
	let userId = $("#sessionId").val();
	if($("#sessionId").val() == ""){
		Swal.fire({
			title: '로그인 후 이용해주세요.',
			icon: 'info',
			showCancelButton: false,
			confirmButtonColor: '#7066e0',
			confirmButtonText: '확인'
		}).then((result)=>{
			location.href="/main";
		})
	}
	
	$("#btnSearch").on("click",function(){
		btnSearchClick();
	});
	$("#keyword").on("keyup", function (key) {
        if (key.keyCode == 13) {
        	btnSearchClick();
        }
    })
	let btnSearchClick = function(){
		let keyword = $("#keyword").val();
		let currentPage = "1";
		let searchKeyword = $("#searchKeyword").val();
		
		let data = {
			"keyword":keyword,
			"currentPage":currentPage,
			"mberId":userId,
			"searchKeyword":searchKeyword
		};
// 		console.log("data:"+data)
		pagingList(data);
	}
	
	let currentPage  = "${param.currentPage}";
	if(currentPage==""){
		currentPage = 1;
	}
	
	let data = {
		"keyword":"${param.keyword}",
		"currentPage":currentPage,
		"mberId":userId,
		"searchKeyword":searchKeyword
	};
// 	console.log("data2:",data)
	pagingList(data);
	
// 	$("#pastTime").on("click",function(){
// 		let keyword = $("#keyword").val();
// 		let currentPage = "1";
// 		let searchKeyword = $("#searchKeyword").val();
		
// 		let data = {
// 			"keyword":keyword,
// 			"currentPage":currentPage,
// 			"mberId":userId,
// 			"searchKeyword":searchKeyword
// 		};
// // 		console.log("data:"+data)
// 		pagingList(data);
		
// 	})
	//리뷰등록 모달 닫을때 이벤트
	$("#reviewModalClose").on("click",function(){
		$("#ondyclReCn").val("");
		$("#ckNum").html("");
		$("#two").removeClass('on');
		$("#three").removeClass('on');
		$("#four").removeClass('on');
		$("#five").removeClass('on');
		$("#starCount").val("");
		$("#reviewModal").modal('hide');
	})
	
	//별점 클릭이벤트
	$('.starRev span').click(function(){
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
// 		console.log($(this).attr("id"));
		$("#starCount").val($(this).attr("id"));
		return false;
	});
	
	//리뷰작성
	$("#reviewConfirm").on("click",function(){
		console.log("리뷰 등록!!");
		let ondyclReCn = $("#ondyclReCn").val();
		let starCount = $("#starCount").val();
		let ondyclNo = $("#ondyclNum").val();
		let mberId = '${memSession.userId}';
		let ondyclReScore = 0;
		
		if(starCount == 'one'){
			ondyclReScore = 1;
		}else if(starCount == 'two'){
			ondyclReScore = 2;
		}else if(starCount == 'three'){
			ondyclReScore = 3;
		}else if(starCount == 'four'){
			ondyclReScore = 4;
		}else{
			ondyclReScore = 5;
		}
		
		data = {
				"ondyclReCn":ondyclReCn,
				"ondyclReScore":ondyclReScore,
				"ondyclNo":ondyclNo,
				"mberId":mberId
		}
		
// 		console.log("별점 : " + ondyclReScore);
// 		console.log("리뷰내용 : " + ondyclReCn);
		if(starCount == null || starCount == ''){
			Swal.fire({
				title: '별점을 선택해주세요.',
				icon: 'error',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인'
			})
		}else if(ondyclReCn == null || ondyclReCn == ''){
			Swal.fire({
				title: '한줄평을 작성해주세요.',
				icon: 'error',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인'
			})
		}else if($("#ondyclReCn").val().length > 50){
			Swal.fire({
				title: '한줄평 글자수 제한이 넘었습니다.',
				icon: 'error',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인'
			})
		}else {
			$.ajax({
				url:'/onedayClass/createReview',
				type:'post',
				data:data,
				success:function(res){
					console.log("리뷰 성공" + res);
					Swal.fire({
						title: '클래스 한줄평 등록 성공!',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						location.reload('true');
					})
				}
			})
		}
	})//리뷰작성 끝
	
	//리뷰 내용 글자수 제한
	$("#ondyclReCn").keyup(function(){
		let content = $(this).val();
// 		console.log("길이 : " + length);
		
		if(content.length == 0 || content == ''){
			$("#reCnLength").text('0/50');
			$("#ondyclReCn").css('border','1px solid lightgray');
			$("#reCnLength").css('color','black');
		}else{
			$("#reCnLength").text(content.length + '/50');
			$("#ondyclReCn").css('border','1px solid lightgray');
			$("#reCnLength").css('color','black');
		}
		
		if(content.length > 50){
			$("#reCnLength").text(content.length + '/50');
			$("#ondyclReCn").css('border','1px solid red');
			$("#reCnLength").css('color','red');
		}
		
	})//리뷰내용 글자수 제한 끝
	
	//리뷰 자동완성
	$("#reviewAuto").on("click",function(){
		let str = "이 수업은 실용적인 접근 방식으로 주제를 명확히 이해할 수 있게 해줘요. 매우 추천합니다!";
		$("#ondyclReCn").val(str);
	})
	
	//수강완료만 보기 클릭
	$("#pastTime").on('click',function(){
		console.log("수강완료");
		let bool = $('#pastTime').is(':checked');
		let keyword = $("#keyword").val();
		let currentPage = "1";
		let searchKeyword = $("#searchKeyword").val();
		
		let data = {
			"keyword":keyword,
			"currentPage":currentPage,
			"mberId":userId,
			"searchKeyword":searchKeyword,
			"bool":bool
		};
		console.log("수강완료 클릭 data : ",data);
		pagingList(data);
	})
})

function cancelClass(e){
	let mberId = '${memSession.userId}';
	let data = {
			"mberId":mberId,
			"ondyclNo":e.id
	}
	console.log("취소 ", data);
	Swal.fire({
    	content: "input",
		title: "원데이 클래스를 취소하시겠습니까?",
		text: "취소를 진행하려면 아래 '클래스취소' 을 입력해주세요.",
		input: 'text',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#7066e0',
		cancelButtonColor: '#6e7881',
		confirmButtonText: '확인',
		cancelButtonText: '취소'
	}).then((result) => {
		if (result.value == "클래스취소") {
			$.ajax({
				url: "/onedayClass/mberClassCancel",
				//             	context-type:"application-json"
				type: "post",
				data: data,
				success: function (res) {
					Swal.fire({
						title: '클래스 취소가 완성되었습니다.',
						text: '환불은 카카오 영업일 기준 2~3일 소요될 수 있습니다',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						location.reload(true);
					})
				}
			})
        }else if(result.isDismissed){ //취소버튼 클릭시
			Swal.fire("원데이클래스 삭제 취소");
        }else{ //인증번호 틀릴시
        	Swal.fire({
				title: '입력텍스트가 일치하지 않습니다.',
				text: '입력텍스트가 일치하지 않으면 취소가 진행되지 않습니다.',
				icon: 'error',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인'
			})
        }
    });
	
}
function createReview(e){
	$("#ondyclNum").val(e.id);
	console.log("리뷰 "+e.id);
	$.ajax({
		url:"/onedayClass/mberReviewTitle?ondyclNo="+e.id,
		contentType:"application/json; charset=utf-8",
		success:function(res){
			console.log("제목 : " + res);
			$("#reviewModalTitle").text("제목 : " + res);
			$("#reviewModal").modal('show');
			
		}
	})
}

</script>
<div style="margin-left:150px;">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
		<div >
			<img alt="원데이클래스" src="../resources/images/클래스.png" style="width:100px; height:auto; margin:0 0 20px 550px;">
			<h2 id="ondayTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">${memSession.userNcnm}님이 예약한 원데이클래스</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 300px 0 300px;">
			<br><br><br>
		</div>
</div>
	
<div class="sidenav">
	<p style="text-align: center;">
		<b>MYPAGE MENU</b>
	</p>
	<hr>
	<c:if test="${memSession.userId  != null && proSession.userId  == null}">
		<a href="/member/memberMypage">마이페이지</a>
		<a href="/srvcBtfInqry/myBtfInqryList">보낸 서비스 사전 문의</a>
	 	<a href="/srvcRequst/mySrvcRqList">보낸 서비스 요청서</a> 
		<a href="/member/memberOndyclList">원데이클래스</a>
		<a href="/member/memberPostList">게시글 관리</a> 
		<a href="/srvcRqReview/reMgmt" id="reviewMgmtLink">서비스 요청 리뷰 관리</a>
		<a href="/oneInqry/myOneInqryList">1:1 문의 내역</a>	
	</c:if>
	<c:if test="${proSession.userId  != null && memSession.userId == null}">
		<a href="/pro/proMypage">마이페이지</a>
		<a href="/srvcBtfInqry/myBtfInqryList">받은 서비스 사전 문의</a>
		<a href="/srvcRequst/mySrvcRqList">받은 서비스 요청서</a> 
		<a href="/pro/proMyClassList">원데이클래스</a>
		<a href="/pro/proPostList">게시글 관리</a> 
		<a href="/srvcRqReview/proReMgmt" id="reviewMgmtLink">서비스 요청 리뷰 관리</a>
	<a href="/oneInqry/myOneInqryList">1:1 문의 내역</a>
	</c:if>
</div>

<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px; margin-left: 92px; padding-bottom: 5px;">	
<div class="col-12 grid-margin stretch-card">
	<input type="hidden" id="searchKeyword" value="title">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6" style="margin-top: 10px;">
						<h3>원데이클래스 예약내역</h3>
						<p class="font-weight-500 mb-0" style="color: red">※클래스 시작 3일전부터는 클래스를 취소할 수 없습니다.</p>
					</div>
					<div class="col-md-6 form-group text-right"> <!-- 중앙 정렬을 위해 text-center 클래스 추가 -->
						<input type="checkbox" id="pastTime" value="pastTime"><label for="pastTime">수강 완료한 클래스만 보기</label>
						<div class="input-group">
							<button class="btn btn-inverse-primary btn-fw btnSelect dropdown-toggle"
								type="button" id="searchCategory" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">제목</button>
							<div class="dropdown-menu" style="">
								<p class="dropdown-item" id="title">제목</p>
								<p class="dropdown-item" id="date">날짜</p>
							</div>
							<input type="text" name="keyword" id="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label=""
								style="width: auto; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 44px; padding-left:11px;
								margin: 0 8px 0 8px;"/>
							<div class="">
								<button type="button" class="btn btn-inverse-primary btn-sm" id="btnSearch" style="height: 42px;">
								<i class="mdi mdi-yeast"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th style="width: 10%;">글번호</th>
								<th style="width: 50%;">제목</th>
								<th style="width: 10%;">진행일자</th>
								<th style="width: 10%;">클래스취소</th>
							</tr>
						</thead>
						<tbody id="myClassTbody">
							<!-- 공지사항 내용이 표시되는 부분 -->
						</tbody>
					</table>
				</div>
				<div class="row justify-content-center" style="margin-top: 20px;">
					<div id="divPagingArea"></div>
				</div>
			</div>
		</div>
	</div>

<!-- Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" data-backdrop="static" aria-labelledby="reviewModalLabel"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewModalTitle"></h5>
				<button type="button" id="reviewModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
			</div>
			<div class="modal-body">
				별점을 매겨주세요!!
				<input type="hidden" id="starCount" value="">
				<div class="starRev">
					<span class="starR on" id="one">⭐</span>
					<span class="starR" id="two">⭐</span>
					<span class="starR" id="three">⭐</span>
					<span class="starR" id="four">⭐</span>
					<span class="starR" id="five">⭐</span>
				</div>
				<textarea rows="2" class="form-control" id="ondyclReCn" name="ondyclReCn" placeholder="50자 내의 간단한 한줄평을 등록해보세요!!" style="margin-top:10px;"></textarea>
				<p id="reCnLength">0/50</p>
				<input type="hidden" id="ondyclNum">
			</div>
			<div class="modal-footer" id="pwDiv">
<!-- 				        <button type="button" class="btn btn-inverse-secondary btn-fw" data-bs-dismiss="modal">취소</button> -->
				<button type="button" id="reviewAuto" style="border:none; background:none; float:right;">
		           	<img src="../resources/images/버튼.png" style="width:50px; height:50px; " />
		        </button>
				<button type="button" id="reviewConfirm" class="btn btn-inverse-primary btn-fw">확인</button>
			</div>
		</div>
	</div>
</div>
</div>