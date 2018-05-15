<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息管理 - 重要个人</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body  onload="public_onload(0)">

<form action="khzygr_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		客户信息管理 &gt; 重要个人</td>
	</tr>
</table>
<%

String dqczy = (String) session.getAttribute("czyid");
String cust_id = getStr( request.getParameter("cust_id") );
String cust_type = getStr( request.getParameter("cust_type") );
ResultSet rs;
String wherestr = " where 1=1 and creator='"+dqczy+"'";
String sqlstr="";
//if ( !cust_id.equals("") ){
	wherestr = wherestr + " and cust_id='" + cust_id + "'";
	 sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from cust_person  " + wherestr; 
//}
%>
	

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td><a href="#" accesskey="n" onClick="dataHander('add','khzygr_add.jsp?cust_id=<%=cust_id%>',dataNav.itemselect);"><img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle"></a></td>
		<td><a href="#" accesskey="m" onClick="dataHander('mod','khzygr_mod.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>
		<td><a href="#" accesskey="d" onClick="dataHander('del','khzygr_del.jsp?czid=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" ></a></td>
    </tr>
</table>
</td>
        <td align="right" width="90%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
        </td>
</tr>
</table>
<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>姓名</th>
		 <th>职位</th>
		 <th>手机</th>
		 <th>是否接收短信</th>
		 <th>创建人</th>
		 <th>创建时间</th>
		 <th>修改人</th>
		 <th>修改时间</th>
      </tr>
<%
	
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){

%>
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("id") ) %>"></td>
		<td align="center"><a href="khzygr.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( rs.getString("name") ) %></a></td>
	
		<td align="center"><%=getDBStr( rs.getString("jobposition") ) %></td>
		
		<td align="center"><%=getDBStr( rs.getString("mobile_number") ) %></td>
		<%if(getDBStr( rs.getString("msg_recieved") )==null || getDBStr( rs.getString("msg_recieved") )=="" || getDBStr( rs.getString("msg_recieved")).equals("否")) {%>
		<td align="center">否</td>
		<%} else {%>
		<td align="center">是</td>
		<%} %>
		<td align="center"><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("xiugairen") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td>
		
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>

<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->

</form>
<!-- end cwMain -->
</body>
</html>
