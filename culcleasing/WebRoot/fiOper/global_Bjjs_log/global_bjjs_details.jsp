<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="/public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ӿ� -�����˰����ֵ˰��</title>
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
 
	 String oper_id = getStr( request.getParameter("oper_id") );


%>
<body onload="public_onload(0);">

<form action="global_bjjs_details.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		����ӿ�&gt; �����˰����ֵ˰��</td>
	</tr>
	<input type="hidden" name="oper_id" value="<%=oper_id%>">
</table>
<!--�������-->

<%
wherestr = "";
if ( oper_id!=null && !"".equals(oper_id) ) {
	wherestr += " and oper_id = '" + oper_id + "'";
}

countSql = "Select count(id) as amount from FI_ERP_DATA_SYNC_INFO_NC where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
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
		<th>������־Id</th>
        <th>����id</th>
        <th>��������</th>
        <th>�ɹ�����ʧ��ԭ��</th>
        <th>����ʱ��</th>      
      </tr>
      <tbody id="data">
<%
String col_str=" id,pri_id,para_2,case when CAST(para_5 AS VARCHAR ) = '0' then '�ɹ�' else para_5 end para_5,oper_id,create_date";

sqlstr = "select top "+ intPageSize +" "+col_str+" from FI_ERP_DATA_SYNC_INFO_NC where 1=1 and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from FI_ERP_DATA_SYNC_INFO_NC where 1=1 "+wherestr+" order by create_date desc,id ) "+wherestr ;
sqlstr += " order by create_date desc,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="center"><%=getDBStr( rs.getString("oper_id")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("pri_id") )  %></td>		
		<td align="center"><%=getDBStr( rs.getString("para_2")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("para_5")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("create_date")) %></td>					
		
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
