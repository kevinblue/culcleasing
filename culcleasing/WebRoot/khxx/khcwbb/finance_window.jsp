<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������񱨱�--�ϴ��ļ�</title>
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
</head>
<%
String context = request.getContextPath();
String userId=getStr(request.getParameter("userId"));
String custId =(String)(request.getParameter("custId"));
 %>

<body onload="public_onload(0);">

<form name="finance_upload_form" id="finance_upload_form" action="javascript:void(0)" enctype="multipart/form-data" method="post"  onsubmit="return fun_save()" >
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:10px;height:400px;">
	<table border="0" cellspacing="0" cellpadding="0"  class="tab_table_title" style="margin-top:30px">
	  <tr>
		<td >ѡ���ϴ��ļ���&nbsp;&nbsp;</td>
		<td>
			<input type="file" id="financeFile" name="financeFile" style="width:200px;">
		</td>
	  </tr>
	  	<tr >				
		<td nowrap id="saveTd" align="center" colspan="2">
			<input style="margin:20px;width:80px;height:20px;"  type="submit" value="ȷ���ϴ�"/>
		</td>
		</tr>
	
	</table>
</div>
<script language="javascript">

function fun_save(){

	var dataNav = document.getElementById("finance_upload_form");
	//�ϴ��ļ���������ȷ
	var financeFile = document.finance_upload_form.financeFile.value;
	var extType =financeFile.substr(financeFile.lastIndexOf(".")+1);
	if(extType!='xls'){
		alert("�Բ���ֻ�����ϴ�xls�ļ���");
		document.finance_upload_form.financeFile.value = "";
		return false;
	}
		
	if(confirm("ȷ��Ҫ�ϴ����񱨱��ļ�:"+financeFile)){
		document.getElementById("saveTd").innerHTML="�ļ��ϴ��У����Ժ�";
		//document.forms[0].submit();
		//<%=context %>/servlet/FinanceUploadServlet?userId=<%=userId %>&custId=<%=custId %>
	
	}
	var  userId="<%=userId %>";
	 var confirstr=false;
	var message='';
	   //ѡ���ļ�֮��ִ���ϴ�  
	  $.ajaxFileUpload({  
		url:'<%=context %>/servlet/FinanceCheckUploadServlet?userId=userId&custId=<%=custId %>',  
		secureuri:false,  
		fileElementId:'financeFile',//file��ǩ��id  
		dataType: 'json',//�������ݵ����� 
		data:{},//һͬ�ϴ�������  
		success: function(res){ 				
			//alert(<%=request.getAttribute("message") %>);						
			var fileName=res.fileName;
			var custId=res.custId;
			if(res.msg!=""&&confirm(res.msg+"�Ƿ�������룡"))
			{				
				  $.ajax({  
						  url: '<%=context %>/servlet/FinanceUploadServlet',  
						  type: 'POST', 
						  cache: false,
						  async: false,							  
						  dataType: 'text',//�������ݵ����� 
						  data: {'custId':custId,'userId':userId,'fileName':fileName},  
						  success: function (resdata) {	
								if(resdata=="success!"){
									message="�ɹ����룡";
								}else{
									message=resdata;
								}
								
						  },
						  error: function (resdata) {  
							message="����ʧ��"+resdata;
						} 
				 });  		 			 
				
			}else{
				message="ȡ������Ʊ���";
			}		
			 window.close();
			 window.opener.alert(message);
			 window.opener.location.reload(); 
		},  
		error: function (e) {  
			alert(e);  
		}  
	});  
		

}
</script>
</form>
</body>
</html>
