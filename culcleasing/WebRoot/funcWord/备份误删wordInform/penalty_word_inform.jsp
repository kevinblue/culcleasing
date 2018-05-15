<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ϣ���� - ֪ͨ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function penaltyInform(obj){
	window.open("http://domino.culc.com/eleasing/PMAgent.nsf/CreatePenaltyPayNotice?openagent&id="+obj,
	"","status=no,scrollbars=no,location=no,menubar=yes,resizable=yes");
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="rent_word_inform.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��Ϣ���� &gt; ֪ͨ��</td>
	</tr>
</table>
<!--�������-->

<%
//wherestr = " and plan_date<=dateadd(mm, 15, getdate()) ";//��ǰ15���ڵ�֪ͨ��
wherestr = "";

//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

if(start_date!=null && !"".equals(start_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+start_date+"' ";
}
if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+end_date+"' ";
}

countSql = "select count(id) as amount from vi_fund_penalty_plan where plan_status='δ����' "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="20" value="<%=project_name %>"></td>

<td>�ƻ�����:&nbsp;
<input name="start_date" type="text" size="10" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
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
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td></td>
	    </tr>
	</table>
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
		<th>��Ŀ����</th>
        <th>������</th>
        <th>������</th>
        
        <th>�������</th>
        <th>�ڴ�</th>
        <th>���ƻ���ȡ��</th>
        <th>���ʵ����ȡ��</th>
        
        <th>��������</th>
        <th>��Ϣ</th>
        <th>ʣ�෣Ϣ</th>
        <th>���ⷣϢ</th>
        <th>�ƻ���ȡ����</th>
        
        <th>����</th>
      </tr>
      <tbody id="data">
<%
String col_str=" * ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_fund_penalty_plan where plan_status='δ����' and id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_penalty_plan where plan_status='δ����' "+wherestr+" order by begin_id,rent_list ) "+wherestr ;
sqlstr += " order by begin_id,rent_list ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("begin_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("cust_name")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("penalty_rent" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("rent_list" )) %></td>	
		<td align="left"><%= getDBDateStr( rs.getString("penalty_rent_planDate")) %></td>	
		<td align="left"><%= getDBDateStr( rs.getString("penalty_rent_hireDate")) %></td>	
		
		<td align="center"><%= CurrencyUtil.convertIntAmount( rs.getString("penalty_day_amount" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("penalty" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("curr_penalty" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("penalty_rid" )) %></td>	
		
		<td align="left"><%= getDBDateStr( rs.getString("plan_date")) %></td>	
		
		<td>
			<a onclick="Javascript:penaltyInform('<%=getDBStr( rs.getString("id")) %>')" target="_blank" title="���ط�Ϣ����֪ͨ��">
			<b style="color:#E46344;">�����ط�Ϣ����֪ͨ�顷</b></a>
		</td>
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
