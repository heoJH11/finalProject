<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<link type="text/css" rel="stylesheet"
	href="/resources/ckeditor5/sample/css/sample.css" media="screen" />
<!DOCTYPE html>

<html>

<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
/* function ajaxList(data){
	$.ajax({
		type:"post",		
		url:"/decl/ajaxLbList",
		data:JSON.stringify(data),
		contentType:"application/json;chatset=utf-8",
		dataType:"json",
		success:function(res){
			console.log(res);
			
			let str = "";
			$.each(res.content,function(idx,LbrtyBbscttVO2){
				//각 각 vo에 뭐가 들어있는지 체크
				console.log("LbrtyBbscttVO2["+idx+"] : ", LbrtyBbscttVO2)
				str+=`
					<tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=\${LbrtyBbscttVO2.lbrtyBbscttNo}'">
						<td>\${LbrtyBbscttVO2.rnum}</td>
						<td>\${LbrtyBbscttVO2.lbrtyBbscttSj}</td>
						<td>\${LbrtyBbscttVO2.userNcnm}</td>
						<td>\${LbrtyBbscttVO2.userId}</td>
					</tr> 
					`
				console.log("str : " + str)
			});
			$("#lbsBody").append(str);
			$("#keyword").val("");
			
			//페이징 처리
			$("#divPaging").html(res.pagingArea);
		}
			
	});
} */
function modalView(no,ta){
	
	//console.log("id :" , id);
	console.log("no :" , no);
	//console.log("sj :" , sj);
	//console.log("cn :" , cn);
	$("#modal_left").text("");
	$("#modal_right").text("");
	
	let data = {
        "declBbscttNo": no,
		"declTarget": ta,
	}
	$.ajax({
		type: "post",
        url: "/decl/declResnList",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success:function(res){
        	//console.log("declProcessAtdeclProcessAt : " + res.declProcessAt);
        	console.log(res);
        	let str = "";
        	var sum = 0;
        	str+=`
        	<h3><b>📃 신고내역</b></h3>
        	<br><br>
        	<div style="line-height:1.5">
        	`
        	for (const SntncDeclVO of res) {
        		console.log("declProcessAt : ",SntncDeclVO.declProcessAt);
        		if(SntncDeclVO.declProcessAt==1){
        			$("#declSetBtn").hide();
        		}else{
        			$("#declSetBtn").show();
        		}
        		str+=`
        			
        			<p>➕ \${SntncDeclVO.declResn} &nbsp; \${SntncDeclVO.count}회</p><br>
        		`
        		sum+= SntncDeclVO.count;
            	console.log("str:",str);
        	}
        	console.log("sum : ",sum)
        	str +=`
        		<h4 style="float: right; margin-top:30px;">총 \${sum} 회</h4>
        		</div>
        	`
        	$("#modal_right").append(str);
        }
	})
	$.ajax({
		type: "post",
        url: "/decl/selectList",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success:function(res){
        	console.log(res);
        	let str = "";
        	
        	str+=`
        		<h3><b>🗨️ 상세보기</b></h3>
        		<div class="card-body">
    			<div class="form-group" style="margin-top:30px;">
    				<input id="no" type="hidden" value="\${res.lbrtyBbscttNo}" />
    				<label for="userId">✔️ 작성자 아이디</label><br>
    				<p>\${res.userId}</p>
    			</div>
    			<div class="form-group" style="margin-top:50px;">
    				<label for="lbrtyBbscttSj">✔️  게시글 제목</label><br>
    				<p>\${res.lbrtyBbscttSj}</p>
    			</div>
    			
    			<br>
    			<div class="form-group" style="margin-top:20px; width:1000px;">
    				<label for="lbrtyBbscttCn">✔️  게시글 내용</label>
    				<br><br>
    				<div id="lbrtyBbscttCn">\${res.lbrtyBbscttCn}</div>
    			</div>
    		</div>
        	`
        	$("#modal_left").append(str);
        	//$("#modal_left").load("http://localhost/lbrtybbsctt/detail?lbrtyBbscttNo=26")
        }
	});
	
}

