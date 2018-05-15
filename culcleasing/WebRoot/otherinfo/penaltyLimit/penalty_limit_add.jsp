<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>罚息额度设置</title>
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<script src="../../js/calend.js"></script>
	</head>

	<!-- 公共变量 -->
	<%@ include file="../../public/commonVariable.jsp"%>
	<!-- 公共变量 -->

	<%
		String czid = getStr(request.getParameter("czid"));
		sqlstr = "select spl.*,dbo.GETUSERNAME(spl.modificator) as gxr from SYS_Penalty_Limit spl where id='"
				+ czid + "'";
		rs = db.executeQuery(sqlstr);

		String penalty_limit = "";
		String flag = "";

		String gxrq = "";
		String start_date = "";
		String end_date = "";
		String xm = "";

		if (rs.next()) {
			penalty_limit = CurrencyUtil.convertFinance(rs
					.getString("penalty_limit"));
			flag = getDBStr(rs.getString("flag"));
			start_date = getDBDateStr(rs.getString("start_date"));
			end_date = getDBDateStr(rs.getString("end_date"));
			gxrq = getDBDateStr(rs.getString("modify_date"));
			xm = getDBStr(rs.getString("gxr"));
		}

		rs.close();
		db.close();
	%>

	<body onLoad="public_onload(44)" style="border: 0px solid #8DB2E3;">

		<table class="title_top" width=100% height=100% align=center
			cellspacing=0 border="0" cellpadding="0">
			<tr valign="top" class="tree_title_txt">
				<td class="tree_title_txt" height=26 valign="middle" align="left">
					罚息额度设置
				</td>
			</tr>
			<tr>
				<td align=center width=100% height=100% valign="top">
					<div class="mydivtab" id="mydiv">
						<form name="form1" method="post" action="penalty_limit_save.jsp"
							target="_blank" onSubmit="return Validator.Validate(this,3);">
							<!-- end cwCellTop -->

							<input type="hidden" name="savetype" value="add">
							<table border="0" cellspacing="0" cellpadding="0" width="100%"
								class="tab_table_title">
								<tr>
									<td scope="row">
										罚息额度
									</td>
									<td>
										<input name="penalty_limit" type="text"
											 Require="ture">
										<span class="biTian">*</span>
									</td>
								</tr>
								<tr>
									<td scope="row">
										有效开始日期
									</td>
									<td>
									<input name="start_date" id="start_date" type="text" Require="ture" readonly="readonly">
									<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
									 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
									<span class="biTian">*</span>
									</td>
								</tr>
								<tr>
									<td scope="row">
										有效结束日期
									</td>
									<td>		<input name="end_date" id="end_date" type="text" Require="ture" readonly="readonly">
									<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
									 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
									<span class="biTian">*</span></td>
								</tr>

							</table>
							<!-- end cwDataNav -->

							<div style="margin: 12px; text-align: right;">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td>
											<input name="Save" value="保存" type="submit" onclick="checkDate();"
												class="btn3_mouseout">
										</td>
										<td>
											<input name="Reset" value="关闭" type="button"
												class="btn3_mouseout" onclick="isClose();">
										</td>
									</tr>
								</table>
							</div>
							<!-- end cwToolbar -->
						</form>
					</div>
					<!-- end cwMain -->
	</body>
	<script type="text/javascript">
function checkDate(){
	/**
	var dd = document.getElementsByName("start_date").length;
	alert(dd);
	
	var dd4 = document.getElementsByName("start_date")[0];
	
	alert(dd4.value);
	
	var dd2 = document.forms[0].start_date.value;
	alert(dd2);
	
	var dd3 = document.getElementById("start_date").value;
	alert(dd3);
	**/

	var start_date = document.getElementById("start_date").value;
	var end_date = document.getElementById("end_date").value;
	if(start_date<end_date){
		Validator.Validate(this,3);
	}else{
	alert("结束日期不能小于开始日期！")
	}
}	
	
function isClose() {
	if (confirm("是否确认关闭!")) {
		window.close();
		opener.location.reload();
	}
    
	return false;
}
	</script>
</html>


