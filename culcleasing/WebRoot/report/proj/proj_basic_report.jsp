<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.OperationUtil"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.ConditionService"%>
<%@page import="com.tenwa.culc.bean.ConditionBean"%>
<%@page import="com.tenwa.culc.service1.ConditionService1"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style type="text/css">
	.maintab_content_table {
		 border-collapse:collapse;
		 padding:0px;
	}
	table th{
		white-space: nowrap;
		border:0px;
		text-align:center;
		font-weight:normal;
		padding:0px 10px 0px 10px;
		color:#154288;
		background-color:#D8E6F6;
		border-top: 1 solid #ffffff;
		border-bottom: 1 solid #ffffff;
		border-right: 1 solid #ffffff;
		height:25px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 项目基本信息</title>
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
	<script type="text/javascript" src="../../js/table.js"></script>
	<script Language="Javascript" src="../../js/jquery.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script src="../../js/validator.js"></script>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
	<script language="javascript" src="/dict/js/js_dictionary.js"></script>
	<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
	<script type="text/javascript" src="../../js/numberseparation.js"></script>
	<script src="../../js/delitem.js"></script>
	<script type="text/javascript">
		function waitSub() {
			var proj_id = document.getElementById("proj_id").value;
			var project_name = document.getElementById("project_name").value;
			var cust_name = document.getElementById("cust_name").value;
			if ((null == proj_id  || proj_id == "")
					&& (project_name == null || project_name == "")
					&& (cust_name == null || cust_name == "")) {
				alert("请填写项目编号");
				return false;//直接返回本身
				//window.location;
			} else {
				dataNav.submit();
			}
		}
</script>
		<%
			String wherestr = "";
			String contract_id = "";
			String project_name = getStr(request.getParameter("project_name"));
			String cust_name = getStr(request.getParameter("cust_name"));
			System.out.println("测试客户名称1111" + cust_name);
			String doc_id = "";
			String proj_id = getStr(request.getParameter("proj_id"));
			String cust_id = "";
			String status_name = "";
			String project_name2 = "";
			String leas_type = "";
			String leas_form = "";
			String cust_name2 = "";
			String parent_deptname = "";
			String proj_manage_name = "";
			String proj_assistant_name = "";
			String proj_ZKmanage_name = "";
			String proj_money = "";
			String proj_leas_money = "";
			double rate;
			String sql = "select contract_id from contract_info where proj_id='"
					+ proj_id + "'";
			ResultSet rs = null;
			rs = db.executeQuery(sql);
			if (rs.next()) {
				contract_id = getDBStr(rs.getString("contract_id"));
			} else {
				contract_id = "0";
			}
			if (contract_id != null && !contract_id.equals("")) {
				wherestr += " and vci.contract_id  ='" + contract_id;
			}
			if (project_name != null && !project_name.equals("")) {
				wherestr += " and vci.project_name  ='" + project_name;
			}
			if (cust_name != null && !cust_name.equals("")) {
				wherestr += " and vci.cust_name ='" + cust_name;
			}
		%>
		<%
			String col_str = "vci.proj_id,vci.cust_id,vci.contract_id,vci.status_name,vci.project_name,vci.leas_form,vci.leas_type,vci.cust_name,vci.parent_deptname,"
					+ "vci.proj_manage_name,vci.proj_assistant_name,bu.name,pinfo.proj_money,pinfo.proj_leas_money   ";
			String str2 = "left join proj_info pinfo on vci.proj_id = pinfo.proj_id left join base_user bu on pinfo.proj_qcmanage=bu.id";
			String sqlstr = "select  " + col_str
					+ " from vi_contract_info vci " + str2
					+ " where 1=1 " + wherestr + "'";
			rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				contract_id = getDBStr((rs.getString("contract_id")));
				proj_id = getDBStr(rs.getString("proj_id"));
				cust_id = getDBStr(rs.getString("cust_id"));
				status_name = getDBStr(rs.getString("status_name"));
				project_name2 = getDBStr(rs.getString("project_name"));
				leas_type = getDBStr(rs.getString("leas_type"));
				leas_form = getDBStr(rs.getString("leas_form"));
				cust_name2 = getDBStr(rs.getString("cust_name"));
				parent_deptname = getDBStr(rs.getString("parent_deptname"));
				proj_manage_name = getDBStr(rs.getString("proj_manage_name"));
				proj_assistant_name = getDBStr(rs.getString("proj_assistant_name"));
				proj_ZKmanage_name = getDBStr(rs.getString("name"));
				proj_money = getDBStr(rs.getString("proj_money"));
				proj_leas_money = getDBStr(rs.getString("proj_leas_money"));
			}
		%>
		<%
			//基础参数	
			//String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
			//获取参数
			String nowDateTime = getSystemDate(0);//当前格式化之后的时间
			//判断执行类型 -- 从数据库查询有数据则upd无则add
			String savaType = "upd";
			//1.如果upd则假装ConditionBean
			System.out.println("执行到这里了....");
			ConditionBean conditionBean = ConditionService.initFactConditionContractBean(contract_id);
			System.out.println("又执行到这里了....");
			//conditionBean = ConditionService1.initConditionContractBean(conditionBean);
		%>
