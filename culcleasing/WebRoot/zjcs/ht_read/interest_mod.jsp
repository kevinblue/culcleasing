<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-qrsr-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>实际利息 - 实际利息修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<body onLoad="fun_winMax();">
<!--  -->
<form name="form1" method="post" action="interest_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
基本信息 &gt;实际利息修改
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
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修改信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
int canmod=0;

	String oneId = getStr( request.getParameter("id") );
	String sqlstr = "select id,measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent_adjust,eptd_rent,rent,corpus,straight_interest,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,fin_interest,creator,create_date,modificator,modify_date from fund_rent_plan where id ='" + oneId + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String	rent_list = "";//int 期项 
	String	rent = "";//money 租金
	String	corpus = "";//money 本金
	String	interest = "";//money 利息
	String	fin_interest = "";//money 确认收入 实际利息
	String	id = "";//int
	//String	measure_id = "";//varchar
	//String	measure_date = "";//datetime
	//String	contract_id = "";//varchar
	//String	plan_status = "";//varchar
	//String	plan_date = "";//datetime 应收日期
	//String	rent_adjust = "";//money
	//String	eptd_rent = "";//money
	//String	straight_interest = "";//money
	//String	year_rate = "";//decimal(18, 6)
	//String	rent_overage = "";//money 
	//String	corpus_overage = "";//money
	//String	interest_overage = "";//money
	//String	penalty_overage = "";//money
	//String	penalty = "";//money
	//String	rent_type = "";//varchar
	//String	creator = "";//varchar
	//String	create_date = "";//datetime
	//String	modificator = "";//varchar
	//String	modify_date = "";//datetime


	if ( rs.next() ) {
		rent_list = getDBStr( rs.getString("rent_list") );
		rent = formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00");
		corpus = formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00");
		interest = formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00");
		fin_interest = formatNumberDoubleTwo(getDBStr( rs.getString("fin_interest") ));
		id = getDBStr( rs.getString("id") );
	}
	rs.close(); 
	db.close();

%>

<!-- 隐藏于传值 -->
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%= id %>">

<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
<!--  
  <tr>
    <td>设备型号</td>
    <td><input name="model_name" type="text" size="20" maxB="100" Require="true" readonly value=""><input type="hidden" name="model_id" value=""><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','设备型号','equip_model','model_name','model_id','model_name','model_name','asc','form1.model_name','form1.model_id');">
    <span class="biTian">*</span></td>
</tr>
  <tr>
    <td>服务时长(小时)</td>
    <td><input name="csa_hours" type="text" size="20" maxB="10" Require="true" dataType="Integer" value="">
    <span class="biTian">*</span></td>
  </tr>
-->  

  <tr>     
    <td>期项</td>
    <td> <%=rent_list%> </td>
  </tr>
  <tr>
    <td>租金(元)</td>
    <td> <%=rent%> </td>
  </tr>
  <tr>
    <td>本金(元)</td>
    <td> <%=corpus%> </td>
  </tr>
  <tr>
    <td>利息(元)</td>
    <td> <%=interest%> </td>
  </tr>
  <tr>
    <td>确认收入(元)</td>
    <td><input name="fin_interest" type="text" size="20" maxB="18" Require="true" dataType="Money" value="<%=fin_interest%>">
    <span class="biTian">*</span></td>
  </tr>
</table>
	




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

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
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
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
