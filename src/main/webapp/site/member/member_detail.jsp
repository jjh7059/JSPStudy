<%@page import="xyz.itwill.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 로그인 사용자의 회원정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 비로그인 사용자가 요청한 경우 에러페이지 이동 - 비정상적인 요청 --%>
<%-- 
<%
	//세션에 저장된 권한 정보 저장
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");

	if(loginMember == null) {//비로그인 사용자인 경우
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
%>
 --%>
 <%-- 외부파일(login_check.jspf)의 코드를 포함하여 처리 --%>
 <%-- include 디렉티브에서는 컨텍스트 디렉토리가 최상위 디렉토리 --%>
 <%@include file="/site/security/login_check.jspf" %>
<style type="text/css">
#detail {
	width: 400px;
	margin: 0 auto;
	text-align: left;
}

#detail li {
	list-style: none;
}

#mypage {
	font-size: 1.1em;
}

#mypage a:hover {
	color: lightgray;
}
</style>
<h1>회원정보</h1>
<div id="detail">
	<ul>
		<li>아이디 = <%=loginMember.getId() %></li>
		<li>이름 = <%=loginMember.getName() %></li>
		<li>이메일 = <%=loginMember.getEmail() %></li>
		<li>전화번호 = <%=loginMember.getMobile() %></li>
		<li>우편번호 = <%=loginMember.getZipcode() %></li>
		<li>기본주소 = <%=loginMember.getAddress1() %></li>
		<li>상세주소 = <%=loginMember.getAddress2() %></li>
		<li>가입날짜 = <%=loginMember.getJoinDate() %></li>
		<li>마지막 로그인 날짜 = <%=loginMember.getLastLogin() %></li>
	</ul>
</div>

<div id="mypage">
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=password_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/site/index.jsp?workgroup=member&work=password_confirm&action=remove">[회원정보탈퇴]</a>&nbsp;&nbsp;
</div>