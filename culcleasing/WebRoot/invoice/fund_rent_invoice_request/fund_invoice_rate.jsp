<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�Ʊ˰��ά�� </title>
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
	//�ύ��������״̬
	function fundInvoiceRate(){		
			var id_list = '';
			var contract_id_list = '';
			var tax_rate_list='';
			var statues_list='';
			
			var selectedIndex = -1;
			var dataNav = document.getElementById("dataNav");
			var str = document.getElementsByName("checkbos_list");
			
		    var tax_rate = document.getElementById("tax_rate").value;
			if(!tax_rate){
				alert("����д�ʽ�˰�ʣ�");
				return  false;
		    }
			var i = 0;
			for (i = 0; i < str.length; i++)
			{
				if (str[i].checked)
				{
					selectedIndex = i;
					id_list = id_list + str[i].value + "#";
					contract_id_list = contract_id_list + str[i].attributes["contract_id"].nodeValue+"#";	
					statues_list = statues_list + str[i].attributes["statues"].nodeValue+"#";
					
				}
			}
			if (selectedIndex < 0 )
			{
				alert("����ѡ����Ҫ��Ʊ��������!");
				return false;
			}
			
		   id_list = id_list.substring(0,id_list.length-1);		   
		   contract_id_list = contract_id_list.substring(0,contract_id_list.length-1);
		   tax_rate_list = tax_rate_list.substring(0,tax_rate_list.length-1);
		   statues_list = statues_list.substring(0,statues_list.length-1);
		  		
		   document.getElementById('id_list').value = id_list;
		   document.getElementById('contract_id_list').value = contract_id_list;
		   document.getElementById('statues_list').value = statues_list;
		   
			dataNav.action="fund_invoice_rate_save.jsp";
			dataNav.target="_blank";
			dataNav.submit();
			dataNav.action="fund_invoice_rate.jsp";
			dataNav.target="_self";
		  
	}
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
	function piliang(beizhu){
		var bz='invoice_remark_'+beizhu;
		var vu = $("input[name='"+bz+"']").val();
		$("input[id='invoice_remark']").val(vu);
	}

</script>



<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="fund_invoice_rate.jsp" name="dataNav" onSubmit="return goPage()"  confirm="false" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<input type="hidden" name="id_list" id="id_list"/>
<input type="hidden" name="contract_id_list" id="contract_id_list"/>
<input type="hidden" name="statues_list" id="statues_list"/>



<!-- �ʽ�ƻ����� -->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		�ʽ�Ʊ˰��ά��</td>
	</tr>
</table> 

<%
wherestr = "";

String proj_name = getStr( request.getParameter("proj_name") );
String proj_manage_name = getStr( request.getParameter("proj_manage_name") );
String parent_deptname=getStr(request.getParameter("parent_deptname"));
String dept_name=getStr(request.getParameter("dept_name"));
String contract_id = getStr( request.getParameter("contract_id") );


if ( proj_name!=null && !proj_name.equals("") ) {
	wherestr += " and project_name like '%" + proj_name + "%'";
}
if ( proj_manage_name!=null && !proj_manage_name.equals("") ) {
	wherestr += " and proj_manage_name like '%" + proj_manage_name + "%'";
}
if(parent_deptname!=null && !parent_deptname.equals("")){
	wherestr +=" and parent_deptname like '%" + parent_deptname + "%'";
}
if(dept_name!=null && !dept_name.equals("")){
	wherestr +=" and dept_name like '%" + dept_name + "%'";
}
if ( contract_id!=null && !contract_id.equals("") ) {
	wherestr += " and contract_id like '%" + contract_id + "%'";
}

countSql = "select count(proj_id) as amount from vi_fund_invoice_rate where 1=1 "+wherestr;

//��������2--���ݵ���
String expsqlstr = "select proj_id ��Ŀ���,contract_id ��ͬ���,project_name ��Ŀ����,cust_name �ͻ�����,parent_deptname ��������, dept_name ��������,proj_manage_name ��Ŀ����, tax_rate  �ʽ�˰��,creator ������, "+
"create_date  ����ʱ��,modificator ���¸�����,modify_date ���¸���ʱ��  from vi_fund_invoice_rate where 1=1 "+wherestr;
System.out.println("vvvvvvvvvvvvv"+expsqlstr);

String updSql="select contract_id,tax_rate,id from vi_fund_invoice_rate where 1=1 "+wherestr;
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
<td>��&nbsp;&nbsp;&nbsp;&nbsp;��:&nbsp;<input  name="parent_deptname" id="parent_deptname" size="15"  type="text" value="<%=parent_deptname%>">
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
<td>��ͬ���:&nbsp;<input name="contract_id"  type="text" size="15" value="<%=contract_id %>"></td>
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
		<td  width="10%">
		    <img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ʽ�˰��ά��(Alt+N)">&nbsp;&nbsp;
			<input  class="btn_2" type="button"  value="�ύ"  onclick="fundInvoiceRate();">&nbsp;&nbsp;
		</td >
		<td>�ʽ�˰��:
				<select id="tax_rate" name="tax_rate" style="width: 60">
			<script type="text/javascript">
			w(mSetOpt('',"|0.03|0.06|0.17","|0.03|0.06|0.17"));
			</script>
			</select>
		</td>

		<td align="left">
		<!--������ť��ʼ-->
		<input name="expsqlstr" type="hidden" value="<%=expsqlstr %>">
		<input name="updsql" type="hidden" value="<%=updSql %>">
		<input name="excel_name" type="hidden" value="ContractInvoiceItem">
		<!--<BUTTON class="btn_2"  type="button" onclick="return validata_data_report('../../func/exp_report.jsp','contract_invoice_item.jsp');">
		<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>-->
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
   class="maintab_content_table"  >
      <tr class="maintab_content_table_title">
	   <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ
	    </th>
		<th>��Ŀ���</th>	
		<th>��Ŀ����</th>	  
		<th>��ͬ���</th>
		<th>�ʽ�˰��</th>
		<th>״̬</th>
	    <th>�ͻ�����</th>
		<th>��������</th>
	    <th>��������</th>
     	<th>��Ŀ����</th>
		<th>������</th>
		<th>����ʱ��</th>
		<th>���¸�����</th>
		<th>���¸���ʱ��</th>
		
      </tr>
   <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_fund_invoice_rate where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_fund_invoice_rate where 1=1 "+wherestr+" order  by  proj_id,contract_id ) "+wherestr ;
sqlstr +=" order  by  proj_id,contract_id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
	
     <tr class="materTr_<%=index_no %>" id="materTr_<%=index_no %>">
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>" 
		contract_id="<%=getDBStr(rs.getString("contract_id"))%>"
		statues="<%=getDBStr(rs.getString("statues"))%>"
		
		/></td>
		<td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("tax_rate"))%></td>
		<td align="left"><%=getDBStr(rs.getString("statues"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("parent_deptname"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
		<td align="left"><%=getDBStr(rs.getString("creator"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("create_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
		<td align="left"><%=getDBDateStr(rs.getString("modify_date"))%></td>
	
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
