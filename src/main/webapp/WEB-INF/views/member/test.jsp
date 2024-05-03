<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="/resources/js/confetti_v2.js"></script>

<style>
	canvas{z-index:10;pointer-events: none;position: fixed;top: 0;transform: scale(1.1);}
</style>

<div class="buttonContainer">
	<button class="canvasBtn" id="stopButton">Stop Confetti</button>
	<button class="canvasBtn" id="startButton">Drop Confetti</button>	
	<p>1</p>
	<p>2</p>
	<p>3</p>
</div>
<input type="checkbox" disabled>
<canvas id="bar-chart" width="476" height="238" style="display: block; width: 476px; height: 238px;" class="chartjs-render-monitor"></canvas>

<script>
// 지도
var mapContainer = document.getElementById('map'); // 지도를 표시할 div
var mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

// 지도를 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 주소-좌표 변환 객체를 생성
var geocoder = new kakao.maps.services.Geocoder();

var proAdres = $("#proAdres").text();
console.log("proAdres", proAdres);

// 주소로 좌표를 검색
geocoder.addressSearch(proAdres, function(result, status) {

    // 정상적으로 검색이 완료
    if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 마커 이미지 설정
        var markerImage = new kakao.maps.MarkerImage(
            '/resources/images/지도마커.png', // 마커 이미지 URL
            new kakao.maps.Size(50, 50), // 마커 이미지 크기
            { offset: new kakao.maps.Point(25, 50) } // 마커 이미지의 좌표 설정
        );

        // 마커를 생성
        var marker = new kakao.maps.Marker({
            position: coords,
            map: map,
            image: markerImage // 커스텀 마커 이미지 설정
        });

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    }
});
</script>