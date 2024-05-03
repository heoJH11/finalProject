<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/imageDetail.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<style>
* {
	font-family: 'GmarketSansLight'; 		
}

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

#rejectModal{
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
<!-- 요청서 본문 -->
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<div class="container-fluid">
						<h3 class="card-title" id="srvcRequstSj">${vSrvcRequstVO.srvcRequstSj}</h3>
						<p class="card-description"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${vSrvcRequstVO.srvcRequstWrDt}"/></p>
						<hr />
						<div class="row">
							<div class="col-md-10 mx-auto">
								<div class="tab-content tab-content-custom-pill" id="pills-tabContent-custom">
									<!-- form 시작 -->
									<form id="srvcRqDetailFrm" action="/srvcRequst/acceptRequst" method="post" enctype="multipart/form-data">
										<!-- form에서 보내는 hidden 정보 -->
										<input type="hidden" id="srvcRequstNo" name="srvcRequstNo" value="${vSrvcRequstVO.srvcRequstNo}" />
										<input type="hidden" id="hiddenSrvcRequstSj" name="hiddenSrvcRequstSj" value="" />
										<input type="hidden" id="atchmnflNo" name="atchmnflNo[]" value=""/>
										<input type="hidden" id="sprviseAtchmnflNo" name="sprviseAtchmnflNo" value="${vSrvcRequstVO.sprviseAtchmnflNo}" />
										<!-- 요청서 본문 -->
										<div style="margin:0 0 0 -65px;">
											<!-- 요청서 이미지 -->
											<div class="d-flex mb-4" id="srvcRequstImages" style="white-space: nowrap;">
												<div id="imageList" class="d-flex flex-wrap">
												<c:forEach var="sprviseAtchmnflVO" items="${vSrvcRequstVO.sprviseAtchmnflVOList}" varStatus="status">
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
											<pre style="background: transparent; font-family: GmarketSansLight;" id="srvcRequstCn"><c:out value="${vSrvcRequstVO.srvcRequstCn}" /></pre>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
		<c:if test="${vSrvcRequstVO.srvcRequstItyy != null}">
		</c:if>
		<c:if test="${vSrvcRequstVO.srvcRequstItyy == null}">
		<button type="button" class="btn btn-inverse-secondary clsBtn" onclick="history.back()" style="margin-top: 10px; position: relative; left: 93%;">닫기</button>
		</c:if>
		<!-- 회원 버튼  -->
		<div class="memBtnDiv" style="display: flex; flex-wrap: wrap; margin-left: 81%; margin-top:10px; ">
		<c:if test="${vSrvcRequstVO.srvcRequstProcessAt == 0 && vSrvcRequstVO.emplyrTy == 'ET01'}">
				<button type="button" class="btn btn-inverse-primary" style="margin-right: 5px;" id="modifyModeBtn" onclick="modifyMode(${vSrvcRequstVO.srvcRequstNo})" >수정</button>
				<button type="button" class="btn btn-inverse-primary" style="display: none; margin-right: 5px;" id="modifySuccessBtn" onclick="confirmBtn('modify')" style=" margin-right: 5px;">완료</button>
				<button type="button" class="btn btn-inverse-secondary" style="display: none;" id="cancelBtn">취소</button>
		</c:if>
		</div>
		<!-- 회원 버튼 끝 -->
		
		<!-- 프로 버튼 -->
		<div style="display: flex; flex-wrap: wrap; margin:10px 0 0 -84px; ">
			<c:if test="${vSrvcRequstVO.srvcRequstProcessAt == 0 && vSrvcRequstVO.emplyrTy == 'ET02'}">
				<button type="button" class="btn btn-inverse-primary" style="margin-right: 5px;" onclick="confirmBtn('accept')">수락</button>
				<button type="button" class="btn btn-inverse-danger btn-icon-text btn-popover" style="margin-right: 5px;" id="rejectModalBtn">거절</button>
			</c:if>
		</div>	
		<!-- 프로 버튼 끝 -->
		
	</div>
</div>

<!-- 거절 사유 있을 시에만 나타남 -->
<c:if test="${vSrvcRequstVO.srvcRequstItyy != null}">
	<div class="content-wrapper"
		style=" border-bottom-left-radius: 45px; border-bottom-right-radius: 45px; position: relative; bottom: 45px;">
		<div class="row">
			<div class="col-lg-12">
				<div class="card px-2">
					<div class="card-body">
						<p class="card-title">거절 사유</p>
						<hr />
						<div class="mb-3 srvcRequstItyy">
							<div id="srvcRequstItyy">
								<pre style="background: transparent; height: 100%; font-family: 'GmarketSansLight'"><c:out value="${vSrvcRequstVO.srvcRequstItyy}"></c:out></pre>
							</div>
						</div>
					</div>
				</div>
			</div>
			<button type="button" class="btn btn-inverse-secondary" onclick="history.back()" style="margin-top: 10px; position: relative; left: 90%;">닫기</button>
		</div>
	</div>
</c:if>

<!-- 이미지 확대 모달  -->
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
                <button type="button" class="btn btn-light" data-dismiss="modal" id="clsBtn">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 거절 모달 -->
