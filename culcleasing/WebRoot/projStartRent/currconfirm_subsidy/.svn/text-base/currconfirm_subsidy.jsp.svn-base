<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>当期分次确认</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script src="../../js/validator.js"></script>
<script type="text/javascript">
	function check_interest(){
		var old_money=document.getElementById("old_money").value;//旧的金额
		var old_term=document.getElementById("old_term").value;//旧的期次
		var interest_money = document.getElementById("interest_money").value;//本次保证金 
		var interest_num = document.getElementById("interest_num").value;//本次期次
		var leftInterestSubsidy = document.getElementById("validLM").value;//剩余保证金 
		if(leftInterestSubsidy-interest_money<0){
			alert("本次确认金额不能大于剩余确认金额！！！");
		}else if(old_money>leftInterestSubsidy){
			alert("本次确认金额不能小于剩余确认金额！！！");
		}
		if(interest_money<0){
			alert("本次确认额度不能小于0");
		}
		
		if(old_money!=""&&(old_money!=interest_money)){
			document.getElementById("tj_sumbit").value="计算";
		}
		if(old_term!=""&&(old_term!=interest_num)){
			document.getElementById("tj_sumbit").value="计算";
		}
		
	}
	
	function mak_value(tmp,flag){
		if(flag==1){
		document.getElementById("temp").value=tmp;		
		}else if(flag==2){
		var old_tmp = document.getElementById("temp").value;
		if((tmp-old_tmp)!=0){
			document.getElementById("tj_sumbit").value="更新";
			document.getElementById("savetype").value="mod";
			}
		}

	}
	
	function check_sub(){
		var save_type=document.getElementById("savetype").value;
		var interest_money = document.getElementById("interest_money").value;//本次保证金 
		var leftInterestSubsidy = document.getElementById("validLM").value;//剩余保证金
		var temp_money=0; 
		if(save_type=="mod"){
			var input = document.getElementsByName("pre_money");
			var money_str="";
			for(var i=0;i<input.length;i++){
				money_str=money_str+document.getElementsByName("pre_money")[i].value+"#";
				temp_money=temp_money+parseFloat(document.getElementsByName("pre_money")[i].value);
			}
			money_str=money_str.substring(0,money_str.length-1);
			document.getElementById("money_str").value=money_str;
			//alert(money_str);
		}
		//判断补贴金额与补贴次数合法性
		if(isNaN($("#interest_money").val()) || isNaN($("#interest_num").val())){
			alert("确认金额或者补贴期数填写格式错误！");
			return false;
		}else if(interest_money<0){
			alert("本次确认额度不能小于0");
			return false;
		}
		else if(leftInterestSubsidy-interest_money<0){
			alert("本次确认金额不能大于剩余确认金额！！");
			return false;
		}else if(temp_money>interest_money){
			alert("本次确认金额不能大于剩余确认金额！");
			return false;
		}		
		else{
			document.forms(0).submit();
		}
		//return false;
	}
	
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//获取参数
String contract_id = getStr(request.getParameter("contract_id"));
String begin_id = getStr(request.getParameter("begin_id"));
String flow_date = getStr(request.getParameter("flow_date"));//流程时间
String doc_id = getStr(request.getParameter("doc_id"));

if("".equals(begin_id)){
	begin_id="12CULC010864L3983";
	contract_id="12CULC010864L39";
	flow_date="2012-5-1";
}

//获取管理费、服务费(租赁手续费)、合计相关额度、已使用额度
String totalInterestSubsidy ="0.00";
String usedInterestSubsidy = "0.00";
sqlstr = "select (isnull(cc.management_fee,0)+isnull(cc.handling_charge,0)) as caution_money,(select isnull(sum(currConfirm_money),0) use_subsidy_money from begin_currconfirm_info  bii ";
sqlstr +="left join begin_info bi on bi.begin_id=bii.begin_id where bi.contract_id=cc.contract_id  and convert(varchar(19),bii.flow_date,21)<convert(varchar(19),'"+flow_date+"',21) ) use_subsidy_money";
sqlstr +=" from contract_condition cc where cc.contract_id='"+contract_id+"' ";
System.out.println("补贴额度============="+sqlstr);
rs = db.executeQuery(sqlstr);
if(rs.next()){
	totalInterestSubsidy = getDBStr(rs.getString("caution_money"));
	usedInterestSubsidy = getDBStr(rs.getString("use_subsidy_money"));
}
rs.close();

