<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@page import="com.tenwa.culc.service1.BeginService1"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../../func/common_simple.jsp"%>


<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 商务交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
function downloadTemplate(){
	var settle_methodVal = $("#settle_method").val();
	var period_typeVal = $("#period_type").val();
	window.open("file_download.jsp?settle_method="+settle_methodVal+"&period_type="+period_typeVal);
}
function showUploadDiv(){
	$("#uploadDiv").fadeIn("slow");
}

/**
 *初始化一些表单事件
 */
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
	
	//租金公比参数 ratio_param
	$(":input[name='ratio_param']").blur(function(){//公比
		//先取出测算方式
		var stm = $("#settle_method").val();
		var ratio_param = $(this).val();

		if( stm=="RentCalcType3" || stm=="RentCalcType6" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公比只能不能填写字符");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param<=0 || ratio_param>=1 ){
				alert("公比只允许0到1之间");
				$(this).val(0);
				$(this).focus();
			}
		}else if( stm=="RentCalcType2" || stm=="RentCalcType5" ){
			if( isNaN(ratio_param) ){
				alert("抱歉，公差不能填写字符");
				$(this).val(0);
				$(this).focus();
			}else if( ratio_param==0 ){
				alert("公差不允许填0");
				$(this).val(0);
				$(this).focus();
			}
		}
	});
});

/**
 * 租金测算方法改变
 */
function changeCalcWay(){
	var settle_methodVal = $("#settle_method").val();
	if( settle_methodVal=="RentCalcType2" ){
		$("#bj_1").text("租金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType5" ){
		$("#bj_1").text("本金公差");
		$("#bj_2").show();
		$("#bj_3").text("不允许填0");
	}else if( settle_methodVal=="RentCalcType3" ){
		$("#bj_1").text("租金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0到1之间");
	}else if( settle_methodVal=="RentCalcType6" ){
		$("#bj_1").text("本金公比");
		$("#bj_2").show();
		$("#bj_3").text("只允许0到1之间");
	}else if( settle_methodVal=="RentCalcType7" ){
		$("#period_type").val("1");
	}else{
		$("#bj_1").text("");
		$("#bj_2").hide();
		$("#bj_3").text("");
		$(":input[name='ratio_param']").val("0");
	}
}
</script>
</head>

<%
	//基础参数	
	String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间

	//1.如果upd则假装ConditionBean
	BeginInfoBean beginInfoBean = null;
	beginInfoBean  = BeginService.initBeginInfoBean(begin_id, doc_id);
	beginInfoBean  = BeginService1.initBeginInfoBean(beginInfoBean);
	
	//2012-3-28 Jaffe 新增查询 新Irr与老Irr
	String newIrr = "";
	String sqlStr = "SELECT new_irr FROM dbo.begin_rent_change_irr where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	ResultSet rs = null;
	rs = db.executeQuery(sqlStr);
	if(rs.next()){
		newIrr = rs.getString("new_irr");
	}
	//db.close();
%> 

<script type="text/javascript">
$(document).ready(function(){
	//起租次数
	$("input[name='begin_order_index']").val("<%=beginInfoBean.getBegin_order_index() %>");
	//租金计算方法 settle_method
	$("select[name='settle_method']").val("<%=beginInfoBean.getSettle_method() %>");
	//付租类型： period_type
	$("#period_type").val("<%=beginInfoBean.getPeriod_type() %>");
	//设备金额 equip_amt
	$("#equip_amt").val("<%=beginInfoBean.getEquip_amt() %>");
	//租赁本金 lease_money
	$("input[name='lease_money']").val("<%=beginInfoBean.getLease_money() %>");
	//净融资额 actual_fund
	$("input[name='actual_fund']").val("<%=beginInfoBean.getActual_fund() %>");
	
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfoBean.getRent_start_date()) %>");
	
	//租赁年利率 year_rate
	$("input[name='year_rate']").val("<%=beginInfoBean.getYear_rate() %>");
	//罚息日利率 pena_rate
	$("input[name='pena_rate']").val("<%=beginInfoBean.getPena_rate() %>");
	//逾期宽限日 free_defa_inter_day
	$("input[name='free_defa_inter_day']").val("<%=beginInfoBean.getFree_defa_inter_day() %>");
	//付租方式 income_number_year
	$("#income_number_year").val("<%=beginInfoBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=beginInfoBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=beginInfoBean.getLease_term() %>");
	//每月偿付日 income_day
	$("select[name='income_day2']").val("<%=beginInfoBean.getIncome_day() %>");
	$("select[name='income_day']").val("<%=beginInfoBean.getIncome_day() %>");
	//利率浮动类型  rate_float_type
	$("select[name='rate_float_type']").val("<%=beginInfoBean.getRate_float_type() %>");
	//利率调整值 rate_float_amt
	$("input[name='rate_float_amt']").val("<%=beginInfoBean.getRate_float_amt() %>");
	$("input[name='rate_float_amt']").blur();
	
	//预计IRR plan_irr
	$("input[name='plan_irr']").val("<%=beginInfoBean.getPlan_irr() %>");
	//实际IRR fact_irr
	$("input[name='fact_irr']").val("<%=beginInfoBean.getFact_irr() %>");
	//调息方式 adjust_style
	$("select[name='adjust_style']").val("<%=beginInfoBean.getAdjust_style() %>");
	//是否批量调息 into_batch
	$(":radio[name='into_batch']").removeAttr("checked");
	$("input[name='into_batch'][value='<%=beginInfoBean.getInto_batch() %>']").attr("checked","checked");
	//利率是否对外公开
	$(":radio[name='is_open']").removeAttr("checked");
	$("input[name='is_open'][value='<%=beginInfoBean.getIs_open() %>']").attr("checked","checked");
	
	// 资产余值 assets_value
	$("input[name='assets_value']").val("<%=beginInfoBean.getAssets_value() %>");
	// 本金公比、租金公比、本金公差、租金公差 ratio_param
	$("input[name='ratio_param']").val("<%=beginInfoBean.getRatio_param() %>");
	//预计收款银行名称
	$("input[name='plan_bank_name']").val("<%=beginInfoBean.getPlan_bank_name() %>");
	//预计收款银行账号
	$("input[name='plan_bank_no']").val("<%=beginInfoBean.getPlan_bank_no() %>");
	//租金开票方式
	$("select[name='invoice_type']").val("<%=beginInfoBean.getInvoice_type() %>");
	//税种
	$("select[name='tax_type']").val("<%=beginInfoBean.getTax_type() %>");
	//增值税发票类型
	//alert(<%=beginInfoBean.getTax_type_invoice() %>);
	$("select[name='tax_type_invoice']").val("<%=(null==beginInfoBean.getTax_type_invoice()?"无":beginInfoBean.getTax_type_invoice()) %>");
	//显示设置
	changeCalcWay();
	
	//原Irr
	$("input[name='old_irr']").val("<%=beginInfoBean.getFact_irr() %>");
	//新Irr
	$("input[name='new_irr']").val("<%=newIrr %>");
});
</script>

