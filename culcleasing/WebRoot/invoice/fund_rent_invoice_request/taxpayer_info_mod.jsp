<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划信息维护-修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js">
</script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<%
	String id = getStr( request.getParameter("id") );
String proj_assistant_name = getStr( request.getParameter("proj_assistant_name") );
String sqlstr="select cust_name,cust_id,tax_payer_no,tax_type_invoice,address,tel,bank_name,bank_no,wh_status,wh_modificator,wh_modify_date from  vi_base_taxPayer_mod  where id ='" + id+"'";
System.out.println("aaaaaaaaaaaaaa"+sqlstr);
	String cust_name;
	String cust_id;
	String tax_payer_no;
	String tax_type_invoice;
	String address;		
	String tel;
    String bank_name;	
    String bank_no;
    String wh_modificator=""; 
    String wh_confirm_user;
	String wh_modify_date=getSystemDate(1);	
	if(wh_modify_date.indexOf("\'")==0){
	wh_modify_date = wh_modify_date.substring(1,wh_modify_date.length()); 
	}
	if(wh_modify_date.lastIndexOf("\'")==(wh_modify_date.length()-1)){
	wh_modify_date = wh_modify_date.substring(0,wh_modify_date.length()-1); 
	}
	String useid = (String) session.getAttribute("czyid");
	String sqluser="select name from base_user where id='" + useid+"'";
	ResultSet rsid = db.executeQuery(sqluser);
	if(rsid.next()){
		wh_modificator=getDBStr(rsid.getString("name"));
	}
	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
	
	   
	    
		
%>
<body  onload="public_onload();fun_winMax();" >
<form name="form1" method="post" action="taxpayer_info_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资金计划维护-修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td >
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修 改</td>
  
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
<!-- end cwCellTop -->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">

  <tr>
    <td nowrap>客户编码</td>
    <td nowrap><input class="text" name="cust_id" type="text" maxlength="3" readOnly size="3" maxB="40" value="<%=getDBStr(rs.getString("cust_id"))%>"></td>
  
    <td nowrap>客户名称</td>
    <td nowrap><input class="text" name="cust_name" readOnly  type="text" size="3" style="width:350px;" maxlength="3" maxB="100" value="<%=getDBStr(rs.getString("cust_name"))%>"></td>
  </tr>

  <tr>
		  
     <td nowrap>电话</td>
    <td nowrap><input class="text" name="tel" type="text"   maxlength="50" maxB="50" value="<%=getDBStr(rs.getString("tel"))%>"></td>
	 <td nowrap>地址</td>
    <td nowrap><input class="text" name="address" type="text"  maxlength="40"   maxB="40" value="<%=getDBDateStr(rs.getString("address"))%>" ></td>
  </tr>
  <tr>
    <td nowrap>纳税人基本开户行</td>
    <td nowrap><input class="text" name="bank_name" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("bank_name"))%>" ></td>
    <td nowrap>纳税人账号</td>
    <td nowrap><input class="text" name="bank_no" type="text"  maxlength="40"  maxB="40" value="<%=getDBStr(rs.getString("bank_no"))%>" ></td>
  </tr>
  
  <tr>
	<td nowrap>维护人</td>
    <td nowrap><input class="text" name="wh_modificator" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modificator%>"></td>
	<td nowrap>维护时间</td>
    <td nowrap><input class="text" name="wh_modify_date" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modify_date%>"></td>    
  </tr>
   <tr>		      	
	<td nowrap>纳税人识别号:</td>
    <td nowrap><input class="text" name="tax_payer_no" type="text"  value="<%=getDBStr(rs.getString("tax_payer_no"))%>"></td>
    <td nowrap>发票类型:</td>
    <td nowrap class="text"><select class="text" Require="true" name="tax_type_invoice"><script>w(mSetOpt(" ","|增值税普通发票|增值税专用发票"));</script></select>
     <span class="biTian">*</span></td>
</td>
  </tr>
    <tr>		      	
    <td nowrap class="text">财务确认人员：</td>
   <td nowrap class="text"><select class="text" Require="true" name="wh_confirm_user"><script>w(mSetOpt(" ","|李悦欣|孙梦琳"));</script></select>
     <span class="biTian">*</span></td>
  </tr>
  
   
  
 <tr>

  
</table>
	<%
	}
rs.close();
db.close();
%>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwToolbar -->
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>
