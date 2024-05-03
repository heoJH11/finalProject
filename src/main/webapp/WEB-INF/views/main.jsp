<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">

<head>
   <title>Home</title>
</head>
<style>
.redBoldText {
    color: red;
    font-weight: bold;
}

.ondyclTitle{
	display: block;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.outterDiv{
	position: relative;
	z-index: 1;
}
.medalImg{
	position: absolute;
	z-index: 2;
	margin-left:-26px;
	margin-top:-15px;
}
@font-face {
    font-family: 'TTHakgyoansimDotbogiR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimDotbogiR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'seolleimcool-SemiBold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2312-1@1.1/seolleimcool-SemiBold.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

.effect-text-in{
	width:200px;
	height:200px;
}


#balloon {
    position: absolute;
    margin-top: -90px;
    top: 0;
    left: 0;
    z-index: 0;
}

#mainImg {
    position: absolute;
    z-index: 1; /* 풍선 이미지 위에 나타나도록 설정 */
}

#mains,#sevMenu {
    position: relative;
    z-index: 2; /* main 이미지 위에 나타나도록 설정 */
}

td{
	font-family: 'GmarketSansLight';
}

</style>


<script>

$(function(){
	$("#dissbtn").click(function(){
	    $("#serModal").modal("hide"); 
	});
	
	
		$("#readAll").click(function(){
			window.location.href = "proHunting/list";
		});
		$(".dropdown-item").click(function() {
	        var selectedText = $(this).text();
	        $("#dropdownMenuSizeButton3").text(selectedText);
	    });
		
	    // 전체 목록 출력
	    let currentPage = "${param.currentPage}";
	    if(currentPage == ""){
	    	currentPage = "1";
	    }
	    
	    let data = {
	    		"keyword" : "${param.keyword}",
				"currentPage" : currentPage
	    }
	    
	    $.ajax({
	    	url : "/proHunting/listAjax?currentPage="+currentPage+"&keyword=${param.keyword}",
	    	contentType : "application/json; charset=utf-8",
	 	    data : JSON.stringify(data),
	 	    type : "post",
	 	    dataType : "json",
	 	    success : function(res){
				console.log("구인게시판리스트 res : " , res);
				$("#proHuntingListBody").html("");
				$("#divPaging").html("");
				var str = "";
				$.each(res.content, function(i, v){
					str += "<tr onclick=\"location.href='/proHunting/detail?proJoBbscttNo=" + v.proJoBbscttNo + "'\" data-no='"+v.proJoBbscttNo+"'>";
					str += "<td>" + v.num + "</td>";
					str += "<td>" + v.proJoBbscttSj + "</td>";
					str += "<td>" + v.mberVOList[0].userNcnm + "</td>";
					str += "<td>" + (v.proJoBbscttWrDt).substr(0, 10) + "</td>";
					str += "<td>" + v.proJoBbscttRdcnt + "</td>";
					str += "</tr>";

				});//each 끝
				$("#proHuntingListBody").html(str);
				if(res.total == 0){
					//페이징 처리
					$("#divPaging").html("");
				}else{
					$("#divPaging").html(res.pagingArea);
				}
	 	    }// success 종료
	 	});//ajax 끝 
	 	
	 	// 검색
		$("#searchBtn").on("click",function(){
			let keyword = $("input[name='keyword']").val();
			
			if (keyword.trim() === '') {
		          Swal.fire({
		              title: '검색어가 없습니다.',
		              icon: 'warning',
		              confirmButtonText: '확인'
		          });
		          return; // 검색어가 없으면 더 이상 실행하지 않음
		      }
			
			// 검색 카테고리 설정
			let selectColumn = $("#dropdownMenuSizeButton3").text();
			let t_selectColumn = "";
			if(selectColumn == "작성자" ){
				selectColumn = "A.USER_NCNM";
				t_selectColumn = "USER_NCNM";
			}else if(selectColumn == "제목"){
				selectColumn = "A.PRO_JO_BBSCTT_SJ";
				t_selectColumn = "PRO_JO_BBSCTT_SJ";
			}else if(selectColumn == "전체"){
				selectColumn = "ALL";
				t_selectColumn = "ALL";
			}

			let currentPage = "1";
			
			var data = {
					"keyword" : keyword,
					"selectColumn" : selectColumn,
					"t_selectColumn" : t_selectColumn,
					"currentPage" : currentPage
						};
			$.ajax({
		        url : "/proHunting/listAjax?currentPage="+currentPage+"&keyword="+keyword,
		        contentType : "application/json; charset=utf-8",
		        data : JSON.stringify(data),
		        type : "post",
		        dataType : "json",
		        success: function(res){
		        	console.log("구인게시판리스트 res : " , res);
					$("#proHuntingListBody").html("");
					var str = "";
					$.each(res.content, function(i, v){
						str += "<tr onclick='location.href='/proHunting/detail?"+v.proJoBbscttNo+"'>";
						str += "<td>"+v.proJoBbscttSj+"</td>";
						str += "<td>"+v.mberVOList[0].userNcnm+"</td>";
						str += "<td>"+(v.proJoBbscttWrDt).substr(0,10)+"</td>";
						str += "<td>"+v.proJoBbscttRdcnt+"</td>";
						str += "</tr>";
					});//each 끝
					history.pushState(null, null, "listAjax?currentPage="+currentPage+"&keyword="+keyword);
					$("#proHuntingListBody").html(str);
		 	    }// success 종료
		 	});//ajax 끝 
		});
	 	
	 	// 조회수
	 	$("#proHuntingListTb").on("click","tr", function(e){
			var proJoBbscttNo = $(this).data("no");
			console.log("행 클릭 : " , proJoBbscttNo);
			var data = {"proJoBbscttNo" : proJoBbscttNo};
			
			$.ajax({
				url : "/proHunting/rdCntUpdt",
				data : JSON.stringify(data),
				contentType : "application/json; charset=UTF-8",
				type : "post",
				success : function(res){
				}
			});
	 	});
	
	 	
	 	
	 	
	 	///서비스 중분류->소분류 리스트
	 	$("#spcltyB2").change(function(){
	 	    var selecSpclty = $(this).val(); // 선택된 중분류
	 	    var selecSpcltyNm = $("#spcltyB2 > option:selected").attr("value2");
	 	    var spcltyOptions = ""; // 소분류를 저장할 변수
	 	    
	 	    $.ajax({
	 	        type: "GET",
	 	        url: "/proSearch/spcltySec",
	 	        data: { code: selecSpclty },
	 	        success: function(data){
	 	            $.each(data, function(index, list){
	 	            	 spcltyOptions += "<option value='" + list.spcltyRealmCode + "' value2='"+list.spcltyRealmNm+"'>" + list.spcltyRealmNm + "</option>";
	 	            });
	 	            
	 	            console.log("spcltyOptions",spcltyOptions);
	 	            if (spcltyOptions.length == 0) {
	 	                $("#b3Cla").css("display", "none");
	 	            } else {
	 	            	$("#b3Cla").css("display", "inline");
	 	            	$("#b3Cla").css("margin-left", "15px");
	 	            	$("#spcltyB3").css("margin-left", "15px");
	 	                $("#spcltyB3").html('<option selected>소분류를 선택해주세요</option>' + spcltyOptions);
	 	            }       
	 	        },
	 	        error: function(xhr, status, error) {
	 	            console.log("Error: " + error);
	 	        }
	 	    });
	 	});

//서비스 대분류-> 중분류 리스트
$("#spcltyB").change(function(){
    var selecSpcltyCode = $(this).val(); // 선택된 대분류
    var selecSpcltyNm = $("#spcltyB > option:selected").attr("value2");
    var spcltyOptions = ""; // 중분류를 저장할 변수
    
    $.ajax({
        type: "GET",
        url: "/proSearch/spcltySec",
        data: { code: selecSpcltyCode },
        success: function(data){
            $.each(data, function(index, list){
                 spcltyOptions += "<option value='" + list.spcltyRealmCode + "' value2='"+list.spcltyRealmNm+"'>" + list.spcltyRealmNm + "</option>";
            });
               $("#spcltyB2").html('<option selected>중분류를 선택해주세요</option>' + spcltyOptions);                   
        },
        error: function(xhr, status, error) {
            console.log("Error: " + error);
        }
    });
});


//서비스 검색하기
$("#searchServBtn").on("click",function(){
      let currentPage="1";
      $("#proListBody").html(""); 
      console.log("keyword : " + $("#spcltyB2").val());
      console.log("keyword2 : " + $("#spcltyB3").val());
      
	let key;
      if ($("#spcltyB2").val() == '중분류를 선택해주세요') {
    	    Swal.fire({
    	        title: '중분류를 선택해주세요.',
    	        icon: 'warning',
    	        confirmButtonColor: '#4B49AC',
    	        cancelButtonColor: '#d33',
    	        confirmButtonText: '확인',
    	    });
    	    return;
    	} else if ($("#spcltyB3").val() == '소분류를 선택해주세요') {
    	    if ($("#b3Cla").css("display") === "none") {
    	        key = $("#spcltyB2").val();
    	    } else {
    	        Swal.fire({
    	            title: '소분류를 선택해주세요.',
    	            icon: 'warning',
    	            confirmButtonColor: '#4B49AC',
    	            cancelButtonColor: '#d33',
    	            confirmButtonText: '확인',
    	        });
    	        return;
    	    }
    	}else if($("#spcltyB3").val() != '소분류를 선택해주세요'){
  		key = $("#spcltyB3").val();
    	}

      console.log("key:" + key);
      
      //서비스
      let selectColumn = "SPCLTY_REALM_CODE";
      
      let data = {
            "currentPage":currentPage,
            "selectColumn":selectColumn,
            "keyword":key
      }
      console.log("data : ", data);
      proList(data);
      $('#serModal').modal('hide');
      window.location.href ="proSearch/proList?currentPage=" + currentPage + "&keyword=" + encodeURIComponent(key)+"&selectColumn="+selectColumn;
   });



//서비스별 카테고리 검색 모달띄우기
for (let i = 1; i <= 7; i++) {
    $("#sevMenu" + i).on("click", function(){
        let currentPage = "1";
        let key = $("#sevMenu" + i).attr("value"); // 해당 서비스 메뉴의 value 속성 값 저장
        console.log("sevMenuKey", key);
        
        let selecSpcltyNm = $("#sevMenu" + i).attr("value2"); // 해당 서비스 메뉴의 value2 속성 값 저장
        console.log("selecSpcltyNm", selecSpcltyNm);
        
        // serModal 모달 띄우기
        $('#serModal').modal('show');
        
        var selecSpclty = $("#spcltyB").val(key); // 선택된 대분류
        console.log("selecSpclty", selecSpclty);
        
        var spcltyOptions = ""; // 중분류를 저장할 변수
        console.log("selecSpclty", selecSpclty);
        
        $.ajax({
            type: "GET",
            url: "/proSearch/spcltySec",
            data: { code: key },
            success: function(data){
                $.each(data, function(index, list){
                     spcltyOptions += "<option value='" + list.spcltyRealmCode + "' value2='"+list.spcltyRealmNm+"'>" + list.spcltyRealmNm + "</option>";
                });
                   $("#spcltyB2").html('<option selected>중분류를 선택해주세요</option>' + spcltyOptions);                   
            },
            error: function(xhr, status, error) {
                console.log("Error: " + error);
            }
        });
    });
}

	
//메인 프로 검색하기
   $("#navbar-search-icon").on("click",function(){
	   let currentPage="1";
	      $("#proListBody").html(""); 
	      console.log("keyword : " + $("#keyword").val());
	      let key = $("#keyword").val();
	      let selectColumn = "ALL";
	      
	      let data = {
	         "keyword": key,
	         "selectColumn":selectColumn,
	         "currentPage": currentPage
	      };
	      console.log("data : ", data);
	      if(key==null || key=="") {
              Swal.fire({
                  title: "검색어를 입력해주세요",
                  confirmButtonText: "확인",
                  icon: 'warning',
                  customClass: {
                      title: 'swal-title'
                  }
              });
              return false;
        	 }
	      proList(data);
	      window.location.href ="proSearch/proList?currentPage=" + currentPage + "&keyword=" + encodeURIComponent(key)+"&selectColumn="+selectColumn;
   });
   
});

