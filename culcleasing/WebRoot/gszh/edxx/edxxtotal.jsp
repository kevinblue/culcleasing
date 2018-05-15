<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<!-- 05.002 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>公司帐户额度使用情况一览</title>
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
        <td id="cwCellTopTitTxt">公司帐户额度使用情况一览</td>
        <td id="cwCellTopTitRight"></td>
      </tr>
    </table>
	
<table id="cwCellToolbar" border="0" cellspacing="5" cellpadding="0" >
      <tr>
<%

String sqlstr;
String expsqlstr; 
ResultSet rs;
String wherestr=" WHERE sz is not null";
String kxmc="";

BigDecimal klje=new BigDecimal("0.00");
BigDecimal dfje=new BigDecimal("0.00");

String searchKeybm="";//部门
String searchKeybmdata="";
String searchKeyhy="";//业务板块
String searchKeygj="";//结算工具
String searchKeyqs1="";
String searchKeyqs2="";
String searchKeykl1="";
String searchKeykl2="";
String searchKeymc="";
String searchKeyyh="";//银行
String searchKeyyhdata="";

if (request.getParameter("searchKeybm")!=null && (request.getParameter("searchKeybm").equals("")==false))
{ 
   searchKeybm=getStr(request.getParameter("searchKeybm"));
   wherestr=wherestr+" and v_zj_edxx1.xmbmmc='"+searchKeybm+"' "; 
}

if (request.getParameter("searchKeyhy")!=null && (request.getParameter("searchKeyhy").equals("")==false))
{
   searchKeyhy=getStr(request.getParameter("searchKeyhy"));
   wherestr=wherestr+" and v_zj_edxx1.xmhy='"+searchKeyhy+"' "; 
}

if (request.getParameter("searchKeygj")!=null && (request.getParameter("searchKeygj").equals("")==false))
{
   searchKeygj=getStr(request.getParameter("searchKeygj"));
   wherestr=wherestr+" and v_zj_edxx1.jsfs='"+searchKeygj+"' "; 
}

if (request.getParameter("searchKeymc")!=null && (request.getParameter("searchKeymc").equals("")==false))
{
   searchKeymc=getStr(request.getParameter("searchKeymc"));
   wherestr=wherestr+" and v_zj_edxx1.xmmc like '%"+searchKeymc+"%' "; 
}

if (request.getParameter("searchKeyyh")!=null && (request.getParameter("searchKeyyh").equals("")==false))
{
   searchKeyyh=getStr(request.getParameter("searchKeyyh"));
   wherestr=wherestr+" and v_zj_edxx1.wsfkzh='"+searchKeyyh+"' "; 
}

//开立日
String rqstrkl1=request.getParameter("searchKeykl1");
String rqstrkl2=request.getParameter("searchKeykl2");
//到期日
String rqstrqs1=request.getParameter("searchKeyqs1");
String rqstrqs2=request.getParameter("searchKeyqs2");

//只填写开立的日期
if ((rqstrkl1!=null && rqstrkl1.equals("")==false) && (rqstrkl2!=null && rqstrkl2.equals("")==false) && (rqstrqs1==null || rqstrqs1.equals("")==true) && (rqstrqs2==null || rqstrqs2.equals("")==true))
{ 
   searchKeykl1=rqstrkl1;
   searchKeykl2=rqstrkl2;
   wherestr=wherestr+" and rq>='"+searchKeykl1+"' and rq<='"+searchKeykl2+"' and kxmc like '%开立%'"; 
}

//只填写兑付的日期
if ((rqstrqs1!=null && rqstrqs1.equals("")==false) && (rqstrqs2!=null && rqstrqs2.equals("")==false) && (rqstrkl1==null || rqstrkl1.equals("")==true) && (rqstrkl2==null || rqstrkl2.equals("")==true))
{
   searchKeyqs1=rqstrqs1;
   searchKeyqs2=rqstrqs2;
   wherestr=wherestr+" and rq>='"+searchKeyqs1+"' and rq<='"+searchKeyqs2+"' and kxmc like '%兑付%' and xmbh in (select xmbh from v_zj_edxx where klrq<='"+searchKeyqs2+"')";
}

//四个日期都填写
if ((rqstrkl1!=null && rqstrkl1.equals("")==false) && (rqstrkl2!=null && rqstrkl2.equals("")==false) && (rqstrqs1!=null && rqstrqs1.equals("")==false) && (rqstrqs2!=null && rqstrqs2.equals("")==false))
{
   searchKeykl1=rqstrkl1;
   searchKeykl2=rqstrkl2;
   searchKeyqs1=rqstrqs1;
   searchKeyqs2=rqstrqs2;

   wherestr=wherestr+" and rq>='"+searchKeyqs1+"' and rq<='"+searchKeyqs2+"' and (kxmc like '%兑付%' or kxmc like '%开立%') and xmbh in (select xmbh from v_zj_edxx where klrq>='"+searchKeykl1+"' and klrq<='"+searchKeykl2+"' and dfrq >='"+searchKeyqs1+"' and dfrq<='"+searchKeyqs2+"' and klhx='已核销' )"; 
}

expsqlstr="SELECT CONVERT(varchar(4), YEAR(rq))+'-'+CONVERT(varchar(2), MONTH(rq))+'-'+CONVERT(varchar(2), DAY(rq)) as 日期,xmbh as 项目编号,xmmc as 项目名称,xmhy as 项目行业,xmbmmc as 部门, kxmc as 款项名称,jsfs as 结算工具,sz as 金额  from v_zj_edxx1 "+wherestr;

