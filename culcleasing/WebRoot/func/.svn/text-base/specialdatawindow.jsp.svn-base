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
		document.all.cwMain.style.height=document.body.clientHeight-60;
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
	thedobj.value=objSelected.text;
	//thedobj.value=(objSelected.text=="--清空--")?"":objSelected.text;///05.06.01
	window.close();
}
</script>


</head>

<body onload="public_onload(48);" class="linetype">
	<%
String selfldname=getStr(request.getParameter("sf"));
String tblname=getStr(request.getParameter("tn"));
String listfld=getStr(request.getParameter("lf"));
String listvalue=getStr(request.getParameter("lv"));
String filterfld=getStr(request.getParameter("ff"));
String filtertype=getStr(request.getParameter("ft"));
String orderfld=getStr(request.getParameter("of"));
String dataobj=getStr(request.getParameter("do"));
String valueobj=getStr(request.getParameter("vo"));
String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue==null) || (filtervalue.equals("")))
{
filtervalue="";
}
%>
<table  class="title_top" width="100%" align=center cellspacing="0" border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">请选择</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">

<div>
	
<div id="mydiv" class="linetype" style="margin:12px;padding:12px;">




<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	
<form name="searchbar" action="specialdatawindow.jsp">
<input type="hidden" name="sf" value="<%=selfldname%>">
<input type="hidden" name="tn" value="<%=tblname%>">
<input type="hidden" name="lf" value="<%=listfld%>">
<input type="hidden" name="lv" value="<%=listvalue%>">
<input type="hidden" name="ff" value="<%=filterfld%>">
<input type="hidden" name="ft" value="<%=filtertype%>">
<input type="hidden" name="of" value="<%=orderfld%>">
<input type="hidden" name="do" value="<%=dataobj%>">
<input type="hidden" name="vo" value="<%=valueobj%>">
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap><%=selfldname%>: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
</td>
      </tr>
</table>

</form>
<%
String sqlstr = "select "+listfld+","+listvalue+" from "+tblname;
ResultSet rs;
if ((filtertype.indexOf("stringfld")>=0) && (filtervalue.length()>0))
sqlstr = sqlstr+" where "+filterfld+" like '%"+filtervalue+"%'"; 

if (orderfld.length()>0)
sqlstr = sqlstr+" order by "+orderfld;
rs=db.executeQuery(sqlstr); 
%>



<select name="datalist" style="height:260px;" size="30" ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');" 

style="width:100%">
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
</table>

</div>
<div style="margin:12px;width:100%;">
<!--按钮案例：-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right">
    	<input class="com_button" type="button" value="确定" onclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">
    	&nbsp;&nbsp;&nbsp;&nbsp;
    	<input class="com_button" type="button" value="取消" onclick="window.close()">
    	
    </td>
  </tr>
</table>
</div>

</div>

</td>
</tr>
<tr><td>
 
</td></tr>
</table>

</body>
</html>
<%if(null != db){db.close();}%>