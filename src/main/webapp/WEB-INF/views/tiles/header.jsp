<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">

<style>
.dropdown {
    margin-right: 25px; 
}

@font-face {
    font-family: 'GmarketSansLight';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.menu-title {
	font-family: 'GmarketSansMedium';
	font-size: 18px;
	color:#4e4c7c;
}

.dropdown-item{
	font-family: 'GmarketSansMedium';
	color:#6c7383;
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
$(document).ready(function(){
    function loadPage(){
		console.log('프로프로필 얼랏창');
		  var sessionId = '${proSession.userId}';
		  
		  console.log('sessionId: ' + sessionId);
	    	$.ajax({
	    		type:'GET',
	    		url:'/proProfl/getProId',
	    		data: { sessionId : sessionId },
	    		dataType:'text',
	    		success: function(data){
	    			var aTag = $("#proProfl");
	    			console.log('data :',data);
	    			if(!data){
	    				aTag.attr("href","/proProfl/create");
	    			}else {
	    				aTag.attr("href",`/proProfl/detail?proId=\${sessionId}`);	    	
	    			}
	    			aTag.on("click",function(){
	    				event.preventDefault();
	    			   if(this.href.includes("create")){
	    				   Swal.fire({
	    					   title: "프로필이 없습니다. \n\n 프로필을 생성하시겠습니까?",
	    					   confirmButtonText: "확인",
	    					   icon: 'question',
	    					 }).then((result) => {
	    					   if (result.isConfirmed) {
	    					      location.href = this.href
	    					   } else if (result.isDenied) {
	    					   }
	    					 });    	    				   
                       }else {
	    				   Swal.fire({
	    					   title: "프로 프로필로 이동합니다",
	    					   confirmButtonText: "확인",
	    					   icon: 'success',
	    					 }).then((result) => {
	    					   if (result.isConfirmed) {
	    					      location.href = this.href
	    					   } else if (result.isDenied) {
	    					   }
	    					 });
                      }
	    	  })
	    			
	    		
	    		},
	    		error:function(xhr,status,error){
	    			console.error('error : ', error);
	    		}
	    	});
	    }
 	    loadPage();
	
	$("#memberLogout").on("click",function(){
		Swal.fire({
			title: '로그아웃하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				location.href="/member/memberLogout";
			}
		})
	})
	
	$("#proLogout").on("click",function(){
		Swal.fire({
			title: '로그아웃하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				location.href="/pro/proLogout";
			}
		})
	})
	
	$("#admLogout").on("click",function(){
		Swal.fire({
			title: '로그아웃하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				location.href="/pro/admLogout";
			}
		})
	})
	
	$("#proSearch").on("click",function(){
	location.href="/proSearch/proList";
	})
	
	$("#memberMypage").on("click",function(){
		location.href="/member/memberUpdateCk";
	})
	
	$("#proMypage").on("click",function(){
		location.href="/pro/proUpdateCk";
	})
	
	$("#ondyclBtn").on("click",function(){
		location.href="/onedayClass/main";
	})
	
	$("#todayMeetingBtn").on("click",function(){
		location.href="/todayMeeting/main";
	})
	
// 	$("#prostory").on("click",function(){
// 		location.href="/prostory/main2";
// 	})
	
	$("#prostory").on("click",function(){
		location.href="/prostory/main";
	})
	
	$("#proBkmkPage").on("click",function(){
	var memId = $("#userId").val();
	location.href="/proBkmk/detail?memId="+memId;
	})
	
	$("#mberShoppingCart").on("click",function(){
		let mberId = '${memSession.userId}';
		console.log(mberId);
		location.href="/onedayClass/mberShoppingCart?mberId=" + mberId;
	})
})
</script>
<div class="header" style="margin: 0px 235px">
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row" style="background:white;">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo mr-5" href="../main"><img src="/resources/images/누네띠네.png" class="mr-2" alt="logo" style=" margin-left:40px; width: 70%; height: auto;"></a>
        <a class="navbar-brand brand-logo-mini" href="../main"><img src="/resources/images/눈.png" alt="logo" style="width: 50%; height: auto;"></a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end" style="height:80px;">
        <!-- /////////////////////////////////////////////////////////////////////////////////////////// -->		
		
		<div class="dropdown">
                      <button class="btn btn-inverse-light btn-fw " type="button" id="proSearch" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">                     	
                        <span class="menu-title" >프로찾기</span>                     	      
                      </button>
                       <c:if test="${memSession == null && proSession != null}">
                       <button class="btn btn-inverse-light btn-fw " type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                       		onclick="location.href='/srvcBtfInqry/btfInqryList'">                     	
                        <span class="menu-title">받은문의</span>                     	      
                      </button>
                       </c:if>
        </div>
                       <c:if test="${memSession == null && proSession != null}">
        <div class="dropdown">
                       <button class="btn btn-inverse-light btn-fw " type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                       		onclick="location.href='/srvcRequst/srvcRqList'">                     	
                        <span class="menu-title">받은요청</span>                     	      
                      </button>
        </div>
                       </c:if>
                    
		<div class="dropdown">
			<button class="btn btn-inverse-light btn-fw" id="ondyclBtn" type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="menu-title">원데이클래스</span>			
			</button>
		</div>
                    
		<div class="dropdown">
			<button class="btn btn-inverse-light btn-fw  dropdown-toggle text-primary" type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			  <span class="menu-title">게시판</span>			
			</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton2">
		<!--                         <h6 class="dropdown-header">자유게시판</h6> -->
	             <a class="dropdown-item" href="/lbrtybbsctt/read2">자유게시판</a>
	             <a class="dropdown-item" href="/reviewBoard/main">후기게시판</a>
	             <a class="dropdown-item" href="/proHunting/list">프로 구인게시판</a>
	             <a class="dropdown-item" href="/proCprtnBbsctt/list">프로 협업게시판</a>
           	</div>
		</div>
                    
		<div class="dropdown">
		        <button class="btn btn-inverse-light btn-fw" type="button" id="todayMeetingBtn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<span class="menu-title">오늘모임
						<a href="//reviewBoard/main"></a>
					</span>
		        </button>
		</div>    
                    
		<div class="dropdown">
			<button class="btn btn-inverse-light btn-fw  " type="button" id="prostory" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="menu-title">프로이야기</span>			
			</button>
		</div>           
			
		<div class="dropdown">
			<button class="btn btn-inverse-light btn-fw  dropdown-toggle text-primary" type="button" id="dropdownMenuSizeButton2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="menu-title">누네띠네</span>			
			</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton2">
		<!--                         <h6 class="dropdown-header" href="#">유저검색</h6> -->
