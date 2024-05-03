<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/imageDetail.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<style>
    .thumbnail-container {
        position: relative;
        display: inline-block;
    }
    .delete-icon {
        position: absolute;
        top: 0px;
        right: 5px;
        cursor: pointer;
        display: none;
    }
    .thumbnail-container:hover .delete-icon {
        display: block;
    }
</style>
<%-- ${oneInqryVO} --%>
<%-- ${loginId} --%>
		<!-- 제목 -->
		<div >
			<img alt="1대1" src="../resources/images/상담.png" style="width:100px; height:auto; margin:20px 0 20px 740px;">
			<h2 id="InqryTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">1:1 문의 관리</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
			<br><br>
		</div>
<div class="col-12">
	<div class="card">
		<div class="card-body" >
			<h3 class="card-title" id="oneInqrySj">${oneInqryVO.oneInqrySj}</h3>
			<p class="card-description"><fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${oneInqryVO.oneInqryWritngDt}"/></p>
			<hr />
			<div class="row">
				<div class="col-md-10 mx-auto">
					<div class="tab-content tab-content-custom-pill" id="pills-tabContent-custom">
						<form id="oneInqryUpdateFrm" action="/oneInqry/oneInqryUpdatePost" method="post" enctype="multipart/form-data">
						<!-- form 시작 -->
							<!-- form으로 보내는 정보 -->
							<input type="hidden" id="oneInqryNo" name="oneInqryNo" value="${oneInqryVO.oneInqryNo}" />
							<input type="hidden" id="hiddenOneInqrySj" name="hiddenOneInqrySj" value="" />
							<input type="hidden" id="atchmnflNo" name="atchmnflNo[]" value=""/>
							<input type="hidden" id="sprviseAtchmnflNo" name="sprviseAtchmnflNo" value="${oneInqryVO.sprviseAtchmnflNo}" />
							<!-- 요청서 본문 -->
							<div>
								<!-- 요청서 이미지 -->
								<div class="d-flex mb-4" id="oneInqryImages" style="white-space: nowrap;">
									<div id="imageList" class="d-flex flex-wrap">
									<c:forEach var="sprviseAtchmnflVO" items="${oneInqryVO.sprviseAtchmnflVOList}" varStatus="status">
										<c:choose>
											<c:when test="${sprviseAtchmnflVO.atchmnflNo == 0 }">
											</c:when>
											<c:otherwise>
												<li style="list-style-type: none; display: inline-block; margin-right: 10px;">
													<div class="thumbnail-container">
														<a href="#modalPicture"
															data-picture-url="${sprviseAtchmnflVO.atchmnflCours}"
															data-toggle="modal"> <img class="prServiceThumb"
															src="${sprviseAtchmnflVO.atchmnflCours}"
															style="width: 150px; height: 130px; border-radius: 20%; margin-right: 10px; margin-top: 10px;" />
															<span class="delete-icon" data-index="${sprviseAtchmnflVO.atchmnflNo}" style="display: none;"><i class='mdi mdi-close'></i></span>
														</a>
													</div>
												</li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									</div>
									<div class="form-group modifyFile">
					                    <input type="file" name="uploadFiles" id="uploadFiles" class="file-upload-default" multiple>
					                    <div class="input-group col-xs-12 d-flex align-items-center">
				    	                        <button class="file-upload-browse btn btn-outline-primary" type="button" id="modifyFileBtn"
				        	                    	style="display:none; width: 150px; height: 130px; border-radius: 20%; margin-right: 10px; margin-top: 10px;">
				            	                	<i class="mdi mdi-plus"></i></button>
				                	    </div>
				                	</div>
								</div>
								<pre style="background: transparent;" id="oneInqryCn"><c:out value="${oneInqryVO.oneInqryCn}"/></pre>
							</div>
						</form>
						<!-- form 끝 -->
						<!-- 답글 -->
						<c:choose>
							<c:when test="${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn != null}">
								<hr /> 
								<div class="mb-3 oneInqryAnswerCn form-group">
					            	<label for="oneInqryAnswerCn" class="col-form-label">문의 답글</label>
					            	<p class="card-description"><fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerWrDt}"/></p>
				    	        	<div id="oneInqryAnswerCn">
				    	        		<pre style="background: transparent; height: 100%;" class="form-control"><c:out value="${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn}"/></pre>
				    	        	</div>         	
								</div>
							</c:when>
							<c:when test="${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn == null && loginId == 'admin'}">
							    <div class="mb-3 oneInqryAnswerCn">
							        <label for="oneInqryAnswerCn" class="col-form-label">문의 답글</label>
							        <textarea class="form-control" id="oneInqryAnswerCn" name="oneInqryCn" placeholder=" 답글을 등록해주세요" rows="2" cols="100" wrap="hard" style="resize: none;"></textarea>
							    </div>
							</c:when>
