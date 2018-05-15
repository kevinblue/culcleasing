<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>；利息 - 修改</title>
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<script src="../../js/calend.js"></script>

		<script language="javascript" src="/dict/js/js_dictionary.js"></script>
		<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

		<script Language="Javascript" src="../../js/jquery.js"></script>
		<script type="text/javascript"
			src="../../js/stleasing_tabledata_nonewline.js"></script>
		<script type="text/javascript" src="../../js/stleasing_function.js"></script>
		<link href="../../css/stleasing_tabledata.css" rel="stylesheet"
			type="text/css">

		
	</head>

	<!-- 公共变量 -->
	<%@ include file="../../public/commonVariable.jsp"%>
	<!-- 公共变量 -->

	<!-- 下拉值 -->
	<%@ include file="../../public/selectData.jsp"%>
	<!-- 下拉值 -->

	<%
//提取参数item_id
String item_id = getStr( request.getParameter("item_id") ); 

sqlstr = "select picode,pcode,industry,dbo.T_getName2Title(bi.income_number_year,'FZFS') as income_number_year,rmb,bi.begin_id from vi_INTERFACE_fina_global_interest inter "+
"left join contract_info ci on ci.proj_id=inter.picode left join begin_info bi on bi.contract_id=ci.contract_id "+
"where inter.id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String proj_id = "";
String project_name="";
String industry_type = "";
String income_number_year = "";
String rmb = "";


if(rs.next()){
	proj_id= getDBStr(rs.getString("picode"));
	project_name=getDBStr(rs.getString("pcode"));
	industry_type = getDBStr(rs.getString("industry"));
	income_number_year = getDBStr(rs.getString("income_number_year"));
	rmb = getDBStr(rs.getString("rmb"));

}
%>

	<body onLoad="public_onload(44)" style="border: 0px solid #8DB2E3;">
		<table class="title_top" width=100% height=100% align=center
			cellspacing=0 border="0" cellpadding="0">
			<tr valign="top" class="tree_title_txt">
				<td class="tree_title_txt" height=26 valign="middle" align="left">
					利息&gt; 修改条目
				</td>
			</tr>
			<tr>
				<td align=center width=100% height=100% valign="top">
					<div class="mydivtab" id="mydiv">

						<form name="form1" method="post" action="interest_save.jsp"
							onSubmit="return Validator.Validate(this,3);">
							<input type="hidden" name="item_id" value="<%=item_id %>">
		
							<table border="0" cellspacing="0" cellpadding="0" width="100%"
								class="tab_table_title">
								<tr>
									<td scope="row">
										项目编号
									</td>
									<td scope="row">
										<input name="proj_id" style="width: 150px;"
											type="text" value="<%=proj_id %>" disabled="disabled">
									</td>
									<td scope="row">
										项目名称
									</td>
									<td scope="row">
										<input name="project_name" style="width: 500px;"
											type="text" value="<%=project_name %>" disabled="disabled">
									</td>
									</tr>
									<tr>
									<td scope="row">
										行业
									</td>
									<td scope="row">
										<input name="industry_type" style="width: 150px;"
											type="text" value="<%=industry_type %>" disabled="disabled">
									</td>
									<td scope="row">
										付租方式
									</td>
									<td scope="row">
										<input name="income_number_year" style="width: 150px;"
											type="text" value="<%=income_number_year %>" disabled="disabled">
									</td>
									</tr>
									<tr>
									<td scope="row">
										利息金额
									</td>
									<td scope="row">
										<input name="interest" style="width: 150px;"
											type="text" value="<%=rmb %>">
									</td>
								</tr>
								
							</table>

							<div style="margin: 12px; text-align: right;">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td>
											<input name="btnSave" value="保存" type="submit"
												class="btn3_mouseout">
										</td>

										<td>
											<input name="btnClose" value="取消" type="button"
												onClick="window.close();" class="btn3_mouseout">
										</td>
									</tr>
								</table>
							</div>
							<!-- end cwToolbar -->

						</form>
					</div>
					<!-- end cwMain -->
	</body>
</html>

<%if(null != db){db.close();}%>