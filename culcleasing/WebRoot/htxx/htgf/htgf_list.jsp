<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同各方</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body onload="public_onload(0);">
<form action="htgf_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同信息 &gt; 合同各方</td>
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
if (right.CheckRight("htxx-htgf-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------

ResultSet rs;
String wherestr = " where 1=1";

String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String searchFld_tmp = "";
if( searchFld.equals("合同编号") ) {
	searchFld_tmp = " contract_signatory.contract_id";
}
if ( !searchFld.equals("") && !searchKey.equals("") ) {
	wherestr = wherestr + " and" + searchFld_tmp + " like '%" + searchKey + "%'";
}

String sqlstr = "select contract_signatory.contract_id, vi_contract_info.cust_name, contract_signatory.lessor, vi_cust_all_info.cust_name as lessor_name, contract_signatory.leaseconsigner, contract_signatory.lease_acc_number, cust_account.bank_name as lease_bank_name, cust_account.account as lease_account, contract_signatory.client, vi_cust_all_info2.cust_name as client_name, contract_signatory.clientconsigner, contract_signatory.client_acc_number, cust_account2.bank_name as client_bank_name, cust_account2.account as client_account, contract_signatory.client_postcode, contract_signatory.client_address, contract_signatory.client_linkman, contract_signatory.client_mobile_number, contract_signatory.client_tel, contract_signatory.client_fax from contract_signatory left join vi_cust_all_info on contract_signatory.lessor=vi_cust_all_info.cust_id left join vi_cust_all_info vi_cust_all_info2 on contract_signatory.client=vi_cust_all_info2.cust_id left join cust_account on contract_signatory.lessor=cust_account.cust_id and contract_signatory.lease_acc_number=cust_account.acc_number left join cust_account cust_account2 on contract_signatory.client=cust_account2.cust_id and contract_signatory.client_acc_number=cust_account2.acc_number left join vi_contract_info on contract_signatory.contract_id=vi_contract_info.contract_id" + wherestr; 
//System.out.println("sqlstr=================="+sqlstr);
%>



<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td nowrap>&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
		<%
			if (right.CheckRight("htxx-htgf-mod",dqczy)>0){
		 %>
		<td><a href="#" accesskey="m" onclick="dataHander('mod','htgf_mod.jsp?czid=',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td>
		<%} %>
	</tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	
<!--翻页控制开始-->


<% 
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


rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--翻页控制结束-->






<!--报表开始-->

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>

   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th width="1%"></th>
		<th>合同编号</th>
		<th>承租客户</th>
        <th>甲方</th>
        <th>委托代理人（甲方）</th>
        <th>开户银行（甲方）</th>
        <th>开户户名（甲方）</th>
        <th>开户帐号（甲方）</th>
        <th>乙方</th>
        <th>委托代理人（乙方）</th>
        <th>开户银行（乙方）</th>
        <th>开户户名（乙方）</th>
        <th>开户帐号（乙方）</th>
        <th>付款联系人</th>
        <th>邮政编码（乙方）</th>
        <th>地址（乙方）</th>
        <th>短信联系手机号</th>
        <th>电话（乙方）</th>
        <th>传真（乙方）</th>
      </tr>
  

<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td align="left"><a href="htgf.jsp?czid=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank"><%= getDBStr(rs.getString("contract_id") ) %></a></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td> 
		<td><%= getDBStr( rs.getString("lessor_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("leaseconsigner") ) %></td>
		<td><%= getDBStr( rs.getString("lease_bank_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("lease_account") ) %></td>
		<td><%= getDBStr( rs.getString("lease_acc_number") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_name") ) %></td>
		<td><%= getDBStr( rs.getString("clientconsigner") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_bank_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_account") ) %></td>
		<td><%= getDBStr( rs.getString("client_acc_number") ) %></td> 
		<td><%= getDBStr( rs.getString("client_linkman") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_postcode") ) %></td>
		<td><%= getDBStr( rs.getString("client_address") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_mobile_number") ) %></td>
		<td><%= getDBStr( rs.getString("client_tel") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("client_fax") ) %></td>
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
</div>

<!--报表结束-->
</form>
</body>
</html>
