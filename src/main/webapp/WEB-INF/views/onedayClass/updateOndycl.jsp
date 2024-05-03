<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
.swal2-title{
	font-family: 'GmarketSansMedium';
}
.swal2-html-container{
	font-family: 'GmarketSansMedium';
}


th, td, input, label,h1,h2,h3,h4 button,textarea{
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

#modifyTitle {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}

.table th {
border-top:none;
}
.table td {
border-top:none;
padding : 10px;
}

#imgProfile{
	width:250px;
	height:250px;
	margin-left: auto;
	border-radius: 150px;
}
.delBtn{
	background-color:transparent;
	border:1px solid black;
	margin-left:5px;
}
#imgModalClose{
	background-color:transparent;
	border:none;
}
.box_container{
/* 	height:100vh; */
	height:400px;
	display:flex;
	justify-content: center;
	
}
#ondyclCn{
	border: solid 1px #CED4DA;
	border-radius: 5px;
}
.box{
	text-align: center;
}
.floatLeft{
	float: left;
	margin-left: 20px;
}
.codeTab{
	border: 1px solid #DDDDDD;
	text-align: center;
	margin:5px;
}
#codeBtn{
	margin-left:30px;
	margin-right:30px;
}
#spcltyRealmCode{
	width:200px;
	height:50px;
	margin:5px;
}
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 78%;
    color: #999999;
}
.filebox #lab {
    display: inline-block;
    padding: 10px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #4B49AC;
    border-radius:13px 13px 13px 13px;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
</style>
<script>
$(function(){
	let startDay = $("#startDay").val();
// 	console.log("날짜형식 : " + startDay);
	let validDay = startDay.substr(0,4) + "-" + startDay.substr(5,2) + "-" + startDay.substr(8,2);
// 	console.log("날짜형식 : " + validDay);
	$("#ondyclSchdulDe").val(validDay);
	
	if($("#proId").val() == null || $("#proId").val() == ""){
		Swal.fire({
			title: '프로 로그인 후 이용한 서비스 입니다.',
			icon: 'warning',
			showCancelButton: false,
			confirmButtonColor: '#7066e0',
			confirmButtonText: '확인'
		}).then((result) => {
			location.href="/onedayClass/main";
		});
	}
	//프로필사진 삭제
	$(".photoDelete").on("click",function(){
		var userId = $("#userId").val();
		Swal.fire({
			title: '프로필 사진을 삭제하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				Swal.fire({
					title: '사진 삭제 성공!!',
					icon: 'success',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				}).then((result) => {
					$(".photoDelete").css("display","none");
					$("#newPhoto").css("display","none");
					$("#photoZone").css("display","none");
					$("#delPhoto").css("display","block");
					$(".upload-name").val("");
					$("#proProflPhoto").val("");
					$("#pfPhoto").val("");
					$("#uploadProfile").val("");
				});
			}
		})
	}) //프로필 사진 삭제 끝
	
	$("#uploadProfile").on("change",function(){
		var fileName = $("#uploadProfile").val();
		$(".upload-name").val(fileName.split('/').pop().split('\\').pop());
		$("#proProflPhoto").val(fileName);
		$(".photoDelete").css("display","none");
		$("#delBtn").css("display","block");
	});
	
	$("#uploadProfile").on("change",imgCk);
	function imgCk(e){
		let files = e.target.files;
		
// 		console.log(files);
		let fileArr = Array.prototype.slice.call(files);
	
		fileArr.forEach(function(f){
			
// 			console.log(f);
			if(!f.type.match("image.*")){
				Swal.fire({
					title: '이미지파일만 등록 가능합니다.',
					icon: 'error',
					showCancelButton: false,
					confirmButtonColor: '#7066e0',
					confirmButtonText: '확인'
				}).then((result)=>{
					return;
				})
			}

			let reader = new FileReader();
			
			$("#newPhoto").html("");
			$("#photoZone").css("display","none");
			$("#delPhoto").css("display","none");
			
			reader.onload = function(e){
				$("#newPhoto").css({
					  "display":"block",
					  "background-image": "url(" + e.target.result + ")",
			          "width": "250px", 
			          "height": "250px",
			          "background-position": "center",
			          "background-size": "cover",
					  "margin-bottom":"20px",
					  "border-radius": "150px"
			    });
			}
			reader.readAsDataURL(f);
			
		});
	}
	//자동완성
	$("#autoFilling").on("click",function(){ 
		$("#ondyclNm").val("저의 테스트 원데이클레스에 여러분을 초대합니다!!");
		$("#ondyclCn").val("안녕하세요. 저의 원데이클래스를 클릭해주셔서 감사합니다.\n방문해주셔서 감사합니다.\n저의 원데이클래스를 즐겨주세요.");
		$("#ondyclPc").val("250000");
		$("#ondyclPsncpa").val("15");
		$("#ondyclSchdulDe").val("2024-04-17");
		$("#ondyclSchdulBeginTime").val("13:00");
		$("#ondyclSchdulEndTime").val("16:30");
	})
	
	//우편번호 api 시작
    $("#zipSelect").on("click",function(){
        new daum.Postcode({
            oncomplete: function(data) {
            	  var resultHTML = [];
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                document.getElementById('ondyclZip').value = data.zonecode;	// --> 우편번호 칸
                document.getElementById("ondyclAdres").value = roadAddr;	// --> 도로명 주소 칸
                if(roadAddr !== ''){
                    document.getElementById("ondyclAdres").value = roadAddr;
                } else {
                    document.getElementById("ondyclAdres").value = extraRoadAddr;
                }
                var guideTextBox = document.getElementById("guide");
           }
        }).open();
        $("#ondyclDetailAdres").focus();
    });
	
	// fileCours 클래스를 가진 모든 입력 필드를 선택
	let fileCoursElements = document.querySelectorAll('.fileCours');
	// 선택된 요소들의 value를 배열에 저장
	let fileCoursValues = Array.from(fileCoursElements).map(element => element.value);
	// 결과 확인
