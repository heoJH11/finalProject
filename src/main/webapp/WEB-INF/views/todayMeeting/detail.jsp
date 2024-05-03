<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/skydash/vendors/font-awesome/css/font-awesome.min.css">
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

p{
font-family: 'GmarketSansMedium';	
}

.py-2::-webkit-scrollbar {
    width: 7px;
 }
   .py-2::-webkit-scrollbar-thumb {
    background-color: #8280c3ab;
    border-radius: 8px;
  }
  .py-2::-webkit-scrollbar-track {
    background-color: white;
    border-radius: 8px;
  }
  
  .card.rounded.mb-2 {
  margin-right: 7px;
  }
 
.nav-link.dropdown-toggle::after {
   	display: none;
}
ul.chatMemList {
	list-style-type: none;
}

ul.chatMemList li {
	overflow: hidden;
	margin-bottom: 1.5em;
	display: flex;
   	align-items: center;
   	
}

ul.chatMemList li img {
	width: 30px;
	height: 30px;
	margin-right: 10px;

}
.chatMemDiv {
	margin: 0px;
    width: 100%;
    display: inline-grid;
    align-items: end;
    justify-content: end;
}
/* .bg-primary, .settings-panel .color-tiles .tiles.primary { */
/*     background-color: #4b49ac9c; */
/* } */
</style>
<script type="text/javascript">

