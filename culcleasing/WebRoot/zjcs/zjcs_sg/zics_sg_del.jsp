<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 不规则租金测算删除</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
	function chek_dal(){
		var rent_list = document.getElementById('rent_list').value;
		if(confirm('确定从'+rent_list+'期开始删除大于等于该期后的所有偿还计划?')){
			form1.submit();
		}else{
			return false;
		}
	}
</script>
</head>
<%
	ResultSet rs;
	String czid = getStr( request.getParameter("czid") );
	
	//接参数
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
	String contract_id = getStr(request.getParameter("contract_id"));//合同编号
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String temp = getStr(request.getParameter("temp"));//用于判断是项目还是合同的操作
	String savetype = getStr(request.getParameter("savetype"));//操作类型
	String key_id = getStr(request.getParameter("itemselect"));//id
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	
	
	String sqlstr = "";
	//判断要修改的期项是否是未回笼
	String plan_status = "";
	String	rent_list = "";
	String	plan_date = "";
	String	rent = "";
	String	corpus = "";
	String	interest = "";
	String	corpus_overage_market = "";//市场本金余额
	//项目交易结构
	if (temp.equals("proj_zjcs")){
		sqlstr = " select * from fund_rent_plan_proj_temp where id = '"+key_id+"' and proj_id = '"+proj_id+"' and measure_id = '"+doc_id+"' ";
	}//项目交易结构结束
	//###################################################################################################
	//								合同偿还计划手工调整
	//###################################################################################################
	else if(temp.equals("contract_zjcs")){
		sqlstr = " select * from fund_rent_plan_temp where id = '"+key_id+"' and contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
	}
	rs = db.executeQuery(sqlstr);
	System.out.println("sql==> : "+sqlstr);
	while(rs.next()){
		rent_list = getDBStr(rs.getString("rent_list") );
		plan_date = getDBDateStr(rs.getString("plan_date") );
		rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
		corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")));
		interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")));
		plan_status = getDBStr( rs.getString("plan_status") );
		corpus_overage_market = getDBStr( rs.getString("corpus_overage_market") );
	}
	if(plan_status.equals("已回笼") || plan_status.equals("部分回笼")){
%>
		<script>
			window.close();
			opener.alert("该笔租金已回笼或者部分回笼!");
			opener.location.reload();
		</script>
<%
		rs.close();
		db.close();
		return;
	}else{
		rs.close(); 
		db.close();
	}
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="zjcs_sg_save.jsp" onSubmit="return checkdata(this);">	

<input type="hidden" name="savetype" value="<%=savetype%>">
<input type="hidden" name="czid" value="<%=czid%>">
<input type="hidden" name="doc_id" value="<%=doc_id%>">
<input type="hidden" name="contract_id" value="<%=contract_id%>">
<input type="hidden" name="proj_id" value="<%=proj_id%>">
<input type="hidden" name="temp" value="<%=temp%>">
<input type="hidden" name="key_id" value="<%=key_id%>">
<input type="hidden" name="rent_list" value="<%=rent_list%>">



<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同信息 &gt; 不规则租金测算修改删除
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	  <td><!-- type="submit"  -->
		<BUTTON class="btn_2" name="btnSave" value="删除" onclick="chek_dal();" >
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
	  	<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
		</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
    <tr>
	<td>
		编号
	</td>
	<!-- 有可能是项目编号  -->
	<td colspan="4">
		<%
			if (temp.equals("proj_zjcs")) {
		%>
		<input name="name_id" type="text" size="50" maxB="50"
			Require="ture" value="<%=proj_id%>" readonly>
		<%
			}
			if (temp.equals("contract_zjcs")) {
		%>
		<input name="name_id" type="text" size="50" maxB="50"
			Require="ture" value="<%=contract_id%>" readonly>
		<%
			}
		%>
	</td>
</tr>	
  <tr>
    <td scope="row" nowrap width="20%">期项：</td>
    <td colspan=""><%=rent_list %></td>
    <td scope="row" nowrap width="20%">承付日期：</td>
    <td><%=plan_date %></td>
    <td scope="row" nowrap width="20%">租金：</td>
    <td><%=rent %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">市场本金：</td>
    <td><%=corpus %></td>
    <td scope="row" nowrap width="20%">市场利息：</td>
    <td><%=interest %></td>
    <td>市场本金余额：</td>
    <td> <%=corpus_overage_market%>  </td>
  </tr>
</table>
<br>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

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

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
</script>
</form>
<!-- end cwMain -->
</body>
</html>
