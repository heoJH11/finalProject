<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

 /* 모달창 먹통 이슈 (은진 수정 가능) */
.modal-backdrop {
    z-index: 0;
    background-color: #ffffff;
}
    

/* 주희 추가 
 커서 손꾸락으로 바꿈 */
tbody {
	cursor: pointer;
}
.bodyTop{
	margin-top:50px;
	position : relative;
	z-index: 3;
}

/* 모달창 크기 고정 */
.modal .modal-dialog .modal-content .modal-body {
    padding: 0px;
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

* {
	font-family: 'GmarketSansLight';
}

.modal .modal-dialog {
	margin-top: 30px;
}
.modal-dialog {
    max-width: 670px;
}


.tdSj {
	display: inline-block;
    width: 300px;                /* 가로 길이 고정*/
    text-overflow: ellipsis;     /* 생략 처리 ( ... )*/
    white-space: nowrap;         /* 줄바꿈 하지 않고 잘림*/
    overflow: hidden;            /* 스크롤 처리 하지 않음*/
}

</style>
<script type="text/javascript">
$(function () {
	
	let userId = `${memSession.userId}`;
		console.log("userId",userId);
		
// 	let proId = `${proSession.userId}`;
// 		console.log("proId", proId);
	
	//회원일 경우에만 등록버튼과 체크박스 보여짐
	if(userId != null && userId != "") {
		$("#btnRvCreate").css("display", "block");
		$(".form-check").css("display", "block");
	}
	
	//검색어 카테고리 이름 가져오기
	$(".rvDrop").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
    });
	
	//체크박스 체크 이벤트
	$("#ckMyReview").change(function() {

	    //체크박스 체크시 로그인한 회원의 후기 리스트만 출력
	    //체크박스 해제시 전체 후기 리스트 출력
	    let currentPage = `${param.currentPage}`;
	    console.log("currentPage : " + currentPage)

	    if (currentPage == "") {
	        currentPage = "1";
	    }
	    

	    let data = {
	        "currentPage": currentPage  
	    };
		
	    // 내가쓴 후기 체크시 userId를 보내고
	    // 체크 해제시 null을 보내서 전체 리스트 출력하기 위한 처리
	    if ($("#ckMyReview").prop("checked")) {
	        data.userId = userId;
	    } else {
	        data.userId = "";
	    }
	    console.log("내가 쓴 후기 data : ", data)

	    $.ajax({
	        url: "/reviewBoard/listAjax",
	        contentType: "application/json;charset=utf-8",
	        data: JSON.stringify(data),
	        type: "post",
	        dataType: "json",
	        success: function(result) {
	        	
	        	if(result.content == "") {
	        		Swal.fire({
	    				title: '작성한 후기가 없습니다.',
	    				icon: 'warning',
	    				confirmButtonText: '확인'
	    			})
	    			$("#ckMyReview").prop("checked", false);
	        	} else {
	        		$("#rvBrdBody").html("");
		            console.log(result);

		            reviewList(result);
	        	}
	        	
	        	
	        }
	    })


	})

	//등록 버튼 클릭시 서비스 요청 완료 목록 출력 모달
	$("#btnRvCreate").on("click",function(){
		
		//리스트가 추가되어 출력되는 걸 방지 하기 위해 body를 비워줌
		$("#svcComModal").html("");
		
		$.ajax({
			url: "/reviewBoard/listModal",
			type: "post",
			data: { "userId" : userId },
			dataType: "json",
			success: function(result) {
				let str = "";
				if(result == "") {
					str = `<tr><td colspan="4" style='text-align:center;'>완료된 서비스가 없습니다.</td></tr>`;
				}
				$.each(result, function(idx, srvcRequesVO) {
					let wrDateFommat1 = new Date(srvcRequesVO.srvcRequstWrDt);
					let wrDateFommat2 = wrDateFommat1.toISOString(); //2024-03-07T15:00:00.000Z
					let srvcRequstWrDt = wrDateFommat2.replace(/\-/g, '.').substr(0,10); //2024.03.07
					
					let comptDateFommat1 = new Date(srvcRequesVO.srvcRequstWrDt);
					let comptDateFommat2 = comptDateFommat1.toISOString(); //2024-03-07T15:00:00.000Z
					let srvcRequstComptDt = comptDateFommat2.replace(/\-/g, '.').substr(0,10); //2024.03.07
					
					console.log(srvcRequstWrDt);
					
					str += "<tr>";
					str += "<td>" + srvcRequesVO.srvcRequstNo + "</td>";
					str += "<td class='tdSj'><a href='/reviewBoard/create?srvcRequstNo="+ srvcRequesVO.srvcRequstNo + "'>" 			
							+ srvcRequesVO.srvcRequstSj + "</a></td>";
					str += "<td>" + srvcRequstWrDt + "</td>";
					str += "<td>"  + srvcRequstComptDt + "</td>";
					str += "</tr>";
				})
				$("#svcComModal").append(str);

			}
		})
	});
	
	//엔터키 입력 검색
	$("#keyword").on("keyup", function (key) {
		if (key.keyCode == 13) {
			searchList();
		}
	})
	
	//검색 버튼 검색
	$("#btnSearch").on("click", function () {

		searchList();
	})
	
	
	//전체 리스트 출력
	
	let currentPage = "${param.currentPage}";
	console.log("currentPage : " + currentPage)
	
	if (currentPage == "") {
		currentPage = "1";
	}
		
	let data = {
			"keyword" : "${param.keyword}",
			"selectColumn" : "${param.selectColumn}",
			"currentPage" : currentPage		
	}
	console.log("data : ", data);
	
	$.ajax({
		url: "/reviewBoard/listAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
		type: "post",
		dataType: "json",
		success: function(result) {
			
			console.log(result);
			
			reviewList(result);
		}
	})
})

