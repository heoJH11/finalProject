<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<style>
@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

label{
	font-family: 'seolleimcool-SemiBold';
	font-size:20px !important;
	color:#4e4c7c;
}

input,button,textarea,p{
	font-family: 'GmarketSansMedium';
}
</style>

<script type="text/javascript">
$(function() {

	$("#tmtAutobtn").on("click", function() {
		$("#tdmtngNm").val("등산 모임");
		$("#tdmtngDt").val("2024-04-22T20:00");
		$("#tdmtngMax").val("10");
		$("#tdmtngCn").val("함께 등산 가실 분들 구해요.");
	})

	$("#btnTmtInsert").on("click", function() {
		
		let tdmtngNm = $("#tdmtngNm").val();
		let tdmtngDt = $("#tdmtngDt").val();
		let tdmtngMax = $("#tdmtngMax").val();
		let tdmtngCn = $("#tdmtngCn").val();
		let uploadFile = $("#uploadFile");//파일객체
		
		if(tdmtngNm == "") {
			Swal.fire({
		          icon: 'error',
		          title: '모임명을 입력하세요.',
		          confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#tdmtngNm").focus();
				})
		} else if(tdmtngDt == "") {
			Swal.fire({
		          icon: 'error',
		          title: '모임일자를 입력하세요.',
		          confirmButtonText: '확인',
		        })
		} else if(tdmtngMax == "") {
			Swal.fire({
		          icon: 'error',
		          title: '정원을 입력하세요.',
		          confirmButtonText: '확인',
		        })
		} else if(tdmtngCn == "") {
			Swal.fire({
		          icon: 'error',
		          title: '내용을 입력하세요.',
		          confirmButtonText: '확인',
		        }).then((result) => {
		        	$("#tdmtngCn").focus();
				})
		}
		
		console.log("tdmtngMax : ", tdmtngMax);
		let files = uploadFile[0].files;
		let formData = new FormData();
		
		formData.append("tdmtngNm", tdmtngNm);
		formData.append("tdmtngDt", tdmtngDt);
		formData.append("tdmtngMax", tdmtngMax);
		formData.append("tdmtngCn", tdmtngCn);

		for(let i=0; i<files.length; i++){
			formData.append("uploadFile", files[i])
		}
		
		console.log(formData);

		$.ajax({
		    url: "/todayMeeting/create",
		    type: "post",
		    processData: false,
		    contentType: false,
		    async : true,
		    data: formData,
		    dataType: "text",
		    success: function(tdmtngNo) {
		        console.log("result : ", tdmtngNo);

		        loadRoomList(); // 회의 목록을 로드합니다.

		        Swal.fire({
		            title: '채팅방이 생성됐습니다.',
		            icon: 'success',
		            confirmButtonText: '확인',
		        }).then(result => {
		            if (result.isConfirmed) {
						location.href = "/todayMeeting/detail?tdmtngNo=" + tdmtngNo;
		            }
		        });
		        $("#btnTmtInsert").remove();
		    }
		});
                $(".tyn-quick-chat").addClass("active");
 	})
// 	window.onload = function(){
		
// 			$(".tyn-quick-chat").addClass("active");
// 	}
 	
 	$("#btnTmtInsertCen").on("click", function (){
 		location.href = "/todayMeeting/main";
 	})

	function loadRoomList() {
		// 내방 목록 출력
		$("#msgArea3").empty();
		$("#chat_form").hide();
		$("#expired").show();
		$.ajax({
			url: "/todayMeeting/myList",
			type: "post",
			dataType: "json",
			success: function (result) {
				
				var roomList = result;
				var str = '';
				
				$.each(roomList, function (index, TdmtngVO) {
					console.log("TdmtngVO :: " + TdmtngVO.tdmtngDt);
					console.log("tdmtngCreateDt :: " + TdmtngVO.tdmtngCreateDt);
					str += '<div class="tyn-media-group">';
					str += '<div class="tyn-media tyn-size-lg">';
					str += '<div class="tyn-media-col">';
					str += '<h6 class="name"><br><a style="color : #4B49AC; font-family:GmarketSansMedium" href="#" onclick="myRoom(event, \'' + TdmtngVO.tdmtngNo + '\')" class="roomLink" data-tdmtngNo="' + TdmtngVO.tdmtngNo + '">';
					str += "<img src='/resources/images/제목.png' alt='이미지' style='width : 30px; height : 30px;'>"+ "  " + TdmtngVO.tdmtngNm + '</a></h6>';
					str += "<h6><img src='/resources/images/날짜.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>" +TdmtngVO.tdmtngCreateDt.substring(0 , 9 + 1) + '</h6>';
					str += "<h6><img src='/resources/images/만나요.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>"+TdmtngVO.tdmtngDt.substring(0 , 15 + 1)  + '</h6>';
					str += '</div>';
					str += '</div>';
					str += '</div>';
					
					chatList.push(TdmtngVO);
				});
				$('#myList').html(str);
			},
			error: function (xhr, status, error) {
				console.error('Error fetching room list:', status, error);
			}
		});
	}
	
	$("#uploadFile").on("change",handleImgFileSelect);
	function handleImgFileSelect(e){
		
		//이벤트가 발생 된 타겟 안에 들어있는 이미지 파일 가져오기
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
			          "height": "500px",
		
			    });
// 				
			}
			//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
			reader.readAsDataURL(f);
		});
	}
	
});

