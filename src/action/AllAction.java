package action;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.oreilly.servlet.MultipartRequest;

import tables.Bookmark;
import tables.BookmarkDao;
import tables.Expense;
import tables.ExpenseDao;
import tables.Member;
import tables.MemberDao;
import tables.Travel;
import tables.TravelDao;

public class AllAction {
	// db연결용
	private MemberDao mdao = new MemberDao();
	private Member mem = new Member();
	
	private TravelDao tdao = new TravelDao();
	private Travel tra = new Travel();
	
	private ExpenseDao edao = new ExpenseDao();
	private Expense exp = new Expense();
	
	private String msg = null;
	private String url = null;
	
	// 로그인 확인
	public int LogCheck(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("email");
		String email = request.getParameter("email");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "./member/loginForm.jsp");
			return 0;
		} else {
			// (info, update에서 필요한 조건 id !=null)
			if(!login.equals("adminkim") && email !=null && !login.equals(email)) {
				request.setAttribute("msg", "본인만 접근 가능합니다");
				request.setAttribute("url", "./../board/mainInfo.pro");
				return 0;
			}
		}
		return 1;
	}

	// 로그인
	public ActionForward login(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		
		msg = "해당 이메일이 존재하지 않습니다.";
		url = "loginForm.pro";
		
		Member mem = mdao.selectEmail(email);
		
		// db에 정보가 있음
		if(mem !=null) {
			if(pass.equals(mem.getPassword())) {
				String nickname = mem.getNickname();
				String profile = mem.getProfile();

				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("nickname", nickname);
				request.getSession().setAttribute("profile", profile);
				
				msg = mem.getNickname() + "님이 로그인하셨습니다";
				url = "./../board/mainInfo.pro?email="+email;
			} else {
				msg = "비밀번호가 일치하지 않습니다";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 비밀번호 찾기
	public ActionForward passFind(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");

		String fpw = mdao.passFind(email, nickname);
		System.out.println("비밀번호 : "+ fpw);
		
		if(fpw == null || fpw.equals("")) {
			request.setAttribute("msg", "해당정보가 없습니다");
			request.setAttribute("url", "pwfindForm.pro");
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("password", fpw.substring(2, fpw.length()));
			return new ActionForward();
		}
	}
	
	// 로그아웃
	public ActionForward logout(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			msg = "로그아웃하셨습니다";
			url = "loginForm.pro";
			
			request.getSession().invalidate();
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			msg = "로그인이 필요합니다";
			url = "../member/loginForm.pro";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
	}
	// 내 정보
	public ActionForward myList(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			Member info = mdao.myLsit(email);
			System.out.println("mylist"+info);
			request.setAttribute("info", info);
			return new ActionForward();
		} else {
			msg = "로그인이 필요합니다";
			url = "../member/loginForm.pro";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
	}
	// 비번바꾸기
	public ActionForward changePass(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String old_pass = request.getParameter("old_pass"); // 입력한 비번
		String new_pass = request.getParameter("new_pass"); // 변경 비번
		String email = (String)request.getSession().getAttribute("email");		
		System.out.println("비번 : "+email);
		boolean opener = false;
		boolean closer = false;
		
		Member mem = mdao.myLsit(email);
		if (!old_pass.equals(mem.getPassword())) {
			opener = false;
			closer = false;
			msg = "비밀번호가 일치하지 않습니다";
			url = "changePassForm.pro?email=" + mem.getEmail();
		} else { // 비밀번호 일치
			int result = mdao.changePass(email, new_pass);
			if (result > 0) {
				opener = true;
				closer = true;
				msg = "비밀번호가 성공적으로 변경되었습니다";
				url = "myListUpdateForm.pro?email="+mem.getEmail();
			}
		}
		request.setAttribute("opener", opener);
		request.setAttribute("closer", closer);

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward();
	}
	// 회원정보 업데이트
	public ActionForward myListUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			mem.setEmail(email);
			mem.setNickname(request.getParameter("nickname"));
			mem.setPassword(request.getParameter("password"));
			mem.setProfile(request.getParameter("profile"));
			System.out.println("사진"+mem.getProfile());
			
			Member dbmem = mdao.myLsit(email);
			
			if(!mem.getPassword().equals(dbmem.getPassword())) {
				msg = "비밀번호가 틀렸습니다";
				url = "myListUpdateForm.pro?email="+email;
			} else { // 비밀번호가 맞을때
				int result = mdao.myListUpdate(mem);
				System.out.println("비밀번호 체크 : "+mem);
				if(result >0) {
					msg = "회원정보 수정을 완료했습니다";
					url = "myList.pro?email="+email;
					
				} else {
					msg = "수정에 실패했습니다";
					url = "myListUpdateForm.pro?email="+email;
					
				}
			}
			request.setAttribute("msg",msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
			
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 탈퇴
	public ActionForward myListDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
		String pass = request.getParameter("password");
		String email = request.getParameter("email");
		
		Member mem = mdao.myLsit(email);
		
			if (pass.equals(mem.getPassword()) && !pass.trim().equals("")) {
				if (mdao.myListDelete(mem) > 0) {
					msg = "무사히 탈퇴하셨습니다.";
					url = "../member/loginForm.pro";
				} else {
					msg = "탈퇴에 실패했습니다";
					url = "myList.pro?email=" + mem.getEmail();
				}
				request.setAttribute("msg", "로그인이 필요합니다");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			} else {
				msg = "비밀번호가 일치하지 않습니다. 확인해주세요";
				url = "myListDeleteForm.pro?email=" + mem.getEmail();
				request.setAttribute("msg", "로그인이 필요합니다");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			}
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 회원가입
	public ActionForward join(HttpServletRequest request, HttpServletResponse response) {
				
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));
		mem.setPassword(request.getParameter("password"));
		mem.setProfile(request.getParameter("profile"));
		
		// msg, url default값
		msg = "회원가입에 실패하셨습니다";
		url = "joinForm.pro";

		if(mdao.insertMem(mem) >0) {
			msg = mem.getNickname() + "님 회원가입되셨습니다.";
			url = "../member/loginForm.pro";
			System.out.println("회원가입 확인 : " + mem);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 회원가입 프로필사진 로드 (opener 화면에 결과주고 현재화면 close()하는건 javaScript에서)
	public ActionForward profile(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("") + "member/profile";
		String filename = null;
		try {
			File f = new File(path);
			if(!f.exists()) {
				f.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			filename = multi.getFilesystemName("profile");
		} catch (IOException e) {
//			e.printStackTrace();
		}
		request.setAttribute("filename", filename); // 이 속성값이 profile.jsp와 연계
		return new ActionForward();
	}
	
	// 중복 검사
	public ActionForward nickname_check(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String nickname = request.getParameter("nickname");
		boolean confirm_nickname = mdao.nickname_check(nickname);

		String msg2 = "";
		if(confirm_nickname == true) {
			msg2 = "사용할 수 없는 닉네임입니다";
		}
		else {
			msg2 = "사용 가능한 닉네임입니다";
		}
		
		request.setAttribute("msg2", msg2);
		request.setAttribute("confirm_nickname", confirm_nickname);
		return new ActionForward(false, "../member/checkmsg.pro"); // ajax으로 전달하는 파일
	}
		
	public ActionForward mainWriteForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			return new ActionForward(false, "mainWrite.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	// 여행지 등록
	public ActionForward mainWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String ulpath = request.getServletContext().getRealPath("/") + "board/background/";
			try {
				File f = new File(ulpath);
				if(!f.exists()) {
					f.mkdirs();
				}
				MultipartRequest multi = new MultipartRequest(request, ulpath, 10*1024*1024,"euc-kr");
				
				tra.setTraveltitle(multi.getParameter("traveltitle"));
				tra.setEmail(multi.getParameter("email"));
				tra.setCountry(multi.getParameter("country"));
				tra.setStart(multi.getParameter("start"));
				tra.setEnd(multi.getParameter("end"));
				tra.setCurrency(Float.parseFloat(multi.getParameter("currency")));
				tra.setBudget(Float.parseFloat(multi.getParameter("budget")));
				tra.setBackground(multi.getFilesystemName("background"));
				
				msg = "여행지 등록에 실패하셨습니다";
				url = "mainWrite.pro?email="+tra.getEmail();
				
				int num = tdao.maxnum();
				tra.setTravelNum(++num);
				
				if(tdao.insertMain(tra) > 0) {
					msg = tra.getTraveltitle() +"가 등록되었습니다.";
					url = "mainInfo.pro?email="+tra.getEmail();
					System.out.println("여행지 등록확인 : " + tra);
				}
			} catch(IOException e) {
				e.printStackTrace();
				throw new ServletException(e);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 여행지 리스트
	public ActionForward mainInfo(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			int limit =5;
			int pageNum =1;
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			} catch(NumberFormatException e) {
				//e.printStackTrace();
			}
			
			String email = (String)request.getSession().getAttribute("email");
			int travelcnt = tdao.boardCount(email);

			List<Travel> list = tdao.list(pageNum, limit, email);
			int maxpage = (int)((double)travelcnt/limit + 0.95);
			int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 +1;
			int endpage = startpage +9;
			if(endpage > maxpage) {
				endpage = maxpage;
			}
			int boardnum = travelcnt - (pageNum -1) *limit;
			request.setAttribute("travelcnt", travelcnt);
			request.setAttribute("list", list);
			request.setAttribute("maxpage", maxpage);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("boardnum", boardnum);
			request.setAttribute("pageNum", pageNum);
			return new ActionForward();
			} else {
				request.setAttribute("msg", "로그인이 필요합니다");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			}
	}
	
	// 여행지 정보 제공
	public ActionForward mainUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			Travel info = tdao.selectOne(travelNum);
			request.setAttribute("info", info);
			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

	// 여행지 수정
	public ActionForward mainUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String ulpath = request.getServletContext().getRealPath("/") + "board/background/";
			try {
				File f = new File(ulpath);
				if(!f.exists()) {
					f.mkdirs();
				}
				MultipartRequest multi = new MultipartRequest(request, ulpath, 10*1024*1024,"euc-kr");
				tra.setTravelNum(Integer.parseInt(multi.getParameter("travelNum")));
				tra.setTraveltitle(multi.getParameter("traveltitle"));
				tra.setCountry(multi.getParameter("country"));
				tra.setEmail(multi.getParameter("email"));
				tra.setCountry(multi.getParameter("country"));
				tra.setStart(multi.getParameter("start"));
				tra.setEnd(multi.getParameter("end"));
				tra.setCurrency(Float.parseFloat(multi.getParameter("currency")));
				tra.setBudget(Float.parseFloat(multi.getParameter("budget")));
				tra.setBackground(multi.getFilesystemName("background"));
				
				if(tra.getBackground() ==null || tra.getBackground().equals("")) {
					tra.setBackground(multi.getParameter("background_up"));
				}
				
				msg = "여행지 수정에 실패했습니다";
				url = "mainUpdateForm.pro?travelNum="+tra.getTravelNum();
				if(tdao.mainUpdate(tra) >0) {
					msg = "여행지 수정을 완료했습니다";
					url = "mainInfo.pro?email="+tra.getEmail();
					System.out.println("여행지수정 : " + tra.toString());
				}
			} catch(IOException e) {
				e.printStackTrace();
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 여행지 삭제하기
	public ActionForward mainDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			String pass = request.getParameter("password");
				
			String email = (String)request.getSession().getAttribute("email");
			Member mem = mdao.selectEmail(email);
			
			Travel tra = tdao.selectOne(travelNum);
			if(tra ==null) {
				msg = "이미 삭제해서 없는 지출내역입니다";
				url = "mainInfo.pro?emailm="+tra.getEmail();
				} else {
					if(pass.equals(mem.getPassword()) && !pass.trim().equals("")) {
						if(tdao.mainDelete(tra) >0) {
							msg = "여행지 삭제에 성공했습니다";
							url = "mainInfo.pro?emailm="+tra.getEmail();
						} else {
							msg = "여행지 삭제에 실패했습니다";
							url = "mainUpdateForm.pro?travelNum="+travelNum;
						}
					} else {
						msg = "비밀번호가 일치하지 않습니다. 확인해주세요";
						url = "mainDeleteForm.pro?travelNum="+tra.getTravelNum();
					}
				}
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else {
				request.setAttribute("msg", "로그인이 필요합니다");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			}
		}
		
	// <여행지 등록 후 지출내역이 보여지는 페이지>
	public ActionForward subList(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			String type1 = request.getParameter("type1"); // url에서 직접 받음
			if(type1 == null || type1.equals("all")) {
				type1 = "all";
			}
			
			Travel info = tdao.selectOne(travelNum); // num에 해당하는 게시물 조회
			request.setAttribute("info", info); //  이걸로 여행기간을 불러올 수 있음
			System.out.println("num에 해당하는 정보"+info);
			
			String email = request.getParameter("email");
			
			// 속성값으로 내용을 보냄
			request.setAttribute("travelNum", info.getTravelNum());
			
			int expcnt = edao.excnt(email, travelNum);
			request.setAttribute("expcnt", expcnt);
			
			// travelNum에 등록된 지출을 list로 불러옴
			List<Expense> exlist = edao.exlist(travelNum, email, type1);
			request.setAttribute("exlist", exlist);
			System.out.println("exlist : " + exlist);
			
			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}		
	}
	
	// <지출 작성하기>
	public ActionForward subWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			
			Travel info = tdao.selectOne(travelNum); // num에 해당하는 게시물 조회
			request.setAttribute("info", info); //  이걸로 여행기간을 불러올 수 있음
			
			exp.setEmail(request.getParameter("email"));
			exp.setTravelNum(Integer.parseInt(request.getParameter("travelNum")));
			exp.setType1(Integer.parseInt(request.getParameter("type1")));
			exp.setPrice(Float.parseFloat(request.getParameter("price")));
			exp.setType2(Integer.parseInt(request.getParameter("type2")));
			exp.setPeocnt(Integer.parseInt(request.getParameter("peocnt")));
			exp.setTitle(request.getParameter("title"));
			exp.setSeldate(Integer.parseInt(request.getParameter("seldate")));
			exp.setSelhour(Integer.parseInt(request.getParameter("selhour")));
			exp.setSelminute(Integer.parseInt(request.getParameter("selminute")));
			exp.setContent(request.getParameter("content"));
			
			msg = "게시물 등록 실패";
			url = "subWriteForm.pro?travelNum="+exp.getTravelNum();
			
			// 지출번호
			int expnum = edao.maxnum();
			exp.setExpenseNum(++expnum);
			
			// 지출 등록
			if(edao.insertEx(exp) > 0) {
				msg = "금액 "+exp.getPrice()+" 사용";
				url = "subList.pro?travelNum="+exp.getTravelNum();
				System.out.println("지출 등록 : "+edao);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward subWriteForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			Travel info = tdao.selectOne(travelNum); // num에 해당하는 게시물 조회
			request.setAttribute("info", info); //  이걸로 여행기간을 불러올 수 있음

			return new ActionForward(false, "subWrite.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward subDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			
			int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
			Expense info = edao.selectEx(expenseNum);
			request.setAttribute("info", info);
			
			int travelNum = info.getTravelNum();
			Travel tinfo = tdao.selectOne(travelNum); // num에 해당하는 게시물 조회
			request.setAttribute("tinfo", tinfo); //  이걸로 여행기간을 불러올 수 있음
			
			Travel info_period = tdao.selectOne(travelNum); // num에 해당하는 게시물 조회
			request.setAttribute("info_period", info_period); //  이걸로 여행기간을 불러올 수 있음
			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 지출 수정하기
	public ActionForward subUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
			Expense info = edao.selectEx(expenseNum);
			request.setAttribute("info", info);
			
			exp.setEmail(request.getParameter("email"));
			exp.setTravelNum(Integer.parseInt(request.getParameter("travelNum")));
			exp.setExpenseNum(Integer.parseInt(request.getParameter("expenseNum")));
			exp.setType1(Integer.parseInt(request.getParameter("type1")));
			exp.setPrice(Float.parseFloat(request.getParameter("price")));
			exp.setType2(Integer.parseInt(request.getParameter("type2")));
			exp.setPeocnt(Integer.parseInt(request.getParameter("peocnt")));
			exp.setTitle(request.getParameter("title"));
			exp.setSeldate(Integer.parseInt(request.getParameter("seldate")));
			exp.setSelhour(Integer.parseInt(request.getParameter("selhour")));
			exp.setSelminute(Integer.parseInt(request.getParameter("selminute")));
			exp.setContent(request.getParameter("content"));
			
			msg = "지출내역을 수정하지 못했습니다 ㅠㅠ";
			url = "subUpdateForm.pro?expenseNum="+exp.getExpenseNum();
						
			if(edao.subUpdate(exp) >0) {
				msg = "지출내역 수정을 완료했습니다";
				url = "subDetailForm.pro?expenseNum="+expenseNum;
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 지출 삭제하기
	public ActionForward subDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
			String pass = request.getParameter("password");
			
			String email = (String)request.getSession().getAttribute("email");
			Member mem = mdao.selectEmail(email);
			
			Expense exp = edao.selectEx(expenseNum);
			if(exp ==null) {
				msg = "이미 삭제해서 없는 지출내역입니다";
				url = "subList.pro?travelNum="+exp.getTravelNum();
			} else {
				if(pass.equals(mem.getPassword()) && !pass.trim().equals("")) {
					if(edao.subDelete(exp) >0) {
						msg = "지출내역 삭제에 성공했습니다";
						url = "subList.pro?travelNum="+exp.getTravelNum();
					} else {
						msg = "게시글 삭제에 실패했습니다";
						url = "subDetailForm.pro?expenseNum="+exp.getExpenseNum();
					}
				} else {
					msg = "비밀번호가 일치하지 않습니다. 확인해주세요";
					url = "subDeleteForm.pro?expenseNum="+exp.getExpenseNum();
				}
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// subList에서 그래프
	public ActionForward graph(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			System.out.println("graph : " + email + travelNum);
			List<Map<String, Integer>> list = edao.graph(email, travelNum);
			System.out.println("graph list : " + list);
			request.setAttribute("list", list);
			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}	
	public ActionForward exchange(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			// 크롤링할 url주소
			String url = "https://www.koreaexim.go.kr/site/program/financial/exchange?menuid=001001004002001";
			String line = "";
			Document doc = null;
			try {
				// doc : 홈페이지의 소스가 저장되어 있음
				doc = Jsoup.connect(url).get();
				// Elements : 배열이거나 list이거나 => collection
				// e1 : url이 제공하는 html 문서 중 태그가 table인 태그들만 저장
				Elements e1 = doc.select(".tType01");
				for(Element ele : e1) { // 여기서 ele는 table태그 한개를 뜻함 => table태그를 제외한 그 안의 내용들
					String temp = ele.html();
					System.out.println("========================");
					System.out.println(temp);
				}
			} catch(IOException e) {
				e.printStackTrace();
			}
			return new ActionForward(); 
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 모두보기(지출 리스트)
	public ActionForward otherList(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int limit = 10;
			int pageNum = 1;
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			} catch(NumberFormatException e) {
				//e.printStackTrace();
			}
			
			// 게시물 검색 조건
			String column = request.getParameter("column");
			String find = request.getParameter("find");
			if(column !=null && column.trim().equals("")) {
				column = null;
			}
			if(find != null && find.trim().equals("")) { // find를 선택하지않아도 검색 가능
				find = null;
			}
			if(column == null || find == null) {
				column =null;
				find = null;
			}

			int expcnt = edao.expcnt(column, find); // 전체 지출 내역
			List<Expense> list = edao.otherlist(limit, pageNum, column, find);
			int maxpage = (int)((double)expcnt/limit + 0.95);
			int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 +1;
			int endpage = startpage +9;
			if(endpage > maxpage) {
				endpage = maxpage;
			}
			int expnum = expcnt - (pageNum-1) *limit;
	
			request.setAttribute("list", list);
			request.setAttribute("expcnt", expcnt);
			request.setAttribute("maxpage", maxpage);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("expnum", expnum);
			request.setAttribute("pageNum", pageNum);
			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	/*
	 * public ActionForward myList(HttpServletRequest request, HttpServletResponse
	 * response) throws ServletException { if(LogCheck(request, response) ==1) {
	 * String email = (String)request.getSession().getAttribute("email");
	 * 
	 * String pass = request.getParameter("password"); Member mem =
	 * mdao.selectEmail(email);
	 * 
	 * if(pass.equals(mem.getPassword())) { msg = mem.getNickname() +
	 * "님의 정보수정이 가능합니다"; url = "myList.pro?email="+email;
	 * request.setAttribute("msg", msg); request.setAttribute("url", url); return
	 * new ActionForward(false, "../alert.jsp"); } else { msg = "비밀번호가 일치하지 않습니다";
	 * url = "myListCheck.pro?email="+email; request.setAttribute("msg", msg);
	 * request.setAttribute("url", url); return new ActionForward(false,
	 * "../alert.jsp"); } } else { request.setAttribute("msg", "로그인이 필요합니다");
	 * request.setAttribute("url", "../member/loginForm.pro"); return new
	 * ActionForward(false, "../alert.jsp"); } }
	 */
	
	public ActionForward bookmarkform(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String email = request.getParameter("email");
		int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
		System.out.println("book확인 : "+ email + expenseNum);
		
		BookmarkDao bdao = new BookmarkDao();
		boolean book = bdao.insert(email, expenseNum);
		
		String msg1 = "";
		if(book == true) {
			msg1 = "따로따로에 추가되었습니다";
		}
		else {
			msg1 = "이미추가된 게시물입니다";
		}
		
		request.setAttribute("msg1", msg1);
		System.out.println("book 값 : "+book);
		return new ActionForward(false, "../board/bookmsg.pro"); // ajax으로 전달하는 파일
	}

	public ActionForward bookmark(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			BookmarkDao bdao = new BookmarkDao();
			
			// 페이지 넘기기
			int limit =10;
			int pageNum =1;
			
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			} catch(NumberFormatException e) {
				//e.printStackTrace();
			}
			int bookcnt = bdao.bookcnt(email);
			
			List<Expense> list = bdao.select(email, limit, pageNum);
			request.setAttribute("list", list);
			
			int maxpage = (int)((double)bookcnt/limit + 0.95);
			int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 +1;
			int endpage = startpage +9;
			if(endpage > maxpage) {
				endpage = maxpage;
			}
			int boardnum = bookcnt - (pageNum -1) *limit;
			request.setAttribute("travelcnt", bookcnt);
			request.setAttribute("maxpage", maxpage);
			request.setAttribute("startpage", startpage);
			request.setAttribute("endpage", endpage);
			request.setAttribute("boardnum", boardnum);
			request.setAttribute("pageNum", pageNum);
			return new ActionForward();			
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(LogCheck(request, response) ==1) {
			String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
			File f = new File(path);
			if(!f.exists()) {
				f.mkdirs();
			}
			
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			String fileName = multi.getFilesystemName("upload");
			
			// "CKEditorFuncNum" : 이미 정해진거야, ck editor에게 파일이름을 전달해줘
			request.setAttribute("fileName", fileName);
			request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
			return new ActionForward(false, "ckeditor.jsp");
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

}
