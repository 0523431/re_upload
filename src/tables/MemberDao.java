package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.MemberMapper;

public class MemberDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<MemberMapper> cls = MemberMapper.class;
	
	// email 가져오기
	public Member selectEmail(String email) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("email", email);
			List<Member> list = session.getMapper(cls).selectE(map);
			return list.get(0);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	// 비밀번호 찾기
	public String passFind(String email, String nickname) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("email", email);
			map.put("nickname", nickname);
			return session.getMapper(cls).passFind(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	// 회원가입하기
	public int insertMem(Member mem) {
		SqlSession session = DBConnection.getConnection();
				
		try {
			return session.getMapper(cls).insertMem(mem);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert 실패를 뜻함 (return -1;도 가능)
	}

	
	
}
