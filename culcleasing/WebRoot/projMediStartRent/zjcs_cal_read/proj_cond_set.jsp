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
<script type="text/javascript">
$(document).ready(function(){
	$(":input").attr("disabled","disabled");
});
</script>
</head>

<%
	//获取参数
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//判断执行类型 -- 从数据库查询有数据则upd无则add
	String savaType = "upd";
	
	//1.如果upd则假装ConditionBean
	BeginInfoMediBean beginInfomediBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfomediBean  = BeginMediService.initBeginInfoBean(begin_id, doc_id);
	}
%> 

<%
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
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return verification();">
<!-- 隐藏域传值区域  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:230px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		 <tr>
			<td  scope="row" nowrap>预计起租日</td>
			<td>
				<input name="start_date" type="text"
					 size="13" maxlength="20" readonly="readonly"/>
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
		    	<input name="income_number" id="income_number" type="text" value="0"
		    		dataType="Integer" size="13" maxlength="10" maxB="10" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- 根据付租方式判断 -->
			<td scope="row" nowrap>租赁期限(月)</td>
		    <td>
		    	<input name="lease_term" id="lease_term" type="text" value="0"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"/>
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
</html>
