<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����������ϸ - ���ʻ�����Ϣ����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->


<body onLoad="public_onload(0)">

<form action="baseconfig_detail_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			���ʻ�����Ϣ����&gt;��������</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<%
wherestr="";
String searchKey=getStr(request.getParameter("searchKey"));


if ( searchKey!=null && !"".equals(searchKey) ) {
	wherestr += " and refund_detail_name like '%" + searchKey + "%'";
}
%>

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>���ʽ��ϸ��
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle" onclick="dataNav.submit();">
          </td>

		<td><a href="#" accesskey="n" onClick="dataHander('add','baseconfig_detail_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="����(Alt+N)"></a></td>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','baseconfig_detail_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','baseconfig_detail_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" ></a></td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		<%
			sqlstr = "Select financing_config_refundtype_detail.*,dbo.GETUSERNAME(financing_config_refundtype_detail.creator) as oper_name,financing_config_refundtype.refund_name from financing_config_refundtype_detail left join financing_config_refundtype on financing_config_refundtype.code=financing_config_refundtype_detail.refund_code where 1=1 "+wherestr+"order by id asc"; 
			LogWriter.logDebug(request, "���sql:"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>���ʽ��ϸ���</th>
     <th>���ʽ��ϸ����</th>
     <th>���ʽ</th>
     <th>����������</th>
     <th>����Ա</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
	  <td align="center"><%=getDBStr(rs.getString("code"))%></td>
	  <td align="center"><%=getDBStr(rs.getString("refund_detail_name"))%></td>
      <td align="center"><%=getDBStr(rs.getString("refund_name"))%></td>
      <td align="center"><%=getDBDateStr(rs.getString("modify_date"))%></td>
      <td align="center"><%=getDBStr(rs.getString("oper_name"))%></td>
    </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>

</form>
</body>
</html>
