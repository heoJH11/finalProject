<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/js/jquery.min.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
a, a:link {
  color: #000;
  text-decoration: none;
  font-family: 'GmarketSansLight';
}
#balloon{
	margin : -184px 0px -238px 379px;
	z-index : 1;
}

#lbrtybbsctt{
	font-family: 'seolleimcool-SemiBold'; 
	color:#4e4c7c; 
	text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;
	margin: 54px 0 -109px 495px;
	position : relative;
	z-index: 2;
}
</style>
<script>
$(function(){
	$(".dropdown-item").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
	});

    // 전체 목록
	let currentPage = "${param.currentPage}";
	if(currentPage == ""){
		currentPage = "1";
	}
	
	let size = "10";
	
	let data = {
			"keyword" : "${param.keyword}",
			"currentPage" : currentPage,
			"size" : size
	}
	console.log("기본 리스트 data : ", data);
	
	$.ajax({
		url : "/srvcRequst/srvcRqRejectList",
	    contentType : "application/json; charset=utf-8",
	    data : JSON.stringify(data),
	    type : "post",
	    dataType : "json",
	    success : function(res){
	    	console.log("기본 res : ", res);
            var str = "";
            $("#rejectTabBody").html("");
            $("#divPaging").html("");
            var length = res.content.length;
            if(length == 0){
            	str = "<td colspan='5' style='font-family: GmarketSansLight; font-size:15pt;'>거절 요청내역이 없습니다</td>"
	            $("#rejectTabBody").html(str);
        	}	
            $.each(res.content, function(i, v){
            	switch(v.emplyrTy) {
                // 회원
                case "ET02":
                    str += "<tr style='font-family: GmarketSansLight;'>";
                    str += "<td id='num" + v.num + "'>" + v.num + "</td>";
                    str += "<td id='proNcnm" + v.srvcRequstNo + "'><a href='/proProfl/detail?proId="+v.proId+"'>" + v.userNcnm + "</a></td>";
                    str += "<td id='srvcRequstSj" + v.srvcRequstNo + "'>";
                    str += "<a href='/srvcRequst/srvcRqDetail?srvcRequstNo=" + v.srvcRequstNo + "'>" + v.srvcRequstSj + "</a></td>";
                    // 진행상태
                    if (v.srvcRequstProcessAt == 1) {
                        str += "<td><label class='badge badge-info'>수락</label></td>";
                    } else if (v.srvcRequstProcessAt == 2) {
                        str += "<td><label class='badge badge-danger'>거절</label></td>";
                    } else {
                        str += "<td><label class='badge badge-secondary'>확인중</label></td>";
                    }

                    str += "<td id='srvcRequstWrDt" + v.btfInqryNo + "'>" + (v.srvcRequstWrDt).substr(0,10) + "</td>";
                    // 한 행 완성
                    str += "</tr>";
                    $("#rejectTabBody").html(str); // bodyList에 행 추가
                    break;
                    	
                    // 프로	
            		case "ET01" :
            			str += "<tr style='font-family: GmarketSansLight;'>";
                        str += "<td id='num" + v.num + "'>" + v.num + "</td>";
                        str += "<td id='proNcnm" + v.srvcRequstNo + "'>" + v.userNcnm + "</td>";
                        str += "<td id='srvcRequstSj" + v.srvcRequstNo + "'>";
                        str += "<a href='/srvcRequst/srvcRqDetail?srvcRequstNo=" + v.srvcRequstNo + "'>" + v.srvcRequstSj + "</a></td>";
                        // 진행상태
                        if (v.srvcRequstProcessAt == 1) {
                            str += "<td><label class='badge badge-info'>수락</label></td>";
                        } else if (v.srvcRequstProcessAt == 2) {
                            str += "<td><label class='badge badge-danger'>거절</label></td>";
                        } else {
                            str += "<td><label class='badge badge-secondary'>미응답</label></td>";
                        }

                        str += "<td id='srvcRequstWrDt" + v.btfInqryNo + "'>" + (v.srvcRequstWrDt).substr(0,10) + "</td>";
                        // 한 행 완성
                        str += "</tr>";
                        $("#rejectTabBody").html(str); // bodyList에 행 추가
                        break;
            	}// switch문 끝
            });//each 끝;
            console.log("기본 res", res.pagingArea);
            if(res.total>0){
		    	$("#Rj_divPaging").html(res.pagingArea);
            }else{
		    	$("#Rj_divPaging").html("");
            }
    	} // success 끝
    }); 
	
	
	// 검색
	$("#searchBtn").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		console.log("키워드 : ", keyword);
		
		if (keyword.trim() === '') {
	          Swal.fire({
	              title: '검색어가 없습니다.',
	              icon: 'warning',
	              confirmButtonText: '확인'
	          });
	          return; // 검색어가 없으면 더 이상 실행하지 않음
	      }
	
		// 검색 카테고리 설정
		let selectColumn = $("#dropdownMenuSizeButton3").text();
		if(selectColumn == "닉네임"){
			selectColumn = "A.USER_NCNM";
		}else if(selectColumn == "제목"){
			selectColumn = "A.SRVC_REQUST_SJ";
		}else if(selectColumn == "전체"){
			selectColumn = "ALL";
		}
		
		// 페이지
		let currentPage = "1";
		let size = "10";
		
		var data = {
				"keyword" : keyword,
				"selectColumn" : selectColumn,
				"currentPage" : currentPage,
				"size" : size
					};
		$.ajax({
	        url : "/srvcRequst/srvcRqRejectList",
	        contentType : "application/json; charset=utf-8",
	        data : JSON.stringify(data),
	        type : "post",
	        dataType : "json",
	        success: function(res){
	            console.log("res", res);
	            console.log("content", res.content);
	            $("#allTabBody").html("");
	            var str = "";
	            var length = res.content.length;
	            if(length == 0){
	            	str = "<td colspan='5' style='font-family: GmarketSansLight; font-size:15pt;'>'"+keyword+"' 로 검색된 결과가 없습니다</td>"
		            $("#rejectTabBody").html(str);
	        	}	
	            str += "<tr><td colspan='5' style=' font-family: GmarketSansLight; font-size:13pt;'>'"+keyword+"' (으)로 검색된 결과가 "+res.total+"건 있습니다.</td></tr>";
	            $.each(res.content, function(i, v){
	            	switch(v.emplyrTy){
	                // 회원
	                case "ET02":
	                    str += "<tr style='font-family: GmarketSansLight;'>";
	                    str += "<td id='num" + v.num + "'>" + v.num + "</td>";
	                    str += "<td id='proNcnm" + v.srvcRequstNo + "'><a href='/proProfl/detail?proId="+v.proId+"'>" + v.userNcnm + "</a></td>";
	                    str += "<td id='srvcRequstSj" + v.srvcRequstNo + "'>";
	                    str += "<a href='/srvcRequst/srvcRqDetail?srvcRequstNo=" + v.srvcRequstNo + "'>" + v.srvcRequstSj + "</a></td>";
	                    // 진행상태
	                    if (v.srvcRequstProcessAt == 1) {
	                        str += "<td><label class='badge badge-info'>수락</label></td>";
	                    } else if (v.srvcRequstProcessAt == 2) {
	                        str += "<td><label class='badge badge-danger'>거절</label></td>";
	                    } else {
	                        str += "<td><label class='badge badge-secondary'>확인중</label></td>";
	                    }

	                    str += "<td id='srvcRequstWrDt" + v.srvcRequstNo + "'>" + (v.srvcRequstWrDt).substr(0,10) + "</td>";
	                    // 한 행 완성
	                    str += "</tr>";
	                    $("#rejectTabBody").html(str); // bodyList에 행 추가
	                    break;
                    	
                    //프로
            		case "ET01" :
            			str += "<tr style='font-family: GmarketSansLight;'>";
                        str += "<td id='num" + v.num + "'>" + v.num + "</td>";
                        str += "<td id='proNcnm" + v.srvcRequstNo + "'>" + v.userNcnm + "</td>";
                        str += "<td id='srvcRequstSj" + v.srvcRequstNo + "'>";
                        str += "<a href='/srvcRequst/srvcRqDetail?srvcRequstNo=" + v.srvcRequstNo + "'>" + v.srvcRequstSj + "</a></td>";
                        // 진행상태
                        if (v.srvcRequstProcessAt == 1) {
                            str += "<td><label class='badge badge-info'>수락</label></td>";
                        } else if (v.srvcRequstProcessAt == 2) {
                            str += "<td><label class='badge badge-danger'>거절</label></td>";
                        } else {
                            str += "<td><label class='badge badge-secondary'>미응답</label></td>";
                        }

                        str += "<td id='srvcRequstWrDt" + v.srvcRequstNo + "'>" + (v.srvcRequstWrDt).substr(0,10) + "</td>";
                        // 한 행 완성
                        str += "</tr>";
                        $("#rejectTabBody").html(str); // bodyList에 행 추가
                        break;
            	}// switch문 끝
            });//each 끝;
	            if(res.total>0){
			    	$("#Rj_divPaging").html(res.pagingArea);
	            }else{
			    	$("#Rj_divPaging").html("");
	            }
	        } // success 끝
	    }); // 검색 ajax 끝
	});
	
	// 거절 탭 클릭
	$("#reject-tab").on("click",function(){
		$("#reject-tab").addClass("active");
    	$("#noAnswer-tab").removeClass("active");
    	$("#all-tab").removeClass("active");		
    	$("#success-tab").removeClass("active");		
		
		// 나머지  탭 닫기
		$("#rejecTab").removeClass("active show");
		$("#successTab").removeClass("active show");
		$("#noAnswerTab").removeClass("active show");
		// 현재 탭 열기
		$("#rjecetTab").addClass("active show");
	});
	
	// 미답변 탭 클릭
	$("#noAnswer-tab").on("click",function(){
    	$("#noAnswer-tab").addClass("active");
		$("#all-tab").removeClass("active");
    	$("#success-tab").removeClass("active");		
    	$("#reject-tab").removeClass("active");		
		
		// 나머지  탭 닫기
		$("#allTab").removeClass("active show");
		$("#successTab").removeClass("active show");
		$("#rejectTab").removeClass("active show");
		// 현재 탭 열기
		$("#noAnswerTab").addClass("active show");
		
	});   
	
	// 답변완료 탭 클릭
	$("#success-tab").on("click",function(){
    	$("#success-tab").addClass("active");		
    	$("#noAnswer-tab").removeClass("active");
		$("#all-tab").removeClass("active");
		$("#reject-tab").removeClass("active");
		
		// 나머지  탭 닫기
		$("#allTab").removeClass("active show");
		$("#noAnswerTab").removeClass("active show");
		$("#rejectTab").removeClass("active show");
		// 현재 탭 열기
		$("#successTab").addClass("active show");
		
	});
	
	// 전체 탭 클릭
	$("#all-tab").on("click",function(){
		$("#all-tab").addClass("active");
    	$("#success-tab").removeClass("active");		
    	$("#noAnswer-tab").removeClass("active");
		$("#reject-tab").removeClass("active");
		
		// 나머지  탭 닫기
		$("#rejectTab").removeClass("active show");
		$("#noAnswerTab").removeClass("active show");
		$("#successTab").removeClass("active show");
		// 현재 탭 열기
		$("#allTab").addClass("active show");
	});	
});