<!-- 				<a class="dropdown-item text-primary " href="/usersSearch/list">유저관리</a> -->
				<a class="dropdown-item" href="/admin/notice">공지사항</a>
				<a class="dropdown-item" href="/faq/list">FAQ</a>
				<a class="dropdown-item" href="/oneInqry/oneInqryList">1대1문의</a>
		            
			</div>
		</div>
                  
		
<!-- ------------------------------------------------------------------------------------ -->        
        
        
        
        <ul class="navbar-nav navbar-nav-right">
        
        <!-- ###################로그인 안되어있을 때#################### -->
         <c:if test="${memSession == null && proSession == null && admSession == null}">
          <li class="nav-item dropdown" style="margin-right:100px; margin-top:20px;">
            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="mdi mdi-account-key mx-0" style="font-size:1.8rem;"></i>
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
        <c:if test="${memSession != null && proSession == null}">
        <!-- 알림 -->
        <ul class="navbar-nav navbar-nav-right">
	        
        </ul>
        <ul class="navbar-nav navbar-nav-right" style="margin-right:100px; margin-top:20px;">

          
          <!-- 개인정보창 -->
          <li class="nav-item dropdown">
	        	<h4 style="margin-right:5px; font-family: 'GmarketSansMedium';">${memSession.userNcnm} 님</h4>
	        </li>
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown" aria-expanded="false" style="margin-top:-10px;">
	            <c:if test="${empty memSession.profile}">
					<img src="/images/2024/profile.jpg" style="float:left;" />
				</c:if>
				<c:if test="${not empty memSession.profile}">
					<img src="${memSession.profile}" style="float:left;" />
				</c:if>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
				<div style="border-radius:20px; text-align:center;">
					<c:if test="${empty memSession.profile}">
						<img src="/images/2024/profile.jpg" style="width:90px;height:90px;"/>
					</c:if>
					<c:if test="${not empty memSession.profile}">
						<img src="${memSession.profile}" style="width:90px;height:90px;"/>
					</c:if>
				</div>
              <div>
              <p class="mb-0 font-weight-normal float-left dropdown-header" style="margin:10px 0 0 25px; background-color:#fcf6e7; border-radius:20px; border:none;" >
	              <span style="font-family: 'GmarketSansLight';">ID : ${memSession.userId}</span><br>
	              <span style="font-family: 'GmarketSansLight';">닉네임 : ${memSession.userNcnm}</span>
              </p>
              </div>
            
              <a class="dropdown-item" id="memberMypage">
                <i class="mdi mdi-account-box text-primary"></i>
                	마이페이지
              </a>
              <a class="dropdown-item" id="proBkmkPage">
              <input type="hidden" id="userId" value="${memSession.userId}">
                <i class="mdi mdi-star-outline text-primary"></i>
                	프로 즐겨찾기
              </a>
              <a class="dropdown-item" id="mberShoppingCart">
                <i class="mdi mdi-cart-outline icon-lg"></i>
                	원데이클래스 장바구니
              </a>
              <a class="dropdown-item" id="memberLogout">
                <i class="mdi mdi-logout-variant text-primary"></i>
                	로그아웃
              </a>
            </div>
          </li>
