<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<!-- contract_condition_temp  ��Ŀ���׽ṹ-->
<title> ������ - ��Ŀ���׽ṹչʾҳ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<!-- ���ڿؼ� -->
<script src="../../js/calend.js"></script>
<script language="javascript"> 

</script>

</head>
<body>
<%
 	ResultSet rs;
	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	//String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	String proj_id = getStr(request.getParameter("proj_id"));//��ȡ��������ͬ��š� 
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� measure_id
	List<String> list = new ArrayList<String>();
	//��Ŀ��Ų�Ϊ��
	StringBuffer querySql = new StringBuffer();
	//�ж������Ƿ�Ϊ��
	querySql.append("select proj_id,currency,equip_amt,first_payment,")//0-3
	 		.append("lease_money,caution_money,net_lease_money,")//4-6
	 		.append("handling_charge,income_number_year,lease_term,")//7-9
	 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
	 		.append("year_rate,rate_float_type,before_interest,")//14-16
	 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
	 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
	 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
	 		.append(" market_irr  ")//�����ֶ� �г�irr 31
	 		.append(" from proj_condition_temp ")
	 	    .append(" where proj_id = '"+proj_id+"'")//��ͬ���
	 	    .append(" and measure_id = '"+doc_id+"' ");//�ĵ����
	System.out.println("��Ŀ���׽ṹֻ��ҳ��ѯSQL-->   "+querySql.toString());
 	rs = db.executeQuery(querySql.toString());//ִ�в�ѯ
 	//rs.last(); //�Ƶ����һ��
	//int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
	//rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
 	int i = 1;
 	while(rs.next()){
 		//ѭ��ȡֵ ȡ�ñ��ǰ31�У��±��1��ʼȡ
 		for(;i <= 32;i++){
	 		list.add(getDBStr(rs.getString(i)));
 		}
 	}
	rs.close();
	db.close();
