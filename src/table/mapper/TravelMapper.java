package table.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import tables.Travel;

public interface TravelMapper {
	
	// 여행지 등록
	@Insert("insert into travel"
			 + " (travelNum,email,traveltitle,start,end,country,background,currency,budget) "
			 + " values (#{travelNum},#{email},#{traveltitle},#{start},#{end},#{country},#{background},#{currency},#{budget})")
	int insertMain(Travel tra);
	
	@Select("select * from travel")
	List<Travel> selectMain();
	
}
