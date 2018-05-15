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
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>


</head>

<%
	String id = getStr( request.getParameter("id") );	
String sqlstr="select pp.id as id ,pp.proj_id as proj_id ,pi.project_name as project_name,pp.plan_money as plan_money,pp.plan_date as plan_date,pp.fee_name as fee_name,isnull(pc.equip_amt,pp.expect_money) as expect_money ,pp.expect_put_time as expect_put_time from  proj_fund_fund_charge_plan pp left join proj_condition pc on pc.proj_id=pp.proj_id left join proj_info pi on  pi.proj_id=pp.proj_id where pp.id ='" + id+"'";
System.out.println("aaaaaaaaaaaaaa"+sqlstr);
	String proj_id;
	String project_name;
	String plan_money;
	String plan_date;
	String fee_name;		
	String expect_money;
    String expect_put_time;	
    String wh_modificator="";  
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
		proj_id=getDBStr(rs.getString("proj_id"));
		project_name=getDBStr(rs.getString("project_name"));
		
	   
	    
		
%>
<body  onload="public_onload();fun_winMax();" >
<form name="form1" method="post" action="add_money_to_zjjh_save.jsp" onSubmit="return Validator.Validate(this,3);">
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
    <td nowrap>项目编号</td>
    <td nowrap><input class="text" name="proj_id" type="text" maxlength="3" readOnly size="3" maxB="40" value="<%=proj_id%>"></td>
  
    <td nowrap>项目名称</td>
    <td nowrap><input class="text" name="project_name" readOnly  type="text" size="3" style="width:350px;" maxlength="3" maxB="100" value="<%=project_name%>"></td>
  </tr>

  <tr>
		  
     <td nowrap>计划金额</td>
    <td nowrap><input class="text" name="plan_money" type="text" readOnly  maxlength="50" maxB="50" value="<%=getDBStr(rs.getString("plan_money"))%>"></td>
	 <td nowrap>计划日期</td>
    <td nowrap><input class="text" name="plan_date" type="text"  maxlength="40"  readOnly maxB="40" value="<%=getDBDateStr(rs.getString("plan_date"))%>" ></td>
  </tr>
  <tr>
    <td nowrap>费用类型</td>
    <td nowrap><input class="text" name="fee_name" type="text"  maxlength="40" readOnly maxB="40" value="<%=getDBStr(rs.getString("fee_name"))%>" ></td>
    <td nowrap>预期金额</td>
    <td nowrap><input class="text" name="expect_money" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("expect_money"))%>" ></td>
  </tr>
  
  <tr>
	<td nowrap>维护人</td>
    <td nowrap><input class="text" name="wh_modificator" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modificator%>"></td>
	<td nowrap>维护时间</td>
    <td nowrap><input class="text" name="wh_modify_date" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modify_date%>"></td>    
  </tr>
   <tr>		      	
	<td nowrap>预期投放日期:</td>
    <td nowrap><input class="text" name="expect_put_time" type="text"  value="<%=getDBStr(rs.getString("expect_put_time"))%>" size="10" maxlength="10" readonly dataType="Date"><img  onClick="openCalendar(expect_put_time);return false" style="cursor:pointer; " src="../../images/btn_time.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  
   
  
 <tr>

  
</table>
	<%
	}
rs.close();
db.close();
db1.close();
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
