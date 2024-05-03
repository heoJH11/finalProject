<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<link type="text/css" rel="stylesheet"
	href="/resources/ckeditor5/sample/css/sample.css" media="screen" />
<style>
/* .form-control {
	background-attachment: local;
	background-image: linear-gradient(to right, white 10px, transparent 10px),
		linear-gradient(to left, white 10px, transparent 10px),
		repeating-linear-gradient(white, white 30px, #ccc 30px, #ccc 31px, white
		31px);
	line-height: 31px;
	padding: 8px 10px;
} */
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

h3,b,p,textarea,small,a{
	font-family: 'GmarketSansMedium';
}
div {
	border: 1em;
}
.ansAnsView2Class{
	margin-left: 3em;
}
.fileList{
	margin-left: 3em;
}
</style>
<script type="text/javascript">
//신고하기
function ansDecl(declTarget,lbrtyBbscttNo,lbrtyBbscttAnswerNo){
	//console.log("신고하기의 vo : ",vo);
	console.log("신고하기의 declTarget : ",declTarget);
	console.log("신고하기의 lbrtyBbscttNo : ",lbrtyBbscttNo);
	console.log("신고하기의lbrtyBbscttAnswerNo : ",lbrtyBbscttAnswerNo);
	
	$("#declTarget").val(declTarget);
	$("#declLbrtyBbscttNo").val(lbrtyBbscttNo);
	$("#declLbrtyBbscttAnswerNo").val(lbrtyBbscttAnswerNo);
};

//첨부파일 여러개 올리고 삭제하기
let selectedFiles = [];

