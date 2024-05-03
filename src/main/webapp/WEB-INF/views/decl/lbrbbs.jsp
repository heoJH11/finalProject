<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
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
        	<b>신고내역</b>
        	<br><br>
        	<div>
        	`;
        	for (const SntncDeclVO of res) {
        		console.log("declProcessAt : ",SntncDeclVO.declProcessAt);
        		if(SntncDeclVO.declProcessAt==1){
        			$("#declSetBtn").hide();
        		}else{
        			$("#declSetBtn").show();
        		}
        		str+=`
        			
        			<a>\${SntncDeclVO.declResn}</a>
        			<a>\${SntncDeclVO.count}회</a><br>
        		`
        		sum+= SntncDeclVO.count;
            	console.log("str:",str);
        	}
        	console.log("sum : ",sum)
        	str +=`
        		<a style="float: right;">총 \${sum} 회</a>
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
        		<b>상세보기</b>
        		<div class="card-body">
    			<div class="form-group">
    				<input id="no" type="hidden" value="\${res.lbrtyBbscttNo}" />
    				<label for="userId">작성자 아이디</label><br>
    				<a>\${res.userId}</a>
    			</div>
    			<div class="form-group">
    				<label for="lbrtyBbscttSj">게시글 제목</label><br>
    				<a>\${res.lbrtyBbscttSj}</a>
    			</div>
    			
    			<br>
    			<div class="form-group">
    				<hr>
    				<label for="lbrtyBbscttCn"></label>
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
	                        <td>\${re.userId}</td>
	                        `
	                        console.log("declProcessAt : ",SntncDeclVO.declProcessAt);
	                        if(SntncDeclVO.declProcessAt==0){
	                        	str+=`<td><button id="typeBtn\${re.lbrtyBbscttNo}">&nbsp;미완료&nbsp; </button></td>`;
	                        }else{
	                        	str+=`<td><button id="typeBtn\${re.lbrtyBbscttNo}">&nbsp;완료&nbsp; </button></td>`;
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
				alert("제재 처리가 완료되었습니다.");
				$('.show').fadeOut('noshow');
			}
		});
		
	});
	
	
});
</script>
<style>
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

					<p class="card-title">자유게시글 신고 관리</p>

					<div class="form-group">
						<div class="input-group">
							<input type="text" name="keyword" id="keyword"
								value="${param.keyword}" class="form-control"
								placeholder="검색어를 입력하세요" aria-label="">
							<div class="input-group-append">
								<button class="btn btn-sm btn-primary" id="btnSearch"
									type="button">Search</button>
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
												class="display expandable-table dataTable no-footer table-hover text-nowrap"
												style="width: 100%;" role="grid">
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
															style="width: 59px;">작성자</th>
														<th class="" tabindex="0" rowspan="1" colspan="1"
															style="width: 59px;">상태</th>

													</tr>
												</thead>
												<tbody id="lbsBody">
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
					<h4 class="modal-title"><b>신고글 상세보기</b></h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body" id="modal_body">
					<div class="left" id="modal_left"></div>
					<div class="right" id="modal_right"></div>
				</div>
				<div></div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="declSetBtn">제재
						처리</button>
				</div>
			</div>

		</div>

	</div>
	<!-- 모달창 ㄲ<ㅌ -->
</body>
</html>
