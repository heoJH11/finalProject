<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/skydash/js/chart.js"></script>
<style>
#reviewProId:hover {
  font-size: 1.2em;
  transition-duration: 0.5s;

}
*{
  font-family: 'GmarketSansLight';
}

a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'GmarketSansLight';
}
p{
	text-decoration: none;
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
.star_rating {
  width: 100%; 
  box-sizing: border-box; 
  display: inline-flex; 
  float: left;
  flex-direction: row; 
  justify-content: flex-start;
  margin-top : 3px;
  margin-bottom: 3px;
}
.star_rating .star {
  width: 25px; 
  height: 25px; 
  margin-right: 10px;
  display: inline-block; 
  background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png') no-repeat; 
  background-size: 100%; 
  box-sizing: border-box; 
}
.star_rating .star.on {
  width: 25px; 
  height: 25px;
  margin-right: 10px;
  display: inline-block; 
  background: url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png') no-repeat;
  background-size: 100%; 
  box-sizing: border-box; 
}

.star_box {
  width: 400px;
  box-sizing: border-box;
  display: inline-block;
  margin: 15px 0;
  background: #F3F4F8;
  border: 0;
  border-radius: 10px;
  height: 100px;
  resize: none;
  padding: 15px;
  font-size: 13px;
  font-family: sans-serif;
}

#showReviewModal{
    width: 430px;
    background-color: white;
    padding-right: 17px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    height: auto;
    padding: 15px;
    border-radius: 10px;
}

#modalBackdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 검은색 배경에 투명도 추가 */
    z-index: 999; /* 다른 요소 위에 배치 */
    display: none; 
}

.notification-dot {
        position: absolute;
        top: 3px;
        right: 15px;
        transform: translate(50%, -50%);
        width: 10px;
        height: 10px;
        background-color: red;
        border-radius: 50%;
    }

    .img-wrapper {
        position: relative;
        display: inline-block; /* 부모 요소의 크기를 자식 요소에 맞추기 위해 사용 */
    }
</style>
<div class="sidenav">
	<p style="text-align: center;">
		<b>MYPAGE MENU</b>
	</p>
	<hr>
	<c:if test="${memSession.userId  != null && proSession.userId  == null}">
		<a href="/member/memberMypage">마이페이지</a>
		<a href="/srvcBtfInqry/myBtfInqryList">보낸 서비스 사전 문의</a>
	 	<a href="/srvcRequst/mySrvcRqList">보낸 서비스 요청서</a> 
		<a href="/member/memberOndyclList">원데이클래스</a>
		<a href="/member/memberPostList">게시글 관리</a> 
		<a href="/srvcRqReview/reMgmt" id="reviewMgmtLink">서비스 요청 리뷰 관리</a>
		<a href="/oneInqry/myOneInqryList">1:1 문의 내역</a>	
	</c:if>
	<c:if test="${proSession.userId  != null && memSession.userId == null}">
		<a href="/pro/proMypage">마이페이지</a>
		<a href="/srvcBtfInqry/myBtfInqryList">받은 서비스 사전 문의</a>
		<a href="/srvcRequst/mySrvcRqList">받은 서비스 요청서</a> 
		<a href="/pro/proMyClassList">원데이클래스</a>
		<a href="/pro/proPostList">게시글 관리</a> 
		<a href="/srvcRqReview/proReMgmt" id="reviewMgmtLink">서비스 요청 리뷰 관리</a>
	<a href="/oneInqry/myOneInqryList">1:1 문의 내역</a>
	</c:if>
