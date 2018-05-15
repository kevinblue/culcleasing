<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租凭物件管理-租凭物件信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body>

<%
	String czid = getStr( request.getParameter("czid") );
	String  sqlstr = "select * from contract_equip_temp where id='" + czid+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
	
%>

<form name="form1" method="post" action="equip_save.jsp">


<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
租凭物件管理 &gt; 删除租凭物件信息
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
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删 除</td>
  
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



<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td nowrap>资产名称/型号</td>
    <td nowrap><input class="text" name="eqip_name" type="text" maxlength="3" size="3" maxB="40" value="<%=getDBStr(rs.getString("eqip_name")) %>" readonly="readonly"></td>
  
    <td nowrap>数量(台)</td>
    <td nowrap><input class="text" name="equip_num" type="text" size="3"  maxlength="3" dataType="Number" maxB="40" value="<%=getDBStr(rs.getString("equip_num"))%>" readonly="readonly"></td>
  </tr>
  

  <tr>
    <td nowrap>设备单价(元)</td>
    <td nowrap><input class="text" name="equip_price" type="text"  maxlength="50" maxB="50" value="<%=getDBStr(rs.getString("equip_price"))%>" readonly="readonly"></td>
  
    <td nowrap>设备总额(元)</td>
    <td nowrap><input class="text" name="total_price" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("total_price"))%>" readonly="readonly"></td>
  </tr>
  <tr>
  <td nowrap>供应商</td>
    <td nowrap><input class="text" name="distributor" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("distributor"))%>" readonly="readonly"></td>
    <td nowrap>租期(月)</td>
    <td nowrap><input class="text" name="equip_team" type="text"  maxlength="40" maxB="40" value="<%=getDBStr(rs.getString("equip_team"))%>" readonly="readonly"></td>
  </tr>
  <tr>
    <td nowrap>每期租金(元)</td>
    <td nowrap><input class="text" name="equip_rent" type="text"  maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("equip_rent"))%>" readonly="readonly"></td>
  
    <td nowrap>产品类别</td>
    <td nowrap><input class="text" name="equip_type" type="text"  maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("equip_type"))%>" readonly="readonly"></td>
 </tr>
 <tr>
 <td nowrap>配置</td>
    <td nowrap><input class="text" name="equip_dispose" type="text"  maxlength="100" maxB="100" value="<%=getDBStr(rs.getString("equip_dispose"))%>" readonly="readonly"></td>
    <td nowrap></td>
    <td nowrap></td>
  </tr>
  
  
  <tr>
    <td nowrap>备注</td>
    <td><textarea class="text" name="memo" maxB="500" rows="6" readonly="readonly"><%=getDBStr(rs.getString("memo"))%></textarea></td>
  

    <td ></td>
  </tr>
  
</table>
<%
}else{
   out.print("<center>该条记录不存在!</center>");
}

rs.close(); 
db.close();
%>

<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->

<!-- end cwToolbar -->
</form>

<!-- end cwMain -->
</body>
</html>
