<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp" %>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�ƻ� - ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkAm(){
	var $amou = $(":checkbox:checked").length
	if($amou>0){
		$(":input[name='ckAmount']").val("2");
	}else{
		if(!confirm("��δѡ�񸶿�ǰ�ᣬȷ���ύ��")){
			return false;
		}
	}
}
</script>
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

sqlstr = "select fee_type_name,plan_money from dbo.vi_proj_fund_fund_charge_plan_temp where payment_id='"+item_id+"'";

String fee_type_name = "";
String plan_money = "";

rs = db.executeQuery(sqlstr);

if(rs.next()){
	fee_type_name = getDBStr(rs.getString("fee_type_name"));
	plan_money = getDBStr(rs.getString("plan_money"));
}
rs.close();
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">�ʽ�ƻ�&gt; ����ǰ��</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_condsave.jsp" onSubmit="return checkAm();">
<input type="hidden" name="type" value="add">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="ckAmount" value="0">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">��������</td>
    <td scope="row"><%=fee_type_name %></td>
   	<td scope="row">�ƻ����</td>
    <td scope="row"><%=plan_money %></td>
  </tr>

  <tr>
    <td scope="row">����ǰ��</td>
    <td scope="row" colspan="3">
		<%
		sqlstr = "select name,title from dbo.ifelc_conf_dictionary where parentid like '%PaymentPremise%' and type='p' order by parentId";
		rs = db.executeQuery(sqlstr);
		String name = "";
		String title = "";
		while(rs.next()){
			name = getDBStr(rs.getString("name"));
			title = getDBStr(rs.getString("title"));
			//�жϸ����Ƿ�ѡ��
			String partSql = "select id from proj_fund_fund_charge_condition_temp where payment_id='"+item_id+"' and pay_condition='"+name+"'";
			ResultSet rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				%>
				<input type="checkbox" name="cond" value="<%=name %>" checked="checked"><%=title %><br/>
				<%
			}else{
				%>
				<input type="checkbox" name="cond" value="<%=name %>"><%=title %><br/>
				<%
			}
		}
		rs.close();
		db.close();
		%>		
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="����" type="submit" class="btn3_mouseout"></td>

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

<%if(null != db1){db1.close();}%>