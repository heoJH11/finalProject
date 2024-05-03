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
	margin: 54px 0 -122px 506px;
	position : relative;
	z-index: 2;
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
	margin-left: 140px;
	/* Same width as the sidebar + left position in px */
	font-size: 10px; /* Increased text to enable scrolling */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 10px;
	}
}
</style>
<script>
$(document).ready(function() {
	
	/*  */
	console.log("자유게시판");
			
			let userId = `${proSession.userId}`;
			let currentPage = "${param.currentPage}";

		    if (currentPage == "") {
		        currentPage = "1";
		    }
		    let data = {
		    		"keyword": "${param.keyword}",
			        "currentPage": currentPage,
			        "userId": userId
			};
		    console.log("data : " , data);
		    
		    $.ajax({
				type:"post",		
				url:"/lbrtybbsctt/ajaxLbList",
				data:JSON.stringify(data),
				contentType:"application/json;chatset=utf-8",
				dataType:"json",
				success:function(res){
					$("#boardListTbody").html("");
					$("#lbsBody").html("");
					$("#divPagingArea").html("");
					console.log(res);
					if(res.total == 0){
						str += "<tr><td colspan='4'>작성한 글이 없습니다</td></tr>";
					}
					let str = "";
					$.each(res.content,function(idx,LbrtyBbscttVO2){
						//각 각 vo에 뭐가 들어있는지 체크
						console.log("LbrtyBbscttVO2["+idx+"] : ", LbrtyBbscttVO2)
						str+=`
							<tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=\${LbrtyBbscttVO2.lbrtyBbscttNo}'">
								<td>\${LbrtyBbscttVO2.rnum}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttSj}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttWrDt}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttRdcnt}</td>
							</tr> 
						`
						console.log("str : " + str)
					});
					
					$("#lbsBody").html("");
					$("#lbsBody").append(str);
					$("#keyword").val("");
					
					$("#boardListTbody").append(str);
					//페이징 처리
					if(res.total == 0){
						$("#divPagingArea").html("");						
					}else{
						$("#divPagingArea").html(res.pagingArea);
					}
				}
					
			});
	/*  */
    // 페이지가 로드될 때 실행되는 함수
    $(".date").each(function() {
        // 클래스가 'date'인 요소들에 대해 각각 실행
        var dateString = $(this).text(); // 요소의 텍스트 내용(날짜)을 가져옴
        var date = new Date(dateString); // 텍스트를 날짜 객체로 변환
        var formattedDate = formatDate(date); // 포맷된 날짜 문자열을 가져옴
        $(this).text(formattedDate); // 변환된 날짜를 요소에 다시 설정
    });
});

// 날짜를 "년.월.일" 형식으로 포맷하는 함수
function formatDate(date) {
    var year = date.getFullYear(); // 년도
    var month = date.getMonth() + 1; // 월 (0부터 시작하므로 1을 더함)
    var day = date.getDate(); // 일
    // 한 자리 숫자일 경우 앞에 0을 붙여 두 자리로 만듦
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;
    return year + '.' + month + '.' + day;
}


