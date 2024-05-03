<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
 body { background-color: #f5f7ff; }
@font-face {
    font-family: 'TTHakgyoansimDotbogiR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimDotbogiR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.btnImg{
	width:300px;
	height: auto;
	filter: brightness(0.5);
}

.btnImg:hover {
    filter: brightness(1);
}

.card-body a {
	padding: 6px 8px 6px 16px;
	text-decoration: none;
	font-size: 18px;
	color: #4B49AC;
	display: block;
}

a:hover {
	color: black;
	text-decoration-line: none;
}
</style>
<script>
$(document).ready(function(){
$(".header").css("display", "none");
$(".footer").css("display", "none");

$(".backBtn").on("click", function(){
    window.location.replace("/main");
 })


	const memberJoin = function(){
		location.href="/member/memberJoin";
	}
	const proJoin = function(){
		location.href="/pro/proJoin"
	}
})

</script>
<div class="container col-lg-10" >
	<div class="card-body" style="text-align: center; margin-top:-100px;">
	<div style="margin-top:50px;">
	<button class="backBtn" style="border:none; background-color:transparent">
		<img src="../resources/images/뒤로가기3.png" alt="img" style="width:50px; margin-left:1100px;"/>
	</button>
	<br>
	<img src="/resources/images/환영.png" style="text-align:center; width:100px; height:auto; margin:-20px 0 20px 0;">
		<h1 class="card-title" style="font-family: 'seolleimcool-SemiBold'; margin-bottom:20px;">환영합니다.</h1>
		<h3 class="card-description" style="font-family: 'seolleimcool-SemiBold';">회원과 프로중 어떤 서비스를 가입하시겠어요?</h3>
		<hr style="border: 0; border-top: 20px solid #e7e7fd; margin:-20px 300px 0 300px;">
		<div class="col-10" style="height:30px;"></div>
		<div class="form-group row" style="margin:30px 0 ">
			<div class="col">
				<div id="the-basics">
					<a href="/member/memberJoin">
						<img src="/resources/images/회원.png" class="btnImg">
						<h3 style="margin-top:15px; font-family: 'seolleimcool-SemiBold';"><b>회원 가입</b></h3>
					</a>
				</div>
			</div>
			<div class="col">
				<div id="bloodhound">
					<a href="/pro/proJoin">
						<img src="/resources/images/프로.png" class="btnImg">
						<h3 style="margin-top:15px; font-family: 'seolleimcool-SemiBold';"><b>프로 가입</b></h3>
					</a>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>
