<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划上报</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<% 
String  contract_boxid="FI"+UUID.randomUUID().toString().replace("-","");
%>
<%=contract_boxid%>
<script type="text/javascript">

function changeOne(){
	
	//判断是否有选中
	var contractIds="";
	var cbk = document.getElementsByName("itemselect");           
    var flag = false ;//标记判断是否选中一个                 
        for(var i=0;i<cbk.length;i++){  
            if(cbk[i].checked){  
                flag = true ;  
                break ;  
            }  
        }  
        if(!flag){  
            alert("请最少选择一项！");  
            return false ;  
        }        
 
	$("input[name^='itemselect']:checked").each(function(){
			var contract_id = $(this).val();
			//contractIds += "'"+ contract_id +"',";
			contractIds += contract_id+",";
	});
	 contractIds= contractIds.substring(0,contractIds.length-1);
	var para3=document.getElementById("contract_boxid").value;
   window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/ProjectCont.nsf/OSNewFlowFromMenuZJJHSBPL?openagent&Contractid="+contractIds+"&para3="+para3);

	
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">

<%

String userid=(String)session.getAttribute("czyid");
String contract_id = getStr( request.getParameter("contract_id") );
String project_name = getStr( request.getParameter("project_name"));
String whereStr = "" ;

if ( contract_id!=null && !contract_id.equals("") ) {
	whereStr = " and contract_id = '" + contract_id + "'";
}
if ( project_name!=null && !project_name.equals("") ) {
	whereStr += " and project_name = '" + project_name + "'";
}

//权限管理：项目助理
if(userid == "ADMN-8GRBW4"){
	
}else{
	whereStr += " and proj_assistant = '" + userid + "'";
}

//countSql = "select count(id) as amount from v_base_user where (role='项目经理' or v_base_user.id in( SELECT user_id FROM base_group_user_relation WHERE group_id='ADMN-857B78')) and isnull(code,'')='' and status=1 " + whereStr ;
countSql = "select count(contract_id) as amount from vi_select_contract_info_ZJJHSB where 1=1"+whereStr;

%>

<form action="ZJJJSB_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
  <tr class="tree_title_txt">
    <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">资金计划上报</td>
  </tr>
</table>
<!--标题结束-->

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>合同编号:&nbsp;<input name="contract_id"  type="text" size="20" value="<%=contract_id%>"></td>
<td>项目名称:&nbsp;<input name="project_name"  type="text" size="120" value="<%=project_name%>"></td>
</tr>
<tr>
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
        <td align="left" width="1%"><!--操作按钮开始-->
	        <table border="0" cellspacing="0" cellpadding="0" >
	        	<tr class="maintab">
		         <td align="left">
		           <BUTTON class="btn_2" name="btnHire" value="转移"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="转移(Alt+Y)" border="0">
        			&nbsp;批量资金计划上报
        			</button>
        			<input type="hidden" name="change_proj_id" id="change_proj_id">
					<input type="show" name="contract_boxid" id="contract_boxid" value="<%=contract_boxid%>">
					
		          </td>
		         </tr>
	        </table>
        </td>
        <!--操作按钮结束-->
        
        <td align="right" width="95%"><!--翻页控制开始-->
		<!-- 翻页控制开始 -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--翻页控制结束-->	
		</td>
	</tr>
</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"  class="maintab_content_table" >
      <tr class="maintab_content_table_title">
        <th width="1%"></th>
	    <th>合同编号</th>
	    <th>项目编号</th>
	    <th>项目名称</th>
     	<th>项目类型</th>
 		<th>行业类型</th>
		<th>项目状态</th>
      </tr>
      <tbody id="data">
<%
String col_str="*";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_select_contract_info_ZJJHSB where contract_id not in (select top "+ (intPage-1)*intPageSize +" contract_id from vi_select_contract_info_ZJJHSB where 1=1"+whereStr+"order by contract_id)"+ whereStr +"order by contract_id" ; 
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
	
%>
      <tr>
        <td align="center"><input class="rd" type="checkbox" name="itemselect" value="<%=getDBStr( rs.getString("contract_id") )%>" 
		para1="<%=getDBStr( rs.getString("proj_id") )%>"
		para2="<%=getDBStr( rs.getString("project_name") )%>"
		para3="<%=getDBStr( rs.getString("leas_form") )%>"
		para4="<%=getDBStr( rs.getString("industry_name") )%>"
		flag="<%=getDBStr( rs.getString("proj_status") )%>" >
		</td>
        <td align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("proj_id"))%></td>
        <td align="center"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="center"><%=getDBStr(rs.getString("leas_form"))%></td>
		<td align="center"><%=getDBStr(rs.getString("industry_name"))%></td>
		<td align="center">
			
			<%
				String pFl = rs.getString("proj_status");
				if("110".equals(pFl)){%>
					合同结束
				<%}else { %>
					起租
			   <% } %>
			</font>
		</td>
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
