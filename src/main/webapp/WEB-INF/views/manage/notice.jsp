<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!DOCTYPE html>
<html>
<head>
<title></title>

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

canvas, h3{
	font-family: 'GmarketSansMedium';
}

 .card-body {
    margin-bottom: 20px; 
}
.card {
    margin-bottom: 20px; 
} 
.background-icon {
    margin-top: -20px; 
}
.accordion-button {
    cursor: pointer;
}
.accordion-content {
    display: none;
}


</style>

</head>
<script  type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> 
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" /> -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript">
//최대 길이 설정
const maxLength = 25;

function convertMngrId(mngrId) {
    return mngrId === 'testAdmin' ? '관리자' : mngrId;
}

function formatDate(dateString) {
   var options = { year: 'numeric', month: '2-digit', day: '2-digit' };
   return new Date(dateString).toLocaleDateString(undefined, options).replace(/\.$/, '');
	} 
 
$(function(){
	if($("#adminId").val() == ""){
		Swal.fire({
			    title: '관리자만 들어갈  수 있습니다.',
			    icon: 'error',
			    showCancelButton: false,
			    confirmButtonColor: '#7066e0',
			    confirmButtonText: '확인',
		    }).then((result) => {
		    	location.href="/main"
		    })
	}
// 	console.log("${admSession}" + '${admSession}');
// 	if(${admSession} == null || )
	//1. notice의 btnSearch
   $("#btnSearch").on("click",function(){
      let keyword = $("#keyword").val();
      let searchKey = $("#search_key").val();
      
//       console.log("keyword:"+keyword);
      
      // 검색어가 비어있는지 체크
      if (keyword.trim() === '') {
          Swal.fire({
              title: '검색어가 없습니다.',
              icon: 'warning',
              confirmButtonColor: '#7066e0',
              confirmButtonText: '확인'
          });
          return; // 검색어가 없으면 더 이상 실행하지 않음
      }
      
      
      let currentPage = "1";
      
      let data = {
         "keyword":keyword,
         "searchKey":searchKey,
         "currentPage":currentPage
      };
//       console.log("data:"+data)
      
      $.ajax({
         url:"/admin/listAjax",
         contentType:"application/json;charset=utf-8",
         data:JSON.stringify(data),
         type:"post",
         dataType:"json",
         success:function(result){
//             console.log("result:",result);
            
            let str = "";
            
            $("#noticeTbody").html("");
         
            $.each(result.content,function(idx, noticeVO){
            	// 공지사항 제목 자르기
                let trimmedNoticeSj = noticeVO.noticeSj;
                if (trimmedNoticeSj.length > maxLength) {
                    trimmedNoticeSj = trimmedNoticeSj.substring(0, maxLength) + "..."; // 최대 길이 초과 시 생략 부호 추가
                }
            	
               str += "<tr onclick=\"location.href='/manage/detail?noticeNo=" + noticeVO.noticeNo + "'\" style=\"cursor: pointer;\">";              
               str += "<td>"+noticeVO.rnum+"</td>";
               str += "<td>"+trimmedNoticeSj+"</td>";
               str += "<td>"+formatDate(noticeVO.noticeWritngDt)+"</td>";
               str += "<td>"+noticeVO.noticeRdcnt+"</td>";              
               str += "<td>"+convertMngrId(noticeVO.mngrId)+"</td>";
               str += "</tr>";
            
            });   
            
            $("#noticeTbody").append(str);
            $("#divPagingArea").html(result.pagingArea);
                     
         }
         
      });
      
   });//end btnSearch
   
   //2. notice의 btnSearch2 
   $("#btnSearch2").on("click",function(){
		let keyword = $("#keyword2").val();
		let searchKey = $("#search_key2").val();
		
// 		console.log("keyword:"+keyword+", keyword : " + keyword + ", searchKey : " + searchKey);
		
		// 검색어가 비어있는지 체크
      if (keyword.trim() === '') {
          Swal.fire({
              title: '검색어가 없습니다.',
              icon: 'warning',
              confirmButtonColor: '#7066e0',
              confirmButtonText: '확인'
          });
          return; // 검색어가 없으면 더 이상 실행하지 않음
      }
		
		
		let currentPage = "1";
		
		let data = {
			"keyword":keyword,
			"searchKey":searchKey,
			"currentPage":currentPage
		};
// 		console.log("data:"+data)
		
		$.ajax({
			url:"/usersSearch/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result:",result);
				
				let str = "";
				
				$("#usersTbody").html("");
			
				$.each(result.content,function(idx, usersVO){
					str += "<tr onclick=\"location.href='/manage/userDetail?userId=" + usersVO.userId + "'\" style=\"cursor: pointer;\">";
					/* str += "<tr>"; */
					
					
					str += "<td>"+usersVO.rnum+"</td>";
					str += "<td>"+usersVO.userId+"</td>";
					str += "<td>"+usersVO.userNcnm+"</td>";
					str += "<td>"+usersVO.userNm+"</td>";
					//str += "<td>"+usersVO.userPassword+"</td>";
					str += "<td>";
					if (usersVO.emplyrTy === "ET01") {
					    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-info'><i class='mdi mdi-face'></i> 회원</div>";
					} else if (usersVO.emplyrTy === "ET02") {
					    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-primary'><i class='mdi mdi-emoticon-cool'></i> 프로</div>";
					} else {
					    str += convertUserType(usersVO.emplyrTy); // 기타 사용자 유형 처리
					}
					str += "<td>"+convertUserType2(usersVO.secsnAt)+"</td>";
					
					str += "</tr>";
				
				});	
				
				$("#usersTbody").append(str);
				$("#divPagingArea2").html(result.pagingArea);
			}
			
		});
		
	});//end btnSearch2
	
	//최초 실행
   leftList(1,"","");
   rightList(1,"","");
	
});//end 달러function
   
