<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!-- 或有租金修订 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>或有租金修订</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
//表单提交事件
function verification(){
	if(Validator.Validate(form1,7)){
		$("input[type='text']").focus();  
		form1.submit();
		return true;
	}else{
		return false;
	}
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<%
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//获取银行和当前租赁期次
	String rI = "1";
	String rPlan_bank_name = "";
	String rPlan_bank_no= "";
	
	sqlstr = "SELECT plan_bank_name,plan_bank_no,isnull(curr_list,0)+1 as rI FROM contract_condition_medi where contract_id='"+contract_id+"'";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		rI = getDBStr(rs.getString("rI"));
		rPlan_bank_name = getDBStr(rs.getString("plan_bank_name"));
		rPlan_bank_no = getDBStr(rs.getString("plan_bank_no"));
	}
	
	
	//租金期次、租赁物件当月运营月收入、运营起始日期、运营截止日期、
	//租金收入（预测收入、保底租金收入、承租人给我司收入、超额分成收益、实际租金收入）、
	//管理公司（管理公司超额收益、重新分额收益）、我司累计所得、收入结算日、计划收取日期
	int flag = 0;
	sqlstr = "SELECT * FROM fund_rent_plan_hy_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	rs = db.executeQuery(sqlstr);
	
	if(rs.next()){//如果有值则加载属性值
		flag = 1;
%>
<script type="text/javascript">
	$(document).ready(function(){
		//业务数据赋值
		$("#rent_list").val("<%=getDBStr(rs.getString("rent_list")) %>");
		$("#equip_operation_revenue").val("<%=getDBStr(rs.getString("equip_operation_revenue")) %>");
		$("#fact_rent_income").val("<%=getDBStr(rs.getString("fact_rent_income")) %>");
		$("#leas_rent_start_date").val("<%=getDBDateStr(rs.getString("leas_rent_start_date")) %>");
		$("#leas_rent_end_date").val("<%=getDBDateStr(rs.getString("leas_rent_end_date")) %>");
		
		$("#income_hire_date").val("<%=getDBDateStr(rs.getString("income_hire_date")) %>");
		$("#plan_date").val("<%=getDBDateStr(rs.getString("plan_date")) %>");
	
		$("#divine_rent_income").val("<%=getDBStr(rs.getString("divine_rent_income")) %>");
		$("#floor_rent_income").val("<%=getDBStr(rs.getString("floor_rent_income")) %>");
		$("#vindicate_out").val("<%=getDBStr(rs.getString("vindicate_out")) %>");
		$("#cust_rent_income").val("<%=getDBStr(rs.getString("cust_rent_income")) %>");
		$("#out_divide_income").val("<%=getDBStr(rs.getString("out_divide_income")) %>");

		$("#mana_divide_income").val("<%=getDBStr(rs.getString("mana_divide_income")) %>");
		$("#re_divide_income").val("<%=getDBStr(rs.getString("re_divide_income")) %>");
	});
</script>
<%
}else{%>
	<script type="text/javascript">
	$(document).ready(function(){
		//初次加载的赋值操作
		$(":input[type='text'][name!='rent_list'][name!='leas_rent_start_date'][name!='leas_rent_end_date'][name!='income_hire_date'][name!='plan_date']").val("0.00");
	});
	</script>
<%
}
%>

<body onload="public_onload(0);">
<form name="form1" method="post"  action="rent_save.jsp">
<!-- 隐藏域传值区域  罚息利率|逾期宽限日-->
<input type="hidden" name="saveType" value="<%=flag %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="plan_bank_name" value="<%=rPlan_bank_name %>">
<input type="hidden" name="plan_bank_no" value="<%=rPlan_bank_no %>">

<!-- 隐藏域传值区域  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		<tr><td colspan="6"></td></tr>
		<tr>
			<td colspan="6" align="left">
				<BUTTON class="btn_2" onClick="return verification()">
				<img src="../../images/save.gif" align="absmiddle" border="0">保存或有租金</button>
			</td>
		</tr>
		
		<tr>
		  	<td scope="row" nowrap>租金期次</td>
		    <td>
		    	<input name="rent_list" id="rent_list" type="text" Require="true" label="租金期次" class="readonlyShowR" value="<%=rI %>" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>租赁物当月运营月收入</td>
		    <td>
		    	<input name="equip_operation_revenue" id="equip_operation_revenue" label="租赁物当月运营月收入" type="text" Require="true" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
		    
 			<td scope="row" nowrap>实际租金收入</td>
		    <td>
		    	<input name="fact_rent_income" id="fact_rent_income" label="实际租金收入" Require="true" type="text" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
		  </tr> 
		  	
		  <tr>
		  	<td scope="row" nowrap>运营起始日期</td>
		    <td>
		    	<input name="leas_rent_start_date" id="leas_rent_start_date" type="text" label="运营起始日期"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(leas_rent_start_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>运营截止日期</td>
		    <td>
		    	<input name="leas_rent_end_date" id="leas_rent_end_date" type="text" label="运营截止日期"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(leas_rent_end_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
		    
		   <td></td>
		   <td></td>
		  </tr> 
		  
		  <tr>
		  	<td scope="row" nowrap>收入结算日</td>
		    <td>
		    	<input name="income_hire_date" id="income_hire_date" type="text" label="收入结算日"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(income_hire_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>计划收取日期</td>
		    <td>
		    	<input name="plan_date" id="plan_date" type="text" label="计划收取日期"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
		    
		    <td></td>
		    <td></td>
		  </tr> 
		  
		  <!-- 华丽的分割线..下面都为非必填项 -->
		  <tr>
			<td colspan="8">
				<b>租金收入</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
		  <!-- 华丽的分割线..下面都为非必填项 -->
		  
		  <tr>
		  	<td scope="row" nowrap>预测收入</td>
		    <td>
		    	<input name="divine_rent_income" id="divine_rent_income" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>保底租金收入</td>
		    <td>
		    	<input name="floor_rent_income" id="floor_rent_income" type="text" size="15"/>
		    </td>
		    
		    <td scope="row" nowrap>成本支出</td>
		    <td>
		    	<input name="vindicate_out" id="vindicate_out" type="text" size="15"/>
		    </td>
		  </tr> 

		  <tr>
		    <td scope="row" nowrap>承租人给我司收入</td>
		    <td>
		    	<input name="cust_rent_income" id="cust_rent_income" type="text"  size="15"/>
		    </td>
		    
		  	<td scope="row" nowrap>超额分成收益</td>
		    <td>
		    	<input name="out_divide_income" id="out_divide_income" type="text" size="15"/>
		    </td>
			 
			<td></td>
			<td></td>
		  </tr> 
		  
		  <!-- 华丽的分割线..下面都为非必填项 -->
		  <tr>
			<td colspan="8">
				<b>管理公司</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
		  <!-- 华丽的分割线..下面都为非必填项 -->
		  
		  <tr>
		  	<td scope="row" nowrap>管理公司超额收益</td>
		    <td>
		    	<input name="mana_divide_income" id="mana_divide_income" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>重新分额收益</td>
		    <td>
		    	<input name="re_divide_income" id="re_divide_income" type="text" size="15"/>
		    </td>
		    
		    <td></td>
		    <td></td>
		  </tr> 
		  
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
<script type="text/javascript">
$(document).ready(function() {
    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouse(this.value,this.name)});
		$(this).focus(function (){huifumouse(this.value,this.name)});
		<%if( flag>0 ){//如果有值%>
         $("input[type='text']").blur(); 
        <%}%>  
 	});
 });
</script>
</html>
