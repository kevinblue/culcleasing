<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>�ʽ�ƻ������� - ͷ��Ԥ���</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/calend.js"></script>

		<script Language="Javascript" src="../../js/jquery.js"></script>
		<script type="text/javascript"
			src="../../js/stleasing_tabledata_nonewline.js"></script>
		<script type="text/javascript" src="../../js/stleasing_function.js"></script>
		<link href="../../css/stleasing_tabledata.css" rel="stylesheet"
			type="text/css">
	</head>

	<!-- �������� -->
	<%@ include file="../../public/commonVariable.jsp"%>
	<!-- �������� -->

	<body onload="public_onload(0);">
		<form action="cwtc_report.jsp" name="dataNav">
			<%
				String start_date = getStr(request.getParameter("start_date"));
				String end_date = getStr(request.getParameter("end_date"));

				String if_hire = getStr(request.getParameter("if_hire"));
				String dept_no = getStr(request.getParameter("dept_no"));
				String dept_name = getStr(request.getParameter("dept_name"));
				
				String proj_manage = getStr(request.getParameter("proj_manage"));
				String manage_name=getStr(request.getParameter("manage_name"));
				String proj_industry = getStr(request.getParameter("proj_industry"));
				String code = getStr(request.getParameter("code"));
			%>

			<!--���⿪ʼ-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						�ʽ�ƻ�������&gt; ͷ��Ԥ���
					</td>
				</tr>
			</table>
			<!--�������-->

			<!--���۵���ѯ��ʼ-->
			<div style="width: 100%;" id="queryArea">
				<fieldset
					style="width: 100%; TEXT-ALIGN: center; margin: 0px 5px 0px 5px;">
					<legend>
						&nbsp;��ѯ����
						<img name="Changeicon" border="0" src="../../images/jt_b.gif"
							onclick="javascript:fieldsetHidden();" style="cursor: hand"
							title="��ʾ/��������">
						&nbsp;
					</legend>
					<table border="0" width="100%" cellspacing="1" cellpadding="0">
						<tr>


							<td>
								�ʽ�ƻ���ʼ��:&nbsp;&nbsp;
								<input name="start_date" id="srart_date" type="text" size="15"
									value="<%=start_date%>" readonly dataType="Date">
								<img onClick="openCalendar(start_date);return false"
									style="cursor: pointer;" src="../../images/tbtn_overtime.gif"
									width="20" height="19" border="0" align="absmiddle">
								&nbsp;&nbsp; ��������:
								<input name="end_date" id="end_date" type="text" size="15"
									value="<%=end_date%>" readonly dataType="Date">
								<img onClick="openCalendar(end_date);return false"
									style="cursor: pointer;" src="../../images/tbtn_overtime.gif"
									width="20" height="19" border="0" align="absmiddle">
							</td>

							<td>
								�Ƿ����:&nbsp;&nbsp;
								<select name="if_hire" id="if_hire" style="width: 115px;"
									Require="true">
									<script type="text/javascript">
 w(mSetOpt('<%=if_hire%>',"|�Ѻ���|δ����","|1|0"));
