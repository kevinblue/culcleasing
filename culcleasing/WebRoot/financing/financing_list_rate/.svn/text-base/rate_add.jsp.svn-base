<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>央行基准利率新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>

<script src="/tenwa/js/public.js"></script>
<script src="/tenwa/js/publicEvent.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="/dict/js/ajax_popupDialog.js"></script>

<!-- 日期控件 -->
<script src="../../js/calend.js"></script>
<script type="text/javascript">
	function closeWin(){
		opener.parent.location.reload();
		window.close();
	}
</script>
</head>
<body>
	<%
		String model = getStr(request.getParameter("model"));
			String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
			String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
			String key_id = getStr(request.getParameter("key_id"));//央行基准利率基准表的主键
			ResultSet rs; 
			//根据登录ID查询登录用户名称
			String user_name = "";
			rs = db.executeQuery(" select name from base_user where id = '"+user_id+"' ");//
			if(rs.next()){
				user_name = getDBStr(rs.getString("name"));
			}
			List<String> list = new ArrayList<String>();
			int flag = 0;
			System.out.println("model的值为==>"+model);
			
	%>

	<form action="rate_save.jsp" method="post" target=""
		onSubmit="return Validator.Validate(this,3);">
		<input type="hidden" name="model" id="model" value="<%=model%>">
		<input type="hidden" name="key_id" id="key_id" value="<%=key_id%>">
		<!--标题开始-->
		<table class="title_top" width=100% height=100% align=center
			cellspacing=0 border="0" cellpadding="0">
			<tr valign="top" class="tree_title_txt">
				<td class="tree_title_txt" height=26 valign="middle">央行基准利率调整</td>
			</tr>
			<tr valign="top">
				<td align=center width=100% height=100%>
					<table align=center width=96% border="0" cellspacing="0"
						cellpadding="0" style="margin-top: 0px">
						<tr>
							<td>
								<!--标题结束--> <!--副标题和操作区开始-->
								<table border="0" width="100%" id="table8" align="center"
									cellspacing="0" cellpadding="0" style="margin-top: 2px;">
									<!--     -->
									<tr class="maintab_dh">
										<td align="left" colspan="2">
											<table border="0" cellspacing="0" cellpadding="0">
												<tr class="maintab_dh">
													<td nowrap>
														<BUTTON class="btn_2" name="btnSave" value="提交"
															type="submit">
															<img src="../../images/save.gif" align="absmiddle"
																border="0">提交
														</button> 
														<BUTTON class="btn_2" name="btnReset" value="取消"
															onClick="window.close();">
															<img src="../../images/hg.gif" align="absmiddle"
																border="0">取消
														</button>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="1" bgcolor="#DFDFDF"></td>
									</tr>
									<tr>
										<td height="5"></td>
									</tr>
									<tr>
										<td class="tab_subline" width="100%" height="2"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

					<div id="mydiv" class="tabBody"
						style="background: #ffffff; width: 96%; height: 500px; overflow: auto;">
						<div id="TD_tab_0">
							<table border="0" style="border-collapse: collapse;"
								align="center" cellpadding="2" cellspacing="1" width="100%"
								hight="95%" class="tab_table_title">
								<tr>
									<th>利率开始执行日期</th>
									<td colspan=""><input type="text" name="Adjust_time" id="Adjust_time"
										size="20" dataType="Date" Require="true"
										value="<%=nowDateTime%>" readonly="readonly" /> <img
										onClick="openCalendar(Adjust_time);return false"
										style="cursor: pointer;" src="../../images/tbtn_overtime.gif"
										width="20" height="19" border="0" align="absmiddle"> <span
										class="biTian">*</span></td>
								</tr>

								<tr>
									<th>本次调整后央行基础利率6个月至1年</th>
									<td><input type="text" name="base_rate_one" id="base_rate_one" size="20"
										dataType="Money" Require="true" value=""  />%</td>
								</tr>
								<tr>
									<th>本次调整后央行基础利率1至3年</th>
									<td><input type="text" name="base_rate_three" id="base_rate_three" size="20"
										dataType="Money" Require="true" value=""  />%</td>
								</tr>
								<tr>
									<th>本次调整后央行基础利率3至5年</th>
									<td><input type="text" name="base_rate_five" id="base_rate_five" size="20"
										dataType="Money" Require="true" value=""  />%</td>
								</tr>
								<tr>
									<th>本次调整后央行基础利率5年以上</th>
									<td><input type="text" name="base_rate_abovefiv" id="base_rate_abovefiv"
										size="20" dataType="Money" Require="true" value=""
										 />% <!-- 登记人  --> <input type="hidden"
										name="creator" value="" /> <!-- 登记时间 --> <input type="hidden"
										name="create_date" value="" /> <!-- 更新人 --> <input
										type="hidden" name="modificator" value="<%=user_name%>" /> <!-- 更新时间  -->
										<input type="hidden" name="modify_date"
										value="<%=nowDateTime%>" /></td>
								</tr>
							</table>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
