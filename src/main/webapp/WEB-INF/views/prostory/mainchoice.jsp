<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
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
.grid-container {
    display: grid;
    grid-template-columns: auto auto auto; /* 세 개의 열을 생성합니다. */
    grid-gap: 10px; /* 그리드 아이템 사이의 간격을 지정합니다. */
    justify-content: center; /* 그리드 아이템들을 가운데 정렬합니다. */
}
.list-item {
    width: calc(33.33% - 20px);
    margin: 5px;
    overflow: hidden;
}
.list-star {
/*     height: 100%; /* 부모 요소인 .list-item의 높이를 100%로 설정합니다. */
    overflow-y: auto; /* 내용이 넘칠 경우 수직 스크롤을 추가합니다. */
}
.list-star img {
max-width: 100%; /* 이미지의 최대 너비를 요소의 너비에 맞게 설정합니다. */
height: auto; /* 이미지의 높이를 자동으로 조정하여 가로세로 비율을 유지합니다. */
border-radius: 15px; /* 이미지를 원형으로 처리합니다. */
overflow: hidden; /* 이미지를 부모 요소의 경계에 맞춰 자르기 위해 overflow 속성을 사용합니다. */
}
.btn-clicked {
        background-color: #4CAF50; /* 변경할 색상 */
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
	window.closeDialog = function() {
        $('.dialog-container').hide(); // jQuery를 사용하여 다이얼로그 숨기기
    };
    $(document).ready(function() {
        // 조회 인덱스
        var startIndex = 1;
        var endIndex   = 2;
        var totalPages = ${total};
        var storyData; // 데이터를 저장할 변수 추가

        addPage(startIndex);

        const addBtn  = document.querySelector("#addBtn");
        const nowCnt  = document.querySelector("#nowCnt");
        const getCnt  = document.querySelector("#getCnt");
        const goodCnt = document.querySelector("#goodCnt");

        // 정렬 버튼 클릭 시 호출되는 함수
        function sortDataBy(column) {
            storyData.sort(function(a, b) {
                // 정렬 기준에 따라 비교
                if (a[column] < b[column]) return -1;
                if (a[column] > b[column]) return 1;
                return 0;
            });
        }

        // 정렬 버튼 클릭 시 처리
        $(".sort-btn").on("click", function() {
            var column = $(this).data("column"); // 정렬할 열
            sortDataBy(column); // 데이터 정렬
            renderPage(); // 페이지 다시 그리기
        });

        // start attBtn click
        addBtn.addEventListener("click" , function(){
            startIndex += endIndex;
            if(totalPages < startIndex){
                document.querySelector('.dialog-container').style.display = 'block';
                return;
            }
            addPage(startIndex);
        });

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
                    storyData = result; // 데이터 저장
                    renderPage(); // 페이지 그리기
                }
            });
        }

     // 페이지 그리기 함수
        function renderPage() {
            let str = "";
            // 기존 데이터와 새로운 데이터를 합치기

            let newData = storyData.slice(startIndex - endIndex, startIndex); // 새로운 페이지 데이터
            
            let combinedData = storyData.slice(0, startIndex - endIndex).concat(newData); // 기존 데이터와 새로운 페이지 데이터 합치기
            
            for (let i = 0; i < combinedData.length; i++) {
                let story = combinedData[i];
                str += '<div class="list-item">';
                str += '<ul class="list-star text-center">';
                str += '<li><a href="/prostory/getStory?storyNo=' + story.proStoryBbscttNo + '">' + story.proStoryBbscttSj + '</a></li>';
                str += '<li>작성일 : ' + story.proStoryBbscttWrDt + '</li>';
                str += '<li>좋아요 : ' + story.proStoryBbscttRecommend + '</li>';
                str += '<li>닉네임 : ' + story.userNcnm + '</li>';
                str += '<li>조회수 : ' + story.proStoryBbscttRdcnt + '</li>';
                str += '<li><img src="/images/' + story.proStoryBbscttThumbPhoto + '" /></li>';
                str += '</ul>';
                str += '</div>';
            }
            document.getElementById('test').innerHTML = str; // 기존 내용 대신에 합쳐진 내용으로 갱신
            applyStylesToNewItems();
        
     }

        function applyStylesToNewItems() {
            let newItems = document.querySelectorAll('.list-item');
            newItems.forEach(function(item) {
                item.style.width = 'calc(33.33% - 10px)';
                item.style.margin = '5px';
                item.style.overflow = 'hidden';
            });
        }
    });

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
<div class="container col-lg-5">
    <div class="d-flex justify-content-between align-items-center">
        <div>
            <button class="btn btn-inverse-primary btn-fw btnSelect dropdown-toggle" type="button" id="keyword" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</button>
            <div class="dropdown-menu" id="dropdown-menu-2" style="min-width: 100px;">
                <a class="dropdown-item" href="#" id="title">제목</a>
                <a class="dropdown-item" href="#" id="writer">작성자</a>
                <a class="dropdown-item" href="#" id="titleAndWriter">제목+작성자</a>
            </div>
        </div>
        <div>
            <input type="text" id="firstInput" class="form-control" aria-label="Text input with dropdown button">
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
    
<div class="container col-lg-5">
    <nav class="scroll-hidden flex space-x-3 overflow-y-scroll lg:space-x-8" aria-label="Tabs">
        <button id="nowCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">최신순</button>
        <button id="getCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">조회수</button>
        <button id="goodCnt" class="btn btn-primary flex shrink-0 rounded-md px-3 py-2 text-sm font-medium sm:text-base sm:leading-5">추천순</button>
    </nav>
    <div class="d-flex justify-content-end">
        <button type="button" id="addBtn" class="btn btn-primary ml-2">더보기</button>
    </div>
</div>
<!--  -->
<div id="container"></div>
	<br />	
	<br />
	
	<div class="list-container" style="display: flex; justify-content: center;">
	    <div class="list-item" style="display: flex; flex-wrap: wrap;" id ="test">
	        <ul class="list-star text-center">
	        </ul>
	    </div>
	</div>
</div>