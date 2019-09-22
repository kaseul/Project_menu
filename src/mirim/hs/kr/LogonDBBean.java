package mirim.hs.kr;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LogonDBBean {
	
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		String url = "jdbc:mysql://localhost:3306/mirim";
		String user = "test";
		String pass = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, user, pass);
		return conn;
	} // getConnection
	
	// menuTbl
	public void insertMenu(MenuBean menu) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO menuTbl(days, part, menu) VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, (Date) menu.getDays());
			pstmt.setString(2, menu.getPart());
			pstmt.setString(3, menu.getMenu());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} } 
		} // finally
		
	} // insertMenu
	
	public void updateMenu(MenuBean menu) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "UPDATE menuTbl SET menu = ? WHERE no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, menu.getMenu());
			pstmt.setInt(2, menu.getNo());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} } 
		} // finally
	}
	
	public List<MenuBean> selectAllMenu() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuBean> menus = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM menuTbl";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				MenuBean menu = new MenuBean();
				menu.setNo(rs.getInt("no"));
				menu.setDays(rs.getDate("days"));
				menu.setPart(rs.getString("part"));
				menu.setMenu(rs.getString("menu"));
				
				menus.add(menu);
			} // while
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(rs != null) { try { rs.close(); } catch(Exception e) {} }
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} }
		} // finally
		
		System.out.println(menus.size());
		return menus;
	}
	
	public List<MenuBean> selectMenuWithDays(String days) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuBean> menus = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM menuTbl WHERE days = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, Date.valueOf(days));
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				MenuBean menu = new MenuBean();
				menu.setNo(rs.getInt("no"));
				menu.setDays(rs.getDate("days"));
				menu.setPart(rs.getString("part"));
				menu.setMenu(rs.getString("menu"));
				
				menus.add(menu);
			} // while
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(rs != null) { try { rs.close(); } catch(Exception e) {} }
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} }
		} // finally
		
		System.out.println(menus.size());
		return menus;
	}
	
	public List<MenuBean> selectMenuWithDaysAndPart(String days, String part) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuBean> menus = new ArrayList<>();
		
		try {
			conn = getConnection();
			//System.out.println(part);
			String sql = "SELECT * FROM menuTbl WHERE days = ? AND part = ?";
			//System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, Date.valueOf(days));
			pstmt.setString(2, new String(part.getBytes("UTF-8"),"8859_1"));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("dd");
				MenuBean menu = new MenuBean();
				menu.setNo(rs.getInt("no"));
				menu.setDays(rs.getDate("days"));
				menu.setPart(rs.getString("part"));
				menu.setMenu(rs.getString("menu"));
				
				menus.add(menu);
			} // if
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(rs != null) { try { rs.close(); } catch(Exception e) {} }
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} }
		} // finally
		
		System.out.println(menus.size());
		return menus;
	}
	
	
	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "INSERT INTO member VALUES(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} } 
		} // finally
		
	} // insertMember
	
	
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String dbpass = "";
		
		try {
			conn = getConnection();
			String sql = "SELECT passwd FROM member WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpass = rs.getString("passwd");
				if(dbpass.equals(passwd)) {
					x = 1;
				}
				else {
					x = 0; 
				}
			}
			else {
				x = -1; 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(rs != null) { try { rs.close(); } catch(Exception e) {} }
			if(pstmt != null) { try { pstmt.close(); } catch(Exception e) {} }
			if(conn != null) { try { conn.close(); } catch(Exception e) {} } 
		} // finally
		
		return x;
	} // userCheck
	
}
