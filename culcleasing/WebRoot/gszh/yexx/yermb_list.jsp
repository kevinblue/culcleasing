<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="java.math.BigDecimal" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>每日现金余额表 - 资金信息管理</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt"  >资金信息管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">


<%
String czzh=getStr(request.getParameter("czzh"));
String czzhmc=getStr(request.getParameter("czzhmc"));
String czid=getStr(request.getParameter("czid"));
String sqlstr;
String expsqlstr;
ResultSet rs;
String czy=(String) session.getAttribute("czyid");//取得操作员ID
if ((czy==null) || (czy.equals(""))) czy="0";
//czy="AFEE-6A6CWE";//资金管理部张惠华
//czy="AFEE-6A6CW5";//融资业务部郭春浩
sqlstr="select bmbh from jb_gsbm where bmmc=(select bmmc from v_yhxx where id='"+czy+"')";
String bmid="";//部门id
rs=db.executeQuery(sqlstr);
if (rs.next()) bmid=rs.getString("bmbh");
if ((bmid==null) || (bmid.equals(""))) bmid="0";
%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">每日现金余额表</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

<%

String sDate=getSystemDate(0); 
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf1.parse(sDate);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String sResult = sdf2.format(date);

BigDecimal total=new BigDecimal("0.00");
BigDecimal total1=new BigDecimal("0.00");
String wherestr="";
String searchKeyjlrq1="";//记录日期1
String searchKeyjlrq2="";//记录日期2

String rqstr1=request.getParameter("searchKeyjlrq1");
String rqstr2=request.getParameter("searchKeyjlrq2");
if ((rqstr1==null) && (rqstr2==null))
{	searchKeyjlrq1=sResult;
	rqstr1=sResult;
}


if (request.getParameter("czzh")!=null && request.getParameter("czzh").equals("")==false)
    wherestr=" where (zh='"+czzh+"') and (qcyebb IS NOT NULL OR dryebb IS NOT NULL)";
else
   {wherestr=" where (1=1) and (qcyebb IS NOT NULL OR dryebb IS NOT NULL)";}
 
   searchKeyjlrq1=rqstr1;
if ((searchKeyjlrq1==null) || (searchKeyjlrq1.equals("")))
{
}
else
{
    wherestr = wherestr+" and (drrq>='"+searchKeyjlrq1+"') "; 
}
searchKeyjlrq2=getStr(request.getParameter("searchKeyjlrq2"));
if ((searchKeyjlrq2==null) || (searchKeyjlrq2.equals("")))
{

}
else
{
    wherestr = wherestr+" and (drrq<='"+searchKeyjlrq2+" 23:59:59') "; 
}
 
expsqlstr="select zh 账号,zhmc 账户名称,drrq 当日日期,qcyebb 期初余额人民币,dtsr 当天收入,dtzc 当天支出,dryebb 当日余额人民币, from v_zh_xjye"+wherestr+" order by drrq";
 
%>

<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
	   <td align="center">账号：<%=czzh%> 账户名称：<%=czzhmc%></td>
   
   <form name="expform" action="../../func/exp.jsp" target="_blank" method="post">
          <td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>"><input name="expsubmit" type="submit" value="导出到EXCEL" style=" border:none;background-image:url(../../images/expExcel.gif); padding:2px 0px 0px 20px; height:20px; width:110px ">
          </td>
        </form>
		
<%
//out.print(bmid);

if (bmid.equals("12"))//权限控制按钮
{
%>
	
<%
}
%>
        <form name="searchbar" action="yermb_list.jsp">
         
        	<td nowrap>日期1<input name="searchKeyjlrq1" accesskey="r" type="text" size="9" value="<%=rqstr1%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
日期2<input name="searchKeyjlrq2" accesskey="q" type="text" size="9" value="<%=searchKeyjlrq2%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
<input name="czzhmc" type="hidden" value="<%=czzhmc%>">
            <input name="czzh"  type="hidden" value="<%=czzh%>">	
			 <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
        </td>
        
        </form>
		
      </tr>
</table>


</div>
<!-- end cwCellTop -->
<% 
int intPageSize;   //一页显示的记录数
int intRowCount=0;   //记录总数
int intPageCount;  //总页数
int intPage;       //待显示页码
int i;
java.lang.String strPage;

     //设置一页显示的记录数
	 intPageSize = 50;
	 intPageCount=1;
	 //取得待显示页码
	 strPage = request.getParameter("page");
	 if(strPage==null || strPage=="")
	 {//表明在QueryString中没有page这一个参数，此时显示第一页数据
	     intPage = 1;
	 }
	 else
	 {//将字符串转换成整型
	      intPage = java.lang.Integer.parseInt(strPage);
		  if(intPage<1) intPage = 1;
	 } 
