<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ŀɸѡ�� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//�ύ��������״̬
	function updMaterStatus(){
		var bank_str1 = document.getElementById("bank_str1").value;
			if(null==bank_str1||''==bank_str1)
			{
			alert("�����в���Ϊ�գ�");
			return false;
			}
			dataNav.action="bank_save.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="proj_selection_list.jsp";
			dataNav.target="_self"
	}

	//�Ƿ�ȫѡ
function SelectAll(){
	var checkboxs=document.getElementsByName("list");
	var all=document.getElementsByName("all");
	all.checked=!all.checked;
	for (var i=0;i<checkboxs.length;i++) {
	var e=checkboxs[i];
	e.checked=!e.checked;
 }
	}
	</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="proj_selection_list.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		������Ŀɸѡ��</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String bank = getStr( request.getParameter("bank") );
String bank_str = getStr( request.getParameter("bank_str") );
String lease_term = getStr( request.getParameter("lease_term") );
String qualification_grade = getStr( request.getParameter("qualification_grade") );
String medical_revenue_start =getStr(request.getParameter("medical_revenue_start"));
String medical_revenue_end =getStr(request.getParameter("medical_revenue_end"));
String leas_type=getStr(request.getParameter("leas_type"));
String industry_type_name=getStr(request.getParameter("industry_type_name"));

String not_income_rent_start =getStr(request.getParameter("not_income_rent_start"));
String not_income_rent_end =getStr(request.getParameter("not_income_rent_end"));

String penalty_num_start =getStr(request.getParameter("penalty_num_start"));
String penalty_num_end =getStr(request.getParameter("penalty_num_end"));

String penalty_day_amount_start =getStr(request.getParameter("penalty_day_amount_start"));
String penalty_day_amount_end =getStr(request.getParameter("penalty_day_amount_end"));