function ajaxList(){
	let str = "";
	$.ajax({
	    type: "post",
	    url: "/decl/ajaxList",
	    dataType: "json",
	    success: async function(res) {
	        console.log(res);
	        for (const SntncDeclVO of res) {
	            console.log("count : ", SntncDeclVO.count);
	            let data = {
	                "declTarget": SntncDeclVO.declTarget,
	                "declBbscttNo": SntncDeclVO.declBbscttNo
	            };

	            console.log("data : ", data);

	            try {
	                let re = await $.ajax({
	                    type: "post",
	                    url: "/decl/selectList",
	                    data: JSON.stringify(data),
	                    contentType: "application/json; charset=utf-8",
	                    dataType: "json"
	                });

	                console.log(re);
	                console.log("re.No", re.lbrtyBbscttNo);
	                let re2 = JSON.stringify(re);
	                console.log("re2 : " , re2);
	                let cn = re.lbrtyBbscttCn;
	                let cn2 = cn.replaceAll('"', "'");
	                console.log("cn : ", cn)
	                console.log("cn2 : ", cn2)
	                
	                // 여기서 str에 결과 추가
	                str += `
	                    <tr onclick="modalView('\${re.lbrtyBbscttNo}','\${SntncDeclVO.declTarget}');" 
							data-toggle="modal" data-target="#modal-xl">
	                        <td>\${SntncDeclVO.count}</td>
	                        <td>\${re.lbrtyBbscttNo}</td>
	                        <td>\${re.lbrtyBbscttSj}</td>
	                        <td>\${re.userNcnm}</td>
	                        `
	                        console.log("declProcessAt : ",SntncDeclVO.declProcessAt);
	                        if(SntncDeclVO.declProcessAt==0){
	                        	str+=`<td><button class="btn btn-light" id="typeBtn\${re.lbrtyBbscttNo}">&nbsp;미완료&nbsp; </button></td>`;
	                        }else{
	                        	str+=`<td><button class="btn btn-primary" btn-sm id="typeBtn\${re.lbrtyBbscttNo}">&nbsp;완료&nbsp; </button></td>`;
	                        }
	                str+=`
	                    </tr>
	                `;
	            } catch (error) {
	                console.error("Error occurred: ", error);
	            }
	        }
	        $("#lbsBody").append(str);
	    }
	});
}
$(function(){
	var memId = "${memSession.userId}";
	var proId = "${proSession.userId}";
	console.log("memId : ", memId);
	console.log("proId : ", proId);
	if(memId != "" || proId != "" ){
		$("#wrtBtn").css("display", "block");
	}
	
	ajaxList();
	
	//제재 처리 버튼 클릭시
	$("#declSetBtn").on("click",function(){
		console.log("버튼을 눌렀습니다..");
		console.log($("#no").val());
		let lbrtyBbscttNo = $("#no").val();
		let data={
			"lbrtyBbscttNo":lbrtyBbscttNo
		}
		
		$.ajax({
			type:"get",
			url:"/decl/declSet",
			data:data,
			//contentType: "application/json; charset=utf-8",
			dataType:"text",
			success:function(res){
				$("#lbsBody").html("");
				ajaxList();
				console.log("res : " , res);
				Swal.fire({
		            title: '제재 처리가 완료되었습니다.',
		            icon: 'success',
					confirmButtonColor: '#7066e0',
		            confirmButtonText: '확인',
		          })
		          $(".btn-default").click();
			}
		});
		
	});
	
	
});
</script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

input,th,td,button,h3,p,h4{
	font-family: 'GmarketSansMedium';
}

label{
	font-family: 'GmarketSansMedium';
	font-size:18px !important;
}
div.modal-body {
	width: 100%;
/* 	border: 1px solid #003458; */
}

div.left {
	width: 60%;
	float: left;
	box-sizing: border-box;
/* 	background: #8977ad; */
}

