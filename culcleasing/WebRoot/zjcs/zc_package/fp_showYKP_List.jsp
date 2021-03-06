<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>发票管理 - 电信发票列表</title>
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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs = null;
	String Zc_num = getStr(request.getParameter("Zc_num"));
	//发票抬头查询： 
	String Fp_tt =  getStr( request.getParameter("Fp_tt"));// "上海庞源建筑机械租赁有限公司"
	StringBuffer sql = new StringBuffer();
	sql.append(" select *  from fund_Assets_Invoice  where id in( select fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+Zc_num+"' )     ") ;
	String searchFld_tmp = "";
	if( !Fp_tt.equals("") && Fp_tt != null ) {
		sql.append(" and Fp_tt like '%"+Fp_tt+"%'  ");
	}
	sql.append("  order by  id  ") ;
	System.out.println("<><><><><><>====="+sql);
%>
<form name="searchbar" action="zc_list.jsp">
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			发票管理 &gt; 电信已开发票列表   
		</td>
	</tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
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
</td>
</tr>
</table>
<!--翻页控制结束-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>"/>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>发票抬头</th>
		<th>发票编号</th>
		<th>金额比例</th> 
		<th>发票金额</th> 
		<th>本金</th> 
		<th>利息</th>
		<th>开票时间</th> 
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_tt"))%></td>
		<td nowrap align="center" width=""><%= getDBStr(rs.getString("Fp_num"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_rate"))%>%</td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_countMoney"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_corpus"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_interest"))%></td>
		<td nowrap align="center" width=""><%= getDBDateStr( rs.getString("Kp_date"))%></td>
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
