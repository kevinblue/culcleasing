<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<!-- 05.04.27 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ѡ������</title>
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
function ListSelect(dobj,vobj,vobj1){//05.04.27
	if(window.opener.closed){alert("�������ѹرգ�");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("����ѡ��");return;}
	var objSelected = objSelect.options[i];
	var thevobj = eval("window.opener."+vobj);
	var thevobj1 = eval("window.opener."+vobj1);
	var thedobj = eval("window.opener."+dobj);
	thevobj.value=objSelected.value;
	thevobj1.value=objSelected.value1;
	thedobj.value=objSelected.returnlist;
	window.close();
}
</script>
</head>
<body onLoad="public_onload(35)" style="border:0px solid #8DB2E3;" class="linetype">
<table  class="title_top" width=100%  align=center cellspacing=0 border="0" cellpadding="0" >

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"   valign="middle" align="center">ѡ����Ŀ</td>
</tr>

<tr>
<td align=center width=100% valign="top" >
<div class="mydivtab" id="mydiv" >
<%
String wherestr="";

String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue!=null) && (!filtervalue.equals("")))
{
	wherestr=" and project_name like '%"+filtervalue+"%'";
}
%>
<form name="searchbar" action="project_info.jsp">
<table id="" border="0" cellspacing="0" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap>��Ŀ����: <input type="text" name="fv"  value="<%=filtervalue%>" style="width:90px">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle" >
		</td>
      </tr>
</table>
</form>
<%
String sqlstr="SELECT *,info.cust_name FROM contract_info ci LEFT JOIN cust_info info ON ci.cust_id=info.cust_id where ci.industry_type='CULC_06' "+wherestr+" order by ci.id";//name-name 
ResultSet rs = null;
rs=db.executeQuery(sqlstr); 

%>
<select name="datalist" size="15" ondblclick="ListSelect('form1.project_name','form1.proj_id','form1.contract_id');" style="height:100%">
<option returnlist=""></option>
<%
while (rs.next())
{
%>
	<option value="<%=getDBStr(rs.getString("proj_id"))%>" value1="<%=getDBStr(rs.getString("contract_id"))%>" returnlist="<%=getDBStr(rs.getString("project_name"))%>">
	<%=getDBStr(rs.getString("project_name"))%>
	</option>
<%} %>
</select>
</div>
</td>
</tr>
<tr>
    <td align="center">
    <input  class="btn3_mouseout" type="button" value="ȷ��" onClick="ListSelect('form1.project_name','form1.proj_id','form1.contract_id');">  
    <input class="btn3_mouseout" type="button" value="ȡ��" onClick="window.close()">
    </td>
</tr>
 
</table>
</body>
</html>
<%if(null != db){db.close();}%>