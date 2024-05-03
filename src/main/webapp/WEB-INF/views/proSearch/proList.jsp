<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/bootstrap.min.js"></script>

<head>
  <title>프로찾기</title>
</head>
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


#keySpan {
    position: absolute;
    z-index: 2; /* 풍선 이미지 위에 나타나도록 설정 */
}

</style>


<script>
$(function(){
   $("#bcityNm").change(function(){
       var selecBcity = $(this).val(); // 선택된 광역시
       var brtcOptions = ""; // 시/구 옵션을 저장할 변수
       
       $.ajax({
           type: "GET",
           url: "/proProfl/brtcList",
           data: { bcityNm: selecBcity },
           success: function(data){
               $.each(data, function(index, list){
                    brtcOptions += '<option value="' + list.brtcNm + '">' + list.brtcNm + '</option>';
               });
               $("#brtcNm").html('<option selected>지역(시/구)</option>' + brtcOptions);
           },
           error: function(xhr, status, error) {
               console.log("Error: " + error);
           }
       });
   });


//지역 검색하기
   $("#searchCityBtn").on("click",function(){
      let currentPage="1";
      $("#proListBody").html(""); 
      console.log("keyword : " + $("#bcityNm").val());      
      console.log("keyword2 : " + $("#brtcNm").val());
      if($("#brtcNm").val()==null || $("#brtcNm").val()=='지역(시/구)'){
         alert("지역(시/구)를 선택해주세요");
         return;
      }
      let key = $("#bcityNm").val() + $("#brtcNm").val();
      if(key.includes('전체')){
    	  key = $("#bcityNm").val();
      }

      let selectColumn = "BCITY_NM";
      
      let data = {
         "keyword": key,
         "selectColumn":selectColumn,
         "currentPage": currentPage
      };
      console.log("data : ", data);
      proList(data);
      history.pushState(null, null, "proList?currentPage="+currentPage+"&keyword="+encodeURIComponent(key)+"&selectColumn="+selectColumn);
      
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
      window.location.href ="proList?currentPage=" + currentPage + "&keyword=" + encodeURIComponent(key)+"&selectColumn="+selectColumn;
   });

//검색하기
   $("#searchProBtn").on("click",function(){
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
              }).then(() => {
                  window.history.back();
              });
          }
      proList(data);
      history.pushState(null, null, "proList?currentPage="+currentPage+"&keyword="+encodeURIComponent(key)+"&selectColumn="+selectColumn);
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
              		<div id="title">
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
	            	                    <h1 style="margin-top:100px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">
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
	            	    <h1 style="margin-top:100px; text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">
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

//전체
   let currentPage = "${param.currentPage}"
   if(currentPage == "") {
      currentPage = "1";
   }
   
   // /proSearch/proList?currentPage=2&keyword=%ED%83%9C%EA%B6%8C%EB%8F%84&selectColumn=SPCLTY_REALM_NM
   let selectColumn = "${param.selectColumn}";
   
   if(selectColumn==""){
	   selectColumn = "ALL";
   }
   
   let data = {
      "keyword": "${param.keyword}",
      "selectColumn":selectColumn,
      "currentPage": currentPage
   };
   console.log("data : " + data);
   proList(data);


//엔터처리
    $(document).on('keydown', function(e){
        if (e.code == 'Enter') {
            // 검색 버튼 클릭
            $('#searchProBtn').click();
        }
    });

});

