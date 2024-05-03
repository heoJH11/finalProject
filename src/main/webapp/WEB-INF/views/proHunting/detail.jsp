<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="/resources/js/jquery.min.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
	font-family: 'GmarketSansMedium';
}
.icon-data-list li p {
	word-wrap: break-word;
}

#answerProId:hover {
  transform: scale(1.2);
  transition-duration: 0.5s;

}
</style>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<div class="container-fluid">
						<h2 class="text-center my-5" style="font-family: GMarketSansMedium;">${proJoBbscttVOList[0].proJoBbscttSj}</h2>
						<div style="margin-left: 76%;">
							<p style="font-family: GMarketSansLight; display: inline; margin-right: 15px;">작성자</p>
							<p style="display: inline;">${proJoBbscttVOList[0].mberVOList[0].mberNcnm}</p>
							<br />
							<p style="font-family: GMarketSansLight; display: inline;">작성일시</p>
							<p style="display: inline;"><fmt:formatDate value="${proJoBbscttVOList[0].proJoBbscttWrDt}" pattern="yyyy.MM.dd HH:mm:ss"/></p>
						</div>
						<hr>
					</div>
					<div class="container-fluid mt-5 w-100">
						<h5 class="mb-5" style="padding-left: 20px;">${proJoBbscttVOList[0].proJoBbscttCn}</h5>
						<hr>
					</div>
					<div class="container-fluid w-100"
						style="display: flex; flex-wrap: wrap; float: right;">
						<button type="button" class="btn btn-outline-primary"
							id="modifyBtn" style="display: none; margin-right: 5px;">수정</button>
						<button type="button" class="btn btn-outline-secondary"
							id="backBtn">목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="content-wrapper"
	style="padding-top: 0; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<p class="card-title">댓글 목록</p>
					<!-- 프로 댓글 작성란 -->
					<div id="inputNewAnswer" style="display: flex; flex-wrap: wrap;">
						<textarea class="form-control" rows="1" wrap="hard" id="txtAreaAnswer"
							style="display:; width: 95%; margin-right: 8px;"></textarea>
						<button type="button" class="btn btn-outline-primary btn-sm"
							id="registerChkBtn">
							<i class="mdi mdi-near-me"></i>
						</button>
					</div>
					<hr />
					<!-- 회원은 댓글 작성하지 못한다는 안내 문구 -->
					<c:if test="${memSession != null || memSession != '' }">
						<p class="text-center">댓글은 프로만 작성할 수 있습니다.</p>
					</c:if>
					
					<!-- 프로 댓글 목록  -->
					<ul class="icon-data-list">
						<c:if
							test="${proJoBbscttVOList[0].proJoBbscttAnswerVOList[0].proJoAnswerNo > 0 }">
							<c:forEach var="proJoAnswerVO"
								items="${proJoBbscttVOList[0].proJoBbscttAnswerVOList}">
								<li>
									<div class="d-flex">
										<img src="${proJoAnswerVO.proProflPhoto}">
										<div style="margin-left: 9px;">
											<p class=" mb-1" style="margin-right: 20px; font-family: GMarketSansLight" id="answerProId${proJoAnswerVO.proId}"
												onclick="location.href='/proProfl/detail?proId=${proJoAnswerVO.proId}'">${proJoAnswerVO.proNcnm}</p>
											<p class="mb-0" style="font-family: 'GMarketSansLight';">${proJoAnswerVO.proJoAnswerCn}</p>
											<small><fmt:formatDate
													value="${proJoAnswerVO.proJoAnswerWrDt}"
													pattern="yyyy.MM.dd HH:mm:ss" /></small>
										</div>
										<div class="dropdown">
											<button type="button" id="dropdownMenuIconButton7"
												data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false" style="border: 0; background: none;">⋮</button>
											<div class="dropdown-menu"
												aria-labelledby="dropdownMenuIconButton7"">
												<c:if test="${proJoAnswerVO.proId == proSession.userId}">
													<p class="dropdown-item" onclick="answerModifyBtn()">수정</p> 
													<p class="dropdown-item" onclick="answerDeleteBtn()">삭제</p> 
												</c:if>
													<a class="dropdown-item" href="#">신고</a>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	var memId = "${memSession.userId}";
	var proId = "${proSession.userId}";
	console.log("memId : ", memId);
	console.log("proId : ", proId);
	var writer = "${proJoBbscttVOList[0].mberId}";
	console.log("기본 정보 : ", writer);

	// 수정 
	if (memId == writer) {
		$("#modifyBtn").css("display", "block");
	}

	$("#backBtn").on("click", function() {
		location.href="/proHunting/list";
	});
	
	//프로 댓글 등록 가능 여부 확인
	var proSessionNcnm = "${proSession.userNcnm}";
	var	chkNcnm = $("#answerProId"+proId).text();
	console.log("프로 세션 닉네임 : ", proSessionNcnm);
	console.log("체크할 닉네임 : ", chkNcnm);
	if(proSessionNcnm == chkNcnm){
		$("#inputNewAnswer").css("display", "none");
	}
	
$(function(){
	// 댓글 등록 스윗알랏
	$("#registerChkBtn").on("click", function(){
		Swal.fire({
	        title: "댓글을 등록하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonText: "등록 완료"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            Swal.fire({
	                title: "등록 완료!",
	                icon: "success"
	            }).then(() => {
	                registerAnswer();
	            });
	        }
	    });
	});
	
	function registerAnswer(){
		var proJoBbscttNo = "${param.proJoBbscttNo}";
		var proJoAnswerCn = $("#txtAreaAnswer").val();
		var proId = "${proSession.userId}"
		console.log("댓글 게시글 번호 : " , proJoBbscttNo);
		console.log("댓글 내용 : " , proJoAnswerCn);
		
		var data = {"proJoBbscttNo" : proJoBbscttNo,
					"proJoAnswerCn" : proJoAnswerCn,
					"proId" : proId
			}
		
		$.ajax({
			url : "/proHunting/proAnswerRegister",
			data : JSON.stringify(data),
			contentType : "application/json; charset=UTF-8",
			dataType : "json",
			type : "post",
			success : function(res){
				console.log(res);
				if(res == "1"){
					location.reload();
				}
			}
		});
	}
});
function answerDeleteBtn(){
	var proJoBbscttNo = "${param.proJoBbscttNo}";
	var proId = "${proSession.userId}";
	
	var data = {"proJoBbscttNo" : proJoBbscttNo,
			"proId" : proId
	}
	
	Swal.fire({
	    title: "댓글을 삭제하시겠습니까?",
	    icon: "question",
	    showCancelButton: true,
	    confirmButtonText: "확인"
	}).then((result) => {
	    if (result.isConfirmed) {
	        $.ajax({
	            type: "post",
	            url: "/proHunting/delProAnswer", // 요청을 보낼 엔드포인트를 지정합니다.
	            dataType : "json",
	            contentType : "application/json; charset=UTF-8",
	            data: JSON.stringify(data),
	            success: function(res) {
	                // 성공적으로 요청이 완료된 후에 실행되는 코드입니다.
	                Swal.fire({
	                    title: "삭제 완료!",
	                    icon: "success"
	                }).then(() => {
	                    location.reload();
	                });
	            }
	        });
	    }
	});
}
</script>