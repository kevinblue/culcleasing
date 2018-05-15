<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%@ page import="java.sql.*" %> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>厂商保证金管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
	<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>




</head>



<body >
<form name="form1"  method="post" action="csbzj_save_tt.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
厂商保证金管理&gt; 厂商保证金修改
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
	    	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
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
<%
String czid;
String sqlstr;

ResultSet rs;
czid=getStr(request.getParameter("id"));
	
sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from contract_manuf where id="+czid;  

 rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr#####***********####"+sqlstr);
//String id="";
String manuf_name="";
String margin_per="";
String initial_margin="";


String creator="";
String create_date="";
String modificator="";
String modify_date="";

	if(rs.next()){
	      
  
		//id=getDBStr(rs.getString("id"));
		manuf_name=getDBStr(rs.getString("manuf_name"));
	    margin_per=getDBStr(rs.getString("margin_per"));
	    initial_margin=getDBStr(rs.getString("initial_margin"));
		

        creator=getDBStr(request.getParameter("creator"));
        create_date=getDBStr(request.getParameter("create_date"));  
        modificator=getDBStr(request.getParameter("modificator"));
        modify_date=getDBStr(request.getParameter("modify_date"));  
	  
	
	
%>
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=czid  %>">

<input class="text" type="hidden" name="id" value="<%=getDBStr(rs.getString("id"))%>">


<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
   
    <td scope="row">厂商名称：</td>
	  <td><input class="text" name="manuf_name" type="text" size="20"  value="<%=getDBStr(rs.getString("manuf_name"))%>"  maxlength="50"  ></td>
  </tr>
  <tr>
  
     <td scope="row">保证金比率:</td>
  
	   <td><input class="text" name="margin_per" type="text" size="20"  value="<%=getDBStr(rs.getString("margin_per"))%>"  maxlength="50" dataType="Number" >%</td>
 
  </tr>
  
    <tr>
    <td scope="row">保证金初始额：</td>
    <td><input class="text" name="initial_margin" type="text" size="20" Require="true"   dataType="Money"  value="<%=formatNumberStr(rs.getString("initial_margin"),"#,##0.00")%>" maxlength="20"><span class="biTian">*</span></td>
   
</table>
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
</form>
<%
}
	rs.close(); 
	db.close();
 %>
<!-- end cwMain -->
</body>
</html>