<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>���Ʊ��עά�� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//�ύ��������״̬
	function updMaterStatus(){
		var flag = 0;
		var erItems = "";
		var items = "";
		var item="";
		var begin_id="";
		var rent_list="";
		var invoice_remark="";
		$("#data>tr").each(function(i){
		    var $materTr = $(this); 
		    item = $materTr.find("td>:input[name^='it_']");
		    begin_id=$materTr.find("td>:input[name^='begin_id_']");
		    rent_list=$materTr.find("td>:input[name^='rent_list_']");
		    invoice_remark=$materTr.find("td>:input[name^='invoice_remark_']");
			items += $.trim(item.val())+"|";// ��|��ʵ����-���ֶ�
		});
			var itemStr=$(":input[name=itemStr]").val(items.substring(0,items.length-1));
			dataNav.action="rent_invoice_remark_save.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			dataNav.action="rent_invoice_remark_mod.jsp";
			dataNav.target="_self"
		
	}
	


	function piliang(beizhu){
		var bz='invoice_remark_'+beizhu;
		var vu = $("input[name='"+bz+"']").val();
		$("input[id='invoice_remark']").val(vu);
	}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="rent_invoice_remark_mod.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		���Ʊ��עά��</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String plan_status =getStr(request.getParameter("plan_status"));
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String start_hire_date = getStr(request.getParameter("start_hire_date"));
String end_hire_date = getStr(request.getParameter("end_hire_date"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));

if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(plan_status!=null && !plan_status.equals("")){
	wherestr +=" and plan_status like '%" + plan_status + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(start_hire_date!=null && !"".equals(start_hire_date) && end_hire_date!=null && !"".equals(end_hire_date)){
	wherestr +=" and last_hire_date>= '"+start_hire_date+"' and last_hire_date<='"+end_hire_date+"'";
}

if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}


countSql = "select count(proj_id) as amount from vi_func_rent_manage_Z where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select proj_id ��Ŀ���,begin_id ������,project_name ��Ŀ����,cust_name as �ͻ�����,parent_deptname ��������, dept_name ��������,proj_manage_name ��Ŀ����,"+
					"rent_list ������,plan_date Ӧ������,rent Ӧ�ս��,interest Ӧ����Ϣ,corpus Ӧ�ձ���,curr_rent ʣ�����,invoice_type ��Ʊ���߷�ʽ,"+
					"invoice_is �Ƿ񿪾�,invoice_normal �Ƿ���������,invoice_remark ��ע,plan_status ����Ƿ����,modificator ��������,tax_type ˰��,tax_type_invoice ��ֵ˰��Ʊ����,invoice_date ��Ʊ����"+
					" from vi_func_rent_manage_Z where 1=1 "+wherestr;
String updSql="select begin_id,rent_list from vi_func_rent_manage_Z where 1=1 "+wherestr;
%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="proj_name"  type="text" size="15" value="<%=proj_name %>"></td>
<td>��Ŀ����:&nbsp;<input name="proj_manage_name"  type="text" size="15" value="<%=proj_manage_name %>">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ��Ŀ����','(select distinct proj_manage_name as proj_manage_name from vi_contract_info) a ','proj_manage_name','','proj_manage_name','proj_manage_name','asc','dataNav.proj_manage_name','');">
</td>
<td>��&nbsp;&nbsp;&nbsp;&nbsp;��:
<input style="width:116px;" name="parent_deptname" id="parent_deptname" type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ����','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</tr>
<tr>
</td>
<td>��&nbsp;&nbsp;&nbsp;&nbsp;��:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ����','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>
<td>Ӧ������:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>ʵ������:&nbsp;<input name="start_hire_date" type="text" size="15" readonly dataType="Date" value="<%=start_hire_date %>">
<img  onClick="openCalendar(start_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_hire_date" type="text" size="15" readonly dataType="Date" value="<%=end_hire_date %>">
<img  onClick="openCalendar(end_hire_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
</tr>
<tr>
<td>�Ƿ����:
 <select name="plan_status" style="width: 116">
    <script type="text/javascript">
     	w(mSetOpt('<%=plan_status %>',"|�ѻ���|���ֻ���|δ����","|�ѻ���|���ֻ���|δ����"));
    </script>
 </select>
</td>
<td> <input type="button" value="��ѯ" onclick="dataNav.submit();"></td>
<td><input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
		<td  width="50%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ύ(Alt+N)">&nbsp;&nbsp;
			<input class="btn_2" type="button"  value="�ύ" onclick="return updMaterStatus();">&nbsp;&nbsp;
		</td>
		<td align="left">
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
	    <!--������ť����-->
	    </td>
		<!-- ��ҳ���� -->
		<td align="right"><!--��ҳ���ƿ�ʼ-->
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
     	<th>��Ŀ���</th>
		<th>������</th>
	    <th>��Ŀ����</th>
	    <th>�ͻ�����</th>
		<th>��������</th>
	    <th>��������</th>
     	<th>��Ŀ����</th>
 		<th>������</th>	
		<th>Ӧ������</th>
		<th>ʵ������</th>
	 	<th>Ӧ�ս��</th>
	 	<th>Ӧ����Ϣ</th>
	 	<th>Ӧ�ձ���</th>
		<th>ʣ�����</th>
	 	<th>��Ʊ���߷�ʽ</th>
	 	<th>��ע</th>
	 	<th>����Ƿ����</th>
	 	<th>��������</th>
		<th>˰��</th>
		<th>��ֵ˰��Ʊ����</th>

      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_func_rent_manage_Z where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_func_rent_manage_Z where 1=1 "+wherestr+" order by begin_id,rent_list,id ) "+wherestr ;
sqlstr +=" order by  begin_id,rent_list,id ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%>
	        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
	        <input type="hidden" name="begin_id_<%=index_no %>" value="<%=getDBStr(rs.getString("begin_id")) %>"/>
	        <input type="hidden" name="rent_list_<%=index_no %>" value="<%=getDBStr(rs.getString("rent_list")) %>"/>
        </td>
        <td align="left"><%=getDBStr(rs.getString("begin_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
	    <td align="left"><%=getDBDateStr(rs.getString("last_hire_date"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("interest"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("corpus"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("curr_rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>	
		<td align="left">
		<input type="text" id="invoice_remark" name="invoice_remark_<%=index_no %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/>
		<BUTTON class="btn_2" type="button" onclick="return piliang('<%=index_no %>');">&nbsp;������ע</button>	
		</td> 
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
      </tr>
<%}
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
