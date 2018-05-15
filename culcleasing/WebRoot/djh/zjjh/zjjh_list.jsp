<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body>
<form action="zjjh_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 资金收支管理 &gt; 资金收支清单</td>
  </tr>
</table>
<%
String searchFld = getStr( request.getParameter("searchFld") );
String searchFld_tmp = "";
if( searchFld.equals("无单据号") ) {
	searchFld_tmp = "where invoice_no=null";
}else if( searchFld.equals("有单据号") ) {
	searchFld_tmp = "where invoice_no<>''";
}else if( searchFld.equals("全部显示") ) {
	searchFld_tmp = "";
}else{
	searchFld_tmp = "where invoice_no=null";
}
ResultSet rs;
String sqlstr = "select inm.id,dbo.getcustnamebycontractid(inm.contract_id) as cust_name,inm.contract_id,dbo.getmodelbyid(info.device_type) as device_type,inm.ebank_number,inm.plan_list,inm.hire_list,inm.hire_type,inm.balance_mode,inm.hire_date,inm.invoice_no,inm.rent,inm.corpus,inm.interest,inm.penalty,inm.rent_adjust,inm.corpus_adjust,inm.interest_adjust,inm.penalty_adjust,inm.hire_source,inm.hire_object,inm.hire_bank,inm.hire_account,inm.hire_number,inm.accounting_date,inm.instead_flag,inm.memo from fund_rent_income as inm left join contract_equip as info  on (info.contract_id=inm.contract_id) "+searchFld_tmp+" order by id desc";
System.out.println(sqlstr);
%>
<form name="searchbar" action="zjjh_list.jsp">
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="30%"><table border="0" cellspacing="0" cellpadding="0" >
          <tr class="maintab">
          <td>显示规则:<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","无单据号|有单据号|全部显示"));</script></select><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
            <td><a href="#" accesskey="u" onClick="dataHander('add_modal','zjjh_upload.jsp',dataNav.itemselect);"><img src="../../images/sbtn_2Excel.gif" alt="导入(Alt+U)" width="19" height="19" align="absmiddle"></a></td>
            <td><a href="zjjh_out.jsp"><img src="../../images/sbtn_down.gif" alt="导出(Alt+U)" width="19" height="19" align="absmiddle"></a></td>
          </tr>
        </table></td>
      <td align="right" width="50%"><%
int intPageSize = 15;   //一页显示的记录数
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
rs=db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr class="maintab">
            <script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
            <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
              <% } %>
              第 <font color="red"><%=intPage%></font> 页
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>转到
              <input name="page" type="text" size="2" value="1">
              页 <img  style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>
        </table>
        <!-- end cwCellTop --></td>
    </tr>
  </table>
<div style="vertical-align:top;height:500px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
    <tr class="maintab_content_table_title">
<th width="1%">id</th>
<th>用户名</th>
<th>合同编号</th>
<th>设备型号</th>
<th>网银编号</th>
<th>计划期项</th>
<th>回笼期项</th>
<th>回笼类型</th>
<th>结算方式</th>
<th>回笼日期</th>
<th>回笼租金</th>
<th>回笼本金</th>
<th>回笼租息</th>
<th>回笼罚息</th>
<th>租金调整</th>
<th>本金调整</th>
<th>租息调整</th>
<th>罚息调整</th>
<th>付款来源</th>
<th>付款人</th>
<th>回笼到位银行</th>
<th>回笼银行帐户</th>
<th>回笼银行帐号</th>
<th>会计处理日</th>
<th>是否代付</th>
<th>备注</th>
<th>单据号</th>
    </tr>
    <%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
%>
    <tr class="cwDLRow" >
      <td><%=getDBStr( rs.getString("id") ) %></td>
      <td><%= getDBStr( rs.getString("cust_name") ) %></td>
      <td><%=getDBStr( rs.getString("contract_id") ) %></td>
      <td><%=getDBStr( rs.getString("device_type") ) %></td>
      <td><%=getDBStr( rs.getString("ebank_number") ) %></td>
      <td><%=getDBStr( rs.getString("plan_list") ) %></td>
      <td><%=getDBStr( rs.getString("hire_list") ) %></td>
      <td><%=getDBStr( rs.getString("hire_type") ) %></td>
      <td><%=getDBDateStr( rs.getString("balance_mode") ) %></td>
      <td><%=getDBDateStr( rs.getString("hire_date") ) %></td>
      <td><%=getDBStr( rs.getString("rent") ) %></td>
      <td><%=getDBStr( rs.getString("corpus") ) %></td>
      <td><%=getDBStr( rs.getString("interest") ) %></td>
      <td><%=getDBStr( rs.getString("penalty") ) %></td>
      <td><%=getDBStr( rs.getString("rent_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("corpus_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("interest_adjust") ) %></td>
      <td><%=getDBDateStr( rs.getString("penalty_adjust") ) %></td>
      <td><%=getDBStr( rs.getString("hire_source") ) %></td>
      <td><%=getDBStr( rs.getString("hire_object") ) %></td>
      <td><%=getDBStr( rs.getString("hire_bank") ) %></td>
<td><%=getDBStr( rs.getString("hire_account") ) %></td>
<td><%=getDBStr( rs.getString("hire_number") ) %></td>
<td><%=getDBDateStr( rs.getString("accounting_date") ) %></td>
<td><%=getDBStr( rs.getString("instead_flag") ) %></td>
<td><%=getDBStr( rs.getString("memo") ) %></td>
      <td><%= getDBStr( rs.getString("invoice_no") ) %></td>
    </tr>
    <%
		rs.next();
		i++; 
	}
}
rs.close(); 
db.close();
%>
  </table>
  <!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
 </form>
</form>
<!-- end cwMain -->
</body>
</html>
