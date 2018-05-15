<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.CRMOperationUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>CRM同步</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
wherestr = "";
String searchKey = getStr(request.getParameter("userid"));

if ( searchKey!=null && !"".equals(searchKey))
{
   LogWriter.logDebug(request, "######"+sqlstr);
   wherestr += " and subString(b.email ,0,(len(b.email)-len(right(b.email,4)))) like '%"+searchKey+"%' "; 
}

%>



<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form action="synchronism_list.jsp" name="dataNav" onSubmit="return goPage()">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			CRM同步
		</tr>
</table> 
</div>
<!-- end cwTop -->
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;查询条件
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
	</legend>
		<table border="0" width="100%" cellspacing="5" cellpadding="0">
			<tr>
				<td>注册ID:&nbsp;<input name="userid"  type="text" size="15" value="<%=searchKey %>"></td>
				<td>
				<input type="button" value="查询" onclick="dataNav.submit();">
				&nbsp;&nbsp;
				<input type="button" value="清空" onclick="clearQuery();" >
				</td>
			</tr>
		</table>
	</fieldset>
</div>
<!--可折叠查询结束-->


<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    <td nowrap>
              <input name="" accesskey="" type="hidden" size="" value="">
              <input name="" type="hidden" src="" alt="" align="" >
          </td>	
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		<%
		sqlstr = "select b.id,b.name,b.phone,subString(b.email ,0,(len(b.email)-len(right(b.email,4)))) userid ,b.role,v.dept_name,b.register_status,b.subsidiary from base_user b,vi_base_user_responsible v where isnull(b.status,'1')=1 "+wherestr+" and b.id=v.id order by id asc"; 
		LogWriter.logDebug(request, "@@@@@@@"+sqlstr);
		%>
		
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>编号</th>
     <th>注册ID</th>
     <th>姓名</th>
     <th>电话</th>
     <th>所属部门</th>
     <th>是否同步</th>
   </tr>
   <tbody id="data">
<%	  
rs.previous();
int num=0;
String userid="";
boolean falg=false;
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	String id=getDBStr(rs.getString("id"));
	userid=getDBStr(rs.getString("userid"));
	String name =getDBStr(rs.getString("name"));
	String register_status =getDBStr(rs.getString("register_status"));
	String subsidiary = getDBStr(rs.getString("subsidiary"));
	//CRMOperationUtil crmoperationutil=null;
	//falg = CRMOperationUtil.getRegisterIf(userid);
%>
     <tr>
   	  <td align="center"><%=id%></td>
      <td align="center"><%=userid%></td>
      <td align="center"><%=name %></td>
      <td align="center"><%=getDBStr(rs.getString("phone"))%></td>
      <td align="center"><%=getDBStr(rs.getString("dept_name"))%></td>
      <td align="center">
      <%if("1".equals(register_status)){ %>已同步 <%}else{ %><a href="synchronism_save.jsp?erpCode=<%=id %>&sCode=<%=userid%>&sName=<%=name %>&subsidiary=<%=subsidiary %>">同步</a><% }%>
      </td>
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