<!--           <li class="nav-item nav-settings d-none d-lg-flex"> -->
<!--             <a class="nav-link" href="#"> -->
<!--               <i class="icon-ellipsis"></i> -->
<!--             </a> -->
<!--           </li> -->
        </ul>
        </c:if>
        <!-- ###################회원 로그인 되어있을 때 끝######################### -->
        
        
        <!-- ###################프로 로그인 되어있을 때######################### -->
        <c:if test="${memSession == null && proSession != null}">
        <!-- 알림 -->
        <ul class="navbar-nav navbar-nav-right">
	        
        </ul>
        
        <ul class="navbar-nav navbar-nav-right" style="margin-right:100px; margin-top:20px;">

          
          <!-- 개인정보창 -->
          <li class="nav-item dropdown">
	        	<h4 style="margin-right:5px; font-family: 'GmarketSansMedium';">${proSession.userNcnm} 님</h4>
	        </li>
          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown" aria-expanded="false" style="margin-top:-10px;">
			<c:if test="${empty proSession.profile}">
				<img src="/images/2024/profile.jpg" style="float:left;" />
			</c:if>
			<c:if test="${not empty proSession.profile}">
				<img src="${proSession.profile}" style="float:left;" />
			</c:if>
            </a>
            
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown" style="width:200px;">
			<div style="border-radius:20px; text-align:center;">
				<c:if test="${empty proSession.profile}">
					<img src="/images/2024/profile.jpg" style="width:90px;height:90px;"/>
				</c:if>
				<c:if test="${not empty proSession.profile}">
					<img src="${proSession.profile}" style="width:90px;height:90px;"/>
				</c:if>
			</div>
			<div>
              <p class="mb-0 font-weight-normal float-left dropdown-header" style="margin:10px 0 0 20px; background-color:#fcf6e7; border-radius:20px; border:none; text-align:center;">
	              <span style="font-family: 'GmarketSansLight';">ID : ${proSession.userId}</span><br>
	              <span style="font-family: 'GmarketSansLight';">닉네임 : ${proSession.userNcnm}</span>
              </p>
            </div>
              <a class="dropdown-item" id="proMypage">
                <i class="mdi mdi-account-box text-primary"></i>
                	마이페이지
              </a>
              <a class="dropdown-item" id="proProfl" href="#">
                <i class="mdi mdi-account-box-outline text-primary"></i>
                	프로 프로필
              </a>

              <a class="dropdown-item" id="proLogout">
                <i class="mdi mdi-logout-variant text-primary"></i>
                	로그아웃
              </a>
            </div>
          </li>
<!--           <li class="nav-item nav-settings d-none d-lg-flex"> -->
<!--             <a class="nav-link" href="#"> -->
<!--               <i class="icon-ellipsis"></i> -->
<!--             </a> -->
<!--           </li> -->
        </ul>
        </c:if>
        <!-- ###################프로 로그인 되어있을 때 끝######################### -->
         
        <c:if test="${memSession == null && proSession == null && admSession !=null}">
        <!-- 알림 -->
        <%-- <ul class="navbar-nav navbar-nav-right">
	        <li class="nav-item dropdown">
	        	<h4>${admSession.userNcnm} 님</h4>
	        </li>
        </ul>
        
              <a class="" id="admLogout">
                <i class="mdi mdi-logout-variant text-primary"></i>
                	로그아웃
              </a> --%>
              
         <ul class="navbar-nav navbar-nav-right">
		    <li class="nav-item dropdown">
		        <a href="/manage/notice" style="text-decoration: none; color: inherit;">
		            <h4 style="display: inline-block; margin-top:10px; margin-right: 10px;">${admSession.userNcnm} 님</h4>
		        </a>
		        <button type="button" id="admLogout" class="btn btn-inverse-primary btn-fw" style="display: inline-block;">로그아웃</button>
		    </li>
		</ul>  
              
       
        </c:if>
          
            </div>
<!--           <li class="nav-item nav-profile dropdown"> -->
<!--           	<button type="button" class="btn btn-inverse-primary btn-rounded btn-fw" onclick="joinBtn()">회원가입</button> -->
<!--           	<button type="button" class="btn btn-inverse-success btn-rounded btn-fw" onclick="memberLogin()">일반회원 로그인</button> -->
<!--           	<button type="button" class="btn btn-inverse-warning btn-rounded btn-fw" onclick="proLogin()">프로 로그인</button> -->
<!--             <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown"> -->
<!--               <img src="/resources/skydash/images/faces/face28.jpg" alt="profile"> -->
<!--             </a> -->
<!--             <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown"> -->
<!--               <a class="dropdown-item"> -->
<!--                 <i class="ti-settings text-primary"></i> -->
<!--                 Settings -->
<!--               </a> -->
<!--               <a class="dropdown-item"> -->
<!--                 <i class="ti-power-off text-primary"></i> -->
<!--                 Logout -->
<!--               </a> -->
<!--             </div> -->
<!--           </li> -->
<!--           <li class="nav-item nav-settings d-none d-lg-flex"> -->
<!--             <a class="nav-link" href="#"> -->
<!--               <i class="icon-ellipsis"></i> -->
<!--             </a> -->
<!--           </li> -->
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="icon-menu"></span>
        </button>
    </nav>
</div>