<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 修改合同各方</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="htgf_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
合同信息 &gt; 修改合同各方
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">修改信息</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("htxx-htgf-mod",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------

	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select contract_signatory.client_email, contract_signatory.contract_id, contract_signatory.lessor, vi_cust_all_info.cust_name as lessor_name, contract_signatory.leaseconsigner, contract_signatory.lease_acc_number, cust_account.bank_name as lease_bank_name, cust_account.account as lease_account, contract_signatory.client, vi_cust_all_info2.cust_name as client_name, contract_signatory.clientconsigner, contract_signatory.client_acc_number, cust_account2.bank_name as client_bank_name, cust_account2.account as client_account, contract_signatory.client_postcode, contract_signatory.client_address, contract_signatory.client_linkman, contract_signatory.client_mobile_number, contract_signatory.client_tel, contract_signatory.client_fax from contract_signatory left join vi_cust_all_info on contract_signatory.lessor=vi_cust_all_info.cust_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.client=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lease_acc_number=cust_account.acc_number left join cust_account cust_account2 on contract_signatory.client_acc_number=cust_account2.acc_number where contract_signatory.contract_id='"+czid+"'" ; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	
	String	lessor = "";
	String	lessor_name = "";
	String	leaseconsigner = "";
	String	lease_acc_number = "";
	String	lease_bank_name = "";
	String	lease_account = "";
	String	client = "";
	String	client_name = "";
	String	clientconsigner = "";
	String	client_acc_number = "";
	String	client_bank_name = "";
	String	client_account = "";
	String	client_linkman = "";
	String	client_postcode = "";
	String	client_address = "";
	String	client_mobile_number = "";
	String	client_tel = "";
	String	client_fax = "";
	String	client_email = "";


	if ( rs.next() ) {
		lessor = getDBStr( rs.getString("lessor") );
		lessor_name = getDBStr( rs.getString("lessor_name") );
		leaseconsigner = getDBStr( rs.getString("leaseconsigner") );
		lease_acc_number = getDBStr( rs.getString("lease_acc_number") );
		lease_bank_name = getDBStr( rs.getString("lease_bank_name") );
		lease_account = getDBStr( rs.getString("lease_account") );
		client = getDBStr( rs.getString("client") );
		client_name = getDBStr( rs.getString("client_name") );
		clientconsigner = getDBStr( rs.getString("clientconsigner") );
		client_acc_number = getDBStr( rs.getString("client_acc_number") );
		client_bank_name = getDBStr( rs.getString("client_bank_name") );
		client_account = getDBStr( rs.getString("client_account") );
		client_linkman = getDBStr( rs.getString("client_linkman") );
		client_postcode = getDBStr( rs.getString("client_postcode") );
		client_address = getDBStr( rs.getString("client_address") );
		client_mobile_number = getDBStr( rs.getString("client_mobile_number") );
		client_tel = getDBStr( rs.getString("client_tel") );
		client_fax = getDBStr( rs.getString("client_fax") );
		client_email = getDBStr( rs.getString("client_email") );
	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>合同编号</td>
    <td><%= czid%></td>
    <td>甲方</td>
    <td><%= lessor_name%><input type="hidden" name="lessor" value="<%= lessor%>"></td>
  </tr>
  <tr>
    <td>委托代理人（甲方）</td>
    <td><input name="leaseconsigner" type="text" size="40" value="<%= leaseconsigner%>"></td>
    <td>开户帐号（甲方）</td>
    <td><input name="lease_acc_number" type="text" size="40" readonly value="<%= lease_acc_number%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('form1.lessor','甲方','cust_id','string','客户名称','cust_account','acc_number','bank_name|account','acc_number','acc_number','asc','form1.lease_acc_number','form1.lease_bank_name|form1.lease_account');"></td>
  </tr>
  <tr>
    <td>开户银行（甲方）</td>
    <td><input name="lease_bank_name" type="text" size="40" value="<%= lease_bank_name%>" readonly></td>
    <td>开户户名（甲方）</td>
    <td><input name="lease_account" type="text" size="40" value="<%= lease_account%>" readonly></td>
  </tr>
  <tr>
    <td>乙方</td>
    <td><%= client_name%><input type="hidden" name="client" value="<%= client%>"></td>
    <td>委托代理人（乙方）</td>
    <td><input name="clientconsigner" type="text" size="40" value="<%= clientconsigner%>"></td>
  </tr>
  <tr>
  	<td>开户帐号（乙方）</td>
    <td><input name="client_acc_number" type="text" size="40" readonly value="<%= client_acc_number%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('form1.client','乙方','cust_id','string','客户名称','cust_account','acc_number','bank_name|account','acc_number','acc_number','asc','form1.client_acc_number','form1.client_bank_name|form1.client_account');"></td>
    <td>开户银行（乙方）</td>
    <td><input name="client_bank_name" type="text" size="40" value="<%= client_bank_name%>" readonly></td>
  </tr>
  <tr>
  	<td>开户户名（乙方）</td>
    <td><input name="client_account" type="text" size="40" value="<%= client_account%>" readonly></td>
    <td>付款联系人</td>
    <td><input name="client_linkman" type="text" size="40" value="<%= client_linkman%>" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>邮政编码（乙方）</td>
    <td><input name="client_postcode" type="text" size="40" value="<%= client_postcode%>" Require="true"><span class="biTian">*</span></td>
    <td>地址（乙方）</td>
    <td><input name="client_address" type="text" size="40" value="<%= client_address%>" Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>短信联系手机号</td>
    <td><input name="client_mobile_number" type="text" size="40" value="<%= client_mobile_number%>" Require="true"><span class="biTian">*</span></td>
    <td>电话（乙方）</td>
    <td><input name="client_tel" type="text" size="40" value="<%= client_tel%>"></td>
  </tr>
  <tr>
  	<td>传真（乙方）</td>
    <td><input name="client_fax" type="text" size="40" value="<%= client_fax%>"></td>
    <td>乙方联系人Email</td>
    <td><input name="client_email" type="text" size="40" value="<%= client_email%>"></td>
  </tr>
  

</table>
	




</div>

</div>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

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

<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
ShowTabN(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
function checkdata(obj){
	var lease_acc_number;
	var client_acc_number;
	lease_acc_number=document.getElementById("lease_acc_number").value;
	client_acc_number=document.getElementById("client_acc_number").value;
	if(lease_acc_number=="" && client_acc_number==""){
		alert("甲方帐号和乙方帐号不能同时为空！");
		return false;
	}
	return Validator.Validate(obj,3);
}
//内部Iframe高度自适应
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
