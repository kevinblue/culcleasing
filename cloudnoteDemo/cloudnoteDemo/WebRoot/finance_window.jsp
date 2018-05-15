<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>导入财务报表--上传文件</title>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script Language="Javascript" src="../../js/ajaxfileupload.js"></script>
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
<body onload="public_onload(0);">

<form name="finance_upload_form" id="finance_upload_form" action="javascript:void(0)" enctype="multipart/form-data" method="post"  onsubmit="return fun_save()" >
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:10px;height:400px;">
	<table border="0" cellspacing="0" cellpadding="0"  class="tab_table_title" style="margin-top:30px">
	  <tr>
		<td >选择上传文件：&nbsp;&nbsp;</td>
		<td>
			<input type="file" id="financeFile" name="financeFile" style="width:200px;">
		</td>
	  </tr>
	  	<tr >				
		<td nowrap id="saveTd" align="center" colspan="2">
			<input style="margin:20px;width:80px;height:20px;"  type="submit" value="确认上传"/>
		</td>
		</tr>
	
	</table>
</div>
<script language="javascript">

function fun_save(){

	var dataNav = document.getElementById("finance_upload_form");
	//上传文件类型是正确
	var financeFile = document.finance_upload_form.financeFile.value;
	var extType =financeFile.substr(financeFile.lastIndexOf(".")+1);
	if(extType!='xls'){
		alert("对不起，只允许上传xls文件！");
		document.finance_upload_form.financeFile.value = "";
		return false;
	}
		
	if(confirm("确认要上传财务报表文件:"+financeFile)){
		document.getElementById("saveTd").innerHTML="文件上传中，请稍后";
		//document.forms[0].submit();
		//<%=context %>/servlet/FinanceUploadServlet?userId=<%=userId %>&custId=<%=custId %>
	
	}
	var  userId="<%=userId %>";
	 var confirstr=false;
	var message='';
	   //选择文件之后执行上传  
	  $.ajaxFileUpload({  
		url:'<%=context %>/servlet/FinanceCheckUploadServlet?userId=userId&custId=<%=custId %>',  
		secureuri:false,  
		fileElementId:'financeFile',//file标签的id  
		dataType: 'json',//返回数据的类型 
		data:{},//一同上传的数据  
		success: function(res){ 				
			//alert(<%=request.getAttribute("message") %>);						
			var fileName=res.fileName;
			var custId=res.custId;
			if(res.msg!=""&&confirm(res.msg+"是否继续导入！"))
			{				
				  $.ajax({  
						  url: '<%=context %>/servlet/FinanceUploadServlet',  
						  type: 'POST', 
						  cache: false,
						  async: false,							  
						  dataType: 'text',//返回数据的类型 
						  data: {'custId':custId,'userId':userId,'fileName':fileName},  
						  success: function (resdata) {	
								if(resdata=="success!"){
									message="成功导入！";
								}else{
									message=resdata;
								}
								
						  },
						  error: function (resdata) {  
							message="导入失败"+resdata;
						} 
				 });  		 			 
				
			}else{
				message="取消导入财报！";
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
