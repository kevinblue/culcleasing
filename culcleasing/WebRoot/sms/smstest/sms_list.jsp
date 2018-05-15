<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*,com.service.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ include file="../../func/sms_common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("sms-smstest-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------以上为权限控制--------
String context = request.getContextPath();
SMSThread sms = (SMSThread)session.getAttribute("thread");
String searchKey = getStr(request.getParameter("searchKey"));
String searchType = getStr(request.getParameter("searchType"));
String searchDel = getStr(request.getParameter("searchDel"));
String searchPhone = getStr(request.getParameter("searchPhone"));
//String searchAddTime = getStr(request.getParameter("searchAddTime"));
//[START]
String searchAddTimeBegin = getStr(request.getParameter("searchAddTimeBegin"));
String searchAddTimeEnd = getStr(request.getParameter("searchAddTimeEnd"));
//[END]
//String searchActualTime = getStr(request.getParameter("searchActualTime"));
//[START]
String searchActualTimeBegin = getStr(request.getParameter("searchActualTimeBegin"));
String searchActualTimeEnd = getStr(request.getParameter("searchActualTimeEnd"));
//[END]
//String searchPerformTime = getStr(request.getParameter("searchPerformTime"));
//[START]
String searchPerformTimeBegin = getStr(request.getParameter("searchPerformTimeBegin"));
String searchPerformTimeEnd = getStr(request.getParameter("searchPerformTimeEnd"));
if(sms!=null){
if(!sms.isAlive()){
 %>
 
 <script language="javascript">
 alert("短信发送完成");
 </script>
 <%session.setAttribute("thread",null);

 }else{
 %>
 <META HTTP-EQUIV="refresh" CONTENT="5;URL=./sms_list.jsp?searchKey=<%=searchKey %>&searchType=<%=searchType %>&searchPhone=<%=searchPhone %>&searchAddTimeBegin=<%=searchAddTimeBegin %>&searchAddTimeEnd=<%=searchAddTimeEnd %>&searchActualTimeBegin=<%=searchActualTimeBegin %>&searchActualTimeEnd=<%=searchActualTimeEnd %>&searchPerformTimeBegin=<%=searchPerformTimeBegin %>&searchPerformTimeEnd=<%=searchPerformTimeEnd %>">
 <%
 }} %>
<title>短信发送平台 - 短信发送平台</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body style="border:1px solid #8DB2E3;">
<form action="sms_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				短信发送平台 &gt; 短信发送平台</td>
			</tr>
</table>
<!--标题结束-->
<%
ResultSet rs = null;
String sql = "";
String strwhere = "";
strwhere=" where 1=1 ";

//[END]
if(searchKey!=null&&!searchKey.equals("")){
	if(searchKey.equals("全部")){
	
	}else if(searchKey.equals("待发送")){
		strwhere +=" and perform_flag<=0 ";
	}else if(searchKey.equals("已发送成功")){
		strwhere +=" and perform_flag>0 ";
	}else if(searchKey.equals("发送中")){
		strwhere +=" and perform_flag=0 and perform_time is not null and actual_time is null ";
	}else if(searchKey.equals("发送失败")){
		strwhere +=" and perform_flag<0 ";
	}else if(searchKey.equals("未发送")){
		strwhere +=" and perform_flag=0 and perform_time is null";
	}
}else{
	searchKey = "待发送";
	strwhere +=" and perform_flag<=0 ";
}
if(searchType!=null&&!searchType.equals("")){
	strwhere +=" and type='"+searchType+"'";
}
if(searchDel!=null&&!searchDel.equals("")){
 	if(!searchDel.equals("-1")){
		strwhere +=" and delete_flag='"+searchDel+"'";
	}
}else{
	searchDel="有效";
	strwhere +=" and delete_flag='0'";
}
if(searchPhone!=null&&!searchPhone.equals("")){
	strwhere +=" and mobile_phone like '%"+searchPhone+"%'";
}
//if(searchAddTime!=null&&!searchAddTime.equals("")){
//	strwhere +=" and convert(char(10),add_time,21) = '"+searchAddTime+"'";
//}
//选择添加时间范围 [START]
if(searchAddTimeBegin!=null&&!searchAddTimeBegin.equals("")){
	strwhere +=" and convert(char(10),add_time,21) >= '"+searchAddTimeBegin+"'";
}
if(searchAddTimeEnd!=null&&!searchAddTimeEnd.equals("")){
	strwhere +=" and convert(char(10),add_time,21) <= '"+searchAddTimeEnd+"'";
}
//选择添加时间范围 [END]

