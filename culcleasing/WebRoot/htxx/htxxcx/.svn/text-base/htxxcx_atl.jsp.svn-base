<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同租金实收</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);" style="border:1px solid #8DB2E3;">
<form action="htzjss_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同信息 &gt; 合同租金实收</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%


ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchFld_tmp = "";

String contract_id = getStr( request.getParameter("contract_id") );
if(contract_id.equals("")){
	wherestr=" where 1=0";
}else{
	wherestr+=" and fund_rent_income.contract_id='"+contract_id+"'";
}

String sqlstr = "select fund_rent_income.contract_id,fund_rent_income.plan_list,fund_rent_income.hire_date,fund_rent_income.rent,fund_rent_income.corpus,fund_rent_income.interest,fund_rent_income.penalty,fund_rent_income.penalty_adjust from fund_rent_income " + wherestr; 
sqlstr+=" order by fund_rent_income.plan_list";
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

<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>合同编号</th>
		<th>期项</th>
		<th>实收日期</th>
        <th>已收租金</th>
        <th>已收本金</th>
        <th>已收利息</th>
        <th>已收罚息</th>
        <th>罚息调整</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	double allrent = 0;
	double allcorpus = 0;
	double allinterest = 0;
	double allpenalty = 0;
	double allacutalpenalty = 0;
	while( i < intPageSize && !rs.isAfterLast() ) {
	
	String return_rent = getDBStr( rs.getString("rent") );
	if(!return_rent.equals("")){
		allrent +=Double.parseDouble(return_rent);
	}
	String return_corpus = getDBStr( rs.getString("corpus") );
	if(!return_corpus.equals("")){
		allcorpus+=Double.parseDouble(return_corpus);
	}
	
	String return_interest = getDBStr(rs.getString("interest"));
	if(!return_interest.equals("")){
		allinterest+=Double.parseDouble(return_interest);
	}
	String penalty = getDBStr(rs.getString("penalty"));
	if(!penalty.equals("")){
		allpenalty+=Double.parseDouble(penalty);
	}
	String acutal_penalty = getDBStr(rs.getString("penalty_adjust"));
	if(!acutal_penalty.equals("")){
		allacutalpenalty+=Double.parseDouble(acutal_penalty);
	}
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") )  %></td> 
		<td><%= getDBStr( rs.getString("plan_list") ) %></td> 
		<td><%= getDBDateStr( rs.getString("hire_date") ) %></td> 	 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00") %></td> 	 	
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("penalty") ),"#,##0.00") %></td>
		<td align="right"><%= formatNumberStr(getDBStr( rs.getString("penalty_adjust") ),"#,##0.00") %></td>
      </tr>
<%
		rs.next();
		i++;
	}
	%>
	<tr>
		<td></td> 
		<td></td> 
		<td></td> 
		<td  align="right"><%= formatNumberDoubleTwo(allrent) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allcorpus) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allinterest) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allpenalty) %></td> 
		<td align="right"><%= formatNumberDoubleTwo(allacutalpenalty) %></td> 
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
