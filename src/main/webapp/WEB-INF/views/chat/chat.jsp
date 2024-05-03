<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- <link rel="stylesheet" href="/resources/chat/chatFFF/bundle.css"> -->
<!-- <link rel="stylesheet" href="/resources/chat/chatFFF/app.css"> -->
<style>
@font-face {
    font-family: 'TTHakgyoansimKossuyeomR';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_keris@1.0/TTHakgyoansimKossuyeomR.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

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
.btn-white {
/*     --bs-btn-color: #475569; */
    --bs-btn-bg: #ffffff;
    --bs-btn-border-color: #ffffff;
    --bs-btn-hover-color: #2563eb;
    --bs-btn-hover-bg: #bfdbfe;
    --bs-btn-hover-border-color: #bfdbfe;
    --bs-btn-focus-shadow-rgb: 227, 230, 233;
    --bs-btn-active-color: #2563eb;
    --bs-btn-active-bg: #bfdbfe;
    --bs-btn-active-border-color: #bfdbfe;
    --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
    --bs-btn-disabled-color: #475569;
    --bs-btn-disabled-bg: #ffffff;
    --bs-btn-disabled-border-color: #ffffff;
}
.btn-secondary, .wizard > .actions .disabled a {
/*     color: #212529; */
    background-color: #03a9f400;
    /* border-color: #a3a4a5; */
}
.end-0 {
    right: 0 !important;
}
.top-0 {
    top: 0 !important;
}
div{
font-family: 'GmarketSansMedium';
}
.btn{
/* color : #475569; */
}
.btn-danger {
    color: #fff;
    background-color: transparent;
    border-color: transparent;
}
.btn-danger:hover {
    color: #fff;
    background-color: transparent;
    border-color: transparent;
}
.btn-secondary:hover {
    color: #fff;
    background-color: transparent;
    border-color: transparent;
}
.bg-primary2 {
    --bs-bg-opacity: 1;
    background-color: rgba(37, 99, 235, var(--bs-bg-opacity)) !important;
}
.tyn-quick-chat-toggle {
    position: fixed;
    height: 4rem;
    width: 4rem;
    right: 1.5rem;
    bottom: 1.5rem;
    z-index: 999;
    border-radius: 50%;
/*     padding: 1rem; */
    border: 2px solid #ffffff;
    background: #dbeafe;
    box-shadow: 0 0 0 1px #bfdbfe;
    transition: 0.3s ease 0.5s;
    opacity: 1;
    transform: translateY(0);
}
.tyn-reply-item {
  display: table-cell;
  vertical-align: middle;
}
.tyn-quick-chat-box {

	display: flex;
    flex-direction: column;
    background: #eff6ff;
    justify-content: stretch;
    position: fixed;
    right: 1.5rem;
    bottom: 1.5rem;
    height: 32rem;
    max-height: calc(100% - 3rem + var(--appbar-height)* -1);
    width: 20rem;
    z-index: 999;
    border-radius: 0.5rem;
    border: 2px solid #ffffff;
/*     transform: translateY(calc(100% + 4rem)); */
/*     opacity: 0; */
    transition: 0.5s ease 0.3s;
    box-shadow: 0 0 0 2px #4b49ac;
}
.bg-light {
    --bs-bg-opacity: 1;
    background-color: rgb(226 232 240), var(--bs-bg-opacity)) !important;
}
.tyn-quick-chat-form {
	display: flex;
    align-items: flex-end;
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	background-color: #ffffff;
	padding: 10px;
	border-top: 1px solid #dddddd;
}
::-webkit-scrollbar {
/*     display: none; */
}
/* .alert { */
/*     width: 100%; */
/* } */
.alert-primary {
color: #272659;
background-color: #dbdbee00;
border-color: #dbdbee00;
}
.tyn-reply {
    --content-gap-x: var(--bs-body-gap-x);
    --content-gap-y: 0.2rem;
    --content-sap-y: 0.375rem;
    --reply-bg: var(--bs-white);
    --reply-text: var(--bs-gray-500);
    --reply-anchor-text: #60a5fa;
    --reply-anchor-hover: #2563eb;
    --outgoing-message-bg: #2563eb;
    --outgoing-message-text: #ffffff;
    --radius-large: 0.5rem;
    --radius-small: 0.25rem;
    --avatar-gap: 0.75rem;
    display: flex;
    flex-direction: column-reverse;
}
.tyn-reply-text {
    font-size: 0.833rem;
    padding: 0.5rem 0.75rem;
/*     border-radius: 0.5rem; */
	border-radius: 15px !important;
    color: var(--reply-text);
    background: var(--reply-bg);
}
.tyn-reply-join{
}
.tyn-reply-group {
  display: flex;
  flex-direction: column; /* 수직 방향으로 정렬 */
}
.incoming .tyn-reply-text {
    color: #64748b;
    background: #ffffff
}
:root {
    --bs-body-gap-x: 1.25rem;
    --bs-size-xs: 1.5rem;
/*     --bs-size-sm: 5px; */
}
.enter-message {
    font-weight: bold;
    color: blue;
}
#msgArea4{
	border-radius: 15px;
	border: 0;
	outline: none;
	height: 30px;
	font-family: GmarketSansMedium;
}
#titleMT{
font-family: 'GmarketSansMedium';
}
.name{
font-family: 'GmarketSansMedium';
}
</style>
<script>
$(document).ready(function(){

	var currentScreen = "A";

	var chatList = [];
	loadRoomList();

	let memSession = "${memSession}";
	let proSession = "${proSession}";
	var isCHK = false;

	console.log("memSession22 : " + memSession);
	console.log("proSession22 : " + proSession);
	
	if( (memSession == null || memSession =="") && (proSession == null || proSession == "")){

		console.log("memSession22 : " + memSession);
		console.log("proSession22 : " + proSession);
		
		let str = "";
		str += '<div id="loginCHK" style="font-family:GmarketSansMedium; font-size : 1.25rem;">'+"로그인 후 이용해 주세요!" + '</div>';
		document.getElementById('check').innerHTML = str;
		
	}
	
	const list = document.querySelector("#list");
	const expired = document.querySelector("#expired");
	const update = document.querySelector("#update");
	const msgArea3 = document.querySelector("#msgArea3");
	
	var urlParams = new URLSearchParams(window.location.search); // URL 매개변수를 가져옵니다.
	var isListReload = urlParams.has('list_reload'); // 'list_reload' 매개변수가 있는지 확인합니다.
	// 페이지 로드 시 실행될 코드
	$("#myList").show(); // 리스트를 보여줍니다.
	$("#scrolling").hide(); // 스크롤을 숨깁니다.
	currentScreen = "B"; // 현재 스크린을 B로 설정합니다.
	$("#char_form").hide()

	// 리스트 버튼 클릭 시 실행될 코드
	list.addEventListener("click", function() {
		// 페이지 리로드 코드
		console.log("isCHK ::11 " + isCHK)
		document.location.reload(true); // 리스트 버튼 클릭시에만 페이지 리로드합니다.
	});
	
console.log("currentScreen :: " + currentScreen );
	/* 모임 마감 임박 정렬 */	
	expired.addEventListener("click", function() {
	    
	   	console.log("storyData 오래된순 버튼:: " + chatList["tdmtngDt"]);
	   	
	   	chatList.sort((a, b) => new Date(a.tdmtngDt) - new Date(b.tdmtngDt));
		
	   	displaySortedData(chatList);
		
	});// end nowCnt -> 오래된순 정렬
	
	function displaySortedData(resultData) {
	    let str = "";

	    str += '<div id="expiredMSG" style="font-family:GmarketSansMedium">'+'&nbsp;&nbsp;&nbsp;&nbsp;' + "서두르세요! 얼마 남지 않았어요!" + '</div>';
	    console.log("resultData.length " + length);

	    for (let i = 0; i < resultData.length; i++) {

	        let dayCHK = resultData[i].tdmtngDt.substring(8,10) - getDay().substring(8,10);

	        if( dayCHK >= 0 && dayCHK < 3 ){
	            console.log("dayCHK :: " + dayCHK);

	            let chatDay = resultData[i];

	            str += '<div class="tyn-media-group">';
	            str += '<div class="tyn-media tyn-size-lg">';
	            str += '<div class="tyn-media-col">';
	            str += '<h6 class="name" style="font-family:GmarketSansMedium"><br><a style="color : black; font-family:GmarketSansMedium" href="#" onclick="myRoom(event, \'' + chatDay.tdmtngNo + '\')" class="roomLink" data-tdmtngNo="' + chatDay.tdmtngNo + '">';
	            str += "<img src='/resources/images/제목.png' alt='이미지' style='width : 30px; height : 30px;'>"+ "  " + chatDay.tdmtngNm + '</a></h6>';
	            str += "<h6><img src='/resources/images/날짜.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>" +chatDay.tdmtngCreateDt.substring(0 , 9 + 1) + '</h6>';
	            str += "<h6><img src='/resources/images/만나요.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>"+chatDay.tdmtngDt.substring(0 , 15 + 1)  + '</h6>';
	            str += '</div>';
	            str += '</div>';
	            str += '</div>';
	        }
	        else {
	            $("#expiredMSG").remove();
	            document.getElementById('myList').innerHTML = ""; // Clear the content if conditions aren't met
	            break;
	        }
	    }
   		document.getElementById('myList').innerHTML += str; // Append the content to the element
	    applyStylesToNewItems();
	}


	function loadRoomList() {
		// 내방 목록 출력
		
		$("#msgArea3").empty();
		$("#chat_form").hide();
		$("#expired").show();
// 		$("#myList").show();
// 		$("#scrolling").hide();
		$.ajax({
			url: "/todayMeeting/myList",
			type: "post",
			dataType: "json",
			success: function (result) {
				
				var roomList = result;
				var str = '';
				
				$.each(roomList, function (index, TdmtngVO) {
					console.log("TdmtngVO :: " + TdmtngVO.tdmtngDt);
					console.log("tdmtngCreateDt :: " + TdmtngVO.tdmtngCreateDt);
					str += '<div class="tyn-media-group">';
					str += '<div class="tyn-media tyn-size-lg">';
					str += '<div class="tyn-media-col">';
					str += '<h6 class="name"><br><a style="color : black; font-family:GmarketSansMedium" href="#" onclick="myRoom(event, \'' + TdmtngVO.tdmtngNo + '\')" class="roomLink" data-tdmtngNo="' + TdmtngVO.tdmtngNo + '">';
					str += "<img src='/resources/images/제목.png' alt='이미지' style='width : 30px; height : 30px;'>"+ "  " + TdmtngVO.tdmtngNm + '</a></h6>';
					str += "<h6><img src='/resources/images/날짜.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>" +TdmtngVO.tdmtngCreateDt.substring(0 , 9 + 1) + '</h6>';
					str += "<h6><img src='/resources/images/만나요.gif' alt='이미지' style='width : 40px; height : 40px; border-radius : 100%'>"+TdmtngVO.tdmtngDt.substring(0 , 15 + 1)  + '</h6>';
					str += '</div>';
					str += '</div>';
					str += '</div>';
					
					chatList.push(TdmtngVO);
				});
				$('#myList').html(str);
			},
			error: function (xhr, status, error) {
				console.error('Error fetching room list:', status, error);
			}
		});
	}
});
//	     $("#scrolling").hide();
	function getTime() {
		let day = new Date();
	
		let year       = day.getFullYear();
		let month      = ('0' + (day.getMonth() + 1)).slice(-2);
		let date       = ('0' + day.getDate()).slice(-2);
	
		let hour       = ('0' + day.getHours()).slice(-2);
		let minutes    = ('0' + day.getMinutes()).slice(-2);
		let secounds   = ('0' + day.getSeconds()).slice(-2);
	
		let timeTT     = year + "." + month + "." + date;
		let timeString = year + month + date + hour + minutes + secounds;
	
		return timeString.trim();
	}
	function getDay() {
	
		let day = new Date();
	
		let year     = day.getFullYear();
		let month    = ('0' + (day.getMonth() + 1)).slice(-2);
		let date     = ('0' + day.getDate()).slice(-2);
		
		let hour     = ('0' + day.getHours()).slice(-2);
		let minutes  = ('0' + day.getMinutes()).slice(-2);
		let secounds = ('0' + day.getSeconds()).slice(-2);
	
		let timeTT   = year + "." + month + "." + date;
	
		return timeTT.trim();
	}
	var currentScreen;
	function myRoom(event, tdmtngNo) {
		event.preventDefault();

		$("#myList").hide();
		$("#scrolling").show();
		$("#chat_form").show();
		console.log("myRoom currentScreen : " + currentScreen);
	
		$.ajax({
			url: "/todayMeeting/join?tdmtngNo=" + tdmtngNo,
			type: "post",
			dataType: "json",
			success: function (result) {
				
				console.log("result22 : " + result);
				
			let str  = '';
				str += "<div style='display : flex; font-family : GmarketSansMedium; margin : 20px 40px; 40px; 100px;'>";
				str += result.tdmtngNm + "<br>";
// 				str += "생성일 "+result.tdmtngCreateDt.substring(5, 10) + "<br>";
// 				str += "만나요 "+result.tdmtngDt.substring(5, 16) + "<br>";
// 				str += "</div>";
// 				str += "<div>"
// 				str += "<img style='width : 65px; height : 65px; border-radius : 100%;' src='"+result.proflPhoto +"'>"
// 				str += "<a>"+ result["userInfo"].mberProflPhoto + "</a>";
				str += "</div>";

				$("#listTT").append(str);
				
				let userNcnm = "";
				
				for(let i = 0 ; i < result["userInfo"].length ; i++){
					if(result.userId == result["userInfo"][i].userId){
						userNcnm = result["userInfo"][i].userNcnm;
					}
				}
				chat(tdmtngNo, result.userId , userNcnm);
			}
		})
	}

	var currentScreen;
	function chat(tdmtngNo, userId , userNcnm) {
		
		var sockJs = new SockJS("/stomp/chat");
		var stomp = Stomp.over(sockJs);
		$("#expired").hide();
		messageCheck(tdmtngNo);

		let str = '';
		stomp.connect({}, function () {

		console.log("STOMP Connection : STOMP Connection");
				
		stomp.subscribe("/sub/chat/room/" + tdmtngNo, function (chat) {
			
			$("#enterTime").remove();
			$("#enterMSG").remove();

			<% /* 구독중인 방에서 채팅 확인 (받는영역 , 메세지 표시 영역) */ %>
			var content = JSON.parse(chat.body);
			var msgNo = content.tdmtngChSpMsgNo;
			var roomNo = content.tdmtngNo;
			var message = content.tdmtngChSpMsgCn;
			var writer = content.userId;
			var date = content.tdmtngChSpMsgTrnsmisDt;
			var isEnterMessage = content.messageType;
			var proflPhoto = content.proflPhoto;
			var userNcnm = content.userNcnm;

			let dateStr = date.substring(8,10) + ":" + date.substring(10,12) + ":" + date.substring(12,14);
			
			let time;
			
			if(dateStr.substring(0,2) >= 12){
				
				
				if(dateStr.substring(0,2) == 12){

					time  = "오후 " + 12 + ":" + date.substring(10,12); 
					
				} else {
					
					time  = "오후 " + (date.substring(8,10) - 12)+ ":" + date.substring(10,12); 
				}
			
			} else {
				
				console.log("dateStr : " + dateStr.substring(0,2));
				
				time = "오전 " + date.substring(8,10)+ ":" + date.substring(10,12) + "  ";
				
				console.log("time : " + time);
				
			}
			
		    if (isEnterMessage === "ENTER") {

		    	str +=  "<div id='enterTime' style='text-align : center;'>" + time + "<br />";
				str += 	"<div id='enterMSG' style='text-align : center;'>" + message + "</div>";
				str +=	"</div>";
			    
		    	$("#msgArea").append(str);
		    }
			
		    else if(isEnterMessage === "MESSAGE") {
		    	
				/**/
				
				if (writer === userId) {
					str += "<div class='tyn-reply-item outgoing'>";
					str += "<div class='tyn-reply-group' style='flex-direction: column;'>";
					str += 			"<div style='display : flex; justify-content: space-between;'>";
					str += 				"<div style='align-content : center'>" + time + dateStr.substring(9, 14) + '&nbsp;'+"</div>";
					str += 					"<div class='tyn-reply-text text-right'>" + message + "</div>";
					str += 				"</div>";
				    str += 		"</div>";
				    str += "</div>";

				    $("#msgArea").append(str);
				    
				} else {
					
						str += 		"<div class='tyn-reply-item incoming'>";
						str += 			"<div class='tyn-reply-avatar'>";
						str += 				"<div class='tyn-media tyn-size-md tyn-circle'>";
						str += 				"<img src='" + proflPhoto + "' alt='이미지' style='width: 55px; height: 55px;'>";
						str += 				"</div>";
						str += 			"<div style='display: flex; flex-direction: column;'>";
						str += 				"<div style='display: flex; justify-content: space-between;'>";
						str += 					"<div class='tyn-reply-text' style='background : transparent;'>" + userNcnm + "</div>";
						str += 				"</div>";
						str += 			"<div style='display: flex; justify-content: space-between;'>";
						str += 				"<div class='tyn-reply-text text-left'>" + message + "</div>";
						str += 				"<div style='align-content : center'>" +'&nbsp;'+ time + "  </div>";
						str += 			"</div>";
						str += 			"</div>";
						str += 			"</div>";
						str += 		"</div>";
						
				    $("#msgArea").append(str);
				}
		    }
	         // 새로운 메시지 추가
// 	        
			$('#scrolling').scrollTop($('#scrolling')[0].scrollHeight);
				
			}); // end stomp.subscribe
			
				let date = getTime();
				
			setTimeout(function() {
				// 메시지 전송
			    stomp.send('/pub/chat/enterK', {},
			    		JSON.stringify({tdmtngNo: tdmtngNo, userNcnm : userNcnm , userId: userId , tdmtngChSpMsgTrnsmisDt : date})
			    		);
				}, 400);
			
			$('#scrolling').scrollTop($('#scrolling')[0].scrollHeight);
		
			}); //end stomp
			<%/** 보내는 영역 */	%>
			$('#tynQuickChatInput').on('keydown', function(e) {
			  
				if (e.key === 'Enter') {
			    
		            e.preventDefault();
					e.stopPropagation(); // 이벤트 전파 중지
	
					var date = getTime();
			        var msg = $(this).text().trim();
			        
			        stomp.send('/pub/chat/message', {},
			            JSON.stringify({ tdmtngNo: tdmtngNo, tdmtngChSpMsgCn: msg, tdmtngChSpMsgTrnsmisDt: date, userId: userId , userNcnm : userNcnm })
			        );
					$("#enterTime").remove();
					$("#enterMSG").remove();
			        
			        $(".tyn-reply-text text-right").remove();
			        $(this).text(''); // 입력창 비우기
			    }
			}); //end keydown
		}
		
