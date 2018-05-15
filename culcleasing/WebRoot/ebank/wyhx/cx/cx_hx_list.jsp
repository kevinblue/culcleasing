<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>租金撤销 - 审核列表</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>
	
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../js/stleasing_function.js"></script>

<script type="text/javascript">
//驳回功能的验证
function cx_bh() {
	//是否有选中的付款单号
	var names=document.getElementsByName("list");
 	var flag_bh=0;
 	var sql_bh_ids="";
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
	    	flag_bh++;
	    	var fid= names[i].value;
	    	sql_bh_ids+="'"+fid+"',";
	    }
	}
	
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	//alert(sql_bh_ids);
	if (flag_bh==0) {
		alert("请选择您要驳回的申请!");
		return false;
	}else {
		if (confirm("您是否确认驳回选中申请?")) {
			document.getElementById("savetype").value="bh";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="cx_sq_save.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();	
			document.dataNav.action="cx_hx_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
</script>		
</head>

<body onload="public_onload(0);">
<form action="cx_hx_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="savetype" id="savetype" type="hidden">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">
<%
String dqczy=(String) session.getAttribute("czyid");
String sqlstr="";
ResultSet rs=null;

if(dqczy==null){%>
	<script language="javascript">
	window.parent.parent.location.replace("http://test.strongflc.com/names.nsf?logout");
	</script> 
<%}
String wherestr=" where isnull(tj_status,0)=1 and isnull(cx_status,0)=0 ";
String applier = getStr( request.getParameter("applier") );

String apply_date_start = getStr( request.getParameter("apply_date_start") );
String apply_date_end = getStr( request.getParameter("apply_date_end") );
if ( !"".equals(applier) && applier!=null ) {
	wherestr += " and applier like '%" + applier + "%'";
}
if(apply_date_start!=null && !"".equals(apply_date_start)){
	wherestr+=" and convert(varchar(10),apply_date,21)>='"+apply_date_start+"' ";
}
if(apply_date_end!=null && !"".equals(apply_date_end)){
	wherestr+=" and convert(varchar(10),apply_date,21)<='"+apply_date_end+"' ";
}

sqlstr = "select frc.* from fund_rent_cx frc  "+wherestr+" order by frc.id ";
%>		
			
<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
    <td scope="row">申请人:</td>
    <td><input name="applier" type="text" value="<%=applier %>" size="14"></td>
    <td scope="row">申请时间段:</td>
    <td> 
    <input name="apply_date_start" type="text" size="12" value="<%=apply_date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(apply_date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="apply_date_end" type="text" size="12" value="<%=apply_date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(apply_date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
    </td>
	<td>
	<input type="button" value="查询" size="10" onclick="dataNav.submit();" align="absmiddle">
	&nbsp;&nbsp;
	<input type="button" value="清空" size="10" onclick="clearQuery();" align="absmiddle">
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
		租金撤销（审核）
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
			<td>
			<BUTTON class="btn_2" type="button" onclick="cx_bh();">
            <img src="../../images/hg.gif" width="19" align="absmiddle" border="0">&nbsp;驳回</button>
			</td>
			<td><img src="../../images/sbtn_split.gif" width="2" height="14"></td>
			
			<td nowrap>
			<input name="ck_all" type="checkbox">&nbsp;全选
			</td>
		</tr>
	</table>
	<!--操作按钮结束-->
	</td>
	<td align="right" width="90%">
	<!--翻页控制开始-->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
	<!--翻页控制结束-->
	</td>
</tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th width="1%"></th> 	
        <th>序号</th>
        <th>申请人</th>
        <th>扣划失败银行</th>
        <th>申请日期</th>
        <th>查看</th>
        <th>操作</th>
        <th>备注</th>
     </tr>
<tbody id="data">
<%	  
rs.previous();
int startIndex = 1;
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
	<tr>
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>

        <td align="center"><%=startIndex++ %></td>
        <td align="center"><%=getDBStr(rs.getString("applier")) %></td>
        <td align="center"><%=getDBStr(rs.getString("hire_bank")) %></td>
        <td align="center"><%=getDBDateStr(rs.getString("apply_date")) %></td>
        <td align="center"><a href="file_download.jsp?file_name=<%=getDBStr(rs.getString("file_name"))%>">下载文件</a></td>
        <td align="center"><a href="cx_save.jsp?prId=<%=getDBStr(rs.getString("id"))%>" target="_blank">执行撤销</a></td>
        <td align="center"><%=getDBStr(rs.getString("remark")) %></td>
	</tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody> </table>
</div>
<!--报表结束-->
</form>
</body>
</html>
