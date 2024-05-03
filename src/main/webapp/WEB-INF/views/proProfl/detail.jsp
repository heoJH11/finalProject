<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5c848eb4fd5eef99d119f9ac75df67b4&libraries=services"></script>




<head>
<title>프로 프로필</title>
</head>
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
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

label, span, p, h5, h6, h3, h4, pre, a, button, input {
	font-family: 'GmarketSansMedium';
}

/* 별점 */
.star_rating .star {
	width: 15px;
	height: 15px;
	margin-right: 2px;
	display: inline-block;
	background:
		url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png')
		no-repeat;
	background-size: 100%;
	box-sizing: border-box;
}

.star_rating .star.on {
	width: 15px;
	height: 15px;
	margin-right: 2px;
	display: inline-block;
	background:
		url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png')
		no-repeat;
	background-size: 100%;
	box-sizing: border-box;
}
</style>
<script>
function notify(){
	console.log("신고 아이콘을 클릭했습니다^^");
	//신고 클릭시 누구를 신고할지 해당 프로의 아이디를 일단 받아와야 된다
	console.log('${proProflVO.proId}');  //신고 대상자 아이디
	//신고 이미지 클릭시 모달창 뜨게 하기		
	$("#declBtn").off("click").on("click",function(){
		console.log($('input:radio[name=declResn]:checked').val());
		console.log($("#userId").val());
		console.log($("#userId2").val());
		
		Swal.fire({
            title: '신고가 완료 됐습니다.',
            icon: 'success',
			confirmButtonColor: '#7066e0',
            confirmButtonText: '확인',
        })
		let userId = $("#userId").val();
		let userId2 = $("#userId2").val();
		let declResn = $('input:radio[name=declResn]:checked').val();
		
		let data = {
			"userId":userId,
			"userId2":userId2,
			"declResn":declResn
		}
		console.log("신고처리 시 넘어갈 data : ",data);
		
		$.ajax({
			type:"post",
			url:"/proProfl/declInsert",
			data:JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			dataType:"text",
			success:function(res){
				console.log("신고에 대한 결과값 : ",res);
			}
		});
		
	});
}
$(function(){

	
	// 지도
	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	var mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

	// 지도를 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();

	var proAdres = $("#proAdres").text();
	console.log("proAdres", proAdres);

	// 주소로 좌표를 검색
	geocoder.addressSearch(proAdres, function(result, status) {

	    // 정상적으로 검색이 완료
	    if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 마커 이미지 설정
	        var markerImage = new kakao.maps.MarkerImage(
	            '/resources/images/지도마커.png', // 마커 이미지 URL
	            new kakao.maps.Size(50, 50), // 마커 이미지 크기
	            { offset: new kakao.maps.Point(25, 50) } // 마커 이미지의 좌표 설정
	        );

	        // 마커를 생성
	        var marker = new kakao.maps.Marker({
	            position: coords,
	            map: map,
	            image: markerImage // 커스텀 마커 이미지 설정
	        });

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    }
	});



	$(document).ready(function(){
	    $('#pop').popover({
	        toggle: "popover", // 팝오버를 토글할 것임을 설정합니다.
	        content: "작업사진과 과정을 포함한 포트폴리오를 등록할 경우 프로님을 선택할 확률이 높아집니다.", // 팝오버 내용을 설정합니다.
	        title: "프로님의 눈에띄는! 작업물을 보여주세요." // 팝오버 제목을 설정합니다.
	    }); 
	});
		
	//신고 관련 수정 부분 시작
	$("#notifybtn").on("click",function(){
		notify();
		/* console.log("신고 아이콘을 클릭했습니다^^");
		//신고 클릭시 누구를 신고할지 해당 프로의 아이디를 일단 받아와야 된다
		console.log('${proProflVO.proId}');  //신고 대상자 아이디
		//신고 이미지 클릭시 모달창 뜨게 하기		
		$("#declBtn").off("click").on("click",function(){
			console.log($('input:radio[name=declResn]:checked').val());
			console.log($("#userId").val());
			console.log($("#userId2").val());
			
			Swal.fire({
	            title: '신고가 완료 됐습니다.',
	            icon: 'success',
				confirmButtonColor: '#7066e0',
	            confirmButtonText: '확인',
	        })
			let userId = $("#userId").val();
			let userId2 = $("#userId2").val();
			let declResn = $('input:radio[name=declResn]:checked').val();
			
			let data = {
				"userId":userId,
				"userId2":userId2,
				"declResn":declResn
			}
			console.log("신고처리 시 넘어갈 data : ",data);
			
			$.ajax({
				type:"post",
				url:"/proProfl/declInsert",
				data:JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				dataType:"text",
				success:function(res){
					console.log("신고에 대한 결과값 : ",res);
				}
			});
			
		}); */
	});
	$("#notifybtn2").on("click",function(){
		notify();
	});
	

	var mberId = $("#mberId").val();
	var proId = $("#proId").val();
	console.log("mberId : " + mberId + ", proId : " + proId);
	var targetString = "http://localhost/proProfl/detail?proId="+proId+"&currentPage=";
	
	// 페이지 로드시 요청서 메뉴나오게하기
	 if(window.location.href == "http://localhost/proProfl/detail?proId="+proId ||window.location.href == "http://localhost/proProfl/detail?proId="+proId+"#" ) {
	$('.nav.profile-navbar .nav-item:first-child .nav-link').addClass('active');
	$('.profile-feed').hide(); // 모든 profile-feed 숨기기
	$('.profile-feed:first').show(); // 첫 번째 profile-feed 보이기

	 }else 	if (window.location.href.indexOf(targetString) !== -1) {
			$('.nav.profile-navbar .nav-item:last-child .nav-link').addClass('active');
			$('.profile-feed').hide(); // 모든 profile-feed 숨기기
			$('.profile-feed:last').show(); // 첫 번째 profile-feed 보이기

		}
    // 메뉴 클릭 시 해당 섹션을 표시 + 색바꾸기
    $('.nav-item').click(function() {
    	$('.nav-item').find('.nav-link').removeClass('active');
        $(this).find('.nav-link').addClass('active');

        var index = $(this).index();
        $('.profile-feed').hide();
        $('.profile-feed').eq(index).show();
    });
	
	//즐겨찾기한사람인지 아닌지 바로확인
	$.ajax({
		url:"/proBkmk/proBkmkCheck",
		data:{"mberId":mberId, "proId":proId},
		type:"get",
		success:function(data){
			console.log("mberId : " + mberId + ", proId : " + proId);
			console.log("즐겨찾기 확인 결과: " + data);
			if(data != null && data != ""){
				$('#UnProBkmkbtn').css("display","none");
				$('#ProBkmkbtn').css("display","inline");
			}else{
				$('#UnProBkmkbtn').css("display","inline");
				$('#ProBkmkbtn').css("display","none");
				}
			}
		});
	
	//즐겨찾기 해제
	$('#ProBkmkbtn').click(function(){
		var mberId = $("#mberId").val();
		var proId = $("#proId").val();
		console.log("mberId : " + mberId + ", proId : " + proId);
		
		$.ajax({
			url:"/proBkmk/proBkmkDelete",
			data:{"mberId":mberId, "proId":proId},
			type:"post",
			success:function(data){
				console.log("즐겨찾기 해제");
				Swal.fire({
					title: '즐겨찾기가 해제되었습니다!',
					icon: 'success',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				}).then((result)=>{
					$('#UnProBkmkbtn').css("display","inline");
					$('#ProBkmkbtn').css("display","none");
					
				})
			}
		});
	});
	
	//즐겨찾기
	$('#UnProBkmkbtn').click(function(){
		var mberId = $("#mberId").val();
		var proId = $("#proId").val();
		console.log("mberId : " + mberId + ", proId : " + proId);
		
		$.ajax({
			url:"/proBkmk/proBkmkCreate",
			data:{"mberId":mberId, "proId":proId},
			type:"post",
			success:function(data){
				console.log("즐겨찾기 성공");
				Swal.fire({
					title: '즐겨찾기 되었습니다!',
					icon: 'success',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				}).then((result)=>{
					$('#UnProBkmkbtn').css("display","none");
					$('#ProBkmkbtn').css("display","inline");
					
				})
				
	        }
		});
	});
	
	//리뷰 페이징
	//전체
	   let currentPage = "${param.currentPage}"
	   if(currentPage == "") {
	      currentPage = "1";
	   }
	   var proId = $("#proIdcheck").text();
	   console.log("proIdㄷㄷ",proId);
	   
	   let data = {
	      "currentPage": currentPage,
	      "proId": proId
	   };
	   console.log("data : " + data);
	   $.ajax({
	        type: "post",
	        url: "/proProfl/reviewPage",
	        data: JSON.stringify(data),
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function(res){
	            console.log("리뷰res",res);
	            console.log("리뷰con",res.content);
	            
	            let str = "";
	            if (res.content == null || res.content.length == 0 || res.content == "") {
	                str += "<div style='text-align: center;'>";
	                str += "<br>";
	                str += "<img src='../resources/images/우는모양.png' style='width: 100px; height: 100px;' />";
	                str += "<h3 style='padding: 20px 0 40px 0; color: #c6c9cc;'>";
	                str += "아직 등록된 리뷰가 없어요!";
	                str += "</h3>";
	                str += "</div>";
	            } else {
	                $.each(res.content, function (idx, ReviewVO) {
	                    console.log("ReviewVO[" + idx + "] : ", ReviewVO);
	                    console.log("res : ", res.content);
	                    str += "<div class='border-bottom py-1' style='margin-top:20px; display: flex; flex-wrap: wrap; align-items: center; width: 100%; height: auto; overflow: auto;'>";
	                    str += "<div>";
	                    if (!ReviewVO.mberReviewVOList[0].mberProflPhoto || ReviewVO.mberReviewVOList[0].mberProflPhoto == "") {
	                        str += "<img src='/images/2024/profile.jpg' alt='profile' style='width:60px; height:60px; border-radius: 70%; margin-bottom:10px;'>";
	                    } else {
	                        str += "<img src='" + ReviewVO.mberReviewVOList[0].mberProflPhoto + "' alt='profile' style='width:60px; height:60px; border-radius: 70%; margin-bottom:10px;'>";
	                    }
	                    str += "</div>";
	                    str += "<div style='display: flex; flex-wrap: wrap; align-items: center;'>";
	                    str += "<div style='margin-left:20px;'>";
	                    str += "<h4><b>" + ReviewVO.userReviewVOList[0].userNcnm + "</b></h4>";
	                    str += "<h6>" + ReviewVO.srvcReVOList[0].mberId + "</h6>";
	                    str += "</div>";
	                    str += "<div style='margin-left:20px; width:350px; height:auto;'>";
	                    str += "<input type='hidden' class='StarScore' value='" + ReviewVO.reScore + "'>";
	                    str += "<div class ='star_rating'>";
	                    str += "<span class='star reScoreVal1' value='1' > </span>";
	                    str += "<span class='star reScoreVal2' value='2'> </span>";
	                    str += "<span class='star reScoreVal3' value='3'> </span>";
	                    str += "<span class='star reScoreVal4' value='4'> </span>";
	                    str += "<span class='star reScoreVal5' value='5'> </span>";
	                    str += "<h6 style='margin-top:5px;'>" + ReviewVO.reCn + "</h6>";
	                    str += "</div>";
	                    str += "</div>";
	                    str += "<div style='margin-left:20px;'>";
	                    str += "<h5 class='badge badge-outline-dark my-1'>" + ReviewVO.comReviewVOList[0].commonCdDetailNm + "</h5>";
	                    str += "</div>";
	                    str += "</div>";
	                    str += "</div>";
	                });
	            }

	            $("#proReviewBody").html(str); 
	    		//별점주기
	    		$(".StarScore").each(function() {
	    	        var reScore = Number($(this).val());
	    	        console.log()
	    	        showStar($(this), reScore);
	    	    });
	    		
	            // 페이징 처리
	            if (res.total == 0) {
	                $("#S_divPaging").html("");
	            } else {               
	                $("#S_divPaging").html(res.pagingArea);
	            }
	            
	            }
	        });

	    function showStar(element, reScore){
	        console.log("빛나라 지식의 별");        
	        console.log(reScore);
	        for(var i = 1; i <= reScore; i++){
	            element.siblings(".star_rating").find(".reScoreVal"+i).addClass("on");
	        }
	    }
	   
	   
	console.log("지역코드를 이름으로");
	var bcityCode = $("#bcityCode").text();
	var brtcCode = $("#brtcCode").text();
	console.log("bcityCode: " + bcityCode + ", brtcCode: " + brtcCode);

	$.ajax({
	    url: "/proProfl/getNm",
	    data: { "bcityCode": bcityCode, "brtcCode": brtcCode },
	    type: "post",
	    success: function(data) {
	        $("#bcityCode").text(data.bcityNm);
	        $("#brtcCode").text(data.brtcNm);
	        
	        if ($("#brtcCode").text() == "전국") {
	            $("#brtcCode").css("display", "none");
	        }
	    }
	});
    
    //포트폴리오 삭제
    $(".btn.btn-success").on("click", function() {
		console.log("삭제하자");
		let sprviseAtchmnflNo = $(this).data("sprviseAtchmnflNo");
		console.log("sprviseAtchmnflNo : " + sprviseAtchmnflNo);
		
		$.ajax({
			url:"/prtFolio/deletePrt",
			data:{"sprviseAtchmnflNo": sprviseAtchmnflNo},
			type:"post",
			success:function(result){
				   Swal.fire({
					   title: "정말 삭제 하시겠습니까?",
					   confirmButtonText: "확인",
					 }).then((result) => {
					   if (result.isConfirmed) {
						   console.log("result : ", result);
						   location.reload();
					   } else if (result.isDenied) {
					   }
					});
			}
		});
	});
	
    // 포트폴리오 모달 내 버튼 클릭 시 슬라이드 변경
    $(document).on("click",".modalPicBody button",function() {
        let slideDirection = $(this).attr("aria-label");
        if (slideDirection === "Previous slide") {
            plusSlides(-1); // 이전 슬라이드로 이동
        } else if (slideDirection === "Next slide") {
            plusSlides(1); // 다음 슬라이드로 이동
        }
    });
	
	
	// 포트폴리오 이미지 클릭 시 모달 창 제목 변경
	$(".prtThumb").on("click", function() {
    	console.log("왔다");
        let portfolioSj = $(this).data("prtfolioSj"); // 수정된 부분: id로 값을 가져오도록 변경
        //data-sprvise-atchmnfl-no="${portfolio.spAtVOList[0].sprviseAtchmnflNo}"
        let sprviseAtchmnflNo = $(this).data("sprviseAtchmnflNo");
        $(".btn.btn-success").data("sprviseAtchmnflNo", sprviseAtchmnflNo);
        
        console.log("portfolioSj : " + portfolioSj + ", sprviseAtchmnflNo : " + sprviseAtchmnflNo);

        
        $("#modalPicTitle").text(portfolioSj); // 모달 창 제목 설정
        
        $.ajax({
        	url:"/proProfl/portfolioPicture",
        	data:{"sprviseAtchmnflNo": sprviseAtchmnflNo},
        	type:"post",
        	success:function(result){
        		console.log("result : ", result);
        		
        		let str = "";
        		
        		str += "<li style='list-style-type: none; display: inline-block;'>";
        		str += "<button type='button' aria-label='Previous slide' style='background: none; margin-left:-30px; border: none; position: absolute; top: 42%;'>";
        		str += "<i class='mdi mdi-arrow-left-drop-circle-outline' style='font-size: 40px;'></i></button></li>";
        		
        		//result : List<SprviseAtchmnflVO>
        		$.each(result,function(idx,sprviseAtchmnflVO){
        			str += "<li style='list-style-type: none; display: inline-block;'>";
        			str += "<img src='"+sprviseAtchmnflVO.atchmnflCours+"' style='width:390px; height:390px; margin-left:20px;'>";
        			str += "</li>";
        		});
        		
        		str += "<li style='list-style-type: none; display: inline-block;'>";
       			str += "<button type='button' aria-label='Next slide' style='background: none; border: none; position: absolute; top: 42%;' >";
      			str += "<i class='mdi mdi-arrow-right-drop-circle-outline' style='font-size: 40px;'></i></button></li>";
        		
        		$("#ulPrt").html(str);
        		
        		showSlides();
        	}
        });
    });
	
	
    // 슬라이드 쇼 함수
    let slideIndex = 0;
    showSlides();

    function plusSlides(n) {
        slideIndex += n;
        showSlides();
    }

    function showSlides() {
    	console.log("왔다2");
        let slides = document.querySelectorAll(".modalPicBody img");
        console.log("slides.length : " + slides.length);
        
        if (slideIndex >= slides.length) {
        	slideIndex = 0 
        }
        if (slideIndex < 0) {
        	slideIndex = slides.length - 1 
        	}
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        if (slides[slideIndex]) {
            slides[slideIndex].style.display = "block";
        } else {
        }
    }

});
    