// 	console.log(fileCoursValues);
	let fileNames = [];
	let fileList = document.getElementById('uploadFileList');
	for(let j=0;j<fileCoursValues.length;j++){
		fileNames.push
		let items = document.createElement('td');
		let aTag = document.createElement('a');
		aTag.className = 'auth-link text-black';
		aTag.id = "imgBtn" + j;
		aTag.setAttribute('data-toggle','modal');
		aTag.setAttribute('data-target','#imgModal');
		
		// let oldFileUrl = URL.createObjectURL(fileCoursValues[j]);
		aTag.onclick = function(){
			document.getElementById('modalImage').src = fileCoursValues[j];
		}
		let fileCour = fileCoursValues[j].split("_");
		let imgPath = "";
		for(let k=1;k<fileCour.length;k++){
			if(fileCour.length-1 == k){
				imgPath += fileCour[k];
			}else{
				imgPath += fileCour[k] + "_";
			}
		}
// 		console.log("imgPath : ",imgPath);
		let fileText = document.createTextNode(imgPath);
		aTag.appendChild(fileText);
		let deleteButton=document.createElement('button');
	    deleteButton.classList.add("delBtn");
	    deleteButton.addEventListener('click', (event) => {
	    	items.remove();
	    	event.preventDefault();
	    	deleteFile(fileCoursValues[j]);
	    });
		deleteButton.innerText="X";
		items.appendChild(aTag);
		items.appendChild(deleteButton);
		fileList.appendChild(items);
	}
	
	$("#classUpdate").on('click',function(){
		Swal.fire({
			title: '원데이클래스 업데이트가 성공헀습니다.',
			icon: 'success',
			showCancelButton: false,
			confirmButtonColor: '#7066e0',
			confirmButtonText: '확인'
		}).then((result)=>{
			$("#updateForm").submit();
		})
	})
	
	//사진 변경 버튼 클릭시
	$("#changePhoto").on('click',function(){
		console.log("사진 변경");
		Swal.fire({
			title: '첨부파일을 변경하시겠습니까?',
			text:'기존의 파일들은 삭제됩니다.',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
            confirmButtonText: '사용',
            cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				$("#photoArea").css('display','block');
				$("#changePhoto").css('display','none');
			}
		})
	})
	
	$("#photoCancelBtn").on('click',function(){
		$("#photoArea").css('display','none');
		$("#changePhoto").css('display','block');
	})
	
})