<body onload="public_onload(0);">
<form name="form1" method="post"  action="cond_save.jsp">
<input type="hidden" name="plan_irr" value="0">
<input type="hidden" name="fact_irr" value="0">

<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height="80%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				租金计算方法:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 <select style="width:130px;" name="settle_method" id="settle_method" 
					Require="true" onchange="changeCalcWay()">
					<script type="text/javascript">
						w(mSetOpt('',
						"等额租金|等差租金|等比租金|等额本金|等差本金|等比本金|等额租金后付(均息法)|不等额租金|不等额本金|不规则",
						"RentCalcType1|RentCalcType2|RentCalcType3|RentCalcType4|RentCalcType5|RentCalcType6|RentCalcType7|RentCalcType8|RentCalcType9|RentCalcType10"));
					</script>
				</select>
				<!--
		        <select style="width:130px;" name="settle_method" id="settle_method" Require="true" onchange="changeCalcWay()"></select>
				<script language="javascript">
				dict_list("settle_method","RentCalcType","","name");
				</script>--><span class="biTian">*</span>
		        &nbsp;&nbsp;|
		        <div id="bj_1" style="float: left;"></div>
				<div id="bj_2" style="display: none;float: left;margin-left: 24px;">
		   			<input name="ratio_param" type="text" dataType="Double" value="0.00" size="13" maxlength="10" maxB="10">
				</div>
		        <div id="bj_3" style="float: left; color: red;margin-left: 5px;"></div>
		        &nbsp;&nbsp;|
		         付租类型：
		        <select name="period_type" id="period_type" style="width: 60px;" Require="true">
		        <script type="text/javascript">
			        w(mSetOpt('0',"期初|期末","1|0"));
		        </script>
		        </select><span class="biTian">*</span>
				</td>
			</tr>
		  <tr>
		  	<!-- 隐藏字段结束 -->
		  	<td scope="row" nowrap>合同编号</td>
		    <td>
		    	<input name="contract_id" id="contract_id" type="text" value="<%=contract_id%>" size="25" maxlength="50"/>
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>货币类型</td>
		     <td><!-- 这里从数据库字典表中获取所有货币的类型  暂时写死不清楚具体的字典表 -->
			 <select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled">
					<option value="currency_type1">人民币</option>
				</select>
				<!--
				<select style="width:100px;" name="currencyVal" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currencyVal","currency_type","currency_type1","name");
				</script>-->
		        <input name="currency" type="hidden" style="width:100px;" value="currency_type1">
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>租赁本金</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" type="text" Require="true" dataType="Money" 
		    	size="13" maxlength="100" maxB="100" Require="true" onblur="checkValid()"/>
		    	<span class="biTian">*</span>
			 </td>
			<td scope="row" nowrap>净融资额</td>
		    <td>
		    	<input name="actual_fund" id="actual_fund" type="text" value=""
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
    			<span class="biTian">*</span>
			</td>
		  </tr> 
		  
		  <tr>
		 	<td scope="row" nowrap>资产余值</td>
		    <td>
		    	<input name="assets_value" type="text" value="0" dataType="Money" size="13" maxlength="10" maxB="10" />
			</td>
		  	<td  scope="row" nowrap>租赁年利率</td>
			<td nowrap="nowrap">
				<input name="year_rate" id="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<span class="biTian">*</span>
			</td>  
			
		  	<td scope="row" nowrap>罚息日利率</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />%%
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>逾期宽限日</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="3"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	<td scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			
			 <td scope="row" id="bj_3">计划收款开户银行</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_name" type="text" readonly="readonly">
		    </td>
		
		    <td scope="row" id="bj_4">计划收款银行账号</td>
		    <td scope="row">
		    <input style="width:150px;" name="plan_bank_no" type="text" readonly="readonly">
		    
		    <img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
			style="cursor:pointer" onclick="popUpWindow('plan_bank_info.jsp',250,350)">
		    </td>
		  	<td  scope="row" nowrap>利率对外公开</td>
			<td>
				<input type="radio" name="is_open" value="是">是 &nbsp;
				<input type="radio" name="is_open" value="否">否 &nbsp;
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		   <td scope="row" nowrap>付租方式</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		    <!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" type="text" value="0"  onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>每月偿付日</td>
			<td>
				<input type="hidden" name="income_day" id="income_day" value="<%=getCurrentDatePart(3) %>">
				<select name="income_day2" style="width: 100px;" disabled="disabled">
					<script type="text/javascript">
						for(var i=1;i<=31;i++){
							document.write("<option value='"+i+"'>"+i+"</option>");
						}
					</script>
				</select>	 
				<span class="biTian">*</span>
			</td>
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap>利率浮动类型</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script type="text/javascript">
			        w(mSetOpt('0',"按央行利率浮动比率|按央行利率加点|隐含利率|保持不变","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>利率调整值</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>原IRR</td>
			<td>
				<input name="old_irr" type="text" value="0" size="13" maxlength="10" readonly="readonly"/>
			</td> 
		  </tr>
		 
		  <tr>
			<td scope="row" nowrap>调息方式</td>
		    <td>
		    	<select name="adjust_style" style="width: 100px;">
			        <script type="text/javascript">
			        	w(mSetOpt('2',"按次日|按次期","1|2"));
			        </script>
		        </select> 
		        批量调息
		        <input type="radio" name="into_batch" value="是" checked="checked">是
		    	<input type="radio" name="into_batch" value="否">否
		    	<span class="biTian">*</span>
			</td>
			
			<td scope="row" nowrap>租金开票方式</td>
			<td>
			<select style="width:140px;" name="invoice_type" id="invoice_type" Require="true" label="租金开票方式">
					  <script type="text/javascript">
						w(mSetOpt('',"先开，租金总额发票|先开，本金收据，利息发票|先开，本利分开|后开，租金总额发票|后开，本金收据，利息发票|后开，本利分开|后开，本利分开两张发票|先开，本利分开两张发票|其它",
						"root.RentInvoice.001|root.RentInvoice.002|root.RentInvoice.003|root.RentInvoice.004|root.RentInvoice.005|root.RentInvoice.006|root.RentInvoice.007|root.RentInvoice.008|root.RentInvoice.009"));
					</script>
				</select>
				<!--
				<select style="width:150px;" name="invoice_type" id="invoice_type" Require="true"></select>
				<script language="javascript">
					dict_list("invoice_type","root.RentInvoice","","name");
				</script>-->
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>税种</td>
			<td>
				<select style="width:100px;" name="tax_type" id="tax_type"  Require="true"  disabled="disabled" >
					  <script type="text/javascript">
						w(mSetOpt('',"营业税|增值税","营业税|增值税"));
					</script>
				</select>
				<span class="biTian">*</span>
			</td> 
			<td  scope="row" nowrap>增值税发票类型</td>
			<td>
			<select style="width:150px;" name="tax_type_invoice" id="tax_type_invoice" Require="true" disabled="disabled" >
					  <script type="text/javascript">
							w(mSetOpt('',"增值税普通发票|增值税专用发票|无","增值税普通发票|增值税专用发票|无"));
					  </script>
				</select>
								
   				<span class="biTian">*</span>
			</td>
			
	   		<td colspan="2"></td>
			
			<td></td><td>
			<input name="new_irr" type="hidden" value="0" size="13" maxlength="10" style="width: 100"/>
			</td>
		</tr>

		  <tr>
			<td  scope="row" nowrap><font style="color:red;font-size:20px;">是否央行调息</font></td>
			<td colspan="7">
	<%
    sqlStr = "SELECT isnull(doc_id,'否') as sftx FROM dbo.fund_adjust_interest_contract_bgz where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' ";
	rs = db.executeQuery(sqlStr);
	String sftx = "否";
	if(rs.next()){
		sftx = rs.getString("sftx");
	}
	db.close();
				%>
				<font style="color:red;font-size:20px;"><%="否".equals(sftx)?"否":"是"%></font>
			</td>
		
		  </tr>
		  
		</table>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                