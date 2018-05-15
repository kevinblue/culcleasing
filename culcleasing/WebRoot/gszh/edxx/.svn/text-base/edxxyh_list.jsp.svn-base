<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>各银行帐户额度信息一览</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>


</head>
<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">资金集中管理</td>
      <td id="cwTopTitRight"></td>
    </tr>
</table>  
</div>
<!-- end cwTop -->



<div id="cwCell">

<div id="cwCellTop">

	<table id="cwCellTopTit" width="100%" border="0" cellpadding="0" cellspacing="0" >
      <tr>
        <td id="cwCellTopTitLeft"></td>
        <td id="cwCellTopTitTxt">各银行帐户额度信息一览</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<%
String sqlstr;
ResultSet rs;
String wherestr=" where 1=1 ";
BigDecimal total1=new BigDecimal("0.00");
BigDecimal total2=new BigDecimal("0.00");
String searchKey1="";//日期1
String searchKey2="";//日期2

String sDate=getSystemDate(0); 
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date date = sdf1.parse(sDate);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String sResult = sdf2.format(date);

String rqstr1=request.getParameter("searchKey1");
String rqstr2=request.getParameter("searchKey2");
if ((rqstr1==null) && (rqstr2==null))
{	searchKey1=sResult;
	rqstr1=sResult;
}

if (((rqstr1!=null) && (rqstr1.equals("")==false)) && ((rqstr2==null) || (rqstr2.equals(""))))
{
   searchKey1=rqstr1;
   wherestr=wherestr+" and v_bankedzh1.szrq >= '"+searchKey1+"' "; 
}

if (((rqstr2!=null) && (rqstr2.equals("")==false)) && ((rqstr1==null) || (rqstr1.equals(""))))
{  
   searchKey2=rqstr2;
   wherestr=wherestr+" and v_bankedzh1.szrq  <= '"+searchKey2+"' "; 
}
if (((rqstr1!=null) && (rqstr1.equals("")==false)) && ((rqstr2!=null) && (rqstr2.equals("")==false)))
{  
   searchKey1=rqstr1;
   searchKey2=rqstr2;
   wherestr=wherestr+" and v_bankedzh1.szrq  >= '"+searchKey1+"' and v_bankedzh1.szrq  <= '"+searchKey2+"' "; 
}

%>        
 <form name="searchbar" action="edxxyh_list.jsp">
 <td nowrap>日期1 　
      <input name="searchKey1" accesskey="r" type="text" size="9" value="<%=rqstr1%>" dataType="Date"><img  onClick="openCalendar(searchKey1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
日期2 　
       <input name="searchKey2" accesskey="q" type="text" size="9" value="<%=searchKey2%>" dataType="Date"><img  onClick="openCalendar(searchKey2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp&nbsp<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align=absmiddle"  onclick="searchbar.submit();"></td>
         </td>

        <br>
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
            <th>帐号简称</th>
            <th>帐号</th>
            <th>期初额度</th>
	    <th>目前可用额度</th>
	    <th>日期</th>	
	    <th>该日余额</th>	
            <th>该日发生金额</th>
      </tr>

<%
sqlstr = "SELECT * FROM v_bankedzh1 "+wherestr+" order by szrq,yhmc"; 
//out.print(sqlstr);
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
        <td align="center"><%=getDBStr(rs.getString("zhmc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("khzh"))%></td>
	<td align="left" nowrap><a href="../edxx/edxx_list.jsp?czid=<%=getDBStr(rs.getString("khzh"))%>" target="_blank"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("sxed",2))%></a></td>
        <td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("kyed",2))%></td>
	<td align="center"><%=getDBDateStr(rs.getString("szrq"))%></td>
	<td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("zhye",2))%></td>
	<td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("fsje",2))%></td>
      </tr>
	  
<%
       rs.next();
       i++;
	}
  }
%>
    </table>
</form>
<div id="cwDataNav" >
<form name="dataNav" action="edxxyh_list.jsp">
<input name="searchKey1" type="hidden" value="<%=searchKey1%>">
<input name="searchKey2" type="hidden" value="<%=searchKey2%>">
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
    <td>转到<input name="page" type="text" onChange="this.value=this.value.replace(/\D/g,'')" onKeyPress="if(event.keyCode == 13){this.blur();goPage('jump');}" size="2"  >页<img style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" width="19" height="19" border="0" align="absmiddle"></td>
    <td style="display:none "><img src="../../images/sbtn_split.gif"></td>
    <td style="display:none ">每页<input type="text" size="2">条<a href="#"><img src="../../images/ok.gif" alt="确定" width="19" height="19" border="0" align="absmiddle"></a></td>
  </tr>
</table>
</form>
</div>
<!-- end cwDataNav -->



</div>
<!-- end cwCellContent -->


<div id="cwCellContent2">
<table class="cwDataList" width="100%"  border="0"  align="center" cellpadding="2" cellspacing="1" >
      <tr class="cwDLHead">
<%
  sqlstr = "SELECT sum(sxed) as total1,sum(kyed) as total2 FROM v_bankedzh group by zhlx"; 
  rs=db.executeQuery(sqlstr); 
  if (rs.next()) {
    total1=(BigDecimal)getDBDecStr(rs.getBigDecimal("total1",2));
    total2=(BigDecimal)getDBDecStr(rs.getBigDecimal("total2",2));
  }
  rs.close(); 
  db.close();
%>
      <th>期初余额总额</th>
      <th>目前可用余额总额</th>
    </tr>
      <tr align="center" class="cwDLRow" >
      <td><%=formatNumberStr(total1.toString())%></td>
      <td><%=formatNumberStr(total2.toString())%></td>
      </tr>
  </table>
</div>

</div>
<!-- end cwCell -->





<div id="cwToolbar">
<input class="btn" name="btnClose" value="关闭" type="button" onClick="window.close()">
</div>
<!-- end cwToolbar -->

</div>
<!-- end cwMain -->
</body>
</html>
