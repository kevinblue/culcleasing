<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>CD����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_startFlow(){
	//�ж��Ƿ���ѡ��
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var contractId = $(":input[name='itemselect']:checked").attr("contractId");
	var projId = $(":input[name='itemselect']:checked").attr("projId");
	var projName = $(":input[name='itemselect']:checked").attr("projName");
	var projDept = "abc";

	if(	priId==undefined || priId==""){
		alert("��ѡ��CD������Ϣ��");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/CDConnect.nsf/OSNewFlowFromMenuCDJJJSP?openagent&contractId="+contractId+"&projName="+projName+"&projId="+projId+"&projDept="+projDept);
	}
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="CDConnect_KJ.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		CD����</td>
	</tr>
</table>
<!--�������-->

<%
//��ҳ��ѯ����
String czy = (String) session.getAttribute("czyid");
System.out.println("["+czy+"]");
String deptName = "";
String deptSql = "select bd.dept_name from base_user bu left join base_department bd on bd.id = bu.department where bu.id = '"+czy+"'";
rs = db.executeQuery(deptSql);
while ( rs.next() ) {
	deptName = getDBStr( rs.getString("dept_name"));
}
System.out.println("[[[[["+deptName+"]]]]]");
String project_name = getStr( request.getParameter("project_name") );
String contract_id = getStr( request.getParameter("contract_id") );

if(project_name!=null && !"".equals(project_name)){
	wherestr+= " and project_name like '%" + project_name + "%'";
}
if(contract_id!=null && !"".equals(contract_id)){
	wherestr+= " and contract_id = '" + contract_id + "'";
}

wherestr += " and (select parent_deptname from v_select_base_department bd where bd.id=(select proj_dept from contract_info ci where ci.contract_id=cd.contract_id)) = '"+deptName+"' ";

countSql = "select count(contract_id) as amount from vi_select_contract_info_ccdjj cd where 1=1 "+wherestr;
//������� - �������>0

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
	<td>               
		��Ŀ����&nbsp;<input name="project_name" type="text" value="<%=project_name %>">
	</td>
	<td>
		��ͬ���&nbsp;<input name="contract_id" type="text" value="<%=contract_id %>">
	</td>	
<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	    	<td><a href="#" accesskey="m" onclick="sub_startFlow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="����(Alt+M)" align="absmiddle">����</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>��ͬ���</th>
		<th>��Ŀ���</th>
		<th>��Ŀ����</th>    
		<th>������ʽ</th>    
		<th>��Ŀ����</th>    
		<th>��Ŀ����</th>    
		<th>������</th>    
		<th>��ҵ����</th>    
      </tr>
      <tbody id="data">
<%
String col_str=" *,(select name from base_user where id=cd.proj_assistant) proj_assistant_name ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_select_contract_info_ccdjj cd  where contract_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" contract_id from vi_select_contract_info_ccdjj cd where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
      	 <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("contract_id")) %>" contractId="<%=getDBStr( rs.getString("contract_id")) %>"
		 flag="0" projId="<%=getDBStr( rs.getString("proj_id")) %>" projName="<%=getDBStr( rs.getString("project_name")) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("leas_form")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_assistant_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("industry_name")) %></td>		
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
</body>
</html>
