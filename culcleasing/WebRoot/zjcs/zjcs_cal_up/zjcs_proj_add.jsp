<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="com.tenwa.bean.ConditionBean"%>
<%@page import="java.util.Date"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- ��Ŀ����--���������� ��contract_condition_temp  ��Ŀ���׽ṹ-->
<title>������ - ��Ŀ���׽ṹ</title>
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
	var measure_typeVal = $("#measure_type").val();
	alert(measure_typeVal);
	window.open("file_download.jsp?measure_type="+measure_typeVal);
}
function showUploadDiv(){
	$("#uploadDiv").fadeIn("slow");
}
</script>
</head>
<body onload="public_onload(0);">

<%
	//��������	
	String user_id = (String)session.getAttribute("czyid");//ȡ�õ�¼�˵�ID ����ȡ�õ�¼�˵�name
	//��ȡ����
	String proj_id = getStr(request.getParameter("proj_id"));
	String nowDateTime = getSystemDate(0);//��ǰ��ʽ��֮���ʱ��
%> 
<!-- form����ת��zjcs_projSave.jspҳ��    doCument.forms[0].onsubmit()-->
<form name="form1" method="post" target="rentplan" action="zjcs_projSave.jsp" onSubmit="return Validator.Validate(this,2);check_allInput();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- ������ֵ  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
			<tr>
				<td colspan="8" align="left">
				
				�����㷽����
				<select style="width: 100px;" id="measure_type" name="measure_type" Require="true" onchange="change_disable2()">
		        <script type="text/javascript">
			        	w(mSetOpt('1',
			        	"�ȶ����|�Ȳ����|�ȱ����|�ȶ��|�Ȳ��|�ȱȱ���|�ȶ�����(��Ϣ��)|���ȶ����|���ȶ��|������",
			        	"1|2|3|4|7|6|5|8|9|0"));
		        </script>
		        </select>&nbsp;&nbsp;|
		         �������ͣ�
		        <select name="period_type" style="width: 60px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select>
		        
		        &nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="������" onClick="downloadTemplate();">
				<img src="../../images/fdmo_24.gif" align="absmiddle" border="0">����</button>
		        &nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="������" onClick="dataHander('add_modal','cond_upload.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>');">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0">�ϴ�</button>
				&nbsp;&nbsp;|
				<BUTTON class="btn_2" name="btnSave" value="������" onClick="submitForm()">
				<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
				&nbsp;&nbsp;&nbsp;
				<div id="uploadDiv" style="display:none;">
					<form name="upload_form" action="cond_save.jsp" enctype="multipart/form-data" method="post">
						�ϴ��ļ���&nbsp;&nbsp; 
						 		<input type="file" name="uploadFile" style="width:250px;">
								<span class="biTian">�����ϴ����ļ�����.xls ���8M</span>
						<BUTTON class="btn_2" name="btnSave" type="button" onclick="fun_save()">
					 	<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">�ϴ��ļ�</button>		
					</form>
				</div>
				
				</td>
			</tr>
		
		  <tr>
		  	<!-- �����ֶο�ʼ -->
		  	<input name="rate_adjustment_modulus" type="hidden" value="0"/>
		  	<input name="plan_irr" type="hidden" value="0.00"/>
		  	<input name="accountPrincipal" type="hidden" value="0"/>
		  	<input name="liugprice" type="hidden" value="0"/>
		  	<input name="rentScale" type="hidden" value="0"/>
		  	<input name="delay" type="hidden" value="0"/>
		  	<input name="grace" type="hidden" value="0"/>
		  	<input name="amt_return" type="hidden" value="��"/>
		  	<!-- �����ֶν��� -->
		  	<td scope="row" nowrap>��Ŀ���</td>
		    <td>
		    	<input name="proj_id" id="proj_id" type="text" value="<%=proj_id%>" 
		    		  size="35" maxlength="50"/>
					<!-- dataType="Number" size="13" maxlength="50" maxB="50"  Require="true" -->
		    	<span class="biTian">*</span>
		     </td>
			 <td scope="row" nowrap>��������</td>
		     <td><!-- ��������ݿ��ֵ���л�ȡ���л��ҵ�����  ��ʱд�������������ֵ�� -->
				<select style="width:100px;" name="currency" id="currency" Require="true" disabled="disabled"></select>
				<script language="javascript" class="text">
				dict_list("currency","currency_type","currency_type1","name");
				</script>
    				
		    	<span class="biTian">*</span>
			</td>
		    <td scope="row" nowrap>�豸���</td>
		    <td>
		    	<input name="equip_amt" id="equip_amt" type="text" 
		    		value="0" onchange="changeFirst_payment()"
		    		dataType="Money" size="13" maxlength="50" maxB="50"  Require="true"/>
		       	<span class="biTian">*</span>
		     </td>
		      <td scope="row" nowrap>�׸���</td>
		      <td>
		    	<input name="first_payment" type="text" value="0" 
		    	onchange="changeFirst_payment()" dataType="Money" size="13" maxlength="50" 
		    	maxB="50"  Require="true"/>
		    	<span class="biTian">*</span>
		   	   </td> 
		  </tr> 
		  	
		  <tr>
		  	<!--  ���ޱ��� = �豸��� - �׸��� onclick="changeFirst_payment()"   -->
		   <td scope="row" nowrap>���ޱ���</td>
		     <td>
		    	<input name="lease_money" id="lease_money" value="0" 
		    	readonly type="text" Require="true" dataType="Money" size="13" maxlength="100" maxB="100" 
		    	Require="true"/>
		    	<span class="biTian">*</span>
			 </td>
			<td  scope="row" nowrap>���ޱ�֤��</td>
			<td>
				<input name="caution_money" id="caution_money" value="0" 
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" 
					onchange="assignment()" type="text"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>����������</td>
			<td>
				<input name="handling_charge" type="text" value="0" 
				 	dataType="Money" size="13" maxlength="20" 
				 	maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>�����</td>
		    <td colspan="">
		    	<input name="management_fee" type="text" value="0"  
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" onchange=""/> 
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td scope="row" nowrap>��ѯ������</td>
		  	<td>
		  		<input name="consulting_fee_in" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
		  	<td scope="row" nowrap>��ѯ��֧��</td>
		  	<td>
		  		<input name="consulting_fee" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<!--  onKeyUp="value=value.replace(/[^\d]/g,'')"   -->
			<td  scope="row" nowrap>��������</td>
			<td>
				<input name="other_income" type="text" value="0" dataType="Money"
					  size="13" maxlength="20" onchange="assignment()" />
			</td>
			<td scope="row" nowrap>����֧��</td>
		    <td colspan="">
		    	<input name="other_expenditure" type="text" value="0" dataType="Money"
		    		  size="13" maxlength="10" onchange="assignment()"/> 
			</td>
		  </tr>	
		  
		  <tr>	
		  	<td  scope="row" nowrap>��ֵ����</td>
			<td>
				<input name="nominalprice" type="text" value="0" onchange="assignment()"
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true"/>
				<span class="biTian">*</span>
			</td>
		    <td  scope="row" nowrap>���̷���</td>
			<td>
				<input name="return_amt" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>Ͷ����ʽ</td>
			<td>
				<select style="width: 100px;" name="insure_type" id="insure_type" Require="true"></select>
				<script language="javascript" class="text">
					dict_list("insure_type","insure_type","","name");
				</script>
   				<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ѽ��</td>
		    <td colspan="">
		   	 <input name="insure_money" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="true" onchange="assignment()"/>
			</td>
		  </tr>
		  
		  <tr>
		   	<td scope="row" nowrap>�����ʶ�</td>
		    <td>
		    	<!--  �����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧�� ��2010-07-23�޸ģ�������Ҫ ��ȥ��ǰϢ�� -->
		    	<input name="net_lease_money" id="net_lease_money" type="text" value="" readonly onclick="assignment()" 
		    	dataType="Money" size="13" maxlength="20" maxB="20"/> 
		    		�����ʶ����
    				<input name="lease_money_proportion" id="lease_money_proportion" type="text" 
					value="" size="5" 
					maxlength="10" readonly="readonly" 
					onclick="getlmp_value()" Require="true"/>% 
    				<span class="biTian">*</span>
			</td>
		  	<td  scope="row" nowrap>����������</td>
			<td nowrap="nowrap">
				<input name="year_rate" type="text" value="0.00"  
					dataType="Rate" size="13" maxlength="10" maxB="10"  Require="true"/>%
				<!--  	display: none; 
				<div id="" style="" align="right"> 
					<input type="button"class="button" value="����" alt="����Э�鱨����Ϣ�е���" onclick=""/>
				</div>	   --> 
				<span class="biTian">*</span>
			</td>  
			
		  	<td scope="row" nowrap>��Ϣ������</td>
		    <td colspan="">
		    	<input name="pena_rate" type="text" value="5"  
		         size="13" maxlength="20" dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />%%
		         <!-- ������ж����뷽ʽ ֻ���������� onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.tolerance_date.value)){
		            alert('��Ϣ������ȷ��������');document.all.tolerance_date.focus();}"  
		          -->
		    	<span class="biTian">*</span>
			</td>  
			
			<td scope="row" nowrap>���ڿ�����</td>
		    <td> 
		    	<input name="free_defa_inter_day" type="text" value="0"  
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" 
		    		onKeyUp="value=value.replace(/[^\d]/g,'')"
		         	onblur="if(isNaN(document.all.free_defa_inter_day.value)){
		            alert('����ȷ�������ڿ�����');document.all.free_defa_inter_day.focus();}"/>
		    	<span class="biTian">*</span>
			</td>
		  </tr>
		  
		   
		  
		   <tr>
		   <td scope="row" nowrap>���ⷽʽ</td>
		    <td>
		    	 <select name="income_number_year" id="income_number_year" style="width: 100px;" onchange="changIncome_number_year_value()">
					<script type="text/javascript">
						w(mSetOpt("","�¸�|˫�¸�|����|���긶|�긶","1|2|3|6|12")); 
					</script>
				</select>
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��������</td>
		    <td><select name="period_type" style="width: 100px;">
		        <script type="text/javascript">
			        w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        </script>
		        </select>
		        <span class="biTian">*</span>
			</td> 
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td>
		    	<input name="income_number" type="text" value="0"    onChange="changLeaseT_value()"
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
		   	<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td>
		    	<input name="lease_term" type="text" value="0"  onClick="changLeaseT_value()" 
		    		dataType="Integer" size="13" maxlength="10" maxB="10"  Require="true" readonly/>
		    	<span class="biTian">*</span>
			</td>
			
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		    	<select name="rate_float_type" onchange="changeOne()">
		        <script>
			        w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td>
		    	<input name="rate_float_amt" type="text" value="0"  onblur="alertChange()"
		    		dataType="Double" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td colspan="2">
				<div id="div_rate"></div>
			</td>
			<td  scope="row" nowrap>Ԥ��IRR</td>
			<td>
				<input name="market_irr" type="text" value="0"  
				  size="13" maxlength="10" readonly/>
			</td> 
		  </tr>
		
		  <tr>
		  	<td scope="row" nowrap>��ǰϢ</td>
		    <td>
		    	<input name="before_interest" type="text" value="0"  onchange="assignment()"
		    		dataType="Money" size="13" maxlength="10" maxB="10"  Require="true" />
		    	<span class="biTian">*</span>
			</td>
			<td scope="row" nowrap>��Ϣ����</td>
		  	<td>
		  		<input name="rate_subsidy" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td scope="row" nowrap>����Ϣ</td>
		  	<td>
		  		<input name="discount_rate" type="text" value="0"  
					dataType="Money" size="13" maxlength="20" maxB="20"  Require="" onchange="assignment()"/>
				<span class="biTian"></span>
			</td>
			<td  scope="row" nowrap>Ԥ��������</td>
			<td>
				<input name="start_date" type="text" value="<%=nowDateTime%>"  
					 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
		  	
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td>
				<select name="income_day" style="width: 100px;">
					<% 
						for(int i = 1;i <= 31;i++){
					%>
						<option value="<%=i%>"><%=i%></option>
					<% 
						}
					%>
				</select>	 
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>�����㷽��</td>
			<td><!-- �ȶ��2  ��ʱ���ص� ������0|�ֹ�����3  2010-08-12  -->
				<select style="width: 100px;" name="measure_type" Require="true" onchange="change_disable2()">
		        <script type="text/javascript">
			        	w(mSetOpt('1',
			        	"�ȶ����|�ȶ�����(��Ϣ��)|������",
			        	"1|5|0"));
		        </script>
		        </select>
				<span class="biTian">*</span>
			</td> 
			<td scope="row" nowrap>��Ϣ��ʽ</td>
		    <td>
		    	<select name="ajdust_style" style="width: 100px;">
		        <script type="text/javascript">
		        	w(mSetOpt('0',"������|������|������|������","0|1|2|3"));
		        </script>
		        </select> 
		    	<span class="biTian">*</span>
			</td>
			
			<td scope="row" nowrap>�Ƿ�������Ϣ</td>
	   		<td>
	    	<select name="into_batch" style="width: 100px;">
		        <script type="text/javascript">
			        	w(mSetOpt('��',"��|��","��|��"));
		        </script>
	        </select>
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
