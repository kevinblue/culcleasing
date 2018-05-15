<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>������ - ������ϸ��</title>
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
<form action="overdue_detail_list.jsp" name="dataNav" onSubmit="return goPage()">
	<!--���⿪ʼ-->
	<table border="0" width="100%" cellspacing="0" cellpadding="0"
		height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				������&gt; ������ϸ��
			</td>
		</tr>
	</table>
<!--�������-->
<%
String expsqlstr="";
String partSql="";
ResultSet rs1=null;
String curr_date = getSystemDate(0);
String dld_name = getStr(request.getParameter("dld_name"));
String zzs = getStr(request.getParameter("zzs"));
String cust_name = getStr(request.getParameter("cust_name"));
String prod_id = getStr(request.getParameter("prod_id"));
String proj_id = getStr(request.getParameter("proj_id"));
String yq_amount = getStr(request.getParameter("yq_amount"));

String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String overdue_day_start = getStr(request.getParameter("overdue_day_start"));
String overdue_day_end = getStr(request.getParameter("overdue_day_end"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dls like '%"+dld_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and cname like '%"+cust_name+"%'";
}
if ( !zzs.equals("") ) {
	wherestr = wherestr + " and manufacturer = '" + zzs + "'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(prod_id!=null && !"".equals(prod_id)){
	wherestr+=" and zlwmc = '"+prod_id+"'";
}
if(yq_amount!=null && !"".equals(yq_amount)){
	if( "����1��".equals(yq_amount) ){//|����2��|����3��|3������
		wherestr+=" and overdue_amount = 1";
	}else if( "����2��".equals(yq_amount) ){
		wherestr+=" and overdue_amount = 2";
	}else if( "����3��".equals(yq_amount) ){
		wherestr+=" and overdue_amount = 3";
	}else if( "3������".equals(yq_amount) ){
		wherestr+=" and overdue_amount >3";
	}
}

if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),qzrq,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),qzrq,21)<='"+end_date+"' ";
}
if(overdue_day_start!=null && !"".equals(overdue_day_start)){
	wherestr+=" and overdue_day>='"+overdue_day_start+"' ";
}
if(overdue_day_end!=null && !"".equals(overdue_day_end)){
	wherestr+=" and overdue_day<='"+overdue_day_end+"' ";
}
//�����б�--��������
String yq_amount_str = "|����1��|����2��|����3��|3������";
String filterProjIdSql = " select proj_id from proj_info where proj_status=20 ";

countSql = "select count(*) as amount from vi_flow_sb where proj_id in("+ filterProjIdSql +") "+filterAgent+wherestr;

//��������1
String exesqlstr1 = "select qy ����,dls �����,subcompany ��֧����,proj_id ��Ŀ���,cname �ͻ�����, manufacturer ������,zlwmc ����������, ";
exesqlstr1 +="jx ����,ccbh �������,qzrq ��������,zlqx ��������,zldqr �ƻ���������,equip_amt �����ﹺ��ۿ�,";
exesqlstr1 +="zjze ����ܶ�,received_amount �Ѹ�����,yfzj �Ѹ����,(zlqx-received_amount) δ������,";
exesqlstr1 +="zjye δ�����,overdue_amount ��������,overdue_day ��������,overdue_sum ��������� ";
exesqlstr1 +="from vi_flow_sb where id in ";

//��������2--���ݵ���
String exesqlstr2 = "select qy ����,dls �����,subcompany ��֧����,proj_id ��Ŀ���,cname �ͻ�����, manufacturer ������,zlwmc ����������, ";
exesqlstr2 +="jx ����,ccbh �������,qzrq ��������,zlqx ��������,zldqr �ƻ���������,equip_amt �����ﹺ��ۿ�,";
exesqlstr2 +="zjze ����ܶ�,received_amount �Ѹ�����,yfzj �Ѹ����,(zlqx-received_amount) δ������,";
exesqlstr2 +="zjye δ�����,overdue_amount ��������,overdue_day ��������,overdue_sum ��������� ";
exesqlstr2 +=" from vi_flow_sb where proj_id in("+ filterProjIdSql +") "+filterAgent+wherestr+"order by overdue_amount desc,id";
%>	
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>������</td>
<td><input name="dld_name" type="text" size="11" value="<%=dld_name %>"></td>
<td>��Ŀ���</td>
<td><input name="proj_id" type="text" size="11" value="<%=proj_id %>"></td>
<td>����������</td>
<td><select name="prod_id" style="width:90px;">
     <script>w(mSetOpt('<%=prod_id%>',"<%= prod_id_str%>"));</script>
     </select>
