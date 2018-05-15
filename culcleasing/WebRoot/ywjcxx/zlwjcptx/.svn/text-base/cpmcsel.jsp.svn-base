<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<!-- 05.04.27 -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>请选择数据</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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
	thedobj.value=objSelected.returnlist;
	window.close();
}
</script>


</head>

<body>
<%
String wherestr="";
String bmmc="";

String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue==null) || (filtervalue.equals("")))
{

}
else
{
wherestr=" where lxmc like '%"+filtervalue+"%'";
}
%>
<div id="cwMain" >
<table width="100%" height="20"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	
<form name="searchbar" action="cpmcsel.jsp">
<br>


<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap>产品名称: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
</td>
      </tr>
</table>

</form>
<%
String sqlstr = "select id,lxmc from jb_zlwjlx "+wherestr+" order by id asc";
ResultSet rs;
rs=db.executeQuery(sqlstr); 
%>



<select name="datalist" size="30" ondblclick="ListSelect('form1.cpiddata','form1.cpid');" style="width:100%">
<option returnlist=""></option>
<%
while (rs.next())
{
%>
<option value="<%=getDBStr(rs.getString("id"))%>" returnlist="<%=getDBStr(rs.getString("lxmc"))%>"><%=getDBStr(rs.getString("id"))+"--"+getDBStr(rs.getString("lxmc"))%></option>
<%
}
%>
</select>

	</td>
  </tr>
  <tr>
    <td align="center" height="30"><input class="btn" type="button" value="确定" onclick="ListSelect('form1.cpiddata','form1.cpid');">  <input class="btn" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</table>
</div>
</body>
</html>
<%if(null != db){db.close();}%>