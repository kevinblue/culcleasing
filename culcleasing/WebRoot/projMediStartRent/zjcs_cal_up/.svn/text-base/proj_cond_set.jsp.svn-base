<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginMediService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoMediBean"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目交易结构</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
//表单提交事件
function verification(){
	if(Validator.Validate(form1,2)){
		form1.submit();
		return true;
	}else{
		return false;
	}
}
</script>
</head>

<%
	//获取参数
	String contract_id = getStr(request.getParameter("contract_id"));
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String flow_date = getStr(request.getParameter("flow_date"));
	String begin_order_index = getStr(request.getParameter("begin_order_index"));
	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
	
	//判断执行类型 -- 从数据库查询有数据则upd无则add
	String savaType = "upd";
	
	//1.如果upd则假装ConditionBean
	BeginInfoMediBean beginInfomediBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfomediBean  = BeginMediService.initBeginInfoBean(begin_id, doc_id);
	}

	//如果有值则加载属性值
if( beginInfomediBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//预计起租日 start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfomediBean.getRent_start_date()) %>");
	
	//付租方式 income_number_year
	$("#income_number_year").val("<%=beginInfomediBean.getIncome_number_year() %>");
	//还租次数 income_number
	$("input[name='income_number']").val("<%=beginInfomediBean.getIncome_number() %>");
	//租赁期限(月) lease_term
	$("input[name='lease_term']").val("<%=beginInfomediBean.getLease_term() %>");
	
	//每月偿付日 income_day
	$("#income_day").val("<%=beginInfomediBean.getIncome_day() %>");
});
</script>
<%
}
%>


<body onload="public_onload(0);">
<form name="form1" method="post"  action="cond_save.jsp">
<!-- 隐藏域传值区域  罚息利率|逾期宽限日-->
<input type="hidden" name="saveType" id="savaType" value="<%=savaType %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="begin_id" value="<%=begin_id %>">
<input type="hidden" name="begin_order_index" value="<%=begin_order_index %>">
<input type="hidden" name="flowSysDate" value="<%=flow_date %>">
<input type="hidden" name="income_day" id="income_day">

<!-- 隐藏域传值区域  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:230px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="4"></td></tr>
			<tr>
				<td colspan="4" align="left">
					<BUTTON class="btn_2" onClick="return verification();">
					<img src="../../images/save.gif" align="absmiddle" border="0">保存起租信息</button>
					<b style="color:red;">(数据修改后，请及时更新！)</b>
				</td>
			</tr>
		 
		 <tr>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>付租方式</td>
		    <td >
		    	 <select name="income_number_year" id="income_number_year" 
		    	 	style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","月付|双月付|季付|半年付|年付","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		</tr>
		
		<tr>	
			<!-- 还租次数=租赁期限/年还租次数 -->
		  	<td scope="row" nowrap>还租次数</td>
		    <td>
		    	<input name="income_number" id="income_number" type="text" value="0" onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" id="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
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
/**
 *初始化一些表单事件
 */
$(document).ready(function(){
	//添加几项失去焦点判断值是否正确
	$(":input[name='income_number']").blur(function(){//年还租次数
		if( $(this).val()=="0" || isNaN($(this).val()) ){//!/^\d+$/.test($(this).val())
			alert("年还租次数填写正整数");
			$(this).val(0);
		}
	});
	
	//起租日期与每月偿付日
	$(":input[name='start_date']").bind("propertychange",function(){
		var staDate = $(this).val();
		var incDay = staDate.substr(staDate.length-2);

		if(incDay.substr(0,1)=="0"){
			incDay = incDay.substr(1,1);
		}
		$("#income_day").val(incDay);
	});
});

//付租方式值改变清空换租次数的值
function changIncome_number_year_value(){	
	var income_number_year = document.getElementsByName("income_number_year")[0].value;
	if(income_number_year == null || income_number_year == ''){
		alert("请选择具体的付租方式!");
		return false;
	}
	document.getElementsByName("income_number")[0].value = '';
	document.getElementsByName("lease_term")[0].value = '';
}


function changLeaseT_value(){
	var income_number_year_value = document.getElementsByName("income_number_year")[0].value;//付租方式
	var income_number_value = document.getElementsByName("income_number")[0].value;//还租次数
	// 还租次数 = 租赁期限/付租方式 //租赁期限 = 还租次数*付租方式
	if(income_number_year_value != null || income_number_year_value != ''){
		if(income_number_value == null || income_number_value == ''){
			alert("请输入还租次数!");
			return false;
		}else{
			var lt_value = income_number_value * income_number_year_value;
			document.getElementsByName("lease_term")[0].value = lt_value; 
		}
	}else{
		alert("请选择付租方式!");
		return false;
	}
}
</script>
</html>
