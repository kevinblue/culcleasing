<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String item_id = getStr( request.getParameter("item_id") );
String order_number = getStr( request.getParameter("order_number") );
String standard = getStr( request.getParameter("standard") );
String disp_name = getStr( request.getParameter("disp_name") );
String value = getStr( request.getParameter("value") );
String veto_flag = getStr( request.getParameter("veto_flag") );
String his_flag = getStr( request.getParameter("his_flag") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //��ȡϵͳʱ��
boolean flag = true;
if ( stype.equals("add") ){        //��Ӳ���
		sqlstr = "select count(*) from base_evaluation_standard where item_id="+item_id+" and disp_name='"+disp_name+"'";
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			if(rs.getInt(1)>0){
				flag = false;
			}
		}
		if(flag){
		sqlstr = "insert into base_evaluation_standard (item_id,order_number,standard,disp_name,value,veto_flag,his_flag,creator ,create_date ) values (" + item_id + ","+order_number+",'"+standard+"','"+disp_name+"',"+value+","+veto_flag+",'"+his_flag+"','"+ dqczy + "'," + datestr +  ")";
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr); 

%>
		<script>
			window.close();
			opener.alert("��ӳɹ�!");
			opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.close();
			opener.alert("���ֱ�׼�Ѵ��ڣ����ʧ��!");
			opener.location.reload();
		</script>
<%
		}
}
if ( stype.equals("mod") ){      //�޸Ĳ���
	//String czid = getStr( request.getParameter("id") );
		sqlstr = "select count(*) from base_evaluation_standard where item_id="+item_id+" and disp_name='"+disp_name+"' and standard_id<>"+czid;
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			if(rs.getInt(1)>0){
				flag = false;
			}
		}
		if(flag){
		sqlstr = "update base_evaluation_standard set item_id=" + item_id +",order_number="+order_number+",standard='"+standard+"',disp_name='"+disp_name+"',value="+value+",veto_flag="+veto_flag+",his_flag='"+his_flag+ "',modificator='" + dqczy  + "',modify_date=" + datestr + " where standard_id=" + czid ;
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("�޸ĳɹ�!");
			opener.location.reload();
		</script>
<%
		}else{
%>
		<script>
			window.close();
			opener.alert("���ֱ�׼�Ѵ��ڣ��޸�ʧ��!");
			opener.location.reload();
		</script>
<%		
		}
}
if ( stype.equals("del") ){         //ɾ������
	
	//String czid = getStr( request.getParameter("id") );
	sqlstr = "delete from base_evaluation_standard where standard_id=" + czid;
	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("ɾ���ɹ�!");
		opener.location.reload();
	</script>
<%			
}
if ( stype.equals("qy") ){            //���ùر�
		sqlstr = "update base_evaluation_standard set his_flag='"+his_flag+ "',modificator='" + dqczy  + "',modify_date=" + datestr + " where standard_id=" + czid;
		//System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("<%=his_flag.equals("0")?"����":"�ر�"%>�ɹ�!");
			opener.location.reload();
		</script>
<%
}
db.close();
%>


</BODY>
</HTML>

