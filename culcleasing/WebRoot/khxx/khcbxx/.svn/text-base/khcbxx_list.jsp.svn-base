<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户财务报表信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<body onLoad="public_onload(0);">
<form action="khcbxx_list.jsp" name="dataNav">
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	客户信息 &gt; 财务报表信息</td>
    </tr>
  </table>
  <!--标题结束-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String financial_year = getStr( request.getParameter("financial_year") );
String index_meaning=getStr(request.getParameter("index_meaning"));
String financial_subject = getStr( request.getParameter("financial_subject") );
String financial_subdata = getStr( request.getParameter("financial_subdata") );
String financial_average = getStr( request.getParameter("financial_average") );


if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}
if(financial_year!=null && !"".equals(financial_year)){
	wherestr+= " and financial_year like '%" + financial_year + "%'";
}
if(index_meaning!=null && !"".equals(index_meaning)){
	wherestr+= " and index_meaning like '%" + index_meaning + "%'";
}
if(financial_subject!=null && !"".equals(financial_subject)){
	wherestr+= " and financial_subject like '%" + financial_subject + "%'";
}



//权限判断
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from vi_finance_info where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		客户编号&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		客户名称&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>	
	<td>
		年    份&nbsp;<input name="financial_year" type="text" size="15" value="<%=financial_year %>">
    </td>
	</tr>
	
	<tr>
	<td>               
		指标标题&nbsp;<input name="index_meaning" type="text" size="15" value="<%=index_meaning %>">
	</td>
	<td>
		数据科目&nbsp;<input name="financial_subject" type="text" size="15" value="<%=financial_subject %>">
	</td>		
		<td>
		<input type="button" value="查询" onclick="dataNav.submit();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="清空" onclick="clearQuery();" >
		</td>
	</tr>
	</table>
	</fieldset>
	</div>
<!--可折叠查询结束-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
     <%if(right.CheckRight("khxx_frkh_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','frkh_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle">新&nbsp;增</a>&nbsp;</td><%}%> 
    
      <td align="left" width="90%" rowspan="2"><!--操作按钮开始-->
  
        <!--操作按钮结束--></td>
        <td align="right" width="20%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>客户编号</th>
	    <th>客户名称</th>
		 <th>年份</th>
		 <th>标题含义</th>
	    <th>科目</th>
	    <th>数据</th>
	    <th>平均值</th>
		 
		<th>担保人1</th>
	    <th>担保人2</th>
	    <th>省份</th>
	    <th>城市</th>
		<th>区县</th>
		<th>总人口(万人)</th>
	    <th>GDP（亿元）</th>
		<th>地区累计未还本金（万元）</th>
		<th>城镇居民可支配收入（元）</th>
	    <th>农民纯收入（元）</th>
		<th>是否存在信用瑕疵</th>
		 <th>业务部门</th>
		<th>风控评审经理</th>
	

      </tr>
      <tbody id="data">
<%


sqlstr = "select top "+ intPageSize +"* from vi_finance_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_finance_info where 1=1 "+wherestr+" order by cust_name,financial_year desc ) "+wherestr ;
sqlstr += " order by cust_name,financial_year desc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center">
        <input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>" 
        custName="<%=getDBStr( rs.getString("cust_name") ) %>"></td>
        
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("financial_year") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("index_meaning") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_subject") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_subdata") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_average") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("guarantor_one") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("guarantor_two") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("province") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("city") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("county") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("total_population") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_gdp") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("outstand_principal") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("towner_disposable_inconme") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("farmer_inconme") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("credit_blemish") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("business_department") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("risk_evaluation_manager") ) %></td>				

		
		
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
