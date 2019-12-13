package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
	
	@Select("select nickname from member where nickname=#{nickname}")
	boolean nickname_check(String nickname);
	
	@Select("select * from member where email=#{email}")
	Member myList(Map<String, Object> map);
	
	@Delete("delete from member where email=#{email}")
	int myListDelete(Member mem);

	@Update("update member set password=#{new_pass} where email=#{email}")
	int changePass(Map<String, Object> map);
	
	@Update("update member set nickname=#{nickname}, profile=#{profile} where email=#{email}")
	int myListUpdate(Member mem);
}
