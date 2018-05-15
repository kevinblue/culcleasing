<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" pageEncoding="gbk"%>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>


<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<form action="inject_proj_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		项目信息</td>
	</tr>
</table>
<!--标题结束-->

<%
//获取查询类型
String injectType = getStr( request.getParameter("injectType") );
System.out.println("输出类型"+injectType);

String partSqlStr = "";
partSqlStr = getStr( request.getParameter("partSqlStr") );
if( "KQZY".equals(injectType) ){
	if( partSqlStr==null || "".equals(partSqlStr) ){
		String qymc="";
		String sfmc="";
		String board_name="";
		String start_date="";
		String end_date="";
		String qy="";
		request.setCharacterEncoding("gbk");
		qymc=getStr(request.getParameter("qymc"));
		System.out.println("输出区域"+qymc);
		sfmc=getStr( request.getParameter("sfmc"));
		board_name=getStr( request.getParameter("board_name"));
		start_date=getStr(request.getParameter("start_date"));
		end_date=getStr(request.getParameter("end_date"));
		qy=getStr(request.getParameter("qy"));
		if(qy.equals("qngs")){
		partSqlStr = " and contract_id in(select contract_id from vi_contract_info vci1 "+
		"left join vi_cust_all_info_t vca on vci1.cust_id=vca.cust_id where vci1.qymc='"+qymc+"' and vca.sfmc='"+sfmc+"' and board_name='"+board_name+"' and convert(varchar(10),cd_date,120)>='"+start_date+"' and convert(varchar(10),cd_date,120)<='"+end_date+"' and CHARINDEX(vca.sfmc,isnull(dbo.report_getSF(vci1.proj_manage),''))>0)";
		}
		if(qy.equals("qwgs")){
		partSqlStr = " and contract_id in(select contract_id from vi_contract_info vci1 "+
		"left join vi_cust_all_info_t vca on vci1.cust_id=vca.cust_id where vci1.qymc='"+qymc+"' and vca.sfmc='"+sfmc+"' and board_name='"+board_name+"' and convert(varchar(10),cd_date,120)>='"+start_date+"' and convert(varchar(10),cd_date,120)<='"+end_date+"' and CHARINDEX(vca.sfmc,isnull(dbo.report_getSF(vci1.proj_manage),''))=0)";
		}


		System.out.println("输出区域"+qymc);
	}
}
else if("YQZJ".equals(injectType)){
	if( partSqlStr==null || "".equals(partSqlStr) ){
		String flag=getStr( request.getParameter("flag"));
		String title=getStr( request.getParameter("title"));
		String start_date=getStr( request.getParameter("start_date"));
		String end_date=getStr( request.getParameter("end_date"));
		int min_day=0;
		int max_day=0;
		if(flag.equals("1")){
			if(title.equals("一周")){
				min_day=0;
				max_day=7;
			}else if(title.equals("一周~两周")){
				min_day=7;
				max_day=14;
			}else if(title.equals("两周~一个月")){
				min_day=14;
				max_day=30;
			}else if(title.equals("一个月~三个月")){
				min_day=30;
				max_day=90;
			}else if(title.equals("三个月以上")){
				min_day=90;
				max_day=99999;
			}
			partSqlStr = " and contract_id in(select fpp.contract_id from fund_penalty_plan fpp left join fund_rent_plan frp on "+ 
					 "fpp.match_id=frp.id where frp.plan_date>='"+start_date+"' and frp.plan_date<='"+end_date+"'"+ 
					 " and fpp.penalty_day_amount>"+min_day+" and fpp.penalty_day_amount<="+max_day+")";
		}else if(flag.equals("2")){
			start_date=start_date.substring(0,4)+"-01-01";
			System.out.println("start_date"+start_date);
			if(title.equals("一周")){
				min_day=0;
				max_day=7;
			}else if(title.equals("一周~两周")){
				min_day=7;
				max_day=14;
			}else if(title.equals("两周~一个月")){
				min_day=14;
				max_day=30;
			}else if(title.equals("一个月~三个月")){
				min_day=30;
				max_day=90;
			}else if(title.equals("三个月以上")){
				min_day=90;
				max_day=99999;
			}
			partSqlStr = " and contract_id in(select fpp.contract_id from fund_penalty_plan fpp left join fund_rent_plan frp on "+ 
						"fpp.match_id=frp.id where frp.plan_date>='"+start_date+"' and frp.plan_date<='"+end_date+"'"+ 
						"and fpp.penalty_day_amount>"+min_day+" and fpp.penalty_day_amount<="+max_day+")";
		}else if(flag.equals("3")){
			if(title.equals("一周")){
				min_day=0;
				max_day=7;
			}else if(title.equals("一周~两周")){
				min_day=7;
				max_day=14;
			}else if(title.equals("两周~一个月")){
				min_day=14;
				max_day=30;
			}else if(title.equals("一个月~三个月")){
				min_day=30;
				max_day=90;
			}else if(title.equals("三个月以上")){
				min_day=90;
				max_day=99999;
			}
			partSqlStr = " and contract_id in(select fpp.contract_id from fund_penalty_plan fpp left join fund_rent_plan frp on "+
						"fpp.match_id=frp.id where frp.plan_date<='"+end_date+"' "+ 
						"and fpp.penalty_day_amount>"+min_day+" and fpp.penalty_day_amount<="+max_day+")";
							System.out.println("截止sql"+partSqlStr);
		}
	}
}

