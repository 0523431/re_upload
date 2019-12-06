package action;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	// db�����
	private MemberDao mdao = new MemberDao();
	private Member mem = new Member();
	
	private TravelDao tdao = new TravelDao();
	private Travel tra = new Travel();
	
	private ExpenseDao edao = new ExpenseDao();
	private Expense exp = new Expense();
	
	private String msg = null;
	private String url = null;
	
	// �α��� Ȯ��
	public int LogCheck(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("email");
		String email = request.getParameter("email");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "./member/loginForm.jsp");
			return 0;
		} else {
			// (info, update���� �ʿ��� ���� id !=null)
			if(!login.equals("adminkim") && email !=null && !login.equals(email)) {
				request.setAttribute("msg", "���θ� ���� �����մϴ�");
				request.setAttribute("url", "./../board/mainInfo.pro");
				return 0;
			}
		}
		return 1;
	}

	// �α���
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
				
				msg = mem.getNickname() + "���� �α����ϼ̽��ϴ�";
				url = "./../board/mainInfo.pro?email="+email;
			} else {
				msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	// ��й�ȣ ã��
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
			msg = "�α׾ƿ��ϼ̽��ϴ�";
			url = "loginForm.pro";
			
			request.getSession().invalidate();
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			msg = "�α����� �ʿ��մϴ�";
			url = "loginForm.pro";
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// ȸ������
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
	
	// ȸ������ �����ʻ��� �ε� (opener ȭ�鿡 ����ְ� ����ȭ�� close()�ϴ°� javaScript����)
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
		request.setAttribute("filename", filename); // �� �Ӽ����� profile.jsp�� ����
		return new ActionForward();
	}
	
	public ActionForward mainWriteForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			return new ActionForward(false, "mainWrite.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	// ������ ���
	public ActionForward mainWrite(HttpServletRequest request, HttpServletResponse response) {
		if(LogCheck(request, response) ==1) {
			tra.setTraveltitle(request.getParameter("traveltitle"));
			tra.setEmail(request.getParameter("email"));
			tra.setCountry(request.getParameter("country"));
			tra.setStart(request.getParameter("start"));
			tra.setEnd(request.getParameter("end"));
			tra.setCurrency(Integer.parseInt(request.getParameter("currency")));
			tra.setBudget(Integer.parseInt(request.getParameter("budget")));
			tra.setBackground(request.getParameter("background"));
			
			msg = "������ ��Ͽ� �����ϼ̽��ϴ�";
			url = "mainWrite.pro?email="+tra.getEmail();
			
			int num = tdao.maxnum();
			tra.setTravelNum(++num);
			
			if(tdao.insertMain(tra) > 0) {
				msg = tra.getTraveltitle() +"�� ��ϵǾ����ϴ�.";
				url = "mainInfo.pro?email="+tra.getEmail();
				System.out.println("������ ���Ȯ�� : " + tra);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		}
		return new ActionForward();
	}
	
	// ������ ����Ʈ
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
				request.setAttribute("msg", "�α����� �ʿ��մϴ�");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			}
	}
	
	// ������ ���� ����
	public ActionForward mainUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			Travel info = tdao.selectOne(travelNum);
			request.setAttribute("info", info);
			return new ActionForward();
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

	// ������ ����
	public ActionForward mainUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			tra.setTravelNum(Integer.parseInt(request.getParameter("travelNum")));
			tra.setTraveltitle(request.getParameter("traveltitle"));
			tra.setCountry(request.getParameter("country"));
			tra.setEmail(request.getParameter("email"));
			tra.setCountry(request.getParameter("country"));
			tra.setStart(request.getParameter("start"));
			tra.setEnd(request.getParameter("end"));
			tra.setCurrency(Integer.parseInt(request.getParameter("currency")));
			tra.setBudget(Integer.parseInt(request.getParameter("budget")));
			
			msg = "������ ������ �����߽��ϴ�";
			url = "mainUpdateForm.pro?travelNum="+tra.getTravelNum();
						
			if(tdao.mainUpdate(tra) >0) {
				msg = "������ ������ �Ϸ��߽��ϴ�";
				url = "mainInfo.pro?email="+tra.getEmail();
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	// ������ �����ϱ�
	public ActionForward mainDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			String pass = request.getParameter("password");
				
			String email = (String)request.getSession().getAttribute("email");
			Member mem = mdao.selectEmail(email);
			
			Travel tra = tdao.selectOne(travelNum);
			if(tra ==null) {
				msg = "�̹� �����ؼ� ���� ���⳻���Դϴ�";
				url = "mainInfo.pro?emailm="+tra.getEmail();
				} else {
					if(pass.equals(mem.getPassword()) && !pass.trim().equals("")) {
						if(tdao.mainDelete(tra) >0) {
							msg = "������ ������ �����߽��ϴ�";
							url = "mainInfo.pro?emailm="+tra.getEmail();
						} else {
							msg = "������ ������ �����߽��ϴ�";
							url = "mainUpdateForm.pro?travelNum="+travelNum;
						}
					} else {
						msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�����ּ���";
						url = "mainDeleteForm.pro?travelNum="+tra.getTravelNum();
					}
				}
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else {
				request.setAttribute("msg", "�α����� �ʿ��մϴ�");
				request.setAttribute("url", "../member/loginForm.pro");
				return new ActionForward(false, "../alert.jsp");
			}
		}
		
	// <������ ��� �� ���⳻���� �������� ������>
	public ActionForward subList(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			String type1 = request.getParameter("type1"); // url���� ���� ����
			if(type1 == null || type1.equals("all")) {
				type1 = "all";
			}
			
			Travel info = tdao.selectOne(travelNum); // num�� �ش��ϴ� �Խù� ��ȸ
			request.setAttribute("info", info); //  �̰ɷ� ����Ⱓ�� �ҷ��� �� ����
			System.out.println("num�� �ش��ϴ� ����"+info);
			
			String email = request.getParameter("email");
			
			// �Ӽ������� ������ ����
			request.setAttribute("travelNum", info.getTravelNum());
			
			int expcnt = edao.excnt(email, travelNum);
			request.setAttribute("expcnt", expcnt);
			
			// travelNum�� ��ϵ� ������ list�� �ҷ���
			List<Expense> exlist = edao.exlist(travelNum, email, type1);
			request.setAttribute("exlist", exlist);
			System.out.println("exlist : " + exlist);
			
			return new ActionForward();
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}		
	}
	
	// <���� �ۼ��ϱ�>
	public ActionForward subWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			
			Travel info = tdao.selectOne(travelNum); // num�� �ش��ϴ� �Խù� ��ȸ
			request.setAttribute("info", info); //  �̰ɷ� ����Ⱓ�� �ҷ��� �� ����
			
			exp.setEmail(request.getParameter("email"));
			exp.setTravelNum(Integer.parseInt(request.getParameter("travelNum")));
			exp.setType1(Integer.parseInt(request.getParameter("type1")));
			exp.setPrice(Integer.parseInt(request.getParameter("price")));
			exp.setType2(Integer.parseInt(request.getParameter("type2")));
			exp.setPeocnt(Integer.parseInt(request.getParameter("peocnt")));
			exp.setTitle(request.getParameter("title"));
			exp.setSeldate(Integer.parseInt(request.getParameter("seldate")));
			exp.setSelhour(Integer.parseInt(request.getParameter("selhour")));
			exp.setSelminute(Integer.parseInt(request.getParameter("selminute")));
			exp.setContent(request.getParameter("content"));
			
			msg = "�Խù� ��� ����";
			url = "subWriteForm.pro?travelNum="+exp.getTravelNum();
			
			// �����ȣ
			int expnum = edao.maxnum();
			exp.setExpenseNum(++expnum);
			
			// ���� ���
			if(edao.insertEx(exp) > 0) {
				msg = "�ݾ� "+exp.getPrice()+" ���";
				url = "subList.pro?travelNum="+exp.getTravelNum();
				System.out.println("���� ��� : "+edao);
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward subWriteForm(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int travelNum = Integer.parseInt(request.getParameter("travelNum"));
			Travel info = tdao.selectOne(travelNum); // num�� �ش��ϴ� �Խù� ��ȸ
			request.setAttribute("info", info); //  �̰ɷ� ����Ⱓ�� �ҷ��� �� ����

			return new ActionForward(false, "subWrite.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
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
			Travel tinfo = tdao.selectOne(travelNum); // num�� �ش��ϴ� �Խù� ��ȸ
			request.setAttribute("tinfo", tinfo); //  �̰ɷ� ����Ⱓ�� �ҷ��� �� ����
			
			Travel info_period = tdao.selectOne(travelNum); // num�� �ش��ϴ� �Խù� ��ȸ
			request.setAttribute("info_period", info_period); //  �̰ɷ� ����Ⱓ�� �ҷ��� �� ����
			return new ActionForward();
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// ���� �����ϱ�
	public ActionForward subUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
			Expense info = edao.selectEx(expenseNum);
			request.setAttribute("info", info);
			
			exp.setEmail(request.getParameter("email"));
			exp.setTravelNum(Integer.parseInt(request.getParameter("travelNum")));
			exp.setExpenseNum(Integer.parseInt(request.getParameter("expenseNum")));
			exp.setType1(Integer.parseInt(request.getParameter("type1")));
			exp.setPrice(Integer.parseInt(request.getParameter("price")));
			exp.setType2(Integer.parseInt(request.getParameter("type2")));
			exp.setPeocnt(Integer.parseInt(request.getParameter("peocnt")));
			exp.setTitle(request.getParameter("title"));
			exp.setSeldate(Integer.parseInt(request.getParameter("seldate")));
			exp.setSelhour(Integer.parseInt(request.getParameter("selhour")));
			exp.setSelminute(Integer.parseInt(request.getParameter("selminute")));
			exp.setContent(request.getParameter("content"));
			
			msg = "���⳻���� �������� ���߽��ϴ� �Ф�";
			url = "subUpdateForm.pro?expenseNum="+exp.getExpenseNum();
						
			if(edao.subUpdate(exp) >0) {
				msg = "���⳻�� ������ �Ϸ��߽��ϴ�";
				url = "subDetailForm.pro?expenseNum="+expenseNum;
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// ���� �����ϱ�
	public ActionForward subDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
			String pass = request.getParameter("password");
			
			String email = (String)request.getSession().getAttribute("email");
			Member mem = mdao.selectEmail(email);
			
			Expense exp = edao.selectEx(expenseNum);
			if(exp ==null) {
				msg = "�̹� �����ؼ� ���� ���⳻���Դϴ�";
				url = "subList.pro?travelNum="+exp.getTravelNum();
			} else {
				if(pass.equals(mem.getPassword()) && !pass.trim().equals("")) {
					if(edao.subDelete(exp) >0) {
						msg = "���⳻�� ������ �����߽��ϴ�";
						url = "subList.pro?travelNum="+exp.getTravelNum();
					} else {
						msg = "�Խñ� ������ �����߽��ϴ�";
						url = "subDetailForm.pro?expenseNum="+exp.getExpenseNum();
					}
				} else {
					msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�����ּ���";
					url = "subDeleteForm.pro?expenseNum="+exp.getExpenseNum();
				}
			}
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	// subList���� �׷���
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
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}	
	
	// ��κ���(���� ����Ʈ)
	public ActionForward otherList(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			int limit = 10;
			int pageNum = 1;
			try {
				pageNum = Integer.parseInt(request.getParameter("pageNum"));
			} catch(NumberFormatException e) {
				//e.printStackTrace();
			}
			
			// �Խù� �˻� ����
			String column = request.getParameter("column");
			String find = request.getParameter("find");
			if(column !=null && column.trim().equals("")) {
				column = null;
			}
			if(find != null && find.trim().equals("")) { // find�� ���������ʾƵ� �˻� ����
				find = null;
			}
			if(column == null || find == null) {
				column =null;
				find = null;
			}

			int expcnt = edao.expcnt(column, find); // ��ü ���� ����
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
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward myList(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			
			String pass = request.getParameter("password");
			Member mem = mdao.selectEmail(email);

			if(pass.equals(mem.getPassword())) {
				msg = mem.getNickname() + "���� ���������� �����մϴ�";
				url = "myList.pro?email="+email;
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			} else {
				msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�";
				url = "myListCheck.pro?email="+email;
				request.setAttribute("msg", msg);
				request.setAttribute("url", url);
				return new ActionForward(false, "../alert.jsp");
			}
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}
	
	public ActionForward bookmarkform(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String email = request.getParameter("email");
		int expenseNum = Integer.parseInt(request.getParameter("expenseNum"));
		System.out.println("bookȮ�� : "+ email + expenseNum);
		
		BookmarkDao bdao = new BookmarkDao();
		boolean book = bdao.insert(email, expenseNum);
		
		String msg1 = "";
		if(book == true) {
			msg1 = "���ε��ο� �߰��Ǿ����ϴ�";
		}
		else {
			msg1 = "�̹��߰��� �Խù��Դϴ�";
		}
		
		request.setAttribute("msg1", msg1);
		System.out.println("book �� : "+book);
		return new ActionForward(false, "../board/bookmsg.pro"); // ajax���� �����ϴ� ����
	}

	public ActionForward bookmark(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		if(LogCheck(request, response) ==1) {
			String email = (String)request.getSession().getAttribute("email");
			BookmarkDao bdao = new BookmarkDao();
			
			// ������ �ѱ��
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
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
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
			
			// "CKEditorFuncNum" : �̹� �������ž�, ck editor���� �����̸��� ��������
			request.setAttribute("fileName", fileName);
			request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
			return new ActionForward(false, "ckeditor.jsp");
		} else {
			request.setAttribute("msg", "�α����� �ʿ��մϴ�");
			request.setAttribute("url", "../member/loginForm.pro");
			return new ActionForward(false, "../alert.jsp");
		}
	}

}
