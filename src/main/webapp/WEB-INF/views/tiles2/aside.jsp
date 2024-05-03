<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
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

<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<nav class="sidebar sidebar-offcanvas" id="sidebar" style="padding-top: 60px;
">
  <ul class="nav" style="font-family: 'GmarketSansMedium';">
   
    <li class="nav-item">
      <a href="/manage/notice" class="nav-link">
        <i class="icon-columns menu-icon"></i>
        <span class="menu-title">누네띠네 관리</span>
      </a>
    </li>

    <li class="nav-item">
      <a href="/manage/faq" class="nav-link">
        <i class="icon-columns menu-icon"></i>
        <span class="menu-title">FAQ</span>
      </a>
    </li>

    <li class="nav-item">
      <a href="/manage/oneInqryList" class="nav-link">
        <i class="icon-columns menu-icon"></i>
        <span class="menu-title">문의</span>
      </a>
    </li>

    <li class="nav-item">
      <a href="/manage/resignPro" class="nav-link">
        <i class="icon-columns menu-icon"></i>
        <span class="menu-title">탈퇴</span>
      </a>
    </li>
    
    <!-- 동균 추가 -->
    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
        <i class="icon-layout menu-icon"></i>
        <span class="menu-title">신고</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse hide" id="ui-basic" style="">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link" href="/manage/userdecl">프로 신고</a></li>
          <li class="nav-item"> <a class="nav-link" href="#">회원 신고</a></li>
          <li class="nav-item"> <a class="nav-link" href="/manage/decl">자유게시글 신고</a></li>
          <li class="nav-item"> <a class="nav-link" href="#">후기게시글 신고</a></li>
        </ul>
      </div>
    </li>
    <!-- 동균 추가 끝 -->
  </ul>
  
</nav>