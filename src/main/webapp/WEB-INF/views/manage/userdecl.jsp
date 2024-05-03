<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
function modalView(userId){
	console.log("userId : ",userId);
	$("#modal_left").text("");
	let data={
		"userId":userId
	}
	let str = "";
	str+=`<input type="hidden" id="targetId" value="\${userId}" />`
	$.ajax({
		type:"post",
		url:"/decl/userDeclList",
		data:data,
		async:false,
		dataType:"json",
		success: function(res){
			console.log("해당 아이디 신고 세부 사항 : ",res);
			let sum = 0;
			str+=`
	        	<h3><b>✔️ 신고 내역</b></h3><br><br>
	        	<h4><b>➕ 처리미완료 신고 내역<b></h4>
	        	<br><br>
	        	<div>
	        	`;
			for(const UserDeclVO of res){
				console.log("반복되는 VO : ",UserDeclVO);
				if(UserDeclVO.declProcessAt==0){
					console.log("아직 신고처리가 안된 친구들");
					sum +=UserDeclVO.count;
					str+=`
						<h4>\${UserDeclVO.declResn}
	        			\${UserDeclVO.count}회</h4>
					`;
					
				}
			}
			if(sum==0){
				str+=`
					<h4 style="color:#3749b0;">목록이 존재하지 않습니다.</h4>
					
				`
			}
			str+=`
				<h4 style="float: right;">미완료 신고 총 \${sum} 회</h4><br><br>
				<h4><b>➕ 처리완료 신고 내역<b></h4>
				<br><br>
			`
			let sum2 = 0;
			
			for(const UserDeclVO of res){
				if(UserDeclVO.declProcessAt==1){
					sum2 +=UserDeclVO.count;
					console.log("신고 처리가 된 친구들");
					str+=`
						<h4>\${UserDeclVO.declResn}
	        			\${UserDeclVO.count}회</h4>
					`
					
				}
			}
			
			if(sum2==0){
				str+=`
					<h4 style="color:#3749b0;">목록이 존재하지 않습니다.</h4>
					
				`
			}
			
			str+=`
				<h4 style="float: right;">완료 신고 총 \${sum2} 회</h4><br>
				</div>
				<hr>
			`
			$("#modal_left").append(str);
		}
	});
	
	//제재 처리 현황 띄우게 하기
	//여기서 넘겨줘야 될 것은 해달 userId
	console.log("제재 처리 현황에서 필요한 userId : ",data);
	
	$.ajax({
		type:"post",
		url:"/decl/declHistoryList",
		//cache:false,
		data:data,
		datatype:"json",
		success: function(res){
			console.log("이것은 제재 현황 리스트다 : ",res);
			let str ="";
			str+=`
				<h4><b>✔️ 제재 내역<b></h4>
				<br><br>
			`
			console.log("제재내역 수 : " ,res.length);
			if(res.length==0){
				str+=`
					<h4 style="color:#3749b0;">목록이 존재하지 않습니다.</h4>
				`
			}
			
			for(const PunshVO of res){
				str+=`
					<h4>\${PunshVO.punshStrDe} ~ \${PunshVO.punshEndDe} 정지</h4>
				`
			}
			$("#modal_left").append(str);
		}
	});
	
	
}
function userList(){
	$.ajax({
		type:"get",
		url:"/decl/userList",
		//contentType: "application/json; charset=utf-8",
		dataType:"json",
		success: async function(res){
			let str = "";
			//console.log("res : ",res)
			for (const usersVO of res) {
				//console.log("usersVO:",usersVO);
				//console.log("userId2 : ",usersVO.userId);
				let userId2 = usersVO.userId;
				let data = {
					"userId2":userId2
				}
				try{
					let declCount = await $.ajax({
						type:"post",
						url:"/decl/getDeclCount",
						data:data,
						dataType:"text"
					});
					//console.log("신고횟수 : ",declCount);
					if(declCount==0) continue;
					//여기서 str에 결과 추가
					str+=`
					
						<tr onclick="modalView('\${usersVO.userId}');" 
						data-toggle="modal" data-target="#modal-xl">
							<td>\${usersVO.declCount}</td>
							<td>\${usersVO.userNm}</td>
							<td>\${usersVO.userNcnm}</td>
							<td>\${usersVO.userId}</td>
						</tr>
					`
					
				} catch(error){
					console.error("Error occurred: ", error);
				}
        	}
			//여기서 바디에 추가
			$("#lbsBody").append(str);
		}
	});
	
}
$(function(){
	var memId = "${memSession.userId}";
	var proId = "${proSession.userId}";
	console.log("memId : ", memId);
	console.log("proId : ", proId);
	if(memId != "" || proId != "" ){
		$("#wrtBtn").css("display", "block");
	}
	/* console.log("sessionId : ",${userId});
	if(`${userId}` == ""){
	      Swal.fire({
	         title: '로그인 후 이용해주세요.',
	         icon: 'info',
	         showCancelButton: false,
	         confirmButtonColor: '#3085d6',
	         confirmButtonText: '확인'
	      }).then((result)=>{
	         location.href="/main";
	      })
	   } */

	//제재 처리 버튼 클릭시
	$("#declSetBtn").off("click").on("click",function(){
		console.log("버튼을 눌렀습니다..");
		console.log("userId : ",$("#targetId").val());
		console.log($('input:radio[name=typesOfSanctions]:checked').val());
		
		let userId = $("#targetId").val();
		let punshDe = $('input:radio[name=typesOfSanctions]:checked').val();
		
		let data={
			"userId":userId,
			"punshDe":punshDe
		}
		console.log("data :",data)
		
		$.ajax({
			type:"post",
			url:"/decl/userDeclSet",
			data:JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			dataType:"text",
			success:function(res){
				console.log("제재처리후 결과 : ",res)
				// 여기서 부터 내가 해보겠다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				Swal.fire({
		            title: '제재 처리가 완료되었습니다.',
		            icon: 'success',
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		          })
				modalView(userId);
				$('input[name="typesOfSanctions"]').prop('checked', false);
			}
			
		});
		
	});
	
	$("#clsBtn").on("click",function(){
		$('input[name="typesOfSanctions"]').prop('checked', false);
	});
	userList()
});
</script>
<style>
div.modal-body {
	width: 100%;
/* 	border: 1px solid #003458; */
}