//검색한 프로 찾기
function proList(data){
    $.ajax({
        type: "post",
        url: "/proSearch/searchPage",
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(res){
            console.log(res);
           
            let str = "";
            if(res.content == null || res.content.length == 0 || res.content == ""){
               str += "<div style='text-align: center; margin-top:50px;'>";
               str += "<img src='../resources/images/우는모양.png' style='width:100px; height:100px; '/>";
               str += "<h3 style='padding:20px 0 40px 0; color:#c6c9cc; font-family: seolleimcool-SemiBold;'><b>검색 결과가 없어요!</b></h3>";
               str += "</div>";
            }else{
            $.each(res.content, function(idx, ProVO){
                console.log("ProVO[" + idx + "] : ", ProVO);
                console.log("res : " , res.content);
                str += "<div style='border: 1px solid #CED4DA; border-radius: 20px; width: 800px; margin-left: 280px; padding: 10px 0;'>";
                str += "<div class='proflClick' style='display: flex; align-items: center; margin-left: 100px;' >";
                str += "<div style='width: 500px;'>";
                str += "<div style='display: flex; align-items: center;'>";
                str += "<div style='width: 200px;'>";
                str += "<h3 style='font-family: GmarketSansMedium;'>"+ProVO.userSeVOList[0].userNcnm+"</h3>";
                str += "<p class='proIds' style='font-family: GmarketSansMedium;'>" + ProVO.proId + "</p>"; 
                str += "</div>";
                str += "<div style='width: 300px;'>";
                str += "<span class='badge badge-outline-dark my-1' id='spcltyRealm' style='margin-right:10px; font-family: GmarketSansMedium;'>&nbsp&nbsp"+ProVO.spcltyRealmVOList[0].spcltyRealmNm+"&nbsp&nbsp</span>";
                str += "<span class='badge badge-outline-dark my-1' style='margin-right:10px; font-family: GmarketSansMedium;'>"+ProVO.proflVOList[0].proProflContactPosblTime+"</span>";
                str += "<span class='badge badge-outline-dark my-1' id='profl-info' style='margin-right:10px; font-family: 'GmarketSansMedium';'>";
                if (ProVO.vcityVOList[0].bcityNm == ProVO.vcityVOList[0].brtcNm) {
                    str += "<span class='brtcNm' style='font-family: GmarketSansMedium;'>" + ProVO.vcityVOList[0].brtcNm + "</span>";
                } else {
                    str += "&nbsp;&nbsp;<span class='bcityNm' style='font-family: GmarketSansMedium;'>" + ProVO.vcityVOList[0].bcityNm + "</span>&nbsp;";
                    str += "<span class='brtcNm' style='font-family: GmarketSansMedium;'>" + ProVO.vcityVOList[0].brtcNm + "</span>&nbsp;&nbsp;";
                }
                str += "</span>";
                str += "</div>";
                str += "</div>";
                str += "<div>";
                str += "<p style='font-family: GmarketSansMedium;'>"+ProVO.proflVOList[0].proProflOnLiIntrcn+"</p>";
                str += "</div>";
                str += "</div>";
                str += "<div style='margin-left: 20px;'>";
                str += "<img class='proProflPhoto' src='"+ (ProVO.proProflPhoto == null ? '/images/2024/profile.jpg' : ProVO.proProflPhoto) +"' style='width: 100px; height: 100px; border-radius: 20%;'> ";  
                str += "</div>";
                str += "</div>";
                str += "</div>";
                str += "<br><br>";
            });
            
            }
  	      
            if(window.location.href == "http://localhost/proSearch/proList" || window.location.href == "http://localhost/proSearch/proList?currentPage="+res.currentPage+"&keyword=&selectColumn=ALL") {
                var titleHtml = `
              		<div>
        			<img alt="프로찾기" src="../resources/images/프찾2.png" style="width:100px; height:auto; margin:0 0 20px 590px;">
        			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 찾기</h2>
        			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
        		</div>
                `;
                $("#title").html(titleHtml);                            
            }else{
          		if(res.keyword == '전국전국'){
	            	var titleHtml = `
	            		<div id="title">
	            	    <h1 style="margin-top:200px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">
	            	       "전국"의 검색결과
	            	    </h1>
	            		</div>
	                        `;
	            	$("#title").html(titleHtml);  
	            }else{
	            	let key = res.keyword;
	            	console.log("keykey",key);
	            	if (key.substring(0, 2) === "SR") {
	            	    $.ajax({
	            	        type: "get",
	            	        url: "/proSearch/spcltyNm",
	            	        data: { "code": key },
	            	        contentType: "application/json; charset=utf-8",
	            	        dataType: "text",
	            	        success: function(data) {
	            	            console.log("dataaaaaa", data);
	            	            var titleHtml = `
	            	                <div id="title">
	            	                    <h1 style="margin-top:200px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">
	            	                    "`+data+`"의 검색결과
	            	                    </h1>
	            	                </div>
	            	            `;
	            	            $("#title").html(titleHtml);
	            	        }
	            	    });
	            	}else{
	            	var titleHtml = `
            		<div id="title">
	            	    <h1 style="margin-top:200px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">
            	       "`+res.keyword+`"의 검색결과
            	    	</h1>
	            	</div>
                       `;
	            	$("#title").html(titleHtml);   
	            	}
	            	           
            	}
          	}
            
            $("#proListBody").html(str); 
            $("#keyword").val("");
            
          //프로누르면 들어가기
            $('.proflClick').on('click', function() {
         	    let proId = $(this).find('.proIds').text();
         	    console.log("이거봐요proId", proId);
         	    window.location.href = "/proProfl/detail?proId=" + proId;
         	});

            //페이징처리
            if(res.content == null || res.content.length === 0){
               $("#S_divPaging").html("");
            }else{               
               $("#S_divPaging").html(res.pagingArea);
            }
        }
    });
}

