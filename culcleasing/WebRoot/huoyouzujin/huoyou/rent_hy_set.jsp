<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!-- ��������޶� -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��������޶�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/numberseparation.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript">
//�����ύ�¼�
function verification(){
	if(Validator.Validate(form1,3)){
		$("input[type='text']").focus();  
		form1.submit();
		return true;
	}else{
		return false;
	}
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<%
	//��ȡ����
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	//��ȡ���к͵�ǰ�����ڴ�
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
	
	//��Ŀ����	��Ŀ���	����	����	�����·�	�������	��Ŀ����	��Ŀ�ɱ�	
	//ҽԺ�ֳ�
	//ҽԺ�����ֳ�	ҽԺ����֧��	ҽԺ��������	ҽԺʵ��	
	//������˾�ֳ�
	//������˾�����ֳ�	������˾���价�����	������˾����ֳ�	������˾����֧��	������˾��������	������˾ʵ��	
	//����ֳ�
	//��������ֳ�	�������	���򳬶�ֳ�	��������֧��	������������	ʵ���������
	
	int flag = 0;
	sqlstr = "SELECT * FROM fund_rent_plan_hy_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	rs = db.executeQuery(sqlstr);
	
	if(rs.next()){//�����ֵ���������ֵ
		flag = 1;
%>
<script type="text/javascript">
	$(document).ready(function(){
		//ҵ�����ݸ�ֵ
		$("#rent_list").val("<%=getDBStr(rs.getString("rent_list")) %>");
		$("#equip_operation_revenue").val("<%=getDBStr(rs.getString("equip_operation_revenue")) %>");
		$("#leas_rent_start_date").val("<%=getDBDateStr(rs.getString("leas_rent_start_date")) %>");
		$("#leas_rent_end_date").val("<%=getDBDateStr(rs.getString("leas_rent_end_date")) %>");
		$("#income_hire_date").val("<%=getDBDateStr(rs.getString("income_hire_date")) %>");
		$("#plan_date").val("<%=getDBDateStr(rs.getString("plan_date")) %>");
		$("#proj_cost").val("<%=getDBStr(rs.getString("proj_cost")) %>");
	
		//ҽԺ�ֳ�
		$("#medi_base_income").val("<%=getDBStr(rs.getString("medi_base_income")) %>");
		$("#medi_other_outcome").val("<%=getDBStr(rs.getString("medi_other_outcome")) %>");
		$("#medi_other_income").val("<%=getDBStr(rs.getString("medi_other_income")) %>");
		$("#medi_fact_income").val("<%=getDBStr(rs.getString("medi_fact_income")) %>");

		//������˾�ֳ�
		$("#mana_base_income").val("<%=getDBStr(rs.getString("mana_base_income")) %>");
		$("#mana_supp_culc_rent").val("<%=getDBStr(rs.getString("mana_supp_culc_rent")) %>");
		$("#mana_out_divide_income").val("<%=getDBStr(rs.getString("mana_out_divide_income")) %>");
		$("#mana_other_outcome").val("<%=getDBStr(rs.getString("mana_other_outcome")) %>");
		$("#mana_other_income").val("<%=getDBStr(rs.getString("mana_other_income")) %>");
		$("#mana_fact_income").val("<%=getDBStr(rs.getString("mana_fact_income")) %>");
	
		//����ֳ�
		$("#culc_base_income").val("<%=getDBStr(rs.getString("culc_base_income")) %>");
		$("#culc_floor_rent_income").val("<%=getDBStr(rs.getString("culc_floor_rent_income")) %>");
		$("#culc_out_divide_income").val("<%=getDBStr(rs.getString("culc_out_divide_income")) %>");
		$("#culc_other_outcome").val("<%=getDBStr(rs.getString("culc_other_outcome")) %>");
		$("#culc_other_income").val("<%=getDBStr(rs.getString("culc_other_income")) %>");
		$("#culc_fact_income").val("<%=getDBStr(rs.getString("culc_fact_income")) %>");
	});
</script>
<%
}else{%>
	<script type="text/javascript">
	$(document).ready(function(){
		//���μ��صĸ�ֵ����
		$("input[class!='readonlyShowR'][type='text']").val("0.00");
	});
	</script>
<%
}
%>

<body onload="public_onload(0);">
<form name="form1" method="post"  action="rent_save.jsp">
<!-- ������ֵ����  ��Ϣ����|���ڿ�����-->
<input type="hidden" name="flag" value="<%=flag %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="plan_bank_name" value="<%=rPlan_bank_name %>">
<input type="hidden" name="plan_bank_no" value="<%=rPlan_bank_no %>">

<!-- ������ֵ����  -->
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top">
	<td  align=center width=100% height=100%>
	
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:500px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
		<tr><td colspan="6"></td></tr>
		<tr>
			<td colspan="6" align="left">
				<BUTTON class="btn_2" onClick="return verification()">
				<img src="../../images/save.gif" align="absmiddle" border="0">����������</button>
			</td>
		</tr>
		
		<tr>
		  	<td scope="row" nowrap>����ڴ�</td>
		    <td>
		    	<input name="rent_list" id="rent_list" type="text" Require="true" label="����ڴ�" class="readonlyShowR" value="<%=rI %>" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>�����ﵱ����Ӫ������</td>
		    <td>
		    	<input name="equip_operation_revenue" id="equip_operation_revenue" label="�����ﵱ����Ӫ������" type="text" Require="true" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
		    
		    
		    <td scope="row" nowrap>��Ŀ�ɱ�</td>
		    <td>
		    	<input name="proj_cost" id="proj_cost" label="��Ŀ�ɱ�" type="text" Require="true" size="15"/>
		    	<span class="biTian">*</span>
		    </td>
		  </tr> 
		  	
		  <tr>
		  	<td scope="row" nowrap>��Ӫ��ʼ����</td>
		    <td>
		    	<input name="leas_rent_start_date" id="leas_rent_start_date" type="text" label="��Ӫ��ʼ����"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(leas_rent_start_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>��Ӫ��ֹ����</td>
		    <td>
		    	<input name="leas_rent_end_date" id="leas_rent_end_date" type="text" label="��Ӫ��ֹ����"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(leas_rent_end_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
		    
		   <td></td>
		   <td></td>
		  </tr> 
		  
		  <tr>
		  	<td scope="row" nowrap>���������</td>
		    <td>
		    	<input name="income_hire_date" id="income_hire_date" type="text" label="���������"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(income_hire_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
			 
			<td scope="row" nowrap>�ƻ���ȡ����</td>
		    <td>
		    	<input name="plan_date" id="plan_date" type="text" label="�ƻ���ȡ����"
		    		class="readonlyShowR" readonly="readonly" Require="true" size="15"/>
		    	<img onClick="openCalendar(plan_date);return false" style="cursor:pointer; " 
				src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
		    	<span class="biTian">*</span>
		    </td>
		    
		    <td></td>
		    <td></td>
		  </tr> 
		  
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
			<td colspan="8">
				<b style="font-size: 13px;">ҽԺ�ֳ�</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
		  	<td scope="row" nowrap>ҽԺ�����ֳ�</td>
		    <td>
		    	<input name="medi_base_income" id="medi_base_income" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>ҽԺ����֧��</td>
		    <td>
		    	<input name="medi_other_outcome" id="medi_other_outcome" type="text" size="15"/>
		    </td>
		    
		    <td scope="row" nowrap>ҽԺ��������</td>
		    <td>
		    	<input name="medi_other_income" id="medi_other_income" type="text" size="15"/>
		    </td>
		  </tr> 

		  <tr>
		    <td scope="row" nowrap>ҽԺʵ��</td>
		    <td>
		    	<input name="medi_fact_income" id="medi_fact_income" type="text"  size="15"/>
		    </td>
			 
			<td></td>
			<td></td>
			 
			<td></td>
			<td></td>
		  </tr> 
		  
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
			<td colspan="8">
				<b style="font-size: 13px;">������˾�ֳ�</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
		  	<td scope="row" nowrap>������˾�����ֳ�</td>
		    <td>
		    	<input name="mana_base_income" id="mana_base_income" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>������˾���价�����</td>
		    <td>
		    	<input name="mana_supp_culc_rent" id="mana_supp_culc_rent" type="text" size="15"/>
		    </td>
		    
			<td scope="row" nowrap>������˾����ֳ�</td>
		    <td>
		    	<input name="mana_out_divide_income" id="mana_out_divide_income" type="text" size="15"/>
		    </td>
		  </tr> 
		  
		  <tr>
		  	<td scope="row" nowrap>������˾����֧��</td>
		    <td>
		    	<input name="mana_other_outcome" id="mana_other_outcome" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>������˾��������</td>
		    <td>
		    	<input name="mana_other_income" id="mana_other_income" type="text" size="15"/>
		    </td>
		    
			<td scope="row" nowrap>������˾ʵ��</td>
		    <td>
		    	<input name="mana_fact_income" id="mana_fact_income" type="text" size="15"/>
		    </td>
		  </tr> 
		  
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
			<td colspan="8">
				<b style="font-size: 13px;">����ֳ�</b>
				<hr style="filter:alpha(opacity=0,finishopacity=100,style=2);height:8px" color="gray">
			</td>
		  </tr>
		  <!-- �����ķָ���..���涼Ϊ�Ǳ����� -->
		  <tr>
		  	<td scope="row" nowrap>��������ֳ�</td>
		    <td>
		    	<input name="culc_base_income" id="culc_base_income" type="text" size="15"/>
		    </td>
			 
			<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="culc_floor_rent_income" id="culc_floor_rent_income" type="text" size="15"/>
		    </td>
		    
		    <td scope="row" nowrap>���򳬶�ֳ�</td>
		    <td>
		    	<input name="culc_out_divide_income" id="culc_out_divide_income" type="text" size="15"/>
		    </td>
		  </tr> 

		  <tr>
		    <td scope="row" nowrap>��������֧��</td>
		    <td>
		    	<input name="culc_other_outcome" id="culc_other_outcome" type="text"  size="15"/>
		    </td>
		    
		    <td scope="row" nowrap>������������</td>
		    <td>
		    	<input name="culc_other_income" id="culc_other_income" type="text"  size="15"/>
		    </td>
			 
			<td scope="row" nowrap>ʵ���������</td>
		    <td>
		    	<input name="culc_fact_income" id="culc_fact_income" label="ʵ���������" type="text" Require="true" size="15"/>
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
$(document).ready(function() {
    $("input[type='text']").each(function(i) {
		$(this).blur(function (){mouse(this.value,this.name)});
		$(this).focus(function (){huifumouse(this.value,this.name)});
		<%if( flag>0 ){//�����ֵ%>
         //$("input[type='text']").blur(); 
        <%}%>  
 	});
 });
</script>
</html>
<%if(null != db){db.close();}%>