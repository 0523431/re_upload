package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.BookmarkMapper;

public class BookmarkDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<BookmarkMapper> cls = BookmarkMapper.class;
		
	public boolean insert(String email, int expenseNum) {
		SqlSession session = DBConnection.getConnection();

		try {
			map.clear();
			map.put("email", email);
			map.put("expenseNum", expenseNum);

			int cnt = session.getMapper(cls).insert(map);
			if(cnt > 0) return true;
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public List<Expense> select(String email, int limit, int pageNum) {
		SqlSession session = DBConnection.getConnection();

		try {
			map.clear();
			map.put("email", email);
			map.put("start", (pageNum-1)*limit);
			map.put("limit", limit);
			return session.getMapper(cls).select(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public int bookcnt(String email) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).bookcnt(email);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}
}
