<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/js/jquery.min.js"></script>
<script>
$(function(){
    $(".dropdown-item").click(function() {
        var selectedText = $(this).text();
        $("#dropdownMenuSizeButton3").text(selectedText);
    });
    
    // 전체 목록 출력
    let currentPage = "${param.currentPage}";
    if(currentPage == ""){
    	currentPage = "1";
    }
    
    let data = {
    		"keyword" : "${param.keyword}",
			"currentPage" : currentPage
    }
    
    $.ajax({
    	url : "/srvcBtfInqry/searchList",
    	 contentType : "application/json; charset=utf-8",
 	    data : JSON.stringify(data),
 	    type : "post",
 	    dataType : "json",
 	    success : function(res){
 	    	console.log(res);
 	    	var str = "";
 	    	$("#allTabBody").html("");
 	    	$("#divPaging").html("");
 	    	var length = res.content.length;
            if(length == 0){
            	str = "<td colspan='5'>문의 내역이 없습니다.</td>"
	            $("#allTabBody").html(str);
        	}	
 	    	$.each(res.content, function(i,v){
 	    		switch(v.emplyrTy){
 	    		// 회원
 	    		case "ET02" :
 	    			str += "<tr>";
 	    			str += "<td id='num"+v.btfInqryNo+"'>"+v.num+"</td>";
                    str += "<td id='proNcnm" + v.btfInqryNo + "'><a href='/proProfl/detail?proId="+v.proId+"'>" + v.userNcnm + "</a></td>";
 	    			str += "<td id=btfInqry"+v.btfInqryNo+"'>";
 	    			str += "<a href='/srvcBtfInqry/btfInqryDetail?btfInqryNo="+v.btfInqryNo+"'>"+v.btfInqrySj+"</a>";
 	    			str += "</td>"
 	    			if(v.btfInqryAnswerCn == null){
 	    				str += "<td><label class='badge badge-secondary'>진행중</label></td>";
 	    			}else if(v.btfInqryAnswerCn != null){
 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
 	    			}
 	    			str += "<td>"+(v.btfInqryWrDt).substr(0,10)+"</td>";
					str += "</tr>";
					$("#allTabBody").html(str);
					break;
					
 	    		case "ET01" :
 	    			str += "<tr>";
 	    			str += "<td id='num"+v.btfInqryNo+"'>"+v.num+"</td>";
 	    			str += "<td id='proNcnm"+v.btfInqryNo+"'>"+v.userNcnm+"</td>";
 	    			str += "<td id='btfInqry"+v.btfInqryNo+"'>";
 	    			str += "<a href='/srvcBtfInqry/btfInqryDetail?btfInqryNo="+v.btfInqryNo+"'>"+v.btfInqrySj+"</a>";
 	    			str += "</td>"
 	    			if(v.btfInqryAnswerCn == null){
 	    				str += "<td><label class='badge badge-secondary'>미답변</label></td>";
 	    			}else if(v.btfInqryAnswerCn != null){
 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
 	    			}
					str += "<td>"+(v.btfInqryWrDt).substr(0,10)+"</td>";
					str += "</tr>";
					$("#allTabBody").html(str);
					break;
 	    		}// switch문 끝
 	    	});// each 끝
 	    	if(res.total > 0){
        	    $("#divPaging").html(res.pagingArea);
            }else{
        	    $("#divPaging").html("");
            }
 	    } // success 끝
    });// 전체목록 출력 ajax 끝
    
    // 검색
	$("#searchBtn").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		
		
		// 검색 카테고리 설정
		let selectColumn = $("#dropdownMenuSizeButton3").text();
		if(selectColumn == "닉네임"){
			selectColumn = "USER_NCNM";
		}else if(selectColumn == "제목"){
			selectColumn = "BTF_INQRY_SJ";
		}else if(selectColumn == "전체"){
			selectColumn = "ALL";
		}

		let currentPage = "1";
		
		var data = {
				"keyword" : keyword,
				"selectColumn" : selectColumn,
				"currentPage" : currentPage
					};
		$.ajax({
	        url : "/srvcBtfInqry/searchList",
	        contentType : "application/json; charset=utf-8",
	        data : JSON.stringify(data),
	        type : "post",
	        dataType : "json",
	        success: function(res){
	            console.log("res", res);
	            $("#allTabBody").html("");
	            var str = "";
	            var length = res.content.length;
	            if(length == 0){
	            	str = "<td colspan='5'>검색된 결과가 없습니다</td>"
		            $("#allTabBody").html(str);
	        	}	
	            $.each(res.content, function(i, v){
	            	console.log(res.content);
		            switch (v.emplyrTy) {
					case "ET02":
						str += "<tr>";
	 	    			str += "<td id='num"+v.btfInqryNo+"'>"+v.num+"</td>";
	 	    			str += "<td id='proNcnm" + v.btfInqryNo + "'><a href='/proProfl/detail?proId="+v.proId+"'>" + v.userNcnm + "</a></td>";
	 	    			str += "<td id=btfInqry"+v.btfInqryNo+"'>";
	 	    			str += "<a href='/srvcBtfInqry/btfInqryDetail?btfInqryNo="+v.btfInqryNo+"'>"+v.btfInqrySj+"</a>";
	 	    			str += "</td>"
	 	    			if(v.btfInqryAnswerCn == null){
	 	    				str += "<td><label class='badge badge-secondary'>진행중</label></td>";
	 	    			}else if(v.btfInqryAnswerCn != null){
	 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
	 	    			}
	 	    			str += "<td>"+(v.btfInqryWrDt).substr(0,10)+"</td>";
						str += "</tr>";
						$("#allTabBody").html(str);
						break;
						
					case "ET01":
						str += "<tr>";
	 	    			str += "<td id='num"+v.btfInqryNo+"'>"+v.num+"</td>";
	 	    			str += "<td id='proNcnm"+v.btfInqryNo+"'>"+v.userNcnm+"</td>";
	 	    			str += "<td id='btfInqry"+v.btfInqryNo+"'>";
	 	    			str += "<a href='/srvcBtfInqry/btfInqryDetail?btfInqryNo="+v.btfInqryNo+"'>"+v.btfInqrySj+"</a>";
	 	    			str += "</td>"
	 	    			if(v.btfInqryAnswerCn == null){
	 	    				str += "<td><label class='badge badge-secondary'>미답변</label></td>";
	 	    			}else if(v.btfInqryAnswerCn != null){
	 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
	 	    			}
						str += "<td>"+(v.btfInqryWrDt).substr(0,10)+"</td>";
						str += "</tr>";
						$("#allTabBody").html(str);
						break;
					}
	            });//each 끝;
	            if(res.total > 0){
	        	    $("#divPaging").html(res.pagingArea);
	            }else{
	        	    $("#divPaging").html("");
	            }
	        } // success 끝
	    }); // 검색 ajax 끝
	});// 검색 버튼 함수 끝
	
    //전체 탭 클릭 시
    $("#all-tab").on("click",function(){
    	$("#all-tab").addClass("active");
    	$("#noAnswer-tab").removeClass("active");
    	$("#success-tab").removeClass("active");
    	
    	// 나머지  탭 닫기
		$("#noAnswerTab").removeClass("active show");
		$("#successTab").removeClass("active show");
		
		// 현재 탭 열기
		$("#allTab").addClass("active show");
    });//전체목록 함수 끝
	
	// 미답변 탭 클릭
	$("#noAnswer-tab").on("click",function(){
    	$("#noAnswer-tab").addClass("active");
		$("#all-tab").removeClass("active");
    	$("#success-tab").removeClass("active");		
		
		// 나머지  탭 닫기
		$("#allTab").removeClass("active show");
		$("#successTab").removeClass("active show");
		// 현재 탭 열기
		$("#noAnswerTab").addClass("active show");
	});//미답변 목록 함수 끝
	
	// 답변완료 탭 클릭
	$("#success-tab").on("click",function(){
    	$("#success-tab").addClass("active");		
    	$("#noAnswer-tab").removeClass("active");
		$("#all-tab").removeClass("active");
		
		// 나머지  탭 닫기
		$("#allTab").removeClass("active show");
		$("#noAnswerTab").removeClass("active show");
		// 현재 탭 열기
		$("#successTab").addClass("active show");
	});//답변완료 목록 함수 끝
}); // 전체 함수 끝
</script>
<div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card data-icon-card-primary">
			<div class="card-body">
				<p class="card-title text-white"></p>
				<div class="row">
					<div class="col-8 text-white">
						<h3>사전 문의</h3>
						<p class="text-white font-weight-500 mb-0">This is list of advance inquiries from you sent</p>
					</div>
					<div class="col-4 background-icon"></div>
	
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-12 grid-margin stretch-card">
<div class="card">
	<div class="card-body">
		<div class="dropdown show"
				style="float: right; margin-right: 0">
				<button class="btn btn-inverse-primary btn-sm dropdown-toggle"
					type="button" id="dropdownMenuSizeButton3" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="true">선택</button>
				<input type="text" name="keyword" id="keyword"
					style="width: auto; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left:11px;" />
				<button type="button" class="btn btn-inverse-primary btn-sm"
					id="searchBtn">
					<i class="mdi mdi-yeast"></i>
				</button>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton3"
					style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 31px, 0px);"
					x-placement="bottom-start">
					<p class="dropdown-item">전체</p>
					<p class="dropdown-item">닉네임</p>
					<p class="dropdown-item">제목</p>
				</div>
			</div>
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="all-tab" data-bs-toggle="tab"
				role="tab" aria-controls="all-1" href="/srvcBtfInqry/btfInqryList"
				aria-selected="true">전체</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="noAnswer-tab" data-bs-toggle="tab" role="tab" href="/srvcBtfInqry/btfInqryNoAnswerList"
				aria-controls="noAnswer-1" aria-selected="false" tabindex="-1">미답변</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="success-tab" data-bs-toggle="tab" role="tab" href="/srvcBtfInqry/btfInqrySuccessList"
				aria-controls="success-1" aria-selected="false" tabindex="-1">완료</a>
			</li>
		</ul>
		<!-- 전체 탭 -->
		<div class="tab-content">
			<div class="tab-pane fade active show" id="allTab" role="tabpanel"
				aria-labelledby="all-tab" >
				<div class="table-responsive" id="btfInqryList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>번 호</th>
								<th>이 름</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
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
				<div class="table-responsive" id="btfInqryList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>번 호</th>
								<th>이 름</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
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
				<div class="table-responsive" id="btfInqryList">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>번 호</th>
								<th>이 름</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
							</tr>
						</thead>
						<tbody id="successTabBody">
						</tbody>
					</table>
					<div id="S_divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>