</script>
							</td>

							<td colspan="2">
								<input type="button" onclick="dataNav.submit()" value="��ѯ">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="button" onclick="clearQuery()" value="���">
							</td>
						</tr>

						<tr>
							<td>
								��������:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input style="width: 150px;" name="dept_no" id="dept_no"
									type="hidden" readonly="readonly" value="<%=dept_no %>">
								<input style="width: 115px;" name="dept_name" id="dept_name"
									type="text" readonly="readonly" value="<%=dept_name %>">
								<img src="../../images/fdmo_65.gif" alt="ѡ" width="19"
									height="19" align="absmiddle" style="cursor: pointer"
									onClick="OpenDataWindow('','','','','��������','base_department','dept_name','dept_name|id','id','id','asc','dataNav.dept_name','dataNav.dept_name|dataNav.dept_no');">
							</td>

							<td>
								��Ŀ����:&nbsp;
								<input style="width: 150px;" name="proj_manage" id="proj_manage"
									type="hidden" readonly="readonly" value="<%=proj_manage %>">
								<input style="width: 115px;" name="manage_name" id="manage_name"
									type="text" readonly="readonly" value="<%=manage_name %>">
								<img src="../../images/fdmo_65.gif" alt="ѡ" width="19"
									height="19" align="absmiddle" style="cursor: pointer"
									onClick="OpenDataWindow('','','','','��Ŀ����','base_user','name','name|id','id','id','asc','dataNav.manage_name','dataNav.manage_name|dataNav.proj_manage');">
							</td>

							<td>
								���:&nbsp;&nbsp;
								<input style="width: 150px;" name="proj_industry"
									id="proj_industry" type="hidden" readonly="readonly" value="<%=proj_industry %>">
								<input style="width: 115px;" name="code" id="code" type="text"
									readonly="readonly" value="<%=code %>">
								<img src="../../images/fdmo_65.gif" alt="ѡ" width="19"
									height="19" align="absmiddle" style="cursor: pointer"
									onClick="OpenDataWindow('','','','','���','base_trade','board_name','board_name|code','code','code','asc','dataNav.code','dataNav.code|dataNav.proj_industry');">
							</td>
						</tr>

					</table>
				</fieldset>
			</div>
			<!-- ��ѯ�������� -->

			<!--������Ͳ�������ʼ-->
			<table border="0" width="100%" id="table8" cellspacing="0"
				cellpadding="0" style="margin-top: 2px;">
				<tr class="maintab">
					<td align="left" width="1%">
						<!--������ť��ʼ-->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr class="maintab">
								<td>
									<BUTTON class="btn_2" type="button" onclick="exportData();">
										<img src="../../images/save.gif" align="absmiddle" border="0">
										&nbsp;����EXCEL
									</button>
								</td>
								<td>
									<img src="../../images/sbtn_split.gif" width="2" height="14">
								</td>
								<td nowrap>
								</td>
								<!--������ť����-->
							</tr>
						</table>
						<!--������ť����-->
					</td>
					<td align="right" width="90%">%<!-- ��ҳ���ƿ�ʼ -->
						<!--��ҳ���ƽ���-->
					</td>
				</tr>
			</table>

			<!--����ʼ-->
			<div
				style="vertical-align: top; width: 100%; overflow: auto; position: relative;"
				id="mydiv">
				<table border="0" style="border-collapse: collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">

					<tr class="maintab_content_table_title">
						<th colspan="2" style="font-weight: bold; width: 40%;">
							��Ŀ
						</th>
						<th align="center" style="font-weight: bold;">
							����
						</th>
						<th align="center" style="font-weight: bold;">
							����
						</th>
					</tr>

					<tbody id="data">
						<%
							//---------------
							String partSql = "";
							//������
							double x1I = 0f;//Ԫ��
							double x2I = 0f;
							double x3I = 0f;
							double x4I = 0f;
							double x5I = 0f;
							double x6I = 0f;
							double x7I = 0f;
							double x8I = 0f;

							double x1O = 0f;//Ԫ��
							double x2O = 0f;
							double x3O = 0f;
							double x4O = 0f;
							double x5O = 0f;

							double xIH = 0f;//����ϼ�
							double xOH = 0f;//֧���ϼ� 

							double XZH = 0f;//ͷ���ܺ� = ���� - ����

							partSql = "Exec dbo.Report_Lease_BB '" + start_date + "','"
									+ end_date + "','" + if_hire + "','" + dept_no + "','"
									+ proj_manage + "','" + proj_industry + "' ";
							System.out.println("partSql:" + partSql);
							db.executeQuery(partSql);

							partSql = "Select * from sys_tool ";
							rs = db.executeQuery(partSql);
							if (rs.next()) {
								x1I = rs.getDouble("resVal01_I");
								x2I = rs.getDouble("resVal02_I");
								x4I = rs.getDouble("resVal04_I");
								x5I = rs.getDouble("resVal05_I");
								x6I = rs.getDouble("resVal06_I");
								x7I = rs.getDouble("resVal07_I");
								x8I = rs.getDouble("resVal08_I");

								x1O = rs.getDouble("resVal01_O");
								x2O = rs.getDouble("resVal02_O");
								x3O = rs.getDouble("resVal03_O");
								x4O = rs.getDouble("resVal04_O");
								x5O = rs.getDouble("resVal05_O");
							}
							//----------------
						%>
						<!-- �ֽ����� -->
						<!-- �ֽ����� -->
						<tr>
							<td rowspan="3">
								�ֽ�����
							</td>
							<td align="center" nowrap="nowrap">
								�������
							</td>
							<td><%=CurrencyUtil.convertFinance(x1I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								���б����������
							</td>
							<td><%=CurrencyUtil.convertFinance(x2I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								�۳�������������
							</td>
							<%
								x3I = x1I - x2I;
							%>
							<td><%=CurrencyUtil.convertFinance(x3I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td rowspan="5">
								�ʽ�����
							</td>
							<td align="center" nowrap="nowrap">
								������Ӫ��ֽ�����
							</td>
							<td><%=CurrencyUtil.convertFinance(x4I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								���н���ʽ�����
							</td>
							<td><%=CurrencyUtil.convertFinance(x5I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								�����л�������ֽ�����
							</td>
							<td><%=CurrencyUtil.convertFinance(x6I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								�����ڲ�����ֽ�����
							</td>
							<td><%=CurrencyUtil.convertFinance(x7I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								��������
							</td>
							<td><%=CurrencyUtil.convertFinance(x8I)%></td>
							<td>
								0
							</td>
						</tr>

						<tr style="background-color: #CCFFFF;">
							<td colspan="2" align="center">
								�ϼ�
							</td>
							<%
								xIH = x3I + x4I + x5I + x6I + x7I + x8I;
							%>
							<td><%=CurrencyUtil.convertFinance(xIH)%></td>
							<td>
								0
							</td>
						</tr>


						<!-- �ֽ�֧�� -->
						<tr>
							<td rowspan="5">
								�ֽ�����
							</td>
							<td align="center" nowrap="nowrap">
								��Ӫ��ֽ�����
							</td>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(x1O)%></td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								��������𣨷Ǳ���
							</td>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(x2O)%></td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								����������Ϣ���Ǳ���
							</td>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(x3O)%></td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								����������
							</td>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(x4O)%></td>
						</tr>

						<tr>
							<td align="center" nowrap="nowrap">
								��������
							</td>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(x5O)%></td>
						</tr>

						<tr style="background-color: #CCFFFF;">
							<td colspan="2" align="center">
								�ϼ�
							</td>
							<%
								xOH = x1O + x2O + x3O + x4O + x5O;
							%>
							<td>
								0
							</td>
							<td><%=CurrencyUtil.convertFinance(xOH)%></td>
						</tr>

						<tr style="background-color: green;">
							<td colspan="2" align="center">
								<font style="font-weight: bold;">ͷ��</font>
							</td>
							<%
								XZH = xIH - xOH;
							%>
							<td colspan="2"><%=CurrencyUtil.convertFinance(XZH)%></td>
						</tr>
						
					
					</tbody>
				</table>
				<table border="0" style="border-collapse:collapse;" align="center"
							cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
						 <tr bgcolor="yellow">
							<th align="center" style="font-weight: bold;">��Ŀ����</th>
							<th align="center" style="font-weight: bold;">����</th>
							<th align="center" style="font-weight: bold;">�տ�</th>
							<th align="center" style="font-weight: bold;">�ƻ�����</th>
							<th align="center" style="font-weight: bold;">ʵ������</th>
						 </tr>
						 <tbody>
						 <%
						 String wherestr1="";
						 if(!start_date.equals("") && !end_date.equals("")){
						 wherestr1="and convert(varchar(10),plan_date,120)>='"+start_date+"' and convert(varchar(10),plan_date,120)<='"+end_date+"'";
						 }
						 String sqlstr1="SELECT TOP 3 ci.project_name, cffcp.plan_money AS payin, 0 AS payout, cffcp.plan_date, (SELECT TOP 1 fact_date FROM fund_fund_charge WHERE match_list = cffcp.id) AS fact_date FROM contract_fund_fund_charge_plan cffcp LEFT JOIN contract_info ci ON ci.contract_id = cffcp.contract_id WHERE cffcp.pay_way = '�տ�' "+wherestr1+" ORDER BY plan_money DESC ";
						 System.out.println("�������sql"+sqlstr1);
						 ResultSet rs1=null;
						 rs1=db.executeQuery(sqlstr1);
						 while(rs1.next()){
						 %>
						 <tr>
							<td><%=rs1.getString("project_name")%></td>
							<td><%=CurrencyUtil.convertFinance(rs1.getString("payout"))%></td>
							<td><%=CurrencyUtil.convertFinance(rs1.getString("payin"))%></td>
							<td><%=getDBDateStr(rs1.getString("plan_date"))%></td>
							<td><%=getDBDateStr(rs1.getString("fact_date"))%></td>
						</tr>
						<%}%>
						 <%
						 String wherestr2="";
						 if(!start_date.equals("") && !end_date.equals("")){
						 wherestr2="and convert(varchar(10),plan_date,120)>='"+start_date+"' and convert(varchar(10),plan_date,120)<='"+end_date+"'";
						 }
						 String sqlstr2="SELECT TOP 7 ci.project_name, 0 AS payin, cffcp.plan_money AS payout, cffcp.plan_date,(SELECT TOP 1 fact_date FROM fund_fund_charge WHERE match_list = cffcp.id) AS fact_date FROM contract_fund_fund_charge_plan cffcp LEFT JOIN contract_info ci ON cffcp.contract_id = ci.contract_id WHERE cffcp.pay_way = '����' "+wherestr2+" ORDER BY plan_money DESC ";
						 System.out.println("�������sql"+sqlstr2);
						 ResultSet rs2=null;
						 rs2=db.executeQuery(sqlstr2);
						 while(rs2.next()){
						 %>
						 <tr>
							<td><%=rs2.getString("project_name")%></td>
							<td><%=CurrencyUtil.convertFinance(rs2.getString("payout"))%></td>
							<td><%=CurrencyUtil.convertFinance(rs2.getString("payin"))%></td>
							<td><%=getDBDateStr(rs2.getString("plan_date"))%></td>
							<td><%=getDBDateStr(rs2.getString("fact_date"))%></td>
						</tr>
						<%}%>
						</tbody>
					</table>
					<%
							db.close();
						%>
			</div>
			<!--�������-->


		</form>
	</body>
	<script type="text/javascript">
 function exportData(){
 	if(confirm("�Ƿ�ȷ������excel?")){
 		dataNav.action="cwtc_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="cwtc_report.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>