<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- 2010-08-05�޸�Ϊ��com.rent.calc.tx.TransRateNew ��ǰ��ֵΪ��com.rent.calc.TransRate -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>

<BODY>
<%
	System.out.println("��Ŀ������Ϣά����aaaaaaaaaaaaaaaaa");
	System.out.println("�ҵĲ��Ե�½�ˣ�"+dqczy);
	String czyid =(String) session.getAttribute("czyid");
	//String czyid =getStr(request.getParameter("czyid"));
	String datestr = getSystemDate(0);
	
	String id_list = getStr(request.getParameter("id_list"));
	String contract_id_list = getStr(request.getParameter("contract_id_list"));
	String begin_id_list = getStr(request.getParameter("begin_id_list"));	
	String is_normal_list = getStr(request.getParameter("is_normal_list"));
	String is_advance_list = getStr(request.getParameter("is_advance_list")); 
	String creator_list = getStr(request.getParameter("creator_list")); 
	String create_date_list = getStr(request.getParameter("create_date_list")); 
	String modificator_list = getStr(request.getParameter("modificator_list")); 
	String modify_date_list = getStr(request.getParameter("modify_date_list")); 
	String statues_list = getStr(request.getParameter("statues_list")); 
	
	String is_normal = getStr(request.getParameter("invoice_is_normal")); 
	String is_advance = getStr(request.getParameter("invoice_is_advance")); 
	
	System.out.println("�Ƿ�������"+is_normal+";�Ƿ���ǰ��"+is_advance);
	
	//ResultSet rs;
	String [] id_arr = id_list.split("#");
	String [] contract_arr = contract_id_list.split("#");
	String [] begin_arr = begin_id_list.split("#");	
	String [] is_normal_arr = is_normal_list.split("#");
	String [] is_advance_arr = is_advance_list.split("#");
	String [] creator_arr = creator_list.split("#");
	String [] create_date_arr = create_date_list.split("#");
	String [] modificator_arr = modificator_list.split("#");
	String [] modify_date_arr = modify_date_list.split("#");
	String [] statues_arr = statues_list.split("#");
	
	System.out.println(id_arr.length+"------"+contract_arr.length+"_--------------"+statues_arr.length);
	
	String message = "����ά��"+id_arr.length+"��;";
	
	for(int i=0;i<id_arr.length;i++){
		int  num=0;
		String	 sql="";
		if("��".equals(statues_arr[i])){
			sql = " insert  into  [dbo].[contract_invoice_item](contract_id,begin_id,contract_is_normal,contract_is_advance,is_save,"+
						 "creator,create_date,modificator,modify_date) "+
						 " values(";
				   sql+="'"+contract_arr[i] +"',";
				   sql+="'"+begin_arr[i] 	+"',";
				   sql+="'"+is_normal		+"',";
				   sql+="'"+is_advance	    +"',";
				   sql+="'"+"��"	    	+"',";
				   sql+="'"+czyid			+"',";
				   sql+="'"+datestr			+"',";
				   sql+="'"+"null"			+"',";
				   sql+="null";
				   sql+=")";
		}else{
				sql = " update  [dbo].[contract_invoice_item]  set contract_is_normal='"+is_normal+
					"',contract_is_advance='"+is_advance+"',modificator='"+czyid+"',modify_date='"+datestr+"'";					 
				sql+=" where  contract_id='"+contract_arr[i] +"'"+" and  begin_id='"+begin_arr[i]+"'";
			
		}
			System.out.println("sql="+sql);
			//rs.close();
			num = db.executeUpdate(sql);
			if(num==0){
				message +="��ͬ�ţ�"+contract_arr[i]+"��Ϣά��ʧ��;";
			}
	}
	db.close();
%>
	<script>		
		window.alert("<%=message%>�ɹ�!");
		window.opener.location.reload();
		window.opener=null;
		window.open("","_self");
		setTimeout("self.close()",100);
		
		
		
	</script>
