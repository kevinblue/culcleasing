<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���ʽ���Ϣά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="add_money_to_zjjh.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��Ŀ���ʽ�ƻ���Ϣά��</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = "";
String wh_userid=(String) session.getAttribute("czyid");
 if(wh_userid.equals("ADMN-8GRBW4")){
	 
   wherestr += " ";
}else{
	wherestr += " and  pi.proj_dept in  (select department from base_user where id='"+wh_userid+"') ";
}
//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and pi.project_name like '%" + project_name + "%'";
}

countSql = "select count(pp.id) as amount from proj_fund_fund_charge_plan pp  left join proj_info pi on  pi.proj_id=pp.proj_id ";
countSql += " inner join vi_proj_info vci on pp.proj_id = vci.proj_id left join vi_contract_info cingo ";
countSql += "  on cingo.proj_id = vci.proj_id ";
countSql +="where 1=1 and cingo.contract_id is null  and pi.proj_status IN ('10', '15')  "+wherestr;
//ʣ����>0
%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>

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
         <th>���</th>	  
	    <th>��Ŀ���</th>		
		<th>��Ŀ����</th>
		<th>��Ŀ����</th>
		<th>����</th>
         <th>����</th>		
        <th>�ƻ���� </th>        
        <th>�ƻ�����</th>
        <th>��������</th>
        <th>Ԥ�ڽ��</th>
		<th>Ԥ��Ͷ������</th>
		<th>ά����</th>
		<th>ά������</th>
		<th>ͬ��״̬</th>
        <th>����</th>
		 <th>ͬ��</th>
              
      </tr>
      <tbody id="data">
<%
String col_str="pp.id as id ,bu.name as projmanage,pp.proj_id as proj_id ,bd.dept_name, bd.parent_deptname,pp.wh_status,pi.project_name as project_name,pp.plan_money as plan_money,"
+"pp.plan_date as plan_date,pp.fee_name as fee_name,isnull(pp.expect_money,pc.equip_amt) as expect_money,isnull(pp.expect_put_time,CONVERT(varchar(100), pp.plan_date, 23)) as expect_put_time,pp.wh_modificator,pp.wh_modify_date";
int i=1;
sqlstr = "select top "+ intPageSize +" "+col_str+" from proj_fund_fund_charge_plan pp ";
sqlstr += " inner join vi_proj_info vci on pp.proj_id = vci.proj_id left join vi_contract_info cingo ";
sqlstr += " on cingo.proj_id = vci.proj_id  left join proj_condition pc on pc.proj_id=pp.proj_id left join proj_info pi on ";
sqlstr +=" pi.proj_id=pp.proj_id  left join v_select_base_department  bd  on bd.id= pi.proj_dept ";
sqlstr += "left join base_user bu on bu.id=pi.proj_manage ";
sqlstr +="where 1=1 "+wherestr+" and pp.id not in("; 
sqlstr += " select top "+ (intPage-1)*intPageSize +" pp.id from ";
sqlstr +="proj_fund_fund_charge_plan pp  inner join vi_proj_info vci on pp.proj_id = vci.proj_id left join vi_contract_info cingo";  
sqlstr += "  on cingo.proj_id = vci.proj_id  left join proj_info pi on pi.proj_id=pp.proj_id  ";
sqlstr += " where 1=1 "+wherestr+" and cingo.contract_id is null and pi.proj_status IN ('10', '15') order by pp.proj_id ) and cingo.contract_id is null and pi.proj_status IN ('10', '15')  " ;
sqlstr += " order by pp.proj_id ";
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=i %></td>
        <td align="left"><%=getDBStr( rs.getString("proj_id")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>
        <td align="left"><%=getDBStr( rs.getString("projmanage")) %></td>			
		<td align="left"><%=getDBStr( rs.getString("dept_name")) %></td>
        <td align="left"><%=getDBStr( rs.getString("parent_deptname")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("plan_money")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("plan_date")) %></td>		

		<td align="center"><%=getDBStr( rs.getString("fee_name")) %></td>			
		<td align="center"><%=getDBStr( rs.getString("expect_money")) %></td>	
		<td align="center"><%=getDBDateStr( rs.getString("expect_put_time")) %></td>
		<td align="center"><%=getDBStr( rs.getString("wh_modificator")) %></td>			
		<td align="center"><%=getDBDateStr( rs.getString("wh_modify_date")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("wh_status")) %></td>	
		<td align="center">
     	<a href='add_money_to_zjjh_mod.jsp?id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">�޸�</a>    	
     	</td>
		<td align="center">
     	<a href='fund_info_add.jsp?proj_id=<%=getDBStr(rs.getString("proj_id"))%>&id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">����ִ��ͬ��</a>
     	
     	</td>	
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
</body>
</html>
