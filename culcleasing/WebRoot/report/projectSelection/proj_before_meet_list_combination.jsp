<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�Ǳ��ǰ�ͻ���Ϣͳ�Ʊ��ϲ��� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">


</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="proj_before_meet_list_combination.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		�Ǳ��ǰ�ͻ���Ϣͳ�Ʊ��ϲ���</td>
	</tr>
</table> 

<%
wherestr = "";
String sqlstrCou="";
String proj_name = getStr( request.getParameter("proj_name") );
String cust_name = getStr( request.getParameter("cust_name") );
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

if ( cust_name!=null && !cust_name.equals("") ) {
	wherestr += " and cust_name like '%" + cust_name + "%'";
}
if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}

if(lease_term!=null && !lease_term.equals("")){
	wherestr +=" and lease_term = '" + lease_term + "'";
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




//2013-08-02������ѯ����
countSql = "select count(proj_id) as amount from vi_report_cust_before_meet_info_comb where 1=1 "+wherestr;

//��������2--���ݵ���

	String expsqlstr = "select proj_id as '��Ŀ���' "
	+" , begin_id as '������' ,cust_name as '�ͻ�����'"
	+" , project_name as '��Ŀ����' ,parent_deptname as '��Ŀ����'"
	+" , dept_name as '����' ,proj_manage_name as '��Ŀ����'"
	+" , industry_type_name as '��Ŀ��ҵ' ,cast(round(medical_revenue,2) as numeric(20,2))  as 'ҽ��ҩƷ����'"
	+" , '' as '����Ԥ������' ,leas_type as '��������'"
	+" ,cast(round(year_rate,2) as numeric(5,2))  as '��������',irr as '�ڲ�����IRR' "
	+" ,StandardIrr as '���IRR', approve_date as 'ǩԼ����',equip_amt as '�����ʲ���ֵ'"
	+" , cast(round(current_equip_amt,2) as numeric(20,2)) as '�������ʲ���ֵ', rent_dq as ������ ,jjzc as �Ӽ���  "
	+" ,caution_money_ratio as '��֤����',not_income_corpus as 'δ������' "
	+" ,case when ifchange IS null then '��' else '��' end '�Ƿ�����',yhqs as '�ѻ��������' "
	+" from vi_report_cust_before_meet_info_comb "
	+"left join (select distinct project_id ifchange from SYS_flow_list where flow_name like '%���%' union select distinct  project_id ifchange from CulcLeasingTJ.dbo.SYS_flow_list) as sfl  "
	+"on sfl.ifchange = proj_id where 1=1 "+ wherestr+" order by proj_id";
	

String updSql="select proj_id,contract_id from vi_report_cust_before_meet_info_comb where 1=1 "+ wherestr;

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
<td>�ͻ����ƣ�&nbsp;<input name="cust_name"  type="text" size="15" value="<%=cust_name %>"></td>
<td>��&nbsp;&nbsp;ҵ��
 <select name="industry_type_name" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=industry_type_name %>',"|ҽ����ҵ|����|����|����|ͨ��|ҽ�ƹ���","|ҽ����ҵ|����|����|����|ͨ��|ҽ�ƹ���"));
    </script>
 </select>
</td>


</tr>
<tr>
<td>ҽ��ҩƷ���룺
 ����<input style="width:116px;" name="medical_revenue_start" id="medical_revenue_start" type="text" value="<%=medical_revenue_start%>">
 С��<input style="width:116px;" name="medical_revenue_end" id="medical_revenue_end" type="text" value="<%=medical_revenue_end%>">
</td>
<td>�������ͣ�
 <select name="leas_type" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=leas_type %>',"|��������|�ۺ������","|��������|�ۺ������"));
    </script>
 </select>
</td>


</tr>
<tr>




</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td align="right"> 
<input type="button" value="��ѯ" onclick="dataNav.submit();">
<input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->
<!--���۵���ѯ��ʼ-->

<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		
		<td>
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="ProjBeforeMeeting">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','proj_before_meet_list_combination.jsp');">
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
	  <th align="center"></th> 
	    <th>��Ŀ���</th>
	    <th>������</th>
	    <th>�ͻ�����</th>
	    <th>��Ŀ����</th>
	 	<th>��Ŀ����</th>
	 	<th>����</th>
		<th>��Ŀ����</th>
	 	<th>��Ŀ��ҵ</th>
		<th>ҽ��ҩƷ����</th>
		<th>����Ԥ������</th>
	 	<th>��������</th>
	 	<th>��������</th>
	 	<th>�ڲ�����IRR</th>
		<th>���IRR</th>
		<th>ǩԼ����</th>

		<th>�����ʲ���ֵ</th>
		<th>�������ʲ���ֵ</th>
		<th>������</th>
		<th>�Ӽ���</th>
		<th>��֤����</th>
	 	
	 	
     	<th>δ������</th>
     	<th>�Ƿ�����</th>
		<th>�ѻ��������</th>


      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_report_cust_before_meet_info_comb "+
         "left join (select distinct  project_id ifchange from SYS_flow_list  where flow_name like '%���%' union "+
         " select distinct  project_id ifchange from CulcLeasingTJ.dbo.SYS_flow_list  where flow_name like '%���%' "+
         ") sfl on sfl.ifchange = proj_id "+ 
         "where proj_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_report_cust_before_meet_info_comb where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstr +=" order by proj_id";





rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td></td>
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left">
        <a href="proj_before_meet_main_comb.jsp?cust_id=<%=getDBStr( rs.getString("cust_id") )  %>" target="_blank"><%=getDBStr( rs.getString("cust_name") )  %></a>
        </td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
		<td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("industry_type_name"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("medical_revenue"))%></td>
		<td align="left"></td>
		<td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("year_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("irr"))%></td>
		<td align="left"><%=getDBStr(rs.getString("StandardIrr"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("approve_date"))%></td>
		
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("current_equip_amt"))%></td>
		
	    <td align="left"><%=getDBStr(rs.getString("rent_dq"))%></td>
	    <td align="left"><%=getDBStr(rs.getString("jjzc"))%></td>
	    <td align="left"> <%=getDBStr(rs.getString("caution_money_ratio"))%></td>
		
        <td align="left"><%=CurrencyUtil.convertFinance(getDBStr(rs.getString("not_income_corpus")))%></td>
        
        <td align="left"><%=getDBStr(rs.getString("ifchange")==null?"��":"��")%></td>
		<td align="left"><%=getDBStr(rs.getString("yhqs"))%></td>
      </tr>
<%}
sqlstrCou = "select sum(vv.equip_amt) equip_amt,SUM(vv.current_equip_amt) current_equip_amt,SUM(vv.not_income_corpus) not_income_corpus from (";
sqlstrCou += "select top "+ intPageSize +"  equip_amt,current_equip_amt ,not_income_corpus from vi_report_cust_before_meet_info_comb "+
"left join (select distinct  project_id ifchange from SYS_flow_list  where flow_name like '%���%' union select distinct  project_id ifchange from CulcLeasingTJ.dbo.SYS_flow_list  where flow_name like '%���%') sfl on sfl.ifchange = proj_id "+ 
"where proj_id not in( ";
sqlstrCou += " select top "+ (intPage-1)*intPageSize +" proj_id from vi_report_cust_before_meet_info where 1=1 "+wherestr+" order by proj_id ) "+wherestr ;
sqlstrCou +=" order by proj_id";
sqlstrCou +=" ) vv";
rs = db.executeQuery(sqlstrCou);

	while ( rs.next() ) {
				index_no++;	
			%>
		 <tr class="materTr_<%=index_no %>"  bgcolor="#FF0000">
		<td></td>
        <td align="left">�ܼƣ�</td>
        <td align="left"></td>
        <td align="left"></td>
        <td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
	    <td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left">�ܼƣ�<%=CurrencyUtil.convertFinance(rs.getString("equip_amt"))%></td>
		<td align="left">�ܼƣ�<%=CurrencyUtil.convertFinance(rs.getString("current_equip_amt"))%></td>
	    <td align="left"></td>
	    <td align="left"></td>
	    <td align="left"></td>
        <td align="left">�ܼƣ�<%=CurrencyUtil.convertFinance(rs.getString("not_income_corpus"))%></td>
        <td align="left"></td>
		<td align="left"></td>
      </tr>	
			<%
	}		
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
