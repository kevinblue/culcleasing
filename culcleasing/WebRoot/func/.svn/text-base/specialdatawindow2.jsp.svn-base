<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="common.jsp"%>
<html>
<head>
<!-- 05.04.27 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
<link href="../css/global.css" rel="stylesheet" type="text/css">
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
	var sTemp="";
	sTemp=(thevobj.value=="")?"":",";
	thevobj.value+=sTemp+objSelected.value;
	thedobj.innerHTML+=sTemp+objSelected.innerHTML;
	window.close();
}
</script>


</head>

<body>
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

<div id="cwMain" >
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
<br>


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
out.print(sqlstr);
sqlstr = "select xmmc,xmmc from v_xmmc";
rs=db.executeQuery(sqlstr); 
%>



<select name="datalist" size="30" ondblclick="ListSelect('<%=dataobj%>','<%=valueobj%>');" 

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
  <tr>
    <td align="center" height="30"><input class="btn" type="button" value="确定" onclick="ListSelect('<%=dataobj%>','<%=valueobj%>');">  <input class="btn" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</table>
</div>
</body>
</html>
<%if(null != db){db.close();}%>