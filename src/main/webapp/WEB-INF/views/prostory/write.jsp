<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<style>
.ck-editor__editable {
min-height: 400px;
}
label {
display: block;
}

</style>
<script>
/*
게시글 번호(자동증가 , sequence)		proStoryBbscttNo	
게시글 제목(직접입력)					proStoryBbscttSj
게시글 내용(직접입력)					proStoryBbscttCn
게시글 작성일자(sysdate)				proStoryBbscttWrDt
게시글 추천수(별도)					proStoryBbscttRecommend
게시글 조회수(별도)					proStoryBbscttRdcnt
프로이야기게시글썸네일사진(직접입력)		proStoryBbscttThumbPhoto
통합첨부파일(사진, 직접입력)			sprviceAtchmnflNo
프로아이디							proId
*/
$(function(){
	
	var id;
	
	loginCK();
	
	if(id === "not"){
		Swal.fire({
            title: "로그인 후 이용하세요",
            confirmButtonText: "확인",
            icon: 'warning',
            customClass: {
                title: 'swal-title'
            }
        });
		return;
	}
	
	function loginCK(){
	
		$.ajax({
			url : "/prostory/idCheck",
			method : "get",
			success : function(result){
				
				if(result === "not"){
					Swal.fire({
		                title: "로그인 후 이용하세요",
		                confirmButtonText: "확인",
		                icon: 'warning',
		                customClass: {
		                    title: 'swal-title'
		                }
		            });
					id = "not";
					location.href = "main";
				}
			}
		})
	}
	document.getElementById("proStoryBbscttThumbPhoto").addEventListener("change", handleImg);
	
	let clsCiImgUrl = document.getElementById("clsCiImgUrl");

	function handleImg(e){
		
		let files = e.target.files;
		
		let fileArr = Array.prototype.slice.call(files);

		$("#clsCiImgUrl").html("");
		
		fileArr.forEach(function(f){

			if(!f.type.match("image.*")){
				Swal.fire({
	                title: "이미지 확장자만 가능합니다",
	                confirmButtonText: "확인",
	                icon: 'warning',
	                customClass: {
	                    title: 'swal-title'
	                }
	            });
				return;
			}
			let reader = new FileReader();

			reader.onload = function(e){

				let img = "<img src="+e.target.result+" style='width:30%' />";
				
				$("#clsCiImgUrl").append(img);	
			}

			reader.readAsDataURL(f);
		
		});//end forEach
	}
		
	$(".ck-blurred").keyup(function () {	
		console.log("str : " + window.editor.getData());
		$("#proStoryContent").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout",function () {
	// focusout : 커서가 영역 밖으로 나올때 마지막 데이터까지 추가
		$("#proStoryContent").val(window.editor.getData());
	});
	
	$("#btnStory").on("click" , function(){
		
		let proStoryBbscttSj   = $("#proStoryBbscttSj").val();
		let proStoryBbscttCn   = $("#proStoryBbscttCn").val(window.editor.getData()).val();
		let proStoryBbscttThumbPhoto = $("#proStoryBbscttThumbPhoto");
		
		console.log("proStoryBbscttSj : " + proStoryBbscttSj);
		console.log("proStoryBbscttCn : " + proStoryBbscttCn);
		console.log("proStoryBbscttThumbPhoto : " + proStoryBbscttThumbPhoto);

        let files = proStoryBbscttThumbPhoto[0].files;
		console.log("files ::: " +files[0]);

		let formData = new FormData();

		formData.append("proStoryBbscttSj" , proStoryBbscttSj);
		formData.append("proStoryBbscttCn" , proStoryBbscttCn);
 			
		for(let i = 0 ; i < files.length ; i++){
			formData.append("uploadFile" , files[i]);
		}
	
		if(confirm("글을 작성 하시겠습니까?")){		}
		
		$.ajax({
				url: "insert",
				processData : false,
				contentType : false,
				type : "post",
				data : formData,
				dataType : "text",
				success : function(result){
					
					console.log("result :: " + result);
					if(result > 0) {
						Swal.fire({
			                title: "게시물 작성 완료",
			                confirmButtonText: "확인",
			                icon: 'warning',
			                customClass: {
			                    title: 'swal-title'
			                }
			            });
						location.href = "/prostory/main";
					} else {
						Swal.fire({
			                title: "게시글 작성 실패",
			                confirmButtonText: "확인",
			                icon: 'warning',
			                customClass: {
			                    title: 'swal-title'
			                }
			            });
					}
						return;
			}
		})
	})
})
</script>
<!--  -->
<div class="container col-lg-6">
	<div class="card">
		<div class="card-body">
			<h4 class="card-title"></h4>
			<p class="card-description">
	
			<form action="#" name="frm" class="forms-sample" method="post" enctype="multipart/form-data">
	
				<input type="hidden" class="form-control" id="" name="" value="" required />
	
				<div class="form-group">
						<label for="proStoryBbscttSj">제목
							<input type="text" class="form-control" id="proStoryBbscttSj" name="proStoryBbscttSj" placeholder="제목을 입력해주세요" required>
	<%-- 					<c:out value="${proStoryBbscttSj}"></c:out> --%>
						</label>
				</div>
	
				<div class="form-group">
					<div id="proStoryContent">
					<label for="proStoryBbscttCn">
					<textarea class="form-control" name="proStoryBbscttCn" id="proStoryBbscttCn" rows="10" style="display: none;" placeholder="">
	<%-- 				<c:out value="${proStoryBbscttCn}"></c:out> --%>
					</textarea>
					</label>		
					</div>
				</div>
	
				<div id="clsCiImgUrl"></div>
					<div class="form-group"><br />썸네일<br />
						<input type="file" id=proStoryBbscttThumbPhoto name="uploadFile" placeholder="" multiple="multiple">
	<%-- 					<c:out value="${proStoryBbscttThumbPhoto}"></c:out> --%>
					</div>
				<br />
				<button type="button" id="btnStory" class="btn btn-primary mr-2">등록</button>
				<button class="btn btn-light">취소</button>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
ClassicEditor.create(document.querySelector('#proStoryContent'),
		{ ckfinder : { uploadUrl : '/upload/uploadCk'} , language : "ko" })
.then(editor=>{window.editor=editor;})
.catch(err=>{console.error(err.stack);});
</script>

<!--  -->
