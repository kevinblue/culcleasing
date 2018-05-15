<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body  onload="public_onload(0)">

<form action="khzygr_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				</td>
			</tr>
</table>
<%

String dqczy=(String)session.getAttribute("czyid");
String id = getStr( request.getParameter("id") );
System.out.println("##############id="+id);
ResultSet rs;
String wherestr = " where 1=1";

//String sqlstr="select *, (vi_mproj_info_cs.ensure_payment+vi_mproj_info_cs.deposit_amount-vi_mproj_info_cs.deposit_export) as leiji,dengjiren=dbo.GETUSERNAME(vi_mproj_info_cs.creator),xiugairen=dbo.GETUSERNAME(vi_mproj_info_cs.modificator)  from vi_mproj_info_cs left join contract_manuf on contract_manuf.id=vi_mproj_info_cs.uid  where 1=1 and uid='"+id+"' ";
String sqlstr="select *,(ensure_payment+deposit_amount-deposit_export) as leiji,dengjiren=dbo.GETUSERNAME(mproj_company.creator),xiugairen=dbo.GETUSERNAME(mproj_company.modificator) from mproj_company where 1=1 and uid='"+id+"'";

	
System.out.println("&*"+sqlstr);
%>
	
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="1%">
<table border="0" cellspacing="0" cellpadding="0" >    
   <tr class="maintab">
				<%if(right.CheckRight("csbzj_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','csbzj_add.jsp?uid=<%=id%>',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle"></a></td><%}%><input name="id" type="hidden" value="<%= id %>">
				<%if(right.CheckRight("csbzj_mod",dqczy)>0){%><td><a href="#" accesskey="m" onClick="dataHander('mod','csbzj_mod.jsp?bid=',dataNav.itemselect);"><img   src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" align="absmiddle" ></a></td><%}%>
				
		    </tr>
</table>
</td>
<td align="right" width="90%">
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
   rs=db.executeQuery(sqlstr); 
   

	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();

	rs.beforeFirst();
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);   
         //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>

<input type="hidden" name="id" value="<%=id%>">
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

<!-- end cwCellTop -->
</td>
</tr>
</table>
<div style="vertical-align:top;height:500px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>



    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		 <th>序号</th>
		
	    <th>子合同编号</th>
	    <th>保证金比率</th>
	    <th>厂商设备金额</th>	
	  	<th>最低保证金额</th>

		<th>保证金累计金额</th>
        <th>保证金汇入金额</th>
		<th>保证金汇入时间</th>
		<th>保证金汇入原因</th>
		 <th>保证金汇出金额</th>
		<th>保证金汇出时间</th>
		<th>保证金汇出原因</th>

		<th>创建人</th>
		<th>创建时间</th>
		<th>修改人</th>
		<th>修改时间</th>
      </tr>
<%
	
if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){

%>
	  
      <tr class="cwDLRow" >
         <td align="center"><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("bid") )%>"></td>
       <td align="center"><a href="csbzj.jsp?bid=<%=getDBStr( rs.getString("bid") )  %>" target="_blank"><%=getDBStr( rs.getString("bid") )  %></a></td>
   
       <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
       
		<td><%=getDBStr(rs.getString("margin_per"))%>%</td>
		
		<td><%=formatNumberStr(rs.getString("vendor_payment"),"#,##0.00")%></td>
		<td><%=getDBStr(rs.getString("min_payment"))%></td>

		<td><%=getDBStr(rs.getString("leiji"))%></td>
		<td><%=getDBStr(rs.getString("deposit_amount"))%></td>
		<td><%=getDBDateStr(rs.getString("margin_time"))%></td>
		<td><%=getDBStr(rs.getString("margin_reason"))%></td>
		<td><%=getDBStr(rs.getString("deposit_export"))%></td>
		<td><%=getDBDateStr(rs.getString("export_time"))%></td>
        <td><%=getDBStr(rs.getString("export_reason"))%></td>

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


<!-- end cwDataNav -->

</div>
<!-- end cwCellContent -->


</form>
<!-- end cwMain -->
</body>
</html>
