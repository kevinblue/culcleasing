<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ʊ�ݹ��� - �ʽ��վ���ȡ�б�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">	
//ɾ��ʱ
function validate_del() {
	//�Ƿ���ѡ�еĸ����
	var fpId = $(":checkbox[name='list']:checked").val();
	
	if(fpId==undefined){
		alert("��ѡ����Ҫɾ�����ʽ�Ʊ!");
		return false;
	}else{
		document.dataNav.action="receipt_zj_save.jsp";
		document.dataNav.target="_blank";
		document.dataNav.submit();
		document.dataNav.action="receipt_zj_flow.jsp";
		document.dataNav.target="_self";
	}
}
</script>		
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String glide_id= getStr( request.getParameter("glide_id") );
String proj_name = getStr( request.getParameter("proj_name") );
String proj_assistant_name = getStr( request.getParameter("proj_assistant_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));
if ( proj_name != null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(start_hire_date!=null && !"".equals(start_hire_date) && end_hire_date!=null && !"".equals(end_hire_date)){
	wherestr +=" and fact_date>= '"+start_hire_date+"' and fact_date<='"+end_hire_date+"'";
}
if ( proj_assistant_name!=null && !proj_assistant_name.equals("") ) {
	wherestr += " and proj_assistant_name like '%" + proj_assistant_name + "%'";
}
wherestr += " and id in(Select pri_id from invoice_draw_detail where apply_id='"+glide_id+"' and invoice_type='�ʽ��վ�')";

//��������2--���ݵ���
String expsqlstr = "select proj_id ��Ŀ���, contract_id ��ͬ���,project_name ��Ŀ����,cust_name �ͻ�����,parent_deptname ��������,";
expsqlstr += " dept_name ��������,proj_manage_name ��Ŀ����,fee_name ��������,";
expsqlstr += "fee_num �ʽ��ڴ�,plan_date Ӧ������,fact_date ʵ������,plan_money Ӧ�ս��, invoice_money ��Ʊ���,";
expsqlstr += "tax_type ˰�� ,tax_type_invoice ��ֵ˰��Ʊ���� from"; 
expsqlstr += " vi_func_fund_manage_draw_receipt where 1=1 "+wherestr;
countSql = "select count(id) as amount from vi_func_fund_manage_draw_receipt where 1=1 "+wherestr;

%>

<body onload="public_onload(0);">
<form action="receipt_zj_flow.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="savetype" value="del"/>
<input type="hidden" name="glide_id" value="<%=glide_id %>"/>


<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			Ʊ�ݹ��� - �ʽ��վ���ȡ
		</td>
	</tr>
</table><!--�������-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td >Ӧ������:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
��
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td >ʵ������:&nbsp;<input name="start_hire_date" type="text" size="15" readonly dataType="Date" value="<%=start_hire_date %>">
<img  onClick="openCalendar(start_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
��
<input name="end_hire_date" type="text" size="15" readonly dataType="Date" value="<%=end_hire_date %>">
<img  onClick="openCalendar(end_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>��Ŀ����:&nbsp;<input name="proj_assistant_name"  type="text" size="15" value="<%=proj_assistant_name %>">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ��Ŀ����','(select distinct proj_assistant_name as proj_assistant_name from vi_contract_info) a ','proj_assistant_name','','proj_assistant_name','proj_assistant_name','asc','dataNav.proj_assistant_name','');">
</td>
<td align="center"><input type="button" value="��ѯ" onclick="dataNav.submit();"></td>
<td align="center"><input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
		<%--	<td>
				<BUTTON class="btn_2" name="btndel" value="ɾ��"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;ɾ��</button>
			</td>--%> 
			<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','receipt_zj_flow.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
			</td>
			
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			</td>
		</tr>
		</table>
		<!--������ť����-->
	</td>
	<td align="right" width="90%">
	<!--��ҳ���ƿ�ʼ-->
	<%@ include file="../../public/pageSplit.jsp"%>
	</td><!--��ҳ���ƽ���-->	
	</tr>
</table>

<!--������ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
			<th width="1%"></th> 			 						
			<th>��Ŀ���</th>
			<th>��ͬ���</th>
		    <th>��Ŀ����</th>
		    <th>�ͻ�����</th>
			<th>��������</th>
		    <th>��������</th>
	     	<th>��Ŀ����</th>
	        <th>��Ŀ����</th>
			<th>��������</th>
			<th>�ʽ��ڴ�</th>
			<th>Ӧ������</th>
			<th>ʵ������</th>
		 	<th>Ӧ�ս��</th>
		 	<th>�վݽ��</th>
			<th>˰��</th>
			<th>��ֵ˰��Ʊ����</th>
		</tr>
<tbody id="data">
<%
sqlstr = "select top "+ intPageSize +" * from vi_func_fund_manage_draw_receipt  where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_fund_manage_draw_receipt where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
      	<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>	
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_assistant_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_num"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("fact_date"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("invoice_money"))%></td>	
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
	</tbody></table>
</div><!--��������-->

</form>
</body>
</html>
