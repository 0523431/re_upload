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
	// db�����
	private MemberDao mdao = new MemberDao();
	private Member mem = new Member();
	
	private TravelDao tdao = new TravelDao();
	private Travel tra = new Travel();
	
	private String msg = null;
	private String url = null;
	
	// �α��� Ȯ�ο�
	public int LogCheck(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("email");
		String email = request.getParameter("email");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "loginForm.pro");
			return 0;
		} else {
			// (info, update���� �ʿ��� ���� id !=null)
			if(!login.equals("adminkim") && email !=null && !login.equals(email)) {
				request.setAttribute("msg", "���θ� ���� �����մϴ�");
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
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

	// �α���
	// 1. id, pass �Ķ���� ����
	// 2. id���� db���� ��ȸ�ϰ� ��й�ȣ ����
	public ActionForward login(HttpServletRequest request, HttpServletResponse response) {
				
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		
		msg = "�ش� �̸����� �������� �ʽ��ϴ�.";
		url = "loginForm.pro";
		Member mem = mdao.selectEmail(email);
		
		// db�� ������ ����
		if(mem !=null) {
			if(pass.equals(mem.getPassword())) {
				String nickname = mem.getNickname();
				String profile = mem.getProfile();

				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("nickname", nickname);
				request.getSession().setAttribute("profile", profile);
				
				msg = mdao.selectEmail(email).getNickname() + "���� �α����ϼ̽��ϴ�";
				url = "main.pro";
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
		System.out.println("��й�ȣ : "+ fpw);
		
		if(fpw == null || fpw.equals("")) {
			request.setAttribute("msg", "�ش������� �����ϴ�");
			request.setAttribute("url", "pwfindForm.pro");
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("password", fpw.substring(2, fpw.length()));
			return new ActionForward();
		}
	}
	
	// �α׾ƿ�
	public ActionForward logout(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			msg = "�α׾ƿ��ϼ̽��ϴ�.";
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
		url = "joinForm.pro";

		if(mdao.insertMem(mem) >0) {
			msg = mem.getNickname() + "�� ȸ�����ԵǼ̽��ϴ�.";
			url = "loginForm.pro";
			System.out.println("ȸ������ Ȯ�� : " + mem);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// ȸ������ �����ʻ��� �ε�
	// (opener ȭ�鿡 ����ְ� ����ȭ�� close()�ϴ°� javaScript����)
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
		request.setAttribute("filename", filename); // �� �Ӽ����� profile.jsp�� ����
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
		request.setAttribute("filename", filename); // �� �Ӽ����� profile.jsp�� ����
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
			
			msg = "������ ��Ͽ� �����ϼ̽��ϴ�";
			url = "mainWrite.pro";
			
			System.out.println(tra);
			
			if(tdao.insertMain(tra) > 0) {
				msg = "������"+ tra.getTraveltitle() +"�� ��ϵǾ����ϴ�.";
				url = "subList.pro?";
				System.out.println("Ȯ�� : " + tra);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		return new ActionForward();
	}
	
	/* <�� ��>
	 * 1. �� �������� �������� �Խñ��� ������ ��¥�� ������ ���ԵǸ� ��������
	 * 
	 * 2. ȭ�鿡 �ʿ���  ������ �Ӽ����� ��� => view�� ����
	 */
	public ActionForward listMain(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			
		}
		return new ActionForward(false, "../alert.jsp");
	}
	
	// �������� ����ϰ� ���� �������� ����Ʈ
	public ActionForward listSub(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			List<Travel> list = tdao.listSub();
			request.setAttribute("list", list);
			return new ActionForward();
		}
		return new ActionForward(false, "../alert.jsp");
	}
}
