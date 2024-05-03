<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<style>
 .card-body {
    margin-bottom: 20px; 
}
.card {
    margin-bottom: 20px; 
} 
.background-icon {
    margin-top: -20px; 
}

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


select , button , input{
	font-family: 'GmarketSansMedium';
}

th{
	font-family: 'GmarketSansMedium';
	font-size: 15px !important;
}
  

</style>
</head>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
//최대 길이 설정
const maxLength = 50;

function convertMngrId(mngrId) {
    return mngrId === 'testAdmin' ? '관리자' : mngrId;
}


function formatDate(dateString) {
   var options = { year: 'numeric', month: '2-digit', day: '2-digit' };
   return new Date(dateString).toLocaleDateString(undefined, options).replace(/\.$/, '');
	} 
 
$(function(){
	
	//1. notice의 btnSearch
   $("#btnSearch").on("click",function(){
      let keyword = $("#keyword").val();
      let searchKey = $("#search_key").val();
      
   // 검색어가 비어있는지 체크
      if (keyword.trim() === '') {
          Swal.fire({
              title: '검색어가 없습니다.',
              icon: 'warning',
				confirmButtonColor: '#7066e0',
              confirmButtonText: '확인'
          });
          return; // 검색어가 없으면 더 이상 실행하지 않음
      }
      
      console.log("keyword:"+keyword);
      
      let currentPage = "1";
      
      let data = {
         "keyword":keyword,
         "searchKey":searchKey,
         "currentPage":currentPage
         
      };
      console.log("data:"+data)
      
      $.ajax({
         url:"/admin/listAjax",
         contentType:"application/json;charset=utf-8",
         data:JSON.stringify(data),
         type:"post",
         dataType:"json",
         success:function(result){
            console.log("result:",result);
            
            let str = "";
            
            $("#noticeTbody").html("");
         
            $.each(result.content,function(idx, noticeVO){
            	// 공지사항 제목 자르기
                let trimmedNoticeSj = noticeVO.noticeSj;
                if (trimmedNoticeSj.length > maxLength) {
                    trimmedNoticeSj = trimmedNoticeSj.substring(0, maxLength) + "..."; // 최대 길이 초과 시 생략 부호 추가
                }
            	
               str += "<tr onclick=\"location.href='/admin/detail?noticeNo=" + noticeVO.noticeNo + "'\" style=\"cursor: pointer;\">";              
               str += "<td>"+noticeVO.rnum+"</td>";
               str += "<td>"+trimmedNoticeSj+"</td>";
               str += "<td>"+formatDate(noticeVO.noticeWritngDt)+"</td>";
               str += "<td>"+noticeVO.noticeRdcnt+"</td>";              
               str += "<td>"+convertMngrId(noticeVO.mngrId)+"</td>";
               str += "</tr>";
            
            });   
            
            $("#noticeTbody").append(str);
            $("#divPagingArea").html(result.pagingArea);
                     
         }
         
      });
      
   });//end btnSearch
	
	//최초 실행
   leftList(1,"","");
	
});//end 달러function
   
function leftList(currentPage, keyword, searchKey){
	//3. 왼쪽 목록 시작 ///////////////////////
	   //let currentPage  = "${param.currentPage}";
	   console.log("leftList->currentPage : " + currentPage);
	   if(currentPage==""){
	      currentPage = 1;
	      
	   }
	   
	   let data = {
	      "keyword":keyword,
	      "currentPage":currentPage,
	      "searchKey":searchKey
	   };
	   console.log("data:",data);
	   
	   $.ajax({
	      url : "/admin/listAjax?currentPage="+currentPage,
	      type : "post",
	      data : JSON.stringify(data),
	      contentType: "application/json;charset=utf-8",
	      dataType:"json",
	      success : function(result){
	         console.log("leftList->result:",result);
	      
	         let str = "";
	         
	         $("#noticeTbody").html("");
	         
	         $.each(result.content,function(idx, noticeVO){
	        	// 공지사항 제목 자르기
	             let trimmedNoticeSj = noticeVO.noticeSj;
	             if (trimmedNoticeSj.length > maxLength) {
	                 trimmedNoticeSj = trimmedNoticeSj.substring(0, maxLength) + "..."; // 최대 길이 초과 시 생략 부호 추가
	             }
	        	 
	            str += "<tr onclick=\"location.href='/admin/detail?noticeNo=" + noticeVO.noticeNo + "'\" style=\"cursor: pointer;\">";   
	            str += "<td>"+noticeVO.rnum+"</td>";
	            str += "<td>"+trimmedNoticeSj+"</td>";
	            str += "<td>"+formatDate(noticeVO.noticeWritngDt)+"</td>";
	            str += "<td>"+noticeVO.noticeRdcnt+"</td>";
	            str += "<td>"+convertMngrId(noticeVO.mngrId)+"</td>";
	            str += "</tr>";
	            
	            
	         });
	         $("#noticeTbody").append(str);
	         console.log(result.pagingArea);
	         $("#divPagingArea").html(result.pagingArea);
	         
	         
	         sessionStorage.setItem("total",result.total);
	      }
	   });
	   //3. 왼쪽 목록 끝 ///////////////////////
}

//////

  

</script>

<body>

		<!-- 제목 -->
		<div >
			<img alt="공지사항" src="../resources/images/확성기.png" style="width:100px; height:auto; margin:0 0 20px 630px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">공지사항</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>


<div class="col-lg-12 grid-margin stretch-card" style="margin:50px 0 300px 0;">
    <div class="card">
        <div class="card-body" style="font-family: 'GmarketSansMedium';">
            <div class="row">
                <div class="col-md-6"  style="margin-top: 10px;">
                    <h3 style="font-family: 'seolleimcool-SemiBold'; color:#a7a7a7;">⭐ 중요한 소식 놓치지 마세요!</h3>
                </div>
                
              

                <div class="col-md-6 form-group text-center"> <!-- 중앙 정렬을 위해 text-center 클래스 추가 -->
                    <div class="input-group">
                    
                          <select class="form-control col-md-3" id="search_key">									
									<option value="title">제목</option>
									<option value="detail">내용</option>
									
								</select>
								
                        <input type="text" name="keyword" id="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label="">
                        <div class="input-group-append">
                            <button class="btn btn-sm btn-primary" id="btnSearch" type="button">
                                검색 <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped text-center table-hover">
                    <thead>
                        <tr class="text-black">
                            <th style="width: 10%;">글번호</th>
							<th style="width: 50%;">공지사항제목</th>
							<th style="width: 10%;">작성일자</th>
							<th style="width: 10%;">조회수</th>
							<th style="width: 10%;">작성자</th>
                        </tr>
                    </thead>
                    <tbody id="noticeTbody">
                        <!-- 공지사항 내용이 표시되는 부분 -->
                    </tbody>
                </table>
            </div>
            <div class="" style="margin-top: 20px;">
            <br>
                <div id="divPagingArea" style="margin-left:600px;"></div>
            </div>
        </div>
    </div>
</div>
	




	<!-- <button type="button" id="insert" class="btn btn-primary">글쓰기</button> -->
<!-- <a href="/admin/create?register" class="btn btn-primary">글쓰기</a> -->
<%-- <c:if test="${not empty sessionScope.admSession}"> --%>
<!--     <a href="/admin/create?register" class="btn btn-primary">글쓰기</a> -->
<%-- </c:if> --%>
</body>
</html>