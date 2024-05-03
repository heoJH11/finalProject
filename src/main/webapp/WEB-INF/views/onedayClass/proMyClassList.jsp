<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
.wrapper {
	width : 100%;
}

.left {
	float : left;
}

.right {
	float: right;
}

.starR{
  display: inline-block;
  width: 30px;
  height: 30px;
  color: transparent;
  text-shadow: 0 0 0 #4B49AC;
  font-size: 1.8em;
  box-sizing: border-box;
  cursor: pointer;
}
.money{
  display: inline-block;
  width: 30px;
  height: 30px;
  color: transparent;
  text-shadow: 0 0 0 #F9C23C;
  font-size: 1.8em;
  box-sizing: border-box;
  cursor: pointer;
}
.innerDiv {
	height: auto;
/* 	text-align: center; */
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
 #balloon{
	margin : -184px 0px -238px 379px;
	z-index : 1;
}

#lbrtybbsctt{
	font-family: 'seolleimcool-SemiBold'; 
	color:#4e4c7c; 
	text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;
	margin: 54px 0 -122px 549px;
	position : relative;
	z-index: 2;
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
monthUserMap = [];
monthPriceMap = [];
function pagingList(data){
// 	$("#moneyRate").val(data.totalPrice);
	$.ajax({
		url : "/onedayClass/proOndyclListAjax",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(res){
			if(res.total == 0){
				Swal.fire({
					title: '검색 결과가 하나도 없습니다.',
					icon: 'info',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				})
			}
			monthUserMap = res.monthUserMap;
			monthPriceMap = res.monthPriceMap;
// 			console.log("res.monthUserMap:"+typeof(monthUserMap.month1));
			let date = new Date();
			let today = date.getFullYear().toString() +"."+ String(date.getMonth() + 1).padStart(2,"0") +"."+ String(date.getDate()).padStart(2,"0");
			let threeDay = new Date(date.setDate(date.getDate() + 3));
			let thirdDate = date.getFullYear().toString() +"."+ String(date.getMonth() + 1).padStart(2,"0") +"."+ String(date.getDate()).padStart(2,"0");
			let str = "";
// 			console.log(today +"/"+thirdDate);
			$("#myClassTbody").html("");
			if(res.totalPrice == 0){
				$("#moneyRate").text("매출이 없습니다.");
			}else{
				$("#moneyRate").html('<div class="starRev" style="margin-right:15px;"><span class="starRev money">💲</span></div><p style="font-size:1.7rem; line-height: 40px;">'+res.totalPrice+' 원</p>');
			}
			
			if(res.totalStar == 0){
				$("#starRate").text("받은 별점이 없습니다.");
			}else{
				$("#starRate").html('<div class="starRev" style="margin-right:15px;"><span class="starRev starR on">⭐</span></div><p style="font-size:1.7rem; line-height: 40px;">'+res.totalStar+'</p>');
			}
			
			if(res.totalUser == 0){
				$("#userRate").html('<div class="starRev" style="margin-right:15px;"><span class="starRev starR on">👥</span></div><p style="font-size:1.7rem; line-height: 40px;">0 명</p>');
			}else{
				$("#userRate").html('<div class="starRev" style="margin-right:15px;"><span class="starRev starR on">👥</span></div><p style="font-size:1.7rem; line-height: 40px;">'+res.totalUser+' 명</p>');
			}
			
			$.each(res.data.content,function(idx, vOndyclProUsersVO){
				str += "<tr style=\"cursor: pointer;\">";   
				/* str += "<tr>"; */
				if(vOndyclProUsersVO.ondyclDelType == 0){
		
					
					if(today < vOndyclProUsersVO.ondyclSchdulDe){
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.rnum+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.ondyclNm+"</td>";
						str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
						if(thirdDate < vOndyclProUsersVO.ondyclSchdulDe){
							str += "<td><button type='button' class='btn btn-outline-secondary btn-rounded btn-icon' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='proCancelClass(this)'><i class='mdi mdi-heart-broken'></i></button></td>";
						}else{
							str += "<td><button type='button' disabled class='btn btn-outline-secondary btn-rounded btn-icon' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='proCancelClass(this)'><i class='mdi mdi-heart-broken'></i></button></td>";
						}
					}else{
						str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.rnum+"</td>";
						str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.ondyclNm+"</td>";
						str += "<td style='text-decoration:line-through; color:red;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + vOndyclProUsersVO.ondyclNo + "&startPoint=proMyClass'\">"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
						str += "<td><button type='button' disabled class='btn btn-outline-secondary btn-rounded btn-icon' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='proCancelClass(this)'><i class='mdi mdi-heart-broken'></i></button></td>";
					}
					str += "</tr>";
				}else{
					str += "<td style='text-decoration:line-through; color:gray;'>"+vOndyclProUsersVO.rnum+"</td>";
					str += "<td style='text-decoration:line-through; color:gray;'>"+vOndyclProUsersVO.ondyclNm+"</td>";
					str += "<td style='text-decoration:line-through; color:gray;'>"+vOndyclProUsersVO.ondyclSchdulDe+"</td>";
	// 				console.log(today);
	// 				console.log(vOndyclProUsersVO.ondyclSchdulDe);
					str += "<td><button type='button' disabled class='btn btn-outline-secondary btn-rounded btn-icon' id='"+vOndyclProUsersVO.ondyclNo+"' onclick='proCancelClass(this)'><i class='mdi mdi-heart-broken'></i></button></td>";
					str += "</tr>";
					
				}
			
			});
			$("#myClassTbody").append(str);
			$("#keyword").val("");
			console.log("여기요 : ",res.data.pagingArea);
			$("#divPagingArea").html(res.data.pagingArea);
// 			sessionStorage.setItem("total",res.total);
			
			//차트 시작###########################################
			//google에서 기본 차트 관련된 package(모듈)명
			//chart 종류에 따라서 google 개발 문서 참조 필수
			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawChart);

			function drawChart() {
				//2차원 배열로 데이터 처리
				var data = google.visualization.arrayToDataTable([
					['Task', 'n명'],
					['1월', Number(monthUserMap.month1)],
					['2월', Number(monthUserMap.month2)],
					['3월', Number(monthUserMap.month3)],
					['4월', Number(monthUserMap.month4)]
				]);

			/* options 변수명은 다른 변수명으로 선언 및 사용 가능
			   title 속성 : 구글 차트에서 title로 사용되는 정보이기 때문에 속성명 수정 불가, 구글 차트가 제공하는 이름
			*/
				var options = {
					title: '',
					width: 500,
					height: 280
				};

				//어떤 위치에 chart를 표현할 것인지에 대한 html tag 정보 반영
				//<div id="piechart" style="width: 900px; height: 500px;"></div>
				var chart = new google.visualization.ColumnChart(document.getElementById('proChart'));
				
				//data와 option값을 적용하여 chart 그리기
				chart.draw(data, options);
			}

			//차트 끝###########################################
			
		}
	});
}
function proCancelClass(e){
 	console.log(e.id);
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
				url: "/onedayClass/deleteClass?classNo=" + e.id,
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
							window.history.back();
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


$(document).ready(function(){
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
			icon: 'warning',
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
		
// 		console.log(keyword + "/" + searchKeyword);
		let data = {
			"keyword":keyword,
			"currentPage":currentPage,
			"proId":userId,
			"searchKeyword":searchKeyword
		};
// 		console.log("data1:",data)
		pagingList(data);
	}
	
	let currentPage = "${param.currentPage}"
	if(currentPage == ""){
		currentPage = "1";
	}
	let data = {
		"keyword":"${param.keyword}",
		"currentPage":currentPage,
		"proId":userId,
		"searchKeyword":searchKeyword
	};
// 	console.log("data2: ",data);
	pagingList(data);
	
	$(".chartRadio").on("click",function(){
		if(this.value == 'monthUser'){
			console.log("월별 이용자");
			var data = google.visualization.arrayToDataTable([
				['Task', 'n명'],
				['1월', Number(monthUserMap.month1)],
				['2월', Number(monthUserMap.month2)],
				['3월', Number(monthUserMap.month3)],
				['4월', Number(monthUserMap.month4)]
			]);
			
			var options = {
				title: '',
				width: 500,
				height: 280
			};
			$("#proChart").html("");
			var chart = new google.visualization.ColumnChart(document.getElementById('proChart'));
			chart.draw(data, options);

		}else if(this.value == 'monthPrice'){
			console.log("월별 이용금액");
			var data = google.visualization.arrayToDataTable([
				['Task', 'n원'],
				['1월', Number(monthPriceMap.month1)],
				['2월', Number(monthPriceMap.month2)],
				['3월', Number(monthPriceMap.month3)],
				['4월', Number(monthPriceMap.month4)]
			]);
			
			var options = {
				title: '',
				width: 500,
				height: 280
			};
			$("#proChart").html("");
			var chart = new google.visualization.ColumnChart(document.getElementById('proChart'));
			chart.draw(data, options);
		}
	})
	
})

