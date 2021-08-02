<%@page import="xyz.itwill.util.Utility"%>
<%@page import="xyz.itwill.dao.BoardDAO"%>
<%@page import="xyz.itwill.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 변경 게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하고 게시글 상세 출력페이지
(board_detail.jsp)로 이동하는 JSP 문서 --%>
<%@include file="/site/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	String subject = Utility.escapeTag(request.getParameter("subject"));
	int status = 0;//전달값이 없는 경우 : 일반글 - 0(초기값)
	if(request.getParameter("secret") != null) {//전달값이 있는 경우 : 비밀글 - 1
		status = Integer.parseInt(request.getParameter("secret"));
	}
	String content = Utility.escapeTag(request.getParameter("content"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	BoardDTO board = new BoardDTO();
	board.setNum(num);//자동 증가값
	board.setSubject(subject);//사용자 입력 전달값(제목)
	board.setContent(content);//사용자 입력 전달값(내용)
	board.setStatus(status);//사용자 입력 전달값(상태 : 일반글 또는 비밀글)
	
	//게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	BoardDAO.getDAO().updateBoard(board);
	
	//게시글 상세 출력페이지 이동 - 페이지 번호와 검색 관련 정보 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+ request.getContextPath()
	+"/site/index.jsp?workgroup=board&work=board_detail&num=" + num + 
	"&pageNum=" + pageNum + "&search=" + search + "&keyword=" + keyword + "';");
	out.println("</script>");
%>