<div id="rejectModal" class="modal">
	<div class="card-body">
		<h4 class="card-title">거절 사유를 선택해주세요.</h4>
		<p class="card-description">
			거절 사유는 회원에게 그대로 전달되며,
			완료 후 수정이 불가합니다.
		</p>
		<form action="/srvcRequst/rejectRequst" method="post" id="rejectRequstFrm">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<div class="form-check">
							<label class="form-check-label"> 
							<input type="checkbox" class="form-check-input" name="srvcRequstItyy" id="srvcRequstItyy"
								value="시간이 맞지 않아요" />시간이 맞지 않아요
							<i class="input-helper"></i></label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" name="srvcRequstItyy" id="srvcRequstItyy"
							 	value="분야가 맞지 않아요" /> 분야가 맞지 않아요 
							 <i	class="input-helper"></i>
							 </label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" name="srvcRequstItyy" id="srvcRequstItyy"
							 	value="가격대가 맞지 않아요" /> 가격이 맞지 않아요
							 <i	class="input-helper"></i>
							 </label>
						</div>
						<div class="form-check">
							<label class="form-check-label">
							 <input type="checkbox" class="form-check-input" id="other" name="srvcRequstItyy"
							 	value="기타" /> 기타
							 <i	class="input-helper"></i>
							 </label>
						</div>
						<textarea class="form-control" id="srvcRequstItyyInput" name="srvcRequstItyyInput" style="display: none; width: 218%;"
							rows="2"></textarea>
					</div>
				</div>
				<input type="hidden" id="rejectSrvcRequstNo" name="rejectSrvcRequstNo" value="${vSrvcRequstVO.srvcRequstNo}" />
			</div>
			<button type="button" class="btn btn-inverse-primary btn-sm" onclick="confirmBtn('reject')">거절</button>
			<button type="button" class="btn btn-inverse-secondary btn-sm" id="modalClsBtn">닫기</button>
		</form>
	</div> 
</div>
<div id="modalBackdrop"></div>
<script>
$(function(){
	$("#rejectModalBtn").on("click",function(){
		console.log("거절");
		$("#rejectModal").show();
		$("#modalBackdrop").show();
	});

	$("#modalClsBtn").on("click",function(){
		$("#srvcRequstItyyInput").val("");
		$("#rejectModal").hide();
		$("#modalBackdrop").hide();
	});
});

function confirmBtn(status){
	if(status == "accept"){
	    Swal.fire({
	        title: "요청을 수락하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	    }).then((result) => {
	        if (result.isConfirmed) {
	            Swal.fire({
	                title: "수락을 완료하였습니다!",
	                icon: "success"
	            }).then(() => {
	                $("#srvcRqDetailFrm").submit();
	            });
	        }
	    });
	    
	}else if (status == "reject") {
        if (!$('input[type="checkbox"][name="srvcRequstItyy"]').is(':checked')) {
            alert("거절 사유를 선택해주세요.");
            return;
        } else {
            Swal.fire({
                title: "요청을 거절하시겠습니까?",
                icon: "warning",
                showCancelButton: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: "거절을 완료하였습니다.",
                        icon: "success",
                    }).then(() => {
                        $("#rejectRequstFrm").submit();
                    });
                }
            });
        }
	}else if(status == "modify"){
	    Swal.fire({
	        title: "수정을 완료하시겠습니까?",
	        icon: "question",
	        showCancelButton: true,
	    }).then((result) => {
	        if (result.isConfirmed) {
	            Swal.fire({
	                title: "수정이 완료되었습니다!",
	                icon: "success"
	            }).then(() => {
	            	var newSrvcRequstSj = $("#newSrvcRequstSj").val();
	            	$("#hiddenSrvcRequstSj").val(newSrvcRequstSj);
	                $("#srvcRqDetailFrm").submit();
	            });
	        }
	    });
	}
}

$('input[type="checkbox"][name="srvcRequstItyy"]').click(function(){
	if($(this).prop('checked')){
		$('input[type="checkbox"][name="srvcRequstItyy"]').prop('checked',false);
		$(this).prop('checked', true);
		srvcRequstItyy = $('input[type="checkbox"][name="srvcRequstItyy"]:checked').val();
		
		 if($('#other').prop('checked')){
	            $("#srvcRequstItyyInput").css("display","block");
	        } else {
	            $("#srvcRequstItyyInput").css("display","none");
	            $("#srvcRequstItyyInput").val("");
	        }
	}
});

$("#cancelBtn").on("click",function(){
	window.location.reload();
});

function modifyMode(no){
	// 수정 버튼 숨기기
	$("#modifyModeBtn").css("display", "none");
	// 수정 완료 보이기
	$("#modifySuccessBtn").css("display", "block");
	// 취소 버튼 보이기
	$("#cancelBtn").css("display", "block");
	// 닫기 버튼 숨기기
	$(".clsBtn").css("display", "none");
	// 버튼 이동
	$(".memBtnDiv").css("margin-left", "81%");
	// 기존 이미지 삭제 아이콘 보이기
	$(".delete-icon").css("display", "block");
	// 새로운 파일 업로드 버튼 보이기
	$("#modifyFileBtn").css("display", "block");
	
	//form action 변경하기
	$("#srvcRqDetailFrm").attr("action", "/srvcRequst/srvcRqUpdatePost")
	
	// 제목 수정 
	var oldSrvcRequstSj = $("#srvcRequstSj").text();
	$("#srvcRequstSj").html("<input type='text' class='form-control' id='newSrvcRequstSj' name='newSrvcRequstSj' value='"+oldSrvcRequstSj+"' />");
	// 내용 수정 
	var oldSrvcRequstCn = $("#srvcRequstCn").text();
	$("#srvcRequstCn").html("<textarea id='newSrvcRequstCn' name='newSrvcRequstCn' class='form-control' col='100' wrap='hard' style='overflow: auto; height: 400px;'>"+oldSrvcRequstCn+"</textarea>");
	
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
// 	   	기존 이미지 선택 index
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
}// 회원 수정 전체 함수 종료
</script>



