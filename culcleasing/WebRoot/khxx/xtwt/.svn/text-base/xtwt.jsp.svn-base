<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>系统意见 - 系统意见库</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select *,xm=dbo.GETUSERNAME(refer_person) from system_suggestion where id=" + czid; 
	ResultSet rs = db.executeQuery(sqlstr); 


	//String cust_name = "";
String model="";
String action="";
String degree="";
String type="";
String remark="";
String describe="";
String appendix="";
String refer_date="";
String xm="";
String manage_person="";
String manage_opinion="";
String manage_date="";
String state="";
	if ( rs.next() ) {
		//cust_name = getDBStr( rs.getString("cust_name") );
		model = getDBStr( rs.getString("model") );
		action = getDBStr( rs.getString("action") );
		degree = getDBStr( rs.getString("degree") );
		type = getDBStr( rs.getString("type") );
		remark = getDBStr( rs.getString("remark") );
		describe = getDBStr( rs.getString("describe") );
		appendix = getDBStr( rs.getString("appendix") );
		refer_date=getDBDateStr( rs.getString("refer_date") );
		xm = getDBStr( rs.getString("xm") );
		state = getDBStr( rs.getString("state") );
		manage_person = getDBStr( rs.getString("manage_person") );
		manage_opinion = getDBStr( rs.getString("manage_opinion") );
		manage_date=getDBDateStr( rs.getString("manage_date") );
	}
	rs.close(); 
	db.close();
%>
<body>




<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
系统意见库管理 &gt; 系统意见明细
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
<a href="xtwt_mod.jsp?czid=<%= czid %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" width="19" height="19" align="absmiddle" >修改</a>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">明 细</td>
  
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
<!-- end cwCellTop -->



<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">



<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap>提交时间：</td>
    <td><%=refer_date %></td>
  <td scope="row" nowrap>提交人：</td>
    <td>
    	<%=xm %>
    	</td>
  <tr>
    <td scope="row" nowrap>模块：</td>
    <td><%=model %></td>
  <td scope="row" nowrap>功能：</td>
    <td>
    	<%=action %>
    	</td>
  </tr>
    <tr>
    <td scope="row" nowrap>优先程度：</td>
    <td><%=degree %></td>
  <td scope="row" nowrap>类型：</td>
    <td>
    	<%=type %>
    	</td>
  </tr>
      <tr>
          <td scope="row" nowrap>处理状态：</td>
    <td><%=state %></td>
    <td scope="row" nowrap>处理人：</td>
    <td><%=manage_person %></td>

  </tr>
  <tr>
  <td>处理意见：</td>
  	<td><%=manage_opinion %></td>
  	    <td scope="row" nowrap>处理时间：</td>
    <td>
    	<%=manage_date %>
    	</td>
  
  	
  	
  </tr>

  <tr>
    <td >问题描述：</td>
<td scope="row" >
    <textarea class="text" name="describe"  maxB="300" rows="15" readonly="readonly"><%=describe %></textarea></td>
        <td >备注：</td>
<td scope="row" >
    <textarea class="text" name="remark"  maxB="300" rows="15" readonly="readonly"><%=remark %></textarea></td>
  </tr>
  <tr>
    <td scope="row">附件：</td>
    <td scope="row"><%= appendix %></td>
  
    <td></td><td></td>
  </tr>
 
</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->

<!-- end cwToolbar -->


<!-- end cwMain -->
</body>
</html>
