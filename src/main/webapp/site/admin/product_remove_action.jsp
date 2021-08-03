<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 삭제하고
제품목록 출력페이지로 이동하는 JSP 문서 --%>
<%-- => 로그인 상태의 관리자만 접근 가능하도록 설정 --%>
<%@include file="/site/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 처리
	if(request.getParameter("productNum") == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=error&work=error400'");
		out.println("</script>");
		return;
	}	

	//전달값을 반환받아 저장
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	
	ProductDTO product = ProductDAO.getDAO().selectNumProduct(productNum);
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품을 삭제하는 DAO클래스 메소드 호출
	ProductDAO.getDAO().deleteProduct(productNum);
	
	//삭제된 제품에 대한 이미지 파일 삭제
	String saveDirectory = request.getServletContext().getRealPath("/site/product_image");
	new File(saveDirectory, product.getMainImage()).delete();
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+ request.getContextPath() +"/site/index.jsp?workgroup=admin&work=product_manager'");
	out.println("</script>");
%>