//String proj_manage = (String)session.getAttribute("czyid");
//wherestr += " and proj_manage='"+proj_manage+"'";

//本页查询参数
String project_name = getStr( request.getParameter("project_name") );
if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}
if( partSqlStr!=null && !"".equals(partSqlStr) ){
	wherestr += partSqlStr;
}

countSql = "select count(id) as amount from vi_contract_info vci where 1=1 "+ wherestr;

%>

<input name="injectType" type="hidden" value="<%=injectType %>">
<input name="partSqlStr" type="hidden" value="<%=partSqlStr %>">

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>
<td>
<input type="button" value="查询" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="清空" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--可折叠查询结束-->

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--操作按钮开始-->
	<!--操作按钮结束-->
	</td>
	<td align="right" width="60%"><!--翻页控制开始-->
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--翻页控制结束-->	
	</td>		 	
 </tr>
</table>

<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>项目编号</th>
		<th>合同编号</th>
		<th>项目名称</th>
		<th>行业</th>
		<th>承租人</th>
		<th>部门名称</th>
		<th>项目经理</th>
		<th>项目助理</th>
		<th>项目类型</th>
		<th>租赁类型</th>
		<th>租赁形式</th>
		<th>立项日期</th>
      </tr>
      <tbody id="data">
<%
String col_str="proj_id,contract_id,project_name,board_name,vci.cust_name,vci.dept_name,proj_manage_name,proj_assistant_name,proj_type,leas_type,leas_form,proj_date";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_contract_info vci where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_contract_info vci where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";
System.out.println("输出sql语句====================="+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
		<td align="left">
		<a href="http://culc.eleasing.com.cn/eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=getDBStr( rs.getString("proj_id")) %>" target="_blank">
		<%=getDBStr( rs.getString("proj_id")) %></a></td>	
		<td align="left"><%=getDBStr( rs.getString("contract_id")) %></td>
		<td align="center"><%=getDBStr( rs.getString("project_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("board_name")) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("dept_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("proj_manage_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("proj_assistant_name")) %></td>
		<td align="center"><%=getDBStr( rs.getString("proj_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("leas_type")) %></td>
		<td align="center"><%=getDBStr( rs.getString("leas_form")) %></td>
		<td align="center"><%=getDBDateStr( rs.getString("proj_date")) %></td>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--报表结束-->

</form>
</body>
</html>