$(function() {
	let userId = `${tdmtngVO.userId}`;
	console.log(userId);
	
	let sessionId = `${sessionId}`;
	console.log(sessionId);
	
	if(userId == sessionId) {
		$("#btnsUpdate").css("display", "inline");	
	}
	
	if (sessionId == "not") {
        $("#btnPrctChat").css("display", "none");
    }
	
	if(sessionId!="not" && sessionId!=userId){
		$("#btnDecl").show();
	}
	
	let tdmtngMax = `${tdmtngVO.tdmtngMax}`;
	let chatMemCount = `${chatMemCount}`;
	console.log(tdmtngMax);
	console.log(chatMemCount);
	
	if(tdmtngMax == chatMemCount) {
		console.log("꽉 찼다!!");
		$("#btnPrctChat").css("display", "none");
		$("#fullMeeting").css("display", "block");
	}
	
	//모임 참여 여부
	let tdmtngNo = `${tdmtngVO.tdmtngNo}`;
	
	let myChatCk = {
			"userId" : sessionId,
			"tdmtngNo" : tdmtngNo
			}
	
	$.ajax({
        url: "/todayMeeting/selectMyChat",
        contentType: "application/json;charset=utf-8",
        type: "post",
        data: JSON.stringify(myChatCk),
        dataType: "json",
        success: function (tdmtngPrtcpntVO) {
        	console.log(tdmtngPrtcpntVO.tdmtngNo);
        	console.log(tdmtngNo);
        	if(tdmtngPrtcpntVO.tdmtngNo == tdmtngNo) {
        		console.log("참가중");
        		$("#btnPrctChat").css("display", "none");
        		$("#btnPrctedChat").css("display", "block");
        	} 
        	
        }
    });
	
	//모임 멤버 리스트
	$("#iconChatMem").on("click", function() {
		
		$("#chatMemList").html("");
		
		let tdmtngNo = `${tdmtngVO.tdmtngNo}`;

		console.log(tdmtngNo);
		
		$.ajax ({
			url: "/todayMeeting/chatMemList",
			type: "post",
			data: {"tdmtngNo" : tdmtngNo},
			dataType: "json",
			success: function(result) {
				console.log(result);
				
				let str ="";
				
				
				$.each(result, function(idx, tdmtngPrtcpntVO) {
					
					let mberPhoto = tdmtngPrtcpntVO.mberProflPhoto;
					let proPhoto = tdmtngPrtcpntVO.proProflPhoto;
					
					console.log("회원 프로필 사진", mberPhoto);
					console.log("프로 프로필 사진", proPhoto);		
	                 
	               	let emplyrTy = tdmtngPrtcpntVO.usersVOList[0].emplyrTy;
	                 
					if(emplyrTy == "ET01") emplyrTy = "회원";
	               	else if(emplyrTy == "ET02") emplyrTy = "프로";
					
					str += `<div class="card rounded mb-2">`;
					str += `<div class="card-body p-3">`;
					str += `<div class="media">`;
					if(mberPhoto == null && proPhoto != null) {
	        			
	        			console.log("프로 사진?")
	        			str += `<img src='\${proPhoto}' class="img-sm me-3 rounded-circle"></td>`;
	        			
	        		} else if(mberPhoto != null && proPhoto == null){
	        			console.log("멤버 사진?")
	        			str += `<img src='\${mberPhoto}' class="img-sm me-3 rounded-circle"></td>`;
	        		
	        		} else {
	        			console.log("없음 : "+ mberPhoto)
	        			str += `<img src='/images/2024/profile.jpg' class="img-sm me-3 rounded-circle"></td>`;
	        		}
					
					str += `<div class="media-body">`;
					str += `<h6 class="mb-1">\${tdmtngPrtcpntVO.usersVOList[0].userNcnm}(\${tdmtngPrtcpntVO.usersVOList[0].userId})</h6>`;
                    str += `<p class="mb-0 text-muted">\${emplyrTy}</p>`;
                    str += `</div></div></div></div>`;  
				})
				$("#chatMemList").append(str);
			}
			
		})
	})

	//모임 참여 버튼 이벤트 -- 재훈 수정 필요하면  수정 해도 됨
	$("#btnPrctChat").on("click", function() {
		
		let aftusBbscttNo = $("#aftusBbscttNo").val();
		Swal.fire({
			title: '모임에 참여 하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonText: '확인',
	        cancelButtonText: '취소',
	        reverseButtons: false,
		}).then((result) => {
			if (result.isConfirmed) {

				let tdmtngMax = `${tdmtngVO.tdmtngMax}`;
				console.log(chatMemCount);
				console.log(tdmtngMax);
				
				$.ajax({
					url: "/todayMeeting/joinChat",
					type: "post",
					data: {"tdmtngNo" : tdmtngNo},
					dataType: "json",
					success: function(result) {
						
						document.location.reload(true);

						$(".tyn-quick-chat").addClass("active");
						
						$("#btnPrctChat").css("display", "none");
						$("#btnPrctedChat").css("display", "block");
		        		
	                    chatMemCount++;
	          
	                    $("#chatMemCount").text(`현재 인원(\${chatMemCount}/\${tdmtngMax})`);
	                    
	                    if(tdmtngMax == chatMemCount) {
	                		
	                		$("#fullMeeting").css("display", "block");
	                	}
		        		
					}
				})
			}
		})
	})
	window.onload = function(){
		
		$(".tyn-quick-chat").addClass("active");
	}
	
	//수정하기
	$("#btnTmtEdit").on("click", function() {
		
		let tdmtngDt = $("#tdmtngDt").val();
		console.log(tdmtngDt);
		
		let formattedTdmtngDt = tdmtngDt.replace(/\./g, '-').replace(' ', 'T') + ':00';

		console.log(formattedTdmtngDt);
		$("#tdmtngDt").val(formattedTdmtngDt);
		$(".notUdt").css("display", "none");
		$("#chatMemDiv").css("display", "none");
		$("#tmtUdtFormDiv").css("display", "block");
		$("#tdmtngCn").css("display", "block");
		$(".btnsdetail").css("display", "none");
		$("#btnsCkUpdate").css("display", "block");
 		$("#imgUpDiv").css("display", "block");
 		$("#imgPreDiv").css("display", "block");
		$("#tdmtngDt").prop("type", "datetime-local");
		$(".tmtDetail").removeAttr("readonly");
		
		$("#uploadFile").on("change", function() {
			$("#imgDiv").css("display", "none");
		});
		
		$("#uploadFile").on("change",handleImgFileSelect);
		function handleImgFileSelect(e){
			
			$("#existingImg").css("display", "none");
			
			let files = e.target.files;
			
			console.log(files);
			let fileArr = Array.prototype.slice.call(files);
		
			fileArr.forEach(function(f){
				//이미지 파일이 아닌 경우 이미지 미리보기 실패 처리(MIME타입)
				console.log(f);
				if(!f.type.match("image.*")){
					Swal.fire({
				          icon: 'error',
				          title: '이미지 파일만 가능합니다',
				          confirmButtonText: '확인',
				        }).then((result) => {
							if (result.isConfirmed) {
								$("#file-upload-info").val("");
							}
						})
					return;
				}
				//이미지 객체를 읽을 자바스크립트의 reader 객체 생성
				let reader = new FileReader();
				
				$(".clsCiImgUrl").html("");
				
				//e : reader가 이미지 객체를 읽는 이벤트
				reader.onload = function(e){
					$(".clsCiImgUrl").css({
				          "background-image": "url(" + e.target.result + ")",
				          "background-position": "center",
				          "background-size": "cover",
				          "width": "500px",
				          "height": "500px"
				    });
//	 				
				}
				//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
				reader.readAsDataURL(f);
			});//end forEach
		}
	})
	
	//삭제
	$("#btnTmtDel").on("click", function() {
		location.href = "/todayMeeting/delete?tdmtngNo="+${tdmtngVO.tdmtngNo};
	})
	
	//목록
	$("#btnTmtList").on("click", function() {
		location.href = "/todayMeeting/main";
	})
	
	//수정 화면에서 취소 버튼 클릭시
    $("#btnTmtCancel").on("click", function() {
    	location.href = "/todayMeeting/detail?tdmtngNo="+${tdmtngVO.tdmtngNo};
    })
	

})
</script>

