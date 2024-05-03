<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>



<head>
<title>프로 프로필</title>
</head>
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


#myWizard{
    position: absolute;
    z-index: 2; /* 풍선 이미지 위에 나타나도록 설정 */
}
</style>
<script>
$(function(){
	
	/* 서비스 상세설명 자동입력 */
    $("#autobtn3").on("click", function(event){
    	 event.preventDefault(); // 기본 제출 동작 막기
    	 var info=`1. 생크림 케이크
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
기초적인 스패츌러 잡는 방법, 아이싱 하는 방법, 조색연습, 다양한 레터링 연습후 실습에 들어갑니다.`;
     		
        $("#proProflHist").val(info);
    });
    
    /* 양식 자동입력 */
    $("#autobtn2").on("click", function(event){
    	 event.preventDefault(); // 기본 제출 동작 막기
    	 var info=`🎂케이크 주문 양식 🎂

1. 필요한 날짜, 픽업 시간 - 주문일, 픽업일 제외하고 3일 전 예약하시면 10% 할인됩니다

2. 주문자 성함, 연락처

3. 케이크 사이즈, 디자인, 문구

(직접 그림을 그리실 경우 정확한 색상을 표시해주시면 더 원할하게 상담 가능합니다😁)

4. 초 여부 (매장에 구비되어 있는 귀여운 초들도 있어요)

✔매장에서 직접 구워서 만든 케이크 시트를 사용합니다

✔기본적으로 생크림으로 작업하고 있구요 우유 크림으로 그림 작업을 하고 있습니다 !
버터 케이크에 비해 훨씬 촉촉하고 부드러워요😀`;
    	 
        $("#proProflReqForm").val(info);
    });
    
    /* 한줄소개 자동입력 */
    $("#autobtn").on("click", function(event){
    	 event.preventDefault(); // 기본 제출 동작 막기
        $("#proProflOnLiIntrcn").val("레터링 케이크, 원데이 클래스 문의 주세요🥰 우유생크림/크림치즈/무염버터/식약처 인증색소 등 좋은 재료를 사용하여 맛있는 케이크를 만듭니다.");
        $("#proProflContactPosblTime").val("9:00~20:00");
    });
	
    $("#bcityNm").change(function(){
        var selecBcity = $(this).val(); // 선택된 광역시
        var brtcOptions = ""; // 시/구 옵션을 저장할 변수
        
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


	 $(".btnPrev").on("click", function(event){
	        event.preventDefault(); // 기본 제출 동작 막기
	    });
	
    $(".btnNext").on("click", function(event){
        event.preventDefault(); // 기본 제출 동작 막기
    });
    
    $("#frm").submit(function(event){
        
        var proProflOnLiIntrcn = $("#proProflOnLiIntrcn").val();
        if (!proProflOnLiIntrcn || proProflOnLiIntrcn.trim() == "") {
            Swal.fire({
                title: "프로필 한줄 소개를 적어주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        var proProflContactPosblTime = $("#proProflContactPosblTime").val();
        if(!proProflContactPosblTime || proProflContactPosblTime.trim()==""){
            Swal.fire({
                title: "연락 가능 시간을 적어주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        var proProflReqForm = $("#proProflReqForm").val();
        if(!proProflReqForm || proProflReqForm.trim()==""){
            Swal.fire({
                title: "요청시 양식을 적어주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        var proProflHist = $("#proProflHist").val();
        if(!proProflHist || proProflHist.trim()==""){
            Swal.fire({
                title: "서비스 상세 설명을 적어주세요",
                confirmButtonText: "확인",
                icon: 'warning',
                customClass: {
                    title: 'swal-title'
                }
            });
            return false;
        }
        
        var brtcNm = $("#brtcNm").val();
        if (!brtcNm || brtcNm == "지역(시/구)") {
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
    });
});
</script>
<!-- 
요청URI : /createPost
요청파라미터 : {PRO_ID=protest100, PRO_PROFL_ON_LI_INTRCN=반려동물 산책/돌봄 자신있습니다, PRO_PROFL_CONTACT_POSBL_TIME=10:00 ~ 21:00, 
              PRO_PROFL_REQ_FORM=반려동물 이름:  종류: , PRO_PROFL_HIST=반려견 산책대회 우승자, BCITY_CODE=25, BRTC_CODE=25030}
요청방식 : post
 -->
<input type="hidden" id="sessionId" value="${proSession.userId}" />
<head>
<title>프로 프로필 작성</title>
<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<style>
  body { background-color: #fafafa; }
  .container { margin: 0px 150px auto; max-width: 960px; }
</style>
</head>

<form id="frm" name="frm" action="/proProfl/createPost" method="post" style="margin-bottom:750px;">
    	<!-- 제목 -->
      	<div>
			<img alt="프로프로필" src="../resources/images/프로.png" style="width:100px; height:auto; margin:0 0 20px 610px;">
			<h2 id="proflTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 프로필 작성</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
		</div>
  <div class="container">

	<div id="myWizard" style="margin:50px 0 0 50px;">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" 
				aria-selected="true" style="font-family: 'GmarketSansMedium';">기본정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab"
			    aria-controls="profile" aria-selected="false" style="font-family: 'GmarketSansMedium';">프로필 정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab"
				aria-controls="contact" aria-selected="false" style="font-family: 'GmarketSansMedium';">요청서 양식</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact2" role="tab"
				aria-controls="contact" aria-selected="false" style="font-family: 'GmarketSansMedium';">서비스 상세설명</a>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent" style="width:930px;">
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab" style="margin-top:40px;">
				<div style="display: flex; flex-wrap: wrap; margin-left:100px;">
					<div class="form-group">
						<c:if test="${vProUsersVO.proProflPhoto == null}">
							<img src="/images/2024/profile.jpg" class="img-lg rounded-circle mb-3" alt="profile" style="width:200px; height:200px; border-radius: 70%;" />
						</c:if>
						<c:if test="${vProUsersVO.proProflPhoto != null}">
							<img src="${vProUsersVO.proProflPhoto}" class="img-lg rounded-circle mb-3" alt="profile" style="width:200px; height:200px; border-radius: 70%;">
						</c:if>
					</div>
					<hr style="border: none; border-left: 1px solid #CED4DA; height: 200px; margin-left:100px;">
					<div class="form-group" style="margin: 20px 0 0 100px;">
						<label for="proId" style="font-family: 'GmarketSansMedium';">😉아이디</label><br>
						<input id="proId" name="proId" value="${proSession.userId}" style=" font-family: 'GmarketSansMedium'; border:none; font-size:20px;" readonly/>
						<div class="form-group" style="margin-top:20px;">
							<label style="font-family: 'GmarketSansMedium';">⭐닉네임</label>
							<h4 style="margin-top:10px; font-family: 'GmarketSansMedium';"><b>${vProUsersVO.userNcnm}</b></h4>
							<p style="border: 1px solid #CED4DA; border-radius: 20px; display: inline-block; margin-top:20px; font-family: 'GmarketSansMedium';">&nbsp;&nbsp;${proBun}&nbsp;&nbsp;</p>
						</div>
					</div>
	            </div>
			</div>
			<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab" style="margin-left:20px;">
				<div class="form-group">
				   <label for="proProflOnLiIntrcn" style="font-family: 'GmarketSansMedium';">⭐한줄소개</label>
				   <input type="text" id="proProflOnLiIntrcn" name="proProflOnLiIntrcn" class="form-control" style="font-family: 'GmarketSansMedium'; width:600px; justify-content: center;"/>
				</div>
				<div class="form-group">
				   <label for="proProflContactPosblTime" style="font-family: 'GmarketSansMedium';">⭐연락 가능 시간</label>
				   <input type="text" name="proProflContactPosblTime" id="proProflContactPosblTime" class="form-control" placeholder="예) 9:00 ~ 10:00" style="width:200px; font-family: 'GmarketSansMedium';"/>
				</div>
	            <div style="display: flex; flex-wrap: wrap;">
					<div class="form-group">
						<label for="bcityNm" style="font-family: 'GmarketSansMedium';">⭐지역(광역시)</label>
							<select id="bcityNm" name="bcityNm" class="form-control" style="font-family: 'GmarketSansMedium';">
								<option selected>지역(광역시)</option>
								<c:forEach items="${bcityVOList}" var="bcityVO">
								<option><c:out value="${bcityVO.bcityNm}"/></option>
								</c:forEach>
							</select>
						</div> 
					<div class="form-group">
					    <label for="brtcNm" style="margin-left:15px; font-family: 'GmarketSansMedium';">⭐지역(시/구)</label>
						<select id="brtcNm" name="brtcNm" class="form-control" style="width:200px; margin-left:15px; font-family: 'GmarketSansMedium';">
						    <option selected>지역(시/구)</option>
						</select>
					</div>
	            </div>
	            <button id="autobtn" style="border:none; background:none; margin-left: 800px;">
	            	<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
	            </button>
			</div>
			<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab" style="margin-left:20px;">
				<div style="display: flex; flex-wrap: wrap;">
					<div class="form-group">
						<h3 style="font-family: 'GmarketSansMedium';">⭐요청서 양식</h3>
						<br>
					    <textarea wrap="hard" id="proProflReqForm" name="proProflReqForm" class="form-control" style="width:500px; height:350px; overflow: auto; font-family: 'GmarketSansMedium';"></textarea>
					</div>
					<div class="form-group">
						<img src="../resources/images/요청서 양식.png" style="width:110px; height:110px; margin: 100px 0 0 130px;" />
						<h6 style="color:#b1b1ae; text-align:center; margin: 30px 0 0 85px; line-height:1.5; font-family: 'GmarketSansMedium';">고객이 요청을 보낼때<br> 받고싶은 정보를 입력해주세요!<br> 요청을 받을때 편하게~<br> 내가 받고 싶은 정보만 쏙쏙! </h6>
					</div>
				</div>
				<button id="autobtn2" style="border:none; background:none; margin-left: 800px;">
	            	<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
	            </button>
			</div>
			<div class="tab-pane fade" id="contact2" role="tabpanel" aria-labelledby="contact2-tab" style="margin-left:20px;">
				<div style="display: flex; flex-wrap: wrap;">
					<div class="form-group">
					 	<h3 style="font-family: 'GmarketSansMedium';">⭐서비스 상세설명</h3>
					 	<br>
					    <textarea wrap="hard" id="proProflHist" name="proProflHist" class="form-control" style="width:500px; height:350px; overflow: auto; font-family: 'GmarketSansMedium';"></textarea>
					</div> 
					<div class="form-group">
						<img src="../resources/images/이력서.png" style="width:110px; height:110px; margin: 100px 0 0 150px;" />
						<h6 style="color:#b1b1ae; text-align:center; margin: 30px 0 0 100px; line-height:1.5; font-family: 'GmarketSansMedium';">고객에게 프로님이 제공하는<br>서비스의 설명을<br>자유롭게 입력해주세요 ! </h6>
					</div>
				</div>
				<button id="autobtn3" style="border:none; background:none; margin-left: 800px;">
	            	<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
	            </button>
			</div>
		</div>
		<div class="row" style="margin:20px 5px 0 0;">
		    <button class="btn btnPrev btn-primary mr-1 ml-auto" style="font-family: 'GmarketSansMedium';">이전</button>
		    <button class="btn btnNext btn-primary" style="font-family: 'GmarketSansMedium';">다음</button>
		</div>
	</div>
  </div>
</form>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="/resources/js/jquery-bootstrap-tab-wizard.min.js"></script>
<script>
$('#myWizard').TabWizard({
    nextButtonClass: '.btnNext',
    previousButtonClass: '.btnPrev',
    onFinish: function () {
        // 폼 제출
        $('#frm').submit();
    }
});
</script>


