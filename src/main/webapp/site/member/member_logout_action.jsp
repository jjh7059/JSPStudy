<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그아웃 처리 후 메인페이지로 이동하는 JSP 문서 --%>
<%
	//로그아웃 - 세션에 저장된 권한 관련 속성 제거
	//session.removeAttribute("loginMember");
	session.invalidate();
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=product&work=product_list'");
	out.println("</script>");
%>