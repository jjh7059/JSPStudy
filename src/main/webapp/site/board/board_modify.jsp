<%@page import="xyz.itwill.dao.BoardDAO"%>
<%@page import="xyz.itwill.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 입력태그의 
초기값으로 설정하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러페이지로 이동 --%>
<%-- => [글변경]을 클릭한 경우 게시글 변경 처리페이지(board_modify_action.jsp)로 이동 - 입력값 전달 --%>
<%@include file="/site/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 처리
	if(request.getParameter("num") == null) {
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
	
	//글번호를 전달받아 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	BoardDTO board =  BoardDAO.getDAO().selectNumBoard(num);
	
	//검색된 게시글이 없거나 검색된 게시글이 삭제글인 경우 - 비정상적인 요청
	if(board == null || board.getStatus() == 9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 - 비정상적인 요청
	if(!loginMember.getId().equals(board.getId()) && loginMember.getStatus() != 9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
table {
	margin: 0 auto;
}

th {
	width: 70px;
	font-weight: normal;
}

td {
	text-align: left;
}
</style>
<h2>글변경</h2>
<form action="<%=request.getContextPath()%>/site/index.jsp?workgroup=board&work=board_modify_action"
	method="post" id="boardForm">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">	
	<input type="hidden" name="search" value="<%=search%>">	
	<input type="hidden" name="keyword" value="<%=keyword%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="40" value="<%=board.getSubject()%>">
				<input type="checkbox" name="secret" value="1" 
					<% if(board.getStatus() == 1) { %>checked="checked"<% } %>>비밀글
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" cols="60" name="content" id="board_content"><%=board.getContent() %></textarea>
			</td>
		</tr>
		<tr> 
			<th colspan="2">
				<button type="submit">변경</button>
				<button type="reset" id="resetBtn">다시쓰기</button>
			</th>
		</tr>
	</table>	
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>