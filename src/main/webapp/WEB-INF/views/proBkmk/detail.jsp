<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/js/jquery.min.js"></script>

<head>
<title>즐겨찾은 프로</title>
</head>
<style>
body { background-color: #f5f7ff; }

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

/* 제목 */
#balloon {
    position: absolute;
    margin-top: -90px;
    top: 0;
    left: 0;
    z-index: 0;
}

#proBkmk {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}
</style>

<script>
$(function(){
    $(document).on("click", ".proBkProfl", function() {
        let proId = $(this).closest("li").find("#proBkId").val();
        console.log("proId : " + proId);
        window.location.href = "/proProfl/detail?proId=" + proId;
    });
});
</script>
  	<!-- 제목 -->
  	
  		<div>
			<img alt="즐겨찾기" src="../resources/images/마커4.png" style="width:100px; height:auto; margin:0 0 20px 630px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">내가 즐겨찾은 프로</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
    
<div style="display: flex; flex-wrap: wrap; align-items: center; justify-content: center; margin-top:50px;">
		<h3 style="margin: 30px 0 0 10px; font-family: 'seolleimcool-SemiBold'; color:#a7a7a7">✨ 내가 즐겨찾은 프로를 쉽게 확인하세요!</h3>
</div>
<%-- <p>${proBkmkVO};</p> --%>
<div style="margin:40px 200px 300px 200px; text-align:center;">
	<ul>
		<c:forEach items="${proBkmkVO}" var="proBkmk" varStatus="status">
		    <c:set var="proId" value="${proBkmk.proId}" />
		    <c:set var="spclty" value="${spcltyCL[status.index]}" /> <!-- 프로 전문분야 : 현재 인덱스에 해당하는 특성 코드 가져오기 -->
		    <li style="list-style-type: none; display: inline-block; margin: 10px 10px 0 0;">
		        <div>
		            <c:if test="${proBkmk.bkmkVOList[0].proProflPhoto==null}">
		            	 <img class="proBkProfl" src="/images/2024/profile.jpg" style="width:150px; height:150px; border-radius: 20%">   
		            </c:if>
		            <c:if test="${proBkmk.bkmkVOList[0].proProflPhoto!=null}">
		            <img class="proBkProfl" src="${proBkmk.bkmkVOList[0].proProflPhoto}" style="width:150px; height:150px; border-radius: 20%">   
		            </c:if>
		            <input type="hidden" id="proBkId" value="${proId}" />
		        </div>
		        <div style="margin-top:5px;">
		            <span style="font-family: 'GmarketSansMedium';">${proId}</span>
		            <br>
		            <span style="font-family: 'GmarketSansMedium';">${proBkmk.userBkVOList[0].userNcnm}</span>
		            <br>
		            <p style="border: 1px solid #CED4DA; border-radius: 20px; display: inline-block; font-family: 'GmarketSansMedium';">&nbsp;&nbsp;${spclty}&nbsp;&nbsp;</p>
		        </div>
		    </li>
		</c:forEach>
	</ul>
</div>