// 	let lastScrollTop; // 스크롤 위치 저장하는 전역변수
	
	function messageCheck(tdmtngNo) {
		
	    $.ajax({
	        url: "/todayMeeting/msgList",
	        type: "POST",
	        data: { tdmtngNo: tdmtngNo},
	        dataType: "json",
	        success: function(result) {
	            let isMonth = false;
	            let previousDate = null;
	            
	            let joinRoom = result["joinRoom"];
	            let msgList = result["msgList"];
	
	            console.log("joinRoom : ", joinRoom);
	            console.log("msgLost : ", msgList);
	            displayChatMessages(result);
	            
			$('#scrolling').scrollTop($('#scrolling')[0].scrollHeight);
			
	    	}
	        
	    });
	    
	    // 스크롤 이벤트 핸들러
		    $('#scrolling').on('scroll', function() {
		        var scrollingElement = $(this)[0];
		        var scrollTop = scrollingElement.scrollTop;
		        lastScrollTop = scrollTop;
		    });
		    
		    // 스크롤 가장 아래로 이동
		$('#scrolling').scrollTop($('#scrolling')[0].scrollHeight);
	}
<% /* 채팅 메시지 출력 */ %>
function displayChatMessages(result) {
	
	console.log("result[joinRoom] :: " + result["joinRoom"]);
	console.log("result[msgList] :: " + result["msgList"]);
	
	let isMonth = false; // 이전 날짜 출력 여부
	let previousDate = null;
	
	console.log("result : ", result);

	let joinRoom = result["joinRoom"];
	let msgList = result["msgList"];

	console.log("joinRoom : ", joinRoom);
	console.log("msgList : ", msgList);
	
	var profile;
	for (let i = 0; i < msgList.length; i++) {
		
			let msgData = {
				roomNo      : msgList[i]["tdmtngNo"],
				userId      : msgList[i]["userId"],
				userNcnm    : msgList[i]["userNcnm"],
				msgNo       : msgList[i]["tdmtngChSpMsgNo"],
				msgCont     : msgList[i]["tdmtngChSpMsgCn"],
				msgSendDate : msgList[i]["tdmtngChSpMsgTrnsmisDt"],
			};

			console.log("msgData " + msgData);
			
			let str = '';
	
			let date         = msgData.msgSendDate.substring(0, 8).trim();
			
			let	currentDate  = msgData.msgSendDate.substring(0, 4).trim() + "-";
				currentDate	+= msgData.msgSendDate.substring(4, 6).trim() + "-";
				currentDate	+= msgData.msgSendDate.substring(6, 8).trim();
			
			let dayWeek = (new Date(currentDate)).getDay();
	
			var weekdays = ['일', '월', '화', '수', '목', '금', '토'];
	
			let dayWeekString = weekdays[dayWeek];
	
				currentDate  = msgData.msgSendDate.substring(0, 4).trim() + "년 ";
			    currentDate	+= msgData.msgSendDate.substring(4, 6).trim() + "월 ";
			    currentDate	+= msgData.msgSendDate.substring(6, 8).trim() + "일 ";
	
			    currentDate	+= dayWeekString + "요일";
			if (currentDate != previousDate) {
				str += "<div class='col-12 text-center' id='weekDay'>"+ currentDate +"</div>";
				previousDate = currentDate;
			}
		//
		applyStylesToNewItems('#weekDay');
		//
		
		let time = "";
		let dateStr = msgData.msgSendDate;
		
		if(dateStr.substring(9,11) >= 12){

			time  = "오후 " + (dateStr.substring(9,11) - 12) + ":" + dateStr.substring(12,14);
			
		} else {
	
			time = "오전 " + (dateStr.substring(9,11)) + ":" + dateStr.substring(12,14);
		}

		$("#msgArea3").empty();

		if (msgData.userId === joinRoom.userId) {
			
            str += "<div class='tyn-reply tyn-reply-quick'>";
            str += 		"<div class='tyn-reply-item outgoing'>";
            str += 			"<div class='tyn-reply-group' style='flex-direction: column;'>";
            str += 				"<div style='display : flex; justify-content: space-between;'>";
            str += 					"<div style='align-content : center'>" + time + '&nbsp;' + "</div>";
            str += 					"<div class='tyn-reply-text text-right'>" + msgData.msgCont + "</div>";
            str += 				"</div>";
            str += 			"</div>";
            str += 		"</div>";
            str += "</div>";

        } else {
            str += "<div class='tyn-reply tyn-reply-quick'>";
            str += 		"<div class='tyn-reply-item incoming'>";
            str += 			"<div class='tyn-reply-avatar'>";
            str += 				"<div class='tyn-media tyn-size-md tyn-circle'>";
            str += 					"<img src='" + msgList[i]["proflPhoto"] + "' alt='이미지' style='width: 55px; height: 55px;'>";
            str += 				"</div>";
            str += 			"<div style='display: flex; flex-direction: column;'>";
            str += 		"<div style='display: flex; justify-content: space-between;'>";
            str += 		"<div class='tyn-reply-text' style='background : transparent;'>" + msgList[i]["userNcnm"] + "</div>";
            str += "</div>";
            str += "<div style='display: flex; justify-content: space-between;'>";
            str += 					"<div class='tyn-reply-text text-left'>" + msgData.msgCont + "</div>";
            str += 					"<div style='align-content : center'>" + '&nbsp;' + time + "  </div>";
            str += 				"</div>";
            str += 			"</div>";
            str += 		"</div>";
            str += "</div>";

        } //end if
            $("#msgArea").append(str);
	}//end for
	
}//end displayChatMessages
	function applyStylesToNewItems(result) {

	let newItems = document.querySelectorAll(result);
	
		   if(result == "#weekDay"){
		   
			   newItems.forEach(function(item) {
				   item.style.overflow = 'hidden';
				   item.style.border = '0px';
				   item.style.borderRadius = '15px';
				   item.style.outline = 'none';
				   item.style.height = '30px';
				   item.style.fontFamily = 'GmarketSansMedium';
				
			    });
		   }
		}
