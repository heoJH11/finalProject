<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<style>

</style>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
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
						<h2 class="text-center my-5" style="font-family: GMarketSansMedium;">유저 아이디 : ${usersVO.userId}</h2>
						<div style="margin-left: 76%;">	
						</div>
						
						<hr>
					</div>
					<div class="container-fluid mt-5 w-100">
						<h3 class="mb-5" style="font-family: 'seolleimcool-SemiBold'; padding-left: 20px;">유저 닉네임 : ${usersVO.userNcnm}</h3>
						<h3 class="mb-5" style="font-family: 'seolleimcool-SemiBold'; padding-left: 20px;">유저 이름 : ${usersVO.userNm}</h3>
						<h3 class="mb-5" style="font-family: 'seolleimcool-SemiBold'; padding-left: 20px;">유저 비밀번호 : ${usersVO.userPassword}</h3>
						<h3 class="mb-5" style="font-family: 'seolleimcool-SemiBold'; padding-left: 20px;">유저 타입: <span id="userType"></span></h3>
						<hr>
					</div>
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