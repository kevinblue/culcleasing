<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 偿还计划修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String sqlstr;
	ResultSet rs;
	String czid = getStr( request.getParameter("czid") );
	//判断要修改的期项是否是未回笼
	String plan_status="";
	sqlstr="select plan_status from fund_rent_plan where contract_id+convert(varchar(10),rent_list)=(select contract_id+convert(varchar(10),rent_list) from fund_rent_plan_temp where id='"+czid+"')";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		plan_status=getDBStr( rs.getString("plan_status") );
	}rs.close();
	if(plan_status.equals("已回笼") || plan_status.equals("部分回笼")){
		%>
		<script>
			window.close();
			opener.alert("该笔租金已回笼或者部分回笼!");
			opener.location.reload();
		</script>
		<%
	}
	
	sqlstr = "select fund_rent_plan_temp.id,fund_rent_plan_temp.measure_id,fund_rent_plan_temp.measure_date,fund_rent_plan_temp.contract_id,fund_rent_plan_temp.rent_list,fund_rent_plan_temp.plan_status,fund_rent_plan_temp.plan_date,fund_rent_plan_temp.eptd_rent,fund_rent_plan_temp.rent,fund_rent_plan_temp.corpus,fund_rent_plan_temp.year_rate,fund_rent_plan_temp. interest,fund_rent_plan_temp.rent_overage,fund_rent_plan_temp.corpus_overage,fund_rent_plan_temp.interest_overage,fund_rent_plan_temp.penalty_overage,fund_rent_plan_temp.penalty,fund_rent_plan_temp.rent_type,fund_rent_plan_temp. creator,fund_rent_plan_temp.create_date,fund_rent_plan_temp.modificator,fund_rent_plan_temp.modify_date from fund_rent_plan_temp where fund_rent_plan_temp.id='"+czid+"'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	rs = db.executeQuery(sqlstr); 

	String	contract_id = "";
	String	rent_list = "";
	String	plan_date = "";
	String	rent = "";
	String	corpus = "";
	String	year_rate = "";
	String	interest = "";


	if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		rent_list = getDBStr( rs.getString("rent_list") );
		plan_date = getDBDateStr( rs.getString("plan_date") );
		rent = formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00");
		corpus = formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00");
		year_rate = formatNumberStr(getDBStr( rs.getString("year_rate") ),"#,##0.0000");
		interest = formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00");
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="chjhxg_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
偿还计划修改
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
	  <td>
		<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
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
    <td scope="row" nowrap width="20%">合同编号：</td>
    <td><%=contract_id %></td>
    <td scope="row" nowrap width="20%">期项：</td>
    <td><%=rent_list %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">承付日期：</td>
    <td><%=plan_date %></td>
    <td scope="row" nowrap width="20%">租金：</td>
    <td><%=rent %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">本金：</td>
    <td><%=corpus %></td>
    <td scope="row" nowrap width="20%">年利率：</td>
    <td><%=year_rate %>%</td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">利息：</td>
    <td><%=interest %></td>
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
