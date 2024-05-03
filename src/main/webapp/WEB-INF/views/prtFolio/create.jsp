<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
    .thumbnail-container {
        position: relative;
        display: inline-block;
    }
    .delete-icon {
        position: absolute;
        top: -8px;
        right: 5px;
        cursor: pointer;
        display: none;
    }
    .thumbnail-container:hover .delete-icon {
        display: block;
    }
</style>


<script>

$(function(){
	
	$(document).ready(function() {
	    // 초기화 버튼 클릭 이벤트 처리
	    $("#reset").click(function() {
	        // 이미지들을 포함하는 요소를 찾아서 이미지들을 삭제합니다.
	    	$("#Images").empty();
	    });
	});

	$("#prtImgs").on("change", handleImg);
	
	function handleImg(e){
		console.log("포트폴리오 이미지");
		let files=e.target.files;
		let fileArr = Array.prototype.slice.call(files);
		
		 // 업로드된 이미지 개수 확인
        var uploadedCount = $("#pImg .thumbnail-container").length;
        var totalFiles = uploadedCount + fileArr.length;

        if (totalFiles > 10) {
            alert("이미지는 최대 10장까지 업로드할 수 있습니다.");
            return;
        }
		
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지 확장자만 가능합니다");
				//함수종료
				return;
			}
			let reader = new FileReader();
			
			reader.onload = function(e){
				let img = "<div class='thumbnail-container'><img class='thumbImg' src='" + e.target.result+"' style='width: 150px; height: 130px; border-radius: 20%; margin-right: 10px;' />";
				img += "<span class='delete-icon'><i class='mdi mdi-close'></i></span></div>"; 
				$("#Images").append(img);
			}
			reader.readAsDataURL(f);
		});
		  // 파일 업로드 정보 업데이트
        updateFileUploadInfo();
	}
    // 이미지 삭제 기능 추가
    $("#Images").on("click", ".delete-icon", function(){
        $(this).parent().remove();
        updateFileUploadInfo();
    });

    // 파일 업로드 정보 업데이트 함수
    function updateFileUploadInfo() {
        var uploadedFiles = $("#Images .thumbnail-container").length;
        if (uploadedFiles === 0) {
            $(".file-upload-info").val("");
        } else {
            $(".file-upload-info").val(uploadedFiles + "개의 파일이 업로드됨");
        }
    }


	
	$("#frm").submit(function(event){
		var prtfolioSj = $("#prtfolioSj").val();
		if(!prtfolioSj || prtfolioSj.trim() == ""){
			alert("포트폴리오 제목을 적어주세요");
			$("#prtfolioSj").focus();
			return false;
		}
	});
	
	$("#submit").on("click",function(){
		let prtfolioSj = $("#prtfolioSj").val();
		let prtImgs = $("#prtImgs");
		
		let files = prtImgs[0].files;
		
		let formData = new FormData();
		formData.append("prtfolioSj",prtfolioSj);
		for(let i=0; i<files.length;i++){
			formData.append("uploadFile",files[i])
		}
		
		$.ajax({
			url:"/prtFolio/createPost",
			processData:false,
			contentType:false,
			data:formData,
			dataType:"text",
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(result){
				console.log("result : ", result);
			}
		});
	});
	
});


</script>
<head>
<title>포트폴리오 추가</title>
</head>


<input type="hidden" id="sessionId" value="${proSession.userId}" />
<div style="margin: 0 400px 0 400px;">
	<div style="display: flex; flex-wrap: wrap; align-items: center;">
		<img src="../resources/images/free-icon-portfolio-4702782.png" style="width:50px;" />
		<h3 style="margin: 15px 0 0 10px;">포트폴리오 추가</h3>
	</div>
	<br><br>
	<form id="frm" name="frm" action="/prtFolio/createPost" method="post" enctype="multipart/form-data">
		<div class="mb-3">   
			<input type="hidden" id="proId" name="proId" value="${proSession.userId}" class="form-control" />
			<div class="form-group">
			   <label for="prtfolioSj">포트폴리오 제목</label>
			   <input type="text" id="prtfolioSj" name="prtfolioSj" class="form-control"/>
			</div>
			
			<div class="form-group">
			 <label>첨부파일</label>
			 <input type="file" name="uploadFile" id="prtImgs" class="file-upload-default" multiple>
			 <div style="display: flex; flex-wrap: wrap;">
			     <input type="text" class="form-control file-upload-info" style="width:82%;" disabled="" placeholder="첨부파일" />
			     <button class="file-upload-browse btn btn-primary" style="margin-left:10px;" type="button">업로드</button>
			 </div>
			 <div id="Images" style="margin-top: 10px; width:120%;"></div>
			</div>
			
			
			<div class="form-group" style="float:right;">
	         <input type="submit" class="btn btn-primary me-2" id="checkBtn" value="등록하기">
	         <button type="reset" id="reset" class="btn btn-outline-secondary btn-fw">초기화</button>
	      </div>
		</div>
	</form>
</div>
