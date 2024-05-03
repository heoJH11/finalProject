<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<!DOCTYPE html>
<html>
<head>
<title></title>
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

#modifyTitle,#proflPhoto {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}

label {
    font-family: 'GmarketSansMedium';
    font-size: 17px !important;
}

input,p {
	font-family: 'GmarketSansMedium';
}
</style>

<script>
		
$(function(){
	
    /* 양식 자동입력 */
    $("#autobtn").on("click", function(event){
    	 event.preventDefault(); // 기본 제출 동작 막기
    	 var info1=`⭐반려동물 생일 ! 멍냥푸름케이크에서 주문해보세요~! ⭐`
    	 var info2=`09:00~21:00`
    	 var info3=`⭐멍냥푸름케이크 많이 찾아주세요!⭐
🎂케이크 주문 양식 🎂

1. 필요한 날짜, 픽업 시간 - 주문일, 픽업일 제외하고 3일 전 예약하시면 10% 할인됩니다

2. 주문자 성함, 연락처

3. 케이크 사이즈, 디자인, 문구

(직접 그림을 그리실 경우 정확한 색상을 표시해주시면 더 원할하게 상담 가능합니다😁)

4. 초 여부 (매장에 구비되어 있는 귀여운 초들도 있어요)

✔매장에서 직접 구워서 만든 케이크 시트를 사용합니다

✔기본적으로 생크림으로 작업하고 있구요 우유 크림으로 그림 작업을 하고 있습니다 !
버터 케이크에 비해 훨씬 촉촉하고 부드러워요😀`
    		 
    	 var info4=`⭐멍냥푸름케이크 많이 찾아주세요!⭐
1. 생크림 케이크
베이킹을 처음 접하시거나 평소에 만들고 싶은 분들,
집에서 만들 수 있는 환경이 안되셔서 시도가 어려우셨던 분들,
기본기를 배우고 싶으신 분들에게 추천드립니다.
시트부터 아이싱 데코레이션 위주로 연습을 한뒤 실습에 들어갑니다.

2. 레터링 케이크
1호 사이즈 지름(약14cm) 기준으로 레터링 케이크를 제작합니다.
기초적인 스패츌러 잡는 방법, 아이싱 하는 방법, 조색연습, 다양한 레터링 연습후 실습에 들어갑니다.
특별한 기념일이나, 직접 만들어서 선물해보는 좋은 클래스입니다.
또는 레터링 케이크를 배우고 싶으셨지만 창업클래스나 가격적으로 부담이 되는 분들에게 추천드립니다. 레시피는 같이 제공해드립니다.

3. 도시락 케이크
▶체험반 (2시간)
일반인분들의 클래스 문의가 많아 오픈이벤트가로 개설했습니다.
아이싱이 되어있는 도시락케이크 위에 원하시는 데코레이션을 하는 체험반입니다!
베이킹에 초보이신분들도 쉽게 만드실 수 있으니 문의주세요 :D

▶베이직반 (3~4시간)
미니 사이즈로 1인, 커플, 친구들과 함께 케이크 위에 다양한 데코를 하실 수 있습니다.
레터링 케이크에 관심이 있으시거나, 정규반이나 창업반을 듣기 전에 입문으로 추천드립니다.
기초적인 스패츌러 잡는 방법, 아이싱 하는 방법, 조색연습, 다양한 레터링 연습후 실습에 들어갑니다.`
    	 
        $("#proProflOnLiIntrcn").val(info1);
        $("#proProflContactPosblTime").val(info2);
        $("#proProflReqForm").val(info3);
        $("#proProflHist").val(info4);
        
    });
	
    console.log("지역코드를 이름으로");
    var bcityCode = $("#bcityCode").val();
    var brtcCode = $("#brtcCode").val();
    console.log("bcityCode : " + bcityCode + ", brtcCode : " + brtcCode);
    
    // AJAX 호출 후 지역 코드를 이름으로 변경
    $.ajax({
        url: "/proProfl/getNm",
        data: { "bcityCode": bcityCode, "brtcCode": brtcCode },
        type: "post",
        dataType: "json",
        success: function(data) {
            console.log("bcityNm : " + data.bcityNm +", brtcNm : " + data.brtcNm);
            $("#bcityCode").text(data.bcityNm); 
            $("#brtcCode").text(data.brtcNm); // 옵션의 텍스트 변경
        	
        },
    });

    // #bcityNm의 값이 변경될 때마다 호출됨
    $("#bcityNm").change(function(){
        var selecBcity = $(this).val(); // 선택된 광역시 이름
        var brtcOptions = ""; // 시/구 옵션을 저장할 변수
        
        // AJAX 호출 후 시/구 목록 업데이트
        $.ajax({
            type: "GET",
            url: "/proProfl/brtcList",
            data: { bcityNm: selecBcity },
            success: function(data){
                $.each(data, function(index, list){
                    brtcOptions += '<option value="' + list.brtcNm + '">' + list.brtcNm + '</option>';
                });
                $("#brtcNm").html('<option selected>지역(시/구)</option>' + brtcOptions);
            },
            error: function(xhr, status, error) {
                console.log("Error: " + error);
            }
        });
    });
    
    
    /* 제출 폼 막기 */
    $("#frm").submit(function(event){
        var bcityNm = $("#bcityCode").text();
		var brtcNm = $("#brtcNm").val();
		var proProflOnLiIntrcn = $("#proProflOnLiIntrcn").val();
		var proProflReqForm = $("#proProflReqForm").val();
		var proProflHist = $("#proProflHist").val();
		var proProflContactPosblTime = $("#proProflContactPosblTime").val();
        
        console.log("bcityNmㄴㄴ" , bcityNm);
        console.log("brtcNmㄴㄴ" , brtcNm);
        
        if (!bcityNm || bcityNm === "") {
            Swal.fire({
                title: "지역을 선택해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        if (!brtcNm || brtcNm === "" || brtcNm === "지역(시/구)") {
            Swal.fire({
                title: "시/구를 선택해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        if (!proProflOnLiIntrcn || proProflOnLiIntrcn === ""){
            Swal.fire({
                title: "한줄소개를 입력해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        if (!proProflReqForm || proProflReqForm === ""){
            Swal.fire({
                title: "요청서 양식을 입력해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        if (!proProflHist || proProflHist === ""){
            Swal.fire({
                title: "서비스 상세설명을 입력해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        if (!proProflContactPosblTime || proProflContactPosblTime === ""){
            Swal.fire({
                title: "연락가능시간을 입력해주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
		event.preventDefault(); // 폼 제출 막기
        
        Swal.fire({
            title: "수정이 완료되었습니다",
            confirmButtonText: "확인",
            icon: 'success', 
            customClass: {
                title: 'swal-title'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                $("#frm").off("submit").submit(); // 확인 버튼을 누르면 폼 제출
            }
        });

});
});



</script>
<br><br>
<!-- 제목 -->
<div style="position: absolute; top: 0; left: 0; width: 100%;" id="title">
    <img src="../resources/images/팻말1.png" id="balloon" style=" opacity: 0.5; width: 500px; height:auto; margin:-40px 0 0 700px;">
    <br><br>
    <h2 id="modifyTitle" style="margin:135px 0 0 830px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 프로필 수정</h2>
</div >
<%-- <p>${proProflVO}</p> --%>

<c:if test="${memSession == null && proSession != null}">
<form id="frm" name="frm" action="/proProfl/modifyProfl?proId=${proProflVO.proId}" method="get" >
	<div class="mb-3" style="margin: 150px 150px 0 150px;"> 
		<div class="form-group" id="proflPhoto" style="margin-left:750px;">
			<c:if test="${proProflVO.proProflPhoto==null}">
				<img src="/images/2024/profile.jpg" alt="profile" style="width:300px; height:300px; border-radius: 70%;">
			</c:if>
			<c:if test="${proProflVO.proProflPhoto!=null}">
				<img src="${proProflVO.proProflPhoto}" alt="profile" style="width:300px; height:300px; border-radius: 70%;">
			</c:if>
		</div>
	    <div class="form-group">
	        <label for="proId">👩‍💼 프로 아이디</label>
	        <input type="text" name="proId" id="proId" value="${proProflVO.proId}" class="form-control" readonly style="width:200px;"/>
	    </div>
      <div class="form-group" >
         <label for="proProflOnLiIntrcn">✔ 한줄소개</label>
         <input type="text" name="proProflOnLiIntrcn" id ="proProflOnLiIntrcn" value="${proProflVO.proProflOnLiIntrcn}" class="form-control" style="width:600px; justify-content: center;"/>
      </div>
      <div class="form-group">
          <label for="proProflContactPosblTime">🕐 연락 가능 시간</label>
          <input type="text" name="proProflContactPosblTime" id="proProflContactPosblTime" value="${proProflVO.proProflContactPosblTime}" class="form-control" style="width:200px;"/>
      </div>
	<div style="display: flex; flex-wrap: wrap;">
		<div class="form-group">
			<label for="bcityNm">✔ 지역(광역시)</label>
			   <select id="bcityNm" name="bcityNm" class="form-control" style="width:200px; font-family: 'GmarketSansMedium';">
			      <option selected id="bcityCode">${proProflVO.bcityCode}</option>
			      <c:forEach items="${bcityVOList}" var="bcityVO">
			         <option><c:out value="${bcityVO.bcityNm}"/></option>
			      </c:forEach>
			   </select>
		</div> 
		<div class="form-group">
			<label for="brtcNm" style="margin-left:15px;">✔ 지역(시/구)</label>
				<select id="brtcNm" name="brtcNm" class="form-control" style="width:200px; margin-left:15px; font-family: 'GmarketSansMedium';">
				    <option id="brtcCode" selected>${proProflVO.brtcCode}</option>
				</select>
		</div>
	</div>
		<p style="margin:-10px 0 30px 0 ; color:#adadad;">📌 상세 주소는 마이페이지에서 수정하세요!<p>
	
      <div class="row">
      <div class="form-group">
         <label for="proProflReqForm">📃 요청서 양식</label>
        <textarea name="proProflReqForm" id="proProflReqForm" class="form-control" style="font-family: 'GmarketSansMedium'; width:500px; height:400px; overflow: auto;">${proProflVO.proProflReqForm}</textarea>
      </div>
      <div class="form-group">
         <label for="proProflHist" style="margin-left:15px;">💬 서비스 상세설명</label>
		<textarea  rows="2" cols="20" wrap="hard" name="proProflHist" id="proProflHist" class="form-control" style="font-family: 'GmarketSansMedium'; width:500px; height:400px; margin-left:15px; overflow: auto;">${proProflVO.proProflHist}</textarea>
      </div> 
      </div>
      <div class="form-group" style="float:right; margin-right:60px;">
	      <button id="autobtn" style="border:none; background:none;">
	      	<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
	      </button>
         <button id="submitBtn" class="btn btn-outline-primary btn-fw" style="font-family: 'GmarketSansMedium';">수정하기</button>
         <button onclick="history.back()" class="btn btn-outline-secondary btn-fw" style="font-family: 'GmarketSansMedium';">뒤로가기</button>
      </div>
</div>

</form>
</c:if>

