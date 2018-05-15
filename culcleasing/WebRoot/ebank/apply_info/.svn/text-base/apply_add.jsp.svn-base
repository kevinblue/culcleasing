<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>新增 - 代理公司付款(首期付款)</title>
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
			alert("请选择您要申请的项目!");
			return false;
		} else{
			document.dataNav.action="apply_save.jsp";
			if (document.getElementById("pay_method").value.length==0) {
				alert("请选择付款方式!");
				return false;
			} else if (document.getElementById("pay_date").value.length==0) {
				alert("请选择应付日期!");
				return false;
			}
			return confirm("是否确认提交");
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

<!-- 租赁公司、代理商的判断 -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- 租赁公司、代理商的判断 -->

<body onload="public_onload(0);">
<form name="dataNav" method="post" action="apply_add.jsp">
<input id="savetype" name="savetype" type="hidden" value="addHeadPay">
<input id="sqlIds" name="sqlIds" type="hidden" >

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle">
	新增 - 代理公司付款(首期付款)
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

<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">
<%
wherestr=" and 1=1 ";
//查询条件判断
String cname = getStr( request.getParameter("cname") );
String cplx = getStr( request.getParameter("cplx") );
String proj_id = getStr( request.getParameter("proj_id") );
String zzs = getStr( request.getParameter("zzs") );


String plan_start_date = getStr( request.getParameter("plan_start_date") );
String plan_end_date = getStr( request.getParameter("plan_end_date") );

if ( cname!=null && !"".equals(cname) ) {
	wherestr = wherestr + " and  khmc like '%" + cname + "%'";
}
if ( cplx!=null && !"".equals(cplx) ) {
	wherestr = wherestr + " and prod_id ='" + cplx + "'";
}
if ( proj_id!=null && !"".equals(proj_id) ) {
	wherestr = wherestr + " and proj_id like '%" + proj_id + "%'";
}
if ( zzs!=null && !"".equals(zzs) ) {
	wherestr = wherestr + " and manufacturer = '" + zzs + "'";
}

if(plan_start_date!=null&&!plan_start_date.equals("")){
	wherestr+=" and convert(varchar(10),sfk_plan_date,21)>='"+plan_start_date+"' ";
}
if(plan_end_date!=null&&!plan_end_date.equals("")){
	wherestr+=" and convert(varchar(10),sfk_plan_date,21)<='"+plan_end_date+"' ";
}

//根据当前登陆的用户查询出代理公司相关的信息
sqlstr="select gs.bmmc as bmmc,yh.bm as bmid,dl.skyy,dl.skzh from jb_yhxx yh  ";
sqlstr+=" left join jb_gsbm gs on gs.id = yh.bm left join dl_mpxx dl on dl.khbh=gs.bmbh where yh.id='"+dqczy+"' ";

String dld_id ="";
String dld_name ="";

rs=db.executeQuery(sqlstr); 
if (rs.next()) { 
	dld_id=getDBStr(rs.getString("bmid"));
	dld_name=getDBStr(rs.getString("bmmc"));
}
rs.close();

%>
<input type="hidden" name="dld_id" value="<%=dld_id%>">
<input type="hidden" name="dld_name" value="<%=dld_name%>">

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
   <tr>
	 <td scope="row">计划日期:</td>
	 <td>
		 <input name="plan_start_date" type="text" size="18" value="<%=plan_start_date %>"   readonly maxlength="10" dataType="Date">
		 <img  onClick="openCalendar(plan_start_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	 </td>
	<td>- 至 -</td>
	<td>
		<input name="plan_end_date" type="text" size="18" value="<%=plan_end_date %>"   readonly maxlength="10" dataType="Date">
		<img  onClick="openCalendar(plan_end_date);return false" style="cursor:pointer; " 
		 src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  	<td scope="row">客&nbsp;户名&nbsp;称:</td>
    <td> 
		<input name="cname" type="text" size="18" value="<%=cname %>"   maxlength="10">
	</td>  
	<td>
	<input type="button" value="查询" onclick="dataNav.submit();">
	</td></tr>
	<tr>
	<td scope="row">项目编号:</td>
    <td>
      <input name="proj_id" type="text" size="18" value="<%=proj_id %>"   maxlength="20">
    </td>
	<td>制造商:</td>
	<td>
	<select name="zzs" style="width:138px;">
     <script>w(mSetOpt('<%=zzs%>',"<%= zzs_str%>"));</script>
     </select>
	</td>
	 <td scope="row">租赁物类型:</td>
    <td>
     <select name="cplx" style="width:140px;">
     <script>w(mSetOpt('<%=cplx%>',"<%= prod_id_str%>"));</script>
     </select>
    </td>
    <td> 
    <input type="button" value="清空" onclick="clearQuery();">
	</td>
  </tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
<tr>
    <td scope="row">代 理 商:</td>
    <td><b style="color:#E46344;"><%=dld_name %></b></td>
	  <td scope="row">付款方式:</td>
    <td>
	   <select name="pay_method" Require="true" style="width:150px;"></select>
	   <span class="biTian">*</span>
	   <script language="javascript">dict_list("pay_method","PaymentType","","name");</script>
    </td>
     <td scope="row">付款日期:</td>
    <td > 
    <input name="pay_date" type="text"  width="150px;"  readonly maxlength="10" dataType="Date" Require="true">
	<span class="biTian">*</span>
	<img  onClick="openCalendar(pay_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
</tr>
  
<tr>
    <td  scope="row">付款金额:</td>
    <td> 
    <input name="pay_amt" id="pay_amt" type="text" width="150px;" readonly maxlength="10">
	</td>
	 <td scope="row">项目数量:</td>
    <td>
     <input name="proj_number" id="proj_number" type="text" width="150px;" readonly maxlength="10">
    </td>
    <td colspan="2">
	<input name="ck_all" type="checkbox" onclick="isSelectAll();">&nbsp;全选/反选
	</td>
</tr>
</table>

<!-- 数据 -->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">				
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
	<tr class="maintab_content_table_title">
		 <th width="1%"></th> 
		 <th>项目编号</th>
		 <th>客户名称</th>
		 
		 <th>租赁物类型</th>
		 <th>制造商</th>
		 <th>机型</th>
		 <th>出厂编号</th>
		 <th>租赁物购买价款</th>
		       
		 <th>1起租租金</th>
		 <th>2保证金</th>
		 <th>3第一期租金</th>
		 <th>4保险费</th>
		 <th>5手续费</th>
		 <th>6担保费</th>
		 <th>7留购价款</th>
		 <th>计划日期</th>
		 <th>首期付款合计</th>
	</tr>
<tbody id="data">						
<%
sqlstr = "select * from vi_zjfwy where 1=1 "+wherestr+filterAgent+" order by sfk_plan_date";
rs = db.executeQuery(sqlstr); 
//复选框id
String item_id="";
String je="";
while (rs.next()){
	item_id = getDBStr(rs.getString("proj_id"));
	je=getDBStr(rs.getString("first_total_money"));
 %>
<tr>
	<td><input type="checkbox" name="list" onclick="makeValue()" item_id="<%=item_id %>" je="<%=je %>"></td>
	<td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
	<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>

	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("manufacturer")) %></td>
	<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>

	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("qzzj")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bzj")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dyqzj")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("bxf")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("sxf")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("dbf")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lgjk")) %></td>

	<td align="center"><%=getDBDateStr(rs.getString("sfk_plan_date")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_total_money")) %></td>
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
	//项目数量
	$("#proj_number").val(xm_Number);
	//项目金额
	$("#pay_amt").val(total);
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
