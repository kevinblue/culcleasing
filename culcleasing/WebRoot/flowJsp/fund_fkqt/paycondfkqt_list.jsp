<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资金计划 - 付款前提</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	//提交保存资料状态
	function updCondStatus(){
		var flag = 0;
		var erItems = "";
		var items = "";
		
		$(".allMaters>tr").each(function(i){
		    var $materTr = $(this); 
		    var text_status = $materTr.find("td>:input[name^='text_status_']:checked");
			var item = $materTr.find("td>:input[name^='it_']");
			var itemId = $materTr.find("td>:input[name^='item_']");
			//alert("text_status"+text_status.val());
			//判断数据的正确性
			if($.trim(text_status.val())=="" ){
				//alert("第["+(i+1)+"]行项目资料请选择交接归档情况！");
				flag = 1;
				erItems += " ["+(i+1)+"] ";
			}
			items += $.trim(item.val())+"|";// 以|分实体以-分字段
		});
		//alert(items);
		if(flag!=0){
		    alert("请确认每1条付款前提！其中第 "+erItems+" 行没有选择！");
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

<%
//提取参数contract_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<form name="form1" method="post" target="_blank" action="proj_cond_save.jsp">
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- 资金付款前提 -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	资金付款前提&nbsp;
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="显示/隐藏内容">				 
</div> 

<!-- end cwTop -->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>&nbsp;
		<!-- -->
			<BUTTON class="btn_2" type="button" onclick="return updCondStatus();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">&nbsp;提交</button>
			
		</td>
		
		<!-- 翻页控制 -->
		<td align="right" width="100%">
		</td><!-- 翻页结束 -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>款项内容</th>
     <th>序号</th>
	 <th>款项名称</th>
     <th>支付时间</th>
     <th>币种</th>
     <th>付款金额</th>
     <th>付款前提</th>
   </tr>
   <tbody id="allMaters">
<%
String col_str="payment_id,contract_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_way,fpnote,plan_status";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan where plan_status='未核销'and pay_way='付款' and contract_id='"+contract_id+"' order by fee_type";

rs = db.executeQuery(sqlstr);
int rowIndex = 2;
while ( rs.next() ) {
rowIndex++;
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
		<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="left">
     		<%
     			String partSql = "select id,(select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')";
				partSql += " as title,status,id,remark from contract_fund_fund_charge_condition pffcct where payment_id='"+rs.getString("payment_id")+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				
				if(rs1.next()){
					rs1.beforeFirst();
					int index_no = 10;
     		%>
     		<!-- 嵌套table -->
     		<table border="0" cellpadding="0" cellspacing="0">
     			<tr>
     				<th>付款条件</th>
     				<th>状态</th>
     				<th>备注</th>
     			</tr>
     			<tbody class="allMaters">
     			<%
	 				while(rs1.next()){ 
	 					index_no++;
	 					%>
						<tr class="materTr_<%=rowIndex %>_<%=index_no %>">
							<td><%=getDBStr(rs1.getString("title")) %>
								<input type="hidden" name="it_<%=rowIndex %>_<%=index_no %>" value="<%=rowIndex %>_<%=index_no %>">
	     						<input type="hidden" name="item_<%=rowIndex %>_<%=index_no %>" value="<%=getDBStr(rs1.getString("id")) %>">
							</td>
							<td>
							<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="已收" 
				     		<%="已收".equals(getDBStr(rs1.getString("status")))?"checked='checked'":"" %>>已收&nbsp;&nbsp;
				     		<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="未收" 
				     		<%="未收".equals(getDBStr(rs1.getString("status")))?"checked='checked'":"" %>>未收&nbsp;&nbsp;
				     		<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="后期补收" 
				     		<%="后期补收".equals(getDBStr(rs1.getString("status")))?"checked='checked'":"" %>>后期补收
							</td>
							<td><%=getDBStr(rs1.getString("remark")) %></td>
						</tr>
				<%	}%>
				</tbody>
     		</table>
     			<%
				}else{
     			%>
     			无付款前提
     			<%} %>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>

<div style="text-align:right;margin-top:20px;margin-right:120px;display:none;">
<BUTTON class="btn_2" type="button" onclick="return updCondStatus();">
<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="提交(Alt+N)">&nbsp;提交</button>
</div>


</div><!-- 结束资金付款前提div -->

</form>
</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%>