<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.MathExtend"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>利息补贴</title>
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
		var interest_money = document.getElementById("interest_money").value;//本次利息 
		var interest_num = document.getElementById("interest_num").value;//本次期次
		var leftInterestSubsidy = document.getElementById("validLM").value;//剩余利息 
		if(leftInterestSubsidy-interest_money<0){
			alert("本次利息补贴金额不能大于剩余利息补贴金额！！！");
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
		if(save_type=="mod"){
			var input = document.getElementsByName("pre_money");
			var money_str="";
			for(var i=0;i<input.length;i++){
				money_str=money_str+document.getElementsByName("pre_money")[i].value+"#";
			}
			money_str=money_str.substring(0,money_str.length-1);
			alert(money_str);
			document.getElementById("money_str").value=money_str;
			alert(money_str);
		}
		document.forms(0).submit();
		//return false;
	}
	
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
//基础参数	
String user_id = (String)session.getAttribute("czyid");//取得登录人的ID 用于取得登录人的name
//获取参数
String contract_id = getStr(request.getParameter("contract_id"));
String begin_id = getStr(request.getParameter("begin_id"));
String doc_id = getStr(request.getParameter("doc_id"));

%>

<body onload="public_onload(0);">
<form name="dataNav" action="oper_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
 <legend style="color:#E46344;font-size: 16px;font-weight: bold">&nbsp;利息补贴
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>

<table border="0" width="100%" cellspacing="5" cellpadding="0">
    <tr height="40" style="font-weight: bold;width:100%;">
		<%
			String totalInterestSubsidy ="0.00";
			String usedInterestSubsidy = "0.00";
			sqlstr = "select rate_subsidy,(select isnull(sum(subsidy_money),0) use_subsidy_money from begin_interest_info  bii ";
			sqlstr +="left join begin_info bi on bi.begin_id=bi.begin_id where bi.contract_id=cc.contract_id) use_subsidy_money";
			sqlstr +=" from contract_condition cc where cc.contract_id='"+contract_id+"' ";
			System.out.println("剩余利息补贴============="+sqlstr);
			rs = db.executeQuery(sqlstr);
			if(rs.next()){
				totalInterestSubsidy = getDBStr(rs.getString("rate_subsidy"));
				usedInterestSubsidy = getDBStr(rs.getString("use_subsidy_money"));
			}
			rs.close();
			//如果已进行过计算，本次补贴的信息
			String old_money="";
			String old_term="";
			sqlstr="select * from begin_interest_info where begin_id='"+begin_id+"'";
			rs = db.executeQuery(sqlstr);
			if(rs.next()){
				old_money = getDBStr(rs.getString("subsidy_money"));
				old_term = getDBStr(rs.getString("subsidy_term"));
			}
			rs.close();
			String leftInterestSubsidy = MathExtend.subtract(totalInterestSubsidy, usedInterestSubsidy);
					//本次初贴明细查询
					sqlstr = "select * from begin_interest_subsidy where begin_id='"+begin_id+"' ";
					LogWriter.logDebug(request, "利息补贴拆分》》》== "+sqlstr);
					rs = db.executeQuery(sqlstr);
		%>
		<td style="font-size: 16px;">合同利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(totalInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">已使用利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(usedInterestSubsidy) %></b></td>
		<td style="font-size: 16px;">剩余利息补贴：<b style="color: red;font-size: 16px;"><%=CurrencyUtil.convertFinance(leftInterestSubsidy) %></b>
		<input type="hidden" id="validLM" value="<%=leftInterestSubsidy %>">
		<input type="hidden" name="contract_id" value="<%=contract_id %>">
		<input type="hidden" name="begin_id" value="<%=begin_id %>">
		<input type="hidden" name="savetype" id="savetype" value="add">
		<input type="hidden" id="old_money" value="<%=old_money %>">
		<input type="hidden" id="old_term" value="<%=old_term %>">
		<input type="hidden" id="temp">
		<input type="hidden" id="money_str" name="money_str">
		</td>
	</tr>
</table>
</fieldset>
</div>


<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="90%">
	<!--操作按钮开始-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
			  <td>本次利息补贴金额 <%=CurrencyUtil.convertFinance(old_money) %>&nbsp;&nbsp;&nbsp;&nbsp;
			  本次利息补贴期数 <%=CurrencyUtil.convertFinance(old_term) %>
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
      <tr  width="100%">
	  <!-- $$$$$$$$$$$$$$- 利息补贴 -$$$$$$$$$$$$$$ -->
	  <td valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>利息补贴</th>
				  </tr>
				  <tbody id="data">
				  <%

					while(rs.next()) {
				  %>
				  <tr>
					<td align="center"><%=getDBStr(rs.getString("subsidy_list")) %></td> 
					<td align="center"><%=CurrencyUtil.convertFinance(getDBStr(rs.getString("subsidy_money")) )%></td> 
				  </tr>
				  <%}
				  	rs.close();
				  %>
				  </tbody>
			  </table>
		  </td>
      </tr>
    </table></div>
</form>
</body>
</html>