%> 
<form name="form1" method="post" target="_black" action="show_projList.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% hight="80%" align=center cellspacing=0 border="0" cellpadding="0">
<!-- ������ֵ  -->
<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
<tr valign="top">
	<td  align=center width=100% height=100%>
	<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
		<tr>
			<td height="5">
				<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
				    <tr class="tree_title_txt">
				      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				      	������ &gt;��Ŀ������ϸ�鿴
				      </td>
				    </tr>
				 </table>
			</td>
		</tr>
		<tr>
			<td width="100%">
 			<table border="0" cellspacing="0" cellpadding="0">
			 	<tr>
  					<td id="Form_tab_0" class="Form_tab" width=88 
  						align=center onClick="chgTabN()"  valign="middle">&nbsp;��ϸ��Ϣ&nbsp;
				</tr>
 			</table>
			</td>
		</tr> 
		<tr>
			<td class="tab_subline" width="100%" height="2">&nbsp;</td>
		</tr>
	</table>

	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:350px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0){
		%>
 			 <tr>
  				<td scope="row" nowrap>��Ŀ���</td>
    			<td> <%=list.get(0)%> </td>
	 			<td scope="row" nowrap>��������</td>
    		    <td>
					<select name="currency" id="currency" disabled="disabled">
					<script>
						var currencyValue = <%=list.get(1)%>;
						if(currencyValue != null && currencyValue != ''){
							w(mSetOpt("<%=list.get(1)%>","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
						}else{
							w(mSetOpt("0","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
						}
					</script>
					</select>
				</td>
    			<td scope="row" nowrap>�豸���</td>
    				<td> <%=formatNumberStr(list.get(2),"#,##0.00")%> </td>
  			</tr> 	
  			<tr>
      			<td scope="row" nowrap>�׸���</td>
      			<td> <%=formatNumberStr(getDBStr(list.get(3)),"#,##0.00")%> </td> 
 				<!--  ���ޱ��� = �豸��� - �׸���   -->
   				<td scope="row" nowrap>���ޱ���</td>
    			 <td> <%=formatNumberStr(getDBStr(list.get(4)),"#,##0.00")%> </td>
				<td  scope="row" nowrap>���ޱ�֤��</td>
				<td> <%=formatNumberStr(getDBStr(list.get(5)),"#,##0.00")%> </td>
  			</tr>
   			<tr>
  				<td scope="row" nowrap>�����ʶ�</td>
   	 			<td> <%=formatNumberStr(getDBStr(list.get(6)),"#,##0.00")%> </td>
				<td  scope="row" nowrap>������</td>
				<td> <%=formatNumberStr(getDBStr(list.get(7)),"#,##0.00")%> </td>
  				<td scope="row" nowrap>���ⷽʽ</td>
    			<td>
    	 			<select name="income_number_year" id="income_number_year" disabled>
					<script>
						var inyValue = "<%=list.get(8)%>";
						if(inyValue != null && inyValue != ''){
							w(mSetOpt("<%=list.get(8)%>","-��ѡ��-|�¸�|˫�¸�|����|���긶|�긶","|1|2|3|6|12")); 
						}else{
							w(mSetOpt("","-��ѡ��-|�¸�|˫�¸�|����|���긶|�긶","|1|2|3|6|12")); 
						} 
					</script>
					</select>
				</td>
  			</tr>	

		  <tr> 
			<td scope="row" nowrap>��������</td>
		    <td>
		    <select name="period_type" disabled>
		        <script>
		        	var perTypeValue = <%=list.get(12)%>;
		        	if(perTypeValue != null && perTypeValue != ''){
			        	w(mSetOpt('<%=list.get(12)%>;',"�ڳ�|��ĩ","1|0"));
		        	}else{
			        	w(mSetOpt('0',"�ڳ�|��ĩ","1|0"));
		        	}
		        </script>
		     </select>
			</td> 
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap>�������</td>
		    <td> <%=list.get(10)%></td>
			<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap>��������(��)</td>
		    <td> <%=list.get(9)%></td>
		  </tr>
		  <tr>
			<td  scope="row" nowrap>����������</td>
			<td> <%=formatNumberStr(getDBStr(list.get(11)),"#,##0.00")%> </td>
		    <td  scope="row" nowrap>���̷���</td>
			<td> <%=formatNumberStr(getDBStr(list.get(13)),"#,##0.00")%> </td>
			<td  scope="row" nowrap>����������</td>
			<td> <%=formatNumberDoubleTwo(getDBStr(list.get(14)))%> </td>  
		  </tr>	
		  <tr>
		  	<td scope="row" nowrap>���ʸ�������</td>
		    <td>
		    	<select name="rate_float_type" disabled>
		        <script>
		        	var rateTypeValue = <%=list.get(15)%>;
		        	if(rateTypeValue != null && rateTypeValue != ''){
			        	w(mSetOpt('<%=list.get(15)%>',"���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"));
		        	}else{
			        	w(mSetOpt('0',"���������ʸ�������|���������ʼӵ�|�̶����������|���ֲ���","0|1|2|3"));
		        	}
		        </script>
		        </select> 
			</td>
			<td scope="row" nowrap>���ʵ���ֵ</td>
		    <td> <%=getDBStr(list.get(29))%> </td>
			<td scope="row" nowrap>��ǰϢ</td>
		    <td> <%=formatNumberDoubleTwo(getDBStr(list.get(16)))%> </td>
		  </tr>
		  <tr>
		  	<td scope="row" nowrap>���ʵ���ϵ��</td>
		    <td> 
		    	<!-- �������ʵ���ϵ��radio��Ĭ�ϳ�ʼ�� -->
		    	<%
		    		String ramValue = getDBStr(list.get(17));
		    		if(ramValue.equals("365/360")){
		    	%>	
					<input type="radio" name="rate_adjustment_modulus" value="365/360" checked style="border:none;">365/360
		    	<%	
		    		}else{ 
		    	%>
		    		<input type="radio" name="rate_adjustment_modulus" value="360/360" checked style="border:none;">360/360
		    	<%
		    		}
		    	%>	
			</td>
		  	<td scope="row" nowrap>��Ϣ����</td>
		    <td colspan=""> <%=formatNumberDoubleTwo(getDBStr(list.get(18)))%> </td>  
			<td  scope="row" nowrap>ÿ�³�����</td>
			<td> <%=getDBStr(list.get(19))%> </td>
		  </tr>
		  <tr>
			<td  scope="row" nowrap>������</td>
			<td> <%=getDBDateStr(list.get(20))%> </td>
			<!-- ��������Ϊ����IRR ԭ����Ϊ�ڲ�������(IRR) -->
			<td  scope="row" nowrap>����IRR</td>
			<td> <%=formatNumberDoubleTwo(getDBStr(list.get(21)))%>% </td> 
			<td  scope="row" nowrap>�����㷽��</td>
			<td>
				<select name="measure_type" disabled="disabled">
		        <script>
		        	var measureValue = <%=list.get(22)%>;
		        	if(measureValue != null){
			        	w(mSetOpt('<%=list.get(22)%>',"�ȶ����|�ȶ��|������","1|2|0"));
		        	}else{
		        		//alert('join');
			        	w(mSetOpt('1',"�ȶ����|�ȶ��|������","1|2|0"));
		        	}
		        </script>
		        </select>
			</td> 
		  </tr>
		  <tr>  
			<td  scope="row" nowrap>��������</td>
			<td> <%=formatNumberStr(getDBStr(list.get(23)),"#,##0.00")%> </td>
			<td scope="row" nowrap>����֧��</td>
		    <td colspan=""> <%=formatNumberStr(getDBStr(list.get(24)),"#,##0.00")%> </td>
		  	<td scope="row" nowrap>��ѯ��</td>
		  	<td colspan=""> <%=formatNumberDoubleTwo(getDBStr(list.get(30)))%> </td>
		  </tr>
		  <tr>
			<td scope="row" nowrap>�Ǽ���</td>
			<td><%=getDBStr(list.get(25))%></td>
			<td scope="row" nowrap>�Ǽ�ʱ��</td>
			<td><%=getDBDateStr(list.get(26))%></td>
			<td scope="row" nowrap>������</td>
			<td><%=getDBStr(list.get(28))%></td>
		  </tr>
		  <tr>
			<td scope="row" nowrap>��������</td>
			<td ><%=getDBDateStr(list.get(27))%></td>
			<td scope="row" nowrap>�г�IRR</td>
			<td colspan="3"><%=formatNumberDoubleTwo(getDBStr(list.get(31)))%></td>
		  </tr>
		<% 		
		}else{
		%>
		  <tr>
			<td scope="row" nowrap>û�и���Ŀ���׽ṹ����ϸ����!</td>
		  </tr>
			
		<% 		
		}
		%>
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
</html>
