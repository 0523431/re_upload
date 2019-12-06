package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.ExpenseMapper;

public class ExpenseDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<ExpenseMapper> cls = ExpenseMapper.class;
			
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();

		try {
			return session.getMapper(cls).maxmum();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public int insertEx(Expense exp) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			int cnt = session.getMapper(cls).insertEx(exp);
			if(cnt >0) {
				return 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { // return했지만, 꼭 하고 다음으로 넘어가
			DBConnection.close(session);
		}
		return 0;
	}

	

	public int excnt(String email, int travelNum) {
		SqlSession session = DBConnection.getConnection();		
		
		try {
			map.clear();
			map.put("email", email);
			map.put("travelNum", travelNum);
			return session.getMapper(cls).excnt(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public List<Expense> exlist(int travelNum, String email, String type1) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("travelNum", travelNum);
			map.put("email", email);
			if(!type1.equals("all")) {
				map.put("type1", Integer.parseInt(type1));
			}
			return session.getMapper(cls).exlist(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Expense selectEx(int expenseNum) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("expenseNum", expenseNum);

			return session.getMapper(cls).selectEx(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public List<Expense> otherlist(int limit, int pageNum, String column, String find) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("start", (pageNum-1)*limit);
			map.put("limit", limit);
			if(column != null) {
				map.put("column", column);
				map.put("find", find);
			}
			return session.getMapper(cls).otherlist(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	// 그래프
	public List<Map<String, Integer>> graph(String email, int travelNum) {
		SqlSession session = DBConnection.getConnection();
		// <key,value> => key : 컬럼명=type2 || value= 그 값
		List<Map<String, Integer>> map = null;
		try {
			map = session.getMapper(cls).graph(email, travelNum);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return map;
	}

	public Expense selectExp(String email) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("email", email);
			return session.getMapper(cls).selectExp(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public int subUpdate(Expense exp) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).subUpdate(exp);
			if(cnt >0) {
				return 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public int subDelete(Expense exp) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).subDelete(exp);
			if(cnt >0) {
				return 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public int expcnt(String column, String find) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			if(column != null) {
				map.put("column", column);
				map.put("find", find);
			}
			return session.getMapper(cls).expcnt(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

}
