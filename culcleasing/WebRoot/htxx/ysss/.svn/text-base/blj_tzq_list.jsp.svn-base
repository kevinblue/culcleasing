<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同日程表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="fun_winMax();">
<form action="htzjys_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同信息 &gt; 合同日程表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%

String sqlstr;
ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchFld_tmp = "";

String contract_id = getStr( request.getParameter("contract_id") );
if(contract_id.equals("")){
	wherestr=" where 1=0";
}else{
	wherestr+=" and fund_contract_plan.contract_id='"+contract_id+"'";
}
//------------------求irr
List xjlr_lc = new ArrayList();
	
String irr="";


sqlstr = "select isnull(sum(fund_contract_plan.net_flow),0) as net_flow from fund_contract_plan" + wherestr +" group by substring(convert(varchar(10),fund_contract_plan.plan_date,121),1,7) order by substring(convert(varchar(10),fund_contract_plan.plan_date,121),1,7)"; 
rs=db.executeQuery(sqlstr);
while(rs.next()){
	xjlr_lc.add(getDBStr(rs.getString("net_flow")));
}rs.close();

irr=getIRR(xjlr_lc,"1","1","12"); 
//------------irr结束
sqlstr = "select fund_contract_plan.contract_id,fund_contract_plan.plan_list,fund_contract_plan.plan_date, isnull(fund_contract_plan.rent,0) as rent , isnull(fund_contract_plan.caution_deduction,0) as caution_deduction , isnull(fund_contract_plan.fund_in,0) as fund_in,isnull(fund_contract_plan.fund_out,0) as fund_out, isnull(fund_contract_plan.net_flow,0) as net_flow from fund_contract_plan" + wherestr; 
sqlstr+=" order by fund_contract_plan.plan_list";
//System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	
	</tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 1000;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>




</td>
</tr>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>合同编号</th>
		<th>期项</th>
		<th>日期</th>
        <th>租金</th>
        <th>其他流入</th>
        <th>其他支出</th>
        <th>保证金抵扣</th>
        <th>净流量</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("plan_list") ) %></td> 
		<td><%= getDBDateStr( rs.getString("plan_date") ) %></td> 	 
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td>	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("fund_in") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("fund_out") ),"#,##0.00") %></td> 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("caution_deduction") ),"#,##0.00") %></td> 	 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("net_flow") ),"#,##0.00") %></td>
      </tr>
<%
		rs.next();
		i++;
	}
	%>
	<tr>
		<td>irr</td> 
		<td align="right" colspan="8"><%= formatNumberStr(getDBStr( String.valueOf(Double.parseDouble(irr)*100) ),"#,##0.00") %></td>
      </tr>
	<%
}
rs.close(); 
db.close();
%>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
