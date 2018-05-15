<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改提取比例 - 管理</title>

</script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">修改外币管理 &gt; 修改</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<form name="form1"  method="post" action="tqbl_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div class="mydivtab" id="mydiv">
<%
String czid;
String sqlstr;
String id;
ResultSet rs;
id=getStr(request.getParameter("id"));
//czid=getStr(request.getParameter("id"));
//if ((czid==null) || (czid.equals("")))
//{
  // czid="0";
//}
	
sqlstr="select * from  base_extractscale where id='"+id+"'"; 
//sqlstr = "SELECT id,contract_id,(select top 1 contract_id from contract_info where  contract_info.contract_id =contract_guarantee_equip.contract_id) as  lease_contract_num, equip_guarantee_type, eqip_name,guarantor, ID_number, equip_num, total_price,equip_place,equip_sn,ownership_document from contract_guarantee_equip where id="+czid; 
//sqlstr = "SELECT id,contract_id,(select top 1 lease_contract_num  from contract_info where  contract_info.contract_id =contract_pledge.contract_id) as  lease_contract_num, pledge_name, reg_name,pledge_money, card_number, pledge_term, pledge_type from contract_pledge where id="+czid; 
System.out.println("hhhhh"+sqlstr);
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
%>
<input class="text" type="hidden" name="savetype" value="mod">
<input class="text" type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  
   <tr>
    <td scope="row">资产分类：</td>
    <td>
    <select name="native_resi" Require="true" value="getDBStr(rs.getString(fiveclass))"></select>
<script language="javascript">dict_list("native_resi","five_class","<%="fiveclass"%>","title");</script>
 
  </tr>
  <tr>
    <td scope="row">提取比例：</td>
    <td><input class="text" name="scale" type="text" size="20" value="<%=getDBStr(rs.getString("scale"))%>" maxlength="50"></td>
  </tr>
 
   
  
</table>
</div>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>
<td width=8 width="12">
<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
</form>
<%
}
else
{
%>
 <center>该条记录不存在!<%=sqlstr%></center>
<div id="cwToolbar" >
<input class="text" class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</body>
</html>


