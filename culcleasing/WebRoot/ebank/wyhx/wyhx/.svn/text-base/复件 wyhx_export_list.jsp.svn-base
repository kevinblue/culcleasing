<%@ page contentType="text/html; charset=gbk" language="java"   errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理(首期付款) - 网银申请</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<body onload="public_onload(0);">
<form action="wyhx_export_list.jsp" name="dataNav" onSubmit="return goPage()">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资产管理(首期付款)&gt; 网银申请
		</td>
	</tr>
</table><!--标题结束-->
<%
wherestr=" where proj_info.proj_status>=10";

String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String proj_id = getStr(request.getParameter("proj_id"));
String contract_id = getStr(request.getParameter("contract_id"));
String prod_id = getStr(request.getParameter("prod_id"));
String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String bank = getStr(request.getParameter("bank"));

if(!proj_id.equals("")){
	wherestr+=" and a.proj_id like '%"+proj_id+"%'";
}
if(!prod_id.equals("")){
	wherestr+=" and proj_info.prod_id = '"+prod_id+"'";
}
if(!dld_name.equals("")){
	wherestr+=" and dl_mpxx.khmc like '%"+dld_name+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vi_cust_all_info.cust_name like '%"+cust_name+"%'";
}
if(!bank.equals("")){
	wherestr+=" and proj_info.bank = '"+bank+"'";
}

if(!start_date.equals("")){
	wherestr+=" and convert(varchar(10),proj_info.create_date,21)>='"+start_date+"' ";
}
if(!end_date.equals("")){
	wherestr+=" and convert(varchar(10),proj_info.create_date,21)<='"+end_date+"' ";
}

sqlstr=" select vi_cust_all_info.card_id,vi_cust_all_info.cust_name,proj_info.account,proj_info.bank,a.plan_money,a.proj_id as memo ";
sqlstr+=" from ( select proj_id,sum(plan_money) as plan_money from fund_fund_charge_plan where item_method='网银' and ";
sqlstr+=" isnull(status,'0')<>'1' and funds_mode='收款' and isnull(export_flag,'')<>'1' group by proj_id ) a left join proj_info on ";
sqlstr+=" a.proj_id=proj_info.proj_id left join dl_mpxx on proj_info.agent_id=dl_mpxx.khbh left join vi_cust_all_info on ";
sqlstr+=" proj_info.cust_id=vi_cust_all_info.cust_id "+wherestr;

String exesqlstr = sqlstr +" and a.proj_id in ";
%>
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="96%" cellspacing="5" cellpadding="0">
<tr>
<td>客户名称:<input name="cust_name" type="text" size="12" value="<%=cust_name %>"></td>
<td>租赁物类型:<select name="prod_id" style="width:115">
     <script>w(mSetOpt('<%=prod_id%>',"<%= prod_id_str%>"));</script>
     </select>
</td>
<td>银行:<select name="bank" style="width:95">
     <script>w(mSetOpt('<%=bank%>',"<%=bank_str%>"));</script>
     </select>
</td>
<td>项目编号:<input name="proj_id" type="text" size="12" value="<%=proj_id %>"></td>
</tr>
<tr>

<td>代   理   商:<input name="dld_name" type="text" size="12" value="<%=dld_name %>">
<td>立项&nbsp;&nbsp;日期:<input name="start_date" type="text" size="12" readonly dataType="Date" value="<%=start_date %>">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
-至-
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td align="left">
<input type="button" value="查询" onclick="xx_submit('查询');">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();">
</td>
</tr>
</table>
</fieldset>
</div>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td align="left" width="1%">
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td nowrap>
		<input type="hidden" name="expsqlstr" id="expsqlstr" value="<%=exesqlstr %>" />
		<BUTTON class="btn_2" type="button" onclick="return validata_headpay_exp_do_all('export_save.jsp')">
		<img src="../../images/save.gif" align="absmiddle" border="0">申请导出</button>
		</td>
		<td nowrap>
		   <span style="color:#154288;height:18px;font-size:13px;">
		   核销银行(模板):
		   </span>
		  <select name="hxBank">
			  <option value="">--请选择--</option>
			  <option value="jsBank">建设银行</option>
			  <option value="msBank">民生银行</option>
		   </select>
		</td>
		<td>
			<img src="../../images/sbtn_split.gif" width="2" height="14">
		</td>
		<td nowrap>
			<input name="ck_all" type="checkbox">&nbsp;全选
		</td>
    </tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">										 	
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
	<!--翻页控制结束-->
	</td>
</tr>
</table>


<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>	
		<th>客户身份证号</th>
		<th>客户名称</th>
		<th>开户银行</th>
		<th>客户帐号</th>
		<th>金额</th>
		<th>备注(项目编号)</th>
      </tr>
<tbody id="data">
<%	  
String item_id = "";
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	item_id = getDBStr( rs.getString("memo") );
%>

      <tr>
		<td><input type="checkbox" name="list" item_id="<%=item_id %>" /></td>
      	<td align="center"><%=getDBStr( rs.getString("card_id") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("bank") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("account") ) %></td>
        <td align="right"><%=CurrencyUtil.convertFinance( rs.getDouble("plan_money") ) %></td>
        <td align="center"><%=getDBStr( rs.getString("memo") ) %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%></tbody></table>
</div>
<!--报表结束-->
</form>
</body>
</html>
<script language="javascript">
function xx_submit(str){
  	if(str=="导出"){
  		dataNav.action="export_save.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}else if(str=="核销"){
  		dataNav.action="wyhx_upload.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}else{
  		dataNav.action="wyhx_export_list.jsp";
  		dataNav.target="";
  		dataNav.submit();
  	}
  	dataNav.action="wyhx_export_list.jsp";
  	dataNav.target="_self";
}

function validata_headpay_exp_do_all(destUrl) {
	//判断是否有数据
	if($("#data>tr").size()==0 ){
		alert("对不起，暂无数据，无法操作！");
		return false;
	}
	//判断是否开户银行相同
	if( $("select[name='bank']").val()=="" ){
		alert("请您选择开户银行以保证当前数据正确！");
		return false;
	}
	//判断是否选择核销银行
	if( $("select[name='hxBank']").val()=="" ){
		alert("对不起，请您选择核销银行！");
		return false;
	}
	var flag = 0;
	//判断栓选的数据是否一致
	$("#data>tr").each(function(){
		//alert($(this).find("td:eq(3)").text());
		if( $(this).find("td:eq(3)").text()!=$("select[name='bank']").val() ){
			flag = 1;
			alert("请您选择银行并执行查询！");
			return false;
		}
	});
	if(flag==1){
		return false;
	}
	//得到复选框的集合
	var sqlIds="";
	var check_amount=0;//选中行的数量
	$("input[name^='list']:checked").each(function(){
		check_amount++;
		var id = $(this).attr("item_id");
		sqlIds += "'"+ id +"',";
	});
	if (check_amount==0)  {
		alert("请勾选您要导出的项目!");
		return false;
	}else{
		//得到复选框的集合
		if (confirm("是否导出文件?")) {//导出Excel
			$("input[name='expsqlstr']").val($.trim($("#expsqlstr").val())+" ("+sqlIds.substring(0,sqlIds.length-1)+" )");

			$("form[name='dataNav']").attr("action",destUrl);
			$("form[name='dataNav']").attr("target","_black");

			dataNav.submit();
			window.location.reload(true);
		}
		return false;
	}
}
</script>