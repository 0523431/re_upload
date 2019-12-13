package tables;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
 * ���������ڸ� ���� �ʾҴ� : ���� ��Ű�������� ������ �����Ѱž�
 */

// ���� ��Ű�� model��Ű�������� ����� ������
// static�̴ϱ� DBConnection�� .���� �����ؿ��� �翬�� ����Ǵ� �ž�?

public class DBConnection {
	
	// static : ��ü ��ü���� �ѹ��� ���ž�
	// sqlMap : �����̳� ��ü
	private static SqlSessionFactory sqlMap;
	
	// static�ʱ�ȭ ��
	static {
		// �����̱⶧���� ���ϸ����� ������ �� �ְ� model.mapper������ ������ ǥ��
		// mybatis-config.xml ������ ��ġ
		String resource = "table/mapper/mybatis-config.xml";
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		} catch(IOException e) {
			e.printStackTrace();
		}
		// build : Connection ��ü ����
		//         SQL ������ �����ϴ� �����̳� ���� (reader�� ���� �о)
		sqlMap = new SqlSessionFactoryBuilder().build(reader);
	}
	
	static SqlSession getConnection() {
		return sqlMap.openSession(); // ������=> DB�� ���� (sqlMap�� �ִ� Connection ��ü�� ����)
	}
	
	static void close(SqlSession session) {
		session.commit();
		session.close();
	}
}
