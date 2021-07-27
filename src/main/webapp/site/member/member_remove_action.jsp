<%@page import="xyz.itwill.dao.MemberDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경어 MEMBER 테이블에
저장된 로그인 사용자의 회원정보를 삭제하고 로그아웃 처리페이지(member_logout_action.jsp)로 이동하는 JSP 문서 --%>
<%-- => 비로그인 사용자일 경우 에러페이지 이동 --%>
<%-- => 전달받은 비밀번호가 로그인 사용자의 비밀번호와 다를 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동 --%>
<%@include file="/site/security/login_check.jspf"%>
<%
	//비정상적인 요청 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값 반환받아 저장
	String passwd = Utility.encrypt(request.getParameter("passwd"));
	
	//전달받은 비밀번호와 로그인 사용자의 비밀번호 비교 같지 않은 경우
	if(!loginMember.getPasswd().equals(passwd)) {
		session.setAttribute("message", "비밀번호가 일치하지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=member&work=password_confirm&action=remove'");
		//out.println("history.go(-1);"); //이전페이지 이동
		out.println("</script>");
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 삭제하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().deleteMember(loginMember.getId());
	
	//로그아웃 처리페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=member&work=member_logout_action'");
	out.println("</script>");
%>