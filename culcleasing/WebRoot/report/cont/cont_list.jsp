<%@ page contentType="text/html; charset=gbk" language="java" errorPage="../../error.jsp"  %>
<jsp:directive.page import="com.tenwa.leasing.web.filter.CreditFilter"/>
<%@ include file="../../func/common.jsp"%>
<!--在common.jsp这个页面中声明了一个log类(org.apache.log4j.Logger)用于日志输出.不推荐使用System.out.print()输出相关信息-->
<jsp:directive.page import="com.tenwa.leasing.dao.Conn"/>
<jsp:directive.page import="java.sql.ResultSet"/>
<!--权限控制代码预留区-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>合同信息 - 合同查询</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<%

Logger logger = Logger.getLogger("jsp:");
    //首先得到此模块的，此用户的权限列表
    CreditFilter cf = new CreditFilter();
    String dqczy = (String) session.getAttribute("uuid");
    String modul = request.getParameter("modulName");
logger.info(dqczy+"===============");
logger.info(modul+"===============");
	List powers =   cf.CheckRight(modul,dqczy);
 // List powers =   cf.CheckRight(modul,"ADMR-8EY9XD");
 logger.info(powers+"===============");
 
  
  if (!powers.contains("view")) {
	  //暂时注释
  	 response.sendRedirect("../../noright.jsp");
  	}


 %>
 
<!--
public_onload(0) 此函数可以把页面中mydiv层自适高度
-->
<body onLoad="public_onload(0)">
<!--这个form的name值会影响到增删改按钮调用函数dataHander()的最后一个参数不建议更改   goPage() 用于响应翻页action 为自己 -->
<form action="cont_list.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" value="<%=modul %>" name="modulName">
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
       合同信息 &gt; 合同查询</td>
    </tr>
  </table>
 <%


String sqlstr;
ResultSet rs;
String wherestr = " where 1=1 ";
boolean isExit1 = false;		//用于判断用户是否存在，存在为true,否则为false
//String whereRight="";
Conn db = new Conn();



String industry_name = getStr( request.getParameter("industry_name") );
String model_id = getStr( request.getParameter("model_id") );
String model_name = getStr( request.getParameter("model_name") );
String contract_id = getStr( request.getParameter("contract_id") );
String contract_num = getStr( request.getParameter("contract_num") );
String cust_name = getStr( request.getParameter("cust_name") );
String proj_manager_name = getStr( request.getParameter("proj_manager_name") );
String status_name = getStr( request.getParameter("status_name") );
String proj_dept=getStr( request.getParameter("proj_dept") );

if(!industry_name.equals("")){
	wherestr+=" and vic.industry_type ='"+industry_name+"'";
}
if(!contract_id.equals("")){
	wherestr+=" and vic.contract_id like '%"+contract_id+"%'";
}
if(!cust_name.equals("")){
	wherestr+=" and vic.cust_name like '%"+cust_name+"%'";
}
if(!proj_manager_name.equals("")){
	wherestr+=" and vic.proj_manage like '%"+proj_manager_name+"%'";
}
if(!status_name.equals("")){
	wherestr+=" and vic.status_name like '%"+status_name+"%'";
}
if(!proj_dept.equals("")){
	wherestr+=" and vic.proj_dept like '%"+proj_dept+"%'";
}

//Logger logger = Logger.getLogger("jsp:");

sqlstr="select vic.cust_id,vic.contract_id, vic.contract_number,pro.approve_date, vic.cust_name as cust_name,vic.industry_type as industry_name, vic.actual_start_date, vic.status_name,cc.clean_lease_money, vic.proj_dept , vic.proj_registrar,vic.proj_assist,vic.proj_manage,vic.start_date,vic.end_date,vic.accounting_start_date,vic.actual_end_date from vi_contract_info vic left join proj_info pro on pro.proj_id=vic.proj_id left join contract_condition cc on vic.contract_id=cc.contract_id  ";
sqlstr+=wherestr;
//sqlstr="select * from ("+sqlstr+") tbl where 1=1 "+whereRight;
String orderby=" contract_id desc ";
logger.debug("sqlstr:"+sqlstr);
%>
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr>
      <td align="left" colspan="2">
  
     <!--查询条件 区域结束-->
<!--可折叠查询开始 --如果不用这个方式查询则删除此段-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onClick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
	<td>内 部 行 业</td>
	<td><select style="width: 48%" name="industry_name"></select><script language="javascript">dict_list("industry_name","cust_kind","<%=industry_name%>","title");</script></td>
	<td>合同编号</td>
	<td><input name="contract_id" type="text" size="15" value="<%=contract_id %>"></td>
	<td>项目经理</td>
	<td><input name="proj_manager_name" type="text"  size="15" value="<%=proj_manager_name %>"></td>
