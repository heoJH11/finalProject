<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title></title>

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
.accordion-button {
    cursor: pointer;
}
.accordion-content {
    display: none;
}

.background-icon {
    margin-top: -20px; 
}





</style>
</head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> 
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" /> -->
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript">


$(function(){
	if($("#adminId").val() == ""){
		Swal.fire({
			    title: '관리자만 들어갈  수 있습니다.',
			    icon: 'error',
			    showCancelButton: false,
			    confirmButtonColor: '#7066e0',
			    confirmButtonText: '확인',
		    }).then((result) => {
		    	location.href="/main"
		    })
	}
	
    $('.accordion-button').click(function(){
        $(this).next('.accordion-content').slideToggle();
    });
    $('#update').on("click", function(){
    	$(".p1").show();
    	$("#update").hide();
    	$("#cancel").show();
    });
	
     $(document).ready(function(){
    	$(document).on("click", '#delete', function () {
    		console.log("정상실행 faq삭제");
            
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
                    let faqNo = $(this).data("delete");
                    let data = {
                        "faqNo": faqNo
                    };
                    console.log("data", data);

                    $.ajax({
                        url: "/faq/delete",
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
                            
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    // 삭제 후에 페이지를 갱신하여 삭제된 항목이 보이지 않도록 함
                                    window.location.href = "/manage/faq";
                                }
                            
                            });
                            
                            $("#div"+faqNo).remove();                        
                        }
                    });
                }//end if
            });
    	});
    }); 
     
    $(document).on("click",'#edit', function(){
        $(this).closest(".card-body").find(".p1").hide();
        $(this).closest(".card-body").find(".p2").show();
        
        let faqQestnEdit = $(this).closest(".card-body").find("#faqQestn");
        let faqAnswerEdit = $(this).closest(".card-body").find("#faqAnswer");
        
        faqQestnEdit.attr("contenteditable", "true");
        faqQestnEdit.focus();

        faqAnswerEdit.attr("contenteditable", "true");
        faqAnswerEdit.focus();
        
    });
     
	
    $(document).on("click",'#confirm',function(){
    	var thisConfirm = $(this);
    	console.log("수정내용확인");
    	console.log("수정내용확인"+$(this).data("confirm"));
    	
    	console.log("aa",$(this).closest(".card").find(".aa").text());
    	console.log("bb",$(this).closest(".card").find(".bb").text());
    	let faqNo = $(this).data("confirm");
    	let faqQestnNew = $(this).closest(".card").find(".aa").text();
    	let faqAnswerNew =$(this).closest(".card").find(".bb").text();
    	
    	console.log("faqQestnNew",$(this));
    	console.log("faqAnswerNew",$(".bb",this));
    	
    	$.ajax({
    		url:"/faq/update",
    		contentType:"application/json;charset=utf-8",
    		data:JSON.stringify({"faqAnswer":faqAnswerNew,"faqQestn": faqQestnNew,"faqNo":faqNo}),
    		type:"post",
    		dataType:"text",
    		success:function(result){
    			console.log("result"+result);
    			
    			let faqQestnEdit = $(".aa");
    			faqQestnEdit.attr("contenteditable","fasle");

    			let faqAnswerEdit = $(".bb");
    			faqAnswerEdit.attr("contenteditable","fasle");
    			
    			thisConfirm.closest(".card-body").find(".p2").hide();
    		
    			console.log("수정내용확인123123");
    			thisConfirm.closest(".card-body").find(".p3").show();
    			 
    		}
    		
    	});
    	
    	
    });
   $(document).on("click",'.p3',function(){
	   Swal.fire({
	        title: '수정이 완료 됐습니다.',
	        icon: 'success',
	        confirmButtonColor: '#3085d6',
	        confirmButtonText: '확인',
	    }).then((result) => {
	        if (result.isConfirmed) {
	   		location.href="/manage/faq";
	        }
	    });
	   
   });
    $(document).on("click",'#cancel',function(){
	   location.href="/manage/faq";
   }); 
   	
});

</script>

<body>
<input type="hidden" id="adminId" value="${admSession.userId}">
<!-- <div class="col-md-12 stretch-card grid-margin grid-margin-md-0"> -->
<!--                   <div class="card data-icon-card-primary"> -->
<!--                     <div class="card-body"> -->
<!--                        <p class="card-title text-white"> </p>                        -->
<!--                       <div class="row"> -->
<!--                         <div class="col-8 text-white"> -->
<!--                           <h3 class="tex-center">관리자 페이지</h3>  -->
<!--                           <p class="text-white font-weight-500 mb-0">This is the management page.</p> -->
<!--                         </div> -->
<!--                         <div class="col-4 background-icon"> -->
<!--                         </div> -->
  
