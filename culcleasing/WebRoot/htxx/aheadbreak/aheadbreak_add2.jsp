<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同后期管理 - 解约</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

</head>
<body>
<form name="form1" method="post" target="_blank" action="aheadbreak_save2.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	
<%
	String sqlstr;
	ResultSet rs;
	ResultSet rs1;
	String contract_id = getStr( request.getParameter("contract_id") );
	String doc_id = getStr( request.getParameter("doc_id") );
	String dqczy = (String) session.getAttribute("czyid");
	
	String billing_manager="";
	String billing_manager_name="";
	String billing_date="";
	String effective_date="";
	
	String price_factor_name1="";
	String price_factor1="";
	String price_factor_name2="";
	String price_factor2="";
	String price_factor_name3="";
	String price_factor3="";
	String price_factor_name4="";
	String price_factor4="";
	String price_factor_name5="";
	String price_factor5="";
	String price_factor_name6="";
	String price_factor6="";
	String price_factor_name7="";
	String price_factor7="";
	String price_factor_name8="";
	String price_factor8="";
	String back_amt="";
	
	sqlstr="select contract_ahead_break.contract_id, contract_ahead_break.billing_manager, jb_yhxx.xm as billing_manager_name, contract_ahead_break.billing_date, contract_ahead_break.effective_date, contract_ahead_break.agree_amt, contract_ahead_break.difference_amt, contract_ahead_break.difference_memo, contract_ahead_break.price_factor_name1, contract_ahead_break.price_factor1, contract_ahead_break.price_factor_name2, contract_ahead_break.price_factor2, contract_ahead_break.price_factor_name3, contract_ahead_break.price_factor3, contract_ahead_break.price_factor_name4, contract_ahead_break.price_factor4, contract_ahead_break.price_factor_name5, contract_ahead_break.price_factor5, contract_ahead_break.price_factor_name6, contract_ahead_break.price_factor6, contract_ahead_break.price_factor_name7, contract_ahead_break.price_factor7, contract_ahead_break.price_factor_name8, contract_ahead_break.price_factor8,contract_ahead_break.back_amt from contract_ahead_break left join jb_yhxx on contract_ahead_break.billing_manager=jb_yhxx.id where contract_ahead_break.doc_id='"+doc_id+"'";
	//System.out.println("sqlstr==========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		billing_manager=getDBStr( rs.getString("billing_manager"));
		billing_manager_name=getDBStr( rs.getString("billing_manager_name"));
		billing_date=getDBDateStr( rs.getString("billing_date"));
		effective_date=getDBDateStr( rs.getString("effective_date"));
		
		price_factor_name1=getDBStr( rs.getString("price_factor_name1"));
		price_factor1=getDBDecStr(rs.getBigDecimal("price_factor1",2)).toString();
		price_factor_name2=getDBStr( rs.getString("price_factor_name2"));
		price_factor2=getDBDecStr(rs.getBigDecimal("price_factor2",2)).toString();
		price_factor_name3=getDBStr( rs.getString("price_factor_name3"));
		price_factor3=getDBDecStr(rs.getBigDecimal("price_factor3",2)).toString();
		price_factor_name4=getDBStr( rs.getString("price_factor_name4"));
		price_factor4=getDBDecStr(rs.getBigDecimal("price_factor4",2)).toString();
		price_factor_name5=getDBStr( rs.getString("price_factor_name5"));
		price_factor5=getDBDecStr(rs.getBigDecimal("price_factor5",2)).toString();
		price_factor_name6=getDBStr( rs.getString("price_factor_name6"));
		price_factor6=getDBDecStr(rs.getBigDecimal("price_factor6",2)).toString();
		price_factor_name7=getDBStr( rs.getString("price_factor_name7"));
		price_factor7=getDBDecStr(rs.getBigDecimal("price_factor7",2)).toString();
		price_factor_name8=getDBStr( rs.getString("price_factor_name8"));
		price_factor8=getDBDecStr(rs.getBigDecimal("price_factor8",2)).toString();
		back_amt=getDBDecStr(rs.getBigDecimal("back_amt",2)).toString();
	}rs.close();
	db.close();
	db1.close();
	
 %>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<!-- 
<BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">计算</button>

<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
 -->
    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="保存"> 保存</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="重置"> 重置</a>
    	
    	<input class="btn" name="btnSave" value="保存" type="submit">
    	<input class="btn" name="btnReset" value="重置" type="reset">
    	-->
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<!--  
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
-->
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:330px;overflow:auto;">

