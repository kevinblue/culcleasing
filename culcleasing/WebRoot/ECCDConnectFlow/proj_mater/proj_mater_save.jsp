<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//��Ŀ����״̬�޸�
//===========================================

//��ȡ��������
String type = getStr( request.getParameter("type") );

//��������
String sqlstr = "";
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
String msg = "";
 
if("updStatus".equals(type)){
	//�޸�״̬
	String items = request.getParameter("itemStr");
	System.out.println("---"+items);
	String[] item = items.split("\\|");
	
	String text_status = "";
	String electron_status = "";
	String itemId = "";
	
	for(int i=0;i<item.length;i++){
		if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
			continue;
		}
		
		LogWriter.logDebug(request, "sqlstr:"+item.length+"----------dogcat-----"+item[i]);
		text_status = getStr(request.getParameter("text_status_"+item[i]));
		electron_status = getStr(request.getParameter("electron_status_"+item[i]));
		itemId = getStr(request.getParameter("item_"+item[i]));
		
		//upd
		sqlstr = "update contract_document_temp set text_status='"+text_status+"',electron_status='"+electron_status+"' where id='"+itemId+"' ";
		flag += db.executeUpdate(sqlstr);
	}

	LogWriter.logDebug(request, "CD���ӣ���Ŀ���Ϲ鵵ȷ��");
	
	//��־����
	String sqlLog = LogWriter.getSqlIntoDB(request, "CD����", "��Ŀ����", "ȷ����Ŀ���Ϲ鵵���:"+items, sqlstr);
	db.executeUpdate(sqlLog);
	
	msg = "��Ŀ���Ϲ鵵ȷ��";
}else if("del".equals(type)){//ɾ��ĳ��Ŀ����

}

//3�����ж�
if(flag>0){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>�ɹ�!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>ʧ��!");
		window.opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>