//엔터처리
    $(document).on('keydown', function(e){

    	 if (e.code == 'Enter' && !$('#tynQuickChatInput').is(':focus')) {
    	        e.stopPropagation();
    	        $('#navbar-search-icon').click();
    	    }
    });

</script>

<%--       <%
Enumeration sen = session.getAttributeNames();

while(sen.hasMoreElements()){
   String nm = (String)sen.nextElement();
   out.print("<p>개똥이 : " + session.getAttribute(nm) + "</p>");
}
%> --%>

<div>
	<div style="position: relative;">
<%-- 	<p>asdfasd${spcltyBList}</p> --%>
		<div style="position: absolute; top: 0; left: 0; width: 100%;">
	        <img src="../resources/images/풍선3.png" id="balloon" style="width: 1600px; height:700px; margin-left:-125px;">
	        <img src="../resources/images/메인3.gif" id="mainImg" style="width: 60%; border-radius: 30px; margin-left:280px;">
	    </div >
		<div id="mains" style="position: relative; padding-top:360px;">
			<h3 style="font-family: 'TTHakgyoansimDotbogiR'; color:#4B49AC; text-align:center;">
			<img src='../resources/images/눈.png' style='width:35px; height:auto; backgroun-color:white;'/>&nbsp;눈에 띄는 프로를 찾아보세요!</h3>
				<div class="input-group"  style="width:400px; margin:0 auto;">
					<input type="text" class="form-control" id="keyword" style="font-family: 'GmarketSansMedium';" placeholder="눈에띄는 프로찾기" aria-label="search" aria-describedby="search">
					<div class="input-group-prepend hover-cursor" id="navbar-search-icon" >
						<span class="input-group-text" id="search">
							<i class="icon-search text-primary"></i>
						</span>
					</div>
				</div>    
			<br>
		</div>
	</div>
	
	<!--서비스 메뉴  -->
	<div id="sevMenu" style="display:flex; justify-content: center; text-align:center; font-family: 'GmarketSansMedium'; color:#6c7384; margin-top:130px;">
		<div id="sevMenu1" value="SR2" value2="운동" style="margin-right:50px;"><img src='../resources/images/운동1.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>운동</h6></div>
		<div id="sevMenu2" value="SR1" value2="반려동물"style="margin-right:50px;"><img src='../resources/images/반려동물3.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>반려동물</h6></div>
		<div id="sevMenu3" value="SR3" value2="악기"style="margin-right:50px;"><img src='../resources/images/악기4.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>악기</h6></div>
		<div id="sevMenu4" value="SR4" value2="인테리어"style="margin-right:50px;"><img src='../resources/images/인테리어3.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>인테리어</h6></div>
		<div id="sevMenu5" value="SR5" value2="취미"style="margin-right:50px;"><img src='../resources/images/취미2.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>취미</h6></div>
		<div id="sevMenu6" value="SR6" value2="취업/직무"style="margin-right:50px;"><img src='../resources/images/취업2.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>취업/직무</h6></div>
		<div id="sevMenu7" value="SR7" value2="기타"><img src='../resources/images/기타2.png' style='width:60px; height:auto;  margin-bottom:10px;'/><br><h6>기타</h6></div>
	</div>
	
	