//if(searchActualTime!=null&&!searchActualTime.equals("")){
//	strwhere +=" and convert(char(10),actual_time,21) = '"+searchActualTime+"'";
//}
//选择实际发送时间范围 [START]
if(searchActualTimeBegin!=null&&!searchActualTimeBegin.equals("")){
	strwhere +=" and convert(char(10),actual_time,21) >= '"+searchActualTimeBegin+"'";
}
if(searchActualTimeEnd!=null&&!searchActualTimeEnd.equals("")){
	strwhere +=" and convert(char(10),actual_time,21) <= '"+searchActualTimeEnd+"'";
}
//选择实际发送时间范围 [END]
//if(searchPerformTime!=null&&!searchPerformTime.equals("")){
//	strwhere +=" and convert(char(10),perform_time,21) = '"+searchPerformTime+"'";
//}
//选择发送时间范围 [START]
if(searchPerformTimeBegin!=null&&!searchPerformTimeBegin.equals("")){
	strwhere +=" and convert(char(10),perform_time,21) >= '"+searchPerformTimeBegin+"'";
}
if(searchPerformTimeEnd!=null&&!searchPerformTimeEnd.equals("")){
	strwhere +=" and convert(char(10),perform_time,21) <= '"+searchPerformTimeEnd+"'";
}
//选择发送时间范围 [END]
strwhere +=" order by id desc";
sql = "select * from sms_info "+strwhere;

//
String strType = "";
String sqlType = "select distinct type from sms_info";
System.out.println(sqlType);
ResultSet rsType = db.executeQuery(sqlType);
while(rsType.next()){
	strType +="|"+getDBStr(rsType.getString("type"));
}
%>
					 	
<!--翻页控制开始-->


<% 
	int intPageSize = 800;   //一页显示的记录数
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

System.out.println(sql);;
rs = db.executeQuery(sql); 

	rs.last();                                      //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>
<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td colspan="2">
					&nbsp;&nbsp;<select name="searchKey"><script>w(mSetOpt('<%=searchKey%>',"全部|已发送成功|待发送|发送中|未发送|发送失败"));</script></select>
			    	类型:<select name="searchType"><script>w(mSetOpt('<%=searchType%>',"<%=strType%>"));</script></select>
			    	<select name="searchDel"><script>w(mSetOpt('<%=searchDel%>',"全部|有效|作废","-1|0|1"));</script></select>
			    	手机号：<input type="text" size="12" name="searchPhone" value="<%=searchPhone %>">
			    	添加时间:<input type="text" size="10" name="searchAddTimeBegin" value="<%=searchAddTimeBegin %>"><img  onClick="openCalendar(searchAddTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
			    	<input type="text" size="10" name="searchAddTimeEnd" value="<%=searchAddTimeEnd %>"><img  onClick="openCalendar(searchAddTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				</td>
			</tr>
			<tr class="maintab">
				<td colspan="2">
				发送时间:<input type="text" size="10" name="searchPerformTimeBegin" value="<%=searchPerformTimeBegin %>"><img  onClick="openCalendar(searchPerformTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
				<input type="text" size="10" name="searchPerformTimeEnd" value="<%=searchPerformTimeEnd %>"><img  onClick="openCalendar(searchPerformTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				
			    	实际发送时间:<input type="text" size="10" name="searchActualTimeBegin" value="<%=searchActualTimeBegin %>"><img  onClick="openCalendar(searchActualTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
			    	<input type="text" size="10" name="searchActualTimeEnd" value="<%=searchActualTimeEnd %>"><img  onClick="openCalendar(searchActualTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			    	<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="forms[0].submit();">
				</td>
			</tr>
			<tr class="maintab">
				<td align="left" width="50%">
					 




