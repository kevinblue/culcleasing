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
if (right.CheckRight("inspecter-jxkcnb-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>考察人员绩效 - 绩效年报</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script>
	function searchInfo(){
		document.getElementById("searchInfo").submit();
	}
	function init(){
		
		var time=new Date();
		var nowYear=time.getYear();
		var searchYear=document.getElementById("searchYear");
		for(var i=nowYear;i>2000;i--){
			var o=new Option(i,i);
			searchYear.options.add(o);
		}
	}
	function selectDefault(demo,str){
		var t=document.getElementById(demo);
		if(str!=""){		
			for(var i=0;i<t.options.length;i++){
				if(t.options[i].value==str){
					t.options[i].selected=true;
					break;
				}
			}
		}
	}
</script>
</head>

<body  onload="public_onload(0)">
<form action="jxnb_list.jsp" name="dataNav" onSubmit="return goPage()">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				考察人员绩效 &gt; 绩效年报</td>
			</tr>
</table>
<%

String findName=getStr( request.getParameter("searchName") );
String findMonth=getStr( request.getParameter("searchMonth") );
String findYear=getStr( request.getParameter("searchYear") );
String cust_id = getStr( request.getParameter("cust_id") );
ResultSet rs;
String wherestr = " where 1=1";
if(!findYear.equals("")){
	wherestr+=" and year(inspect_begintime)="+findYear+" ";
}
if ( !cust_id.equals("") ){
	wherestr = wherestr + " and cust_id='" + cust_id + "'";
}
if(findName!="" && findName!=null){
	wherestr = wherestr + " and inspecter like '%" + findName + "%' ";
}
if(!findMonth.equals("0") && findMonth!=null && !findMonth.equals("")){
	wherestr = wherestr + " and month(inspect_begintime)="+findMonth+" ";
}else {
	wherestr = wherestr + " ";
}
String sqlstr = "select inspecter,inspect_month=month(inspect_begintime),inspectCount=count(inspect_id),"+
		"marksAvg=sum(inspect_marks)/count(inspect_id),"+
		"bhgCount=count(case when cast(cast(inspect_endtime as datetime)-cast(inspect_begintime as datetime) as int)>3 then inspect_id end),"+
		"tskcs=count(case when special_inspect=1 then special_inspect end)"+
		"from inspect_info "+ wherestr+
		" group by month(inspect_begintime),inspecter"; 

%>
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left">
					&nbsp;&nbsp;考察员<input name="searchName" accesskey="s" type="text" size="15" value="<%=findName %>">
					&nbsp;&nbsp;年份
					<select name="searchYear" id="searchYear">
						
					</select>
					&nbsp;&nbsp;月份
					<select name="searchMonth" id="searchMonth">
						<option value="0"></option>
						<option value="1">一月</option>
						<option value="2">二月</option>
						<option value="3">三月</option>
						<option value="4">四月</option>
						<option value="5">五月</option>
						<option value="6">六月</option>
						<option value="7">七月</option>
						<option value="8">八月</option>
						<option value="9">九月</option>
						<option value="10">十月</option>
						<option value="11">十一月</option>
						<option value="12">十二月</option>
					</select>
					<script>
						window.onLoad=init();
						selectDefault("searchYear","<%=findYear %>");
						selectDefault("searchMonth","<%=findMonth %>");
					</script>
					&nbsp;<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchInfo();">
				</td>
			
<td align="right">
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
	intPageCount = (intRowCount+intPageSize-1) / intPageSize;   //记算总页数
	if(intPage>intPageCount) intPage = intPageCount;            //调整待显示的页码
	if(intPageCount>0)
	   rs.absolute((intPage-1) * intPageSize + 1);              //将记录指针定位到待显示页的第一条记录上
	int i = 0; %>

<input type="hidden" name="cust_id" value="<%=cust_id%>">
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
		 <th>考察员</td>
		 <th>月份</th>
		 <th>考察项目数量</th>
		 <th>平均得分</th>
		 <th>考察绩效</th>
		 <th>特殊考察绩效</th>
		 <th>总绩效</th>
      </tr>
	  
<%

if(intRowCount!=0){
	while(i<intPageSize && !rs.isAfterLast()){
		double kczl=0;		//考察质量
		int xmzs=0;			//项目数量
		double marksAvg=0;	//平均考察分
		int bhgCount=0;	//不合格的数量
		double hgbl=0;		//合格比例
		double timing=0;	//时效评分
		double kcyj=0;		//考察业绩
		int tskcs=0;		//特殊考察数
		xmzs=rs.getInt("inspectCount");
		marksAvg=rs.getDouble("marksAvg");
		bhgCount=rs.getInt("bhgCount");
		
		tskcs=rs.getInt("tskcs");
		
		if(marksAvg<2){
			kczl=-0.5;
		}else if(marksAvg>=2 && marksAvg<3){
			kczl=0;
		}else if(marksAvg>=2 && marksAvg<3){
			kczl=0;
		}else if(marksAvg>=3 && marksAvg<3.5){
			kczl=0.5;
		}else if(marksAvg>=3.5 && marksAvg<4){
			kczl=1;
		}else if(marksAvg>=4){
			kczl=1.5;
		}
		
		hgbl=(1-((double)bhgCount/xmzs))*100;
		
		if(hgbl<70){
			timing=-0.5;
		}else if(hgbl>=70 && hgbl<80){
			timing=0;
		}else if(hgbl>=80 && hgbl<90){
			timing=0.5;
		}else if(hgbl>=90 && hgbl<100){
			timing=1;
		}else if(hgbl==100){
			timing=1.5;
		}
		kcyj=20*xmzs*(kczl+timing+1);
%>
	  
      <tr class="cwDLRow" >
		<td align="center"><%=getDBStr( rs.getString("inspecter") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("inspect_month") ) %></td>
		<td align="center"><%=xmzs %></td>
		<td align="center"><%=formatNumberDoubleTwo(marksAvg) %></td>
		<td align="center"><%=kcyj %></td>
		<td align="center"><%=tskcs*20 %></td>
		<td align="center"><%=kcyj+tskcs*20 %></td>
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
