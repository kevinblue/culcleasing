<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tenwa.culc.util.ERPDataSource"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同基本信息</title>

<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
</head>


<%
	String contractid = getStr( request.getParameter("contract_id") );	
	String doc_id = getStr( request.getParameter("doc_id") );
	//获得当前登录人
   // String wh_userid=(String) session.getAttribute("czyid");                  

    String sqlstr="select contract_id,cust_name,approve_process,manager_project,proj_type,cust_id,proj_id,project_name,dept_name,proj_manage_name,proj_assistant_name,industry_type_name,leas_form,leas_type from vi_contract_info"; 
      sqlstr += " where contract_id ='"+contractid+"'";
%>

<%
	String contract_id;
	String cust_name;
	String cust_id;
	String proj_id;
	String project_name;		
	String dept_name;
    String proj_manage_name;	
    String proj_assistant_name;  
	String industry_type_name;
	String leas_form;
	String leas_type;
	String proj_type;
	String manager_project;
	String approve_process;
	
	ResultSet rs = db1.executeQuery(sqlstr);
	if( rs.next() ){
		contract_id=getDBStr(rs.getString("contract_id"));
		cust_name=getDBStr(rs.getString("cust_name"));
		cust_id=getDBStr(rs.getString("cust_id"));
		proj_id=getDBStr(rs.getString("proj_id"));
		project_name=getDBStr(rs.getString("project_name"));
		dept_name=getDBStr(rs.getString("dept_name"));
		proj_manage_name=getDBStr(rs.getString("proj_manage_name"));
		proj_assistant_name=getDBStr(rs.getString("proj_assistant_name"));
		industry_type_name=getDBStr(rs.getString("industry_type_name"));
		leas_form=getDBStr(rs.getString("leas_form"));
		leas_type=getDBStr(rs.getString("leas_type"));
	    proj_type=getDBStr(rs.getString("proj_type"));
		manager_project=getDBStr(rs.getString("manager_project"));
		approve_process=getDBStr(rs.getString("approve_process"));
		
%>
<body  onload="public_onload();fun_winMax();" style="overflow:auto;">
<form name="form1">
<table  class="title_top" width=100% height="100" align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
	<td  align=center width=100% height=100%>
 
<table  border="0" cellspacing="0" cellpadding="0" width="98%" height="20px" align="center" class="tab_table_title">


		<tr>
			<td scope="row" nowrap>项目编号</td>
				<td>
					<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" readonly 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			
			<td scope="row" nowrap>合同编号</td>
				<td>
					<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" readonly 
		    		  size="35" maxlength="30"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				</td>
		</tr>
   
		
		<tr>
			<td scope="row" nowrap>承租客户</td>
				<td>
					<input name="cust_name" id="cust_name" type="text" value="<%=cust_name%>" readonly 
						size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				</td>
				
			<td scope="row" nowrap>客户编号</td>
				<td>
					<input name="cust_id" id="cust_id" type="text" value="<%=cust_id%>" readonly 
						size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				</td>
		</tr>
		
		
		<tr>
			<td scope="row" nowrap>租赁类型</td>
				<td>
					<input name="leas_form" id="leas_form" type="text" value="<%=leas_form%>" readonly 
						  size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				 </td>
			<td scope="row" nowrap>租赁形式</td>
				<td>
					<input name="leas_type" id="leas_type" type="text" value="<%=leas_type%>" readonly 
						  size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				 </td>
		</tr>
   
	  <tr>
		<td scope="row" nowrap>行业分类</td>
		    <td>
		    	<input name="industry_type_name" id="industry_type_name" type="text" value="<%=industry_type_name%>" readonly 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>项目类型</td>
		    <td>
		    	<input name="proj_type" id="proj_type" type="text" value="<%=proj_type%>" readonly 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
		</tr>
	
  
		<tr>
			<td scope="row" nowrap>出单部门</td>
				<td>
					<input name="dept_name" id="dept_name" type="text" value="<%=dept_name%>" readonly 
						  size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				 </td>
			<td scope="row" nowrap>项目管理/投资工资</td>
				<td>
					<input name="manager_project" id="manager_project" type="text" value="<%=manager_project%>" readonly 
						  size="35" maxlength="50"/>
						
				 </td>
		</tr>
		
	
		<tr>	 
			 <td scope="row" nowrap>项目名称</td>
				<td>
					<input name="project_name" id="project_name" type="text" value="<%=project_name%>" readonly 
						size="80" maxlength="100"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				</td>
	
			<td scope="row" nowrap>项目经理</td>
		    <td>
		    	<input name="proj_manage_name" id="proj_manage_name" type="text" value="<%=proj_manage_name%>" readonly 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
	  </tr>
	  
	  
	  
		<tr>	 
			 <td scope="row" nowrap>审批程序</td>
				<td>
					<input name="approve_process" id="approve_process" type="text" value="<%=approve_process%>" readonly 
						 size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				</td>
	
			 <td scope="row" nowrap>项目助理</td>
				<td>
					<input name="proj_assistant_name" id="proj_assistant_name" type="text" value="<%=proj_assistant_name%>" readonly 
						  size="35" maxlength="50"/>
						<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
					<span class="biTian">*</span>
				 </td>
	  </tr>
	  
	  
	 
	  
  
</table>
	<%
}
rs.close();
db1.close();
%>



<!-- end cwToolbar -->
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>