<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div style="display: flex; flex-wrap: wrap;">
					<img id="btnDecl" src="../resources/images/사이렌2.png" style="width: 25px; margin: 20px 0px 5px 1230px; display: none;"
						data-toggle="modal" data-target="#modal-sm"/>
				</div>
				<div class="card-body">
					<form action="/todayMeeting/update" class="forms-sample" name="tmtUpdate" method="post" enctype="multipart/form-data">
						<div class="container-fluid notUdt">
							<input type="hidden" id="tdmtngNo" name="tdmtngNo" value="${tdmtngVO.tdmtngNo}">
							<h2 class="text-center my-5" style="font-family: GMarketSansMedium">${tdmtngVO.tdmtngNm}</h2>
							<div style="margin-left: 76%;">
								<p style="font-family: GMarketSansLight; display: inline; margin-right: 40px; font-size:20px;">모임장</p>
								<p style="display: inline; font-size:15px;">${tdmtngVO.userNcnm}</p>
								<br />
								<p style="font-family: GMarketSansLight; display: inline; margin-right: 20px; font-size:20px;">작성일시</p>
								<p style="display: inline; font-size:15px;">${tdmtngVO.tdmtngCreatDt}</p>
								<br />
								<p style="font-family: GMarketSansLight; display: inline; margin-right: 20px; font-size:20px;">모임일시</p>
								<p style="display: inline; font-size:15px;">${tdmtngVO.tdmtngDt}</p>
							</div>
							<hr>
						</div>
						<div class="container-fluid w-100 notUdt">
							<div class="form-group chatMemDiv">
				            	<div class="dropdown" id="fileGroup" style="margin-right:0px;">
				            	<button type="button" class="btn btn-inverse-primary" 
				            		data-toggle="dropdown" id="iconChatMem" style="margin-right:5px; padding: 8px;">
				            		<img src="/resources/images/모임인원아이콘.png" style="height:50px; float:left;">
				            		<p id="chatMemCount" style="margin-left: 30px; margin-top: 5px; margin-bottom: 5px;">현재 인원
				            		(${chatMemCount}/${tdmtngVO.tdmtngMax})</p>
				            		</button>
				            		<div class="dropdown-menu" aria-labelledby="dropdownMenuIconButton6" 
				            			style="min-width: 20rem; background: none; border: none;">	
										<div class="col-md-6 h-100" style="max-width: 100%; background: #a3a8da75;">
					                      	<div class="p-4 rounded" style="height:100%;">
					                        	<h6 class="card-title text-white">모임 멤버</h6>
					                        	<div class="py-2" id="chatMemList" style="overflow-y: auto; max-height: 257px;">
					                        	</div>
					                      	</div>
					                    </div>
				                	</div>
				            	</div>
				            </div>
				    		<pre class="mb-5" style="font-family: GmarketSansLight; padding-left: 20px; font-size: 1.1rem; background: none;">${tdmtngVO.tdmtngCn}</pre>	
				            <div id="imgDiv" class="form-group" style="max-width: 700px">
				                <img src="${tdmtngVO.tdmtngThumbPhoto}" class="img-fluid mb-2" onerror="this.style.display='none'">
				            </div>	       		
				            <hr>
				            <h6 id="fullMeeting" style="display: none">※ 정원 초과로 마감된 모임 입니다.</h6>
						</div>
						
						<!-- 수정 버튼 클릭시 보이게 하기 -->
						<div class="container-fluid" id="tmtUdtFormDiv" style="display: none;">
							<div style="display: flex;">
								<div class="form-group col-6" style="padding-left: 0px;">
									<label for="tdmtngNm">모임명</label>
									<input type="text" class="form-control" id="tdmtngNm" name="tdmtngNm" value="${tdmtngVO.tdmtngNm}">
								</div>
						        <div class="form-group col-4">
						            <label for="tdmtngDt">모임일시</label>
						            <input type="text" class="form-control" id="tdmtngDt" name="tdmtngDt" value="${tdmtngVO.tdmtngDt}">
						        </div>
						        <div class="form-group col-2" style="padding-right: 0px;">
						        	<label for="tdmtngMax">정원</label>
						            <input type="number" class="form-control" id="tdmtngMax" name="tdmtngMax" value="${tdmtngVO.tdmtngMax}">
						        </div>
					        </div>
					        <div class="form-group" style="padding-left: 0px;">
								<label for="tdmtngCn">내용</label>
								<textarea class="form-control" rows="10" id="tdmtngCn" name="tdmtngCn"
									style="display: none;">${tdmtngVO.tdmtngCn}</textarea>	
							</div>
							<div id="existingImg" class="form-group" style="max-width: 700px">
				                <img src="${tdmtngVO.tdmtngThumbPhoto}" class="img-fluid mb-2" onerror="this.style.display='none'">
				            </div>
				            <div id="imgPreDiv" class="clsCiImgUrl  col-xs-12">
							</div>    
							<div id="imgUpDiv" class="form-group">
				                <label>이미지 파일</label>
				                <input type="file" id="uploadFile" name="uploadFile" class="file-upload-default" >
				                <div class="input-group col-xs-12">
				                    <input type="text" id="file-upload-info" class="form-control file-upload-info" disabled="" placeholder="파일선택">
				                    <span class="input-group-append">
				                        <button class="file-upload-browse btn btn-primary" type="button">업로드</button>
				                    </span>
				                </div>
				            </div>
				            <hr>
				            <div id="btnsCkUpdate" style="display: none;">
								<button type="submit" id="btnTmtCkEdit" class="btn btn-primary mr-2">확인</button>
								<button type="button" id="btnTmtCancel" class="btn btn-light">취소</button>
							</div>
						</div>
						<!-- 수정 버튼 클릭시 보이게 하기 끝 -->				
						<div class="container-fluid w-100 btnsdetail" style="display: flex; flex-wrap: wrap; float: right;">							
							<button type="button" class="btn btn-primary" id="btnPrctChat" style="margin-right:5px;">모임 참여</button>
            				<button type="button" class="btn btn-primary" id="btnPrctedChat" disabled style="display: none; margin-right:5px;">참여중</button>
							<div id="btnsUpdate" style="display: none; margin-right: 5px;">
								<button type="button" id="btnTmtEdit" class="btn btn-outline-primary">수정</button>
								<button type="button" id="btnTmtDel" class="btn btn-outline-primary">삭제</button>
							</div>
								<button type="button" class="btn btn-outline-secondary" id="btnTmtList" style="margin-right:5px;">목록</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>