</script>
<div class="tyn-quick-chat" id="tynQuickChat">
	<button class="tyn-quick-chat-toggle js-toggle-quick">
		<svg viewBox="0 0 43 40" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path
				d="M37.2654 14.793C37.2654 14.793 45.0771 20.3653 41.9525 29.5311C41.9525 29.5311 41.3796 31.1976 39.0361 34.4264L42.4732 37.9677C42.4732 37.9677 43.3065 39.478 41.5879 39.9987H24.9229C24.9229 39.9987 19.611 40.155 14.8198 36.9782C14.8198 36.9782 12.1638 35.2076 9.76825 31.9787L18.6215 32.0308C18.6215 32.0308 24.298 31.9787 29.7662 28.3333C35.2344 24.6878 37.4217 18.6988 37.2654 14.793Z"
				fill="#60A5FA"></path>
			<path
				d="M34.5053 12.814C32.2659 1.04441 19.3506 0.0549276 19.3506 0.0549276C8.31004 -0.674164 3.31055 6.09597 3.31055 6.09597C-4.24076 15.2617 3.6751 23.6983 3.6751 23.6983C3.6751 23.6983 2.99808 24.6357 0.862884 26.5105C-1.27231 28.3854 1.22743 29.3748 1.22743 29.3748H17.3404C23.4543 28.7499 25.9124 27.3959 25.9124 27.3959C36.328 22.0318 34.5053 12.814 34.5053 12.814ZM19.9963 18.7301H9.16412C8.41419 18.7301 7.81009 18.126 7.81009 17.3761C7.81009 16.6261 8.41419 16.022 9.16412 16.022H19.9963C20.7463 16.022 21.3504 16.6261 21.3504 17.3761C21.3504 18.126 20.7358 18.7301 19.9963 18.7301ZM25.3708 13.314H9.12245C8.37253 13.314 7.76843 12.7099 7.76843 11.96C7.76843 11.21 8.37253 10.6059 9.12245 10.6059H25.3708C26.1207 10.6059 26.7248 11.21 26.7248 11.96C26.7248 12.7099 26.1103 13.314 25.3708 13.314Z"
				fill="#2563EB"></path>
		</svg>
		<span class="badge bg-primary2 top-0 end-0 position-absolute rounded-pill"></span>
	</button>
	<div class="tyn-quick-chat-box" style="width: 400px;">
		<div class="tyn-reply tyn-reply-quick" id="tynQuickReply" style="overflow: auto">
			<div class="tyn-reply-item outgoing" id="myList" style="overflow: auto"></div>
				<div class="tyn-reply-group" id="scrolling" style="overflow: auto;">
