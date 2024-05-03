<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<style>
.card-body {
	margin-bottom: 20px;
}

.card {
	margin-bottom: 20px;
}

.accordion-button {
	cursor: pointer;
}

.accordion-content {
	display: none;
}

.background-icon {
	margin-top: -20px;
}
</style>
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
    	url : "/oneInqry/searchList",
    	 contentType : "application/json; charset=utf-8",
 	    data : JSON.stringify(data),
 	    type : "post",
 	    dataType : "json",
 	    success : function(res){
 	    	console.log(res);
 	    	var str = "";
 	    	$("#allTabBody").html("");
 	    	$("#divPaging").html("");
 	    	var total = res.total;
 	    	console.log("total : ", total);
 	    	var length = res.data.content.length;
 	    	var mngrId = res.mngrId;
 	    	console.log("관리자 아이디 : " ,mngrId);
            if(length == 0){
            	str = "<td colspan='5'>문의 내역이 없습니다.</td>"
	            $("#allTabBody").html(str);
        	}	
 	    	$.each(res.data.content, function(i,v){
 	    		console.log("res.data.content", res.data.content);
 	    		switch(mngrId){
 	    		//관리자
 	    		case "testAdmin" :
 	    			str += "<tr>";
 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
 	    			str += "<td id='userId"+v.oneInqryNo+"'>"+v.userId+"</td>";
 	    			str += "<td id='oneInqrySj"+v.oneInqryNo+"'>";
 	    			str += "<a href='/oneInqry/oneInqryDetail?oneInqryNo="+v.oneInqryNo+"&userId="+v.userId+"'>"+v.oneInqrySj+"</a>";
 	    			str += "</td>"
	 	    			if(v.oneInqryAnswerVOList.oneInqryAnswerCn == null){
	 	    				str += "<td><label class='badge badge-secondary'>미답변</label></td>";
	 	    			}else if(v.oneInqryAnswerVOList.oneInqryAnswerCn != null){
	 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
	 	    			}
					str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
					str += "</tr>";
					$("#allTabBody").html(str);
					break;
	 	    		
 	    		default :
 	    			str += "<tr>";
 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
                    str += "<td id='userId" + v.oneInqryNo + "'>" + v.userId + "</td>";
 	    			str += "<td id='oneInqry"+v.oneInqryNo+"'>";
 	    			str += "<a href='/oneInqry/oneInqryDetail?oneInqryNo="+v.oneInqryNo+"'>"+v.oneInqrySj+"</a>";
 	    			str += "</td>"
 		 	    			if(v.oneInqryAnswerVOList[0].oneInqryAnswerCn == null){
 		 	    				str += "<td><label class='badge badge-secondary'>진행중</label></td>";
 		 	    			}else if(v.oneInqryAnswerVOList[0].oneInqryAnswerCn != null){
 		 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
 		 	    			}
 	    			str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
					str += "</tr>";
					$("#allTabBody").html(str);
					break;
 	    		}// switch문 끝
 	    	});// each 끝
 	    	if(total > 0){
        	    $("#divPaging").html(res.data.pagingArea);
            }else{
        	    $("#divPaging").html("");
            }
 	    } // success 끝
    });// 전체목록 출력 ajax 끝
    
    //검색
	$("#searchBtn").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		
		// 검색 카테고리 설정
		let selectColumn = $("#dropdownMenuSizeButton3").text();
		if(selectColumn == "닉네임"){
			selectColumn = "A.USER_ID";
		}else if(selectColumn == "제목"){
			selectColumn = "A.ONE_INQRY_SJ";
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
	        url : "/oneInqry/searchList",
	        contentType : "application/json; charset=utf-8",
	        data : JSON.stringify(data),
	        type : "post",
	        dataType : "json",
	        success: function(res){
	            console.log("res", res);
	            $("#allTabBody").html("");
	            var total = res.total;
	            var mngrId = res.mngrId;
	            var str = "";
	            var length = res.data.content.length;
	            if(length == 0){
	            	str = "<td colspan='5'>검색된 결과가 없습니다</td>"
		            $("#allTabBody").html(str);
	        	}	
	            $.each(res.data.content, function(i, v){
	            	console.log(res.data.content);
	 	    		switch(mngrId){
	 	    		//관리자
	 	    		case "testAdmin" :
	 	    			console.log("관리자란다");
	 	    			str += "<tr>";
	 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
	 	    			str += "<td id='userId"+v.oneInqryNo+"'>"+v.userId+"</td>";
	 	    			str += "<td id='oneInqrySj"+v.oneInqryNo+"'>";
	 	    			str += "<a href='/oneInqry/oneInqryDetail?oneInqryNo="+v.oneInqryNo+"&userId="+v.userId+"'>"+v.oneInqrySj+"</a>";
	 	    			str += "</td>"
		 	    			if(v.oneInqryAnswerVOList.oneInqryAnswerCn == null){
		 	    				str += "<td><label class='badge badge-secondary'>미답변</label></td>";
		 	    			}else if(v.oneInqryAnswerVOList.oneInqryAnswerCn != null){
		 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
		 	    			}
						str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
						str += "</tr>";
						$("#allTabBody").html(str);
						break;
		 	    		
	 	    		default :
	 	    			str += "<tr>";
	 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
	                    str += "<td id='userId" + v.oneInqryNo + "'>" + v.userId + "</td>";
	 	    			str += "<td id='oneInqry"+v.oneInqryNo+"'>";
	 	    			str += "<a href='/oneInqry/oneInqryDetail?oneInqryNo="+v.oneInqryNo+"'>"+v.oneInqrySj+"</a>";
	 	    			str += "</td>"
	 		 	    			if(v.oneInqryAnswerVOList[0].oneInqryAnswerCn == null){
	 		 	    				str += "<td><label class='badge badge-secondary'>진행중</label></td>";
	 		 	    			}else if(v.oneInqryAnswerVOList[0].oneInqryAnswerCn != null){
	 		 	    				str += "<td><label class='badge badge-info'>답변완료</label></td>";
	 		 	    			}
	 	    			str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
						str += "</tr>";
						$("#allTabBody").html(str);
						break;
	 	    		}// switch문 끝
	            });//each 끝;
	            if(total > 0){
	        	    $("#divPaging").html(res.data.pagingArea);
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
<body>
<div class="col-md-12 stretch-card grid-margin grid-margin-md-0">
		<!-- 제목 -->
		<div >
			<img alt="1대1" src="../resources/images/상담.png" style="width:100px; height:auto; margin:20px 0 20px 740px;">
			<h2 id="InqryTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">1:1 문의</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
			<br><br>
		</div>
</div>
<div class="card">
	<div class="card-body">
		<div class="dropdown show" style="position: relative; margin-left: 950px; margin-bottom: -45px;">
			<button class="btn btn-inverse-primary btn-sm dropdown-toggle"
				type="button" id="dropdownMenuSizeButton3" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="true">선택</button>
			<input type="text" name="keyword" id="keyword"
				style="width: 200px; border-radius: 15px; border: 0; outline: none; background-color: rgb(233, 233, 233); height: 30px; padding-left: 15px;" />
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
				role="tab" aria-controls="all-1" href="/oneInqry/oneInqryList"
				aria-selected="true">전체</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="noAnswer-tab" data-bs-toggle="tab" role="tab" href="/oneInqry/oneInqryNoAnswerList"
				aria-controls="noAnswer-1" aria-selected="false" tabindex="-1">미답변</a>
			</li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="success-tab" data-bs-toggle="tab" role="tab" href="/oneInqry/oneInqrySuccessList"
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
								<th>아이디</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
							</tr>
						</thead>
						<tbody id="allTabBody">
						</tbody>
					</table>
					<div id="divPaging"
						style="position: relative; margin-left: 40%; margin-top: 20px;"></div>
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
								<th>아이디</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
							</tr>
						</thead>
						<tbody id="noAnswerTabBody">
						</tbody>
					</table>
					<div id="No_divPaging"
						style="position: relative; margin-left: 40%; margin-top: 20px;"></div>
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
								<th>아이디</th>
								<th>제 목</th>
								<th>진행상태</th>
								<th>문의일자</th>
							</tr>
						</thead>
						<tbody id="successTabBody">
						</tbody>
					</table>
					<div id="S_divPaging"
						style="position: relative; margin-left: 40%; margin-top: 20px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>