$(document).ready(function(){
	if('${proSession.userId}' == ""){
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
	// #################################게시글 출력########################################################
	// $("#boardListTbody").html(~) 148째 줄
	$("#boardSelect").on('change',function(){
		if($("#boardSelect").val() == 'lbrtybbsctt'){
			console.log("자유게시판");
			
			let userId = `${proSession.userId}`;
			let currentPage = "${param.currentPage}";

		    if (currentPage == "") {
		        currentPage = "1";
		    }
		    let data = {
		    		"keyword": "${param.keyword}",
			        "currentPage": currentPage,
			        "userId": userId
			};
		    console.log("data : " , data);
		    
		    $.ajax({
				type:"post",		
				url:"/lbrtybbsctt/ajaxLbList",
				data:JSON.stringify(data),
				contentType:"application/json;chatset=utf-8",
				dataType:"json",
				success:function(res){
					$("#boardListTbody").html("");
					$("#lbsBody").html("");
					$("#divPagingArea").html("");
					console.log(res);
					let str = "";
					if(res.total == 0){
						str += "<tr><td colspan='4'>작성한 글이 없습니다</td></tr>";
					}
					$.each(res.content,function(idx,LbrtyBbscttVO2){
						//각 각 vo에 뭐가 들어있는지 체크
						console.log("LbrtyBbscttVO2["+idx+"] : ", LbrtyBbscttVO2)
						str+=`
							<tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=\${LbrtyBbscttVO2.lbrtyBbscttNo}'">
								<td>\${LbrtyBbscttVO2.rnum}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttSj}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttWrDt}</td>
								<td>\${LbrtyBbscttVO2.lbrtyBbscttRdcnt}</td>
							</tr> 
						`
						console.log("str : " + str)
					});
					
					$("#lbsBody").html("");
					$("#lbsBody").append(str);
					$("#keyword").val("");
					
					$("#boardListTbody").append(str);
					//페이징 처리
					if(res.total == 0){
						$("#divPagingArea").html("");						
					}else{
						$("#divPagingArea").html(res.pagingArea);
					}
				}
					
			});
			
		}else if($("#boardSelect").val() == 'proHunting'){
			console.log("프로 구인 게시판");
			
		}else{
			console.log("프로 협업 게시판");
			let currentPage  = "${param.currentPage}";
			   console.log("currentPage",currentPage);
			   if(currentPage==""){
			      currentPage = 1;
			      
			   }
// 			   let proNcnm = "${proSession.userNcnm}";
// 			   console.log("proNcnm" +  proNcnm);
			   let data = {
			      "keyword":"${param.keyword}",
			      "currentPage":currentPage
			   };
			   console.log("data:",data);
			   
			   $.ajax({
			      url : "/proCprtnBbsctt/listAjax?currentPage="+currentPage,
			      type : "post",
			      data : JSON.stringify(data),
			      contentType: "application/json;charset=utf-8",
			      dataType:"json",
			      success : function(result){
			         console.log("result:",result);
			      
			         let str = "";
			         
			         $("#boardListTbody").html("");
			         $("#divPagingArea").html("");
					
			         if(result.total == 0){
							str += "<tr><td colspan='4'>작성한 글이 없습니다</td></tr>";
						}
			         $.each(result.content,function(idx, proCprtnBbscttVO){

		 	        	   str += "<tr onclick=\"location.href='/proCprtnBbsctt/detail?proCprtnBbscttNo=" + proCprtnBbscttVO.proCprtnBbscttNo + "'\" style=\"cursor: pointer;\">";
						   //str += "<tr>";
			               str += "<td>"+proCprtnBbscttVO.rnum+"</td>";		   
			               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttSj+"</td>";
// 			               str += "<td>"+proCprtnBbscttVO.proId+"</td>";
			               str += "<td>"+formatDate(new Date(proCprtnBbscttVO.proCprtnBbscttWrDt))+"</td>";
			               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttRdcnt+"</td>";
			               str += "</tr>";
			            
			            
			         });
			         $("#boardListTbody").append(str);
			         console.log(result.pagingArea);
			         if(result.total == 0){
							$("#divPagingArea").html("");						
						}else{
							$("#divPagingArea").html(res.pagingArea);
						}
			         
			         
			         sessionStorage.setItem("total",result.total);
			      }
			      
			   });
			
		}
	})
	// #################################게시글 출력########################################################
})
</script>
<div style="margin-left:150px;">
	<input type="hidden" id="sessionId" value="${proSession.userId}" />
			<div >
			<img alt="게시글 관리" src="../resources/images/문서.png" style="width:100px; height:auto; margin:0 0 20px 550px;">
			<h2 id="ondayTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">내가 쓴 게시글 관리</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 300px 0 300px;">
			<br>
			<p style="text-align:center; font-size: 17pt; top: 157px; font-family: seolleimcool-SemiBold;">
						${proSession.userNcnm}님이 작성한 글을 한 눈에 모아 볼 수 있어요!</p>
			<br><br>
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
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px; padding-bottom:5px; margin-left: 92px;">
<div class="col-lg-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
				<div class="col-md-12 text-center" style="margin-top: 10px;">
					<h3>보고싶은 게시판을 선택해주세요.</h3>
				</div>
				<div class="col-md-12 text-center">
					<select class="form-control" id="boardSelect"
						style="width: auto; border-radius: 15px; border: 0; outline: none; float:right; background-color: rgb(233, 233, 233); height: 44px; padding-left:11px;">
						<option value="lbrtybbsctt">자유게시판</option>
						<option value="proHunting">프로 구인 게시판</option>
						<option value="proCprtnBbsctt">프로 협업 게시판</option>
					</select>
				</div>
		</div>
		<div class="card">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th style="width: 5%">번호</th>
								<th>제목</th>
<!-- 							<th colspan="2" style="width: 15%">작성자</th> -->
								<th style="width: 15%">작성일</th>
								<th style="width: 10%">조회수</th>
							</tr>
						</thead>

						<tbody id="boardListTbody">
							<!-- 
								################### 게시글 위치 출력할 곳 ##########################
							 -->
						</tbody>

					</table>
				</div>
				<div id="divPagingArea" style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
			</div>
		</div>
	</div>
</div>
</div>
