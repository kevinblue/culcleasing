<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<!-- 09.01.05 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>修改节假日</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
</head>
<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">基础信息管理 &gt; 修改节假日</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">

<form name="form1"  method="post" action="jjr_save.jsp" onSubmit="return Validator.Validate(this,3);">
<!-- end cwCellTop -->
<div id="cwCellContent">
<%
String sqlstr;
String czid;
String date;
String ishr;
String notes;
String jjr;
String hrjjr;
String jjr1;
String hrjjr1;
ResultSet rs;
czid=getStr(request.getParameter("czid"));
sqlstr = " SELECT * FROM hr_jjr where id='"+czid+"' ";  
rs=db.executeQuery(sqlstr); 
if (rs.next()) 
{
	date=getDBStr(rs.getString("date"));
	ishr=getDBStr(rs.getString("ishr"));
	notes=getDBStr(rs.getString("notes"));
	
%>
<input type="hidden" name="savetype" value="mod"><input type="hidden" name="kid" value="<%=rs.getString("id")%>">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
	<tr>
	<td width="16%" scope="row">日期</td>
   <td><input name="date" type="text" value="<%=getDBDateStr(rs.getString("date"))%>" class="text" readonly maxlength="10" dataType="Date"    Require="true" > <img onClick="openCalendar(date);return false;" style="cursor:pointer; " src="../../images/btn_time.gif" border="0" align="absmiddle"><span class="biTian">*</span></td>
</tr>

  <tr>
    <td scope="row">是否节假日</td>

      <%
	      jjr=getDBStr(rs.getString("ishr"));
	      hrjjr=null;
	      if(jjr.equals("1"))
		  {
			  hrjjr="是";
		  }
		  else
	      {
			  hrjjr="否";
			  jjr="0";
	      }	      
      %>
    <td><select name="ishr"  class="select_css">
		<option value="<%=jjr%>"><%=hrjjr%></option>
           <%
               jjr1=null;
	           hrjjr1=null;
              if(hrjjr.equals("是"))
	          {
			     hrjjr1="否";
				 jjr1="0";
		     
			  }
			  if(hrjjr.equals("否"))
	          {
				  hrjjr1="是";
			      jjr1="1";
              }
            %>
			<option value="<%=jjr1%>"><%=hrjjr1%></option>

	        </select></td>
  </tr>
  <tr>
    <td scope="row">备注</td>
    <td><input name="notes" type="text" value="<%=getDBStr(rs.getString("notes"))%>"  label="提取比例" ></td>
  </tr>

</table>
<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwCell -->
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
<!-- end cwToolbar -->
    </form>
    <%
}
else
{
%>
 <center>该条记录不存在!</center>
<div id="cwToolbar" >
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<%
}
rs.close(); 
db.close();
%>
</div>
<!-- end cwMain -->
</body>
</html>