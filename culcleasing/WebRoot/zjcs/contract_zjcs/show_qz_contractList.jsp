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
<title> ������ - �����ͬ���׽ṹչʾҳ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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
	if(proj_id.equals("") || proj_id == null){
		proj_id = "��Ŀ���Ϊ��";
	}
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ���� measure_id
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	String model = getStr(request.getParameter("model"));//model
	List<String> list = new ArrayList<String>();
	//��Ŀ��Ų�Ϊ��
	StringBuffer querySql = new StringBuffer();
	//�ж������Ƿ�Ϊ��
	querySql.append("select contract_id,currency,equip_amt,first_payment,")//0-3
 		.append("lease_money,caution_money,net_lease_money,")//4-6
 		.append("handling_charge,income_number_year,lease_term,")//7-9
 		.append("income_number,nominalprice,period_type,return_amt,")//10-13
 		.append("year_rate,rate_float_type,before_interest,")//14-16
 		.append("rate_adjustment_modulus,pena_rate,income_day,start_date,")//17-20
 		.append("plan_irr,measure_type,other_income,other_expenditure,creator,")//21-25
 		.append("create_date,modify_date,modificator,rate_float_amt,consulting_fee, ")//26-30
 		.append(" market_irr,  ")//�����ֶ� �г�irr 31
 		.append(" lease_money_proportion,  ")//�������ֶ� 2010-07-27��32 �����ʶ����
 		.append(" accountPrincipal  ")//�������ֶ� 2010-08-06��33 ��ƺ��㱾��
 		.append(",rentScale  ")//�������ֶ� 2010-08-20��34 Բ����
 		.append(",liugprice  ")//�������ֶ� 2010-09-21��35 �����ۣ�ԭ���������۸ĳɲ�ֵ
 		 .append(",delay")//�������ֶ� 2010-10-20��36 �ӳ�����
		.append(",grace")//�������ֶ� 2010-10-20��37 ��������
		.append(",management_fee  ")//�������ֶ� 2010-11-11��38 ����� 
		.append(",ajdustStyle  ")//�������ֶ� 2010-11-23��39 ��Ϣ��ʽ  
 		.append(" from contract_condition_temp ")
 		.append(" where contract_id = '"+contract_id+"' ")
 		.append(" and measure_id = '"+doc_id+"' ");
 		//.append(" and lease_money_proportion = ((net_lease_money/equip_amt)*100)"); 
	System.out.println("��Ŀ���׽ṹֻ��ҳ��ѯSQL-->   "+querySql.toString());
 	rs = db.executeQuery(querySql.toString());//ִ�в�ѯ
 	//rs.last(); //�Ƶ����һ��
	//int rowCount = rs.getRow(); //�õ���ǰ�кţ�Ҳ���Ǽ�¼��
	//rs.beforeFirst(); //��Ҫ�õ���¼�����Ͱ�ָ�����Ƶ���ʼ����λ��
 	int i = 1;
 	while(rs.next()){
 		//ѭ��ȡֵ ȡ�ñ��ǰ31�У��±��1��ʼȡ
 		for(;i <= 40;i++){
	 		list.add(getDBStr(rs.getString(i)));
 		}
 	}
 	rs.close();
