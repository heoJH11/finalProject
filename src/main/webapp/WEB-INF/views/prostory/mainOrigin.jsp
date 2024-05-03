<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
/* sweet alert */
        .dialog-container {
            width: 300px;
            height: 200px;
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
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

        /* sweet alert */
        .grid-container {
            display: grid;
            grid-template-columns: auto auto auto;
            /* 세 개의 열을 생성합니다. */
            grid-gap: 10px;
            /* 그리드 아이템 사이의 간격을 지정합니다. */
            justify-content: center;
            /* 그리드 아이템들을 가운데 정렬합니다. */
        }

        .list-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            /* 요소들을 한 줄에 배치하고, 넘칠 경우 다음 줄로 이동합니다. */
        }

        .list-item {
            /* 너비 수정하지 않음 */
            margin: 5px;
            /* 요소들 사이의 간격을 설정합니다. */
            overflow: hidden;
        }

        .list-star {
            overflow-y: auto;
            /* 내용이 넘칠 경우 수직 스크롤을 추가합니다. */
        }

        .list-star img {
            max-width: 100%;
            /* 이미지의 최대 너비를 요소의 너비에 맞게 설정합니다. */
            height: auto;
            /* 이미지의 높이를 자동으로 조정하여 가로세로 비율을 유지합니다. */
            border-radius: 15px;
            /* 이미지를 원형으로 처리합니다. */
            overflow: hidden;
            /* 이미지를 부모 요소의 경계에 맞춰 자르기 위해 overflow 속성을 사용합니다. */
        }

        .btn-clicked {
            background-color: #4CAF50;
            /* 변경할 색상 */
            color: white;
        }
</style>

<div class="dialog-container" style="display: none; height:150px;">
    <p style="text-align: center;">마지막 페이지 입니다!</p>
    <div class="button-container">
        <button class="button" onclick="closeDialog()">Close</button>
    </div>
</div>

<script>
	
	function changeButtonColor(button) {
	    // 모든 버튼의 클래스를 초기화
	    var buttons = document.querySelectorAll('.btn-primary');
	    
	    buttons.forEach(function(btn) {
	        btn.classList.remove('btn-clicked');
	    });
	    
	    // 클릭된 버튼에만 색상 변경 클래스 추가
	    button.classList.add('btn-clicked');
	}
	function closeDialog() {
	    document.querySelector('.dialog-container').style.display = 'none';
	     $('#addBtn').remove();
	}