let selectedFiles = []; 
function fileChange(uploadFile) {
	let fileList = document.getElementById('uploadFileList');
	for(let i=0; i<uploadFile.length; i++) {
	    selectedFiles.push(uploadFile[i]);
	    let item=document.createElement( 'td');
	    let a = document.createElement('a');
		a.className = 'auth-link text-black';
		a.id = "imgBtn" + i;
		a.setAttribute('data-toggle', 'modal');
		a.setAttribute('data-target', '#imgModal');
		
		let fileURL = URL.createObjectURL(uploadFile[i]);
		a.onclick = function(){
			document.getElementById("modalImage").src = fileURL;
		}
		
		let linkText = document.createTextNode(uploadFile[i].name);
		a.appendChild(linkText);
	    let deleteButton=document.createElement('button');
	    deleteButton.classList.add("delBtn");
	    deleteButton.addEventListener('click', (event) => {
	    	item.remove();
	    	event.preventDefault();
	    	deleteFile(uploadFile[i]);
	    });
		deleteButton.innerText="X";
		item.appendChild(a);
		item.appendChild(deleteButton);
		fileList.appendChild(item);
	}
}
function deleteFile(deleteFile) {
	let inputFile = document.querySelector('input[name="files"]');
	let dataTransfer = new DataTransfer();
	selectedFiles = selectedFiles.filter(file => file!==deleteFile);
	// console.log("삭제버튼 " + deleteFile);
	selectedFiles.forEach(file => {
		dataTransfer.items.add(file);
	})
	inputFile.files = dataTransfer.files;
}
function updateFormSubmit(){
	Swal.fire({
		title: '원데이클래스 업데이트가 성공헀습니다.',
		icon: 'success',
		showCancelButton: false,
		confirmButtonColor: '#7066e0',
		confirmButtonText: '확인'
	}).then((result)=>{
		history.back();
	})
}
</script>
<div class="col-lg-8 container">
	<div class="card">
		<div class="card-body">
