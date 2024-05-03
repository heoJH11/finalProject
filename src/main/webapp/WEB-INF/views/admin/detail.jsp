<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<title>공지상세보기</title>


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

.card-body {
    margin-bottom: 20px; 
}
.card {
    margin-bottom: 20px; 
}
.background-icon {
    margin-top: -20px; 
}
</style>

</head>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> 
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" /> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script type="text/javascript">

$(function(){

 	
    console.log("정상실행");
    
    $("#list").on("click",function(){
        location.href="/manage/notice";
    });
    
//     $("#list2").on("click", function() {
//         // 만약 admSession이 존재하면 /manage/notice로 이동
//         if (${not empty admSession}) {
//             location.href = "/manage/notice";
//         } else {
//             // 만약 admSession이 없으면 /admin/notice로 이동
//             location.href = "/admin/notice";
//         }
//     });
    $("#list2").on("click", function() {

            location.href = "/admin/notice";
     
    });
    
/*     $("#delete").on("click",function(){
        console.log("정상실행3")
       
        //id속성의 값이 noticeNo인 요소의 벨류값
        //let noticeNo = $("#noticeNo").val();
          //요청 파라미터의 noticeNo이름의 벨류값
        let noticeNo = "${param.noticeNo}";
//        let noticeNo = $(this).data("delete");
        let data = {
           "noticeNo":noticeNo
        };
        console.log("data", data);
        
        $.ajax({
           url:"/admin/delete",
           contentType:"application/json;charset=utf-8",
           data:JSON.stringify(data),
           type:"post",
           dataType:"text",
           success:function(result){
              console.log("result:",result);
              location.href="/admin/notice";
           }
        });
     }); */
     
    $(document).ready(function(){
    	$(document).on("click", '#delete', function () {
    		console.log("정상실행 notice삭제");
            
            Swal.fire({
                title: '정말 삭제 하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
                confirmButtonText: '확인',
                cancelButtonText: '취소',
                reverseButtons: false,
            }).then((result) => {
  				
            	if (result.isConfirmed) {
                    let noticeNo = "${param.noticeNo}";
                    let data = {
                        "noticeNo": noticeNo
                    };
                    console.log("data", data);

                    $.ajax({
                        url: "/admin/delete",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "text",
                        success: function (result) {
                            console.log("result:", result);
                            Swal.fire({
                                title: '삭제가 완료 됐습니다.',
                                icon: 'success',
                				confirmButtonColor: '#7066e0',
                                confirmButtonText: '확인',
                            }).then(() => {
                                // 삭제가 완료되면 공지사항 목록 페이지로 이동합니다.
                                location.href = "/manage/notice";
                            });
                            $("#div"+noticeNo).remove();                            
                        }
                    });
                }//end if
            });
    	});
    }); 
    
    $('#edit').on("click",function(){
        console.log("정상실행2")
        $("#p1").hide();

        // 공지사항 내용을 수정할 수 있는 입력 필드로 변경
        let noticeCnEdit = $("#noticeCn");
        let noticeSjEdit = $("#noticeSj");

        noticeCnEdit.attr("contenteditable", "true"); // 수정 가능하도록 설정
        noticeCnEdit.focus(); // 입력 필드에 포커스를 줌
      
        noticeSjEdit.attr("contenteditable", "true");
        noticeSjEdit.focus();
        
        // 수정 완료 후 확인 버튼 활성화
        $("#p2").show();
    });
   
    $('#cancel').on("click",function(){
       $("#p1").show();
       $("#p2").hide();
    });
    

    $('#confirm').on("click",function(){
        console.log("수정 내용 확인");

        let noticeNo = "${param.noticeNo}";
        let noticeCnNew = $("#noticeCn").text();
        // 수정이 완료된 내용을 가져옴
        let noticeSjNew = $("#noticeSj").text();
        
   
        
        // 수정된 내용을 전송
        $.ajax({
            url:"/admin/update",
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({"noticeSj":noticeSjNew, "noticeCn": noticeCnNew,"noticeNo":noticeNo}),
            type:"post",
            dataType:"text",
            success:function(result){
                console.log("result: " + result);
                
                
              
                // 수정 완료 후 다시 읽기 전용으로 변경
                let noticeCnEdit = $("#noticeCn");
                noticeCnEdit.attr("contenteditable", "false"); // 수정 불가능하도록 설정
           
                let noticeSjEdit = $("#noticeSj");
                noticeSjEdit.attr("contenteditable", "false");
                
                
                
                // 확인 버튼을 다시 감춤
                $("#p2").hide();
                $("#p1").show();
                                         
                }
                
                
          
        });
        
    });
    $(document).on("click",'#confirm',function(){
 	   Swal.fire({
 	        title: '수정이 완료 됐습니다.',
 	        icon: 'success',
			confirmButtonColor: '#7066e0',
 	        confirmButtonText: '확인',
 	    }).then((result) => {
 	        if (result.isConfirmed) {
 	   			/* location.href="/manage/notice" */
 	        }
 	    });
 	   
    });   
    
  });
    

