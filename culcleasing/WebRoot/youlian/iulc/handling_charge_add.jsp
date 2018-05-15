<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*" errorPage="" %>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新增手续费拆份-手续费拆分报表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script type="text/javascript">
function choiceRentInfo(){
	var contractId = document.form1.contract_id.value;
	if(contractId==""){
		alert("请先选择合同标号！");
	}else{
		alert('choice_rent_info.jsp?contract_id='+contractId);
		popUpWindow('choice_rent_info.jsp?contract_id='+contractId,250,350);
	}
}
</script>
</head>

<body onLoad="public_onload(44)" style="border:0px solid #8DB2E3;">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">手续费拆份报表 &gt; 新增手续费拆分</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<div class="mydivtab" id="mydiv">
<form name="form1" method="post" action="khhyml_save.jsp" onSubmit="return Validator.Validate(this,3);">

<input type="hidden" name="savetype" value="add">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td width="16%" scope="row">合同编号</td>
    <td >
      	<input name="contract_id" type="text" size="50" maxlength="1" label="合同编号"  Require="true" readonly="readonly" >
      	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="popUpWindow('choice_contract_info.jsp',250,350)"> <span class="biTian">*</span>
</td>
  </tr>
  <tr>
    <td scope="row">项目名称</td>
    <td>
	<input name="project_name" type="text" size="100" maxlength="100" label="" readonly="readonly" > </td>
  </tr>
  <tr>
    <td scope="row">计划日期</td>
    <td>
		<input name="plan_date" type="text" size="20" maxlength="30" label=""  readonly="readonly" >
	</td>
  </tr>
  <tr>
    <td scope="row">期次</td>
    <td>
	<input name="plan_list" type="text" size="20" maxlength="30" label="期次" Require="true" readonly="readonly" > 
	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="return choiceRentInfo();"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td scope="row">本金</td>
    <td>
	<input name="corpus" type="text" size="20" maxlength="30" label="" readonly="readonly" > </td>
  </tr>
  <tr>
    <td scope="row">租赁收入</td>
    <td>
	<input name="interest" type="text" size="20" maxlength="30" label=""  readonly="readonly"> </td>
  </tr>
  <tr>
    <td scope="row">
    其中：租息
	<input name="hymlmc" type="text" size="15" maxlength="20" label=""  ></td> <td>
	手续费<input name="hymlmc" type="text" size="20" maxlength="30" label=""  > 
	其它收入<input name="hymlmc" type="text" size="20" maxlength="30" label=""  > 
	其它支出<input name="hymlmc" type="text" size="20" maxlength="30" label=""  > 
	</td>
  </tr>
  <tr>
    <td scope="row">剩余本金</td>
    <td>
	<input name="corpus_overage" type="text" size="20" maxlength="30" label=""  > </td>
  </tr>
</table>


<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr valign="top"><td>
<input name="btnSave" value="保存" type="submit" class="btn3_mouseout"></td>

<td>
<input name="btnClose" value="取消" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
</form>

</div>
</td></tr></table>
<!-- end cwToolbar -->
</body>
</html>
