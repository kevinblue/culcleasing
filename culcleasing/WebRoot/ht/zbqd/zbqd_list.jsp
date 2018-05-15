<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("contract-zbqd-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同正本清单 - 合同管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
ResultSet rs;
String searchKey = getStr( request.getParameter("searchKey") );
String wherestr = "";
if(!searchKey.equals("")) {
	wherestr = "and info.contract_id like '%"+searchKey+"%'";
}
String sqlstr = "select DISTINCT info.contract_id,dbo.getcustnamebycontractid(info.contract_id) as cust_name,DBO.GETMODELBYID(equip.DEVICE_TYPE) AS DEVICE_TYPE,equip.equip_sn,convert(varchar(10),start_date,120) as start_date,first_payment_ratio,lease_term,convert(varchar,(select top 1 rent from fund_rent_plan as plans where plans.contract_id=info.contract_id order by rent_list),1) as rent,dbo.fk_getname(info.proj_dept)as proj_dept ,base.province,convert(varchar(10),confirm_date,120)as confirm_date,convert(varchar(10),get_date,120) as get_date,dbo.getattach(info.contract_id) as attach_memo,convert(varchar(10),branch_expdate,120) as branchexpdate ,convert(varchar(10),csmd_receive_date,120)as csmdredate,convert(varchar(10),csmd_expdate,120)as csmdexpdate,convert(varchar(10),proj.offer_date,120) as offer_date,special_remark from contract_info as info left join contract_condition as con on (info.contract_id=con.contract_id) left join contract_equip as equip on (info.contract_id=equip.contract_id) left join downpayment_info as down on (info.contract_id=down.contract_id) left join insurance_info as ins on (info.contract_id=ins.contract_id) left join proj_info as proj on(info.proj_id=proj.proj_id) left join contract_time_info as timeinfo on(info.contract_id=timeinfo.contract_id) left join base_filiale_province as base on(info.proj_dept=base.filiale_id) where 1=1 " +wherestr; 
System.out.println("sqlstr=================="+sqlstr);
%>
<body onLoad="public_onload(0);">
<form action="zbqd_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				合同管理 &gt; 合同正本清单</td>
			</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="35%">
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
    	<td align="left" width="30%">
					 &nbsp;按合同编号查询
<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>
"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
<a href="#" accesskey="n" onClick="dataHander('mod','zbqd_mod.jsp?czid=',dataNav.itemselect);"><img  src="../../images/sbtn_mod.gif" alt="修改(Alt+N)" align="absmiddle"></a></td>
    </tr>
</table>
<td align="left" width="1%">

<!--操作按钮开始-->
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
		<th>客户名称</th>
		<th>设备型号</th>
        <th>机编号</th>
        <th>起租日</th>
        <th>首付比例</th>
        <th>租赁期限</th>
        <th>每期租金</th>
        <th>分公司</th>
        <th>省份</th>
        <!--<th>资料所在地</th>-->
        <th>首付确认日期</th>
        <th>收保单日期</th>
        <th>文件备注</th>
        <!--<th>发票开具日</th>-->
        <th>分公司寄件日</th>
        <th>CSMD收件日</th>
        <th>CSMD寄件日</th>
        <th>报价通过日期</th>
        <th>特别备注</th>
      </tr>


<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%= getDBStr( rs.getString("contract_id") ) %>"></td>
        <td><%= getDBStr(rs.getString("cust_name") ) %></td>
        <td><%= getDBStr( rs.getString("DEVICE_TYPE") ) %></td>
        <td><%= getDBStr( rs.getString("equip_sn") ) %></td>
        <td><%= getDBDateStr( rs.getString("start_date") ) %></td>
        <td><%= getDBStr( rs.getString("first_payment_ratio") ) %></td>
        <td><%= getDBStr( rs.getString("lease_term") ) %></td>        
        <td><%= getDBStr( rs.getString("rent") ) %></td>
        <td><%= getDBStr( rs.getString("proj_dept") ) %></td>
        <td><%= getDBStr( rs.getString("province") ) %></td>
        <!--<td></td>-->
        <td><%= getDBDateStr( rs.getString("confirm_date") ) %></td>
        <td><%= getDBDateStr( rs.getString("get_date") ) %></td>
        <td><%= getDBStr( rs.getString("attach_memo") ) %></td>
        <!--<td></td>-->
        <td><%= getDBDateStr( rs.getString("branchexpdate") ) %></td>
        <td><%= getDBDateStr( rs.getString("csmdredate") ) %></td>
        <td><%= getDBDateStr( rs.getString("csmdexpdate") ) %></td>
        <td><%= getDBDateStr( rs.getString("offer_date") ) %></td>
        <td><%= getDBStr( rs.getString("special_remark") ) %></td>
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
