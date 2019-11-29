package action;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import tables.Member;
import tables.MemberDao;

public class MemberAction {
	// db�����
	private MemberDao mdao = new MemberDao();
	private Member mem = new Member();
	
	private String msg = null;
	private String url = null;
	
	
	// �α���
	// 1. id, pass �Ķ���� ����
	// 2. id���� db���� ��ȸ�ϰ� ��й�ȣ ����
	public ActionForward login(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		
		msg = "�ش� �̸����� �������� �ʽ��ϴ�.";
		url = "loginForm.mem";
		
		System.out.println("pass : " + pass);
		System.out.println("db���� email�� ���� ������ ���� : " + mdao.selectEmail(email));
		System.out.println("�Ʊ�� Ȯ�� : " + mdao.selectEmail(email).getPassword());
		
		// db�� ������ ����
		if(mdao.selectEmail(email) !=null) {
			if(pass.equals(mdao.selectEmail(email).getPassword())) {
				
				request.getSession().setAttribute("login", email);
				
				msg = mdao.selectEmail(email).getNickname() + "���� �α����ϼ̽��ϴ�";
				url = "main.mem";
			} else {
				msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�";
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// ��й�ȣ ã��
	// 1. �Է��� �̸���, �г��� �޾ƿͼ� db���� ��ȸ�ϱ�
	public ActionForward passFind(HttpServletRequest request, HttpServletResponse response) {
		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		
		String fpw = mdao.passFind(email, nickname);
		
		if(fpw == null || fpw.equals("")) {
			request.setAttribute("msg", "�ش������� �����ϴ�");
			request.setAttribute("url", "pwfindForm.do");
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("pass", fpw.substring(2, fpw.length()));
			return new ActionForward();
		}
	}
	
	// ȸ������
	// 1. parameter������ Member��ü�� ����
	// 2. Member ��ü�� db�� �߰�
	public ActionForward join(HttpServletRequest request, HttpServletResponse response) {
				
		mem.setNickname(request.getParameter("nickname"));
		mem.setEmail(request.getParameter("email"));
		mem.setPassword(request.getParameter("password"));
		mem.setProfile(request.getParameter("profile"));
		
		// msg, url default��
		msg = "ȸ�����Կ� �����ϼ̽��ϴ�";
		url = "joinForm.mem";
			if(mdao.insertMem(mem) >0) {
				msg = mem.getNickname() + "�� ȸ�����ԵǼ̽��ϴ�.";
				url = "loginForm.mem";
			}
			
		System.out.println("ȸ������ Ȯ�� : " + mem);
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// ȸ������ �����ʻ��� �ε�
	// (opener ȭ�鿡 ����ְ� ����ȭ�� close()�ϴ°� javaScript����)
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
		request.setAttribute("filename", filename); // �� �Ӽ����� profile.jsp�� ����
		return new ActionForward();
	}
}