<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
	@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}

	@font-face {
	    font-family: 'seolleimcool-SemiBold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	.box_container{
		height:100vh;
		display:flex;
		justify-content: center;
	}
	.box{
		text-align: center;
		margin-top: 200px;
	}
	#passCk{
		margin-top:20px;
		margin-bottom:20px;
	}
	
	.content-wrapper {
	    background-image: url("../resources/images/dd5.jpg");
	    background-size: 2000px;
	    background-position: center;
	}
	
	input::placeholder {
	    color: white;
	}
	.swal2-title{
	font-family: 'GmarketSansMedium';
	}
	.swal2-html-container{
		font-family: 'GmarketSansMedium';
	}
	button{
		font-family: 'GmarketSansMedium';
	}
		

</style>
<script>

$(function(){
	if($("#sessionId").val() == ""){
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
	$(".header").css("display", "none");
    $(".footer").css("display", "none");
	var btnOk = document.getElementById("btnOk");
	var sessionPass = document.getElementById("sessionPass").value;
	btnOk.addEventListener("click",function(){
		passCkEvent();
	})
	
	$("#passCk").on("keyup", function (key) {
        if(key.keyCode == 13) {
        	passCkEvent();
        }
    })
    $(".backBtn").on("click", function(){
       window.location.replace("/main");
    })
})
let passCkEvent = function(){
	var passCk = $("#passCk").val();
	var sessionPass = document.getElementById("sessionPass").value;
// 	console.log(passCk + "/" + sessionPass);
	if(passCk != sessionPass){
		Swal.fire({
			title: '비밀번호가 일치하지 않습니다.',
			text: "다시 입력해주세요.",
			icon: 'error',
			showCancelButton: false,
			confirmButtonColor: '#7066e0',
			confirmButtonText: '확인',
		}).then((result) => {
			$("#passCk").focus();
		})
	}else{
		Swal.fire({
			    title: '비밀번호가 일치합니다.',
			    icon: 'success',
			    showCancelButton: false,
				confirmButtonColor: '#7066e0',
			    confirmButtonText: '확인',
	    }).then((result) => {
			location.href="/pro/proMypage";
	    })
	}
	
}
</script>
<input type="hidden" id="sessionId" value="${proSession.userId}" />
<input type="hidden" id="sessionPass" value="${proSession.userPassword}" />
  <div class="container-scroller" style="margin:-120px -300px;">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth">
        <div class="row w-100">
          <div class="col-lg-4 mx-auto">
			<button class="backBtn" style="border:none; background-color:transparent">
				<img src="../resources/images/뒤로가기3.png" alt="img" style="width:50px; margin:-350px 0 0 1100px;"/>
			</button>
          	<h2 style="text-align:center; font-size: 40px; color:#4B49AC; font-family:'seolleimcool-SemiBold'; text-shadow: -2px 0px #f6ecff, 0px 2px #f6ecff, 2px 0px #f6ecff, 0px -2px #f6ecff;"">마이페이지</h2>
            <div class="auth-form-transparent text-left p-5 text-center">
				<c:if test="${empty proSession.profile}">
					<img src="/images/2024/profile.jpg" class="lock-profile-img" alt="img"/>
				</c:if>
				<c:if test="${not empty proSession.profile}">
					<img src="${proSession.profile}" class="lock-profile-img" alt="img"/>
				</c:if>
<!--               <form class="pt-5"> -->
                <div class="form-group">
                 <label for="examplePassword1" style="font-size: 25px; color:#4B49AC; font-family:'seolleimcool-SemiBold'; margin-top:20px;">비밀번호를 한번 더 입력해주세요</label>
                  <input type="password" style="font-family: 'GmarketSansMedium'; border-radius:20px; border: 1px solid white; color: white; width:400px; height:40px; text-align:center; font-size: 15px; background-color:transparent;" id="passCk" placeholder="비밀번호">
                </div>
                <div class="mt-5">
                  <button type="button" id="btnOk" style="font-family: 'GmarketSansMedium';"class="btn btn-outline-primary btn-fw">확인</button>
                </div>
<!--               </form> -->
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>



