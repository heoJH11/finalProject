<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.chat-message {
/*         max-width: 50%; */
        word-wrap: break-word; /* 긴 단어가 너비를 벗어나면 줄 바꿈 */
        word-break: break-all; /* 단어가 너비를 벗어나도 줄 바꿈 */
}
</style>
<script>
function getTime(){
	let day = new Date();
	
	let year  = day.getFullYear();
	let month    = ('0'+ (day.getMonth()+1)).slice(-2);
	let date     = ('0'+ day.getDate()).slice(-2);

	let hour     = ('0'+ day.getHours()).slice(-2);
	let minutes  = ('0'+ day.getMinutes()).slice(-2);
	let secounds = ('0'+ day.getSeconds()).slice(-2);
	
//		var timeString = year+"년 " + month+"월 " + date+"일 " + hour+"시 " + minutes+"분 " + secounds+"초 ";
//		console.log("day : " + timeString);
	
	let timeTT = year+"/"+month+"/"+date;
	let timeString = year+month+date+hour+minutes+secounds;
	
	return timeString;

function getTime2(){
	
	let day = new Date();
	
	let year = day.getFullYear();
	let month = ('0'+ (day.getMonth()+1)).slice(-2);
	let date = ('0'+ day.getDate()).slice(-2);

	let hour =('0'+ day.getHours()).slice(-2);
	let minutes = ('0'+ day.getMinutes()).slice(-2);
	let secounds = ('0'+ day.getSeconds()).slice(-2);
	
	let timeTT = year+"/"+month+"/"+date;
	
	return timeTT.trim();
}
console.log("myRoomChat" , "${myRoomChat}");
// window.onload = function() {
//     var element = document.getElementById("chatMessagesDiv"); // 스크롤할 요소 선택
//     window.scrollBy(10, 50)
//     element.scrollIntoView(); // 요소가 보이도록 스크롤
// };
</script>
    <div id="chatMessages">
    </div>
<script>
$(document).ready(function(){
	var myRoom = ${myList};
 	var roomMessageJson = ${roomMessageJson};
 	var roomNo = myRoom["roomNo"];
	var userId = myRoom["userId"];
	console.log("roomMessageJson" , roomMessageJson);

	var sockJs = new SockJS("/stomp/chat");
 	var stomp = Stomp.over(sockJs);
	
 	stomp.connect({}, function() {
 		
	console.log("STOMP Connection");
	
	stomp.subscribe("/sub/chat/room/" + roomNo, function(chat) {
		
	    var content = JSON.parse(chat.body);
	    var roomNo  = content.roomNo;
	    var message = content.msgCont;
	    var writer = content.userId;
	    var date = content.msgSendDate;
	    
	    let str = '';
	    
		console.log("content : " , content);
		var newChatMessageDiv = document.createElement("div");
		
	    if (writer === userId) {
	        str += "<div class='col-6'>";
	        str += "<div class='alert alert-secondary'>";
	        str += "<b>" + writer + " : " + message + "</b>";
	        str += "</div></div>";
	    } else {
// 	    	console.log("유저아이디와 다를때" , userId);
	        str += "<div class='col-6'>";
	        str += "<div class='alert alert-warning'>";
	        str += "<b>" + writer + " : " + message + "</b>";
	        str += "</div></div>";
	    }
	    $("#msgArea").append(str)
	    $("#theme-settings-sub").append(str);
	});
	console.log("테스트" , roomNo)
	  stomp.send('/pub/chat/enter', {},
			  JSON.stringify({ roomNo: roomNo, userId:userId})
			  );
	});
	$("#msg").keydown(function(key) {
	  var msg = document.getElementById("msg");
	  
	  let str = '';
	  var newChatMessageDiv = document.createElement("div");
	  var date = getTime();
	  
	  if (key.keyCode == 13) {
	      stomp.send('/pub/chat/message', {},
	          JSON.stringify({ roomNo: roomNo, msgCont: msg.value, msgSendDate: date , userId:userId , msgCheck:"T" })
	      );
	      console.log('Enter');
	      msg.value = '';

         $("#msgArea").append(str);
	     $("#theme-settings-sub").append(str);
         $("#msgArea").append(msg.value);
	  }
	});
});
</script>