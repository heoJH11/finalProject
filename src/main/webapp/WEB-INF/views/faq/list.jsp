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
#balloon {
    position: absolute;
    margin-top: -90px;
    top: 0;
    left: 0;
    z-index: 0;
}

#faq {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
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
            	                    $("#div"+faqNo).remove();
            	                    location.href="/manage/faq";
            	                }
            	            });
            	        }
            	    });
            	}
            });
    	});
    }); 
     /* $(document).on("click",'#delete',function(){
    	console.log("정상실행 faq삭제")
    	;
    	let faqNo = $(this).data("delete");
    	let data = {
    		"faqNo":faqNo
    	};
    	console.log("data",data);
    	
    	$.ajax({
    		url:"/faq/delete",
    		contentType:"application/json;charset=utf-8",
    		data:JSON.stringify(data),
    		type:"post",
    		dataType:"text",
    		success:function(result){
    			console.log("result:",result);
    			alert("삭제완료");
    			location.href="/faq/list";
    		}
    		
    	})
    	
    	
    	
    });  */
    
    
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
    			location.href="/manage/faq";
    		}
    		
    	});
    	
    	
    });
   $(document).on("click",'.p3',function(){
	   Swal.fire({
	        title: '수정이 완료 됐습니다.',
	        icon: 'success',
			confirmButtonColor: '#7066e0',
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
<div class="content-wrapper" style=" margin-top:-40px; background : #F5F7FF;">
<div style="position: absolute; top: 0; left: 0; width: 100%;">
	        <img src="../resources/images/풍선.png" id="balloon" style="width: 500px; height:auto; margin:-90px 0 0 680px;">
	        <h1 id="faq" style="margin:130px 0 0 790px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:white;">FAQ<br> 자주 묻는 질문</h1>
	    </div >
 				
   
   	<div class="col-lg-12 grid-margin stretch-card" style="margin:300px 0 0 100px; width:80%;"">
		<div class="card">
			<div class="card-body" style="margin:50px 100px 0 100px;">
				<div class="row"  >
					<div class="col-md-6" >
	        			<h3 style="font-family: 'seolleimcool-SemiBold';"><img src="../resources/images/faq3.png" style="width: 50px; height:auto; margin-right:20px;">회원님들이 자주 묻는 질문</h3>
					</div>
					<div class="col-md-6 text-right" >
<%--         <c:if test="${not empty sessionScope.admSession}"> --%>
<!--         <a href="/faq/create?register" class="btn btn-primary" style="font-family: 'GmarketSansMedium';">FAQ 등록</a> -->
<!--         <button type="button" id="update" class="btn btn-primary" style="font-family: 'GmarketSansMedium';">수정/삭제</button> -->
<%--         </c:if> --%>
<!--         <button type="button" id="cancel" class="btn btn-outline-secondary btn-fw p4" style="display:none; font-family: 'GmarketSansMedium';">취소</button> -->
    </div>
			</div>
			</div>
  	

<div class="row" style="margin: 0 0 80px 80px;">

    <c:forEach items="${faqList}" var="faq" varStatus="loop">
        <div class="col-md-12 grid-margin grid-margin-md-0 stretch-card mb-3" id="div${faq.faqNo}" style="height: fit-content;">
            
              <div class="faq-block card-body">
              <div class="accordion">
              <div class="card" style="margin-bottom: -50px; width:90%; ">
                <div style="padding:30px; ">
                    
                            <%-- <li>${faq.rnum}</li> --%>
                       
                        <%-- <p>${faq.faqNo}</p>  --%>                      
                        
                        <p id="faqQestn" contenteditable="false" class="card-title  accordion-button aa mdi mdi-face" style="font-family: 'GmarketSansMedium';"> ${faq.faqQestn}</p>
                      
                
                        <p id="faqAnswer" contenteditable="false" style="font-family: 'GmarketSansMedium';" class="list-star  accordion-content bb mdi mdi-check-circle text-primary">
                            ${faq.faqAnswer}
                        </p>
                        
                        <div class="p1 text-right" style="display:none;">
                            <button type="button" id="edit" class="btn btn-primary" style="font-family: 'GmarketSansMedium';">수정</button>
                            <button type="button" id="delete" class="btn btn-outline-danger btn-fw" data-delete="${faq.faqNo}" style="font-family: 'GmarketSansMedium';">삭제</button>
                            
                        </div>
                        <div class="p2 text-right" style="display:none;">
                            <button type="button" id="confirm" class="btn btn-primary" data-confirm="${faq.faqNo}" style="font-family: 'GmarketSansMedium';">확인</button>
                        </div>
                        <div class="p3 text-right" style="display:none;">
                            <button type="button" id="end" class="btn btn-primary" style="font-family: 'GmarketSansMedium';">완료</button>
                        </div>
                     

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
    
</body>
</html>