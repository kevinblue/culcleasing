<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

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

//该函数比较重要- 不通用
function ListSelect(dobj,vobj,vobj2,vobj3){//05.04.27
	if(window.opener.closed){alert("主窗口已关闭！");close();return;}
	var objSelect =document.getElementById("datalist");
	var i = objSelect.selectedIndex;
	if(i==-1){alert("请先选择！");return;}
	var objSelected = objSelect.options[i];
	var thedobj = eval("window.opener."+dobj);
	var thevobj = eval("window.opener."+vobj);
	var thevobj2 = eval("window.opener."+vobj2);
	var thevobj3 = eval("window.opener."+vobj3);
	
	thedobj.value=objSelected.value;
	thevobj.value=objSelected.returnlist;
	thevobj2.value=objSelected.returnlist2;
	thevobj3.value=objSelected.returnlist3;
	
	window.close();
}
</script>
</head>
<body onLoad="public_onload(35)" style="border:0px solid #8DB2E3;" class="linetype">
<table  class="title_top" width=100%  align=center cellspacing=0 border="0" cellpadding="0" >

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"   valign="middle" align="center">选择期次</td>
</tr>

<tr>
<td align=center width=100% valign="top" >
<div class="mydivtab" id="mydiv" >
<%
String wherestr="";
String contract_id=getStr(request.getParameter("contract_id"));//合同编号
if ((contract_id!=null) && (!"".equals(contract_id)))
{
	wherestr=" and contract_id ='"+contract_id+"'";
}else{
	//合同编号不存在不显示
	wherestr=" and contract_id =''";
}

String filtervalue=getStr(request.getParameter("fv"));
if ((filtervalue!=null) && (!filtervalue.equals("")))
{
	wherestr=" and rent_list like '%"+filtervalue+"%'";
}
%>
<form name="searchbar" action="plan_bank_info.jsp">
<table id="" border="0" cellspacing="0" cellpadding="0" style="float:left " >
      <tr>
        <td nowrap>选择期次: <input type="text" name="fv"  value="<%=filtervalue%>" style="width:90px">
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" >
		</td>
      </tr>
</table>
</form>
<%
String sqlstr="select * from fund_rent_plan where 1=1 "+wherestr+" order by id";//name-name 
ResultSet rs = null;
rs=db.executeQuery(sqlstr); 

%>
<select name="datalist" size="15" ondblclick="ListSelect('form1.plan_list','form1.corpus','form1.interest','form1.plan_date');" style="height:80%">
<option returnlist="" returnlist2="" returnlist3=""></option>
<%
while (rs.next())
{
%>
	<option value="<%=getDBStr(rs.getString("rent_list"))%>" 
	returnlist="<%=getDBStr(rs.getString("corpus"))%>" 
	returnlist2="<%=getDBStr(rs.getString("interest"))%>"
	returnlist3="<%=getDBStr(rs.getString("plan_date"))%>">
	期次：<%=getDBStr(rs.getString("rent_list"))%> 计划日期：<%=getDBDateStr(rs.getString("plan_date"))%>
	</option>
<%} %>
</select>
</div>
</td>
</tr>
<tr>
    <td align="center">
    <input  class="btn3_mouseout" type="button" value="确定" 
    onClick="ListSelect('form1.plan_list','form1.corpus','form1.interest','form1.plan_date');">  
    <input class="btn3_mouseout" type="button" value="取消" onClick="window.close()">
    </td>
</tr>
 
</table>
</body>
</html>
