<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 现金流列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//记录模糊查询
function query(){
	//form1.action = "";
	//document.form1.target = "";
	var start_plan_date = document.getElementById("start_plan_date").value ;
	 var end_plan_date = document.getElementById("end_plan_date").value ;
	// alert(end_plan_date > start_plan_date);
    if((start_plan_date != null && start_plan_date != '')&&(end_plan_date != null && end_plan_date != '')){
    	if(end_plan_date < start_plan_date){
    		alert("结束日期不能小于开始日期!");
    		return false;
    	}
    }
    var inputs = document.getElementsByTagName("input");
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].type=="text"){
			if(inputs[i].value.indexOf("\'")>=0){
				alert("输入框不能输入非法字符!");
				return false;
			}
		}
	}   	
	form1.submit();
}
//非法字符验证
function isValidStr(str,name){
    if(str.indexOf("\\") != -1)
    {
       //alert( name+ "不能包含反斜杠\符号！");
       return false;
    }
    var ignoreStr="'\"（）()<>#$%^&*+";
    for(i=0;i<str.length;i++){
         if(ignoreStr.indexOf(str.substring(i,i+1)) != -1)
         {
            //alert( name+"不能包含'和\"以<>#$%^&*+括号等符号，请重新输入！");
            return false;
          }
     }
    return true;
}  
</script>
</head>
<body>
<%
	//权限处理 
	//String dqczy = (String) session.getAttribute("czyid");
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "无认证";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//央行基准利率表
	String sqlstr = " select * from fund_contract_plan where 1=1  "; 
	//获取查询条件
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
	String start_plan_date = getStr(request.getParameter("start_plan_date")); 
	String end_plan_date = getStr(request.getParameter("end_plan_date")); 
	//if(start_plan_date.equals("") || start_plan_date == null){
	//	start_plan_date = nowDateTime;
	//}
	//if(end_plan_date.equals("") || end_plan_date == null){
	//	end_plan_date = nowDateTime;
	//}
	
	if(!contract_id.equals("") && contract_id != null){
		sqlstr = sqlstr + " and  contract_id like '"+contract_id+"'";
	}
	if(!doc_id.equals("") && doc_id != null){
		sqlstr = sqlstr + " and  doc_id like '"+doc_id+"'";
	}
	if(!start_plan_date.equals("") && start_plan_date != null){
		sqlstr = sqlstr + " and  plan_date >= '"+start_plan_date+"' ";
	}
	if(!end_plan_date.equals("") && end_plan_date != null){
		sqlstr = sqlstr + " and  plan_date <= '"+end_plan_date+"' ";
	}
	sqlstr = sqlstr + " order by id";
	System.out.println("sqlstr查询sql语句==>> "+sqlstr);
%>
<form name="form1" action="zjcs_xjl.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	租金测算 &gt; 现金流列表
      </td>
    </tr>
    <tr class="maintab">
		<td align="left" colspan="2">               
			&nbsp;合同编号/项目编号&nbsp;
			<input type="text" name="contract_id"  value="<%=contract_id%>"/>
			&nbsp;文档编号&nbsp;
			<input name="doc_id" type="text" size="15" value="" value="<%=doc_id%>"/>
			&nbsp;日期起&nbsp;
			<input name="start_plan_date" id="start_plan_date" type="text" value="<%=start_plan_date%>"  
					 dataType="Date" size="13" maxlength="20"  Require="true"  readonly="readonly"/>
				<img  onClick="openCalendar(start_plan_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
			&nbsp;至&nbsp;
			<input name="end_plan_date" id="end_plan_date" type="text" value="<%=end_plan_date%>"  
					 dataType="Date" size="13" maxlength="20"  Require="true"   readonly/>
				<img  onClick="openCalendar(end_plan_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="查询" border="0" align="absmiddle" >
			</a>
       </td>
	</tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
 
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--翻页控制开始-->
<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr(request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sqlstr);

	rs.last();                                                  //获取记录总数
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
		var nf = document.form1;
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

<!--翻页控制结束 style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>合同编号/项目编号</th>
	    <th>文档编号</th>
	    <th>日期</th>
		<th>流入量</th>
		<th>流入量清单</th>
		<th>流出量</th>
		<th>流出量清单</th>
		<th>净流量</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
		<td nowrap align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td nowrap align="center"><%=getDBStr(rs.getString("doc_id"))%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_in")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_in_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_out")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_out_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("net_follow")),"#,##0.00")%></td>				
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
