<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/5.0.0/imagesloaded.pkgd.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
@media (max-width: 992px) {
    .list-item {
        width: 48%; /* 화면이 작아지면 한 줄에 2개씩 배치됩니다. */
    }
}
@media (min-width: 992px)
.col-lg-5 {
    max-width: 100%;
}
#balloon {
    position: absolute;
    margin-top: -45px;
    top: 0;
    left: 0;
    z-index: 0;
}
#storybbsctt {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}
.button-container {
    text-align: center;
    margin-top: 20px;
}
.a{
color : none;
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
    grid-template-columns: auto auto auto;
    grid-gap: 10px;
    justify-content: center;
}
.list-container {
    justify-content: center;
    flex-wrap: wrap;
}
.list-item {
    width: 23%; 			/* 각 요소 너비를 조절 */
    float: left; 			/* 왼쪽 정렬 */
    margin-bottom: 20px; 	/* 아래 여백추가 */
}
.list-item {
    overflow-y: auto;
}
.list-item img {
    width: 90%; 			/* 이미지를 부모 요소의 너비에 맞춤 */
    height: auto; 			/* 이미지의 비율을 유지 */
    border-radius: 13px; 	/* 이미지의 모서리를 둥글게 */
    overflow: hidden;
}
.btn-clicked {
    background-color: #4CAF50;
    color: white;
}
.icon-container {
    display: inline-block;
    vertical-align: middle;
}
.dropdown-item.active, .dropdown-item:active {
/*     color: #fff; */
    text-decoration: none;
    background-color: #fff;
    color: inherit;
}
.btn-primary {
    background-color: rgba(75, 73, 172, 0.2);
    color: #4B49AC;
    background-image: none;
    border-color: rgba(75, 73, 172, 0);
}
.progress {
    border-radius: 7px;
    height: 20px;
    width: 100%;
	background-color: rgb(0 0 0 / 20%); /* 흐린 배경 */
	z-index: 9999;
	line-height : normal;
}
.progress-text{
align-content : center;
/* margin: 5px; */
}
.progress-text::after {
    content: "\00a0\00a0"; /* 공백 문자 추가 */
}
/* 모달 오버레이 스타일 */
.modal-overlay {
  border: 1px solid transparent; 
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgb(0 0 0 / 24%); 	/* 반투명한 검은색 배경 */
  z-index: 999; 						/* 프로그래스 바보다 위에 표시 */
}
/* 모달 내용 스타일 */
.modal-content {
  position: fixed;
  top: 50%;
  left: 50%;
  width: 300px;
  transform: translate(-50%, -50%);
  background-color: #fff;
  border-radius : 20px;
  padding: 20px;
  z-index: 1000; /* 모달 오버레이보다 위에 표시 */
}
</style>
<script>
$(document).ready(function() {

    let imgTT = document.querySelectorAll("imgTest");
	$("#imgTest").hide();
    // 진행률 표시 함수를 호출
    imagesProgress();
    
    // 진행률 표시 함수를 호출
    function imagesProgress () {

        var $container    = $('#progress'),                    // 1
            $progressBar  = $container.find('.progress-bar'),  // 2
            $progressText = $container.find('.progress-text'), // 3
            // 1. 진행률 표시 전체 컨테이너
            // 2. 진행률 표시 막대 부분
            // 3. 진행률 표시 텍스트 부분

            // imagesLoaded 라이브러리에서 body 요소의 이미지 로딩을 모니터링
            // 동시에 body 전체 이미지 수를 저장
            imgLoad       = imagesLoaded('body'),
            imgTotal      = imgLoad.images.length,

            // 읽을 완료 한 이미지의 숫자 카운터와
            // 진행률 표시의 현재 위치에 해당하는 수치 (모두 처음에는 0)
            imgLoaded     = 0,
            current       = 0,

            // 1 초에 40 번씩 읽어 여부 확인
            progressTimer = setInterval(updateProgress, 1000 / 40);

        // imagesLoaded을 이용하여 이미지를로드 할 때마다 카운터를 가산
        imgLoad.on('progress', function () {
            imgLoaded++;
        });

        // 이미지로드 상황을 바탕으로 진행 표시를 업데이트 setInterval() 메소드 => 1 초에 40번 호출
        function updateProgress () {

            // 읽음 완료 한 이미지의 비율
            var target = (imgLoaded / imgTotal) * 100;

            // current (현재 위치)와 target (목적지)의 거리를 바탕으로 여유를 건다
            current += (target - current) * 0.1;

            // 표시 바의 폭과 텍스트에 current 값을 반영 하고, 텍스트는 소수점 이하 버리고 정수로
            $progressBar.css({ width: current + '%' });
            $progressText.text(Math.floor(current) + '%');

            // 종료
            if(current >= 100){
                // 진행률 표시의 업데이트를 중지
                clearInterval(progressTimer);
                // CSS 스타일을 바꾸기 위하여 클래스를 추가
                $container.addClass('progress-complete');
                // 진행률 막대와 텍스트를 동시에 애니메이션시키기 위해
                // 그룹화하고 하나의 jQuery 객체에
                $progressBar.add($progressText)
                    // 0.5 초 대기
                    .delay(500)
                    // 0.25 초에 걸쳐 진행률 막대와 텍스트를 투명하게
                    .animate({ opacity: 0 }, 250, function () {
                        // 1 초에 걸쳐 오버레이를 위쪽으로 슬라이드 아웃
                        $container.animate({ top: '-100%' }, 1000, 'easeInOutQuint');
                    });
            }

            console.log("이미지 테스트 : " + imgTT);
            // current가 99.9보다 크면 100으로 간주하여 종료
            if (current > 99.9) {
                current = 100;
                $("#modal-content").css("background-color", "transparent");
                $("#modal-overlay").css("border", "transparent");
                $("#modal-overlay").animate({ opacity: 0 }, 150, function() {
                    $(this).hide(); // 애니메이션이 완료된 후 요소 숨기기
                });
                $("#modal-content").animate({ opacity: 0 }, 150, function() {
                    $(this).hide(); // 애니메이션이 완료된 후 요소 숨기기
                });
                // imgTT.animate({ opacity: 0 }, 150, function() {
                //     $(this).hide(); // 애니메이션이 완료된 후 요소 숨기기
                // });

				imgTest.style.transition = "opacity 0.15s"; // 애니메이션 효과 설정
				imgTest.style.opacity = "0"; // 요소를 투명하게 만듦

		// 애니메이션이 완료된 후 요소 숨기기
		setTimeout(function() {
			imgTest.style.display = "none";
		}, 150); // 150밀리초 후에 요소를 숨김
						
						$("#imgTest").show();
						$container.hide();
						$progressBar.hide();
						$progressText.hide();
					}

				}
			}
    
	// 	var totalPages      = ${total};
	var type ="";
	var keyword ="";
	
	// 정렬하기 위한 배열데이터
	let storyData       = [];
	let storySearchData = [];

	<% /* 최초 실행 */%>
	addPage("${param.currentPage}");
	
	const addBtn     = document.querySelector("#addBtn");
	const nowCnt     = document.querySelector("#nowCnt");
	const getCnt     = document.querySelector("#getCnt");
	const goodCnt    = document.querySelector("#goodCnt");
	const btnSearch  = document.querySelector("#btnSearch");
	
	console.log("storyData       : " + storyData);
	console.log("storySearchData : " + storySearchData);

	//start create click
	$("#create").on("click", function(){
		
		$.ajax({
			url : "/prostory/idCheck",
			method : "get",
			success : function(result){
				
				if(result === "not"){
					Swal.fire({
		                title: "로그인 후 이용하세요",
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
		
		location.href = "/prostory/write"
		
	});// end create click

	/* 좋아요순 정렬	*/	
	goodCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 추천수 버튼:: " + storyData["proStoryBbscttRecommend"]);
	   	
	    storyData.sort((a, b) => b.proStoryBbscttRecommend - a.proStoryBbscttRecommend);

	    displaySortedData(storyData);
	    
	});// end goodCnt -> 좋아요순 정렬
	
	/* 조회수 정렬	*/	
	getCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 조회수 버튼:: " + storyData["proStoryBbscttRdcnt"]);
	   	
	    storyData.sort((a, b) => b.proStoryBbscttRdcnt - a.proStoryBbscttRdcnt);

	    displaySortedData(storyData);
	   	
	});// end getCnt -> 조회수 정렬
	
	/* 최신순 정렬	*/	
	nowCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 최신순 버튼:: " + storyData["proStoryBbscttWrDt"]);
	   	
	    storyData.sort((a, b) => new Date(b.proStoryBbscttWrDt) - new Date(a.proStoryBbscttWrDt));

	    displaySortedData(storyData);
	    
	});// end nowCnt -> 최신순 정렬
	
	/* 오래된순 정렬	*/	
	reverseNow.addEventListener("click", function() {
	    
	   	console.log("storyData 오래된순 버튼:: " + storyData["proStoryBbscttWrDt"]);
	   	
	   	storyData.sort((a, b) => new Date(a.proStoryBbscttWrDt) - new Date(b.proStoryBbscttWrDt));
		
	   	displaySortedData(storyData);
		
	});// end nowCnt -> 오래된순 정렬

	function displaySortedData(resultData) {
		
	    let str = "";
	    
	    for (let i = 0; i < resultData.length; i++) {
	    
	    	let story = resultData[i];
	    	str += '<div class="list-item" style="margin : 0px;">';
			str += '<ul class="text-center">';
			str += '<li><a style="font-family : GmarketSansMedium; font-size : 1.3rem; word-break :keep-all;  color : black;" href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">';
// 			str += '<li><img id="imgTest" src="/resources/images/엑박.jpg" onload="this.src=\'/images/' + story.proStoryBbscttThumbPhoto + '\'" /></li>';
			str += '<li><img id="imgTest" src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
// 			str += '<li><img src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
			str += '<br>' + story.proStoryBbscttSj + '</a></li>';
			str += '<li class="vertical-center">';
			str += '<img src="/resources/images/free-icon-like.png" alt="이미지" style="width:25px"> ' +story.proStoryBbscttRecommend + '&nbsp;&nbsp;';
			str += '<img src="/resources/images/click.png" alt="이미지" style="width:25px"> ' +story.proStoryBbscttRdcnt + '</li>';
			str += '</ul>';
			str += '</div>';
			
//				str += '<li><img id="imgTest" src="/resources/images/엑박.jpg" onload="this.src=\'/images/' + story.proStoryBbscttThumbPhoto + '\'" /></li>';
			
	    }
	    document.getElementById('listContent').innerHTML = str;
	    applyStylesToNewItems();
	}
	
	// 드롭다운 & 검색 클릭 이벤트 핸들러
	document.querySelectorAll('.dropdown-item').forEach(item => {
	    
		item.addEventListener('click', event => {
	        // 클릭한 메뉴의 텍스트를 버튼에 적용
	        searchType = document.querySelector("#searchType").innerText = event.target.innerText;
	        // 다른 모든 메뉴 비활성화
	        document.querySelectorAll('.dropdown-item').forEach(item => {
	            item.classList.remove('active');
	        });
	        // 클릭한 메뉴 활성화
	        event.target.classList.add('active');
	
	        // 클릭한 메뉴에 따라 동작 수행
	        switch(event.target.id) {
	        
	            case "title":
	            	type = searchType;
	                console.log("제목 버튼 클릭 : " + type);
	                break;
	            case "content":
	            	type = searchType;
	                console.log("내용 버튼 클릭 : " + type);
	                break;
	            case "writer":
	            	type = searchType;
	                console.log("작성자 버튼 클릭 : " + type);
	                break;
	            default:
	        }
	    });
	});

	btnSearch.addEventListener("click" , function(){
	
		let currentPage = "${param.currentPage}"
		
		keyword = document.getElementById("searchKeyword").value;
		
		console.log("keyword : " + keyword);
		
		if(type==""){
			type = "제목";
		}
		
		if(keyword == ""){
			Swal.fire({
                title: "검색어를 입력하세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
			return;
		}
		console.log("type : " + type);
		
		let	data = { "currentPage" : currentPage,
					 "keyword"     : keyword,
					 "type"        :type
					};
		
		console.log("type 여기서 값을 봐야 : " + type);
		console.log("currentPage 여기서 값을 봐야 : " + currentPage);
		console.log("keyword 여기서 값을 봐야 : " + keyword);
		$.ajax({
			url : "/prostory/getPage",
			type : "post",
			dataType : "json",
			data : data,			
			success : function(result , textStatus){
				console.log("test : " + result);
				
				let data = result.content;
				
				let str = "";
				
				data.forEach(function(story) {
				    var str = '<div class="list-item">';
				    str += '<ul class="text-center">';
				    str += '<li><a style="font-family : GmarketSansMedium; font-size : 1.3rem; word-break :keep-all;  color : black;" href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">';
// 				    str += '<li><img id='"imgTest"' src="/resources/images/엑박.jpg" onload="this.src=\'/images/' + story.proStoryBbscttThumbPhoto + '\'" /></li>';
// 				    str += '<li><img id="imgTest" src="/resources/images/엑박.jpg" onload="this.src=\'/images/' + story.proStoryBbscttThumbPhoto + '\'" /></li>';
				    str += '<li><img id="imgTest" src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
				    str += '<br>' + story.proStoryBbscttSj + '</a></li>';
				    str += '<li class="vertical-center">';
				    str += '<img src="/resources/images/free-icon-like.png" alt="이미지" style="width:25px"> ' + story.proStoryBbscttRecommend + '&nbsp;&nbsp;';
				    str += '<img src="/resources/images/click.png" alt="이미지" style="width:25px"> ' + story.proStoryBbscttRdcnt + '</li>';
				    str += '</ul>';
				    str += '</div>';

				    storyData.push(story);

				    document.getElementById('listContent').innerHTML = str;
				});

				$("#divPagingArea").html(result.pagingArea);
			}
		})
	})

	<% // start addPage function %>
	function addPage(currentPage){
		
		$.ajax({
			url : "/prostory/getPage",
			async : true,
			type : "post",
			dataType : "json",
			data : {"currentPage":currentPage},
			success : function(result , textStatus){
				
				let data = result.content;
	
				let str = "";
				
				//result : ArticlePage
				$.each(data , function(idx , story){
					str += '<div class="list-item">';
					str += '<ul class="text-center">';
					str += '<li><a style="font-family : GmarketSansMedium; font-size : 1.3rem; word-break :keep-all;  color : black;" href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">';
// 					str += '<li><img id="imgTest" src="/resources/images/엑박.jpg" onload="this.src=\'/images/' + story.proStoryBbscttThumbPhoto + '\'" /></li>';
					str += '<li><img id="imgTest" src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
					
					str += '<br>' + story.proStoryBbscttSj + '</a></li>';
					str += '<li class="vertical-center">';
					str += '<img src="/resources/images/free-icon-like.png" alt="이미지" style="width:25px"> ' +story.proStoryBbscttRecommend + '&nbsp;&nbsp;';
					str += '<img src="/resources/images/click.png" alt="이미지" style="width:25px"> ' +story.proStoryBbscttRdcnt + '</li>';
					str += '</ul>';
					str += '</div>';
							
					storyData.push(story);
				});// end for
	
				document.getElementById('listContent').innerHTML += str;
	// 			applyStylesToNewItems();
				$("#divPagingArea").html(result.pagingArea);
			}// end success
			
		})// end ajax
		
	}// end addPage

function applyStylesToNewItems() {
	
	   let newItems = document.querySelectorAll('.list-item');
	
	   newItems.forEach(function(item) {
			item.style.overflow = 'hidden';
	    });
	}
})
$(document).on('keydown', function(e){

	if (e.code == 'Enter' && !$('#tynQuickChatInput').is(':focus')) {
// 	       e.stopPropagation();
	       $('#btnSearch').click();
	   }
});
</script>
<% /* 로딩 스피너*/%>
<div class="modal-overlay" id="modal-overlay"></div>

<!-- 모달 내용 -->
<div class="modal-content" id="modal-content">
    <!-- 모달 내용 -->
	<div style="text-align: center; font-family: 'GmarketSansMedium';">
	    <img id="imgIcon" src="/resources/images/로딩아이콘.gif" style="width: 60px; height: 60px;">
		<br>잠시만 기다려 주세요
		<br>
	</div>
		<br>
	<div class="progress" id="progress">
	    <div class="progress-bar" id="progress-bar">
	    </div>
	    <div class="progress-text" id="progress-text">&nbsp;0%</div>
	</div>
	<br>
</div>
<% /* 로딩 스피너*/%>
  <!-- 제목 -->
<div>
<div class="list-container" style="text-align: center;">
	<div class="container col-lg-5" style="text-align:center; position: absolute; top: 0; left: 0; width: 100%; max-width: 100%">
    	<div>
		<!-- 제목 -->
		<div >
			<img alt="프로이야기" src="../resources/images/프로이야기.png" style="width:100px; height:auto; margin:150px 0 20px 0;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로이야기</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 750px 0 750px;">
		</div>
	    </div>
	</div>
		<br>
<div class="container col-lg-8">
	<br><br><br><br><br><br><br><br><br>
	
	<div class="d-flex justify-content-center align-items-center mb-3">
		<div class="dropdown" style="float: right; margin-right: 0">
			<button class="btn btn-inverse-primary btn-sm dropdown-toggle" type="button" id="searchType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-right: 10px;">제목</button>
			<input type="text" name="keyword" id="searchKeyword" value="${param.keyword}" style="width: 250px; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left:11px; font-family: GmarketSansMedium; text-indent: 10px;">
			<button type="button" class="btn btn-inverse-primary btn-sm" id="btnSearch" style="margin-left: 10px;">
				<i class="mdi mdi-yeast"></i>
			</button>
			<div class="dropdown-menu" id="dropdown-menu2" aria-labelledby="dropdownMenuSizeButton3" style="min-width: 150px;">
				<p class="dropdown-item" id="title">제목</p>
				<p class="dropdown-item" id="content">내용</p>
				<p class="dropdown-item" id="writer">작성자</p>
			</div>
		</div>
        <c:if test="${memSession==null && proSession != null}">
            <button class="btn btn-inverse-primary btn-sm" type="button" id="create" style="margin-left: 10px;">글쓰기</button>
        </c:if>
	</div>
    <div class="d-flex justify-content-end align-items-center">
    </div>

	<div class="container col-lg-8 d-flex justify-content-center">
	    <nav class="scroll-hidden flex space-x-3 lg:space-x-8" aria-label="Tabs">
			<button id="nowCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">최신순</button>
	        <button id="reverseNow" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5" >오래된순</button>
			<button id="getCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">조회수</button>
			<button id="goodCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">좋아요</button>
	    </nav>
	</div>
</div>
	<br />
	<div style="text-align: left; margin-left: 90px; ">
		<h3 style="font-family: 'seolleimcool-SemiBold'; color:#a7a7a7;">
		<img src="/resources/images/다이어리.gif" style="width: 60px ">	프로의 특별한 이야기를 만나보세요 </h3>
	</div>
	
	<div class="list-container" id="listContent" style="display: flex; justify-content: center; ">
	</div>
</div>
<!--  -->
<div class="col-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<div id="divPagingArea" style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
		</div>
	</div>
</div>
</div>