<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="contract_id" value="<%= contract_id %>">
<input type="hidden" name="doc_id" value="<%= doc_id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">

  <tr>
    <td>结算经办人</td>
    <td><input name="billing_manager_name" type="text" size="20"  Require="true" readonly value="<%= billing_manager_name%>"><input type="hidden" name="billing_manager" value="<%= billing_manager%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','用户名称','jb_yhxx','xm','id','xm','xm','asc','form1.billing_manager_name','form1.billing_manager');">
    <span class="biTian">*</span></td>
    <td colspan="2"><BUTTON class="btn_2" name="btnSave" value="计算"  type="submit" >
	<img src="../../images/save.gif" align="absmiddle" border="0">计算</button></td>
  </tr>
  <tr>
    <td>结算日期</td>
    <td><input name="billing_date" accesskey="s" type="text" size="10" readonly value="<%=billing_date%>" Require="true"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(billing_date);return false"><span class="biTian">*</span></td>
    <td>有效日</td>
    <td><input name="effective_date" accesskey="s" type="text" size="10" readonly value="<%=effective_date%>" Require="true"><img src="../../images/tbtn_overtime.gif" widtd="20" height="19" border="0" align="absmiddle" style="cursor:pointer; "  onClick="openCalendar(effective_date);return false"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>解约要素1</td>
    <td><input name="price_factor_name1" type="text" size="40" value="<%=price_factor_name1%>"></td>
    <td>金额</td>
    <td><input name="price_factor1" type="text" size="20" value="<%=price_factor1%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素2</td>
    <td><input name="price_factor_name2" type="text" size="40" value="<%=price_factor_name2%>"></td>
    <td>金额</td>
    <td><input name="price_factor2" type="text" size="20" value="<%=price_factor2%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素3</td>
    <td><input name="price_factor_name3" type="text" size="40" value="<%=price_factor_name3%>"></td>
    <td>金额</td>
    <td><input name="price_factor3" type="text" size="20" value="<%=price_factor3%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素4</td>
    <td><input name="price_factor_name4" type="text" size="40" value="<%=price_factor_name4%>"></td>
    <td>金额</td>
    <td><input name="price_factor4" type="text" size="20" value="<%=price_factor4%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素5</td>
    <td><input name="price_factor_name5" type="text" size="40" value="<%=price_factor_name5%>"></td>
    <td>金额</td>
    <td><input name="price_factor5" type="text" size="20" value="<%=price_factor5%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素6</td>
    <td><input name="price_factor_name6" type="text" size="40" value="<%=price_factor_name6%>"></td>
    <td>金额</td>
    <td><input name="price_factor6" type="text" size="20" value="<%=price_factor6%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素7</td>
    <td><input name="price_factor_name7" type="text" size="40" value="<%=price_factor_name7%>"></td>
    <td>金额</td>
    <td><input name="price_factor7" type="text" size="20" value="<%=price_factor7%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>解约要素8</td>
    <td><input name="price_factor_name8" type="text" size="40" value="<%=price_factor_name8%>"></td>
    <td>金额</td>
    <td><input name="price_factor8" type="text" size="20" value="<%=price_factor8%>" dataType="Money" onpropertychange="getTotalMoney();"></td>
  </tr>
  <tr>
    <td>总计(解约金额)</td>
    <td><input name="back_amt" type="text" size="20" value="<%=back_amt%>" dataType="Money" readonly></td>
  </tr>
</table>
<!-- 
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
<tr bgcolor="#8DB2E3"><td>费用处理</td></tr>
<tr>
<td><iframe frameborder="0" width="100%" height="500px" src="./aheadincomeHl.jsp?contract_id=<%=contract_id%>"></iframe></td>
</tr>
</table>
-->
</div>

<div id="TD_tab_1" style="display:none;">

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
</form>

<!-- end cwMain -->
</body>
</html>
<<script type="text/javascript">
function getTotalMoney(){
	document.getElementById("back_amt").value=forcepos(document.getElementById("price_factor1").value*1
	+document.getElementById("price_factor2").value*1+document.getElementById("price_factor3").value*1
	+document.getElementById("price_factor4").value*1+document.getElementById("price_factor5").value*1
	+document.getElementById("price_factor6").value*1+document.getElementById("price_factor7").value*1
	+document.getElementById("price_factor8").value*1,2);
}
</script>
