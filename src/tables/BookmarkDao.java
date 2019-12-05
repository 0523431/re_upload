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
		
	public Bookmark insert(String email, int expenseNum) {
		SqlSession session = DBConnection.getConnection();

		try {
			map.clear();
			map.put("email", email);
			map.put("expenseNum", expenseNum);

			return session.getMapper(cls).insert(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public List<Expense> select(String email) {
		SqlSession session = DBConnection.getConnection();

		try {
			
			return session.getMapper(cls).select(email);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
}
