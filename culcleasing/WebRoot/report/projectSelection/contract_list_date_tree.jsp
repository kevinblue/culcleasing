<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ͻ��� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="contract_list_date_tree.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��Ŀʱ����</td>
	</tr>
</table> 

<%
String projId = getStr(request.getParameter("proj_id"));
%>
<!--���۵���ѯ��ʼ-->
	<%-- <div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;����Ŀ��ѯ
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	
	<td scope="row" id="bj_4">��Ŀ��ţ�&nbsp;
	<input type="text" id="proj_id" name="proj_id" value="<%=projId %>"/>
</td>
<td>			
	<input type="submit" value="ȷ��" >
	&nbsp;&nbsp;
	<input type="button" value="���" onclick="clearQuery();" >
	</td>
	
	</tr>
	</table>
	</fieldset>
	</div> --%>
	<!--���۵���ѯ����-->
<input type="hidden" name="proj_id" value="<%=projId %>"/>
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:scroll;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;overflow:scroll;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>���</th>
		<th>ʱ���</th>
		<th>&nbsp;&nbsp;</th>
		<th>ʱ��</th>
		<th>��ע</th>
      </tr>
   <tbody id="data">
<%
int index_no =0;

String lxsj = "";
String xckcsj="";String bgcjsj="";

String qysplcsj1="";String qysplcsj2="";String qysplcsj3="";String qysplcsj4="";String qysplcsj5="";

String qysj1="";String qysj2="";String qysj3="";String qysj4="";String qysj5="";
String cdjjsj1="";String cdjjsj2="";String cdjjsj3="";String cdjjsj4="";String cdjjsj5="";
String fksj = "";
//����ʱ��
String sqlLxsj = "select flow_end_time from sys_flow_list where flow_name like '%��Ŀ��������%' and project_id = '" + projId + "'";
rs = db.executeQuery(sqlLxsj);
if( rs.next() ) {
	lxsj = getDBDateStr(rs.getString("flow_end_time"));
}
//2�ֳ�����ʱ�䣬3�������ʱ��
String sqlXckcsj ="select TYzkkcsj,TYxmdjsj,TYbgscsj from proj_industry_InspectionInformation where proj_id = '" + projId + "'";
rs = db.executeQuery(sqlXckcsj);
if( rs.next() ) {
	xckcsj = getDBDateStr(rs.getString("TYzkkcsj"));
	bgcjsj = getDBDateStr(rs.getString("TYbgscsj"));
}
//ǩԼ��������ʱ��
String sqlQysplcsj = "select top 5 flow_end_time from sys_flow_list where ( flow_name like '%ǩԼ%' or flow_name like '%��ͬ���%' ) and flow_end_time is not null and project_id = '" + projId + "'";
rs = db.executeQuery(sqlQysplcsj);
if( rs.next() ) {
	qysplcsj1 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	qysplcsj2 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	qysplcsj3 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	qysplcsj4 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	qysplcsj5 = getDBDateStr(rs.getString("flow_end_time"));
}