function leftList(currentPage, keyword, searchKey){
	//3. 왼쪽 목록 시작 ///////////////////////
	   //let currentPage  = "${param.currentPage}";
	   console.log("leftList->currentPage : " + currentPage + ", searchKey : " + searchKey);
	   if(currentPage==""){
	      currentPage = 1;
	      
	   }
	   
	   let data = {
	      "keyword":keyword,
	      "currentPage":currentPage,
	      "searchKey":searchKey
	   };
	   console.log("data:",data);
	   
	   $.ajax({
	      url : "/admin/listAjax?currentPage="+currentPage,
	      type : "post",
	      data : JSON.stringify(data),
	      contentType: "application/json;charset=utf-8",
	      dataType:"json",
	      success : function(result){
	         console.log("leftList->result:",result);
	      
	         let str = "";
	         
	         $("#noticeTbody").html("");
	         
	         $.each(result.content,function(idx, noticeVO){
	        	// 공지사항 제목 자르기
	             let trimmedNoticeSj = noticeVO.noticeSj;
	             if (trimmedNoticeSj.length > maxLength) {
	                 trimmedNoticeSj = trimmedNoticeSj.substring(0, maxLength) + "..."; // 최대 길이 초과 시 생략 부호 추가
	             }
	        	 
	            str += "<tr onclick=\"location.href='/manage/detail?noticeNo=" + noticeVO.noticeNo + "'\" style=\"cursor: pointer;\">";   
	            str += "<td>"+noticeVO.rnum+"</td>";
	            str += "<td>"+trimmedNoticeSj+"</td>";
	            str += "<td>"+formatDate(noticeVO.noticeWritngDt)+"</td>";
	            str += "<td>"+noticeVO.noticeRdcnt+"</td>";
	            str += "<td>"+convertMngrId(noticeVO.mngrId)+"</td>";
	            str += "</tr>";
	            
	            
	         });
	         $("#noticeTbody").append(str);
// 	         console.log(result.pagingArea);
	         $("#divPagingArea").html(result.pagingArea);
	         
	         
	         sessionStorage.setItem("total",result.total);
	      }
	   });
	   //3. 왼쪽 목록 끝 ///////////////////////
}

