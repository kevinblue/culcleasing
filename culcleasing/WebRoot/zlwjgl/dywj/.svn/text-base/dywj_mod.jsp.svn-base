<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同抵押物件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="dywj_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同信息 &gt; 合同抵押物件
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
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("zjwjgl-dywj-mod",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------


	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select contract_guarantee_equip.*,ifelc_conf_dictionary.title as equip_guarantee_type_name ,ifelc_conf_dictionary2.title as equip_status_name from contract_guarantee_equip left join ifelc_conf_dictionary on contract_guarantee_equip.equip_guarantee_type=ifelc_conf_dictionary.name left join ifelc_conf_dictionary ifelc_conf_dictionary2 on contract_guarantee_equip.equip_status=ifelc_conf_dictionary2.name where contract_guarantee_equip.id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	contract_id = "";
	String	equip_guarantee_type = "";
	String	equip_guarantee_type_name = "";
	String	eqip_name = "";
	String	equip_num = "";
	String	total_price = "";
	String	equip_place = "";
	
	String	equip_sn = "";
	String	ownership_document = "";
	String	guarantor = "";
	String	second_hand_market = "";
	String	memo = "";
	String	equip_status = "";
	String	equip_status_name = "";
	String	status_date = "";


	if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		equip_guarantee_type = getDBStr( rs.getString("equip_guarantee_type") );
		equip_guarantee_type_name = getDBStr( rs.getString("equip_guarantee_type_name") );
		eqip_name = getDBStr( rs.getString("eqip_name") );
		equip_num = getDBStr( rs.getString("equip_num") );
		total_price = getDBStr( rs.getString("total_price") );
		equip_place = getDBStr( rs.getString("equip_place") );
		
		equip_sn = getDBStr( rs.getString("equip_sn") );
		ownership_document = getDBStr( rs.getString("ownership_document") );
		guarantor = getDBStr( rs.getString("guarantor") );
		second_hand_market = getDBStr( rs.getString("second_hand_market") );
		memo = getDBStr( rs.getString("memo") );
		equip_status = getDBStr( rs.getString("equip_status") );
		equip_status_name = getDBStr( rs.getString("equip_status_name") );
		status_date = getDBDateStr( rs.getString("status_date") );
	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>合同编号</td>
    <td><input name="contract_id" type="text" size="20"  Require="true" readonly value="<%=contract_id %>"></td>
    <td>抵押/质押</td>
    <td><select name="equip_guarantee_type"></select>
	<script language="javascript">dict_list("equip_guarantee_type","GuarantyType","<%=equip_guarantee_type %>","name");</script>
    </td>
  </tr>
  <tr>
    <td>抵质押物名称</td>
    <td><input name="eqip_name" type="text" size="20" maxB="300" value="<%=eqip_name %>"></td>
    <td>数量</td>
    <td><input name="equip_num" type="text" size="20" maxB="10" dataType="Integer" Require="true" value="<%=equip_num %>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>价格</td>
    <td><input name="total_price" type="text" size="20" dataType="Money" Require="true" value="<%=total_price %>"><span class="biTian">*</span></td>
  	<td>存放地点</td>
    <td><textarea name="equip_place" maxB="300"><%=equip_place %></textarea></td>
  </tr>
  <tr>
    <td>设备序列号</td>
    <td><textarea name="equip_sn" maxB="300"><%=equip_sn %></textarea></td>
    <td>权属文件</td>
    <td><textarea name="ownership_document" maxB="300"><%=ownership_document %></textarea></td>
  </tr>
  <tr>
    <td>抵押/质押人</td>
    <td><textarea name="guarantor" maxB="300"><%=guarantor %></textarea></td>
    <td>二手市场状况</td>
    <td><textarea name="second_hand_market" maxB="300"><%=second_hand_market %></textarea></td>
  </tr>
  <tr>
    <td>描述</td>
    <td><textarea name="memo" maxB="300"><%=memo %></textarea></td>
    <td>物件状态</td>
    <td><select name="equip_status"></select>
	<script language="javascript">dict_list("equip_status","equip_status","<%=equip_status %>","name");</script>
    </td>
  </tr>
  <tr>
    <td>状态日期</td>
    <td colspan="3"><input name="status_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=status_date %>"> <img  onClick="openCalendar(status_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
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
ShowTabN(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