function test(files) {
    console.log("이건가?1 :",files);
    const fileList = document.getElementById('file-list');
    console.log("이건가?2 : ", fileList);
    
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
//===============================

// 첨부파일 삭제 버튼 이벤드
function fileDel(sprviseAtchmnflNo,atchmnflNo,statCount){
	console.log("sprviseAtchmnflNo : " + sprviseAtchmnflNo);
	console.log("atchmnflNo : " + atchmnflNo);
	console.log("statCount : " + statCount)
	
	let data = {
		"sprviseAtchmnflNo":sprviseAtchmnflNo,
		"atchmnflNo":atchmnflNo
	}
	console.log("data : ",data)
	
	$.ajax({
		url:"/lbrtybbsctt/fileDel",
		type:"post",		
		data:JSON.stringify(data),
		contentType:"application/json;chatset=utf-8",
		dataType:"json",
		success:function(res){
			console.log("fileDel->res : " ,res);
			console.log("fileDel->res.at" + res.atchmnflNo);
			let atchmnflNo = res.atchmnflNo
			$("#fileDel"+atchmnflNo).hide();
		}
		
	});
}

/* //시간을 ..전으로 만들어주는 함수
function displayedAt(createdAt) {
  const milliSeconds = new Date() - createdAt
  const seconds = milliSeconds / 1000
  if (seconds < 60) return `방금 전`
  const minutes = seconds / 60
  if (minutes < 60) return `${Math.floor(minutes)}분 전`
  const hours = minutes / 60
  if (hours < 24) return `${Math.floor(hours)}시간 전`
  const days = hours / 24
  if (days < 7) return `${Math.floor(days)}일 전`
  const weeks = days / 7
  if (weeks < 5) return `${Math.floor(weeks)}주 전`
  const months = days / 30
  if (months < 12) return `${Math.floor(months)}개월 전`
  const years = days / 365
  return `${Math.floor(years)}년 전`
} */

function ansAnsCnt(no){
$.ajax({
	url:"/lbrtybbsctt/ansAnsCnt",
	type:"post",
	data:JSON.stringify({
		"ptLbrtyBbscttAnswerNo":no
	}),
	contentType:"application/json;charset=utf-8",
	dataType:"text",
	success:function(res){
		console.log("cnt",res);
		$("#ansAnsViewBtn"+no).html("답글 "+ res + "개 ▼");
		$("#ansAnsViewBtn2"+no).html("답글 "+ res +"개  ▲");
		
		if(res==0){
			$("#ansAnsView"+no).hide();
		}else{
			$("#ansAnsView"+no).show();
		}
		
	}

});
}


function udtAns(no){
	console.log("내용 : ", $("#lbrtyBbscttAnswerCn"+no).val());
	console.log("수정");
	
	let beforCn = $("#lbrtyBbscttAnswerCn"+no).val();
	
	console.log(no);
	
	$("#lbrtyBbscttAnswerCn"+no).attr("readonly", false);
	console.log("#ansUdt"+no);
	console.log("#ansCns"+no);
	console.log("#lbrtyBbscttAnswerCn"+no);
	
	
	$("#ansUdt"+no).show();
	$("#ansCns"+no).show();
	
	$("#ansCns"+no).on("click",function(){
		console.log("눌러보겠다!!");
		$("#lbrtyBbscttAnswerCn"+no).val(beforCn);
		$("#lbrtyBbscttAnswerCn"+no).attr("readonly", true);
		$("#ansUdt"+no).hide();
		$("#ansCns"+no).hide();
	});
	
	$("#ansUdt"+no).on("click",function(){
		console.log("할룽");
		console.log($("#lbrtyBbscttAnswerCn"+no).val())
		let lbrtyBbscttAnswerCn = $("#lbrtyBbscttAnswerCn"+no).val();
		console.log(no);
		
		let data = {
			"lbrtyBbscttAnswerNo" : no,
			"lbrtyBbscttAnswerCn" : lbrtyBbscttAnswerCn
			
		}
		
		$.ajax({
			url:"/lbrtybbsctt/updataAns",
			type:"post",
			data:JSON.stringify(data),
			contentType:"application/json;charset=UTF-8",
			dataType:"text",
			success:function(res){
				console.log("res",res);
				listAns();
				$("#ansUdt"+no).hide();
				$("#lbrtyBbscttAnswerCn"+no).attr("readonly", true);
			}
		});
	});
	
	$("#ansUdt"+no).val()
	
}

//대댓글 수정
function udtAnsans(no){
	
	let beforCn = $("#lbrtyBbscttAnswerCn"+no).val();
	
	console.log("수정");
	console.log(no);
	//$("#ansCns"+no)
	$("#lbrtyBbscttAnswerCn"+no).attr("readonly", false);
	console.log("#ansUdt"+no);
	console.log("#lbrtyBbscttAnswerCn"+no);
	
	
	$("#ansUdt"+no).show();
	$("#ansCns"+no).show();
	
	$("#ansCns"+no).on("click",function(){
		console.log("눌러보겠다!!");
		$("#lbrtyBbscttAnswerCn"+no).val(beforCn);
		$("#lbrtyBbscttAnswerCn"+no).attr("readonly", true);
		$("#ansUdt"+no).hide();
		$("#ansCns"+no).hide();
	});
	
	
	$("#ansUdt"+no).on("click",function(){
		$("#ansCns"+no).hide();
		console.log("할룽");
		console.log($("#lbrtyBbscttAnswerCn"+no).val())
		let lbrtyBbscttAnswerCn = $("#lbrtyBbscttAnswerCn"+no).val();
		console.log(no);
		
		let data = {
			"lbrtyBbscttAnswerNo" : no,
			"lbrtyBbscttAnswerCn" : lbrtyBbscttAnswerCn
		}
		
		$.ajax({
			url:"/lbrtybbsctt/updataAns",
			type:"post",
			data:JSON.stringify(data),
			contentType:"application/json;charset=UTF-8",
			dataType:"text",
			success:function(res){
				console.log("res",res);
				ansAnsViewBtn(no)
				$("#ansUdt"+no).hide();
				$("#lbrtyBbscttAnswerCn"+no).attr("readonly", true);
			}
		});
	});
	
	$("#ansUdt"+no).val()
	
}

//댓글 삭제
function delAns(no){
	console.log("삭제");
	console.log(no);
	let data = {
		"lbrtyBbscttAnswerNo": no
	}
	console.log("no : ", no);
	
	$.ajax({
		url:"/lbrtybbsctt/deleteAns",
		type:"post",
		data:JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		dataType:"text",
		success:function(res){
			console.log("res",res)
			listAns();
		}
	});
	
}

//대댓글 삭제
function delAnsans(lbrtyBbscttAnswerNo,ptLbrtyBbscttAnswerNo){
	console.log("삭제");
	console.log("넘어온 대댓글 번호 : ",lbrtyBbscttAnswerNo);
	console.log("넘어온 댓글 번호: ",ptLbrtyBbscttAnswerNo);
	let data = {
		"lbrtyBbscttAnswerNo": lbrtyBbscttAnswerNo
	}
	
	$.ajax({
		url:"/lbrtybbsctt/deleteAns",
		type:"post",
		data:JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		dataType:"text",
		success:function(res){
			console.log("res",res)
			$("#ansAnsView3"+lbrtyBbscttAnswerNo).hide();
			//여기서 필요한것은 38이라는 숫자입니다..
			ansAnsCnt(ptLbrtyBbscttAnswerNo);
			/* $.ajax({
				url:"/lbrtybbsctt/ansAnsCnt",
				type:"post",
				data:JSON.stringify({
					"ptLbrtyBbscttAnswerNo":ptLbrtyBbscttAnswerNo
				}),
				contentType:"application/json;charset=utf-8",
				dataType:"text",
				success:function(res){
					console.log(res)
					//ansAnsViewBtn238
					
					console.log($("#ansAnsView"+ptLbrtyBbscttAnswerNo));
					if(res==0){
						$("#ansAnsView"+ptLbrtyBbscttAnswerNo).hide();
					}
				}
			}); */
		}
	});
	
}

var lbrtyBbscttNo = "${detail.lbrtyBbscttNo}";
var userId = `${userId}`;
console.log("userIdawdasd : " + userId);
//댓글 관련
let data = {
	"lbrtyBbscttNo" : lbrtyBbscttNo
}
// 댓글 조회
listAns();
function listAns(){
	$.ajax({
		url:"/lbrtybbsctt/listAns",
		type:"post",
		data:JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		success:function(res){
			console.log("result : ",res);
			
			let str = "";
			$("#ansRes").html("");
			
			//res : LbrtyBbscttAnswerVO
			$.each(res,function(idx,LbrtyBbscttAnswerVO){
				//console.log(displayedAt(0010812433000));
				console.log("detailId : ",`\${LbrtyBbscttAnswerVO.userId}`);
				let detailId = `\${LbrtyBbscttAnswerVO.userId}`;
				console.log("sessionId : ", userId);
				
				str+=`
				
				<div class="gams\${idx}">
				
				<div class="lbsdropdown">
				<button class="btn dropdown" type="button" style="float: right;"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					aria-expanded="false"><b>⋮</b> 
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
				`
				
				if(userId == detailId){
					str +=`
					<li><a class="dropdown-item" href="javacsript:void(0);" onclick="udtAns(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});" >수정</a></li>
					<li><a class="dropdown-item" href="javacsript:void(0);" onclick="delAns(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});" >삭제</a></li>
					`
				}else{
					str +=`
						<li><a class="dropdown-item" href="javacsript:void(0);" 
						onclick="ansDecl('LBRTY_BBSCTT_ANSWER',\${LbrtyBbscttAnswerVO.lbrtyBbscttNo},\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});" 
							data-toggle="modal" data-target="#modal-sm">신고</a></li>
					`
				}
				str+=`
				</ul>
				</div>
				<a style="display:none;">댓글번호 : <span class="gam\${idx}">\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}</span></a><br>
				<b>\${LbrtyBbscttAnswerVO.userNcnm} (\${LbrtyBbscttAnswerVO.userId})</b> <small>&nbsp&nbsp\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerWrDt}</small><br>
				<textarea name="lbrtyBbscttCn" id="lbrtyBbscttAnswerCn\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}" 
				readonly rows="1" cols="50" 
				style="border: none" >\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerCn}</textarea>
				
				<button type="button" class="btn btn-block" style="width:2.5cm; display:none;"
					id="ansUdt\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">등록</button>
				<button type="button" class="btn btn-block" style="width:2.5cm; display:none;"
					id="ansCns\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">취소</button>
				`
				console.log("userId == ",userId);
				if(userId==null || userId==""){
					console.log("userId가 없지롱");
				}else{
					str+=`
						<button type="button" class="btn btn-block" style="width:2.5cm; display:block;"
							id="ansInt2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}" 
							name="ansInt2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
							onclick="ansAnsInt(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});">답글 </button>
						`
				}
				str+=`
				<div id="ansAns\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}" style="display:none;">
				<br>
					<textarea 
					style="border: none" id="lbrtyBbscttAnswerCn2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
					name="lbrtyBbscttAnswerCn2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
					rows="1" cols="50" placeholder="답글을 입력해주세요..."></textarea>
					<button type="button" class="btn" style="width:2.5cm;"
						id="ansInt3\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
						name="ansInt3\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
						>등록</button>
					<button type="button" class="btn" style="width:2.5cm;"
						id="cnsInt\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
						name="cnsInt\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
						onclick="cnsInt(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});">취소</button>
				</div>
					<div id="ansAnsView\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">
						<button type="button" class="btn" style="width:4cm;"
							id="ansAnsViewBtn\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}" 
							name="ansAnsViewBtn\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
							onclick="ansAnsViewBtn(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo})">
							답글 보기</button>
						<button type="button" class="btn" style="width:4cm; display:none;"
							id="ansAnsViewBtn2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}" 
							name="ansAnsViewBtn2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">
							답글 보기 </button>
						<div class="ansAnsView2Class" id="ansAnsView2\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
						style="display:none;">
						</div>
					</div>
				</div>
				
				<hr>
				`; 
				ansAnsCnt(`\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}`)
			})
		
			$("#ansRes").append(str);
		
		}
	});
	}

//답글 달기
function ansAnsInt(no){
	console.log(no);
	$("#ansInt2"+no).hide();
	$("#ansAns"+no).show();
	//여기서 최초 날린 값만 추가가 되게 하면 된다.
	// 해당 버튼에 대한 클릭 이벤트 핸들러를 한 번만 바인딩
	$("#ansInt3"+no).off("click").on("click",function(){
		let lbrtyBbscttAnswerCn = $("#lbrtyBbscttAnswerCn2"+no).val();
		console.log($("#lbrtyBbscttAnswerCn2"+no).val());
		//여기서 이벤트가 계속 누적이 됨.
		if(lbrtyBbscttAnswerCn=="") {
			Swal.fire({
	          icon: 'error',
	          title: '내용 없음',
	          text: '내용을 입력해주세요..',
	          confirmButtonText: '확인',
	        });
		return;
		};
		
		let data = {
				/* $(세션이름.id 또는 닉네임) */
				"userId":"${userId}",
				"lbrtyBbscttNo":lbrtyBbscttNo,
				"lbrtyBbscttAnswerCn":lbrtyBbscttAnswerCn,
				"ptLbrtyBbscttAnswerNo":no,
				"ptLbrtyBbscttNo":lbrtyBbscttNo,
			}
		console.log("data : ",data)
		
		$.ajax({
			url:"/lbrtybbsctt/ansAnsInt",
			type:"post",
			data:JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			dataType:"text",
			success:function(res){
				console.log("res : ",res);
				console.log("no : ",no);
				$("#lbrtyBbscttAnswerCn2"+no).val("");
				ansAnsCnt(no);
				ansAnsViewBtn(no);
				
			}
		});
	});
};
//답글 달기 취소
function cnsInt(no){
	$("#ansAns"+no).hide();
	$("#ansInt2"+no).show();
	$("lbrtyBbscttAnswerCn2"+no).html("");
	
};

//답글 보기
function ansAnsViewBtn(no){
	console.log(no);
	$("#ansAnsViewBtn"+no).hide();
	$("#ansAnsViewBtn2"+no).show();
	$("#ansAnsView2"+no).show();
	
		//console.log("돨까요?");
	$("#ansAnsViewBtn2"+no).on("click",function(){
		$("#ansAnsViewBtn"+no).show();
		$("#ansAnsViewBtn2"+no).hide();
		$("#ansAnsView2"+no).hide();
	});
	
	
	console.log("data",data)
	listAnsans(no)
	
	

	
	
};
function listAnsans(no){
	let data = {
			/* $(세션이름.id 또는 닉네임) */
			//"lbrtyBbscttNo":lbrtyBbscttNo,
			"ptLbrtyBbscttAnswerNo":no,
			//"ptLbrtyBbscttNo":lbrtyBbscttNo,
			
		}
$.ajax({
	url:"/lbrtybbsctt/ansAnsView",
	type:"post",
	data:JSON.stringify(data),
	contentType:"application/json;charset=utf-8",
	dataType:"json",
	success:function(res){
		console.log("res : ", res);
		let str = "";
		$("#ansAnsView2"+no).html("");
		$.each(res,function(idx,LbrtyBbscttAnswerVO){
			console.log("ansuserId : ",`\${LbrtyBbscttAnswerVO.userId}`);
			let ansuserId = `\${LbrtyBbscttAnswerVO.userId}`;
			str+=`
				<div id="ansAnsView3\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">
				`
				if(userId==null || userId==""){
					console.log("userId  ~~ : ", userId);
					console.log("sessionId가 없다!!!!")
				}else{
				str+=`
				<div class="lbsdropdown">
				<button class="btn dropdown" type="button" style="float: right;"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					aria-expanded="false"><b>⋮</b></button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">`
				if(userId==ansuserId){
					str+=`
					<li><a class="dropdown-item" href="javacsript:void(0);" onclick="udtAnsans(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});" >수정</a></li>
					<li><a class="dropdown-item" href="javacsript:void(0);" onclick="delAnsans(\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo},\${no});">삭제</a></li>
					`
				}else{
					str+=`
						<li><a class="dropdown-item" href="javacsript:void(0);" 
						onclick="ansDecl(\${LbrtyBbscttAnswerVO.lbrtyBbscttNo},\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo});" 
							data-toggle="modal" data-target="#modal-sm">신고</a></li>
					`
				}
				str+=`
				</ul>
				</div>
				`
				}
				str+=`
					<a style="display:none;">댓글번호 : <span class="gam\${idx}">\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}</span></a><br>
					<b>\${LbrtyBbscttAnswerVO.userNcnm} (\${LbrtyBbscttAnswerVO.userId})</b> <small>&nbsp;&nbsp;\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerWrDt}</small><br>
					<textarea name="lbrtyBbscttCn" id="lbrtyBbscttAnswerCn\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}"
					readonly rows="1" cols="50" 
					style="border: none" >\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerCn}</textarea>
					<button type="button" class="btn btn-block" style="width:2.5cm; display:none;"
						id="ansUdt\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">등록</button>
					<button type="button" class="btn btn-block" style="width:2.5cm; display:none;"
						id="ansCns\${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerNo}">취소</button>
				</div>
				`
		});
		$("#ansAnsView2"+no).append(str);
	}
	
});
}


$(function(){
	
	/* $("#download").on("click",function(){
		console.log("다운버튼 누릐");
	    var buttons = document.querySelectorAll('download'); // 다운로드 버튼을 선택합니다.
	    var originalUrl = this.getAttribute('href'); // 클릭된 버튼의 href 속성을 가져옵니다.
        var filename = this.getAttribute('download'); // 파일 이름을 가져옵니다.
        console.log("originalUrl",originalUrl);
        
        console.log("filename",filename);
	    buttons.forEach(function(button) {
	        button.addEventListener('click', function(event) {
	            event.preventDefault(); // 기본 동작(링크 이동)을 막습니다.
	            
	            var originalUrl = this.getAttribute('href'); // 클릭된 버튼의 href 속성을 가져옵니다.
	            var filename = this.getAttribute('download'); // 파일 이름을 가져옵니다.

	            // 로컬 호스트 경로를 제거하고 새로운 경로를 만듭니다.
	            var newPath = originalUrl.replace('http://localhost/lbrtybbsctt/', '');

	            // 다운로드 링크로 리다이렉트합니다.
	            window.location.href = newPath;
	        });
	    });
	}); */
	
	//첨부파일 목록 보기 숨기기
	$("#fileListShow").on("click",function(){
		$("#fileListShow2").show();
		$("#fileListShow").hide();
		$("#fileList").hide();
	});
	$("#fileListShow2").on("click",function(){
		$("#fileListShow").show();
		$("#fileListShow2").hide();
		$("#fileList").show();
	});
	
	
	//ansDecl(lbrtyBbscttNo,lbrtyBbscttAnswerNo);
	
	//신고 하기 declBtn 버튼 클릭시 신고 실행
	$("#declBtn").on("click",function(){
		console.log($('input:radio[name=declResn]:checked').val());
		console.log($("#declUserId").val());
		//console.log($("#declDetailCn").val());
		console.log($("#declLbrtyBbscttNo").val());
		console.log($("#declLbrtyBbscttAnswerNo").val());
		console.log()
		
		let declTarget = $("#declTarget").val();
		let declResn = $('input:radio[name=declResn]:checked').val();
		let userId = $("#declUserId").val();
		//let declDetailCn = $("#declDetailCn").val()
		let declBbscttNo = $("#declLbrtyBbscttNo").val()
		let declAnswerNo = $("#declLbrtyBbscttAnswerNo").val()
		
		let data = {
			"declTarget":declTarget,
			"declResn":declResn,
			"userId":userId,
			//"declDetailCn":declDetailCn,
			"declBbscttNo":declBbscttNo,
			"declAnswerNo":declAnswerNo
		}
		console.log("신고할 data : ",data)
		$.ajax({
			type:"post",
			url:"/lbrtybbsctt/declInsert",
			data:JSON.stringify(data),
			dataType:"text",
			contentType:"application/json;charset=utf-8",
			success:function(res){
				console.log("하하하하하 신고하기 : ",res)
			}
			
		});
		
		console.log("신고를 진행하겠습닏.");
		Swal.fire({
            title: '신고가 완료 됐습니다.',
            icon: 'success',
			confirmButtonColor: '#7066e0',
            confirmButtonText: '확인',
          })
		
	});
	
	
	//아이디 일치시만 게시글 수정 삭제 보여지게 하기
	console.log("sessuserId : ",`${userId}`);
	console.log("detailId : ",`${detail.userId}`);
	
	let sessionId = `${userId}`;
	let detailId = `${detail.userId}`;
	if(sessionId==detailId){
		console.log("같다는디옹?")
		$("#bbsUdt").show();
		$("#bbsDel").show();
		
	}else if(sessionId!=null && sessionId!=""){
		$("#btnDecl").show();
		console.log("sessionId awdasdasd : ",sessionId);
		console.log("게시글 작성자 아이디와 세션 아이디가 다르고 세션아이디가 널이 아닐때만 떠야되는 콘솔창");
		console.log("다릅니다!!?")
	}
	
	
	if(sessionId==null || sessionId==""){
		console.log("세션 아이디가 없는디");
		//댓글 등록 버튼을 비활성화 시키고
		$("#ansInt").attr("disabled",true);
		$("#lbrtyBbscttAnswerCn").attr("placeholder","로그인이 필요한 서비스 입니다..")
		// 플레이스 홀더에 로그인이 필요한 서비스라고 말해준다
		
		$(".lbsdropdown").hide();
	}else{
		console.log("세션 아이디가 있는디");
	}
	
	
	//세션 아이디와 댓글 작성자 일치시, 다를시 
	
	//세션 아이디와 대댓글 작성시 일치시, 다를시
	
	
	//파일 업로드시 파일 이름 읽기
	/* const input = document.getElementById('uploadFile')
	const output = document.getElementById('output')

	document.getElementById("uploadFile").addEventListener('input', (event) => {
	  const files = event.target.files
	  output.innerHTML = Array.from(files).map(file => file.name).join("<br>");
	}) */
	// 댓글 달기 
	$("#ansInt").on("click",function(){
		console.log("하요");
		console.log("userId : " , $("#ansUserId").text())
		
		let userId = $("#ansUserId").text();
		let lbrtyBbscttAnswerCn = $("#lbrtyBbscttAnswerCn").val();
		if(lbrtyBbscttAnswerCn == ""){
			Swal.fire({
		          icon: 'error',
		          title: '내용 없음',
		          text: '내용을 입력해주세요..',
		          confirmButtonText: '확인',
		        });
			return;
		};
		let data = {
			"userId":"${userId}",
			"lbrtyBbscttAnswerCn":lbrtyBbscttAnswerCn,
			"lbrtyBbscttNo" : lbrtyBbscttNo
		}
		console.log("data",data)
		$.ajax({
			url:"/lbrtybbsctt/insertAns",
			type:"post",
			data:JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			dataType:"text",
			success:function(res){
				console.log("result : ",res);
				
				$("#lbrtyBbscttAnswerCn").val("");
				listAns();

				/* let str = "";
				$("#ansRes").html("");
				
				//res : LbrtyBbscttAnswerVO
// 				$.each(res,function(idx,LbrtyBbscttAnswerVO){
					str+=`
					<a>작성자 : \${LbrtyBbscttAnswerVO.userNcnm} (\${LbrtyBbscttAnswerVO.userId})</a><br>
					<a>내용 : \${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerCn}</a><br>
					<a>작성일자 : \${LbrtyBbscttAnswerVO.lbrtyBbscttAnswerWrDt} </a>
					<button type="button" class="btn btn-block" style="width:2.5cm;"
						id="ansInt2" name="ansInt2">답글 </button>
					<div class="input-group-append" id="ansans" style="display:none;">
					<br><br>
					<textarea class="form-control" 
					style="border: none" id="lbrtyBbscttAnswerCn" name="lbrtyBbscttAnswerCn"
					rows="1" placeholder="답글을 입력해주세요..."></textarea>
					<button type="button" class="btn btn-block" style="width:2.5cm;"
					id="ansInt3" name="ansInt3">등록</button>
					</div>
					<hr>
					`;  */
				//})
				//$("#ansRes").append(str);
			//alarm(userId , detailId);
			}
			//////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////
		});
	});
	
	//댓글 끝
	
	console.log("개똥이");
	
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());
		
		$("#lbrtyBbscttCn2").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout",function(){
		$("#lbrtyBbscttCn2").val(window.editor.getData());
	});
	
	//게시글 수정
	$("#bbsUdt").on("click",function(){
		$("#updateBtn2").show();
		$("#updateBtn3").hide();
		$("#sjUpt").hide();
		$("#sjUpt2").show();
		$("#upthide").hide();
		console.log("난 수정을 하겠다.");
		$(".downA").hide()
		$(".fileDelBtn").css("display","block");
		$("#fileIns").show();
		$("#fileTitle").html("첨부파일 목록 수정");
		$("#lbrtyBbscttCn").hide();
		$("#lbrtyBbscttCn2").hide();
		console.log("files1 : ",document.querySelector('input[name="files"]').files);
		
		
		
		$("#cncn").hide();
		$("#ansView").hide();
		$("#ckCn").show();
		$("#lbrtyBbscttSj").attr("readonly", false);
		
		$("#lbrtyBbscttCn").val();
		$("#lbrtybbsCns").on("click",function(){
			console.log("까궁");
			window.location.reload();
		});
		$("#lbrtybbsUdt").on("click",function(){
			console.log("files2 : ",document.querySelector('input[name="files"]').files);
			let userId = $("#userId").val();
			let lbrtyBbscttNo = $("#lbrtyBbscttNo").val();
			let lbrtyBbscttSj = $("#lbrtyBbscttSj").val();
			let lbrtyBbscttCn = $("#lbrtyBbscttCn2").val();
			let sprviseAtchmnflNo = $("#sprviseAtchmnflNo").val();
			console.log("sprviseAtchmnflNo : " + $("#sprviseAtchmnflNo").val());
			let files = document.querySelector('input[name="files"]').files;
			let selectedFiles = [];
			for(let i=0; i<files.length; i++) {
		        selectedFiles.push(JSON.stringify(files[i]));
			}
			
			let formData = new FormData()
			formData.append("userId",userId);
			formData.append("lbrtyBbscttNo",lbrtyBbscttNo);
			formData.append("lbrtyBbscttSj",lbrtyBbscttSj);
			formData.append("lbrtyBbscttCn",lbrtyBbscttCn);
			formData.append("sprviseAtchmnflNo",sprviseAtchmnflNo);
			for(let i=0; i<files.length; i++) {
				formData.append("files",files[i]);
			}
			
			console.log("formData : ",formData);
			
			/* let data = {
				"lbrtyBbscttNo":lbrtyBbscttNo,
				"lbrtyBbscttSj":lbrtyBbscttSj,
				"lbrtyBbscttCn":lbrtyBbscttCn,
				"files":selectedFiles
			} */
			$.ajax({
				url:"/lbrtybbsctt/bbsUpdate",
				type:"post",
				data:formData,
				contentType:false,  // 초기값 하지마라 
				processData:false,	// 디폴트로 설정되어 있는것을 하지마라		  	
				dataType:"text",
				success:function(res){
					console.log(res);
					location.reload();
				}
			});
		});
		
		
		//$("#").attr("readonly", false);
		
		//게시글 수정시 가능한것, 제목, 내용, 첨부파일
		let userId = "${userId}";
		let detailId = "${detail.userId}";
		
	});
	
	//게시글 삭제
	$("#bbsDel").on("click",function(){
		console.log("난 삭제를 하겠다.");
		console.log("lbrtyBbscttNo : ", lbrtyBbscttNo);
		//var con = confirm("정말로 삭제하시겠습니까?");
		Swal.fire({
		    title: '정말 삭제 하시겠습니까?',
		    icon: 'warning',
		    showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#6e7881',
		    confirmButtonText: '확인',
		    cancelButtonText: '취소',
		    reverseButtons: false, // 버튼 순서 거꾸로
		}).then((result) => {
		    if (result.isConfirmed) {
		    	console.log("result.isConfirmed : ", result.isConfirmed);

	            console.log("Swal.fire : ", Swal.fire)
	            console.log("sprviseAtchmnflNo", $("#sprviseAtchmnflNo").val());
	            //console.log(con);
	            let sprviseAtchmnflNo = $("#sprviseAtchmnflNo").val();
	            //if(!con) return;


	            //console.log("취소 누르면 실행되면 안돼")

	            let data = {
	                "lbrtyBbscttNo": lbrtyBbscttNo,
	                "sprviseAtchmnflNo": sprviseAtchmnflNo
	            }
	            $.ajax({
	                url: "/lbrtybbsctt/bbsDelete",
	                type: "post",
	                data: JSON.stringify(data),
	                dataType: "text",
	                contentType: "application/json;charset=utf-8",
	                success: function (res) {
	                    console.log(res);
	                    window.location.href = "/lbrtybbsctt/read2"
	                }
	            });
	        }
	    });
	});
	
	
});
</script>


