<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="dbconn.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>租赁公司收款列表</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>
	<script src="../../js/calend.js"></script>
	
	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<body onload="public_onload(0);">
<form action="leasing_list_search.jsp" name="dataNav" onSubmit="return goPage()">
<%
String dqczy=(String) session.getAttribute("czyid");

String wherestr=" where 1=1 ";
String sqlstr = "";	
ResultSet rs = null;

String code = getStr( request.getParameter("code") );
String dls = getStr( request.getParameter("dls") );
String status = getStr( request.getParameter("status") );

String fk_date_start = getStr( request.getParameter("fk_date_start") );
String fk_date_end = getStr( request.getParameter("fk_date_end") );
	
	
if ( !code.equals("") ) {
	wherestr = wherestr + " and apply.id  like '%" + code + "%'";
}
if ( !dls.equals("") ) {
	wherestr = wherestr + " and dld_name  like '%" + dls + "%'";
}
if ( !status.equals("") ) {
	wherestr = wherestr + " and status = '" + status + "'";
}

if(fk_date_start!=null&&!fk_date_start.equals("")){
	wherestr+=" and convert(varchar(10),pay_date,21)>='"+fk_date_start+"' ";
}
if(fk_date_end!=null&&!fk_date_end.equals("")){
	wherestr+=" and convert(varchar(10),pay_date,21)<='"+fk_date_end+"' ";
}

//判断代理商还是租赁公司
String filterAgent = "";
String loginBmbh = "";//登录用户的部门编号
sqlstr="select bmbh from jb_yhxx where id='"+ dqczy +"'";
//执行查询
rs = db.executeQuery(sqlstr);
if (rs.next()){
	loginBmbh = rs.getString("bmbh");
	try{
		Integer.parseInt(loginBmbh);
		filterAgent ="";
	}catch(Exception e){//代理商
		filterAgent =" and apply.creator in (select id from jb_yhxx where bmbh = (select bmbh from jb_yhxx where id='"+dqczy+"')) ";
	}
	if( "".equals(loginBmbh) ){//租赁物公司部门编号为数字或""
		filterAgent ="";
	}
}else {//错误操作
	System.out.println("++++权限丢失++++"); %>
	<script language="javascript">
	window.parent.parent.location.replace("http://test.strongflc.com/names.nsf?logout");
	</script> 
<%	}

sqlstr="select apply.*,dl.skyy as yh,dl.skzh as zh,title,khmc from apply_info  apply left join dl_mpxx dl  on apply.dld_id=dl.khbh left join dbo.ifelc_conf_dictionary on ifelc_conf_dictionary.name=apply.pay_method "+wherestr+filterAgent+" and pay_type in('资金','资金管理服务费') and apply.status<>'已驳回'  and isnull(is_sub,'')='已提交' ";

%>		  

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
   <tr>
    <td scope="row">付款单号
		<input name="code" type="text"  size="10"  value="<%=code %>">
    </td>
    <td scope="row">状态
    <select name="status"><script>w(mSetOpt("<%=status %>","|已核销|未核销"));</script></select>
    </td>
    <td scope="row">代理商
    <input name="dls" type="text"  size="10"  value="<%=dls %>">
	</td>
    <td scope="row">付款时间段
    <input name="fk_date_start" type="text"  size="9"   value="<%=fk_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(fk_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" height="19" border="0" align="absmiddle">
     -
    <input name="fk_date_end" type="text"  size="9"   value="<%=fk_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(fk_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" height="19" border="0" align="absmiddle">
     &nbsp;
   <input type="button" value="查询" onclick="dataNav.submit();">
   <input type="button" value="清空" onclick="clearQuery();">
  	</td>
  </tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			租赁公司收款列表（首期付款）
		</td>
	</tr>
</table>
<!--标题结束-->

<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0">
			<tr class="maintab">
			</tr>
		</table>
		<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplitNoCode.jsp" %>
	</td>
	<!--翻页控制结束-->			
</tr>
</table>
	
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height: 80%;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">							
        <th>付款单号</th>
        <th>代理商</th>
        <th>付款方式</th>
        <th>付款金额</th>
        
        <th>项目数量</th>
        <th>付款日期</th>
        <th>到帐日期</th>
        <th>状态</th>
		</tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
	<tr>
        <td align="center">
		<a href="leasing.jsp?czid=<%=getDBStr(rs.getString("id"))%>&fact_date=<%=getDBDateStr(rs.getString("fact_date")) %>" target="deltail">
		<%=getDBStr(rs.getString("id"))%>
		</a></td>
       <td align="center"><%=getDBStr(rs.getString("dld_name")) %></td>
       <td align="center"><%=getDBStr(rs.getString("title")) %></td>
       <td align="center"><%=formatNumberDoubleTwo(rs.getString("pay_amt")) %></td>
       <td align="center"><%=getDBStr(rs.getString("proj_number")) %></td>
       <td align="center"><%=getDBDateStr(rs.getString("pay_date")) %></td>
       
       <td align="center"><%=getDBDateStr(rs.getString("fact_date")) %></td>
    
         <td align="center"><%=getDBStr(rs.getString("status")) %></td>
	</tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
	</tbody>	
	</table>
</div><!--报表结束-->
</form>		
</body>
</html>

















