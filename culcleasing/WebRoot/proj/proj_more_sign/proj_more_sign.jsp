<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���ǩԼ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>

<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
function chkform(form){
	var obj=document.getElementsByName("is_more");
	var status="";
	for(var i = 0; i < obj.length; i++) { 
		if(obj[i].checked) { 
			status =obj[i].value; 
			} 
		}
	//alert(status);
	
//	if(status=="��"){
//		alert("����ѡ���Ƿ���ǩԼ��");
//		return false;
//	}
	if(status=="��"&&form.start_amount.value==""){
		alert("Ԥ�ƶ��ǩԼ��������Ϊ�գ�");
		return false;
	}
	//return false;
	return confirm("ȷ��Ҫ�ƽ���")
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
String change_proj_id=getStr(request.getParameter("change_proj_id"));
String col_str="proj_id,project_name,br.trade,vcai.cust_name,(select dept_name from base_department where id=pif.proj_dept) as proj_dept_name,";
col_str+=" (select name from base_user where id=pif.proj_manage) as proj_manage_name,(select name from base_user where id=pif.proj_assistant) ";
col_str+=" as proj_assistant_name, isnull(is_more,'��') as is_more,isnull(start_amount,1) start_amount ";
sqlstr = "select  "+col_str+" from proj_info pif left join base_trade br on pif.industry_type=br.code ";
sqlstr += "left join vi_cust_all_info vcai on vcai.cust_id=pif.cust_id  ";
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
<form name="list" action="proj_more_sign_save.jsp" target="_self" onSubmit="return chkform(this)">
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
        </td>
      </tr>
<%
  }
rs.close(); 
db.close();
%>

	<tr class="cwDLRow" > 
		<td colspan="6" align="center">�Ƿ���ǩԼ����:
				<input type="radio" name="is_more" value=	"��" checked="checked">��
		    	<input type="radio" name="is_more" value="��">��
		</td>
    </tr>
	<tr class="cwDLRow" > 
		<td colspan="6" align="center">Ԥ�ƶ��ǩԼ��������:
		<input name="start_amount" id="start_amount" type="text" size="20"   Require="ture">
		</td>
    </tr>
    
    <tr class="cwDLRow" > 
		<td colspan="6" align="center" nowrap="nowrap">
		<input type="image" value="�ύ" width="25px;" src="../../images/save.gif">�ύ
		</td>
    </tr>
</table>
</form>
</div>

</body>
</html>