</script>
<!-- 
요청URI : /createPost
요청파라미터 : {PRO_ID=protest100, PRO_PROFL_ON_LI_INTRCN=반려동물 산책/돌봄 자신있습니다, PRO_PROFL_CONTACT_POSBL_TIME=10:00 ~ 21:00, 
              PRO_PROFL_REQ_FORM=반려동물 이름:  종류: , PRO_PROFL_HIST=반려견 산책대회 우승자, BCITY_CODE=25, BRTC_CODE=25030}
요청방식 : post
 -->
<!--비회원이보는 프로필  -->
<c:if test="${memSession == null && proSession == null}">
	<%-- <p>${proProflVO}</p> --%>
	<c:if test="${proProflVO.proId==null}">
		<script>
        function nullProfl() {
            Swal.fire({
                title: '프로필이 없는 프로입니다',
                icon: 'warning',
                confirmButtonColor: '#4B49AC',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
            }).then((result) => {
                if (result.isConfirmed) {
                    history.back();
                }
            });
        }
        $(document).ready(function() {
        	nullProfl(); // 함수 호출
        });
	    </script>
	</c:if>
	<div class="main-panel" style="margin: -20px 0 0 80px;">
		<div class="content-wrapper">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div class="col-lg-4">
									<!-- ProProflVO(proId=asdasd, proProflOnLiIntrcn=내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로, 
									proProflContactPosblTime=asdfasd, 
									proProflReqForm=안녕하세요? 넵 안녕하세요!! 헤헤,
									proProflHist=이력이란.. 이력은 이력이다!, bcityCode=11, brtcCode=11090, 
									adres=대전 동구 판교2길 9) -->
									<div class="border-bottom text-center pb-4">
										<c:if test="${vProUsersVO.proProflPhoto == null}">
											<img src="/images/2024/profile.jpg" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<c:if test="${vProUsersVO.proProflPhoto != null}">
											<img src="${vProUsersVO.proProflPhoto}" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<div class="border-bottom py-4">
											<h3 style="font-family: 'seolleimcool-SemiBold';">${vProUsersVO.userNcnm}</h3>
											<hr
												style="border: 0; border-top: 30px solid #fff7d5; margin-top: -35px;">
											<div class="d-flex align-items-center justify-content-center">
												<h5 class="mb-0 me-2 text-muted" id="proIdcheck"
													style="margin-top: -5px;">${proProflVO.proId}</h5>
											</div>
											<div>
												<label class="badge badge-outline-dark my-1"> <span
													id="bcityCode">${proProflVO.bcityCode}</span>&nbsp; <span
													id="brtcCode">${proProflVO.brtcCode}</span>
												</label>
											</div>
											<p style="margin-top: 10px;" class="w-75 mx-auto mb-3">
												<c:out value='${proProflVO.proProflOnLiIntrcn}' />
											</p>
										</div>
										<div class="py-1">
											<h6 style="margin: 20px 0 0 0;">🕐 연락 가능 시간</h6>
											<div>
												<label class="badge badge-outline-dark my-1"> <c:out
														value='${proProflVO.proProflContactPosblTime}' /></label>
											</div>
											<h6 style="margin: 10px 0 0 0;">🎨 분야</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proBun">${proBun}</span>
											</div>
											<h6 style="margin: 10px 0 0 0;">🚩 상세 주소</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proAdres">${proProflVO.adres}</span>
											</div>
										</div>
										<!--지도  -->
										<div style="margin-top: 10px;">
											<div id="map"
												style="width: 100%; height: 280px; border-radius: 20px;"></div>
										</div>
									</div>
								</div>
								<div class="col-lg-8">
									<input type="hidden" id="mberId" value="${memSession.userId}" />
									<input type="hidden" id="proId" value="${vProUsersVO.proId}" />
									<div
										class="d-block d-md-flex justify-content-between mt-4 mt-md-0"
										style="text-align: center;">
										<div class="text-center mt-4 mt-md-0" style="margin: 0 auto;">
											<br>
											<h4>💬 서비스 이용은 로그인후 가능합니다.</h4>
											<hr
												style="border: 0; border-top: 20px solid #e7e7fd; margin-top: -30px;">
										</div>
									</div>
									<br>
									<div
										style="display: flex; flex-wrap: wrap; justify-content: center; align-items: center; width: 100%; height: 130px; border: none; border-radius: 20px; background-color: #f9f9f9; margin-bottom: -10px;">
										<div style="text-align: center; margin-right: 120px;">
											<h5>👦 고용</h5>
											<h3 style="margin-top: 25px;">${srvcCount}회</h3>
										</div>
										<div style="text-align: center; margin-right: 120px;">
											<h5>🧾 리뷰</h5>
											<h3 style="margin-top: 25px;">${revCount}개</h3>
										</div>
										<div style="text-align: center;">
											<h5>💖 팔로워</h5>
											<h3 style="margin-top: 25px;">${bkmkCount}명</h3>
										</div>
									</div>
									<br>
									<div class="mt-4 py-2 border-top border-bottom">
										<ul class="nav profile-navbar">
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-user"></i> 요청서
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-receipt"></i> 서비스 상세설명
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-calendar"></i> 포트폴리오
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-clip"></i> 리뷰
											</a></li>
										</ul>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">요청서
															양식 </b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; height: 450px; margin: 20px 15px 15px 15px; overflow: auto;">
															<c:out value="${proProflVO.proProflReqForm}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
															서비스 상세설명</b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; margin: 20px 15px 15px 15px; height: 450px; overflow: auto;">
															<c:out value="${proProflVO.proProflHist}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<!--포트 폴리오-->
									<div class="profile-feed">
										<div id="portfolio"
											style="width: 100%; height: auto; margin: 0 auto;">
											<br>
											<h5 style="text-align: center; margin: 15px 0;">
												<b
													style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
													포트 폴리오</b>
											</h5>
											<br>
											<c:if test="${VPrtfolioVO[0].sprviseAtchmnflNo == null}">
												<div style="text-align: center;">
													<img src="../resources/images/우는모양.png"
														style="width: 100px; height: 100px;" />
													<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">
														아직 등록된 포트폴리오가 없어요!</h3>
												</div>
											</c:if>
											<ul>
												<c:forEach items="${VPrtfolioVO}" var="portfolio">
													<li
														style="list-style-type: none; display: inline-block; margin-right: 5px; width: 150px;">
														<div>
															<a href="#modalPicture"
																data-picture-url="${portfolio.spAtVOList[0].atchmnflCours}"
																data-toggle="modal"> <img class="prtThumb"
																src="${portfolio.spAtVOList[0].atchmnflCours}"
																data-prtfolio-sj="${portfolio.prtfolioSj}"
																data-sprvise-atchmnfl-no="${portfolio.spAtVOList[0].sprviseAtchmnflNo}"
																style="width: 150px; height: 150px; border-radius: 20%">
															</a>
														</div>
														<div class="prtName">
															<input type="text" name="prtName" id="portfolioTitle"
																value="${portfolio.prtfolioSj}"
																style="width: 100%; margin: 5px 0; text-align: center; background: none; border: none;">
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
															리뷰</b>
													</h5>
													<!--[ReviewVO(reNo=81, reTy=REV01, reCn=아주 좋았어요!, reWrDt=Sat Mar 30 01:07:26 KST 2024, reScore=4, srvcRequstNo=382, vSrvcRequstVOList=null, 
															srvcReVOList=[SrvcRequstVO(mberId=testUser, proId=testPro)], 
															mberReviewVOList=[MberVO(mberId=testUser, mberProflPhoto=null,)], 
															userReviewVOList=[UsersVO(userNcnm=tesU023)], 
															comReviewVOList=[CommonCdDetailVO(commonCdDetail=REV01, commonCdDetailNm=책임감 있어요]),  -->

													<div id="proReviewBody"></div>

													<div id="S_divPaging"
														style="position: relative; margin-top: 20px; padding-bottom: 50px;"">
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- //////// 이미지 크게 보기 모달 //////// -->
	<div class="modal fade" id="modalPicture" tabindex="-1"
		aria-labelledby="exampleModalLabel-2" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalPicTitle"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!-- 
			sprviseAtchmnflVOList : 
			[VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=1, 
				atchmnflCours=/images/2024/03/18/932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflNm=거징징이.jpg, storeAtchmnflNm=932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null), 
			VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=2, 
				atchmnflCours=/images/2024/03/18/168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflNm=아니.jpg, storeAtchmnflNm=168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null)]
			
			 -->
				<div class="modalPicBody" style="margin-left:20px;">
					<ul id="ulPrt" style="margin: 7px 0 0 18px;">
					</ul>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</c:if>