function rightList(currentPage, keyword, searchKey){
	//4. 오른쪽 목록 시작 ///////////////////////
	//let currentPage  = "${param.currentPage}";
	console.log("currentPage",currentPage);
	if(currentPage==""){
		currentPage = 1;
		
	}
	
	let data = {
		"keyword":keyword,
		"currentPage":currentPage,
		"searchKey":searchKey
	};
// 	console.log("rightList->data:",data);
	
	$.ajax({
		url : "/usersSearch/listAjax?currentPage="+currentPage,
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(result){
// 			console.log("result:",result);
		
			let str = "";
			
			$("#usersTbody").html("");
			
			$.each(result.content,function(idx, usersVO){

				str += "<tr onclick=\"location.href='/manage/userDetail?userId=" + usersVO.userId + "'\" style=\"cursor: pointer;\">";
				/* str += "<tr>"; */
				
				
				str += "<td>"+usersVO.rnum+"</td>";
				str += "<td>"+usersVO.userId+"</td>";
				str += "<td>"+usersVO.userNcnm+"</td>";
				str += "<td>"+usersVO.userNm+"</td>";
				//str += "<td>"+usersVO.userPassword+"</td>";
				str += "<td>";
				if (usersVO.emplyrTy === "ET01") {
				    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-info'><i class='mdi mdi-face'></i> 회원</div>";
				} else if (usersVO.emplyrTy === "ET02") {
				    str += "<div class='col-sm-6 col-md-4 col-lg-3 text-primary'><i class='mdi mdi-emoticon-cool'></i> 프로</div>";
				} else {
				    str += convertUserType(usersVO.emplyrTy); // 기타 사용자 유형 처리
				}
				str += "<td>"+convertUserType2(usersVO.secsnAt)+"</td>";
				
				str += "</tr>";
				
				
			});
			$("#usersTbody").append(str);
// 			console.log(result.pagingArea);
			$("#divPagingArea2").html(result.pagingArea);
			
			
			sessionStorage.setItem("total",result.total);
		}
		
	});//end ajax
	//4. 오른쪽 목록 끝 ///////////////////////
}
  

function convertUserType(userType) {
    switch(userType) {
        case "ET01":
            return "회원";
        case "ET02":
        	return "프로";
            
        default:
            return userType;
    }
}

function convertUserType2(userType) {
    switch(userType) {
        case 1:
            return "이용중";
        case 0:
            return "탈퇴";
        default:
            return "기타";
    }
}




</script>

<body>
<input type="hidden" id="adminId" value="${admSession.userId}">
<!-- <div class="col-md-12 stretch-card grid-margin grid-margin-md-0"> -->
<!--                   <div class="card data-icon-card-primary"> -->
<!--                     <div class="card-body" > -->
<!--                        <p class="card-title text-white"> </p>                        -->
<!--                       <div class="row"> -->
<!--                         <div class="col-8 text-white"> -->
<!--                           <h3 class="tex-center">관리자 페이지</h3>  -->
<!--                           <p class="text-white font-weight-500 mb-0">This is the management page.</p> -->
<!--                         </div> -->
<!--                         <div class="col-4 background-icon"> -->
<!--                         </div> -->
  
<!--                       </div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div>   -->
 	 <div class="container col-lg-12">
	<input type="hidden" id="sessionId" value="${memSession.userId}" />
	<div>
		<div class="">
		<!-- 제목 -->
		<div >
			<img alt="공지사항" src="../resources/images/확성기.png" style="width:100px; height:auto; margin:0 0 20px 730px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">누네띠네 관리</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
			<br><br>
		</div>
		</div>
	</div>
</div>	

		<h3 style="text-align:center;">📊 전문분야별 프로 통계</h3>
		<br>