<!--                       </div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div>   -->			
 <div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div >
		<div class="">
		<!-- 제목 -->
		<div >
			<img alt="faq" src="../resources/images/궁금2.png" style="width:100px; height:auto; margin:0 0 20px 730px;">
			<h2 id="faqTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">FAQ</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
			<br><br>
		</div>
		</div>
	</div>
</div>	
 	
 	
 				
<div class="row">

    
   	
<!--    	<div class="col-md-6 grid-margin grid-margin-md-0 stretch-card mb-3" id="div6" style="height: fit-content;"> -->
            
<!--               <div class="faq-block card-body"> -->
<!--               <div class="accordion"> -->
<!--               <div class="card" style="margin-bottom: -50px; width:90%; "> -->
<!--                 <div style="padding:30px; "> -->
                   
                            
                       
                                              
                                    
                                            
         
                                        
                                        
        
   
    <div class="col-lg-6">
        <div class="card">
            <div class="card-body" style="font-family: 'GmarketSansMedium';">
                <div class="row">
                    <div class="col-md-6" style="margin-top: 10px;">
                        <h3>📋 FAQ 목록</h3>
                    </div>
                    <c:forEach items="${faqList}" var="faq" varStatus="loop">
                    <div class="col-md-12 grid-margin grid-margin-md-0 stretch-card mb-3" id="div${faq.faqNo}" style="height: fit-content;">
                        <div class="faq-block card-body">
                        <div class="accordion">
                        <div class="card" style="margin-bottom: -50px">
                            <div class="card-body">
                                <blockquote style="margin:50px 20px 0 20px;">
                                    <p id="faqQestn" contenteditable="false" class="card-title aa mdi mdi-face"> ${faq.faqQestn}</p>
                                    <p id="faqAnswer" contenteditable="false" class="list-star bb mdi mdi-check-circle text-primary">${faq.faqAnswer}</p>
                                </blockquote>
                            </div>
                        </div>
                    </div> 
                    </div>
                    </div>
                </c:forEach>     
                </div>
            </div>
        </div>
    </div>
    
    
    
    
        <div class="col-lg-6">

        <div class="card">
            <div class="card-body" style="font-family: 'GmarketSansMedium';" >
                <div class="row">
                	<div class="col-md-6" style="margin-top: 10px;">
                        <h3>⭐ FAQ 등록/수정/삭제</h3>
                    </div>
                    <div class="col-md-6 text-right" >
                        <c:if test="${not empty sessionScope.admSession}">
                            <a href="/manage/create?register" class="btn btn-inverse-primary">FAQ 등록</a>
                            <button type="button" id="update" class="btn btn-inverse-danger">수정/삭제</button>
                        </c:if>
                        <button type="button" id="cancel" class="btn btn-inverse-secondary btn-fw p4" style="display:none;">취소</button>
                    </div>
                
                    <c:forEach items="${faqList}" var="faq" varStatus="loop">
                        <div class="col-md-12 grid-margin grid-margin-md-0 stretch-card mb-3" id="div${faq.faqNo}" style="height: fit-content;">
                      	 <div class="faq-block card-body">
                       		<div class="accordion">
                            	<div class="card" style="margin-bottom: -50px">
	                                <div class="card-body">
	                                    <blockquote style="margin:30px 20px -20px 20px;">
	                                        <p id="faqQestn" contenteditable="false" class="card-title  accordion-button aa mdi mdi-face"> ${faq.faqQestn}</p>
	                                        <p id="faqAnswer" contenteditable="false" class="list-star  accordion-content bb mdi mdi-check-circle text-primary">
	                                            ${faq.faqAnswer}
	                                        </p>
	                                        <div class="p1 text-right" style="display:none;">
	                                            <button type="button" id="edit" class="btn btn-inverse-primary">수정</button>
	                                            <button type="button" id="delete" class="btn btn-inverse-danger btn-fw" data-delete="${faq.faqNo}">삭제</button>
	                                        </div>
	                                        <div class="p2 text-right" style="display:none;">
	                                            <button type="button" id="confirm" class="btn btn-inverse-primary" data-confirm="${faq.faqNo}">확인</button>
	                                        </div>
	                                        <div class="p3 text-right" style="display:none;">
	                                            <button type="button" id="end" class="btn btn-inverse-primary">완료</button>
	                                        </div>
	                                    </blockquote>
	                                </div>
                            	</div>
                        	</div> 
                        </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    
</div>
    
</body>
</html>