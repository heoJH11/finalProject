<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
<title></title>
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


.icon-data-list li p {
	word-wrap: break-word;
}

#answerProId:hover {
  transform: scale(1.2);
  transition-duration: 0.5s;

}  
.profileImage{
	width : 30px;
	height : 30px;
	border-radius: 15px;	
	margin-right : 10px;

	
}   

   
    
</style>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
    $("#backBtn").on("click", function() {
        location.href="/proCprtnBbsctt/list";
    });
});


</script>

</head>
<%-- <p>${proCprtnBbscttVO}</p> --%>

<%-- <p>${proCprtnBbscttVO2}</p> --%>

<body>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<div class="container-fluid">
						<h2 class="text-center my-5" style="font-family: GMarketSansMedium;">${proCprtnBbscttVO.proCprtnBbscttSj}</h2>
						<div style="margin-left: 76%;">
							<p style="font-family: GmarketSansMedium; display: inline; margin-right: 15px;">작성자</p>
							<p style="display: inline;">
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${empty proCprtnBbscttVO.proProflPhoto}"> --%>
<!-- 									<img class="profileImage" src="/images/2024/profile.jpg"/> -->
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<%-- 									<img class="profileImage" src="${proCprtnBbscttVO.proProflPhoto}"/>							 --%>
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
							${proCprtnBbscttVO.userNcnm}</p>
							<br />
							<p style="font-family: GmarketSansMedium; display: inline;">작성일시</p>
							<p style="font-family: GmarketSansMedium;"><fmt:formatDate value="${proCprtnBbscttVO.proCprtnBbscttWrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></p>
						</div>
						
						<hr>
					</div>
					<div class="container-fluid mt-5 w-100">
						<h5 class="mb-5" style="font-family: 'GmarketSansMedium'; padding-left: 20px;">${proCprtnBbscttVO.proCprtnBbscttCn}</h5>
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
					<hr />
					<p class="text-center">댓글은 프로만 작성할 수 있습니다.</p>
<!-- 					<div id="inputNewAnswer" style="display: flex; flex-wrap: wrap;"> -->
<!-- 						<textarea class="form-control" rows="1" wrap="hard" -->
<!-- 							style="display:; width: 95%; margin-right: 8px;"></textarea> -->
<!-- 						<button type="button" class="btn btn-outline-primary btn-sm" -->
<!-- 							id="registerChkBtn"> -->
<!-- 							<i class="mdi mdi-near-me"></i> -->
<!-- 						</button> -->
<!-- 					</div> -->
					
					
					
					
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
											<p class="mb-0" style="font-family: 'seolleimcool-SemiBold';">${proJoAnswerVO.proJoAnswerCn}</p>
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
													<p class="dropdown-item" onclick="answerModifyBtn">수정</p> 
													<p class="dropdown-item" onclick="answerDeleteBtn">삭제</p> 
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

	

</body>


</html>