function printName()  {
	  const name = document.getElementById('name').value;
	  document.getElementById("result").innerText = name;
	}

</script>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
			    <div class="card-body">
			        <h4 class="card-title"></h4>
			        <form action="" id="tmtInsertForm" class="forms-sample" 
			        	method="post" enctype="multipart/form-data">
						<div style="display: flex;">
							<div class="form-group col-6" style="padding-left: 0px;">
								<label for="tdmtngNm">🎨 모임명</label>
								<input type="text" class="form-control" id="tdmtngNm" name="tdmtngNm" required>
							</div>
					        <div class="form-group col-4">
					            <label for="tdmtngDt">📆 모임일시</label>
					            <input type="datetime-local" class="form-control" id="tdmtngDt" name="tdmtngDt">
					        </div>
					        <div class="form-group col-2" style="padding-right: 0px;">
					        	<label for="tdmtngMax">👦 정원</label>
					            <input type="number" class="form-control" id="tdmtngMax" name="tdmtngMax">
					        </div>
				        </div>
				        <div class="form-group">
				            <label for="tdmtngCn">🧾 모임내용</label>
				            <textarea class="form-control" rows="10" id="tdmtngCn" name="tdmtngCn"></textarea>
				        </div>
						<div class="clsCiImgUrl  col-xs-12">
						</div>        
				        <div class="form-group">
				            <label>📂 이미지 파일</label>
				            <input type="file" id="uploadFile" name="uploadFile" class="file-upload-default">
				            <div class="input-group col-xs-12">
				                <input type="text" id="file-upload-info" class="form-control file-upload-info" disabled="" placeholder="파일선택">
				                <span class="input-group-append">
				                    <button class="file-upload-browse btn btn-primary" type="button">업로드</button>
				                </span>
				            </div>
				        </div>
				        <hr>
						<button type="button" id="btnTmtInsert" class="btn btn-primary mr-2">등록</button>
						<button class="btn btn-light" id="btnTmtInsertCen">취소</button>
						<button type="button" id="tmtAutobtn" style="border:none; background:none; margin-left: 1000px;">
							<img src="../resources/images/버튼.png" style="width:50px; height:50px;" />
						</button>
			        </form>
			    </div>
			</div>
		</div>
	</div>
</div>

<!-- 모임 등록 클릭 모달 -->
<div class="modal fade" id="modal-tmtCreat"  data-backdrop="static" tabindex="-1" aria-labelledby="exampleModalSmLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center"> 
        <div>
      	<button type="button" class="btn btn-inverse-primary" id="btnGoChat">채팅방입장</button>
      	<button type="button" class="btn btn-inverse-primary" id="btnGoDetail">게시글상세</button>
      </div>
      </div>
      <div class="modal-footer">
      <button type="button" id="btnModalClose" class="btn btn-primary">닫기</button>
      </div>
    </div>
  </div>
</div>
