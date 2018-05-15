<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>
<%@ page import="com.tenwa.culc.financing.util.FinancingReportUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ��ծ����ѯ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function onSumbit(){
	var dollar_currency_rate = document.getElementById("dollar_currency_rate").value;
	var hongKong_dollar_rate = document.getElementById("hongKong_dollar_rate").value;
	var rmb_rate = document.getElementById("rmb_rate").value;
	if(isNaN(dollar_currency_rate)){
		alert("��Ԫ���ʱ��������֣�");
		return false;
	}
	if(isNaN(hongKong_dollar_rate)){
		alert("��Ԫ���ʱ��������֣�");
		return false;
	}
	if(isNaN(rmb_rate)){
		alert("����һ��ʱ��������֣�");
		return false;
	} 
	dataNav.submit();
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="financing_drawings_liabilities.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��Ϣ��ծ����ѯ��
		</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = " ";

//��ҳ��ѯ����
String drawings_date_end = getStr( request.getParameter("drawings_date_end") );
if(drawings_date_end==null || "".equals(drawings_date_end)){
	drawings_date_end=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
}
String dollar_currency_rate = getStr( request.getParameter("dollar_currency_rate") );
double dollar_currency_rate_d =1d;
try{
	dollar_currency_rate_d = Double.valueOf(dollar_currency_rate).doubleValue();
}
catch(Exception e){
	dollar_currency_rate_d =1d;
}
String hongKong_dollar_rate = getStr( request.getParameter("hongKong_dollar_rate") );
double hongKong_dollar_rate_d =1d;
try{
	hongKong_dollar_rate_d = Double.valueOf(hongKong_dollar_rate).doubleValue();
}
catch(Exception e){
	hongKong_dollar_rate_d =1d;
}
String rmb_rate = getStr( request.getParameter("rmb_rate") );
double rmb_rate_d =1d;
try{
	rmb_rate_d = Double.valueOf(rmb_rate).doubleValue();
}
catch(Exception e){
	rmb_rate_d =1d;
}

String leftCorpusFlag = getStr( request.getParameter("leftCorpusFlag") );
if("��".equals(leftCorpusFlag)){
	wherestr +=" and drawings_id in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 )";
	wherestr +=" and drawings_date <= '"+drawings_date_end+"' ";
}//ʱ���ж�
if("��".equals(leftCorpusFlag)){
	wherestr +=" and ( drawings_id not in (select de.drawings_id from (select drawings_id ,isnull(SUM(refund_corpus),0) as sum_refund_corpus from financing_refund_plan where refund_plan_date > '"+drawings_date_end+"' group by drawings_id ) de where de.sum_refund_corpus <> 0 ) ";
	wherestr +=" or drawings_date > '"+drawings_date_end+"' ) ";
}

countSql = "select count(id) as amount from vi_financing_drawings_detail where 1=1 "+wherestr;
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
 <input type="text" id="drawings_date_end" name="drawings_date_end"
	 readonly="readonly" 
	value="<%=drawings_date_end %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
<td scope="row">
	��Ԫ���ʣ�<input type="text" id="dollar_currency_rate" name="dollar_currency_rate" value="<%=dollar_currency_rate %>" />
</td>
<td scope="row">
	��Ԫ���ʣ�<input type="text" id="hongKong_dollar_rate" name="hongKong_dollar_rate" value="<%=hongKong_dollar_rate %>" />
</td>
<td scope="row">
	����һ��ʣ�<input type="text" id="rmb_rate" name="rmb_rate" value="<%=rmb_rate %>" />
</td>
<td scope="row">ʣ�౾��ԭ�ң��Ƿ�Ϊ0��
		<select name="leftCorpusFlag" style="width: 116">
    	<script type="text/javascript">
     	w(mSetOpt('<%=leftCorpusFlag%>',"|��|��","|��|��"));
    	</script>
		 </select>
	</td>
<td>
<input type="button" value="��ѯ" onclick="onSumbit();">
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
		<input name="excel_name" type="hidden" value="financing_drawings_liabilities">
		<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_liabilities.jsp','financing_drawings_liabilities.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
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
      	<th>�������</th>
	    <th>�����</th>
		<th>���ŵ�λ</th>
		<th>��������</th>
		<th>����ԭ�ң�</th>
		<th>�ѻ���ԭ�ң�</th>
		<th>ʣ�౾��ԭ�ң�</th>
		
		<th>����ʣ�౾��ԭ�ң�</th>
		<th>�Ǽ���ʣ�౾��ԭ�ң�</th>
		
        <th>����</th>
        <th>����</th>
        <th>ʣ�౾������ң�</th>
        
        <th>����ʣ�౾������ң�</th>
		<th>�Ǽ���ʣ�౾������ң�</th>
        
		<th>����δ̯��������ң�</th>
		
		<th>���ڷ���δ̯��������ң�</th>
		<th>�Ǽ��ڷ���δ̯������ң�</th>
		
        <th>��Ϣ��ծ���</th>
        <th>���ڴ�Ϣ��ծ</th>
        <th>�Ǽ��ڴ�Ϣ��ծ</th>
        <th>��ǰ����</th>
        <th>���������</th>
        <th>�������</th>
        <th>��Ѻ���</th>
        <th>�������</th>   
        <th>���������</th>
        <th>���ʷ�ʽ</th>
        <th>��������</th>
        <th>��������</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_financing_drawings_detail where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_financing_drawings_detail where 1=1 "+wherestr+" order by crediter,id ) "+wherestr ;
