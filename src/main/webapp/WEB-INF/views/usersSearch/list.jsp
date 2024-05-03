<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<style>
.card-body {
	margin-bottom: 20px;
}

.card {
	margin-bottom: 20px;
}

.background-icon {
	margin-top: -20px;
}
</style>
</head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
    // 드롭다운 항목 클릭 시 이벤트 처리
	
	
	$("#btnSearch").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		
		console.log("keyword:"+keyword);
		
		let currentPage = "1";
		
		let data = {
			"keyword":keyword,
			"currentPage":currentPage
		};
		console.log("data:"+data)
		
		$.ajax({
			url:"/usersSearch/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result:",result);
				
				let str = "";
				
				$("#usersTbody").html("");
			
				$.each(result.content,function(idx, usersVO){
					str += "<tr onclick=\"location.href='/usersSearch/detail?userId=" + usersVO.userId + "'\" style=\"cursor: pointer;\">";
					/* str += "<tr>"; */
					
					
					str += "<td>"+usersVO.rnum+"</td>";
					str += "<td>"+usersVO.userId+"</td>";
					str += "<td>"+usersVO.userNcnm+"</td>";
					str += "<td>"+usersVO.userNm+"</td>";
 					//str += "<td>"+usersVO.userPassword+"</td>";
					str += "<td>";
					if (usersVO.emplyrTy === "ET01") {
					    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-info'><i class='mdi mdi-face'></i> 회원</div>";
					} else if (usersVO.emplyrTy === "ET02") {
					    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-primary'><i class='mdi mdi-emoticon-cool'></i> 프로</div>";
					} else {
					    str += convertUserType(usersVO.emplyrTy); // 기타 사용자 유형 처리
					}
					str += "<td>"+convertUserType2(usersVO.secsnAt)+"</td>";
					
					str += "</tr>";
				
				});	
				
				$("#usersTbody").append(str);
				$("#divPagingArea").html(result.pagingArea);
				
				
			}
			
		});
		
	});
	
	let currentPage  = "${param.currentPage}";
	console.log("currentPage",currentPage);
	if(currentPage==""){
		currentPage = 1;
		
	}
	
	let data = {
		"keyword":"${param.keyword}",
		"currentPage":currentPage
	};
	console.log("data:",data);
	
	$.ajax({
		url : "/usersSearch/listAjax?currentPage="+currentPage,
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(result){
			console.log("result:",result);
		
			let str = "";
			
			$("#usersTbody").html("");
			
			$.each(result.content,function(idx, usersVO){

				str += "<tr onclick=\"location.href='/usersSearch/detail?userId=" + usersVO.userId + "'\" style=\"cursor: pointer;\">";
				/* str += "<tr>"; */
				
				
				str += "<td>"+usersVO.rnum+"</td>";
				str += "<td>"+usersVO.userId+"</td>";
				str += "<td>"+usersVO.userNcnm+"</td>";
				str += "<td>"+usersVO.userNm+"</td>";
				//str += "<td>"+usersVO.userPassword+"</td>";
				str += "<td>";
				if (usersVO.emplyrTy === "ET01") {
				    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-info'><i class='mdi mdi-face'></i> 회원</div>";
				} else if (usersVO.emplyrTy === "ET02") {
				    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-primary'><i class='mdi mdi-emoticon-cool'></i> 프로</div>";
				} else {
				    str += convertUserType(usersVO.emplyrTy); // 기타 사용자 유형 처리
				}
				str += "<td>"+convertUserType2(usersVO.secsnAt)+"</td>";
				
				str += "</tr>";
				
				
			});
			$("#usersTbody").append(str);
			console.log(result.pagingArea);
			$("#divPagingArea").html(result.pagingArea);
			
			
			sessionStorage.setItem("total",result.total);
		}
		
	});
	
});

function convertUserType(userType) {
    switch(userType) {
        case "ET01":
            return "회원";
        case "ET02":
        	return "프로";
            
        default:
            return userType;
    }
}

function convertUserType2(userType) {
    switch(userType) {
        case 1:
            return "이용중";
        case 0:
            return "탈퇴";
        default:
            return "기타";
    }
}


</script>

<body>

	<div class="col-md-12 stretch-card grid-margin grid-margin-md-0">
		<div class="card data-icon-card-primary">
			<div class="card-body">
				<p class="card-title text-white"></p>
				<div class="row">
					<div class="col-8 text-white">
						<h3 class="tex-center">유저관리</h3>
						<p class="text-white font-weight-500 mb-0">This is a page to
							manage users.</p>
					</div>
					<div class="col-4 background-icon"></div>

				</div>
			</div>
		</div>
	</div>
	
	<div class="col-lg-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6" style="margin-top: 10px;">
						<h3>유저관리</h3>
					</div>
					<div class="col-md-6 form-group text-center"> <!-- 중앙 정렬을 위해 text-center 클래스 추가 -->
                    <div class="input-group">
                        <input type="text" name="keyword" id="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label="">
                        <div class="input-group-append">
                            <button class="btn btn-sm btn-primary" id="btnSearch" type="button">
                                Search <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
			</div>
		

				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr class="text-white" style="background-color: #4b49ac">
								<th>번호</th>
								<th>아이디</th>
								<th>닉네임</th>
								<th>이름</th>
								<!-- <th>비밀번호</th> -->
								<th>사용자유형</th>
								<th>탈퇴여부</th>
								
							</tr>
						</thead>
						
						<tbody id="usersTbody">
							
						</tbody>
						
					</table>
				</div>
		
				
				
				<div class="row justify-content-center" style="margin-top: 20px;">
					<div id="divPagingArea"></div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>