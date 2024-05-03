<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.0/classic/ckeditor.js"></script>
<!-- <script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script> -->
<link rel="stylesheet" href="/resources/skydash/vendors/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/skydash/vendors/mdi/css/materialdesignicons.min.css">
<style>

	.ck-editor__editable_inline {
		min-height: 500px;
	}

	.ck-editor__editable_inline {
		min-height: 500px;
	}
	
	/* 댓글  */
	ul,
	li {
		display: contents;
	}

	.list-wrapper {
		overflow: hidden;
	}

	.ansInputDiv {
		margin-top: 20px;
	}

	.btnRegisterAns,
	.btnUdtAns,
	.btnCnsAns {
		color: #A4B4E0;
		font-size: 13px;
		padding: 5px 10px;
		margin: 10px 0px 10px 0px;
		border-radius: 10px;
		border: 1px solid #A4B4E0;
		background: #FFFFFF;
	}

	.btnRegisterAns:hover {
		color: #FFFFFF;
		background: #A4B4E0;
	}

	.btnRegisterDiv {
		display: flex;
		justify-content: end;
	}

	.ansAnsViewBtn {
		padding: 0px 15px;
	}

	.aftusBbscttAnswerCn {
		border: none;
		overflow: hidden;
		width: 100%;
	}

	.aftusBbscttAnswerCnUdt {
		overflow: hidden;
		width: 100%;
	}
</style>
<script type="text/javascript">
	$(function () {
		
		let userId = `${aftusBbscttVO.userId}`;
		console.log(userId);

		let sessionId = `${sessionId}`;
		console.log(sessionId);

		if (userId == sessionId) {
			$("#btnsUpdate").css("display", "inline");
		}
		if(sessionId!="" && sessionId!=userId){
			$("#btnDecl").show();
		}
		
		let sprviseAtchmnflNo = `${aftusBbscttVO.sprviseAtchmnflNo}`;
		console.log("sprviseAtchmnflNo : ", sprviseAtchmnflNo);
		if(sprviseAtchmnflNo != 0){
 			$("#btnFileView").show();
		}

		if (sessionId == null || sessionId == "") {
			//로그인 안 할 경우 댓글 막기
			$("#aftusBbscttAnswerCn").attr("placeholder", "로그인을 해주세요..");
			$("#ansInt").attr("readonly", "true");
		}
		
		$("#btnRvEdit").on("click", function () {
			$("#fileUploadDiv").css("display", "block");
			$("#fileGroup").css("display", "none");
			$("#btnRvList").css("display", "none");
		})


		//ckEditor 내용 입력
		$(".ck-blurred").keydown(function () {
			console.log("str : " + window.editor.getData());
			$("#aftusBbscttCn").val(window.editor.getData());
		});

		$(".ck-blurred").on("focusout", function () {
			console.log("str : " + window.editor.getData());
			$("#aftusBbscttCn").val(window.editor.getData());

		});

		//후기 수정
		$("#btnRvEdit").on("click", function () {
			$("#rvUdtFormDiv").css("display", "block");
			
			$(".notUdt").css("display", "none");

			$("#btnsUpdate").css("display", "none");
			$("#btnsCkUpdate").css("display", "block");

			$("#rvCon").css("display", "none");

			$("#imgUpDiv").css("display", "block");
		})
		
		//수정 취소 버튼 클릭
		$("#btnRvCancel").on("click", function () {
			$("#rvUdtFormDiv").css("display", "none");
			
			$(".notUdt").css("display", "block");

			$("#btnsUpdate").css("display", "block");
			$("#btnsCkUpdate").css("display", "none");

			$("#rvCon").css("display", "block");

			$("#imgUpDiv").css("display", "none");
		})

		//목록 클릭시 메인 이동
		$("#btnRvList").on("click", function () {
			location.href = "/reviewBoard/main";
		})
		
		//후기 삭제
		$("#btnRvDel").on("click", function () {
			let aftusBbscttNo = $("#aftusBbscttNo").val();
			Swal.fire({
				title: '정말 삭제 하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				reverseButtons: false,
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url: "/reviewBoard/delete",
						type: "post",
						data: { "aftusBbscttNo": aftusBbscttNo },
						success: function (result) {
							Swal.fire({
								title: '삭제가 완료 됐습니다.',
								icon: 'confirm',
								confirmButtonText: '확인',
							}).then((result) => {
								location.href = "/reviewBoard/main";
							})

						}

					})
				}
			})
		})

		//파일 삭제
		$(".ti-close").on("click", function () {
			let liElement = $(this).closest('li');

			let fileName = liElement.text().trim();
			let sprviseAtchmnflNo = liElement.find('input[name="sprviseAtchmnflNo"]').val();
			let atchmnflNo = liElement.find('input[name="atchmnflNo"]').val();

			console.log(sprviseAtchmnflNo);
			console.log(atchmnflNo);
			console.log($('#file-list li'));
			console.log(fileName);

			liElement.remove();

			let index = selectedFiles.indexOf(fileName);
			selectedFiles.splice(index, 1);

			let delFileInfo = {
				"sprviseAtchmnflNo": sprviseAtchmnflNo,
				"atchmnflNo": atchmnflNo
			};

			console.log(delFileInfo);

			$.ajax({
				url: "/reviewBoard/fileDel",
				type: "post",
				data: JSON.stringify(delFileInfo),
				contentType: "application/json;chatset=utf-8",
				dataType: "text",
				success: function (res) {
					console.log("fileDel->res : " + res);
				}

			});

		});

		//댓글 등록
		$("#ansInt").on("click", function () {
			console.log("하요");

			let userId = `${sessionId}`;

			let aftusBbscttAnswerCn = $("#aftusBbscttAnswerCn").val();

			let data = {
				"userId": userId,
				"aftusBbscttAnswerCn": aftusBbscttAnswerCn,
				"aftusBbscttNo": aftusBbscttNo
			}
			console.log("data", data)
			$.ajax({
				url: "/reviewBoard/insertAns",
				type: "post",
				data: JSON.stringify(data),
				contentType: "application/json;charset=utf-8",
				dataType: "text",
				success: function (res) {
					console.log("result : ", res);

					$("#aftusBbscttAnswerCn").val("");
					listAns();

					alarm(userId, detailId);
				}
		
			});
		});
	})