</div>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px; margin-left: 92px;">
<div class="col-md-12 grid-margin grid-margin-md-0">
    <div class="card">
        <div class="card-body text-center">
            <div style="padding-left: 17px;">
                <img class="img-lg rounded-circle mb-2" id="userProfile" alt="profile image" src="/images/2024/profile.jpg">
                <h4 style="margin: 10px 0 10px 0;" id="userNcnm"></h4>
            </div>
            <button class="btn btn-info btn-sm mt-3 mb-4" id="proProfileLink" style="display: none;"><i class="ti-user"></i> My Profile</button>
            <div class="border-top pt-3">
                <div class="row">
                    <div class="col-4">
                        <h6 id="srvcRqCnt">${rqrvTotal}</h6>
                        <button type="button" id="srvcRqBtn" class="btn btn-outline-primary btn-sm" data-clicked="false">이용 완료 서비스</button>
                    </div>
                    <div class="col-4">
                        <h6 id="reviewWrCnt">${rvTotal}</h6>
                        <button type="button" id="reviewWrBtn" class="btn btn-outline-primary btn-sm">나의 리뷰</button>
                    </div>
                    <div class="col-4">
	                        <h6 id="reScoreAvg">${rvScoreAvg}</h6>
                        <button type="button" id="reScoreChrtBtn"class="btn btn-outline-primary btn-sm">나의 평균 별점</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 리스트섹션 -->
<div class="listGrid" ></div>
<div id="divPaging" style="margin-left: 49%;"></div>
</div>
<script>
var memId = "${memSession.userId}";
var proId = "${proSession.userId}";
var profile = "";
console.log("회원별명 :", memId);
console.log("프로별명 :", proId);
if(memId != ""){
	if("${memSession.profile}"!= ""){
		$("#userProfile").attr("src", "${memSession.profile}");
	}
	$("#userNcnm").text("${memSession.userNcnm}");
	$("#proProfileLink").css("display", "none");
}
if(proId != ""){
	if("${proSession.profile}"!= ""){
		$("#userProfile").attr("src", "${proSession.profile}");
	}
	$("#userNcnm").text("${proSession.userNcnm}");
	$("#proProfileLink").css("display", "block");
	$("#proProfileLink").attr("onclick", "location.href='/proProfl/detail?proId='${proSession.userId}");
	
}
console.log("${rvScoreAvg}");
var reScoreAvg = "${rvScoreAvg}";
if(reScoreAvg == "NaN"){
	$("#reScoreAvg").text(0);
}

$(document).ready(function() {
    //페이지 로드 시 초기 상태 확인
    var srvcRqBtnClicked = localStorage.getItem('srvcRqBtnClicked');
    var reviewBtnClicked = localStorage.getItem('reviewBtnClicked');
    var reScoreChrtBtnClicked = localStorage.getItem('reScoreChrtBtnClicked');
    
    if (srvcRqBtnClicked === 'true') {
        $("#srvcRqBtn").addClass("active");
        loadSrvcRqList(); // 이용 완료 서비스 목록 로드
    }else if(reviewBtnClicked === 'true'){
    	$("#reviewWrBtn").addClass("active");
    	loadReviewList();
    }else if(reScoreChrtBtn == 'true'){
    	$("#reScoreChrtBtn").addClass("active");
    }

    // 이용 완료 서비스 버튼 클릭 시
    $("#srvcRqBtn").on("click", function() {
    	$("#reviewWrBtn").removeClass("active");
    	$("#reScoreChrtBtn").removeClass("active");
        if (!$(this).hasClass("active")) {
            $(this).addClass("active");
            localStorage.setItem('srvcRqBtnClicked', 'true');
            loadSrvcRqList(); // 
        }
    });
    
 // 작성 리뷰 버튼 클릭 시
    $("#reviewWrBtn").on("click", function() {
    	$("#srvcRqBtn").removeClass("active");
    	$("#reScoreChrtBtn").removeClass("active");
        if (!$(this).hasClass("active")) {
            $(this).addClass("active");
            localStorage.setItem('reviewBtnClicked', 'true');
            loadReviewList(); // 
        }
    });

 // 별점 버튼 클릭 시
    $("#reScoreChrtBtn").on("click", function() {
    	$("#srvcRqBtn").removeClass("active");
    	$("#reviewWrBtn").removeClass("active");
        if (!$(this).hasClass("active")) {
            $(this).addClass("active");
            localStorage.setItem('reScoreChrtBtnClicked', 'true');
            loadReScoreChrt(); // 
        }
    });
});

