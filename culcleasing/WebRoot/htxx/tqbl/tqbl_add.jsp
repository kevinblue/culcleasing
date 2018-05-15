<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增外币信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>



</head>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="tqbl_save.jsp"  onSubmit="return Validator.Validate(this,3);">

<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理管理 &gt; 提取比例
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">提交生效</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<input type="hidden" name="savetype" value="add">
<table border="1" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  
   
  <tr>
    <td scope="row">资产分类：</td>
    		<td><select name="fiveclass" Require="true" ></select>
<script language="javascript">dict_list("fiveclass","five_class","","title");</script>
 </td>
  <tr>
    <td scope="row">提取比例：</td>
    <td><input class="text" name="scale" type="text" Require="true"  maxlength="20">
    <span class="biTian">*</span></td>
  </tr>
 
  
  
   
</table>
</div>

<script type="text/javascript">
	function searchInfo(){
		var cardNo=$("#org_code").val();
		$.ajax({
   			type: "POST",
   			url: "frkh_info.jsp",
   			data: "cardId="+cardNo,
   			dataType: "xml",
   			success:function(data){
   				var obj = $(data);
   				var error=obj.find("error").text();
   				if(error==""){
    				$("#custId").val(obj.find("custId").text());
				    $("#custName").val(obj.find("custName").text());
				    $("#licenseNo").val(obj.find("licenseNo").text());
				    $("#comTel").val(obj.find("comTel").text());
				    $("#legal").val(obj.find("legal").text());
				    $("#legalCardNo").val(obj.find("legalCardNo").text());
				    $("#legalTel").val(obj.find("legalTel").text());
				    $("#legalPhone").val(obj.find("legalPhone").text());
				    $("#province").val(obj.find("province").text());
				    $("#provinceName").val(obj.find("provinceName").text());
				    $("#city").val(obj.find("city").text());
				    $("#contact").val(obj.find("contact").text());
				    $("#contactCardNo").val(obj.find("contactCardNo").text());
				    $("#contactTel").val(obj.find("contactTel").text());
				    $("#contactPhone").val(obj.find("contactPhone").text());
					var branchval=obj.find("branch").text()
					$("#branch option[value='"+branchval+"']").attr("selected",true);

				    $("#assets").val(obj.find("assets").text());
				    $("#regMoney").val(obj.find("regMoney").text());
				    $("#savetype").val("add2");
   				}else{
   				    alert(error);
    				$("#custId").val("");
				    $("#custName").val("");
				    $("#licenseNo").val("");
				    $("#comTel").val("");
				    $("#legal").val("");
				    $("#legalCardNo").val("");
				    $("#legalTel").val("");
				    $("#legalPhone").val("");
				    $("#province").val("");
				    $("#provinceName").val("");
				    $("#city").val("");
				    $("#contact").val("");
				    $("#contactCardNo").val("");
				    $("#contactTel").val("");
				    $("#contactPhone").val("");
				    $("#branch").val("");    
				    $("#regMoney").val(""); 
				    $("#assets").val(""); 
				   $("#savetype").val("add");
			    }
   			}
   		});
	}
</script>
</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->
</form>

<!-- end cwMain -->
</body>
</html>
