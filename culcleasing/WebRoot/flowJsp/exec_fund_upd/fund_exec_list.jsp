<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����ʽ�ƻ��ϱ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="fund_exec_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		�����ʽ�ƻ��ϱ�</td>
	</tr>
</table>
<!--�������-->

<%
//Ĭ�ϲ�ѯ���������100������� -- and DATEDIFF(dd,plan_date,getdate())>100
wherestr = " ";

String project_name = getStr( request.getParameter("project_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String is_sb = getStr(request.getParameter("is_sb"));

if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+end_date+"' ";
}
if(is_sb!=null && !is_sb.equals("")){
	wherestr+=" and sb_state ='"+is_sb+"' ";
}
countSql = "select count(id) as amount from vi_flow_exec_fundUpd where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select type as ����,id ��ʶ��,project_name ��Ŀ����,pay_way ���ʽ,fee_type_name ��������,fee_num ���,fee_name ��������,pay_obj_name '��/������',"+
	"pay_bank_name &#34;��/�����˿�������&#34;,pay_bank_no &#34;��/�����������˺�&#34;,plan_date '��/֧ʱ��',currency_name ����,plan_money '��/������',"+
	"plan_bank_name '�ƻ���/����������',plan_bank_no '�ƻ���/�������˺�',pay_type_name ���㷽ʽ from vi_flow_exec_fundUpd where 1=1"+wherestr;


%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>�ƻ�����:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
�Ƿ��ϱ���&nbsp;
<select name="is_sb" style="width: 100px;">
	 <script type="text/javascript">
     	w(mSetOpt('<%=is_sb %>',"|��|��","|��|��"));
    </script>
	
</select>
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
			<td>
			<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
			<input name="excel_name" type="hidden" value="Fund_Exec">
			
			<a href="#" accesskey="n" onclick="return validata_data_report('../../func/exp_report.jsp','fund_exec_list.jsp');">
		    <img align="absmiddle"  src="../../images/action_down.gif" alt="����" align="absmiddle">�����ʽ�����</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		
			<td>
			<a href="#" accesskey="n" onClick="impData()">
		    <img align="absmiddle"  src="../../images/action_up.gif" alt="����" align="absmiddle">�ϴ��ϱ�����</a></td>
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
	     <th>��Ŀ����</th>
	     <th>���ʽ</th>
	     <th>��������</th>
	     <th>���</th>
	     <th>��������</th>
	     <th>��/������</th>
	     <th>��/�����˿�������</th>
	     <th>��/�����������˺�</th>
	     <th>��/֧ʱ��</th>
	     <th>����</th>
	     <th>��/������</th>
	     <th>�ƻ���/����������</th>
	     <th>�ƻ���/�������˺�</th>
	     <th>���㷽ʽ</th>
		 <th>�Ƿ��ϱ�</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_flow_exec_fundUpd where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_flow_exec_fundUpd where 1=1 "+wherestr+" order by id desc ) "+wherestr ;
sqlstr +=" order by id desc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr(rs.getString("project_name")) %></td>
		<td align="center"><%=getDBStr(rs.getString("pay_way")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_obj_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_name")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("sb_state")) %></td>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
<script type="text/javascript">
 function exportData(){
 	if(confirm("�Ƿ�ȷ������excel?")){
 		dataNav.action="fund_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="fund_exec_report.jsp";
 		dataNav.target="_self";
 	}
 }

function impData(){
	window.open("fund_upload.jsp");
}

</script>
</body>
</html>
