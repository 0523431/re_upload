package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import tables.Member;

public interface MemberMapper {
	@Insert("insert into member "
			+ " (nickname, email, password, profile) "
			+ " values (#{nickname}, #{email}, #{password}, #{profile})")
	int insertMem(Member mem);
	
	@Select({"<script>",
				"select * from member", // 무조건 실행되고
				"<if test='email !=null'> where binary email=#{email} </if>",
	 		 "</script>"})
	List<Member> selectE(Map<String, Object> map);

	@Select("select password from member where binary email=#{email} and binary nickname=#{nickname}")
	String passFind(Map<String, Object> map);

}