// 파일업로드
let selectedFiles = [];

function test(uploadFile) {
	console.log(uploadFile);
	const fileList = $('#file-list');


	for (let i = 0; i < uploadFile.length; i++) {

		selectedFiles.push(uploadFile[i]);
		console.log(selectedFiles);
		const item = $('<li></li>');
		const fileName = $(document.createTextNode(uploadFile[i].name));
		console.log(fileName);
		const deleteButton = $('<i class="remove ti-close"></i>');

		deleteButton.on('click', (event) => {
			item.remove();
			event.preventDefault();
			deleteFile(uploadFile[i]);
		});
		item.append(fileName);
		item.append(deleteButton);
		fileList.append(item);
	}
}

function deleteFile(deleteFile) {
	var inputFile = $("#uploadFile");
	var dataTransfer = new DataTransfer();
	selectedFiles = selectedFiles.filter(function (uploadFile) {
		return uploadFile !== deleteFile;
	});
	selectedFiles.forEach(function (uploadFile) {
		dataTransfer.items.add(uploadFile);
	});
	inputFile.files = dataTransfer.files;
}

//댓글 시작
var aftusBbscttNo = `${aftusBbscttVO.aftusBbscttNo}`;
var userId = `${sessionId}`;
console.log("userIdawdasd : " + userId);

let data = {
	"aftusBbscttNo": aftusBbscttNo
}
console.log(data);

