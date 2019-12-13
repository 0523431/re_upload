package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import action.ActionForward;
import table.mapper.TravelMapper;

public class TravelDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<TravelMapper> cls = TravelMapper.class;
	
	// 등록된 게시물 번호 중 최대값을 리턴
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).maxnum();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// 여행지 등록
	public int insertMain(Travel tra) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			int cnt = session.getMapper(cls).insertMain(tra);
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

	public int boardCount(String email) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).boardCount(email);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<Travel> list(int pageNum, int limit, String email) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("start", (pageNum-1)*limit); // 0이면 첫번째 레코드
			map.put("limit", limit);
			map.put("email", email);

			return session.getMapper(cls).select(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public Travel selectOne(int travelNum) {
		SqlSession session = DBConnection.getConnection();		
		
		try {
			map.clear();
			map.put("travelNum",travelNum);
			map.put("start", 0);
			map.put("limit", 1);
			System.out.println(travelNum);
			return session.getMapper(cls).select(map).get(0);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	public int mainUpdate(Travel tra) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).mainUpdate(tra);
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

	public int mainDelete(Travel tra) {
		SqlSession session = DBConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).mainDelete(tra);
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

}
