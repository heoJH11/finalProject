<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<script src="/resources/chat/chat.js"></script>
<sidebar class="sidebar">

<script>
console.log("테스트");
</script>
<!-- <div> -->
<!-- <div class="content"> -->
<!-- 	<ul class="menu nav"> -->
<!-- 		<li class="menu1 active">채팅방1</li> -->
<!-- 		<li class="menu2">채팅방2</li> -->
<!-- 		<li class="menu3">채팅방3</li> -->
<!-- 		<li class="menu4">채팅방4</li> -->
<!-- 		<li class="menu5">채팅54</li> -->
<!-- 	</ul> -->
<!-- 	<div class="menu tab"> -->
<!-- 		<div class="menu1 active" style="background: #fcc1c1;"></div> -->
<!-- 		<div class="menu2" style="background : #fcedc1;"></div> -->
<!-- 		<div class="menu3" style="background : #f8fcc1;"></div> -->
<!-- 		<div class="menu4" style="background : #e2fcc1;"></div> -->
<!-- 		<div class="menu5" style="background : #c1fcd7;"></div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- <div class="content"> -->
<!-- <ul class="menu nav"> -->
<!-- 		<li class="menu1 active">채팅방1</li> -->
<!-- 		<li class="menu2">채팅방2</li> -->
<!-- 		<li class="menu3">채팅방3</li> -->
<!-- 		<li class="menu4">채팅방4</li> -->
<!-- 		<li class="menu5">채팅방4</li> -->
<!-- 	</ul> -->
<!-- 	<div class="menu tab"> -->
<!-- 		<div class="menu1 active" style="background: #c1fcf2;"></div> -->
<!-- 		<div class="menu2" style="background : #c1eefc;"></div> -->
<!-- 		<div class="menu3" style="background : #c1d8fc;"></div> -->
<!-- 		<div class="menu4" style="background : #d6c1fc;"></div> -->
<!-- 		<div class="menu5" style="background : #fcc1f1;"></div> -->
<!-- 	</div> -->
<!-- </div> -->
<div id="bottomContent">
	<div id="contentCover">
		<div>
			<a href="/chat/make" onclick="make(event)">방생성</a>
			<div id="roomWrap">
			
					<a href="chat/main" onclick="check(event)">체크</a>
					<div id="roomHeader">전체리스트</div>
						<c:forEach var="roomVO" items="${allRoomList}" varStatus="stat">
							<a
								href="<c:url value='/chat/joinRoom'><c:param name='roomNo' value='${roomVO.roomNo}'/></c:url>"
								onclick="allRoomList(event , '${roomVO.roomNo}')">${roomVO.roomName}
							</a>
							<br>
						</c:forEach>
				</div>
			<div id="roomWrap">
				<div id="myroomlist">
					<div id="roomHeader">내방목록</div>
					<ul>
						<c:forEach var="myRoomVO" items="${myRoomList}" varStatus="stat">
							<br>
							<a
								href="<c:url value='#'><c:param name='roomNo' value='${myRoomVO.roomNo}'/></c:url>"
								onclick="join('${myRoomVO.roomNo}')"> ${myRoomVO.roomName}</a>
						</c:forEach>

					</ul>
				</div>
			</div>
			</div>
		<div id="roomWrap"></div>
	</div>
</div>
</sidebar>