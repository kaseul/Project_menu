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
	
	public void updateLikes(int no, int amount) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "UPDATE menuTbl SET likes = likes + ? WHERE no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, amount);
			pstmt.setInt(2, no);
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
				menu.setLikes(rs.getInt("likes"));
				
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
	
	public List<MenuBean> selectPopularMenus() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuBean> menus = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM menuTbl ORDER BY likes DESC limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MenuBean menu = new MenuBean();
				menu.setNo(rs.getInt("no"));
				menu.setDays(rs.getDate("days"));
				menu.setPart(rs.getString("part"));
				menu.setMenu(rs.getString("menu"));
				menu.setLikes(rs.getInt("likes"));
				
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
	
	public MenuBean selectMenu(int no) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuBean menuBean = null;
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM menuTbl WHERE no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				MenuBean menu = new MenuBean();
				menu.setNo(rs.getInt("no"));
				menu.setDays(rs.getDate("days"));
				menu.setPart(rs.getString("part"));
				menu.setMenu(rs.getString("menu"));
				menu.setLikes(rs.getInt("likes"));
				
				menuBean = menu;
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
		
		
		return menuBean;
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
				menu.setLikes(rs.getInt("likes"));
				
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
				menu.setLikes(rs.getInt("likes"));
				
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
	
	
	public void insertMember(MemberBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "INSERT INTO memberTbl VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
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
	
	public int idCheck(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;
		
		try {
			conn = getConnection();
			String sql = "SELECT password FROM memberTbl WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = 1;
			}
			else {
				x = 0; 
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
	}
	
	
	public int userCheck(String id, String password) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		String dbpass = "";
		
		try {
			conn = getConnection();
			String sql = "SELECT password FROM memberTbl WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpass = rs.getString("password");
				if(dbpass.equals(password)) {
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
	
	public List<LikesBean> selectLikes(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LikesBean> likes = new ArrayList<>();
		
		try {
			conn = getConnection();
			//System.out.println(part);
			String sql = "SELECT * FROM likesTbl WHERE id = ?";
			//System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				LikesBean like = new LikesBean();
				like.setId(rs.getString("id"));
				like.setNo(rs.getInt("no"));
				
				likes.add(like);
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
		
		System.out.println(likes.size());
		return likes;
	}
	
	public void insertLikes(String id, int no) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO likesTbl VALUES(?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
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
	
	public void deleteLikes(String id, int no) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "DELETE FROM likesTbl WHERE id = ? AND no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
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
	
	public void insertBoard(BoardBean board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "INSERT INTO boardTbl VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setInt(2, board.getNo());
			pstmt.setString(3, board.getContent());
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
	
	public List<BoardBean> selectAllBoard() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardBean> boards = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM boardTbl";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				BoardBean board = new BoardBean();
				board.setId(rs.getString("id"));
				board.setNo(rs.getInt("no"));
				board.setContent(rs.getString("content"));
				
				boards.add(board);
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
		
		System.out.println(boards.size());
		return boards;
	}
	
	public List<BoardBean> selectBoards(int no) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardBean> boards = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT * FROM boardTbl WHERE no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				BoardBean board = new BoardBean();
				board.setId(rs.getString("id"));
				board.setNo(rs.getInt("no"));
				board.setContent(rs.getString("content"));
				
				boards.add(board);
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
		
		System.out.println(boards.size());
		return boards;
	}
	
	public List<Integer> selectBoardNo() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Integer> boards = new ArrayList<>();
		
		try {
			conn = getConnection();
			String sql = "SELECT DISTINCT no FROM boardTbl";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println("dd");
				boards.add(rs.getInt("no"));
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
		
		System.out.println(boards.size());
		return boards;
	}
	
}