// 댓글 조회
listAns();
function listAns() {
	$.ajax({
		url: "/reviewBoard/listAns",
		type: "post",
		data: data,
		dataType: "json",
		success: function (res) {
			console.log("listAnsResult : ", res);

			let str = "";
			$("#ansRes").html("");

			// res: aftusBbscttAnswerVO
			$.each(res, function (idx, aftusBbscttAnswerVO) {
				console.log("detailId : ", `\${aftusBbscttAnswerVO.userId}`);
				let detailId = `\${aftusBbscttAnswerVO.userId}`;
				console.log("userId : ", userId);

				let mberPhoto = aftusBbscttAnswerVO.mberProflPhoto;
				let proPhoto = aftusBbscttAnswerVO.proProflPhoto;
				console.log("회원 사진? ", mberPhoto);
				console.log("프로 사진? ", proPhoto);
				
				str += `
               			<div class="d-flex align-items-start profile-feed-item" style="justify-content: space-between;">
               				<div class="d-flex align-items-start" style="width: 100%;">
 						`
				if (proPhoto == null && mberPhoto != null) {
					console.log("회원 사진을 로딩해봐라!!");

					str += `<img src = "\${mberPhoto}"
									id = "usersPhoto" class="img-sm rounded-circle">
									`
				} else if (proPhoto != null && mberPhoto == null) {
					console.log("프로 사진 가져와");

					str += `<img src = "\${proPhoto}" 
									id = "usersPhoto" class="img-sm rounded-circle">
               						`
				} else {
					console.log("가만 있어!!");
					str += `<img src='/images/2024/profile.jpg' class="img-sm rounded-circle">
           							`
				}
				str += `
						<div class="ms-4" style="margin-left: 20px; width: 100%;">
							<div>
								<h6>
									\${aftusBbscttAnswerVO.userNcnm} (\${aftusBbscttAnswerVO.userId})
								</h6>
							</div>
							<textarea class="aftusBbscttAnswerCn" name="aftusBbscttAnswerCn"
								id="aftusBbscttAnswerCn\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" readonly
								style="display: block;">\${aftusBbscttAnswerVO.aftusBbscttAnswerCn}</textarea>
	
	            			<!-- 댓글 수정 클릭시 나타나야 되는 부분 -->
							<textarea class="form-control aftusBbscttAnswerCnUdt" id="aftusBbscttAnswerCnUdt\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
								name="aftusBbscttAnswerCnUdt\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" rows="4"
								style="display: none"></textarea>
	
							<button type="button" id="btnUdtAns\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" class="btnUdtAns"
								style="display: none">수정</button>
							<button type="button" id="btnCnsAns\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" class="btnCnsAns"
								style="display: none">취소</button>

							<!-- 대댓글 보기 닫기 버튼 -->
							<p class="small text-muted mt-2 mb-0">
								<span>\${aftusBbscttAnswerVO.aftusBbscttAnswerWrDt}&nbsp;&nbsp;&nbsp;</span>
								<span id="ansAnsView\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}">
									<button type="button" class="btn ansAnsViewBtn" id="ansAnsViewBtn\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
										name="ansAnsViewBtn\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
										onclick="ansAnsViewBtn(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo})">
									</button>
									<button type="button" class="btn ansAnsViewBtn" style="display:none;"
										id="ansAnsViewBtn2\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
										name="ansAnsViewBtn2\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}">
									</button>
								</span>
							</p>
						</div>
               		</div >
						<div class="dropdown">
							<a href="#" data-bs-toggle="dropdown" style="color:#4B49AC;">
								<i class="fa fa-ellipsis-v"></i></a>

							<div class="dropdown-menu">
								<ul>
									`
					if (userId == detailId) {
						str += `
	               				<li><a class="dropdown-item" href="javacsript:void(0);"
	               						onclick="udtAns(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});">수정</a></li>
	               				<li><a class="dropdown-item" href="javacsript:void(0);"
	               						onclick="delAns(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});">삭제</a></li>
	               				`
					} else {
						str += `
	               				<li><a class="dropdown-item" href=""
	               						onclick="ansDecl('AFTUS_BBSCTT_ANSWER',\${aftusBbscttAnswerVO.aftusBbscttAnswerNo},\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});"
	               						data-toggle="modal" data-target="#modal-sm">신고</a></li>
	               				`
					}
					str += `
								</ul>
							</div>
						</div>
					</div >
					<div id="panelsStayOpen-collapseOne\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" class="accordion-collapse collapse"
						style="margin-left:30px;" aria-labelledby="panelsStayOpen-headingOne">
						<div id="ansAnsInsDiv" style="margin-top:5px;">
							<div id="ansAns\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}">
								<textarea class="form-control" id="aftusBbscttAnswerCn2\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
									name="aftusBbscttAnswerCn2\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" rows="4"
									placeholder="답글 추가.."></textarea>
								<div class="btnRegisterDiv">
									<button type="button" class="btnRegisterAns" id="ansInt3\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
										name="ansInt3\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}"
										onclick="ansAnsInt(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});">등록</button>
								</div>
							</div>
						</div>
					</div>
					`
				ansAnsCnt(`\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}`);
			})
			$("#ansRes").append(str);
		}
	});
}



