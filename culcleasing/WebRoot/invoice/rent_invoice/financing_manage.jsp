<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="financing_manage.jsp" name="dataNav" onSubmit="return goPage()" method="post">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		</td>
	</tr>
</table> 

<%
wherestr = "";

String industry_type_name = getStr( request.getParameter("industry_type_name") );
String start_medical_revenue = getStr( request.getParameter("start_medical_revenue") );
String end_medical_revenue = getStr( request.getParameter("end_medical_revenue") );
String bank_name = getStr( request.getParameter("bank_name") );
String qualification_grade = getStr( request.getParameter("qualification_grade") );

if ( industry_type_name!=null && !industry_type_name.equals("") ) {
	wherestr += " and industry_type_name like '%" + industry_type_name + "%'";
}
if ( start_medical_revenue!=null && !start_medical_revenue.equals("") ) {
	wherestr += " and medical_revenue >="+start_medical_revenue;
}
if ( end_medical_revenue!=null && !end_medical_revenue.equals("") ) {
	wherestr += " and medical_revenue <="+end_medical_revenue;
}
if ( bank_name!=null && !bank_name.equals("") ) {
	wherestr += " and bank like '%"+bank_name+"%";
}
if ( qualification_grade!=null && !qualification_grade.equals("") ) {
	wherestr += " and qualification_grade like '%"+qualification_grade+"%'";
}


countSql = "select count(proj_id) as amount from vi_fina_detail where 1=1 "+wherestr;

//��������2--���ݵ���
%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��ҵ:&nbsp;
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|ҽ����ҵ|����|����|��е|����|ҽ�ƹ���","|ҽ����ҵ|����|����|��е|����|ҽ�ƹ���"));
    </script>
 </select>
</td>
<td>���ʵȼ�:&nbsp;<input name="qualification_grade"  type="text" size="15" value="<%=qualification_grade %>"></td>
<td>ҽ��ҩƷ����:&nbsp;<input name="start_medical_revenue" type="text" size="15" dataType="Money" value="<%=start_medical_revenue %>">
&nbsp;��&nbsp;<input name="end_medical_revenue" type="text" size="15" dataType="Money" value="<%=end_medical_revenue %>">
</td>
<td>����:
<input name="bank_name"  type="text" size="15" value="<%=bank_name %>">
</td>
<td> <input type="button" value="��ѯ" onclick="dataNav.submit();">
<input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->
<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">

		<td align="left" width="10%">
		<!--������ť��ʼ-->
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
	    <!--������ť����-->
	    </td>

		<!-- ��ҳ���� -->
		<td align="right" width="40%"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>��Ŀ����</th>
	    <th>����</th>
		<th>δ�������</th>
	    <th>δ���ձ���</th>
     	<th>���ڴ���</th>
 		<th>��������</th>																								
		<th>��Ŀ����</th>
	 	<th>��Ŀ����</th>
	 	<th>��Ŀ��ҵ</th>
	 	<th>ҽ��ҩƷ����</th>
	 	<th>ҽԺ�ȼ���ģ</th>
	 	<th>��������</th>
	 	<th>��������</th>
	 	<th>�����㷽ʽ</th>
	 	<th>�ڲ�����IRR</th>
	 	<th>���IRR</th>
		<th>ǩԼ����</th>
		<th>������</th>
		<th>�����ʲ���ֵ</th>
		<th>���޳ɱ�</th>
		<th>���������޳ɱ�</th>
		<th>ʵ���ʽ�֧��</th>
		<th>����ܶ�</th>
		<th>�����</th>
		<th>���޷����</th>
		<th>��֤��</th>
		<th>��֤�����</th>
		<th>�׸���</th>
		<th>�׸������</th>
		<th>�ͻ�����</th>
		<th>�ͻ����ʵȼ�</th>
		<th>�ͻ���ҵС��</th>
		<th>ĩ������</th>
		<th>ʣ������</th>
      </tr>
   <tbody id="data">
<%
String expsqlstr = "select project_name ��Ŀ����,bank as ����,not_income_rent δ�������, not_income_corpus δ���ձ���,penalty_num ���ڴ���,penalty_day_amount as ��������,proj_manage_name as ��Ŀ����,dept_name ��Ŀ����,industry_type_name ��Ŀ��ҵ,medical_revenue ҽ��ҩƷ����,hospital_scale_level ҽԺ�ȼ���ģ,leas_type ��������,leas_year ��������,settle_method �����㷽ʽ,irr �ڲ�����IRR,StandardIrr ���IRR,approve_date ǩԼ����,rent_start_date ������,equip_amt as �����ʲ���ֵ from vi_fina_detail where 1=1 "+wherestr;

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fina_detail where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_fina_detail where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id ";
System.out.println("ccccccccc"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>   
     <tr>
    
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><input name="bank_str"  type="text" size="20" value="<%=getDBStr(rs.getString("bank")) %>"></td>
		<td align="left"><%=getDBStr(rs.getString("not_income_rent"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_corpus"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_num"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_day_amount"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("medical_revenue"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hospital_scale_level"))%></td>		
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td> 
		<td align="left"><%=getDBStr(rs.getString("leas_year"))%></td>
		<td align="left"><%=getDBStr(rs.getString("settle_method"))%></td>

		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("StandardIrr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("yqz_lease_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fact_fund_pay"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("sum_rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("management_fee"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("handling_charge"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("caution_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("caution_money_ratio"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("first_payment"))%></td>

		<td align="left"><%=getDBStr(rs.getString("first_payment_ratio"))%></td>
		<td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("qualification_grade"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hyxlmc"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("end_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("syqx"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
