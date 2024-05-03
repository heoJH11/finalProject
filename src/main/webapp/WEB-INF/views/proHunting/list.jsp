<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="/resources/js/jquery.min.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'GmarketSansLight';
}
a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'GmarketSansLight';
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


.bodyTop{
	margin-top:50px;
	position : relative;
	z-index: 3;
}
</style>	
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card">
		<!-- 제목 -->
		<div >
			<img alt="구인" src="../resources/images/구인.png" style="width:100px; height:auto; margin:0 0 20px 600px;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 구인 게시판</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
		</div>
	</div>
</div>
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
<div class="bodyTop">
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
				<div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton3"
					style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 31px, 0px);"
					x-placement="bottom-start">
					<p class="dropdown-item">전체</p>
					<p class="dropdown-item">작성자</p>
					<p class="dropdown-item">제목</p>
				</div>
			</div>
			<div>
				<button type="button" class="btn btn-inverse-primary btn-sm" id="wrtBtn" style="float:right; display: none; margin-top: 2px; margin-right: 5px;">글쓰기</button>
			</div>
			<div class="table-responsive" style="margin-top: 45px;">
				<table class="table table-striped text-center" id="proHuntingListTb" style="font-family: 'GmarketSansLight';">
					<thead>
						<tr>
							<th style="width: 5%; font-family: 'GmarketSansLight';">번호</th>
							<th>제목</th>
							<th style="width: 15%; font-family: 'GmarketSansLight';">작성자</th>
							<th style="width: 15%; font-family: 'GmarketSansLight';">작성일</th>
							<th style="width: 10%; font-family: 'GmarketSansLight';">조회수</th>
						</tr>
					</thead>
					<tbody id= "proHuntingListBody">
					</tbody>
				</table>
			</div>
			<div id="divPaging"
						style="position: relative; margin-left: 42%; margin-top: 20px;"></div>
		</div>
	</div>
</div>
</div>
<script>
var memSession = "${memSession.userId}";
if(memSession != ""){
	$("#wrtBtn").css("display", "block");
}

$(function(){
	$(".dropdown-item").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
    });
	
    // 전체 목록 출력
    let currentPage = "${param.currentPage}";
    if(currentPage == ""){
    	currentPage = "1";
    }
    
    let data = {
    		"keyword" : "${param.keyword}",
			"currentPage" : currentPage
    }
    
    $.ajax({
    	url : "/proHunting/listAjax?currentPage="+currentPage+"&keyword=${param.keyword}",
    	contentType : "application/json; charset=utf-8",
 	    data : JSON.stringify(data),
 	    type : "post",
 	    dataType : "json",
 	    success : function(res){
			console.log("구인게시판리스트 res : " , res);
			$("#proHuntingListBody").html("");
			$("#divPaging").html("");
			var str = "";
			$.each(res.content, function(i, v){
				str += "<tr onclick=\"location.href='/proHunting/detail?proJoBbscttNo=" + v.proJoBbscttNo + "'\" data-no='"+v.proJoBbscttNo+"'>";
				str += "<td>" + v.num + "</td>";
				str += "<td>" + v.proJoBbscttSj + "</td>";
				str += "<td>" + v.mberVOList[0].userNcnm + "</td>";
				str += "<td>" + (v.proJoBbscttWrDt).substr(0, 10) + "</td>";
				str += "<td>" + v.proJoBbscttRdcnt + "</td>";
				str += "</tr>";

			});//each 끝
			$("#proHuntingListBody").html(str);
			if(res.total == 0){
				//페이징 처리
				$("#divPaging").html("");
			}else{
				$("#divPaging").html(res.pagingArea);
			}
 	    }// success 종료
 	});//ajax 끝 
 	
 	// 검색
	$("#searchBtn").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		
		if (keyword.trim() === '') {
	          Swal.fire({
	              title: '검색어가 없습니다.',
	              icon: 'warning',
	              confirmButtonText: '확인'
	          });
	          return; // 검색어가 없으면 더 이상 실행하지 않음
	      }
		
		// 검색 카테고리 설정
		let selectColumn = $("#dropdownMenuSizeButton3").text();
		let t_selectColumn = "";
		if(selectColumn == "작성자" ){
			selectColumn = "A.USER_NCNM";
			t_selectColumn = "USER_NCNM";
		}else if(selectColumn == "제목"){
			selectColumn = "A.PRO_JO_BBSCTT_SJ";
			t_selectColumn = "PRO_JO_BBSCTT_SJ";
		}else if(selectColumn == "전체"){
			selectColumn = "ALL";
			t_selectColumn = "ALL";
		}

		let currentPage = "1";
		
		var data = {
				"keyword" : keyword,
				"selectColumn" : selectColumn,
				"t_selectColumn" : t_selectColumn,
				"currentPage" : currentPage
					};
		$.ajax({
	        url : "/proHunting/listAjax",
	        contentType : "application/json; charset=utf-8",
	        data : JSON.stringify(data),
	        type : "post",
	        dataType : "json",
	        success: function(res){
	        	console.log("구인게시판리스트 res : " , res);
				$("#proHuntingListBody").html("");
				$("#divPaging").html("");
				var str = "";
				$.each(res.content, function(i, v){
					str += "<tr onclick='location.href='/proHunting/detail?"+v.proJoBbscttNo+"'>";
					str += "<td>"+v.proJoBbscttSj+"</td>";
					str += "<td>"+v.mberVOList[0].userNcnm+"</td>";
					str += "<td>"+(v.proJoBbscttWrDt).substr(0,10)+"</td>";
					str += "<td>"+v.proJoBbscttRdcnt+"</td>";
					str += "</tr>";
				});//each 끝
				history.pushState(null, null, "listAjax?currentPage="+currentPage+"&keyword="+keyword);
				$("#proHuntingListBody").html(str);
				if(res.total > 0){
	 	    	$("#divPaging").html(res.pagingArea);
				}else{
	 	    	$("#divPaging").html("");
				}
	 	    }// success 종료
	 	});//ajax 끝 
	});
	 	
 	
 	// 조회수
 	$("#proHuntingListTb").on("click","tr", function(e){
		var proJoBbscttNo = $(this).data("no");
		console.log("행 클릭 : " , proJoBbscttNo);
		var data = {"proJoBbscttNo" : proJoBbscttNo};
		
		$.ajax({
			url : "/proHunting/rdCntUpdt",
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			type : "post",
			success : function(res){
			}
		});
 	});
});
</script>