<div class="row" style="margin:0 0 50px 300px; ">
	<div style="width:500px; height:400px; background:white; border-radius:20px; margin-right:20px; padding:20px;">
		<br>
		<div style="width:460px; height:300px;">
		    <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
		    <canvas id="myChart" style="width: 48%;"></canvas>
		</div>
	</div>
	<div style="width:500px; height:400px; background:white; border-radius:20px; padding:20px;">
		<br>
		<div style="width:460px; height:300px; margin-left: 80px;">
		    <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
		    <canvas id="myChart2" style="width: 48%;"></canvas>
		</div>
	</div>
</div>

               
                

<div class="row">
    <!-- 공지사항 카드 -->
    <div class="col-md-6 grid-margin stretch-card">
        <div class="card">
            <div class="card-body" style="font-family: 'GmarketSansMedium';">
                <div class="row">
                    <div class="col-md-6" style="margin-top: 10px;">
                        <h3>📋 공지사항</h3>
                    </div>
                    <c:if test="${not empty sessionScope.admSession}">
	                    <a href="/manage/create" class="btn btn-inverse-primary" style="margin-left:280px;">글쓰기</a>
	                </c:if>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped text-center table-hover col-md-12">
                       
                    <thead>
                        <tr class="text-black">
                            <th style="width: 10%;">글번호</th>
							<th style="width: 50%;">공지사항제목</th>
							<th style="width: 10%;">작성일자</th>
							<th style="width: 10%;">조회수</th>
							<th style="width: 10%;">작성자</th>
                        </tr>
                    </thead>
                    <tbody id="noticeTbody">
                        <!-- 공지사항 내용이 표시되는 부분 -->
                    </tbody>
               
                    </table>
                </div>
                <div class="row">
	                <div class="" style="margin-top: 20px; width:200px;">
	                    <div id="divPagingArea"></div>
	                </div>
	                <div class="col-md-6 form-group text-center" style="margin:20px 0 0 180px;">
	                    <div class="input-group">
	                    
	                    <select class="form-control col-md-3" id="search_key">
						<option value="title">제목</option>
						<option value="detail">내용</option>
					</select>
	                    
	                        <input type="text" name="keyword" id="keyword" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label="">
	                        <div class="input-group-append">
	                            <button class="btn btn-sm btn-primary" id="btnSearch" type="button">
	                                	검색 <i class="fas fa-search"></i>
	                            </button>
	                        </div>
	                    </div>
	                </div>
                </div>
            </div>
        </div>
    </div>

     <!-- 사용자 관리 카드 -->
    <div class="col-md-6 grid-margin stretch-card">
        <div class="card">
            <div class="card-body" style="font-family: 'GmarketSansMedium';">
                <div class="row">
                    <div class="col-md-6" style="margin-top: 10px;">
                        <h3>💁‍♀️ 사용자 관리</h3>
                    </div>
<!--                     <div class="col-md-6 form-group text-center"> -->
<!-- 					    <button class="btn btn-info btn-sm filter-btn" data-type="ET01">회원</button> -->
<!-- 					    <button class="btn btn-primary btn-sm filter-btn" data-type="ET02">프로</button> -->
<!-- 					    <button class="btn btn-secondary btn-sm filter-btn" data-type="">모두 보기</button> -->
<!-- 					</div> -->
                    
                   
                </div>
                <div class="table-responsive">
                    <table class="table table-striped text-center table-hover">
                    						<thead>
							<tr class="text-black">
								<th>번호</th>
								<th>아이디</th>
								<th>닉네임</th>
								<th>이름</th>
								<!-- <th>비밀번호</th> -->
								<th>사용자유형</th>
								<th>탈퇴여부</th>
								
							</tr>
						</thead>
						
						<tbody id="usersTbody">
							
						</tbody>
                        <!-- 사용자 관리 테이블 내용 -->
                    </table>
                </div>
                <div class="row">
	                <div class="" style="margin-top: 20px; width:300px;">
	                    <div id="divPagingArea2" style="width:500px;"></div>
	                </div>
	                 <div class="col-md-6 form-group text-center" style="margin:20px 0 0 80px;">
	                     <div class="input-group">
	                         
	                         <select class="form-control col-md-3" id="search_key2">
							<option value="id">아이디</option>
							<option value="nickname">닉네임</option>
							<option value="name">이름</option>
							<option value="type">사용자 유형</option>
						</select>
	                         
	                         <input type="text" name="keyword" id="keyword2" value="${param.keyword}" class="form-control" placeholder="검색어를 입력하세요" aria-label="">
	                         <div class="input-group-append">
	                             <button class="btn btn-sm btn-primary" id="btnSearch2" type="button">
	                                 	검색 <i class="fas fa-search"></i>
	                             </button>
	                         </div>
	                     </div>
	                 </div>
                </div>
            </div>
        </div>
    </div>
