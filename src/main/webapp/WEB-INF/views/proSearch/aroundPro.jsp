<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<script src="/resources/js/jquery.min.js"></script>
    <meta charset="utf-8">    
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
</style>
<body>
<!--[ProVO(proId=testPro,proProflPhoto=null, spcltyRealmCode=SR2502, ]
userSeVOList=[UsersVO(userNm=테스트프로,],
adresList=[AdresVO(adres=경기 고양시 일산서구 하이파크1로 64, )]),  -->
<%-- <p>${aroundProList}</p> --%>
<img src="/resources/images/찾기3.png" alt="search" style="width:60px; height:auto; display: block; margin: 0 auto;">
<div style="text-align:center; font-family: 'seolleimcool-SemiBold'; color:#4B49AC; margin-top:20px; "><h2 style="text-shadow: -2px 0px white, 0px 2px white, 2px 0px white, 0px -2px white;">내 주변 프로 찾기</h2></div>
<hr style="border-top: 50px solid #f5f7ff; margin:-50px 300px 0 300px;">
<div id="map" style="width:70%; height:700px; border-radius: 20px; margin:50px 0 0 200px;"></div>

<c:forEach items="${aroundProList}" var="aroundPro">
	<div class="col-md-4 grid-margin stretch-card" style="display:none;">
		<div class="card" style="width:50px;">
			<div class="card-body">
				<div class="d-sm-flex flex-row flex-wrap text-center text-sm-left align-items-center">
					<c:if test="${aroundPro.proProflPhoto == null}">
						<img src="/images/2024/profile.jpg" alt="profile" style="width:50px; height:50px; border-radius: 70%;">
					</c:if>
					<c:if test="${aroundPro.proProflPhoto != null}">
						<img src="${aroundPro.proProflPhoto}" alt="profile" style="width:50px; height:50px; border-radius: 70%;">
					</c:if>
					<div class="ms-sm-3 ms-md-0 ms-xl-3 mt-2 mt-sm-0 mt-md-2 mt-xl-0" style="margin-left:20px;">
						<h6 class="mb-0">${aroundPro.userSeVOList[0].userNm}</h6>
						<p class="text-muted mb-1">${aroundPro.proId}</p>
						<span class="badge badge-outline-dark my-1" id="spcltyRealmCode">${aroundPro.spcltyRealmCode}</span>
						<input type="text" class="adres" value="${aroundPro.adresList[0].adres}"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5c848eb4fd5eef99d119f9ac75df67b4&libraries=services"></script>
<script>
$.getScript('http://dapi.kakao.com/v2/maps/sdk.js?appkey=5c848eb4fd5eef99d119f9ac75df67b4&autoload=false', function() { daum.maps.load(function() { var map = new daum.maps.Map(el, options); }); }) 
	//클릭하면 프로프로필 이동
	$(document).on('click', '.text-center', function() {
	    // proId 값 가져오기
	    var proId = $(this).find('.proIds').text();
	    // 페이지 이동
	    window.location.href = "/proProfl/detail?proId=" + proId;
	});
$(function(){
	$.ajax({
		   url: "/proSearch/aroundInfo",
		   data: {},
		   type: "get",
		   dataType: "json",
		   success: function(data) {
		       console.log("data",data); // 받아온 데이터를 출력
				var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
				var mapOption = { 
				    center: new kakao.maps.LatLng(36.324982404009695, 127.40899557516643), // 지도의 중심좌표
				    level: 3 // 지도의 확대 레벨 
				}; 
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
				// HTML5의 geolocation으로 사용할 수 있는지 확인
				if (navigator.geolocation) {
				    // GeoLocation을 이용해서 접속 위치 얻어오기
				    navigator.geolocation.getCurrentPosition(
				        function(position) {
				            var lat = position.coords.latitude; // 위도
				            var lon = position.coords.longitude; // 경도
// 				            var locPosition = new kakao.maps.LatLng(lat, lon); // 현재 위치의 좌표
				            var locPosition = new kakao.maps.LatLng(36.324982404009695, 127.40899557516643); // 대덕 위치의 좌표
				            displayMarker(locPosition);
				        },
				        function(error) {
				            // 위치 정보를 가져오지 못한 경우 기본 위치를 사용
				            var defaultPosition = new kakao.maps.LatLng(36.324982404009695, 127.40899557516643); // 기본 위치의 좌표
				            displayMarker(defaultPosition);
				        }
				    );
				} else { // HTML5의 GeoLocation을 사용할 수 없을 때 기본 위치를 사용
				    var defaultPosition = new kakao.maps.LatLng(36.324982404009695, 127.40899557516643); // 기본 위치의 좌표
				    displayMarker(defaultPosition);
				}
				
				//지도에 마커를 표시
				function displayMarker(locPosition) {

					 // 마커 이미지 설정
				    var markerImage = new kakao.maps.MarkerImage(
				        '/resources/images/지도3.png', // 마커 이미지 URL
				        new kakao.maps.Size(50, 50), // 마커 이미지 크기
				        { offset: new kakao.maps.Point(25, 50) } // 마커 이미지의 좌표 설정
				    );
					 
				    // 마커를 생성
				    var marker = new kakao.maps.Marker({  
				        map: map, 
				        position: locPosition,
				        image: markerImage
				    }); 
				    
				    // 마커를 지도 중심으로 설정
				    map.setCenter(locPosition);
				} 
				
				/* 여러개뜨는거 */
					
				// 주소-좌표 변환 객체를 생성
				var geocoder = new kakao.maps.services.Geocoder();

				var proAdres = [];
				$(".adres").each(function() {
					var adres = $(this).val();
					    proAdres.push(adres);
				});
				/* console.log("proAdres",proAdres);
				console.log("datadata",data); */
				
				// 다음 주소에 대한 처리를 호출하는 함수
				function processNextAddress() {
				    if (proAdres.length == 0) {
				        // 모든 주소 마커 완료되었을 때
				        console.log('주소 마커 완료.');
				        return;
				    }
				    var address = proAdres.shift(); // 리스트에서 주소를 하나씩 추출하여 처리
				    geocodeAddress(address); // 주소로 좌표를 검색하고 마커를 생성하는 함수 호출
				}

				//현재 열려있는 인포윈도우 객체를 추적하기 위한 변수
				var currentInfowindow = null;

				// 다음 주소에 대한 처리를 호출하는 함수
				function processNextAddress() {
				    if (proAdres.length === 0) {
				        // 모든 주소 마커가 완료되었을 때
				        console.log('주소 마커 완료.');
				        return;
				    }
				    
				    var address = proAdres.shift(); // 리스트에서 주소를 하나씩 추출하여 처리
				    geocodeAddress(address); // 주소로 좌표를 검색하고 마커를 생성하는 함수 호출
				}

				// 현재 열려있는 인포윈도우 객체를 추적하기 위한 변수
				var currentInfowindow = null;

				// 주소로 좌표를 검색하고 마커를 생성하는 함수
				function geocodeAddress(address) {
				    geocoder.addressSearch(address, function(result, status) {
				        // 정상적으로 검색이 완료되었을 때
				        if (status === kakao.maps.services.Status.OK) {
				            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				            
				            // 마커 이미지 설정
				            var markerImage = new kakao.maps.MarkerImage(
				                '/resources/images/지도마커.png', // 마커 이미지 URL
				                new kakao.maps.Size(50, 50), // 마커 이미지 크기
				                { offset: new kakao.maps.Point(25, 50) } // 마커 이미지의 좌표 설정
				            );
				            
				            // 마커를 생성하고 지도에 표시
				            var marker = new kakao.maps.Marker({
				                position: coords,
				                map: map,
				                image: markerImage
				            });

				            // 인포윈도우 내용
				            var iwContent  = '<div class="text-center" style="margin-left:40px;">';
				            
				            // 주소가 일치하는 경우 해당 데이터의 정보를 인포윈도우 내용에 추가
				            for (var i = 0; i < data.length; i++) {
				                if (address === data[i].adresList[0].adres) {
				                    var proProflPhoto = data[i].proProflPhoto; // 이미지 URL
				                    var userNm = data[i].userSeVOList[0].userNm; // 사용자 이름
				                    var proId = data[i].proId; // 프로 ID
				                    var spcltyRealmCode = data[i].spcltyRealmCode; // 특별 도메인 코드
				                    
				                    $.ajax({
				             		   url: "/proSearch/spcltyCode",
				             		   data: {"spcltyRealmCode":spcltyRealmCode},
				             		   type: "get",
				             		   dataType: "text",
				             		   success: function(data2) {
				             		   /* console.log("data2",data2); */
				             		
				             		   var sRealmCode = data2; // 특별 도메인 코드
				             		   /* console.log("sRealmCode",sRealmCode); */
				                   
				             		   if (proProflPhoto == null) {
				                        iwContent  += '<img src="/images/2024/profile.jpg" alt="profile" style="margin: 10px;  width:50px; height:50px; border-radius: 70%;">';
				                    } else {
				                        iwContent  += '<img src="' + proProflPhoto + '" alt="profile" style="margin: 10px; width:50px; height:50px; border-radius: 70%;">';
				                    }
				                    iwContent  += '<div">' +
				                    	'<div><a style="text-decoration: none; color: inherit; "href="/proProfl/detail?proId=' + proId + '">' + userNm + '</a></div>' +
				                        '<p class="proIds">' + proId + '</p>' +
				                        '<span class="badge badge-outline-dark my-1" id="spcltyRealmCode">' + sRealmCode + '</span>' +
				                        '<p type="text" class="adres" value="' + address + '"/>' +
				                        '</div>' +
				                        '</div>';
				                    var infoWindow = new kakao.maps.InfoWindow({
				                        position: coords,
				                        content: iwContent 
				                    });

				                    // 마커를 클릭했을 때 인포윈도우 열기
				                    kakao.maps.event.addListener(marker, 'click', function () {
				                        // 열려있는 인포윈도우가 있으면 닫기
				                        if (currentInfowindow) {
				                            currentInfowindow.close();
				                        }
				                        // 새로운 인포윈도우 오픈
				                        infoWindow.open(map, marker);
				                        // 현재 열려있는 인포윈도우를 업데이트
				                        currentInfowindow = infoWindow;
				                    });
				                    
				             		}
				                 });
				                }
				            }
				            // 마지막 주소 처리 시에만 호출
				            if (proAdres.length === 0) {
				                console.log('마지막 주소 처리 완료.');
				            }
				        } else {
				            // 검색 실패 또는 유효하지 않은 주소일 때 처리할 내용 작성
				            console.log('지도에 표시할 수 없는 주소.');
				        }
				        // 다음 주소 처리 호출
				        processNextAddress();
				    });
				}

				// 비동기적으로 주소 처리 시작
				processNextAddress();
		   },
		});
});
</script>
</body>
</html>