<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.star_rating {
  width: 100%; 
  box-sizing: border-box; 
  display: inline-flex; 
  float: left;
  flex-direction: row; 
  justify-content: flex-start;
}
.star_rating .star {
  width: 25px; 
  height: 25px; 
  margin-right: 10px;
  display: inline-block; 
  background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png') no-repeat; 
  background-size: 100%; 
  box-sizing: border-box; 
}
.star_rating .star.on {
  width: 25px; 
  height: 25px;
  margin-right: 10px;
  display: inline-block; 
  background: url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png') no-repeat;
  background-size: 100%; 
  box-sizing: border-box; 
}

.star_box {
  width: 400px;
  box-sizing: border-box;
  display: inline-block;
  margin: 15px 0;
  background: #F3F4F8;
  border: 0;
  border-radius: 10px;
  height: 100px;
  resize: none;
  padding: 15px;
  font-size: 13px;
  font-family: sans-serif;
}

#reviewModal{
    width: 430px;
    background-color: white;
    padding-right: 17px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    height: auto;
    padding: 15px;
    border-radius: 10px;
}

#modalBackdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 검은색 배경에 투명도 추가 */
    z-index: 999; /* 다른 요소 위에 배치 */
    display: none; 
}
</style>
<!-- reInfo -->
<div class="modal" id="reviewModal">
    <form id="reviewFrm" action="" method="post">
        <h3>Review</h3>
        <p>욕설 및 비방은 관리자에 의해 삭제될 수 있습니다.</p>
        
        <div class ="star_rating">
          <span class="star reScoreVal" value="1"> </span>
          <span class="star reScoreVal" value="2"> </span>
          <span class="star reScoreVal" value="3"> </span>
          <span class="star reScoreVal" value="4"> </span>
          <span class="star reScoreVal" value="5"> </span>
        </div>
        <input type="hidden" id="reScore" name="reScore" value="" />
        
        <select class="form-control" id=reTySel style="height: 30px; margin-top: 43px;">
        </select>
        <input type="hidden" id="reTy" name="reTy" value=""/>        
        
        <div>
            <textarea class="star_box" id="reCn" name="reCn" placeholder="리뷰 내용을 작성해주세요." wrap="hard" maxlength="50" required></textarea>
        	<p id="reCnLength" style="color:gray; margin-top: -20px; margin-left: 4px;">0/50</p>
        </div>
        
        <div style="float: right">
            <button type="button" class="btn btn-inverse-primary btn-sm createBtn" id="createBtn" onclick="chkBtn()">등록</button>
            <button type="button" class="btn btn-inverse-secondary btn-sm" onclick="closeModal()">닫기</button>
        </div>
    </form>
</div>
<div id="modalBackdrop"></div>
<script>
// 별점
$('.star_rating > .star').click(function() {
    $(this).parent().children('span').removeClass('on');
    $(this).addClass('on').prevAll('span').addClass('on');
});

// 리뷰 모달 
function reviewBtn(no) {
    console.log("리뷰 버튼", no);
    $("#reviewModal").show();
    $("#modalBackdrop").show(); // 배경 레이어 표시
    $("#reviewFrm").attr("action", "/srvcRqReview/reCreate?srvcRequstNo="+no);
    $("#createBtn").attr("id", "createBtn"+no),
    
    $.ajax({
    	url:"/srvcRqReview/reInfo",
    	contentType:"application/json;charset=UTF-8",
    	type :"get",
    	dataType : "json",
    	success : function(res){
    		console.log("res", res);
    		str = "";
    		str += "<option>선택해주세요.</option>"
    		$.each(res,function(i, v){
    			str += "<option class='reTyVal' value='"+v.COMMON_CD_DETAIL+"'>"+v.COMMON_CD_DETAIL_NM+"</option>"
    		});
    		
    		$("#reTySel").append(str);
    	}
    });
	// 별점
	$(".reScoreVal").on("click",function(){
		var reScore = $(this).attr("value");
		console.log("reSore", reScore);
		$("#reScore").attr("value", reScore);
		
		$("#createBtn"+no).attr("onclick","chkBtn("+no+")");
	});
}
// 리뷰 유형(공통코드)
$(document).on("click","#reTySel", function(){
	var reTy = $(this).val();
	console.log("리뷰코드 : ", reTy);
	$("#reTy").attr("value", reTy);	
});


$("#reCn").keyup(function(){
	
	let content = $(this).val();
	
	if(content.length == 0 || content == ''){
		$("#reCnLength").text('0/50');
		$("#reCn").css('border','1px solid lightgray');
		$("#reCnLength").css('color','black');
	}else{
		$("#reCnLength").text(content.length + '/50');
		$("#reCn").css('border','1px solid lightgray');
		$("#reCnLength").css('color','black');
	}
	
	if(content.length > 50){
		$("#reCnLength").text(content.length + '/50');
		$("#reeCn").css('border','1px solid red');
		$("#reCnLength").css('color','red');
	}
})

//등록 버튼 클릭 시 실행되는 함수
function chkBtn(no) {
	var reScore = "0";
	reScore = $("#reScore").val();
	console.log("초반 점수 : " + reScore);
	var reTy = "";
	reTy = $("#reTy").val();
	var reCn = $("#reCn").val();
	
	// 별점 필수
	if(reScore == 0){
		alert("별점을 선택해주세요.");
		return
	}
	
    Swal.fire({
        title: "리뷰를 등록하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "완료"
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: "등록 완료!",
                icon: "success"
            }).then(() => {
            	   var data = {
            	    		"reTy" : reTy,
            	    		"reScore" : reScore,
            	    		"srvcRequstNo" : no,
            	    		"reCn" : reCn
            	    }
            	    console.log("ajax로 보낼 data", data);
            	    
            	    $.ajax({
            	    	url : "/srvcRqReview/reCreatePost",
            	    	contentType : "application/json;charset=UTF-8",
            	    	data : JSON.stringify(data),
            	    	type : "post",
            	    	dataType : "json",
            	    	success : function(res){
            	    		console.log("res의 결과값", res);
            	    		if(res = 1){
            	    			$("#reviewBtn"+no).removeAttr("onclick");
            	    			$("#reviewBtn"+no).text("리뷰 완료");
            	    			closeModal();
            	    		}
            	    	}//success 종료
            	    }); // ajax 종료
            	});
        }
    });
}
// 모달 닫기 함수
function closeModal() {
    $('.star_rating > .star').removeClass('on');
    $('#reTy').val('');
    $('.star_box').val('');
    $(".createBtn").attr("id", "createBtn");
    $("#reviewModal").hide();
    $("#modalBackdrop").hide();
}


</script>
