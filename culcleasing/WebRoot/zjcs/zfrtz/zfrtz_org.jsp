<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ page import="com.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>���ƻ����� - �����ƻ�</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	</head>

	<body onload="ForbidErrorKeydown();">
		<form name="form1" method="post" action="zfrtz_save.jsp"
			target="_blank" onSubmit="return checkdata(this);">
			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				style="display:none" height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						���ƻ����� &gt; �����ƻ�
					</td>
				</tr>
			</table>
			<!--�������-->

			<!--������Ͳ�������ʼ-->

			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top:2px;">
				<tr class="maintab">
					<td align="left" width="1%">

						<%
							String contract_id = getStr(request.getParameter("contract_id"));

							String curr_date = getSystemDate(0); //��֤��Ϣ
							String sqlstr;
							ResultSet rs;

							

							sqlstr = "select * from fund_rent_plan where contract_id='"
									+ contract_id + "' order by rent_list";
							rs = db.executeQuery(sqlstr);
							

							//System.out.println("sqlstr======================================="+sqlstr);
						%>



						<!--������ť��ʼ-->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								

							</tr>
						</table>
						<!--������ť����-->
					</td>
					<td align="right" width="90%">


						<!--��ҳ���ƿ�ʼ-->
					</td>
				</tr>
			</table>

			<!--��ҳ���ƽ���-->






			<!--����ʼ-->

			<div
				style="vertical-align:top;height:300px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"
				id="mydiv";>


				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th>
							��ͬ���
						</th>
						<th>
							����
						</th>
						<th>
							�ƻ�״̬
						</th>
						<th>
							�и�����
						</th>
						<th>
							���
						</th>
						<th>
							����
						</th>
						<th>
							������
						</th>
						<th>
							��Ϣ
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
			<!--�������-->
		</form>
	</body>
</html>
<script language="javascript">


</script>