//ǩԼʱ��
String sqlQysj ="select top 5 fact_sign_date from contract_list_info where fact_sign_date is not null and proj_id = '" + projId + "' group by fact_sign_date order by fact_sign_date ";
rs = db.executeQuery(sqlQysj);
if( rs.next() ) {
	qysj1 = getDBDateStr(rs.getString("fact_sign_date"));
}
if( rs.next() ) {
	qysj2 = getDBDateStr(rs.getString("fact_sign_date"));
}
if( rs.next() ) {
	qysj3 = getDBDateStr(rs.getString("fact_sign_date"));
}
if( rs.next() ) {
	qysj4 = getDBDateStr(rs.getString("fact_sign_date"));
}
if( rs.next() ) {
	qysj5 = getDBDateStr(rs.getString("fact_sign_date"));
}
//cd����ʱ��
String sqlCdjjsj ="select top 5 flow_end_time from sys_flow_list where flow_end_time is not null and flow_name in ('CD��������','����CD��������') and project_id = '" + projId + "' group by flow_end_time order by flow_end_time ";
rs = db.executeQuery(sqlCdjjsj);
if( rs.next() ) {
	cdjjsj1 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	cdjjsj2 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	cdjjsj3 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	cdjjsj4 = getDBDateStr(rs.getString("flow_end_time"));
}
if( rs.next() ) {
	cdjjsj5 = getDBDateStr(rs.getString("flow_end_time"));
}
//����ʱ��
String sqlFksj ="select  fact_date from vi_contract_fund_fund_charge_condition where fee_type ='17' and proj_id = '" + projId + "'";
rs = db.executeQuery(sqlFksj);
if( rs.next() ) {
	fksj = getDBDateStr(rs.getString("fact_date"));
}
rs.close();
db.close();
%>   
     <tr class="materTr_<%=index_no++ %>">
		<td align="left">1</td>
		<td align="left">����ʱ��</td>
        <td align="left">&nbsp;&nbsp;</td>
        <td align="left"><%=lxsj%></td>
        <td align="left">ȡϵͳʱ�䣨���������</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">2</td>
		<td align="left">�ֳ�����ʱ��</td>
        <td align="left">&nbsp;&nbsp;</td>
        <td align="left"><%=xckcsj%></td>
        <td align="left">�ʿ�������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">3</td>
		<td align="left">�������ʱ��</td>
        <td align="left">&nbsp;&nbsp;</td>
        <td align="left"><%=bgcjsj%></td>
        <td align="left">�ʿ�������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">4</td>
		<td align="left">ǩԼ��������ʱ��</td>
        <td align="left">��һ��ǩԼ��������ʱ��</td>
        <td align="left"><%=qysplcsj1%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�ڶ���ǩԼ��������ʱ��</td>
        <td align="left"><%=qysplcsj2%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">������ǩԼ��������ʱ��</td>
        <td align="left"><%=qysplcsj3%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">���Ĵ�ǩԼ��������ʱ��</td>
        <td align="left"><%=qysplcsj4%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�����ǩԼ��������ʱ��</td>
        <td align="left"><%=qysplcsj5%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">5</td>
		<td align="left">ǩԼʱ��</td>
        <td align="left">��һ��ǩԼʱ��</td>
        <td align="left"><%=qysj1%></td>
        <td align="left">��ҵ����������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�ڶ���ǩԼʱ��</td>
        <td align="left"><%=qysj2%></td>
        <td align="left">��ҵ����������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">������ǩԼʱ��</td>
        <td align="left"><%=qysj3%></td>
        <td align="left">��ҵ����������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">���Ĵ�ǩԼʱ��</td>
        <td align="left"><%=qysj4%></td>
        <td align="left">��ҵ����������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�����ǩԼʱ��</td>
        <td align="left"><%=qysj5%></td>
        <td align="left">��ҵ����������д</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">6</td>
		<td align="left">CD����ʱ��</td>
        <td align="left">��һ��CD����ʱ��</td>
        <td align="left"><%=cdjjsj1%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�ڶ���CD����ʱ��</td>
        <td align="left"><%=cdjjsj2%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">������CD����ʱ��</td>
        <td align="left"><%=cdjjsj3%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">���Ĵ�CD����ʱ��</td>
        <td align="left"><%=cdjjsj4%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">&nbsp;&nbsp;</td>
		<td align="left">&nbsp;&nbsp;</td>
        <td align="left">�����CD����ʱ��</td>
        <td align="left"><%=cdjjsj5%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>
      <tr class="materTr_<%=index_no++ %>">
		<td align="left">7</td>
		<td align="left">����ʱ��</td>
        <td align="left">&nbsp;&nbsp;</td>
        <td align="left"><%=fksj%></td>
        <td align="left">ȡϵͳʱ��</td>
      </tr>


     </tbody>
</table>
</div>
</form>

</body>
</html>