<!--회원이보는 프로필  -->
<c:if test="${memSession != null && proSession == null}">
	<%-- <p>${proProflVO}</p> --%>
	<c:if test="${proProflVO.proId==null}">
		<script>
        function nullProfl() {
            Swal.fire({
                title: '프로필이 없는 프로입니다',
                icon: 'warning',
                confirmButtonColor: '#4B49AC',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
            }).then((result) => {
                if (result.isConfirmed) {
                    history.back();
                }
            });
        }
        $(document).ready(function() {
        	nullProfl(); // 함수 호출
        });
	    </script>
	</c:if>
	<div class="main-panel" style="margin: -20px 0 0 80px;">
		<div class="content-wrapper">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div class="col-lg-4">
									<!-- ProProflVO(proId=asdasd, proProflOnLiIntrcn=내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로내가 바로 프로프로, 
									proProflContactPosblTime=asdfasd, 
									proProflReqForm=안녕하세요? 넵 안녕하세요!! 헤헤,
									proProflHist=이력이란.. 이력은 이력이다!, bcityCode=11, brtcCode=11090, 
									adres=대전 동구 판교2길 9) -->
									<div class="border-bottom text-center pb-4">
										<c:if test="${vProUsersVO.proProflPhoto == null}">
											<img src="/images/2024/profile.jpg" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<c:if test="${vProUsersVO.proProflPhoto != null}">
											<img src="${vProUsersVO.proProflPhoto}" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<div class="border-bottom py-4">
											<h3 style="font-family: 'seolleimcool-SemiBold';">${vProUsersVO.userNcnm}</h3>
											<hr
												style="border: 0; border-top: 30px solid #fff7d5; margin-top: -35px;">
											<div class="d-flex align-items-center justify-content-center">
												<h5 class="mb-0 me-2 text-muted" id="proIdcheck"
													style="margin-top: -5px;">${proProflVO.proId}</h5>
											</div>
											<div>
												<label class="badge badge-outline-dark my-1"> <span
													id="bcityCode">${proProflVO.bcityCode}</span>&nbsp; <span
													id="brtcCode">${proProflVO.brtcCode}</span>
												</label>
											</div>
											<p style="margin-top: 10px;" class="w-75 mx-auto mb-3">
												<c:out value='${proProflVO.proProflOnLiIntrcn}' />
											</p>
										</div>
										<div class="py-1">
											<h6 style="margin: 20px 0 0 0;">🕐 연락 가능 시간</h6>
											<div>
												<label class="badge badge-outline-dark my-1"> <c:out
														value='${proProflVO.proProflContactPosblTime}' /></label>
											</div>
											<h6 style="margin: 10px 0 0 0;">🎨 분야</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proBun">${proBun}</span>
											</div>
											<h6 style="margin: 10px 0 0 0;">🚩 상세 주소</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proAdres">${proProflVO.adres}</span>
											</div>
										</div>
										<!--지도  -->
										<div style="margin-top: 10px;">
											<div id="map"
												style="width: 100%; height: 280px; border-radius: 20px;"></div>
										</div>
									</div>
								</div>
								<div class="col-lg-8">
									<input type="hidden" id="mberId" value="${memSession.userId}" />
									<input type="hidden" id="proId" value="${vProUsersVO.proId}" />
									<div
										class="d-block d-md-flex justify-content-between mt-4 mt-md-0">
										<div class="text-center mt-4 mt-md-0">
											<button class="btn btn-outline-primary btn-fw"
												onclick="location.href='/srvcBtfInqry/btfInqryCreate?proId=${proProflVO.proId}'">문의하기</button>
											<button class="btn btn-outline-primary btn-fw"
												onclick="location.href='/srvcRequst/srvcRqCreate?proId=${proProflVO.proId}'">요청하기</button>
											<img id="UnProBkmkbtn" src="../resources/images/하트1.png"
												style="width: 40px; margin: 5px 0px 5px 360px; display: inline;" />
											<img id="ProBkmkbtn" src="../resources/images/하트2.png"
												style="width: 40px; margin: 5px 0px 5px 360px; display: none;" />
											<!--신고 관련 수정 부분 시작 -->
											<img id="notifybtn" src="../resources/images/사이렌2.png"
												style="width: 25px; margin: 5px 0px 5px 5px; display: inline;"
												data-toggle="modal" data-target="#modal-sm" />
											<!--신고 관련 수정 부분 끝 -->
										</div>
									</div>
									<br>
									<div
										style="display: flex; flex-wrap: wrap; justify-content: center; align-items: center; width: 100%; height: 130px; border: none; border-radius: 20px; background-color: #f9f9f9; margin-bottom: -10px;">
										<div style="text-align: center; margin-right: 120px;">
											<h5>👦 고용</h5>
											<h3 style="margin-top: 25px;">${srvcCount}회</h3>
										</div>
										<div style="text-align: center; margin-right: 120px;">
											<h5>🧾 리뷰</h5>
											<h3 style="margin-top: 25px;">${revCount}개</h3>
										</div>
										<div style="text-align: center;">
											<h5>💖 팔로워</h5>
											<h3 style="margin-top: 25px;">${bkmkCount}명</h3>
										</div>
									</div>
									<br>
									<div class="mt-4 py-2 border-top border-bottom">
										<ul class="nav profile-navbar">
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-user"></i> 요청서
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-receipt"></i> 서비스 상세설명
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-calendar"></i> 포트폴리오
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-clip"></i> 리뷰
											</a></li>
										</ul>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">요청서
															양식 </b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; height: 450px; margin: 20px 15px 15px 15px; overflow: auto;">
															<c:out value="${proProflVO.proProflReqForm}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
															서비스 상세설명</b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; margin: 20px 15px 15px 15px; height: 450px; overflow: auto;">
															<c:out value="${proProflVO.proProflHist}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<!--포트 폴리오-->
									<div class="profile-feed">
										<div id="portfolio"
											style="width: 100%; height: auto; margin: 0 auto;">
											<br>
											<h5 style="text-align: center; margin: 15px 0;">
												<b
													style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
													포트 폴리오</b>
											</h5>
											<br>
											<c:if test="${VPrtfolioVO[0].sprviseAtchmnflNo == null}">
												<div style="text-align: center;">
													<img src="../resources/images/우는모양.png"
														style="width: 100px; height: 100px;" />
													<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">
														아직 등록된 포트폴리오가 없어요!</h3>
												</div>
											</c:if>
											<ul>
												<c:forEach items="${VPrtfolioVO}" var="portfolio">
													<li
														style="list-style-type: none; display: inline-block; margin-right: 5px; width: 150px;">
														<div>
															<a href="#modalPicture"
																data-picture-url="${portfolio.spAtVOList[0].atchmnflCours}"
																data-toggle="modal"> <img class="prtThumb"
																src="${portfolio.spAtVOList[0].atchmnflCours}"
																data-prtfolio-sj="${portfolio.prtfolioSj}"
																data-sprvise-atchmnfl-no="${portfolio.spAtVOList[0].sprviseAtchmnflNo}"
																style="width: 150px; height: 150px; border-radius: 20%">
															</a>
														</div>
														<div class="prtName">
															<input type="text" name="prtName" id="portfolioTitle"
																value="${portfolio.prtfolioSj}"
																style="width: 100%; margin: 5px 0; text-align: center; background: none; border: none;">
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
															리뷰</b>
													</h5>
													<!--[ReviewVO(reNo=81, reTy=REV01, reCn=아주 좋았어요!, reWrDt=Sat Mar 30 01:07:26 KST 2024, reScore=4, srvcRequstNo=382, vSrvcRequstVOList=null, 
															srvcReVOList=[SrvcRequstVO(mberId=testUser, proId=testPro)], 
															mberReviewVOList=[MberVO(mberId=testUser, mberProflPhoto=null,)], 
															userReviewVOList=[UsersVO(userNcnm=tesU023)], 
															comReviewVOList=[CommonCdDetailVO(commonCdDetail=REV01, commonCdDetailNm=책임감 있어요]),  -->

													<div id="proReviewBody"></div>
													<div id="S_divPaging"
														style="position: relative; margin-top: 20px; padding-bottom: 50px;"">
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //////// 이미지 크게 보기 모달 //////// -->
	<div class="modal fade" id="modalPicture" tabindex="-1"
		aria-labelledby="exampleModalLabel-2" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalPicTitle"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!-- 
			sprviseAtchmnflVOList : 
			[VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=1, 
				atchmnflCours=/images/2024/03/18/932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflNm=거징징이.jpg, storeAtchmnflNm=932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null), 
			VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=2, 
				atchmnflCours=/images/2024/03/18/168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflNm=아니.jpg, storeAtchmnflNm=168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null)]
			
			 -->
				<div class="modalPicBody" style="margin-left:20px;">
					<ul id="ulPrt" style="margin: 7px 0 0 18px;">
					</ul>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</c:if>