//대댓글 등록
function ansAnsInt(no) {
	console.log(no);
	$("#ansInt2" + no).hide();
	$("#ansAns" + no).show();
	console.log("왔나");

	let aftusBbscttAnswerCn = $("#aftusBbscttAnswerCn2" + no).val();

	let data = {
		"userId": userId,
		"aftusBbscttNo": aftusBbscttNo,
		"aftusBbscttAnswerCn": aftusBbscttAnswerCn,
		"ptAftusBbscttAnswerNo": no,
		"ptAftusBbscttNo": aftusBbscttNo,
	}
	console.log("ansAnsdata : ", data)

	$.ajax({
		url: "/reviewBoard/ansAnsInt",
		type: "post",
		data: JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType: "text",
		success: function (res) {
			console.log("res : ", res);
			
			$("#aftusBbscttAnswerCn2" + no).val("");
			
			ansAnsCnt(no);
			ansAnsViewBtn(no);
		}
	});

};

//대댓글 달기 취소
function cnsInt(no) {
	$("#ansAns" + no).hide();
	$("#ansInt2" + no).show();
	$("aftusBbscttAnswerCn2" + no).html("");

};


//대댓글 보기
function ansAnsViewBtn(no) {
	console.log("대댓글 보러 왔다")
	console.log(no);

	if (userId == null || userId == "") {
		console.log("없다 이자식아");

		$("#aftusBbscttAnswerCn2" + no).attr("placeholder", "로그인을 해주세요..");
		$("#ansInt3" + no).attr("readonly", "true");

	}
	$("#ansAnsViewBtn" + no).hide();
	$("#ansAnsViewBtn2" + no).show();
	$("#panelsStayOpen-collapseOne" + no).show();

	$("#ansAnsViewBtn2" + no).on("click", function () {
		$("#ansAnsViewBtn" + no).show();
		$("#ansAnsViewBtn2" + no).hide();
		$("#panelsStayOpen-collapseOne" + no).hide();
	});

	listAnsans()

	function listAnsans() {
		$.ajax({
			url: "/reviewBoard/ansAnsView",
			type: "post",
			data: {"ptAftusBbscttAnswerNo": no},
			dataType: "json",
			success: function (res) {
				console.log("res : ", res);
				let str = "";
				$("#panelsStayOpen-collapseOne" + no).children().not("#ansAnsInsDiv").empty();
				$.each(res, function (idx, aftusBbscttAnswerVO) {

					let ansuserId = aftusBbscttAnswerVO.userId;

					console.log("ansuserId : ", ansuserId);
					console.log("userId : ", userId);
					
					let mberPhoto = aftusBbscttAnswerVO.mberProflPhoto;
					let proPhoto = aftusBbscttAnswerVO.proProflPhoto;
	
					str += `
							<div id = "ansAnsView3\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}">
								<div class="d-flex align-items-start profile-feed-item" style = "justify-content: space-between;">
									<div class="d-flex align-items-start" style="width: 100%;">
							`
					if (proPhoto == null && mberPhoto != null) {
					console.log("회원 사진을 로딩해봐라!!");

					str += `<img src = "\${mberPhoto}"
									id = "usersPhoto" class="img-sm rounded-circle">
									`
				} else if (proPhoto != null && mberPhoto == null) {
					console.log("프로 사진 가져와");

					str += `<img src = "\${proPhoto}" 
									id = "usersPhoto" class="img-sm rounded-circle">
             						`
				} else {
					console.log("가만 있어!!");
					str += `<img src='/images/2024/profile.jpg' class="img-sm rounded-circle">
         							`
				}
		
					str += `
							<div class="ms-4" style="margin-left: 20px; width: 100%;">
								<div>
									<h6>\${aftusBbscttAnswerVO.userNcnm} (\${aftusBbscttAnswerVO.userId})</h6>
								</div>
								<textarea class="aftusBbscttAnswerCn" name="aftusBbscttAnswerCn" 
	                				id="aftusBbscttAnswerCn\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" readonly 
	                				style="display: block;">\${aftusBbscttAnswerVO.aftusBbscttAnswerCn}</textarea>
							
								<!-- 댓글 수정 클릭시 나타나야 되는 부분 -->
								<textarea class="form-control aftusBbscttAnswerCnUdt" id="aftusBbscttAnswerCnUdt\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" 
									name="aftusBbscttAnswerCnUdt\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" rows="4"
									style="display: none"></textarea>
								<button type="button" id="btnUdtAns\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" 
									class="btnUdtAns" style="display: none">수정</button>
								<button type="button" id="btnCnsAns\${aftusBbscttAnswerVO.aftusBbscttAnswerNo}" 
									class="btnCnsAns" style="display: none">취소</button>
								<p class="small text-muted mt-2 mb-0">
								<span>\${aftusBbscttAnswerVO.aftusBbscttAnswerWrDt}&nbsp;&nbsp;&nbsp;</span>
								</p>
							</div>
						</div>
					<div class="dropdown">
					<a href="#" data-bs-toggle="dropdown" style="color:#4B49AC;">
						<i class="fa fa-ellipsis-v"></i></a>
						<div class="dropdown-menu ansDropdown">
							<ul>
					`
					if (userId == ansuserId) {
						str += `
 					    <li><a class="dropdown-item" href="javacsript:void(0);" onclick="udtAnsans(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});">수정</a></li>
 					    <li><a class="dropdown-item" href="javacsript:void(0);" onclick="delAnsans(\${aftusBbscttAnswerVO.aftusBbscttAnswerNo},\${no});">삭제</a></li>
 					`
					} else {
						str += `
 						<li><a class="dropdown-item" href="" 
 						onclick="ansDecl(\${aftusBbscttAnswerVO.aftusBbscttNo},\${aftusBbscttAnswerVO.aftusBbscttAnswerNo});" 
 							data-toggle="modal" data-target="#modal-sm">신고</a></li>
 					`
					}
					str += `
							</ul>
						</div>
					</div>
				</div>
			</div >
			`
				});
				$("#panelsStayOpen-collapseOne" + no).prepend(str);
			}
		});
	}
};