%>	
        <form name="expform" action="../../func/exp.jsp" target="_blank" method="post">	  
          <td nowrap><input name="expsqlstr" type="hidden" value="<%=expsqlstr%>"><input name="expsubmit" type="submit" value="导出到EXCEL" style=" border:none;background-image:url(../../images/expExcel.gif); padding:2px 0px 0px 20px; height:20px; width:110px ">          </td>        </form>
		  <td><img src="../../images/sbtn_split.gif"></td>

        <form name="searchbar" action="edxxtotal.jsp">
	  <td nowrap> 开立日
            <input name="searchKeykl1" accesskey="r" type="text" size="9" value="<%=searchKeykl1%>" dataType="Date"><img  onClick="openCalendar(searchKeykl1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><br>
           至<input name="searchKeykl2" accesskey="q" type="text" size="9" value="<%=searchKeykl2%>" dataType="Date"><img  onClick="openCalendar(searchKeykl2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> </td>	
          <td nowrap> 到期日
            <input name="searchKeyqs1" accesskey="r" type="text" size="9" value="<%=searchKeyqs1%>" dataType="Date"><img  onClick="openCalendar(searchKeyqs1);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><br>
           至<input name="searchKeyqs2" accesskey="q" type="text" size="9" value="<%=searchKeyqs2%>" dataType="Date"><img  onClick="openCalendar(searchKeyqs2);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"> </td>
      <td nowrap> 板块
       <input name="searchKeyhy" type="text" size="8" value="<%=searchKeyhy%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 onclick="SpecialDataWindow('板块','v_xmjbxx_xmhy','xmhy','xmhy','xmhy','stringfld','xmhy','searchbar.searchKeyhy','searchbar.searchKeyhy');"><br>
        部门
        <input name="searchKeybmdata" type="text" size="15" value="<%=searchKeybm%>"><input name="searchKeybm" type="hidden" value="<%=searchKeybm%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer"
 onclick="SpecialDataWindow('事业部门','v_yh_zh','bmmc','bmmc','bmmc','stringfld','bmmc','searchbar.searchKeybmdata','searchbar.searchKeybm');"></td>
        <td nowrap>所属银行
       	<input name="searchKeyyhdata" type="text" size="15" value="<%=searchKeyyh%>"><input name="searchKeyyh" type="hidden" value="<%=searchKeyyh%>"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="SpecialDataWindow('银行','v_bankedzh','yhmc','khzh','khzh','stringfld','yhmc','searchbar.searchKeyyhdata','searchbar.searchKeyyh');"><br>
       结算工具<input name="searchKeygj" accesskey="s" type="text" size="10" value="<%=searchKeygj%>"></td>
    	<td nowrap>项目名称
       	<input name="searchKeymc" accesskey="s" type="text" size="20" value="<%=searchKeymc%>"><input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();"></td>
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
	 intPageSize = 15;
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
	    <th>结算工具</th>
	    <th>结算天数</th> 	
            <th>日期</th>
	    <th>部门</th>
	    <th>板块</th>	 	 
	    <th>项目名称</th>
	    <th>款项名称</th>
	    <th>银行</th>	
	    <th>兑付金额</th>
      </tr>

<%
sqlstr = "SELECT * FROM v_zj_edxx1 "+wherestr;
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
        <td align="center"><%=getDBStr(rs.getString("jsfs"))%></td>
	<%
        if (getDBDecStr(rs.getBigDecimal("klts",0)).compareTo(new BigDecimal(0.00))==0)
        {
        %>
 	<td align="left" nowrap></td>
	<%
        }
	else
        { 
        %>
     <td align="left" nowrap><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("klts",0))%></td>
        <%
        }
        %>  
        <td align="center"><%=getDBDateStr(rs.getString("rq"))%></td>
	<td align="center"><%=getDBStr(rs.getString("xmbmmc"))%></td> 
	<td align="center"><%=getDBStr(rs.getString("xmhy"))%></td>	
        <td align="center"><%=getDBStr(rs.getString("xmmc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("kxmc"))%></td>	
	<td align="center"><%=getDBStr(rs.getString("wsfkyh"))%></td>	
	<td align="center"><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("sz",2))%></td>
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
<form name="dataNav" action="edxxtotal.jsp">
<input name="searchKeykl1" type="hidden" value="<%=searchKeykl1%>">
<input name="searchKeykl2" type="hidden" value="<%=searchKeykl2%>">
<input name="searchKeyqs1" type="hidden" value="<%=searchKeyqs1%>">
<input name="searchKeyqs2" type="hidden" value="<%=searchKeyqs2%>">
<input name="searchKeygj" type="hidden" value="<%=searchKeygj%>">
<input name="searchKeyhy" type="hidden" value="<%=searchKeyhy%>">
<input name="searchKeybm" type="hidden" value="<%=searchKeybm%>">
<input name="searchKeymc" type="hidden" value="<%=searchKeymc%>">
<input name="searchKeyh" type="hidden" value="<%=searchKeyyh%>">

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
      <th>开立金额</th>
      <th>兑付金额</th>
    </tr>
      <tr align="center" class="cwDLRow" >
<%
sqlstr = "SELECT sum(sz) as klze FROM v_zj_edxx1 "+wherestr+" and kxmc like '%开立%' group by xgr";
rs=db.executeQuery(sqlstr); 
if (rs.next()) {
%>
      <td><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("klze",2))%></td>
<%
}
sqlstr = "SELECT sum(sz) as dfze FROM v_zj_edxx1 "+wherestr+" and kxmc like '%兑付%' group by xgr";
rs=db.executeQuery(sqlstr); 
if (rs.next()) {
%>
      <td><%=(BigDecimal)getDBDecStr(rs.getBigDecimal("dfze",2))%></td>
<%
}
rs.close(); 
db.close();
%>
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