sqlstr += " order by crediter,id ";
%>
 <%-- <tr><td colspan="100"><%=sqlstr %></td></tr>  --%>
<% 
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	String drawings_id=rs.getString("drawings_id");
%>
      <tr>
        <td align="center"><%=drawings_date_end %></td>
        <%
        	boolean flag =true;
        	String drawings_date =rs.getString("drawings_date");
        	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
        	java.util.Date drawings_date_end_date = df.parse(drawings_date_end);
        	java.util.Date drawings_date_date = df.parse(drawings_date);
        	if(drawings_date_end_date.before(drawings_date_date)){
        		flag=false;
        	}
        %>
        <td align="center"><%=getDBDateStr( drawings_date) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_id")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("crediter")) %></td>
		<td align="center"><%=getDBStr( rs.getString("drawings_type")) %></td>
		<%String drawings_money=rs.getString("drawings_money" );  %>
		<td align="center"><%= CurrencyUtil.convertFinance( drawings_money) %></td>
		<%
		double drawingsLeftCorpus =0.00d;
		double drawingsLeftCorpusSightAmount=0.00d;
		double drawingsLeftCorpusNoSightAmount=0.00d; 
			if(flag){
		%>
		<td align="center"><%=CurrencyUtil.convertFinance(FinancingReportUtil.getDrawingsRefundCorpus(drawings_id,drawings_date_end)) %></td>
		<%drawingsLeftCorpus = FinancingReportUtil.getDrawingsLeftCorpus(drawings_id,drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance(drawingsLeftCorpus) %></td>
		<%drawingsLeftCorpusSightAmount = FinancingReportUtil.getDrawingsLeftSightAmount(drawings_id, drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftCorpusSightAmount) %></td>
		<%drawingsLeftCorpusNoSightAmount = FinancingReportUtil.getDrawingsLeftNoSightAmount(drawings_id, drawings_date_end); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftCorpusNoSightAmount) %></td>
		<%
			}else{
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
			}
		%>
		<td align="center"><%=getDBStr( rs.getString("currency")) %></td>
		<td align="center">
		<%
			String currency = getDBStr( rs.getString("currency"));
			double rate=1d;
			double rmbRate = 1d;
			if("�����".equals(currency)){
				rate=rmb_rate_d;
				//rmbRate = FinancingReportUtil.getCurrentRate(drawings_id ,drawings_date_end);
			}
			if("��Ԫ".equals(currency)){
				rate=dollar_currency_rate_d;
			}
			if("�۱�".equals(currency)){
				rate=hongKong_dollar_rate_d;
			}
			%><%=rate %><%
		%>
		</td>
		
		<%
			if(flag){
		%>
		<%double drawingsLeftRMB = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpus,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMB) %></td>
		<%double drawingsLeftRMBSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusSightAmount,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBSightAmount) %></td>
		<%double drawingsLeftRMBNoSightAmount = FinancingReportUtil.getCurrencyToRMB(drawingsLeftCorpusNoSightAmount,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBNoSightAmount) %></td>
		<%double nonAmortizationRMB = FinancingReportUtil.getNonAmortizationRMB(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMB) %></td>
		<%double nonAmortizationRMBSightAmount = FinancingReportUtil.getNonAmortizationRMBSightAmount(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMBSightAmount) %></td>
		<%double nonAmortizationRMBNoSightAmount = FinancingReportUtil.getNonAmortizationRMBNoSightAmount(drawings_id,drawings_date_end,rate); %>
		<td align="center"><%=CurrencyUtil.convertFinance( nonAmortizationRMBNoSightAmount) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMB-nonAmortizationRMB) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBSightAmount-nonAmortizationRMBSightAmount) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance( drawingsLeftRMBNoSightAmount-nonAmortizationRMBNoSightAmount) %></td>
		<% 
			}else{
				%>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<td align="center">0.00</td>
				<%
			}
		%>
		<td align="center"><%=rmbRate %></td>
		<td align="center"><%=getDBStr( rs.getString("Table_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("loan_category")) %></td>
		<td align="center"><%=getDBStr( rs.getString("pawn_condition")) %></td>
        <td align="center"><%=getDBStr( rs.getString("assurer_condition")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Abroad_domestic")) %></td>
        <td align="center"><%=getDBStr( rs.getString("Financing_Method")) %></td>
        <td align="center"><%=getDBStr( rs.getString("drawings_rate_type")) %></td>
        <td align="center"><%=getDBStr( rs.getString("drawings_time_type")) %></td>	
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
