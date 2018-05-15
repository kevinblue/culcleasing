<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金管理 - 发票管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<style>
select{
width:50px;
}
</style>



<script type="text/javascript">

function invoice_submit(){
	var cust_name=document.getElementById("cust_name").value;
	//alert(cust_name);
	if(cust_name==""||cust_name==null){
	alert("承租人不能为空");
	return false;
	}
	else{
	document.search.action="fpgl_add.jsp";
	document.search.submit();
	}
}



</script>


</head>


<body onload="fun_winMax();" style="overflow:auto;" class="linetype">
<form name="search" method="post" action="fpgl_add_static.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="plan_id" name="plan_id" type="hidden" >


<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
发票管理 &gt;发票增加
</td>
</tr>

<tr valign="top">
<td  align=center width=100% height=100% style="padding: 0px;">
<div style="margin-top: 0px;">
<table align=center width=100%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>




<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">发票信息</td>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
</div>

<div style="margin-top: 5px;">
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;margin: 0px;">
<div id="TD_tab_0">


<%
String sqlstr;
//ResultSet rs;

//得到当前登陆的用户
String dqczy = (String) session.getAttribute("czyid");

//查询条件判断
//String contract_id="";
//String cust_name="";
//String create_start_date="";
//String create_end_date="";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
String cust_name = getStr( request.getParameter("cust_name") );

String contract_id1="";
String cust_name1="";
//处理项目基本信息中产品类型为中文的选择
String prod_id_str="";


%>


<input type="hidden" name="savetype" value="add">





<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
  <tr class="maintab">
   <td>  承 租 人<input class="text" name="cust_name" accesskey="s" type="text" size="15" readonly="readonly" value="<%= cust_name %>">
   <img src="../../images/fdmo_65.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
onClick="OpenDataWindow('','','','','承租人','vi_cust_all_info_t','cust_name','cust_id','cust_name','cust_name','asc','search.cust_name','search.cust_name');"><span class="biTian">*</span>

 
					&nbsp;按&nbsp;<select class="text" name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|租金"));</script></select>
					&nbsp;查询&nbsp;<input class="text" name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
				

 
               
				
					
		添加日期<input class="text" name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input class="text" name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input  name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="invoice_submit();">
                </td>
			</tr>
	
  <tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="10"></td>
</tr>
 <tr>
   
   
	
	<td scope="row" colspan="2">
		
		<input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选/反选
	</td>
    <td>发票抬头</td>
	<td>
	<input class="text" name="invoice_name" id="invoice_name" type="text"  readonly maxlength="20" size="10">
	</td>
	 <td scope="col">发票金额:</td>
    <td> 
    <input class="text" name="invoice_total" id="invoice_total" type="text"  readonly maxlength="10" size="10">
	</td>
  </tr>


</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;left: 0px; top: 0px;"
				id="mydiv";>
				
<table border="0" style="border-collapse:collapse;" align="center"
						cellpadding="0" cellspacing="0" width="100%"
						class="maintab_content_table">
						<tr class="maintab_content_table_title">
						
							 <th width="1%"></th> 						
       						<th>序号</th>
	    <th>项目名称</th>
	    <th>合同额</th>
	    <th>合同编号</th>
	    <th>发票抬头</th>
	    <th>本期数</th>
	    <th>总期数</th>
	    <th>租金</th>
	    <th>还款日期</th>
		<th>本金</th>
		<th>利息</th>
						</tr>
						
	<tr>
	
	<td colspan="12" rowspan="3" align="center" style="font-size: 24">
	<font color=#808080 size="24px">
&nbsp;&nbsp;您好，首次载入请点击查询...</font>
	</td>
	</tr>					
						
</table>

</div>
</div>
</div>



<div style="margin-top: 5px;">
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</div>


</table>  
</div>

 



 
</form>


<!-- end cwMain -->
</body>
</html>
