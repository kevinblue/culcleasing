<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��˰����Ϣȷ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function isSelectAll() {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
}

function  getList(){
	//�õ���ѡ��ļ���
	var sqlIds="";
 	//var check_amount=0;//ѡ���е�����
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += id +",";

		

		
	});

	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1).replace("'",""));
	dataNav.action="taxpayer_confirm_data_sync.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			
}

function  backInfo(){
	//�õ���ѡ��ļ���
	var sqlIds="";
 	//var check_amount=0;//ѡ���е�����
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds +=  id +",";

		

		
	});

	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1).replace("'",""));
	dataNav.action="taxpayer_back_data_sync.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->


<body onLoad="public_onload(0);">
<form action="taxpayer_info_confirm.jsp" name="dataNav">
<input id="sqlIds" name="sqlIds" type="hidden" >
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	��˰����Ϣȷ��</td>
    </tr>
  </table>
  <!--�������-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String userid = (String) session.getAttribute("czyid");
String wh_status = getStr( request.getParameter("wh_status") );
if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}
if(wh_status!=null && !"".equals(wh_status)){
	wherestr+= " and wh_status like '%" + wh_status + "%'";
}

//Ȩ���ж�
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);
//ADMN-8GRBW4
if(("ADMN-8GRBW4").equals(userid)){
	
}else if(("ADMN-AP5BVP").equals(userid)){
	wherestr+= "and wh_confirm_user = '������'";
}else if(("ADMN-AP5BVM").equals(userid)){
	wherestr+= "and wh_confirm_user = '������'";
}
//ADMN-AP5BVP
//wherestr+= "and wh_confirm_user = '������'";
//ADMN-AP5BVM
//wherestr+= "and wh_confirm_user = '������'";
countSql = "select count(id) as amount from vi_base_taxPayer_request where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		�ͻ����&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		�ͻ�����&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>
	<td>ά��״̬:
	<select name="wh_status" style="width:105">
		<script type="text/javascript">
			w(mSetOpt('<%=wh_status%>',"|������|��ȷ��","|������|��ȷ��"));
		</script>
	 </select>
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


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
      <td align="left" width="90%" rowspan="2"><!--������ť��ʼ-->
  	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="n" onClick="getList();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="ȷ��" align="absmiddle">ȷ��</a></td>
			<td><a href="#" accesskey="n" onClick="backInfo();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="�˻�" align="absmiddle">�˻�</a></td>
	    </tr>
	</table>
        <!--������ť����--></td>
        <td align="right" width="20%" colspan="2"><!--��ҳ���ƿ�ʼ-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--��ҳ���ƽ���-->
  
  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%">���</th>
	    <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ
	    </th>	    
	    <th>�ͻ�����</th>
	    <th>�ͻ�����</th>
	    <th>��˰��˰��</th>
	    <th>��ַ</th>
	    <th>�绰</th>
	    <th>��˰�˻���������</th>
	    <th>��˰���˺�</th>
	    <th>��Ʊ����</th>	  
	    <th>ά��״̬</th>  
	    <th>ά����</th>
	    <th>ȷ����Ա</th>
		<th>ά��ʱ��</th>	
      </tr>
      <tbody id="data">
<%
String col_str="id, cust_name, cust_id,tax_payer_no,tax_type_invoice,address,tel,bank_name,bank_no,wh_status,wh_modificator,wh_confirm_user,wh_modify_date ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_base_taxPayer_request where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_base_taxPayer_request where 1=1 "+wherestr+" order by  id  desc ) "+wherestr ;
sqlstr += " order by id desc ";

LogWriter.logDebug(request, "���˿ͻ���Ϣ����###"+sqlstr);
int i=0;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center"><%=i %></td>
        <td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>"
		/></td>	
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("tax_payer_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("address") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tel") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("bank_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tax_type_invoice") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_status") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_modificator") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_confirm_user") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("wh_modify_date") ) %></td>
		
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- ������� -->

</form>
</body>
</html>
