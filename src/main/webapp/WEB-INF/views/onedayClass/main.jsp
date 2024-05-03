<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<style>
 body { background-color: #f5f7ff; }
 
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

a,div,button{
font-family: 'GmarketSansMedium';
}
/* 제목 */
#balloon {
    position: absolute;
    margin-top: -90px;
    top: 0;
    left: 0;
    z-index: 0;
}

#ondayTitle {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}

.ondyclName{
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size: 0.8rem;
}
.thumbnail{
	width: auto;
	height: auto;
/* 	border-radius: 20px; */
}
.inModalBtn{
	background-color:transparent;
	border:none;
}
.profile{
	width: 24px;
	height: 24px;
	border-radius: 12px;
}
.eachAlbum{
	color:black;
}
.eachAlbum:hover{
	color:#4B49AC;
	text-decoration:none;
}
.btnSelect{
	margin-left: 15px;
}
table{
	width: 100%;
	height: 25px;
	margin-bottom:15px;
}
</style>
<script>
$(document).ready(function(){
	paging(${vOndyclProUsersVOList.size()});

	var countOndycl = $("#countOndycl").val();
	var forDate = {};
	for(var i=0;i<countOndycl;i++){
		var inputId = "#startDate" + i;
		var dateSpan = "#dateSpan" + i;
		var bfFormat = $(inputId).val();
		forDate[i] = formatDate(bfFormat);
		
		$(dateSpan).text(forDate[i]);
	}
})
function formatDate(str){
	var year = str.substring(0,4);
	var month = str.substring(4,6);
	var day = str.substring(6,8);
	return year+"."+month+"."+day;
}
$(function(){
	//검색조건 제목
	$("#title").on("click",function(){
		const btnElement = document.getElementById('keyword');
		btnElement.innerText = '제목';
		$('#firstInput').attr("type", "text");
		$('#secondInput').attr("type", "hidden");
		$("#searchKeyword").val("title");
		$("#firstInput").val("");
		$("#secondInput").val("");
	})
	//검색조건 날짜
	$("#date").on("click",function(){
		const btnElement = document.getElementById('keyword');
		btnElement.innerText = '날짜';
		$('#firstInput').attr("type", "date");
		$('#secondInput').attr("type", "date");
		$("#searchKeyword").val("date");
		$("#firstInput").val("");
		$("#secondInput").val("");
	})
	//글쓰기
	$("#createOndycl").on("click",function(){
		location.href="/onedayClass/createOndycl";
	})
	//검색조건 작성자
	$("#writer").on("click",function(){
		const btnElement = document.getElementById('keyword');
		btnElement.innerText = '작성자';
		$('#firstInput').attr("type", "text");
		$('#secondInput').attr("type", "hidden");
		$("#searchKeyword").val("writer");
		$("#firstInput").val("");
		$("#secondInput").val("");
	})
	//검색 초기화버튼
	$("#btnCancel").on('click',function(){
		$("#btnCancel").css("display","none");
		location.href=("/onedayClass/main");
	})
	
	//프로 본인의 클래스만 보기
	$("#proMyClass").on("click",function(){
		let keyword = "writer";
		let firstInput = "${proSession.userNcnm}";
		let data = {
				"keyword":keyword,
				"firstInput":firstInput
		}
		$.ajax({
			url:"/onedayClass/searchClass?keyword="+keyword+"&firstInput="+firstInput,
			type:"get",
			success:function(res){
// 				console.log("내꺼만 ",res);
				if(res.length == 0){
					Swal.fire({
						title: '검색된 결과가 존재하지 않습니다.',
						icon: 'info',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						return;
					})
				}
				var str = "";
				for(var i=0;i<res.length;i++){
					console.log("내꺼만2 ",res[i].ondyclThumbPhoto);
					str += `
						<a href='/onedayClass/onedayClassDetail?ondyclNo=\${res[i].ondyclNo}&mberId=${memSession.userId}' class='eachAlbum'>
						<div class="colGrid" style="margin:20px; width:250px; height:auto; ">
						<div class='card shadow-sm'>`;
						
						if(res[i].ondyclThumbPhoto == null || res[i].ondyclThumbPhoto == ""){
							str +=`<img src="/images/2024/no_image.gif" loading='lazy' class='lazy' width="100%" height="225">`;
						}else{
							str +=`<img src="\${res[i].ondyclThumbPhoto}" loading='lazy' class='lazy' width="100%" height="225">`;
						}
						
					str +=`<div class='card-body'>
						<p class='card-text'>
						<div style='font-size:1.2rem;' class='ondyclName'><b>\${res[i].ondyclNm}</b></div>
						<div id='dateSpan\${i}'></div>
						<input type='hidden' id='startDate\${i}' value='\${res[i].ondyclSchdulDe}'>
						</p>
						<div class='d-flex justify-content-between align-items-center'>
						<small class='text-body-secondary'>\${res[i].spcltyRealmCode}</small>
						<div class='btn-group'>
					`;
					if(res[i].proProflPhoto == null){
						str += `<img class='profile lazy' loading='lazy' src='/images/2024/profile.jpg'>`;
					}else{
						str += `<img class='profile lazy' loading='lazy' src='\${res[i].proProflPhoto}'>`;
					}
				str += `
					<span>\${res[i].userNcnm}</span>
					</div>
					</div>
					</div>
					</div>
					</div>
					</a>
					`;
				}
// 				console.log("str : "+str);
				$("#result").html("");
				$("#result").html(str);
				paging(res.length);
				$("#btnCancel").css("display","block");
			}
		})
	})
	
	//검색실행
	$("#btnSearch").on("click",function(){
		btnSearchClick();
	})
	$("#firstInput").on("keyup", function (key) {
        if (key.keyCode == 13) {
        	btnSearchClick();
        }
    })
	
	let btnSearchClick = function(){
		var keyword = $("#searchKeyword").val();
		var firstInput = $("#firstInput").val();
		var secondInput = $("#secondInput").val();
		if(searchKeyword == 'date'){
			if(secondInput != null && secondInput != ""){
				if(firstInput > secondInput){
					Swal.fire({
						title: '날짜 선택이 잘못되었습니다.',
						text: '날짜를 확인하세요.',
						icon: 'error',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						return;
					})
				}
			}else{
				Swal.fire({
					title: '로그인 후 이용해주세요.',
					icon: 'info',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				}).then((result)=>{
					location.href="/main";
				})
			}
			
		}
		
		let data = {
				"keyword":keyword,
				"firstInput":firstInput,
				"secondInput":secondInput
		}
		
		$.ajax({
			url:"/onedayClass/searchClass?keyword="+keyword+"&firstInput="+firstInput+"&secondInput="+secondInput,
			type:"get",
			success:function(res){
				if(res.length == 0){
					Swal.fire({
						title: '검색된 결과가 존재하지 않습니다.',
						icon: 'info',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						return;
					})
				}
				$("#categoryBtn").html("<i class='mdi mdi-format-list-bulleted'></i>전문분야");
				$("#localBtn").html("<i class='mdi mdi-format-list-bulleted'></i>지역");
				var str = "";
				for(var i=0;i<res.length;i++){
					console.log("검색어 검색 " , res[i]);
					str += `
						<a href='/onedayClass/onedayClassDetail?ondyclNo=\${res[i].ondyclNo}&mberId=${memSession.userId}' class='eachAlbum'>
						<div class="colGrid" style="margin:20px; width:250px; height:auto; ">
						<div class='card shadow-sm'>`;
						
						if(res[i].ondyclThumbPhoto == null || res[i].ondyclThumbPhoto == ""){
							str +=`<img src="/images/2024/no_image.gif" loading='lazy' class='lazy' width="100%" height="225">`;
						}else{
							str +=`<img src="\${res[i].ondyclThumbPhoto}" loading='lazy' class='lazy' width="100%" height="225">`;
						}
						
					str +=`<div class='card-body'>
						<p class='card-text'>
						<div style='font-size:1.2rem;' class='ondyclName'><b>\${res[i].ondyclNm}</b></div>
						<div id='dateSpan\${i}'></div>
						<input type='hidden' id='startDate\${i}' value='\${res[i].ondyclSchdulDe}'>
						</p>
						<div class='d-flex justify-content-between align-items-center'>
						<small class='text-body-secondary'>\${res[i].spcltyRealmCode}</small>
						<div class='btn-group'>
					`;
					if(res[i].proProflPhoto == null){
						str += `<img class='profile lazy' loading='lazy' src='/images/2024/profile.jpg'>`;
					}else{
						str += `<img class='profile lazy' loading='lazy' src='\${res[i].proProflPhoto}'>`;
					}
				str += `
					<span>\${res[i].userNcnm}</span>
					</div>
					</div>
					</div>
					</div>
					</div>
					</a>
					`;
				}
// 				console.log("str : "+str);
				$("#result").html("");
				$("#result").html(str);
				paging(res.length);
				$("#btnCancel").css("display","block");
			}
		})
	}
	
	//광역시 선택시 시군구 출력
	$("#bcityCode").on("change",function(){
// 		value="${bcity.bcityCode}" value2="${bcity.bcityNm}
		var bcityCode = $("#bcityCode").val();
		var bcityNm = $("#bcityCode > option:selected").attr("value2");
		if(bcityCode != "none"){
			$("#bcityNm").val(bcityNm);
			$.ajax({
				url:"/onedayClass/brtcSelect?bcityCode="+bcityCode,
				success:function(data){
// 					console.log("시군구 검색 성공 : ",data);
					var brtcStr = "<option value='none'>시군구를 선택하세요.</option>";
	                $.each(data, function(index, brtc) {
	                	brtcStr += "<option value='" + brtc.brtcCode + "' value2='"+brtc.brtcNm+"'>" + brtc.brtcNm + "</option>";
	                });
// 	                console.log("brtcStr" + brtcStr);
	                $("#brtcCode").html("");
	                $("#brtcCode").html(brtcStr);
	    			$("#brtcNm").val("");
				}
			})
		}else{
			$("#brtcCode").html("<select><option>시군구를 선택하세요.</option></select>");
			$("#bcityNm").val("");
			$("#brtcNm").val("");
		}
	})
	
	//시군구 선택시 아래 text에 입력
	$("#brtcCode").on("change",function(){
		var brtcCode = $("#brtcCode").val();
		var brtcNm = $("#brtcCode > option:selected").attr("value2");
		$("#brtcNm").val(brtcNm);
	})
	
	//전문분야 대분류 선택시
	$("#firstCode").on("change",function(){
		$("#thirdCode").html("<select><option>소분류를 선택하세요.</option></select>");
       	$("#codeName").val("");
		$("#spcltyRealmCode").val("");
		var firstCode = $("#firstCode").val();
		var firstCodeNm = $("#firstCode > option:selected").attr("value2");
		if(firstCode != "none"){
			$.ajax({
	            url: '/pro/codeSelect', // 서버 URL
	            type: 'GET',
	            data: {"code": firstCode},
	            dataType: 'json',
	            success: function(data) {
// 		            	$("#secondCode").css("display","block");
	            	var secondStr = "<option value='none'>중분류를 선택하세요.</option>";
	                $.each(data, function(index, secondCodeNm) {
	                    secondStr += "<option value='" + secondCodeNm.spcltyRealmCode + "' value2='"+secondCodeNm.spcltyRealmNm+"'>" + secondCodeNm.spcltyRealmNm + "</option>";
	                });
	                $("#secondCode").html(secondStr);
	                $("#codeName").val("");
	    			$("#spcltyRealmCode").val("");
	            }
	        });
	    } else {
           	$("#secondCode").html("<select><option>중분류를 선택하세요.</option></select>");
           	$("#thirdCode").html("<select><option>소분류를 선택하세요.</option></select>");
           	$("#codeName").val("");
   			$("#spcltyRealmCode").val("");
	    }	
	})
	
	//전문분야 중분류 선택시
	$("#secondCode").on("change",function(){
		var secondCode = $("#secondCode").val();
		var secondCodeNm = $("#secondCode > option:selected").attr("value2");
		if(secondCode.length == 6){
			$("#codeName").val(secondCodeNm);
			$("#spcltyRealmCode").val(secondCode);
			$("#thirdCode").html("<select>소분류가 존재하지 않습니다.</select>");
		}else{
			if(secondCode != "none"){
				$.ajax({
		            url: '/pro/codeSelect', // 서버 URL
		            type: 'GET',
		            data: {"code": secondCode},
		            dataType: 'json',
		            success: function(data) {
		            	$("#thirdCode").css("display","block");
		            	var thirdStr = "<option value='none'>소분류를 선택하세요.</option>";
		                $.each(data, function(index, thirdCodeNm) {
		                	thirdStr += "<option value='" + thirdCodeNm.spcltyRealmCode + "' value2='"+thirdCodeNm.spcltyRealmNm+"'>" + thirdCodeNm.spcltyRealmNm + "</option>";
		                });
		                $("#thirdCode").html(thirdStr);
		            }
		        });
		    } else {
            	$("#thirdCode").html("<select><option소중류를 선택하세요.</option></select>");
            	$("#codeName").val("");
    			$("#spcltyRealmCode").val("");
		    }	
		}
	})
	
	//전문분야 소분류 선택 시
	$("#thirdCode").on("change",function(){
		var thirdCode = $("#thirdCode").val();
		var thirdCodeNm = $("#thirdCode > option:selected").attr("value2");
		if(thirdCode != "none"){
			$("#codeName").val(thirdCodeNm);
			$("#spcltyRealmCode").val(thirdCode);
		}else{
			$("#codeName").val("");
			$("#spcltyRealmCode").val("");
		}
		
	})
	//전문분야 모달창 끌때 초기화
	$("#categoryModalClose").on('click',function(){
		$("#firstCode").val("none");
		$("#secondCode").val("none");
		$("#thirdCode").val("none");
		$("#spcltyRealmCode").val("");
		$("#codeName").val("");
	})
	//지역 모달창 끌때 초기화
	$("#localModalClose").on('click',function(){
		$("#bcityCode").val("none");
		$("#brtcCode").val("none");
		$("#bcityNm").val("");
		$("#brtcNm").val("");
	})
	
	//전문분야 검색 실행
	$("#categorySubmit").on("click",function(){
		var spcltyRealmCode = $("#spcltyRealmCode").val();
		if(spcltyRealmCode == null || spcltyRealmCode == ""){
			Swal.fire("검색 조건을 선택해주세요.");
			return;
		}
		
		$.ajax({
			url:"/onedayClass/categorySearch?spcltyRealmCode="+spcltyRealmCode,
			success:function(res){
				if(res.length == 0){
					Swal.fire({
						title: '검색된 결과가 존재하지 않습니다.',
						icon: 'info',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						$("#categoryModal").modal('hide');
						$("#firstCode").val("none");
						$("#secondCode").val("none");
						$("#thirdCode").val("none");
						$("#spcltyRealmCode").val("");
						$("#codeName").val("");
						return;
					})
				}
				var firstCodeNm = $("#firstCode > option:selected").attr("value2");
				var secondCodeNm = $("#secondCode > option:selected").attr("value2");
				var thirdCodeNm = $("#thirdCode > option:selected").attr("value2");
				
				$("#categoryBtn").html("<i class='mdi mdi-format-list-bulleted'></i>"+firstCodeNm + " " + secondCodeNm + " " + thirdCodeNm);
				$("#localBtn").html("<i class='mdi mdi-format-list-bulleted'></i>지역");
				var str = "";
				for(var i=0;i<res.length;i++){
					console.log("카테고리 검색 " , res[i]);
					str += `
						<a href='/onedayClass/onedayClassDetail?ondyclNo=\${res[i].ondyclNo}&mberId=${memSession.userId}' class='eachAlbum'>
						<div class="colGrid" style="margin:20px; width:250px; height:auto; ">
						<div class='card shadow-sm'>`;
						
						if(res[i].ondyclThumbPhoto == null || res[i].ondyclThumbPhoto == ""){
							str +=`<img src="/images/2024/no_image.gif" loading='lazy' class='lazy' width="100%" height="225">`;
						}else{
							str +=`<img src="\${res[i].ondyclThumbPhoto}" loading='lazy' class='lazy' width="100%" height="225">`;
						}
						
					str +=`<div class='card-body'>
						<p class='card-text'>
						<div style='font-size:1.2rem;' class='ondyclName'><b>\${res[i].ondyclNm}</b></div>
						<div id='dateSpan\${i}'></div>
						<input type='hidden' id='startDate\${i}' value='\${res[i].ondyclSchdulDe}'>
						</p>
						<div class='d-flex justify-content-between align-items-center'>
						<small class='text-body-secondary'>\${res[i].spcltyRealmCode}</small>
						<div class='btn-group'>
					`;
					if(res[i].proProflPhoto == null){
						str += `<img class='profile lazy' loading='lazy' src='/images/2024/profile.jpg'>`;
					}else{
						str += `<img class='profile lazy' loading='lazy' src='\${res[i].proProflPhoto}'>`;
					}
				str += `
					<span>\${res[i].userNcnm}</span>
					</div>
					</div>
					</div>
					</div>
					</div>
					</a>
					`;
				}
				$("#result").html("");
				$("#result").html(str);
				paging(res.length);
				$("#btnCancel").css("display","block");
				$("#categoryModal").modal('hide');
			}
		})
	})
	
	//지역 검색 실행
	$("#localSubmit").on("click",function(){
		var bcityNm = $("#bcityNm").val();
		var brtcNm = $("#brtcNm").val();
		var cityName;
		if(brtcNm == null || brtcNm == ""){
			Swal.fire("검색 조건을 모두 선택해주세요.");
			return;
		}
		if(brtcNm!=null){
			cityName = bcityNm + " " + brtcNm;
		}else{
			cityName = bcityNm;
		}
		
		$.ajax({
			url:"/onedayClass/localSearch?cityName="+cityName,
			success:function(res){
				if(res.length == 0){
					Swal.fire({
						title: '검색된 결과가 존재하지 않습니다.',
						icon: 'info',
						showCancelButton: false,
						confirmButtonColor: '#7066e0',
						confirmButtonText: '확인'
					}).then((result)=>{
						$("#bcityCode").val("none");
						$("#brtcCode").val("none");
						$("#bcityNm").val("");
						$("#brtcNm").val("");
						$("#localModal").modal('hide');
						return;
					})
				}
				$("#localBtn").html("<i class='mdi mdi-format-list-bulleted'></i>"+cityName);
				$("#categoryBtn").html("<i class='mdi mdi-format-list-bulleted'></i>전문분야");
				var str = "";
				for(var i=0;i<res.length;i++){
					console.log("도시 검색 ", res[i]);
					str += `
						<a href='/onedayClass/onedayClassDetail?ondyclNo=\${res[i].ondyclNo}&mberId=${memSession.userId}' class='eachAlbum'>
						<div class="colGrid" style="margin:20px; width:250px; height:auto; ">
						<div class='card shadow-sm'>`;
						
						if(res[i].ondyclThumbPhoto == null || res[i].ondyclThumbPhoto == ""){
							str +=`<img src="/images/2024/no_image.gif" loading='lazy' class='lazy' width="100%" height="225">`;
						}else{
							str +=`<img src="\${res[i].ondyclThumbPhoto}" loading='lazy'  class='lazy' width="100%" height="225">`;
						}
						
					str +=`<div class='card-body'>
						<p class='card-text'>
						<div style='font-size:1.2rem;' class='ondyclName'><b>\${res[i].ondyclNm}</b></div>
						<div id='dateSpan\${i}'></div>
						<input type='hidden' id='startDate\${i}' value='\${res[i].ondyclSchdulDe}'>
						</p>
						<div class='d-flex justify-content-between align-items-center'>
						<small class='text-body-secondary'>\${res[i].spcltyRealmCode}</small>
						<div class='btn-group'>
					`;
					if(res[i].proProflPhoto == null){
						str += `<img class='profile lazy' loading='lazy' src='/images/2024/profile.jpg'>`;
					}else{
						str += `<img class='profile lazy' loading='lazy' src='\${res[i].proProflPhoto}'>`;
					}
				str += `
					<span>\${res[i].userNcnm}</span>
					</div>
					</div>
					</div>
					</div>
					</div>
					</a>
					`;
				}
// 				console.log("str : "+str);
				$("#result").html("");
				$("#result").html(str);
				paging(res.length);
				$("#btnCancel").css("display","block");
				$("#localModal").modal('hide');
			}
		})
	})
})

