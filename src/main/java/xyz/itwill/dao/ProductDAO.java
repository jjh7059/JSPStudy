package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ProductDTO;

public class ProductDAO extends JdbcDAO{
	private static ProductDAO _dao;
	
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	//ī�װ��� ���޹޾� PRODUCT ���̺� ����� �ش� ī�װ��� ��ǰ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public List<ProductDTO> selectCategoryProductList(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();
			
			if(category.equals("ALL")) {//��� ��ǰ���� �˻�
				String sql = "select * from product order by product_code";
				pstmt = con.prepareStatement(sql);
			} else {//ī�װ��� ��ǰ���� �˻�
				String sql = "select * from product where product_code like ?||'%' order by product_code";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductCode(rs.getString("product_code"));
				product.setProductName(rs.getString("product_name"));
				product.setMainImage(rs.getString("main_image"));
				product.setProductDetail(rs.getString("product_detail"));
				product.setProductQty(rs.getInt("product_qty"));
				product.setProductPrice(rs.getInt("product_price"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectCategoryProductList() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//��ǰ������ ���޹޾� PRODUCT ���̺� ���� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "insert into product values(product_seq.nextval,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getProductCode());
			pstmt.setString(2, product.getProductName());
			pstmt.setString(3, product.getMainImage());
			pstmt.setString(4, product.getProductDetail());
			pstmt.setInt(5, product.getProductQty());
			pstmt.setInt(6, product.getProductPrice());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]insertProduct() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//��ǰ�ڵ带 ���޹޾� PRODUCT ���̺� ����� �ش� ��ǰ�ڵ��� ��ǰ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public ProductDTO selectCodeProduct(String productCode) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		
		try {
			con = getConnection();
			
			String sql = "select * from product where product_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productCode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductCode(rs.getString("product_code"));
				product.setProductName(rs.getString("product_name"));
				product.setMainImage(rs.getString("main_image"));
				product.setProductDetail(rs.getString("product_detail"));
				product.setProductQty(rs.getInt("product_qty"));
				product.setProductPrice(rs.getInt("product_price"));
			}
		} catch (SQLException e) {
			System.out.println("[����]selectCodeProduct() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	//��ǰ��ȣ�� ���޹޾� PRODUCT ���̺� ����� �ش� ��ǰ�ڵ��� ��ǰ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public ProductDTO selectNumProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		
		try {
			con = getConnection();
			
			String sql = "select * from product where product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDTO();
				product.setProductNum(rs.getInt("product_num"));
				product.setProductCode(rs.getString("product_code"));
				product.setProductName(rs.getString("product_name"));
				product.setMainImage(rs.getString("main_image"));
				product.setProductDetail(rs.getString("product_detail"));
				product.setProductQty(rs.getInt("product_qty"));
				product.setProductPrice(rs.getInt("product_price"));
			}
		} catch (SQLException e) {
			System.out.println("[����]selectCodeProduct() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	//��ǰ������ ���޹޾� PRODUCT ���̺� ����� ��ǰ������ �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int updateProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "update product set product_code=?,product_name=?,main_image=?,product_detail=?"
					+ ",product_qty=?,product_price=? where product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getProductCode());
			pstmt.setString(2, product.getProductName());
			pstmt.setString(3, product.getMainImage());
			pstmt.setString(4, product.getProductDetail());
			pstmt.setInt(5, product.getProductQty());
			pstmt.setInt(6, product.getProductPrice());
			pstmt.setInt(7, product.getProductNum());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]updateProduct() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//��ǰ������ ���޹޾� PRODUCT ���̺� ����� �ش� ��ǰ��ȣ�� ��ǰ������ �����ϰ� 
	//�������� ������ ��ȯ�ϴ� �޼ҵ�
	public int deleteProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "delete from product where product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]deleteProduct() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
