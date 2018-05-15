<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>额度平衡表总体</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>


</head>
<body>

<div id="cwMain" >


<div id="cwTop">
<table id="cwTopTit" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td id="cwTopTitLeft"></td>
      <td id="cwTopTitTxt">额度平衡表总体</td>
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
        <td id="cwCellTopTitTxt">额度平衡表总体</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<%
String sqlstr;
String expsqlstr; 
ResultSet rs;
String wherestr="";
wherestr=" WHERE xmbh IN (SELECT xmbh FROM v_zj_edxx WHERE klrq >= '2006-1-1')";

String searchKeyqs1="";
String searchKeyqs2="";

String rqstrqs1=request.getParameter("searchKeyqs1");
String rqstrqs2=request.getParameter("searchKeyqs2");

if (((rqstrqs1!=null) && (rqstrqs1.equals("")==false)) && ((rqstrqs2==null) || (rqstrqs2.equals(""))))
{  
   searchKeyqs1=rqstrqs1;
   wherestr=wherestr+" and rq >= '"+searchKeyqs1+"' "; 
}

if (((rqstrqs2!=null) && (rqstrqs2.equals("")==false)) && ((rqstrqs1==null) || (rqstrqs1.equals(""))))
{  
   searchKeyqs2=rqstrqs2;
   wherestr=wherestr+" and rq <= '"+searchKeyqs2+"' "; 
}
if (((rqstrqs1!=null) && (rqstrqs1.equals("")==false)) && ((rqstrqs2!=null) && (rqstrqs2.equals("")==false)))
{  
   searchKeyqs1=rqstrqs1;
   searchKeyqs2=rqstrqs2; 
   wherestr=wherestr+" and rq >= '"+searchKeyqs1+"' and rq <= '"+searchKeyqs2+"' "; 
}
   
expsqlstr="SELECT v_zj_edxx1.jsfs AS 结算工具,v_zj_edxx1.rq AS 日期,v_zj_edxx1.xmmc as 项目名称,v_zj_edxx1.xmbmmc as 部门名称,v_zj_edxx1.xmhy as 项目行业,v_zj_edxx1.kxmc as 款项名称,v_zj_edxx1.sz as 金额,v_zj_edxx1.bqmed as 本期末额度 from v_zj_edxx1 "+wherestr;

%>
        <form name="expform" action="../../func/exp.jsp" target="_blank" method="post">
          <td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>"><input name="expsubmit" type="submit" value="导出到EXCEL" style=" border:none;background-image:url(../../images/expExcel.gif); padding:2px 0px 0px 20px; height:20px; width:110px ">          </td>        </form>
		  <td><img src="../../images/sbtn_split.gif"></td>

        <form name="searchbar" action="edphb.jsp">
	  <td nowrap> 到期日
          <input name="searchKeyqs1" accesskey="r" type="text" size="9" value="<%=searchKeyqs1%>" dataType="Date"><img  onClick="openCalendar(searchKeyqs1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
          至<input name="searchKeyqs2" accesskey="q" type="text" size="9" value="<%=searchKeyqs2%>" dataType="Date"><img  onClick="openCalendar(searchKeyqs2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
          &nbsp;&nbsp;&nbsp;<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
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
	    <th>日期</th>
	    <th>部门</th>
 	    <th>项目名称</th>
	    <th>款项名称</th>
	    <th>结算工具</th>
	    <th>金额</th>
	    <th>本期末额度</th>
      </tr>

<%
sqlstr = "SELECT * FROM v_zj_edxx1 "+wherestr+" order by rq,xmmc";
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
        <td align="center"><%=getDBDateStr(rs.getString("rq"))%></td>
	<td align="center"><%=getDBStr(rs.getString("xmbmmc"))%></td> 
        <td align="center"><%=getDBStr(rs.getString("xmmc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("kxmc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("jsfs"))%></td>
	<%
        if (getDBDecStr(rs.getBigDecimal("sz",2)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
         <td align="left" nowrap></td>
        <%
        }
        else
        { 
        %>
	<td align="center"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("sz",2))%></td>
	 <%
        }
        if (getDBDecStr(rs.getBigDecimal("bqmed",2)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
     <td align="left" nowrap></td>
        <%
        }
        else
        { 
        %>
     <td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("bqmed",2))%></td>
        <%
        }
        %>  
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
</form>
<div id="cwDataNav" >
<form name="dataNav" action="edphb.jsp">
<input name="searchKeyqs1" type="hidden" value="<%=searchKeyqs1%>">
<input name="searchKeyqs2" type="hidden" value="<%=searchKeyqs2%>">
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
