<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ�嵥</title>
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
//ɾ��ʱ
function validate_del() {
	var sqlIds="";
 	//var check_amount=0;//ѡ���е�����
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += "'"+ id +"',";		
	});
	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
	if(sqlIds==undefined||sqlIds==""){
		alert("��ѡ��Ҫɾ��������");
	}else{
		
			document.dataNav.action="deletelist.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="deleteContractlistinfo.jsp";
			document.dataNav.target="_self";
		
		
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
	dataNav.action="deleteContractlistinfo.jsp";
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
<form action="deleteContractlistinfo.jsp" name="dataNav">
<input id="sqlIds" name="sqlIds" type="hidden" >
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	��ͬ�嵥</td>
    </tr>
  </table>
  <!--�������-->

<%
wherestr = "";

String phy_contract_id = getStr( request.getParameter("contract_id") );

wherestr+= " and phy_contract_id = '" + phy_contract_id + "'";


//Ȩ���ж�
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from contract_list_info where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	
	
	</table>
	</fieldset>
	</div>
<!--���۵���ѯ����-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
        <td align="left" width="90%" rowspan="2">
        <!--������ť��ʼ-->
      <table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	     
	        <td>
				<BUTTON class="btn_2" name="btndel" value="ɾ��"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;ɾ��</button>
			</td> 
		
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
	    <th width="1%">��ͬ���</th>
	    <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">ȫѡ
	    </th>
	    <th>��ͬ����</th>
	    <th>��ͬ���</th>
	    <th>��ͬ���</th>
	    <th>ǩԼ��</th>
	    <th>��ͬ״̬</th> 
		<!--<th>����</th>-->
      </tr>
      <tbody id="data">
<%
String col_str="*";

sqlstr = "select top "+ intPageSize +" "+col_str+" from contract_list_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from contract_list_info where 1=1 "+wherestr+" order by id,create_date desc ) "+wherestr ;
sqlstr += " order by id,create_date desc ";

LogWriter.logDebug(request, "��ͬ�嵥###"+sqlstr);
int i=1;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center"><%=i %></td>
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("id")) %>"
		/></td>
        <td align="center"><%=getDBStr( rs.getString("contract_name") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("make_contract_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("contract_main_type") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("sign_way") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("contract_status") ) %></td>
	
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
