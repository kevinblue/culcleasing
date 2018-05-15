<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
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
if (right.CheckRight("insurance-fees-del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报价管理 - 保险费计算维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/validator.js"></script>
</head>
<%
	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select dbo.FK_GETNAME(insurer) insurer1,insurer,fees_way,note,insurance_type from insurance_fees where insurance_fees='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	insurer = "";
	String	insurer1 = "";
	String	fees_way = "";
	String	note = "";
	String insurance_type="";
	if ( rs.next() ) {
		insurer1 = getDBStr( rs.getString("insurer1") );
		insurance_type = getDBStr( rs.getString("insurance_type") );
		insurer = getDBStr( rs.getString("insurer") );
		fees_way = getDBStr( rs.getString("fees_way") );
		note = getDBStr( rs.getString("note") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="fun_winMax();">
<form name="form1" method="post" action="insurance_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
报价管理 &gt; 保险费计算维护
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
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
    <td>保险公司</td>
    <td><input name="insurer" type="text" value="<%= insurer1 %>" size="20" maxB="50" readonly ></td>
    <td>计算方法</td>
    <td><select name="fees_way" width="80px" Require="true">
    		<option value="" <%="".equals(fees_way) ? "selected" : ""%>></option>
    		<option value="1" <%="1".equals(fees_way) ? "selected" : ""%>>非平安保险计算方法</option>
          	<option value="2" <%="2".equals(fees_way) ? "selected" : ""%>>平安保险计算方法</option>
            <option value="3" <%="3".equals(fees_way) ? "selected" : ""%>>平安保险计算方法(送首年保费)</option>
    </select>
    <span class="biTian">*</span></td>
     </tr>
    <tr> 
	<td>险种</td>
    <td colspan="3"><textarea name="note" cols="20" rows="5" maxb="100" style="width:536px"><%= insurance_type%></textarea></td>
    <td>备注</td>
    <td colspan="3"><textarea name="note" cols="20" rows="5" maxb="100" style="width:536px"><%= note%></textarea></td>
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
</script>
</form>
<!-- end cwMain -->
</body>
</html>
