<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<link type="text/css" rel="stylesheet" 
	href="/resources/ckeditor5/sample/css/sample.css" media="screen" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> 
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" /> -->
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">



<script type="text/javascript">

$(function(){
	
	
	 $("#insert").click(function () {
	    Swal.fire({
	        title: '등록이 완료 됐습니다.',
	        icon: 'success',
			confirmButtonColor: '#7066e0',
	        confirmButtonText: '확인',
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $("#frm").submit();
	        }
	    });
	}); 

	 $("#frm").on('submit', function (e) {
		    e.preventDefault(); // 기본 동작 방지

		    // AJAX 요청 대신 폼을 제출하고 페이지 이동 처리
		    $.ajax({
		        url: $(this).attr('action'),
		        type: $(this).attr('method'),
		        data: $(this).serialize(),
		        success: function () {
		            // 등록이 성공하면 페이지 이동
		            window.location.href = "/manage/faq";
		        },
		        error: function () {
		            // 등록이 실패하면 에러 처리
		            console.error("등록에 실패했습니다.");
		        }
		    });
		});
	 
	 
	
	
   $("#reset").on("click",function(){
	  location.href="/manage/faq"; 
   });

	console.log("개똥이")
	
	
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		
		$("#faqAnswer").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout",function(){
		$("#faqAnswer").val(window.editor.getData());
	});
	 
});

</script>
 <div class="card card-primary"> 

		<!-- 제목 -->
		<div >
			<img alt="faq" src="../resources/images/궁금2.png" style="width:100px; height:auto; margin:0 0 20px 730px;">
			<h2 id="faqTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">FAQ</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
			<br><br>
		</div>

	<!-- 
	요청URI : /stud/create?register
	요청파라미터 : {studId=a001,studNm=개똥이,studPw=java,studDet=학생상세내용
	            ,gender=여성,nationality=korea,postNum=12345,studAddress=대전 중구
	            ,studAddress2=123-33}
	 파람즈 : register
	 요청방식 : post
	 -->
	<form name="frm" id="frm" action="/faq/create?register" method="post">
		<div class="card-body">
			<div class="form-group">
				<label for="faqQestn">FAQ제목</label> 
				<input type="text" name="faqQestn" class="form-control" id="faqQestn"
					placeholder="FAQ제목" required />
			</div>
			<div class="form-group">
				<label for="faqAnswer">FAQ내용</label> 
				<div id="ckFaqAnswer" style="height:150px;"></div>
				<textarea id="faqAnswer" name="faqAnswer" class="form-control" rows="4" placeholder="FAQ내용" ></textarea>
			</div>
			 
			<!-- <div class="form-group">
				<label for="faqAnswer">FAQ 내용</label> 
				<div id="ckFaqAnswer" style="height:150px;"></div>
				<textarea name=faqAnswer id="faqAnswer" class="form-control" rows="4" style="display:none;" ></textarea>
			</div> -->
			
		</div>

		<div class="card-footer">
			<button type="button" id="insert" class="btn btn-primary">등록</button>
			<button type="button" id="reset" class="btn btn-secondary">취소</button>
		</div>
		
	</form>
</div>

<script type="text/javascript">
ClassicEditor
 .create(document.querySelector('#ckFaqAnswer'),
		{ckfinder:{uploadUrl:'/upload/uploads?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});
</script>