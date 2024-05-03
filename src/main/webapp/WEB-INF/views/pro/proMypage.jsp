<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'GmarketSansLight';
}
*{
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
.main {
  margin-left: 140px; /* Same width as the sidebar + left position in px */
  font-size: 10px; /* Increased text to enable scrolling */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 10px;}
}
#donggyun{
	width:300px;
}
.form-control{
	width:200px;
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
table{
/* 	text-align: center; */
}
#imgProfile{
	width:300px;
	height:300px;
	margin-left: auto;
	margin-bottom:20px;
	border-radius: 150px;
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
#modalBackdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 검은색 배경에 투명도 추가 */
    z-index: 1030; /* 다른 요소 위에 배치 */
    display: none; 
}
</style>
<script>

$(document).ready(function(){
	
	$(document).on("change","#bfUserPassword",function(){
		const userPassword = $("#bfUserPassword").val();
		const userPasswordCk = $("#bfUserPasswordCk").val();
		if(userPassword == userPasswordCk){
			$("#bfUserPassword").css("border","1px solid green");
			$("#bfUserPasswordCk").css("border","1px solid green");
		}else{
			$("#bfUserPassword").css("border","1px solid red");
			$("#bfUserPasswordCk").css("border","1px solid red");
		}
	})
	$(document).on("change","#bfUserPasswordCk",function(){
		const userPassword = $("#bfUserPassword").val();
		const userPasswordCk = $("#bfUserPasswordCk").val();
		if(userPassword == userPasswordCk){
			$("#bfUserPassword").css("border","1px solid green");
			$("#bfUserPasswordCk").css("border","1px solid green");
		}else{
			$("#bfUserPassword").css("border","1px solid red");
			$("#bfUserPasswordCk").css("border","1px solid red");
		}
	})
	
	if('${proSession.userId}' == ""){
		Swal.fire({
			title: '로그인 후 이용해주세요..',
			icon: 'error',
			showCancelButton: false,
			confirmButtonText: '확인'
		}).then((result)=>{
			location.href="/main";
		})
	}
	const urlParams = new URL(location.href).searchParams;
	const name = urlParams.get("updPass");
	console.log("name : ",name);
	
	//정보수정 확인 비밀번호 일치 폼 변경
	if(name == "success"){
		var str = "<table class='table table-hover'>";
		var gender = $("#gender").val();
		str += "<tbody><tr><th>아이디</td><td>${proSession.userId}</td><td></td></tr>";
		str += "<tr><th>닉네임</td><td><input class='form-control' type='text' id='bfUserNcnm' name='bfUserNcnm' value='${proSession.userNcnm}'></td>";
		str += "<td><button type='button' class='btn btn-inverse-primary btn-fw' id='nickDupCk'>중복확인</button></td></tr>";
		str += "<tr><th>비밀번호</th><td colspan='2'><input class='form-control' type='password' id='bfUserPassword' name='bfUserPassword'></td></tr>";
		str += "<tr><th>비밀번호 확인</th><td colspan='2'><input class='form-control' type='password' id='bfUserPasswordCk'></td></tr>";
		str += "<tr><th>이메일</th><td><input class='form-control' type='email' id='bfEmail' value='${proSession.email}'></td><td><button type='button' id='emailDupCk' class='file-upload-browse btn btn-inverse-primary btn-fw'>중복확인</button></td></tr>";
		str += "<tr><th>이름</th><td colspan='2'><input class='form-control' type='text' id='bfUserNm' value='${proSession.userNm}'></td><td>";
		str += "<tr><th>전화번호</th><td><input type='text' class='form-control' id='bfProMbtlnum' name='bfProMbtlnum' value='${proSession.ProMbtlnum}'></td>";
		str += "<td><button type='button' class='btn btn-inverse-primary btn-fw' id='telCk'>본인인증</button></td></tr>";
		str += "<tr><th>성별</th>";
		if(gender == "SD01"){
			str += "<td colspan='2'>남자</td>";
			$("#sexdstnTy").val("SD01");
		}else if(gender == "SD02"){
			str += "<td colspan='2'>여자</td>";
			$("#sexdstnTy").val("SD02");
		}else if(gender == "SD03"){
			str += "<td colspan='2'>기타성별</td>";
			$("#sexdstnTy").val("SD03");
		}
		str += "<td></td></tr>";
		str += "<tr><th>우편번호</th><td><input type='text' readonly class='form-control' id='bfZip' placeholder='우편번호' value='${proSession.zip}'></td><td><button type='button' id='zipSelect' class='file-upload-browse btn btn-inverse-primary btn-fw'>우편번호 찾기</button></td></tr>";
		str += "<tr><th>주소</th><td><input type='text' class='form-control' id='bfAdres' placeholder='주소' readonly value='${proSession.adres}'></td><td><input required type='text' class='form-control' id='bfDetailAdres' placeholder='상세주소' required value='${proSession.detailAdres}'></td></tr></tbody></table>";

		var btnStr = "<button type='button' class='btn btn-light btn-rounded btn-fw' id='updating'>수정</button>";
		btnStr += "<button type='button' class='btn btn-light btn-rounded btn-fw' id='updateCancel'>취소</button>";
		
		$("#photoBtn").css("display","block");
		if($("#pfPhoto").val() == null || $("#pfPhoto").val() == ""){
			$("#photoDelete").css("display","none");
		}
		
		$("#mpTable").html(str);
		$("#mpBtn").html(btnStr);
	}//정보수정 확인 비밀번호 일치 시 폼 변경 끝
	
	$("#bfUserNm").on("change",function(){
		$("#userNm").val($("#bfUserNm").val());
		console.log("#userNm : " + $("#userNm").val());
	})
	$("#bfEmail").on("change",function(){
		$("#emailDup").val("change");
	})
	$("#bfProMbtlnum").on("change",function(){
		$("#telDup").val("change");
	})
	$("#bfUserNcnm").on("change",function(){
		$("#nickDup").val("change");
	})
	
	$("#bfDetailAdres").on("change",function(){
		$("#detailAdres").val($("#bfDetailAdres").val());
		console.log("#detailAdres : " + $("#detailAdres").val());
		$("#adres").val($("#bfAdres").val());
		console.log("#adres : " + $("#adres").val());
		$("#zip").val($("#bfZip").val());
		console.log("#zip : " + $("#zip").val());
	})
	
	$("#uploadFile").on("change",function(){
		console.log("이미지 변경");
		$("#photoZone").css("display","none");
		
		var fileName = $("#uploadFile").val();
		$(".upload-name").val(fileName.split('/').pop().split('\\').pop());
		$("#proProflPhoto").val(fileName);
		$("#pfPhoto").val(fileName);
		$("#photoDelete").css("display","block");
	});
	
	$("#uploadFile").on("change",imgCk);
	function imgCk(e){
		let files = e.target.files;
		
		console.log(files);
		let fileArr = Array.prototype.slice.call(files);
	
		fileArr.forEach(function(f){
			
			console.log(f);
			if(!f.type.match("image.*")){
				Swal.fire({
					title: '이미지파일만 등록 가능합니다.',
					icon: 'error',
					showCancelButton: false,
					confirmButtonText: '확인'
				}).then((result)=>{
					return;
				})
			}

			let reader = new FileReader();
			
			$("#newPhoto").html("");
			$("#photoZone1").css("display","none");
			
			reader.onload = function(e){
				$("#newPhoto").css({
					  "display":"block",
					  "background-image": "url(" + e.target.result + ")",
			          "width": "300px", 
			          "height": "300px",
			          "background-position": "center",
			          "background-size": "cover",
					  "margin-bottom":"20px",
					  "border-radius": "150px"
			    });
			}
			reader.readAsDataURL(f);
		});
	}
	
	//프로필사진 삭제
	$("#photoDelete").on("click",function(){
		var userId = $("#userId").val();
		Swal.fire({
			title: '프로필 사진을 삭제하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				$.ajax({
					url:"/pro/photoDelete",
					type:"post",
					data:{"userId":userId},
					success:function(res){
						Swal.fire({
							title: '사진 삭제 성공!!',
							icon: 'success',
							showCancelButton: false,
							confirmButtonText: '확인'
						}).then((result)=>{
							$("#photoDelete").css("display","none");
							$(".upload-name").val("");
							$("#proProflPhoto").val("");
							$("#pfPhoto").val("");
							$("#photoZone").css("display","none");
							$("#photoZone1").css("display","block");
						})
					}
				})
			}
		})
	}) //프로필 삭제 끝
	
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
                document.getElementById('bfZip').value = data.zonecode;	// --> 우편번호 칸
                document.getElementById("bfAdres").value = roadAddr;	// --> 도로명 주소 칸
                if(roadAddr !== ''){
                    document.getElementById("bfAdres").value = roadAddr;
                } else {
                    document.getElementById("bfAdres").value = extraRoadAddr;
                }
                var guideTextBox = document.getElementById("guide");
           }
        }).open();
        $("#bfDetailAdres").focus();
    });
	
