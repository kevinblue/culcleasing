<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>

<html>
<head>
<!-- 05.06.01 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
<link href="../css/mainstyle.css" rel="stylesheet" type="text/css">
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/js-t/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/js-t/publicEvent.js"></SCRIPT>
<script>
window.onload=onWinLoad;
window.onresize=onWinResize;


function onWinLoad(){
	fixCCH();
}
function onWinResize(){
	fixCCH();
}
function fixCCH(){
	if (document.body.clientHeight>80){
		document.all.cwMain.style.height=document.body.clientHeight-10;
		document.all.datalist.size=0;
		document.all.datalist.size=(document.all.cwMain.clientHeight-30)/15;
		document.body.scroll = "no";
	}else{
		document.body.scroll = "yes";
	}
}
</script>

<script language="javascript">
function ListSelect(dobj,vobj){//05.04.27
	if(window.opener.closed){alert("主窗口已关闭！");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("请先选择！");return;}
	var objSelected = objSelect.options[i];
	var thevobj = eval("window.opener."+vobj);
	var thedobj = eval("window.opener."+dobj);
	thevobj.value=objSelected.value;
	thedobj.value=objSelected.innerHTML;
	window.close();
}
</script>


</head>

<body onload="public_onload(48);" class="linetype">
<%
String tblname=request.getParameter("tn");
String listfld=request.getParameter("lf");
String listvalue=request.getParameter("lv");
String filterfld=request.getParameter("ff");
String filtervalue=request.getParameter("fv");
String filtertype=request.getParameter("ft");
String orderfld=request.getParameter("of");
String dataobj=request.getParameter("do");
String valueobj=request.getParameter("vo");

%>

<%
String sqlstr = "select "+listfld+","+listvalue+" from "+tblname;
ResultSet rs;

if (filtertype.indexOf("stringfld")>=0)
sqlstr = sqlstr+" where "+filterfld+"='"+filtervalue+"'"; 
if (filtertype.indexOf("numberfld")>=0)
sqlstr = sqlstr+" where "+filterfld+"="+filtervalue; 

if (orderfld.length()>0)
sqlstr = sqlstr+" order by "+orderfld;
//System.out.println("---"+sqlstr);
rs=db.executeQuery(sqlstr); 
%>

	<table  class="title_top" width="100%" align=center cellspacing="0" border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">请选择</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div id="mydiv" class="linetype" style="margin:12px;padding:12px;">
<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0"  class="maintab_content_table">
  <tr>
    <td valign="top">
<select name="datalist" size="20" style="width:100%; " ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">
<option selected></option>

<%
while (rs.next())
{
%>
<option value="<%=rs.getString(listvalue)%>"><%=rs.getString(listfld)%></option>
<%
}
%>

</select>	

	</td>
  </tr>
  <tr>
    <td align="right" height="30"><input class="com_button" type="button" value="确定" onclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">  <input class="com_button" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</table>
</div>
</table>
</body>
</html>
<%if(null != db){db.close();}%>