<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>报表 - 中投签约投放明细表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
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

	String searchFld = getStr( request.getParameter("searchFld") );
	System.out.println("searchFld==>"+searchFld);
	
	String searchKey = getStr( request.getParameter("searchKey") );
	
	String create_start_date = getStr( request.getParameter("create_start_date") );
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = "";
	if(create_start_date != null && !create_start_date.equals("")){
		//转换日期格式
	    java.util.Date cDate = sdf.parse(create_start_date);  
	    java.sql.Date now_date = new java.sql.Date(cDate.getTime()); 
		nowDateTime = sdf.format(now_date);//格式化称固定的格式
	}else{
		//获取系统当前日期 
		nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	}
	create_start_date = nowDateTime;
	
	String year = "";//年份
	ResultSet rs;
	//合同编号|银行合同编号|开户银行|维护人员
	String wherestr = " where 1=1";
	String searchFld_tmp = "";
	if( searchFld.equals("合同编号")){
		searchFld_tmp = "contract_id";
	}
	else if( searchFld.equals("承租人")){
		searchFld_tmp = "cust_name";
	}
	else if( searchFld.equals("项目名称")){
		searchFld_tmp = "project_name";
	}else if( searchFld.equals("部门")){
		searchFld_tmp = "dept_name";
	}
	else{
		searchFld_tmp = "";
	}
	
	if ( !searchFld.equals("") && !searchKey.equals("") ) {
	
		wherestr = wherestr + " and " + searchFld_tmp +  " like '%" + searchKey + "%'";
	}
	//截取年份作为查询条件必用字段 CONVERT (varchar(4),'2010-04-09',20)
	//if(create_start_date!=null && !create_start_date.equals("")){
		//year = create_start_date.substring(0,4);//截取年份
		//wherestr = wherestr +" and convert(varchar(10),update_time,21) >= '"+create_start_date+"' ";
	//}
	//if((searchFld.equals("电信公司名称") || searchFld.equals("")) && searchKey.equals("")){
		//wherestr = wherestr + " and cust.cust_name  like '%电信%'";
	//}
	//sign_date 的查询也需要遵循选择的时间
	//wherestr = wherestr + " and   cont.sign_date like '%" + year + "%'";
	
	//拼装报表的SQL语句
	
	String sqlstr = "select dept_name,'0' as proj_dept,'' as project_name,'' as contract_id , '' as cust_name,";
	 sqlstr +=" '' as  leas_type,'' as leas_form,";
	 sqlstr +=" (select sum(contract_money) from vi_signTouFangE vst ";
	 sqlstr +=" where vst.proj_dept=vstf.proj_dept) as  contract_money,";
	 sqlstr +=" (select sum(contract_money) from vi_signTouFangE vst ";
	 sqlstr +=" where vst.proj_dept=vstf.proj_dept)*100/(select sum(contract_money) from vi_signTouFangE) as rate1,";
	 sqlstr +=" (select sum(tf_money) from vi_signTouFangE vst ";
	 sqlstr +=" where vst.proj_dept=vstf.proj_dept) as  tf_money,";
	 sqlstr +=" (select sum(tf_money) from vi_signTouFangE vst ";
	 sqlstr +=" where vst.proj_dept=vstf.proj_dept)*100/(select sum(tf_money) from vi_signTouFangE) as rate2 ";
	 sqlstr +=" from vi_signTouFangE vstf "+wherestr+" group by dept_name,proj_dept";
	 sqlstr +=" union all ";

	 sqlstr +=" select dept_name,proj_dept,project_name,contract_id,cust_name,leas_type,leas_form,contract_money,";
	 sqlstr +=" rate1,tf_money,rate2 from vi_signTouFangE "+wherestr+" order by dept_name,proj_dept desc";
	
	
	System.out.println("签约投放额明细表###"+sqlstr);
%>
<script type="text/javascript">
//导出Excel
function isExport() {
	if (confirm("是否确认导出Excel!")) {
		var form1 = document.getElementById("dataNav1");
		dataNav1.action="exportSign_save.jsp";
  		form1.submit();
		dataNav1.action="report_sign_list.jsp";
	}
    
	return false;
}
</script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
	 <form name="dataNav1" action="report_sign_list.jsp" method="post">		
	 <input type="hidden" name="query_sql" id="query_sql" value="<%=sqlstr%>"/>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      报表 &gt;签约投放额明细表</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;
						<select name="searchFld" onchange="init_searchKey()">
							<script type="text/javascript" >
								w(mSetOpt("<%= searchFld %>","|合同编号|承租人|项目名称|部门"));
							</script>
				        </select>
					&nbsp;查询&nbsp;
					<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">

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
  <div style="vertical-align:top;width:100%;height:520;overflow:auto;position: relative;"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	<th rowspan="1">部门</th>
	     <th rowspan="1">合同编号</th>
	    <th rowspan="1">项目名称</th>
	    <th rowspan="1">承租人</th>
	    <th rowspan="1">租凭类型</th>
	    <th rowspan="1">租凭类别</th>
	    <th colspan="2">合同额</th>
	    <th colspan="2">投放额</th>
	  
      </tr>
      <tr class="maintab_content_table_title">
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
        <th>金额</th>
	    <th>占比</th>
	    <th>金额</th>
		<th>占比</th>
	 
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	String proj_dept=getDBStr(rs.getString("proj_dept"));
	%>
      <tr><%
 if("0".equals(proj_dept)){ %>
			<!-- 区域小计行 -->
        <td align="center" nowrap style="color:#10418C;font-weight:bold;"><%=getDBStr( rs.getString("dept_name") ) %>小计</td>
        <td align="center" nowrap class="tbodyStyle"><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td align="center" nowrap class="tbodyStyle"><%=getDBStr( rs.getString("project_name") ) %></td>
		<td align="center" nowrap class="tbodyStyle"><%= getDBStr( rs.getString("cust_name")) %></td>
		<td align="center" nowrap class="tbodyStyle"><%= getDBStr( rs.getString("leas_type")) %></td>
		<td align="center" nowrap class="tbodyStyle"><%= getDBStr( rs.getString("leas_form")) %></td>
		<td align="center" nowrap class="tbodyStyle"><%= formatNumberStr(getDBStr( rs.getString("contract_money")),"#,##0.00")%></td>
		<td align="center" nowrap class="tbodyStyle"><%= formatNumberStr(getDBStr( rs.getString("rate1")),"#,##0.00")%></td>
		<td align="center" nowrap class="tbodyStyle"><%= formatNumberStr(getDBStr( rs.getString("tf_money")),"#,##0.00")%></td>
		<td align="center" nowrap class="tbodyStyle"><%= formatNumberStr(getDBStr( rs.getString("rate2")),"#,##0.00")%></td>
		
      <% }else {%>
         <td align="center" nowrap><%=getDBStr( rs.getString("dept_name") ) %></td>
        <td align="center" nowrap><%=getDBStr( rs.getString("contract_id") ) %></td>
        <td align="center" nowrap><%=getDBStr( rs.getString("project_name") ) %></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("cust_name")) %></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("leas_type")) %></td>
		<td align="center" nowrap><%= getDBStr( rs.getString("leas_form")) %></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("contract_money")),"#,##0.00")%></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("rate1")),"#,##0.00")%></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("tf_money")),"#,##0.00")%></td>
		<td align="center" nowrap><%= formatNumberStr(getDBStr( rs.getString("rate2")),"#,##0.00")%></td>
      
      
      
      
<%
}
%>
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