//리스트 출력 함수
function reviewList(result) {
	let str = "";
	$.each(result.content, function(idx, aftusBbscttVO) {
		let mberPhoto = aftusBbscttVO.mberProflPhoto;
		console.log("프사", mberPhoto);
		str += `<tr onclick="location.href='/reviewBoard/detail?aftusBbscttNo=\${aftusBbscttVO.aftusBbscttNo}'">`;
		str += `<td>\${aftusBbscttVO.rnum}</td>`;
		str += `<td>\${aftusBbscttVO.aftusBbscttSj}</td>`;
		str += `<td>\${aftusBbscttVO.userNcnm}</td>`;
		str += `<td>\${aftusBbscttVO.aftusBbscttWrDt}</td>`;
		str += `<td>\${aftusBbscttVO.aftusBbscttRdcnt}</td>`;
		str += `</tr>`;
	})
	
	$("#rvBrdBody").append(str);
	
	if(result.total == 0){
		//페이징 처리
		$("#divPagingArea").html("");
	}else{
		$("#divPagingArea").html(result.pagingArea);
	}
}

function searchList() {

    let selectColumn = $("#dropdownMenuSizeButton3").text();
    let keyword = $("#keyword").val();
	
    console.log(selectColumn);

    console.log("keyword : " + keyword);
	
    let currentPage = "1";  
    
    let data = {
        "keyword": keyword,
        "selectColumn": selectColumn,
        "currentPage" : currentPage
    };
    console.log("data : ", data)

	$.ajax({
		url: "/reviewBoard/listAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
		type: "post",
		dataType: "json",
		success: function(result) {
			
			if(result.content == "") {
        		Swal.fire({
    				title: '검색 결과가 존재하지 않습니다.',
    				icon: 'warning',
    				confirmButtonText: '확인'
    			})
    			$("#keyword").val("");
    			
			} else {
				$("#rvBrdBody").html("");
				
				reviewList(result);
			}
		}
	})
}
</script>
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card">
		<!-- 제목 -->
		<div >
			<img alt="후기" src="../resources/images/게후기.png" style="width:100px; height:auto; margin:0 0 20px 600px;">
			<h2 id="freeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">후기게시판</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
		</div>
	</div>
</div>

<div class="sidenav">
   <p style="text-align: center;">
      <b style="font-family: GmarketSansMedium;">BOARD MENU</b>
   </p>
   <hr>
   <a href="/lbrtybbsctt/read2">자유 게시판</a> 
   <a href="/reviewBoard/main">후기 게시판</a>
   <a href="/proHunting/list">프로 구인 게시판</a> 
   <a href="/proCprtnBbsctt/list">프로 협업 게시판</a>
</div>
<div class="bodyTop">
<div class="col-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
				<div class="dropdown" style="float: right; margin-right: 0">
					<button class="btn btn-inverse-primary btn-sm dropdown-toggle" type="button" 
					id="dropdownMenuSizeButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</button>
					<input type="text" name="keyword" id="keyword" 
					style="width: auto; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left:11px;">
					<button type="button" class="btn btn-inverse-primary btn-sm" id="btnSearch">
						<i class="mdi mdi-yeast"></i>
					</button>
					<div class="dropdown-menu" id="search_key" aria-labelledby="dropdownMenuSizeButton3" style="">
						<p class="dropdown-item rvDrop">제목</p>
						<p class="dropdown-item rvDrop">작성자</p>
					</div>
				</div>
				<div>
					<button type="button" class="btn btn-inverse-primary btn-sm" data-toggle="modal"
						data-target="#modal-Create" id="btnRvCreate" style="display: none; float: right; margin: 3px 5px 0 0; ">후기등록</button>
				</div>
			<div class="table-responsive">
				<div class="form-check" style="display:none;">
					<label class="form-check-label">
						<input type="checkbox" id="ckMyReview" class="form-check-input">
						내가 쓴 후기
						<i class="input-helper"></i>
					</label>
				</div>
				<table class="table table-striped text-center">
					<thead>
						<tr>
							<th style="width: 5%">번호</th>
							<th>제목</th>
							<th style="width: 15%;">작성자</th>
							<th style="width: 15% ">작성일</th>
							<th style="width: 10%">조회수</th>
						</tr>
					</thead>
					<tbody id="rvBrdBody"></tbody>
				</table>
			</div>
			<div id="divPagingArea"
					style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
		</div>
	</div>
</div>
</div>

<!-- 내 서비스 모달 -->
<div class="modal fade" id="modal-Create" data-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenteredScrollableTitle" style="color:red">
				※ 이용이 완료된 서비스에 대한 후기만 작성 가능합니다</h5>	
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="card">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>요청일자</th>
										<th>완료일자</th>
									</tr>
								</thead>
								<tbody id="svcComModal">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="btnModalClose" data-dismiss="modal" class="btn btn-primary">닫기</button>
			</div>
		</div>
	</div>
</div>