// 	//파일 선택시 이름 출력
// 	$("#uploadFile").on('change',function(){
// 		var fileName = $("#uploadFile").val();
// 		$(".upload-name").val(fileName);
// 		$("#proProflPhoto").val(fileName);
// 		$("#photoDelete").css("display","block");
// 	});
	
	
	//닉네임 중복확인
	$("#nickDupCk").on("click",function(){
		console.log("닉네임중복");
		const bfUserNcnm = $("#bfUserNcnm").val();
		const test = /^[A-Za-z가-힣\d]{2,8}$/;
		
		if(test.test(bfUserNcnm)){
			$.ajax({
				url:"/pro/ncnmCk?userNcnm=" + bfUserNcnm,
				method:"get",
				dataType:"text",
//					beforeSend: function (xhr) {
//	                	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//	                },
				success:function(res){
					if(res==0){
						Swal.fire({
				            title: '사용할 수 있는 닉네임입니다.',
				            text: "이 닉네임을 사용하시겠습니까?",
				            icon: 'success',
				            showCancelButton: true,
				            confirmButtonText: '사용',
				            cancelButtonText: '취소'
				        }).then((result) => {
				            if (result.isConfirmed) {
				                $("#nickDup").val("ok");
				                $("#userNcnm").val($("#bfUserNcnm").val());
				            }else{
				            	$("#bfUserNcnm").focus();
				            }
				        })
					}else{
						Swal.fire({
				            title: '존재하는 닉네임입니다.',
				            text: "다른 닉네임을 입력하세요.",
				            icon: 'warning',
				            showCancelButton: false,
				            confirmButtonText: '확인'
				        }).then((result) => {
				        	$("#bfUserNcnm").focus();
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
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	$("#usersNcnm").focus();
	        })
		}
	}) //닉네임 중복확인 끝
	
	//이메일 중복확인
	$("#emailDupCk").on('click',function(){
		var email = $("#bfEmail").val();
		const emailTest = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		if(emailTest.test(email)){
			$.ajax({
				url:"/pro/emailCk?email=" + email,
				method:"get",
				dataType:"text",
//					beforeSend: function (xhr) {
//	                	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//	                },
				success:function(res){
					if(res==0){
						Swal.fire({
				            title: '사용할 수 있는 이메일입니다.',
				            text: "이 이메일을 사용하시겠습니까?",
				            icon: 'success',
				            showCancelButton: true,
				            confirmButtonText: '사용',
				            cancelButtonText: '취소'
				        }).then((result) => {
				            if (result.isConfirmed) {
				                $("#emailDup").val("ok");
				                $("#email").val($("#bfEmail").val());
				            }else{
				            	$("#bfEmail").focus();
				            }
				        })
					}else{
						Swal.fire({
				            title: '존재하는 이메일입니다.',
				            text: "이메일을 다시 입력하세요.",
				            icon: 'warning',
				            showCancelButton: false,
				            confirmButtonText: '확인'
				        }).then((result) => {
				        	$("#bfEmail").focus();
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
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	$("#bfEmail").focus();
	        })
		}
	})//이메일 중복확인 끝
	
	//폰번호 인증
	$("#telCk").on("click",function(){
		var bfproMbtlnum = $("#bfProMbtlnum").val();
		const test = /^010[\d]{8}$/;
		let number = '01021127977';
		console.log("전화번호 체크", bfproMbtlnum);
		
		if(test.test(bfproMbtlnum)){
			$.ajax({
                  type: "post",
                  url: "/pro/check/sendSMS",
                  cache: false,
                  data: { "proMbtlnum": bfproMbtlnum },
//	                  beforeSend: function (xhr) {
//	                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//	                  },
                  success: function (data) {
					console.log("인증번호 : " + data);
	                  if (data == "error") {
	                  	Swal.fire({
		     			    title: '전화번호 형식이 올바르지 않습니다.',
		     			    text: "전화번호를 확인해주세요.",
		     			    icon: 'error',
		     			    showCancelButton: false,
		     			    confirmButtonText: '확인',
	     			    }).then((result) => {
	     			    	$("#bfproMbtlnum").focus();
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
						            confirmButtonText: '확인',
						        }).then((result) => {
					                $("#telDup").val("ok");
					                $("#proMbtlnum").val($("#bfProMbtlnum").val());
					                
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
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	$("#bfproMbtlnum").focus();
	        })
		}
	}) //폰번호 인증 끝
	
	//업데이트 버튼 클릭 이벤트
	$("#updating").on("click",function(){
		console.log("수정진행");
		var bfUserNcnm = $("#bfUserNcnm").val();
		var bfUserPassword = $("#bfUserPassword").val();
		var bfUserPasswordCk = $("#bfUserPasswordCk").val();
		var bfproMbtlnum = $("#bfproMbtlnum").val();
		
		if(bfUserPassword == bfUserPasswordCk){
			$("#userPassword").val(bfUserPassword);
		}else{
			Swal.fire({
				title: '비밀번호가 서로 일치하지 않습니다.',
				text:'다시한번 확인해주세요.',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonText: '확인'
			})
		}
		
		if($("#nickDup").val() == "change"){
			Swal.fire({
	            title: '닉네임 중복확인을 하지 않으셨습니다.',
	            text: "중복확인을 하지 않으시면 닉네임은 변경되지 않습니다.",
	            icon: 'warning',
	            showCancelButton: false,
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	if(result.isConfirmed){
	        		$("#bfUserNcnm").focus();
	        	}else{
	        		Swal.fire({
	     				title: '닉네임은 변경되지 않습니다.',
	     				icon: 'error',
	     				showCancelButton: false,
	     				confirmButtonText: '확인',
	    			}).then((res) => {
	    				$("#nickDup").val("");
	    			})
	        	}
	        })
		}else if($("#telDup").val() == "change"){
			Swal.fire({
	            title: '휴대폰 본인인증을 하지 않으셨습니다.',
	            text: "본인인증을 하지 않으시면 닉네임은 변경되지 않습니다.",
	            icon: 'warning',
	            showCancelButton: false,
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	if(result.isConfirmed){
	        		$("#bfProMbtlnum").focus();
	        	}else{
	        		Swal.fire({
	     				title: '전화번호는 변경되지 않습니다.',
	     				icon: 'error',
	     				showCancelButton: false,
	     				confirmButtonText: '확인',
	    			}).then((res) => {
	    				$("#telDup").val("");
	    			})
	        	}
	        })
		}else if($("#emailDup").val() == "change"){
			Swal.fire({
	            title: '이메일 중복확인을 하지 않으셨습니다.',
	            text: "중복확인을 하지 않으시면 닉네임은 변경되지 않습니다.",
	            icon: 'warning',
	            showCancelButton: false,
				confirmButtonColor: '#7066e0',
	            confirmButtonText: '확인',
	        }).then((result) => {
	        	if(result.isConfirmed){
	        		$("#bfEmail").focus();
	        	}else{
	        		Swal.fire({
	     				title: '이메일은 변경되지 않습니다.',
	     				icon: 'error',
	     				showCancelButton: false,
	     				confirmButtonText: '확인',
	    			}).then((res) => {
	    				$("#emailDup").val("");
	    			})
	        	}
	        })
		}
		
		if($("#emailDup").val() != "change" && $("#telDup").val() != "change" && $("#nickDup").val() != "change"){
// 			console.log($("#userPassword").val() + $("#userNcnm").val() + $("#ProMbtlnum").val());
			Swal.fire({
	            title: '회원정보 수정 성공!!',
	            icon: 'success',
	            showCancelButton: false,
	            confirmButtonText: '확인',
	        }).then(result => {
				$("#updateForm").submit();
	        })
		}
		
	}) //업데이트 버튼클릭 이벤트 끝
	
	//취소버튼 클릭
	$("#updateCancel").on("click",function(){
		location.href="/pro/proMypage";
	})
})

$(function(){
	//회원정보수정
	$("#updatePro").on("click",function(){
		Swal.fire({
			title: '회원 정보 수정 페이지로\n 이동하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				location.href="/pro/proMypage?updPass=success";
			}
		})
	})
	//회원탈퇴
	$("#resignPro").on("click", function(){
		console.log("회원 탈퇴");
		$("#exampleModal-3").addClass("show");
		$("#modalBackdrop").show();
		$("#exampleModal-3").css("display", "block");
		$("#exampleModal-3").attr("aria-modal", "true");
	});

	$("#clsBtn").on("click", function(){
		$("#exampleModal-3").removeClass("show");
		$("#modalBackdrop").hide();
		$("#exampleModal-3").css("display", "none");
		$("#exampleModal-3").attr("aria-modal", "false");
	});
	
	$('input[type="checkbox"][name="resignReason"]').click(function(){
		if($(this).prop('checked')){
			$('input[type="checkbox"][name="resignReason"]').prop('checked',false);
			$(this).prop('checked', true);
			srvcRequstItyy = $('input[type="checkbox"][name="resignReason"]:checked').val();
			
			 if($('#other').prop('checked')){
		            $("#resignReasonInput").css("display","block");
		        } else {
		            $("#resignReasonInput").val("");
		            $("#resignReasonInput").css("display","none");
		            
		        }
		}
	});
	
	$("#resignSuccessChk").on("click", function(){
		   Swal.fire({
		        title: "탈퇴하시겠습니까?",
		        icon: "question",
		        showCancelButton: true,
		    }).then((result) => {
		        if (result.isConfirmed) {
		            Swal.fire({
		                title: "탈퇴 요청을 완료하였습니다.",
		                icon: "success"
		            }).then(() => {
		                $("#resignFrm").submit();
		            });
		        }
		    });
	});
	
})

</script>
<input type="hidden" id="sessionId" value="${proSession.userId}" />
<input type="hidden" id="nickDup" />
<input type="hidden" id="telDup" />
<input type="hidden" id="emailDup" />

<div class="sidenav">
	<p style="text-align:center; font-family: GMarketSansMedium"><b>MYPAGE MENU</b></p><hr>
	<a href="/pro/proMypage">마이페이지</a>
	<a href="/srvcBtfInqry/myBtfInqryList">받은 서비스 문의 내역</a>
	<a href="/srvcRequst/mySrvcRqList">받은 서비스 요청 내역</a>
	<a href="/pro/proMyClassList">원데이클래스</a>
	<a href="/pro/proPostList">게시글 관리</a>
	<a href="/srvcRqReview/proReMgmt">서비스요청 리뷰 관리</a>
	<a href="/oneInqry/myOneInqryList">1:1 문의 내역</a>
</div>

<div class="container col-10">
	<div class="card">
		<div class="card-body">
						<!-- 제목 -->
		<div >
			<img alt="마이페이지" src="../resources/images/마이.png" style="width:100px; height:auto; margin:0 0 20px 490px;">
			<h2 id="myPTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">마이 페이지</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 250px 0 250px;">
			<br>
		</div>
<!-- 			<p class="card-description"> -->
<!-- 				Add class -->
<%-- 				<code>.table-hover</code> --%>
<!-- 			</p> -->
			<form action="/pro/updating" id="updateForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="userNcnm" name="userNcnm" />
			<input type="hidden" id="userPassword" name="userPassword" />
			<input type="hidden" id="proMbtlnum" name="proMbtlnum" />
			<input type="hidden" id="proProflPhoto" name="proProflPhoto" />
			<input type="hidden" id="email" name="email" />
			<input type="hidden" id="userNm" name="userNm" />
			<input type="hidden" id="zip" name="zip" />
			<input type="hidden" id="adres" name="adres" />
			<input type="hidden" id="detailAdres" name="detailAdres" />
			<input type="hidden" id="sexdstnTy" name="sexdstnTy" />
			<input type="hidden" id="pfPhoto" value="${proSession.profile}">
			<input type="hidden" id="gender" value="${proSession.sexdstnTy}" />
			<input type="hidden" id="userId" name="userId" value="${proSession.userId}" />
				<div class="table-responsive pt-3">
					<div class="box_container">
						<div class="box">
							<div id="photoZone">
								<c:if test="${empty proSession.profile}">
									<img id="imgProfile" src="/images/2024/profile.jpg"
										style="float: left;" />
								</c:if>
								<c:if test="${not empty proSession.profile}">
									<img id="imgProfile" src="${proSession.profile}"
										style="float: left;" />
								</c:if>
							</div>
							<div id="photoZone1" style="display: none;">
								<img id="imgProfile" src="/images/2024/profile.jpg"
										style="float: left;" />
							</div>
							<div id="newPhoto" style="display: none;"></div>
							<div id="photoBtn" style="display: none;">
								<div class='form-group filebox'>
									<div class='input-group col-xs-12'>
										<input placeholder='변경할 프로필 사진을 골라주세요' id='donggyun' readonly
											class='upload-name form-control file-upload-info' /> <span
											class='input-group-append'> <label for='uploadFile'
											id='lab'>파일찾기</label> <input type='file' id='uploadFile'
											class='file-upload-browse btn btn-inverse-primary btn-fw'
											name='uploadFile'>
										</span>
										<button type='button' class='btn btn-inverse-link btn-fw'
											id='photoDelete'>사진 삭제</button>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					<table class="table table-hover" id="mpTable">
						<tbody>
							<tr>
								<th>아이디</th>
								<td colspan="2"><c:out value="${proSession.userId}"></c:out></td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td colspan="2"><c:out value="${proSession.userNcnm}"></c:out></td>
							</tr>
							<tr>
								<th>전문 분야</th>
								<td colspan="2"><c:out value="${proSession.spcltyRealmNm}"></c:out></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td colspan="2"><c:out value="${proSession.email}"></c:out></td>
							</tr>
							<tr>
								<th>이름</th>
								<td colspan="2"><c:out value="${proSession.userNm}"></c:out></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td colspan="2"><c:out value="${proSession.proMbtlnum}"></c:out></td>
							</tr>
							<tr>
								<th>성별</th>
								<c:if test="${proSession.sexdstnTy eq 'SD01'}">
									<td colspan="2">남자</td>
								</c:if>
								<c:if test="${proSession.sexdstnTy eq 'SD02'}">
									<td colspan="2">여자</td>
								</c:if>
								<c:if test="${proSession.sexdstnTy eq 'SD03'}">
									<td colspan="2">기타성별</td>
								</c:if>
							</tr>
							<tr>
								<th>우편번호</th>
								<td colspan="2"><c:out value="${proSession.zip}"></c:out></td>
							</tr>
							<tr>
								<th>주소</th>
								<td><c:out value="${proSession.adres}"></c:out></td>
								<td><c:out value="${proSession.detailAdres}"></c:out></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="mpBtn">
					<button type="button" class="btn btn-light btn-rounded btn-fw"
						id="updatePro">회원 정보 수정</button>
					<button type="button" class="btn btn-light btn-rounded btn-fw" data-bs-toggle="modal"
						 data-bs-target="#exampleModal-3" id="resignPro">프로 탈퇴</button>	
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 프로 탈퇴 모달  -->
<div class="modal fade" id="exampleModal-3" tabindex="-1"
	aria-labelledby="exampleModalLabel-3"
	style="display: none; padding-right: 17px;" aria-modal="false"
	role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel-3">탈퇴 사유를 선택해주세요.</h5>
				<button type="button" class="close" data-bs-dismiss="modal"
					aria-label="Close">
				</button>
			</div>
			<div class="modal-body">
				<form id="resignFrm" action="/oneInqry/resignPro" method="post">
					<input type="hidden" name="userId" id="userId" value="${proSession.userId}"/>
					<div class="form-group">
						<div class="form-check">
							<label class="form-check-label"> 
							<input type="checkbox" class="form-check-input" name="resignReason" id="resignReason" value="이용 빈도 낮음">이용 빈도 낮음
							<i class="input-helper"></i><i class="input-helper"></i></label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" name="resignReason" id="resignReason" value="사이트 이용의 불편함">사이트 이용의 불편함
							 <i class="input-helper"></i>
							 <i class="input-helper"></i></label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" name="resignReason" id="resignReason" value="탈퇴 후 재가입"> 탈퇴 후 재가입
							 <i class="input-helper"></i>
							 <i class="input-helper"></i></label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" id="other" name="resignReason" value="기타"> 기타
							 <i class="input-helper"></i>
							 <i class="input-helper"></i></label>
						</div>
						<textarea class="form-control" id="resignReasonInput" name="resignReasonInput" style="display: none;" rows="2" cols="5"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-inverse-primary" id="resignSuccessChk">탈퇴하기</button>
				<button type="button" class="btn btn-inverse-secondary" data-bs-dismiss="modal" id="clsBtn">닫기</button>
			</div>
		</div>
	</div>
</div>
<div id="modalBackdrop"></div>