<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.swal2-title{
	font-family: 'GmarketSansMedium';
}
.swal2-html-container{
	font-family: 'GmarketSansMedium';
}

.table th {
border-top:none;
}
th, td, input, label, button{
	font-family: 'GmarketSansMedium';
}
.table td {
border-top:none;
padding : 10px;
}
.form-group{
margin-bottom:0px;
}

#firstCode, #secondCode, #thirdCode{
	width:160px;
	border: 3px;
}
#fileName{
	width:200px;
}
#imgProfile{
	width:260px;
	height:260px;
	margin-left: auto;
	margin-bottom:20px;
	border-radius: 130px;
}
.box_container{
/* 	height:100vh; */
	height:auto;
	display:flex;
	justify-content: center;
	
}
.box{
	text-align: center;
}
.floatLeft{
	float: left;
	margin-left: 20px;
}
.codeTab{
	border: 1px solid #DDDDDD;
	text-align: center;
	margin:5px;
}
#codeBtn{
	margin-left:30px;
	margin-right:30px;
}
#spcltyRealmCode{
	width:200px;
	height:50px;
	margin:5px;
}
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 78%;
    color: #999999;
}
.filebox #lab {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #4B49AC;
    border-radius:13px 13px 13px 13px;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>
<script>
	$(function(){
		//자동입력
		$("#autoInsert").on("click",function(){
			let ranNum = Math.floor(Math.random() * 9000) + 1000;
			let ranNum1 = Math.floor(Math.random() * 90000000) + 10000000;
// 			console.log("랜덤숫자 " + ranNum);
			
			$("#userId").val("nntn"+ranNum);
			$("#userNcnm").val("nntn"+ranNum);
			$("#email").val("nntn"+ranNum+"@naver.com");
			$("#userNm").val("홍길동");
			$("#userPassword").val("asdasd");
			$("#userPasswordCk").val("asdasd");
			$("#proMbtlnum").val("01092942378");
			$("#zip").val("34908");
			$("#adres").val("대전 중구 계룡로 846");
			$("#detailAdres").val("대덕인재개발원");

		})//자동입력 끝
		
		//전문분야 2번쨰 select 태그 출력
		$("#firstCode").on("change",function(){
			$("#thirdCode").html("<select><option>소분류 선택</option></select>");
        	$("#codeName").val("");
			$("#spcltyRealmCode").val("");
			var firstCode = $("#firstCode").val();
			var firstCodeNm = $("#firstCode > option:selected").attr("value2");
			if(firstCode != "none"){
				$.ajax({
		            url: '/pro/codeSelect', // 서버 URL
		            type: 'GET',
		            data: {"code": firstCode},
		            dataType: 'json',
		            success: function(data) {
// 		            	$("#secondCode").css("display","block");
		            	var secondStr = "<option value='none'>중분류 선택</option>";
		                $.each(data, function(index, secondCodeNm) {
		                    secondStr += "<option value='" + secondCodeNm.spcltyRealmCode + "' value2='"+secondCodeNm.spcltyRealmNm+"'>" + secondCodeNm.spcltyRealmNm + "</option>";
		                });
		                $("#secondCode").html(secondStr);
		                $("#codeName").val("");
		    			$("#spcltyRealmCode").val("");
		            }
		        });
		    } else {
            	$("#secondCode").html("<select><option>중분류 선택</option></select>");
            	$("#thirdCode").html("<select><option>소분류 선택</option></select>");
            	$("#codeName").val("");
    			$("#spcltyRealmCode").val("");
		    }	
		})
		
		$("#secondCode").on("change",function(){
			var secondCode = $("#secondCode").val();
			var secondCodeNm = $("#secondCode > option:selected").attr("value2");
			if(secondCode.length == 6){
				$("#codeName").val(secondCodeNm);
				$("#spcltyRealmCode").val(secondCode);
				$("#thirdCode").html("<select></select>");
// 				console.log($("#codeName").val() + "/" + $("#spcltyRealmCode").val());
// 				console.log(secondCode + "/" + secondCodeNm);
			}else{
				if(secondCode != "none"){
					$.ajax({
			            url: '/pro/codeSelect', // 서버 URL
			            type: 'GET',
			            data: {"code": secondCode},
			            dataType: 'json',
			            success: function(data) {
			            	$("#thirdCode").css("display","block");
			            	var thirdStr = "<option value='none'>소분류 선택</option>";
			                $.each(data, function(index, thirdCodeNm) {
			                	thirdStr += "<option value='" + thirdCodeNm.spcltyRealmCode + "' value2='"+thirdCodeNm.spcltyRealmNm+"'>" + thirdCodeNm.spcltyRealmNm + "</option>";
			                });
			                $("#thirdCode").html(thirdStr);
			            }
			        });
			    } else {
	            	$("#thirdCode").html("<select><option소분류 선택</option></select>");
	            	$("#codeName").val("");
	    			$("#spcltyRealmCode").val("");
			    }	
			}
		})
		
		$("#thirdCode").on("change",function(){
			var thirdCode = $("#thirdCode").val();
			var thirdCodeNm = $("#thirdCode > option:selected").attr("value2");
// 			console.log(thirdCode + "/" + thirdCodeNm);
			if(thirdCode != "none"){
				$("#codeName").val(thirdCodeNm);
				$("#spcltyRealmCode").val(thirdCode);
// 				console.log($("#codeName").val() + "/" + $("#spcltyRealmCode").val());
			}else{
				$("#codeName").val("");
				$("#spcltyRealmCode").val("");
			}
			
		})
		
		$("#uploadFile").on('change',function(){
			var fileName = $("#uploadFile").val();
			$(".upload-name").val(fileName.split('/').pop().split('\\').pop());
		});
		
		//닉네임, 이메일, 아이디 중복확인하고 값 바뀌면 다시 확인하게
		$("#userNcnm").on("change",function(){
			$("#nicDupRes").val("");
		})
		$("#email").on("change",function(){
			$("#emailDupRes").val("");
		})
		$("#userId").on("change",function(){
			$("#idDupRes").val("");
		})
	
		//회원가입 버튼 클릭 이벤트
		$("#proInsert").on("click",function(){
			var idDupRes = $("#idDupRes").val();
			var emailDupRes = $("#emailDupRes").val();
			var phoneDupRes = $("#phoneDupRes").val();
			var nicDupRes = $("#nicDupRes").val();
			var userPassword = $("#userPassword").val();
			var userPasswordCk = $("#userPasswordCk").val();
			var sexdstnTy = $("#sexdstnTy").val();
			var spcltyRealmCode = $("#spcltyRealmCode").val();
			
			if(idDupRes != "ok"){
				Swal.fire("아이디 중복체크를 해주세요.");
// 				$("#idDupCk").focus();
			}else if(emailDupRes != "ok"){
				Swal.fire("이메일 중복체크를 해주세요.");
// 				$("#emailDupCk").focus();
// 			}else if(phoneDupRes != "ok"){
// 				Swal.fire("휴대폰 본인인증을 해주세요.");
// 				$("#telCk").focus();
			}else if(nicDupRes != "ok"){
				Swal.fire("닉네임 중복체크를 해주세요.");
// 				$("#nickDupCheck").focus();
			}else if(userPassword != userPasswordCk){
				Swal.fire("입력하신 비밀번호가 서로 다릅니다.\n비밀번호를 확인해주세요.");
			}else if(sexdstnTy=="0"){
				Swal.fire("성별을 선택해주세요.");
			}else if(spcltyRealmCode=="0"){
				Swal.fire("전문분야를 선택해주세요.");
			}else{
				$("#insertForm").submit();
			}
		}) //회원가입버튼 클릭 이벤트 끝
		
		//전화번호 본인인증
		$("#telCk").on("click",function(){
			const proMbtlnum = $("#proMbtlnum").val();
			const test = /^010[\d]{8}$/;
			
			if(test.test(proMbtlnum)){
				$.ajax({
	                  type: "post",
	                  url: "/pro/check/sendSMS",
	                  cache: false,
	                  data: { "proMbtlnum": proMbtlnum },
// 	                  beforeSend: function (xhr) {
// 	                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 	                  },
	                  success: function (data) {
						console.log("인증번호 : " + data);
		                  if (data == "error") {
		                  	Swal.fire({
			     			    title: '전화번호 형식이 올바르지 않습니다.',
			     			    text: "전화번호를 확인해주세요.",
			     			    icon: 'error',
			     			    showCancelButton: false,
			    				confirmButtonColor: '#7066e0',
			     			    confirmButtonText: '확인',
		     			    }).then((result) => {
		     			    	$("#proMbtlnum").focus();
		     			    })
		                  } else {
							Swal.fire({
								content: "input",
								title: "인증번호가 발송되었습니다.",
								text: "전송받은 인증번호 6자리를 입력해주세요.",
								input: 'text',
								buttons: ["확인", "취소"],
								dangerMode: true,
							})
							.then((ranNum) => {
								if(data == ranNum.value){ //인증번호 동일
									Swal.fire({
							            title: '본인인증이 완료되었습니다.',
							            icon: 'success',
							            showCancelButton: false,
										confirmButtonColor: '#7066e0',
							            confirmButtonText: '확인',
							        }).then((result) => {
							        	$("#telCk").attr("disabled",true);
						                $("#phoneDupRes").val("ok");
						                
							        })
								}else{ //인증번호 틀리면
									Swal.fire("입력하신 번호가 전송된 인증번호와 일치하지 않습니다.");
								}
							});
								authNum = data;
		                  }
	                  }
	               });
			}else{
				Swal.fire({
		            title: '전화번호 형식이 올바르지 않습니다.',
		            text: "전화번호를 확인해주세요.",
		            icon: 'error',
		            showCancelButton: false,
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#proMbtlnum").focus();
		        })
			}
			
		})//전화번호 본인인증 끝
		
		//이메일 중복확인
		$("#emailDupCk").on('click',function(){
			var email = $("#email").val();
			const emailTest = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			if(emailTest.test(email)){
				$.ajax({
					url:"/pro/emailCk?email=" + email,
					method:"get",
					dataType:"text",
// 					beforeSend: function (xhr) {
// 	                	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 	                },
					success:function(res){
						if(res==0){
							Swal.fire({
					            title: '사용할 수 있는 이메일입니다.',
					            text: "이 이메일을 사용하시겠습니까?",
					            icon: 'success',
					            showCancelButton: true,
								confirmButtonColor: '#7066e0',
								cancelButtonColor: '#6e7881',
					            confirmButtonText: '사용',
					            cancelButtonText: '취소'
					        }).then((result) => {
					            if (result.isConfirmed) {
					            	$("#emailDupCk").attr("disabled",true);
					                $("#emailDupRes").val("ok");
					            }else{
					            	$("#email").val("");
					            	$("#email").focus();
					            }
					        })
						}else{
							Swal.fire({
					            title: '존재하는 이메일입니다.',
					            text: "이메일을 다시 입력하세요.",
					            icon: 'warning',
					            showCancelButton: false,
								confirmButtonColor: '#7066e0',
					            confirmButtonText: '확인'
					        }).then((result) => {
					        	$("#email").focus();
					        })
						}
					}
				})
			}else{
				Swal.fire({
		            title: '이메일 형식이 올바르지 않습니다.',
		            text: "이메일 형식을 확인해주세요.",
		            icon: 'error',
		            showCancelButton: false,
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#email").focus();
		        })
			}
		})//이메일 중복확인 끝
		
		//아이디 중복확인
		$("#idDupCk").on('click',function(){
			const userId = $("#userId").val();
			const test = /^[A-Za-z\d]{6,12}$/;
			if(test.test(userId)){
				$.ajax({
					url:"/pro/idCk?userId=" + userId,
					method:"get",
					dataType:"text",
// 					beforeSend: function (xhr) {
// 	                	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 	                },
					success:function(res){
						if(res==0){
							Swal.fire({
					            title: '사용할 수 있는 아이디입니다.',
					            text: "이 아이디를 사용하시겠습니까?",
					            icon: 'success',
					            showCancelButton: true,
								confirmButtonColor: '#7066e0',
								cancelButtonColor: '#6e7881',
					            confirmButtonText: '사용',
					            cancelButtonText: '취소'
					        }).then((result) => {
					            if (result.isConfirmed) {
					            	$("#idDupCk").attr("disabled",true);
					                $("#idDupRes").val("ok");
					            }else{
					            	$("#userId").val("");
					            	$("#userId").focus();
					            }
					        })
						}else{
							Swal.fire({
					            title: '존재하는 아이디입니다.',
					            text: "아이디를 다시 입력하세요.",
					            icon: 'warning',
					            showCancelButton: false,
								confirmButtonColor: '#7066e0',
					            confirmButtonText: '확인'
					        }).then((result) => {
					        	$("#userId").focus();
					        })
						}
					}
				})
			}else{
				Swal.fire({
		            title: '아이디 형식이 올바르지 않습니다.',
		            text: "영문과 숫자만 포함하여 6~12자로 입력해주세요.",
		            icon: 'error',
		            showCancelButton: false,
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#userId").focus();
		        })
			}
		})//아이디 중복확인 끝
		
		//닉네임 중복확인
		$("#nickDupCheck").on('click',function(){
			const userNcnm = $("#userNcnm").val();
			const test = /^[A-Za-z가-힣\d]{2,15}$/;
// 			console.log("test",test.test(userNcnm));
			if(test.test(userNcnm)){
				$.ajax({
					url:"/pro/ncnmCk?userNcnm=" + userNcnm,
					method:"get",
					dataType:"text",
// 					beforeSend: function (xhr) {
// 	                	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 	                },
					success:function(res){
						if(res==0){
							Swal.fire({
					            title: '사용할 수 있는 닉네임입니다.',
					            text: "이 닉네임을 사용하시겠습니까?",
					            icon: 'success',
					            showCancelButton: true,
								confirmButtonColor: '#7066e0',
								cancelButtonColor: '#6e7881',
					            confirmButtonText: '사용',
					            cancelButtonText: '취소'
					        }).then((result) => {
					            if (result.isConfirmed) {
					            	$("#nickDupCheck").attr("disabled",true);
					                $("#nicDupRes").val("ok");
					            }else{
					            	$("#userNcnm").val("");
					            	$("#userNcnm").focus();
					            }
					        })
						}else{
							Swal.fire({
					            title: '존재하는 닉네임입니다.',
					            text: "다른 닉네임을 입력하세요.",
					            icon: 'warning',
					            showCancelButton: false,
								confirmButtonColor: '#7066e0',
					            confirmButtonText: '확인'
					        }).then((result) => {
					        	$("#userNcnm").focus();
					        })
						}
					}
				})
			}else{
				Swal.fire({
		            title: '닉네임 형식이 올바르지 않습니다.',
		            text: "영문과 숫자,한글을 포함하여 2~8자로 입력해주세요.",
		            icon: 'error',
		            showCancelButton: false,
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#usersNcnm").focus();
		        })
			}
		})//닉네임 중복확인 끝
		
		//우편번호 api 시작
	    $("#zipSelect").on("click",function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	  var resultHTML = [];
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	                document.getElementById('zip').value = data.zonecode;	// --> 우편번호 칸
	                document.getElementById("adres").value = roadAddr;	// --> 도로명 주소 칸
	                if(roadAddr !== ''){
	                    document.getElementById("adres").value = roadAddr;
	                } else {
	                    document.getElementById("adres").value = extraRoadAddr;
	                }
	                var guideTextBox = document.getElementById("guide");
	           }
	        }).open();
	        $("#detailAdres").focus();
	    });
		
		//프로필사진 삭제
		$("#photoDelete").on("click",function(){
			var userId = $("#userId").val();
			Swal.fire({
				title: '프로필 사진을 삭제하시겠습니까?',
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
	            confirmButtonText: '사용',
	            cancelButtonText: '취소'
			}).then((result)=>{
				if(result.isConfirmed){
					Swal.fire({
						title: '사진 삭제 성공!!',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						$("#photoDelete").css("display","none");
						$("#newPhoto").css("display","none");
						$("#photoZone").css("display","block");
						$(".upload-name").val("");
						$("#proProflPhoto").val("");
						$("#pfPhoto").val("");
					})
				}
			})
		}) //프로필 사진 삭제 끝
		
		$("#uploadFile").on("change",function(){
			console.log("이미지 변경");
			
			var fileName = $("#uploadFile").val();
			$(".upload-name").val(fileName);
			$("#proProflPhoto").val(fileName);
			$("#photoDelete").css("display","block");
		});
		
		$("#uploadFile").on("change",imgCk);
		function imgCk(e){
			let files = e.target.files;
			
// 			console.log(files);
			let fileArr = Array.prototype.slice.call(files);
		
			fileArr.forEach(function(f){
				
// 				console.log(f);
				if(!f.type.match("image.*")){
					Swal.fire({
						title: '이미지파일만 등록 가능합니다.',
						icon: 'error',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						return;
					})
				}

				let reader = new FileReader();
				
				$("#newPhoto").html("");
				$("#photoZone").css("display","none");
				
				reader.onload = function(e){
					$("#newPhoto").css({
						  "display":"block",
						  "background-image": "url(" + e.target.result + ")",
				          "width": "260px", 
				          "height": "260px",
				          "background-position": "center",
				          "background-size": "cover",
						  "margin-bottom":"20px",
						  "border-radius": "130px"
				    });	 				
				}
				reader.readAsDataURL(f);
			});
		}
		
		$("#email").on("change",function(){
			$("#emailDupRes").val("");
			$("#emailDupCk").attr("disabled",false);
		})
		$("#proMbtlnum").on("change",function(){
			$("#phoneDupRes").val("");
			$("#telCk").attr("disabled",false);
		})
		$("#userNcnm").on("change",function(){
			$("#nicDupRes").val("");
			$("#nickDupCheck").attr("disabled",false);
		})
		$("#userId").on("change",function(){
			$("#idDupRes").val("");
			$("#idDupCk").attr("disabled",false);
		})
		
		$("#userPassword").on("change",function(){
			const userPassword = $("#userPassword").val();
			const userPasswordCk = $("#userPasswordCk").val();
			if(userPassword == userPasswordCk){
				$("#userPassword").css("border","1px solid green");
				$("#userPasswordCk").css("border","1px solid green");
			}else{
				$("#userPassword").css("border","1px solid red");
				$("#userPasswordCk").css("border","1px solid red");
			}
		})
		$("#userPasswordCk").on("change",function(){
			const userPassword = $("#userPassword").val();
			const userPasswordCk = $("#userPasswordCk").val();
			if(userPassword == userPasswordCk){
				$("#userPassword").css("border","1px solid green");
				$("#userPasswordCk").css("border","1px solid green");
			}else{
				$("#userPassword").css("border","1px solid red");
				$("#userPasswordCk").css("border","1px solid red");
			}
		})
	});
	