</tr>
<tr>
	<td>合同状态</td>
	<td><input name="status_name" type="text" size="15" value="<%=status_name %>" readonly><input type="hidden" name="status"><img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','合同状态','base_contractstatus','status_name','status_code','status_name','status_name','asc','dataNav.status_name','dataNav.status');"></td>
	<td>承租客户</td>
	<td><input name="cust_name" type="text"  size="15" value="<%=cust_name %>"></td>
	<td>出单部门</td>
	<td><input name="proj_dept" type="text"  size="15" value="<%=proj_dept %>">&nbsp;&nbsp;<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();"></td>
</tr>

</table>
</fieldset>
</div>
<!--可折叠查询结束-->
        </td>
    </tr>
    <tr class="maintab">
      <td align="left" width="50%">
      <!--操作按钮-->
      <table border="0" cellspacing="0" cellpadding="0" >
          <tr class="maintab">
          </tr>
        </table>
        </td>
        <!--加载分页页面-->
      <td align="right" width="50%"><%@ include file="../../page.jsp"%></td>
    </tr>
  </table>
  <!--这个层是数据展示层 加载了public_onload(0) 函数之后就不需要设置高度 层的ID 不能变-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th width="10%">合同号</th>
        <th width="3%">承租客户</th>
        <th width="3%">信审日期</th>
        <th width="3%">内部行业</th>
        
        <th width="3%">预计起租日</th>
        <th width="3%">实际起租日期</th>
        <th width="3%">预计结束日期</th>
        <th width="3%">实际结束日期</th>
        <th width="3%">财务起租日</th>
        
        <th width="3%">合同状态</th>
        <th width="3%">净融资额</th>
        <th width="3%">项目经理</th>
        
        <th width="3%">经办人</th>
        <th width="3%">项目协办</th>
        
        <th width="3%">出单部门</th>
        <th width="10%">回笼信息</th>
      </tr>
<%
while(rs.next()){
%>
      <tr class="cwDLRow"><!--cwDLRow 这个样式可以选中一行并改变行背景色-->
    <td><%= getDBStr( rs.getString("contract_id") ) %></td>
		<td><%= getDBStr( rs.getString("cust_name") ) %></td>
        <td nowrap><%= getDBDateStr( rs.getString("approve_date") ) %></td>
		<td nowrap><%= getDBStr( rs.getString("industry_name") ) %></td>
		<td nowrap><%= getDBDateStr( rs.getString("start_date") ) %></td>
		<td nowrap><%= getDBDateStr( rs.getString("actual_start_date") ) %></td>
		
		<td nowrap><%= getDBDateStr( rs.getString("end_date") ) %></td>
		<td nowrap><%= getDBDateStr( rs.getString("actual_end_date") ) %></td>
		<td nowrap><%= getDBDateStr( rs.getString("accounting_start_date") ) %></td>
		
		
		<td nowrap><%= getDBStr( rs.getString("status_name") ) %></td>
		<td><%= formatNumberStr(getDBStr( rs.getString("clean_lease_money") ),"#,##0.00") %></td>
		<td nowrap><%= getDBStr( rs.getString("proj_manage") ) %></td>
		
		<td nowrap><%= getDBStr( rs.getString("proj_registrar") ) %></td>
		<td nowrap><%= getDBStr( rs.getString("proj_assist") ) %></td>
		
		<td nowrap><%= getDBStr( rs.getString("proj_dept") ) %></td>
      	<td nowrap>
      		<a href="../../contract_info/condition_read/main.jsp?id=<%= getDBStr( rs.getString("contract_id") ) %>&processType=cont_ready_process&cust_id=<%= getDBStr( rs.getString("cust_id") ) %>" target="_blank">商务条件</a>
      		<a href="../../contract_info/condition/rent_income.jsp?contract_id=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank">实际回笼</a>
      		<a href="change_list.jsp?contract_id=<%= getDBStr( rs.getString("contract_id") ) %>" target="_blank">变更历史</a>
      	
      	</td>
      </tr>
<%
}
rs.close(); 
db.close();//一定要关闭db
%>
    </table>
  </div>
</form>
<script>
function getout(){//如果用JS方式下载form2 中的隐藏域要和查询条件中的域一样 
	document.forms.item(1).submit();
}
</script>



</body>
</html>
