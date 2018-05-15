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

							<input type="hidden" name="savetype" value="mod">
							<input type="hidden" name="czid" value="<%=czid %>">
							
							<table border="0" cellspacing="0" cellpadding="0" width="100%"
								class="tab_table_title">
								<tr>
									<td scope="row">
										罚息额度
									</td>
									<td>
										<input name="penalty_limit" type="text"
											value="<%=penalty_limit%>" Require="ture">
										<span class="biTian">*</span>
									</td>
								</tr>
								<tr>
									<td scope="row">
										有效开始日期
									</td>
									<td><%=start_date%></td>
								</tr>
								<tr>
									<td scope="row">
										有效结束日期
									</td>
									<td><%=end_date%></td>
								</tr>
								<tr>
									<td scope="row">
										状态
									</td>
									<td>
									<select class="text"  style="width: 50px; " name="flag">
										<script>w(mSetOpt("<%= flag %>","|有效|无效"));</script>
									</select>
		       					 	
									</td>
								</tr>

								<tr>
									<td scope="row">
										最后更新日期
									</td>
									<td><%=gxrq%></td>
								</tr>
								<tr>
									<td scope="row">
										操作员
									</td>
									<td><%=xm%></td>
								</tr>
							</table>
							<!-- end cwDataNav -->

							<div style="margin: 12px; text-align: right;">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td>
											<input name="btnSave" value="保存" type="submit"
												class="btn3_mouseout">
										</td>
										<td>
											<input name="btnReset" value="关闭" type="button"
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
function isClose() {
	if (confirm("是否确认关闭!")) {
		window.close();
		opener.location.reload();
	}
    
	return false;
}
	</script>
</html>


