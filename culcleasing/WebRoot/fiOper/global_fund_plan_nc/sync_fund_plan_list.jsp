<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ��ո��ƻ�����ͬ�� </title>
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
<form action="sync_fund_plan_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		�ʽ��ո��ƻ�����ͬ��</td>
	</tr>
</table> 

<%
wherestr = "";
String proj_name = getStr( request.getParameter("proj_num") );
if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}

//2013-08-02������ѯ����
countSql ="SELECT count(invcode) as amount FROM vi_INTERFACE_fina_global_fundplan_nc WHERE isnull(invcode,'')<>'' "
	+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>'' and nc_deptno<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'"+wherestr;
%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ��ţ�&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td align="right"> <input type="button" value="��ѯ" onclick="dataNav.submit();">
<input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->
<!--���۵���ѯ��ʼ-->

<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
    <td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="n" onClick="dataHander('add_modal','fundplan_info_add.jsp',dataNav.itemselect);">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="����ִ��ͬ��" align="absmiddle">������Ŀͬ��</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
		<!-- ��ҳ���� -->
		<td width="60%" align="right"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->
		</td><!-- ��ҳ���� -->
</tr>
</table>

<!--������ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	  <th align="center"></th> 
	    <th>��Ŀ���</th>
	 	<th>��Ŀ����</th>
	    <th>����ͻ�</th>
	    <th>��/������</th>
	    <th>��������</th>
		<th>���</th>
		<th>�ƻ�����</th>
	    <th>��������</th>
		<th>��ͬ��</th>
	 	<th>�����ʶ</th>
	 	<th>��Ŀ����</th>
      </tr>
   <tbody id="data">
<%


sqlstr = "SELECT * FROM vi_INTERFACE_fina_global_fundplan_nc WHERE isnull(invcode,'')<>'' "
	+ "AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>'' and nc_deptno<>'' and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'"+wherestr;

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td></td>
        <td align="left"><%=getDBStr(rs.getString("ccodetrust"))%></td>
        <td align="left"><%=getDBStr(rs.getString("ccode"))%></td><!--
        <td align="left">
        <a href="proj_before_meet_main.jsp?cust_id=<%=getDBStr( rs.getString("cust_id") )  %>" target="_blank"><%=getDBStr( rs.getString("cust_name") )  %></a>
        </td>
        -->
        <td align="left"><%=getDBStr(rs.getString("bcode"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tenancytype"))%></td>
		
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("picode"))%></td>
		<td align="left"><%=getDBStr(rs.getString("pcode"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("ordcode"))%></td>
		<td align="left"></td>
		<td align="left"><%=getDBStr(rs.getString("changesign"))%></td>
		<td align="left"><%=getDBStr(rs.getString("odate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invtype"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rmb"))%></td>
      </tr>
<%}		
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>