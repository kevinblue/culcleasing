<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>测试</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script type="text/javascript">
function jsTest(){
	alert("起租日期："+document.form1.start_date.value);
}
</script>
</head>

<body onload="public_onload(0);">
<!-- form表单跳转到zjcs_projSave.jsp页面    doCument.forms[0].onsubmit()-->
<form name="form1" method="post"  action="cond_save.jsp" onSubmit="return Validator.Validate(this,2);check_allInput();">
<table  class="title_top" width=100% height="100%" align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
	<td  align=center width=100% height=100%>
	<!-- 隐藏域传值  -->
	<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:430px;overflow:auto;">
	<div id="TD_tab_0">
		<table  border="0" cellspacing="0" cellpadding="0" width="100%" height=100%" align="center" class="tab_table_title">
			<tr><td colspan="8"></td></tr>
		
		  <tr>
		  	<td  scope="row" nowrap>起租日</td>
			<td>
				<input name="start_date" type="text" onpropertychange="jsTest()"
					 size="13" maxlength="20" readonly="readonly"/>
				<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
				<span class="biTian">*</span>
			</td>
			<td  scope="row" nowrap>每月偿付日1</td>
			<td>
				<input name="sd" type="text" >
				<span class="biTian">*</span>
			</td>
			
			<td  scope="row" nowrap>每月偿付日2</td>
			<td>
				<select name="income_day" style="width: 100px;">
					<script type="text/javascript">
						for(var i=1;i<=31;i++){
							document.write("<option value='"+i+"'>"+i+"</option>");
						}
					</script>
				</select>	 
				<span class="biTian">*</span>
			</td>
		  </tr> 
		</table>
		</div>
		</div>
	</td>
	</tr>
</table>
</form>
</body>
<script  type="text/javascript" src="../../js/leasing_rentcalc.js"></script>
</html>
