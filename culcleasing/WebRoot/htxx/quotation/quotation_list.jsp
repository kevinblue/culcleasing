<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>电信协议报价 - 报价维护</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
	
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
System.out.println("dqczy="+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );

ResultSet rs;
String wherestr = " where mqi.contract_id is not null ";

String searchFld_tmp = "";
if( searchFld.equals("主项目编号") ) {
	searchFld_tmp = "mqi.proj_id";
}else if( searchFld.equals("主合同号") ) {
	searchFld_tmp ="mqi.contract_id";
}else if( searchFld.equals("客户名称") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("付款方式") ) {
	searchFld_tmp ="pay_type";
}else if( searchFld.equals("报价期限") ) {
	searchFld_tmp ="plan_year";
}else if( searchFld.equals("期末设备退还") ) {
	searchFld_tmp ="equip_return ";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}

//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info_main" + wherestr +" order by create_date desc"; 
String sqlstr = "select mqi.*,vca.cust_name,xm=dbo.GETUSERNAME(mqi.modificator)  from mproj_quotation_info mqi left join mproj_info mi on mqi.contract_id=mi.contract_id left join vi_cust_all_info vca on mi.cust_id=vca.cust_id  " + wherestr+" order by cust_name "; 
System.out.println("###"+sqlstr);
%>
<!--<body onLoad="public_onload(0);"-->

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      主协议报价 &gt; 主协议报价信息</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
	 <form name="dataNav1" action="quotation_list.jsp">		
	<tr class="maintab">
				<td align="left" colspan="4">               
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|主项目编号|主合同号|客户名称|付款方式|报价期限|期末设备退还"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
				<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="3%" rowspan="2"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr>
			<%--
				<%if(right.CheckRight("khxx_frkh_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','quotation_mod.jsp?custId=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a>&nbsp;</td><%}%>
             --%>
	  </tr>
</table>
        <!--操作按钮结束--></td>
      <td align="right" width="90%" colspan="2"><!--翻页控制开始-->
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

System.out.println("%%%%===================================%%"+sqlstr);
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
		var nf = document.dataNav1;
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
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>
          </form>
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <form action="frkh_list.jsp" name="dataNav">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <!-- <th width="1%"></th> -->
	    <th>主项目编号</th>
	    <th>主合同编号</th>
	    <th>客户名称</th>
	    <th>付租类型</th>
	    <th>付租方式</th>
	     <th>报价年利率</th>
	    <th>报价IRR</th>
		<th>租凭期限</th>
		<th>设备退环</th>
		<!-- <th>修改人</th>
		<th>修改时间</th> -->
		
		
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	//String custId=getDBStr(rs.getString("cust_id"));
   //System.out.println("99"+custId);
%>

      <tr>
	 
        <%-- <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>"></td>  --%>
        <td align="center"><%=getDBStr( rs.getString("proj_id") )  %></td>
        <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
         <td align="center"><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("type") ) %></td>
			<td align="center"><%= getDBStr( rs.getString("pay_type") ) %></td>

		<td align="center"><%=formatNumberStr( rs.getString("plan_bj"),"#,##0.00") %></td>
		<td align="center"><%=formatNumberStr( rs.getString("plan_bjirr"),"#,##0.00") %></td>
		<td align="center"><%=getDBStr( rs.getString("plan_year")) %></td>
		<td align="center"><%=getDBStr( rs.getString("equip_return")) %></td>
		<%--  <td align="center"><%= getDBStr( rs.getString("xm") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td> --%>
			
      </tr>
<%
		rs.next();
		i++;
	}
}
}
rs.close(); 
db.close();
%>
    </table>
    </form>
  </div>
  <!--报表结束-->

</body>
</html>
