<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String context = request.getContextPath();
String userId=(String) session.getAttribute("czyid");
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ʊ�ӿڵ��� </title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">	
	//checkbosȫѡ
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
	function allbool(va){
		var v=va;
		if(v=='��1'){
			$(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='��']").attr("checked","checked");	
		
		}else if(v=='��1'){
		    $(":radio[id='invoice_is']").removeAttr("checked");
			$("input[id='invoice_is'][value='��']").attr("checked","checked");
		}
	}	
	function  getList(){
		//�õ���ѡ��ļ���
		var sqlIds="";
	 	//var check_amount=0;//ѡ���е�����
		$("input[name^='checkbos_list']:checked").each(function(){
			var id = $(this).attr("value");
			sqlIds += "'"+ id +"',";

			

			
		});

		$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
		dataNav.action="data_sync.jsp";
				dataNav.target="_blank"
				dataNav.submit();
				
	}
</script>



<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="invoice_export.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">
<input id="sqlIds" name="sqlIds" type="hidden" >
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="fee_name_list" id="fee_name_list"/>
<input type="hidden" name="fee_num_list" id="fee_num_list"/>
<input type="hidden" name="invoice_statues" id="invoice_statues"/>
<input type="hidden" name="invoice_statues_list" id="invoice_statues_list"/>


<!-- �ʽ�ƻ����� -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��Ʊ�ӿڵ���</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));

String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String invoice_statu=getStr(request.getParameter("invoice_statu"));


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr +=" and plan_date>= '"+start_date+"' and plan_date<='"+end_date+"'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}

if(invoice_statu!=null && !invoice_statu.equals("")){
	wherestr +=" and invoice_statues ='" +invoice_statu +"'";
}

countSql = "select count(proj_id) as amount from vi_invoice_export where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select '' ���ݱ��,'' ��������,'' ��Ʊ��,'' ��Ʊ����, cust_name �ͻ�����,'��'+convert(varchar(20),fee_num)+'���ʽ�'+fee_name+'(��������)'  ��Ʒ,'1' ����,plan_money   ����,plan_money ���,invoice_remark ��ע,'' �տ���,'0' ״̬ from vi_invoice_export where 1=1 "+wherestr; 
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,fee_name,fee_num,id from vi_invoice_export where 1=1 "+wherestr;
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
<td>����:&nbsp;<input  name="parent_deptname" id="parent_deptname" size="15"  type="text" value="<%=parent_deptname%>">
<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ����','(select distinct parent_deptname as parent_deptname from v_select_base_department ) a ','parent_deptname','','parent_deptname','parent_deptname','asc','dataNav.parent_deptname','');">
</td>
</tr>
<tr>
<td>��&nbsp;&nbsp;&nbsp;&nbsp;��:
 <input style="width:116px;" name="dept_name" id="dept_name" type="text" value="<%=dept_name%>">
  <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onclick="OpenDataWindow('','','','',' ����','(select distinct dept_name as dept_name,order_field from v_select_base_department ) a ','dept_name','','dept_name','order_field','asc','dataNav.dept_name','');">
</td>

<td >�ƻ�����:&nbsp;<input name="start_date" type="text" size="15" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
��
<input name="end_date" type="text" size="15" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
</tr>
<tr>

<td ><input type="button" value="���" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="��ѯ" onclick="dataNav.submit();"></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="n" onClick="getList();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="ִ��ͬ��" align="absmiddle">ִ��ͬ��</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%">
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>

<!--������ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
	   <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ
	    </th>
     	<th>��Ʊ���ݺ�</th>
		<th>��Ŀ���</th>
	    <th>��ͬ���</th>
		<th>��Ŀ����</th>
	    <th>�ͻ�����</th>
		<th>��������</th>
		<th>��������</th>
		<th>��Ŀ����</th>

		<th>��������</th>
		<th>�ڴ�</th>
		<th>�ƻ�����</th>
		<!--<th>ʵ������</th>-->
	 	<th>�ƻ����</th>
		<th>�������</th>
		<th>��ֵ˰��Ʊ����</th>
		<th>�ʽ�˰��</th>
		<th>��˰��ʶ���</th>
		<th>��˰�˵�ַ</th>
		<th>��˰�˵绰</th>
		<th>��˰�˻���������</th>
		<th>��˰���˺�</th>
		<th>����״̬</th>
		
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_invoice_export where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_invoice_export where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id ";

System.out.println("sqlstr��ѯ����"+sqlstr);

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("out_no")) %>"
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		tax_rate="<%=getDBStr(rs.getString("tax_rate"))%>"
		/></td>
	 
        <td align="left"><%=getDBStr(rs.getString("out_no"))%>	</td>		
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("fee_num"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("plan_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_money"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_type_invoice"))%></td>
     	<td align="left"><%=getDBStr(rs.getString("tax_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_payer_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("address"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tel"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("bank_no"))%></td>
		<td align="left"><%=getDBStr(rs.getString("statues"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</form>

</body>
</html>