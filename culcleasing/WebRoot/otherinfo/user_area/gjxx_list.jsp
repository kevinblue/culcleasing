<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ����</title>
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

<%
wherestr = "";
String searchKey = getStr(request.getParameter("searchKey"));
if ( searchKey!=null && !"".equals(searchKey))
{
   LogWriter.logDebug(request, "######"+sqlstr);
   wherestr += " and b.name like '%"+searchKey+"%' "; 
}

%>

<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="gjxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			��Ϣά��&gt;�û�����ά��</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap>�û����ƣ�
              <input name="searchKey" accesskey="s" type="text" size="15" value="<%=searchKey %>">
              <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="dataNav.submit();">
          </td>
		
		<td><a href="#" accesskey="m" onClick="dataHander('mod','gjxx_mod.jsp?id=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		<%
		// b.role in('��Ŀ����','���ž���','��������') and
		//2012-11-6��������ſ���ɫȨ�ޣ������˿ɱ༭
		sqlstr = "select b.id,b.name,b.phone,b.email,b.role,v.respon_provice_title as area,dbo.getusername(v.modificator) as gxr,v.modify_date from base_user b left join base_user_respons v on b.id=v.base_user_id where isnull(b.status,'1')=1 "+wherestr+" order by b.name asc"; 
		LogWriter.logDebug(request, "��Ŀ��������ά��--@@@@@@@"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th width="1%"></th>
     <th>���</th>
     <th>�û�����</th>
     <th>�绰</th>
     <th>����ʡ��</th>
     <th>ά����Ա</th>
     <th>��������</th> 
   </tr>
   <tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
     <tr>
      <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>">
      <input type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>" />
      </td>
	  <td><%=getDBStr(rs.getString("id"))%></td>
      <td><%=getDBStr(rs.getString("name"))%></td>
      <td><%=getDBStr(rs.getString("phone"))%></td>
      <td><%=getDBStr(rs.getString("area"))%></td>
      <td><%=getDBStr(rs.getString("gxr"))%></td>
      <td><%=getDBDateStr(rs.getString("modify_date"))%></td>
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
