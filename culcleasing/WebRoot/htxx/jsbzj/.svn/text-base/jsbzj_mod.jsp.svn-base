<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>

<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-结算保证金管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String czid;
String sqlstr;

ResultSet rs;
czid=getStr(request.getParameter("id"));
	
	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_mproj_guarantee_info where id="+czid;  
 rs = db.executeQuery(sqlstr);
	
String contract_id="";
String proj_id="";

String sign_date="";
String lineof_credit="";
String credit_fact="";
String credit_remain="";
String guarantee_plan="";
String plan_remain="";
String income_remian="";
String guarantee_income="";
String remark="";
String creator="";
String create_date="";
String modificator="";
String modify_date="";

	if(rs.next()){
	       proj_id=getStr(request.getParameter("proj_id"));
            contract_id=getStr(request.getParameter("contract_id"));
			sign_date=getStr(request.getParameter("sign_date"));
			lineof_credit=getStr(request.getParameter("lineof_credit"));
            credit_fact=getStr(request.getParameter("credit_fact"));
            credit_remain=getStr(request.getParameter("credit_remain"));
            guarantee_plan=getStr(request.getParameter("guarantee_plan"));
            plan_remain=getStr(request.getParameter("plan_remain"));
                  
            income_remian=getStr(request.getParameter("income_remian"));
            guarantee_income=getStr(request.getParameter("guarantee_income"));
            remark=getStr(request.getParameter("remark"));
            
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date"));  
	  
		
	
%>


<body onLoad="public_onload(44);fun_winMax();" class="linetype">
<form name="form1" method="post" action="jsbzj_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理&gt; 结算保证金修改
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
	    	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

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
 </table>
  <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=czid  %>">

<input class="text" type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">


<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td scope="row">项目编号：</td>
   <td><%=getDBStr(rs.getString("proj_id"))%></td>
    <td scope="row">合同编号：</td>
     <td><%=getDBStr(rs.getString("contract_id"))%></td>
  </tr>
  <tr>
   <td scope="row">日期：</td>
    <td>
        <input class="text" type="text" name=sign_date  Require="true" value="<%=getDBDateStr(rs.getString("sign_date"))%>" maxlength="40" readonly>
     <img  onClick="openCalendar(sign_date);return false" style="cursor:pointer; " src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
     <td scope="row">授信总额度:</td>
    <td>
        <input class="text" type="text" name="lineof_credit"  Require="true" value="<%=formatNumberStr(rs.getString("lineof_credit"),"#,##0.00")%>" maxlength="40" dataType="Money">
      <span class="biTian">*</span></td>
 
  </tr>
    <tr>
    <td scope="row">授信发生额：</td>
    <td><input class="text" name="credit_fact" type="text" size="20" Require="true"   dataType="Money"  value="<%=formatNumberStr(rs.getString("credit_fact"),"#,##0.00")%>" maxlength="20"><span class="biTian">*</span></td>
    <td scope="row">授信余额：</td>
    <td><input class="text" name="credit_remain" type="text" size="20"  value="<%=formatNumberStr(rs.getString("credit_remain"),"#,##0.00")%>"   maxlength="30" dataType="Money"></td>
 
  </tr>
    <tr>
    <td scope="row">应收保证金：</td>
    <td><input class="text" name="guarantee_plan" type="text" size="20"  value="<%=formatNumberStr(rs.getString("guarantee_plan"),"#,##0.00")%>"  maxlength="50" dataType="Money"></td>
   
    <td scope="row">应收保证金余额：</td>
    <td><input class="text" name="plan_remain" type="text" size="20" value="<%=formatNumberStr(rs.getString("plan_remain"),"#,##0.00")%>"   maxlength="50" dataType="Moiney"></td>
</tr>
	<tr>
	 <td scope="row">实收保证金余额：</td>
    <td><input class="text" name="income_remian" type="text" size="20" value="<%=formatNumberStr(rs.getString("income_remian"),"#,##0.00")%>"   maxlength="50" dataType="Money"></td>
     <td scope="row">实收保证金发生额：</td>
    <td><input class="text" name="guarantee_income" type="text" size="20" value="<%=formatNumberStr(rs.getString("guarantee_income"),"#,##0.00")%>"   maxlength="50" dataType="Money"></td>
  </tr>
  <tr>
   <td scope="row">备注：</td>
    <td><textarea class="text" name="remark" type="text" size="20" value="<%=getDBStr(rs.getString("remark"))%>" maxlength="50" ></textarea></td>
 <td></td><td></td>
  </tr>
</table>
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
</form>
<%
}
	rs.close(); 
	db.close();
 %>
<!-- end cwMain -->
</body>
</html>