</script>
<div class="content-wrapper" style=" margin-top:-40px; background : #F5F7FF;">
<div>
  	<!-- 제목 -->
  		<div id="title">
			<img alt="프로찾기" src="../resources/images/프찾2.png" style="width:100px; height:auto; margin:0 0 20px 590px;">
			<h2 id="noticeTitle" style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4e4c7c; text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">프로 찾기</h2>
			<hr style="border-top: 50px solid #fff; margin:-50px 500px 0 500px;">
		</div>
   <br>
   <span id="keySpan" style="display:flex; justify-content: center; margin:0 0 0 430px;">
      <input id="keyword" style="width:400px; height:40px; padding: 0 20px 0 20px; border:1px solid #c4c4c4; border-radius: 20px;">
      <button id="searchProBtn" class="btn btn-primary" type="button" style="margin-left: 10px; font-family: 'GmarketSansMedium';">검색</button>
   </span>

   <div style="margin-top:70px; background:white; border-radius: 20px;">
   <br><br>
      <div style="margin-left:-50px;">
         <div  style="display:flex; align-items: center; justify-content: center;">
            <div>
               <button id="searchSev" class="btn btn-outline-primary btn-fw" type="button" style="margin-right: 10px; font-family: 'GmarketSansMedium';" data-toggle="modal" data-target="#serModal">서비스</button>
               <button class="btn btn-outline-primary btn-fw" type="button" style="margin-right: 10px; font-family: 'GmarketSansMedium';" data-toggle="modal" data-target="#cityModal">지역</button>
            </div>
            <span class="card-description" style="margin:0 -30px 0 290px;">
              <button type="button" style="font-family: 'seolleimcool-SemiBold'; font-size:20px; width:300px; height:60px; border:none; background-color:#f5f7ff; border-radius: 20px;" onclick="location.href='/proSearch/aroundPro'">
              <img src="/resources/images/찾기.png" alt="search" style="width:40px; height:40px; "> &nbsp;&nbsp;내 주변 프로찾기</button>
            </span>
         </div>
         <br><br>
         
           <div id="proListBody">
         <!--  proSearchList : [ProVO(proId=asdasd, proProflPhoto=/images/2024/03/15/c192873a-de59-47ac-8221-0f46f42412af_Anne-Marie(앤마리)-2002.jpg, spcltyRealmCode=SR2502, 
         proflVOList=[ProProflVO(proProflOnLiIntrcn=dasfd, proProflContactPosblTime=asdfasd, bcityCode=11, brtcCode=11090)], 
         userSeVOList=[UsersVO(userNcnm=asdasd)], 
         vCityVOList=[VCityVO(bcityNm=서울, brtcNm=강북구, ], 
         spcltyRealmVOList=[SpcltyRealmVO(spcltyRealmNm=태권도)]), -->
         <c:if test=""></c:if>
         </div>
       </div>
      <div id="S_divPaging" style="position: relative; margin-left: 45%; margin-top: 20px; padding-bottom:50px;"">
      <br><br><br><br>
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
            <button type="button" class="btn btn-light" data-dismiss="modal" style="font-family: 'GmarketSansMedium';">닫기</button>
         </div>
      </div>
   </div>
</div>



<!-- //////// 지역 선택 모달 //////// -->
<div class="modal fade" id="cityModal" tabindex="-1" aria-labelledby="exampleModalLabel-2" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="cityModalTitle" style="font-family: 'GmarketSansMedium';">지역별 검색하기</h5>
            <button type="button" class="close" data-dismiss="modal"
               aria-label="Close">
               <span aria-hidden="true">×</span>
            </button>
         </div>
         <div class="cityModalBody" style="height:auto; margin:20px 0 5px 30px;">
               <div class="form-group" style="margin-left:15px;">
                  <label for="bcityNm" style="font-family: 'GmarketSansMedium';">지역(광역시)</label>
                     <select id="bcityNm" name="spcltyB" class="form-control" style="width:400px; font-family: 'GmarketSansMedium';">
                        <option selected>지역(광역시)를 선택해주세요</option>
                        <c:forEach items="${bcityVOList}" var="bcityVO">
                        <option><c:out value="${bcityVO.bcityNm}"/></option>
                        </c:forEach>
                     </select>
               </div> 
               <div class="form-group" id="b2Cla" style="margin-left:15px;">
                   <label for="brtcNm" style="font-family: 'GmarketSansMedium';">지역(시/구)</label>
                  <select id="brtcNm" name="brtcNm" class="form-control" style="width:400px; font-family: 'GmarketSansMedium';">
                      <option selected>지역(시/구)를 선택해주세요</option>
                  </select>
               </div>
         </div>
         
         <div class="modal-footer">
            <button class="btn btn-primary" type="button" id="searchCityBtn" data-dismiss="modal" style="font-family: 'GmarketSansMedium';">확인</button>
            <button type="button" class="btn btn-light" data-dismiss="modal" style="font-family: 'GmarketSansMedium';">닫기</button>
         </div>
      </div>
   </div>
</div>
