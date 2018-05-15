<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户移交管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>

<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
function chkform(form){
	if(form.yhid.value==""){
		alert("请先选择移交对象！");
		return false;
	}
	return confirm("确定要移交吗？")
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
 String khstr=getStr(request.getParameter("khstr"));
 if ((khstr==null) || (khstr.equals("")))
 {
    sqlstr="select * from vi_cust_all_info_t where (1=0)"; 
 }else
 {
     sqlstr ="select cust_id,cust_name,cust_code,parent_company,lbdlmc,hymlmc,create_date,modify_date,dept_name,dengjiren=dbo.GETUSERNAME(creator),";
     sqlstr+="xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_all_info_t "+khstr; 
 }
 //System.out.println("sqlstr"+sqlstr);
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">客户移交</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="list" action="khyj_save.jsp" target="_self" onSubmit="return chkform(this)">
<input type="hidden" name="savetype" value="yj" >
<input type="hidden" name="khstr"  value="<%=khstr%>">
 <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>客户编号</th>
        <th>客户名称</th>
        <th>客户代号</th>
        <th>登记人</th>
        <th>登记日期</th>
      </tr>
<%
rs=db.executeQuery(sqlstr); 
while (rs.next())
{ 
%>  
      <tr class="cwDLRow" >
        <td align="center" ><%=getDBStr(rs.getString("cust_id"))%>
        <input type="hidden" name="cust_id" value="<%=getDBStr(rs.getString("cust_id"))%>">
        </td>
        <td><a href="mingxi.jsp?czid=<%=getDBStr(rs.getString("cust_id"))%>&cust_code=<%= getDBStr( rs.getString("cust_code") ) %>" target="_blank"><%=getDBStr(rs.getString("cust_name"))%></a></td>
        <td><%=getDBStr(rs.getString("cust_code"))%>
        <input type="hidden" name="cust_code" value="<%=getDBStr(rs.getString("cust_code"))%>">
       </td>
        <td><%=getDBStr(rs.getString("dengjiren"))%></td>
        <td><%=getDBDateStr(rs.getString("create_date"))%></td>      
      </tr>
<%
  }
rs.close(); 
db.close();
%>

	<tr class="cwDLRow" > 
		<td colspan="6" align="center">将以上客户移交给:
		<input name="yhiddata" type="text" size="20" readonly  Require="ture">
		<input name="yhid" type="hidden">
		<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="popUpWindow('yhsel.jsp',250,350)">
		</td>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;移交客户备注:&nbsp;
		<textarea name="yj_remark" style="width: 200px;height: 60px;"></textarea>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center">
		<input type="image" value="移交" src="../../images/sbtn_yijiao_b.gif">
		</td>
    </tr>
</table>
</form>
</div>

<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top">
<!-- 
<td>
<input name="btnClose" value="关闭" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
 -->
</tr>
</table>
</div>

</body>
</html>

