<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>租金测算 - 不规则租金测算添加</title>
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
		var corpus = document.getElementById('corpus_market').value;
		var interest = document.getElementById('interest_market').value;	
		var rent = document.getElementById('rent').value;	
		var corpus_overage_market = document.getElementById('lease_money').value;	
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
				var tem1 = parseFloat(corpus) + parseFloat(interest);
				var tem2 = parseFloat(corpus_overage_market) - parseFloat(corpus);
				document.getElementById('rent').value = tem1.toFixed(2);//Math.round(tem1,2);
				//剩余本金等于 = 上一期的剩余本金 - 本期的本金
				document.getElementById('corpus_overage_market').value = tem2.toFixed(2);//Math.round(tem2,2);
			}
		}
			
	}
</script>
	</head>
	<body onload="fun_winMax();">
<form name="form1" method="post"  action="zjcs_sg_save.jsp"  onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {
	overflow: hidden;
}
</style>

<%
	//项目和交易的做成一个
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String temp = getStr(request.getParameter("temp"));//用于判断是项目还是合同的操作
	String savetype = getStr(request.getParameter("savetype"));//操作类型
	String key_id = getStr(request.getParameter("itemselect"));//id
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs;
	String query_maxRentList = "";
	String max_rentList = "";//封装偿还计划列表中最大一期的’期项‘ 
	String corpus_overage_market = "";//封装偿还计划列表中最大一期的剩余本金
	String table_where = "";
	//如果是 项目租金偿还计划添加
	if (temp.equals("proj_zjcs")) {
		table_where = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"'";
		//查询临时表中最大的期项
		query_maxRentList = " select corpus_overage_market,rent_list from fund_rent_plan_proj_temp ";
		query_maxRentList = query_maxRentList + " where  proj_id = '"+ proj_id + "' and  measure_id = '" + doc_id + "'";
		query_maxRentList = query_maxRentList + " and rent_list = ( select max(rent_list) as rent_list  from fund_rent_plan_proj_temp  ";
		query_maxRentList = query_maxRentList + " where  proj_id = '"+ proj_id + "' and  measure_id = '" + doc_id + "' )";
		//query_maxRentList = "select max(rent_list) as rent_list  from fund_rent_plan_proj_temp  ";
		//query_maxRentList = query_maxRentList + " where  proj_id = '"+ proj_id + "' and  measure_id = '" + doc_id + "'";
	}
	//###################################################################################################
	//								合同偿还计划手工调整
	//###################################################################################################
	else if(temp.equals("contract_zjcs")){
		table_where = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"'";
		//查询临时表中最大的期项
		query_maxRentList = " select corpus_overage_market,rent_list from fund_rent_plan_temp ";
		query_maxRentList = query_maxRentList + " where  contract_id = '"+ contract_id + "' and  measure_id = '" + doc_id + "'";
		query_maxRentList = query_maxRentList + " and rent_list = ( select max(rent_list) as rent_list  from fund_rent_plan_temp  ";
		query_maxRentList = query_maxRentList + " where  contract_id = '"+ contract_id + "' and  measure_id = '" + doc_id + "' )";
	}
	System.out.println("query_maxRentList==>"+query_maxRentList);
	rs = db.executeQuery(query_maxRentList);
	while (rs.next()) {
		max_rentList = getDBStr(rs.getString("rent_list"));
		corpus_overage_market = getDBStr(rs.getString("corpus_overage_market"));
	}
	if(max_rentList.equals("") || max_rentList == null){
		max_rentList = "1";
		String sqlstr = " select * from "+table_where; 
		System.out.println("sqlstr==>"+sqlstr);
		rs = db.executeQuery(sqlstr);
		while(rs.next()){//租赁本金 作为最初的剩余本金值
			corpus_overage_market = getDBStr(rs.getString("lease_money"));
		}
	}else{
		max_rentList = String.valueOf(Integer.parseInt(max_rentList) + 1);
	}
%>
<!-- 隐藏于传值 -->
<input type="hidden" name="nowDateTime" id="nowDateTime" value="<%=nowDateTime%>"/>
<input name="doc_id" type="hidden" value="<%=doc_id%>"/>
<input name="contract_id" type="hidden" value="<%=contract_id%>"/>
<input name="proj_id" type="hidden" value="<%=proj_id%>"/>
<input name="temp" type="hidden" value="<%=temp%>"/>
<input name="savetype" type="hidden" value="<%=savetype%>"/>
<input name="key_id" type="hidden" value="<%=key_id%>"/>
<input name="lease_money" id="lease_money" type="hidden" value="<%=corpus_overage_market%>"/>

			<div id=bgDiv>
				<table class="title_top" width=100% height=100% align=center
					cellspacing=0 border="0" cellpadding="0">
					<tr valign="top" class="tree_title_txt">
						<td class="tree_title_txt" height=26 valign="middle">
							租金信息 &gt; 不规则租金测算添加
						</td>
					</tr>
					<tr valign="top">
						<td align=center width=100% height=100%>
							<table align=center width=96% border="0" cellspacing="0"
								cellpadding="0" style="margin-top: 0px">
								<tr>
									<td>
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


													<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
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
												<td>
													编号
												</td>
												<!-- 有可能是项目编号  -->
												<td colspan="4">
													<%
														if (temp.equals("proj_zjcs")) {
													%>
													<input name="name_id" type="text" size="50" maxB="50"
														Require="ture" value="<%=proj_id%>" readonly>
													<%
														}
														if (temp.equals("contract_zjcs")) {
													%>
													<input name="name_id" type="text" size="50" maxB="50"
														Require="ture" value="<%=contract_id%>" readonly>
													<%
														}
													%>
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td> 期项 </td>
												<td>
													<input name="rent_list" id="rent_list" type="text" size="20"
														value="<%=max_rentList%>" maxB="20" Require="true"
														dataType="Integer" readonly="readonly"/>
												</td>
												<td> 偿还日期 </td>
												<td>
													<input name="plan_date" id="plan_date" type="text" size="15" 
														readonly value="<%=nowDateTime%>"  onchange="checkDate()"
														maxlength="10" dataType="Date" Require="ture"/>
													<img onClick="openCalendar(plan_date);return false"
														style="cursor: pointer;"
														src="../../images/tbtn_overtime.gif" width="20"
														height="19" border="0" align="absmiddle">
													<span class="biTian">*</span>
												</td>
												<td> 市场本金 </td>
												<td>
													<input name="corpus_market" id="corpus_market" type="text" size="20" maxB="20"
														Require="true" dataType="Money"  onchange="fzValue()"  value="0.00">
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td> 市场利息 </td>
												<td>
													<input name="interest_market" id="interest_market" type="text" size="20" maxB="20"
														Require="true" dataType="Double" onchange="fzValue()" value="0.00"/>
													<span class="biTian">*</span>
													
												</td>
												<td> 租金 </td>
												<td colspan="">
													<input name="rent" id="rent" type="text" size="20" maxB="20"  value="0.00"
														Require="true" dataType="Money" onchange="fzValue()" readonly="readonly"/>
												</td>
												<td> 市场本金余额 </td>
												<td colspan="">
													<input name="corpus_overage_market" id="corpus_overage_market"  type="text" size="20" maxB="20"
														Require="true" dataType="Money"  value="<%=corpus_overage_market%>" readonly="readonly"/>
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
