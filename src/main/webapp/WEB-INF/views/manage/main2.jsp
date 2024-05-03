<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<button onclick="fChg()">여러번 눌러방</button>
    <button onclick="fChgType()">Type Mix</button>
    <!-- 차트 크기는 부모 크기를 조절하면 거기에 맞게 자동으로 맹글어짐-->
    <div style="width:600px;height:400px;border:2px solid black">
        <!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
        <canvas id="myChart"></canvas>
    </div>
    <script>
        // 7개 랜덤데이터 배열 리턴 함수
        function fRanArrData() {
            let ranArr = [];
            for (let i = 1; i <= 7; i++) {
                ranArr.push(Math.round(Math.random() * 70) + 30); // 30~100
            }
            return ranArr;
        }

        // 버튼 눌렀을 때 실행
        function fChg() {
            //값 재 할당!
            mChart.data.datasets[0].data = fRanArrData();
            mChart.data.datasets[1].data = fRanArrData();
            //chart.js에서 가장 중요한 메소드, 다시 그려랑(re rendering)
            mChart.update();
        }

        let isToggle = false;
        function fChgType() {
            // 오직 bar와 line만 믹스 가능(생각해 보면 그냥 이해됨)
            if (isToggle) {
                mChart.data.datasets[0].type = "bar";
                mChart.data.datasets[1].type = "line";
            } else {
                mChart.data.datasets[0].type = "line";
                mChart.data.datasets[1].type = "bar";
            }
            mChart.update();
            isToggle = !isToggle;
        }


        const ctx = document.querySelector('#myChart');

        const mChart = new Chart(ctx, {
            type: 'bar',  // bar, line, pie, doughnut, radar 등등...
            data: {
                labels: ['구두', '스니커즈', '캔버스화', '워커', '운동화', '크록스', '샌들'],
                datasets: [
                    {
                        label: '작년 매출',
                        data: [10, 19, 13, 15, 12, 13, 9],
                        borderWidth: 1,
                    },
                    {
                        label: '올해 매출',
                        data: [9, 14, 10, 19, 22, 11, 16],
                        borderWidth: 1
                    },
                    {
                        label: '목표 매출',
                        data: [14, 12, 14, 15, 16, 15, 18],
                        borderWidth: 1
                    }
                ]
            },
            options: {
            	indexAxis:'y', // 요것만 넣으면 수평차트가 됨!
                scales: {
                    x: {
                        beginAtZero: true
                    }
                }
            }
        });
        // mChart에 담긴 값 확인, 누느로 꼬옥 화긴하장!
        console.log("labels:", mChart.data.labels);
        console.log("labels:", mChart.data.datasets[0]);
        console.log("labels:", mChart.data.datasets[1].label);
        console.log("labels:", mChart.data.datasets[1].data);


    </script>