//댓글 수정
function udtAns(no) {

	console.log("수정");

	console.log(no);

	$("#aftusBbscttAnswerCn" + no).hide();
	$("#aftusBbscttAnswerCnUdt" + no).val($("#aftusBbscttAnswerCn" + no).text());
	$("#aftusBbscttAnswerCnUdt" + no).show();

	//댓글 수정/취소 버튼 보이기
	$("#btnUdtAns" + no).show();
	$("#btnCnsAns" + no).show();

	//취소 클릭시
	$("#btnCnsAns" + no).on("click", function () {
		console.log("눌러보겠다!!");
		$("#aftusBbscttAnswerCn" + no).css("display", "block");
		$("#aftusBbscttAnswerCnUdt" + no).css("display", "none");
		$("#btnUdtAns" + no).hide();
		$("#btnCnsAns" + no).hide();
	});

	//수정 클릭시
	$("#btnUdtAns" + no).on("click", function () {
		console.log("할룽");
		console.log($("#aftusBbscttAnswerCn" + no).val())
		let aftusBbscttAnswerCn = $("#aftusBbscttAnswerCnUdt" + no).val();
		console.log(no);

		let data = {
			"aftusBbscttAnswerNo": no,
			"aftusBbscttAnswerCn": aftusBbscttAnswerCn
		}

		$.ajax({
			url: "/reviewBoard/updateAns",
			type: "post",
			data: JSON.stringify(data),
			contentType: "application/json;charset=UTF-8",
			dataType: "text",
			success: function (res) {
				console.log("res", res);
				listAns();
				$("#btnUdtAns" + no).hide();
				$("#btnCnsAns" + no).hide();
				$("#aftusBbscttAnswerCn" + no).show();
			}
		});
	});

	// 	$("#btnUdtAns"+no).val()

}


