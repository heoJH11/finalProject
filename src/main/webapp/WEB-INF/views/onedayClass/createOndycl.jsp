<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	margin-top:20px;
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
	if($("#proId").val() == null || $("#proId").val() == ""){
		Swal.fire({
            title: '프로 로그인 후 이용한 서비스 입니다.',
            icon: 'warning',
            showCancelButton: false,
			confirmButtonColor: '#7066e0',
            confirmButtonText: '확인',
        }).then((result) => {
			location.href="/onedayClass/main";
        })
	}
	//프로필사진 삭제
	$("#photoDelete").on("click",function(){
		var userId = $("#userId").val();
		Swal.fire({
			title: '프로필 사진을 삭제하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
            confirmButtonText: '사용',
            cancelButtonText: '취소'
		}).then((result)=>{
			if(result.isConfirmed){
				Swal.fire({
		            title: '사진 삭제 성공!!',
		            icon: 'success',
		            showCancelButton: false,
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		        }).then((result) => {
					$("#photoDelete").css("display","none");
					$("#newPhoto").css("display","none");
					$("#photoZone").css("display","block");
					$(".upload-name").val("");
					$("#proProflPhoto").val("");
					$("#pfPhoto").val("");
		        })
			}
		})
	}) //프로필 사진 삭제 끝
	
	$("#uploadProfile").on("change",function(){
		var fileName = $("#uploadProfile").val();
		$(".upload-name").val(fileName.split('/').pop().split('\\').pop());
		$("#proProflPhoto").val(fileName);
		$("#photoDelete").css("display","block");
		
// 		let inputFile = document.getElementById("uploadProfile");
// 		var fReader = new FileReader();
// 		fReader.readAsdataURL(inputFile.files[0]);
// 		fReader.onloadend = function(event){
// 			var img = document.getElementById("imgProfile");
// 			img.src = event.target.result;
// 			console.log("path : ",event.target.result);
// 		}
	});
	
	$("#uploadProfile").on("change",imgCk);
	function imgCk(e){
		let files = e.target.files;
		
		console.log(files);
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
		str = `
			헤어디자인은 사회적으로도 매우 중요한 역할을 하고 있습니다. 사람들은 외모에 신경을 많이 쓰고, 헤어 스타일은 이들의 외모와 자신감에 큰 영향을 미치기도 합니다. 상황에 따라 필요한 헤어 스타일이 각양각색이기도 하며 개인의 이미지를 나타내는 요소가 되었습니다. 그 역할이 전문화되고 찾는 이들이 많아지면서 헤어디자이너에 대한 수요는 지속적인 추세를 보이고 있습니다. 미용사의 지위와 대우가 향상됨과 함께  안정적인 취업 기회를 가지게 되었습니다.
			<br><br>
			◈ 취업 경쟁력과 기회 확대<br>
			많은 미용실이 자격증을 가진 실력 있는 미용사를 선호하며, 자격증을 보유한 사람들은 경쟁력 있는 취업 기회를 얻을 수 있습니다. 국가가 공인하는 기술 자격증이기 때문에 헤어 미용 분야에서 필요한 전문적인 기술과 지식을 보유하고 있음을 보여주고 업계의 인정을 받습니다. 또한 고객들에게 헤어 디자인, 컷팅, 염색 등 다양한 서비스를 전문적으로 제공할 수 있는 자격을 가지고 있다는 신뢰를 얻을 수 있습니다.
			<br><br>
			◈ 업무 확장과 창업 자격<br>
			자격증을 보유한 사람들은 미용실에서의 업무뿐만 아니라, 자신의 미용실을 창업하거나 관련 분야에서 다양한 경로로 활동할 수 있는 기회를 얻을 수 있습니다. 공중위생법상 미용사가 되려는 자는 미용사 자격 취득 후  시∙도지사의 면허를 받을 수 있습니다. 미용업 창업 시에는 면허가 필수로 요구됩니다. 또한 자격증 보유자는 7년 이상 실무 종사 경력이 인정되면 최상위 자격 '미용장' 시험에 응시할 수 있게 됩니다.
			<br><br>
			헤어디자이너가 갖춰야 할 필수적인 기술은 크게 헤어 커트, 헤어 컬러링, 헤어 스타일링, 헤어 케어로 볼 수 있습니다. 모든 내용에 대해 이론부터 실전 기술까지 습득할 수 있는 자격증 과정과 함께 각각의 역량을 보다 심도 있게 배우고 훈련할 수 있는 단과/심화 과정도 활발히 운영되고 있습니다. 헤어미용자격증 취득과 함께 특기를 살릴 수 있는 교육도 함께 받는다면 취,창업 시 헤어디자이너로서 경쟁력을 갖출 수 있을 것입니다.
			<br><br>
			◈ 헤어디자인 주요 강의 핵심 내용<br>
			▶ 헤어 국가자격증 과정 <br>
			 필기 검정이론, 커트, 퍼머넌트, 두피스케일링&샴푸, 헤어 컬러링, 블로드라이&롤 세팅<br><br>
			▶ 헤어 현장실무 과정<br>
			 펌(일반 디자인 펌, 특수 펌 등 트렌드 펌), 아이론 기법을 통한 업스타일, 블로우 드라이, 컬러링, 컷 등 전반적인 살롱테크닉<br><br>
			▶ 업스타일 과정<br>
			 업스타일자격증, 볼륨드라이, 매직드라이, 웨딩업스타일, 혼주업스타일<br><br>
			▶ 헤어 커트 과정<br>
			 기본 이론, 베이직 컷, 트렌드 컷, 종류별 원랭스 컷, 보브커트 응용 레이어 커트기법<br><br>
			▶ 헤어 컬러링 과정 <br>
			 모발 생리학, 컬러링 차트 이론과 조제방법, 컬러링(염색과 탈염기법 및 반사 빛 다운기법) 등 살롱테크닉<br><br>
			▶ 헤어 대회반<br>
			 응용 펌&커트 디자인, 의상&오브제 제작, 대회 출전<br><br>
			◈ 기술만큼 중요한 헤어디자이너의 필수 역량 2가지<br>
			1. 상담 및 커뮤니케이션 <br>
			헤어디자이너는 고객과의 상담 및 소통 기술을 가져야 합니다. 고객의 요구와 선호도를 이해하고, 고객의 얼굴 형태, 피부톤, 생활 스타일 등을 분석하여 맞춤형 헤어 스타일을 제안합니다. 상담 및 소통 기술은 고객과의 원활한 대화와 요구 사항의 이해를 통해 고객의 만족도를 높이는 역할을 합니다.
			<br><br>
			2. 트렌드 및 시장 이해<br>
			헤어디자이너는 헤어 트렌드와 시장 동향을 파악하고 이를 활용하는 능력을 가져야 합니다. 업계의 변화를 주시하며 새로운 헤어 스타일과 기술을 습득하고, 고객들에게 최신 트렌드에 부응하는 서비스를 제공합니다.

		`;
		
		$("#ondyclNm").val("헤어 클리닉 기본부터 잡고가자!");
		$("#ondyclCn").val(str);
		$("#ondyclPc").val("78000");
		$("#ondyclPsncpa").val("5");
		$("#ondyclSchdulDe").val("2024-04-17");
		$("#ondyclSchdulBeginTime").val("13:00");
		$("#ondyclSchdulEndTime").val("16:30");
		$("#ondyclDetailAdres").val("대덕인재개발원");
		$("#ondyclAdres").val("대전 중구 계룡로 846");
		$("#ondyclZip").val("34908");
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
})
let selectedFiles = []; 
function fileChange(uploadFile) {
	const fileList = document.getElementById('uploadFileList');
	for(let i=0; i<uploadFile.length; i++) {
	    selectedFiles.push(uploadFile[i]);
	    const item=document.createElement( 'td');
	    const a = document.createElement('a');
		a.className = 'auth-link text-black';
		a.id = "imgBtn" + i;
		a.setAttribute('data-toggle', 'modal');
		a.setAttribute('data-target', '#imgModal');
		
		const fileURL = URL.createObjectURL(uploadFile[i]);
		a.onclick = function(){
			document.getElementById("modalImage").src = fileURL;
		}
		
		const linkText = document.createTextNode(uploadFile[i].name);
		a.appendChild(linkText);
	    const deleteButton=document.createElement('button');
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
	const inputFile = document.querySelector('input[name="files"]');
	const dataTransfer = new DataTransfer();
	selectedFiles = selectedFiles.filter(file => file!==deleteFile);
	selectedFiles.forEach(file => {
		dataTransfer.items.add(file);
	})
	inputFile.files = dataTransfer.files;
}

</script>
<div class="col-lg-8 container">
	<div class="card">
		<div class="card-body">
			 <h2 id="modifyTitle" style="margin:20px 0 0 255px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">원데이 클래스 등록</h2>
			<h3 class="card-description" style="text-align:center; margin-top:150px;">✨😉 ${proSession.userNcnm} 님만의 원데이클래스를 등록해보세요.</h3>
			<br>
			 <img src="../resources/images/팻말1.png" id="balloon" style=" opacity: 0.5; width: 500px; height:auto; margin:-180px 0 0 165px;">
			<form class="forms-sample" id="insertForm" name="insertForm" method="post"
				enctype="multipart/form-data" action="/onedayClass/createOndycl">
				<input type="hidden" id="proId" name="proId" value="${proSession.userId}">
				<input type="hidden" id="spcltyRealmNm" name="spcltyRealmNm" value="${proSession.spcltyRealmNm}">
				<input type="hidden" id="spcltyRealmCode" name="spcltyRealmCode" value="${proSession.spcltyRealmCode}">
				<input type="hidden" id="proProflPhoto" name="proProflPhoto">
				<div class="box_container">
					<div class="box">
						<div id="photoZone">
							<img id="imgProfile" src="/images/2024/profile.jpg"
									style="float: left;" />
						</div>
						<div id="newPhoto" style="display: none;"></div>
					</div>
				</div>
				<div class="form-group filebox" style="margin:-110px 0 20px 240px;">
					<div class="input-group">
						<span class="input-group-append">
							<input placeholder="썸네일을 등록해보세요" readonly required
								class=" upload-name form-control file-upload-info" style="width:300px;" />
							<label for="uploadProfile" id="lab" style="width:100px;">파일찾기</label> 
							<input type="file" id="uploadProfile" name="uploadProfile" accept=".gif, .jpg, .png"
								class="file-upload-browse btn btn-inverse-primary btn-fw"></button>
						</span>
						<button type='button' class='btn btn-inverse-link btn-fw'
										id='photoDelete' style="display:none;">사진 삭제</button>
					</div>
				</div>
				<div class="container">
					<label for="ondyclNm">✏️  원데이클래스 제목</label>
					<div class="form-group input-group">
						<input type="text" class="form-control" id="ondyclNm" name="ondyclNm"
							placeholder="제목을 입력하세요" required />
					</div>
					
					<label for=ondyclCn>📝 원데이클래스 상세내용</label>
					<div class="form-group input-group">
					<textarea rows="5" cols="120" id="ondyclCn" class="form-control" placeholder="나만의 클래스를 설명해주세요." name="ondyclCn" required></textarea>
					</div>
					<table class="table table-hover">
						<tbody>
							<tr>
								<td>
									<label for="ondyclPsncpa">🙋‍♀️ 원데이클래스 정원</label>
									<div class="form-group input-group">
										<input type="number" class="form-control" id="ondyclPsncpa" name="ondyclPsncpa"
											placeholder="정원 입력" required /> <p style="margin:15px 0 0 10px;">명</p>
									</div>
								</td>
								<td colspan='2'>
									<label for="ondyclPc">💸 원데이클래스 희망가격</label>
									<div class="form-group input-group">
										<input type="number" class="form-control" id="ondyclPc" name="ondyclPc"
											placeholder="금액 입력" required /> <p style="margin:15px 0 0 10px;">원</p>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<label for="ondyclSchdulDe">📆 시행날짜</label>
									<div class="form-group input-group">
										<input type="date" class="form-control" id="ondyclSchdulDe"
											name="ondyclSchdulDe" required />
									</div>
								</td>
								<td>
									<label for="ondyclSchdulBeginTime">⏰ 시작 예정시간</label>
									<div class="form-group input-group">
										<input type="time" class="form-control" id="ondyclSchdulBeginTime"
										name="ondyclSchdulBeginTime"
											placeholder="시작 예정시간" required />
									</div>
								</td>
								<td>
									<label for="ondyclSchdulDe">⏰ 종료 예정시간</label>
									<div class="form-group input-group">
										<input type="time" class="form-control" id="ondyclSchdulEndTime" name="ondyclSchdulEndTime"
											placeholder="정원 입력" required />
									</div>
								</td>
							</tr>
							
							<tr>
								<td>
									<label for="ondyclSchdulDe">📮 우편번호</label>
									<div class="form-group input-group">
										<input type="text" readonly class="form-control" id="ondyclZip" name="ondyclZip"
											placeholder="우편번호">
										<span class="input-group-append">
											<button type="button" id="zipSelect" class="file-upload-browse btn btn-inverse-primary btn-fw">우편번호 찾기</button>
										</span>
									</div>
								</td>
								<td>
									<label for="ondyclSchdulBeginTime">🚩 주소</label>
									<div class="form-group input-group">
										<input type="text" readonly class="form-control" id="ondyclAdres" name="ondyclAdres"
										placeholder="주소" required>
									</div>
								</td>
								<td>
									<label for="ondyclSchdulDe">🚩 상세주소</label>
									<div class="form-group input-group">
										<input type="text" class="form-control" id="ondyclDetailAdres" name="ondyclDetailAdres"
											placeholder="상세주소" required>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
<!-- 					<a class="auth-link text-black"  data-toggle="modal" data-target="#idModal">아이디 찾기</a> -->
					<div class="form-group">
		                <label>이미지 파일</label>
		                <input type="file" id="uploadFile" multiple name="uploadFile" class="file-upload-default" onchange="fileChange(this.files	)">
		                <div class="input-group col-xs-12">
<!-- 		                    <input type="text" class="form-control file-upload-info" disabled="" placeholder="파일선택"> -->
		                    <span class="">
		                        <button class="file-upload-browse btn btn-primary" type="button">업로드</button>
		                    </span>
		                </div>
<!-- 		                <input type="text" class="form-control" readonly id="uploadFile"> -->
			            <div class="table-responsive">
							<table class="table table-striped">
								<tr id="uploadFileList">
								</tr>
							</table>
						</div>
		            </div>
					
					<button type="submit" id="proInsert" class="btn btn-outline-primary btn-fw" style="float:right;">등록</button>
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
