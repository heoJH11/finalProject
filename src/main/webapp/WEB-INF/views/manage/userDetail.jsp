<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
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



</style>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#backBtn").on("click", function() {
        location.href="/manage/notice";
    });
    
    // 회원 유형을 확인하고 출력을 변경하는 함수
    function formatEmplyrTy(emplyrTy) {
        if (emplyrTy === "ET01") {
            return "회원";
        } else if (emplyrTy === "ET02") {
            return "프로";
        } else {
            return "알 수 없음";
        }
    }
    
    // 페이지 로드 후 회원 유형을 변경하여 출력
    var emplyrTy = "${usersVO.emplyrTy}";
    var formattedEmplyrTy = formatEmplyrTy(emplyrTy);
    $("#userType").text(formattedEmplyrTy);
    
    $("#warning").on("click",function(){
    	Swal.fire({
		    title: '제재처리하시겠습니까?',
		    icon: 'info',
		    showCancelButton: true,
		    confirmButtonColor: '#7066e0',
		    cancelButtonColor: '#ff4081',
		    confirmButtonText: '확인',
	    	cancelButtonText: '취소'
	    }).then((result)=>{
	    	if(result.isConfirmed){
	    		Swal.fire({
	    		    title: '제재처리가 성공했습니다.',
	    		    icon: 'success',
	    		    showCancelButton: false,
	    		    confirmButtonColor: '#7066e0',
	    		    confirmButtonText: '확인'
	    	    }).then((result) => {
			    	location.href="/manage/notice"
			    })
	    	}else{
	    		Swal.fire({
	    		    title: '제재처리가 취소됐습니다.',
	    		    icon: 'success',
	    		    showCancelButton: false,
	    		    confirmButtonColor: '#7066e0',
	    		    confirmButtonText: '확인'
	    	    }).then((result) => {
			    	location.href="/manage/notice"
			    })
	    	}
	    })
    });
    $("#danger").on("click",function(){
    	Swal.fire({
		    title: '탈퇴처리하시겠습니까?',
		    icon: 'info',
		    showCancelButton: true,
		    confirmButtonColor: '#7066e0',
		    cancelButtonColor: '#ff4081',
		    confirmButtonText: '확인',
	    	cancelButtonText: '취소'
	    }).then((result)=>{
	    	if(result.isConfirmed){
	    		let userId = '${param.userId}';
	    		console.log("userId"+userId);
	    		
	    		$.ajax({
	    			url: "/manage/userDanger",
	    			type: "post",
	    			data: {"userId":userId},
	    			success:function(){
	    				Swal.fire({
	    	    		    title: '탈퇴처리가 성공했습니다.',
	    	    		    icon: 'success',
	    	    		    showCancelButton: false,
	    	    		    confirmButtonColor: '#7066e0',
	    	    		    confirmButtonText: '확인'
	    	    	    }).then((result) => {
	    			    	location.href="/manage/notice"
	    			    })
	    			}	
	    			
	    		})
	    	}else{
	    		Swal.fire({
	    		    title: '탈퇴처리가 취소됐습니다.',
	    		    icon: 'success',
	    		    showCancelButton: false,
	    		    confirmButtonColor: '#7066e0',
	    		    confirmButtonText: '확인'
	    	    }).then((result) => {
			    	location.href="/manage/notice"
			    })
	    	}
	    })
    })
});


</script>

<body>

<%-- ${usersVO} --%>
<!-- UsersVO(rnum=0, userId=테프로, userNcnm=테프로, userNm=홍길동, userPassword=123456, emplyrTy=ET02, secsnAt=1) -->
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<div class="container-fluid">
						<h2 class="text-center my-5" style="font-family:seolleimcool-SemiBold;">유저 아이디 : ${usersVO.userId}</h2>
						<div style="margin-left: 76%;">	
						</div>
						
						<hr>
					</div>
					<div class="container-fluid mt-5 w-100">
					
					
					    <div class="row">
					        <div class="col-md-6">
					            <h3 class="mb-5" style="font-family: 'GmarketSansMedium';">유저 닉네임 : ${usersVO.userNcnm}</h3>
					            <h3 class="mb-5" style="font-family: 'GmarketSansMedium';">유저 이름 : ${usersVO.userNm}</h3>
					            <h3 class="mb-5" style="font-family: 'GmarketSansMedium';">유저 비밀번호 : ${usersVO.userPassword}</h3>
					            <h3 class="mb-5" style="font-family: 'GmarketSansMedium';">유저 타입: <span id="userType"></span></h3>
					        </div>
					        <div class="col-md-6">
					        	<c:choose>
						        	<c:when test="${empty profile}">
						        		<img alt="" src="/images/2024/profile.jpg" style="width: 400px; height: 400px; border-radius: 200px">
						        	</c:when>
						        	<c:otherwise>
							            <img src="${profile}" style="width: 400px; height: 400px; border-radius: 200px">
						        	</c:otherwise>
					        	</c:choose>	
					        </div>
					    </div>
					    
					    <div class="row mt-3">
					        <div class="col-md-6">
					            <button type="button" id="warning" class="btn btn-inverse-warning">제재</button>                        
					            <button type="button" id="danger" class="btn btn-inverse-danger">탈퇴</button>
					        </div>
					    </div>
					
					    <hr>
					</div>
					
					
						<hr>
					<div class="container-fluid w-100"
						style="display: flex; flex-wrap: wrap; float: right;">
						<button type="button" class="btn btn-outline-primary"
							id="modifyBtn" style="display: none; margin-right: 5px;">수정</button>
						<button type="button" class="btn btn-outline-secondary"
							id="backBtn">목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>