<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@ page import="com.tenwa.log.LogWriter"%>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
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
dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
String msg = "";
 
if("updStatus".equals(type)){
	//�޸�״̬
	String items = request.getParameter("itemStr");
	System.out.println("---"+items);
	String[] item = items.split("\\|");
	
	String invoice_is = "";
	String itemId = "";
	String begin_id="";
	String rent_list="";
	String create_date="";
	String invoice_remark="";
	String creator="";
	String modificator="";
	String modify_date="";
	
	for(int i=0;i<item.length;i++){
		if(item[i]==null || "".equals(item[i]) || "|".equals(item[i])){
			continue;
		}
		
		LogWriter.logDebug(request, "sqlstr:"+item.length+"----------dogcat-----"+item[i]);
		invoice_is = getStr(request.getParameter("invoice_is_"+item[i]));
		itemId = getStr(request.getParameter("item_"+item[i]));
		begin_id=getStr(request.getParameter("begin_id_"+item[i]));
		rent_list=getStr(request.getParameter("rent_list_"+item[i]));
		create_date=getStr(request.getParameter("create_date_"+item[i]));
		invoice_remark=getStr(request.getParameter("invoice_remark_"+item[i]));
		creator=getStr(request.getParameter("creator_"+item[i]));
		modificator=getStr(request.getParameter("modificator_"+item[i]));
		modify_date=getStr(request.getParameter("modify_date_"+item[i]));
		//upd
		
		int t=0;
		
		sqlstr="select count(*) t from invoice_rent_detail where begin_id='"+begin_id+"'and rent_list='"+rent_list+"'and creator='"+creator+"'";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			t=rs.getInt("t");
		}
		if(t==1){
			sqlstr = "update invoice_rent_detail set invoice_is='"+invoice_is+"' , invoice_remark='"+invoice_remark+"'";
			sqlstr+=", modificator='"+modificator+"'";
			sqlstr+="begin_id='"+begin_id+"'and rent_list='"+rent_list+"'and creator='"+creator+"'";
			LogWriter.logDebug(request, "��Ҫ��sqlstr"+sqlstr);	
			flag += db.executeUpdate(sqlstr);
		}else{

			sqlstr="insert into invoice_rent_detail values('"+begin_id+"','"+rent_list+"','"+invoice_is+"','"+invoice_remark+"','"+creator+"','"+create_date+"','"+modificator+"','"+modify_date+"')";
			LogWriter.logDebug(request, "��Ҫ��sql"+sqlstr);
			flag = db.executeUpdate(sqlstr);
		}
	}
	
	LogWriter.logDebug(request, "CD���ӣ���Ŀ���Ϲ鵵ȷ��");
	
	//��־����
	String sqlLog = LogWriter.getSqlIntoDB(request, "CD����", "��Ŀ����", "ȷ����Ŀ���Ϲ鵵���:"+items, sqlstr);
	db.executeUpdate(sqlLog);
	
	msg = "��Ŀ���Ϲ鵵ȷ��";
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