window.addEventListener('beforeunload', function(event) {
    // 현재 URL을 확인하고 특정 조건을 만족하면 localStorage를 초기화합니다.
    if (window.location.href.indexOf('/srvcRqReview/reMgmt') === -1) {
        localStorage.removeItem('srvcRqBtnClicked'); // localStorage 초기화
        localStorage.removeItem('reviewBtnClicked'); // localStorage 초기화
        localStorage.removeItem('reScoreChrtBtnClicked'); // localStorage 초기화
    }
});

// 이용 완료 서비스 목록 로드
function loadSrvcRqList() {
    // 전체 목록
    let currentPage = "${param.currentPage}";
    if (currentPage == "") {
        currentPage = "1";
    }

    let size = "5";

    let data = {
        "keyword": "${param.keyword}",
        "currentPage": currentPage,
        "size": size
    }
    console.log("기본 리스트 data : ", data);

    $.ajax({
        url: "/srvcRequst/srvcRqSuccessList",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        success: function(res) {
            console.log("이용완료 res :", res);
            $(".listGrid").html("");
            $("#divPaging").html("");
            var str = "";
            str += "<div class='col-md-12 stretch-card grid-margin'>";
            str += "<div class='card'>";
            str += "<div class='card-body'>";
            str += "<p class='card-title text-center'>이용 완료 서비스</p>";
            str += "<ul class='icon-data-list'>";
            $.each(res.content, function(i, v) {
                if (v.srvcRequstProcessMber == "1" && v.srvcRequstProcessPro == "1") {
                    str += "<li>";
                    str += "<div class='d-flex' id='srvcRqRow" + v.srvcRequstNo + "' data-value='" + v.srvcRequstNo + "'>";
                    str += "<div class='img-wrapper' style='margin-right:7px;'>"; // 이미지와 알림 점을 감싸는 래퍼 요소
                    str += "<img src='" + v.proProflPhoto + "'>";
                    str += "<div class='notification-dot' id='notiDot" + v.srvcRequstNo + "' style='display:block;'></div>"; // 알림 점 추가
                    str += "</div>"; // img-wrapper 종료
                    str += "<div>";
                    str += "<p class='mb-1' id='reviewProId' onclick=\"location.href='/proProfl/detail?proId=" + v.proId + "'\">" + v.userNcnm + "</p>";
                    str += "<p class='mb-0' onclick=\"location.href='/srvcRequst/srvcRqSuccessList'\">" + v.srvcRequstSj + "</p>";
                    str += "<small>" + (v.srvcRequstWrDt).substr(0, 10) + "</small>";
                    str += "</div>";
                    str += "</div>";
                    str += "</li>";
                }
            }); //each 종료
            str += "</ul></div></div></div>";
            $(".listGrid").html(str);
            if(res.total == 0){
	            $("#divPaging").html("");
            }else{
	            $("#divPaging").html(res.pagingArea);
            }

            NotyreviewNoWr();
        } //success 종료
    });
}

// 요청서 목록에서 리뷰 미작성 요청서 표시
function NotyreviewNoWr() {
    var reviewVOList = ${reviewVOList}; // JSON 데이터 받아오기
    $.each(reviewVOList, function(i, v) {
        console.log(v);
        var reRequstNo = v.srvcRequstNo;
        var srvcRequstNo = $("#srvcRqRow" + reRequstNo).data("value");
        if (reRequstNo == srvcRequstNo) {
            $("#notiDot" + srvcRequstNo).css("display", "none");
        }
    });
}

