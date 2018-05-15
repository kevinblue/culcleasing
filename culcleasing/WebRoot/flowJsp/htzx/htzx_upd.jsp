<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ִͬ�� - �޸�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<%
//��ȡ����item_id
String item_id = getStr( request.getParameter("item_id") ); 
String leas_form = getStr( request.getParameter("leas_form") );
String appendix = getStr( request.getParameter("appendix") );
String ids = getStr(request.getParameter("ids"));
sqlstr = "select * from vi_contract_htzx pffcpt where id='"+item_id+"'";
rs = db.executeQuery(sqlstr);

String contract_id = "";
String project_name = "";
String equip_name = "";
String equip_model = "";
String provider = "";
String equip_manufacturer = "";
String table_type = "";
String equip_price = "";
String equip_num = "";
String total_price = "";
String plan_date = "";
String fact_date = "";
String equip_status = "";
String is_arrive = "";

String equip_id = "";

if(rs.next()){
	contract_id = getDBStr(rs.getString("contract_id"));
	project_name = getDBStr(rs.getString("project_name"));
	equip_name = getDBStr(rs.getString("equip_name"));
	equip_model = getDBStr(rs.getString("equip_model"));
	provider = getDBStr(rs.getString("provider"));
	equip_manufacturer = getDBStr(rs.getString("equip_manufacturer"));
	table_type = getDBStr(rs.getString("table_type"));
	equip_price = CurrencyUtil.convertFinance(rs.getString("equip_price"));
	equip_num = getDBStr(rs.getString("equip_num"));
	total_price = CurrencyUtil.convertFinance(rs.getString("total_price"));
	plan_date = getDBDateStr(rs.getString("plan_date"));
	fact_date = getDBDateStr(rs.getString("fact_date"));
	equip_status = getDBStr(rs.getString("equip_status_name"));
	equip_id= getDBStr(rs.getString("equip_id"));
	is_arrive = getDBStr(rs.getString("is_arrive"));
}

    String sql = "select leas_form from proj_info where contract_id='"+contract_id+"'";
    
%>

<script type="text/javascript">
$(document).ready(function(){
	var brNum = $("br");
	var ids = $("input[name=ids]").val().split(",");
	for(var num = 0;num < brNum.length;num++){
		$(brNum[num]).replaceWith("&nbsp;&nbsp;<input type='button' style='background-color: gray;border: 1px solid gray;color: white;'  value='ɾ��' onclick='hide("+num+")' name='appendix"+num+"'><input type='hidden' name='ids"+num+"'>");
	}
});

function hide(obj){
	var ids = $("input[name=ids]").val().split(",");
	if(confirm("ȷ��ɾ��")){
		$("input[name=ids"+obj+"]").val(ids[obj]);
		//alert($("input[name=ids"+obj+"]").val());
		$("a:eq("+obj+")").css("display","none");
		$("input[name=appendix"+obj+"]").css("display","none");
	}
}

function ismod(){
		var p_date = $("input[name=p_date]").val();
		var plan_date = $("input[name=plan_date]").val();
		var file = $("input[name=name1]").val();
		if(p_date != plan_date && ""==file){
			alert("���ϴ��ļ�");
		}else if(p_date != plan_date && ""!=file){
			$("form[name=form1]").submit();
		}else if(p_date == plan_date){
			$("form[name=form1]").submit();
		}
}

</script>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">��ִͬ��&gt; �޸�</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form id="form1" name="form1" method="post" enctype="multipart/form-data"  action="htzx_upsave.jsp">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="leas_form" value="<%=leas_form %>">
<input type="hidden" name="table_type" value="<%=table_type %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="f_date" value="<%=fact_date %>">
<input type="hidden" name="equip_id" value="<%=equip_id %>">
<input type="hidden" name="p_date" value="<%=plan_date %>">
<input type="hidden" name="ids" value="<%=ids %>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">��ͬ���:</td>
    <td scope="row">
     <%=contract_id %>
     
    </td>
    <td scope="row">��Ŀ����:</td>
    <td scope="row">
     <%=project_name %>
    </td>
  </tr>
  <tr>
    <td scope="row">�豸����:</td>
    <td scope="row">
     <%=equip_name %>
    </td>
    <td scope="row">�豸�ͺ�:</td>
    <td scope="row">
    <%=equip_model %>
    </td>
  </tr>
	  <tr>
    <td scope="row">��Ӧ��:</td>
    <td scope="row">
     <%=provider %>
    </td>
    <td scope="row">������:</td>
    <td scope="row">
     <%=equip_manufacturer %>
    </td>
  </tr>
   </tr>
	  <tr>
    <td scope="row">��ҵ</td>
    <td scope="row">
     <%=table_type %>
    </td>
    <td scope="row">�豸����</td>
    <td scope="row">
    <%=equip_price %>
    </td>
  </tr>
   </tr>
	  <tr>
    <td scope="row">����</td>
    <td scope="row">
    <%=equip_num %>
    </td>
    <td scope="row">�ܼ�</td>
    <td scope="row">
     <%=total_price %>
    </td>
  </tr>
  <tr>
  	<td>�豸����</td>
  	<td>
  		<input type="radio" value="��" name="isDeliver" <%if("��".equals(is_arrive)){ %>checked="checked"<%} %>>��
  		<input type="radio" value="��" name="isDeliver" <%if("��".equals(is_arrive)){ %>checked="checked"<%} %>>��
  	</td>
  	<td scope="row">�ƻ�����</td>
    <td scope="row">
      <input name="plan_date" type="text" style="width:150px;" readonly="readonly" dataType="Date" Require="ture" value="<%=plan_date %>">
    <img  onClick="openCalendar(plan_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
   </tr>
	  <tr>
    <td scope="row">�豸����״̬</td>
    <td scope="row">
		<select style="width:150px;" name="equip_status" id="equip_status" Require="true"></select>
		<script language="javascript" class="text">
		dict_list("equip_status","equip_status","<%=equip_status %>","name");
		</script>
	    <span class="biTian">*</span>
    </td>
    <td scope="row">ʵ������</td>
    <td scope="row">
    <input name="fact_date" type="text" style="width:150px;" readonly="readonly" dataType="Date" Require="ture" value="<%=fact_date %>">
    <img  onClick="openCalendar(fact_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
  </tr>
   </tr>
	  <tr>
    <td scope="row">������</td>
    <td>
    <%=appendix %>
    <!-- �ϴ���� -->
	
	<table id="tabUpFile" border="0" cellpadding="0" cellspacing="0">
	<input type="button" onclick="insRow('tabUpFile')" value="�����ϴ���" name="addFileNum" >
	</table><script>insRow('tabUpFile')</script>
	<!-- End �ϴ���� --><span class="biTian">�����ϴ����ļ�����.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span>
	</td>
	<td></td>
	<td></td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="bafdfa" value="����" type="button" onclick="ismod();"  class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="ȡ��" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div>
<!-- end cwMain -->
</body>

</html>

<%if(null != db){db.close();}%>