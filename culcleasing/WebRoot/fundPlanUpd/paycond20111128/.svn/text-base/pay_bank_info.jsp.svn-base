<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>请选择数据</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
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
<td class="tree_title_txt"   valign="middle" align="center">选择账号</td>
</tr>

<tr>
<td align=center width=100% valign="top" >
<div class="mydivtab" id="mydiv" >
<%
String cust_id = getStr(request.getParameter("cust_id"));
String wherestr=" and acc_status='是' and cust_id='"+cust_id+"' ";

String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue!=null) && (!filtervalue.equals("")))
{
	wherestr=" and bank_name like '%"+filtervalue+"%'";
}
%>
<form name="searchbar" action="pay_bank_info.jsp">
<table id="" border="0" cellspacing="0" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap>开户银行: <input type="text" name="fv"  value="<%=filtervalue%>" style="width:90px">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
		</td>
      </tr>
</table>
</form>
<%
String sqlstr="select * from cust_account where 1=1 "+wherestr+" order by id";//name-name 
ResultSet rs = null;
rs=db.executeQuery(sqlstr); 
%>
<select name="datalist" size="15" ondblclick="ListSelect('form1.pay_bank_name','form1.pay_bank_no');" style="height:80%">
<option returnlist=""></option>
<%
while (rs.next())
{
%>
	<option value="<%=getDBStr(rs.getString("acc_number"))%>" returnlist="<%=getDBStr(rs.getString("bank_name"))%>">
	<%=getDBStr(rs.getString("bank_name"))%> -- <%=getDBStr(rs.getString("acc_number"))%>
	</option>
<%} %>
</select>
</div>
</td>
</tr>
<tr>
    <td align="center">
    <input  class="btn3_mouseout" type="button" value="确定" onClick="ListSelect('form1.pay_bank_name','form1.pay_bank_no');">  
    <input class="btn3_mouseout" type="button" value="取消" onClick="window.close()">
    </td>
</tr>
 
</table>
</body>
</html>
