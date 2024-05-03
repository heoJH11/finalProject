<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

th,td,h5,h4{
	font-family: 'GmarketSansMedium';
}
#proSecssionModalClose{
	background-color:transparent;
	border:none;
}
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
	
	if($("#adminId").val() == ""){
		Swal.fire({
			    title: '관리자만 들어갈  수 있습니다.',
			    icon: 'error',
			    showCancelButton: false,
				confirmButtonColor: '#7066e0',
			    confirmButtonText: '확인',
		    }).then((result) => {
		    	location.href="/main"
		    })
	}
	
	
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
    	url : "/manage/resignProList",
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
 	    	var length = res.content.length;
            if(length == 0){
            	str = "<td colspan='5'>탈퇴 요청이 없습니다.</td>"
	            $("#allTabBody").html(str);
        	}	
 	    	$.each(res.content, function(i,v){
 	    		console.log("res.content", res.content);
 	    			str += "<tr onclick='tblClick(this)' id='" + v.userId + "'>";
 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
                    str += "<td id='userId" + v.oneInqryNo + "'>" + v.userId + "</td>";
 	    			str += "<td id='oneInqry"+v.oneInqryNo+"'>"+v.oneInqrySj+v.oneInqryCn;
 	    			str += "</td>";
 	    			str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
					str += "</tr>";
					$("#allTabBody").html(str);
 	    	});// each 끝
 	    	if(total > 0){
        	    $("#divPaging").html(res.pagingArea);
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
	        url : "/manage/resignProList",
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
	            var length = res.content.length;
	            if(length == 0){
	            	str = "<td colspan='5'>검색된 결과가 없습니다</td>"
		            $("#allTabBody").html(str);
	        	}	
	            $.each(res.content, function(i, v){
// 	            	console.log(res.content);
		            	str += "<tr onclick='tblClick(this)' id='" + v.userId + "'>";
	 	    			str += "<td id='num"+v.oneInqryNo+"'>"+v.num+"</td>";
	                    str += "<td id='userId" + v.oneInqryNo + "'>" + v.userId + "</td>";
	 	    			str += "<td id='oneInqry"+v.oneInqryNo+"'>"+v.oneInqrySj+v.oneInqryCn;
	 	    			str += "</td>";
	 	    			str += "<td>"+(v.oneInqryWritngDt).substr(0,10)+"</td>";
						str += "</tr>";
						$("#allTabBody").html(str);
	            });//each 끝;
	            if(total > 0){
	        	    $("#divPaging").html(res.pagingArea);
	            }else{
	        	    $("#divPaging").html("");
	            }
	        } // success 끝
	    }); // 검색 ajax 끝
	});// 검색 버튼 함수 끝
	
	//탈퇴모달 확인버틀 클릭
	$("#proSecssionOk").on("click",function(){
		if($("#secssionCheck").val() == '탈퇴진행'){
			$.ajax({
				url:"/manage//proSecssion",
				data:{"proId":$("#modalProId").val()},
				type:'post',
				success:function(res){
					console.log("탈퇴수리 " + res);
					Swal.fire({
						title: $("#modalProId").val() + ' 프로의 탈퇴가 성공적으로 진행되었습니다.',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						location.href="/manage/resignPro";
					})
				}
			})
		}else{
			Swal.fire({
				title: '입력 문자가 올바르지 않습니다.',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인'
			})
		}
	})
	
	$("#proSecssionModalClose").on('click',function(){
		$("#proSecssionModal").modal('hide');
	})
	
}); // 전체 함수 끝

//프로 탈퇴 글목록 선택
let tblClick = function(e){
	console.log(e.id);
	$("#modalProId").val(e.id);
	$("#secssionCheck").val("");
	$("#modalTitle").text(e.id + " 님의 탈퇴요청입니다.");
	$("#proSecssionModal").modal('show');
}
</script>
<body>
<input type="hidden" id="adminId" value="${admSession.userId}">
<div>
	<!-- 제목 -->
		<div >
			<img alt="탈퇴" src="../resources/images/탈퇴.png" style="width:100px; height:auto; margin:0 0 20px 740px;">
			<h2 id="resignTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">탈퇴 요청</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 600px 0 600px;">
			<br><br>
		</div>
</div>
	<div class="card">
		<div class="card-body">
			<div class="dropdown show"
				style="position: relative; float: right;">
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
				</div>
			</div>
			<!-- 전체 탭 -->
			<div>
				<div class="table-responsive" id="" style="margin-top: 50px;">
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>번 호</th>
								<th>아이디</th>
								<th>탈퇴 사유</th>
								<th>탈퇴 요청일</th>
							</tr>
						</thead>
						<tbody id="allTabBody">
						</tbody>
					</table>
					<div id="divPaging"
						style="position: relative; margin-left: 48%; margin-top: 20px;"></div>
				</div>
			</div>
		</div>
</div>

<!-- 프로 탈퇴처리 모달  -->
<div class="modal fade" id="proSecssionModal" tabindex="-1" data-backdrop="static"
	data-backdrop="static" aria-labelledby="proSecssionModal"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" style="font-size: 1.3rem;" style='font-family: GmarketSansMedium;'>🛠️ 프로 탈퇴처리 확인</h5>
				<button type="button" id="proSecssionModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
			</div>
			<input type="hidden" id="modalProId">
			<div class="modal-body">
				<h4 id="modalTitle"></h4>
				<h5 style='font-family: GmarketSansMedium; line-height: 1.2;'>프로 탈퇴를 진행하시려면 <b style="font-size: 1.3rem; color:red;">'탈퇴진행'</b> 입력 후<br>탈퇴처리 버튼을 눌러주세요.</h5>
				<input type="text" class="form-control" id="secssionCheck">
			</div>
			<div class="modal-footer">
				<button type="button" id="proSecssionOk" class="btn btn-primary" style="float: right;">탈퇴처리</button>
			</div>
		</div>
	</div>
</div>