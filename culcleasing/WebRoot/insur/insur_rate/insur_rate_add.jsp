<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.util.ArrayList"%> 
<%@ page import="java.util.List"%> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��������</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script  src="../../js/sys_test_time.js"></script>
<script type="text/javascript">
	function closeWin(){
		opener.parent.location.reload();
		window.close();
	}
</script>
</head>
<body>
<%
String model = getStr(request.getParameter("model"));

%>
<form action="insur_rate_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);" name="form1">
<input type="hidden" name="model" value="add">
  <!--���⿪ʼ-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			��������
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
					  <!--�������-->
					  <!--������Ͳ�������ʼ-->
  						<table border="0" width="100%" id="table8" align="center" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   						<!--     -->
    					<tr class="maintab_dh">
      						<td align="left" colspan="2">
      							<table border="0" cellspacing="0" cellpadding="0">    
									<tr class="maintab_dh">
									<td nowrap >
										
									<BUTTON class="btn_2" name="btnSave" value="�ύ"  type="submit" >
									<img src="../../images/save.gif" align="absmiddle" border="0">�ύ</button>
									
									<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
									<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>
									    </td></tr>
								</table>
        					</td>
   						 </tr>
						
						<tr><td class="tab_subline" width="100%" height="2"></td></tr>
				</table>
			</td>
		</tr>
	</table>	

<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="95%" class="tab_table_title" >

      <tr>
	    <th>���չ�˾</th>
	    <td colspan="">
	    	 <input style="width:150px;" name="cust_name" type="text" Require="ture" readonly="readonly" value="�찲���չɷ����޹�˾�����ֹ�˾">
			 <input name="cust_id" type="hidden" value="0870060127">

				<img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  
				style="cursor:pointer" onclick="popUpWindow('pay_obj.jsp',250,350)">
				<span class="biTian">*</span>
	    </td>
	    <th>����</th>
	    <td>
	    	
			 <select style="width:150px;" name="insur_type" id="insur_type" Require="true"></select>
	<script language="javascript" class="text">
	dict_list("insur_type","root.insurType","root.insurType.001","name");
	</script>
	<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>1����</th>
	    <td>
	    	<input type="text" name="month_1" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"/>%
			<span class="biTian">*</span>
	    </td>
		<th>2����</th>
	    <td>
	    	<input type="text" name="month_2"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	   
      <tr>
      	<th>3����</th>
	    <td>
	    	<input type="text" name="month_3" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
		<th>4����</th>
	    <td>
	    	<input type="text" name="month_4" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>5����</th>
	    <td>
	    	<input type="text" name="month_5" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
		<th>6����</th>
	    <td>
	    	<input type="text" name="month_6" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	</tr>
    <tr>  
		<th>7����</th>
	    <td>
	    	<input type="text" name="month_7" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
		<th>8����</th>
	    <td>
	    	<input type="text" name="month_8" value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	</tr>
	<tr>
	    <th>9����</th>
	    <td >
	    	<input type="text" name="month_9"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
		 <th>10����</th>
	    <td >
	    	<input type="text" name="month_10"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	 </tr>
	 <tr>
	    <th>11����</th>
	    <td >
	    	<input type="text" name="month_11"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
		 <th>12����</th>
	    <td >
	    	<input type="text" name="month_12"  value="0"
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>%
			<span class="biTian">*</span>
	    </td>
	 </tr>
	 <tr>
	 <th>���׼����</th>
	 <td><input type="text" name="base_year_rate"  value="0"
	    		 size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;"//>
			<span class="biTian">*</span>
	 </td>
	 <th>
	 
	 </th>
	 <td>
	 
	 </td>
	 </tr>
	
    </table>
</div>
</div>
</td></tr>
</table>
</form>
</body>
</html>
