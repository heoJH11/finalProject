<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css.map">
<!DOCTYPE html>

<html>
<head>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#insertBt").on("click",function(){
		console.log("클릭 했습니다.");
		
	})
});
</script>
<title></title>
</head>
	
	
<body>
	<%-- ${lbrtyBbscttList} --%>
	<div class="card">
		<div class="card-header">
			<h3 class="card-title">자유 게시판</h3>
			<div class="card-tools">
				<div class="input-group input-group-sm" style="width: 150px;">
					<input type="text" name="table_search"
						class="form-control float-right" placeholder="Search">
					<div class="input-group-append">
						<button type="submit" class="btn btn-default">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
			</div>
		</div>

		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr>
						<th>게시글 번호</th>
						<th>게시글 제목</th>
						<th>닉네임</th>
						<th>작성자</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach var="lbrtyBbscttList" items="${lbrtyBbscttList}"
						varStatus="stat">
						<tr onclick="location.href='/lbrtybbsctt/detail?lbrtyBbscttNo=${lbrtyBbscttList.lbrtyBbscttNo}'" style="cursor:hand">
						<td>${stat.count}</td>
						<td>${lbrtyBbscttList.lbrtyBbscttSj}</td>
						<td>${lbrtyBbscttList.userNcnm}</td>
						<td>${lbrtyBbscttList.userId}</td>
						</tr>
						<%-- <tr onclick="location.href='/detail?lbrtyBbscttNo=${lbrtyBbscttList.lbrtyBbscttNo}'" style="cursor:hand">
							<a>${stat.count}</a><br>
							<a>${lbrtyBbscttList.lbrtyBbscttSj}</a><br>
							<a>${lbrtyBbscttList.ncnm}</a><br>
							<a>${lbrtyBbscttList.userId}</a><br>
						</tr><hr> --%>
						<%-- <li data-v-3e43d9c2="" data-v-0cf3b482="" class="feed-item">
						<a data-v-3e43d9c2="" href="/detail?lbrtyBbscttNo=${lbrtyBbscttList.lbrtyBbscttNo}" class="" data-testid="soomgo-life-feed-item">
						<p data-v-746dd3c0="" data-v-3e43d9c2="" data-testid="soomgo-life-topic-name" 
						class="topic-name legacy-typography interface-description gray-500 text-align-left">
						${lbrtyBbscttList.lbrtyBbscttSj}</p>
						<div data-v-3e43d9c2="" class="feed-content">
						<div data-v-3e43d9c2="">
						<section data-v-3e43d9c2="" class="item-wrapper">
						<h3 data-v-746dd3c0="" data-v-3e43d9c2="" class="legacy-typography headline-subhead5 gray-900 text-align-left">${lbrtyBbscttList.lbrtyBbscttSj}</h3>
						<p data-v-746dd3c0="" data-v-3e43d9c2="" class="content legacy-typography interface-body2 gray-500 text-align-left"> 현재 냉장고장 사진과 원하는 스타일 사진 첨부합니다. 냉장고 + 김냉 + 큐커 + 홈바 넣은걸로 시공하면 견적 얼마 정도 나올지 궁금해요~~!! </p>
						</section>
						<p data-v-746dd3c0="" data-v-3e43d9c2="" class="sub-information legacy-typography interface-description gray-500 text-align-left">${lbrtyBbscttList.ncnm}</p>
						</div>
						</div>
						<!---->
						</a>
						</li> --%>
					</c:forEach>
					
				</tbody>
			</table>
			<br>
			
			<br>
		</div>
	
	</div>
	<button type="button" class="btn btn-block btn-secondary btn-sm w-25"
	onClick="location.href='/lbrtybbsctt/insert'">글 쓰기</button>
</body>
</html>
