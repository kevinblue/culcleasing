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

String id = getStr( request.getParameter("id") );
String doc_id = getStr( request.getParameter("doc_id") );
String contract_id = getStr( request.getParameter("contract_id") );
String cust_id = getStr( request.getParameter("cust_id") );
String acc_number = getStr( request.getParameter("acc_number") );
String bank_name = getStr( request.getParameter("bank_name") );
String account = getStr( request.getParameter("account") );
String acc_status = getStr( request.getParameter("acc_status") );
String bank_addr = getStr( request.getParameter("bank_addr") );
String stype = getStr( request.getParameter("savetype") );
String memo = getStr(request.getParameter("memo"));
String sqlstr = "";
String is_del = "";
String temp_id = "";
ResultSet rs = null;
	//String systemDate = getSystemDate(0);
String datestr = getSystemDate(0); //��ȡϵͳʱ��
if ( stype.equals("add") ){        //��Ӳ���
		int flag = 0;
		//���ж���ʹ���˺�ֻ��һ��	
		sqlstr = "select id,isnull(is_del,0) is_del from contract_cust_account_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and account_id='"+id+"'";
		rs = db.executeQuery(sqlstr);
		if(rs.next()){
			is_del = getDBStr(rs.getString("is_del"));
			temp_id = getDBStr(rs.getString("id"));
			
			if("0".equals(is_del)){
				flag = -1;
			}else {
				flag=1;
				
			}
		}
		rs.close();
		
		if(flag!=-1){
			if(flag==1){
				sqlstr="update contract_cust_account_temp set is_del=0 where id='"+temp_id+"'";
				System.out.println("sqlstr1111111111="+sqlstr);
			}else{
			sqlstr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,creator,create_date,memo)";
			sqlstr += " select '"+contract_id+"','"
					+ doc_id
					+ "',id,'" + dqczy + "',getdate(),'" + memo + "' from cust_account where id='"+id+"'";
			}
			System.out.println("sqlstrsqlstr=="+sqlstr);
		db.executeUpdate(sqlstr);
		}
		
		if(flag==-1){
%>
		<script>
			window.close();
			opener.alert("���ʻ��Ѿ����ڣ������ٴ����!");
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
	sqlstr = "update contract_cust_account_temp set account_id='"+id+"',memo='" + memo + "',modificator='" + dqczy + "',modify_date=getdate() where id='" + czid + "'";
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
	sqlstr = "update  contract_cust_account_temp set is_del=1 where id='" + czid + "'";
	db.executeUpdate(sqlstr); 
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
