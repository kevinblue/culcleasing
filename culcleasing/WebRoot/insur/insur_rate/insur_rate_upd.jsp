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
<title>修改费率</title>
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
</head>
<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<body>
<%
String model = getStr(request.getParameter("model"));
String key_id = getStr(request.getParameter("key_id"));
sqlstr="select bir.*,ci.cust_name,icd.title from base_insur_rate bir left join cust_info ci on ci.cust_id=bir.cust_id left join ifelc_conf_dictionary icd on icd.name=bir.insur_type where bir.id="+key_id;
rs=db.executeQuery(sqlstr);
String cust_name="";
String insur_type="";
String month_1="";
String month_2="";
String month_3="";
String month_4="";
String month_5="";
String month_6="";
String month_7="";
String month_8="";
String month_9="";
String month_10="";
String month_11="";
String month_12="";
String base_year_rate="";

if(rs.next()){
	System.out.println("======"+rs.getString("month_1"));
cust_name=rs.getString("cust_name");
insur_type=rs.getString("insur_type");
month_1=rs.getString("month_1");
month_2=rs.getString("month_2");
month_3=rs.getString("month_3");
month_4=rs.getString("month_4");
month_5=rs.getString("month_5");
month_6=rs.getString("month_6");
month_7=rs.getString("month_7");
month_8=rs.getString("month_8");
month_9=rs.getString("month_9");
month_10=rs.getString("month_10");
month_11=rs.getString("month_11");
month_12=rs.getString("month_12");
base_year_rate=rs.getString("base_year_rate");
}
%>
<form action="insur_rate_save.jsp" method="post" target="" onSubmit="return Validator.Validate(this,3);" name="form1">
<input type="hidden" name="model" value="mod">
<input type="hidden" name="key_id" value="<%=rs.getInt("id")%>">
  <!--标题开始-->
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top" class="tree_title_txt">
		<td class="tree_title_txt"  height=26 valign="middle">
			修改费率
		</td>
	</tr>
	<tr valign="top">
		<td  align=center width=100% height=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
					  <!--标题结束-->
					  <!--副标题和操作区开始-->
  						<table border="0" width="100%" id="table8" align="center" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   						<!--     -->
    					<tr class="maintab_dh">
      						<td align="left" colspan="2">
      							<table border="0" cellspacing="0" cellpadding="0">    
									<tr class="maintab_dh">
									<td nowrap >
										
									<BUTTON class="btn_2" name="btnSave" value="提交"  type="submit" >
									<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>
									
									<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
									<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
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
	    <th>保险公司</th>
	    <td colspan="">
	    	 <input style="width:150px;" name="cust_name" type="text" Require="ture" readonly="readonly" value="<%=cust_name%>">
			 <input name="cust_id" type="hidden" value="0870060127">

				<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
				style="cursor:pointer" onclick="popUpWindow('pay_obj.jsp',250,350)">
				<span class="biTian">*</span>
	    </td>
	    <th>险种</th>
	    <td>
	    	
			<select style="width:150px;" name="insur_type" id="insur_type" Require="true"></select>
			<script language="javascript" class="text">
			dict_list("insur_type","root.insurType","<%=insur_type%>","name");
			</script>
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>1个月</th>
	    <td>
	    	<input type="text" name="month_1" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_1%>"/>%
			<span class="biTian">*</span>
	    </td>
		<th>2个月</th>
	    <td>
	    	<input type="text" name="month_2" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_2%>"/>%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	   
      <tr>
      	<th>3个月</th>
	    <td>
	    	<input type="text" name="month_3" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_3%>"/>%
			<span class="biTian">*</span>
	    </td>
		<th>4个月</th>
	    <td>
	    	<input type="text" name="month_4" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_4%>"/>%
			<span class="biTian">*</span>
	    </td>
	  </tr>
	  <tr>
	    <th>5个月</th>
	    <td>
	    	<input type="text" name="month_5" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_5%>"/>%
			<span class="biTian">*</span>
	    </td>
		<th>6个月</th>
	    <td>
	    	<input type="text" name="month_6" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_6%>"/>%
			<span class="biTian">*</span>
	    </td>
	</tr>
    <tr>  
		<th>7个月</th>
	    <td>
	    	<input type="text" name="month_7" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_7%>"/>%
			<span class="biTian">*</span>
	    </td>
		<th>8个月</th>
	    <td>
	    	<input type="text" name="month_8" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_8%>"/>%
			<span class="biTian">*</span>
	    </td>
	</tr>
	<tr>
	    <th>9个月</th>
	    <td >
	    	<input type="text" name="month_9"  
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_9%>"/>%
			<span class="biTian">*</span>
	    </td>
		 <th>10个月</th>
	    <td >
	    	<input type="text" name="month_10"  
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_10%>"/>%
			<span class="biTian">*</span>
	    </td>
	 </tr>
	 <tr>
	    <th>11个月</th>
	    <td >
	    	<input type="text" name="month_11"  
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_11%>"/>%
			<span class="biTian">*</span>
	    </td>
		 <th>12个月</th>
	    <td >
	    	<input type="text" name="month_12" 
	    		dataType="Money" size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=month_12%>"/>%
			<span class="biTian">*</span>
	    </td>
	 </tr>
	 <tr>
	
		 <th>年基准费率</th>
	    <td >
	    	<input type="text" name="base_year_rate" 
	    		 size="20" maxlength="10" maxB="10"  Require="true" style="width:150px;" value="<%=base_year_rate%>"/>
			<span class="biTian">*</span>
	    </td>
	        <td >
	    </td>
	        <td >
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
<%if(null != db){db.close();}%>