// 작성 리뷰
function loadReviewList(){
	// 전체 목록
	let currentPage = "${param.currentPage}";
	if(currentPage == ""){
		currentPage = "1";
	}
	
	let size = "5";
	
	let data = {
			"keyword" : "${param.keyword}",
			"currentPage" : currentPage,
			"size" : size
	}
	console.log("기본 리스트 data : ", data);
	
	$.ajax({
		url : "/srvcRqReview/reviewList",
	    contentType : "application/json; charset=utf-8",
	    data : JSON.stringify(data),
	    type : "post",
	    dataType : "json",
	    success : function(res){
	    	console.log("이용완료 res :" , res);
	    	var cdDetailList = ${cdDetailList};
	    	console.log("json으로 부른 코드 : ", cdDetailList);
	    	$(".listGrid").html("");
	    	$("#divPaging").html("");
	    	str = "";
	    	str += "<div class='col-md-12 stretch-card grid-margin'>";
	    	str += "<div class='card'>";
	    	str += "<div class='card-body'>";
	    	str += "<p class='card-title text-center'>나의 리뷰</p>";
	    	if(res.reviewNoWrCnt > 0){
	    		str += "<p class='card-description'>작성되지 않은 리뷰가 "+res.reviewNoWrCnt+"건 있습니다.</p>"
	    	}
	    	str += "<ul class='icon-data-list'>";
	    	$.each(res.data.content, function(i, v){
	    		console.log("리뷰 후기 : ", res.data.content);
	    		var reScore = v.RE_SCORE;
	    		console.log("reScore :", reScore);
	    		var reTy = v.RE_TY;
	    		console.log("유형 : ", reTy);
	    		var date = new Date(v.RE_WR_DT);
	    		var formattedDate = date.getFullYear() + '.' + ('0' + (date.getMonth() + 1)).slice(-2) + '.' + ('0' + date.getDate()).slice(-2);
	    		str += "<li>";
	    		str += "<div class='d-flex'>";
	    		str += "<img src='"+v.PRO_PROFL_PHOTO+"'>";
	    		str += "<div>";
	    		str += "<p class='mb-1' id='reviewProId' onclick=\"location.href='/proProfl/detail?proId=" + v.PRO_ID + "'\">" + v.USER_NCNM + "</p>";
	    	    $.each(cdDetailList, function(i, cdNm){
	    			console.log("cdDetailList", cdNm.COMMON_CD_DETAIL);
	    			var cdDetail = cdNm.COMMON_CD_DETAIL;
	    			if(reTy == cdDetail){
	    				str += "<small class='btn btn-outline-secondary btn-sm'>"+cdNm.COMMON_CD_DETAIL_NM+"</small>";
	    			}
	    	    });
// 	    		str += "<button type='button' class='btn btn-inverse-primary btn-sm' onclick=\showReview('"+v.RE_NO+"')\>리뷰 보기</button>"
	    		str += "<div class ='star_rating'>";
	    		str += "<span class='star " + (reScore >= 1 ? "on" : "") + " reScoreVal1' value='1'></span>";
	    		str += "<span class='star " + (reScore >= 2 ? "on" : "") + " reScoreVal2' value='2'></span>";
	    		str += "<span class='star " + (reScore >= 3 ? "on" : "") + " reScoreVal3' value='3'></span>";
	    		str += "<span class='star " + (reScore >= 4 ? "on" : "") + " reScoreVal4' value='4'></span>";
	    		str += "<span class='star " + (reScore >= 5 ? "on" : "") + " reScoreVal5' value='5'></span>";
	    	    str += "</div>";
	    	    if(v.RE_CN == undefined){
		    		str += "<p class='mb-0' ></p>";
	    	    }else{
		    		str += "<p class='mb-0' style='margin-top:10px;'>" +v.RE_CN+"</p>";
	    	    }
	    		str += "<small>"+formattedDate+"</small>";
	    		str += "</div>";
	    		str += "</div>";
	    		str += "</li>";
	    	});//each 종료
	    	str += "</ul></div></div></div>";
	    	$(".listGrid").html(str);
	    	$("#divPaging").html(res.data.pagingArea);
        }//success 종료
	});// ajax 종료
}// 작성 리뷰 보기 함수 종료

$('.star_rating > .star').click(function() {
    $(this).parent().children('span').removeClass('on');
    $(this).addClass('on').prevAll('span').addClass('on');
});

