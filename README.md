# 전문가 매칭 시스템
+ 주요 기능
1. 공통 : 프로 찾기, 게시판, 채팅, 모임
2. 회원 : 서비스 사전 문의 및 요청, 원데이 클래스 이용, 리뷰 및 후기
3. 프로 : 서비스 사전 문의 및 요청 처리, 원데이 클래스 등록 및 관리, 이달의 프로
4. 관리자 : 홈페이지 관리, 이용자 관리, 신고 관리
---
+ 개발 기간 : 2024.02 ~ 2024.04
+ 개발 인원 : 7명
+ 개발 환경
1. 언어 : Java(jdk 1.8), JavaScript, Ajax, HTML5, CSS3
2. 서버 : Apache Tomcat 8.5
3. 형상관리 : SVN 4.3
4. 프레임워크 : eGovFrameDev-3.10, Mybatis 3.5
5. DB : Oracle 11g
---
+ 담당 파트

  <후기 게시판> 조회, 등록, 수정, 삭제

  kr.or.ddit.board.review_board.controller

  kr.or.ddit.board.review_board.service

  kr.or.ddit.board.review_board.service.impl

  kr.or.ddit.board.review_board.mapper

  kr.or.ddit.vo.AftusBbscttVO

  kr.or.ddit.vo.SprviseAtchmnflVO

  reviewBoard/index.jsp

  reviewBoard/create.jsp

  reviewBoard/detail.jsp

  <모임 게시판> 조회, 등록, 수정, 삭제

  kr.or.ddit.board.todaymeeting.controller

  kr.or.ddit.board.todaymeeting.service

  kr.or.ddit.board.todaymeeting.service.impl

  kr.or.ddit.board.todaymeeting.mapper

  kr.or.ddit.vo.TdmtngVO

  kr.or.ddit.vo.TdmtngPrtcpntVO

  todayMeeting/index.jsp

  todayMeeting/create.jsp

  todayMeeting/detail.jsp
