<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@page import="com.condition.ZC_Package"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>资产包管理--打包数据处理页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
  </head>
  <%
  	int flag = 0;
  	String message = "";
  	//第一步：接值
  	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
  	String all_checkbos_value_s = getStr(request.getParameter("all_checkbos_value"));//租金偿还计划表中的id
  	String rent_list_value = getStr(request.getParameter("rent_list_value"));//资金偿还计划中的期项
  	String model = getStr(request.getParameter("model"));//model
  	String zc_num = getStr(request.getParameter("zc_num"));//资产编号
  	String cust_name = getStr(request.getParameter("cust_name"));//承租人
  	String cust_id = getStr(request.getParameter("cust_id_v"));//承租人编号
  	String str_contract_id = getStr(request.getParameter("str_contract_id"));//合同号
	System.out.println("zc_num==>"+zc_num);
	System.out.println("model==>"+model);
	System.out.println("cust_id==>"+cust_id);
	
	String query_cn = " select * from  vi_cust_all_info where cust_id = '"+cust_id+"'"; 
	ResultSet rsc = db.executeQuery(query_cn);
	String custName = "";
	if(rsc.next()){
		custName = getDBStr( rsc.getString("cust_name") ) ;
	}
	rsc.close();
	if(!cust_name.equals(custName)){
		cust_name = custName; 
	}
	if("add".equals(model)){
	  	//第二步：往资产包表 fund_Assets_Package新增一条资产包信息
	  	message = "资产包打包";
	  	String ins_sql_toFAP = " INSERT INTO  fund_Assets_Package ";
	           ins_sql_toFAP = ins_sql_toFAP + "(Zc_num ,UserName ,status ";
	           ins_sql_toFAP = ins_sql_toFAP + ",Caertor ,Caertor_date,Cust_id  ";
	           ins_sql_toFAP = ins_sql_toFAP + ")  VALUES ( ";
	           ins_sql_toFAP = ins_sql_toFAP + " '"+zc_num+"' ,'"+cust_name+"' ,'待提交' ";
	           ins_sql_toFAP = ins_sql_toFAP + " ,'"+user_id+"' ,getdate(),'"+cust_id+"' ) "; 
		System.out.println("往资产包表 fund_Assets_Package新增一条资产包信息==>"+ins_sql_toFAP);
	    flag = db.executeUpdate(ins_sql_toFAP);
	    if(flag > 0){
		  	//第三步：往资产包与租金计划的对应表  fund_ Assets_rent_Corresponding新增多条选中的租金偿还信息
			if(!all_checkbos_value_s.equals("") && all_checkbos_value_s != null){
		  		String[] id = all_checkbos_value_s.split("#");//解析所有的编号
		  		String[] rent_list = rent_list_value.split("#");//解析所有的期项
		  		String[] contract_id = str_contract_id.split("#");//解析所有的合同号
		  		StringBuffer sql = new StringBuffer();
		  		for(int i = 0;i < id.length;i++){
		  			sql.append(" INSERT INTO  fund_Assets_rent_Corresponding  ")
					    .append("       (Zc_num ,Contract_id ,Chjx_id ")
					    .append("        ,Rent_list ,Caertor ")
					    .append("        ,Caertor_date  ")
					    .append("        )  VALUES ( ")
					    .append("         '"+zc_num+"' ,'"+contract_id[i]+"' ")
					    .append("        ,'"+id[i]+"' ,'"+rent_list[i]+"' ")
					    .append("        ,'"+user_id+"' ,getdate()) ")
		  			   .append(" ; ");
		  		}
		  		System.out.println("往资产包与租金计划的对应表==>"+sql);
		  		flag = db.executeUpdate(sql.toString());
		  	}
	    }
	}
	if("del".equals(model)){//删除资产包操作，需要先删除
		//删除前先判断发票表中的发票编码是不是存在
		ZC_Package zc_Package = new ZC_Package();	
		boolean flag_cz = zc_Package.queryFpNum(zc_num);//发票编号是否存在
		
		if(!flag_cz){//发票编号存在是不允许删除的
			message = "资产包删除";
			//删除操作 ，需要删除资产包，发票对应的一起四张表
			String del_sql1 = " delete from fund_Assets_Package where  Zc_num = '"+zc_num+"'";
			String del_sql2 = " delete from fund_Assets_rent_Corresponding  where  Zc_num = '"+zc_num+"'";
			String del_sql3 = " delete from fund_Assets_Invoice_Corresponding   where  Zc_num = '"+zc_num+"'";
			String del_sql4 = " delete from fund_Assets_Invoice where id in ( select fp_id from fund_Assets_Invoice_Corresponding where  Zc_num = '"+zc_num+"' ) ";
			//System.out.println("--del_sql1"+del_sql1);
			flag = db.executeUpdate(del_sql1);
			//System.out.println("--flag1"+flag);
			flag = flag + db.executeUpdate(del_sql2);
			//System.out.println("--flag2"+flag);
			flag =  flag + db.executeUpdate(del_sql3);
			//System.out.println("--flag3"+flag);
			flag =  flag + db.executeUpdate(del_sql4);
			System.out.println("--flag:"+flag);
		}else{
			message = "发票编号已存在,资产包删除";
		}
		
	}
  	
  	//
  	if(!"del".equals(model)){
  	
   		if(flag > 0){
			String hrefStr="";
%>
		        <script>
					opener.opener.alert("<%=message%>成功!");
					opener.opener.location.reload();
					window.close();
					opener.window.close();
				</script>
<%
		}else{
%>
	        <script>
				opener.opener.alert("<%=message%>失败!");
					opener.opener.location.reload();
					window.close();
					opener.window.close();
			</script>
<%	
		}

  	}else{//打包删除操作的
  		if(flag > 0){
			String hrefStr="";
%>
		        <script>
					opener.alert("<%=message%>成功!");
					opener.location.reload();
					window.close();
				</script>
<%
		}else{
%>
	        <script>
				opener.alert("<%=message%>失败!");
				opener.location.reload();
				window.close();
			</script>
<%	
		}
	}
%>
</html>
<%if(null != db){db.close();}%>