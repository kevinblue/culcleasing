<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<%
String context = request.getContextPath();
String userId=(String)(request.getParameter("userId"));
String custId =(String)(request.getParameter("custId"));
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>导入财务报表--下载模板文件</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript" src="../../js/ajaxfileupload.js"></script>
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	font-family: Tahoma,Arial,Helvetica,Sans-Serif; 
	background: #DDE4EA; 
	margin: 0px; 
	padding: 0px;
	text-align:center;
}
img {
	border: none; 
	vertical-align: middle;
}
</style>
<script language="javascript">

function file_download(){
	
	var dataNav = document.getElementById("finance_download_form");
	//上传文件类型是正确
	var current_date = document.finance_download_form.current_date.value;
	if(!current_date){
		alert("请选择当前模板的时间");
		return false;
	}
	if(ajaxFunc(current_date)){
		return  true;
	}else{
		return  false;
	}
}
function  ajaxFunc(current_date){
	var result=false;
		 $.ajax({  
		  url: '<%=context %>/servlet/FinanceDownloadServlet',  
		  type: 'POST',
		cache: false,
		async: false,//只有在获取到了data值并赋值给result以后才会返回result完成该方法的调用	  
		  dataType: 'text',//返回数据的类型 
		  data: {"current_date":current_date},  
		  success: function (data) {
			 result=true;
		  },
		  error: function(data) {  
					   result=false;
                   }
	 }); 
	//alert(result);
	return  result;
}

</script>
</head>


<body onload="public_onload(0);">

<form name="finance_download_form" id="finance_download_form" action="javascript:void(0)" enctype="multipart/form-data" method="post" >

<div class="tabBody" style="background:#ffffff;overflow:auto;margin:10px;height:400px;">
	<table border="0" cellspacing="0" cellpadding="0"  class="tab_table_title" style="margin-top:30px">
	  <tr>
		<td >选择下载模板当前年月：&nbsp;&nbsp;</td>
		<td>
			<input  id="current_date" name="current_date" type="text" size="15" readonly dataType="Date" >
			<img  onClick="openCalendar(current_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		</td>
	  </tr>
	  	<tr >				
		<td colspan="2" align="center">
		<a href="../../template/finance_report_timpltag.xls"  onClick="return  file_download()" >下载模板文件</a>
		</td>
		</tr>
	
	</table>
</div>

</form>
</body>
</html>
