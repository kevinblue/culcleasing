<%@ page contentType="text/html; charset=gbk" language="java" %>

<%
int intPageSize = 15;   //一页显示的记录数
int intRowCount = 0;   //记录总数
int intPageCount = 1; //总页数
int intPage;       //待显示页码

String pageSize = getStr( request.getParameter("pageSize") );          //取得一页显示的记录数
if( pageSize.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
   intPageSize = 50;
}else{
   intPageSize = java.lang.Integer.parseInt(pageSize);
} 

String strPage = getStr( request.getParameter("page") );          //取得待显示页码
if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
   intPage = 1;
}else{
   intPage = java.lang.Integer.parseInt(strPage);
   if(intPage<1) intPage = 1;
} 

rs = db.executeQuery(countSql); 

if(rs.next()){                                               
	intRowCount = rs.getInt("amount");	//获取记录总数
}else{
	intRowCount = 0;
}

intPageCount =  intRowCount / intPageSize + 1 ;   //记算总页数
if( intPage > intPageCount ) intPage = intPageCount;             //调整待显示的页码
%>

<!-- 分页开始 -->
<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">  
    <td nowrap>共 <b style="color:#E46344;"><%=intRowCount%></b> 条 / <b style="color:#E46344;"><%=intPageCount%></b> 页 
	每页
	<select name="pageSize" style="border:none;height:15px;" onchange="dataNav.submit();">
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
		<option value="30">30</option>
		<option value="50">50</option>
		<option value="100">100</option>
		<option value="300">300</option>
	</select>
	条
	<script>
		var cp = <%=intPage %>;
		var lp = <%=intPageCount %>;
		var nf = document.dataNav;
		$("select[name='pageSize']").val(<%=intPageSize %>);
	</script>
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
		
    <td nowrap>转到 <input name="page" type="text" size="2" value="<%=intPage %>"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
</tr>
</table> <!-- 分页结束 -->
