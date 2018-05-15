<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>GPS修改 -GPS巡检报告修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("gps-tzxj-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>

<form name="form1" method="post" action="gps_tzxj_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 GPS管理 &gt; GPS巡检报告修改
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
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

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
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->

<%
String id = getStr( request.getParameter("id") );
String polling_date = "";
String right_num="";
String fall_num="";
String import_date = "";
String importer="";	
ResultSet rs;
String sqlstr = "select * from vi_tzexamine_info where tzpolling_id='" + id + "'"; 
rs = db.executeQuery(sqlstr); 
if ( rs.next() ) {
	polling_date=getDBDateStr( rs.getString("polling_date") );
	right_num=getDBStr( rs.getString("right_num") );
	fall_num=getDBStr( rs.getString("fall_num") );
	import_date=getDBDateStr( rs.getString("import_date") );
	importer=getDBStr( rs.getString("importer") );		
}
rs.close(); 
db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
	<td scope="row">巡检日期</td>
	<td><input name="polling_date" type="text" size="10" value="<%=polling_date%>" readonly><img  onClick="openCalendar(polling_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  <td>入网车辆</td>
  <td><input name="right_num" type="text" size="10" value="<%=right_num%>"  dataType="Number"></td>
  </tr>
  <tr>
  <td>巡检失败车辆 </td>
   <td><input name="fall_num" type="text" size="10" value="<%=fall_num%>"  dataType="Number"></td> <td ></td>
    <td></td>
  </tr>
  <tr>
	<td scope="row">导入日期</td>
	<td><%=import_date%></td>
 <td >导入人：</td>
    <td><%=importer%></td>
  </tr>
</table>
</div>
</div>

    </form>
<script language="javascript">
 dict_list("credit_rank","CredDegree","","name");
</script>

</body>
</html>
