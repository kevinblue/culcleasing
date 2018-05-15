<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
/*if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("inspecter-jxkcnb-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>每月应收租金 - 财务</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body  onload="public_onload(0)">
<form action="yszj_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				财务&gt; 每月应收租金</td>
			</tr>
</table>
<%
String findMonth=getStr( request.getParameter("searchMonth") );
String findYear=getStr( request.getParameter("searchYear") );
String date=getSystemDate(0);
String dates[]=date.split("-");
ResultSet rs;
String wherestr = " where 1=1";
if(findYear.equals("")){
findYear=dates[0];
}
if(findMonth.equals("")){
findMonth=dates[1];
}
int year=Integer.parseInt(findYear);
int month=Integer.parseInt(findMonth);
String star=year+"-"+month+"-1";
String end=year+"-"+(month+1)+"-1";
if(month==12){end=(year+1)+"-1-1";}
String sqlstr = "select * from (select info.contract_id,dbo.getcustnamebycontractid(info.contract_id) as cust_name,cond.lease_money,(select sum(interest) from fund_rent_plan where contract_id=info.contract_id) as all_inerest,(select corpus from fund_rent_plan where contract_id=info.contract_id and plan_date>='"+star+"' and  plan_date<'"+end+"') as corpus from contract_info as info left join contract_condition as cond on (info.contract_id=cond.contract_id)) as rs where rs.all_inerest>0 and rs.corpus>0"; 
System.out.print(sqlstr);
%>
<script>
	function init(){
		var time=new Date();
		var nowYear=time.getYear();
		var searchYear=document.getElementById("searchYear");
		for(var i=nowYear-5;i<nowYear+5;i++){
			var o=new Option(i,i);
			searchYear.options.add(o);
			if(i==<%=year%>){
				o.selected=true;
			}
		}
	}
</script>
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left">
					&nbsp;&nbsp;年份
					<select name="searchYear" id="searchYear" value="<%=findYear%>">						
					</select>
					&nbsp;&nbsp;月份
					<select name="searchMonth" id="searchMonth">
						<option value="1" <%if(month==1)out.print("selected");%>>一月</option>
						<option value="2" <%if(month==2)out.print("selected");%>>二月</option>
						<option value="3" <%if(month==3)out.print("selected");%>>三月</option>
						<option value="4" <%if(month==4)out.print("selected");%>>四月</option>
						<option value="5" <%if(month==5)out.print("selected");%>>五月</option>
						<option value="6" <%if(month==6)out.print("selected");%>>六月</option>
						<option value="7" <%if(month==7)out.print("selected");%>>七月</option>
						<option value="8" <%if(month==8)out.print("selected");%>>八月</option>
						<option value="9" <%if(month==9)out.print("selected");%>>九月</option>
						<option value="10" <%if(month==10)out.print("selected");%>>十月</option>
						<option value="11" <%if(month==11)out.print("selected");%>>十一月</option>
						<option value="12" <%if(month==12)out.print("selected");%>>十二月</option>
					</select>
                    <script>init();</script>
					&nbsp;<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchInfo();">
				</td>
			
<td align="right">
<%
int intPageSize = 18;   //一页显示的记录数
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

<div style="vertical-align:top;height:200px;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		 <th>合同编号</td>
		 <th>客户名称</th>
		 <th>净融资额</th>
		 <th>利息总和</th>
		 <th>租金</th>
		 <th>&nbsp;&nbsp;月份&nbsp;&nbsp;</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
		
%>  
      <tr class="cwDLRow" >
		<td align="center"><%=getDBStr( rs.getString("contract_id") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>
		<td align="center"><%=formatNumberStr( rs.getString("lease_money"),"#,##0.00" ) %></td>
		<td align="center"><%=formatNumberStr(rs.getString("all_inerest"),"#,##0.00") %></td>
		<td align="center"><%=formatNumberStr(rs.getString("corpus"),"#,##0.00") %></td>
		<td align="center"><%=findYear+"-"+findMonth%></td>
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
</form>
</body>
</html>