</script>
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
			<!-- 제목 -->
			<div >
				<img alt="요청" src="../resources/images/요청서3.png" style="width:100px; height:auto; margin:0 0 20px 600px;">
				<h2 id="ondayTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">요청서 작성</h2>
				<hr style="border-top: 50px solid #f5f7ff; margin:-50px 300px 0 300px;">
				<br>
			</div>
</div>
	<div class="col-12 grid-margin stretch-card">
<div class="card" style="margin-top: 49px;">
		<div class="dropdown show"
				style="float: right; position: absolute; margin : 33px 0 0 976px;">
				<button class="btn btn-inverse-primary btn-sm dropdown-toggle" style="font-family: 'GmarketSansLight';"
					type="button" id="dropdownMenuSizeButton3" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="true">전체</button>
				<input type="text" name="keyword" id="keyword"
					style="width: auto; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left:11px;" />
				<button type="button" class="btn btn-inverse-primary btn-sm"
					id="searchBtn">
					<i class="mdi mdi-yeast"></i>
				</button>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton3"
					style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 31px, 0px);"
					x-placement="bottom-start">
					<p class="dropdown-item" style="font-family: 'GmarketSansLight';">전체</p>
					<p class="dropdown-item" style="font-family: 'GmarketSansLight';">닉네임</p>
					<p class="dropdown-item" style="font-family: 'GmarketSansLight';">제목</p>
				</div>
			</div>
	<div class="card-body">
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link" id="all-tab"  style="font-family: 'GmarketSansLight';"
				 aria-controls="all-1" href="/srvcRequst/srvcRqList"
				aria-selected="false">전체</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link" style="font-family: 'GmarketSansLight';"
				id="noAnswer-tab"  href="/srvcRequst/srvcRqNoAnswerList"
				aria-controls="noAnswer-1" aria-selected="false" tabindex="-1">미답변</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link" style="font-family: 'GmarketSansLight';"
				id="success-tab" " href="/srvcRequst/srvcRqSuccessList"
				aria-controls="success-1" aria-selected="false" tabindex="-1">요청 수락</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link active" style="font-family: 'GmarketSansLight';"
				id="reject-tab"  href="/srvcRequst/srvcRqRejectList"
				aria-controls="reject-1" aria-selected="true" tabindex="-1">요청 거절</a>
			</li>
		</ul>
		<!-- 전체 탭 -->
		<div class="tab-content">
			<div class="tab-pane fade" id="allTab" role="tabpanel"
				aria-labelledby="all-tab">
				<div class="table-responsive" id="srvcRqList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">번 호</th>
								<c:if test="${memSession.userId != null || memSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">프 로</th>
								</c:if>
								<c:if test="${proSession.userId != null || proSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">작성자</th>
								</c:if>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">제 목</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">진행 상태</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">요청 일자</th>
							</tr>
						</thead>
						<tbody id="allTabBody">
						</tbody>
					</table>
					<div id="divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
			<!-- 미답변 탭 -->
			<div class="tab-pane fade " id="noAnswerTab" role="tabpanel"
				aria-labelledby="noAnswer-tab">
				<div class="table-responsive" id="srvcRqList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">번 호</th>
								<c:if test="${memSession.userId != null || memSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">프 로</th>
								</c:if>
								<c:if test="${proSession.userId != null || proSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">작성자</th>
								</c:if>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">제 목</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">진행 상태</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">요청 일자</th>
							</tr>
						</thead>
						<tbody id="noAnswerTabBody">
						</tbody>
					</table>
					<div id="No_divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
			<!-- 완료 탭 -->
			<div class="tab-pane fade" id="successTab" role="tabpanel"
				aria-labelledby="success-tab">
				<div class="table-responsive" id="srvcRqList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">번 호</th>
								<c:if test="${memSession.userId != null || memSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">프 로</th>
								</c:if>
								<c:if test="${proSession.userId != null || proSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">작성자</th>
								</c:if>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">제 목</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">진행 상태</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">요청 일자</th>
							</tr>
						</thead>
						<tbody id="successTabBody">
						</tbody>
					</table>
					<div id="S_divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
			<!-- 거절 탭 -->
			<div class="tab-pane fade active show" id="rejectTab" role="tabpanel"
				aria-labelledby="reject-tab">
				<div class="table-responsive" id="srvcRqList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">번 호</th>
							<c:if test="${memSession.userId != null || memSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">프 로</th>
								</c:if>
								<c:if test="${proSession.userId != null || proSession.userId == ''}">
									<th style="font-size: 15pt; font-family: 'GmarketSansLight';">작성자</th>
								</c:if>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">제 목</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">진행 상태</th>
								<th style="font-size:15pt; font-family: 'GmarketSansLight';">요청 일자</th>
							</tr>
						</thead>
						<tbody id="rejectTabBody">
						</tbody>
					</table>
					<div id="Rj_divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>