package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.TravelMapper;

public class TravelDao {
	// param���� �����
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<TravelMapper> cls = TravelMapper.class;
	
	// ��ϵ� �Խù� ��ȣ �� �ִ밪�� ����
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).maxnum();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	// ������ ���
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

	public int boardCount() {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).boardCount();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<Travel> list(int pageNum, int limit) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("start", (pageNum-1)*limit); // 0�̸� ù��° ���ڵ�
			map.put("limit", limit);
			return session.getMapper(cls).select(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}


	
	
}
