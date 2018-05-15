<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-担保物管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("id"));
   // String id = getStr( request.getParameter("id") );
	//String cust_id = getStr( request.getParameter("custId") );
	 sqlstr = "select *,proj_info.project_name from contract_guarantee_equip left join contract_info on contract_guarantee_equip.contract_id=contract_info.contract_id left join proj_info on contract_info.proj_id=proj_info.proj_id where id="+czid; 
	 rs = db.executeQuery(sqlstr);
	//String cust_id="";//客户名称\省份

	 String total_price="";
	String registraction_authority="";
	String contract_id="";
	String pay_date="";
	String equip_num="";
	String ownership_document="";
	String eqip_name="";
	String equip_guarantee_type="";
	String zheng_hao="";
	if(rs.next()){
		//cust_id=getDBStr(rs.getString("cust_id"));
		total_price=getDBStr(rs.getString("total_price"));
		registraction_authority=getDBStr(rs.getString("registraction_authority"));
		contract_id=getDBStr(rs.getString("contract_id"));
		equip_num=getDBStr(rs.getString("equip_num"));
			zheng_hao=getDBStr(rs.getString("zheng_hao"));
	    ownership_document=getDBStr(rs.getString("ownership_document"));
	    eqip_name=getDBStr(rs.getString("eqip_name"));
	    equip_guarantee_type=getDBStr(rs.getString("equip_guarantee_type"));
	
	
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="dydw_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
担保物管理 &gt; 担保物删除
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
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
<center>

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">




<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
  <td >项目名称：</td>
    <td ><%=getDBStr(rs.getString("project_name"))%></td>
    <td >合同编号：</td>
    <td ><%=getDBStr(rs.getString("contract_id"))%></td>
 
   
  </tr>
  <tr>
  <td >类型：</td>
    <td ><%=getDBStr(rs.getString("equip_guarantee_type"))%>
    <td >登记机关:</td>
    <td >
       <%=getDBStr(rs.getString("registraction_authority"))%></td>
</tr>

<tr>
  <td >担保原值：</td>
    <td ><%=formatNumberStr(rs.getString("original_value"),"#,##0.00")%>元</td>
    <td >担保金额：</td>
    <td ><%=formatNumberStr(rs.getString("total_price"),"#,##0.00")%>元</td>
  </tr>
  <tr>
  <td >评估值：</td>
    <td ><%=formatNumberStr(rs.getString("eval_value"),"#,##0.00")%>元</td>
    <td >评估机构：</td>
    <td > <%=getDBStr(rs.getString("assessment_agencies"))%></td>
  </tr>
  
    <tr>
  <td >评估日期：</td>
     <td > <%=getDBStr(rs.getString("assessment_date"))%></td>
    <td >保险情况：</td>
    <td > <%=getDBStr(rs.getString("insurance_situation"))%></td>
  </tr>
  <tr>
     <td >担保物名称：</td>
    <td > <%=getDBStr(rs.getString("eqip_name"))%></td>
     <td >担保物所在地：</td>
    <td > <%=getDBStr(rs.getString("collateral_place"))%></td>
	</td>
  </tr>
    <tr>
    <td >证号：</td>
    <td ><%=getDBStr(rs.getString("zheng_hao"))%></td>
  
    <td >期限：</td>
    <td ><%=getDBStr(rs.getString("ownership_document"))%></td>
  </tr>
    <tr>
     <td >备注：</td>
     <td ><textarea class="text" readonly><%=getDBStr(rs.getString("memo"))%></textarea></td>
    </tr>
	
</table>
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

<%
}
	rs.close(); 
	db.close();
 %>






</form>

<!-- end cwMain -->
</body>
</html>