<div class="content-wrapper"
	style="border-top-left-radius: 45px; border-top-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div style="display: flex; flex-wrap: wrap;">
					<%-- <button type="button" class="btn btn-block btn-light btn-sm"
						style="width: 2.0cm; display: none;" id="btnDecl"
						onclick="ansDecl('LBRTY_BBSCTT','${detail.lbrtyBbscttNo}',0)"
						data-toggle="modal" data-target="#modal-sm">신고</button> --%>
					<img id="btnDecl" src="../resources/images/사이렌2.png" style="width: 25px; margin: 30px 0px 5px 1220px; display: none;"
						data-toggle="modal" data-target="#modal-sm"
						onclick="ansDecl('LBRTY_BBSCTT','${detail.lbrtyBbscttNo}',0)" />
					<!-- <button type="button" class="btn btn-light btn-sm"
						style="width: 2.0cm; display: none;" id="bbsUdt">수정</button>
					<button type="button" class="btn btn-block btn-light btn-sm"
						style="width: 2.0cm; display: none;" id="bbsDel">삭제</button> -->
				</div>
				<div class="card-body">
					<div class="container-fluid">
						<h3 class="text-center my-5">${proJoBbscttVOList[0].proJoBbscttSj}</h3>
						<div class="text-right">
						<form name="frm" id="frm" action="/lbrtybbsctt/bbsUpdate" method="post"
							enctype="multipart/form-data">
							<input type="hidden" name="sprviseAtchmnflNo" class="form-control"
								id="sprviseAtchmnflNo" placeholder="통합첨부파일 번호" required readonly
								style="border: none; border-right: 0px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;"
								value="${detail.sprviseAtchmnflNo}" /> 
							<input type="hidden" name="lbrtyBbscttNo" class="form-control" id="lbrtyBbscttNo"
								placeholder="게시글 번호" required readonly
								style="border: none; border-right: 0px; border-top: 0px; boder-left: 0px; boder-bottom: 0px;"
								value="${detail.lbrtyBbscttNo}" /> 
							
							<h3 class="text-center my-5" id="sjUpt">${detail.lbrtyBbscttSj}</h3>
							<div id="sjUpt2" style="display:none;">
							<b>게시글 제목</b>
							<p><input type="text"
								name="lbrtyBbscttSj" class="form-control" id="lbrtyBbscttSj"
								placeholder="게시글 제목" required readonly
								value="${detail.lbrtyBbscttSj}" /></p>
							</div>
							<div id="upthide">
							<b>작성자</b>
							<p id="userId">${detail.userId}</p>
							<b>작성일</b>
							
							<p>
							<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${detail.lbrtyBbscttWrDt}"/> 
							</p>
							</div>
							

								<!-- <div id="fileIns" class="form-group" style="display: none;">
									<label for="uploadFile">첨부 파일 추가</label>
									<div class="custom-file">
										<input type="file" name="files" multiple="multiple"
											onchange="test(this.files)">
										<div id="file-list"></div>
									</div>
								</div> -->
								<button type="submit" class="btn btn-primary" style="display: none;">등록</button>
							<button type="reset" class="btn btn-secondary" style="display: none;">초기화</button>
						</form>
						</div>
					</div>
					<hr>
					<div>
						<label for="lbrtyBbscttCn"></label>
						<div id="lbrtyBbscttCn">${detail.lbrtyBbscttCn}</div>
					<div id="ckCn" style="display: none;">
							<label for="lbrtyBbscttCn2">게시글 내용</label>
							<div id="cklbrtyBbscttCn" style="height: 150px;">${detail.lbrtyBbscttCn}</div>
							<textarea name="lbrtyBbscttCn" id="lbrtyBbscttCn2"
								class="form-control" rows="4" style="display: block;"></textarea>
						</div>
					</div>
					<hr>
					<!-- $("#fileListShow").on("click",function(){
						$("#fileListShow2").show();
						$("#fileListShow").hide();
						$("#fileList").hide();
					}); -->
					<button type="button" id="fileListShow" class="btn"><b id="fileTitle" >첨부파일 목록 ▲</b></button>
					<button type="button" id="fileListShow2" class="btn" style="display:none;"><b id="fileTitle" >첨부파일 목록 ▼</b></button>
							<div id ="fileList" class="fileList">
								
								<c:forEach var="sprList" items="${sprList}" varStatus="stat">
									<div id="fileDel${sprList.atchmnflNo}"
										style="display: flex; flex-wrap: wrap;">
										<a id="fileDel${stat.count}">${sprList.atchmnflNm}</a>
										<button class="btn btn-block btn-light btn-xs fileDelBtn"
											onclick="fileDel(`${sprList.sprviseAtchmnflNo}`,`${sprList.atchmnflNo}`,`${stat.count}`)"
											style="display: none; width: 1.0cm;" " type="button">X</button>
										<a type="button" class="btn btn-light btn-xs downA"
											style="width: 2.0cm;"
											href="${sprList.atchmnflCours}"
											download='${sprList.atchmnflNm}'>다운</a><br>
									</div>
								</c:forEach>
							</div>
							<hr>
								<div id="fileIns" class="form-group" style="display: none;">
									<label for="uploadFile">첨부 파일 추가</label>
									<div class="custom-file">
										<input type="file" name="files" multiple="multiple"
											onchange="test(this.files)">
										<div id="file-list"></div>
									</div>
								</div>
								<div id="updateBtn2" style="display: none;">
								<button type="button"
									class="btn btn-outline-secondary" id="lbrtybbsUdt">수정</button>
								<button type="button"
									class="btn btn-outline-secondary" id="lbrtybbsCns">취소</button>
								</div>
					<div class="container-fluid w-100" id="updateBtn3"
						style="display: flex; flex-wrap: wrap; float: right;">
						<button type="button" class="btn btn-outline-primary"
							id="modifyBtn" style="display: none; margin-right: 5px;">수정</button>
						<button type="button" class="btn btn-outline-secondary"
							id="backBtn" onclick="location.href='read2'"
							style="margin-right: 5px;">목록</button>
						<button type="button" class="btn btn-outline-secondary"
							style="display: none;
							margin-right: 5px;" id="bbsUdt">수정</button>
						<button type="button" class="btn btn-outline-secondary"
							style="display: none;" id="bbsDel">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 댓글을 이분에 달아야됨 -->
