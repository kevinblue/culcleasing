<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>������ - �ۿ�δ�ɹ���ϸ��</title>
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
<form action="kkfailed_rent_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" name="excel_name" value="kkfailed_rent">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			������ &gt; �ۿ�δ�ɹ���ϸ��
		</td>
	</tr>
</table><!--�������-->
<%
wherestr=" and 1=1 ";

String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));
String zzs = getStr(request.getParameter("zzs"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String zj_status = getStr(request.getParameter("zj_status"));
String hx_status = getStr(request.getParameter("hx_status"));
String fee_type = getStr(request.getParameter("fee_type"));
String bank = getStr(request.getParameter("bank"));
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dld like '%"+dld_name+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and khmc like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and prod_id = '"+prod_id+"'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(zj_status!=null && !"".equals(zj_status)){
	wherestr+=" and status = '"+zj_status+"'";
}
if(fee_type!=null && !"".equals(fee_type)){
	wherestr+=" and fee_type = '"+fee_type+"'";
}
if(bank!=null && !"".equals(bank)){
	wherestr+=" and bank = '"+bank+"'";
}
if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(*) as amount from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr;

//��������1
String exesqlstr1 = "select qymc ����,dld ������,proj_id ��Ŀ���,khmc �ͻ�����,cust_id �ͻ����,card_id ���֤,method ���򸶿�, ";
exesqlstr1 += " prod_id ����������,manufacturer ������,model_id ����,equip_sn �������,";
exesqlstr1 += " fee_type ��������,rent_list �ڴ�,plan_date Ӧ������,";
exesqlstr1 += " costmoney Ӧ�ս��,modify_date �ۿ�����,fail_reason δ�ɹ�ԭ��,";
exesqlstr1 += " overdue_reason ����ԭ��,overdue_description ����˵��,";
exesqlstr1 += " detail_description ��ϸ���� from vi_report_kkfailed_rent where item_id in ";

//��������2--���ݵ���
String exesqlstr2 = "select qymc ����,dld ������,proj_id ��Ŀ���,khmc �ͻ�����,cust_id �ͻ����,card_id ���֤,method ���򸶿�, ";
exesqlstr2 += " prod_id ����������,manufacturer ������,model_id ����,equip_sn �������,";
exesqlstr2 += " fee_type ��������,rent_list �ڴ�,plan_date Ӧ������,";
exesqlstr2 += " costmoney Ӧ�ս��,modify_date �ۿ�����,fail_reason δ�ɹ�ԭ��,";
exesqlstr2 += " overdue_reason ����ԭ��,overdue_description ����˵��,";
exesqlstr2 += " detail_description ��ϸ���� from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr+" order by dld,proj_id,rent_list";

%>	
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
<td>��Ŀ���</td>
<td><input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>����������</td>
<td><select name="prod_id" style="width:88px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>Ӧ������</td>
<td><input name="start_date" type="text" size="9" readonly dataType="Date" value="<%=start_date %>">
<img onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;&nbsp;��&nbsp;</td>
<td><input name="end_date" type="text" size="9" readonly dataType="Date" value="<%=end_date %>">
<img onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>��������</td>
<td><select name="prod_id" style="width:90px;">
    <script>w(mSetOpt('<%=bank%>',"<%=bank_str%>"));</script>
     </select></td>

</tr>

<tr>
<td>������</td>
<td>
<select name="zzs" style="width:88px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
</select>
</td>
<td>�ͻ�����</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>����&nbsp;&nbsp;���</td>
<td><input name="equip_sn" type="text" size="11" value="<%=equip_sn %>"></td>

<td>�ʽ�״̬</td>
<td>
<select name="zj_status" style="width:100px;">
 <script>w(mSetOpt('<%=zj_status%>',"|����|����"));</script>
</select>
</td>
<td>��������</td>
<td>
<select name="fee_type" style="width:100px;">
 <script>w(mSetOpt('<%=fee_type %>',"|���|ΥԼ��"));</script>
</select>
</td>
<td align="left"><input type="button" onclick="dataNav.submit()" value="��ѯ"></td>
<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="clearQuery()" value="���"></td>
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
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','kkfailed_rent_report.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
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
		</table>
		<!--������ť����-->
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
		<th>������</th>
        <th>��Ŀ���</th>
		<th>�ͻ�����</th>
		<th>�ͻ����</th>
		<th>���֤</th>
		
		<th>���򸶿�</th>
		<th>����������</th>
		<th>������</th>
		<th>����</th>
		<th>�������</th>

		<th>��������</th>
		<th>�ڴ�</th>
		<th>�ۿʽ</th>
		<th>Ӧ������</th>
		<th>Ӧ�ս��</th>

		<th>�ۿ�����</th>
		<th>δ�ɹ�ԭ��</th>

		<th>����ԭ��</th>
		<th>����˵��</th>
		<th>��ϸ����</th>
	</tr>
<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from vi_report_kkfailed_rent where 1=1 and item_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" item_id from vi_report_kkfailed_rent where 1=1 "+filterAgent+wherestr+" order by  dld,proj_id,rent_list,item_id ) "+filterAgent+wherestr ;
sqlstr +=" order by dld,proj_id,rent_list,item_id ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("item_id") );
%>
	<tr>
		<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
		<td align="center"><%=startIndex++ %></td>
        <td align="center"><%=getDBStr(rs.getString("qymc"))%></td>
        <td align="center"><%=getDBStr(rs.getString("dld"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
		<td align="center"><%=getDBStr(rs.getString("cust_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("card_id")) %></td>

		<td align="center"><%=getDBStr(rs.getString("method"))%></td>
        <td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
		<td align="center"><%=getDBStr(rs.getString("manufacturer"))%></td>
        <td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>

		<td align="center"><%=getDBStr(rs.getString("fee_type"))%></td>
        <td align="center"><%=getDBStr(rs.getString("rent_list")) %></td>
		<td align="center"><%=getDBStr(rs.getString("item_method"))%></td>
        <td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("costmoney")) %></td>

		<td align="center"><%=getDBDateStr(rs.getString("modify_date")) %></td>
		<td align="left"><%=getDBStr(rs.getString("fail_reason")) %></td>

		<td align="left"><%=getDBStr(rs.getString("overdue_reason")) %></td>		
		<td align="left"><%=getDBStr(rs.getString("overdue_description")) %></td>
		<td align="left"><%=getDBStr(rs.getString("detail_description")) %></td>
</tr>
<% }
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->
</form>
</body>
</html>

