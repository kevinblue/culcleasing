<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>  
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>现金流量 - 计划现金流量</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String sqlstr;
	ResultSet rs ;
	
	String contract_id = getStr( request.getParameter("contract_id") );
	String min_date="";
	String max_date="";
	List plan_date = new ArrayList();
	List xjlr = new ArrayList();
	List xjlc = new ArrayList();
	List xjlr_lc = new ArrayList();
	String first_fund_in="0";
	String first_fund_out="0";
	String end_fund_in="0";
	String end_fund_out="0";
	
	String irr="";
	
	
	sqlstr="select substring(convert(varchar(10),min(plan_date),121),1,7) as min_date,substring(convert(varchar(10),max(plan_date),121),1,7) as max_date from fund_rent_plan where contract_id='"+contract_id+"'";
	//System.out.println("sqlstr1111========================================="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if ( rs.next() ) {
		min_date = getDBStr( rs.getString("min_date") );
		max_date = getDBStr( rs.getString("max_date") );
	}rs.close();
	if(!min_date.equals("") && !max_date.equals("")){
		sqlstr="select b.plan_date,sum(b.rent) as rent from ( select top 100 percent a.contract_id, case when plan_date is null then months else substring(convert(varchar(10),a.plan_date,121),1,7) end as plan_date, isnull(a.rent,0) as rent from xjll_months left join ( select * from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' )a on xjll_months.months=substring(convert(varchar(10),a.plan_date,121),1,7) where xjll_months.months>='"+min_date+"' and xjll_months.months<='"+max_date+"' order by xjll_months.months )b group by b.plan_date";
		rs=db.executeQuery(sqlstr);
		while(rs.next()){
			plan_date.add(getDBDateStr(rs.getString("plan_date")));
			xjlr.add(getDBStr(rs.getString("rent")));
			xjlc.add("0");
		}rs.close();
		
		sqlstr="select isnull(caution_money,0) as first_fund_in,isnull(equip_amt,0) as first_fund_out,isnull(nominalprice,0) as end_fund_in,0 as end_fund_out from contract_condition where contract_id='"+contract_id+"'";
		rs=db.executeQuery(sqlstr);
		while(rs.next()){
			first_fund_in=getDBStr(rs.getString("first_fund_in"));
			first_fund_out=getDBStr(rs.getString("first_fund_out"));
			end_fund_in=getDBStr(rs.getString("end_fund_in"));
			end_fund_out=getDBStr(rs.getString("end_fund_out"));
		}rs.close();
		
		if(xjlr.size()>0){
			xjlr.set(0,String.valueOf(Double.parseDouble(xjlr.get(0).toString())+Double.parseDouble(first_fund_in)));
			xjlc.set(0,first_fund_out);
			xjlr.set(xjlr.size()-1,String.valueOf(Double.parseDouble(xjlr.get(xjlr.size()-1).toString())+Double.parseDouble(end_fund_in)));
			xjlc.set(xjlc.size()-1,end_fund_out);
		}
		
		for(int i=0;i<xjlr.size();i++){
			xjlr_lc.add(String.valueOf(Double.parseDouble(xjlr.get(i).toString())-Double.parseDouble(xjlc.get(i).toString())));
		}
		//xjlr_lc.set(2,"4000000");
		//System.out.println(xjlr_lc);
		
		
		irr=getIRR(xjlr_lc,"1","1","12");
	}
	
	 
	db.close();
%>
<body>

<form name="form1" method="post" action="htgf_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
计划现金流量明细
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">明 细</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap width="20%">irr：</td>
    <td><%=irr %></td>
  </tr>
 
</table>
<br>

<div id="TD_tab_1" style="display:none;"> 
  选择卡中的内容2
</div>
<div id="TD_tab_2" style="display:none;"> 
  选择卡中的内容3

选择卡中可能包含以下内容：

注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

</div>

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

</script>
</form>
<!-- end cwMain -->
</body>
</html>
