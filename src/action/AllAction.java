package action;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

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
	
	private String msg = null;
	private String url = null;
	
	// 로그인 확인용
	public int LogCheck(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("email");
		String email = request.getParameter("email");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "loginForm.pro");
			return 0;
		} else {
			// (info, update에서 필요한 조건 id !=null)
			if(!login.equals("adminkim") && email !=null && !login.equals(email)) {
				request.setAttribute("msg", "본인만 접근 가능합니다");
				request.setAttribute("url", "main.pro");
				return 0;
			}
		}
		return 1;
	}
	
	public ActionForward main(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {

			return new ActionForward();
		} else {
			request.setAttribute("msg", "로그인이 필요합니다");
			request.setAttribute("url", "loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

	// 로그인
	// 1. id, pass 파라미터 저장
	// 2. id정보 db에서 조회하고 비밀번호 검증
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
				
				msg = mdao.selectEmail(email).getNickname() + "님이 로그인하셨습니다";
				url = "main.pro";
			} else {
				msg = "비밀번호가 일치하지 않습니다";
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 비밀번호 찾기
	// 1. 입력한 이메일, 닉네임 받아와서 db에서 조회하기
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
			msg = "로그아웃하셨습니다.";
			url = "loginForm.pro";
			
			request.getSession().invalidate();
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			msg = "???????????";
			url = "loginForm.pro";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// 회원가입
	// 1. parameter정보를 Member객체에 저장
	// 2. Member 객체를 db에 추가
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
			url = "loginForm.pro";
			System.out.println("회원가입 확인 : " + mem);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 회원가입 프로필사진 로드
	// (opener 화면에 결과주고 현재화면 close()하는건 javaScript에서)
	public ActionForward profile(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("") + "member/profile";
		System.out.println("path : "+path);
		
		String filename = null;
		try {
			File f = new File(path);
			if(!f.exists()) {
				f.mkdirs();
			}
			
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			filename = multi.getFilesystemName("profile");
		} catch (IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("filename", filename); // 이 속성값이 profile.jsp와 연계
		return new ActionForward();
	}
	
	public ActionForward picture(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("") + "board/picture";
		System.out.println("path : "+path);
		
		String filename = null;
		try {
			File f = new File(path);
			if(!f.exists()) {
				f.mkdirs();
			}
			
			MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
			filename = multi.getFilesystemName("picture");
		} catch (IOException e) {
			e.printStackTrace();
		}
		request.setAttribute("filename", filename); // 이 속성값이 profile.jsp와 연계
		return new ActionForward();
	}
	
	public ActionForward mainWrite(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			tra.setTraveltitle(request.getParameter("traveltitle"));
			tra.setCountry(request.getParameter("country"));
			tra.setStart(request.getParameter("start"));
			tra.setEnd(request.getParameter("end"));
			tra.setCurrency(Integer.parseInt(request.getParameter("currency")));
			tra.setBudget(Integer.parseInt(request.getParameter("budget")));
			tra.setBackground(request.getParameter("background"));
			
			msg = "여행지 등록에 실패하셨습니다";
			url = "mainWrite.pro";
			
			System.out.println(tra);
			
			if(tdao.insertMain(tra) > 0) {
				msg = "여행지"+ tra.getTraveltitle() +"가 등록되었습니다.";
				url = "subList.pro?";
				System.out.println("확인 : " + tra);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		return new ActionForward();
	}
	
	/* <할 일>
	 * 1. 한 페이지에 보여지는 게시글은 지정된 날짜에 오늘이 포함되면 보여야해
	 * 
	 * 2. 화면에 필요한  정보를 속성으로 등록 => view로 전송
	 */
	public ActionForward listMain(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			
		}
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 여행지를 등록하고 나면 보여지는 리스트
	public ActionForward listSub(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			List<Travel> list = tdao.listSub();
			request.setAttribute("list", list);
			return new ActionForward();
		}
		return new ActionForward(false, "../alert.jsp");
	}
}
