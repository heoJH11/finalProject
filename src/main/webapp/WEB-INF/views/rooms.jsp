<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	
// $(document).ready(function(){

// 	let roomName = $("#roomName").val();
// 	let username = $("#username").val();
// 	console.log("roomName : " + roomName);
//     if(roomName != null)
// //         alert(roomName + "방이 개설되었습니다.");

//     $(".btn-create").on("click", function (e){
//         e.preventDefault();

//         var name = $("input[name='name']").val();
//         var name = $("#roomName").val();

//         if(roomName == "")
//             alert("Please write the name.")
//         else
//             $("form").submit();
//     });

// });
</script>
<body>
<%-- ${chatRoomList} --%>

<%-- ${ChatRoomVO} --%>
<!-- <div class="container"> -->
<!--     <div> -->
<!--         <ul> -->
<%--             <c:forEach var="ChatRoomVO" items="${ChatRoomVO}" varStatus="stat"> --%>
<!--                 <li> -->
<%--                 <a href="<c:url value='/chat/room'> --%>
<%--                 <c:param name='roomNo' value='${ChatRoomVO.roomNo}'/></c:url>">${ChatRoomVO.roomName} --%>
<!--                 </a> -->
<!--                 </li> -->
<%--             </c:forEach> --%>
<!--         </ul> -->
<!--     </div> -->
<!-- </div> -->
<!-- <!-- <form action="/chat/room" method="post"></form> --> -->
<%-- <form action="<c:url value='/chat/room'/>" method="post"> --%>
<!--      <input type="text" name="name" id="roomName" class="form-control"> -->
<!--      <input type="hidden" name="username" id="username" class="form-control"> -->
<!--     <button onclick="create()" class="btn btn-secondary">개설하기</button> -->
<!-- </form> -->
<!--             <a href="/chat/roomCreate" >테스트</a> -->
</body>
</html>