<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<%if (right.CheckRight("sms-smstest-send",dqczy)>0) {%>
		<td><a href="#" accesskey="n" onclick="fun_smssend()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="发送短信" align="absmiddle">发送短信</a> </td>
		<%}%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="fun_refresh()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="刷新" align="absmiddle">刷新</a></td>
		<%if (right.CheckRight("sms-smstest-add",dqczy)>0) {%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="dataHander('add','sms_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="新增" align="absmiddle">新增</a></td>
		<%}%>
		
		<%if (right.CheckRight("sms-smstest-info",dqczy)>0) {%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="dataHander('add','sms_info.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="可发送短信数量" align="absmiddle">可发送短信数量</a></td>
		<%}%>
    	<td>&nbsp;&nbsp;<%if(sms!=null){
if(!sms.isAlive()){ %>短信发送完成，请察看已发送短信纪录<%}else{%>当前有 <%=intRowCount%> 条记录未发送<%}} %></td>
    </tr>
</table>

<!--操作按钮结束-->
</td>
					 <td align="right" width="40%">
					 	



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

<!--翻页控制结束-->

<!--
</form>
<form name="list">
-->

<!--报表开始-->
<input type="hidden" name="czid">
<input type="hidden" name="del_flag">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      
      <tr class="maintab_content_table_title">
	    <th>发送号码</th>
	    <th>短信信息</th>
	    <th>添加时间</th>
	    <th>发送时间</th>
	    <th>实际发送时间</th>
	    <th>类型</th>
	    <th>有效/作废</th>
	    <th>操作标志</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>

		<td><%= getDBStr( rs.getString("mobile_phone") ) %></td>	
		<td><%= smsReplace(getDBStr( rs.getString("sms_message") )) %></td>
		<td><%= getDBStr( rs.getString("add_time")) %></td>
		<td><%= getDBStr( rs.getString("perform_time")) %></td>
		<td><%= getDBStr( rs.getString("actual_time")) %></td>
		<td><%= getDBStr( rs.getString("type")) %></td>
		<td><%if( getDBStr( rs.getString("delete_flag")).equals("0")){ %><a href="#" onclick="fun_del('<%=getDBStr( rs.getString("id")) %>')"><span title="设置为作废">有效</span></a><%}else{ %><a href="#" onclick="fun_use('<%=getDBStr( rs.getString("id")) %>')"><span title="设置为有效">作废</span></a><%} %></td>
		<td><%int flag = rs.getInt("perform_flag");%><% if(flag>0){ %>发送成功<%}else if(flag<0){ %>发送失败<%}else if(flag==0&&!getDBStr( rs.getString("perform_time")).equals("")){ %>发送中<%}else if(flag==0&&getDBStr( rs.getString("perform_time")).equals("")){ %>未发送<%} %></td>
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

</html>
<script language="javascript">
function fun_smssend(){
	if(confirm("确实要发送短信")){
		alert("请不要关闭当前页面，短信发送结束后察看系统提示");
		document.forms[0].action="sms_send.jsp";
		document.forms[0].submit();
	}
}
function fun_refresh(){
	document.forms[0].action="sms_list.jsp";
	document.forms[0].submit();
}
function fun_del(id){
	if(confirm("确实要将记录作废")){
		document.forms[0].action="sms_del.jsp";
		document.forms[0].target="_black";
		document.forms[0].czid.value=id;
		document.forms[0].del_flag.value=1;
		document.forms[0].submit();
		
	}
}
function fun_use(id){
	if(confirm("确实要将记录生效")){
		document.forms[0].action="sms_del.jsp";
		document.forms[0].target="_black";
		document.forms[0].czid.value=id;
		document.forms[0].del_flag.value=0;
		document.forms[0].submit();
		
	}
}
</script>
