<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>���޹�˾�տ��б�</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
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

<body  onload="public_onload(0);">
<form action="leasing_list_detail_search.jsp" name="dataNav" onSubmit="return goPage()">
<%
wherestr=" and 1=1 ";
		
String dls = getStr( request.getParameter("dls") );
String xmbh = getStr( request.getParameter("xmbh") );
String khmc = getStr( request.getParameter("khmc") );
String zzs = getStr( request.getParameter("zzs") );
String zlwlx = getStr( request.getParameter("zlwlx") );
String kxmc = getStr( request.getParameter("kxmc") );

String yf_date_start = getStr( request.getParameter("yf_date_start") );
String yf_date_end = getStr( request.getParameter("yf_date_end") );

String dz_date_start = getStr( request.getParameter("dz_date_start") );
String dz_date_end = getStr( request.getParameter("dz_date_end") );
	
if ( !dls.equals("") ) {
	wherestr = wherestr + " and dld  like '%" + dls + "%'";
}
if ( !xmbh.equals("") ) {
	wherestr = wherestr + " and proj_id  like '%" + xmbh + "%'";
}
if ( !khmc.equals("") ) {
	wherestr = wherestr + " and khmc like '%" + khmc + "%'";
}
if ( !zzs.equals("") ) {
	wherestr = wherestr + " and manufacturer ='" + zzs + "'";
}
if ( !zlwlx.equals("") ) {
	wherestr = wherestr + " and prod_id = '" + zlwlx + "'";
}
if ( !kxmc.equals("") ) {
	wherestr = wherestr + " and funds_name = '" + kxmc + "'";
}

if(yf_date_start!=null&&!yf_date_start.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+yf_date_start+"' ";
}
if(yf_date_end!=null&&!yf_date_end.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+yf_date_end+"' ";
}
if(dz_date_start!=null&&!dz_date_start.equals("")){
	wherestr+=" and convert(varchar(10),fact_date,21)>='"+dz_date_start+"' ";
}
if(dz_date_end!=null&&!dz_date_end.equals("")){
	wherestr+=" and convert(varchar(10),fact_date,21)<='"+dz_date_end+"' ";
}

countSql = "select count(*) as amount from v_zjfwy_detail where 1=1 "+wherestr+filterAgent;

%>		
			
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
	<td>������:<input name="dls" type="text" size="10" value="<%=dls %>" /></td>
	<td>��Ŀ&nbsp;&nbsp;���: <input name="xmbh" type="text" size="10" value="<%=xmbh %>" /></td>
	<td>�ͻ�����:&nbsp;<input name="khmc" type="text" size="10" value="<%=khmc %>" /></td>
	<td>Ӧ������:
	<input name="yf_date_start" type="text"  size="10"   value="<%=yf_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="yf_date_end" type="text"  size="10"   value="<%=yf_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(yf_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 </td>
	 <td>
	 <input type="button" value="��ѯ" onclick="dataNav.submit();"> 
	 </td>
   </tr>

   <tr>
	<td>������:<select name="zzs" style="width:80px;">
     <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
     </select>
	<td>����������:
	<select name="zlwlx" style="width:80px;">
     <script>w(mSetOpt('<%=zlwlx%>',"<%=prod_id_str%>"));</script>
     </select>
	 </td>
	<td>��������:
	<select name="kxmc" style="width:80px;">
		<script>w(mSetOpt("<%=kxmc %>","|���շ�|��֤��|��һ�����|�����ۿ�|�������|������|��������"));</script>
	</select>
	</td>
	<td>��������:
	<input name="dz_date_start" type="text"  size="10"   value="<%=dz_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="dz_date_end" type="text"  size="10"   value="<%=dz_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(dz_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>
	 <input type="button" value="���" onclick="clearQuery();">
	</td>
	</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
	<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		���޹�˾�տ��б����ڸ��
	</td>
	</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
			<!--������ť��ʼ-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr class="maintab">
				</tr>
			</table>
			<!--������ť����-->
		</td>
		<td align="right" width="90%">
		<!-- ��ҳ��ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:100%" id="mydiv">

<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
		<tr class="maintab_content_table_title">							

        <th>������</th>
		<th>��Ŀ���</th>
		<th>�ͻ�����</th>

		<th>������</th>
		<th>����������</th>
		<th>����</th>
        <th>�������</th>

        <th>��������</th>
        <th>Ӧ�����</th>
        <th>�����</th>
		<th>Ӧ������</th>
        <th>��������</th>
		</tr>
<tbody id="data">
<%	  
sqlstr = "select top "+ intPageSize +" * from v_zjfwy_detail where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from v_zjfwy_detail where 1=1 "+wherestr+filterAgent+ " order by dld,id ) "+filterAgent+wherestr ;
sqlstr +=" order by dld,id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
	<tr>
       <td align="center"><%=getDBStr(rs.getString("dld"))%></a></td>
       <td align="center"><%=getDBStr(rs.getString("proj_id")) %></td>
       <td align="center"><%=getDBStr(rs.getString("khmc")) %></td>

       <td align="center"><%=getDBStr(rs.getString("manufacturer")) %></td>
       <td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
       <td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	   <td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>
       
       <td align="center"><%=getDBStr(rs.getString("funds_name")) %></td>
	   <td align="center"><%=formatNumberDoubleTwo(rs.getString("plan_money")) %></td>

       <td align="center"><%=getDBStr(rs.getString("apply_id")) %></td>
	   <td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
	   <td align="center"><%=getDBDateStr(rs.getString("fact_date")) %></td>
	</tr>
<% }
rs.close(); 
db.close();
%>
	</tbody>	
</table>
</div>
<!--�������-->
</form>		
</body>
</html>

















