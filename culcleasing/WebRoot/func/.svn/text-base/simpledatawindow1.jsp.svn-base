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
function ListSelect(dobj,vobj){//05.04.28
	if(window.opener.closed){alert("主窗口已关闭！");close();return;}
	var objSelect =document.getElementById("datalist");
	var thevobj = eval("window.opener."+vobj);
	var thedobj = eval("window.opener."+dobj);
	var tempStrV="",tempStrD="",j=0;
	for(i=0;i<objSelect.length;i++){
		if(objSelect.options[i].selected){
			splishStr=(j>0)?",":"";
			tempStrV += splishStr+objSelect.options[i].value;
			tempStrD += splishStr+objSelect.options[i].innerHTML;
			j++;
		}
	}
	if(j==0){alert("请先选择！");return;}
	thevobj.value=tempStrV;
	thedobj.value=tempStrD;
	window.close();
}
</script>


</head>

<body>
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
rs=db.executeQuery(sqlstr); 
%>

<div id="cwMain">
<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
<select name="datalist" size="20" multiple style="width:100%; " ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">
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
    <td align="center" height="30"><input class="btn" type="button" value="确定" onclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">  <input class="btn" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</table>
 </div>
 
</body>
</html>
<%if(null != db){db.close();}%>