//별점 차트 보기
function loadReScoreChrt(){
	
	$.ajax({
		url : "/srvcRqReview/reTyChrtList",
		contentType : "application/json; charset:UTF-8",
		success : function(res){
			console.log("별점 차트 res", res);
			$(".listGrid").html("");
			$("#divPaging").html("");
			var str = "";
			str += "<div class='row'><div class='col-md-12 grid-margin stretch-card'><div class='card position-relative'>";
			str	+= "<div class='card-body'><div id='detailedReports' class='carousel slide detailed-report-carousel position-static pt-2' data-ride='carousel'>";
			str	+= "<div class='carousel-inner'><div class='carousel-item active'>"
			str	+= "<div class='row'>";
			str	+= "<div class='col-md-6 border-right'>";
			str	+= "<div class='table-responsive mb-3 mb-md-0 mt-3'>";
			str	+= "<table class='table table-borderless report-table'>";
			str	+= "<tbody>";
			$.each(res.reTyList, function(i, v) {
			    console.log("res.reTyList : ", res.reTyList);
			        if (res.reTyChrtList[i] && res.reTyChrtList[i].COUNT != undefined) {
			            var percent = ((res.reTyChrtList[i].COUNT) / 100.0) * 100;
			        }else{
			        	var percent = 0;
			        }
			            str += "<tr>";
			            str += "<td class='text-muted'>" + res.reviewCodeNmList[i].COMMON_CD_DETAIL_NM+ "</td>";
			            str += "<td class='w-100 px-0'>";
			            str += "<div class='progress progress-md mx-4'>";
			            str += "<div class='progress-bar bg-primary' role='progressbar' style='width: " + percent + "%' aria-valuenow='" + percent + "%' aria-valuemin='0' aria-valuemax='100'></div>";
			            str += "</div>";
			            str += "</td>";
			            str += "<td><h5 class='font-weight-bold mb-0'>" + percent + "</h5></td>";
			            str += "</tr>";
			}); // 코드명 each 끝

			str += "</tbody></table></div></div>";
			str += "<div class='col-md-6 mt-3'>";
			str += "<div class='chartjs-size-monitor'>";
			str += "<div class='chartjs-size-monitor-expand'>";
			str += "<div class=''></div>";
			str += "</div>";
			str += "<div class='chartjs-size-monitor-shrink'>";
			str += "<div class=''></div>";
			str += "</div>";
			str += "</div>";
			str += "<canvas id='north-america-chart' width='376' height='187' style='display: block; height: 150px; width: 301px;' class='chartjs-render-monitor'></canvas>";
			str += "<div id='north-america-legend'>";
			str += "<div class='report-chart'>";
			// 별점 차트	
			var array = [];
// 			$.each(res.reScoreChrtList,function(i, reScore){
// 				if(reScore[i] null){
// 					var v = 0;	
// 				}else {
// 				    var v = reScore.COUNT;
// 				}
// 			    console.log("v " , v);
// 			    array.push(parseFloat((v / 100.0) * 100).toFixed(0));
// 			    console.log("별점 배열 : ", array);
// 			});
			for(i=0; i<5; i++){
				if(res.reScoreChrtList[i] && res.reScoreChrtList[i].RE_SCORE != undefined){
					var v = res.reScoreChrtList[i].COUNT;
				}else {
					var v = 0;
				}
				console.log("v : ",i, v);
				array.push(parseFloat((v / 100.0) * 100).toFixed(0));
				console.log("별점 배열 : ", array);
			}
			str += "</div></div></div></div></div></div></div></div></div></div></div></div>";
			$(".listGrid").html(str);
			
			if($("#north-america-chart").length){
				var areaData = {
			    	labels: ["1점", "2점", "3점", "4점", "5점"],
					datasets: [{
					data: array,
					backgroundColor: [
						"#7371FC","#8C83FB", "#B9ABFC","#CDC1FF","#E5D9F2",
						],
					borderColor: "rgba(0,0,0,0)"
					}
					]
				};
			    var areaOptions = {
			    	      responsive: true,
			    	      maintainAspectRatio: true,
			    	      segmentShowStroke: false,
			    	      cutoutPercentage: 78,
			    	      elements: {
			    	        arc: {
			    	            borderWidth: 4
			    	        }
			    	      },      
			    	      legend: {
			    	        display: false
			    	      },
			    	      tooltips: {
			    	        enabled: true
			    	      },
			    	        legendCallback: function(chart) { 
			    	            var text = [];
			    	            text.push('<div class="report-chart">');
			    	              text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[0] + '"></div><p class="mb-0">1점</p></div>');
			    	              text.push('<p class="mb-0">'+array[0]+'</p>');
			    	              text.push('</div>');
			    	              text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[1] + '"></div><p class="mb-0">2점</p></div>');
			    	              text.push('<p class="mb-0">'+array[1]+'</p>');
			    	              text.push('</div>');
			    	              text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[2] + '"></div><p class="mb-0">3점</p></div>');
			    	              text.push('<p class="mb-0">'+array[2]+'</p>');
			    	              text.push('</div>');
			    	              text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[3] + '"></div><p class="mb-0">4점</p></div>');
			    	              text.push('<p class="mb-0">'+array[3]+'</p>');
			    	              text.push('</div>');
			    	              text.push('<div class="d-flex justify-content-between mx-4 mx-xl-5 mt-3"><div class="d-flex align-items-center"><div class="mr-3" style="width:20px; height:20px; border-radius: 50%; background-color: ' + chart.data.datasets[0].backgroundColor[4] + '"></div><p class="mb-0">5점</p></div>');
			    	              text.push('<p class="mb-0">'+array[4]+'</p>');
			    	              text.push('</div>');
			    	            text.push('</div>');
			    	            return text.join("");
			    	          },
			    	    }
			    var northAmericaChartPlugins = {
			    	      beforeDraw: function(chart) {
			    	        var width = chart.chart.width,
			    	            height = chart.chart.height,
			    	            ctx = chart.chart.ctx;
			    	    
			    	        ctx.restore();
			    	        var fontSize = 3.125;
			    	        ctx.font = "500 " + fontSize + "em sans-serif";
			    	        ctx.textBaseline = "middle";
			    	        ctx.fillStyle = "#13381B";
			    	    
			    	        var text = ${rvScoreAvg},
			    	            textX = Math.round((width - ctx.measureText(text).width) / 2),
			    	            textY = height / 2;
			    	    
			    	        ctx.fillText(text, textX, textY);
			    	        ctx.save();
			    	      }
			    	    }
			    var northAmericaChartCanvas = $("#north-america-chart").get(0).getContext("2d");
			    var northAmericaChart = new Chart(northAmericaChartCanvas, {
			      type: 'doughnut',
			      data: areaData,
			      options: areaOptions,
			      plugins: northAmericaChartPlugins
			    });
			    document.getElementById('north-america-legend').innerHTML = northAmericaChart.generateLegend();
			}//chart if 끝
		}// success 끝
	}); //ajax 끝
}
</script>
<!-- 리뷰 디테일 모달 -->
<div class="modal" id="showReviewModal">
        <h3>내가 쓴 리뷰</h3>
        <p>욕설 및 비방은 관리자에 의해 삭제될 수 있습니다.</p>
        
        <div class ="star_rating">
          <span class="star reScoreVal1" value="1" > </span>
          <span class="star reScoreVal2" value="2"> </span>
          <span class="star reScoreVal3" value="3"> </span>
          <span class="star reScoreVal4" value="4"> </span>
          <span class="star reScoreVal5" value="5"> </span>
        </div>
        
        <div class="form-control" id=reTy style="height: 30px; margin-top: 43px;">
        </div>
        
        <div>
            <pre class="star_box" id="reCn" style="display:none"></pre>
        </div>
        
        <div style="float: right">
            <button type="button" class="btn btn-inverse-secondary btn-sm" onclick="closeModal()" style="margin-top: 10px;">닫기</button>
        </div>
</div>
<div id="modalBackdrop"></div>
