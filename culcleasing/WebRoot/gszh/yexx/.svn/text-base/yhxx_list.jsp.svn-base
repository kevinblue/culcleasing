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
<title>每日银行收支一览 - 资金信息管理</title>
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

BigDecimal bz1=new BigDecimal("0.00");
BigDecimal bz2=new BigDecimal("0.00");
BigDecimal bz3=new BigDecimal("0.00");
BigDecimal bz4=new BigDecimal("0.00");
BigDecimal bz5=new BigDecimal("0.00");
BigDecimal bz11=new BigDecimal("0.00");
BigDecimal bz21=new BigDecimal("0.00");
BigDecimal bz31=new BigDecimal("0.00");
BigDecimal bz41=new BigDecimal("0.00");
BigDecimal bz51=new BigDecimal("0.00");

%>


<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">每日银行收支一览</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>

<%


String sDate=getSystemDate(0); 
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf1.parse(sDate);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String sResult = sdf2.format(date);


String wherestr="";
String searchKeyjlrq1="";//记录日期1
 wherestr=" where (1=1)";

String rqstr1=request.getParameter("searchKeyjlrq1");

if ((rqstr1==null))
{	searchKeyjlrq1=sResult;
	rqstr1=sResult;
}
   searchKeyjlrq1=rqstr1;
if ((searchKeyjlrq1==null) || (searchKeyjlrq1.equals("")))
{
}
else
{
    wherestr = wherestr+" and (drrq='"+searchKeyjlrq1+"') "; 
}

expsqlstr="select yhmc 银行名称,drrq 当日日期,qcyebb 期初余额人民币,qcyewb 期初余额外币,kyed 可用额度 from v_zhmx1"+wherestr+" order by drrq";
 
%>

<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
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
        <form name="searchbar" action="yhxx_list.jsp">
        	<td nowrap>日期<input name="searchKeyjlrq1" accesskey="r" type="text" size="9" value="<%=rqstr1%>" dataType="Date"><img  onClick="openCalendar(searchKeyjlrq1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			 <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
       
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
	   
	    <th>银行名称</th>
		<th>日期</th>
	    <th>可用额度</th>
	    <th>期初余额人民币</th>
	 	<th>期初余额外币</th>
		 
<%

sqlstr = "select * from v_zhmx1"+wherestr;

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
        
        <td align="center"><%=getDBStr(rs.getString("yhmc"))%></td>
        <td align="center"><%=getDBDateStr(rs.getString("drrq"))%></td>
		<td align="center"><%=getDBStr(rs.getString("kyed"))%></td>
		<td align="center"><%=getDBStr(rs.getString("qcyebb"))%></td>
		<td align="center"><%=getDBStr(rs.getString("qcyewb"))%></td>
	
		
<%
  //    total=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
  //    total1=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
%>
	  
<%
    //       bz1=(BigDecimal)getDBDecStr(rs.getBigDecimal("qcyebb",2));
  //      bz11=bz11.add(bz1);
//		bz2=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtsr",2));
     //   bz21=bz21.add(bz2);
	//	  bz3=(BigDecimal)getDBDecStr(rs.getBigDecimal("dtzc",2));
      //  bz31=bz31.add(bz3);
		//  bz4=(BigDecimal)getDBDecStr(total);
      //  bz41=bz31.subtract(bz21);
	//	bz5=(BigDecimal)getDBDecStr(rs.getBigDecimal("dryebb",2));
  //      bz51=bz51.add(bz5);
%>
     		
     


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
<form action="yhxx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="searchKeyjlrq1" type="hidden" value="<%=searchKeyjlrq1%>">

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