<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ page import="com.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>租金计划管理 - 偿还计划</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	</head>

	<body onload="ForbidErrorKeydown();">
		<form name="form1" method="post" action="zfrtz_save.jsp"
			target="_blank" onSubmit="return checkdata(this);">
			<!--标题开始-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				style="display:none" height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						租金计划管理 &gt; 偿还计划
					</td>
				</tr>
			</table>
			<!--标题结束-->

			<!--副标题和操作区开始-->

			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top:2px;">
				<tr class="maintab">
					<td align="left" width="1%">

						<%
							String contract_id = getStr(request.getParameter("contract_id"));

							String curr_date = getSystemDate(0); //验证信息
							String sqlstr;
							ResultSet rs;

							

							sqlstr = "select * from fund_rent_plan where contract_id='"
									+ contract_id + "' order by rent_list";
							rs = db.executeQuery(sqlstr);
							

							//System.out.println("sqlstr======================================="+sqlstr);
						%>



						<!--操作按钮开始-->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								

							</tr>
						</table>
						<!--操作按钮结束-->
					</td>
					<td align="right" width="90%">


						<!--翻页控制开始-->
					</td>
				</tr>
			</table>

			<!--翻页控制结束-->






			<!--报表开始-->

			<div
				style="vertical-align:top;height:300px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"
				id="mydiv";>


				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th>
							合同编号
						</th>
						<th>
							期项
						</th>
						<th>
							计划状态
						</th>
						<th>
							承付日期
						</th>
						<th>
							租金
						</th>
						<th>
							本金
						</th>
						<th>
							年利率
						</th>
						<th>
							租息
						</th>
					</tr>
					<%
						rs = db.executeQuery(sqlstr);
						while (rs.next()) {
					%>

					<tr>
						<td>
							<%=getDBStr(rs.getString("contract_id"))%>
						</td>
						<td>
							<%=getDBStr(rs.getString("rent_list"))%>
						</td>
						<td>
							<%=getDBStr(rs.getString("plan_status"))%>
						</td>
						<td>
							<%=getDBDateStr(rs.getString("plan_date"))%>
						</td>
						<td>
							<%=formatNumberStr(getDBStr(rs.getString("rent")),
								"#,##0.00")%>
						</td>
						<td>
							<%=formatNumberStr(getDBStr(rs.getString("corpus")),
								"#,##0.00")%>
						</td>
						<td>
							<%=formatNumberStr(getDBStr(rs.getString("year_rate")),
								"#,##0.000000")%>
						</td>
						<td>
							<%=formatNumberStr(getDBStr(rs.getString("interest")),
								"#,##0.00")%>
						</td>
					</tr>

					<%
						}
						rs.close();
						db.close();
					%>
				</table>
			</div>
			<!--报表结束-->
		</form>
	</body>
</html>
<script language="javascript">


</script>
