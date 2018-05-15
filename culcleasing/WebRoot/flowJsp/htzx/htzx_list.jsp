<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ִͬ��</title>
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

<%
wherestr = "";
String project_name = getStr( request.getParameter("project_name") );
String contract_id = getStr( request.getParameter("contract_id") );
String provider = getStr( request.getParameter("provider") );
String plan_start_date = getStr( request.getParameter("plan_start_date") );
String plan_end_date = getStr( request.getParameter("plan_end_date") );
String fact_start_date = getStr( request.getParameter("fact_start_date") );
String fact_end_date = getStr( request.getParameter("fact_end_date") );
if ( project_name!=null && !project_name.equals("") ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if ( contract_id!=null && !contract_id.equals("") ) {
	wherestr += " and htzx.contract_id like '%" + contract_id + "%'";
}
if ( provider!=null && !provider.equals("") ) {
	wherestr += " and provider like '%" + provider + "%'";
}
if ( plan_start_date!=null && !"".equals(plan_start_date) && plan_end_date!=null && !"".equals(plan_end_date)) {
	wherestr += " and plan_date>= '"+plan_start_date+"' and plan_date<='"+plan_end_date+"'";
}
if ( fact_start_date!=null && !"".equals(fact_start_date) && fact_end_date!=null && !"".equals(fact_end_date) ) {
	wherestr += " and fact_date>= '"+fact_start_date+"' and fact_date<='"+fact_end_date+"'";
}
countSql = "select count(id) as amount from dbo.vi_contract_htzx htzx where 1=1 "+wherestr;
System.out.println("==========="+countSql);

%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<form action="htzx_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��ִͬ��</td>
	</tr>
</table> 
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>��ͬ���:&nbsp;<input name="contract_id"  type="text" size="15" value="<%=contract_id %>"></td>
<td>��Ӧ��:&nbsp;<input name="provider"  type="text" size="15" value="<%=provider %>"></td>
</tr>
<tr>
	<td>�ƻ�����:&nbsp;<input name="plan_start_date"  readonly dataType="Date" size="15" value="<%=plan_start_date %>">
	<img  onClick="openCalendar(plan_start_date);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	
	<input name="plan_end_date" type="text" size="15" readonly dataType="Date" value="<%=plan_end_date %>">
	<img  onClick="openCalendar(plan_end_date);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>ʵ������:&nbsp;<input name="fact_start_date" readonly dataType="Date" size="15" value="<%=fact_start_date %>">
	<img  onClick="openCalendar(fact_start_date);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	
	<input name="fact_end_date" type="text" size="15" readonly dataType="Date" value="<%=fact_end_date %>">
	<img  onClick="openCalendar(fact_end_date);return false" style="cursor:pointer; " 
	src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td><input type="button" value="��ѯ" onclick="dataNav.submit();">
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

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:50%;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��ͬ���</th>
     <th>��Ŀ����</th>
     <th>�豸����</th>
     <th>�豸�ͺ�</th>
     <th>��Ӧ��</th>
     <th>������</th>
     <th>��ҵ</th>
     <th>�豸����</th>
     <th>����</th>
     <th>�ܼ�</th>
     <th>�ƻ�����</th>
     <th>ʵ������</th>
     <th>�豸����</th>
     <th>�豸����״̬</th>
	 <th>����</th>
     <th>����</th>
   </tr>
   <tbody id="data">
<%
String col_str="*";
String appendix="";
String ids = "";
String is_arrive = "";

sqlstr = "select top "+ intPageSize +" "+col_str+" from dbo.vi_contract_htzx htzx left join (select * from upload_doc ud left join "
		+"(SELECT up.pid,upload_file_path FROM (SELECT pid,(SELECT replace(REPLACE((SELECT upload_file_path+'' FROM upload_doc_detail where pid=udd.pid and flag='0' order by id FOR XML PATH('')),'&lt;','<'),'&gt;','>')) AS upload_file_path "+
		"FROM upload_doc_detail udd GROUP BY pid) up) dd on ud.id=dd.pid "
		+"left join (SELECT up.ppid,ids FROM (SELECT pid as ppid,(SELECT replace(REPLACE((SELECT cast(id as varchar(8))+',' "
		+"FROM upload_doc_detail where pid=udd.pid and flag='0' order by id FOR XML PATH('')),'&lt;','<'),'&gt;','>')) AS ids "
		+"FROM upload_doc_detail udd GROUP BY udd.pid) up) dd1 on ud.id=dd1.ppid) uudd "
		+"on uudd.contract_id=htzx.contract_id and uudd.equip_id=htzx.equip_id "
		+"where htzx.id not in( select top "+ (intPage-1)*intPageSize +" id from dbo.vi_contract_htzx htzx where 1=1 "+wherestr+" order by contract_id) "+wherestr+" order by htzx.contract_id";
System.out.println("-----------------"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	appendix = getDBStr( rs.getString("upload_file_path") );
	ids = getDBStr(rs.getString("ids"));
	is_arrive = getDBStr(rs.getString("is_arrive"));
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("project_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("equip_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("equip_model")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("provider")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("equip_manufacturer")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("table_type")) %></td>
     	<td align="center"><%=CurrencyUtil.convertFinance(rs.getString("equip_price")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("equip_num")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("total_price")) %></td>
     	<td align="left"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="left"><%=getDBDateStr(rs.getString("fact_date")) %></td>
     	<td align="center"><%=is_arrive%></td>
     	<td align="center"><%=getDBStr(rs.getString("equip_status")) %></td>
		<td align="center"><%=appendix%></td>
     	<td align="center">
     	<%if("��".equals(is_arrive) || "".equals(is_arrive)){%>
     	<a href='htzx_upd.jsp?ids=<%=ids %>&item_id=<%=getDBStr(rs.getString("id"))%>&leas_form=<%=getDBStr(rs.getString("leas_form"))%>&appendix=<%=appendix%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>
     	<%}%>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>
</div>
</div><!-- �����ʽ�ƻ�div -->

</form>
</body>
</html>
<%if(null != db){db.close();}%>