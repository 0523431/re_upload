package tables;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import table.mapper.MemberMapper;

public class MemberDao {
	// param���� �����
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<MemberMapper> cls = MemberMapper.class;
	
	// email ��������
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
	
	// ��й�ȣ ã��
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

	// ȸ�������ϱ�
	public int insertMem(Member mem) {
		SqlSession session = DBConnection.getConnection();
				
		try {
			return session.getMapper(cls).insertMem(mem);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert ���и� ���� (return -1;�� ����)
	}
	
	// ���̵� �ߺ� üũ
	public boolean nickname_check(String nickname) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).nickname_check(nickname);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}

	public Member myLsit(String email) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("email", email);
			return session.getMapper(cls).myList(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public int myListDelete(Member mem) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).myListDelete(mem);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public int changePass(String email, String new_pass) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			map.put("email", email);
			map.put("new_pass", new_pass);
			return session.getMapper(cls).changePass(map);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	public int myListUpdate(Member mem) {
		SqlSession session = DBConnection.getConnection();
		try {
			return session.getMapper(cls).myListUpdate(mem);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}
}
