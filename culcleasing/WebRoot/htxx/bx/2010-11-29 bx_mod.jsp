<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʲ����� - ���չ���</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>


<form name="form1" enctype="multipart/form-data" method="post" action="bx_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ʲ�����&gt; �����޸�
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">�ر�</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="����"> ����</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="����"> ����</a>
    	
    	<input class="btn" name="btnSave" value="����" type="submit">
    	<input class="btn" name="btnReset" value="����" type="reset">
    	-->
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script> 
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
	String czid = getStr( request.getParameter("id") );
	String sqlstr = "select * from contract_insurance left join contract_info on contract_insurance.contract_id=contract_info.contract_id where id='"+czid+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
    String cust_id="";
	
	
	String colleaction_date="";
	String insurance_type="";
	String payments="";
	String pay_date="";
	String buy_insuranceself="";
	String period_insurance="";
	String insurance_id="";
	String contract_id="";
	String insurance_my="";
	String insured_amount="";
	
	String insurance_company="";
	String insured="";
        String b_insured="";
        String insurance_coverage="";
	String price_coverage="";
	String price_appraisal="";
	String assessment_company="";
        String production_date="";
	String total_insurance="";
	String deductible_accident="";
	String premium_rate="";
	String general_insurance="";
	String jurisdiction="";
	String beneficiaries="";
	String memo="";
	String attachment="";
	
	if(rs.next()){
	 insurance_my=getDBStr(rs.getString("insurance_my"));
	    contract_id=getDBStr(rs.getString("contract_id"));
	    insurance_id=getDBStr(rs.getString("insurance_id"));
		buy_insuranceself=getDBStr(rs.getString("buy_insuranceself"));
		period_insurance=getDBStr(rs.getString("period_insurance"));
		colleaction_date=getDBStr(rs.getString("colleaction_date"));
	    insurance_type=getDBStr(rs.getString("insurance_type"));
	    System.out.println("insurance_type=**"+insurance_type);
	    pay_date=getDBStr(rs.getString("pay_date"));
	    payments=getDBStr(rs.getString("payments"));
		insured_amount=getDBStr(rs.getString("insured_amount"));
		
		insurance_company=getDBStr(rs.getString("insurance_company"));
	  insured=getDBStr(rs.getString("insured"));
	  b_insured=getDBStr(rs.getString("b_insured"));
	  insurance_coverage=getDBStr(rs.getString("insurance_coverage"));
	  price_coverage=getDBStr(rs.getString("price_coverage"));
	  price_appraisal=getDBStr(rs.getString("price_appraisal"));
	  assessment_company=getDBStr(rs.getString("assessment_company"));
	 //production_date=getDBStr(rs.getString("production_date"));
	  production_date=getDBStr(rs.getString("production_date"));
	  total_insurance=getDBStr(rs.getString("total_insurance"));
	  deductible_accident=getDBStr(rs.getString("deductible_accident"));
	  premium_rate=getDBStr(rs.getString("premium_rate"));
	  general_insurance=getDBStr(rs.getString("general_insurance"));
	  jurisdiction=getDBStr(rs.getString("jurisdiction"));
	  beneficiaries=getDBStr(rs.getString("beneficiaries"));
	  memo=getDBStr(rs.getString("memo"));
	  attachment=getDBStr(rs.getString("attachment"));
	}
	rs.close(); 
	db.close();
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%= czid %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
   <tr>
    <td scope="row" width="130px">��ͬ��ţ�</td>
    <td><input class="text" name="contract_id" type="text" size="30" readonly value="<%=contract_id %>"></td>
     <td width="130px">�Ƿ���˾�����գ�</td>
    <td>
    <input name="insurance_my" type="radio" value="��" checked="checked">
												��
													<input name="insurance_my" type="radio" value="��">
											��
    </td>
  </tr>
  
   <tr>
     	<td>�������ͣ�</td>
    	<td><input class="text"  name="insurance_type" type="text" size="30"  value="<%=insurance_type%>" maxB="30" ></td>
     	<td>���չ�˾��</td>
     <td><input class="text"  name="insurance_company" type="text" size="50"  value="<%=insurance_company%>" maxB="50" ></td>
     	</tr>
   	 <tr>
     	<td>���յ��ţ�</td>
	<td><input class="text"  name="insurance_id" type="text" size="30"  value="<%=insurance_id%>"  maxB="20" Require="true"><span class="biTian">*</span></td>
     	<td>Ͷ���ˣ�</td>
     <td><input class="text"  name="insured" type="text" size="50"  value="<%=insured%>" maxB="50" ></td>
     	</tr>
     	
     		
     	 <tr>
     	<td>�������ˣ�</td>
	<td><input class="text"  name="b_insured" type="text" size="30"  value="<%=b_insured%>"  maxB="30" ></td>
      <td>�������ޣ�</td>
	<td><input class="text"  name="period_insurance" type="text" size="30"  value="<%=period_insurance%>" maxB="30" Require="true" dataType="Number"><span class="biTian">*</span></td>
     	</tr>
     	
     	 <tr>
     	<td>������Ŀ��</td>
	<td><input class="text"  name="insurance_coverage" type="text" size="30"  value="<%=insurance_coverage%>"  maxB="30" ></td>
      <td>������Ŀԭ�ۣ�</td>
	<td><input class="text"  name="price_coverage" type="text" size="30"  value="<%=formatNumberDoubleTwo(price_coverage)%>" maxB="30"  dataType="Money"></td>
     	</tr>
     	
     		 <tr>
     	<td>������Ŀ�����ۣ�</td>
	<td><input class="text"  name="price_appraisal" type="text" size="30"  value="<%=formatNumberDoubleTwo(price_appraisal)%>"  maxB="30" dataType="Money"></td>
      <td>������Ŀ������˾��</td>
	<td><input class="text"  name="assessment_company" type="text" size="30"  value="<%=assessment_company%>" maxB="30"  ></td>
     	</tr>
     	
     		 <tr>
     	<td>������Ŀ�������ڣ�</td>
	<td><input class="text" name="production_date" type="text" size="30" readonly Require="true" value="<%=getDBDateStr(production_date)%>">
	<img onClick="openCalendar(production_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 </td>
     <td width="130px">���ս�</td>
	<td><input class="text"  name="payments" type="text" size="30"  value="<%=formatNumberDoubleTwo(payments)%>" dataType="Money" Require="true"><span class="biTian">*</span></td>
     	</tr>
     	
     	 <tr>
     	<td>�ܱ��ս�</td>
	<td><input class="text"  name="total_insurance" type="text" size="30"  value="<%=formatNumberDoubleTwo(total_insurance)%>"  maxB="30" dataType="Money"></td>
      <td>ÿ���¹�����</td>
	<td><input class="text"  name="deductible_accident" type="text" size="30"  value="<%=formatNumberDoubleTwo(deductible_accident)%>" maxB="30"  ></td>
     	</tr>
	 <tr>
     	<td>���շ��ʣ�</td>
	<td><input class="text"  name="premium_rate" type="text" size="30"  value="<%=formatNumberDoubleTwo(premium_rate)%>"  maxB="30" dataType="Money"></td>
      <td>�ܱ��շѣ�</td>
	<td><input class="text"  name="general_insurance" type="text" size="30"  value="<%=formatNumberDoubleTwo(general_insurance)%>" maxB="30"  ></td>
     	</tr>
     	 <tr>
     	<td>�������ڣ�</td>
	<td><input class="text" name="pay_date" type="text" size="30" readonly  Require="true" value="<%=getDBDateStr(pay_date)%>">
	<img onClick="openCalendar(pay_date);return false;" style="cursor:pointer; " src="../../images/fdmo_63.gif" border="0" align="absmiddle"><span class="biTian">*</span>
 </td>
      <td>˾����Ͻ��</td>
	<td><input class="text"  name="jurisdiction" type="text" size="30"  value="<%=jurisdiction%>" maxB="30"  ></td>
     	</tr>
    <tr>
     	<td>�����ˣ�</td>
	<td><input class="text"  name="beneficiaries" type="text" size="30"  value="<%=beneficiaries%>"  maxB="30" ></td>
      <td>��ע��</td>
	<td><input class="text"  name="memo" type="text" size="30"  value="<%=memo%>" maxB="30"  ></td>
     	</tr>
    <tr>
    <td scope="row" nowrap>������</td>
	<%if(!attachment.equals("")){%>
    <td><%= attachment %><input type="submit" value="ɾ��" onclick="form1.fj_del.value=1;"><input type="hidden" name="fj_del"></td>
	<%}else{%>
	<td><table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End �ϴ���� --><span class="biTian">�����ϴ����ļ�����.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
	<%}%>
  </tr>
</table>

</div>


</div>

</form>

<!-- end cwMain -->
</body>
</html>