String syqx_start =getStr(request.getParameter("syqx_start"));
String syqx_end =getStr(request.getParameter("syqx_end"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( bank!=null && !bank.equals("") ) {
	wherestr += " and bank like '%" + bank + "%'";
}
if(bank_str!=null && !bank_str.equals("")){
	wherestr +=" and bank_str like '%" + bank_str + "%'";
}
if(lease_term!=null && !lease_term.equals("")){
	wherestr +=" and lease_term = '" + lease_term + "'";
}
if(qualification_grade!=null && !qualification_grade.equals("")){
	wherestr +=" and qualification_grade = '" + qualification_grade + "'";
}
if(leas_type!=null && !leas_type.equals("")){
	wherestr +=" and leas_type = '" + leas_type + "'";
}
if(industry_type_name!=null && !industry_type_name.equals("")){
	wherestr +=" and industry_type_name = '" + industry_type_name + "'";
}

if(medical_revenue_start!=null && !"".equals(medical_revenue_start) && medical_revenue_end!=null && !"".equals(medical_revenue_end)){
	wherestr +=" and medical_revenue>= '"+medical_revenue_start+"' and medical_revenue<='"+medical_revenue_end+"'";
}
if(not_income_rent_start!=null && !"".equals(not_income_rent_start) && not_income_rent_end!=null && !"".equals(not_income_rent_end)){
	wherestr +=" and not_income_rent>= '"+not_income_rent_start+"' and not_income_rent<='"+not_income_rent_end+"'";
}
if(penalty_num_start!=null && !"".equals(penalty_num_start) && penalty_num_end!=null && !"".equals(penalty_num_end)){
	wherestr +=" and penalty_num>= '"+penalty_num_start+"' and penalty_num<='"+penalty_num_end+"'";
}
if(penalty_day_amount_start!=null && !"".equals(penalty_day_amount_start) && penalty_day_amount_end!=null && !"".equals(penalty_day_amount_end)){
	wherestr +=" and penalty_day_amount>= '"+penalty_day_amount_start+"' and penalty_day_amount<='"+penalty_day_amount_end+"'";
}
if(syqx_start!=null && !"".equals(syqx_start) && syqx_end!=null && !"".equals(syqx_end)){
	wherestr +=" and syqx>= '"+syqx_start+"' and syqx<='"+syqx_end+"'";
}
countSql = "select count(proj_id) as amount from vi_fina_detail where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select project_name ��Ŀ����,bank �걨����, bank_str ������,not_income_rent δ�������,not_income_corpus δ���ձ���,"+
"penalty_num ���ڴ���,penalty_day_amount ��������,proj_manage_name ��Ŀ����,parent_deptname ��Ŀ����,dept_name ����,"+								"industry_type_name ��Ŀ��ҵ,medical_revenue ҽ��ҩƷ����,hospital_scale_level ҽԺ�ȼ���ģ,leas_type ��������,lease_term ��������,"+
"settle_method �����㷽ʽ,irr �ڲ�����IRR,StandardIrr ���IRR,approve_date ǩԼ����,rent_start_date ������,equip_amt �����ʲ���ֵ,"+
"lease_money ���޳ɱ�,yqz_lease_money ���������޳ɱ�,fact_fund_pay ʵ���ʽ�֧��,sum_rent ����ܶ�,management_fee �����,"+
"handling_charge ���޷����,caution_money ��֤��,caution_money_ratio ��֤�����,first_payment �׸���,first_payment_ratio �׸������,"+
"cust_name �ͻ�����,qualification_grade �ͻ����ʵȼ�,hyxlmc �ͻ���ҵС��,end_date ĩ������,syqx ʣ������ from vi_fina_detail where 1=1 "+wherestr;
String updSql="select proj_id,contract_id from vi_fina_detail where 1=1 "+wherestr;
%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ���ƣ�&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>��&nbsp;&nbsp;ҵ��
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|ҽ����ҵ|����|����|����|ͨ��|ҽ�ƹ���","|ҽ����ҵ|����|����|����|ͨ��|ҽ�ƹ���"));
    </script>
 </select>
</td>
<td>���ʵȼ���
 <select name="qualification_grade" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=qualification_grade %>',"|����|����|����|����|����","|����|����|����|����|����"));
    </script>
 </select>
</td>
<td>ҽ��ҩƷ���룺
 ����<input style="width:116px;" name="medical_revenue_start" id="medical_revenue_start" type="text" value="<%=medical_revenue_start%>">
 С��<input style="width:116px;" name="medical_revenue_end" id="medical_revenue_end" type="text" value="<%=medical_revenue_end%>">
</td>
</tr>
<tr>
<td>��&nbsp;&nbsp;&nbsp;&nbsp;�У�&nbsp;<input name="bank"  type="text" size="15" value="<%=bank %>"></td>
<td>�����У�&nbsp;<input name="bank_str"  type="text" size="15" value="<%=bank_str %>"></td>
<td>�������ͣ�
 <select name="leas_type" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=leas_type %>',"|��������|�ۺ������","|��������|�ۺ������"));
    </script>
 </select>
</td>
<td>δ�������
 ����<input style="width:116px;" name="not_income_rent_start" id="medical_revenue_start" type="text" value="<%=not_income_rent_start%>">
 С��<input style="width:116px;" name="not_income_rent_end" id="medical_revenue_end" type="text" value="<%=not_income_rent_end%>">
</td>

</tr>
<tr>
<td>�������ޣ�&nbsp;<input name="lease_term"  type="text" size="15" value="<%=lease_term %>"></td>
<td>���ڴ�����
 ����<input style="width:116px;" name="penalty_num_start" id="medical_revenue_start" type="text" value="<%=penalty_num_start%>">
 С��<input style="width:116px;" name="penalty_num_end" id="medical_revenue_end" type="text" value="<%=penalty_num_end%>">
</td>
<td>����������
 ����<input style="width:116px;" name="penalty_day_amount_start" id="medical_revenue_start" type="text" value="<%=penalty_day_amount_start%>">
 С��<input style="width:116px;" name="penalty_day_amount_end" id="medical_revenue_end" type="text" value="<%=penalty_day_amount_end%>">
</td>

<td>ʣ�����ޣ�
 ����<input style="width:116px;" name="syqx_start" id="medical_revenue_start" type="text" value="<%=syqx_start%>">
 С��<input style="width:116px;" name="syqx_end" id="medical_revenue_end" type="text" value="<%=syqx_end%>">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td align="right"> <input type="button" value="��ѯ" onclick="dataNav.submit();">
<input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->
<!--���۵���ѯ��ʼ-->
	<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;�����޸�
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	
	<td scope="row" id="bj_4">�����޸������У�&nbsp;<input name="bank_str1" id="bank_str1" type="text" size="100">
			
	<input type="button" value="ȷ��" onclick="return updMaterStatus();">
	&nbsp;&nbsp;
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
		
		<td>
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="RentInvoice">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','insur_pay.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
	    <!--������ť����-->
	    </td>		

		<!-- ��ҳ���� -->
		<td width="60%" align="right"><!--��ҳ���ƿ�ʼ-->
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
	  <th align="center"><input type="checkbox" name="all" id="all" style="border:0px;" onclick="SelectAll()">ȫ/��ѡ</th> 
	    <th>��Ŀ����</th>
	    <th>�걨����</th>
		<th>������</th>
	    <th>δ�������</th>
     	<th>δ���ձ���</th>
 		<th>���ڴ���</th>
 		
		<th>��������</th>
		<th>��Ŀ����</th>
	 	<th>��Ŀ����</th>
	 	<th>����</th>
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

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fina_detail where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_fina_detail where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("contract_id"))%>"></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("bank"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_str"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_rent"))%></td>
        <td align="left"><%=getDBStr(rs.getString("not_income_corpus"))%></td>
        <td align="left"><%=getDBStr(rs.getString("penalty_num"))%></td>

        <td align="left"><%=getDBStr(rs.getString("penalty_day_amount"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("medical_revenue"))%></td>
		<td align="left"><%=getDBStr(rs.getString("hospital_scale_level"))%></td>	
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("lease_term"))%></td>
		<td align="left"><%=getDBStr(rs.getString("settle_method"))%></td>
		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("StandardIrr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("rent_start_date"))%></td>
		
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
	    <td align="left"><%=CurrencyUtil.convertFinance(rs.getString("lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("yqz_lease_money"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("fact_fund_pay"))%></td>
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
			System.out.println("test=========="+index_no);
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>
