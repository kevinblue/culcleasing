<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Expires" content="3600"><!-- ����1Сʱ -->
	<title>����������ͳ�� - ������ʷ����</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<!-- ���޹�˾�������̵��ж� -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- ���޹�˾�������̵��ж� -->

<body onload="public_onload(0);">
<form action="history_two_overdue_list_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="excel_name" value="two_overdue">

<%
wherestr=" and 1=1 ";

String dld_name = getStr(request.getParameter("dld_name"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and khjc like '%"+dld_name+"%'";
}

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2)-1);

countSql = "select count(*) as amount from report_two_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+filterAgent+wherestr;

//��������1
String exesqlstr1 = "select qy ����,khmc ������ȫ��,khjc ��������,overdueProjAmount ����������Ŀ����,overdueEquipAmount ���������豸���� from report_two_overdue where agent_id in ";

//��������2--���ݵ���
String exesqlstr2 = "select qy ����,khmc ������ȫ��,khjc ��������,overdueProjAmount ����������Ŀ����,overdueEquipAmount ���������豸���� from report_two_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+filterAgent+wherestr+"order by overdueProjAmount desc,bmid";

%>	

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0"
	height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			����������ͳ�� &gt;<font color="color:red;"> <%=year %>��<%=month %>��</font>&gt; ��������
		</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>������</td>
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>ѡ�����</td>
<td>
<select name="cho_year">
<script type="text/javascript">
for(var i=<%=getCurrentDatePart(1) %>;i><%=getCurrentDatePart(1)-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>
<td>ѡ���·�</td>
<td>
<select name="cho_month">
<script type="text/javascript">
for(var i=1;i<=12;i++){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>

<td>
<input type="button" onclick="dataNav.submit()" value="��ѯ">
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="���"></td>
</tr>

</table>
</fieldset>
<script type="text/javascript">
$("select[name='cho_year']").val(<%=year %>);
$("select[name='cho_month']").val(<%=month %>);
</script>
</div><!-- ��ѯ�������� -->


<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">		
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input type="hidden" id="export_type1" value="<%=exesqlstr1%>">
				<input type="hidden" id="export_type2" value="<%=exesqlstr2%>">

				<input name="expsqlstr" type="hidden">
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','history_two_overdue_list_report.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!--
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;ҳ��ȫѡ
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;����ȫѡ
				</td><!--������ť����-->
			</tr>
		</table><!--������ť����-->
		</td>

		<td align="right" width="90%">
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	 				
		</td>
	</tr>
</table>

<!--������ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>���</th>
		<th>����</th>
		<th>������ȫ��</th>
        <th>�����̼��</th>
        <th>����������Ŀ����</th>
        <th>���������豸����</th>
	</tr>
	<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from report_two_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+" and bmid not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" bmid from report_two_overdue where overdueProjAmount>0 and year(create_date)= "+year+" and month(create_date)="+month+filterAgent+wherestr+" order by overdueProjAmount desc,bmid  ) "+filterAgent+wherestr;
sqlstr +=" order by overdueProjAmount desc,bmid ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("agent_id") );
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qy"))%></td>
	<td align="left"><%=getDBStr(rs.getString("khmc"))%></td>
	<td align="left">
	<%=getDBStr(rs.getString("khjc")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getInt("overdueProjAmount")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getInt("overdueEquipAmount")) %></td>
</tr>
<% }
rs.close(); 
db.close();
%>  
</tbody></table>
</div><!--��������-->
</form>
</body>
</html>