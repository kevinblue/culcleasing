<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("zdkk-zdkkjl-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>主动扣款信息信息列表 - 主动扣款信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String searchKeyName = getStr( request.getParameter("searchKeyName") );
String searchKeyDate = getStr( request.getParameter("searchKeyDate") );
String searchtype = getStr( request.getParameter("searchtype") );
ResultSet rs;
String where="";
if(!searchKeyDate.equals("")){
	where="  and createdate<='"+searchKeyDate+"' ";
}
if(!searchKeyName.equals("")){
	where="  and creator like '%"+searchKeyName+"%' ";
}
if(!searchtype.equals("3")&&!searchtype.equals("")){
	where="  and type ='"+searchtype+"' ";
}
String sqlstr = "select id,(case type when 1 then '导出' else '导入' end) as type,dbo.getusername(creator) as creator,createdate,addr,remark,is_verification from rent_list  where 1=1 "+where +" order by createdate desc";
System.out.println(sqlstr);
 %>
<body style="border:1px solid #8DB2E3;">
<form action="zdkkjl_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt"> 主动扣款信息  &gt; 主动扣款信息列表</td>
  </tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr><td colspan="2">
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left">
      &nbsp;按操作人&nbsp;
        <input name="searchKeyName" accesskey="s" type="text" size="15" value="<%= searchKeyName %>">
        按操作日期:
        <input name="searchKeyDate" accesskey="s" type="text" size="15" readonly value="<%= searchKeyDate %>">
        <img  onClick="openCalendar(searchKeyDate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><input type="radio" name="searchtype" <%if(searchtype.equals("3")||searchtype.equals(""))out.print("checked");%> value="3">查看全部<input type="radio"  <%if(searchtype.equals("1"))out.print("checked");%>   name="searchtype" value="1">查看导出<input type="radio"  <%if(searchtype.equals("0"))out.print("checked");%>  name="searchtype" value="0">查看导入
        <input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">

        </td>
    </tr>
  </table>
</td>
</tr>
      <tr class="maintab">
        <td align="left">(提示:点击文件名下载查看该文件)</td>
        <td align="right" width="60%"><!--翻页控制开始-->
          <% 
	int intPageSize = 16;   //一页显示的记录数
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
rs = db.executeQuery(sqlstr); 

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
		var nf = document.dataNav;
	</script>
              <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
                <%if(intPage>1){%>
                <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
                <%}else{%>
                <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
                <% } %>
                第 <font color="red"><%=intPage%></font> 页
                <%if(intPage<intPageCount){%>
                <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
                <%}else{%>
                <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
                <% } %></td>
              <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
              <td nowrap>转到
                <input name="page" type="text" size="2" value="1">
                页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0"></td>
            </tr>
          </table></td>
      </tr>
    </table>
    <!--翻页控制结束-->
    <!--
</form>
<form name="list">
-->
    <!--报表开始-->
    <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
      <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
        <tr class="maintab_content_table_title">
          <th>可操作选项</th>
          <th>文件名</th>
          <th>操作类型</th>
          <th>操作人</th>
          <th>操作日期</th>
          <th width="50%">备注</th>
        </tr>
        <%
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
        <tr>
        <td>
		<%
		String id=getDBStr(rs.getString("id"));
		String type=getDBStr(rs.getString("type"));
		String is_verification=getDBStr(rs.getString("is_verification"));
			if(type.equals("导入")){
				if(is_verification.equals("0")){
				out.print("<a href=\"zdkkjl_save.jsp?id="+id+"\">核销</a>");
				}else if(is_verification.equals("2")){
					out.print("空文件");	
				}else{
					out.print("已核销过");	
				}
			}else{
				out.print("仅查看");
			}
		%>
        </td>
		<td><a href="zdkkjl_out.jsp?id=<%=id%>"><%=getDBStr(rs.getString("addr"))%></a></td>
        <td><%=type%></td>
        <td><%=getDBStr(rs.getString("creator"))%></td>
        <td><%=getDBDateStr(rs.getString("createdate"))%></td>
        <td><%=getDBStr(rs.getString("remark"))%></td>
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
    <!--报表结束-->
    </form>
</body>
</html>