%>



<div id="cwCellContent">

    <form name="list">

    <table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
	    <th width="1%"></th>
	    <th>当日日期</th>
	    <th>期初余额人民币</th>
	 	  <th>当天收入</th>
		  <th>当天支出</th>
		  <th>当日净额变化</th>
		  <th>当日余额人民币</th>
		  
<%

sqlstr = "select * from v_zh_xjye"+wherestr;

//out.print(sqlstr);
//out.print(orderstr);
rs=db.executeQuery(sqlstr); 

if (rs.next())
  {
     
	//获取记录总数
	rs.last();
	intRowCount = rs.getRow();
	
	//记算总页数
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;
	
	//调整待显示的页码
	if(intPage>intPageCount) intPage = intPageCount;
	
	if(intPageCount>0)
	//将记录指针定位到待显示页的第一条记录上
	   rs.absolute((intPage-1) * intPageSize + 1);
	
	//显示数据
	i=0;
		while(i<intPageSize && !rs.isAfterLast())
        {
%>
	  
      <tr class="cwDLRow" >
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr(rs.getString("id"))%>"></td>
		<td><a href="yemx_report.jsp?zh=<%=getDBStr(rs.getString("zh"))%>&zhmc=<%=getDBStr(rs.getString("zhmc"))%>" target="_blank"><%=getDBDateStr(rs.getString("drrq"))%></a></td>
		<td align="center"><%=getDBStr(rs.getString("qcyebb"))%></td>
		<td align="center"><%=getDBStr(rs.getString("dtsr"))%></td>
		<td align="center"><%=getDBStr(rs.getString("dtzc"))%></td>
		<%  
      total=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
      total1=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
%>
	   <td align="center"><%=getDBDecStr(total.subtract(total1))%></td>
		<td align="center"><%=getDBStr(rs.getString("dryebb"))%></td>
      </tr>
	
	 <script>btnAdd.style.display="none"</script>  

<%
       rs.next();
       i++;
	}
  }
rs.close(); 
db.close();
%>

    </table>
</form>


<div id="cwDataNav">
<form action="yermb_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKeyjlrq1" type="hidden" value="<%=searchKeyjlrq1%>">
<input name="searchKeyjlrq2" type="hidden" value="<%=searchKeyjlrq2%>">
<input name="czzhmc" type="hidden" value="<%=czzhmc%>">
<input name="czzh"  type="hidden" value="<%=czzh%>">
<input name="czid" type="hidden" value="<%=czid%>">
<table border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td>
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
	<%if(intPage>1){%>	<img style="cursor:pointer; " onClick="goPage('first')" src="../../images/quick_back.gif" alt="第一页" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('prev')" src="../../images/back.gif" alt="上一页" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/quick_back.gif" alt="最后页" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/back.gif" alt="最后页" width="19" height="19" border="0"><% } %>
	<%if(intPage<intPageCount){%> <img style="cursor:pointer; " onClick="goPage('next')" src="../../images/forward.gif" alt="下一页" width="19" height="19" border="0"> <img style="cursor:pointer; " onClick="goPage('last')" src="../../images/quick_forward.gif" alt="最后页" width="19" height="19" border="0">
	<%}else{%><img style="filter:Gray;" src="../../images/forward.gif" alt="最后页" width="19" height="19" border="0"> <img style="filter:Gray;" src="../../images/quick_forward.gif" alt="最后页" width="19" height="19" border="0"><% } %></td>
    <td>共<%=intRowCount%>条 第<%=intPage%>页/共<%=intPageCount%>页 </td>
    <td><img src="../../images/sbtn_split.gif"></td>
    <td>转到<input name="page" type="text" size="2">页<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" width="19" height="19" border="0" align="absmiddle"></td>
<!--     <td><img src="../../images/sbtn_split.gif"></td>
    <td>每页<input type="text" size="2">条<a href="#"><img src="../../images/ok.gif" alt="确定" width="19" height="19" border="0" align="absmiddle"></a></td>
 -->  </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->




</div>
<!-- end cwCellContent -->




</div>
<!-- end cwCell -->





<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>