<!-- 이달의 프로 -->
<!--monthProList[ProVO(proId=nn34111, 
	proProflPhoto=/images/2024/03/12/3a4500c7-1342-4dd9-8493-7ea0a356660f_Desert.jpg, spcltyRealmCode=SR2502,  
	proflVOList=[ProProflVO(proProflOnLiIntrcn=asdfasdf], 
	userSeVOList=[UsersVO(userNm=ndfn111,)]  -->
<div>
<div style="width:700px; height:auto; margin:60px 0 0 340px;">
<%-- 	<p>${monthProList}</p> --%>
           <div>
             <div class="card">
               <div class="card-body text-center" style="border-radius:20px; background-color:#f5f7ff;">
               	<c:forEach var="proVO" items="${monthProList}">
					<div>
					<img src='/resources/images/축하2.png' style='width:50px; height:50px; margin-bottom:10px'>
						<h2 style="font-family: 'seolleimcool-SemiBold';">이달의 프로</h2>
						<c:if test="${proVO.proProflPhoto == null}">
						<img src="/images/2024/profile.jpg" style="width: 120px; height: 120px; border-radius: 70%; margin:20px 0 ;" alt="profile image">
						</c:if>
						<c:if test="${proVO.proProflPhoto != null}">
						<img src="${proVO.proProflPhoto}" style="width: 120px; height: 120px; border-radius: 70%; margin:20px 0 ;" alt="profile image">
						</c:if>
						<h4 style="font-family: 'GmarketSansMedium';">${proVO.userSeVOList[0].userNm}</h4>
						<p style="font-family: 'GmarketSansMedium';" class="text-muted mb-0">${proVO.proId}</p>
					</div>
					<p class="mt-2 card-text" style="font-family: 'GmarketSansMedium';">
					  	${proVO.proflVOList[0].proProflOnLiIntrcn}
					</p>
                  <button class="btn btn-info btn-sm mt-3 mb-4" style="font-family: 'GmarketSansMedium';" onclick="location.href='/proProfl/detail?proId=${proVO.proId}'">프로필 보러가기</button>
                 </c:forEach>
                  <div class="border-top pt-3">
                    <div class="row">
                      <div class="col-4">
                        <h6 style="font-family: 'GmarketSansMedium';">${srvcCount}</h6>
                        <p style="font-family: 'GmarketSansMedium';">고용수</p>
                      </div>
                      <div class="col-4">
                        <h6 style="font-family: 'GmarketSansMedium';">${revCount}</h6>
                        <p style="font-family: 'GmarketSansMedium';">리뷰수</p>
                      </div>
                      <div class="col-4">
                        <h6 style="font-family: 'GmarketSansMedium';">${bkmkCount}</h6>
                        <p style="font-family: 'GmarketSansMedium';">팔로워</p>
                      </div>
                    </div>
                  </div>
                </div>
             </div>
           </div>
	</div>

	<!-- 동균 서비스요청 통계 -->
	<div style="margin-top:100px;">
		<h3 style="text-align:center;"><b>📊 서비스 요청시 프로는 이만큼 수락하고있어요</b></h3>
		<div class="row" style="margin:20px 0 0 250px; ">
			<div style="width:500px; height:400px; background:white; border-radius:20px; margin-right:20px; padding:20px;">
				<br>
			    <div style="width:460px; height:300px;">
			        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
			        <canvas id="myChart3" style="width: 48%;"></canvas>
			    </div>
			</div>
			<div style="width:500px; height:400px; background:white; border-radius:20px; padding:20px;">
			    <br>
			    <div style="width:460px; height:300px; margin-left:80px;">
			        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
			        <canvas id="myChart4" style="width: 48%;"></canvas>
			    </div>
			</div>
		</div>
	</div>
	<!-- 동균 서비스요청 통계 끝 -->
	
	
<!-- 프로구인게시판 -->
		<div class="card" style="width: 800px; margin: 30px 0 0 300px;">
			<div class="card-body">
				<div style="display:flex; flex-wrap: wrap; align-items: center;">
				<h3 style="font-family: 'seolleimcool-SemiBold';" >
				 <img src="../resources/images/구인.png" style="width:50px; height:auto; margin-right:5px; background-color:white; vertical-align: middle;" alt="구인아이콘"/>
				 프로 구인 게시판
				 </h3>
				 <h4 style="font-family: 'GmarketSansMedium'; margin-left:400px; color:#a7a7a7;">전체 보기</h4>
				 <img src="../resources/images/화살표.png" id="readAll" style="width:30px; height:auto; margin:-10px 0 0 20px; background-color:white; " alt="화살표아이콘"/>
				</div>
				<div class="table-responsive">
					<table class="table table-striped text-center"
						id="proHuntingListTb">
						<thead>
							<tr>
								<th style="width: 5%; font-family: 'GmarketSansLight';">번호</th>
								<th style="width: 5%; font-family: 'GmarketSansLight';">제목</th>
								<th style="width: 15%; font-family: 'GmarketSansLight';">작성자</th>
								<th style="width: 15%; font-family: 'GmarketSansLight';">작성일</th>
								<th style="width: 10%; font-family: 'GmarketSansLight';">조회수</th>
							</tr>
						</thead>
						<tbody id="proHuntingListBody" style="font-family: 'GmarketSansLight';">
						</tbody>
					</table>
				</div>
			</div>
		</div>


		<!-- 프로이야기 -->
<div style="margin:60px -235px 80px 320px;">
<h3 style="font-family: 'seolleimcool-SemiBold';">
    <img src="../resources/images/불이야.png" style="width:35px; height:auto; margin-right:5px; background-color:white; vertical-align: middle;" alt="hot아이콘"/>
    <span style="vertical-align: middle;"> 
        <span class="redBoldText" style="font-family: 'seolleimcool-SemiBold';">HOT</span> 프로이야기
    </span>
</h3>
	<br />
		<div class="row portfolio-grid" style="width:60%; height:auto;">
			<c:forEach var="VO" items="${getRecommendList}">
				<div class="col-xl-3 col-lg-3 col-md-3 col-sm-6 col-12">
				  <figure class="effect-text-in" style="background:#f6e28b">
				
					<a href="/prostory/getStory?storyNo=${VO.proStoryBbscttNo}">
				    <img src="images${VO.proStoryBbscttThumbPhoto}" alt="">
				    <figcaption>
				      <h4 class="proStorylTitle" style="font-family: 'GmarketSansMedium';">${VO.proStoryBbscttSj}</h4>
				      <p style="font-family: 'GmarketSansMedium';">${VO.userNcnm}</p>
				    </figcaption>
				    
				  	</a>
				  </figure>
				</div>
			</c:forEach>
		</div>
</div>


<!-- 원데이 클래스  -->
	<div style="margin:80px -235px 80px 320px;">
<h3 style="font-family: 'seolleimcool-SemiBold';">
	<img src="../resources/images/수업.png" style="width:35px; height:auto; margin-right:5px; background-color:white; vertical-align: middle;" alt="원데이클래스아이콘"/>
	지금 인기있는 원데이 클래스!
</h3>
<br />
		<div class="row portfolio-grid" style="width: 60%; height: auto;">
			<div class="col-4 outterDiv">
				<a href='/onedayClass/onedayClassDetail?ondyclNo=${ondyclVOList[0].ondyclNo}&mberId=${memSession.userId}&mainck=main'>
					<img class='medalImg' src='/images/2024/gold_medal.png' style='width:50px; height:50px;'>
					<figure class="effect-text-in" style="background:#98b3e8">
						<img src="${ondyclVOList[0].ondyclThumbPhoto}" loading="lazy" alt="image">
						<figcaption>
							<h4 class='ondyclTitle' style="font-family: 'GmarketSansMedium';">${ondyclVOList[0].ondyclNm}</h4>
							<p style="font-family: 'GmarketSansMedium';">${ondyclVOList[0].ondyclResvpa} 명</p>
						</figcaption>
					</figure>
				</a>
			</div>
			<div class="col-4 outterDiv">
				<a href='/onedayClass/onedayClassDetail?ondyclNo=${ondyclVOList[1].ondyclNo}&mberId=${memSession.userId}&mainck=main'>
					<img class='medalImg' src='/images/2024/silver_medal.png' style='width:50px; height:50px;'>
					<figure class="effect-text-in" style="background:#98b3e8">
						<img src="${ondyclVOList[1].ondyclThumbPhoto}" loading="lazy" alt="image">
						<figcaption>
							<h4 class='ondyclTitle' style="font-family: 'GmarketSansMedium';">${ondyclVOList[1].ondyclNm}</h4>
							<p style="font-family: 'GmarketSansMedium';">${ondyclVOList[1].ondyclResvpa} 명</p>
						</figcaption>
					</figure>
				</a>
			</div>
			<div class="col-4 outterDiv">
				<a href='/onedayClass/onedayClassDetail?ondyclNo=${ondyclVOList[2].ondyclNo}&mberId=${memSession.userId}&mainck=main'>
					<img class='medalImg' src='/images/2024/copper_medal.png' style='width:50px; height:50px;'>
					<figure class="effect-text-in" style="background:#98b3e8">
						<img src="${ondyclVOList[2].ondyclThumbPhoto}" loading="lazy" alt="image">
						<figcaption>
							<h4 class='ondyclTitle' style="font-family: 'GmarketSansMedium';">${ondyclVOList[2].ondyclNm}</h4>
							<p style="font-family: 'GmarketSansMedium';">${ondyclVOList[2].ondyclResvpa} 명</p>
						</figcaption>
					</figure>
				</a>
			</div>
		</div>
	</div>


</div>


<!-- //////// 서비스 선택 모달 //////// -->
<div class="modal fade" id="serModal" tabindex="-1" aria-labelledby="exampleModalLabel-2" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="serModalTitle">서비스별 검색하기</h5>
            <button type="button" class="close" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">×</span>
            </button>
         </div>
         <div class="serModalBody" style="height:auto; margin:20px 0 0 30px;">
            <div class="form-group">
      
               <div class="form-group" style="margin-left:15px;">
                  <label for="spcltyB" style="font-family: 'GmarketSansMedium';">대분류</label>
                     <select id="spcltyB" name="spcltyB" class="form-control" style="width:400px; font-family: 'GmarketSansMedium';">
                        <option selected>대분류를 선택해주세요</option>
                        <c:forEach items="${spcltyBList}" var="spcltyBVO">
	                        <c:if test="${spcltyBVO.lev eq 1}">
		                        <option value="${spcltyBVO.spcltyRealmCode}" value2="${spcltyBVO.spcltyRealmNm}">${spcltyBVO.spcltyRealmNm}</option>
	                        </c:if>
                        </c:forEach>
                     </select>
               </div> 
               <div class="form-group" id="b2Cla" style="margin-left:15px;">
                   <label for="spcltyB2" style="font-family: 'GmarketSansMedium';">중분류</label>
                  <select id="spcltyB2" name="spcltyB2" class="form-control" style="width:400px; font-family: 'GmarketSansMedium';">
                      <option selected>중분류를 선택해주세요</option>
                  </select>
               </div>
               <div class="form-group" id="b3Cla" style="margin-left:15px;">
                   <label for="spcltyB3" style="font-family: 'GmarketSansMedium';">소분류</label>
                  <select id="spcltyB3" name="spcltyB3" class="form-control" style="width:400px; font-family: 'GmarketSansMedium';">
                      <option selected>소분류를 선택해주세요</option>
                  </select>
               </div>
            </div> 
         </div>
         
         <div class="modal-footer" style="border-top:none;">
            <button class="btn btn-primary" type="submit" id="searchServBtn" style="font-family: 'GmarketSansMedium';">확인</button>
            <button type="button" id="dissbtn" class="btn btn-light" style="font-family: 'GmarketSansMedium';" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>
</div>
<!-- 동균 통계 추가 -->
<script>
	const ctx3 = document.querySelector('#myChart3');
	const ctx4 = document.querySelector('#myChart4');
	
	let january = ${dongVO2.january};
	let february = ${dongVO2.february};
	let march = ${dongVO2.march};
	let april = ${dongVO2.april};
	let may = ${dongVO2.may};
	let june = ${dongVO2.june};
	let july = ${dongVO2.july};
	let august = ${dongVO2.august};
	let september = ${dongVO2.september};
	let october = ${dongVO2.october};
	let november = ${dongVO2.november};
	let december = ${dongVO2.december};
	
	//서비스요청 월별 통계
	new Chart(ctx3, {
		 type: 'bar',  // bar, line, pie, doughnut, radar 등등...
		    data: {
		        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월','10월','11월','12월'],
		        
		        datasets: [
		            {	
		            	maxBarThickness: 10,
		                label: '서비스요청',
		                data: [january, february, march, april, may, june, july, august, september, october, november, december],
		                borderWidth: 1,
		                backgroundColor: '#A6C8FF'
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
	
	
	
	

	let agree = ${dongVO3.agree};
	let refusal = ${dongVO3.refusal};
	let total2 = ${dongVO3.total};
	
	let ptAgree = (agree / total2 * 100).toFixed(2);
	let ptRefusal = (refusal / total2 * 100).toFixed(2);
	
	//서비스요청 프로 수락 거절 현황
	new Chart(ctx4, {
		 type: 'doughnut',  // bar, line, pie, doughnut, radar 등등...
		    data: {
		        labels: ['수락', '거절'],
		        
		        datasets: [
		            {	
		            	maxBarThickness: 10,
		                label: '서비스요청',
		                data: [ptRefusal, ptAgree],
		                borderWidth: 1,
		                backgroundColor: [
		                	'#A6C8FF',
		                	'#D8D8D8'
		                	]
		            }
		        ]
		    },
		    options: {
		    
		    }
		});
	
	
</script>
<!-- 동균 통계 추가 끝 -->
