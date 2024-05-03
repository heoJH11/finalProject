<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
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

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'seolleimcool-SemiBold';
}
a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'Recipekorea';
}

tbody {
	cursor: pointer;
}

/* 네비게이션 메뉴 */
.sidenav {
  width: 200px;
  position: fixed;
  z-index: 1;
  font-size: 18px;
  top: 153px;
  left: 45px;
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

p, th, td, a{
	font-family: 'GmarketSansMedium';
}



.bodyTop{
	margin-top:50px;
	position : relative;
	z-index: 3;
}
</style>

<script type="text/javascript">
function detailBtn(no){
	console.log("원클릭 이벤트를 2개 주고싶다");
	console.log("no : ", no);
	
	let data={
		"lbrtyBbscttNo":no		
	}
	console.log("data = ",data)
	$.ajax({
		type:"get",
		url:"/lbrtybbsctt/cntUp",
		data:data,
		dataType:"text",
		success:function(res){
			console.log("조회수 : " + res);
		}
	});
	
	location.href="/lbrtybbsctt/detail?lbrtyBbscttNo="+no
}
function ajaxList(data){
	
	$.ajax({
		type:"post",		
		url:"/lbrtybbsctt/ajaxLbList",
		data:JSON.stringify(data),
		contentType:"application/json;chatset=utf-8",
		dataType:"json",
		success:function(res){
			console.log(res);
			let total = res.total;
			console.log("res.total : ",res.total);
			let str = "";
			$.each(res.content,function(idx,LbrtyBbscttVO2){
				//각 각 vo에 뭐가 들어있는지 체크
				//console.log("LbrtyBbscttVO2["+idx+"] : ", LbrtyBbscttVO2)
				str+=`
					<tr onclick="detailBtn(\${LbrtyBbscttVO2.lbrtyBbscttNo})",onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=\${LbrtyBbscttVO2.lbrtyBbscttNo}'">
						<td>\${LbrtyBbscttVO2.rnum}</td>
						<td colspan="2">\${LbrtyBbscttVO2.lbrtyBbscttSj}</td>
						<td style='text-align:center; padding-left:0;'>\${LbrtyBbscttVO2.userNcnm}</td>
						<td>\${LbrtyBbscttVO2.lbrtyBbscttWrDt}</td>
						<td>\${LbrtyBbscttVO2.lbrtyBbscttRdcnt}</td>
					</tr> 
					`
					total--
				//console.log("str : " + str)
			});
			$("#lbsBody").append(str);
			$("#rvBrdBody").append(str);
			$("#keyword").val("");
			
			if(res.total == 0){
				//페이징 처리
				$("#divPagingArea").html("");
			}else{
				$("#divPagingArea").html(res.pagingArea);
			}
		}
			
	});
}
$(function(){
	var userId = '${proSession.userId}';
	var userId2 = '${memSession.userId}';
	console.log("userId : " + userId);
	console.log("userId2 : " + userId2);
	if(userId=="" && userId2=="" ){
		console.log("세션 아이디가 없는디");
		$("#wriBtn").hide();
	}else{
		$("#wriBtn").show();
	}
	
	
	//검색어 카테고리 이름 가져오기
	$(".one").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
    });
	
	$("#btnSearch").on("click",function(){
		let currentPage = "1";
		$("#lbsBody").html("");
		//console.log("keyword : " + $("#keyword").val());
		let keword = $("#keyword").val();
		
		let data = {
			"currentPage":currentPage,
			"keyword":keword
		}
		//console.log("data : " , data)
		ajaxList(data);
		
	});
	
	
	$("#insertBt").on("click",function(){
		console.log("클릭 했습니다.");
		
	})
	
	// 전체 목록 출력
	let currentPage = "${param.currentPage}"
	if(currentPage == ""){
		currentPage = "1";
	}
	
	let data = {
			"keyword":"${param.keyword}",
			"currentPage":currentPage
		}
	//console.log("data : " + data);
	ajaxList(data)
});

</script>
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card">
		<!-- 제목 -->
		<div >
			<img alt="자유" src="../resources/images/게자유.png" style="width:100px; height:auto; margin:0 0 20px 600px;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">자유게시판</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
		</div>
	</div>
</div>
<div class="bodyTop">
<div class="sidenav">
   <p style="text-align: center;">
      <b style="font-family: GmarketSansMedium;">BOARD MENU</b>
   </p>
   <hr>
   <a href="/lbrtybbsctt/read2">자유 게시판</a> 
   <a href="/reviewBoard/main">후기 게시판</a>
   <a href="/proHunting/list">프로 구인 게시판</a> 
   <a href="/proCprtnBbsctt/list">프로 협업 게시판</a>
</div>
<div class="col-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<div class="dropdown show"
				style="float: right; margin-right: 0">
				<button class="btn btn-inverse-primary btn-sm dropdown-toggle"
					type="button" id="dropdownMenuSizeButton3" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="true">선택</button>
				<input type="text" name="keyword" id="keyword"
					style="width: auto; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left:11px;" />
				<button type="button" class="btn btn-inverse-primary btn-sm"
					id="searchBtn">
					<i class="mdi mdi-yeast"></i>
				</button>
				<div class="dropdown-menu" id="search_key" aria-labelledby="dropdownMenuSizeButton3" style="">
					<p class="dropdown-item one">제목</p>
					<p class="dropdown-item one">작성자</p>
				</div>
			</div>
			<div>
				<button type="button" class="btn btn-inverse-primary btn-sm" id="wriBtn" 
					style="float:right; display: none; margin-top: 2px; margin-right: 5px;" onClick="location.href='/lbrtybbsctt/insert'">글쓰기</button>
			</div>
		</div>		
		<div class="table-responsive">
			<table class="table table-striped text-center">
				<thead>
					<tr>
						<th style="width: 5%; font-size: 15px;">번호</th>
						<th style="font-size: 15px;">제목</th>
						<th colspan="2" style="width: 15%; font-size: 15px;">작성자</th>
						<th style="width: 15%; font-size: 15px;">작성일</th>
						<th style="width: 10%; font-size: 15px;">조회수</th>
					</tr>
					</thead>
					<tbody id="rvBrdBody">
				</table>
			</div>
			<div id="divPagingArea"
					style="position: relative; margin-left: 48%; margin-top: 20px;">
			</div>
		</div>
	</div>
	</div>
<!-- 주누 참고 리스트 끝 -->
	<!-- <button type="button" id="insert" class="btn btn-primary">글쓰기</button> -->
	<!-- <a href="/admin/create?register" class="btn btn-primary">글쓰기</a> -->
</html>
