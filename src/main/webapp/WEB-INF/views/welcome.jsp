<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/confetti_v2.js"></script>
<style>
	canvas{z-index:10;pointer-events: none;position: fixed;top: 0;transform: scale(1.1);}
</style>
<script>
$(function(){
	$("#startButton").click(); // 자동 클릭 이벤트 실행
	$("#main").on('click',function(){
		location.href="/main";
	})
})
</script>
<canvas id="canvas"></canvas>
<button class="canvasBtn" id="startButton" style="display:none;">Drop Confetti</button>

<div style="margin-bottom:100px">
	<div style="text-align: center; margin-top:100px;">
		<img src="/resources/images/누네띠네.png" alt="logo" style="width: 50%; height: auto;">
	</div>
	
	<div style="height: 30px;"></div>
	<div >
		<div class="card">
			<div class="card-body" style='text-align: center; '>
				<h2 style="margin:10px;">누네띠네에 오신것을 환영합니다</h2><br>
				<p  class="card-description" style="font-size: 1.1rem;">로그인 후 누네띠네를 즐겨주세요~ <button type="button" class="btn btn-inverse-primary btn-fw" id="main">메인으로</button></p>
				
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){  
  //티스토리 공감버튼 이벤트
  function reAction(){
  	$("#startButton").trigger("click");
  	setTimeout(function(){
  		$("#main").trigger("click");
  	}, 6000);
  }
  
  $(".uoc-icon").on('click', function(){
      reAction();
  }); 
});
</script>