</div>




</body>
</html>
<script>
	const ctx = document.querySelector('#myChart');
	const ctx2 = document.querySelector('#myChart2');
	
	
	//  생성 객체를 변수로 받으면, 요기에 생성시 사용된 옵션값들이 거의 다 담겨있당.
    //  chart.js는 이거 덕분에 사용이 아주 쉽당. 누니 쫓아만 가면 된당.
	/* const mChart = new Chart(ctx,{
		
	}); */
	
	// mChart에 담긴 값 확인, 누르고 꼬옥 확인하자
	/* console.log("labels :",mChart.data.labels);
	console.log("labels :",mChart.data.datasets[0]);
	console.log("labels :",mChart.data.datasets[1].label);
	console.log("labels :",mChart.data.datasets[1].data); */
	let pet = ${dongVO.pet};
	let sport = ${dongVO.sport};
	let music = ${dongVO.music};
	let home = ${dongVO.home};
	let hobby = ${dongVO.hobby};
	let meet = ${dongVO.meet};
	let gita = ${dongVO.gita};
	let total = ${dongVO.total};
	
	let ptPet = (pet / total * 100).toFixed(2);
	let ptSport = (sport / total * 100).toFixed(2);
	let ptMusic = (music / total * 100).toFixed(2);
	let ptHome  = (home / total * 100).toFixed(2);
	let ptHobby = (hobby / total * 100).toFixed(2);
	let ptMeet  = (meet / total * 100).toFixed(2);
	let ptGita  = (gita / total * 100).toFixed(2);
	
	
	
	console.log("ptPet",ptPet);
	
	console.log("pet",pet);
	
	
	<%-- 	let dongVO = <% ${dongVO} %>; --%>
	
	//전문분야별 통계
	new Chart(ctx, {
	    type: 'bar',  // bar, line, pie, doughnut, radar 등등...
	    data: {
	        labels: ['반려동물', '운동', '악기', '인테리어', '취미', '면접', '기타'],
	        
	        datasets: [
	            {	
	            	maxBarThickness: 20,
	                label: '전문분야별통계',
	                data: [pet, sport, music, home, hobby, meet, gita],
	                borderWidth: 1,
	                backgroundColor:[
	                	'#E6B8FF',
	                	'#B4E6D4',
	                	'#A6C8FF',
	                	'#FFD6E6',
	                	'#FFF0B4',
	                	'#FFE6CC',
	                	'#D8D8D8'
	                ]
	            }
	        ]
	    },
	    options: {
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	
	//전문분야별 통계 퍼센트
	new Chart(ctx2, {
	    type: 'doughnut',  // bar, line, pie, doughnut, radar 등등...
	    data: {
	        labels: ['반려동물', '운동', '악기', '인테리어', '취미', '면접', '기타'],
	        
	        datasets: [
	            {	
	            	maxBarThickness: 10,
	                label: '분야별통계',
	                data: [ptPet, ptSport, ptMusic, ptHome, ptHobby, ptMeet, ptGita],
	                borderWidth: 1,
	                backgroundColor:[
	                	'#E6B8FF',
	                	'#B4E6D4',
	                	'#A6C8FF',
	                	'#FFD6E6',
	                	'#FFF0B4',
	                	'#FFE6CC',
	                	'#D8D8D8'
	                ]
	            }
	        ]
	    },
	    
	    options: {
	    	
	    }
	});
	
	
</script>