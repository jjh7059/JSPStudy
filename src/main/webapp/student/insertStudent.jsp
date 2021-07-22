<%@page import="xyz.itwill.dao.StudentDAO"%>
<%@page import="xyz.itwill.dto.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(insertFormStudent.jsp)에서 전달된 학생정보를 반환받아 STUDENT 테이블에
저장하고 학생정보 검색 출력페이지(displayStudent.jsp)로 이동하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 처리
	if(request.getMethod().equals("GET")) {//JSP 문서를 GET 방식으로 요청한 경우
		session.setAttribute("message", "비정상적인 방법으로 페이지를 요청하였습니다.");
		response.sendRedirect("insertFormStudent.jsp");//입력페이지 이동
		return;
	}

	//POST 방식으로 요청하여 전달된 값에 대한 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");
	
	//전달값을 반환받아 저장
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String birthday = request.getParameter("birthday");
	
	//DTO 인스턴스를 생성하여 전달값으로 필드값 변경
	StudentDTO student = new StudentDTO();
	student.setNo(no);
	student.setName(name);
	student.setPhone(phone);
	student.setAddress(address);
	student.setBirthday(birthday);
	
	//전달된 학생번호가 STUDENT 테이블에 저장된 기존 학생의 학생번호가 존재할 경우
	//학생정보 저장 입력페이지(insertFormStudent.jsp)로 이동
	//학생번호를 전달받아 STUDENT 테이블에 저장된 학생정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => null 반환 : 학생정보 검색X, StudentDTO 인스턴스 반환 : 학생정보 검색
	if(StudentDAO.getDAO().selectNoStudent(no) != null) {
		response.sendRedirect("insertFormStudent.jsp");
		session.setAttribute("student", student);
		session.setAttribute("message", "이미 존재하는 학생번호입니다.");
		return;
	}
	
	//학생정보(StudentDTO 인스턴스)를 전달받아 STUDENT 테이블에 삽입하는 DAO 클래스의 메소드
	StudentDAO.getDAO().insertStudent(student);
	
	//학생정보 검색 출력페이지(displayStudent.jsp)로 이동
	response.sendRedirect("displayStudent.jsp");
%>