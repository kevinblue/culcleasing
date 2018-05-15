<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>租金测算 - 手工偿还计划添加</title>
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<script src="../../js/validator.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>


<script type="text/javascript">
	
	function checkDate(){//检查日期
	alert('join');
		var nowDateTime = document.getElementById('nowDateTime').value;
		var newDateTime = document.getElementById('plan_date').value;
		//alert(newDateTime);
		if(newDateTime < nowDateTime){
			alert("偿还日期不能小于今天的日期!");
			document.getElementById('plan_date').value = nowDateTime;
			return false;
		}
	}
	//给租金赋值
	function fzValue(){
		//alert('join');
		//租金 = 本金 + 利息
		var corpus = document.getElementById('corpus').value;
		var interest = document.getElementById('interest').value;	
		var rent = document.getElementById('rent').value;	
		if(corpus == null || corpus == ''){
			alert("本金不能为空!");
			return false;
		}
		else if(interest == null || interest == ''){
			alert("利息不能为空!");
			return false;
		}
		else{
			var str = document.getElementById('rent').value;
			//alert(rent != str);
			if(rent < str || rent > str){
				alert("租金=本金+利息");
				return false;
			}else{
				document.getElementById('rent').value = Number(corpus) + Number(interest);
			}
		}
			
	}
</script>
	</head>
	<body onload="fun_winMax();">
<form name="form1" method="post" action="zjcs_contract_save.jsp"  onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {
	overflow: hidden;
}
</style>

<%
	//项目和交易的做成一个
	//String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	//String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	//String temp = getStr(request.getParameter("temp"));//用于判断是项目还是合同的操作
	String savetype = getStr(request.getParameter("savetype"));//操作类型
	String key_id = getStr(request.getParameter("itemselect"));//id
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs;
	String query_maxRentList = "";
	String max_rentList = "";//封装偿还计划列表中最大一期的’期项‘ 
	
	//查询合同租金表中最大的期项
	query_maxRentList = "select max(rent_list) as rent_list  from fund_rent_plan  ";
	query_maxRentList = query_maxRentList + " where  contract_id = '"+ contract_id + "' ";
	rs = db.executeQuery(query_maxRentList);
	
	while (rs.next()) {
		max_rentList = getDBStr(rs.getString("rent_list"));
		if(max_rentList.equals("") || max_rentList == null){
			max_rentList = "1";
		}else{
			max_rentList = String.valueOf(Integer.parseInt(max_rentList) + 1);
		}
	}
%>
<!-- 隐藏于传值 -->
<input type="hidden" name="nowDateTime" id="nowDateTime" value="<%=nowDateTime%>"/>
<input name="contract_id" type="hidden" value="<%=contract_id%>"/>
<input name="savetype" type="hidden" value="<%=savetype%>"/>

			<div id=bgDiv>
				<table class="title_top" width=100% height=100% align=center
					cellspacing=0 border="0" cellpadding="0">
					<tr valign="top" class="tree_title_txt">
						<td class="tree_title_txt" height=26 valign="middle">
							租金信息 &gt; 偿还计划添加
						</td>
					</tr>
					<tr valign="top">
						<td align=center width=100% height=100%>
							<table align=center width=96% border="0" cellspacing="0"
								cellpadding="0" style="margin-top: 0px">
								<tr>
									<td align="center">
										<!--操作按钮开始-->
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="maintab_dh">
												<td nowrap>
													<BUTTON class="btn_2" name="btnSave" value="保存" onclick="fzValue()"
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
													新 增
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
									style="background: #ffffff; width: 96%; height: 500px; overflow: auto;">
									<div id="TD_tab_0">
										<input type="hidden" name="savetype" value="add">
										<table border="0" cellspacing="0" cellpadding="0" width="98%"
											align="center" class="tab_table_title">
											<tr>
												<td align="center">
													编号
												</td>
												<!-- 有可能是项目编号  -->
												<td>
													
													<input name="name_id" type="text" size="20" maxB="20"
														Require="ture" value="<%=contract_id%>" readonly>
													<span class="biTian">*</span>
												</td>
												<td align="center"> 期项 </td>
												<td>
													<input name="rent_list" type="text" size="20"
														value="<%=max_rentList%>" maxB="20" Require="true"
														dataType="Integer" readonly="readonly"/>
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td align="center"> 偿还日期 </td>
												<td>
													<input name="plan_date" type="text" size="15" 
														readonly value="<%=nowDateTime%>"  onchange="checkDate()"
														maxlength="10" dataType="Date" Require="ture"/>
													<img onClick="openCalendar(plan_date);return false"
														style="cursor: pointer;"
														src="../../images/tbtn_overtime.gif" width="20"
														height="19" border="0" align="absmiddle">
													<span class="biTian">*</span>
												</td>
												<td align="center"> 本金 </td>
												<td>
													<input name="corpus" type="text" size="20" maxB="20"
														Require="true" dataType="Money">
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td align="center"> 利息 </td>
												<td>
													<input name="interest" type="text" size="20" maxB="20"
														Require="true" dataType="Double" onchange="fzValue()"/>
													<span class="biTian">*</span>
													
												</td>
												<td align="center"> 租金 </td>
												<td>
													<input name="rent" type="text" size="20" maxB="20"
														Require="true" dataType="Money" onchange="fzValue()" readonly="readonly"/>
													<span class="biTian">*</span>
												</td>
											</tr>

										</table>
									</div>
									<div id="TD_tab_1" style="display: none;"> 选择卡中的内容2 </div>
									<div id="TD_tab_2" style="display: none;">
										选择卡中的内容3 选择卡中可能包含以下内容： 注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。
									</div>
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
//内部Iframe高度自适应
//function autoResize()
//{try{document.all["UserBody"].style.height=UserBody.document.body.scrollHeight}catch(e){}}
</script>
		</form>

		<!-- end cwMain -->
	</body>
</html>
<%if(null != db){db.close();}%>