<%-- 							<c:when test="${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn == null}"> --%>
							<c:otherwise>
								<div class="mb-3 oneInqryAnswerCn">
					            	<label for="oneInqryAnswerCn" class="col-form-label">문의 답글</label>
				    	        	<div class="form-control" id="oneInqryAnswerCn">등록된 답글이 없습니다.</div>	
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
         	<hr />
        	<!-- 버튼 -->
         	<div style="display: flex; flex-wrap: wrap;">
				<button type="button" class="btn btn-inverse-secondary clsBtn" id="clsBtn">닫기</button>
<!-- 				프로 답글 등록 버튼 -->
				<button type="button" class="btn btn-inverse-primary" id="answerChkBtn" 
					onclick="chkBtn('${oneInqryVO.oneInqryNo}','insert')" style="display: none; margin-right: 5px;">등록</button>
<!-- 				이용자 문의 수정 버튼 -->
				<button type="button" class="btn btn-inverse-primary" id="modifyChkBtn"
					 onclick="javascript:modifyChkBtn('${oneInqryVO.oneInqryNo}')" style="display: none; margin-right: 5px;">수정</button>
				<button type="button" class="btn btn-inverse-primary" id="modifySuccessBtn"
					 onclick="chkBtn('${oneInqryVO.oneInqryNo}','modify')" style="display: none; margin-right: 5px;">완료</button>
				<button type="button" class="btn btn-inverse-secondary" id="cancelBtn" style="display: none;">취소</button>	
			</div>
		</div>
	</div>
</div>
<!-- 이미지 확대 보기 모달  -->
<div class="modal fade" id="modalPicture" tabindex="-1" aria-labelledby="exampleModalLabel-2" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalPicTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modalPicBody">
                <ul id="ulPrt">
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal" id="clsBtn">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function(){
	var loginId = "${loginId}";
	console.log("loginId", loginId);
	 
	//프로의 문의 답글 등록 버튼
	if(loginId == "admin" && ${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn == null} ){
		console.log("관리자다!");
		$("#answerChkBtn").css("display","block");
		$('#oneInqryAnswerCn').html("");
		str = "<textarea class='form-control' id='oneInqryAnswerCn' name='oneInqryCn' placeholder=' 답글을 등록해주세요' rows='2' cols='100'";
		str += "wrap='hard' style='resize: none;'></textarea>"
	}
	// 답글 등록 전 회원 문의 수정
	if(${oneInqryVO.oneInqryAnswerVOList[0].oneInqryAnswerCn == null} && loginId != "admin" ){
		console.log("회원이다!");
		$("#modifyChkBtn").css("display","block");
	}else{
		
	}
});

$(".clsBtn").on("click",function(){
	window.location.href="/manage/oneInqryList";
});

// 버튼 확인 alert
function chkBtn(no,fnc){
	if(fnc == "insert"){
	Swal.fire({
        title: "답글을 등록하시겠습니까?",
        text: "등록 완료 후 변경은 불가합니다.",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "등록 완료"
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: "등록 완료!",
                icon: "success"
            }).then(() => {
                oneInqryAnswerBtn(no);
            });
        }
    });
	
	}else if(fnc == "modify"){
		Swal.fire({
	        title: "내용을 수정하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonText: "수정 완료"
	    }).then((result) => {
	        if (result.isConfirmed) {
	            Swal.fire({
	                title: "수정 완료!",
	                icon: "success"
	            }).then(() => {
	            	var newBtfInqrySj = $("#newOneInqrySj").val();
	            	console.log("새로운 제목 : ",newBtfInqrySj);
	            	$("#hiddenOneInqrySj").val(newBtfInqrySj);
	                $("#oneInqryUpdateFrm").submit();
	            });
	        }
	    });	
	}	
}


// 관리자 답글 등록
function oneInqryAnswerBtn(no){
	console.log("답글 확인 번호 : ", no);
	var btfIqnryAnswerCn =	$("#oneInqryAnswerCn").val();
	var userId = "${param.userId}";
	
	var param = {
			"oneInqryAnswerCn" : btfIqnryAnswerCn,
			"oneInqryNo" : no,
			"userId" : userId
			}

	console.log("보낼 데이터들", param);
	$.ajax({
		url:"/oneInqry/updateAnswer",
		contentType : "application/json;charset=utf-8",
		type : "post",
		data : JSON.stringify(param),
		dataType : "json",
		success : function(res){
			console.log("답글 업데이트 결과", res);
			if(res == 1){
				// 입력한 내용을 input에서 div로 바꾸기
				window.location.reload();
			}
		}
	});
}

$("#cancelBtn").on("click",function(){
	window.location.reload();
});

