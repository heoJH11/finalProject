<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<!-- 동균 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!-- 동균 추가 끝 -->

<style>
@font-face {
   font-family: 'seolleimcool-SemiBold';
   src:
      url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2')
      format('woff2');
   font-weight: normal;
   font-style: normal;
}
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
h2{
   font-family: 'seolleimcool-SemiBold';
}
h6,input,a,label,div,button{
   font-family: 'GmarketSansMedium';
}
.result{
   width:150px;
   border-top:none;
   border-left:none;
   border-right:none;
}
#idModalClose, #pwModalClose{
   background-color:transparent;
   border:none;
}
#back{
   background-color: white;
   padding-top : 1px;
}
</style>
<script>
//전화번호 본인인증
$(function(){
   //자동완성
   document.getElementById("autoInsert").addEventListener("click",function(){
      console.log("자동완성");
      $("#proId").val("tldus111");
      $("#proMbtlnum").val("01074302398");
      $("#searchPwEmail").val("2398_@naver.com");
   })
   
   $("#telCk").on("click",function(){
      var proMbtlnum = $("#proMbtlnum").val();
      const test = /^010[\d]{4}[\d]{4}$/;
      console.log(proMbtlnum);
      if(test.test(proMbtlnum)){
         Swal.fire({
            title: '해당 휴대폰번호로 인증번호를 전송하였습니다.',
            icon: 'success',
            showCancelButton: false,
			confirmButtonColor: '#7066e0',
            confirmButtonText: '확인'
         })
         var str = '<input type="text" class="form-control mb-2 mr-sm-2" id="sendNum" name="sendNum">';
          str += '<button type="button" id="numCheck" class="btn btn-inverse-warning btn-fw btn-sm">본인인증</button>';
             $("#ckNum").html(str);
         $.ajax({
                 type: "post",
                 url: "/pro/check/sendSMS",
                 cache: false,
                 data: { "proMbtlnum": proMbtlnum },
   //               beforeSend: function (xhr) {
   //                  xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
   //               },
                 success: function (data) {
                    console.log("인증번호 : " + data);
                    $("#numCheck").on('click',function(){
                       if($("#sendNum").val() == data){ //인증번호 일치
                            Swal.fire({
                              title: '본인인증에 성공했습니다.',
                              icon: 'success',
                              showCancelButton: false,
              				confirmButtonColor: '#7066e0',
                              confirmButtonText: '확인'
                           }).then((result)=>{
                                $("#sendNum").attr("readonly",true);
                               $("#numCheck").attr("disabled",true);
                               $("#telCk").attr("disabled",true);
                               $("#phoneDupRes").val("ok");
                           })
                       }else{ //인증번호 틀릴때
                        Swal.fire({
                              title: '인증번호가 일치하지 않습니다.',
                              text:'다시 입력하세요.',
                              icon: 'warning',
                              showCancelButton: false,
              				confirmButtonColor: '#7066e0',
                              confirmButtonText: '확인'
                           }).then((result)=>{
                           $("#sendNum").focus();
                           })
                       }
                    })
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
   
   //전화번호 바뀌면 다시 인증
   $("#proMbtlnum").on("change",function(){
      $("#sendNum").attr("readonly",false);
        $("#numCheck").attr("disabled",false);
        $("#telCk").attr("disabled",false);
        $("#sendNum").val("");
        $("#phoneDupRes").val("");
   })
   
   //아이디 찾기
   $("#idSearch").on("click",function(){
      console.log("아이디 찾기");
      var userNm = $("#userNm").val();
      var email = $("#email").val();
      if(email == null){
         Swal.fire("이메일을 입력하세요.");
      }else if(userNm == null){
         Swal.fire("이름을 입력하세요.");
      }else{
         $.ajax({
            url:"/pro/idSearch",
            data:{"userNm":userNm, "email":email},
            type:"post",
//                 beforeSend: function (xhr) {
//                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//              },
            success:function(res){
               console.log("아이디찾기 성공 : ", res);
               if(!res){
                  Swal.fire({
                     title: '입력하신 정보와 일치하는 아이디가 존재하지 않습니다.',
                     text:'다시 입력해주세요.',
                     icon: 'warning',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인'
                  }).then((result)=>{
                     $("#userNm").focus();
                  })
               }else if(res.emplyrTy == "warn"){
                  Swal.fire({
                     title: '입력하신 정보와 일치하는 아이디가 존재하지 않습니다.',
                     text:'다시 입력해주세요.',
                     icon: 'warning',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인'
                  }).then((result)=>{
                     $("#userNm").focus();
                  })
               }else{
                  if(res.emplyrTy != "ET02"){
                     Swal.fire({
                        title: '검색하신 내용은 일반회원의 아이디 입니다.',
                        text:'로그인시 주의하세요.',
                        icon: 'info',
                        showCancelButton: false,
        				confirmButtonColor: '#7066e0',
                        confirmButtonText: '확인'
                     }).then((result)=>{
                        $("#resultId").val(res.userId);
                     })
                  }else{
                     Swal.fire({
                        title: '아이디 검색 성공.',
                        text:'하단의 검색 결과를 확인해주세요.',
                        icon: 'success',
                        showCancelButton: false,
        				confirmButtonColor: '#7066e0',
                        confirmButtonText: '확인'
                     }).then((result)=>{
                        $("#resultId").val(res.userId);
                     })
                  }
               }
            }
         })
      }
   }) //아이디 찾기 끝
   
   //비밀번호 찾기
   $("#pwSearch").on("click",function(){
      console.log("비밀번호 찾기");
      var phoneDupRes = $("#phoneDupRes").val();
      var proId = $("#proId").val();
      var proMbtlnum = $("#proMbtlnum").val();
      var email = $("#searchPwEmail").val();
      
      if(phoneDupRes != "ok"){
         Swal.fire("휴대폰 본인인증을 해주세요.");
      }else if(userId == null){
         Swal.fire("아이디를 입력하세요.");
      }else if(email == null){
         Swal.fire("이메일을 입력하세요.");
      }else if(phoneDupRes!="ok"){
         Swal.fire("휴대폰 본인인증을 진행해주세요.");
      }else{
         Swal.fire({
            title: '비밀번호 찾기를 실행하시겠습니까?',
            text:'메일로 임시비밀번호가 발송되며 비밀번호가 변경됩니다.',
            icon: 'question',
            showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
            confirmButtonText: '사용',
            cancelButtonText: '취소'
         }).then((result)=>{
            if(result.isConfirmed){
               $.ajax({
                  url:"/pro/pwSearch",
                  data:{"proMbtlnum":proMbtlnum, "proId":proId, "email":email},
                  type:"post",
//                       beforeSend: function (xhr) {
//                       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
//                    },
                  success:function(res){
//                      console.log("비밀번호찾기 성공 : ", res);
                     if(!res){
                        Swal.fire({
                           title: '입력하신 정보와 일치하는 아이디가 존재하지 않습니다.',
                           text:'다시 입력해주세요.',
                           icon: 'warning',
                           showCancelButton: false,
	           				confirmButtonColor: '#7066e0',
                           confirmButtonText: '확인'
                        }).then((result)=>{
                           $("#proId").focus();
                        })
                     }else if(res.emplyrTy == "warn"){
                        Swal.fire({
                           title: '입력하신 정보와 일치하는 아이디가 존재하지 않습니다.',
                           text:'다시 입력해주세요.',
                           icon: 'warning',
                           showCancelButton: false,
	           				confirmButtonColor: '#7066e0',
                           confirmButtonText: '확인'
                        })
                     }else{
                        if(res.emplyrTy != "ET02"){
//                            console.log("res.emplyrTy : " + res.emplyrTy);
                           Swal.fire({
                              title: '검색하신 내용은 일반회원의 아이디 입니다.',
                              icon: 'warning',
                              showCancelButton: false,
              				confirmButtonColor: '#7066e0',
                              confirmButtonText: '확인'
                           })
                        }else{
                           Swal.fire({
                              title: '비밀번호를 입력하신 이메일로 전송했습니다.',
                              icon: 'warning',
                              showCancelButton: false,
              				confirmButtonColor: '#7066e0',
                              confirmButtonText: '확인'
                           })
                           console.log("임시비밀번호 : " + res.imsiPw);
                        }
                     }
                  }
               })
            }else{
               return;
            }
         })
      }
   }) //비밀번호 찾기 끝
   
   //아이디 찾기 모달 닫을때 이벤트
   $("#idModalClose").on("click",function(){
      $("#userNm").val("");
      $("#email").val("");
      $("#resultId").val("");
   })
   //비밀번호 찾기 모달 닫을때 이벤트
   $("#pwModalClose").on("click",function(){
      $("#proId").val("");
      $("#proMbtlnum").val("");
      $("#searchPwEmail").val("");
      $("#ckNum").html("");
   })
   
   $("#userPassword").on("keyup", function (key) {
        if (key.keyCode == 13) {
           proLogin();
        }
    })
    $("#userId").on("keyup", function (key) {
        if (key.keyCode == 13) {
           proLogin();
        }
    })
    
  //아이디 기억하기 시작
   let key = getCookie("key");
   $("#userId").val(key);

   if($("#userId").val() != ""){
      $("#idSaveCk").attr("checked",true);
   }

   $("#idSaveCk").change(function(){
      if($("#idSaveCk").is(":checked")){
         setCookie("key", $("#userId").val(), 3);
      }else{
         deleteCookie("key");
      }
   })

   $("#userId").keyup(function(){
      if($("#idSaveCk").is(":checked")){
         setCookie("key", $("#userId").val(), 3);
      }
   })
   //아이디 기억하기 끝
   
})
let setCookie = function(cookieName, value, exdays){
   let exdate = new Date();
   exdate.setDate(exdate.getDate() + exdays);

   let cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
   document.cookie = cookieName + "=" + cookieValue;
}

function deleteCookie(cookieName){
   let expireDate = new Date();
   expireDate.setDate(expireDate.getDate() - 1);
   document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName){
   cookieName = cookieName + "=";

   let cookieData = document.cookie;
   let start = cookieData.indexOf(cookieName);
   let cookieValue = '';

   if(start != -1){
      start += cookieName.length;
      let end = cookieData.indexOf(';',start);
      if(end == -1) end = cookieData.length;
      cookieValue = cookieData.substring(start, end);
   }

   return unescape(cookieValue);
}
//로그인처리
var proLogin = function(){
   var userId = $("#userId").val();
   var userPassword = $("#userPassword").val();
   data = {
         "userId":userId,
         "userPassword":userPassword
   }
   console.log("로그인버튼 / " + userId + "/" + userPassword +"/",data);
   $.ajax({
      type:"post",
      url:"/pro/proLogin",
      data:data,
      success : function(res) {
         /*
         1. 프로
         res : {"zip":"10236","userNm":"테스트프로","proMbtlnum":"01066666666","userPassword":"asdasd","userNcnm":"testP12"
            ,"profile":"/images/2024/03/29/2ca84211-3664-4295-b6b9-b591d4ddc727_spongebob.png","cnt":1,"firstSRCode":"운동"
            ,"detailAdres":"대","type":"ET02","userId":"testPro","spcltyRealmNm":"운동 >> 격투종목 >> 태권도","secondSRCode":"격투종목"
            ,"thirdsrCode":"태권도","adres":"경기 고양시 일산서구 하이파크1로 64","sexdstnTy":"SD02","email":"test@test.net"}
   
         2. 관리자
         res : {"zip":"-","userPassword":"asdasd","userNcnm":"테스트관리자","cnt":1,"adres":"-","detailAdres":"-","type":"ET03","userId":"testAdmin"}
            
         3. 일반
         res : {zip: '13544', userNm: '테스023', userPassword: 'asdasd', userNcnm: 'tesU023', mberMbtlnum: '01099992223', …}
         */
         console.log("res : " + JSON.stringify(res));
         
         console.log("res.cnt : " + res.cnt);
         console.log("res : " , res);
         
         if (res.cnt == 1) {
            if(res.type == "ET02"){
               Swal.fire({
                     title: '로그인 성공',
                     html: '누네띠네에 오신것을 환영합니다.<br>어서오십시오.',
                     icon: 'success',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '메인으로',
                  }).then((result) => {
                     if(res.changePwCk == 1){
                        Swal.fire({
                            title: '입력하신 비밀번호는 임시비밀번호입니다.',
                            text: "마이페이지에서 비밀번호 변경을 해주세요.",
                            icon: 'info',
                            showCancelButton: false,
            				confirmButtonColor: '#7066e0',
                            confirmButtonText: '확인',
                         }).then((result) => {
                           location.href="/main"
                         })
                     }else{
                        location.href="/main"
                     }
                  })
            }else if(res.type == "ET03") {
               Swal.fire({
                     title: '로그인 성공',
                     html: '누네띠네에 오신것을 환영합니다.<br>어서오십시오.',
                     icon: 'success',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '관리자페이지로',
                  }).then((result) => {
                     location.href="/manage/notice"
                  })
                   
            }else{ //회원아이디일 때
               Swal.fire({
                     title: '로그인 실패',
                     html: '입력하신 정보는 프로가 아닌 회원 아이디입니다.<br> 회원 로그인을 이용해주세요.',
                     icon: 'warning',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인',
                  }).then((result) => {
                     $("#userId").focus();
                  })
            }
         }else if(res.cnt == 2){
            //동균 추가 부분
               let date = new Date(res.userEndDt);
               let date2 = moment(date, "ddd MMM DD YYYY HH:mm:ss [GMT]Z").format('YYYY-MM-DD');
               Swal.fire({
                     title: '로그인 실패',
                     html: "해당 계정은 정지 상태입니다"+`<br>`+"정지 종료일 : "+date2,
                     icon: 'error',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인',
                  }).then((result) => {
                     $("#userId").focus();
                  })
                   return;
         //동균 추가 부분 끝
         } else {
            if(res.type == "ET01") {
               Swal.fire({
                     title: '로그인 실패',
                     icon: 'warning',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인',
                     html: '입력하신 정보는 프로가 아닌 회원 아이디입니다.<br> 회원 로그인을 이용해주세요.',
                  }).then((result) => {
                     $("#userId").focus();
                  })
            }else{ //회원아이디일 때
               Swal.fire({
                     title: '로그인 실패',
                     icon: 'error',
                     showCancelButton: false,
     				confirmButtonColor: '#7066e0',
                     confirmButtonText: '확인',
                     html: '아이디 혹은 비밀번호가 올바르지 않습니다.<br>다시 한번 확인해주세요.',
                    }).then((result) => {
                       $("#userId").focus();
                   })
            }
         }
      }
   });
}
</script>
   <div class="container-scroller" style="height:800px;">
     <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-stretch auth auth-img-bg">
        <div class="row flex-grow">
         <div class="col-lg-6 d-flex align-items-center justify-content-center" style="margin:-120px 0 0 -50px;">
           <div class="auth-form-transparent text-left p-3" style="margin:-50px -50px;">
            <div class="brand-logo">
               <img src="/resources/images/누네띠네.png" alt="logo" style="width: 40%; height: auto;">
            </div>
            <h2 style="margin-bottom:10px; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 로그인</h2>
            <h6 class="font-weight-light">눈에띄는 당신의 재능을 펼쳐보세요.</h6>
            <form class="pt-3">
               <div class="form-group">
                 <input type="text" class="form-control form-control-lg" id="userId" name="userId" placeholder="아이디" required>
               </div>
               <div class="form-group">
                 <input type="password" class="form-control form-control-lg" id="userPassword" name="userPassword" placeholder="비밀번호" required>
               </div>
               <div class="mt-3">
                 <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" onclick="proLogin()">로그인</a>
               </div>
               <div class="my-4 d-flex justify-content-between align-items-center">
                 <div class="form-check">
                  <label class="form-check-label text-muted">
                    <input type="checkbox" class="form-check-input" id='idSaveCk'>
                       아이디 기억
                  <i class="input-helper"></i></label>
                 </div>
                 <a href="#" class="auth-link text-black" data-toggle="modal" data-target="#idModal">아이디 찾기</a>
                 <a href="#" class="auth-link text-black" data-toggle="modal" data-target="#pwModal">비밀번호 찾기</a>
   
               </div>
               <div class="mb-2">
   <!--                   <button type="button" class="btn btn-block btn-facebook auth-form-btn"> -->
   <!--                     <i class="ti-facebook mr-2"></i>Connect using facebook -->
   <!--                   </button> -->
               </div>
               <div class="text-center mt-4 font-weight-light">
                    아이디가 없으신가요? <a href="/pro/proJoin" class="text-primary">프로 회원가입</a>
               </div>
              </form>
           </div>
         </div>
         <div class="col-lg-6" style="margin-left:-70px;">
         <img src="../resources/images/사람2.jpg" style="max-width: 120%;"  />
         </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
     </div>
     <!-- page-body-wrapper ends -->
   </div>

  
<!-- 아이디 찾기 Modal -->
<div class="modal fade" id="idModal" tabindex="-1" aria-labelledby="idModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">아이디 찾기</h5>
        <button type="button" id="idModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
      </div>
      <div class="modal-body">
      이름<input type="text" class="form-control mb-1 mr-sm-1" id="userNm" name="userNm">
      이메일<input type="text" class="form-control mb-1 mr-sm-1" id="email" name="email">
      </div>
      <div class="modal-footer" id="idDiv">
         검색 결과 : <input type="text" class="form-control result" id="resultId">
<!--         <button type="button" class="btn btn-inverse-secondary btn-fw" data-dismiss="modal">닫기</button> -->
        <button type="button" id="idSearch" class="btn btn-inverse-primary btn-fw">찾기</button>
      </div>
    </div>
  </div>
</div>

<!-- 비밀번호 찾기 Modal -->
<div class="modal fade" id="pwModal" tabindex="-1"  data-backdrop="static" aria-labelledby="pwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 찾기</h5>
        <button type="button" id="pwModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
      </div>
      <div class="modal-body">
      아이디<input type="text" class="form-control mb-1 mr-sm-1" id="proId" name="proId">
      전화번호
      <div class="form-inline">
         <input type="text" class="form-control mb-2 mr-sm-2" id="proMbtlnum" name="proMbtlnum">
         <button type="button" id="telCk" class="btn btn-inverse-warning btn-fw btn-sm">인증번호 발송</button>
         <input type="hidden" id="phoneDupRes" name="phoneDupRes">
      </div>
      <div class="form-inline" id="ckNum"></div>
      이메일<input type="text" class="form-control mb-1 mr-sm-1" id="searchPwEmail" name="email">
      </div>
      <div class="modal-footer" id="pwDiv">
<!--         <button type="button" class="btn btn-inverse-secondary btn-fw" data-dismiss="modal">닫기</button> -->
      <button type="button" id="autoInsert" class="btn btn-light" style="float:right;">자동완성</button>
        <button type="button" id="pwSearch" class="btn btn-inverse-primary btn-fw">찾기</button>
      </div>
    </div>
  </div>
</div>