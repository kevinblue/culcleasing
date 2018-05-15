<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>新增 - 网银资金收款</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

	<script language="javascript" src="/dict/js/js_dictionary.js"></script>
	<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

	<script src="../../js/comm.js"></script>
	<script src="../../js/validator.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	// 是否可以提交付款申请
	function isSub(obj) {
		var names=document.getElementsByName("list");
		var statu=0;
		for(i=0;i<names.length;i++){
			if (names[i].checked){
				statu++;
			}
		}
		if (statu==0) {
			alert("请选择您要申请的款项!");
			return false;
		} else{
			document.dataNav.action="apply_save.jsp";
			if (document.getElementById("method").value.length==0) {
				alert("请选择结算方式!");
				return false;
			} 
			return confirm("是否确认提交？");
		}
		return false;
	}
	</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<body onload="public_onload(0);">
<form name="dataNav" method="post" action="apply_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="addEbankFund">
<input id="sqlIds" name="sqlIds" type="hidden" >

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle">
	新增 - 网银资金收款
	</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
	<!--操作按钮开始-->
	<tr><td>
	<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
		<BUTTON class="btn_2" value="保存"  type="submit"  onclick="return isSub(this);" >
		<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>

		<BUTTON class="btn_2" value="取消" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
		</td>
	  </tr>
	</table>
	</td></tr><!--操作按钮结束-->
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>

<tr><td width="100%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">新增信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
 </tr>
</table></td></tr> 

<script language="javascript">
ShowTabN(0);
</script>

<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:80%;overflow:auto;">
<div id="TD_tab_0">
<%
//if ((dqczy==null) || (dqczy.equals("")))
//{
 // dqczy="无认证";
  //response.sendRedirect("../../noright.jsp");
//}

wherestr="";
//查询条件判断
String project_name = getStr( request.getParameter("project_name") );

String plan_start_date = getStr( request.getParameter("plan_start_date") );
String plan_end_date = getStr( request.getParameter("plan_end_date") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr = wherestr + " and project_name like '%" + project_name + "%'";
}

if(plan_start_date!=null&&!plan_start_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+plan_start_date+"' ";
}
if(plan_end_date!=null&&!plan_end_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+plan_end_date+"' ";
}
if(plan_start_date==null&&plan_start_date.equals("")&&plan_end_date==null&&plan_end_date.equals("")){
	wherestr+=" and plan_date < DateAdd(day,5,getdate())";
}

//项目经理只能查询自己当前的项目
//wherestr += " and proj_manage='"+dqczy+"'";

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
   <tr>
   	<td scope="row" width="100">项目名称:</td>
    <td width="250"> 
		<input name="project_name" type="text" size="18" value="<%=project_name %>" >
	</td>  
	
	<td scope="row" width="150">计划日期:</td>
	<td width="300">
	 <input name="plan_start_date" type="text" size="10" value="<%=plan_start_date %>"   readonly maxlength="10" dataType="Date">
	 <img  onClick="openCalendar(plan_start_date);return false" style="cursor:pointer; " 
	 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 &nbsp;至&nbsp;
	<input name="plan_end_date" type="text" size="10" value="<%=plan_end_date %>"   readonly maxlength="10" dataType="Date">
	<img  onClick="openCalendar(plan_end_date);return false" style="cursor:pointer; " 
	 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td> 
	<td align="left">
	<input type="button" value="查询" onclick="dataNav.submit();">
	&nbsp;&nbsp;
	<input type="button" value="清空" onclick="clearQuery();">
	</td></tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!-- 生成区域 -->
<table border="0" cellspacing="0" cellpadding="0" width="1200" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="7"></td>
</tr>
  
<tr>
    <td  scope="row">收款金额:</td>
    <td> 
    <input name="amt" id="amt" type="text" width="150px;" readonly maxlength="10">
	</td>
	 <td scope="row">数量:</td>
    <td>
     <input name="amount" id="amount" type="text" width="150px;" readonly maxlength="10">
    </td>
     <td scope="row"></td>
    <td>
    </td>
    <td> 
	 <input name="ck_all" type="checkbox" onclick="isSelectAll();" style="border: none;">&nbsp;全选
    </td>
</tr>
</table>

<!-- 数据列表 -->
<div style="vertical-align:top;width:1200;overflow:auto;position: relative;height:80%;" id="mydiv">				
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
	<tr class="maintab_content_table_title">
		 <th width="1%"></th> 
		 <th>项目名称</th>
		 <th>合同编号</th>
		 <th>款项方式</th>
	     <th>款项内容</th>
	     <th>序号</th>
	     <th>款项名称</th>
	     <th>结算方式</th>
	     <th>付款人</th>
	     <th>付款人账号</th>
	     <th>收款日期</th>
	     <th>币种</th>
	     <th>收款金额</th>
	     <th>计划收款开户银行</th>
	     <th>计划收款银行账号</th>
	     <th>备注</th>
	</tr>
<tbody id="data">						
<%
sqlstr = "select * from vi_ebank_fund_hire where 1=1 "+wherestr+" order by contract_id";
rs = db.executeQuery(sqlstr); 
//复选框id
String item_id="";
String je="";
while (rs.next()){
	item_id = getDBStr(rs.getString("id"));
	je=getDBStr(rs.getString("plan_money"));
 %>
<tr>
	<td><input type="checkbox" name="list" onclick="makeValue()" style="border: none;" item_id="<%=item_id %>" je="<%=je %>"></td>
	<td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>

	<td align="center"><%=getDBStr(rs.getString("pay_way")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("pay_type_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("pay_obj_name")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("pay_bank_no")) %></td>
   	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
   	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("plan_bank_no")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("fpnote")) %></td>
</tr>
<%	} %>
</tbody>
</table>
</div>
</div>
</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>
</div>
<!--添加结束-->
<%
rs.close(); 
db.close();
%> 
</form>
<!-- end cwMain -->
<script type="text/javascript">
//总金额
var total=0;
//总项目数
var xm_Number=0;
//项目id
var sqlIds="";

//更新项目数量与金额
function makeValue(){
	total = 0;
	xm_Number = 0;

	//得到复选框的集合
	sqlIds="";
 	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		xm_Number++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
		var je = $(this).attr("je");
		total = accAdd(total, je);
	});
	//alert(total+"___"+xm_Number);
	//更新信息
	updateInfo();
}

//求和函数
function accAdd(arg1,arg2){
	var r1,r2,m; 
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	m=Math.pow(10,Math.max(r1,r2));
	return (arg1*m+arg2*m)/m;
} 

//更新项目数量、金额
function updateInfo(){
	//数量
	$("#amount").val(xm_Number);
	//金额
	$("#amt").val(total);
	//主键id
	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
}

//全选
function isSelectAll () {
	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	makeValue("ck_0");
}
</script>
</body>
</html>
