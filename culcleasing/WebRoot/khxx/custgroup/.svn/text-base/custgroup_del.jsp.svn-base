<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 集团信息删除</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx-custgroup-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "SELECT * FROM cust_group where group_id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	group_name = "";

	if ( rs.next() ) {
		group_name = getDBStr( rs.getString("group_name") );
	}
	rs.close(); 

%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="custgroup_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息 &gt;集团信息删除</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	  <td>
		<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
	  	<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
		</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
 <tr>
    <td>集团名称</td>
    <td><%=group_name%></td>
</tr>
  <tr>
    <td>集团成员</td>
<%
	String cust_name="";
	sqlstr ="SELECT vi_cust_all_info.cust_name FROM cust_group_company LEFT OUTER JOIN vi_cust_all_info ON cust_group_company.cust_id = vi_cust_all_info.cust_id where cust_group_company.group_id='"+czid+"' order by vi_cust_all_info.cust_name";
	rs = db.executeQuery(sqlstr); 
	while ( rs.next() )
	{
		cust_name+=getDBStr( rs.getString("cust_name") )+"<br>";
	}
	rs.close(); 
 %>
    <td><%=cust_name%></td>
  </tr>
</table>
<br>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</div>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
</script>
</form>
<%db.close();%>
<!-- end cwMain -->
</body>
</html>