//如果已进行过计算，本次补贴的信息
String old_money="";
String old_term="";
String conf_type = "";

sqlstr="select * from begin_currconfirm_info where begin_id='"+begin_id+"' ";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	old_money = getDBStr(rs.getString("currConfirm_money"));
	old_term = getDBStr(rs.getString("currConfirm_term"));
	conf_type = getDBStr(rs.getString("confirm_type"));
}
rs.close();

String leftInterestSubsidy = MathExtend.subtract(totalInterestSubsidy, usedInterestSubsidy);
%>

<% if(!"".equals(conf_type)) { %>
<script type="text/javascript">
$(document).ready(function() {
	$(":radio[name='feeType']").removeAttr("checked");
	$("input[name='feeType'][value='<%=conf_type %>']").attr("checked","checked");
 });
</script>
<%} %>

<body onload="public_onload(0);">
<form name="dataNav" action="oper_save.jsp" target="_blank" onSubmit="return Validator.Validate(this,3);">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
 <legend style="color:#E46344;font-size: 16px;font-weight: bold">&nbsp;当期分次确认
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>

<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr style="font-weight: bold;">
		<td>
		选择费用类型：
			<input type="radio" name="feeType" checked="checked" value="管理费" style="border: none;">管理费
			<input type="radio" name="feeType" value="服务费" style="border: none;">服务费
			<input type="radio" name="feeType" value="合计"   style="border: none;">合计
		</td>
	</tr>
    <tr height="40" style="font-weight: bold;width:100%;">
		<td style="font-size: 16px;">额度：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">已使用额度：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">剩余额度：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftInterestSubsidy) %></b></td>
	</tr>
</table>

<input type="hidden" id="validLM" value="<%=leftInterestSubsidy %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="begin_id" value="<%=begin_id %>">
<input type="hidden" name="savetype" id="savetype" value="add">
<input type="hidden" name="flow_date" value="<%=flow_date %>">
<input type="hidden" id="old_money" value="<%=old_money %>">
<input type="hidden" id="old_term" value="<%=old_term %>">
<input type="hidden" id="confirm_type" value="<%=conf_type %>">
<input type="hidden" id="temp">
<input type="hidden" id="money_str" name="money_str">
		
</fieldset>
</div>




<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="90%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			<td>
			  本次确认额度<input type="text" name="interest_money" id="interest_money" dataType="Number" 
			  	Require="true"  onblur="check_interest();" value="<%=old_money %>"><span class="biTian">*</span>
			  确认期数<input type="text" name="interest_num" id="interest_num" dataType="Number"  
			  	Require="true" onblur="check_interest();" value="<%=old_term %>"><span class="biTian">*</span>
				<input type="button" id="tj_sumbit" value="计算" onclick="check_sub();">
			</td>
			
			<td>
				<BUTTON class="btn_2" type="button" onclick="updData();">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="上传(Alt+N)">&nbsp;上传Excel</button>
			</td>
	    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="10%"><!--翻页控制开始-->
	</td>		 	
 </tr>
</table>


<div style="vertical-align:top;width:100% ;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">
	<table align="center" width="100%">		
      <tr width="100%">
	  <td valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>确认期次</th>
					<th>日期</th>
					<th>确认额度</th>
				  </tr>
				  <tbody id="data">
				  <%
					//本次初贴明细查询
					sqlstr = "select * from begin_currconfirm_subsidy where begin_id='"+begin_id+"' ";
					rs = db.executeQuery(sqlstr);
					while(rs.next()) {
				  %>
				  <tr>
					<td><%=getDBStr(rs.getString("currconfirm_list")) %></td> 
					<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
					<td>
						<input type="text" name="pre_money"  onfocus="mak_value(this.value,'1');" 
						onblur="mak_value(this.value,'2');" value="<%=getDBStr(rs.getString("currconfirm_money")) %>"></td> 
				  </tr>
				  <%}
				  	rs.close();
				  	db.close();
				  %>
			  </tbody>
		  </table>
	  </td>
      </tr>
    </table>
</div>
</form>
<script type="text/javascript">
	function updData(){
		var ty = $(":radio[name='feeType']").val();
		window.open("confirm_upload.jsp?begin_id=<%=begin_id %>&contract_id=<%=contract_id %>&flow_date=<%=flow_date %>&type="+ty);
	}
</script>
</body>
</html>
