<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目多次签约控制</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>

<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
function chkform(form){
	var obj=document.getElementsByName("is_floor");
	var status="";
	for(var i = 0; i < obj.length; i++) { 
		if(obj[i].checked) { 
			status =obj[i].value; 
			} 
		}
	//alert(status);
	
//	if(status=="否"){
//		alert("请先选择是否多次签约！");
//		return false;
//	}
if (/[^0-9\.]/.test(form.floor_rent.value) || isNaN(form.floor_rent.value) ||form.floor_rent.value=="" ) {
		alert("请确认保底金额");
		return false;
	}
	//return false;
	return confirm("确定要提交吗？")
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
String change_contract_id=getStr(request.getParameter("change_contract_id"));

sqlstr ="select * from vi_flow_bd_rent where 1=1 ";

if ((change_contract_id==null) || (change_contract_id.equals("")))
{
   sqlstr += " and 1=2 ";
}else{
   sqlstr += " and b.contract_id='"+change_contract_id+"'";
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">项目提交</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="list" action="base_rent_change_save.jsp" target="_self" onSubmit="return chkform(this)">
<input type="hidden" name="change_contract_id"  value="<%=change_contract_id%>">
 <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	     <th>合同编号</th>
	    <th>项目名称</th>
	    <th>行业</th>
	    <th>租赁本金</th>
	    <th>设备金额</th>
     	<th>保底金额</th>
      </tr>
<%
System.out.print("我需要的"+sqlstr);
rs=db.executeQuery(sqlstr); 
while (rs.next())
{ 
%>  
      <tr class="cwDLRow" >
        <td align="left"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("industry_name"))%></td>
        

        <td align="left"><%=getDBStr(rs.getString("lease_money"))%></td>
        <td align="left"><%=getDBStr(rs.getString("equip_amt"))%></td>
        <td align="left"><%=getDBStr(rs.getString("equip_amt"))%></td>
      </tr>
<%
  }
rs.close(); 
db.close();
%>

	<input type="hidden" name="is_floor" id="is_floor" value="是"/>
	<tr class="cwDLRow" > 
		<td colspan="6" align="center">保底金额填写
		<input name="floor_rent" id="floor_rent"  type="text" size="20"   Require="ture">
		</td>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center" nowrap="nowrap">
		<input type="image" value="提交" width="25px;" src="../../images/save.gif">提交
		</td>
    </tr>
</table>
</form>
</div>

</body>
</html>

