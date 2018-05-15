<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-保险管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>
</head>

<% 
	String id = getStr( request.getParameter("id"));
	System.out.println(id+"**");

	String sqlstr = "select*,dengjiren=dbo.GETUSERNAME(contract_insurance.creator),xiugairen=dbo.GETUSERNAME(contract_insurance.modificator) from contract_insurance left join contract_info on contract_insurance.contract_id=contract_info.contract_id where id='"+id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	System.out.println("sqlstr="+sqlstr);
	String contract_id="";
    String colleaction_date="";
	String insurance_type="";
	String payments="";
	String pay_date="";
	String buy_insuranceself="";
	String period_insurance="";
	String insurance_id="";
	String insurance_my="";
	String proj_id="";
	String cust_id="";
	String cust_name="";
	String project_name="";
	String out_dept="";
	String creator="";
	String create_date="";
	String modificator="";
	String modify_date="";
	String insured_amount="";
	String start_date="";
	String end_date="";
	String insurance_company="";
	String insured="";
  String b_insured="";
  String insurance_coverage="";
	String price_coverage="";
	String price_appraisal="";
	String assessment_company="";
  String production_date="";
	String total_insurance="";
	String deductible_accident="";
	String premium_rate="";
	String general_insurance="";
	String jurisdiction="";
	String beneficiaries="";
	String memo="";
	String attachment="";
	String add_beneficiaries="";
	if(rs.next()){
	 creator=getDBStr(rs.getString("dengjiren"));
	 create_date=getDBStr(rs.getString("create_date"));
	 modificator=getDBStr(rs.getString("xiugairen"));
	 modify_date=getDBStr(rs.getString("modify_date"));
	
		start_date=getDBStr(rs.getString("start_date"));
		end_date=getDBStr(rs.getString("end_date"));	
	 out_dept=getDBStr(rs.getString("out_dept"));
	 project_name=getDBStr(rs.getString("project_name"));
	 cust_name=getDBStr(rs.getString("cust_name"));
	 cust_id=getDBStr(rs.getString("cust_id"));
	 proj_id=getDBStr(rs.getString("proj_id"));
	 contract_id=getDBStr(rs.getString("contract_id"));
	 insurance_my=getDBStr(rs.getString("insurance_my"));
	 insurance_id=getDBStr(rs.getString("insurance_id"));
	 buy_insuranceself=getDBStr(rs.getString("buy_insuranceself"));
	 period_insurance=getDBStr(rs.getString("period_insurance"));
	colleaction_date=getDBStr(rs.getString("colleaction_date"));
	 insurance_type=getDBStr(rs.getString("insurance_type"));
	 pay_date=getDBStr(rs.getString("pay_date"));
	 payments=getDBStr(rs.getString("payments"));
	 insured_amount=getDBStr(rs.getString("insured_amount"));
	 
	 insurance_company=getDBStr(rs.getString("insurance_company"));
	  insured=getDBStr(rs.getString("insured"));
	  b_insured=getDBStr(rs.getString("b_insured"));
	  insurance_coverage=getDBStr(rs.getString("insurance_coverage"));
	  price_coverage=getDBStr(rs.getString("price_coverage"));
	  price_appraisal=getDBStr(rs.getString("price_appraisal"));
	  assessment_company=getDBStr(rs.getString("assessment_company"));
	  production_date=getDBStr(rs.getString("production_date"));
	  
	  total_insurance=getDBStr(rs.getString("total_insurance"));
	  deductible_accident=getDBStr(rs.getString("deductible_accident"));
	  premium_rate=getDBStr(rs.getString("premium_rate"));
	  general_insurance=getDBStr(rs.getString("general_insurance"));
	  jurisdiction=getDBStr(rs.getString("jurisdiction"));
	  beneficiaries=getDBStr(rs.getString("beneficiaries"));
	  add_beneficiaries=getDBStr(rs.getString("add_beneficiaries"));	  
	  memo=getDBStr(rs.getString("memo"));
	  attachment=getDBStr(rs.getString("attachment"));
	}
	rs.close(); 
	db.close();
%>

<body onLoad="public_onload(12)">
<form name="form1" method="post" action="bx_save.jsp" onSubmit="return checkdata(this);">	

<div id=bgDiv>

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
资产管理&gt; 保险明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
		<td><a href="bx_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor">
		<img src="../../images/btn_edit.gif" align="absmiddle" >修改</a></td>
	  	<td>&nbsp;&nbsp;<a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor">
		<img src="../../images/quit.gif" align="absmiddle" >关闭</a></td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

	<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	 <tr>
	 <td>合同编号：</td>
	 <td><%=contract_id %></td>
	  <td  nowrap scope="row">是否是否我司代买保险：</td>
	    <td><%=insurance_my %></td>
	 </tr>
	 
	 <tr>
	      <td>保险类型：</td>
	    <td><%=insurance_type %></td>
	   <td>保险公司：</td>
	    <td><%=insurance_company%></td> 
	    </tr>
	  
	  <tr>
	  	 <td>保险单号：</td>
	    <td><%=insurance_id %></td>
	  	 <td>投保人：</td>
	    <td><%=insured %></td>
	  	</tr>
	  	
	   <tr>
	  	 <td>被保险人：</td>
	    <td><%=b_insured %></td>
	  	  <td>保险期限(月)：</td>
	    <td><%=period_insurance %></td>
	  	</tr>
	  <tr>
	  <td>开始日期：</td>
	  <td><%=start_date %></td>
	  <td>结束日期：</td>
	  <td><%=end_date %></td>
	  </tr>
	  <tr>
	  	 <td>保险项目：</td>
	    <td><%=insurance_coverage %></td>
	  	  <td>保险项目原价：</td>
	    <td><%=price_coverage %></td>
	  	</tr>
	  
	   <tr>
	  	 <td>保险项目评估价：</td>
	    <td><%=price_appraisal %></td>
	  	  <td>保险项目评估公司：</td>
	    <td><%=assessment_company %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>保险项目生产日期：</td>
	    <td><%=getDBDateStr(production_date) %></td>
	  	  <td>保险金额：</td>
	   <td><%=payments %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>总保险金额：</td>
	    <td><%=total_insurance %></td>
	  	  <td>每次事故免赔额 ：</td>
	   <td><%=deductible_accident %></td>
	  	</tr>
	  
	    <tr>
	  	 <td>保险费率：</td>
	    <td><%=premium_rate %></td>
	  	  <td>总保险费 ：</td>
	   <td><%=general_insurance %></td>
	  	</tr>
	   <tr>
	    
	   <td>付费日期：</td>
	    <td><%=getDBDateStr(pay_date) %></td>
	     <td>司法管辖 ：</td>
	   <td><%=jurisdiction %></td>
	    </tr>
	    
	 
	    
	<tr>
	<td>受益人：</td>
	    <td><%=beneficiaries %></td>
	    <td>附加被保险人：</td>
	    <td><%=add_beneficiaries %></td>
	</tr>
	<tr>
	<td>备注：</td>
	<td colspan="40" nowrap><textarea class="text" ><%=memo %></textarea></td>
	<td></td>
	<td></td>
   </tr>
	<tr>
    <td scope="row">附件：</td>
    <td  name="fj_name"><%= attachment %></td>
   <td></td><td></td>
  </tr>
	</table>
<br>
<div style="text-align:left;width:98%">


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

</form>
<!-- end cwMain -->
<script language="javascript">
ShowTabN(0);
</script>
</body>
</html>
