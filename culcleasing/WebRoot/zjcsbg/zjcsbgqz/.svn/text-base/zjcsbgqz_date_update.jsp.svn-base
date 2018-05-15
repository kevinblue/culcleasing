<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage=""%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>租金测算 - 请款日期修改</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
	</head>
	<body onload="fun_winMax();">
		<form name="form1" method="post"
			action="zjcsbgqz_date_update_save.jsp"
			onSubmit="return Validator.Validate(this,3);">
			<div id=bgDiv>
				<table class="title_top" width=100% height=100% align=center
					cellspacing=0 border="0" cellpadding="0">
					<tr valign="top" class="tree_title_txt">
						<td class="tree_title_txt" height=26 valign="middle">
							基本信息 &gt; 请款日期修改
						</td>
					</tr>
					<tr valign="top">
						<td align=center width=100% height=100%>
							<table align=center width=96% border="0" cellspacing="0"
								cellpadding="0" style="margin-top:0px">
								<tr>
									<td>
										<!--操作按钮开始-->
										<table border="0" cellspacing="0" cellpadding="0" height="30">
											<tr>
												<td>

													<BUTTON class="btn_2" name="btnSave" value="保存"
														type="submit">
														<img src="../../images/save.gif" align="absmiddle"
															border="0">
														保存
													</button>
													<BUTTON class="btn_2" name="btnReset" value="取消"
														onclick="window.close();">
														<img src="../../images/hg.gif" align="absmiddle"
															border="0">
														取消
													</button>

												</td>
											</tr>
										</table>
										<!--操作按钮结束-->
									</td>
								</tr>
								<tr>
									<td height="1" bgcolor="#DFDFDF"></td>
								</tr>
								<tr>
									<td height="5"></td>
								</tr>
								<tr>
									<td width="100%">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td id="Form_tab_0" class="Form_tab" width=70 align=center
													onclick="chgTabN()" valign="middle">
													修改信息
												</td>

												<td id="Form_tab_1" class="Form_tab" width=0 align=center
													onclick="chgTabN()" valign="middle"></td>
												<td id="Form_tab_2" class="Form_tab" width=0 align=center
													onclick="chgTabN()" valign="middle"></td>

											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="tab_subline" width="100%" height="2"></td>
								</tr>
							</table>
							<center>

								<div id="divH" class="tabBody"
									style="background:#ffffff;width:96%;height:500px;overflow:auto;">
									<div id="TD_tab_0">

																<%
											//--------以上为权限控制-----------------------------

											String czid = getStr(request.getParameter("czid"));
											String sqlstr = "select inter_account_ebankcode.id,inter_account_ebankcode.account,inter_account_ebankcode.code from inter_account_ebankcode where inter_account_ebankcode.id='"
													+ czid + "'";
											//System.out.println("sqlstr======================"+sqlstr);
											ResultSet rs = db.executeQuery(sqlstr);

											String account = "";
											String code = "";

											if (rs.next()) {
												account = getDBStr(rs.getString("account"));
												code = getDBStr(rs.getString("code"));
											}
											rs.close();
											db.close();
										%>

										<%
											//得到传过来的参数
											String contract_id = getStr(request.getParameter("contract_id"));
											String doc_id = getStr(request.getParameter("doc_id"));
											String rent_list = getStr(request.getParameter("rent_list"));
											String rent_date = getStr(request.getParameter("rent_date"));
										%>

										<input type="hidden" name="savetype" value="mod">
										<input type="hidden" name="czid" value="<%=czid%>">

										<input type="hidden" name="contract_id"
											value="<%=contract_id%>">
										<input type="hidden" name="doc_id" value="<%=doc_id%>">
										<input type="hidden" name="rent_list" value="<%=rent_list%>">


										<table class="tab_table_title" border="0" cellspacing="0"
											cellpadding="0" width="100%">
											<tr>
												<td>
													第
													<%=rent_list%>
													期
												</td>
												<td>
													计划日期：
													<%=rent_date%>
												</td>
											</tr>
											<tr>
												<td>
													修改为:
													<input name="charge_date" type="text" dataType="Date"
														size="10" maxlength="10" maxB="10" Require="true">
													<img onClick="openCalendar(charge_date);return false"
														style="cursor:pointer; "
														src="../../images/tbtn_overtime.gif" width="20"
														height="19" border="0" align="absmiddle">
													<span class="biTian">*</span>
												</td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<div id="TD_tab_1" style="display:none;">
									选择卡中的内容2
								</div>
								<div id="TD_tab_2" style="display:none;">
									选择卡中的内容3 选择卡中可能包含以下内容： 注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
								</div>
							</center>
							<table width=96% align=center border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<td width="50%"></td>
									<td width="50%" valign="middle" align="right">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<!--添加结束-->

			<!--控制选择卡和内置iframe的高度适应窗口-->
			<script language="javascript">
ShowTabN(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
</script>
		</form>
	</body>
</html>