div.left {
	width: 60%;
	float: left;
	box-sizing: border-box;
	padding-left:50px;
	padding-right:100px;
/* 	background: #8977ad; */
}

div.right {
	width: 40%;
	float: right;
	align: right;
	text-align:left;
	padding-left:100px;
	padding-right:100px;
	box-sizing: border-box;
/* 	background: #ece6cc; */
}

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

th,td,h5,h4,input,button,b{
	font-family: 'GmarketSansMedium';
}

label{
	font-family: 'GmarketSansMedium';
	font-size: 15px !important;
	margin-left:5px;
}

</style>
<title></title>
</head>

<body>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">

					<!-- 제목 -->
					<div >
						<img alt="신고" src="../resources/images/신고2.png" style="width:100px; height:auto; margin:0 0 20px 730px;">
						<h2 id="declTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 신고관리</h2>
						<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
						<br><br>
					</div>

					<div class="form-group">
						<div class="input-group">
							<input type="text" name="keyword" id="keyword"
								value="${param.keyword}" class="form-control"
								placeholder="검색어를 입력하세요" aria-label="" style="margin-left: 1100px;">
							<div class="input-group-append">
								<button class="btn btn-sm btn-primary" id="btnSearch"
									type="button">검색</button>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-12">
							<div class="table-responsive">
								<div id="example_wrapper"
									class="dataTables_wrapper dt-bootstrap4 no-footer">
									<div class="row">
										<div class="col-sm-12 col-md-6"></div>
										<div class="col-sm-12 col-md-6"></div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<table id=""
												class="table" 
												style="text-align: center; width: 100%;" role="grid">
												<thead>
													<tr role="row">
														<th class="" tabindex="1" rowspan="1" colspan="1"
															style="width: 59px;">신고수</th>
															
														<th class="" tabindex="0" rowspan="1" colspan="1" aria-label="Quote#"
															style="width: 70px;">이름</th>
															
														<th class="" tabindex="0" rowspan="1" colspan="1"
															style="width: 58px;">닉네임</th>

														<th class="" tabindex="0" rowspan="1" colspan="1"
					                                        style="width: 59px;">아이디</th>

													</tr>
												</thead>
												<tbody id="lbsBody">
													<%-- <c:forEach var="lbrbbsList" items="${lbrbbsList}" 
                                    varStatus="stat">
                                             <tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=${lbrtyBbscttList.lbrtyBbscttNo}'" style="cursor:hand">
                                                 <td>${lbrbbsList.count}</td>
                                             </tr>
                                    </c:forEach> --%>
												</tbody>
											</table>
										</div>
									</div>

									<div id="divPaging" style="display: flex; flex-wrap: wrap;">

									</div>

									<div class="row">
										<div class="col-sm-12 col-md-5"></div>
										<div class="col-sm-12 col-md-7"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
	<!-- ///// 모달 시작 /// -->
	<div class="modal fade show" id="modal-xl"
		style="display: none; padding-right: 17px;" aria-modal="true"
		role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title"><b>🚨 프로 신고 상세보기</b></h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body" id="modal_body">
					<div class="left" id="modal_left">
					</div>
					<div class="right" id="modal_right" style="background-color:#f5f7ff; padding:20px; border-radius:20px;">
						<p><input type="radio" id="jj01" name="typesOfSanctions" value="7"/>
						<label for="jj01">7일 정지</label></p>
						<p><input type="radio" id="jj02" name="typesOfSanctions" value="15" />
						<label for="jj02">15일 정지</label></p>
						<p><input type="radio" id="jj03" name="typesOfSanctions" value="999999" />
						<label for="jj03">영구 정지</label></p>
						<button style="float: right;" type="button" class="btn btn-primary" id="declSetBtn">제재
						처리</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="clsBtn" data-dismiss="modal">닫기</button>
				</div>
			</div>

		</div>

	</div>
	<!-- 모달창 ㄲ<ㅌ -->
</body>
</html>
<c:if test="${memSession == null && proSession == null && admSession == null}">
    <script>
        function login() {
        	$("body").html("");
            Swal.fire({
                title: '로그인 후 이용해주세요',
                icon: 'warning',
                confirmButtonColor: '#4B49AC',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
            }).then((result) => {
                if (result.isConfirmed) {
                    history.back();
                }
            });
        }
        $(document).ready(function() {
            login(); // 함수 호출
        });
    </script>
</c:if>