<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html xmlns="http//www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>省份分配</title>
<link href="../../css/main.css" type="text/css" rel="stylesheet" >

<script src="../../js/common.js"></script>
<script src="../../js/func.js"></script>
<script>parent.setNavOn("LNgc","leftNavBtn");	parent.setNavOn("LNgc_xmxx","leftNavSub");</script>
<style type="text/css">
<!--
-->
</style>

<%
String credit_group_id=getStr(request.getParameter("cgroup_id"));
String credit_group_name=getStr(request.getParameter("cgroup_name"));

String sqlstr;
ResultSet rs=null;

String selid="";
String selmc="";
String seledid=credit_group_id;
String seledmc=credit_group_name;
String seledtemp="";


sqlstr = "select * from jb_ssxx order by qyid";
rs=db.executeQuery(sqlstr); 
if (rs.next())
{
	while (!rs.isAfterLast())
	{
       		if (!seledtemp.equals(getDBStr(rs.getString("id"))))
       		{
       			seledtemp=getDBStr(rs.getString("id"));
       			selid=selid+getDBStr(rs.getString("id"))+",";
       			selmc=selmc+getDBStr(rs.getString("sfmc"))+",";
       		}
       		rs.next();
   		}
   		selid=selid.substring(0,selid.length()-1);
   		selmc=selmc.substring(0,selmc.length()-1);
}		

rs.close();	
%>


<script>
	var fldText="<%=selmc%>";
	var fldName="<%=selid%>";
	var arrFldText=fldText.split(",");
	var arrFldName=fldName.split(",");
	var seledfldText="<%=seledmc%>";
	var seledfldName="<%=seledid%>";
	var arrseledFldText=seledfldText.split(",");
	var arrseledFldName=seledfldName.split(",");
function init(){
     if (arrFldText[0]!="")
     {
	for(i=0;i<arrFldText.length;i++){
		document.all.boxField.add(new Option(arrFldText[i],arrFldName[i]));
	}
     }
    if (arrseledFldText[0]!="")
    {
	for(i=0;i<arrseledFldText.length;i++){
		document.all.boxSelField.add(new Option(arrseledFldText[i],arrseledFldName[i]));
	}
    }
}

function makedata(){
	opener.form1.credit_group_id.value="";
	opener.form1.credit_group_name.value="";
	for(i=0;i<form1.boxSelField.length;i++){
		splitStr=(form1.credit_group_id.value=="")?"":",";
		form1.credit_group_id.value+= splitStr +form1.boxSelField.options[i].value;
		opener.form1.credit_group_id.value+= splitStr +form1.boxSelField.options[i].value;
		splitStr2=(form1.credit_group_name.value=="")?"":",";
		form1.credit_group_name.value+= splitStr2 +form1.boxSelField.options[i].text;
		opener.form1.credit_group_name.value+= splitStr2 +form1.boxSelField.options[i].text;
	}

	window.opener=null;
	window.open("","_self"); 
	window.close();
	return false;
}
</script>
</head>

<body onLoad="init()">

<div class="cellTit">
<div class="cellTitL"></div>
<div class="cellTitC NormTit " id="CellTitTxt"></div>
<div class="cellTitR"></div>
</div>



<form action="gjxx_mod.jsp" method="post" name="form1">

<div class="divCBox">

<table border="0" cellpadding="0" cellspacing="0" class="nTable">
<tr>
<td id="lay1">

	<div class="tTable click" onClick="expIt();"><img src="../../images/sbtn_selUser.gif" id="icon_exp" name="icon_exp" width="20" height="20" align="absmiddle" />&nbsp;选择授权集合</div>
<div name="expContent">

<table width="100%" style="width:100%" border="0" cellspacing="0" cellpadding="4" >
  <TR> 
    <TD vAlign=top class="selectedBox"> <SELECT name="boxField" size=13 multiple style="width: 100%;" onFocus="setActObj(this.name)" onmousewheel="wheelmove()" ondblclick="move(this,boxSelField);"   > 
    </SELECT>    </TD> 
    <TD align="center" vAlign=middle width="3%" class="selBoxToolbar"> <input type="hidden" name="actObj" value="boxField" > <img src="../../images/sbtn_right.gif" width="19" height="19" alt="选择" onClick="move(boxField,boxSelField);" class="click"><br>
     <br><img src="../../images/sbtn_left.gif" width="19" height="19" alt="撤销" onClick="move(boxSelField,boxField);" class="click" ></TD> 
    <TD vAlign=top class="selectBox"> <SELECT name="boxSelField" size=13 multiple style="width: 100%" onFocus="setActObj(this.name)" onmousewheel="wheelmove()" ondblclick="move(this,boxField);" > 
    </SELECT> </TD> 
  </TR> 
  <tr>
    <td align="center" height="30" colspan="3"><input class="btnSave" type="button" value="确定" onclick="return makedata();">  <input class="btnClose" type="button" value="取消" onclick="window.close()"></td>
  </tr>
</TABLE>
</div>


<input type="hidden" name="credit_group_name">
<input type="hidden" name="credit_group_id">
</td>
</tr>
<%
db.close();
%>

</table></div>
<div class="formToolBar " >
<b><input class="btn" name="btnSave" value="保存" type="submit" onClick="return makedata();"></b> 
<input class="btn" name="btnReset" value="重置" type="reset" onClick="location.reload()"> 
<input class="btn" name="btnClose" value="取消" type="button" onClick="window.close();"> 
</div></form>
</body>
</html>

