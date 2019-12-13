package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import tables.Travel;

public interface TravelMapper {

	@Select("select ifnull(max(travelNum),0) from travel")
	int maxnum();
		
	// 여행지 등록
	@Insert("insert into travel "
			 + " (travelNum,email,traveltitle,start,end,country,background,currency,budget) "
			 + " values (#{travelNum},#{email},#{traveltitle},#{start},#{end},#{country},#{background},#{currency},#{budget})")
	int insertMain(Travel tra);

	@Select({"<script>",
			 " select * from travel ",
			 	" where 1+1 ",
		 			" <if test='travelNum !=null'> and travelNum =#{travelNum} </if>",
			 		" <if test='email !=null'> and email =#{email} </if>",
			  	" order by travelNum desc limit #{start}, #{limit}",
			 "</script>"})
	List<Travel> select(Map<String, Object> map);
	
	@Select("select count(*) from travel where email=#{email}")
	int boardCount(String email);
	
	@Update(" update travel set "
			+ " traveltitle=#{traveltitle}, "
			+ " start=#{start},end=#{end},country=#{country}, "
			+ " currency=#{currency},budget=#{budget}, background=#{background} "
			+ " where travelNum=#{travelNum} ")
	int mainUpdate(Travel tra);

	@Delete("delete from travel where travelNum=#{travelNum}")
	int mainDelete(Travel tra);

}