$(document).ready(function() {
		
	// 조회 인덱스
	var firstIndex      = 1;
	var startIndex      = 1;
	var endIndex        = 4;
	var totalPages      = ${total};
	var type ="";
	var keyword ="";
	
	// 정렬하기 위한 배열데이터
	var storyData       = [];
	var storySearchData = [];

	addPage(startIndex);
	
	const addBtn     = document.querySelector("#addBtn");
	const nowCnt     = document.querySelector("#nowCnt");
	const getCnt     = document.querySelector("#getCnt");
	const goodCnt    = document.querySelector("#goodCnt");
	const btnSearch  = document.querySelector("#btnSearch");
	
	console.log("firstIndex      : " + firstIndex );
	console.log("startIndex      : " + startIndex);
	console.log("endIndex        : " + endIndex);
	console.log("totalPages      : " + totalPages);
	console.log("storyData       : " + storyData);
	console.log("storySearchData : " + storySearchData);
	
	$("#create").on("click", function(){
	//start create click
		
		$.ajax({
			url : "/prostory/idChk",
			method : "get",
			
		})
		
		
		location.href = "/prostory/write"
		
	});// end create click

	/*	*/	
	goodCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 추천수 버튼:: " + storyData["proStoryBbscttRecommend"]);
	    storyData.sort((a, b) => b.proStoryBbscttRecommend - a.proStoryBbscttRecommend);

	    displaySortedData(storyData);
	    
	});// end goodCnt -> 좋아요순 정렬
	
	/*	*/	
	getCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 조회수 버튼:: " + storyData["proStoryBbscttRdcnt"]);
	    storyData.sort((a, b) => b.proStoryBbscttRdcnt - a.proStoryBbscttRdcnt);

	    displaySortedData(storyData);
	   	
	});// end getCnt -> 조회수 정렬
	
	/*	*/	
	nowCnt.addEventListener("click", function() {
	    
	   	console.log("storyData 최신순 버튼:: " + storyData["proStoryBbscttWrDt"]);
	    storyData.sort((a, b) => new Date(b.proStoryBbscttWrDt) - new Date(a.proStoryBbscttWrDt));

	    displaySortedData(storyData);
	    
	});// end nowCnt -> 최신순 정렬
	
	/*	*/	
	reverseNow.addEventListener("click", function() {
	    
	   	console.log("storyData 날짜 역순 버튼:: " + storyData["proStoryBbscttWrDt"]);
	   	storyData.sort((a, b) => new Date(a.proStoryBbscttWrDt) - new Date(b.proStoryBbscttWrDt));
		
	   	displaySortedData(storyData);
		
	});// end nowCnt -> 오래된순 정렬

	function displaySortedData(resultData) {
		
	    let str = "";
	    
	    for (let i = 0; i < resultData.length; i++) {
	    
	    	let story = resultData[i];
			     str += '<div class="list-item">';
			     str += '<ul class="list-star text-center">';
			     str += '<li class="no-star"><img src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
			     str += '<li><a href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">' + story.proStoryBbscttSj + '</a></li>';
			     str += '<li>글번호 : ' + story.proStoryBbscttNo + '</li>';
                 str += '<li>작성일 : ' + story.proStoryBbscttWrDt.substring(0 , 10) + '</li>';
			     str += '<li>좋아요 : ' + story.proStoryBbscttRecommend + '</li>';
			     str += '<li>닉네임 : ' + story.userNcnm + '</li>';
			     str += '<li>아이디 : ' + story.userId + '</li>';
			     str += '<li>조회수 : ' + story.proStoryBbscttRdcnt + '</li>';
			     str += '</ul>';
			     str += '</div>';
	    }
	    document.getElementById('test').innerHTML = str;
	    applyStylesToNewItems();
	}
	
	/* 더보기버튼 attBtn click */
	addBtn.addEventListener("click" , function(){
		
		console.log("startIndex 더보기 클릭 전 : " + startIndex);
		startIndex += endIndex;
		console.log("startIndex 더보기 클릭 후 : " + startIndex);
		
		if(totalPages < startIndex || endIndex > totalPages){
			startIndex = totalPages;
			firstIndex      = 1;
			endIndex        = totalPages;
			document.querySelector('.dialog-container').style.display = 'block';
			return;
		}
		
		addPage(startIndex);
		
		console.log("더보기 클릭시 오는 데이터 확인 startIndex : " + startIndex);
		
	})// end addBtn
	
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
	
	console.log("버튼 누를때 startIndex   : " + startIndex);
	console.log("버튼 누를때 totalPages   : " + totalPages);

	console.log("작성자 클릭 확인 : " + type);
	let keyword = document.getElementById("searchKeyword").value;
	
	let currentIndex = startIndex;
	// 시작페이지가 전체페이지 수보다 크거나 같으면
	if(startIndex >= totalPages){
		
		startIndex = totalPages+1;
		
	}
	
	searchPage(firstIndex , startIndex + 1 , type , keyword);
})
/* 통합 */
// start addPage function
function addPage(index){
	
	let $endIndex = index + endIndex - 1;
	
	$.ajax({
		url : "/prostory/getPage",
		async : true,
		type : "post",
		dataType : "json",
		data : {
				startIndex : index ,
				endIndex   : $endIndex
				},
		success : function(result , textStatus){
			
			let data = result;

			// 데이터에 접근하여 필요한 작업을 수행합니다.
			let str = "";

			for (let i = 0; i < data.length; i++) {
				let story = data[i];
				
				str += '<div class="list-item">';
				str += '<ul class="list-star text-center">';
				str += '<li class="no-star"><img src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
				str += '<li><a href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">' + story.proStoryBbscttSj + '</a></li>';
				str += '<li>글번호 : ' + story.proStoryBbscttNo + '</li>';
				str += '<li>작성일 : ' + story.proStoryBbscttWrDt.substring(0 , 10) + '</li>';
				str += '<li>좋아요 : ' + story.proStoryBbscttRecommend + '</li>';
				str += '<li>닉네임 : ' + story.userNcnm + '</li>';
				str += '<li>아이디 : ' + story.userId + '</li>';
				str += '<li>조회수 : ' + story.proStoryBbscttRdcnt + '</li>';
				str += '</ul>';
				str += '</div>';
						
				storyData.push(story);
			}// end for

			document.getElementById('test').innerHTML += str;
			applyStylesToNewItems();
			
		}// end success
		
	})// end ajax
	
}// end addPage
function searchPage(index , currentIndex , type , keyword){
	
	if(type == "") type ="제목";
	
	if(type == "" || keyword == "") { alert("검색어를 입력하세요"); return; }
	
	console.log("searchPage 데이터 확인 index        : " + index);
	console.log("searchPage 데이터 확인 currentIndex : " + currentIndex);
	console.log("searchPage 데이터 확인 type         : " + type);
	console.log("searchPage 데이터 확인 keyword      : " + keyword);
	storyData = [];

	endIndex = currentIndex - 1;
	
	console.log("searchPage 데이터 확인 currentIndex 보낼때 : " + currentIndex);
	
	$.ajax({
		url : "/prostory/getPage",
		async : true,
		type : "post",
		dataType : "json",
		data : {
				startIndex : firstIndex ,
				endIndex   : endIndex - 1,
				type       : type,
				keyword    : keyword
				},
		success : function(result , textStatus){
			
			let data = result;

			let str = "";

			for (let i = 0; i < data.length; i++) {
				let story = data[i];
				
						str += '<div class="list-item">';
						str += '<ul class="list-star text-center">';
						str += '<li class="no-star"><img src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
						str += '<li><a href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">' + story.proStoryBbscttSj + '</a></li>';
						str += '<li>글번호 : ' + story.proStoryBbscttNo + '</li>';
						str += '<li>작성일 : ' + story.proStoryBbscttWrDt.substring(0 ,10) + '</li>';
						str += '<li>좋아요 : ' + story.proStoryBbscttRecommend + '</li>';
						str += '<li>닉네임 : ' + story.userNcnm + '</li>';
						str += '<li>아이디 : ' + story.userId + '</li>';
						str += '<li>조회수 : ' + story.proStoryBbscttRdcnt + '</li>';
						str += '</ul>';
						str += '</div>';
						
						storyData.push(story);
			}// end for
			document.getElementById('test').innerHTML = str;
			applyStylesToNewItems();
		}// end success
		
	})// end ajax
}
function applyStylesToNewItems() {
	
	   let newItems = document.querySelectorAll('.list-item');
	
	   newItems.forEach(function(item) {
// 			item.style.width = 'calc(33.33% - 10px)';
			item.style.margin = '5px';
			item.style.overflow = 'hidden';
	    });
	}
})
</script>
<div class="list-container" style="text-align: center;">
		<div data-v-744b39cc="" data-v-422e0ac9="" class="topic-guide-banner-container soomgo-story">
			<p data-v-744b39cc="" class="guideline">
				<!---->
				프로가 전하는 특별한 이야기를 만나보세요
			</p>
			<img data-v-744b39cc=""
				src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNzIiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA3MiA0MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZD0iTTQyLjY5IDBoMTUuMjI4YzEuNzU3IDAgMy40My4zNDggNC45NTEuOTc3QzY4LjIxMyAzLjAyIDcyIDguMDc0IDcyIDEzLjk5OWMwIDcuMDkyLTUuNDE4IDEzLjA2NS0xMi40NDUgMTMuOTg2LTEuMDIxLjEzNC0xLjkzNy0uNjMxLTEuOTM3LTEuNjM1di0xLjY0NUg0Mi42OWMtNy4wMDggMC0xMi42OS01LjUzLTEyLjY5LTEyLjM1M0MzMCA1LjUzMSAzNS42ODIgMCA0Mi42OSAwIiBmaWxsPSIjODBEQkI0Ii8+CiAgICAgICAgPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDEgMTEpIiBmaWxsPSIjRkZGIj4KICAgICAgICAgICAgPGNpcmNsZSBjeD0iMiIgY3k9IjIiIHI9IjIiLz4KICAgICAgICAgICAgPGNpcmNsZSBjeD0iMTAiIGN5PSIyIiByPSIyIi8+CiAgICAgICAgICAgIDxjaXJjbGUgY3g9IjE4IiBjeT0iMiIgcj0iMiIvPgogICAgICAgIDwvZz4KICAgICAgICA8Zz4KICAgICAgICAgICAgPHBhdGggZD0iTTI5LjMxIDEySDE0LjA4MmMtMS43NTcgMC0zLjQzLjM0OC00Ljk1MS45NzdDMy43ODcgMTUuMDIgMCAyMC4wNzQgMCAyNS45OTljMCA3LjA5MiA1LjQxOCAxMy4wNjUgMTIuNDQ1IDEzLjk4NiAxLjAyMS4xMzQgMS45MzctLjYzMSAxLjkzNy0xLjYzNXYtMS42NDVIMjkuMzFjNy4wMDggMCAxMi42OS01LjUzIDEyLjY5LTEyLjM1M0M0MiAxNy41MzEgMzYuMzE4IDEyIDI5LjMxIDEyIiBmaWxsPSIjNDVDNTlCIi8+CiAgICAgICAgICAgIDxwYXRoIGQ9Ik0xNS42NjcgMjIuMjVoLS44OWMtLjk4MSAwLTEuNzc3Ljc4My0xLjc3NyAxLjc1djUuMjVjMCAuOTY3Ljc5NiAxLjc1IDEuNzc4IDEuNzVoLjg4OWMuNDkgMCAuODg5LS4zOTIuODg5LS44NzV2LTdhLjg4Mi44ODIgMCAwIDAtLjg5LS44NzVtMTEuNTU2IDBoLTQuNDQ0bC43MzQtMi43MDZhMS43MzcgMS43MzcgMCAwIDAtLjczOC0xLjg4bC0uNzg3LS41MTdhLjg5Ny44OTcgMCAwIDAtMS4yODguMzM3bC0yLjAwNCA0LjAzOWEzLjQ1NiAzLjQ1NiAwIDAgMC0uMzYxIDEuNTM2djYuMTkxYzAgLjk2Ny43OTUgMS43NSAxLjc3NyAxLjc1aDYuMDQ0Yy44NDcgMCAxLjU3Ny0uNTg5IDEuNzQzLTEuNDA3bDEuMDY3LTUuMjVjLjIyLTEuMDgyLS42MjItMi4wOTMtMS43NDMtMi4wOTMiIGZpbGw9IiMxNTlBNkQiLz4KICAgICAgICA8L2c+CiAgICA8L2c+Cjwvc3ZnPgo="
				class="guide-icon">
		</div>
		<br>
