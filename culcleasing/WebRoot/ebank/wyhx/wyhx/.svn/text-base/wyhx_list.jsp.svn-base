<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>资产管理(首期付款) - 网银核销</title>
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
<form action="wyhx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="sqlstr" value="<%=sqlstr %>" type="hidden">

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		资产管理(首期付款)&gt; 网银核销
		</td>
	</tr>
</table>
<!--标题结束-->
<%
String start_date = getStr(request.getParameter("start_date"));
String end_date = getStr(request.getParameter("end_date"));
String proj_id = getStr(request.getParameter("proj_id"));
String contract_id = getStr(request.getParameter("contract_id"));
String prod_id = getStr(request.getParameter("prod_id"));
String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String bank = getStr(request.getParameter("bank"));

wherestr=" where 1=1 ";
if(!start_date.equals("")){
	wherestr+=" and convert(varchar(10),proj_info.create_date,21)>='"+start_date+"' ";
}
if(!end_date.equals("")){
	wherestr+=" and convert(varchar(10),proj_info.create_date,21)<='"+end_date+"' ";
}
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

sqlstr=" select vi_cust_all_info.card_id,vi_cust_all_info.cust_name,proj_info.account,proj_info.bank, ";
sqlstr+=" a.plan_money,a.proj_id as memo from ( select proj_id,sum(plan_money) as plan_money from fund_fund_charge_plan where ";
sqlstr+=" item_method='网银' and isnull(status,'0')<>'1' and funds_mode='收款' and isnull(export_flag,'')='1' group by proj_id)a ";
sqlstr+=" left join proj_info on a.proj_id=proj_info.proj_id left join dl_mpxx on proj_info.agent_id=dl_mpxx.khbh left join ";
sqlstr+=" vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id "+wherestr;

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
<td>立项&nbsp;&nbsp;日期:<input name="start_date" type="text" size="12" readonly dataType="Date" value="<%=start_date %>"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>
-至-
<input name="end_date" type="text" size="10" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
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
		<a href="#" accesskey="n" onclick="xx_submit('核销')">
		<img align="absmiddle"  src="../../images/sbtn_new.gif" alt="上传扣款回执" align="absmiddle">上传扣款回执</a>
		<BUTTON class="btn_2" name="btnModify" value="重置"  type="button" onclick="updateState(); ">
		<img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">重置</button>
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
	<%@ include file="../../public/pageSplitNoCode.jsp" %>
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
		<th>客户姓名</th>
		<th>开户银行</th>
		<th>客户帐号</th>
		<th>金额</th>
		<th>备注(项目编号)</th>
      </tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("memo"))%>"></td>
        <td align="center"><%= getDBStr( rs.getString("card_id") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("account") ) %></td>
        <td align="center"><%=formatNumberDoubleTwo( rs.getString("plan_money") ) %></td>
        <td align="center"><%= getDBStr( rs.getString("memo") ) %></td>
      </tr>
<%
	rs.next();
	i++;
}}
rs.close(); 
db.close();
%>
 </tbody> </table>
</div>
<!--报表结束-->
<script language="javascript">
function xx_submit(str){
  	if(str=="导出"){
  		dataNav.action="export_save.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}if(str=="核销"){
		//判断是否有数据
		if($("#data>tr").size()==0 ){
			alert("对不起，暂无审核数据，无法操作！");
			return false;
		}
  		dataNav.action="wyhx_upload.jsp";
  		dataNav.target="_black";
  		dataNav.submit();
  	}else{
  		dataNav.action="wyhx_list.jsp";
  		dataNav.target="";
  		dataNav.submit();
  	}
  	dataNav.action="wyhx_list.jsp";
  	dataNav.target="_self";
}

String.prototype.trim = function()
{
    return this.replace(/(^\s*)|(\s*$)/g, "");
};
  
var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
function stateChanged(){	
	if(xmlHttp.readyState == 4)	{
		var returnvalue=xmlHttp.responseText ;
		if(returnvalue!=""){
			if (returnvalue.trim()=="-1") {
				alert("修改状态成功!");
				window.location.reload(true);	
			} else {
				alert("修改状态失败!");
			}
		}
	}	
}

var sql_bh_ids="";
function updateState(){
  	xmlHttp = GetXmlHttpObject();
	if (validate_sel()){ 
		if (confirm("慎重:确认后会将历史记录修改!")){
			var url = "state_check.jsp?sql_bh_ids="+sql_bh_ids;
		  	xmlHttp.onreadystatechange = stateChanged;	
		  	xmlHttp.open("POST",url,false);
		  	xmlHttp.send(null);
		} 
	}	
}
</script>

<script type="text/javascript">
	function validate_sel() {
	//是否有选中的付款单号
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//保存所要删除的付款单号
	 sql_bh_ids="";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].value;
			str_bh+=fid+",";
			sql_bh_ids+="'"+fid+"',";
		}
	}
	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	if (flag_bh==0) {
		alert("请选择您要重置的项目!");
		return false;
	}else {
		return true;
	}		
}		
</script>
</form>
</body>
</html>		
		