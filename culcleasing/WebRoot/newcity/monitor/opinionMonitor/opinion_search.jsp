<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ѯǩԼ�����ѯ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_startFlowzx(proj_id){	
		window.open("http://old.eleasing.com.cn/ELeasing/ProjectWF/ProjectBEvaluate.nsf/GetWFByProjID?openagent&projid="+proj_id);
}
function sub_startFlowqy(proj_id){	
		window.open("http://old.eleasing.com.cn/ELeasing/ProjectWF/ProjectCSign.nsf/GetWFByProjID?openagent&projid="+proj_id);
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">��ѯǩԼ�����ѯ</td>
  </tr>
</table>
<!--�������-->

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_id = getStr( request.getParameter("proj_id") );

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_id!=null && !proj_id.equals("") ) {
	wherestr += " and proj_id like '%" + proj_id + "%'";
}
if((proj_id.equals("") || proj_id==null) && (proj_name.equals("") || proj_id==null)){
	wherestr+=" and 1=2";
}

countSql = "select count(proj_id) as amount from vi_proj_info where 1=1 "+wherestr;

%>

<form action="opinion_search.jsp" name="dataNav" onSubmit="return goPage()">
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="proj_name"  type="text" size="13" value="<%=proj_name %>"></td>
<td>��Ŀ���:&nbsp;<input name="proj_id"  type="text" size="13" value="<%=proj_id %>"><td>
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
        <td align="right"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>

  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>��ҵ</th>
		<th>������</th>
		<th>��������</th>
		<th>����</th>
		<th>��Ŀ����</th>
		<th>��Ŀ����</th>
		<th>��Ŀ����</th>
		<th>��������</th>
		<th>��Ŀ״̬</th>
		<th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_proj_info where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_proj_info where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td><%=getDBStr( rs.getString("proj_id"))%></td>
		<td><%= getDBStr( rs.getString("project_name") ) %></td>
		<td align="center"><%=rs.getString("industry_type_name") %></td>
		<td align="center"><%=rs.getString("cust_name") %></td>
		<td align="center"><%=rs.getString("parent_deptname")  %></td>
		<td align="center"><%=rs.getString("dept_name") %></td>
		<td align="center"><%=rs.getString("proj_manage_name") %></td>
		<td align="center"><%=rs.getString("proj_assistant_name")%></td>
		<td align="center"><%=rs.getString("proj_type") %></td>
		<td align="center"><%=rs.getString("leas_type") %></td>
		<td align="center"><%=rs.getString("status_name")  %></td>
		<td><a href="#" accesskey="m" onclick="sub_startFlowzx('<%=getDBStr( rs.getString("proj_id"))%>')">��������|���</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" accesskey="m" onclick="sub_startFlowqy('<%=getDBStr( rs.getString("proj_id"))%>')">ǩԼ����|���</a></td>
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