<%-- 			<p>vOndyclSchdulVO : ${vOndyclSchdulVO}</p> --%>
			<h2 id="modifyTitle" style="margin:20px 0 0 255px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">원데이 클래스 수정</h2>
			<h3 class="card-description" style="text-align:center; margin-top:150px;">🛠️  ${proSession.userNcnm} 님의 원데이클래스 수정페이지 입니다.</h3>
			<br>
			 <img src="../resources/images/팻말1.png" id="balloon" style=" opacity: 0.5; width: 500px; height:auto; margin:-180px 0 0 165px;">
			<form class="forms-sample" id="updateForm" name="updateForm" method="post"
				enctype="multipart/form-data" action="/onedayClass/updateOndycl">
				<input type="hidden" value="${vOndyclSchdulVO.ondyclNo}" id="ondyclNo" name="ondyclNo">
				<input type="hidden" id="proId" name="proId" value="${proSession.userId}">
				<input type="hidden" id="spcltyRealmNm" name="spcltyRealmNm" value="${proSession.spcltyRealmNm}">
				<input type="hidden" id="spcltyRealmCode" name="spcltyRealmCode" value="${proSession.spcltyRealmCode}">
				<input type="hidden" id="proProflPhoto" name="proProflPhoto">
				<div class="box_container">
					<div class="box">
						<div id="photoZone">
							<c:if test="${not empty vOndyclSchdulVO.ondyclThumbPhoto}">
								<img id="imgProfile" src="${vOndyclSchdulVO.ondyclThumbPhoto}"
										style="float: left;" />
							</c:if>
							<c:if test="${empty vOndyclSchdulVO.ondyclThumbPhoto}">
								<img id="imgProfile" src="/images/2024/profile.jpg"
									style="float: left;" />
							</c:if>
						</div>
						<div id="newPhoto" style="display: none;"></div>
						<div id="delPhoto" style="display: none;">
							<img id="imgProfile" src="/images/2024/profile.jpg"
									style="float: left;" />
						</div>
					</div>
				</div>
				<div class="form-group filebox" style="margin:-110px 0 20px 240px;">
					<div class="input-group">
						<span class="input-group-append">
							<input placeholder="썸네일을 등록해보세요" readonly required
								class=" upload-name form-control file-upload-info" style="width:300px;" />
							<label for="uploadProfile" id="lab" style="width:100px;">파일찾기</label> 
							<input type="file" id="uploadProfile" name="uploadProfile" accept=".gif, .jpg, .png"
								class="file-upload-browse btn btn-inverse-primary btn-fw">
						</span>
						<c:if test="${not empty vOndyclSchdulVO.ondyclThumbPhoto}">
							<button type='button' class='btn btn-inverse-link btn-fw photoDelete'>사진 삭제</button>
						</c:if>
						<button type='button' class='btn btn-inverse-link btn-fw photoDelete' id="delBtn" style="display:none;">사진 삭제</button>
					</div>
				</div>
				<div class="container">
					<label for="ondyclNm">✏️ 원데이클래스 제목</label>
					<div class="form-group input-group">
						<input type="text" class="form-control" id="ondyclNm" name="ondyclNm"
							placeholder="제목을 입력하세요" value="${vOndyclSchdulVO.ondyclNm}" required />
					</div>
					
					<label for=ondyclCn>📝 원데이클래스 상세내용</label>
					<div class="form-group input-group">
					<textarea rows="5" cols="120" id="ondyclCn" name="ondyclCn" class="form-control" placeholder="나만의 클래스를 설명해주세요." required>${vOndyclSchdulVO.ondyclCn}</textarea>
					</div>
					<table class="table table-hover">
						<tbody>
							<tr>
								<td>
									<label for="ondyclPsncpa">🙋‍♀️ 원데이클래스 정원 (현재 예약 인원 : ${vOndyclSchdulVO.ondyclResvpa} 명)</label>
									<div class="form-group input-group">
										<input type="number" class="form-control" value="${vOndyclSchdulVO.ondyclPsncpa}" id="ondyclPsncpa" name="ondyclPsncpa"
											placeholder="정원 입력" required />  <p style="margin:15px 0 0 10px;">명</p>
									</div>
								</td>
								<td colspan='2'>
									<label for="ondyclPc">💸 원데이클래스 희망가격</label>
									<div class="form-group input-group">
										<input type="number" class="form-control" value="${vOndyclSchdulVO.ondyclPc}" id="ondyclPc" name="ondyclPc"
											placeholder="금액 입력" required />  <p style="margin:15px 0 0 10px;">원</p>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ondyclSchdulDe">📆 시행날짜</label>
									<input type="hidden" value="${vOndyclSchdulVO.ondyclSchdulDe}" id="startDay">
									<div class="form-group input-group">
										<input type="date" class="form-control" id="ondyclSchdulDe" value=""
											name="ondyclSchdulDe" required />
									</div>
								</td>
								<td>
									<label for="ondyclSchdulBeginTime">⏰ 시작 예정시간</label>
									<div class="form-group input-group">
										<input type="time" class="form-control" id="ondyclSchdulBeginTime" value="${vOndyclSchdulVO.ondyclSchdulBeginTime}"
										name="ondyclSchdulBeginTime"
											placeholder="시작 예정시간" required />
									</div>
								</td>
								<td>
									<label for="ondyclSchdulDe">⏰ 종료 예정시간</label>
									<div class="form-group input-group">
										<input type="time" class="form-control" id="ondyclSchdulEndTime" name="ondyclSchdulEndTime" value="${vOndyclSchdulVO.ondyclSchdulEndTime}"
											placeholder="정원 입력" required />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ondyclSchdulDe">📮 우편번호</label>
									<div class="form-group input-group">
										<input type="text" readonly class="form-control" id="ondyclZip" name="ondyclZip" value="${vOndyclSchdulVO.ondyclZip}"
											placeholder="우편번호">
										<span class="input-group-append">
											<button type="button" id="zipSelect" class="file-upload-browse btn btn-inverse-primary btn-fw">우편번호 찾기</button>
										</span>
									</div>
								</td>
								<td>
									<label for="ondyclSchdulBeginTime">🚩 주소</label>
									<div class="form-group input-group">
										<input type="text" readonly class="form-control" id="ondyclAdres" name="ondyclAdres" value="${vOndyclSchdulVO.ondyclAdres}"
										placeholder="주소" required>
									</div>
								</td>
								<td>
									<label for="ondyclSchdulDe">🚩 상세주소</label>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="ondyclDetailAdres" name="ondyclDetailAdres" value="${vOndyclSchdulVO.ondyclDetailAdres}"
											placeholder="상세주소" required>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
                    <button class="btn btn-warning" id='changePhoto' type="button">사진 변경하기</button><br>
					<div class="form-group col-12" id='photoArea' style="display:none;">
		                <label>첨부파일</label>
		                <input type="file" id="uploadFile" multiple name="uploadFile" class="file-upload-default" onchange="fileChange(this.files)">
		                <div class="input-group col-xs-12">
