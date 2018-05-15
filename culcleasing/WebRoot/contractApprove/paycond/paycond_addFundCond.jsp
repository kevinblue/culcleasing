<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp" %>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>付款前提 - 新增</title>
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
	var $amou = $(":checkbox:checked").length;
	if($amou>0){
		$(":input[name='ckAmount']").val("2");
	}else{
		if(!confirm("您未选择付款前提，确认提交吗？")){
			return false;
		}
	}
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%
//提取参数item_id
String item_id = getStr( request.getParameter("item_id") );
String doc_id = getStr( request.getParameter("doc_id") );

sqlstr = "select fee_type_name,plan_money from dbo.vi_contract_fund_fund_charge_plan_temp where doc_id='"+doc_id+"' and payment_id='"+item_id+"'";

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
<td class="tree_title_txt"  height=26 valign="middle" align="left">付款前提</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="paycond_condsave.jsp" onSubmit="return checkAm();">
<input type="hidden" name="type" value="add">
<input type="hidden" name="item_id" value="<%=item_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="ckAmount" value="0">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">款项名称</td>
    <td scope="row"><%=fee_type_name %></td>
   	<td scope="row">计划金额</td>
    <td scope="row"><%=plan_money %></td>
  </tr>

  <tr>
    <td scope="row">付款前提</td>
    <td scope="row" colspan="3">
    	<%
		String partSql = "";
		String partSql2 = "";
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String partName = "";
		String partTitle = "";
		//查询资料大类
		sqlstr = "select name,title from dbo.ifelc_conf_dictionary where parentid='PaymentPremise' order by id";
		rs = db.executeQuery(sqlstr);
		String name = "";
		String title = "";
		while(rs.next()){
			name = getDBStr(rs.getString("name"));
			title = getDBStr(rs.getString("title"));
			%>
			<!--可折叠查询开始-->
			<div style="width:80%;">
			<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
			  <legend>&nbsp;<%=title %>
				<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
				style="cursor:hand" title="显示/隐藏内容">&nbsp;
			</legend>
			<table border="0" width="100%" cellspacing="5" cellpadding="0">
				
				<%
					//查询该大类下小类资料
					partSql = "select name,title from ifelc_conf_dictionary where parentid='"+name+"' order by orderflag";
					rs1 = db1.executeQuery(partSql);
					while(rs1.next()){
						partName = getDBStr(rs1.getString("name"));
						partTitle = getDBStr(rs1.getString("title"));
						//判断该项是否选中
						partSql2 = "select id from contract_fund_fund_charge_condition_temp where doc_id='"+doc_id+"' and payment_id='"+item_id+"' and pay_condition='"+partName+"'";
						rs2 = db2.executeQuery(partSql2);
						if(rs2.next()){
							%>
							<tr>
							<td>
								<input type="checkbox" name="cond" value="<%=partName %>" checked="checked"><%=partTitle %>
							</td>
							</tr>
							<%
						}else{
							%>
							<tr>
							<td>
								<input type="checkbox" name="cond" value="<%=partName %>"><%=partTitle %>
							</td>
							</tr>
							<%
						}
						rs2.close();
					}
					rs1.close();
				%>
			</table>
			</fieldset>
			</div>
			<!--可折叠查询结束-->
			<%
		}
		rs.close();
		db.close();
		db1.close();
		db2.close();
		%>		
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
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

