<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>

<link type="text/css" rel="stylesheet" 
	href="/resources/ckeditor5/sample/css/sample.css" media="screen" />
<script type="text/javascript">

$(function(){

   $("#reset").on("click",function(){
	  location.href="/manage/notice"; 
   });

	console.log("개똥이")
	
	 $(document).ready(function() { 
	    // 초기화 버튼 클릭 이벤트 처리
	    $("#reset2").click(function() {
	        // 이미지들을 포함하는 요소를 찾아서 이미지들을 삭제합니다.
	    	$("#Images").empty();	    
	    	 $("#prtImgs").val('');
	    });
	 }); 
	
	
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		$("#noticeCn").val(window.editor.getData());
	});
	
	 $(".ck-blurred").on("focusout",function(){
		$("#noticeCn").val(window.editor.getData());
	}); 
	 
	 $("#prtImgs").on("change", handleImg);
	 
	 function handleImg(e){
		console.log("첨부파일");
		let files=e.target.files;
		let fileArr = Array.prototype.slice.call(files);
		
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				
				//함수종료
				return;
			}
			let reader = new FileReader();
			
			reader.onload = function(e){
				let img = "<img src='"+e.target.result+"'style ='width:20%;' />";
				$("#Images").append(img);
			}
			
			reader.readAsDataURL(f);
		});
	 }

	 $("#test").on("click", function () {
		    let prtImgs = $("#prtImgs");
		    let noticeSj = $("#noticeSj").val();
		    console.log("noticeCn", noticeCn);

		    console.log("noticeSj " + noticeSj)

		    let files = prtImgs[0].files;

		    console.log("prtImgs", prtImgs);

		    let formData = new FormData();
		    console.log("files", files);

		    if (noticeSj.trim() === '') {
		        noticeSj = '제목 없음';
		    }
		    if (noticeCn.trim() === '') {
		        noticeCn = '내용 없음';
		    }

		    formData.append("noticeSj", noticeSj);
		    formData.append("noticeCn", noticeCn);

		    for (let i = 0; i < files.length; i++) {
		        formData.append("uploadFile", files[i])
		    }

		    console.log(formData);
		    $.ajax({
		        url: "/admin/createPost",
		        processData: false,
		        contentType: false,
		        data: formData,
		        dataType: "text",
		        type: "post",
		        success: function (result) {
		            console.log("result : ", result);
		            Swal.fire({
		                title: '등록이 완료 됐습니다.',
		                icon: 'success',
						confirmButtonColor: '#7066e0',
		                confirmButtonText: '확인',
		            }).then((result) => {
		                if (result.isConfirmed) {
		                    location.href = "/manage/notice";
		                }
		            });
		        }
		    });
		    
		    Swal.fire({
		        title: '등록이 완료 됐습니다.',
		        icon: 'success',
				confirmButtonColor: '#7066e0',
		        confirmButtonText: '확인',
		    }).then((result) => {
		        if (result.isConfirmed) {
		            $("#frm").submit();
		            location.href = "/manage/notice";
		        }
		    });
		});
 
	});


</script>
 <div class="card card-primary"> 

 	<div class="card-header"> 
		
		<h3 class="card-title">공지 등록</h3>
	</div>

	<!-- 
	요청URI : /stud/create?register
	요청파라미터 : {studId=a001,studNm=개똥이,studPw=java,studDet=학생상세내용
	            ,gender=여성,nationality=korea,postNum=12345,studAddress=대전 중구
	            ,studAddress2=123-33}
	 파람즈 : register
	 요청방식 : post
	 -->
	<form name="frm" id="frm" action="/admin/createPost" method="post" enctype="multipart/form-data">
		<div class="card-body">
			<div class="form-group">
				<label for="noticeSj">공지사항제목</label> 
				<input type="text" name="noticeSj" class="form-control" id="noticeSj"
					placeholder="공지사항제목" required />
			</div>
			
			<div class="form-group">
		   		<label for="uploadFileSj">첨부파일</label>
<!-- 		   	<button type="reset" id="reset2" class="btn btn-primary">초기화</button>  -->
 		   		<button type="button" id="reset2" class="btn btn-outline-secondary btn-sm">초기화</button>
		   		<input type="file" id="prtImgs" name="uploadFile" class="form-control" multiple/>
			</div>
			
		 <!-- 	<div class="form-group">
				<label for="Images" id="Images"></label>
			</div> -->
			
			
			
			<!-- <div class="form-group">
				<label for="noticeCn">공지사항내용</label> 
				<div id="ckNoticeCn"></div>
				<textarea id="noticeCn" name="noticeCn" class="form-control" rows="4" placeholder="공지사항내용"></textarea>
			</div> -->
			<div class="form-group">
				<label for="noticeCn">공지사항 내용</label> 
				<div id="ckNoticeCn"
				style="height:150px;"></div>
				<textarea name=noticeCn id="noticeCn" class="form-control" 
				rows="4" style="display:none;" ></textarea>
			</div>
		</div>

		<div class="card-footer">
<!-- 			<input type="submit" id="test" class="btn btn-primary" value="제출하기"></button> -->
<!-- 			<input type="submit" class="btn btn-outline-primary btn-fw" value="등록하기"> -->
			<button type="button" id="test" class="btn btn-primary">등록</button>
			<button type="button" id="reset" class="btn btn-primary">취소</button>
		</div>
		
	</form>
</div>

<script type="text/javascript">
ClassicEditor
 .create(document.querySelector('#ckNoticeCn'),
		{ckfinder:{uploadUrl:'/upload/uploads?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});
</script>