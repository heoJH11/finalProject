<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<style>
@font-face {
    font-family: 'TTHakgyoansimKossuyeomR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimKossuyeomR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

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
.ck-editor__editable {
	min-height: 400px;
	max-width: 845px;
}
label {
	display: block;
}
.content{
	border: 1px dotted #cecece;
}
.content-wrapper{
text-align: center;
}
.content img{
	max-width: 100%;
}
.comments ul{
	padding: 0;
	margin: 0;
	list-style-type: none;
}
.comments ul li{
	border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
}
.comments dt{
	margin-top: 5px;
}
.comments dd{
	margin-left: 26px;
} 	
.comments form textarea, .comments form button{
	float: left;
}
.comments li{
	clear: left;
}
.comments form textarea{
	width: 85%;
	height: 100px;
}
.comments form button{
	width: 15%;
	height: 100px;
}
/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
.comment form{
	display: block;
}
.comment{
	position: relative;
}
.comment .reply_icon{
	width: 8px;
	height: 8px;
	position: absolute;
	top: 10px;
	left: 30px;
}
.comments .user-img{
	width: 20px;
	height: 20px;
	border-radius: 50%;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.button {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.grid-container {
    display: grid;
    grid-template-columns: auto auto auto; /* 세 개의 열을 생성 */
    grid-gap: 10px; /* 그리드 아이템 사이의 간격을 지정 */
    justify-content: center; /* 그리드 아이템들을 가운데 정렬 */
}
@media (min-width: 992px)
.col-lg-6 {
    flex: 0 0 50%;
    /* max-width: 50%; */
}
.list-item {
    margin: 5px;
    overflow: hidden;
}
.list-star {
/*     height: 100%; /* 부모 요소인 .list-item의 높이를 100%로 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 수직 스크롤 추가 */
}
.list-star img {
max-width: 100%;		 /* 이미지의 최대 너비를 요소의 너비에 맞게 설정 */
height: auto; 			 /* 이미지의 높이를 자동으로 조정하여 가로세로 비율을 유지 */
border-radius: 100%; 	 /* 이미지를 원형으로 처리 */
overflow: hidden; 		 /* 이미지를 부모 요소의 경계에 맞춰 자르기 위해 overflow 속성 사용 */
}
.btn-clicked {
        background-color: #4CAF50; /* 변경할 색상 */
        color: white;
    }
.title {
/* text-align: left; */
margin-right: 30px; /* 제목과 좋아요 영역 사이의 간격 조절 */
}
.container, .container-fluid, .container-sm, .container-md, .container-lg, .container-xl {
    width: 100%;
}
 .title-like-area {
    display: flex;
     align-items: center;
 }
.like-area {
     display: flex;
     align-items: center;
 }
.like-area span {
  margin-right: 10px; /* 좋아요 아이콘과 텍스트 사이의 간격 조절 */
 }
 a{
color : red;
 }
#proInfo {
    cursor: pointer; /* 기본 커서 설정 */
}
#proInfoCA:hover {
    cursor: url('/resources/images/free-icon-document-4426024.png');
}
</style>
<script>
<% /*
 게시글 번호(자동증가 , sequence)		proStoryBbscttNo	
 게시글 제목(직접입력)					proStoryBbscttSj
 게시글 내용(직접입력)					proStoryBbscttCn
 게시글 작성일자(sysdate)				proStoryBbscttWrDt
 게시글 추천수(별도)					proStoryBbscttRecommend
 게시글 조회수(별도)					proStoryBbscttRdcnt
 프로이야기게시글썸네일사진(직접입력)		proStoryBbscttThumbPhoto
 통합첨부파일(사진, 직접입력)			sprviceAtchmnflNo
 프로아이디							proId
*/ %>
$(function() {

	 $(".like-area").hover(
		        function() {
		            $(this).find("svg").css("color", "red"); // 마우스를 올렸을 때 하트 아이콘의 색상을 빨간색으로 변경
		        },
		        function() {
		            $(this).find("svg").css("color", "red"); // 마우스를 벗겼을 때 하트 아이콘의 색상을 빨간색으로 변경
		        }
		    );

	let storyNo = ${getStory.proStoryBbscttNo};
	let writer = "${getStory.proId}";
	
	let goodChk = "${goodChk}";
	let story = ${getStoryStr};
	
	let storyTest = story.proStoryBbscttCn;
	var checkId;
	
	const proInfo = document.querySelector("#proInfo");
	
	$.ajax({
    	url : "/prostory/idCheck",
    	method : "get",
    	success : function(result){
    		
    		if(result === "not"){
    			checkId = result;
	    		}
	    	}
    	})
// 	const storyGood = document.querySelector("#good");
	
	proInfo.addEventListener("click" , function(){
		
		console.log("프로 프로필 클릭");
		
		Swal.fire({
			  title: '프로필로 이동하시겠습니까?',
			  text: '확인을 누르면 이동합니다',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonText: '확인',
			  cancelButtonText: '아니오',
// 			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    location.href = "/proProfl/detail?proId="+writer;
// 			    Swal.fire(
// 			      'Deleted!',
// 			      'Your file has been deleted.',
// 			      'success'
// 			    );
			  } else if (result.dismiss === Swal.DismissReason.cancel) {
// 			    Swal.fire(
// 			      'Cancelled',
// 			      'Your imaginary file is safe :)',
// 			      'error'
// 			    );
// 			  }
			  return;
			}
		});
	})
	
	$(".heart-click").click(function() {
		
		if(checkId === "not") {
			Swal.fire({
                title: "로그인 후 이용하세요!",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
			return;
		}
	    
//		게시물 번호(storyNo)를 idx로 전달받아 저장
		let storyNo = $(this).attr('idx');

	    // 빈하트를 눌렀을때
	    if($(this).children('svg').attr('class') == "bi bi-suit-heart"){

	        $.ajax({
	            url : '/prostory/goodUp',
	            type : 'get',
	            data : {
	            	storyNo : storyNo,
	            },
	            success : function(result) {
	            	
	            	let heart = result.proStoryBbscttRecommend;

	            	let storyGoodElement = $("#storyGood"+ storyNo)
	                .css({"width": "35px", "height": "35px", "display": "flex", "align-items": "center"})
	                .text("\u00A0\u00A0"+heart);

	            },
	            error : function() {
	            	Swal.fire({
		                title: "왜 실패했지",
		                confirmButtonText: "확인",
		                icon: 'warning',
		                customClass: {
		                    title: 'swal-title'
		                }
		            });
	            }
	        });

	        // 꽉찬하트로 바꾸기
	        $(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='35' height='35' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
	        $('.heart_icon'+storyNo).html("<svg xmlns='http://www.w3.org/2000/svg' width='35' height='35' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");

	    // 꽉찬 하트를 눌렀을 때
	    } else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
	       
	    	console.log("꽉찬하트 클릭 : " + storyNo);

	        $.ajax({
	            url : '/prostory/goodCancle',
	            type : 'get',
	            data : {
	            	storyNo : storyNo,
	            },
	            success : function(result) {
					
	            	let heart = result.proStoryBbscttRecommend;

	            	let storyGoodElement = $("#storyGood"+ storyNo)
	                .css({"width": "35px", "height": "35px", "display": "flex", "align-items": "center"})
	                .text("\u00A0\u00A0"+heart);
	            },
	            error : function() {
	            	Swal.fire({
		                title: "서버에러?!",
		                confirmButtonText: "확인",
		                icon: 'warning',
		                customClass: {
		                    title: 'swal-title'
		                }
		            });
	            }
	        });

	        // 빈하트로 바꾸기
	        $(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	        $('.heart_icon'+storyNo).html('<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
	    }

	});
	
	$("#update").on("click" , function(){
		
		let writer = "${getStory.proId}";
		
		console.log("writer 데이터 : " + writer);
		
		if(confirm("게시글 수정?")){
		
			console.log("writer 체크 : " + writer);
			
			$.ajax({
				url : "/prostory/idChk",
				type : "get",
				data : { writer : writer },
				success : function(result){

					if(result === "true"){
						Swal.fire({
			                title: "수정 페이지로 이동합니다!",
			                confirmButtonText: "확인",
			                icon: 'warning',
			                customClass: {
			                    title: 'swal-title'
			                }
			            });
						location.href = "/prostory/update?storyNo="+ storyNo;
					} else {
						Swal.fire({
			                title: "본인만 수정 가능합니다",
			                confirmButtonText: "확인",
			                icon: 'warning',
			                customClass: {
			                    title: 'swal-title'
			                }
			            });
						return;
					}
				}
			})
		};
	})
	
	$("#delete").on("click" , function(){
		
		let writer = "${getStory.proId}";
		
		if(confirm("게시글 삭제?")){
		
				$.ajax({
				url : "/prostory/idChk",
				type : "get",
				data : { writer : writer },
				success : function(result){
	
						if(result === "true"){
		
							$.ajax({
								url : "/prostory/delete?storyNo="+storyNo,
								type : "post",
								dataType : "text",
								data : { storyNo : storyNo },
								success : function(result){
									
									if(result > 0){
										Swal.fire({
							                title: "게시물 삭제 성공!",
							                confirmButtonText: "확인",
							                icon: 'warning',
							                customClass: {
							                    title: 'swal-title'
							                }
							            });
										location.href = "/prostory/main";
									} else{
										Swal.fire({
							                title: "게시물 삭제 실패!",
							                confirmButtonText: "확인",
							                icon: 'warning',
							                customClass: {
							                    title: 'swal-title'
							                }
							            });
										location.href = "/prostory/main";
									}
									console.log("삭제 테스트 : " + result)
								}
							})
		
						} else {
							Swal.fire({
				                title: "본인만 삭제 가능!",
				                confirmButtonText: "확인",
				                icon: 'warning',
				                customClass: {
				                    title: 'swal-title'
				                }
				            });
							return;
					}
				}
			})
		}
	})
	
})
</script>
<div style="text-align: center;">
    <div class="container-fluid">
        <div class="container col-lg-6" style="text-align: center;">
            <div data-v-78548f8c="" data-v-09a142b7="" class="soomgo-life-post-detail is-test-b" id="storyTitle">
                <div data-v-00e3049a="" data-v-78548f8c="" class="post-header">
                    <div class="list-item" style="display: flex; justify-content: flex-end;">
                        <c:if test="${memSession==null && proSession != null && proSession.userId == getStory.proId}">
                            <button type="button" id="update" class="btn btn-primary mr-2">글수정</button>
                            <button type="button" id="delete" class="btn btn-primary mr-2">글삭제</button>
                            <br>
                        </c:if>
                    </div>
                </div>
            </div>
            <br>
            <div class="container-fluid">
                <img style="width : 100%; border-radius: 20px;" src="/images/${getStory.proStoryBbscttThumbPhoto}" />
            </div>
            <br />
            <div style="text-align: left; margin-left: 5px;">
	            <div>
	           		 커뮤니티 > 프로이야기
	            </div>
            <br />
	            <div style="font-family: GmarketSansMedium; font-size: 2rem;">
                <img style="width : 45px;" src="/resources/images/서비스.gif" />
	            ${getStory.spcltyRealmNm}
	            </div>
            </div>
            <hr />
            <div style="text-align: center; font-family: GmarketSansMedium;">
		    <div class="title-like-area">
		        <h2 class="title">${getStory.proStoryBbscttSj}</h2>
		    </div>
		    <br />
		        <h6>
		            <span class="like-area">
		                <c:if test="${goodChk > 0}">
		                    <a idx="${getStory.proStoryBbscttNo}" href="javascript:" class="heart-click heart_icon${getStory.proStoryBbscttNo}">
		                        <svg xmlns='http://www.w3.org/2000/svg' width='35' height='35' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>
		                            <path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>
		                        </svg>
		                    </a>
		                </c:if>
		                <c:if test="${goodChk == 0}">
		                    <a idx="${getStory.proStoryBbscttNo}" href="javascript:" class="heart-click heart_icon${getStory.proStoryBbscttNo}">
		                        <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
		                            <path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" />
		                        </svg>
		                    </a>
		                </c:if>
		                <!-- 좋아요 조회수 출력 -->
		                <span id="storyGood${getStory.proStoryBbscttNo}">&nbsp;&nbsp;${getStory.proStoryBbscttRecommend}</span>
		                &nbsp;&nbsp;
		                <span><img style="width: 35px" src="/resources/images/click.png">&nbsp;&nbsp;${getStory.proStoryBbscttRdcnt}</span>
		            </span>
		        </h6>
		</div>
            <hr />
           <div class="container-fluid">
    <div style="display: flex; align-items: left; justify-content: flex-start;" id="proInfo">
        <c:choose>
            <c:when test="${empty getStory.proProflPhoto}">
                <img style="border-radius: 100%; width: 60px; height: 60px;" src="/images/2024/profile.jpg" />
            </c:when>
            <c:otherwise>
                <img style="border-radius: 100%; width: 60px; height: 60px;" src="${getStory.proProflPhoto}" />
            </c:otherwise>
        </c:choose>
        <div style="text-align : left; display: flex; flex-direction: column; justify-content: left; margin-left : 10px; margin-top: 10px; font-family: GmarketSansMedium;">
            <h5>${getStory.userNcnm}</h5>
            <c:set var="originalString" value="${getStory.proStoryBbscttWrDt}" />
            <c:set var="substringLength" value="16" />
            <c:set var="substring" value="${fn:substring(originalString, 0, substringLength)}" />
            <c:out value="${substring}" />
        </div>
    </div>
</div>

            <hr />
        </div>
        <br />
        <div class="container-fluid" id="detailTest" style="width: 50%">
            <div>
                ${getStory.proStoryBbscttCn}
            </div>
        <hr />
        </div>
    </div>
</div>
