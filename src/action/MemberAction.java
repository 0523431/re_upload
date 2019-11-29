package action;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import tables.Member;
import tables.MemberDao;

public class MemberAction {
	// db연결용
	private MemberDao mdao = new MemberDao();
	private Member mem = new Member();
	
	private String msg = null;
	private String url = null;
	
	
	// 로그인
	// 1. id, pass 파라미터 저장
	// 2. id정보 db에서 조회하고 비밀번호 검증
	public ActionForward login(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		
		msg = "해당 이메일이 존재하지 않습니다.";
		url = "loginForm.mem";
		
		System.out.println("pass : " + pass);
		System.out.println("db에서 email을 통해 가져온 정보 : " + mdao.selectEmail(email));
		System.out.println("아까거 확인 : " + mdao.selectEmail(email).getPassword());
		
		// db에 정보가 있음
		if(mdao.selectEmail(email) !=null) {
			if(pass.equals(mdao.selectEmail(email).getPassword())) {
				
				request.getSession().setAttribute("login", email);
				
				msg = mdao.selectEmail(email).getNickname() + "님이 로그인하셨습니다";
				url = "main.mem";
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
		
		if(fpw == null || fpw.equals("")) {
			request.setAttribute("msg", "해당정보가 없습니다");
			request.setAttribute("url", "pwfindForm.do");
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("pass", fpw.substring(2, fpw.length()));
			return new ActionForward();
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
		url = "joinForm.mem";
			if(mdao.insertMem(mem) >0) {
				msg = mem.getNickname() + "님 회원가입되셨습니다.";
				url = "loginForm.mem";
			}
			
		System.out.println("회원가입 확인 : " + mem);
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// 회원가입 프로필사진 로드
	// (opener 화면에 결과주고 현재화면 close()하는건 javaScript에서)
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
			e.printStackTrace();
		}
		request.setAttribute("filename", filename); // 이 속성값이 profile.jsp와 연계
		return new ActionForward();
	}
}