package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import tables.Expense;

public interface BookmarkMapper {
	
	@Insert("insert into bookmark (email,expenseNum) values (#{email},#{expenseNum})")
	int insert(Map<String, Object> map);

	@Select("SELECT * FROM expense e JOIN member m "
			+ " ON e.email = m.email "
			+ " WHERE expenseNum in ( SELECT expenseNum from bookmark WHERE email=#{email} ) "
			+ " order by e.seldate desc, e.selhour desc, e.selminute "
			+ " limit #{start}, #{limit} ")
	List<Expense> select(Map<String, Object> map);
	
	@Select("select count(*) from bookmark where email = #{email}")
	int bookcnt(String email);

}
	