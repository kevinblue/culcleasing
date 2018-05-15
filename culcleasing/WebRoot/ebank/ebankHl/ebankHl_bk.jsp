<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>网银核销处理 - 合同金额列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="fun_winMax();">
<form action="ebank_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				网银核销处理 &gt; 合同金额列表</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
					 
					 <%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("ebank-ebankHl-view",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("您没有操作权限！");
}

</script>
<%
//--------以上为权限控制-----------------------------
String sqlstr;
ResultSet rs;

String arrive_date = getStr( request.getParameter("arrive_date") );
String contract_id_show = getStr( request.getParameter("contract_id_show") );
String contract_arr[] = contract_id_show.split(",");
List list_rent = new ArrayList();
List list_custName = new ArrayList();
String contract_id="";
String badRent="";
for(int i=0;i<contract_arr.length;i++){
	contract_id=contract_arr[i];
	sqlstr="select cust_name,(select isnull(sum(rent),0) from fund_rent_plan where contract_id=vi_contract_info.contract_id and plan_date<='"+arrive_date+"')-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id=vi_contract_info.contract_id and hire_date<dateadd(day,1,'"+arrive_date+"')) as badRent from vi_contract_info where contract_id='"+contract_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		badRent=getDBStr(rs.getString("badRent") );
		list_custName.add(getDBStr(rs.getString("cust_name") ));
	}rs.close();
	if(Double.parseDouble(badRent)<=0){
		sqlstr="select (select isnull(sum(rent),0) from fund_rent_plan where contract_id='"+contract_id+"' and rent_list=(select isnull(min(rent_list),0) from fund_rent_plan where contract_id='"+contract_id+"' and plan_status<>'已回笼'))-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list=(select isnull(min(rent_list),0) from fund_rent_plan where contract_id='"+contract_id+"' and plan_status<>'已回笼')) as adjust_flag";
		rs=db.executeQuery(sqlstr);
		if(rs.next()){
			badRent=getDBStr(rs.getString("adjust_flag") );
		}rs.close();
	}
	list_rent.add(badRent);
}
db.close();
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


<table border="0" cellspacing="0" cellpadding="0">
  
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>合同编号</th>
		<th>承租人</th>
        <th>应核销金额</th>
      </tr>
  

<%	  

	for(int i=0;i<contract_arr.length;i++){
%>

      <tr>
        <td><%= contract_arr[i] %></td> 	
        <td><%= list_custName.get(i).toString() %></td> 
        <td><%= formatNumberStr(list_rent.get(i).toString(),"#,##0.00") %></td> 
      </tr>
<%	
	}

%>
    </table>
</div>

<!--报表结束-->
</form>
</body>
</html>
