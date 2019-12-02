package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import tables.Travel;

public interface TravelMapper {

	@Select("select ifnull(max(travelNum),0) from travel")
	int maxnum();
		
	// ������ ���
	@Insert("insert into travel "
			 + " (travelNum,email,traveltitle,start,end,country,background,currency,budget) "
			 + " values (#{travelNum},#{email},#{traveltitle},#{start},#{end},#{country},#{background},#{currency},#{budget})")
	int insertMain(Travel tra);

	// �Խñ� ���(�˻� ��ϱ���)
	@Select({"<script>",
			 " select * from travel ",
			 	" <choose>",
			 		" <when test='travelNum !=null'> where travelNum =#{travelNum} </when>",
			 		" <otherwise>"
			 + 			" limit #{start},#{limit}"
			 + 		" </otherwise>",
			 	"</choose>",
			 "</script>"})
	List<Travel> select(Map<String, Object> map);
	
	@Select("select count(*) from travel")
	int boardCount();

}