</td>

<td>����ȷ����</td>
<td><input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;��
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="dataNav.submit()" value="��ѯ"></td>
</tr>

<tr>
<td>������</td>
<td><select name="zzs" style="width:90px;">
     <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
     </select></td>
<td>�ͻ�����</td>
<td><input name="cust_name" type="text" size="11" value="<%=cust_name %>"></td>
<td>����&nbsp;&nbsp;����</td><td><select name="yq_amount" style="width:90px;">
     <script>w(mSetOpt('<%=yq_amount%>',"<%= yq_amount_str%>"));</script>
     </select>
</td>

<td>����&nbsp;&nbsp;����</td>
<td><input name="overdue_day_start" type="text" size="10" value="<%=overdue_day_start %>">&nbsp;&nbsp;��&nbsp;&nbsp;
<input name="overdue_day_end" type="text" size="10" value="<%=overdue_day_end %>">
</td>
<td><input type="button" onclick="clearQuery()" value="���"></td>
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
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_report_exp('../../func/exp_report.jsp','overdue_detail_list.jsp');">
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
		<th>�����</th>
        <th>��֧����</th>
        <th>��Ŀ���</th>
        <th>�ͻ�����</th>
		<th>������</th>
		<th>����������</th>
        <th>����</th>
        <th>�������</th>
        
		<th>��������</th>
		<th>��������</th>
		<th>�ƻ���������</th>

		<th>�����ﹺ��ۿ�</th>
        
		<th>����ܶ�</th>
		<th>�Ѹ�����</th>
		<th>�Ѹ����</th>

		<th>δ������</th>
		<th>δ�����</th>
        
		<th>��������</th>
		<th>�ۼ�����</th>
        <th>��������</th>
        <th>���������</th>
        
	</tr>
	<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from vi_flow_sb where proj_id in("+ filterProjIdSql +") and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_flow_sb where proj_id in("+ filterProjIdSql +") "+filterAgent+wherestr+" order by overdue_amount desc,id ) "+filterAgent+wherestr ;
sqlstr +=" order by overdue_amount desc,id ";

rs = db.executeQuery(sqlstr);
String item_id = "";
int overdue_con_amount=0;
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("id") );
%>

	<tr>
		<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
		<td align="center"><%=startIndex++ %></td>
		 <td align="center"><%=getDBStr(rs.getString("qy"))%></td>
        <td align="center"><%=getDBStr(rs.getString("dls"))%></td>
 <td align="center"><%=getDBStr(rs.getString("subcompany"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
        <td align="center"><%=getDBStr(rs.getString("cname")) %></td>
		<td align="center"><%=getDBStr(rs.getString("manufacturer")) %></td>
        <td align="center"><%=getDBStr(rs.getString("zlwmc")) %></td>
		<td align="center"><%=getDBStr(rs.getString("jx"))%></td>
        <td align="center"><%=getDBStr(rs.getString("ccbh")) %></td>

        <td align="center"><%=getDBDateStr(rs.getString("qzrq")) %></td>
		<td align="center"><%=getDBStr(rs.getString("zlqx")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("zldqr")) %></td>

        <td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
		
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("zjze")) %></td>

		<td align="center"><%=getDBStr(rs.getString("received_amount")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("yfzj")) %></td>
		<td align="center"><%=rs.getInt("zlqx")-rs.getInt("received_amount") %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("zjye")) %></td>
		
		<td align="center"><%=getDBStr(rs.getString("overdue_amount")) %></td>
		<%
			//�ۼ�����
			partSql = "select dbo.overdue_con_amount('"+rs.getString("proj_id")+"') as r ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				overdue_con_amount = rs1.getInt("r");
			}
			rs1.close();
		%>
        <td align="center"><%=overdue_con_amount %></td>
        <td align="center"><%=getDBStr(rs.getString("overdue_day")) %></td>
		<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("overdue_sum")) %></td>
</tr>
<%
}
rs.close(); 
db1.close();
db.close();
%>
	</tbody></table>
	</div><!--�������-->
</form>
</body>
</html>

