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
if (right.CheckRight("insurance-caver-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保险管理 - 保险是否覆盖融资期限表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onLoad="fun_winMax();">
<form name="form1" method="post" action="caver_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
保险管理 &gt; 保险是否覆盖融资期限表
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">维护信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="caver_id">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="czid">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>合同号</td>
    <td><input name="contract_id" type="text" size="20" maxB="50" Require="true" readonly><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','合同号',  'vi_caver','contract_id','device_type|cust_name|equip_sn|equip_num|lease_term|years|start_date|end_date|insurance_date|insurance_enddate|insurer|days','contract_id','','','form1.contract_id','form1.device_type|form1.cust_name|form1.equip_sn|form1.equip_num|form1.months|form1.years|form1.start_date|form1.end_date|form1.insurance_date|form1.insurance_enddate|form1.insurer|form1.days');">
	<span class="biTian">*</span></td>
    <td>客户名</td>
    <td><input name="cust_name" type="text" size="20" maxB="50" readonly ></td>
    <td>型号</td>
    <td><input name="device_type" type="text" size="20" maxB="50" readonly></td>
   </tr>
   <tr>
    <td>机编号</td>
    <td><input name="equip_sn" type="text" size="20" maxB="50" readonly></td>
    <td>台数</td>
    <td><input name="equip_num" type="text" size="20" maxB="50" readonly></td>
    <td>融资期限（月）</td>
    <td><input name="months" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>融资期限（年）</td>
    <td><input name="years" type="text" size="20" maxB="50" readonly></td>
    <td>租赁起始日</td>
    <td><input name="start_date" type="text" size="20" maxB="50" readonly></td>
    <td>租赁截止日</td>
    <td><input name="end_date" type="text" size="20" maxB="50" readonly></td>
  </tr>
  <tr>
    <td>保险起始日</td>
    <td><input name="insurance_date" type="text" size="20" maxB="50" readonly></td>
    <td>保险截止日</td>
    <td><input name="insurance_enddate" type="text" size="20" maxB="50" readonly></td>
    <td>保险公司</td>
    <td><input name="insurer" type="text" size="20" maxB="50" readonly></</td>
  </tr>
  <tr>
    <td>覆盖误差(天数)</td>
    <td><input name="days" type="text" size="20" maxB="50" readonly ></td>
    <td>处理状态</td>
    <td><select name="insurance_state" width="80px" Require="true">
    		<option value="0">待处理</option>
            <option value="1">已处理</option>
    </select></td>
    <td>处理结果</td>
    <td><input name="insurance_result" type="text" size="20" maxB="50" ></td>
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

</script>
</form>








<!-- end cwMain -->
</body>
</html>
ss