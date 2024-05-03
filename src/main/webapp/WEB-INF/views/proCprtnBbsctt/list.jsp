<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
td.user-info {
  text-align: left;
}

.bodyTop{
	margin-top:50px;
	position : relative;
	z-index: 3;
}

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
}
a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'Recipekorea';
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
*{
	font-family: 'GmarketSansLight';
}

img{
	margin-right : 10px;
}

</style>
<script type="text/javascript">


$(document).ready(function() {
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


$(function(){
	
	   $("#btnSearch").on("click",function(){
		      let keyword = $("input[name='keyword']").val();
		      
		      console.log("keyword:"+keyword);
		      
		      let currentPage = "1";
		      
		      let data = {
		         "keyword":keyword,
		         "currentPage":currentPage
		      };
		      console.log("data:"+data)
		      
		      $.ajax({
		         url:"/proCprtnBbsctt/listAjax",
		         contentType:"application/json;charset=utf-8",
		         data:JSON.stringify(data),
		         type:"post",
		         dataType:"json",
		         success:function(result){
		            console.log("result:",result);
		            
		            let str = "";
		            
		            $("#proCprtnBbscttTbody").html("");
		         
		            $.each(result.content,function(idx, proCprtnBbscttVO){
 		               str += "<tr onclick=\"location.href='/proCprtnBbsctt/detail?proCprtnBbscttNo=" + proCprtnBbscttVO.proCprtnBbscttNo + "'\" style=\"cursor: pointer;\">";
		               //str += "<tr>";
		               str += "<td>"+proCprtnBbscttVO.rnum+"</td>";		   
		               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttSj+"</td>";
		               str += "<td>"+proCprtnBbscttVO.userNcnm+"</td>";		            
// 		               str += "<td class='user-info'>";
// 		               if (proCprtnBbscttVO.proProflPhoto == null || proCprtnBbscttVO.proProflPhoto == "") {
// 		                   str += "<img src='/images/2024/profile.jpg'>" + proCprtnBbscttVO.userNcnm + "</td>";
// 		               } else {
// 		                   str += "<img src='" + proCprtnBbscttVO.proProflPhoto + "'>" + proCprtnBbscttVO.userNcnm + "</td>";
// 		               }
		               str += "<td>"+formatDate(new Date(proCprtnBbscttVO.proCprtnBbscttWrDt))+"</td>";
		               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttRdcnt+"</td>";
		               str += "</tr>";
		            
		            });   
		            
		            $("#proCprtnBbscttTbody").append(str);
		            if(result.total == 0){
			            $("#divPaging").html("");
		            }else{
			            $("#divPaging").html(result.pagingArea);
		            }
		         }
		         
		      });
		      
		   });
	
	   let currentPage  = "${param.currentPage}";
	   console.log("currentPage",currentPage);
	   if(currentPage==""){
	      currentPage = 1;
	      
	   }
	   
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
	         
	         $("#proCprtnBbscttTbody").html("");
	         
	         $.each(result.content,function(idx, proCprtnBbscttVO){

 	        	   str += "<tr onclick=\"location.href='/proCprtnBbsctt/detail?proCprtnBbscttNo=" + proCprtnBbscttVO.proCprtnBbscttNo + "'\" style=\"cursor: pointer;\">";
				   //str += "<tr>";
	               str += "<td>"+proCprtnBbscttVO.rnum+"</td>";		   
	               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttSj+"</td>";
	               str += "<td>"+proCprtnBbscttVO.userNcnm+"</td>";
// 	               str += "<td class='user-info'>";
// 	               if (proCprtnBbscttVO.proProflPhoto == null || proCprtnBbscttVO.proProflPhoto == "") {
// 	                   str += "<img src='/images/2024/profile.jpg'>" + proCprtnBbscttVO.userNcnm + "</td>";
// 	               } else {
// 	                   str += "<img src='" + proCprtnBbscttVO.proProflPhoto + "'>" + proCprtnBbscttVO.userNcnm + "</td>";
// 	               }
	               str += "<td>"+formatDate(new Date(proCprtnBbscttVO.proCprtnBbscttWrDt))+"</td>";
	               str += "<td>"+proCprtnBbscttVO.proCprtnBbscttRdcnt+"</td>";
	               str += "</tr>";
	            
	            
	         });
	         $("#proCprtnBbscttTbody").append(str);
	         console.log(result.pagingArea);
	         $("#divPaging").html(result.pagingArea);
	         
	         
	         sessionStorage.setItem("total",result.total);
	      }
	      
	   });
	   
	   
	   
});



</script>
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card">
		<!-- 제목 -->
		<div >
			<img alt="협업" src="../resources/images/게협업2.png" style="width:90px; height:auto; margin:0 0 20px 600px;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 협업 게시판</h2>
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
<div class="col-md-6 form-group text-center" style="display: none;">
	<div class="input-group">
		<input type="text" name="keyword" id="keyword"
			value="${param.keyword}" class="form-control"
			placeholder="검색어를 입력하세요" aria-label="">
		<div class="input-group-append">
			<button class="btn btn-sm btn-primary" id="btnSearch" type="button">
				Search <i class="fas fa-search"></i>
			</button>
		</div>
	</div>
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
			<div class="table-responsive" style="margin-top: 45px;">
				<table class="table table-striped text-center table-hover">
					<thead>
						<tr class="text-black">
							<th style="width:5%">번호</th>
							<th>제목</th>
							<th style="width:15%">작성자</th>
							<th style="width:15%">작성일</th>
							<th style="width:10%">조회수</th>
						</tr>
					</thead>
					<tbody id="proCprtnBbscttTbody"></tbody>
				</table>
			</div>			
			<div id="divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
		</div>
	</div>
</div>
</div>
<!-- <a href="/proCprtnBbsctt/create" class="btn btn-inverse-primary btn-fw">글쓰기</a> -->
