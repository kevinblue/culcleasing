<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ�ƽ�����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>

<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
function chkform(form){
	if(form.change_proj_id.value==""){
		alert("����ѡ���ƽ�����");
		return false;
	}
	if(form.proj_manage_name.value==""){
		alert("����ѡ���ƽ����µ���Ŀ����");
		return false;
	}
	if(form.proj_assisant_name.value==""){
		alert("����ѡ���ƽ����µ���Ŀ����");
		return false;
	}
	if(form.transfer_date.value==""){
		alert("����ѡ���ƽ�ʱ�䣡");
		return false;
	}
	return confirm("ȷ��Ҫ�ƽ���")
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String change_proj_id=getStr(request.getParameter("change_proj_id"));

sqlstr = "select proj_id,project_name,trade,cust_name,proj_dept_name,proj_manage_name,proj_assistant_name,proj_changed_amout from vi_proj_change_list ";
if ((change_proj_id==null) || (change_proj_id.equals("")))
{
   sqlstr += " where 1=2 ";
}else{
   sqlstr += " where proj_id='"+change_proj_id+"'";
}
%>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="center">��Ŀ�ƽ�</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="list" action="proj_change_save.jsp" target="_self" onSubmit="return chkform(this)">
<input type="hidden" name="savetype" value="yj" >
<input type="hidden" name="change_proj_id"  value="<%=change_proj_id%>">
 <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>������</th>
     	<th>��ҵ</th>
 		<th>��Ŀ����</th>
		<th>��Ŀ����</th>
      </tr>
<%
rs=db.executeQuery(sqlstr); 
while (rs.next())
{ 
%>  
      <tr class="cwDLRow" >
      
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("cust_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("trade"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%>
        <input type="hidden" name="old_manager" value="<%=getDBStr(rs.getString("proj_manage_name"))%>">
        </td>
        <td align="left"><%=getDBStr(rs.getString("proj_assistant_name"))%>
        <input type="hidden" name="old_manage_assisant" value="<%=getDBStr(rs.getString("proj_assistant_name"))%>">
        </td>
      </tr>
<%
  }
rs.close(); 
db.close();
%>

	<tr class="cwDLRow" > 
		<td colspan="6" align="center">�ƽ�������Ŀ����:
		<input name="proj_manage_name" type="text" size="20" readonly  Require="ture">
		<input name="proj_manage_id" type="hidden">
		<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('change_manage.jsp',250,350)">
		</td>
    </tr>
	<tr class="cwDLRow" > 
		<td colspan="6" align="center">�ƽ�������Ŀ����:
		<input name="proj_assisant_name" type="text" size="20" readonly  Require="ture">
		<input name="proj_assisant_id" type="hidden">
		<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
		style="cursor:pointer" onclick="popUpWindow('change_assisant.jsp',250,350)">
		</td>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		�ƽ�ʱ��:&nbsp;
		<input name="transfer_date" type="text" size="20" readonly dataType="Date" value="<%=getSystemDate(0) %>">
		<img  onClick="openCalendar(transfer_date);return false" style="cursor:pointer; " 
		src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
    </tr>
    <tr class="cwDLRow" > 
		<td colspan="6" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ƽ���Ŀ��ע:&nbsp;
		<textarea name="ctmemo" style="width: 200px;height: 60px;"></textarea>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center">
		<input type="image" value="�ƽ�" src="../../images/sbtn_yijiao_b.gif">
		</td>
    </tr>
</table>
</form>
</div>

</body>
</html>

