package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.TravelMapper;

public class TravelDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<TravelMapper> cls = TravelMapper.class;
	
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

	public List<Travel> listSub() {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).selectMain();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
