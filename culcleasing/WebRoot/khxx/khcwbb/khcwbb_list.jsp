<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ����񱨱� - �ͻ���Ϣ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<body>
<form action="khcwbb_list.jsp" name="dataNav" onSubmit="return goPage()" >
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				�ͻ���Ϣ���� &gt;�ͻ����񱨱� </td>
			</tr>
</table>
<%
String custId=(String)(request.getParameter("custId"));
String userId =getStr(request.getParameter("userId"));
System.out.println("�����ֲ��ԲƱ��б�userId:"+userId);
String users="ADMN-8GRBW4,ADMN-8HT5H6";

%>
<input style="margin:10px;width:100px;height:20px;" type="button"   value="������񱨱�" onclick="importFinanceReport()"/>
<input style="margin:10px;width:100px;height:20px;" type="button"   value="���زƱ�ģ��" onclick="downlosdTempFile()"/>

<div style="text-align:left;width:98%;margin:10px">
<table border="0" cellspacing="0" cellpadding="0" >
 <tr>
  <td id="Form_s_tab_0" class="Form_tab" width=70 height=15 align=center onClick="chgTabSub()"  valign="middle">������Ϣ</td>
  <td id="Form_s_tab_1" class="Form_tab" width=140 height=15 align=center onClick="chgTabSub()"  valign="middle">ҽԺ�����뾭Ӫ��Ϣ</td>  
  <td id="Form_s_tab_2" class="Form_tab" width=100 height=15 align=center onClick="chgTabSub()"  valign="middle">�ط�������Ϣ</td>
 
 </tr>
 </table>
<table border="0" cellspacing="3" cellpadding="0" width="100%"  ><tr><td bgcolor="#8DB2E3" width="100%"><img height="1" width="1"></td></tr></table>
<div id="TD_s_tab_0" >
<iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" height="95%"  src="khcb_jcxx_list.jsp?custId=<%=custId%>&userId=<%=userId%>" align="center"></iframe>
</div>
<div id="TD_s_tab_1" style="display:none;">
<iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" height="95%" src="khcb_cwjy_list.jsp?custId=<%=custId%>&userId=<%=userId%>"></iframe>
</div>
<div id="TD_s_tab_2" style="display:none;"> 
<iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" height="95%" src="khcb_dfcl_list.jsp?custId=<%=custId%>&userId=<%=userId%>"></iframe>
</div>

</div>
<!-- end cwCellContent -->
</form>
<!-- end cwMain -->
<script language="javascript">
	ShowTabN(0);
	ShowTabSub(0);
	reinitIframe();
	//�ⲿdiv�߶�����Ӧ
	function reinitIframe(){
	var divH = document.getElementById("divH");
	var reinitIframe_resize=function(){
	divH.style.height=window.document.body.clientHeight-100;
	}
	reinitIframe_resize();
	window.onresize=reinitIframe_resize;
	}
	//�ڲ�Iframe�߶�����Ӧ
	function autoResize()
	{
		try
		{
			document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
			document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
			document.all["UserBody2"].style.height=UserBody2.document.body.scrollHeight
		}
		catch(e)
		{
			
		}
	}
	function importFinanceReport(){
		window.open('finance_window.jsp?custId=<%=custId%>&userId=<%=userId%>',"","width=400,height=300");
	}

	function importFinanceCall(message){
		window.location.reload(); 	
	}
	function downlosdTempFile(){
		window.open('finance_download.jsp?custId=<%=custId%>&userId=<%=userId%>',"","width=500,height=400");
	}
</script>
</body>
</html>
