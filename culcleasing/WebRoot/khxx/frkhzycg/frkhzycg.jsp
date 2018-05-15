<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>主要参股- 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>
<%String id = getStr( request.getParameter("czid") ); %>
<body>


<form name="form1" method="post" action="frkhzycg_mod.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 主要参股
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
<a href="frkhzycg_mod.jsp?czid=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改</a>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">详细信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->







<!-- end cwCellTop -->

<%
	
	String rank = "";
	String cust_id = "";	
	String create_date = "";
	String memo = "";
	String creator = "";	
	String modificator = "";
	String modify_date = "";
	String biz_scope_primary="";
	String asset_size = "";
	String asset_liability = "";
	String profit_year = "";
	String reg_number = "";
	String stake = "";
	
 
	
	ResultSet rs;
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from cust_share_company where 1=1 and id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){

		rank = getDBStr( rs.getString("rank") );
		cust_id = getDBStr( rs.getString("cust_id") );		
		create_date = getDBDateStr( rs.getString("create_date") );
		memo = getDBStr( rs.getString("memo") );
		creator = getDBStr( rs.getString("dengjiren") );		
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	    biz_scope_primary = getDBStr( rs.getString("biz_scope_primary") );
		stake = getDBStr( rs.getString("stake") );
		reg_number = getDBStr( rs.getString("reg_number") );
		asset_size = getDBStr( rs.getString("asset_size") );
		asset_liability = getDBStr( rs.getString("asset_liability") );
		profit_year = getDBStr( rs.getString("profit_year") );
		modificator=getDBStr( rs.getString("modificator") );
	
		
	//}
	//rs.close();
	//db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row">公司名称：</td>
    <td><%= rank %>
	</td>

    <td>注册资本：</td>
    <td><%=formatNumberStr(rs.getString("reg_number"),"#,##0.00")%></td>
  </tr>
  <tr>
	<td scope="row">持股比例：</td>
	<td><%=stake %>%</td>
  <td>主营业务：</td>
    <td><%=biz_scope_primary %></td>
    
  </tr>
 
  <tr>
   <td>资产规模：</td>
    <td ><%=asset_size%></td>
  
    <td>资产负债率：</td>
    <td ><%=asset_liability%>%</td>
  </tr>
  <tr>
    <td>本年净利润：</td>
    <td ><%=formatNumberStr(rs.getString("profit_year"),"#,##0.00")%>&nbsp;</td>
  <td></td><td></td>
   </tr>
   <tr>
  <td colspan="3">备注：
   <textarea rows="3"><%=memo %></textarea>
    </td>
  </tr>
</table>


</div>
</div>
</td></tr></table>
    </form>
<%
}
	rs.close();
	db.close();
 %>
</body>
</html>
