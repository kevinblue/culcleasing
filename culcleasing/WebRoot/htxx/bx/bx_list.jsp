<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产管理-保险管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
	
</head>

<%
String dqczy=(String) session.getAttribute("czyid");
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("保险期限") ) {
	searchFld_tmp = "period_insurance";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "contract_insurance.contract_id";
}else if( searchFld.equals("险种") ) {
	searchFld_tmp = "insurance_type";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),contract_insurance.create_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),contract_insurance.create_date,21)<='"+create_end_date+"' ";
}

String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(contract_insurance.creator),xiugairen=dbo.GETUSERNAME(contract_insurance.modificator) from contract_insurance left join contract_info on contract_insurance.contract_id=contract_info.contract_id" + wherestr; 
%>
<body onLoad="public_onload(0);" style="border:1px solid #8DB2E3;overflow:auto">
<form action="bx_list.jsp" name="dataNav" onSubmit="return goPage()">
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">资产管理 &gt;保险管理</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" colspan="2">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
				&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|保险期限|险种"));</script></select>
				&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
				添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
			</td>
          </tr>
        </table></td>
        
    </tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<%if(right.CheckRight("bx_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','bx_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td><%}%>
				<%if(right.CheckRight("bx_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','bx_mod.jsp?id=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td><%}%>
				<%if(right.CheckRight("bx_del",dqczy)>0){%><td><a href="#" accesskey="d" onClick="dataHander('del','bx_del.jsp?id=',dataNav.itemselect);"><img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" align="absmiddle" ></a></td><%}%>
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
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>序号</th>
	    <th>合同编号</th>
	    <th>是否我司购买保险</th>
	    <th>保险单号</th>
	    <th>保险期限</th>
	  
	    <th>创建人</th>
		<th>创建时间</th>
		<th>修改人</th>
		<th>修改时间</th>
		
		
		
      </tr>

<%	  

if ( intRowCount!=0 ) 
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	//String custId=getDBStr(rs.getString("cust_id"));
%>

      <tr>
        <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>"></td>
        <td align="center"><a href="bx.jsp?id=<%=getDBStr( rs.getString("id") )  %>" target="_blank"><%=getDBStr( rs.getString("id") )  %></a></td>
		<td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("insurance_my") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("insurance_id") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("period_insurance") ) %></td>
	
		<td align="center"><%= getDBStr( rs.getString("dengjiren") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("xiugairen") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("modify_date") ) %></td>
				
		
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
