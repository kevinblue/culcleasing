<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ʷ������Ϣ</title>
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
<%
//��ͬ��
String contract_id = getStr( request.getParameter("contract_id") );
String flow_date = getStr( request.getParameter("flow_date") );

//ģ�⸳ֵ
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
}

%>
<body onload="public_onload(0);">

<form action="wyhx_loadlist.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��ʷ������Ϣ</td>
	</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>��ͬ���</th>
	    <th>������</th>
	    <th>���ޱ���</th>
	    <th>��������</th>
	    <th>�������</th>
	    <th>���ⷽʽ</th>
	    <th>��������</th>
	    <th>��������</th>
	    <th>�����㷽��</th>
	    <th>����������</th>
	    <th>������</th>
	    <th>��𳥻���</th>
	    <th>���ڿ�����</th>
	    <th>������Ϣ</th>
	    <th></th>
      </tr>
      <tbody id="data">
<%
sqlstr = "select * from vi_begin_info where contract_id='"+contract_id+"' and convert(varchar(10),create_date,21)<convert(varchar(10),'"+flow_date+"',21) order by id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%= getDBStr( rs.getString("contract_id")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("begin_id")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("lease_money")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("currency_title")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("income_number")) %></td>
		<td align="center">
			<select style="width: 100px;" disabled="disabled">
				<script type="text/javascript">
					w(mSetOpt("<%= getDBStr(rs.getString("income_number_year"))%>","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
				</script>
			</select>
		</td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term")) %></td>	
		<td align="center">
			<select style="width: 60px;" disabled="disabled">
	        <script type="text/javascript">
		        w(mSetOpt('<%=getDBStr(rs.getString("period_type")) %>',"�ڳ�|��ĩ","1|0"));
	        </script>
		</td>	
		<td align="center"><%= getDBStr( rs.getString("settle_method_title")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("year_rate")) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("start_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("income_day")) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("free_defa_inter_day")) %></td>	
		<td align="center"><%= getDBStr( rs.getString("into_batch")) %></td>	
		<td align="center">
			<a href="main.jsp?begin_id=<%=getDBStr( rs.getString("begin_id")) %>&contract_id=<%=getDBStr( rs.getString("contract_id")) %>" target="_blank">
			�鿴���
			</a>
		</td>
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
