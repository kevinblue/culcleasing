<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");

String cust_id = getStr( request.getParameter("cust_id") );
String acc_number = getStr( request.getParameter("acc_number") );
String bank_name = getStr( request.getParameter("bank_name") );
String account = getStr( request.getParameter("account") );
String acc_status = getStr( request.getParameter("acc_status") );
String bank_addr = getStr( request.getParameter("bank_addr") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr = "";
ResultSet rs = null;
	//String systemDate = getSystemDate(0);
String datestr = getSystemDate(0); //��ȡϵͳʱ��
if ( stype.equals("add") ){        //��Ӳ���
		int flag = 0;
		//���ж���ʹ���˺�ֻ��һ��	
		sqlstr = "select id from cust_account where cust_id='"+cust_id+"' and acc_status='��' ";
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			if(acc_status!=null && "��".equals(acc_status)){
				flag = -1;
			}
		}
		rs.close();
		
		if(flag!=-1){
			sqlstr = "insert into cust_account (cust_id, acc_number,bank_addr, bank_name, account, acc_status, creator ,create_date,modificator,modify_date ) values ('" + cust_id + "','" + acc_number + "','"+bank_addr+"','" + bank_name + "','" + account + "','" + acc_status + "','" + dqczy + "','" + datestr +"','"+dqczy+"','"+datestr+"')";
			System.out.println("sqlstrsqlstr=="+sqlstr);
			db.executeUpdate(sqlstr); 
		}
		if(flag==-1){
%>
		<script>
			window.close();
			opener.alert("�ÿͻ��Ѿ���һ�ʻ�����ʹ�ã������ٴ����!");
			opener.location.reload();
		</script>
<%		
		}else{
%>
		<script>
			window.close();
			opener.alert("��ӳɹ�!");
			opener.location.reload();
		</script>
<%
		}
}
if ( stype.equals("mod") ){      //�޸Ĳ���
	String czid = getStr( request.getParameter("czid") );
	
		sqlstr = "update cust_account set acc_number='" + acc_number + "',bank_addr='"+bank_addr+"',bank_name='" + bank_name + "',account='" + account + "',acc_status='" + acc_status + "',modificator='" + dqczy  + "',modify_date='" + datestr + "' where id='" + czid + "'";
		System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("�޸ĳɹ�!");
			opener.location.reload();
		</script>
<%
	
}
if ( stype.equals("del") ){         //ɾ������
	
	String czid = getStr( request.getParameter("czid") );
//2014-07-29 �������������ʺű�ɾ������ʱע�͵��˴����
//	sqlstr = "delete from cust_account where id='" + czid + "'";
//	db.executeUpdate(sqlstr); 
%>
	<script>
		window.close();
		opener.alert("ɾ���ɹ�!");
		opener.location.reload();
	</script>
<%			
}
db.close();
%>


</BODY>
</HTML>
