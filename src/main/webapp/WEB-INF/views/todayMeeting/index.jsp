<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="
https://cdn.jsdelivr.net/npm/fullcalendar@4.0.0-alpha.4/dist/fullcalendar.min.js
"></script>
<link href="
https://cdn.jsdelivr.net/npm/fullcalendar@4.0.0-alpha.4/dist/fullcalendar.min.css
" rel="stylesheet">

<style>
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

/* 주희 추가 
 커서 손꾸락으로 바꿈 */
tbody {
	cursor: pointer;
}


.searchForm {
	margin-top: 30px;
}
.content-wrapper {
	background: none;

}
.keyword, .dateKeyword{
	display:inline;
 	width: auto;
	border-radius: 15px; 
	border: 0; outline: none; 
	background-color: rgb(233, 233, 233); 
	height: 30px; 
	padding-left: 11px;
}

th{
	font-family: 'GmarketSansMedium';
	font-size:17px !important;
}
td{
	font-family: 'GmarketSansMedium';
}

button,input{
	font-family: 'GmarketSansMedium';
}

a{
	font-family: 'GmarketSansMedium';
	color:#4e4c7c;
}

h2{
	font-family: 'seolleimcool-SemiBold';
	color:#4e4c7c;
}
</style>
<script>
$(function () {

    let userId = `${userId}`;
    console.log(userId);

    //로그인 상태에만 등록버튼, 내 모임 보이기
    if (userId != "not") {
        $("#btnTmtCreate").css("display", "block");
        $(".tmtCalTab").css("display", "block");
    }

    
    $(".tmtDrop").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
        
        console.log(selectedText);
        if (selectedText == "모임일자") {
        	//모임명이나 제목을 검색 후 날짜 검색을 하면 키워드가 남아있어서 비워줌
        	$("#keyword").val("");
            $("#keyword").prop("type", "hidden");
            $(".dateKeyword").prop("type", "date");
        } else {
            $("#keyword").prop("type", "text");
            $(".dateKeyword").prop("type", "hidden");
        }
      
    });
	
    //탭 클릭 이벤트
    $("#tmtListTab").on("click", function () {
        $("#tmtCalTab").attr('class', 'nav-link');
        $("#tmtListTab").attr('class', 'nav-link active');
        $("#tmtCal").attr('class', 'tab-pane fade');
        $("#tmtList").attr('class', 'tab-pane fade active show');
    })
    $("#tmtCalTab").on("click", function () {
        $("#tmtCalTab").attr('class', 'nav-link active');
        $("#tmtListTab").attr('class', 'nav-link');
        $("#tmtCal").attr('class', 'tab-pane fade active show');
        $("#tmtList").attr('class', 'tab-pane fade');
    })

    //모임 등록
    $("#btnTmtCreate").on("click", function () {
        location.href = "/todayMeeting/create";
    })

    //엔터키 입력 검색
    $("#keyword").on("keyup", function (key) {
        if (key.keyCode == 13) {
            meetingSearch();
        }
    })

    //검색 버튼 검색
    $("#btnSearch").on("click", function () {

    	meetingSearch();
    })

    //전체리스트 출력
    let currentPage = "${param.currentPage}";
	  console.log("currentPage : " + currentPage)

 	if (currentPage == "") {
 		currentPage = "1";
 	}

	let data = {
		"selectColumn" : "${param.selectColumn}",
		"keyword" : "${param.keyword}",
		"currentPage" : currentPage
	}

    
    $.ajax({
        url: "/todayMeeting/listAjax",
        type: "post",
        data:JSON.stringify(data),//
		contentType:"application/json;charset=utf-8",//페이징처리 해줄 때 넣어줌
        dataType: "json",
        success: function (result) {
        	meetingList(result);
        }
    })

    //모달 닫기 버튼 클릭 이벤트
	$("#btnModalClose").on("click", function() {	
		$("#modal-calendar").modal("hide");
	})
    
    $("#tmtCalTab").on("click", function () {
    //캘린더
	    var request = $.ajax({
	        url: "/todayMeeting/calendarList", // 값 불러오기
	        data: {"userId" : userId},
	        method: "GET",
	        dataType: "json"
	    });
	    request.done(function (data) {
	    	$("#calendar").html("");
	        console.log(data); // log로 데이터 찍어주기
	        var calendarEl = document.getElementById('calendar');
	        calendar = new FullCalendar.Calendar(calendarEl, {
	            height: '700px',
	            slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	            slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	            // 헤더에 표시할 툴바
	            headerToolbar: {
	                left: 'prev, next today',
	                center: 'title',
	                right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	            },
	            initialView: 'dayGridMonth', // 초기 로드 될 때 보이는 캘린더 화면 (기본 설정 : 달)
	            navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
	            editable: true, // 수정 가능?
	            selectable: true, // 달력 일자 드래그 설정 가능
	            droppable: true, // 드래그 앤 드롭 
	            events: data,
	            locale: 'ko', // 한국어 설정
	
	            eventClick: function (info) {
		
	            	$("#modal-calendar").modal("show");
	            	
	            	var tdmtngNo = info.event.id;
	            	
					location.href = "/todayMeeting/detail?tdmtngNo=" + tdmtngNo;
	       
	          
	            }
	
	        });
	        calendar.render();
	    });
    })


});