//회원 문의 수정
function modifyChkBtn(no){
	console.log("수정 버튼");
	// 닫기(리스트 돌아가기) 버튼 안보기
	$("#clsBtn").css("display", "none");
	// 수정 버튼 숨기기
	$("#modifyChkBtn").css("display", "none");
	// 수정 취소 버튼 보이기
	$("#cancelBtn").css("display", "block");
	// 수정 완료 버튼 보이기
	$("#modifySuccessBtn").css("display", "block");
	// 기존 이미지 삭제 아이콘 보이기
	$(".delete-icon").css("display", "block");
	// 새로운 파일 업로드 버튼 보이기
	$("#modifyFileBtn").css("display", "block");
	// 등록되지 않은 답글 숨기기
	$(".oneInqryAnswerCn").css("display", "none");
	
	// 제목 수정 
	var oldOneInqrySj = $("#oneInqrySj").text();
	$("#oneInqrySj").html("<input type='text' class='form-control' id='newOneInqrySj' name='newBtfInqrySj' value='"+oldOneInqrySj+"' />");
	// 내용 수정 
	var oldOneInqryCn = $("#oneInqryCn").text();
	$("#oneInqryCn").html("<textarea id='newBtfInqryCn' name='newOneInqryCn' class='form-control' col='100' wrap='hard' style='overflow: auto; height: 200px;'>"+oldOneInqryCn+"</textarea>");
	
	// 사진 파일 수정
	$(document).on("change", "#uploadFiles", handleImg);
	const dataTransfer = new DataTransfer;
	function handleImg(e) {
		var fileArr = e.target.files;
        // 이미지 업로드 개수 확인
        var totalFiles = dataTransfer.files.length + fileArr.length;

        console.log("이미지 업로드 개수: ", totalFiles);

        if (totalFiles > 10) {
            alert("이미지는 최대 10장까지 업로드할 수 있습니다.");
            return;
        }

        if (fileArr != null && fileArr.length > 0) {
            for (var i = 0; i < fileArr.length; i++) {
                // 이미지 개수가 10장 이하인 경우에만 파일을 추가
                if (totalFiles <= 10) {
                    dataTransfer.items.add(fileArr[i]);
                } else {
                    break; // 이미지 개수가 10장을 초과하면 파일 추가 중지
                }
            }
            document.getElementById("uploadFiles").files = dataTransfer.files;

	        console.log("dataTransfer: ", dataTransfer.files);
	        console.log("업로드된 파일: ", document.getElementById("uploadFiles").files);
	    }
        for (var i = 0; i < totalFiles; i++) {
            var file = fileArr[i];
            if (!file.type.match("image.*")) {
                alert("이미지 파일만 업로드 가능합니다.");
                continue;
            }
			var imgUrl = URL.createObjectURL(file);
            let img_html = "<li style='list-style-type: none; display: inline-block; margin-right: 10px;'>";
	            img_html += "<div class='thumbnail-container'><a href='#modalPicture' data-picture-url='' data-toggle='modal'>";
	            img_html += "<img class='prServiceThumb' src='" + imgUrl + "' style='width: 150px; height: 130px; border-radius: 20%; margin-right: 10px; margin-top:10px;' />";
	            img_html += "<span class='delete-icon'><i class='mdi mdi-close'></i></span></a></div></li>";
	            $("#imageList").append(img_html);

	         // 업로드 버튼 위치 조정
	       	 $(".modifyFile").appendTo($("#imageList"));
	    }
	}// handleImg 함수 종료
 	
	var atchmnflNoArray = [];
	// 이미지 삭제 기능
	$("#imageList").on("click", ".delete-icon", function(e){
	    e.stopPropagation();
	   	// 기존 이미지 선택 index
	   	targetIdx = $(this).data("index");
	   	atchmnflNoArray.push(targetIdx);
	    console.log("기존 이미지 선택 인덱스 값 : ", targetIdx);
	   	
	    // 새로 업로드한 파일 삭제
	    let fileArr = document.getElementById("uploadFiles").files;
	    targetFile = $(this).parent().index();
	    for(var i=0; i<dataTransfer.files.length; i++){
			if(i == targetFile){
			dataTransfer.items.remove(i);
			break;
			}
		}
	    console.log("dataTransfer 삭제 : ", dataTransfer.files);
		console.log("uploadFiles 삭제 : ", document.getElementById("uploadFiles").files);
	    
	    // 썸네일 삭제
	    $(this).parent().remove();

	    console.log("ajax로 들어갈 atchmnflno : ",atchmnflNoArray);
		console.log("ajax로 들어갈 file들 : ", document.getElementById("uploadFiles").files);
		
		$("#atchmnflNo").val(atchmnflNoArray);
	});
	
}// 전체 함수 종료
</script>

