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
		    var text_status = $materTr.find("td>:input[name^='text_status_']:checked");
			var electron_status = $materTr.find("td>:input[name^='electron_status_']:checked");
			var item = $materTr.find("td>:input[name^='it_']");
			var itemId = $materTr.find("td>:input[name^='item_']");
			//alert("text_status"+text_status.val());
			//判断数据的正确性
			if($.trim(text_status.val())=="" || $.trim(electron_status.val())=="" ){
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

<%
//提取参数contract_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//模拟赋值
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
	doc_id = "JS999999900_HT11_22_44";
}

//先初始化加载项目资料清单
ProjMaterService.flowInitContractData(contract_id, doc_id);
%>

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
			<!-- 新增资金计划 -->
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
     <th>资料大类</th>
     <th>资料小类</th>
     <th>备注</th>
     <th>文本是否归档</th>
     <th>电子版是否归档</th>
   </tr>
   <tbody id="allMaters">
<%
String col_str="id,contract_id,doc_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";

sqlstr = "select "+col_str+" from vi_contract_document_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
	index_no++;
%>
     <tr class="materTr_<%=index_no %>">
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %>
     	<input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
     	<input type="hidden" name="item_<%=index_no %>" value="<%=getDBStr(rs.getString("id")) %>">
     	</td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     		<input type="radio" class="rd" name="text_status_<%=index_no %>" value="是">是&nbsp;&nbsp;
     		<input type="radio" class="rd" name="text_status_<%=index_no %>" value="否">否
     	</td>
     	<td align="center">
     		<input type="radio" class="rd" name="electron_status_<%=index_no %>" value="是">是&nbsp;&nbsp;
     		<input type="radio" class="rd" name="electron_status_<%=index_no %>" value="否">否
     	</td>
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
