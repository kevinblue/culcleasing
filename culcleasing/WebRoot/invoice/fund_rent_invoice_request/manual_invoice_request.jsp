<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>手工凭证信息录入</title>
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
//删除时
function validate_del() {
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += "'"+ id +"',";		
	});
	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
	if(sqlIds==undefined||sqlIds==""){
		alert("请选择要删除的发票");
	}else{
		document.dataNav.action="manual_invoice_del.jsp";
		document.dataNav.target="_blank";
		document.dataNav.submit();
		document.dataNav.action="manual_invoice_request.jsp";
		document.dataNav.target="_self";
	}
}
function  getList(){
	//得到复选框的集合
	var sqlIds="";
 	//var check_amount=0;//选中行的数量
	$("input[name^='checkbos_list']:checked").each(function(){
		var id = $(this).attr("value");
		sqlIds += "'"+ id +"',";		
	});

	$("#sqlIds").val(sqlIds.substring(0,sqlIds.length-1));
	dataNav.action="handwork_data_sync.jsp";
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
<form action="manual_invoice_request.jsp" name="dataNav">
<input id="sqlIds" name="sqlIds" type="hidden" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	手工凭证信息录入</td>
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

countSql = "select count(out_no) as amount from vi_manual_open_invoice_info_show where 1=1 "+wherestr;

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
        <td align="left" width="90%" rowspan="2">
        <!--操作按钮开始-->
      <table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	        <td><a href="#" accesskey="n" onClick="dataHander('add','manual_invoice_add.jsp?1=1',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="新增(Alt+N)" align="absmiddle">新&nbsp;增</a>&nbsp;</td>
	        <td>
				<BUTTON class="btn_2" name="btndel" value="删除"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;删除</button>
			</td> 
			<td><a href="#" accesskey="n" onClick="getList();">
			<img align="absmiddle"  src="../../images/sbtn_quick_up.gif" alt="执行同步" align="absmiddle">执行同步</a></td>
	    </tr>
	    
	</table>
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
	    <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
	    <th>ERP单据号</th>
	    <th>客户编码</th>
	    <th>客户名称</th>
	    <th>纳税人税号</th>
	    <th>地址</th>
	    <th>电话</th>
	    <th>纳税人基本开户行</th>
	    <th>纳税人账号</th>
	    <th>备注</th>
	    <th>商品编码</th>
	    <th>商品名称</th>
	    <th>规格型号</th>
	    <th>计量单位</th>
	    <th>单价</th>
	    <th>税率</th>
	    <th>销售数量</th>
	    <th>是否含税</th>
	    <th>金额</th>
	    <th>发票类型</th>
	    <th>创建人</th>
		<th>创建时间</th>
		<th>是否是erp数据</th>
		<th>操作</th>
      </tr>
      <tbody id="data">
<%
String col_str="out_no,cust_id,cust_name,tax_payer_no,address,phone,bank_name,account_number,remark,product_number";
col_str +=",product_name,commercial_specification,unit,unit_price,rate,quantity,if_tax";
col_str +=",include_tax_money,invoice_type,creator,create_date,if_erp";
sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_manual_open_invoice_info_show where out_no not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" out_no from vi_manual_open_invoice_info_show where 1=1 "+wherestr+" order by out_no,create_date desc ) "+wherestr ;
sqlstr += " order by cust_id,create_date desc ";

LogWriter.logDebug(request, "法人客户信息界面###"+sqlstr);
int i=0;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center"><%=i %></td>
		<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("out_no")) %>"
		/></td>
        <td align="center"><%=getDBStr( rs.getString("out_no") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>		
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("tax_payer_no") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("address") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("phone") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("bank_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("account_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("remark") ) %></td>	
		<td align="center"><%= getDBStr( rs.getString("product_number") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("product_name") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("commercial_specification") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("unit") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("unit_price") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("rate") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("quantity") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("if_tax") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("include_tax_money") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("invoice_type") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("creator") ) %></td>
		<td align="center"><%= getDBDateStr( rs.getString("create_date") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("if_erp") ) %></td>
		<td align="center">
     	<a href='manual_invoice_take_info_add.jsp?out_no=<%=getDBStr(rs.getString("out_no"))%>' target="_blank">
	    <img src="../../images/btn_edit.gif" align="bottom" border="0">带数据新增</a>    	
     	</td>
		
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