</script>
<div style="margin-left:150px;">
	<input type="hidden" id="sessionId" value="${proSession.userId}" />
		<div >
			<img alt="원데이클래스" src="../resources/images/클래스.png" style="width:100px; height:auto; margin:0 0 20px 550px;">
			<h2 id="ondayTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">${proSession.userNcnm}님의 원데이클래스</h2>
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
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px;
			 margin-bottom: 15px; padding-bottom: 0; margin-left: 92px;" >
<div class="col-12 grid-margin stretch-card" style="margin : 0 0 20px 0; padding : 0 0 25px 0;">
		<div class="innerDiv col-6">
			<div class="card" style="height: 420px;">
				<div class="card-body">
					<h4 class="card-title chartRadio">월별 이용자/금액 통계</h4>
					<input type='radio' name='chartRadio' class='chartRadio' id='monthUser' value='monthUser' checked><label for='monthUser'>월별 이용자</label>
					<input type='radio' name='chartRadio' class='chartRadio' id='monthPrice' value='monthPrice'><label for='monthPrice'>월별 금액</label>
					<div id="proChart" style="padding-left: 35px;"></div>
				</div>
			</div>
		</div>
		<div class="innerDiv col-6">
			<div class="grid">
				<div class="content-wrapper" style="background: white; padding: 10px 0 10px 0; margin-bottom: 15px; border-radius: 25px;">			
					<div class="g-col-6">
						<div class="card-body">
							<h3 class="card-title">전체 별점 통계</h3>
							<div class="row" id="starRate" style="padding-left:18px;">
								<!-- 별점 위치 -->
							</div>
						</div>
					</div>
				</div>
				
				<div class="content-wrapper" style="background: white; padding: 10px 0 10px 0; margin-bottom: 15px; border-radius: 25px;">
					<div class="g-col-6">
						<div class="card-body">
							<h3 class="card-title">통합 매출</h3>
							<div class="row" id="moneyRate" style="padding-left:18px;">
								<!-- 매출 위치 -->
							</div>
						</div>
					</div>
				</div>
				
				<div class="content-wrapper" style="background: white; padding: 10px 0 10px 0; margin-bottom: 15px; border-radius: 25px;">
					<div class="g-col-6">
						<div class="card-body">
							<h3 class="card-title">누적 이용자</h3>
							<div class="row" id="userRate" style="padding-left:18px;">
								<!--   누적 이용자 위치 -->
							</div>
						</div>
					</div>
				</div>
				
				
			</div>
		</div>
	</div>
</div>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px; margin-left: 92px;">	
<div class="col-12 grid-margin stretch-card" style="margin-bottom: 0">
	<input type="hidden" id="searchKeyword" value="title">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6" style="margin-top: 10px;">
						<h3>원데이클래스 생성내역</h3>
						<p class="font-weight-500 mb-0" style="color: red">※클래스 시작 3일전부터는 클래스를 취소할 수 없습니다.</p>
					</div>
					<div class="col-md-6 form-group text-center"> <!-- 중앙 정렬을 위해 text-center 클래스 추가 -->
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
</div>
