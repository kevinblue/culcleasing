<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>厂商保证金管理</title>

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
	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_mproj_info_cs where id="+czid;
	 
	 rs = db.executeQuery(sqlstr);


String contract_id="";


String manuf_name="";
String margin_per="";
String vendor_payment="";
String min_payment="";
String ensure_payment="";
String margin_amount="";
String deposit_amount="";
String margin_time="";
String margin_reason="";
String deposit_export="";
String export_time="";
String export_reason="";
String attachment="";


String creator="";
String create_date="";
String modificator="";
String modify_date="";
	if(rs.next()){
		
            contract_id=getStr(request.getParameter("contract_id"));
			
             manuf_name=getStr(request.getParameter("manuf_name"));
			 margin_per=getStr(request.getParameter("margin_per"));
			 vendor_payment=getStr(request.getParameter("vendor_payment"));
			 min_payment=getStr(request.getParameter("min_payment"));
			 ensure_payment=getStr(request.getParameter("ensure_payment"));
			 margin_amount=getStr(request.getParameter("margin_amount"));
			 deposit_amount=getStr(request.getParameter("deposit_amount"));
			 margin_time=getStr(request.getParameter("margin_time"));
			 margin_reason=getStr(request.getParameter("margin_reason"));
			 deposit_export=getStr(request.getParameter("deposit_export"));
			 export_time=getStr(request.getParameter("export_time"));
			 export_reason=getStr(request.getParameter("export_reason"));
			 attachment=getStr(request.getParameter("attachment"));
	
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date")); 
	
%>
<body onLoad="public_onload(44);fun_winMax();">
<form name="form1" enctype="multipart/form-data" method="post" action="csbzj_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
结算保证金管理 &gt; 汇出汇入记录删除
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
<img src="../../images/fdmo_01.gif" align="absmiddle" border="0">删除</button>
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

<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">


<input type="hidden" name="savetype" value="del">
<input type="hidden" name="id" value="<%=czid%>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
 
    <td >合同编号：</td>
    <td ><%=getDBStr(rs.getString("contract_id"))%></td>
	 <td >厂商名字：</td>
    <td ><%=getDBStr(rs.getString("manuf_name"))%></td>
  </tr>
  
  <tr>
    <td >保证金比率：</td>
    <td >
       <%=getDBStr(rs.getString("margin_per"))%></td>

  
    <td >厂商设备金额：</td>
    <td ><%=formatNumberStr(rs.getString("vendor_payment"),"#,##0.00")%>元</td>
  </tr>
    <tr>
    <td >保证金初始金额：</td>

     <td ><%=formatNumberStr(rs.getString("ensure_payment"),"#,##0.00")%>元</td>
  
    <td >保证金现有金额：</td>
       <td><%=formatNumberStr(rs.getString("margin_amount"),"#,##0.00")%>元</td>
  </tr>
    <tr>
     <td>保证金汇入金额：</td>
    <td><%=formatNumberStr(rs.getString("deposit_amount"),"#,##0.00")%>元</td>
    <td>保证金汇出金额：</td>
 
     <td><%=formatNumberStr(rs.getString("deposit_export"),"#,##0.00")%>元</td>

  </tr>
 
    <tr>
     <td>保证金汇入时间：</td>
     <td><%=formatNumberStr(rs.getString("margin_time"),"#,##0.00")%>元</td>
  
    <td>保证金汇出时间：</td>
     <td><%=formatNumberStr(rs.getString("export_time"),"#,##0.00")%>元</td>


  </tr>

    <tr>
   <td>最低保证金金额：</td>
     <td><%=formatNumberStr(rs.getString("min_payment"),"#,##0.00")%>元</td>
	<td scope="row">附件：</td>
    <td  name="fj_name"><%= attachment %></td>
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