</script>
<div class="container col-lg-10" style="padding:0px;">
	<div class="row col-lg-10">
		<img src="../resources/images/프로.png" style="width: 100px; height:auto; margin-right:20px;">
		<h1 class="card-title" style="margin-top:30px; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 가입</h1>		
	</div>
	<hr style="border-top: 50px solid #eaebf7; margin:-45px 0 30px 0;">
</div>
<div style="margin-left:80px;">
<form class="forms-sample" id="insertForm" name="insertForm" method="post"
	enctype="multipart/form-data" action="/pro/proInsert">
	<input type="hidden" id="proProflPhoto" name="proProflPhoto">
	<input type="hidden" id="idDupRes">
	<input type="hidden" id="emailDupRes">
	<input type="hidden" id="phoneDupRes">
	<input type="hidden" id="nicDupRes">
<!-- 	<img src="/images/2024/04/11/1.png"> -->
	<div class="container-fluid justify-content-center">
		<div class="row">
			<div class="innerDiv col-7">
				<div class="centerDiv co-10">
					<div class="slideDiv">
<!-- 						<ul id="ulPrt"> -->
							<div class="box_container">
								<div class="box">
									<div id="photoZone">
										<img id="imgProfile" src="/images/2024/profile.jpg"
												style="margin-left:-100px;" />
									</div>
									<div id="newPhoto" style="display: none;"></div>
									<label style="margin:0 0 30px -100px;">프로필사진 등록</label>
						<!-- 			<input type="file" name="mberProflPhoto" class="file-upload-default"> -->
