<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目资料 - CD交接</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	//提交保存资料状态
	function updMaterStatus(){
		var totalMoney = 0;
		var flag = 0;
		var erItems = "";
		var items = "";
		$("#allMaters>tr").each(function(i){
		    var $materTr = $(this); 
		    var invoice_is = $materTr.find("td>:input[name^='invoice_is']:checked");
		    var item = $materTr.find("td>:input[name^='it_']");
		    var begin_id=$materTr.find("td>:input[name^='begin_id_']");
		    var rent_list=$materTr.find("td>:input[name^='rent_list_']");
		    var create_date=$materTr.find("td>:input[name^='create_date_']");
		    var invoice_remark=$materTr.find("td>:input[name^='invoice_remark_']");
		    var creator=$materTr.find("td>:input[name^='creator_']");
		    var modificator=$materTr.find("td>:input[name^='modificator_']");
		    var modify_date=$materTr.find("td>:input[name^='modify_date_']");
		    
			//alert("text_status"+text_status.val());
			//判断数据的正确性
			if($.trim(invoice_is.val())==""  ){
				//alert("第["+(i+1)+"]行项目资料请选择交接归档情况！");
				flag = 1;
				erItems += " ["+(i+1)+"] ";
			}
			items += $.trim(item.val())+"|";// 以|分实体以-分字段
		});
		//alert(parseFloat(totalMoney)+'sdsdsd'+parseFloat(cost));
		if(flag!=0){
		    alert("请确认每1条项目资料归档情况！其中第 "+erItems+" 行没有选择！");
			return false;
		}else{
			$(":input[name=itemStr]").val(items.substring(0,items.length-1));
			document.form1.submit();
		}
	}
</script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->


<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form name="form1" method="post" target="_blank" action="proj_mater_save.jsp">
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">

<!-- 资金计划数据 -->
<div style="margin-top: 20px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		项目资料清单</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<BUTTON class="btn_2" type="button" onclick="return updMaterStatus();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">&nbsp;提交</button>
		</td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     	<th>项目编号</th>
	    <th>项目名称</th>
	    <th>出单部门</th>
     	<th>项目经理</th>
 		<th>租金期数</th>
 		
		<th>应收日期</th>
	 	<th>应收租金</th>
	 	<th>利息</th>
	 	<th>本金</th>
	 	<th>发票开具方式</th>
	 	<th>是否开具</th>
	 	<th>备注</th>
	 	<th>租金是否核销</th>
	 	<th>最后更新人</th>
      </tr>
   </tr>
   <tbody id="allMaters">
<%

String user_id = (String)session.getAttribute("czyid");//当前登陆人
String col_str="*";

sqlstr = "select "+col_str+" from vi_func_rent_manage ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="center">
        <BUTTON class="btn_2" name="btnHire" value="转移"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="转移(Alt+Y)" border="0">
        			&nbsp;租金
        			</button>
        
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
        <input type="hidden" name="begin_id_<%=index_no %>" value="<%=getDBStr(rs.getString("begin_id")) %>"/>
        <input type="hidden" name="rent_list_<%=index_no %>" value="<%=getDBStr(rs.getString("rent_list")) %>"/>
        <input type="hidden" name="creator_<%=index_no %>" value="<%=getDBStr(rs.getString("creator")) %>"/>
        <input type="hidden" name="create_date_<%=index_no %>" value="<%=getDBStr(rs.getString("create_date")) %>"/>
        <input type="hidden" name="czyid_<%=index_no %>" value="<%=(String)session.getAttribute("czyid")%>"/>
        <input type="hidden" name="modify_date_<%=index_no %>" value="<%=getDBStr(rs.getString("modify_date")) %>"/>
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=getDBStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("corpus"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>	
		<td align="center">
			<input type="radio" class="rd" name="invoice_is_<%=index_no %>" value="是" 
     			<%="是".equals(getDBStr(rs.getString("text_status")))?"checked='checked'":"" %>>是&nbsp;&nbsp;
     		<input type="radio" class="rd" name="invoice_is_<%=index_no %>" value="否" 
     			<%="否".equals(getDBStr(rs.getString("text_status")))?"checked='checked'":"" %>>否
		</td>	
		<td align="left"><input type="text" name="invoice_remark_<%=index_no %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
      </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div>
</form>

</body>
</html>
