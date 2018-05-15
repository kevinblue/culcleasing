<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改客户交往记录 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body>


<form name="form1" enctype="multipart/form-data" method="post" action="khjwjl_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 修改客户交往记录
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>

    	
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
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修 改</td>
  
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
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select * from cust_intercourse where id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	//String cust_name = "";
	String record_type = "";
	String record_content = "";
	String attachment = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	String contact_date = "";

	if ( rs.next() ) {
	//	cust_name = getDBStr( rs.getString("cust_name") );
		record_type = getDBStr( rs.getString("record_type") );
		contact_date = getDBDateStr( rs.getString("contact_date") );
		record_content = getDBStr( rs.getString("record_content") );
		attachment = getDBStr( rs.getString("attachment") );
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	}
	rs.close(); 
	db.close();
%>
<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%= czid %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
   
   <tr>
    <td scope="row" nowrap>交往时间：</td>
    <td><input name="contact_date" type="text" value="<%=contact_date %>" dataType="Date" Require="true" readonly><img  onClick="openCalendar(contact_date);return false" style="cursor:pointer; " src="../../images/btn_time.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
   <td scope="row" nowrap>记录类型：</td>
    <td>
    	<input type="text" name="record_type"  value="<%= record_type %>"></td>
  </tr>
  <tr>
    <td valign="top">记录内容：</td>
    <td scope="row" nowrap colspan="4" valign="top">
  <textarea class="text" name="record_content"  maxB="800" rows="15"><%= record_content %></textarea></td>
  </tr>
  <tr>
    <td scope="row" nowrap>附件：</td>
	<%if(!attachment.equals("")){%>
    <td><%= attachment %><input type="submit" value="删除" onclick="form1.fj_del.value=1;"><input type="hidden" name="fj_del"></td>
	<%}else{%>
	<td><table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End 上传组件 --><span class="biTian">允许上传的文件类型.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
	<%}%>
  </tr>
</table>

</div>


</div>
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>


