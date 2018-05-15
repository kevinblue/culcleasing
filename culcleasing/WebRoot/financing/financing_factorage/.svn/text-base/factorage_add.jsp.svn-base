<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保费计划 - 新增</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>

<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->

<%

String drawings_id = getStr( request.getParameter("drawings_id") );

%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">提款手续费&gt; 新增</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1" method="post" action="factorage_save.jsp">
<input type="hidden" name="type" value="add">
<input type="hidden" name="drawings_id" value="<%=drawings_id%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">手续费类型</td>
    <td scope="row">
	    <select style="width:150px;" name="factorage_type" Require="ture" id="factorage_type" >
	       <script language="javascript" class="text">
			dict_list("factorage_type","root.FactorageType","root.FactorageType.001","title");
		   </script>
	     </select>
	     <span class="biTian">*</span>
    </td>
    
    <td scope="row">支付方式</td>
    <td scope="row">
	
	    <select style="width:150px;" name="factorage_paytype" Require="ture">
	        <script type="text/javascript">
		        	w(mSetOpt('',"先付|后付|年付","先付|后付|年付"));
	        </script>
	     </select>
	     <span class="biTian">*</span>
	
  </tr>
     
  <tr>
    <td scope="row" id="bj_5">手续费日期</td>
    <td scope="row">
    <input name="factorage_date" type="text" style="width:150px;" readonly="readonly" Require="ture">
    <img  onClick="openCalendar(factorage_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
    height="19" border="0" align="absmiddle">
    <span class="biTian">*</span>
    </td>
    
    <td scope="row">手续费金额</td>
    <td scope="row">
    <input name="factorage_money" id="factorage_money" style="width:150px;" type="text" dataType="Money" value="0" Require="ture">
	<span class="biTian">*</span>
    </td>
  </tr>
  <tr>
    <td scope="row" id="bj_5">币种</td>
    <td scope="row">
     <select style="width:150px;" name="currency_type" Require="ture">
	       <script language="javascript" class="text">
			dict_list("currency_type","currency_type","","title");
		   </script>
	     </select>
    <span class="biTian">*</span>
    </td>
    
    <td scope="row"></td>
    <td scope="row">
    </td>
  </tr>
  
  <tr>
  <td scope="row">收/支备注</td>
    <td scope="row" colspan="3">
    	<textarea rows="6" cols="4" name="factorage_remark"></textarea>
    </td>
  </tr>
</table>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
<!-- end cwToolbar -->

</form>
</div>
<!-- end cwMain -->
</body>

</html>

<%if(null != db){db.close();}%>