<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>下属公司 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
</head>


<body>


<form name="form1" method="post" action="khxsgs_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt;下属公司
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
<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">删除</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
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
<!-- end cwTop -->
<!-- end cwCellTop -->

<%
	String id = getStr( request.getParameter("czid") );
	String create_date = "";
	String cust_id = "";	
	String memo = "";
	String creator = "";	
	String modificator = "";
	String modify_date = "";
	
	String rank = "";
	String reg_number = "";
	String primary_ratio= "";
	String stake = "";
	String biz_scope_primary = "";	
	String asset_size = "";
	String asset_liability = "";
    String profit_year = "";
	ResultSet rs;
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_member_company where id='" + id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_id = getDBStr( rs.getString("cust_id") );		
		rank = getDBStr( rs.getString("rank") );
		create_date = getDBDateStr( rs.getString("create_date") );
		memo = getDBStr( rs.getString("memo") );
		creator = getDBStr( rs.getString("dengjiren") );		
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
		reg_number = getDBStr( rs.getString("reg_number") );
		profit_year = getDBStr( rs.getString("profit_year") );
		stake = getDBStr( rs.getString("stake") );
		biz_scope_primary = getDBStr( rs.getString("biz_scope_primary") );
		asset_size = getDBStr( rs.getString("asset_size") );
		cust_id = getDBStr( rs.getString("asset_liability") );	
		
	}
	rs.close();
	db.close();
%>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="del">
<input type="hidden" name="czid" value="<%=id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
<tr>
    <td scope="row" nowrap>公司名称：</td>
    <td><%= rank %>
	</td>
    <td scope="row" nowrap>注册资本：</td>
    <td><%=reg_number %></td>
  </tr>
  <tr>
	<td scope="row" nowrap>持股比例：</td>
	<td><%=stake %>%</td>
  
    <td scope="row" nowrap>主营业务：</td>
    <td><%=biz_scope_primary %></td>
  </tr>
  
  <tr>
	<td scope="row" nowrap>资产规模：</td>
	<td><%=asset_size %></td>
  
    <td scope="row" nowrap>资产负债率：</td>
    <td><%=asset_liability %>%</td>
  </tr>
 
 <tr>
	<td scope="row" nowrap>本年净利润：</td>
	<td><%=profit_year %></td>
	<td></td><td></td>
  </tr>
   <tr>
  <td scope="row" nowrap>备注：</td>
   <td colspan="5" rowspan="3"><%=memo %></td>
    <td></td><td></td>
  </tr>
</table>


</div>
</div>
</td></tr></table>
    </form>

</body>
</html>
