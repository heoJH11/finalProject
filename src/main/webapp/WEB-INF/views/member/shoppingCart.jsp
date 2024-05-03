<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
body { background-color: #f5f7ff; }

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.swal2-title{
	font-family: 'GmarketSansMedium';
}
.swal2-html-container{
	font-family: 'GmarketSansMedium';
}

th, td, input, label,h1,h2,h3,h4 button,textarea,a{
	font-family: 'GmarketSansMedium';
}


#bundleTable img{
	width: 150px;
	height: 150px;
	text-align: center;
	border-radius: 0px;
}
</style>
<script>
checkList = []; //체크한 애들 배열
checkPastList = []; //기간 지난애들 배열
function pagingList(data){
	console.log("함수 data : ", data);
	$.ajax({
		url : "/onedayClass/mberShoppingCartAjax",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(res){
			if(res.total == 0){
				$("#cartTbody").html("<tr style=\'height:100px; cursor: pointer;\'><td colspan='5' style='text-align:center;'>검색결과가 없습니다.</td></tr>");
			}
// 			console.log("res:",res);
			let date = new Date();
			let today = date.getFullYear().toString() +"."+ String(date.getMonth() + 1).padStart(2,"0") +"."+ String(date.getDate()).padStart(2,"0");
			let str = "";
			$("#cartTbody").html("");
			
			$.each(res.content,function(idx, shopngBundleVO){
				/* str += "<tr>"; */
				if(shopngBundleVO.ondyclDelType == 0){
					if(today < shopngBundleVO.ondyclSchdulDe){
						if(shopngBundleVO.peopleCheck){
							str += "<tr style=\"height:100px; cursor: pointer;\">";
							str += "<td><p style='color:lightgray;'>정원초과</p></td>";
							str += "<td style='text-align:center; color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">";
							
							if(shopngBundleVO.ondyclThumbPhoto == null || shopngBundleVO.ondyclThumbPhoto == ""){
								str += "<img class='classThumb' src='/images/2024/no_image.gif'></td>";
							}else{
								str += "<img class='classThumb' src='"+shopngBundleVO.ondyclThumbPhoto+"'></td>";
							}
							
							str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclNm+"</td>";
							str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.userNcnm+"</td>";
							str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclSchdulDe+"</td>";
							str += "</tr>";
						}else{
							str += "<tr style=\"height:100px; cursor: pointer;\">";
							str += "<td><div class='form-check bunCkBox'><label class='form-check-label'><input onclick='bunCk(this)' type='checkbox' value='"+shopngBundleVO.ondyclNo+"' class='form-check-input ckBtn'><i class='input-helper'></i></label></div></td>"
							str += "<td style='text-align:center;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">";
							
							if(shopngBundleVO.ondyclThumbPhoto == null || shopngBundleVO.ondyclThumbPhoto == ""){
								str += "<img class='classThumb' src='/images/2024/no_image.gif'></td>";
							}else{
								str += "<img class='classThumb' src='"+shopngBundleVO.ondyclThumbPhoto+"'></td>";
							}
							
							str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclNm+"</td>";
							str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.userNcnm+"</td>";
							str += "<td onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclSchdulDe+"</td>";
							str += "</tr>";
						}
					}else{
						let classNum = (shopngBundleVO.ondyclNo).toString();
						checkPastList.push(classNum);
// 						console.log("classNum 타입 : " + typeof(classNum));
						str += "<tr style=\"height:100px; cursor: pointer;\">";
						str += "<td><div class='form-check bunCkBox'><label class='form-check-label'><input type='checkbox' onclick='bunCk(this)' value='"+shopngBundleVO.ondyclNo+"' class='form-check-input ckBtn'><i class='input-helper'></i></label></div></td>"
						str += "<td style='text-align:center; color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">";
						
						if(shopngBundleVO.ondyclThumbPhoto == null || shopngBundleVO.ondyclThumbPhoto == ""){
							str += "<img class='classThumb' src='/images/2024/no_image.gif'></td>";
						}else{
							str += "<img class='classThumb' src='"+shopngBundleVO.ondyclThumbPhoto+"'></td>";
						}
						
						str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclNm+"</td>";
						str += "<td style='color:lightgray;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.userNcnm+"</td>";
						str += "<td style='color:red;' onclick=\"location.href='/onedayClass/onedayClassDetail?ondyclNo=" + shopngBundleVO.ondyclNo + "&startPoint=myBundle'\">"+shopngBundleVO.ondyclSchdulDe+"</td>";
						str += "</tr>";
					}
				}
			
			});
// 			console.log("checkPastList 타입 : " + typeof(checkPastList));
			$("#cartTbody").append(str);
			$("#keyword").val("");
// 			console.log("여기요 : ",res.pagingArea);
			$("#divPagingArea").html(res.pagingArea);
// 			sessionStorage.setItem("total",res.total);
		}
	});
}
function bunCk(checkBox){
	checkList.push(checkBox.value);
	let ondyclNo = checkBox.value;
// 	console.log("checkBox 타입 : " + typeof(checkBox.value));
// 	console.log("checkList 타입 : " + typeof(checkList));
	if(checkBox.checked){
// 		console.log("체크 : " + checkBox.value);
		let xhr = new XMLHttpRequest();
		xhr.open("get", "/onedayClass/priceCk?ondyclNo="+ondyclNo,true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				let res = JSON.parse(xhr.responseText);
				let ondyclPc = res.ondyclPc;
				let dayCheck = res.dayCheck;
// 				console.log("res" , res);
// 				console.log("res.ondyclPc" , res.ondyclPc);
				
				let totalPc = document.getElementById('totalPc').innerText;
				let totalCnt = Number(document.getElementById('totalCnt').innerText);
// 				console.log("ondyclPc" + ondyclPc);
// 				console.log(totalPc + "/" + totalCnt);
				if(!dayCheck){
					document.getElementById('totalPc').innerText = Number(totalPc) + Number(ondyclPc);
					document.getElementById('totalCnt').innerText = totalCnt + 1;
				}
			}
		}
		xhr.send();
	}else{
		console.log("체크 풀림");
		let xhr = new XMLHttpRequest();
		xhr.open("get", "/onedayClass/priceCk?ondyclNo="+ondyclNo,true);
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				let res = JSON.parse(xhr.responseText);
				let ondyclPc = res.ondyclPc;
				let dayCheck = res.dayCheck;
// 				console.log("res" , res);
// 				console.log("res.ondyclPc" , res.ondyclPc);
				
				let totalPc = document.getElementById('totalPc').innerText;
				let totalCnt = Number(document.getElementById('totalCnt').innerText);
// 				console.log("ondyclPc" + ondyclPc);
// 				console.log(totalPc + "/" + totalCnt);
				if(!dayCheck){
					document.getElementById('totalPc').innerText = totalPc - ondyclPc;
					document.getElementById('totalCnt').innerText = totalCnt - 1;
				}
			}
		}
		xhr.send();
	}
}
$(document).ready(function(){
	$("#allSelect").on('click',function(){
		if($("#allSelect").is(":checked")){
			console.log("전체체크");
			$(".ckBtn").prop("checked", true);
		}else{
			console.log("전체체크 해제");
			$(".ckBtn").prop("checked", false);
		}
	})
	
	//검색조건 제목
	$("#title").on("click",function(){
		const btnElement = document.getElementById('searchCategory');
		btnElement.innerText = '제목';
		$('#keyword').attr("type", "text");
		$("#searchKeyword").val("title");
		$("#keyword").val("");
	})
	//검색조건 날짜
	$("#date").on("click",function(){
		const btnElement = document.getElementById('searchCategory');
		btnElement.innerText = '날짜';
		$('#keyword').attr("type", "date");
		$("#searchKeyword").val("date");
		$("#keyword").val("");
	})
	
	let searchKeyword = $("#searchKeyword").val();
	let userId = $("#sessionId").val();
	if($("#sessionId").val() == ""){
		Swal.fire({
			title: '로그인 후 이용해주세요.',
			icon: 'error',
			showCancelButton: false,
			confirmButtonColor: '#7066e0',
			confirmButtonText: '확인'
		}).then((result)=>{
			location.href="/main";
		})
	}
	
	$("#btnSearch").on("click",function(){
		let keyword = $("#keyword").val();
		let currentPage = "1";
		let searchKeyword = $("#searchKeyword").val();
		let mberId = '${memSession.userId}';
		
// 		console.log(keyword + "/" + searchKeyword);
		let data = {
			"keyword":keyword,
			"currentPage":currentPage,
			"mberId":mberId,
			"searchKeyword":searchKeyword,
		};
		console.log("data1:",data)
		pagingList(data);
	});
	let currentPage = "${param.currentPage}";
	let mberId = '${memSession.userId}';
	if(currentPage == ""){
		currentPage = "1";
	}
	let data = {
		"keyword":"${param.keyword}",
		"currentPage":currentPage,
		"mberId":mberId,
		"searchKeyword":searchKeyword
	};
	console.log("페이징 데이터 : ",data);
	pagingList(data);
	
	//기간 지난상품 삭제
	$("#delPastClass").on("click",function(){
		let mberId = '${memSession.userId}';
		console.log("기간삭제", checkPastList);
		if(checkPastList.length == 0){
			Swal.fire({
				title: '기간이 지난 항목이 없습니다.',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인',
			})
		}else{
			Swal.fire({
				title: '수강날짜가 지난 클래스를 삭제하시겠습니까?',
				text:'총 '+checkPastList.length + ' 개의 클래스가 장바구니에서 삭제됩니다.',
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then((result)=>{
				if(result.isConfirmed){
					$.ajax({
						url:'/onedayClass/delBundle',
						type:'post',
						traditional: true,
						data:{"checkList":checkPastList, "mberId":mberId},
						dataType:'json',
						success:function(res){
							if(res == 0){
								Swal.fire({
									title: '기간이 지난 항목이 없습니다.',
									icon: 'warning',
									showCancelButton: dalse,
									confirmButtonColor: '#7066e0',
									confirmButtonText: '확인',
								})
							}
							Swal.fire({
								title: '기간이 지난 항목들이 장바구니에서 삭제되었습니다.',
								icon: 'success',
								showCancelButton: true,
								confirmButtonColor: '#7066e0',
								cancelButtonColor: '#6e7881',
								confirmButtonText: '확인',
								cancelButtonText: '취소'
							}).then((result)=>{
								location.reload(true);
							})
						}
					})
				}else{
					Swal.fire({
						title: '삭제가 취소되었습니다.',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인',
					})
				}
			})
		}
	})
	
	
	//선택항목 구매
	$("#buyBundle").on("click",function(){
		console.log("구매");
		console.log("선택한 애들 ",checkList);
		if(checkList.length == 0){
			Swal.fire({
				title: '선택한 항목이 없습니다.',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인',
			})
		}else{
			Swal.fire({
				title: '선택한 항목들을 구매하시겠습니까?',
				text:'총 '+checkList.length + ' 개의 클래스로 '+$("#totalPc").text()+' 원이 결제됩니다.',
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then((result)=>{
				if(result.isConfirmed){
					console.log("결제실행");
					//결제 시작
					var IMP = window.IMP; 
					IMP.init("imp67011510");	// 테스트용 가맹점ID(변경 X)
	
					var today = new Date();
					var year = today.getFullYear().toString();
					var month = today.getMonth().toString();
					var day = today.getDate().toString();
					var hours = today.getHours().toString(); // 시
					var minutes = today.getMinutes().toString();  // 분
					var seconds = today.getSeconds().toString();  // 초
					var milliseconds = today.getMilliseconds().toString();
					var makeMerchantUid = year + month + day + hours +  minutes + seconds + milliseconds;
					
					let mberId = "${memSession.userId}";
					
		//결제없이 연습/ 끝나면 밑으로########################################
// 					let data = {
// 							"setleNo":makeMerchantUid,
// 							"mberId":mberId,
// 							"checkList":checkList
// 						}
// 						// console.log(rsp);
// 						$.ajax({
// 							url: "/onedayClass/buyBundle",
// 							type: "post",
// 							data:JSON.stringify(data),
// 							contentType:"application/json;charset=utf-8",
// 							success:function(res){
// 								Swal.fire({
// 									title: '결제가 성공하였습니다.',
// 									icon: 'success',
// 									showCancelButton: false,
// 									confirmButtonColor: '#7066e0',
// 									confirmButtonText: '확인'
// 								}).then((result)=>{
// 									location.reload(true);
// 								})
// 							}
// 						})
		//결제없이 연습/ 끝나면 밑으로########################################
		
					IMP.request_pay({
						pg: 'kakaopay',
						pay_method: 'card',
						merchant_uid: makeMerchantUid,  // 주문번호
						name: '선택 클래스 ' + $("#totalCnt").text() + "개",							// 상품명
						amount: $("#totalPc").text(),							// 가격(결제 금액)
					}, function (rsp) {
						if (rsp.success) {
							// 서버 결제 API 성공시 로직
							let data = {
								"setleNo":makeMerchantUid,
								"mberId":mberId,
								"checkList":checkList
							}
							// console.log(rsp);
							$.ajax({
								url: "/onedayClass/buyBundle",
								type: "post",
								data:JSON.stringify(data),
								contentType:"application/json;charset=utf-8",
								success:function(res){
									Swal.fire({
										title: '결제가 성공하였습니다.',
										icon: 'success',
										showCancelButton: false,
										confirmButtonColor: '#3085d6',
										confirmButtonText: '확인'
									}).then((result)=>{
										location.reload(true);
									})
								}
							})
						} else {
							Swal.fire({
								title: '결제가 취소되었습니다.',
								icon: 'error',
								showCancelButton: false,
								confirmButtonColor: '#3085d6',
								confirmButtonText: '확인'
							})
						}
					})//결제 끝
				}else{
					Swal.fire({
						title: '결제가 취소되었습니다.',
						icon: 'error',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인',
					})
				}
				
				
			})
		}
	})
	//선택항목 삭제
	$("#delBundle").on("click",function(){
		let mberId = '${memSession.userId}';
		console.log("선택삭제 " + checkList);
		if(checkList.length == 0){
			Swal.fire({
				title: '선택한 항목이 없습니다.',
				icon: 'warning',
				showCancelButton: false,
				confirmButtonColor: '#7066e0',
				confirmButtonText: '확인',
			})
		}else{
			Swal.fire({
				title: '선택한 항목들을<br>장바구니에서 삭제하시겠습니까?',
				text:'총 '+checkList.length + ' 개의 클래스가 장바구니에서 삭제됩니다.',
				icon: 'question',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#6e7881',
				confirmButtonText: '확인',
				cancelButtonText: '취소'
			}).then((result)=>{
				if(result.isConfirmed){
					$.ajax({
						url:'/onedayClass/delBundle',
						type:'post',
						traditional: true,
						data:{"checkList":checkList, "mberId":mberId},
						dataType:'json',
						success:function(res){
							Swal.fire({
								title: '선택한 항목들이 장바구니에서 삭제되었습니다.',
								icon: 'success',
								showCancelButton: true,
								confirmButtonColor: '#7066e0',
								cancelButtonColor: '#6e7881',
								confirmButtonText: '확인',
								cancelButtonText: '취소'
							}).then((result)=>{
								location.reload(true);
							})
						}
					})
				}else{
					Swal.fire({
						title: '삭제가 취소되었습니다.',
						icon: 'success',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인',
					})
				}
			})
		}
	})
	
})
</script>
<div class="container col-lg-10">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div class="col-12 stretch-card grid-margin grid-margin-md-0">
				<p class="card-title text-white"></p>
				<div >
					<img alt="장바구니" src="../resources/images/장바구니.png" style="width:70px; height:auto; margin:0 0 20px 500px;">
					<h2 id="ondayCart" style="margin-left: 380px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">${memSession.userNcnm} 님의 <br>원데이클래스 장바구니</h2>
					<hr style="border-top: 100px solid #f5f7ff; margin:-90px -70px 0 300px;">
					<br>
				</div>

	</div>

	<div class="col-12 grid-margin stretch-card" style="margin-top:30px;">
	<input type="hidden" id="searchKeyword" value="title">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-6 form-group text-center" style="margin-left:530px;"> <!-- 중앙 정렬을 위해 text-center 클래스 추가 -->
						<div class="input-group">
							<button class="btn btn-inverse-primary btn-fw btnSelect dropdown-toggle" style="margin-right:10px;"
								type="button" id="searchCategory" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">제목</button>
							<div class="dropdown-menu" style="">
								<a class="dropdown-item" href="#" id="title">제목</a>
								<a class="dropdown-item" href="#" id="date">날짜</a>
							</div>
							<input type="text" name="keyword" id="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label="">
							<div class="input-group-append">
								<button class="btn btn-sm btn-primary" id="btnSearch" type="button">
								&nbsp; 검색 &nbsp; <i class="fas fa-se	arch"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table table-hover" id="bundleTable">
						<thead>
							<tr>
<!-- 								<td>총액 : <span id="totalPc">0</span>원</td> -->
<!-- 								<td>개수 : <span id="totalCnt">0</span>개</td> -->
								<td colspan='2'>개수 : <span id="totalCnt">0</span>개 / 총액 : <span id="totalPc">0</span>원  / <input type="checkbox" class="" id="allSelect"><label for='#allSelect'>전체선택</label></td>
								<td><button type="button" id="delPastClass" class="btn btn-inverse-secondary btn-sm" style='float:right;'>기간 지난 상품 삭제</button></td>
								<td><button type="button" id="buyBundle" class="btn btn-primary btn-sm">선택 구매</button></td>
								<td><button type="button" id="delBundle" class="btn btn-inverse-danger btn-sm">선택 삭제</button></td>
							</tr>
							<tr class="text-white">
								<th style="width: 5%; color:black;">체크박스</th>
								<th style="width: 15%; color:black; text-align:center;">썸네일</th>
								<th style="width: 50%; color:black;">제목</th>
								<th style="width: 10%; color:black;">판매자</th>
								<th style="width: 10%; color:black;">날짜</th>
							</tr>
						</thead>
						<tbody id="cartTbody">
							<!-- 공지사항 내용이 표시되는 부분 -->
						</tbody>
					</table>
				</div>
				<div class="row justify-content-center" style="margin-top: 20px;">
					<div id="divPagingArea"></div>
				</div>
			</div>
		</div>
	</div>
</div>