div.right {
	width: 40%;
	float: right;
	box-sizing: border-box;
/* 	background: #ece6cc; */
}
</style>
<title></title>
</head>

<body>
	<div class="row">
		<div class="col-md-12 grid-margin stretch-card">
			<div class="card">
				<div class="card-body">

					<!-- 제목 -->
					<div >
						<img alt="신고" src="../resources/images/신고2.png" style="width:100px; height:auto; margin:0 0 20px 730px;">
						<h2 id="declTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">자유게시판 신고관리</h2>
						<hr style="border-top: 50px solid #f5f7ff; margin:-50px 500px 0 500px;">
						<br><br>
					</div>

					<div class="form-group">
						<div class="input-group">
							<input type="text" name="keyword" id="keyword"
								value="${param.keyword}" class="form-control"
								placeholder="검색어를 입력하세요" aria-label="" style="margin-left: 1100px;">
							<div class="input-group-append">
								<button class="btn btn-sm btn-primary" id="btnSearch"
									type="button">검색</button>
							</div>
						</div>
					</div>

					<div class="row">

						<div class="col-12">
							<div class="table-responsive">
								<div id="example_wrapper"
									class="dataTables_wrapper dt-bootstrap4 no-footer">
									<div class="row">
										<div class="col-sm-12 col-md-6"></div>
										<div class="col-sm-12 col-md-6"></div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<table id=""
												class="table" 
												style="text-align: center; width: 100%;" role="grid">
												<thead>
													<tr role="row">
														<th class="" tabindex="0" rowspan="1" colspan="1"
															style="width: 59px;">신고 횟수</th>
														<th class="" rowspan="1" colspan="1" aria-label="Quote#"
															style="width: 70px;">글번호</th>

														<th class="" tabindex="0" rowspan="1" colspan="1"
															aria-sort="ascending" style="width: 51px;">게시글 제목</th>

														<th class="" tabindex="0" rowspan="1" colspan="1"
															style="width: 58px;">닉네임</th>

														<!-- <th class="" tabindex="0" 
                                          rowspan="1" colspan="1"
                                          
                                          style="width: 43px;">조회수</th> -->

														<th class="" tabindex="0" rowspan="1" colspan="1"
															style="width: 59px;">상태</th>

													</tr>
												</thead>
												<tbody class="tmtBody" id="lbsBody">
													<%-- <c:forEach var="lbrbbsList" items="${lbrbbsList}" 
                                    varStatus="stat">
                                             <tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=${lbrtyBbscttList.lbrtyBbscttNo}'" style="cursor:hand">
                                                 <td>${lbrbbsList.count}</td>
                                             </tr>
                                    </c:forEach> --%>
												</tbody>
											</table>
										</div>
									</div>

									<div id="divPaging" style="display: flex; flex-wrap: wrap;">

									</div>

									<div class="row">
										<div class="col-sm-12 col-md-5"></div>
										<div class="col-sm-12 col-md-7"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
	<!-- ///// 모달 시작 /// -->
	<div class="modal fade show" id="modal-xl"
		style="display: none; padding-right: 17px;" aria-modal="true"
		role="dialog">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title"><b>🚨 자유게시판 신고 상세보기</b></h3>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body" id="modal_body">
					<div class="left" id="modal_left"></div>
					<div class="right" id="modal_right" style="background-color:#f5f7ff; padding:20px; border-radius:20px;"></div>
				</div>
				<div></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="declSetBtn">제재처리</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>

		</div>

	</div>
	<!-- 모달창 ㄲ<ㅌ -->
</body>
</html>
<c:if test="${memSession == null && proSession == null && admSession == null}">
    <script>
        function login() {
        	$("body").html("");
            Swal.fire({
                title: '로그인 후 이용해주세요',
                icon: 'warning',
                confirmButtonColor: '#4B49AC',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
            }).then((result) => {
                if (result.isConfirmed) {
                    history.back();
                }
            });
        }
        $(document).ready(function() {
            login(); // 함수 호출
        });
    </script>
</c:if>
