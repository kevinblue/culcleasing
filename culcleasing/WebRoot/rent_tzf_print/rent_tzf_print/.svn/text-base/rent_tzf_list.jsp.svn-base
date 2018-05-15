<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>到期租金 - 通知单</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<body onload="public_onload(0);">
<form action="rent_tzf_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				到期租金 &gt; 通知单</td>
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
if (right.CheckRight("rent-tzf-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------
String curr_date = getSystemDate(0);
ResultSet rs;
String wherestr = " where 1=1";
String wherestr2 = " where 1=1 and aa.deduRent>0 and aa.contract_id not in(select contract_id from contract_notsend union select contract_id from contract_info where contract_status in('103') or charge_off_flag='是' union select contract_id from contract_equip where equip_status in('equip_status3','equip_status4','equip_status5'))";
String s_date = getStr( request.getParameter("s_date") );	//开始日期
String e_date = getStr( request.getParameter("e_date") );	//结束日期
String bad_date = getStr( request.getParameter("bad_date") );	//逾期结算日期
String print_flag= getStr( request.getParameter("print_flag") );//打印标志
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
if(s_date.equals("")){
	s_date=curr_date;
}
if(e_date.equals("")){
	e_date=getDateAdd(curr_date,1,"mm");
}
if(bad_date.equals("")){
	bad_date=curr_date;
}


wherestr=wherestr+" and fund_rent_plan.plan_date>='"+s_date+"' and fund_rent_plan.plan_date<='"+e_date+"'";
if ( !searchFld.equals("") && !searchKey.equals("") ) {
	if ( searchFld.equals("aa.industry_name") && searchKey.equals("非建筑") ) {
		wherestr2 = wherestr2 + " and isnull(aa.industry_name,'')<>'建筑业'";
	}else{
		wherestr2 = wherestr2 + " and " + searchFld + " like '%" + searchKey + "%'";
	}
}


String sqlstr = "select aa.* from (select contract_payment_notice.id,a.contract_id, vi_contract_info.cust_name, ifelc_conf_dictionary.title as industry_name, contract_signatory.client_mobile_number as phone,fund_rent_plan.rent, a.plan_date, dbo.bb_getBadRent('1970-01-01','"+bad_date+"',a.contract_id) as badRent,isnull(contract_payment_notice.print_status,'否') as print_status,dbo.bb_getDeduRent_tzf(fund_rent_plan.contract_id,fund_rent_plan.rent_list) as deduRent from ( select fund_rent_plan.contract_id,max(fund_rent_plan.plan_date) as plan_date from fund_rent_plan"+wherestr+" group by fund_rent_plan.contract_id )a inner join fund_rent_plan on a.contract_id=fund_rent_plan.contract_id and a.plan_date=fund_rent_plan.plan_date left join vi_contract_info on a.contract_id=vi_contract_info.contract_id left join ( 	select contract_payment_notice.* from contract_payment_notice where id in( 		select max(id) as id from contract_payment_notice group by contract_id,rent_list 	) )contract_payment_notice on fund_rent_plan.contract_id=contract_payment_notice.contract_id and fund_rent_plan.rent_list=contract_payment_notice.rent_list left join ifelc_conf_dictionary on vi_contract_info.industry_type=ifelc_conf_dictionary.name left join contract_signatory on vi_contract_info.contract_id=contract_signatory.contract_id)aa"+wherestr2; 

if(!print_flag.equals("")){
	sqlstr = sqlstr+" and isnull(aa.print_status,'否')='"+print_flag+"'";
}
sqlstr+=" order by aa.contract_id";
System.out.println("sqlstr000=================="+sqlstr);
%>




<!--翻页控制开始-->


<% 
	int intPageSize = 300;   //一页显示的记录数
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






<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td nowrap>&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|行业|合同|客户","|aa.industry_name|aa.contract_id|aa.cust_name"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="10" value="<%= searchKey %>"></td>
    	
		<td nowrap align="left">逾期结算日<input name="bad_date" type="text" size="10" readonly dataType="Date" value="<%=bad_date %>" require="true">
<!--
<img  onClick="openCalendar(bad_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
-->
</td>
		<td  nowrap>打印标记<select name="print_flag"><script>w(mSetOpt("<%=print_flag%>",'|否|是'));</script></select></td>
		
		
		
	</tr>
    <tr class="maintab">
    	<td nowrap>开始日期<input name="s_date" type="text" size="10" readonly dataType="Date" value="<%=s_date %>" require="true"><img  onClick="openCalendar(s_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    	<td nowrap>结束日期&nbsp;&nbsp;<input name="e_date" type="text" size="10" readonly dataType="Date" value="<%=e_date %>" require="true"><img  onClick="openCalendar(e_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
		<td nowrap>
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
		
		<%if (right.CheckRight("rent-tzf-print",dqczy)>0){ %>
    	<a href="./rent_tzf_print.jsp?s_date=<%= s_date %>&e_date=<%= e_date %>&bad_date=<%= bad_date %>&searchFld=<%= searchFld %>&searchKey=<%= searchKey %>&print_flag=<%= print_flag %>&intPage=<%=intPage%>" target="_blank"><img align="absmiddle"  src="../../images/sbtn_print.gif" alt="打印" align="absmiddle"></a>
		<%} %>
		
		<%if (right.CheckRight("rent-tzf-print1",dqczy)>0){ %>
    	<a href="./rent_tzf_print1.jsp?s_date=<%= s_date %>&e_date=<%= e_date %>&bad_date=<%= bad_date %>&searchFld=<%= searchFld %>&searchKey=<%= searchKey %>&print_flag=<%= print_flag %>" target="_blank"><img align="absmiddle"  src="../../images/sbtn_2Excel.gif" alt="导出代理商excel" align="absmiddle"></a>
    	<%} %>
    	
    	<%if (right.CheckRight("rent-tzf-print2",dqczy)>0){ %>
    	<a href="./rent_tzf_print2.jsp?s_date=<%= s_date %>&e_date=<%= e_date %>&bad_date=<%= bad_date %>&searchFld=<%= searchFld %>&searchKey=<%= searchKey %>&print_flag=<%= print_flag %>" target="_blank"><img align="absmiddle"  src="../../images/sbtn_hz.gif" alt="生成短信" align="absmiddle"></a>
		<%} %>
		
		<%if (right.CheckRight("printcancel-save",dqczy)>0){ %>
    	<a href="./printcancel_save.jsp?s_date=<%= s_date %>&e_date=<%= e_date %>&bad_date=<%= bad_date %>&searchFld=<%= searchFld %>&searchKey=<%= searchKey %>&print_flag=<%= print_flag %>&intPage=<%=intPage%>" target="_blank"><img align="absmiddle"  src="../../images/sbtn_del.gif" alt="批量取消" align="absmiddle"></a>
		<%} %>
		</td>
    </tr>
</table>
<!--操作按钮结束-->
</td>
					 <td align="right" width="90%">
					 	
					 	



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
		<th>合同编号</th>
		<th>行业</th>
        <th>承租客户</th>
        <th>手机号码</th>
        <th>打印状态</th>
        <th>应收租金</th>
        <th>偿还日期</th>
        <th>逾期租金</th>
      </tr>
  

<%	
	rs.previous();
	if ( rs.next() ) {  
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
		<td><%= getDBStr( rs.getString("contract_id") ) %></td> 
		<td><%= getDBStr( rs.getString("industry_name") ) %></td> 	 	
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td><%= getDBStr( rs.getString("phone") ) %></td>
		<% if(getDBStr( rs.getString("print_status") ).equals("是") && right.CheckRight("isprint-save",dqczy)>0){ %>
		<td><a href="./isprint_save.jsp?czid=<%= getDBStr( rs.getString("id") ) %>" target="_blank"><%= getDBStr( rs.getString("print_status") ) %></a></td>
		<%}else{ %>
		<td><%= getDBStr( rs.getString("print_status") ) %></td>
		<%} %>
		<td><%= formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00") %></td>
		<td><%= getDBDateStr( rs.getString("plan_date") ) %></td> 	 	
		<td><%= formatNumberStr(getDBStr( rs.getString("badRent") ),"#,##0.00") %></td>
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
