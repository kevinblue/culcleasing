<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户项目信息 - 客户纳税人信息</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>


<script type="text/javascript" src="../../js/numberseparation.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script> 

</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->
<%

String cust_id = getStr( request.getParameter("cust_id") );

countSql = "select count(id) as amount from base_taxPayer where 1=1 "+wherestr;

String id="";
String tax_payer_type="";
String tax_payer_no="";
String is_dk="";
String tax_type_invoice="";
String address="";
String tel="";
String bank_name="";
String bank_no="";

sqlstr="select * from base_taxPayer where cust_id='"+cust_id+"'";
rs = db.executeQuery(sqlstr);

if(rs.next()){
id=getDBStr(rs.getString("id"));
tax_payer_type=getDBStr(rs.getString("tax_payer_type"));
tax_payer_no=getDBStr(rs.getString("tax_payer_no"));
is_dk=getDBStr(rs.getString("is_dk"));
tax_type_invoice=getDBStr(rs.getString("tax_type_invoice"));
address=getDBStr(rs.getString("address"));
tel=getDBStr(rs.getString("tel"));
bank_name=getDBStr(rs.getString("bank_name"));
bank_no=getDBStr(rs.getString("bank_no"));
}

%>

<script type="text/javascript">
$(document).ready(function(){
	//纳税人类型
	$(":radio[name='tax_payer_type']").removeAttr("checked");
	$(":radio[name='tax_payer_type'][value='<%=tax_payer_type %>']").attr("checked","checked");
	//是否进项抵扣
	$(":radio[name='is_dk']").removeAttr("checked");
	$(":radio[name='is_dk'][value='<%=is_dk %>']").attr("checked","checked");
	});
</script>

<body onLoad="">
<form name="form1" method="post" action="nsrxx_save.jsp" onSubmit="return checkdata(this);">	
<input type="hidden" name="cust_id" value="<%=cust_id%>">
<input type="hidden" name="id" value="<%=id%>">
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 纳税人信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
<center>





	<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
	<tr>
	    <td >纳税人类型：</td>
	    <td>
		
		<input type="radio" name="tax_payer_type" value="一般纳税人" >一般纳税人
		<input type="radio" name="tax_payer_type" value="小规模纳税人">小规模纳税人
		
		</td>
	    <td scope="row">纳税人识别号：</td>
	    <td scope="row"><input type="text" name="tax_payer_no" value="<%=tax_payer_no%>" style="width:250"></td>
	    <td scope="row">是否可以进项抵扣：</td>
	     <td scope="row">
		 
		<input type="radio" name="is_dk" value="是" >是
		<input type="radio" name="is_dk" value="否" >否
		
		</td>
	</tr>
	<tr>
	    <td  scope="row" nowrap>增值税发票类型</td>
			<td>
			<select style="width:250" name="tax_type_invoice" id="tax_type_invoice" >
					  <script type="text/javascript">
							w(mSetOpt('<%=tax_type_invoice%>',"增值税普通发票|增值税专用发票|无","增值税普通发票|增值税专用发票|无"));
					  </script>
				</select>
					
			</td>
		<td scope="row" nowrap width="5%">地址：</td>
	    <td scope="row" nowrap width="15%"><input type="text" name="address" value="<%=address%>" style="width:250"></td>
	    <td scope="row" nowrap width="8%">电话：</td>
	    <td scope="row" nowrap width="15%"><input type="text" name="tel" value="<%=tel%>" style="width:250" ></td>
	  </tr>
	  
	   <tr>
	   	<td scope="row" nowrap width="5%">基本户开户行：</td>
	    <td scope="row" nowrap width="15%"><input type="text" name="bank_name" value="<%=bank_name%>" style="width:250" ></td>
	   <td scope="row" nowrap width="5%">账号：</td>
	    <td scope="row" nowrap width="15%"><input type="text" name="bank_no" value="<%=bank_no%>" style="width:250" ></td>
		<td scope="row"></td>
	  </tr>
	  <tr>
		<td align="right" colspan="6"><input name="btnSave" value="保存" type="submit" class="btn3_mouseout">
		</td>
	  </tr>
	</table>
<br>
</center>
</td>
</tr>
</table>  

</form>

</body>
</html>
<%if(null != db){db.close();}%>