<!-- 									<div class="form-group filebox"> -->
<!-- 										<div class="input-group col-xs-12"> -->
<!-- 											<input placeholder="프로필 사진을 등록해보세요" readonly -->
<!-- 												class=" upload-name form-control file-upload-info" /> -->
<!-- 											<span class="input-group-append"> -->
<!-- 												<label for="uploadFile" id="lab">파일찾기</label>  -->
<!-- 												<input type="file" id="uploadFile" class="file-upload-browse btn btn-inverse-primary btn-fw" name="uploadFile"></button> -->
<!-- 											</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</div>
							</div>
<!-- 						</ul> -->
					</div>
				</div>
				<div class="innerDiv col-10">
					<div class="form-group filebox">
						<div class="input-group">
							<input placeholder="프로필 사진을 등록해보세요" readonly
								class=" upload-name form-control file-upload-info" id="fileName" />
							<span class="input-group-append">
								<label for="uploadFile" id="lab">파일찾기</label> 
								<input type="file" id="uploadFile" class="file-upload-browse btn btn-inverse-primary btn-fw" name="uploadFile"></button>
		<!-- 						<input type="file" id="uploadFile" name="uploadFile" class="file-upload-browse btn btn-primary">업로드</button> -->
							</span>
							<button type='button' class='btn btn-inverse-link btn-fw'
											id='photoDelete' style="display:none;">사진 삭제</button>
						</div>
					</div>
					<table class="table table-hover" >
						<tbody>
							<tr>
								<th>아이디</th>
								<td>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="userId" name="userId"
											placeholder="아이디" required />
										<span class="input-group-append">
											<button type="button" class="file-upload-browse btn btn-inverse-primary btn-fw" id="idDupCk">중복확인</button>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="password" class="form-control" id="userPassword" name="userPassword"
										placeholder="비밀번호" required />
								</td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td>
									<input type="password" class="form-control" id="userPasswordCk" name="userPasswordCk"
										placeholder="비밀번호 확인">
								</td>
							</tr>
							<tr>
								<th>전문분야</th>
								<td>
									<input type="text" class="form-control" id="codeName" readonly>
									<input type="hidden" class="form-control" id="spcltyRealmCode" name="spcltyRealmCode">
								</td>
							</tr>
							<tr>
								<td colspan='2'>
									<div id="firstCodeDiv" class="floatLeft">
										<select class="form-control form-control-sm" id="firstCode">
											<option value="none">대분류 선택</option>
					                    	<c:forEach var="codeNm" items="${codeList}">
									      		<c:if test="${codeNm.lev eq 1}">
										       		<option value="${codeNm.spcltyRealmCode}" value2="${codeNm.spcltyRealmNm}">${codeNm.spcltyRealmNm}</option>
									      		</c:if>
									      	</c:forEach>
					                    </select>
									</div>
									<div id="secondCodeDiv" class="floatLeft">
										<select class="form-control form-control-sm" id="secondCode">
											<option>중분류 선택</option>
					                    </select>
									</div>
									<div id="thirdCodeDiv" class="floatLeft">
										<select class="form-control form-control-sm" id="thirdCode">
											<option>소분류 선택</option>
					                    </select>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="innerDiv col-5">
				<div class="innerDiv co-10">
					<table class="table table-hover" style="background-color: white; margin-left:-100px;">
						<tbody>
							<tr>
								<th>이메일</th>
								<td>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="email" name="email" required
											placeholder="이메일">
										<span class="input-group-append">
											<button type="button" id="emailDupCk" class="file-upload-browse btn btn-inverse-primary btn-fw">중복확인</button>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" class="form-control" id="userNm" name="userNm" required
										placeholder="이름">
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="proMbtlnum" name="proMbtlnum" placeholder="- 없이 숫자 11자리 입력">
										<span class="input-group-append">
											<button type="button" id="telCk" class="file-upload-browse btn btn-inverse-primary btn-fw">본인인증</button>
										</span>
									</div>			
								</td>
							</tr>
							<tr>
								<th>성별</th>
								<td>
									<select class="form-control" id="sexdstnTy" name="sexdstnTy">
										<option value="0">성별을 선택하세요</option>
										<option value="SD01">남성</option>
										<option value="SD02">여성</option>
										<option value="SD03">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="userNcnm" name="userNcnm"
											placeholder="닉네임" required>
										<span class="input-group-append">
											<button type="button" id="nickDupCheck" class="file-upload-browse btn btn-inverse-primary btn-fw">중복확인</button>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>우편번호</th>
								<td>
									<div class="form-group input-group">
										<input type="text" readonly class="form-control" id="zip" name="zip"
											placeholder="우편번호">
										<span class="input-group-append">
											<button type="button" id="zipSelect" class="file-upload-browse btn btn-inverse-primary btn-fw">우편번호 찾기</button>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<input type="text" readonly class="form-control" id="adres" name="adres"
										placeholder="주소" required>
								</td>
							</tr>
							<tr>
								<th>상세주소</th>
								<td>
									<input type="text" class="form-control" id="detailAdres" name="detailAdres"
										placeholder="상세주소" required>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="hrDiv co-10"></div>
				<div class="innerDiv col-10">
					<button type="button" id="autoInsert" style="border:none; background:none; float:right;">
		            	<img src="../resources/images/버튼.png" style="width:50px; height:50px; " />
		            </button>
					<button type="button" id="proInsert" class="btn btn-outline-primary btn-fw" style="float:right;">회원가입</button>
					<button type="reset" class="btn btn-light" style="float:right;">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>