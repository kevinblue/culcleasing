<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<style type="text/css">
body {
	font-family: Tahoma,Arial,Helvetica,Sans-Serif; 
	background: #DDE4EA; 
	margin: 0px; 
	padding: 0px;
	text-align:center;
}
img {
	border: none; 
	vertical-align: middle;
}
</style>
<%
ResultSet rs = null;
String sqlstr = "";
//����������
String hire_bank_str="";
sqlstr="select distinct title from ifelc_conf_dictionary";
sqlstr+=" where parentid='HireBank' and title is not null ";
sqlstr+=" and title<>'' ";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	hire_bank_str=hire_bank_str+"|"+rs.getString("title");
}rs.close();
db.close();
%>
</head>

<body>
<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:450px;">
<form name="list" action="cx_sq_save.jsp" enctype="multipart/form-data" method="post">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr><td>
					<table border="0" cellspacing="0" cellpadding="0">    
						<tr class="maintab_dh">
							<td nowrap id="saveTd">
								<BUTTON class="btn_2" name="btnSave" type="button" onclick="fun_save()">
								<img src="../../images/save.gif" align="absmiddle" border="0">�������������</button>
							</td>
						</tr>
					</table>
				</td></tr>
			</table>
		</td>
	</tr>
</table>

<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center">
	  <tr>
		<td align="right">�� �� ��&nbsp;&nbsp;</td>
		<td><input name="applier" type="text" style="width:145px;"> </td>
	  </tr>
	  <tr>
		<td align="right">��������&nbsp;&nbsp;</td>
		<td>
		<select name="hire_bank" style="width:145px;">
		<script>w(mSetOpt('',"<%=hire_bank_str%>"));</script>
		</select>
		</td>
	  </tr>
	  <tr>
		<td align="right">��������&nbsp;&nbsp;</td>
		<td><input name="fact_date" type="text" value="<%=getSystemDate(0) %>" style="width:145px;" readonly maxlength="10" dataType="Date">
		<img  onClick="openCalendar(fact_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		</td>
	  </tr>
	  <tr>
		<td align="right">�ϴ��ļ�&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="loadFile" style="width:250px;">&nbsp;
			<span class="biTian">���ϴ������ļ�*</span>
		</td>
	  </tr>
	  <tr>
		<td align="right">��ע&nbsp;&nbsp;</td>
		<td>
			<textarea rows="4" cols="18" name="remark"></textarea>
		</td>
	  </tr>
	</table>
</div>
</form>
</div>
</body>
<script language="javascript">
function fun_save(){
	if(document.forms[0].applier.value==""){
		alert("�����˲���Ϊ��");
		return false;
	}
	if(document.forms[0].hire_bank.value==""){
		alert("�������в���Ϊ��");
		return false;
	}
	if(document.forms[0].fact_date.value==""){
		alert("�������ڲ���Ϊ��");
		return false;
	}
	if(document.forms[0].loadFile.value==""){
		alert("��ѡ���ϴ��ļ�");
		return false;
	}
	//�ϴ��ļ��ĺ�׺
	var bf = document.forms[0].loadFile.value;
	var extType = bf.substr(bf.lastIndexOf(".")+1);
	//alert(extType);
	
	if(confirm("ȷ��Ҫ�ϴ�������ļ�"+bf)){
		document.forms[0].action="cx_sq_save.jsp?savetype=add";
		document.getElementById("saveTd").innerHTML="�ļ��ϴ��У����Ժ�";
		document.forms[0].submit();
	}
}
</script>
</html>
