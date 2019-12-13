package table.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import tables.Expense;

public interface ExpenseMapper {

	@Select("select ifnull(max(expenseNum),0) from expense")
	int maxmum();
	
	@Insert("insert into expense "
			+ " (expenseNum,email,travelNum,type1,price,type2,title,peocnt,seldate,selhour,selminute,content) "
			+ " values (#{expenseNum},#{email},#{travelNum},#{type1},#{price},#{type2},#{title},#{peocnt},#{seldate},#{selhour},#{selminute},#{content}) ")
	int insertEx(Expense exp);
	
	@Select({"<script>",
				" select * from expense ",
				" where 1=1 ",
					" <if test='travelNum !=null'>and travelNum =#{travelNum} </if>",
					" <if test='email !=null'>and email =#{email} </if>",
				 	" <if test='type1 !=null'> and type1 = #{type1} </if>",
					" order by seldate desc, selhour desc, selminute desc ",
		 	 "</script>"})
	List<Expense> exlist(Map<String, Object> map);
		
	@Select(" select * from expense e join member m "
			+ " on e.email = m.email "
			+ " where expenseNum = #{expenseNum} ")
	Expense selectEx(Map<String, Object> map);
	
	// 같이보자(전체 지출 리스트)
	@Select({"<script>",
				" select * from expense e join member m join travel t"
				+ " on e.email = m.email AND e.travelNum  = t.travelNum ",
	 			  " <if test='column !=null'> where ${column} like '%${find}%' </if>", 
				  " order by expenseNum desc limit #{start}, #{limit} ",
			"</script>"})
	List<Expense> otherlist(Map<String, Object> map);
	
	// 지출 게시물 개수
	/*
	 * @Select({"<script>", " select count(*) from expense", " <choose>",
	 * " <when test='travelNum !=null'> where travelNum =#{travelNum} </when>",
	 * " <when test='email !=null'> where email =#{email} </when>", " </choose>",
	 * "</script>"})
	 */
	@Select({"<script>",
			  	" select count(*) from expense",
			  	" where 1=1 ",
			  	" <if test='travelNum !=null'> and travelNum =#{travelNum} </if> ",
			  	" <if test='email !=null'> and email =#{email} </if>",
			"</script>"})
	int excnt(Map<String, Object> map);
	
	@Select("select * from expense where email = #{email}")
	Expense selectExp(Map<String, Object> map);
	
	@Update(" update expense set "
			+ " type1=#{type1},price=#{price},type2=#{type2},title=#{title},peocnt=#{peocnt}, "
			+ " seldate=#{seldate},selhour=#{selhour},selminute=#{selminute},content=#{content} "
			+ " where expenseNum=#{expenseNum} ")
	int subUpdate(Expense exp);
	
	// 지출내역 삭제
	@Delete("delete from expense where expenseNum=#{expenseNum}")
	int subDelete(Expense exp);

	@Select({"<script>",
				" select count(*) from expense ",
				" <if test='column !=null'> where ${column} like '%${find}%' </if>",
			 "</script>"})
	int expcnt(Map<String, Object> map);
	
	//case 조건 컬럼 when 조건 값 then 출력값
	//when 조건 값 then 출력값
	//when 조건 값 then 출력값
	//else 출력값 end
	@Select(" select case type2 when 1 then '식비' "
							+ " when 2 then '쇼핑' "
							+ " when 3 then '관광' "
							+ " when 4 then '교통' "
							+ " when 5 then '숙박' "
							+ " when 6 then '선물' "
							+ " else '기타' end type2, count(*) as cnt from expense "
			  + " where travelNum =#{travelNum}"
			  + " and email =#{email}"
			  + " group by type2 "
	  		  + " order by cnt desc ")
	List<Map<String, Integer>> graph(@Param("email")String email, @Param("travelNum")int travelNum);
	
	// 그래프 : 맵객체를 리스트형태로 전달
	@Select(" select type2, count(*) as cnt from expense "
			  + " where travelNum =#{travelNum}"
			  + " and email =#{email}"
			  + " group by type2 "
	  		  + " order by cnt desc ")
	List<Map<Integer, Integer>> graph_test(Map<String, Object> map);
}