<div class="content-wrapper"
	style="padding-top: 0; border-bottom-left-radius: 45px; border-bottom-right-radius: 45px;">
	<div class="row">
		<div class="col-lg-12">
			<div class="card px-2">
				<div class="card-body">
					<p class="card-title">댓글 목록</p>
					<!--  -->
					<!--====================== 댓글 시작============================== -->
	<div id="ansView">
		<!-- 드롭다운 -->
		<!-- 드롭다운 끝 -->
		<br> <br>
		<div class="col-sm-6">
			<div>
				<div>
					<a id="ansUserId">${userId}</a>
					<textarea class="form-control" style="border: none"
						id="lbrtyBbscttAnswerCn" name="lbrtyBbscttAnswerCn" rows="1"
						cols="100" placeholder="댓글을 입력해주세요..."></textarea>
					<button type="button" class="btn btn-block" style="width: 2.5cm;"
						id="ansInt" name="ansInt">등록</button>
				</div>
				<hr>
				<!-- 답글공간 -->
				<div id="ansRes">
				</div>
				<!-- 답글공간 -->
			</div>
		</div>
	</div>
	<!--====================== 댓글 끝============================== -->
					<!--  -->
				</div>
			</div>
		</div>
	</div>
</div>



<!-- 모달창 -->

