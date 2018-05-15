<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>纳税人信息确认后展示</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function isSelectAll() {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
}

function  getList(){
	//得到复选框的集合
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += id +",";

		

		
	});

	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1).replace("'",""));
	dataNav.action="taxpayer_confirm_data_sync.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			
}

function  backInfo(){
	//得到复选框的集合
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds +=  id +",";

		

		
	});

	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1).replace("'",""));
	dataNav.action="taxpayer_back_data_sync.jsp";
			dataNav.target="_blank"
			dataNav.submit();
			
}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<!-- 下拉值 -->
<%@ include file="../../public/selectData.jsp"%>
<!-- 下拉值 -->


<body onLoad="public_onload(0);">
<form action="taxpayer_info_confirm.jsp" name="dataNav">
<input id="sqlIds" name="sqlIds" type="hidden" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	纳税人信息确认后展示</td>
    </tr>
  </table>
  <!--标题结束-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );


if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}


//权限判断
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from vi_base_taxPayer_confirm_show where 1=1 "+wherestr;

%>

<!--可折叠查询开始-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;查询条件
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		客户编号&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		客户名称&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>	
	</tr>
	<tr>
     <td ><input type="button" value="清空" onclick="clearQuery();" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="button" value="查询" onclick="dataNav.submit();"></td>
    </tr>
	</table>
	</fieldset>
	</div>
<!--可折叠查询结束-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
      <td align="left" width="90%" rowspan="2"><!--操作按钮开始-->
        <!--操作按钮结束--></td>
        <td align="right" width="20%" colspan="2"><!--翻页控制开始-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--翻页控制结束-->
  
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%">编号</th>	    
	    <th>客户编码</th>
	    <th>客户名称</th>
	    <th>纳税人税号</th>
	    <th>地址</th>
	    <th>电话</th>
	    <th>纳税人基本开户行</th>
	    <th>纳税人账号</th>
	    <th>发票类型</th>	  
	    <th>维护状态</th>  
	    <th>维护人</th>
		<th>维护时间</th>	
      </tr>
      <tbody id="data">
<%
String col_str="id, cust_name, cust_id,tax_payer_no,tax_type_invoice,address,tel,bank_name,bank_no,wh_status,wh_modificator,wh_modify_date ";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_base_taxPayer_confirm_show where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_base_taxPayer_confirm_show where 1=1 "+wherestr+" order by  id  desc ) "+wherestr ;
sqlstr += " order by id desc ";

LogWriter.logDebug(request, "法人客户信息界面###"+sqlstr);
int i=0;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center"><%=i %></td>
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("tax_payer_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("address") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tel") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("bank_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("tax_type_invoice") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_status") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("wh_modificator") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("wh_modify_date") ) %></td>
		
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- 报表结束 -->

</form>
</body>
</html>
