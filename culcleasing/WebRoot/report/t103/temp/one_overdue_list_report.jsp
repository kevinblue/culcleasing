<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Expires" content="3600"><!-- ����1Сʱ -->
	<title>����������ͳ�� - һ������</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<style type="text/css">
	.tbodyStyle {
		color:#10418C;
		font-weight:500;
	}
	tfoot tr td {
		color:#E74100;
		font-weight:550;
	}
	</style>
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
<form action="one_overdue_list_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="excel_name" value="one_overdue">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			����������ͳ�� &gt; һ������
		</td>
	</tr>
</table><!--�������-->
<%
wherestr=" and 1=1 ";

String dld_name = getStr(request.getParameter("dld_name"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and khjc like '%"+dld_name+"%'";
}

countSql = "select count(*) as amount from vi_report_overdue_one where overdueProjAmount>0 "+filterAgent+wherestr;

//��������1
String exesqlstr1 = "select qy ����,khmc �����ȫ��,khjc �������,cast(overdueProjAmount as decimal) һ��������Ŀ����,cast(overdueEquipAmount as decimal) һ�������豸���� from vi_report_overdue_one where agent_id in ";

//��������2--���ݵ���
String exesqlstr2 = "select qy ����,khmc �����ȫ��,khjc �������,cast(overdueProjAmount as decimal) һ��������Ŀ����,cast(overdueEquipAmount as decimal) һ�������豸���� from vi_report_overdue_one where overdueProjAmount>0 "+filterAgent+wherestr;

%>	
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>�����̣�&nbsp;<input name="dld_name" type="text" size="14" value="<%=dld_name %>"></td>
<td>
<input type="button" onclick="dataNav.submit()" value="��ѯ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="���"></td>
</tr>

</table>
</fieldset>
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
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','one_overdue_list_report.jsp');">
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

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>���</th>
		<th>����</th>
		<th>������ȫ��</th>
        <th>�����̼��</th>
        <th>һ��������Ŀ����</th>
        <th>һ�������豸����</th>
	</tr>
	<tbody id="data">
<%
int overdueProjAmount=0;
int overdueEquipAmount=0;

String col_str="qy,khmc,khjc,agent_id,overdueProjAmount,overdueEquipAmount";	  
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_report_overdue_one where overdueProjAmount>0 and bmid not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" bmid from vi_report_overdue_one where overdueProjAmount>0 "+filterAgent+wherestr+" order by overdueProjAmount desc,bmid  ) "+filterAgent+wherestr;
sqlstr +=" order by overdueProjAmount desc,bmid ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("agent_id") );
	overdueProjAmount=rs.getInt("overdueProjAmount");
	overdueEquipAmount=rs.getInt("overdueEquipAmount");
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qy"))%></td>
	<td align="left"><%=getDBStr(rs.getString("khmc"))%></td>
	<td align="left"><%=getDBStr(rs.getString("khjc")) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(overdueProjAmount) %></td>
	<td align="center"><%=CurrencyUtil.convertIntAmount(overdueEquipAmount) %></td>
</tr>
<% }
rs.close(); 
db.close();
%>  
</tbody>
</table>
</div><!--�������-->
</form>
</body>
</html>