//댓글 삭제
function delAns(no) {
	console.log("삭제");

	console.log("no : ", no);

	$.ajax({
		url: "/reviewBoard/deleteAns",
		type: "post",
		data: { "aftusBbscttAnswerNo": no },
		dataType: "text",
		success: function (res) {
			console.log("delres : ", res)
			listAns();
		}
	});

}

//대댓글 갯수
function ansAnsCnt(no) {
	$.ajax({
		url: "/reviewBoard/ansAnsCnt",
		type: "post",
		data: { "ptAftusBbscttAnswerNo": no },
		dataType: "text",
		success: function (res) {
			console.log("cnt", res);
			$("#ansAnsViewBtn" + no).html("답글 " + res + "개 ▼");
			$("#ansAnsViewBtn2" + no).html("답글 " + res + "개  ▲");

			if (res == 0) {
				$("#ansAnsViewBtn" + no).html("답글");
				$("#ansAnsViewBtn2" + no).html("답글");
			}

		}

	});
}

//대댓글 수정
function udtAnsans(no) {
	console.log("대댓글 수정");
	console.log(no);

	$("#aftusBbscttAnswerCn" + no).hide();
	$("#aftusBbscttAnswerCnUdt" + no).val($("#aftusBbscttAnswerCn" + no).text());
	$("#aftusBbscttAnswerCnUdt" + no).show();

	//수정/취소 버튼 보이기
	$("#btnUdtAns" + no).show();
	$("#btnCnsAns" + no).show();

	//취소 클릭시
	$("#btnCnsAns" + no).on("click", function () {
		console.log("눌러보겠다!!");
		$("#aftusBbscttAnswerCn" + no).show();
		$("#aftusBbscttAnswerCnUdt" + no).hide();
		$("#btnUdtAns" + no).hide();
		$("#btnCnsAns" + no).hide();
	});

	$("#btnUdtAns" + no).on("click", function () {
		console.log("할룽");
		console.log($("#aftusBbscttAnswerCn" + no).val())
		let aftusBbscttAnswerCn = $("#aftusBbscttAnswerCnUdt" + no).val();
		console.log(no);

		let data = {
			"aftusBbscttAnswerNo": no,
			"aftusBbscttAnswerCn": aftusBbscttAnswerCn
		}


		$.ajax({
			url: "/reviewBoard/updateAns",
			type: "post",
			data: JSON.stringify(data),
			contentType: "application/json;charset=UTF-8",
			dataType: "text",
			success: function (res) {
				console.log("res", res);
				ansAnsViewBtn(no);

				$("#btnUdtAns" + no).hide();
				$("#btnCnsAns" + no).hide();

				$("#aftusBbscttAnswerCn" + no).text(aftusBbscttAnswerCn);

				$("#aftusBbscttAnswerCn" + no).show();

				$("#aftusBbscttAnswerCnUdt" + no).hide();
			}
		});
	});



}

