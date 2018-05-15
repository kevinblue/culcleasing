<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-tzxj-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS管理 - GPS上传</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form name="list" action="gps_tzxj_save.jsp" enctype="multipart/form-data" method="post" onSubmit="">
<input type="hidden" name="upload" value="up">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap id="saveTd">
									<BUTTON class="btn_2" name="btnSave" value="保存GPS巡检报告"  type="submit">
									<img src="../../images/save.gif" align="absmiddle" border="0">保存GPS巡检报告</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
		<td align="right" width="20%">上传日期&nbsp;&nbsp;</td>
		<td width="80%"><input name="ebank_date" type="text" value="<%=getSystemDate(0) %>" size="15" readonly maxlength="10" dataType="Date"> <img  onClick="openCalendar(ebank_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
	  </tr>
	  <tr>
		<td align="right">上传文件&nbsp;&nbsp;</td>
		<td><table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End 上传组件 --><span class="biTian">允许上传的文件类型.xls</span></td>
	  </tr>
	</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">

function fun_save(){
	if(confirm("确认要上传GPS巡检报告文件"+document.forms[0].name1.value)){
	document.forms[0].action="gps_tzxj_save.jsp";
	document.getElementById("saveTd").innerHTML="文件上传中，请稍后";
	document.forms[0].submit();
	}
}

</script>