<body>
	<form action="proj_basic_report.jsp" name="dataNav">
		<!--标题开始-->
		<table border="0" width="100%" cellspacing="0" cellpadding="0"
			height="30">
			<tr>
				<th width="100%">
					报表 &gt; 项目基本信息
				</th>
			</tr>
		</table>
		<div style="width: 100%;" id="queryArea">
			<fieldset
				style="width: 100%; TEXT-ALIGN: center; margin: 0px 5px 0px 5px;">
				<table border="0" width="100%" cellspacing="1" cellpadding="0">
					<tr>
						<td>
							项目编号:&nbsp;
							<input style="width: 150px;" name="proj_id" id="proj_id"
								type="text" value="<%=proj_id%>">
						</td>
						<td>
						
						 <!-- 	项目名称:&nbsp; -->
							<input style="width: 150px;" type="hidden" name="project_name"
								id="project_name" type="text" value="<%=project_name%>">
						</td>
	
						<td>
							<!-- 客户名称:&nbsp;&nbsp; -->
							<input style="width: 150px;" name="cust_name" type="hidden" id="cust_name"
								type="text" value="<%=cust_name%>">
						</td> 
						
						<td colspan="2" align="left">
							<input type="button" onclick="waitSub()" value="查询">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" onclick="clearQuery()" value="清空">
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		<script>
		   jQuery(function(){
		       jQuery("#mydiv").css("height",((document.body.clientHeight)-60)+"px");
		   });
		</script>		
			<style type="text/css">
			th {
	    		color: #6666FF;
	    	}
			.first {
	    		color: #6666FF;
	    	}
		</style>
		<div style="width:100%; height:100%; OVERFLOW:auto" id="mydiv">
			<div>
				<div id="tabletit" class="tabtitexp">
					&nbsp; 一:项目基本信息&nbsp;
					<img name="Changeicon" border="0" src="../../images/jt_b.gif"
						onclick="javascript:fieldsetHidden();" style="cursor: hand"
						title="显示/隐藏内容">
				</div>
				<div>
				<table border="0" style="border-collapse:collapse;" align="center" 
						cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">

					<tr>
						<td align="center" colspan="22">
							<h5 class="first">
								融资租赁合同台账
							</h5>
						</td>
					</tr>
					<tr>
						<td align="left" colspan="1" style="font-weight: bold;" class="first">
							项目编号:
						</td>
						<td colspan="6"><%=proj_id%></td>
						<td align="left" colspan="1" style="font-weight: bold;" class="first">
							项目名称：
						</td>
						<td colspan="12" align="left"><%=project_name2%></td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;" class="first">
							项目状态:
						</td>
						<td align="left"><%=status_name%></td>
						<td style="font-weight: bold;" class="first">
							租赁形式：
						</td>
						<td align="left"><%=leas_form%></td>
						<td align="left" style="font-weight: bold;" class="first">
							融资类型:
						</td>
						<td colspan="2" align="left"><%=leas_type%></td>
						<td align="left" style="font-weight: bold;" class="first">
							承租人:
						</td>
						<td colspan="4" align="left"><%=cust_name2%></td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;" class="first">
							出单部门:
						</td>
						<td align="left"><%=parent_deptname%></td>
						<td align="left" style="font-weight: bold;" class="first">
							项目经理:
						</td>
						<td align="left"><%=proj_manage_name%></td>
						<td align="left" style="font-weight: bold;" class="first">
							项目助理:
						</td>
						<td align="left" colspan="2"><%=proj_assistant_name%></td>
						<td align="left" style="font-weight: bold;" class="first">
							质控经理:
						</td>
						<td align="left"><%=proj_ZKmanage_name%></td>
						<td align="left" style="font-weight: bold;" class="first">
							商务经理:
						</td>
						<td align="left"><%=proj_manage_name%></td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;" class="first">
							项目金额:
						</td>
						<td align="left" colspan="8"><%=formatNumberStr(proj_money,"#,##0.00")%></td>
						<td align="left" style="font-weight: bold;" class="first">
							融资净额:
						</td>
						<td align="left" colspan="4"><%=formatNumberStr(proj_leas_money,"#,##0.00")%></td>
					</tr>

				</table>
			</div>
		</div>
			<div>
				<div class="tabtitexp">
					&nbsp; 二:租赁物件信息&nbsp;
					<img name="Changeicon" border="0" src="../../images/jt_b.gif"
					onclick="javascript:fieldsetHidden();" style="cursor: hand"
					title="显示/隐藏内容">
				</div>
				<div>
					<table border="0" style="border-collapse:collapse;" align="center" 
					cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
					<%
						if (leas_form.equals("直租")) {
					%>
					<tr>
						<th>
							设备名称
						</th>
						<th colspan="2">
							规格型号
						</th>
						<th colspan="2">
							生产商
						</th>

						<th colspan="2">
							供应商
						</th>
						<th colspan="2">
							单价
						</th>
						<th colspan="2">
							数量
						</th>
						<th colspan="2">
							总价
						</th>
						<th colspan="2">
							预计到货时间
						</th>
						<th colspan="2">
							实际到货时间
						</th>
						<th colspan="2">
							设备状态
						</th>
						<th colspan="2">
							投保状态
						</th>
					</tr>
					<%
						String ZRent = "select equip_name,equip_model ,equip_manufacturer ,provider ,equip_price ,"
									+ "equip_num ,total_price ,convert(varchar, plan_date, 23) plan_date,convert(varchar, fact_date, 23) fact_date,equip_status ,is_insur ,vci.leas_form  "
									+ "from vi_contract_equip_all_info  vceai left join vi_contract_info vci on vceai.contract_id = vci.contract_id " 
									+ "  where vci.leas_form = '直租' and vceai.contract_id ='"
									+ contract_id + "'";
							System.out.print("Zrent------------------======--------------------"+ ZRent);
							rs = db.executeQuery(ZRent);
							while (rs.next()) {
					%>
					<tr>
						<td align="center"><%=getDBStr(rs.getString("equip_name"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("equip_model"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("equip_manufacturer"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("provider"))%></td>
						<td align="center" colspan="2"><%=formatNumberStr(getDBStr(rs.getString("equip_price")),"#,##0.00")%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("equip_num"))%></td>
						<td align="center" colspan="2"><%=formatNumberStr(getDBStr(rs.getString("total_price")),"#,##0.00")%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("plan_date"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("fact_date"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("equip_status"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("is_insur"))%></td>
					</tr>
					<%
							}
						}
					%>
					<%
						if (leas_form.equals("回租")) {
					%>
					<tr>
						<th>
							设备名称
						</th>
						<th>
							规格型号
						</th>
						<th colspan="2">
							生产商
						</th>
						<th>
							价格
						</th>
						<th>
							数量
						</th>
						<th colspan="2">
							发票日期
						</th>
						<th>
							尚可使用月份
						</th>
						<th>
							规定用月份
						</th>
						<th>
							折现率
						</th>
						<th>
							公司折价
						</th>
						<th>
							折现价
						</th>
						<th>
							总价
						</th>
						<th colspan="2">
							预计到货时间
						</th>
						<th colspan="2">
							实际到货时间
						</th>
						<th>
							设备状态
						</th>
						<th>
							投保状态
						</th>
					</tr>
					<%
						String HRent = "select equip_name,equip_model ,equip_manufacturer ,equip_price ,"
									+ "equip_num,total_price,convert(varchar, invoice_date, 23) invoice_date,still_canuse_months,rule_all_usemonths,discount_rate,company_discount,"
									+ "now_discount,convert(varchar, plan_date, 23) plan_date ,convert(varchar, fact_date, 23) fact_date ,equip_status "
									+ ",is_insur ,vci.leas_form  from vi_contract_equip_all_info  vceai  left join vi_contract_info vci on vceai.contract_id = vci.contract_id"
									+ "   where vci.leas_form = '回租' and vceai.contract_id = '"
									+ contract_id + "'";
							System.out.print("HRent------------------======--------------------"+ HRent);
							rs = db.executeQuery(HRent);
							while (rs.next()) {
					%>
					<tr>
						<td align="center"><%=getDBStr(rs.getString("equip_name"))%></td>
						<td align="center"><%=getDBStr(rs.getString("equip_model"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("equip_manufacturer"))%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("equip_price")),"#,##0.00")%></td>
						<td align="center"><%=getDBStr(rs.getString("equip_num"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("invoice_date"))%></td>
						<td align="center"><%=getDBStr(rs.getString("still_canuse_months"))%></td>
						<td align="center"><%=getDBStr(rs.getString("rule_all_usemonths"))%></td>
						<td align="center"><%=getDBStr(rs.getString("discount_rate"))%></td>
						<td align="center"><%=getDBStr(rs.getString("company_discount"))%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("now_discount")),"#,##0.00")%></td>
						<td align="center"><%=formatNumberStr(getDBStr(rs.getString("total_price")),"#,##0.00")%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("plan_date"))%></td>
						<td align="center" colspan="2"><%=getDBStr(rs.getString("fact_date"))%></td>
						<td align="center"><%=getDBStr(rs.getString("equip_status"))%></td>
						<td align="center"><%=getDBStr(rs.getString("is_insur"))%></td>
					</tr>
					<%
							}
						}
					%>

				</table>
			</div>
		</div>
 <div>
	<div  class="tabtitexp">
		&nbsp; 三:交易结构信息&nbsp;
		<img name="Changeicon" border="0" src="../../images/jt_b.gif"
			onclick="javascript:fieldsetHidden();" style="cursor: hand"
			title="显示/隐藏内容">
	</div>
	<div>
		<table  border="0" style="border-collapse:collapse;" align="center" 
			cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
						
						<tr>
						<td colspan="8" align="left" class="first">
							租金计算方法:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<% 
								String  settle_method = conditionBean.getSettle_method();
								System.out.print("aaaaabbbbbb" + settle_method);
								if("RentCalcType1".equals(settle_method)){
									settle_method = "等额租金";
								}
								if("RentCalcType2".equals(settle_method)){
									settle_method = "等差租金";
								}
								if("RentCalcType3".equals(settle_method)){
									settle_method = "等比租金";
								}
								if("RentCalcType4".equals(settle_method)){
									settle_method = "等额本金";
								}
								if("RentCalcType5".equals(settle_method)){
									settle_method = "等差本金";
								}
								if("RentCalcType6".equals(settle_method)){
									settle_method = "等比本金";
								}
								if("RentCalcType7".equals(settle_method)){
									settle_method = "等额租金后付(均息法)";
								}
								if("RentCalcType8".equals(settle_method)){
									settle_method = "不等额租金";
								}
								if("RentCalcType9".equals(settle_method)){
									settle_method = "不等额本金";
								}
								if("RentCalcType10".equals(settle_method)){
									settle_method = "不规则";
								}
								%>
								<input  name="settle_method" disabled="disabled" value="<%=settle_method%>"/>
								<span class="biTian">*</span> &nbsp;&nbsp;|
								<div id="bj_1" style="float: left;"></div>
													<div id="bj_2"
														style="display: none; float: left; margin-left: 24px;">
														<input name="ratio_param" type="text"
															dataType="Double" value="0.00" size="13"
															maxlength="10" maxB="10" disabled="disabled">
													</div>
													<div id="bj_3"
														style="float: left; color: red; margin-left: 5px;"></div>
													&nbsp;&nbsp;| 付租类型：
													<input  name="period_type"
														value="<%=((conditionBean.getPeriod_type()=="1")?"期初":"期末")%>" disabled="disabled">
													<span class="biTian">*</span>
												</td>
											</tr>

											<tr>
												<!-- 隐藏字段结束 -->
												<td scope="row" nowrap class="first">
													合同编号
												</td>
												<td>
													<input name="contract_id" id="contract_id"
														type="text" value="<%=contract_id%>" size="35"
														maxlength="50" disabled="disabled"/>
													<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
													<span class="biTian">*</span>
												</td>

												<td scope="row" nowrap class="first">
													设备金额
												</td>
												<td>
													<input name="equip_amt" id="equip_amt" type="text"
														readonly value="<%=formatNumberStr(proj_money,"#,##0.00")%>"
														onchange="changeFirst_payment()"
														
														disabled="disabled" dataType="Money" size="13"
														maxlength="50" maxB="50" Require="true"
														readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap class="first">
													首付款
												</td>
												<td>
													<input name="first_payment" id="first_payment"
														type="text" disabled="disabled"
														onchange="changeFirst_payment()" dataType="Money"
														size="13" maxlength="50" maxB="50" Require="true"
														readonly="readonly"
														value="<%=formatNumberStr(conditionBean.getFirst_payment(),"#,##0.00") %>" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap class="first">
													货币类型
												</td>
												<td>
													<!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
													<%-- --%>
													<select style="width: 100px;" name="currencyVal"
														id="currency" Require="true" disabled="disabled">
														<option value="currency_type1">
															人民币
														</option>
													</select>
													<input name="currency" type="hidden"
														style="width: 100px;" value="currency_type1">
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<!--  租赁本金 = 设备金额 - 首付款 onclick="changeFirst_payment()"   -->
												<td scope="row" nowrap class="first">
													租赁本金
												</td>
												<td>
													<input name="lease_money" id="lease_money"
														value="<%=formatNumberStr(proj_money,"#,##0.00")%>" disabled="disabled"
														readonly="readonly" type="text" Require="true"
														dataType="Money" size="13" maxlength="100"
														maxB="100" Require="true" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													租赁保证金
												</td>
												<td>
													<input name="caution_money" id="caution_money"
														value="<%=formatNumberStr(conditionBean.getCaution_money(),"#,##0.00")%>"
														disabled="disabled" readonly="readonly"
														dataType="Money" size="13" maxlength="20" maxB="20"
														Require="true" onchange="assignment()" type="text"
														readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													租赁手续费
												</td>
												<td>
													<input name="handling_charge" id="handling_charge"
														type="text"
														value="<%=formatNumberStr(conditionBean.getHandling_charge(),"#,##0.00")%>"
														readonly="readonly" disabled="disabled"
														dataType="Money" size="13" maxlength="20" maxB="20"
														Require="true" onchange="assignment()"
														readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													管理费
												</td>
												<td colspan="">
													<input name="management_fee" id="management_fee"
														type="text"
														value="<%=formatNumberStr(conditionBean.getManagement_fee(),"#,##0.00")%>"
														disabled="disabled" readonly="readonly"
														dataType="Money" size="13" maxlength="20" maxB="20"
														Require="true" onchange="" readonly="readonly" />
													<span class="biTian">*</span>
												</td>
											</tr>

											<tr>
												<td scope="row" nowrap  class="first">
													咨询费收入
												</td>
												<td>
													<input name="consulting_fee_in"
														id="consulting_fee_in" type="text"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require="true"
														readonly="readonly"
														value="<%=formatNumberStr(conditionBean.getConsulting_fee_in(),"#,##0.00")%>" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													咨询费支出
												</td>
												<td>
													<input name="consulting_fee_out"
														id="consulting_fee_out" type="text"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require="true"
														onchange="assignment()" readonly="readonly"
														value="<%=formatNumberStr(conditionBean.getConsulting_fee_out(),"#,##0.00")%>" />
													<span class="biTian">*</span>
												</td>

												<td scope="row" nowrap  class="first">
													其他收入
												</td>
												<td colspan="">
													<input name="other_expenditure"
														id="other_expenditure" type="text"
														value="<%=formatNumberStr(conditionBean.getOther_income(),"#,##0.00")%>"
														dataType="Money" disabled="disabled"
														disabled="disabled" size="13" maxlength="20"
														onchange="assignment()" readonly="readonly" />
												</td>
												<td scope="row" nowrap  class="first"> 
													其他支出
												</td>
												<td colspan="">
													<input name="other_expenditure"
														id="other_expenditure" type="text"
														value="<%=formatNumberStr(conditionBean.getOther_expenditure(),"#,##0.00")%>"
														dataType="Money" disabled="disabled"
														disabled="disabled" size="13" maxlength="20"
														onchange="assignment()" readonly="readonly" />
												</td>
											</tr>

											<tr>
												<td scope="row" nowrap  class="first">
													残值收入
												</td>
												<td>
													<input name="nominalprice" id="nominalprice"
														type="text"
														value="<%=formatNumberStr(conditionBean.getNominalprice(),"#,##0.00")%>"
														onchange="assignment()" disabled="disabled"
														dataType="Money" size="13" maxlength="20" maxB="20"
														Require="true" readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													厂商返利
												</td>
												<td>
													<input name="return_amt" id="return_amt" type="text"
														value="<%=formatNumberStr(conditionBean.getReturn_amt(),"#,##0.00")%>"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require="true"
														onchange="assignment()" readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap class="first">
													保费金额
												</td>
												<td colspan="">
													<input name="insure_money" id="insure_money"
														type="text"
														value="<%=formatNumberStr(conditionBean.getInsure_money(),"#,##0.00")%>"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require="true"
														onchange="assignment()" readonly="readonly" />
												</td>
												<td scope="row" nowrap  class="first">
													预计IRR
												</td>
												<td>
													<input name="plan_irr" disabled="disabled"
														id="plan_irr" type="text"
														value="<%=conditionBean.getPlan_irr()%>" size="13"
														maxlength="10" readonly="readonly" />
													%
												</td>
											</tr>

											<tr>
												<td scope="row" nowrap  class="first">
													租前息
												</td>
												<td>
													<input name="before_interest" id="before_interest"
														type="text"
														value="<%=conditionBean.getBefore_interest()%>"
														onchange="changeTwoData()" disabled="disabled"
														dataType="Money" size="13" maxlength="20" maxB="20"
														Require="true" readonly="readonly" />
													是否算本
													<input type="text" name="before_interest_type"
															readonly="readonly" disabled="disabled"
															value="<%=conditionBean.getBefore_interest_type()%>">
														<span class="biTian">*</span>
													</td>
													
																																
														
													
												<td scope="row" nowrap  class="first">
													利息补贴
												</td>
												<td>
													<input name="rate_subsidy" id="rate_subsidy"
														type="text"
														value="<%=formatNumberStr(conditionBean.getRate_subsidy(),"#,##0.00")%>"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require=""
														onchange="assignment()" readonly="readonly" />
													<span class="biTian"></span>
												</td>
												<td scope="row" nowrap  class="first">
													贴现息
												</td>
												<td>
													<input name="discount_rate" id="discount_rate"
														type="text"
														value="<%=formatNumberStr(conditionBean.getDiscount_rate(),"#,##0.00")%>"
														disabled="disabled" dataType="Money" size="13"
														maxlength="20" maxB="20" Require=""
														onchange="assignment()" readonly="readonly" />
													<span class="biTian"></span>
												</td>
												<td scope="row" nowrap  class="first">
													资产余值
												</td>
												<td>
													<input name="assets_value" id="assets_value"
														type="text" disabled="disabled"
														value="<%=formatNumberStr(conditionBean.getAssets_value(),"#,##0.00")%>"
														dataType="Money" size="13" maxlength="20" maxB="20"
														readonly="readonly" />
												</td>
											</tr>

											<tr>
												<td scope="row" nowrap  class="first">
													净融资额
												</td>
												<td>
													<!--  净融资额=设备款-保证金-手续费-厂商返佣-其他收入+咨询费+其他支出 【2010-07-23修改，增加需要 减去租前息】 -->
													<input name="actual_fund" id="actual_fund"
														type="text" readonly on onClick="assignment()"
														dataType="Money" size="13" maxlength="20" maxB="20"
														value="<%=formatNumberStr(conditionBean.getActual_fund(),"#,##0.00")%>" disabled="disabled"/>
														净融资额比例
														<input name="actual_fund_ratio"
														id="actual_fund_ratio" type="text" size="5"
														disabled="disabled" maxlength="10"
														 onclick="getlmp_value()"
														Require="true"
														value="<%=conditionBean.getActual_fund_ratio()%>" />%
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													付租方式
												</td>
												<%
													String fzfs=conditionBean.getIncome_number_year();
													if("1".equals(fzfs)){
														fzfs = "月付";
													}
													if("2".equals(fzfs)){
														fzfs="双月付";
													}
													
													if("3".equals(fzfs)){
														fzfs="季付";
													}
													if("6".equals(fzfs)){
														fzfs="半年付";
													}
													if("12".equals(fzfs)){
														fzfs="年付";
													}
												%>
												<td>
													<input tpye="text" name="income_number_year"
														style="width: 100px;"
														value="<%=fzfs%>"
														disabled="disabled"/>
													<span class="biTian">*</span>
												</td>
												<!-- 还租次数=租赁期限/年还租次数 -->
												<td scope="row" nowrap  class="first">
													还租次数
												</td>
												<td>
													<input name="income_number" id="income_number"
														disabled="disabled" type="text"
														value="<%=conditionBean.getIncome_number()%>"
														onChange="changLeaseT_value()" dataType="Integer"
														size="13" maxlength="10" maxB="10" Require="true"
														readonly="readonly" />
													<span class="biTian">*</span>
												</td>
												<!-- 根据付租方式判断 -->
												<td scope="row" nowrap  class="first">
													租赁期限(月)
												</td>
												<td>
													<input name="lease_term" id="lease_term" type="text"
														value="<%=conditionBean.getLease_term()%>"
														onClick="changLeaseT_value()" dataType="Integer"
														size="13" maxlength="10" maxB="10" Require="true"
														disabled="disabled" />
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td scope="row" nowrap  class="first">
													租赁年利率
												</td>
												<td nowrap="nowrap">
													<input name="year_rate" id="year_rate" type="text"
														value="<%=conditionBean.getYear_rate()%>"
														disabled="disabled" dataType="Double" size="13"
														maxlength="13" maxB="13" Require="true"
														readonly="readonly" />
													%
													<span class="biTian">*</span>
												</td>

											</tr>
											<tr>
												<td colspan="20" >
													<hr style="filter: alpha(opacity =   0, finishopacity =   100, style =   2); height: 12px," color=grey>
												</td>
											</tr>
											<tr>
												<td scope="row" nowrap  class="first">
													调息方式
												</td>
												<td>
													<input type="text" name="adjust_style"
														disabled="disabled" id="adjust_style"
														value="<%=("2".equals(conditionBean.getAdjust_style()) ? "按次期" : "按次日")%>" />											批量调息
													<input type="text" name="into_batch"
														disabled="disabled"
														value="<%=conditionBean.getInto_batch()%>">

													<span class="biTian">*</span>
												</td>
													
												<td scope="row" nowrap  class="first">
													预计起租日
												</td>
												<td>
													<input name="start_date" id="start_date" type="text"
														size="13" maxlength="20" Require="true"
														value="<%=getDBDateStr(conditionBean.getRent_start_date())%>"
														readonly="readonly" label="预计起租日"
														disabled="disabled" />

													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													罚息日利率
												</td>
												<td colspan=""  class="first">
													<input name="pena_rate" disabled="disabled"
														id="pena_rate" type="text"
														value="<%=conditionBean.getPena_rate()%>" size="13"
														maxlength="20" dataType="Double" size="13"
														maxlength="10" maxB="10" Require="true"
														label="罚息日利率" />
													%%
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													逾期宽限日
												</td>
												<td>
													<input name="free_defa_inter_day"
														id="free_defa_inter_day" disabled="disabled"
														type="text"
														value="<%=conditionBean.getFree_defa_inter_day()%>"
														dataType="Integer" size="13" maxlength="10"
														maxB="10" Require="true" label="逾期宽限日" />
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td scope="row" nowrap  class="first">
													利率浮动类型
												</td>
												<td>
													<%
														String rate_float_type = conditionBean.getRate_float_type();
														if ("0".equals(rate_float_type)) {
															rate_float_type = "按央行利率浮动比率";
														}
														if ("1".equals(rate_float_type)) {
															rate_float_type = "按央行利率加点";
														}
														if ("2".equals(rate_float_type)) {
															rate_float_type = "隐含利率";
														}
														if ("3".equals(rate_float_type)) {
															rate_float_type = "保持不变";
														}
													%>
													<input name="rate_float_type"
														value="<%=rate_float_type%> " disabled="disabled"/>
													<span class="biTian">*</span>
												</td>
												<td colspan="4">
													<div id="div_rate"></div>
												</td>
												<td scope="row" nowrap  class="first">
													利率调整值
												</td>
												<td>
													<input name="rate_float_amt" id="rate_float_amt"
														type="text"
														value="<%=conditionBean.getRate_float_amt()%>"
														onblur="alertChange()" dataType="Double" size="13"
														maxlength="13" maxB="13" Require="true"
														label="利率调整值" disabled="disabled"/>
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<td scope="row" nowrap  class="first">
													达标IRR
												</td>
												<td>
													<input type="text" disabled="disabled"
														dataType="Double" style="width: 140"
														name="StandardIrr"
														value="<%=conditionBean.getStandardIrr()%>"
														label="达标IRR" />
													% 
													是否达标
													<input type="text" name="StandardF"
														value="<%=conditionBean.getStandardF()%>"
														disabled="disabled" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													实际IRR
												</td>
												<td>
													<input name="irr" id="irr" disabled="disabled"
														type="text" value="<%=conditionBean.getIrr()%>"
														size="13" maxlength="10" label="实际IRR" />
													%
												</td>
												<td scope="row" nowrap  class="first">
													每月偿付日
												</td>
												<td>
													<input type="text" disabled="disabled"
														name="income_day" id="income_day"
														value="<%=conditionBean.getIncome_day()%>" />

													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													税种
												</td>
												<td>
													<input type="text" disabled="disabled"
														value="<%=(null==conditionBean.getTax_type())?"无":conditionBean.getTax_type()%>" />
													<span class="biTian">*</span>
												</td>
											</tr>

											<tr>
												<td scope="row" nowrap  class="first">
													租金开票方式
												</td>
												<%
													String invoice_type = conditionBean.getInvoice_type();
													if ("root.RentInvoice.001".equals(invoice_type)) {
														invoice_type = "先开，租金总额发票";
													}

													if ("root.RentInvoice.002".equals(invoice_type)) {
														invoice_type = "先开，本金收据，利息发票";
													}
													if ("root.RentInvoice.003".equals(invoice_type)) {
														invoice_type = "先开，本利分开";
													}
													if ("root.RentInvoice.004".equals(invoice_type)) {
														invoice_type = "后开，租金总额发票";
													}
													if ("root.RentInvoice.005".equals(invoice_type)) {
														invoice_type = "后开，本金收据，利息发票";
													}
													if ("root.RentInvoice.006".equals(invoice_type)) {
														invoice_type = "后开，本利分开两张发票";
													}
													if ("root.RentInvoice.007".equals(invoice_type)) {
														invoice_type = "先开，本利分开两张发票";
													}
													if ("root.RentInvoice.008".equals(invoice_type)) {
														invoice_type = "其它";
													}
												%>
												<td>
													<input name="invoice_type" disabled="disabled"
														value="<%=invoice_type%>" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													投保方式
												</td>
												<td>
													<%
														String insure_type = conditionBean.getInsure_type();
														if ("insure_type1".equals(insure_type)) {
															insure_type = "本司付款";
														}
														if ("insure_type2".equals(insure_type)) {
															insure_type = "本司代付";
														}
														if ("insure_type3".equals(insure_type)) {
															insure_type = "客户自保";
														}
														if ("insure_type4".equals(insure_type)) {
															insure_type = "客户代付";
														}
														if ("insure_type6".equals(insure_type)) {
															insure_type = "管理方投保";
														}
														if ("insure_type5".equals(insure_type)) {
															insure_type = "不投保";
														}
													%>
													<input name="insure_type" disabled="disabled"
														value="<%=insure_type%>" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													保险收取方式
												</td>
												<%
													String insure_pay_type = conditionBean.getInsure_pay_type();
													if ("root.insurPayType.001".equals(insure_pay_type)) {
														insure_pay_type = "1次性收完";
													}
													if ("root.insurPayType.002".equals(insure_pay_type)) {
														insure_pay_type = "分年";
													}
													if ("root.insurPayType.003".equals(insure_pay_type)) {
														insure_pay_type = "分季";
													}
													if ("root.insurPayType.004".equals(insure_pay_type)) {
														insure_pay_type = "无";
													}
													if(null==insure_pay_type){
														insure_pay_type = "无";
													}
												%>
												<td>
													<input name="insure_pay_type" disabled="disabled"
														value="<%=insure_pay_type%>" />
													<span class="biTian">*</span>
												</td>
												<td scope="row" nowrap  class="first">
													增值税发票类型
												</td>
												<td>
													<input name="tax_type_invoice" disabled="disabled"
														value="<%=(null==conditionBean.getTax_type_invoice())?"无":"conditionBean.getTax_type_invoice()"%>" />
													<span class="biTian">*</span>
												</td>
											</tr>
											<tr>
												<!-- sys考核调整隐藏域 -->
												<input type="hidden" name="assess_adjust" value="0"
													disabled="disabled" dataType="Money" size="13"
													maxlength="10" maxB="10"
													onchange="changeFirst_payment()" />
											</tr>
					</table>						
				</div>
			</div>
								<div>
									<div  class="tabtitexp">
										&nbsp; 四:资金收付信息&nbsp;
										<img name="Changeicon" border="0" src="../../images/jt_b.gif"
											onclick="javascript:fieldsetHidden();" style="cursor: hand"
											title="显示/隐藏内容">
									</div>
									<div>
										<table border="0"  class="maintab_content_table">
									<tr id="tabletit">
												<td colspan="18">
													&nbsp; 资金收付信息&nbsp;
												</td>
											</tr>
											<tr>
												<th>
													合同编号
												</th>
												<th>
													款项方式
												</th>
												<th>
													款项内容
												</th>
												<th>
													序号
												</th>
												<th>
													款项名称
												</th>
												<th>
													收/付款人
												</th>
												<th>
													收/付款人开户银行
												</th>
												<th>
													收/付款人银行账号
												</th>
												<th>
													收/支时间
												</th>
												<th>
													收/付款金额
												</th>
												<th>
													计划收/付开户银行
												</th>
												<th>
													计划收/付银行账号
												</th>
												<th>
													结算方式
												</th>
												<th>
													状态
												</th>
												<th>
													票据类型
												</th>
											</tr>
											<%
											System.out.println("10000000000000s" + sqlstr);
												col_str = " vcffcp.contract_id,vcffcp.pay_way,vcffcp.fee_type_name,vcffcp.fee_num, vcffcp.fee_name, vcffcp.pay_obj_name, vcffcp.pay_bank_name,vcffcp.pay_bank_no, vcffcp.plan_date,"+
												" vcffcp.currency_name, vcffcp.plan_money,vcffcp.plan_bank_name,vcffcp.plan_bank_no,vcffcp.pay_type_name,vcffcp.plan_status,tax_type_invoice,vcffcp.fpnote ";
												sqlstr = "select "
														+ col_str
														+ " from vi_contract_fund_fund_charge_plan vcffcp  left join contract_fund_fund_charge_plan cffcp on vcffcp.payment_id= cffcp.payment_id "
														+"where vcffcp.contract_id='"
														+ contract_id + "' order by vcffcp.id";
												System.out.println("11111111111111" + sqlstr);
												rs = db.executeQuery(sqlstr);
												while (rs.next()) {
													
											%>
											<tr>
												<td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
												<td align="center"><%=getDBStr(rs.getString("pay_way"))%></td>
												<td align="center"><%=getDBStr(rs.getString("fee_type_name"))%></td>
												<td align="center"><%=getDBStr(rs.getString("fee_num"))%></td>
												<td align="center"><%=getDBStr(rs.getString("fee_name"))%></td>
												<td align="center" ><%=getDBStr(rs.getString("pay_obj_name"))%></td>
												<td align="center" ><%=getDBStr(rs.getString("pay_bank_name"))%></td>
												<td align="center" ><%=getDBStr(rs.getString("pay_bank_no"))%></td>
												<td align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
												<td align="center"><%=CurrencyUtil.convertFinance(rs
						.getString("plan_money"))%></td>
												<td align="center"><%=getDBStr(rs.getString("plan_bank_name"))%></td>
												<td align="center"><%=getDBStr(rs.getString("plan_bank_no"))%></td>
												<td align="center"><%=getDBStr(rs.getString("pay_type_name"))%></td>
												<td align="center"><%=getDBStr(rs.getString("plan_status"))%></td>
												<td align="center"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
											</tr>
											<%
												}
												rs.close();
											%>


											<tr id="tabletit">
												<td colspan="16">
													&nbsp; 资金付款前提&nbsp;
												</td>
											</tr>


											<tr>
												<th colspan="2">
													款项内容
												</th>
												<th colspan="2">
													序号 
												</th>
												<th colspan="2">
													款项名称
												</th>
												<th colspan="2">
													收支时间
												</th>
												<th colspan="2">
													币种
												</th>
												<th colspan="2">
													付款金额
												</th>
												<th colspan="4">
													付款前提
												</th>
											</tr>
											<%
												String col_str_2 = " payment_id,contract_id,pay_type_name,fee_type_name,fee_name,fee_num,plan_date,plan_money,";
												col_str_2 += "currency_name,pay_obj,pay_obj_name,pay_way,fpnote";

												sqlstr = "select "
														+ col_str_2
														+ " from vi_contract_fund_fund_charge_plan where pay_way='付款' and contract_id='"
														+ contract_id + "' order by id";
												System.out.println("fukuanqiantiSQL=="+sqlstr);
												rs = db.executeQuery(sqlstr);
												while (rs.next()) {
											%>
											<tr>
												<td colspan="2" align="center"><%=getDBStr(rs.getString("fee_type_name"))%></td>
												<td colspan="2" align="center"><%=getDBStr(rs.getString("fee_num"))%></td>
												<td colspan="2" align="center"><%=getDBStr(rs.getString("fee_name"))%></td>
												<td colspan="2" align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
												<td colspan="2" align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
												<td colspan="2" align="center"><%=CurrencyUtil.convertFinance(rs.getString("plan_money"))%></td>
												<td colspan="4" align="center">
													<%
														String partSql = "select (select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')";
															partSql += " as title,status from contract_fund_fund_charge_condition pffcct where  payment_id='"
																	+ rs.getString("payment_id") + "' ";
															System.out.println("partSqlSQL=="+partSql);
															ResultSet rs1 = db1.executeQuery(partSql);
															if (rs1.next()) {
																rs1.beforeFirst();
													%>
													<table>
														<tr>
															<th colspan="3" align="center">
																付款条件
															</th>
															<th colspan="2" align="center">
																状态
															</th>
														</tr>
														<%
															while (rs1.next()) {
														%>
														<tr>
															<td colspan="3" align="center"><%=getDBStr(rs1.getString("title"))%></td>
															<td colspan="2" align="center"><%=getDBStr(rs1.getString("status"))%></td>
														</tr>
														<%
															}
														%>
													</table>
													<%
														} else {
													%>
													无付款前提
													<%
														}
													%>

												</td>
											</tr>
											<%
												}
												rs.close();
												
											%>

										</table>
									</div>
								</div>


								<div>
									<div  class="tabtitexp">
										&nbsp; 五:起租信息&nbsp;
										<img name="Changeicon" border="0" src="../../images/jt_b.gif"
											onclick="javascript:fieldsetHidden();" style="cursor: hand"
											title="显示/隐藏内容">
									</div>
									<div>
									<table  width="100%" class="maintab_content_table">

										<tr>
											<td colspan="22" align="left"  class="first" style="font-size: 15;">
												本次起租租金偿还情况
											</td>
										</tr>
										
										<%
										
											String begin_str = "select bi.begin_id,isnull(a.sum_rent,0) dq_rent,isnull(a.sum_corpus,0) dq_corpus,isnull(a.sum_interest,0) dq_interest,"
													+ "isnull(b.sum_rent,0) ss_rent,isnull(b.sum_corpus,0) ss_corpus,isnull(b.sum_interest,0) ss_interest,"
													+ "c.sum_rent whs_rent,c.sum_corpus whs_corpus,c.sum_interest whs_interest,d.sum_penalty ,d.sum_penalty_day_amount "
													+ "from begin_info  bi left join (select begin_id, sum(rent)"
													+ "as sum_rent,sum(corpus) sum_corpus,sum(interest) sum_interest "
													+ "from fund_rent_plan where plan_date<=getdate() "
													+ "group by begin_id) a on bi.begin_id =a.begin_id "
													+ "left join  (select begin_id, sum(rent) as sum_rent,sum(corpus) sum_corpus,"
													+ "sum(interest) sum_interest from fund_rent_income where hire_date<=getdate() "
													+ "group by begin_id) b on bi.begin_id = b.begin_id "
													+ "left join (select begin_id,sum(rent) sum_rent,sum(corpus) sum_corpus,sum(interest) sum_interest "
													+ "from fund_rent_plan where plan_status='未回笼' group by begin_id)c on bi.begin_id = c.begin_id "
													+ "left join (select begin_id,sum(penalty) sum_penalty,sum(penalty_day_amount) sum_penalty_day_amount from fund_penalty_plan fpp group by begin_id) d on d.begin_id= bi.begin_id "
													+ "where bi.contract_id='" + contract_id + "'";
											ResultSet rs2 = null;
											rs = db.executeQuery(begin_str);
											while (rs.next()) {
												String bid = getDBStr(rs.getString("begin_id"));
										%>
										
										<tr>
											<td colspan="2"  class="first">
												项目编号:
											</td>
											<td colspan="4">
												<%=proj_id%>
											</td>
											<td colspan=""  class="first">
												合同编号:
											</td>
											<td colspan="5">
												<%=contract_id%>
											</td>
											<td colspan="5"  class="first">
												起租编号:
											</td>
											<td colspan="4">
												<%=bid%>
											</td>
										</tr>

										<tr>
											<th>
												期次
											</th>
											<th>
												本期利率
											</th>
											<th>
												计划租金日
											</th>
											<th>
												租金
											</th>
											<th>
												本金
											</th>
											<th>
												利息
											</th>
											<th>
												实际租金日
											</th>
											<th>
												实际租金
											</th>
											<th>
												租金状态
											</th>
											<th>
												欠收租金
											</th>
											<th>
												欠本金
											</th>
											<th>
												欠收利息
											</th>
											<th colspan="2">
												逾期天数
											</th>
											<th colspan="2">
												罚息
											</th>
											<th colspan="2">
												罚息状态
											</th>
											<th colspan="2">
												收罚息日期
											</th>
										</tr>
										<%
											String beginSql = "select frp.rent_list,year_rate,convert(varchar, frp.plan_date, 23) plan_date,"
														+ "frp.rent frp_rent,frp.corpus ,frp.interest,convert(varchar,hire_date, 23) hire_date,"
														+ "fri.rent fri_rent,frp.plan_status rent_plan_status,curr_rent,curr_corpus,curr_interest,"
														+ "fpp.plan_status penalty_plan_status,penalty_day_amount,fpp.penalty ,convert(varchar, fpp.plan_date, 23)  penalty_plan_date "
														+ "from fund_rent_plan frp left join fund_rent_income fri on frp.begin_id = fri.begin_id and frp.rent_list=fri.plan_list "
														+ "left join fund_penalty_plan fpp on fpp.begin_id = frp.begin_id and fpp.rent_list = frp.rent_list "
														+ "where frp.begin_id='"
														+ bid
														+ "' order by frp.rent_list";


												rs2 = db2.executeQuery(beginSql);
												while (rs2.next()) {
										%>
										<tr>
											<td align="center"><%=getDBStr(rs2.getString("rent_list"))%></td>
											<td align="center"><%=getDBStr(rs2.getString("year_rate"))%></td>
											<td align="center"><%=getDBStr(rs2.getString("plan_date"))%></td>
											<td align="center"><%=formatNumberStr(getDBStr(rs2.getString("frp_rent")),"#,##0.00")%></td>
											<td align="center"><%=formatNumberStr(getDBStr(rs2.getString("corpus")),"#,##0.00")%></td>
											<td align="center"><%=formatNumberStr(getDBStr(rs2.getString("interest")),"#,##0.00")%></td>
											<td align="center"><%=getDBStr(rs2.getString("hire_date"))%></td>
											<td align="center"><%=formatNumberStr(getDBStr(rs2.getString("fri_rent")),"#,##0.00")%></td>
											<td align="center"><%=getDBStr(rs2.getString("rent_plan_status"))%></td>
											<td align="center"><%=getDBStr(rs2.getString("curr_rent"))%></td>
											<td align="center"><%=getDBStr(rs2.getString("curr_corpus"))%></td>
											<td align="center"><%=getDBStr(rs2.getString("curr_interest"))%></td>
											<td  colspan="2" align="center"><%=getDBStr(rs2.getString("penalty_day_amount"))%></td>
											<td  colspan="2" align="center"><%=formatNumberStr(getDBStr(rs2.getString("penalty")),"#,##0.00")%></td>
											<td colspan="2" align="center"><%=getDBStr(rs2.getString("penalty_plan_status"))%></td>
											<td colspan="2" align="center"><%=getDBStr(rs2.getString("penalty_plan_date"))%></td>
										</tr>

										<%
											}
												double qs_rent1 = Double.parseDouble(getDBStr(rs
														.getString("dq_rent")))
														- Double.parseDouble(getDBStr(rs.getString("ss_rent")));
												
												String qs_rent = Double.toString(qs_rent1);
												qs_rent = formatNumberStr(qs_rent,"#,##0.00");
												
												double qs_coupus1 = Double.parseDouble(getDBStr(rs
														.getString("dq_corpus")))
														- Double
																.parseDouble(getDBStr(rs.getString("ss_corpus")));
												
												String qs_coupus = Double.toString(qs_coupus1);
												qs_coupus = formatNumberStr(qs_coupus,"#,##0.00");
												
												
												double qs_interest1 = Double.parseDouble(getDBStr(rs
														.getString("dq_interest")))
														- Double.parseDouble(getDBStr(rs
																.getString("ss_interest")));
												
												String qs_interest = Double.toString(qs_interest1);
												qs_interest = formatNumberStr(qs_interest,"#,##0.00");
										%>
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收租金:</td>
											<td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">实收租金:</td>
											<td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收租金:</td>
											<td colspan="2"><%=qs_rent%></td>
											<td colspan="1" align="left"  class="first">预期天数:</td>
											<td colspan="6"><%=getDBStr(rs.getString("sum_penalty_day_amount"))%></td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收本金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_corpus")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">实收本金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_corpus")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收本金:</td><td colspan="2"><%=qs_coupus%></td>
											<td colspan="1" align="left"  class="first">罚息总额:</td><td colspan="6"><%=formatNumberStr(getDBStr(rs.getString("sum_penalty")),"#,##0.00")%></td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收利息:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_interest")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">实收利息:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_interest")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收利息:</td><td colspan="4"><%=qs_interest%></td><td colspan="5"></td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">未回收租金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("whs_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">未回收本金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("whs_corpus")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">未回收利息:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("whs_interest")),"#,##0.00")%></td><td colspan="5"></td>
										</tr>
										
										<%
											}

											String czrSql = "select  "
													+ "isnull(a.dq_sum_rent,0) dq_sum_rent,isnull(a.dq_sum_corpus,0) dq_sum_corpus,isnull(a.dq_sum_interest,0) dq_sum_interest, isnull(ss_sum_rent,0) ss_sum_rent,isnull(ss_sum_corpus,0) ss_sum_corpus, isnull(ss_sum_interest,0) ss_sum_interest,"
													+ "isnull(sum(penalty_day_amount),0) sum_penalty_day_amount,isnull(sum(fpp.penalty),0) sum_penalty,isnull(whs_rent,0)whs_rent,isnull(whs_corpus,0)whs_corpus, whs_interest  "
													+ "from vi_contract_info vci "
													+ "left join  fund_penalty_plan fpp on fpp.contract_id = vci.contract_id  "
													+ "left join  (select cust_id,isnull(sum(rent),0) dq_sum_rent,isnull(sum(corpus),0) dq_sum_corpus, isnull(sum(interest),0) dq_sum_interest from fund_rent_plan frp left join contract_info ci "
													+ "on frp.contract_id=ci.contract_id where  plan_date<=getdate() group by cust_id) a  on vci.cust_id=a.cust_id  "
													+ "left join  (select cust_id,isnull(sum(rent),0) ss_sum_rent,isnull(sum(corpus),0) ss_sum_corpus,isnull(sum(interest),0) ss_sum_interest from fund_rent_income fri left join contract_info ci  "
													+ "on fri.contract_id= ci.contract_id where hire_date<=getdate() group by cust_id) b on vci.cust_id = b.cust_id "
													+ "left join (select cust_id,isnull(sum(rent),0) whs_rent,isnull(sum(corpus),0)whs_corpus,isnull(sum(interest),0) whs_interest from fund_rent_plan frp left join contract_info ci on frp.contract_id=ci.contract_id where  plan_status='未回笼' group by cust_id) w on vci.cust_id = w.cust_id "
													+ "where vci.cust_id='"
													+ cust_id
													+ "' group by vci.cust_id,a.dq_sum_rent,a.dq_sum_corpus,a.dq_sum_interest,ss_sum_rent,ss_sum_corpus,ss_sum_interest,whs_rent,whs_corpus, whs_interest ";

											rs = db.executeQuery(czrSql);
											while (rs.next()) {
												
												
												double qs_rent3 = Double.parseDouble(getDBStr(rs
														.getString("dq_sum_rent")))
														- Double.parseDouble(getDBStr(rs
																.getString("ss_sum_rent")));
												
												String qs_rent2 = Double.toString(qs_rent3);
												qs_rent2 = formatNumberStr(qs_rent2,"#,##0.00");
												
												
												double qs_coupus3 = Double.parseDouble(getDBStr(rs
														.getString("dq_sum_corpus")))
														- Double.parseDouble(getDBStr(rs
																.getString("ss_sum_corpus")));
												
												String qs_coupus2 = Double.toString(qs_coupus3);
												qs_coupus2 = formatNumberStr(qs_coupus2,"#,##0.00");
												
												
												double qs_interest3 = Double.parseDouble(getDBStr(rs
														.getString("dq_sum_interest")))
														- Double.parseDouble(getDBStr(rs
																.getString("ss_sum_interest")));
												
												String qs_interest2 = Double.toString(qs_interest3);
												qs_interest2 = formatNumberStr(qs_interest2,"#,##0.00");
												
												if ((Double.parseDouble(getDBStr(rs.getString("ss_sum_rent"))) + Double
														.parseDouble(getDBStr(rs.getString("whs_rent")))) != 0) {
													rate = Double.parseDouble(getDBStr(rs
															.getString("ss_sum_rent")))
															/ (Double.parseDouble(getDBStr(rs
																	.getString("ss_sum_rent"))) + Double
																	.parseDouble(getDBStr(rs
																			.getString("whs_rent"))));
													
												} else {
													rate = 0d;
												}
										%>
											</table>
									</div>
								</div>
								
								<div>
									<div id="tabletit" class="tabtitexp">
										&nbsp; 六:承租人租金偿还情况&nbsp;
										<img name="Changeicon" border="0" src="../../images/jt_b.gif"
											onclick="javascript:fieldsetHidden();" style="cursor: hand"
											title="显示/隐藏内容">
									</div>
									<div>
										<table border="0" style="border-collapse:collapse;" align="center" 
											cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
										<tr>
											<td colspan="20" align="left"  class="first" style="font-size: 15;">
												
											</td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">承租人：</td><td colspan="9"><%=cust_name2%></td>
											<td colspan="1" align="left"  class="first">承租人编号：</td><td colspan="9"><%=cust_id%></td>
										</tr> 
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收租金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_sum_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">实收租金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_sum_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收租金:</td><td colspan="4"><%=qs_rent2.equals("-0.00")?"0.00":qs_rent2%></td>
											<td colspan="1" align="left"  class="first">逾期天数:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("sum_penalty_day_amount")),"#,##0.00")%></td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收本金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_sum_corpus")),"#,##0.00")%></td>
											<td colspan="1"align="left"  class="first">实收本金:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_sum_corpus")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收本金:</td><td colspan="4"><%=(qs_coupus2).equals("-0.00")?"0.00":qs_coupus2%></td>
											<td colspan="1" align="left"  class="first">罚息总额:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("sum_penalty")),"#,##0.00")%></td>
										</tr>
										<tr>
											<td colspan="20">
												&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">已到期应收利息:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("dq_sum_interest")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">实收利息:</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("ss_sum_interest")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">欠收利息:</td><td colspan="8"><%=qs_interest2.equals("-0.00")?"0.00":qs_interest2%></td>
										</tr>
										<tr>
											<td colspan="1" align="left"  class="first">未收回租金：</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("whs_rent")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">未收回本金：</td><td colspan="4"><%=formatNumberStr(getDBStr(rs.getString("whs_corpus")),"#,##0.00")%></td>
											<td colspan="1" align="left"  class="first">回收率：</td><td colspan="8"><%=rate*100%>%</td>
										</tr>
										<tr>
											<td colspan="20">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</td>
										</tr>
										<%
											}
										%>
										<tr>
											<td colspan="20">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</td>
										</tr>

									</table>
							</div>
							</div>
							</div>		
	</form>
	</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%><%if(null != db2){db2.close();}%>