<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%-- ���ε�� ��ġ�� ck editor���� �˷��ִ� ����� �ϴ� jsp

	(??? , ���, alertâ)
--%>
<script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction(${param.CKEditorFuncNum}, 'imgfile/${fileName}','�̹��� ���ε� �Ϸ�')
</script>;
