package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import action.AllAction;

// .do ��û�̵����� ���� ȣ����
@WebServlet(urlPatterns= {"*.pro"}, initParams= {@WebInitParam(name="properties", value="method.properties")})

public class ControllerMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	// Properties : map��ü�ν�, HashMap�� ���� ��ü
	private Properties pr = new Properties();
	private AllAction action = new AllAction();
	private Class[] paramType = new Class[] {HttpServletRequest.class, HttpServletResponse.class};
	
	// init : ������ ��üȭ(����) �� ���� �ٷ� ȣ��Ǵ� �޼��� (======> static�޼��尡 �ƴϱ⶧���� ��üȭ ���Ŀ� ȣ���)
	// config ��ü : �Ķ���� ����
	//             name="properties", value="method.properties"
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		// props : method.properties�� ���� ������ �ְ� ��.
		String props = config.getInitParameter("properties");
		FileInputStream f = null;
		try {
			// f : WEB-INF/method.properties ������ �б� ���� �Է� ��Ʈ��
			f = new FileInputStream(config.getServletContext().getRealPath("/") + "WEB-INF/" + props);
			
			// method.properties ���Ͽ� �ִ�
			// /model2/hello.do=hello
			// 		- Key : /model2/hello.do
			// 		- Value : hello
			pr.load(f);
			f.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
    public ControllerMethodServlet() {
        super();
    }
    
    // Ŭ���̾�Ʈ GET ��� ��û�� ȣ��Ǵ� �޼���
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// �ѱ� ȣȯ
		request.setCharacterEncoding("EUC-KR");
		
		Object[] paramObjs = new Object[] {request, response};
		ActionForward forward = null;
		String command = null;
		try {
			System.out.println(request.getRequestURI()); // /jsp_study2/model2/board/writeForm.do
			//System.out.println(request.getContextPath()); // ������Ʈ �̸�
			
			// � url�� ���Դ����� Ȯ��
			// key���� ���ƾ��� : /model2/hello.do
			command = request.getRequestURI().substring(request.getContextPath().length());
			// methodName : hello
			// �޼��� �̸��� String��, �޼��� �̸��� ��� �ٲ�� ��
			String methodName = pr.getProperty(command);
			// method ��¥ �޼��� ��ü ����
			// BoardAllAction.class Ŭ�������� 
			// �޼��� �̸��� methodName�̰�,
			// �Ű������� paramType�� �޼��带 ��ü�� ���� (�����ε��� �Ǵϱ�, �̸��� ���Ƶ� �Ű�����(����)�� �ٸ��� �ٸ� �޼��尡 ��)
			Method method = AllAction.class.getMethod(methodName, paramType);
			// invoke : �޼��� ȣ�� ���
			// hello()�޼��忡, request, response�� �Ű��������� ���� ====> action.hello(request, response)�� ȣ��
			// =====> action��ü�� �������ִ� forward�� ���޹���
			forward = (ActionForward)method.invoke(action, paramObjs);
		} catch(NullPointerException e) {
			forward = new ActionForward(); // ���ܰ� �߻��ϸ�, �׳� ��ü�� ��������
			e.printStackTrace();
		} catch(Exception e) {
			throw new ServletException(e);
		}
		
		if(forward !=null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getView()); // ���û sendRedirect
			} else {
				if(forward.getView() == null) {
					forward.setView(command.replace(".pro", ".jsp"));
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		} else response.sendRedirect("nopage.jsp"); // 404
	}
	
    // Ŭ���̾�Ʈ POST ��� ��û�� ȣ��Ǵ� �޼���
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
