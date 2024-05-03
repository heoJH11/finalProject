<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.dropdown {
    margin-right: 20px; 
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
button,h4{
	font-family: 'GmarketSansMedium';
}

</style>
<script>
$(document).ready(function(){
	
	$("#memberLogout").on("click",function(){
		let memLogout = confirm("로그아웃하시겠습니까?");
		if(memLogout){
			location.href="/member/memberLogout";
		}
	})
	
	$("#proLogout").on("click",function(){
		let proLogout = confirm("로그아웃하시겠습니까?");
		if(proLogout){
			location.href="/pro/proLogout";
		}
	})
	
	$("#admLogout").on("click",function(){
    Swal.fire({
        title: '로그아웃 성공',
        text: "안녕히 가세요 오늘도 누네띠네였습니다.",
        icon: 'success',
        showCancelButton: false,
		confirmButtonColor: '#7066e0',
        confirmButtonText: '확인',
    }).then((result) => {
        // 확인 버튼을 눌렀을 때만 로그아웃 처리를 진행합니다.
        if (result.isConfirmed) {
            location.href = "/pro/admLogout";
        }
    });
});

	$("#manageMain").on("click",function(){
		location.href="/manage/notice";
	})
	$("").on("click",function(){
		location.href="";
	})
	$("#proBkmkPage").on("click",function(){
	var memId = $("#userId").val();
	location.href="/proBkmk/detail?memId="+memId;
	})
})
</script>
<div class="">
<!-- <div class="" style="margin: 0px 235px 0px 235px;"> -->
	<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
<!--         <a class="navbar-brand brand-logo mr-5" href="../main"><img src="/resources/images/누네띠네2.png" class="mr-2" alt="logo" style="width: 60%; height: auto;"></a> -->
		<a class="navbar-brand brand-logo mr-5" href="../main"><img src="/resources/images/누네띠네.png" class="mr-2" alt="logo" style="width: 70%; height: auto;"></a>
<!--         <a class="navbar-brand brand-logo-mini" href="../main"><img src="/resources/images/누네띠네.png" alt="logo" style="width: 50%; height: auto;"></a> -->
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <!-- /////////////////////////////////////////////////////////////////////////////////////////// -->		
		

    
                    
<!-- 			<div class="dropdown"> -->
<!--                       <button class="btn btn-inverse-light btn-fw" id="manageMain" type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--                         <i class="mdi mdi-clipboard-outline text-primary"></i> -->
<!--                         <span class="menu-title text-primary">메인으로</span>			 -->
<!--                       </button> -->
<!--                     </div> -->
                    
                
              
                    
        
			
<!-- 			<div class="dropdown"> -->
<!--                       <button class="btn btn-inverse-light btn-fw  dropdown-toggle text-primary" type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--                         <i class="mdi mdi-security text-primary"></i> -->
<!--                         <span class="menu-title text-primary">누네띠네</span>			 -->
<!--                       </button> -->
<!--                       <div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton2"> -->
<!--                         <a class="dropdown-item text-primary " href="">유저관리</a> -->
<!--                         <a class="dropdown-item text-primary" href="">공지사항</a> -->
<!--                         <a class="dropdown-item text-primary" href="">FAQ</a> -->
<!--                         <a class="dropdown-item text-primary" href="">1대1문의</a> -->
                        
<!--                       </div> -->
<!--                     </div> -->
                  
		
<!-- ------------------------------------------------------------------------------------ -->        

        <!-- ###################로그인 안되어있을 때#################### -->
         <ul class="navbar-nav navbar-nav-right">
         <c:if test="${memSession == null && proSession == null && admSession == null}">
          <li class="nav-item dropdown">
            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-account-key mx-0"></i>
<!--               <span class="count"></span> 이거 넣으면 위에 원생김. 알람있을때 확인용으로 쓰면 될듯-->
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
<!--               <p class="mb-0 font-weight-normal float-left dropdown-header">나의 알림</p> -->
              <a class="dropdown-item preview-item" href="/member/joinSelect">
                <div class="preview-thumbnail">
					<div class="preview-icon bg-success">
					  <i class="mdi mdi-camera-front-variant mx-0"></i>
					</div>
                </div>
                <div class="preview-item-content">
                  <h6 class="preview-subject font-weight-normal">회원가입</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    Join us
                  </p>
                </div>
              </a>
              <a class="dropdown-item preview-item" href="/member/memberLogin">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-warning">
                    <i class="ti-user mx-0"></i>
                  </div>
                </div>
                <div class="preview-item-content">
                  <h6 class="preview-subject font-weight-normal">회원 로그인</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    Member Login
                  </p>
                </div>
              </a>
              <a class="dropdown-item preview-item" href="/pro/proLogin">
                <div class="preview-thumbnail">
                  <div class="preview-icon bg-info">
                    <i class="ti-user mx-0"></i>
                  </div>
                </div>
                <div class="preview-item-content">
                  <h6 class="preview-subject font-weight-normal">프로 로그인</h6>
                  <p class="font-weight-light small-text mb-0 text-muted">
                    Pro login
                  </p>
                </div>
              </a>
            </div>
          </li>
         </c:if>
         </ul>
        <!-- ###################로그인 안되어있을 때 끝#################### -->
        
        <!-- ###################회원 로그인 되어있을 때######################### -->

        <!-- ###################회원 로그인 되어있을 때 끝######################### -->
        
        <!-- ###################프로 로그인 되어있을 때######################### -->

        <!-- ###################프로 로그인 되어있을 때 끝######################### -->
         
        <c:if test="${memSession == null && proSession == null && admSession !=null}">
       
<!--         <ul class="navbar-nav navbar-nav-right"> -->
<!-- 	        <li class="nav-item dropdown"> -->
<%-- 	        	<h4>${admSession.userNcnm} 님</h4> --%>
<!-- 	        </li> -->
<!--         </ul> -->
        	
<!--         <button type="button" id="admLogout" class="btn btn-inverse-primary btn-fw">로그아웃 -->
        	
<!--         </button> -->
        
        	<ul class="navbar-nav navbar-nav-right">
		    <li class="nav-item dropdown">
		        <a href="/manage/notice" style="text-decoration: none; color: inherit; font-family: 'GmarketSansMedium';">
		            <h4 style="display: inline-block; margin-top:10px; margin-right: 10px;">${admSession.userNcnm} 님</h4>
		        </a>
		        <button type="button" id="admLogout" class="btn btn-inverse-primary btn-fw" style="display: inline-block;">로그아웃</button>
		    </li>
			</ul>  
		        
        
        
        
        	
         <!--   <a class="" id="admLogout">
                <i class="mdi mdi-logout-variant text-primary"></i>
                	로그아웃
              </a> -->
       
        </c:if>
    
              
         </div>

        </ul>

      </div>
    </nav>
</div>