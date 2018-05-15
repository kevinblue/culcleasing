<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���չ��� - �����޶�</title>
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

<form action="insur_bfxd.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		���չ���&gt; �����޶�</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = " ";
String wherestr1=" contract_id ";
//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );
String start_date=getStr( request.getParameter("start_date") );
String cd=getStr( request.getParameter("CD") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if(!cd.equals("") || cd!=null){
	if(cd.equals("����")){
	wherestr1="cd_date asc";
	}else if (cd.equals("����")){
	wherestr1="cd_date desc";
	}
}

if(!start_date.equals("") || start_date!=null){
	if(start_date.equals("����")){
	wherestr1="insur_start_date asc";
	}else if (start_date.equals("����")){
	wherestr1="insur_start_date desc";
	}
}
//�ݲ�����Ͷ�������������

countSql = "select count(id) as amount from vi_insur_bfxd where 1=1 "+wherestr;

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
<td>CD��������ʽ
<select name="CD" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=cd %>","|����|����","|����|����")); 
	</script>
</select>
</td>
<td>Ͷ����ʼ��������
<select name="start_date" style="width: 120px;" >
	<script type="text/javascript">
		w(mSetOpt("<%=start_date %>","|����|����","|����|����")); 
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
		<th>��Ŀ���</th>
		<th>��ͬ���</th>
		<th>������</th>
		<th>��Ŀ����</th>
		<th>Ͷ����ʽ</th>
		<th>������ȡ��ʽ</th>
		<th>��Ŀ���</th>
		<th>��������(��)</th>
		<th>CD����ʱ��</th>
		<th>Ͷ����ʼ����</th>
        <th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_insur_bfxd where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_insur_bfxd where 1=1 "+wherestr+" order by  "+wherestr1+") "+wherestr+" order by "+wherestr1 ;
System.out.println("aaa"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insur_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("insure_pay_type")) %></td>	

		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("equip_amt" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("lease_term" )) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("cd_date" )) %></td>	
		<td align="center"><%= getDBDateStr( rs.getString("insur_start_date" )) %></td>	
      	<td align="center">
			<a href="bfxd_list.jsp?contract_id=<%=getDBStr( rs.getString("contract_id")) %>&insur_type=<%=getDBStr( rs.getString("insur_type")) %>&insur_start_date=<%= getDBDateStr( rs.getString("insur_start_date" )) %>&insur_end_date=<%= getDBDateStr( rs.getString("insur_end_date" )) %>"  target="_blank">�鿴�����ʽ�ƻ�</a>
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
