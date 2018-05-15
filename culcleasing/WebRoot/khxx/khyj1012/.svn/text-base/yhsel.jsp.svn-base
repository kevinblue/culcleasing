<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<!-- 05.04.27 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
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
	thedobj.value=objSelected.returnlist;
	window.close();
}
</script>
</head>
<body onLoad="public_onload(35)" style="border:0px solid #8DB2E3;" class="linetype">
<table  class="title_top" width=100%  align=center cellspacing=0 border="0" cellpadding="0" >

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"   valign="middle" align="center">选择姓名</td>
</tr>
<tr>
<td align=center width=100% valign="top" >
<div class="mydivtab" id="mydiv" >
<%
String wherestr="";
String dept_name="";

String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue==null) || (filtervalue.equals("")))
{

}
else
{
wherestr=" and name like '%"+filtervalue+"%'";
}
%>
<form name="searchbar" action="yhsel.jsp">
<table id="" border="0" cellspacing="0" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap>姓名: <input type="text" name="fv"   value="<%=filtervalue%>" style="width:90px"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
</td>
      </tr>
</table>
</form>
<%
//String sqlstr="select dept_name,id from jb_gsbm "+wherestr+" order by dept_name";
//String sqlstr = "select name,dept_name,id from v_yhxx "+wherestr+" order by dept_name,name";
//移交给新的项目经理
String sqlstr="select department, dept_name,id,name from vi_cust_t where role='项目经理' "+wherestr+" order by department,dept_name";//name-name 
ResultSet rs;
rs=db.executeQuery(sqlstr); 
%>
<select name="datalist" size="15" ondblclick="ListSelect('list.yhiddata','list.yhid');" style="height:80%">
<option returnlist=""></option>
<%
while (rs.next())
{
if (rs.getString("dept_name")!="null")
dept_name="  ---  "+getDBStr(rs.getString("dept_name"));
%>
<option value="<%=getDBStr(rs.getString("id"))%>" returnlist="<%=getDBStr(rs.getString("name"))%>"><%=getDBStr(rs.getString("name"))+dept_name%></option>
<%
}
%>
</select>
</div>
</td>
 </tr>
<tr>
    <td align="center">
    <input  class="btn3_mouseout" type="button" value="确定" onClick="ListSelect('list.yhiddata','list.yhid');">  
    <input class="btn3_mouseout" type="button" value="取消" onClick="window.close()">
    </td>
</tr>
 
</table>
</body>
</html>
