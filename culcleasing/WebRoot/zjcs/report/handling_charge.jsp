<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 手续费拆分</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script src="../../js/delitem.js"></script>
<script type="text/javascript">

		
	//查询条件变更为空时后面的输入框值清空
	function init_searchKey(){
		var searchFld  = document.dataNav1.searchFld.value;
		//alert(searchFld);
		if(searchFld == null || searchFld == ""){
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = true;
		}else{
			document.dataNav1.searchKey.value = "";
			document.dataNav1.searchKey.disabled = false;
		}
	}
</script>

<%
	String dqczy=(String) session.getAttribute("czyid");
	//System.out.println("dqczy="+dqczy);

String contract_id = getStr( request.getParameter("contract_id") );

String systemDate = getSystemDate(0);
ResultSet rs;
String wherestr = " where 1=1 ";

String searchFld_tmp = "";


if ( !contract_id.equals("") && !contract_id.equals("") ) {

	wherestr += " and hct.contract_id='"+contract_id+"'";
}
//if(create_start_date!=null&&!create_start_date.equals("")){
	//wherestr+=" and convert(varchar(10),create_date,21)>='"+create_start_date+"' ";
//}
//if(create_end_date!=null&&!create_end_date.equals("")){
	//wherestr+=" and convert(varchar(10),create_date,21)<='"+create_end_date+"' ";
//}
//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_info_main" + wherestr +" order by create_date desc"; 
String sqlstr="select hct.contract_id,project_name,plan_date,plan_list,rent,corpus,isnull(interest,0) interest,";
		sqlstr+="corpus_overage,isnull(other_interest,0) other_interest,isnull(other_handling,0) other_handling,isnull(other_income_detail,0) other_income_detail,isnull(other_expenditure_detail,0) other_expenditure_detail from handling_charge_temp hct left join contract_info ci on hct.contract_id=ci.contract_id "+wherestr ;
System.out.println("###"+sqlstr);
	
%>
<script type="text/javascript">
//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="handling_export_save.jsp";
  		form1.submit();
		dataNav1.action="handling_charge.jsp";
	}
    
	return false;
}
</script>
</head>
<body onLoad="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto">
	 <form name="dataNav1" action="handling_charge.jsp" method="post">		
	 <input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt;手续费拆分</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
				<td align="left" colspan="2">               
				
					&nbsp;合同号&nbsp;
					<input name="contract_id" accesskey="s" type="text" size="15" value="<%= contract_id %>">
					
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<td>
					<a href="#" accesskey="n" 
						onClick="isExport()">
						<img   src="../../images/sbtn_2Excel.gif" alt="导出" align="absmiddle">
					</a>
				</td>
		    </tr>
        </table>
        <!--操作按钮结束--></td>
      <td align="right" width="90%"><!--翻页控制开始-->
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
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--报表开始-->


<div
				style="vertical-align:top;width:100%;overflow:auto;position: relative;"
				id="mydiv";>

					

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	     <th width='80'>合同号</th>
	     <th>项目名称</th>
        <th width='80'>计划日期</th>
        <th>期次</th>
        <th>租金</th>
		<th>本金</th>
        <th>租赁收入</th>
        <th>其中:租息</th>
	<th>其中:手续费收入</th>
        <th>其中:其它收入</th>
        <th>其中:其它支出</th>
        <th>剩余本金</th>
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>
         <td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
         <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
        <td align="center"><%=getDBStr(rs.getString("plan_list"))%></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("rent")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("corpus")) %></td>
		<td align="center"><%=formatNumberDoubleTwo(rs.getString("interest"))%></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("other_interest")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("other_handling")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("other_income_detail")) %></td>
        <td align="center"><%=formatNumberDoubleTwo(rs.getString("other_expenditure_detail")) %></td>
		<td align="center"><%=formatNumberDoubleTwo(rs.getString("corpus_overage"))%></td>

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
  </div>
    </form>
  <!--报表结束-->

</body>
</html>
