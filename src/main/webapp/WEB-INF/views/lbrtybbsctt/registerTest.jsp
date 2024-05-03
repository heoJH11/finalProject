<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>  
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.0/classic/ckeditor.js"></script>

<link type="text/css" rel="stylesheet" 
	href="/resources/ckeditor5/sample/css/sample.css" media="screen" />
<script type="text/javascript">
function btnDel(a){
	console.log("a : ", a)
	//console.log("obj : ", obj)
	const input = document.getElementById('file-input')
	console.log("input",input);
	console.log("files",files);
}

let selectedFiles = [];

function test(files) {
    console.log(files);
    const fileList = document.getElementById('file-list');
    for(let i=0; i<files.length; i++) {
        selectedFiles.push(files[i]);
        const item = document.createElement('div');
        const fileName = document.createTextNode(files[i].name);
        const deleteButton = document.createElement('button');
        deleteButton.addEventListener('click', (event) => {
            item.remove();
            event.preventDefault();
            deleteFile(files[i]);
        });
        deleteButton.innerText="X";
        item.appendChild(fileName);
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
$(function(){
	//파일 업로드시 파일 이름 읽기
	/*const input = document.getElementById('file-input')
	const output = document.getElementById('preview')

	document.getElementById("file-input").addEventListener('input', (event) => {
	  var files = event.target.files
	  console.log("files0 : ",files[0]);
	  console.log("files1 : ",files[1]);
	  console.log("files.[1]",files);
	  var data = files[1];
	  console.log("data : ", data)
	  let res = 0;
	  output.innerHTML = "<a>"+Array.from(files).map(file => file.name+"<button id='btn"+(res)+"' onclick='btnDel("+(res++)+")' type='button'>x</button></a><br>").join("");
	  $("#btn"+(res)).on("click",function(a){
		 console.log("awdasd : " + a) 
	  });
	})
	
	
	$("#file-input").on("change",function(){
		console.log("asdawd")
		console.log("$('#file-input')[0].files.length : ",$('#file-input')[0].files.length)
		console.log("$('#file-input')[0].files.length",$('#file-input')[0].files[0])
		if ($('#file-input')[0].files.length === 0) {
		    console.log("No files selected.");
		}
	});
	*/
		
	
	/* $("#uploadFile").on("change", function() {
        $("#imgDiv").css("display", "none");
     });$("#uploadFile").on("change", function() {
         $("#imgDiv").css("display", "none");
     });
     
	$("#uploadFile").on("change",handleImgFileSelect);
	function handleImgFileSelect(e){
		console.log("dasd")
		//이벤트가 발생 된 타겟 안에 들어있는 이미지 파일들을 가져와보자
		let files = e.target.files;
		

		console.log(files);
		let fileArr = Array.prototype.slice.call(files);
	
		fileArr.forEach(function(f){
			//이미지 파일이 아닌 경우 이미지 미리보기 실패 처리(MIME타입)
			
			console.log(f);
			if(!f.type.match("image.*")){
				alert("이미지 파일만 가능합니다.");
				//함수 종료
				return;
			}
			//이미지 객체를 전역 배열타입 변수에 넣자
			//이미지 객체를 읽을 자바스크립트의 reader 객체 생성
			let reader = new FileReader();
			
			$(".clsCiImgUrl").html("");
			
			//e : reader가 이미지 객체를 읽는 이벤트
			reader.onload = function(e){
				$(".clsCiImgUrl").css({
			          "background-image": "url(" + e.target.result + ")",
			          "background-position": "center",
			          "background-size": "cover",
			          "width": "300px", 
			          "height": "200px",
			          "border": "1px solid #ccc"
			        });
// 				
			}
			//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
			reader.readAsDataURL(f);
		});//end forEach
	} */
		
	
	console.log("개똥이");
	
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		
		$("#lbrtyBbscttCn").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout",function(){
		$("#lbrtyBbscttCn").val(window.editor.getData());
	});
	
});
</script>

<style> 
     .ck-editor__editable_inline{ 
     min-height:550px; 
     } 
</style>
<div class="col-12 grid-margin stretch-card">
    <div class="card">
    	<div class="card-body">
			<h4 class="card-title">게시글 작성</h4>
        	<p class="card-description">욕설 및 비방적인 글은 신고 대상 및 제재가 될 수 있습니다.</p>
        	
			<form name="frm" id="frm" action="/lbrtybbsctt/create" 
				method="post" enctype="multipart/form-data" >
				<div class="form-group">
					
					<input type="hidden" name="userId" class="form-control" id="userId" value="${userId}"
						placeholder="작성자 아이디" required readonly/>
				</div>
				<div class="form-group">
					<label for="lbrtyBbscttSj">게시글 제목</label> 
					<input type="text" name="lbrtyBbscttSj" class="form-control" id="lbrtyBbscttSj"
						placeholder="제목을 입력해주세요" required />
				</div>
				<div class="form-group">
						<label for="file-input">첨부 파일</label>
						<div class="custom-file">
							<input type="file" name="files" multiple="multiple" onchange="test(this.files)">
							<div id="file-list">
							</div>
						</div> 
				</div>
			
				<div class="form-group">
					<label for="lbrtyBbscttCn">게시글 내용</label> 
					<div id="cklbrtyBbscttCn"
					style="height:150px;"></div>
					<textarea name="lbrtyBbscttCn" id="lbrtyBbscttCn" class="form-control" 
					rows="4" style="display:none;" ></textarea>
				</div>
			<button type="submit" class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-light">초기화</button>
			<button type="button" class="btn btn-light" onclick="location.href='read2'">취소</button>
		<%-- <sec:csrfInput/> --%>
	</form>
	</div>
</div>
</div>
<script type="text/javascript">
ClassicEditor
 .create(document.querySelector('#cklbrtyBbscttCn'),
		{ckfinder:{uploadUrl:'/upload/uploads?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});
</script>