function paging(totalItems){
	// 전체 아이템 수
//     var totalItems = ${vOndyclProUsersVOList.size()};
    // 페이지당 아이템 수
    var itemsPerPage = 9;
    // 전체 페이지 수
    var totalPages = Math.ceil(totalItems / itemsPerPage);
    //현재페이지
    var thisPages = 1;
	$("#thisPages").val(thisPages);

    // 페이지 번호를 클릭했을 때 해당 페이지를 표시하는 함수
    function showPage(page) {
        // 시작 아이템 인덱스
		thisPages = page;
        var startIndex = (page - 1) * itemsPerPage;
        // 끝 아이템 인덱스
        var endIndex = Math.min(startIndex + itemsPerPage, totalItems);
        // 모든 아이템을 숨김
        $('.colGrid').hide();
        // 해당 페이지에 해당하는 아이템만 표시
        for (var i = startIndex; i < endIndex; i++) {
            $('.colGrid').eq(i).show();
        }
    }

    // 초기 페이지 표시
	if(totalItems > 8){
		showPage(1);
	}

    // 페이지 링크 생성
    var paginationHtml = "";
    if(thisPages > 5){
		paginationHtml += `<li class="paginate_button page-item">
								<a href="#" class="page-link" id="beforePage">
									<i class="mdi mdi-chevron-double-left"></i>
								</a>
							</li>`;
	}
	if(totalPages > 5){
		for (var i = 1; i <= 5; i++) {
			paginationHtml += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${i}">\${i}</a>
								</li>`;
		}
		paginationHtml += `<li class="paginate_button page-item">
								<a href="#" class="page-link pageNext" id="nextPage">
									<i class="mdi mdi-chevron-double-right"></i>
								</a>
							</li>`;
	}else{
		for (var i = 1; i <= totalPages; i++) {
			paginationHtml += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${i}">\${i}</a>
								</li>`;
		}
	}
    $('#pagination-container').html(paginationHtml);

	// >> 버튼 클릭
	$('#pagination-container').on("click","#nextPage",function(){
		console.log("눌림" + thisPages);
		if(thisPages <= 5){ //첫번째 리스트
			let str = `<li class="paginate_button page-item">
							<a href="#" class="page-link" id="beforePage">
								<i class="mdi mdi-chevron-double-left"></i>
							</a>
						</li>`;
			for (var j = 6; j <= 10; j++) {
				str += `<li class="paginate_button page-item paginationNum">
							<a class="page-link" href="#" data-page="\${j}">\${j}</a>
						</li>`;
			}
			str += `<li class="paginate_button page-item">
						<a href="#" class="page-link pageNext" id="nextPage">
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
					</li>`;
			$("#pagination-container").html("");
			$("#pagination-container").html(str);
			showPage(6);
		}else if(thisPages > 5 || thisPages <= (totalPages/5).toFixed(0)*5){
			console.log("눌림" + thisPages);
			if(thisPages%5 != 0){
				let str1 = `<li class="paginate_button page-item">
							<a href="#" class="page-link" id="beforePage">
								<i class="mdi mdi-chevron-double-left"></i>
							</a>
						</li>`;
				if(((parseInt(thisPages/5) + 2))*5 <= totalPages){
					for (var k = (((parseInt(thisPages/5) + 1)) * 5) + 1; k <= ((parseInt(thisPages/5) + 2))*5; k++) {
						str1 += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${k}">\${k}</a>
								</li>`;
					}
					str1 += `<li class="paginate_button page-item">
								<a href="#" class="page-link pageNext" id="nextPage">
									<i class="mdi mdi-chevron-double-right"></i>
								</a>
							</li>`;
				}else{
					for (var ks = (((parseInt(thisPages/5) + 1)) * 5) + 1; ks <= totalPages; ks++) {
						str1 += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${ks}">\${ks}</a>
								</li>`;
					}
					
				}
				$("#pagination-container").html("");
				$("#pagination-container").html(str1);
				showPage((((parseInt(thisPages/5) + 1)) * 5) + 1);
			}else{
				let str1 = `<li class="paginate_button page-item">
							<a href="#" class="page-link" id="beforePage">
								<i class="mdi mdi-chevron-double-left"></i>
							</a>
						</li>`;
				if((thisPages/5) == parseInt(totalPages/5)){
					for (var k = (thisPages) + 1; k <= totalPages; k++) {
						str1 += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${k}">\${k}</a>
								</li>`;
					}
				}else{
					for (var k = (thisPages) + 1; k <= (thisPages) + 5; k++) {
						str1 += `<li class="paginate_button page-item paginationNum">
									<a class="page-link" href="#" data-page="\${k}">\${k}</a>
								</li>`;
					}
					str1 += `<li class="paginate_button page-item">
								<a href="#" class="page-link pageNext" id="nextPage">
									<i class="mdi mdi-chevron-double-right"></i>
								</a>
							</li>`;
				}
				$("#pagination-container").html("");
				$("#pagination-container").html(str1);
				showPage((thisPages) + 1);
			}
			
		}else if(thisPages > (totalPages/5).toFixed(0)*5){
			let str2 = `<li class="paginate_button page-item">
							<a href="#" class="page-link" id="beforePage">
								<i class="mdi mdi-chevron-double-left"></i>
							</a>
						</li>`;
			for (var l = 6; l <= 10; l++) {
				str2 += `<li class="paginate_button page-item paginationNum">
							<a class="page-link" href="#" data-page="\${l}">\${l}</a>
						</li>`;
			}
			$("#pagination-container").html("");
			$("#pagination-container").html(str2);
			showPage(6);
		}
	})

	// << 버튼 클릭
	$('#pagination-container').on("click","#beforePage",function(){
		console.log("눌림" + thisPages);
		if(6 <= thisPages  && thisPages <= 10){ //두번째 리스트
			let str = "";
			for (var j = 1; j <= 5; j++) {
				str += `<li class="paginate_button page-item paginationNum">
							<a class="page-link" href="#" data-page="\${j}">\${j}</a>
						</li>`;
			}
			str += `<li class="paginate_button page-item">
						<a href="#" class="page-link pageNext" id="nextPage">
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
					</li>`;
			$("#pagination-container").html("");
			$("#pagination-container").html(str);
			showPage(1);
		}else if(thisPages > 10){
			console.log("눌림" + thisPages);
			if(thisPages%5 != 0){
				console.log("여기2");
				let str1 = `<li class="paginate_button page-item">
							<a href="#" class="page-link" id="beforePage">
								<i class="mdi mdi-chevron-double-left"></i>
							</a>
						</li>`;
				for (var ks = (parseInt(thisPages/5) * 5) - 5; ks <= (parseInt(thisPages/5) * 5); ks++) {
					str1 += `<li class="paginate_button page-item paginationNum">
								<a class="page-link" href="#" data-page="\${ks}">\${ks}</a>
							</li>`;
				}
				str1 += `<li class="paginate_button page-item">
						<a href="#" class="page-link pageNext" id="nextPage">
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
					</li>`;
				$("#pagination-container").html("");
				$("#pagination-container").html(str1);
				showPage((parseInt(thisPages/5) * 5) - 5);
			}
		}
	})

    // 페이지 번호 클릭 이벤트 처리
    $('#pagination-container').on('click', '.paginationNum a', function() {
		var page = $(this).data('page');
		thisPages = page
		$("#thisPages").val(thisPages);
        console.log("페이지 : " + thisPages);
        showPage(page);
    });
}
// document.addEventListener("DOMContentLoaded", function() {
//   var lazyloadImages = document.querySelectorAll("img.lazy");    
//   var lazyloadThrottleTimeout;
  
//   function lazyload () {
//     if(lazyloadThrottleTimeout) {
//       clearTimeout(lazyloadThrottleTimeout);
//     }    
    
//     lazyloadThrottleTimeout = setTimeout(function() {
//         var scrollTop = window.pageYOffset;
//         lazyloadImages.forEach(function(img) {
//             if(img.offsetTop < (window.innerHeight + scrollTop)) {
//               img.src = img.dataset.src;
//               img.classList.remove('lazy');
//             }
//         });
//         if(lazyloadImages.length == 0) { 
//           document.removeEventListener("scroll", lazyload);
//           window.removeEventListener("resize", lazyload);
//           window.removeEventListener("orientationChange", lazyload);
//         }
//     }, 20);
//   }
  
//   document.addEventListener("scroll", lazyload);
//   window.addEventListener("resize", lazyload);
//   window.addEventListener("orientationChange", lazyload);
// });



// document.addEventListener("DOMContentLoaded", function() {
//   var lazyloadImages;    

//   if ("IntersectionObserver" in window) {
//     lazyloadImages = document.querySelectorAll(".lazy");
//     var imageObserver = new IntersectionObserver(function(entries, observer) {
//       entries.forEach(function(entry) {
//         if (entry.isIntersecting) {
//           var image = entry.target;
//           image.src = image.dataset.src;
//           image.classList.remove("lazy");
//           imageObserver.unobserve(image);
//         }
//       });
//     });

//     lazyloadImages.forEach(function(image) {
//       imageObserver.observe(image);
//     });
//   } else {  
//     var lazyloadThrottleTimeout;
//     lazyloadImages = document.querySelectorAll(".lazy");
    
//     function lazyload () {
//       if(lazyloadThrottleTimeout) {
//         clearTimeout(lazyloadThrottleTimeout);
//       }    

//       lazyloadThrottleTimeout = setTimeout(function() {
//         var scrollTop = window.pageYOffset;
//         lazyloadImages.forEach(function(img) {
//             if(img.offsetTop < (window.innerHeight + scrollTop)) {
//               img.src = img.dataset.src;
//               img.classList.remove('lazy');
//             }
//         });
//         if(lazyloadImages.length == 0) { 
//           document.removeEventListener("scroll", lazyload);
//           window.removeEventListener("resize", lazyload);
//           window.removeEventListener("orientationChange", lazyload);
//         }
//       }, 20);
//     }

//     document.addEventListener("scroll", lazyload);
//     window.addEventListener("resize", lazyload);
//     window.addEventListener("orientationChange", lazyload);
//   }
// })
</script>
<div class="container col-lg-9">
	<input type="hidden" id="thisPages">
		<div >
			<img alt="수업" src="../resources/images/수업.png" style="width:100px; height:auto; margin:0 0 20px 450px;">
			<h2 id="ondayTitle" style="margin-left:400px; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">원데이클래스</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-5px 300px 0 300px;">
		</div>
	<div class="row">
		<div class="col-md-12">
    <div style="margin-top:50px;">
			<p class="card-description" style="font-family: 'seolleimcool-SemiBold'; color:#a7a7a7; line-height: 1.4; font-size:20px;">
				⭐<b>${countOndycl}</b> 개의 원데이클래스 ⭐  전문적인 프로들에게 직접 배울수있는 기회!! <input
					type="hidden" value="${countOndycl}" id="countOndycl">
			</p>
			<br><br>
			<button type="button"
				class="btn btn-inverse-primary btn-fw btnSelect" data-toggle="modal"
				id="categoryBtn" data-target="#categoryModal">
				<i class="mdi mdi-format-list-bulleted"></i>전문분야
			</button>
			<button type="button"
				class="btn btn-inverse-primary btn-fw btnSelect" data-toggle="modal"
				id="localBtn" data-target="#localModal">
				<i class="mdi mdi-format-list-bulleted"></i>지역
			</button>
			<c:if test="${memSession == null && proSession != null}">
				<button type="button" id="createOndycl"
					class="btn btn-inverse-primary btn-fw btnSelect"
					style="float: right;">등록</button>
				<button type="button" class="btn btn-inverse-primary btn-fw"
					style="float: right;" id="proMyClass">나의 원데이클래스</button>
			</c:if>
		</div>
	</div>
	<hr>
</div>
<input type="hidden" id="searchKeyword" value="title">

<div class="row portfolio-grid">
	<div id="result" style="margin-top:50px; display: flex; flex-wrap: wrap; justify-content: center;">
		
		<c:forEach var="vOndyclProUsersVO" items="${vOndyclProUsersVOList}"
			varStatus="stat">
			<div class="colGrid" style="margin:20px; width:250px; height:auto; ">
				<div class="card shadow-sm">
					<a href="/onedayClass/onedayClassDetail?ondyclNo=${vOndyclProUsersVO.ondyclNo}&mberId=${memSession.userId}" class="eachAlbum">
						<c:choose>
							<c:when test="${empty vOndyclProUsersVO.ondyclThumbPhoto}">
								<img src="/images/2024/no_image.gif" class='lazy' loading='lazy' width="100%" height="225">
							</c:when>
							<c:otherwise>
								<img src="${vOndyclProUsersVO.ondyclThumbPhoto}" class='lazy' loading='lazy' width="100%" height="225">
							</c:otherwise>
						</c:choose>
					</a>
					<div class="card-body">
						<p class="card-text" style="font-family: 'GmarketSansMedium';">
							<a href="/onedayClass/onedayClassDetail?ondyclNo=${vOndyclProUsersVO.ondyclNo}&mberId=${memSession.userId}" class="eachAlbum">
								<div style="font-size:1.2rem;" class="ondyclName" style="font-family: 'GmarketSansMedium';"><b><c:out value="${vOndyclProUsersVO.ondyclNm}"></c:out></b></div>
							</a>
							<div id="dateSpan${stat.index}"></div>
							<input type="hidden" id="startDate${stat.index}" value="${vOndyclProUsersVO.ondyclSchdulDe}">
						</p>
						<div class="d-flex justify-content-between align-items-center">
						<small class="text-body-secondary" style="font-family: 'GmarketSansMedium';"><c:out value="${vOndyclProUsersVO.spcltyRealmCode}"></c:out></small>
							<div class="btn-group">
								<a href="/proProfl/detail?proId=${vOndyclProUsersVO.proId}"  class="eachAlbum">
									<c:if test="${empty vOndyclProUsersVO.proProflPhoto}">
										<img class="profile lazy" loading='lazy' src="/images/2024/profile.jpg">
									</c:if>
									<c:if test="${not empty vOndyclProUsersVO.proProflPhoto}">
										<img class="profile lazy" loading='lazy' src="${vOndyclProUsersVO.proProflPhoto}">
									</c:if>
									<span style="font-family: 'GmarketSansMedium';"><c:out value="${vOndyclProUsersVO.userNcnm}"></c:out></span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		
	</div>
</div>

	<div id="divPagingArea" style="margin-top:80px;">
		<div>
			<div class="dataTables_paginate paging_simple_numbers pagination-container">
				<ul class="pagination flex-wrap pagination-rounded-flat pagination-primary" id="pagination-container" style="justify-content: center;">
				</ul>
			</div>
		</div>
	</div>
	
	<div class="col-lg-8">
	<table style="margin:40px 0 80px 220px;">
		<tr>
			<td>
				
			</td>
			<td></td>
			<td></td>
			<td style="width:120px;">
				<button class="btn btn-inverse-primary btn-fw btnSelect dropdown-toggle"
					type="button" id="keyword" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">제목</button>
				<div class="dropdown-menu" style="">
					<a class="dropdown-item" href="#" id="title">제목</a>
					<a class="dropdown-item" href="#" id="writer">작성자</a>
					<div role="separator" class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" id="date">날짜</a>
				</div>
			</td>
			<td colspan='2'>
				<input type="text" id="firstInput" style="width:100%; margin-right:20px;" class="form-control" aria-label="Text input with dropdown button">
			</td>
			<td>
				<input type="hidden" id="secondInput" style="width:100%;" class="form-control" aria-label="Text input with dropdown button">
			</td>
			<td><button class="btn btn-primary" type="button" id="btnSearch" style="margin-left:20px;">검색</button></td>
			<td style="width:100px;"><button class="btn btn-link" type="button" id="btnCancel" style="display:none;">초기화</button></td>
		</tr>
	</table>
</div>

</div>

<!-- 카테고리 선택 모달 -->
<div class="modal fade" id="categoryModal" tabindex="-1"
	data-backdrop="static" aria-labelledby="categoryModalLabel"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">전문분야 검색</h5>
				<button type="button" class="inModalBtn" id="categoryModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
			</div>
			<div class="modal-body" id="categoryModalBody">
				<div id="codeDiv" class="container">
					<div id="firstCodeDiv">
						<select class="form-control form-control-sm" id="firstCode">
							<option value="none">대분류를 선택하세요.</option>
	                    	<c:forEach var="codeNm" items="${codeList}">
					      		<c:if test="${codeNm.lev eq 1}">
						       		<option value="${codeNm.spcltyRealmCode}" value2="${codeNm.spcltyRealmNm}">${codeNm.spcltyRealmNm}</option>
					      		</c:if>
					      	</c:forEach>
	                    </select>
					</div>
					<div id="secondCodeDiv">
						<select class="form-control form-control-sm" id="secondCode">
							<option>중분류를 선택하세요.</option>
	                    </select>
					</div>
					<div id="thirdCodeDiv">
						<select class="form-control form-control-sm" id="thirdCode">
							<option>소분류를 선택하세요.</option>
	                    </select>
					</div>
					<div>
						<input type="text" class="form-control" placeholder="전문분야 선택" id="codeName" readonly>
						<button type="button" class="btn btn-primary" id="categorySubmit" data-dismiss="modal">검색</button>
						<input type="hidden" class="form-control" id="spcltyRealmCode" name="spcltyRealmCode">
					</div>
            	</div>
			</div>
		</div>
	</div>
</div>

<!-- 지역 선택 모달 -->
<div class="modal fade" id="localModal" tabindex="-1"
	data-backdrop="static" aria-labelledby="#localModalLabel"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">지역 검색</h5>
				<button type="button" class="inModalBtn" id="localModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
			</div>
			<div class="modal-body" id="localModalBody">
				<div id="codeDiv" class="container">
					<div id="bcityCodeDiv">
						<select class="form-control form-control-sm" id="bcityCode">
							<option value="none">광역시를 선택하세요</option>
	                    	<c:forEach var="bcity" items="${bcityVOList}">
					       		<option value="${bcity.bcityCode}" value2="${bcity.bcityNm}">${bcity.bcityNm}</option>
					      	</c:forEach>
	                    </select>
					</div>
					<div id="bcityCodeDiv">
						<select class="form-control form-control-sm" id="brtcCode">
							<option>시군구를 선택하세요.</option>
	                    </select>
					</div>
					<div>
						<div class="row container">
							<input type="text" placeholder="광역시 선택" class="form-control" style="width:38%;" id="bcityNm" readonly>
							<input type="text" placeholder="시군구 선택" class="form-control" style="width:38%;" id="brtcNm" readonly>
							<button type="button" class="btn btn-primary" id="localSubmit" data-dismiss="modal">검색</button>
						</div>
					</div>
            	</div>
			</div>
		</div>
	</div>
</div>
