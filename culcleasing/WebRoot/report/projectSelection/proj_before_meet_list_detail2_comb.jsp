<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�Ǳ��ǰ�ͻ���Ϣͳ�Ʊ�-��ϸ </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="proj_before_meet_list_detail2_comb.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<%
String cust_idnew  = getStr( request.getParameter("cust_id") );

%>
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="cust_id" value="<%=cust_idnew%>">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		�����ϸ</td>
	</tr>
</table> 
<%
wherestr = "";
String cust_id = getStr( request.getParameter("cust_id") );
String project_name = getStr( request.getParameter("project_name") );
if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and ci.project_name like '%" + project_name + "%'";
}
//2013-08-02������ѯ����
countSql = "select count(proj_id) as amount from vi_fund_rent_plan_comb frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id where ci.cust_id='"+cust_id+"'" +wherestr;
%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>

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
	  <th align="center"></th> 
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>������</th>
	 	<th>����ڴ�</th>
	 	<th>�ƻ�����</th>
		<th>ʵ������</th>
	 	<th>���</th>
		<th>ʣ�����</th>
		<th>ʣ�����</th>
	 	<th>����</th>
	 	<th>��Ϣ</th>
	 	<th>״̬</th>
      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" ci.proj_id,ci.project_name,frp.begin_id,frp.rent_list,frp.plan_date,frp.rent,frp.curr_rent,frp.plan_status,(select MAX(hire_date) from (select * from fund_rent_income union select * from CulcLeasingTJ.dbo.fund_rent_income) fri where fri.match_id=frp.id)"; 
sqlstr +="hire_date,";
sqlstr +="isnull(frp.rent_diff,0) rent_diff,frp.corpus,frp.interest from vi_fund_rent_plan_comb frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id ";
sqlstr +="where frp.id not in( select top "+ (intPage-1)*intPageSize +" frp.id from vi_fund_rent_plan_comb  frp left join vi_contract_info_comb ci on ci.contract_id=frp.contract_id where ci.cust_id='"+cust_id+"' "+wherestr+" order by ci.proj_id,frp.begin_id,rent_list ) and  " ;
sqlstr +=" ci.cust_id='"+cust_id+"' "+wherestr+" order by ci.proj_id,frp.begin_id,rent_list";


rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>  


     <tr class="materTr_<%=index_no %>">
		<td></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        
		<td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent_diff"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		
      </tr>
<%}
			System.out.println("test=========="+index_no);
rs.close();
db.close();
%>   
     </tbody>
</table>
</div>
</form>

</body>
</html>
