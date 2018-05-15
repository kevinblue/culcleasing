<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="dbconn.*" %> 
<%@page import="com.condition.ZC_Package"%> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产包管理 - 已被打包的资产信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<script type="text/javascript">
	function check_input(){
		var inputs = document.getElementsByTagName("input");
		for(var i = 0;i<inputs.length;i++){
			if(inputs[i].type=="text"){
				if(inputs[i].value.indexOf("\'")>=0){
					alert("\' 是非法字符");
					return false;
				}
			}
		}
	}
	//非法字符验证
	function isValidStr(str,name,name_name){
	    if(str.indexOf("\\") != -1)
	    {
	       alert( name+ "的输入不能包含反斜杠\符号！");
	       document.getElementById(name_name).value = "";
	       return false;
	    }
	    var ignoreStr="'\"（）()<>#$%^&*+";
	    for(i=0;i<str.length;i++){
	         if(ignoreStr.indexOf(str.substring(i,i+1)) != -1)
	         {
	            alert( name+"的输入不能包含'和\"以<>#$%^&*+括号等符号，请重新输入！");
		        document.getElementById(name_name).value = "";
	            return false;
	          }
	     }
	    return true;
	} 

</script>
<%
	//根据后台类生成资产编号
	ZC_Package zc_Package = new ZC_Package();
	String zc_num = zc_Package.get_Id();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs = null;
	//承租人查询： 
	String Zc_num = getStr(request.getParameter("Zc_num"));
	String UserName = getStr(request.getParameter("UserName"));
	String status = getStr(request.getParameter("status"));
	StringBuffer sql = new StringBuffer();
	sql.append("select f.Chjx_id,f.Contract_id,f.Zc_num,f.Rent_list,frp.plan_date,frp.rent,frp.corpus,frp.interest ")
		.append("       ,fa.status,fa.UserName,f.Caertor_date ")
		.append(" from  fund_Assets_rent_Corresponding as f  ")
		.append(" left join fund_rent_plan as frp on frp.id = f.Chjx_id and frp.contract_id = f.Contract_id ")
		.append(" left join fund_Assets_Package as fa on fa.Zc_num = f.Zc_num ")
		.append("  where f.Zc_num = '"+Zc_num+"' ")
		.append(" order by  f.Chjx_id");
	System.out.println("<><><><><><>====="+sql);
%>
<form name="searchbar" action="zc_list.jsp">
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			资产包管理 &gt; 已被打包的资产信息
		</td>
	</tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr>
		<td>资产包编号:<%=Zc_num%>&nbsp;&nbsp;承租人:<%=UserName %>&nbsp;&nbsp;资产包状态:<%=status %></td>
	</tr>

<tr class="maintab">
<td align="right" width="90%">
<!--翻页控制开始-->
<% 
	int intPageSize = 50;   //一页显示的记录数
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
	rs = db.executeQuery(sql.toString()); 
	rs.last();                                      //获取记录总数
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
		var nf = document.searchbar;
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
</form>
</td>
</tr>
</table>
<!--翻页控制结束-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
<form action="zc_list.jsp" name="form1">
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>编号</th>
		<th>合同号</th>
		<th>期次</th> 
		<th>偿还日期</th> 
		<th>租金</th> 
		<th>本金</th> 
		<th>利息</th>
		<th>资产包创建日期</th>
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("Chjx_id") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr(rs.getString("contract_id"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td nowrap align="center" width=""><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("rent") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("corpus") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("interest") ) %></td>
		<td nowrap align="center" width=""><%= getDBDateStr( rs.getString("Caertor_date") ) %></td>
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
</div>
<!--报表结束-->
</body>
</html>