<!-- ///// 모달 시작(작은 크기) /// -->
<div class="modal fade" id="modal-sm">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title general" id="modalTitle">🚨 신고하기</h4>
				<input type="hidden" id="declUserId"
					class="form-control is-warning edit" value="${userId}"
					style="display: block;" /> <input type="hidden" id="declTarget"
					class="form-control is-warning edit" value=""
					style="display: block;" /> <input type="hidden"
					id="declLbrtyBbscttNo" class="form-control is-warning edit"
					value="" style="display: block;" /> <input type="hidden"
					id="declLbrtyBbscttAnswerNo" class="form-control is-warning edit"
					value="" style="display: block;" />
				<button type="button" class="close" id="clsBtn" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="false">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<p class="general" id="modalBody"></p>


				<div>
					<c:forEach var="comCdList" items="${comCdList}" varStatus="stat">
						<input type="radio" id="${comCdList.commonCdDetail}"
							name="declResn" value="${comCdList.commonCdDetailNm}" />
						<label for="${comCdList.commonCdDetail}">${comCdList.commonCdDetailNm}</label>
						<br>
					</c:forEach>
				</div>

				<!-- <textarea rows="10" cols="30" id="declDetailCn" style="display:block;">신고하디</textarea> -->
			</div>
			<div class="modal-footer">

				<button id="declBtn" type="button" class="btn btn-default"
					data-dismiss="modal">신고</button>
				<button id="declCns" type="button" class="btn btn-default"
					data-dismiss="modal" style="display: block;">취소</button>
				<!-- data-dismiss="modal" -->

				<br> <br>

				<!-- 일반모드 -->
				<%--         <button type="button" id="modify" ${disabled} class="btn btn-primary general">수정</button> --%>
				<button type="button" id="delete" ${disabled} style="display: none;"
					class="btn btn-primary general">삭제</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- ///// 모달 끝(작은 크기) /// -->
<!-- 모달창 ㄲ<ㅌ -->

<script type="text/javascript">
ClassicEditor
 .create(document.querySelector('#cklbrtyBbscttCn'),
		{ckfinder:{uploadUrl:'/upload/uploads?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});

</script>