<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户对照表 - 客户对照表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">客户信息维护 &gt; 修改客户对照</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="fyxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  //dqczy="无认证";
  //response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gszh_mod",dqczy)>0) canedit=1;
//if (canedit==0) response.sendRedirect("../../noright.jsp");

%>
<%
String sqlstr;
String czid;
String feetype_number;
String subject_number;
String cdigest;
String auxiliary_account;
String flow_name;
String handle_flag;
String modify_date;
String modificator;

ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = "select ifs.*,bf.feetype_name from dbo.inter_fee_subject_join ifs left join base_feetype bf on ifs.feetype_number=bf.feetype_number where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{	
	 handle_flag =getDBStr(rs.getString("handle_flag"));
		 if(handle_flag.equals("1")){
		 handle_flag="借";
		 }else{
		 handle_flag="贷";
		 }
	auxiliary_account=getDBStr(rs.getString("auxiliary_account"));
	String a=String.valueOf(auxiliary_account.charAt(0));
	String b=String.valueOf(auxiliary_account.charAt(1));
	String c=String.valueOf(auxiliary_account.charAt(2));
	String d=String.valueOf(auxiliary_account.charAt(3));
	

%> 
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr >
    <td width="120" height="30" scope="row">费用类型</td>
    <td height="30" >
  <input class="text" name="feetype_number" accesskey="s" type="text" size="20" style="width: 133px" value="<%=getDBStr(rs.getString("feetype_name")) %>" readonly="readonly">
<img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','承租人','base_feetype','feetype_name','feetype_number','feetype_name','feetype_name','asc','form1.feetype_number','form1.feetype_number');"><span class="biTian">*</span>
	</td>
  </tr>
   <tr>
    <td height="30" scope="row">课目ID</td>
    <td height="30"><input name="subject_number" type="text" label="课目ID"  value="<%=getDBStr(rs.getString("subject_number")) %>"  Require="ture"><span class="biTian">*</span></td>
  </tr>
   <tr>
    <td height="30" scope="row">摘要</td>
    <td height="30"><input name="cdigest" type="text" label="摘要"  value="<%=getDBStr(rs.getString("cdigest")) %>"  Require="ture"><span class="biTian">*</span></td>
  </tr>
  
<tr>
    <td height="30" scope="row">辅助核算</td>
    
    <td height="30">
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account1" value="1" <% if(a.equals("1")){ %> checked="checked" <%} %>>部门核算
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account2" value="2" <% if(b.equals("1")){ %> checked="checked" <%} %>>客户核算
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account3" value="3" <% if(c.equals("1")){ %> checked="checked" <%} %> onclick="check(this.id);">项目核算
    <input type="checkbox" name="auxiliary_account" id="auxiliary_account4" value="4" <% if(d.equals("1")){ %> checked="checked" <%} %> onclick="check(this.id);">帐户核算
    </td>
  </tr>
    <tr>
    <td height="30" scope="row">流程名</td>
    <td height="30"><input name="flow_name" type="text"  label="流程名"  value="<%=getDBStr(rs.getString("flow_name")) %>"  Require="true"> <span class="biTian">*</span></td>
  </tr>
    <tr>
    <td height="30" scope="row">借/贷</td>
    <td height="30">
    <select class="text" name="handle_flag" style="width: 40px"><script>w(mSetOpt("<%=handle_flag%>","|借|贷"));</script></select>
     <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td height="30" scope="row">最后更新日期</td>
    <td height="30"><%=getDBDateStr(rs.getString("modify_date"))%></td>
  </tr>
  <tr>
    <td height="30" scope="row"> 操作员</td>
    <td height="30"><%=getDBStr(rs.getString("modificator"))%></td>
  </tr>

</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>