</script>
<body>
<%-- <a>${sprviseAtchmnflVOList}</a> --%>


  	<!-- 제목 -->
  		<div id="title">
			<img alt="공지사항" src="../resources/images/확성기.png" style="width:100px; height:auto; margin:0 0 20px 630px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">공지사항</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
                <br>
                
                
                
                
                
                
                
 <blockquote class="content-wrapper" >                          
<div class="row">                         
<div class="col-md-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body" style="font-family: 'GmarketSansMedium';">
                  <div class="row align-items-center"> 
                <div class="col-md-6">
                    <h1 class="card-title" id="noticeSj" contenteditable="false"> ${noticeVO.noticeSj}</h1>
                </div>
                <div class="col-md-6 text-right" style="font-family: 'GmarketSansMedium'; margin-top: -20px;"> 
                     <h5><fmt:formatDate value="${noticeVO.noticeWritngDt}" pattern="yyyy.MM.dd" /> </h5>

                </div>
              </div>
               </div>
                
                <div class="card-body"  style="font-family: 'GmarketSansMedium'; margin-top: -50px;">
                  <blockquote>  
                       
                    <div>              
                     <p><b>공지내용</b></p>
                     <blockquote class="blockquote">
                     
                    <p class="mb-0" id="noticeCn" contenteditable="false">${noticeVO.noticeCn}</p>
                  	 
                  </blockquote>             
                    </div>              
                                    
                   <p><b>조회수 : ${noticeVO.noticeRdcnt}</b></p>
                   <!-- sprviseAtchmnflVOList : noticeVO -->
<%--               <p><b>첨부파일 : ${sprviseAtchmnflVOList.spAtVOList}</b></p> --%>
                   <div class="form-group">
                    <c:forEach var="sprviseAtchmnflVO" items="${sprviseAtchmnflVOList.spAtVOList}" varStatus="stat">						
<%-- 						<label for="Images" id="Images">${sprviseAtchmnflVO.atchmnflNm}</label> --%>
<%-- 						<p><b>첨부파일 : ${sprviseAtchmnflVO.atchmnflNm}</b></p> --%>
						<p><a href="${sprviseAtchmnflVO.atchmnflCours}" download="${sprviseAtchmnflVO.atchmnflNm}">첨부파일 :${sprviseAtchmnflVO.atchmnflNm}</a></p>
<%-- 						<img src='${sprviseAtchmnflVO.atchmnflCours}' width="720" height="405" /> --%>
<%--  						<img src='${sprviseAtchmnflVO.atchmnflCours}' />			 --%>
					</c:forEach>
					
					
				   </div>
                 
                  
                    <div class="col-md-12 text-right" style="margin-top: -20px;"> <!-- 오른쪽으로 정렬하기 위한 클래스 추가 -->
                    <i class="mdi mdi-account-circle">${noticeVO.mngrId == 'testAdmin' ? '관리자' : noticeVO.mngrId}</i>
                </div>
                    
                    
                  </blockquote>
                </div>
              </div>
            </div>                          
        </div>                          
		<div>
    
    

<!--     <p id="p1"> -->
<!--         <button type="button" id="edit" class="btn btn-primary">수정</button> -->
<!--         <button type="button" id="delete" class="btn btn-danger">삭제</button> -->
<!--         <button type="button" id="list" class="btn btn-secondary">목록</button> -->
<!--     </p> -->
<%--     <c:if test="${not empty sessionScope.admSession}"> --%>
<!--     <p id="p1"> -->
<!--         <button type="button" id="edit" class="btn btn-primary">수정</button> -->
<!--         <button type="button" id="delete" class="btn btn-danger">삭제</button> -->
<!--         <button type="button" id="list" class="btn btn-secondary">목록</button> -->
<!--     </p> -->
<%-- 	</c:if> --%>
	
<%-- 		<c:if test="${empty sessionScope.admSession}"> --%>
    	<button type="button" id="list2" class="btn btn-primary">목록</button>
<%--     	</c:if> --%>
    
<!--     <p id="p2" style="display:none;"> -->
<!--         <button type="button" id="confirm" class="btn btn-primary">확인</button> -->
<!--         <button type="button" id="cancel" class="btn btn-secondary">취소</button> -->
<!--     </p> -->
</div>	
			
      </blockquote>                        






</body>
</html>