<!--프로일때  -->
<c:if test="${memSession == null && proSession != null}">
	<c:if test="${proProflVO==null}">
		<script>
        function nullProfl() {
            Swal.fire({
                title: '프로필이 없는 프로입니다',
                icon: 'warning',
                confirmButtonColor: '#4B49AC',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
            }).then((result) => {
                if (result.isConfirmed) {
                    history.back();
                }
            });
        }
        $(document).ready(function() {
        	nullProfl(); // 함수 호출
        });
	    </script>
	</c:if>
	<div class="main-panel" style="margin: -20px 0 0 80px;">
		<div class="content-wrapper">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div class="col-lg-4">
									<div class="border-bottom text-center pb-4">
										<c:if test="${vProUsersVO.proProflPhoto == null}">
											<img src="/images/2024/profile.jpg" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<c:if test="${vProUsersVO.proProflPhoto != null}">
											<img src="${vProUsersVO.proProflPhoto}" alt="profile"
												style="width: 150px; height: 150px; border-radius: 70%;">
										</c:if>
										<div class="border-bottom py-4">
											<h3 style="font-family: 'seolleimcool-SemiBold';">${vProUsersVO.userNcnm}</h3>
											<div class="d-flex align-items-center justify-content-center">
												<h5 class="mb-0 me-2 text-muted" id="proIdcheck">${proProflVO.proId}</h5>
											</div>
											<div>
												<label class="badge badge-outline-dark my-1"> <span
													id="bcityCode">${proProflVO.bcityCode}</span>&nbsp; <span
													id="brtcCode">${proProflVO.brtcCode}</span>
												</label>
											</div>
											<p style="margin-top: 10px;" class="w-75 mx-auto mb-3">
												<c:out value='${proProflVO.proProflOnLiIntrcn}' />
											</p>
										</div>
										<div class="py-1">
											<h6 style="margin: 20px 0 0 0;">🕐 연락 가능 시간</h6>
											<div>
												<label class="badge badge-outline-dark my-1"> <c:out
														value='${proProflVO.proProflContactPosblTime}' /></label>
											</div>
											<h6 style="margin: 10px 0 0 0;">🎨 분야</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proBun">${proBun}</span>
											</div>
											<h6 style="margin: 10px 0 0 0;">🚩 상세 주소</h6>
											<div>
												<span class="badge badge-outline-dark my-1" id="proAdres">${proProflVO.adres}</span>
											</div>
										</div>
										<!--지도  -->
										<div style="margin-top: 10px;">
											<div id="map"
												style="width: 100%; height: 280px; border-radius: 20px;"></div>
										</div>
									</div>
								</div>
								<div class="col-lg-8">
									<input type="hidden" id="mberId" value="${memSession.userId}" />
									<input type="hidden" id="proId" value="${vProUsersVO.proId}" />
									<div
										class="d-block d-md-flex justify-content-between mt-4 mt-md-0">
										<div class="text-center mt-4 mt-md-0">
											<c:if test="${proSession.userId==proProflVO.proId}">
												<button class="btn btn-outline-primary btn-fw" type="button"
													style="margin-left: 290px;"
													onclick="location.href='/proProfl/modify?proId=${proProflVO.proId}'">수정하기</button>
											</c:if>
											<c:if test="${proSession.userId!=proProflVO.proId}">
												<img id="notifybtn2" src="../resources/images/사이렌2.png"
													style="width: 25px; margin: 5px 0px 5px 620px; display: inline;"
													data-toggle="modal" data-target="#modal-sm" />
											</c:if>
										</div>
									</div>
									<br>
									<div
										style="display: flex; flex-wrap: wrap; justify-content: center; align-items: center; width: 100%; height: 130px; border: none; border-radius: 20px; background-color: #f9f9f9; margin-bottom: -10px;">
										<div style="text-align: center; margin-right: 120px;">
											<h5>👦 고용</h5>
											<h3 style="margin-top: 25px;">${srvcCount}회</h3>
										</div>
										<div style="text-align: center; margin-right: 120px;">
											<h5>🧾 리뷰</h5>
											<h3 style="margin-top: 25px;">${revCount}개</h3>
										</div>
										<div style="text-align: center;">
											<h5>
												💖 팔로워
												<h5>
													<h3 style="margin-top: 25px;">${bkmkCount}명</h3>
										</div>
									</div>
									<br>
									<div class="mt-4 py-2 border-top border-bottom">
										<ul class="nav profile-navbar">
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-user"></i> 요청서
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-receipt"></i> 서비스 상세설명
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-calendar"></i> 포트폴리오
											</a></li>
											<li class="nav-item"><a class="nav-link" href="#"> <i
													class="ti-clip"></i> 리뷰
											</a></li>
										</ul>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">요청서
															양식 </b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; height: 450px; margin: 20px 15px 15px 15px; overflow: auto;">
															<c:out value="${proProflVO.proProflReqForm}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px; height: 450px; overflow: auto;">
															서비스 상세설명</b>
													</h5>
													<pre
														style="white-space: pre-wrap; background-color: #fff; margin: 20px 15px 15px 15px;">
															<c:out value="${proProflVO.proProflHist}" />
														</pre>
												</div>
											</div>
										</div>
									</div>

									<!--포트 폴리오-->
									<div class="profile-feed">
										<div id="portfolio"
											style="width: 100%; height: auto; margin: 0 auto;">
											<br>
											<h5 style="text-align: center; margin: 15px 0;">
												<b
													style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
													포트 폴리오</b> <br>
												<br>
											</h5>
											<c:if test="${proSession.userId==proProflVO.proId}">
												<button class="btn btn-outline-primary btn-fw"
													style="margin: 10px 0 20px 500px;" type="button"
													onclick="location.href='/prtFolio/create'">포트폴리오
													추가</button>
											</c:if>
											<c:if test="${VPrtfolioVO[0].sprviseAtchmnflNo == null}">
												<div style="text-align: center;">
													<img src="../resources/images/우는모양.png"
														style="width: 100px; height: 100px;" />
													<h3 style="padding: 20px 0 40px 0; color: #c6c9cc;">
														아직 등록된 포트폴리오가 없어요! <br>
														<br>
														<c:if test="${proSession.userId==proProflVO.proId}">
															<button type="button" id="pop" class="btn btn-primary">포트 폴리오란?</button>
														</c:if>
													</h3>
												</div>
											</c:if>
											<ul>
												<c:forEach items="${VPrtfolioVO}" var="portfolio">
													<li
														style="list-style-type: none; display: inline-block; margin-right: 5px; width: 150px;">
														<div>
															<a href="#modalPicture"
																data-picture-url="${portfolio.spAtVOList[0].atchmnflCours}"
																data-toggle="modal"> <img class="prtThumb"
																src="${portfolio.spAtVOList[0].atchmnflCours}"
																data-prtfolio-sj="${portfolio.prtfolioSj}"
																data-sprvise-atchmnfl-no="${portfolio.spAtVOList[0].sprviseAtchmnflNo}"
																style="width: 150px; height: 150px; border-radius: 20%">
															</a>
														</div>
														<div class="prtName">
															<input type="text" name="prtName" id="portfolioTitle"
																value="${portfolio.prtfolioSj}"
																style="width: 100%; margin: 5px 0; text-align: center; background: none; border: none;">
														</div>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>

									<div class="profile-feed">
										<div style="margin: 0 auto;">
											<div class="ms-4">
												<div
													style="width: 100%; height: auto; float: left; overflow: auto;">
													<br>
													<h5 style="text-align: center; margin: 15px 0;">
														<b
															style="font-size: 20px; background-color: #f5f7ff; border-radius: 20px; padding: 5px 20px;">
															리뷰</b>
													</h5>
													<!--[ReviewVO(reNo=81, reTy=REV01, reCn=아주 좋았어요!, reWrDt=Sat Mar 30 01:07:26 KST 2024, reScore=4, srvcRequstNo=382, vSrvcRequstVOList=null, 
															srvcReVOList=[SrvcRequstVO(mberId=testUser, proId=testPro)], 
															mberReviewVOList=[MberVO(mberId=testUser, mberProflPhoto=null,)], 
															userReviewVOList=[UsersVO(userNcnm=tesU023)], 
															comReviewVOList=[CommonCdDetailVO(commonCdDetail=REV01, commonCdDetailNm=책임감 있어요]),  -->

													<div id="proReviewBody"></div>
													<div id="S_divPaging"
														style="position: relative; margin-top: 20px; padding-bottom: 50px;"">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //////// 포트폴리오 이미지 크게 보기 모달 //////// -->
	<div class="modal fade" id="modalPicture" tabindex="-1"
		aria-labelledby="exampleModalLabel-2" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalPicTitle"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!-- 
			sprviseAtchmnflVOList : 
			[VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=1, 
				atchmnflCours=/images/2024/03/18/932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflNm=거징징이.jpg, storeAtchmnflNm=932722b2-a0ac-4039-a8a5-4081e2beee5d_거징징이.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null), 
			VPrtfolioVO(prtfolioNo=32, prtfolioSj=1번, prtfolioWrDt=Mon Mar 18 17:07:08 KST 2024, 
				sprviseAtchmnflNo=323, proId=protest200, atchmnflNo=2, 
				atchmnflCours=/images/2024/03/18/168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflNm=아니.jpg, storeAtchmnflNm=168de32a-0169-4817-a2dd-d7ef6f6429f6_아니.jpg, 
				atchmnflTy=image/jpeg, registDt=Mon Mar 18 17:07:08 KST 2024, updtDt=null)]
			
			 -->
				<div class="modalPicBody" style="margin-left:20px;">
					<ul id="ulPrt" style="margin: 7px 0 0 18px;">
					</ul>
				</div>

				<div class="modal-footer">
					<c:if test="${proSession.userId==proProflVO.proId}">
						<button type="button" class="btn btn-success">삭제하기</button>
					</c:if>
					<button type="button" class="btn btn-light" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</c:if>
<!-- ///// 신고 누를시 뜨는 모달창 /// -->
<div class="modal fade" id="modal-sm">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title general" id="modalTitle">🚨 신고하기</h4>
				<input type="hidden" id="userId2"
					class="form-control is-warning edit" value="${proProflVO.proId}"
					style="display: block;" /> <input type="hidden" id="userId"
					class="form-control is-warning edit"
					value="${memSession.userId}${proSession.userId}"
					style="display: block;" /> <input type="hidden" id="declTarget"
					class="form-control is-warning edit" value=""
					style="display: block;" /> <input type="hidden"
					id="declLbrtyBbscttNo" class="form-control is-warning edit"
					value="" style="display: block;" /> <input type="hidden"
					id="declLbrtyBbscttAnswerNo" class="form-control is-warning edit"
					value="" style="display: block;" />
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="false">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p class="general" id="modalBody"></p>


				<div>
					<c:forEach var="comCdList" items="${comCdList}" varStatus="stat">
						<input type="radio" id="${comCdList.commonCdDetail}"
							name="declResn" value="${comCdList.commonCdDetailNm}" />
						<label for="${comCdList.commonCdDetail}">${comCdList.commonCdDetailNm}</label>
						<br>
					</c:forEach>
				</div>

				<!-- <textarea rows="10" cols="30" id="declDetailCn" style="display:block;">신고하디</textarea> -->
			</div>
			<div class="modal-footer justify-content-between">

				<button id="declBtn" type="button" class="btn btn-default"
					data-dismiss="modal">신고</button>
				<button id="declCns" type="button" class="btn btn-default"
					data-dismiss="modal" style="display: block;">취소</button>
				<br> <br>

				<!-- 일반모드 -->
				<%--         <button type="button" id="modify" ${disabled} class="btn btn-primary general">수정</button> --%>
				<button type="button" id="delete" ${disabled} style="display: none;"
					class="btn btn-primary general">삭제</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- ///// 동균 신고 누를시 뜨는 모달창 끝 /// -->