<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ���� ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="financing_drawings_interest.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��Ϣ���ñ�
		</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = " ";

//��ҳ��ѯ����
/* String drawings_date_start = getStr( request.getParameter("drawings_date_start") ); */
String drawings_date_end = getStr( request.getParameter("drawings_date_end") );
if(drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date <='"+drawings_date_end+"'";
}
/* if(drawings_date_start!=null && !"".equals(drawings_date_start) && drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date >= '"+drawings_date_start+"' and drawings_date<='"+drawings_date_end+"'";
}
if(drawings_date_start!=null && !"".equals(drawings_date_start) && "".equals(drawings_date_end)){
	wherestr +=" and drawings_date >= '"+drawings_date_start+"'";
}
if("".equals(drawings_date_start) && drawings_date_end!=null && !"".equals(drawings_date_end)){
	wherestr +=" and drawings_date <='"+drawings_date_end+"'";
} */

countSql = "select count(id) as amount from vi_financing_drawings_detail where 1=1 "+wherestr;
String expsqlstr = "select drawings_id as '�����',crediter as '���ŵ�λ',drawings_type as '��������',drawings_money as '����ԭ�ң�',currency as '����',drawings_date as '�������',drawings_end_date as '�������',drawings_time_limit as '��������',factorage_money as '�����ѣ��ܺͣ�',drawings_rate_para1 as '��ͬ���ʸ���',drawings_rate_float as '��ͬ���ʸ���',isnull(current_foreign_rate,0) as 'ԭʼ����',isnull(drawings_fact_rate,0) as '��ǰ����',refund_way as '���𳥻���ʽ',rebated_type as '��Ϣ֧����ʽ',drawings_rate_float_type as '��Ϣ��ʽ',loan_category as '�������',pawn_condition as '��Ѻ���',assurer_condition as '�������',abroad_domestic as '���������',withholding_tax as '����˰�����',withholding_tax_rate as '����˰��˰��',table_type as '���������',drawings_rate_type as '��������',drawings_time_type as '��������',financing_method as '���ʷ�ʽ' from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ";
%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td scope="row">��ѯʱ�䣺
<%-- ����<input type="text" id="drawings_date_start" name="drawings_date_start"
	 readonly="readonly" 
	 value="<%=drawings_date_start %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> --%>
 <input type="text" id="drawings_date_end" name="drawings_date_end"
	 readonly="readonly" 
	value="<%=drawings_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="excel_name" type="hidden" value="financing_drawings_interest">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','financing_drawings_interest.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
	    <!--������ť����-->
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	<th>��ѯʱ��</th>
	    <th>�����</th>
		<th>���ŵ�λ</th>
		<!-- <th>��������</th> -->
		<th>����ԭ�ң�</th>
        <th>����</th>
        
        <th>�������</th>
        <th>�������</th>
        <!-- <th>��������</th>
        <th>�����ѣ��ܺͣ�</th>   
        <th>��ͬ���ʻ�׼</th>
        
        <th>��ͬ��������</th>
        <th>ԭʼ����</th>
        <th>��ǰ����</th>
        <th>���𳥻���ʽ</th>   
        <th>��Ϣ֧����ʽ</th>
        
        <th>��Ϣ��ʽ</th> -->
        <!-- <th>�ѻ�����ԭ�ң�</th>
        <th>ʣ�౾��ԭ�ң�</th> -->
        <!-- th>��������</th>   
        <th>��Ѻ���</th>
        
        <th>�������</th> -->
        <th>���������</th>
        <th>����˰�����</th>
        <th>����˰��˰��</th>   
        <!-- <th>���������</th>
        
        <th>��������</th>
        <th>��������</th>   
        <th>���ʷ�ʽ</th> -->
         
      </tr>
      <tbody id="data">
<%
String col_str=" * ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_drawings_detail where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ) "+wherestr ;
sqlstr += " order by crediter,id ";

rs = db.executeQuery(sqlstr);

while ( rs.next() ) {
%>
      <tr>
      	<td align="center"><%=drawings_date_end %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td> --%>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("drawings_money" )) %></td>
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		
		<td align="center"><%=getDBDateStr( rs.getString("drawings_date")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("drawings_end_date")) %></td>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_time_limit")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("factorage_money" )) %></td>	
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_para1")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_float")) %></td>
		<td align="center"><%=getDBStr( rs.getString("current_foreign_rate")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_fact_rate")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("refund_way")) %></td>
        <td align="center"><%=getDBStr( rs.getString("rebated_type")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_float_type")) %></td> --%>
		<%-- <td align="center"><%=getDBStr( rs.getString("drawings_refund_corpus")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_left_corpus")) %></td> --%>	
        <%-- <td align="center"><%=getDBStr( rs.getString("loan_category")) %></td>
        <td align="center"><%=getDBStr( rs.getString("pawn_condition")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("assurer_condition")) %></td> --%>
		<td align="center"><%=getDBStr( rs.getString("Abroad_domestic")) %></td>
		<td align="center"><%=getDBStr( rs.getString("Withholding_tax")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("Withholding_tax_rate")) %></td>
        <%-- <td align="center"><%=getDBStr( rs.getString("Table_type")) %></td>
        
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_type")) %></td>	
        <td align="center"><%=getDBStr( rs.getString("drawings_time_type")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Financing_Method")) %></td> --%>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
</body>
</html>