<!-- 					<div class="tyn-reply-bubble"> -->
						<div class="tyn-reply-text">
							<div id="msgArea"></div>
							<div id="msgArea3" class="tyn-reply-join" style="text-align:center; background-color: transparent;">
							</div>
							<div id="msgArea4" style="text-align:center; background-color: transparent;">
							</div>
							<br>
						</div>
<!-- 					</div> -->
			</div>
			<br />
		<div>
			<br />
			<div class="tyn-quick-chat-form" id="chat_form">
				<div class="tyn-chat-form-input bg-light" id="tynQuickChatInput" contenteditable=""></div>
				<ul class="tyn-list-inline me-n2 my-1">
					<li>
						<button id="msg" class="btn btn-icon btn-white btn-sm btn-pill">
							<!-- send-fill -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
								class="bi bi-send-fill" viewBox="0 0 16 16">
								<path
									d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z">
								</path>
							</svg>
						</button>
					</li>
				</ul>
			</div>
		</div>
		<br>
		</div>
		<div id = "check" style="text-align: center">
		<br>
    <div>
    <!-- 첫 번째 아이콘 -->
<!--     <button class="btn btn-danger btn-sm btn-icon top-0 end-0 position-absolute rounded-pill translate-middle js-toggle-quick"> -->
<!--         x-lg -->
<!--         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16"> -->
<!--             <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"></path> -->
<!--         </svg> -->
<!--     </button> -->
<!--     <button id="update" class="btn btn-secondary btn-sm btn-icon top-0 end-3 position-absolute rounded-pill translate-middle" style="right: 120px; border-color: transparent;"> -->
<!--         <img src="/resources/images/업데이트.png" alt="List Icon" style="width: 36px;"> -->
<!--     </button> -->
    <!-- 두 번째 아이콘 -->
    <div id="listTT" class="top-0 end-5 position-absolute rounded-pill translate-middle" style="border-color: black;"></div>
    <button id="list" class="btn btn-secondary btn-sm btn-icon top-0 end-1 position-absolute rounded-pill translate-middle" style="right: 40px; border-color: transparent;">
        <img src="/resources/images/리스트.gif" alt="List Icon" style="width: 40px; background-color: #eff6ff; border-radius : 100%;">
    </button>
    <button id="expired" class="btn btn-secondary btn-sm btn-icon top-0 end-2 position-absolute rounded-pill translate-middle" style="right: 80px; border-color: transparent;">
        <img src="/resources/images/마감임박.gif" alt="List Icon" style="width: 40px; background-color: #eff6ff; border-radius : 100%;">
    </button>
    <button id="exit" class="btn btn-danger btn-sm btn-icon top-0 end-0 position-absolute rounded-pill translate-middle js-toggle-quick" style="right: 40px; border-color: transparent;">
        <img src="/resources/images/종료.png" alt="List Icon" style="width: 36px; border-radius : 100%;">
    </button>
</div>


	</div>
</div>
</div>
