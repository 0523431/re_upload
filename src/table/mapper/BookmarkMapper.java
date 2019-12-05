package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import tables.Bookmark;
import tables.Expense;

public interface BookmarkMapper {
	
	@Insert("insert into bookmark (email,expenseNum) values (#{email},#{expenseNum})")
	Bookmark insert(Map<String, Object> map);

	@Select("SELECT * FROM expense "
			+ "WHERE expenseNum in ( SELECT expenseNum from bookmark WHERE email=#{email} )")
	List<Expense> select(String email);
}