%> 
<form name="form1" method="post" target="_blank" action="zjcs_qz_contractSave.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% hight="80%" align=center cellspacing=0 border="0" cellpadding="0">
<!-- ������ֵ  -->
<input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>"/>
<input type="hidden" name="proj_id" id="proj_id" value="<%=proj_id%>"/>
<input type="hidden" name="contract_id" id="contract_id" value="<%=contract_id%>"/>
<input type="hidden" name="savaType" id="savaType" value="<%=model%>"/>
<tr valign="top">
	<td  align=center width=100% height=100%>
	<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
		<tr>
			<td height="5">
				<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
				    <tr class="tree_title_txt">
				      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				      	������ &gt;��ͬ������ϸ�鿴
				      </td>
				    </tr>
				 </table>
			</td>
		</tr>
	</table>

	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:380px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" hight=100%" align="center" class="tab_table_title">
		<%
			if(list.size() > 0){
		%>
 			 <tr>
  				<td scope="row" nowrap >��Ŀ���</td>
    			<td> <%=proj_id%> </td>
  				<td scope="row" nowrap >��ͬ���</td>
    			<td> <%=list.get(0)%> </td>
	 			<td scope="row" nowrap >��������</td>
    		    <td> 
					<select name="currency" id="currency" disabled="disabled">
					<script>
						var currencyValue = <%=list.get(1)%>;
						if(currencyValue != null && currencyValue != '' && currencyValue != 'undefined'){
							w(mSetOpt("<%=list.get(1)%>","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
						}else{
							w(mSetOpt("0","�����|��Ԫ|��Ԫ|��������|�¹����|�۱�|���ô�Ԫ|������|��ʿ����|����ʱ����|ŷԪ","0|1|2|3|4|5|6|7|8|9|10")); 
						}
					</script>
					</select>
				</td>
    			<td scope="row" nowrap >�豸���</td>
    			<td> <%=formatNumberStr(getDBStr(list.get(2)),"#,##0.00")%> </td>
  			</tr> 	
  			<tr> 
      			<td scope="row" nowrap >�׸���</td>
      			<td> <%=formatNumberStr(getDBStr(list.get(3)),"#,##0.00")%> </td> 
 				<!--  ���ޱ��� = �豸��� - �׸���   -->
   				<td scope="row" nowrap >���ޱ���</td>
    			 <td> <%=formatNumberStr(getDBStr(list.get(4)),"#,##0.00")%> </td>
				<td  scope="row" nowrap >���ޱ�֤��</td>
				<td> <%=formatNumberStr(getDBStr(list.get(5)),"#,##0.00")%> </td>
				<td scope="row" nowrap >����������</td>
				<td> <%=formatNumberStr(getDBStr(list.get(7)),"#,##0.00")%> </td>
  			</tr>

   			<tr>
   				<td scope="row" nowrap>�����</td>
			    <td colspan=""> <%=getDBStr(list.get(38))%> </td>
  				<td scope="row" nowrap >�����ʶ�</td>
   	 			<td> 
   	 				<%=formatNumberStr(getDBStr(list.get(6)),"#,##0.00")%> 
   	 				&nbsp;&nbsp;&nbsp;�����ʶ���� <%=formatNumberStr(getDBStr(list.get(32)),"#,##0.00")%>&nbsp;% </td>
   	 			</td>
   	 			<td scope="row" nowrap >���ⷽʽ</td>
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
				<td scope="row" nowrap >��������</td>
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
  			</tr>	

		  <tr> 
 			
		    <!-- �������=��������/�껹����� -->
		  	<td scope="row" nowrap >�������</td>
		    <td> <%=list.get(10)%> </td>
			<!-- ���ݸ��ⷽʽ�ж� -->
			<td scope="row" nowrap >��������(��)</td>
		    <td> <%=list.get(9)%> </td>
			<td  scope="row" nowrap >�ʲ���ֵ</td>
			<td> <%=formatNumberStr(getDBStr(list.get(11)),"#,##0.00")%> </td>
		    <td  scope="row" nowrap >���̷���</td>
			<td> <%=formatNumberStr(getDBStr(list.get(13)),"#,##0.00")%> </td>
		  </tr>	
		  
		  <tr>
		  	<td scope="row" nowrap >���ʸ�������</td>
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
			<td scope="row" nowrap >���ʵ���ֵ</td>
		    <td> <%=getDBStr(list.get(29))%> </td>
			<td scope="row" nowrap >��ǰϢ</td>
		    <td> <%=formatNumberStr(getDBStr(list.get(16)),"#,##0.00")%> </td>
		  	<td  scope="row" nowrap >����������</td>
			<td>
				<%
					//2011-05-06  �����ʱ�� ���������ʵ��޸� �������ʱ������
					String measure_type =  list.get(22);//�ȶ����|�ȶ��|������","1|2|0"
					if(!"0".equals(measure_type)){
				%>
				<input name="year_rate" id="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"  
					dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"/>%
				<span class="biTian">*</span> 
				<% }else{%>
				<input name="year_rate" id="year_rate" type="text" value="<%=formatNumberStr(getDBStr(list.get(14)),"#,##0.000000")%>"  
					readonly="readonly"/>%
				<% }%>
			</td>  
		 </tr>
		 
		 <tr>
		  	<td scope="row" nowrap >���ʵ���ϵ��</td>
		    <td> 
		    	<%
		    		String ramValue = list.get(17);
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
			<td scope="row" nowrap >��Ϣ������</td>
			<td colspan=""> <%=formatNumberStr(getDBStr(list.get(18)),"#,##0.00")%>&nbsp;%%</td>  
			<td  scope="row" nowrap >ÿ�³�����</td>
			<td>
				<select name="income_day">
					<% 
						for(int j = 1;j <= 31;j++){
							int num_temp = Integer.parseInt(getDBStr(list.get(19)));
							if(num_temp == j){
					%>
						<option value="<%=getDBStr(list.get(19))%>" selected><%=getDBStr(list.get(19))%></option>
					<% 
							}else{
					%>
						<option value="<%=j%>"><%=j%></option>	
					<% 
							}
						}
					%>
				</select>	
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap >������</td>
			<td>
				<input name="start_date" type="text" value="<%=getDBDateStr(list.get(20))%>"  
						 size="13" maxlength="20"  Require="true" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
					 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
		  </tr>
		  
		  <tr>
			<td  scope="row" nowrap >�����㷽��</td>
			<td>
				<select name="measure_type" disabled>
		        <script>
		        	var measureValue = <%=list.get(22)%>;
		        	if(measureValue != null){
			        	w(mSetOpt('<%=list.get(22)%>',"�ȶ����|�ȶ��|������","1|2|0"));
		        	}else{
			        	w(mSetOpt('2',"�ȶ����|�ȶ��|������","1|2|0"));
		        	}
		        </script>
		        </select>
			</td> 
			<td  scope="row" nowrap >����IRR</td>
			<td> <%=formatNumberStr(getDBStr(list.get(21)),"#,##0.000000")%>&nbsp;%</td> 
		    <td scope="row" nowrap>�г�IRR</td>
			<td><%=formatNumberStr(getDBStr(list.get(31)),"#,##0.000000")%>&nbsp;%</td>
			<td  scope="row" nowrap >��������</td>
			<td> <%=formatNumberStr(getDBStr(list.get(23)),"#,##0.00")%> </td>
		</tr>
		<tr>
			<td scope="row" nowrap >����֧��</td>
		    <td> <%=formatNumberStr(getDBStr(list.get(24)),"#,##0.00")%> </td>
		  	<td scope="row" nowrap >��ѯ��</td>
		  	<td > <%=formatNumberStr(getDBStr(list.get(30)),"#,##0.00")%> </td>
		  	<!-- ����ӵĻ�ƺ��㱾�� = �����ʶ�+��֤��  2010-08-06 -->
		  	<td scope="row" nowrap>��ƺ��㱾��</td>
		  	<td> <%=formatNumberStr(getDBStr(list.get(33)),"#,##0.00")%> 
			</td>
		  	<!-- 
		  	<td scope="row" nowrap >�Ǽ���</td>
			<td><%=getDBStr(list.get(25))%></td>
		  	<td scope="row" nowrap >�Ǽ�ʱ��</td>
			<td><%=getDBDateStr(list.get(26))%></td>
			 -->
			<!-- �����ֶ� 2010-09-21 ԭ���������۸ĳɲ�ֵ--->
			<td scope="row" nowrap>�����ۿ�</td>
		  	<td> <%=formatNumberStr(getDBStr(list.get(35)),"#,##0.00")%> </td>
		</tr>
		<!-- 
		<tr>
		  	<td scope="row" nowrap >������</td>
			<td><%=getDBStr(list.get(28))%></td>
		  	<td scope="row" nowrap >��������</td>
			<td colspan=""><%=getDBDateStr(list.get(27))%></td>
			 
		</tr>
		 -->
		<tr>
			<!-- �����ֶ�  2010-08-20 -->
		  	<td scope="row" nowrap>Բ����</td>
		  	<td colspan="">
		  		<select name="rentScale" disabled="disabled">
			        <script>
			        	var rentScaleValue = '<%=list.get(34)%>';
			        	//alert(rentScaleValue);
			        	if(rentScaleValue != null && rentScaleValue != ''){
				        	w(mSetOpt('<%=list.get(34)%>',"Ԫ|��|��","0|1|2"));
			        	}else{
				        	w(mSetOpt('0',"Ԫ|��|��","0|1|2"));
			        	}
			        </script>
		        </select> 
			</td>
			<td  scope="row" nowrap>�ӳ�����</td>
			<td> <%=getDBStr(list.get(36))%>  </td>
		 	<td scope="row" nowrap>��������</td>
		    <td colspan=""> <%=getDBStr(list.get(37))%> </td>
		    <td scope="row" nowrap>��Ϣ��ʽ</td>
		    <td colspan="">
		    	<select name="ajdustStyle" disabled="disabled">
		        <script>
		        	var ajdustStyle = <%=list.get(39)%>;//������,������,������,������,ƽϢ��
		        	if(ajdustStyle != null && ajdustStyle != ''){
			        	w(mSetOpt('<%=list.get(39)%>',"������|������|������|������|ƽϢ��","0|1|2|3|4"));
		        	}else{
			        	w(mSetOpt('0',"������|������|������|������|ƽϢ��","0|1|2|3|4"));
		        	}
		        </script>
		        </select> 
			</td>
		</tr>
		<% 
			//��2011-04-13��������������ʱ������޸ĳ������ڡ�
			//�����������ʱ���������� 2011-03-02
			//String measure_type = list.get(22);
			//if(!"0".equals(measure_type)){
		%>		
		<tr>
			<td colspan="8" align="right" nowrap>
				<BUTTON class="btn_2" name="btnSave" value="������" type="submit">
				<img src="../../images/save.gif" align="absmiddle" border="0">������</button>
			 </td>
			 
		  </tr>
		<% 
			//}
		%>		
		<% 		
		}else{
		%>
		  <tr>
			<td scope="row" nowrap >û�иú�ͬ���׽ṹ����ϸ����!</td>
		  </tr>
			
		<% 		
		}
		db.close();
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
