<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.util.CurrencyUtil"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>������Ŀ</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

	<script language="javascript" src="/dict/js/js_dictionary.js"></script>
	<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>

	<script src="../../js/comm.js"></script>
	<script src="../../js/validator.js"></script>
	<script src="../../js/calend.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

	<script type="text/javascript">
	// �Ƿ�����ύ��������
	function isSub(obj) {
		var names=document.getElementsByName("list");
		var statu=0;
		for(i=0;i<names.length;i++){
			if (names[i].checked){
				statu++;
			}
		}
		if (statu==0) {
			alert("��ѡ����Ҫ��ӵ���Ŀ!");
			return false;
		} else{
			document.dataNav.action="apply_save.jsp";
			
			return confirm("�Ƿ�ȷ���ύ��");
		}
		return false;
	}
	</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<body onload="public_onload(0);">
<form name="dataNav" method="get" action="proj_info.jsp">
<input id="savetype" name="savetype" type="hidden" value="add">
<input id="sqlIds" name="sqlIds" type="hidden" >

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
	<td class="tree_title_txt"  height=26 valign="middle">
	������Ŀ
	</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
	<!--������ť��ʼ-->
	<tr><td>
	<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
		<BUTTON class="btn_2" value="����"  type="submit"  onclick="return isSub(this);" >
		<img src="../../images/save.gif" align="absmiddle" border="0">����</button>

		<BUTTON class="btn_2" value="ȡ��" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
		</td>
	  </tr>
	</table>
	</td></tr><!--������ť����-->
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>

<tr><td width="100%">
<table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">������Ϣ</td>

 </tr>
</table></td></tr> 

<script language="javascript">
ShowTabN(0);
</script>

<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:80%;overflow:auto;">
<div id="TD_tab_0">
<%

wherestr="";
//����
String cust_id = getStr( request.getParameter("cust_id") );

wherestr=" and cust_id='"+cust_id+"'";


%>

<!-- �������� -->
<table border="0" cellspacing="0" cellpadding="0" width="1200" align="center" class="tab_table_title">
<tr class="maintab">
	<td align="left" colspan="7"></td>
</tr>
  
<tr>
    
    <td> 
	 <input name="ck_all" type="checkbox" onclick="isSelectAll();" style="border: none;">&nbsp;ȫѡ
    </td>
</tr>
</table>

<!-- �����б� -->
<div style="vertical-align:top;width:1200;overflow:auto;position: relative;height:80%;" id="mydiv">				
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
	<tr class="maintab_content_table_title">
		 <th width="1%"></th> 
		 <th>��Ŀ����</th>
		 <th>��ͬ���</th>
		 <th>������ҵ</th>
	     <th>����</th>
	     <th>����</th>
	     <th>��Ŀ����</th>
	     <th>��������</th>
	     <th>������ʽ</th>
	     <th>CD����ʱ��</th>
	     <th>��Ŀ״̬</th>
	    
	</tr>
<tbody id="data">						
<%
sqlstr = "select * from vi_contract_info where 1=1 "+wherestr+" order by contract_id";
rs = db.executeQuery(sqlstr); 
//��ѡ��id
String item_id="";
String contract_id="";
while (rs.next()){
	item_id = getDBStr(rs.getString("id"));
	contract_id= getDBStr(rs.getString("contract_id"));
 %>
<tr>
	<td><input type="checkbox" name="list" onclick="makeValue()" style="border: none;" item_id="<%=item_id %>" contract_id="<%=contract_id%>"></td>
	<td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
	<td align="center"><%=getDBStr(rs.getString("contract_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("industry_type_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("parent_deptname")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("dept_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("proj_manage_name")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("leas_type")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("leas_form")) %></td>
   	<td align="left"><%=getDBStr(rs.getString("cd_date")) %></td>
   	<td align="center"><%=getDBStr(rs.getString("status_name")) %></td>
   
</tr>
<%	} %>
</tbody>
</table>
</div>
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
<!--��ӽ���-->
<%
rs.close(); 
db.close();
%> 
</form>
<!-- end cwMain -->
<script type="text/javascript">
//ȫѡ
function isSelectAll () {
	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	
}
</script>
</body>
</html>
