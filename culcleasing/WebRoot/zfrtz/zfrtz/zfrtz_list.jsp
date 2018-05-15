<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>租金计划管理 - 支付日调整</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
		<script language="javascript" src="/dict/js/js_dictionary.js"></script>
		<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	</head>

	<body onload="setDivHeight('mydiv',-55)"
		style="border:1px solid #8DB2E3;">
			<form name="form1" method="post" action="zfrtz_save.jsp" target="_blank"
				onSubmit="return Validator.Validate(this,3);">
			<!--标题开始-->
			<table border="0" width="100%" cellspacing="0" cellpadding="0"
				height="25">
				<tr class="tree_title_txt">
					<td nowrap width="100%" class="tree_title_txt" valign="middle"
						id="cwCellTopTitTxt">
						租金计划管理 &gt; 支付日调整
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
	String sqlstr = "";
	ResultSet rs;
	String wherestr = " where 1=1";
	String searchFld = getStr(request.getParameter("searchFld"));
	String searchKey = getStr(request.getParameter("searchKey"));
	String searchFld_tmp = "";
	

	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String flag="";
	if (contract_id.equals("")) {
		wherestr = " where 1=0";
	} else {
		wherestr = wherestr + " and fund_rent_plan.contract_id='"+ contract_id + "'";
	}

	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		flag="1";
	}rs.close();
	
	if(flag.equals("")){
		sqlstr = "select fund_rent_plan.contract_id,fund_rent_plan.rent_list,fund_rent_plan.plan_status,fund_rent_plan.plan_date,fund_rent_plan.rent,fund_rent_plan.corpus,fund_rent_plan.year_rate,fund_rent_plan.interest from fund_rent_plan"
			+ wherestr;
	}else{
		sqlstr = "select fund_rent_plan_temp.contract_id,fund_rent_plan_temp.rent_list,fund_rent_plan_temp.plan_status,fund_rent_plan_temp.plan_date,fund_rent_plan_temp.rent,fund_rent_plan_temp.corpus,fund_rent_plan_temp.year_rate,fund_rent_plan_temp.interest from fund_rent_plan_temp where fund_rent_plan_temp.measure_id='"+doc_id+"'";
	}
	
	//System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<input name="contract_id" type="hidden" value="<%=contract_id %>">
<input name="doc_id" type="hidden" value="<%=doc_id %>">
<table border="0" cellspacing="0" cellpadding="0">
	<tr class="maintab">
		<td nowrap>
		支付日变更为<input name="zfr_date" type="text" size="5" maxB="2" Require="true">日，开始期项为第<input name="start_rent_list" type="text" size="5" maxB="3" Require="true">期
		<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit">
<img src="../../images/save.gif" align="absmiddle" border="0" >保存</button>
		</td>
		
	</tr>
</table>
<!--操作按钮结束-->
					</td>
					<td align="right" width="90%">


						<!--翻页控制开始-->


						<%
							int intPageSize = 200; //一页显示的记录数
							int intRowCount = 0; //记录总数
							int intPageCount = 1; //总页数
							int intPage; //待显示页码
							String strPage = getStr(request.getParameter("page")); //取得待显示页码
							if (strPage.equals("")) { //表明在QueryString中没有page这一个参数，此时显示第一页数据
								intPage = 1;
							} else {
								intPage = java.lang.Integer.parseInt(strPage);
								if (intPage < 1)
									intPage = 1;
							}

							rs = db.executeQuery(sqlstr);

							if (rs.next()) {
								rs.last(); //获取记录总数
								intRowCount = rs.getRow();
								intPageCount = (intRowCount + intPageSize - 1) / intPageSize; //记算总页数
								if (intPage > intPageCount)
									intPage = intPageCount; //调整待显示的页码
								if (intPageCount > 0)
									rs.absolute((intPage - 1) * intPageSize + 1); //将记录指针定位到待显示页的第一条记录上
								int i = 0;
						%>


						
					</td>
				</tr>
			</table>

		<!--翻页控制结束-->






		<!--报表开始-->

		<div
			style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"
			id="mydiv";>
				
				
				<table border="0" style="border-collapse:collapse;" align="center"
					cellpadding="2" cellspacing="1" width="100%"
					class="maintab_content_table">
					<tr class="maintab_content_table_title">
						<th>合同编号</th>
						<th>期项</th>
						<th>计划状态</th>
						<th>承付日期</th>
						<th>租金</th>
						<th>本金</th>
						<th>年利率</th>
						<th>租息</th>
					</tr>


					<%
					while (i < intPageSize && !rs.isAfterLast()) {
					%>

					<tr>
						<td><%=getDBStr(rs.getString("contract_id"))%></td>
						<td><%=getDBStr(rs.getString("rent_list"))%></td>
						<td><%=getDBStr(rs.getString("plan_status"))%></td>
						<td><%=getDBDateStr(rs.getString("plan_date"))%></td>
						<td><%=getDBStr(rs.getString("rent"))%></td>
						<td><%=getDBStr(rs.getString("corpus"))%></td>
						<td><%=getDBStr(rs.getString("year_rate"))%></td>
						<td><%=getDBStr(rs.getString("interest"))%></td>
					</tr>
					
					<%
								rs.next();
								i++;
							}
					
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
