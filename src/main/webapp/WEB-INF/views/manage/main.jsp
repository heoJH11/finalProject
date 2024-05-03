<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- 차트 크기는 부모 크기를 조절하면 거기에 맞게 자동으로 맹글어짐-->
    <b>전문분야별 통계</b>
    <div style="width:460px; height:300px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart" style="width: 48%;"></canvas>
    </div>
    ${dongVO}
    <br>
    <b>전문분야별 통계(단위:%)</b>
    <div style="width:460px; height:300px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart2" style="width: 48%;"></canvas>
    </div>
    
    <b>서비스요청 월별 통계</b>
    <div style="width:460px; height:300px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart3" style="width: 48%;"></canvas>
    </div>
    <b>서비스요청 프로 수락 거절 현황(단위:%)</b>
    <div style="width:460px; height:300px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart4" style="width: 48%;"></canvas>
    </div>
    ${dongVO2}
    <br>
    ${dongVO3}
<script>
	const ctx = document.querySelector('#myChart');
	const ctx2 = document.querySelector('#myChart2');
	const ctx3 = document.querySelector('#myChart3');
	const ctx4 = document.querySelector('#myChart4');
	
	
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