//대댓글 삭제
function delAnsans(aftusBbscttAnswerNo, ptAftusBbscttAnswerNo) {
	console.log("삭제");
	console.log("넘어온 대댓글 번호 : ", aftusBbscttAnswerNo);
	console.log("넘어온 원댓글 번호 : ", ptAftusBbscttAnswerNo);


	$.ajax({
		url: "/reviewBoard/deleteAns",
		type: "post",
		data: { "aftusBbscttAnswerNo": aftusBbscttAnswerNo },
		dataType: "text",
		success: function (res) {
			console.log("res", res)
			$("#ansAnsView3" + aftusBbscttAnswerNo).hide();
			//여기서 필요한것은 38이라는 숫자입니다..
			ansAnsCnt(ptAftusBbscttAnswerNo);

		}
	});

}
//댓글 끝

</script>
<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div style="display: flex; flex-wrap: wrap;">
					<img id="btnDecl" src="../resources/images/사이렌2.png" style="width: 25px; margin: 30px 0px 5px 1220px; display: none;"
						data-toggle="modal" data-target="#modal-sm">
				</div>
				<div class="card-body">
					<form action="/reviewBoard/update" class="forms-sample" name="rvUpdate" method="post" enctype="multipart/form-data">
						<div class="container-fluid notUdt">
							<!-- 파일번호가 0으로 넘어가면 update가 아닌 insert를 해주기 위한 처리 -->
	 						<input type="hidden" name="sprviseAtchmnflNo" value="${aftusBbscttVO.sprviseAtchmnflNo}">
	 						<input type="hidden" id="aftusBbscttNo" name="aftusBbscttNo" value="${aftusBbscttVO.aftusBbscttNo}">
							<h2 class="text-center my-5" style="font-family: GMarketSansMedium">${aftusBbscttVO.aftusBbscttSj}</h2>
							<div style="margin-left: 76%;">
								<p style="font-family: GMarketSansLight; display: inline; font-size:15px; margin-right: 15px;">작성자</p>
								<p style="display: inline; font-size:15px;">${aftusBbscttVO.userNcnm}</p>
								<br />
								<p style="font-family: GMarketSansLight; display: inline; font-size:15px; margin-right: 30px;">프로</p>
								<p style="display: inline; font-size:15px;">${aftusBbscttVO.proId}</p>
								<br />
								<p style="font-family: GMarketSansLight; display: inline; font-size:15px; margin-right: 15px;">작성일</p>
								<p style="display: inline; font-size:15px;">${aftusBbscttVO.aftusBbscttWrDt}</p>
							</div>
							<hr>
							<div class="container-fluid w-100" style="margin-top: 10px;">							
								<!-- 파일  -->
								<div class="fileDiv" style="display: flex; justify-content: end;">
									<div class="dropdown" id="fileGroup">
										<button class="btn btn-inverse-primary dropdown-toggle" type="button" id="btnFileView" data-bs-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false" style="display: none;">
											<i class="fa fa-download"></i>첨부파일
										</button>
										<div class="dropdown-menu" id="fileListDiv" aria-labelledby="dropdownMenuIconButton6">
											<c:forEach var="fileList" items="${fileList}" varStatus="stat">
												<!-- 상세화면 파일 리스트 -->
												<a class="dropdown-item" href="${fileList.atchmnflCours}"
													download="${fileList.atchmnflNm}"> ${fileList.atchmnflNm}</a>
											</c:forEach>
										</div>
									</div>
									
								</div>
								<!-- 내용 -->
								<div>
									<h5 class="mb-5" style="font-family: GmarketSansLight; padding-left: 20px;">${aftusBbscttVO.aftusBbscttCn}</h5>
								</div>
							</div>
							<hr>
						</div>
						<div class="container-fluid" id="rvUdtFormDiv" style="display: none;">
							<div class="form-group">
								<label for="aftusBbscttSj">제목</label>
								<input type="text" class="form-control" id="aftusBbscttSj"
								name="aftusBbscttSj" value="${aftusBbscttVO.aftusBbscttSj}">	
							</div>
							<div class="form-group">		
							<label for="aftusBbscttCn">내용</label>
								<div id="ckEditor">${aftusBbscttVO.aftusBbscttCn}</div>
								<textarea class="form-control" rows="10" id="aftusBbscttCn" name="aftusBbscttCn"
									style="display: none;"></textarea>
							</div>
							<div class="form-group" id="fileUploadDiv" style="display: none; margin-top: 24px;">
								<div class="list-wrapper">
									<ul class="d-flex flex-row todo-list todo-list-custom" id="file-list">
										<!-- 수정시 기존 파일리스트가 들어가는 곳 -->
										<c:forEach var="fileList" items="${fileList}" varStatus="stat">
											<li>${fileList.atchmnflNm}<i class="remove ti-close"></i> <input type="hidden" name="sprviseAtchmnflNo"
													value="${fileList.sprviseAtchmnflNo}"></input> <input type="hidden" name="atchmnflNo"
													value="${fileList.atchmnflNo}"></input>
											</li>
										</c:forEach>
									</ul>
								</div>
								
								<div class="input-group">
									<div class="custom-file">
										<input type="file" id="uploadFile" name="uploadFile"
											class="file-upload-default" multiple="multiple"
											onchange="test(this.files)">
											<span class="input-group-append">
											<button class="file-upload-browse btn btn-primary" type="button">업로드</button>
										</span>
									</div>
								</div>
							</div>
							<hr>
						</div>
						<!-- 버튼 그룹 -->
						<div class="container-fluid w-100" style="display: flex; flex-wrap: wrap; float: right;">
							
							<div id="btnsUpdate" style="display: none; margin-right: 5px;">
								<button type="button" id="btnRvEdit" class="btn btn-outline-primary">수정</button>
								<button type="button" id="btnRvDel" class="btn btn-outline-primary">삭제</button>
							</div>
								<button type="button" class="btn btn-outline-secondary" id="btnRvList">목록</button>
							<div id="btnsCkUpdate" style="display: none;">
								<button type="submit" id="btnRvCkEdit" class="btn btn-primary mr-2">확인</button>
								<button type="button" id="btnRvCancel" class="btn btn-light">취소</button>
							</div>							
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 댓글 그룹 -->
<div class="content-wrapper"
	style="margin-top:50p; padding-top: 0; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<p class="card-title">댓글 목록</p>
					<div id="ansView">
						<div class="form-group">
							<div>
								<textarea class="form-control ansInputDiv" id="aftusBbscttAnswerCn" name="aftusBbscttAnswerCn" rows="4"
									placeholder="댓글 추가.."></textarea>
								<div class="btnRegisterDiv">
									<button type="button" id="ansInt" name="ansInt" class="btnRegisterAns">등록</button>
								</div>
							</div>
							<div id="ansRes"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- CK Editor -->
<script type="text/javascript">
	ClassicEditor
		.create(document.querySelector('#ckEditor'),
			{ ckfinder: { uploadUrl: '/upload/uploads' } })
		.then(editor => { window.editor = editor; })
		.catch(err => { console.error(err.stack); });
</script>