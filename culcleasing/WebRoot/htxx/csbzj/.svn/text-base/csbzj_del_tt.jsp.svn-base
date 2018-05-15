<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<%
String czid;
String sqlstr;
ResultSet rs;
czid=getStr(request.getParameter("id"));

	sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from contract_manuf where id="+czid;
	 
	 rs = db.executeQuery(sqlstr);

String manuf_name="";
String margin_per="";
String initial_margin="";




String creator="";
String create_date="";
String modificator="";
String modify_date="";
	if(rs.next()){
		
           
			
             manuf_name=getStr(request.getParameter("manuf_name"));
			 margin_per=getStr(request.getParameter("margin_per"));
			 initial_margin=getStr(request.getParameter("initial_margin"));
			
	
            creator=getStr(request.getParameter("creator"));
            create_date=getStr(request.getParameter("create_date"));  
            modificator=getStr(request.getParameter("modificator"));
            modify_date=getStr(request.getParameter("modify_date")); 
	
%>
<body onLoad="public_onload(44);fun_winMax();">
<form name="form1"  method="post" action="csbzj_save_tt.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
结算保证金管理 &gt; 结算保证金删除
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
	 <td >厂商名字：</td>
    <td ><%=getDBStr(rs.getString("manuf_name"))%></td>
  </tr>
  
  <tr>
    <td >保证金比率：</td>
    <td >
       <%=getDBStr(rs.getString("margin_per"))%>%</td>
  </tr>
    <tr>
    <td >保证金初始金额：</td>

     <td ><%=formatNumberStr(rs.getString("initial_margin"),"#,##0.00")%>元</td>
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


</body>
</html>
