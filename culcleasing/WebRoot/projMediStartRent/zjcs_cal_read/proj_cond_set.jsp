<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.service.BeginMediService"%>
<%@page import="com.tenwa.culc.bean.BeginInfoMediBean"%>
<%@ include file="../../func/common_simple.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���׽ṹ</title>
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
	//��ȡ����
	String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//�ж�ִ������ -- �����ݿ��ѯ��������upd����add
	String savaType = "upd";
	
	//1.���upd���װConditionBean
	BeginInfoMediBean beginInfomediBean = null;
	
	if( savaType!=null && "upd".equals(savaType)){
		beginInfomediBean  = BeginMediService.initBeginInfoBean(begin_id, doc_id);
	}
%> 

<%
//�����ֵ���������ֵ
if( beginInfomediBean!=null ){
%>
<script type="text/javascript">
$(document).ready(function(){
	//Ԥ�������� start_date
	$("input[name='start_date']").val("<%=getDBDateStr(beginInfomediBean.getRent_start_date()) %>");
	
	//���ⷽʽ income_number_year
	$("#income_number_year").val("<%=beginInfomediBean.getIncome_number_year() %>");
	//������� income_number
	$("input[name='income_number']").val("<%=beginInfomediBean.getIncome_number() %>");
	//��������(��) lease_term
	$("input[name='lease_term']").val("<%=beginInfomediBean.getLease_term() %>");
	
	//ÿ�³����� income_day
	$("#income_day").val("<%=beginInfomediBean.getIncome_day() %>");
});
</script>
<%
}
%>


<body onload="public_onload(0);">
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return verification();">
<!-- ������ֵ����  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:230px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		 <tr>
			<td  scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text"
					 size="13" maxlength="20" readonly="readonly"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ⷽʽ</td>
		    <td >
		    	 <select name="income_number_year" id="income_number_year" 
		    	 	style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
		</tr>
		
		<tr>	
			<!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" id="income_number" type="text" value="0"
		    		dataType="Integer" size="13" maxlength="10" maxB="10" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
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
