<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>
<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������� - �ļ��ϴ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script Language="Javascript" src="../../js/jquery.js"></script>
<script src="../../js/comm.js"></script>

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

<script type="text/javascript">
function upload_file(){
	var uploadFileVal = $("input[name='uploadFile']").val();
	var extType = uploadFileVal.substr(uploadFileVal.lastIndexOf(".")+1);
	
	if(document.upload_form.uploadFile.value==""){
		alert("��ѡ���ϴ��ļ�");
		return false;
	}
	
	//�ϴ��ļ���������ȷ
	if(extType!='xls'){
		alert("�Բ���ֻ�����ϴ�xls�ļ���");
		$("input[name='uploadFile']").val("");
		return false;
	}
		
	if(confirm("ȷ��Ҫ�ϴ��ļ�"+uploadFileVal+"?")){
		document.getElementById("saveTd").innerHTML="<img src='../../images/ajax-loader-bk.gif' align='bottom' border='0'>�ļ��ϴ��У����Ժ�...";
		document.upload_form.submit();
	}
}
function showFileName(){
	var uploadFileVal = $("input[name='uploadFile']").val();
	var fileName = uploadFileVal.substring(uploadFileVal.lastIndexOf("\\")+1, uploadFileVal.lastIndexOf("."));
	
	$("input[name='uploadFileName']").val(fileName);
}
</script>
</head>

<%
//��ȡ����proj_id,doc_id
String contract_id = getStr(request.getParameter("contract_id"));
String doc_id = getStr(request.getParameter("doc_id"));

%>

<body onload="public_onload(0);">
<div style="margin-left:30px;margin-top:30px;border:1px solid gray;width:80%;height:70%;">
<form name="upload_form" action="cond_upload_save.jsp" enctype="multipart/form-data" method="post">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top"><td  align=center width=100%>
		<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
			<tr><td>
			<table border="0" cellspacing="0" cellpadding="0">    
			<tr class="maintab_dh">
				<td nowrap id="saveTd">
					<BUTTON class="btn_2" type="button" id="saveTd" onclick="return upload_file()">
					<img src="../../images/sbtn_2Excel.gif" align="bottom" border="0">�ϴ��ļ�</button>
				</td>
			</tr>
		</table></td></tr>
	</table></td></tr>
</table>

<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<div class="tabBody" style="background:#ffffff;overflow:auto;margin:0px;height:500px;">
	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
		<td align="right">�ϴ��ļ���&nbsp;&nbsp;</td>
		<td>
			<input type="file" name="uploadFile" style="width:250px;" onchange="showFileName()">
			<span class="biTian">�����ϴ����ļ�����.xls ���8M</span>
		</td>
	  </tr>
	  <tr>
		<td align="right">����ģ�ͣ�&nbsp;&nbsp;</td>
		<td>
	    <!--   <input type="text" name="uploadFileName" readonly="readonly" style="width:180px;"> --> 
	    <select name="uploadFileName" style="width:180px;"  Require="ture"  readonly="readonly">
   		<%
  		//List list=new ArrayList();
  		String settleMethod="";
  		String sqlStr2="SELECT title FROM ifelc_conf_dictionary WHERE parentid='root.cstype'";
  		rs=db.executeQuery(sqlStr2);
  		while(rs.next()){
  		settleMethod=rs.getString("title");
  		//list.add(name);
  		%>
  		<script type="text/javascript">
     	w(mSetOpt('',"<%=settleMethod %>","<%=settleMethod %>")); 
   		 </script>
  		<%
  		}
  		rs.close();
  		db.close();
   		%>
   
 	</select><span class="biTian">*</span>
		</td>
	  </tr>
	   <tr>
		<td colspan="2" align="center">
		 <a href="../../template/rent_calc_tmp/�ȶ�����.xls">����ģ���ļ�</a> 
		</td>
 </tr>
	</table>
</div>
</form>
</div>
</body>
</html>
