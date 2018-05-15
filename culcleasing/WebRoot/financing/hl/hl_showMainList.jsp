<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>汇率维护</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<body>
<form name="form1" action="tx_showMainList.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	汇率维护
      </td>
    </tr>
  </table>
  <!--标题结束-->
  

  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>外币名称</th>
	    <th>汇率</th>
		<th>操作</th>
      </tr>
	  <%
		sqlstr="select bc.id,title,isnull(exchange_rate,0) as exchange_rate from ifelc_conf_dictionary icd left join base_currency bc on bc.currency_name=icd.title where parentid='currency_type' and isnull(title,'')<>'人民币'";
		rs=db.executeQuery(sqlstr);
		while(rs.next()){
	  %>
      <tr>
		<td align="center" nowrap><%= getDBStr(rs.getString("title"))%>:人民币</td>
		<td align="center" nowrap><%= getDBStr(rs.getString("exchange_rate"))%>:1</td>
		<td align="center" nowrap>
		<a href="hl_fsi_add.jsp?title=<%=rs.getString("title")%>" target="_blank">
            		<img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" >修改
            	</a></td>
      </tr>
<%
		
	}
rs.close(); 
db.close();
%>
    </table>
  </div>
  

</form>
</body>
</html>