<div class="container col-lg-8">
    <div class="d-flex justify-content-between align-items-center">
        <div>
			<button class="btn btn-inverse-primary btn-fw btnSelect dropdown-toggle" type="button" id="searchType" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</button>

	            <div class="dropdown-menu" id="dropdown-menu-2" style="min-width: 100px;">
	                <a class="dropdown-item" href="#" id="title">제목</a>
	                <a class="dropdown-item" href="#" id="content">내용</a>
	                <a class="dropdown-item" href="#" id="writer">작성자</a>
	            </div>
        </div>
        <div>
            <input type="text" id="searchKeyword" name="keyword" value="${param.keyword}" class="form-control" aria-label="Text input with dropdown button">
        </div>
        <div>
            <input type="hidden" id="secondInput" class="form-control" aria-label="Text input with dropdown button">
        </div>
        <div>
            <button class="btn btn-primary ml-2" type="button" id="btnSearch">검색</button>
            <c:if test="${memSession==null && proSession != null}">
            <button class="btn btn-primary ml-2" type="button" id="create" style="text-align: right">글쓰기</button>
            </c:if>
            <button class="btn btn-link ml-2" type="button" id="btnCancel" style="display:none;">초기화</button>
        </div>
    </div>
</div>

    <div style="margin-top: 40px;">
        <button class="btn btn-link" type="button" id="btnCancel" style="display:none;">초기화</button>
    </div>
    
<div class="container col-lg-8">
    <nav class="scroll-hidden flex space-x-3 lg:space-x-8" aria-label="Tabs">
        <button id="reverseNow" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">오래된순</button>
        <button id="nowCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">최신순</button>
        <button id="getCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">조회수</button>
        <button id="goodCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">좋아요</button>
    </nav>
    <div class="d-flex justify-content-end">
        <button type="button" id="addBtn" class="btn btn-primary ml-2">더보기</button>
    </div>
</div>
<!--  -->
	<br />	
	<br />
	
	<div class="list-container" style="display: flex; justify-content: center;">
	    <div class="list-item" style="display: flex; flex-wrap: wrap;" id ="test">
	        <ul class="list-star text-center">
	        </ul>
	    </div>
	</div>
</div>