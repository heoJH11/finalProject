<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.0/classic/ckeditor.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/build/ckeditor.js"></script>

<style> 
.ck-editor__editable_inline{ 
	min-height:300px; 

}
ul, li {
	display: inline;
}
.list-wrapper {
	overflow: hidden;
}
</style>
<script type="text/javascript">

$(function(){
	
	$("#rvAutobtn").on("click", function() {
		$("#aftusBbscttSj").val("만족합니다!!");
		editor.setData("굉장히 친절하시고 요구 사항 전부 다 들어주셔서 감사했습니다");		
 		$("#aftusBbscttCn").val("굉장히 친절하시고 요구 사항 전부 다 들어주셔서 감사했습니다");
	})
		
	$("#rvCreate").on("click", function() {
		if($("#aftusBbscttSj").val() == "") {
			Swal.fire({
				icon: 'error',
		        title: '제목을 입력하세요.',
	        	confirmButtonText: '확인',
			})
		} else if($("#aftusBbscttCn").val() == "") {
			Swal.fire({
				icon: 'error',
		        title: '내용을 입력하세요.',
	        	confirmButtonText: '확인',
			})
		} else {
			$("#rvInsertForm").submit();

		}
 	})
 	
 	$("#rvCancel").on("click", function (){
 		location.href = "/reviewBoard/main";
 	})
	
	//ckEditor 내용 입력
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		$("#aftusBbscttCn").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout",function(){
		console.log("str : " + window.editor.getData());
		$("#aftusBbscttCn").val(window.editor.getData());
	});
	
	$("#uploadFile").on("change", function() {
    
		const uploadFile = $(this)[0].files; 
		test(uploadFile);
	});
	
});


let selectedFiles = [];

function test(uploadFile) {
    console.log(uploadFile);
    const fileList = $('#file-list');
    for (let i = 0; i < uploadFile.length; i++) {
        selectedFiles.push(uploadFile[i]);
        const item = $('<li></li>');
        const fileName = $(document.createTextNode(uploadFile[i].name));
        console.log(fileName);
        const deleteButton = $('<i class="remove ti-close"></i>');
        deleteButton.on('click', (event) => {
            const fileToRemove = uploadFile[i];
            item.remove();
            event.preventDefault();
            deleteFile(fileToRemove);
        });
        
        item.append(fileName);
        item.append(deleteButton);
        fileList.append(item);
    }
}

function deleteFile(deleteFile) {
    selectedFiles = selectedFiles.filter(function(uploadFile) {
        return uploadFile !== deleteFile;
    });
    updateFileInput();
}

function updateFileInput() {
    const inputFile = $("#uploadFile")[0];
    const dataTransfer = new DataTransfer();
    selectedFiles.forEach(function(uploadFile) {
        dataTransfer.items.add(uploadFile);
    });
    inputFile.files = dataTransfer.files;
}




</script>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<h4 class="card-title"></h4>
					<p class="card-description">
					<form action="/reviewBoard/createAjax" id="rvInsertForm" name="frm" class="forms-sample" method="post" enctype="multipart/form-data">
						<input type="hidden" class="form-control" id="srvcRequstNo" name="srvcRequstNo" value="${srvcRequstNo}" required>
						<div class="form-group">
							<label for="aftusBbscttSj">제목</label>
							<input type="text" class="form-control" id="aftusBbscttSj" name="aftusBbscttSj">
						</div>
						<div class="form-group">
							<label for="aftusBbscttCn">내용</label>
							<div id="ckEditor" class="ckEditor"></div>
							<textarea class="form-control" rows="10" id="aftusBbscttCn" name="aftusBbscttCn"
								style="display: none;"></textarea>
						</div>
						<div class="form-group">
							<div class="list-wrapper pt-1 col-sm-12">
								<ul class="d-flex flex-row todo-list todo-list-custom" id="file-list">
								</ul>
							</div>
							<div class="input-group col-xs-12">
								<div class="custom-file">
									<input type="file" id="uploadFile" name="uploadFile" class="file-upload-default" multiple="multiple">
			
									<span class="input-group-append">
										<button class="file-upload-browse btn btn-primary" type="button">업로드</button>
									</span>
								</div>
							</div>
						</div>
						<hr>
						<button type="button" id="rvCreate" class="btn btn-primary mr-2">등록</button>
						<button type="button" id="rvCancel" class="btn btn-light">취소</button>
						<button type="button" id="rvAutobtn" style="border:none; background:none; margin-left: 1000px;">
							<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
						</button>
					</form>
					
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
ClassicEditor
 .create(document.querySelector('#ckEditor'),
		{ckfinder:{uploadUrl:'/upload/uploads'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});
</script>
