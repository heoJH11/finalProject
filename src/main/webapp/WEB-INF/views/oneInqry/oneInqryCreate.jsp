<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
*{
	font-family: 'GmarketSansMedium';
}
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
	
	$("#btnAuto").on("click", function(){
		$("#oneInqrySj").val("안녕하세요 문의 남깁니다.");
		$("#oneInqryCn").val("안녕하세요 문의 남깁니다 남서연프로 조금 사기 같아요 확인 부탁드립니다.");
	});
	
	
});


$(document).ready(function(){
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
            var imgUrl = URL.createObjectURL(file); // 파일 객체를 이미지 URL로 변환합니다.
            var img_html = "<div class='thumbnail-container'><img class='thumbImg' src='" + imgUrl + "' style='width: 150px; height: 130px; border-radius: 20%; margin-right: 10px;' />";
            img_html += "<span class='delete-icon'><i class='mdi mdi-close'></i></span></div>";
            $("#pImg").append(img_html); // 이미지를 표시합니다.
        }
        // 파일 업로드 정보 업데이트
        updateFileUploadInfo(totalFiles);
    }
  // 이미지 삭제 기능 추가
	$("#pImg").on("click", ".delete-icon", function(){
		let fileArr = document.getElementById("uploadFiles").files;
	    console.log("파일 목록 : " ,fileArr);
		targetFile = $(this).parent().index();
		console.log("targetFile : ", targetFile);
	
		for(var i=0; i<dataTransfer.files.length; i++){
			if(i == targetFile){
			dataTransfer.items.remove(i);
			break;
			}
		}
		var fileLength = dataTransfer.files.length;
		console.log("dataTransfer 삭제 : ", dataTransfer.files);
		console.log("uploadFiles 삭제 : ", document.getElementById("uploadFiles").files);
	   	$(this).parent().remove();
	      
	    updateFileUploadInfo(fileLength);
	  });
});
// 파일 업로드 정보 업데이트 함수
function updateFileUploadInfo(no) {
   var uploadedFiles = no;
   if (uploadedFiles == 0) {
	   $(".file-upload-info").val("");
   } else {
   	   $(".file-upload-info").val(uploadedFiles + "개의 파일이 업로드됨");
   }
}
</script>
<div class="col-12 grid-margin stretch-card">
    <div class="card">
        <div class="card-body">
		<div >
			<img alt="1대1문의" src="../resources/images/상담.png" style="width:100px; height:auto; margin:0 0 20px 600px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">관리자에게 1:1 문의하기</h2>
			<hr style="border-top: 50px solid #f5f7ff; margin:-50px 400px 0 400px;">
			<br>
		</div>
            <p class="card-description text-center">욕설 및 비방적인 글은 제재가 될 수 있으며, 작성된 내용은 관리자에게 전달됩니다.</p>
            
            <form class="forms-sample" action="/oneInqry/oneInqryCreatePost" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="oneInqrySj">제목</label>
                     <input type="text" class="form-control" id="oneInqrySj" name="oneInqrySj" placeholder="제목을 입력해주세요"
                        required="required" />
                </div>
                
                <div class="form-group">
                    <label>첨부파일</label>
                    <input type="file" name="uploadFiles" id="uploadFiles" class="file-upload-default" multiple>
                    <div class="input-group col-xs-12 d-flex align-items-center">
                        <input type="text" class="form-control file-upload-info" disabled="" placeholder="jpg, png 등의 파일만 업로드 가능합니다.(최대 10장)" />
                        <span class="input-group-append ms-2">
                            <button class="file-upload-browse btn btn-primary" type="button" style="margin-left: 5px;">업로드</button>
                        </span>
                    </div>
                    <div id="pImg" style="margin-top: 10px;"></div>
                </div>
                
                <div class="form-group">
                    <label for="oneInqryCn">문의내용</label> 
                    <textarea class="form-control" id="oneInqryCn" name="oneInqryCn" placeholder="내용을 입력해주세요" wrap="hard"
                     style="overflow: auto; height: 300px; " required="required"></textarea>
                </div>
                
                <button class="btn btn-light" onclick="history.back()" style="float: right;">취소</button>
                <button type="submit" class="btn btn-primary me-2" id="checkBtn" style="float: right; margin-right: 5px;">등록</button>
            </form>
            <button class="btn btn-inverse-primary" id="btnAuto">자동완성</button>
        </div>
    </div>
</div>