function meetingSearch() {
	
    let selectColumn = $("#dropdownMenuSizeButton3").text();
    let keyword = $("#keyword").val();
    let dateKeyword1 = $("#dateKeyword1").val();
    let dateKeyword2 = $("#dateKeyword2").val();

    console.log($("#dateKeyword1").val());
    console.log($("#dateKeyword2").val());

    console.log($("#search_key").val());

    console.log($("#search_key").val())
    console.log("keyword : " + keyword);
    
    let currentPage = "1";

    let data = {
        "keyword": keyword,
        "selectColumn": selectColumn,
        "dateKeyword1": dateKeyword1,
        "dateKeyword2": dateKeyword2,
        "currentPage" : currentPage
    };
    console.log("data : ", data)

    $.ajax({
        url: "/todayMeeting/listAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        success: function (result) {
        	meetingList(result);
        }
    });
}

function meetingList (result) {
	let str = "";

    $("#tmtBody").html("");

    $.each(result.content, function (idx, tdmtngVO) {
    	let mberPhoto = tdmtngVO.mberProflPhoto;
    	let proPhoto = tdmtngVO.proProflPhoto;
    	
		console.log("회원프사", mberPhoto);
		console.log("프로프사", proPhoto);
    	
		str += `<tr onclick="location.href='/todayMeeting/detail?tdmtngNo=\${tdmtngVO.tdmtngNo}'">`;
		str += `<td>\${tdmtngVO.rnum}</td>`;
		str += `<td>\${tdmtngVO.tdmtngNm}</td>`;
		str += `<td class='py-1' style='text-align:right; padding-right:10px;'>`;
		if(mberPhoto == null && proPhoto != null) {
			
			console.log("프로 사진?")
			str += `<img src='\${proPhoto}'></td>`;
			
		} else if(mberPhoto != null && proPhoto == null){
			console.log("멤버 사진?")
			str += `<img src='\${mberPhoto}'></td>`;
		
		} else {
			console.log("없음 : "+ mberPhoto)
			str += `<img src='/images/2024/profile.jpg'></td>`;
		}
		str += `<td style='text-align:left; padding-left:0;'>\${tdmtngVO.userNcnm}</td>`;
		str += `<td>\${tdmtngVO.tdmtngDt}</td>`;
		str += `</tr>`; 
    });

    $("#tmtBody").append(str);
    
 // 페이징 처리
    if (result.total == 0) {
        $("#divPagingArea").html("");
    } else {
        $("#divPagingArea").html(result.pagingArea);
    }
}
</script>

		<!-- 제목 -->
		<div >
			<img alt="오늘모임" src="../resources/images/모임3.png" style="width:100px; height:auto; margin:0 0 20px 620px;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">오늘 모임</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>

<div class="col-12 grid-margin stretch-card" style="margin-top:50px;">
	<div class="card">
		<div class="card-body">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<button type="button" class="btn btn-inverse-primary btn-fw" data-toggle="modal"
					data-target="#modal-Create" id="btnTmtCreate" style="display: none;">모임등록</button>
				<div class="dropdown" style="float: right; margin-right: 0">
					<button class="btn btn-inverse-primary btn-sm dropdown-toggle" type="button" 
					id="dropdownMenuSizeButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">모임명</button>
					<input type="text" name="keyword" id="keyword" class="keyword">
					<input type="hidden" id="dateKeyword1" name="dateKeyword1" class="form-control dateKeyword">
					<input type="hidden" id="dateKeyword2" name="dateKeyword2" class="form-control dateKeyword">
					
					
					<button type="button" class="btn btn-inverse-primary btn-sm" id="btnSearch">
						<i class="mdi mdi-yeast"></i>
					</button>
					<div class="dropdown-menu" id="search_key" aria-labelledby="dropdownMenuSizeButton3">
						<p class="dropdown-item tmtDrop">모임명</p>
						<p class="dropdown-item tmtDrop">모임장</p>
						<p class="dropdown-item tmtDrop">모임일자</p>
					</div>
				</div>
			</div>
	
			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item" role="presentation">
					<a class="nav-link active" id="tmtListTab" data-bs-toggle="tab" href="#tmtList" role="tab" aria-controls="tmtList"
						aria-selected="true">모임 목록</a>
				</li>
				<li class="nav-item tmtCalTab" role="presentation" style="display: none;">
					<a class="nav-link" id="tmtCalTab" data-bs-toggle="tab" href="#tmtCal" data-bs-target="#tmtCal"
						role="tab" aria-controls="tmtCal" aria-selected="false" tabindex="-1">내 모임</a>
				</li>
	
			</ul>

		<div class="tab-content">
			<div class="tab-pane fade active show" id="tmtList" role="tabpanel" aria-labelledby="tmtListTab">
				<div class="table-responsive">
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th style="width: 5%">번호</th>
								<th>모임명</th>
								<th colspan="2" style="width: 15%">모임장</th>
								<th style="width: 15%">모임일자</th>
							</tr>
						</thead>
						<tbody id="tmtBody">
						</tbody>
					</table>
				</div>
				<div id="divPagingArea" style="position: relative; margin-left: 38%; margin-top: 50px;"></div>
				</div>
				<div class="tab-pane fade" id="tmtCal" role="tabpanel" aria-labelledby="tmtCalTab">
					<div class="media">
	
						<div class="media-body">
						
							
						
							<div id="calendar" class=cal></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