<!-- 		                    <input type="text" class="form-control file-upload-info" disabled="" placeholder="파일선택"> -->
		                    <span class="">
		                    	<button class="file-upload-browse btn btn-primary" type="button">파일 선택</button>
		                    	<button class="btn btn-secondary" id='photoCancelBtn' type="button">취소</button>
		                    </span>
		                </div>
<!-- 		                <input type="text" class="form-control" readonly id="uploadFile"> -->
			            <div class="table-responsive" style="width:100%;">
<%-- 							<c:forEach var="sprviseAtchmnflVO" items="${sprviseAtchmnflVOList}" varStatus="stat"> --%>
<%-- 								<input type="text" class="fileCours" value="${sprviseAtchmnflVO.atchmnflCours}"> --%>
<%-- 							</c:forEach> --%>
							<table class="table table-striped">
								<tr id="uploadFileList">
									<td class='auth-link text-black'></td>
								</tr>
							</table>
						</div>
		            </div>
					<button type="button" id="classUpdate" class="btn btn-outline-primary btn-fw" style="float:right;">수정</button>
					<button type="reset" class="btn btn-light" style="float:right; margin:0 10px">취소</button>
					<img src="../resources/images/버튼.png" id="autoFilling"  style="width:50px; height:50px; float:right;">
				</div>
	<!-- 		<sec:csrfInpit /> -->
			</form>
		</div>
	</div>
</div>

<!-- 이미지 미리보기 Modal -->
<div class="modal fade" id="imgModal" tabindex="-1"
	aria-labelledby="pwModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">이미지 미리보기</h5>
				<button type="button" id="imgModalClose" data-dismiss="modal"><i class="mdi mdi-close-circle-outline icon-md"></i></button>
			</div>
			<div class="modal-body">
				<img id="modalImage" src="" style="width: 100%;" />
			</div>
		</div>
	</div>
</div>
