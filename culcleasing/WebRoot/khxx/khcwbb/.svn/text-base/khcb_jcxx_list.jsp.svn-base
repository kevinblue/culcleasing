<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>财务报表 -基础信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>
<style type="text/css">

.gridtable{

	border:2px solid #999999; 
	border-collapse:collapse; 
	cellpadding:0px;
	cellspacing:0px;
	
}
.gridtable tr {
	font-family: verdana,arial,sans-serif;
	font-size:20px;
	color:#333333;
	width:10px;
	height:10px;
	border-width: 1px;
	border-color: #666666;
	background-color: #fff;
}
.gridtable td {
	border-width: 1px;
	height:30px;
	padding: 8px;
	border-style: solid;
	border-color: #666666;
	border-collapse:collapse; 
	background-color: #fff;
	border-bottom:1px solid #999999; 
	 empty-cells : show;
	
}


</style>
<script type="text/javascript">

function public_onload(){	

}

</script>
<% 
	String custId = getStr( request.getParameter("custId"));
	String sqlstr = "select fb.* from dbo.financial_base_info fb where fb.cust_id='"+custId+"'"+
	"and fb.create_date  in(select MAX(fbs.create_date) from dbo.financial_base_info fbs where fbs.cust_id='"+custId+"'"+
	"group by fbs.cust_id)"; 
	
	ResultSet rs = db.executeQuery(sqlstr);
		String cust_id="";
		String cust_name="";
		String guarantor_one="";
		String guarantor_two="";
		String province="";
		String city="";
		String county="";
		String total_population="";
		String financial_gdp="";
		String outstand_principal="";
		String towner_disposable_inconme="";				
		String farmer_inconme="";
		String credit_blemish="";
		String business_department="";
		String risk_evaluation_manager="";
		String government="";
		String people_congress="";
		String finance_bureau="";
		String health_bureau="";
		String city_investment_guarantee="";
		String city_bond="";
	if(rs.next()){
		cust_id=getDBStr(rs.getString("cust_id"));
		cust_name=getDBStr(rs.getString("cust_name"));
		guarantor_one=getDBStr(rs.getString("guarantor_one"));
		guarantor_two=getDBStr(rs.getString("guarantor_two"));
		province=getDBStr(rs.getString("province"));
		city=getDBStr(rs.getString("city"));
		county=getDBStr(rs.getString("county"));
		total_population=getDBStr(rs.getString("total_population"));
		financial_gdp=getDBStr(rs.getString("financial_gdp"));
		outstand_principal=getDBStr(rs.getString("outstand_principal"));
		towner_disposable_inconme=getDBStr(rs.getString("towner_disposable_inconme"));				
		farmer_inconme=getDBStr(rs.getString("farmer_inconme"));
		credit_blemish=getDBStr(rs.getString("credit_blemish"));
		business_department=getDBStr(rs.getString("business_department"));
		risk_evaluation_manager=getDBStr(rs.getString("risk_evaluation_manager"));
		government=getDBStr(rs.getString("government"));
		people_congress=getDBStr(rs.getString("people_congress"));
		finance_bureau=getDBStr(rs.getString("finance_bureau"));
		health_bureau=getDBStr(rs.getString("health_bureau"));
		city_investment_guarantee=getDBStr(rs.getString("city_investment_guarantee"));
		city_bond=getDBStr(rs.getString("city_bond"));
	}
	rs.close();
	db.close();
%>

<body  onload="public_onload(0)">

<div style="vertical-align:top;width:100%;height:500px;overflow-y:scroll;position: relative; left: 0px; top: 0px"  id="mydiv_one";>
<table class="gridtable" width='100%'  border='1' cellpadding='0' cellspacing='0' id='list_table'>
<tr>
<td align='center' >承租人全称</td>
<td align='center' colspan='5'><%=cust_name %></td>

</tr>
<tr>
<td align='center' >担保人1全称</td>
<td  align='center' colspan='5'><%=guarantor_one %></td>
</tr>
<tr>
<td align='center' >担保人2全称</td>
<td  align='center' colspan='5'><%=guarantor_two %></td>
</tr>
<tr>
<td align='center'>所属省份</td>
<td align='center'><%=province %></td>
<td align='center' >所属地级市</td>
<td align='center'><%=city %></td>
<td align='center'>所属区县</td>
<td align='center'><%=county %></td>
</tr>
<tr>
<td align='center' >当地总人口（万人）</td>
<td align='center' ><%=total_population %></td>
<td align='center' >GDP（亿元）</td>
<td align='center' ><%=financial_gdp %></td>
<td align='center' >地区累计未还本金（万元）</td>
<td align='center' ><%=outstand_principal %></td>
</tr>
<tr>
<td align='center'>城镇居民可支配收入（元）</td>
<td align='center'><%=towner_disposable_inconme %></td>
<td align='center'>农民纯收入（元）</td>
<td align='center'><%=farmer_inconme %></td>
<td align='center'>是否存在信用瑕疵</td>
<td align='center'><%=credit_blemish %></td>
</tr>
<tr>
<td align='center'>业务部门</td>
<td  align='center' colspan='3'><%=business_department %></td>
<td align='center'>风控评审经理</td>
<td align='center'><%=risk_evaluation_manager %></td>
</tr>
<tr>
<td align='center' colspan='6'>出文及担保情况（有/无）</td>
</tr>
<tr>
<td align='center'>政府</td>
<td align='center'>人大</td>
<td align='center'>财政局</td>
<td align='center'>卫生局</td>
<td align='center'>城投担保</td>
<td align='center'>城投有无发债</td>
</tr>

<tr >
<td align='center'><%=government %></td>
<td align='center'><%=people_congress %></td>
<td align='center'><%=finance_bureau %></td>
<td align='center'><%=health_bureau %></td>
<td align='center'><%=city_investment_guarantee %></td>
<td align='center'><%=city_bond %></td>
</tr>
</table>
</div>

</body>
</html>
