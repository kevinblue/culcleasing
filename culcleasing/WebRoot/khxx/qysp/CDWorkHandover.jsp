<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.*"%>
<%@page import="com.tenwa.datasync.vo.FundConditionVo"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>C-D工作交接联系单打印</title>
<base href="<%=basePath%>" />
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<style type="text/css">
<!--
.STYLE3 {
	font-family: "华文楷体";
	font-size: 16px;
}
.STYLE4 {
	font-family: "华文楷体";
	font-weight: bold;
	font-size: 16px;
}
-->
</style>
</head>

<body>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onClick="javascript:zy();" name="printB23"/>
<%
	String projId=getStr(request.getParameter("projId"));
	String prodRa = getStr(request.getParameter("prodRa"));
	String selectSql="select contract_id,project_name,parent_deptname,proj_manage_name from vi_contract_info where proj_id = '" + projId +"'";
	String parentDeptname = "";
	String projManageName = "";
	String projName = "";
	String contractId ="";
	ResultSet rs = db.executeQuery(selectSql);
	if(rs.next()){
		parentDeptname = rs.getString("parent_deptname");
		projManageName = rs.getString("proj_manage_name");
		projName = rs.getString("project_name");
		contractId = rs.getString("contract_id");
	}
	
%>
<table width="650" border="0" align="center" cellspacing="0" cellpadding="5">
  <tr>
    <td align="center" colspan="2" class="STYLE4" style="font-size: 20px;" >C-D工作交接联系</td>
  </tr>
  <tr>
    <td class="STYLE3" width="50%">编号：</td>
	<td class="STYLE3" width="50%">日期：<%=prodRa %></td>
  </tr>
</table>
<table  width="650"  border="1" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td height="30" align="center" class="STYLE3">出单部门</td>
    <td align="center" class="STYLE3"><%=parentDeptname %></td>
    <td align="center" class="STYLE3">经办人</td>
    <td align="center" class="STYLE3"><%=projManageName %></td>
  </tr>
  <tr>
    <td width="121" height="30" align="center" class="STYLE3">项目编号</td>
    <td width="121" align="center" class="STYLE3"><%=projId %></td>
    <td width="122" align="center" class="STYLE3">项目名称</td>
    <td width="252" align="center" class="STYLE3"><%=projName %></td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">合同签署</td>
  </tr>
  <tr>
    <td width="121" height="30" align="center" class="STYLE3">序号</td>
    <td width="121" height="30" align="center" class="STYLE3">合同编号</td>
    <td width="122" height="30" align="center" class="STYLE3">合同名称</td>
    <td width="252" height="30" align="center" class="STYLE3">签署时间</td>
  </tr>
  <tr>
    <td height="27" colspan="4" align="center" class="STYLE3">见附录</td>
  </tr>
  <tr>
    <td height="27" colspan="1" align="center" class="STYLE3">全套合同正本是否归档：</td>
    <td height="27" colspan="3" align="center" class="STYLE3">是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否</td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">商务运作先决条件</td>
  </tr>
  <tr>
    <td height="27" colspan="4" align="center" class="STYLE3">合同签署</td>
  </tr>
  <tr>
    <td  height="27" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">付款条件</td>
  </tr>
  <tr>
    <td height="37" align="center" class="STYLE3">款项内容</td>
    <td height="37" align="center" class="STYLE3">金额</td>
    <td height="37" align="center" class="STYLE3">预计支付时间</td>
    <td height="37" align="center" class="STYLE3">支付条件</td>
  </tr>
   <%
 	String queryFundCondition =
 			"select cff.payment_id,cff.fee_name,cff.plan_money,CONVERT(varchar(10),cff.plan_date,120) as plan_date,icd.title " 
 			+ " from contract_fund_fund_charge_plan cff,ifelc_conf_dictionary icd "
 			+ " where cff.fee_type = 17 "
 			+ " and cff.currency=icd.name "
 			+ " and cff.contract_id = '" 
 			+ contractId + "'";
  	List<FundConditionVo> list = new ArrayList<FundConditionVo>();
 	ResultSet rsFundCondition = db.executeQuery(queryFundCondition);
 	while(rsFundCondition.next()){
 		FundConditionVo fcv =new FundConditionVo();
 		fcv.setPaymentId(rsFundCondition.getString("payment_id"));
 		fcv.setFeeName(rsFundCondition.getString("fee_name"));
 		fcv.setPlanMoney(rsFundCondition.getDouble("plan_money"));
 		fcv.setPlanDate(rsFundCondition.getString("plan_date"));
 		fcv.setCurrencyName(rsFundCondition.getString("title"));
 		list.add(fcv);
	}
 	int paging =2;//用于控制分页
 	int len = list.size();
 	for(int i=0;i<len&&i<paging;i++){
 		FundConditionVo fcv = list.get(i);
 		String paymentId=fcv.getPaymentId();
 		String queryPaymentContent = 
 			"select payment_id,payment_content from fund_condition where payment_id = '" + paymentId + "'" ;
 		ResultSet rsPaymentContent = db.executeQuery(queryPaymentContent);
 		boolean flag =false;//fundCondition 判断表中是否有数据，如果没有就插入
 		if(rsPaymentContent.next()){
 			flag=true;
 			fcv.setPaymentContent(rsPaymentContent.getString("payment_content"));
 		}
 		//
 		if(!flag){
 			String querytitles = 
 					"select idc.title "
 					+ " from ifelc_conf_dictionary idc,contract_fund_fund_charge_condition cff"
 					+ " where idc.name = cff.pay_condition "
 					+ " and cff.payment_id = '" + paymentId + "'";
 			ResultSet rstitles= db.executeQuery(querytitles);
 			StringBuilder sb=new StringBuilder();
 			while(rstitles.next()){
 				sb.append("《");
 				sb.append(rstitles.getString("title"));
 				sb.append("》；");
 			}
 			fcv.setPaymentContent(sb.toString());
 			//fundCondition表中如果没有就插入数据
 			String insertFundCondition="insert into fund_condition (payment_id,payment_content) values ( '"
 					+ fcv.getPaymentId()+"','" + fcv.getPaymentContent()+"')";
 			db.executeUpdate(insertFundCondition);
 		}
 		%>
  <tr class="STYLE3">
    <td height="105" align="center" class="STYLE3"><%=fcv.getFeeName() %></td>
    <td height="105" align="center" class="STYLE3"><%=fcv.getCurrencyName() %><%=CurrencyUtil.convertFinance(fcv.getPlanMoney()) %></td>
    <td height="105" align="center" class="STYLE3"><%=fcv.getPlanDate() %></td>
    <td height="105" align="center" class="STYLE3" id="<%=fcv.getPaymentId() %>div">
    <!-- 隐藏aymentId -->
    <input type ="hidden" name="paymentId" value="<%=fcv.getPaymentId() %>"/>
     <!-- style="BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;" --> 
      <textarea name="paymentContent" cols="30" rows="8" class="STYLE3" style="font-size:18px; BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;"  onpropertychange="wordLimitFundCondition(this);" style="overflow:hidden"><%=fcv.getPaymentContent() %>
      </textarea>   
    </td>
  </tr>
  <%
 	}
 	%>
  </table>
  <%
 	if(len == 1){
 %>
 <table width="650" height="500" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 </table>
  <% 
 	}else{
%>
<table width="650" height="200" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 </table>
<%
 	}
%>

<!-- 第二页 -->
<table  width="650"  border="1" align="center" cellpadding="3" cellspacing="0">
<%
	if(len > 2){
%>
  <tr>
    <td width="121" height="30" align="center" class="STYLE3">项目编号</td>
    <td width="121" align="center" class="STYLE3"><%=projId %></td>
    <td width="122" align="center" class="STYLE3">项目名称</td>
    <td width="252" align="center" class="STYLE3"><%=projName %></td>
  </tr>
<%
	}
 	for(int i=paging;i<len;i++){
 		FundConditionVo fcv = list.get(i);
 		String paymentId=fcv.getPaymentId();
 		String queryPaymentContent = 
 			"select payment_id,payment_content from fund_condition where payment_id = '" + paymentId + "'" ;
 		ResultSet rsPaymentContent = db.executeQuery(queryPaymentContent);
 		boolean flag =false;//fundCondition 判断表中是否有数据，如果没有就插入
 		if(rsPaymentContent.next()){
 			flag=true;
 			fcv.setPaymentContent(rsPaymentContent.getString("payment_content"));
 		}
 		//
 		if(!flag){
 			String querytitles = 
 					"select idc.title "
 					+ " from ifelc_conf_dictionary idc,contract_fund_fund_charge_condition cff"
 					+ " where idc.name = cff.pay_condition "
 					+ " and cff.payment_id = '" + paymentId + "'";
 			ResultSet rstitles= db.executeQuery(querytitles);
 			StringBuilder sb=new StringBuilder();
 			while(rstitles.next()){
 				sb.append("《");
 				sb.append(rstitles.getString("title"));
 				sb.append("》；");
 			}
 			fcv.setPaymentContent(sb.toString());
 			//fundCondition表中如果没有就插入数据
 			String insertFundCondition="insert into fund_condition (payment_id,payment_content) values ( '"
 					+ fcv.getPaymentId()+"','" + fcv.getPaymentContent()+"')";
 			db.executeUpdate(insertFundCondition);
 		}
 		%>
  <tr class="STYLE3">
    <td height="105" align="center" class="STYLE3"><%=fcv.getFeeName() %></td>
    <td height="105" align="center" class="STYLE3"><%=fcv.getCurrencyName() %><%=CurrencyUtil.convertFinance(fcv.getPlanMoney()) %></td>
    <td height="105" align="center" class="STYLE3"><%=fcv.getPlanDate() %></td>
    <td height="105" align="center" class="STYLE3" id="<%=fcv.getPaymentId() %>div">
    <!-- 隐藏aymentId -->
    <input type ="hidden" name="paymentId" value="<%=fcv.getPaymentId() %>"/>
     <!-- style="BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;" --> 
      <textarea name="paymentContent" cols="30" rows="8" class="STYLE3" style="font-size:18px; BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;"  onpropertychange="wordLimitFundCondition(this);" style="overflow:hidden"><%=fcv.getPaymentContent() %>
      </textarea>   
    </td>
  </tr>
  <%
 	}
  %> 
  
  <!-- 位置  测试块 -->
<!--   <tr class="STYLE3">
    <td height="105" align="center" class="STYLE3">贷款</td>
    <td height="105" align="center" class="STYLE3">￥2,000,000.00</td>
    <td height="105" align="center" class="STYLE3">2013-6-28</td>
    <td height="105" align="center" class="STYLE3" id="iddiv">
    <input type ="hidden" name="paymentId" value=""/>
     style="BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;" 
      <textarea name="paymentContent" cols="30" rows="8" class="STYLE3" style="font-size:18px; BORDER-BOTTOM: 0px solid; BORDER-LEFT: 0px solid; BORDER-RIGHT: 0px solid; BORDER-TOP: 0px solid;"  onpropertychange="wordLimitFundCondition(this);" style="overflow:hidden">测试的蚊子
      </textarea>   
    </td>
  </tr> -->
  
 </table>
<%
switch(len)
{
case 3: 
case 4:
	%>
	 <table width="650" height="800" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 	</table>
	<%
	break;
case 5:
	%>
	 <table width="650" height="500" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 	</table> 
	<%
	break;
case 6:
	%>
	<table width="650" height="150" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 	</table> 
	<%
	break;
}
%>
 <!--   填充快测试 -->
<!--  <table width="650" height="800" border="0" align="center" cellspacing="0" cellpadding="5">
 	<tr>
 		<td></td>
 	</tr>
 </table> 
  -->
 
<!--   第三页 -->
  <table  width="650"  border="1" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td width="121" height="30" align="center" class="STYLE3">项目编号</td>
    <td width="121" align="center" class="STYLE3"><%=projId %></td>
    <td width="122" align="center" class="STYLE3">项目名称</td>
    <td width="252" align="center" class="STYLE3"><%=projName %></td>
  </tr>
  <tr>
    <td  height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">收款条件</td>
  </tr>
  <tr>
    <td  height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">起租</td>
  </tr>
   <%
  	String queryProjOnHire="select proj_id,contract_id,on_hire_condition,on_hire_date from proj_on_hire where proj_id = '" + projId + "'";
   	String onHireCondition = "";
   	String onHireDate = "";
   	ResultSet rsProjOnHire = db.executeQuery(queryProjOnHire);
	if(rsProjOnHire.next()){
		onHireCondition = rsProjOnHire.getString("on_hire_condition");
		onHireDate = rsProjOnHire.getString("on_hire_date");
	}
	%>  
  <tr>
    <td height="42" width="25%" colspan="1" align="center" class="STYLE3" >
    	<input type="hidden" id="projId" name="projId" value="<%=projId %>"/>
		<input type="hidden" id="contractId" name="contractId" value="<%=contractId %>"/>起租条件
    </td>
    <td  width="75%" colspan="3" align="center" class="STYLE3" >
    <input style="height:39px;width:489px" type="text" id="onHireCondition" name="onHireCondition" onpropertychange="wordLimitProjOnHire(this)" value="<%=onHireCondition==""?"&nbsp;":onHireCondition %>"/>
	</td>
  </tr>
  <tr>
    <td  width="25%" height="39" colspan="1" align="center" class="STYLE3" >起租日</td>
    <td  width="75%" height="39" colspan="3" align="center" class="STYLE3" >
    <input style="height:39px;width:489px"  type="text" id="onHireDate" name="onHireDate" onpropertychange="wordLimitProjOnHire(this)" value="<%=onHireDate==""?"&nbsp;":onHireDate %>"/>
    </td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">项目部门流转审批意见</td>
  </tr>
  <tr>
    <td height="35" colspan="4">&nbsp;&nbsp;<span class="STYLE3">&nbsp;&nbsp;项目经理（签字）：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门总经理（签字）：  </span>
    <p>&nbsp;</p>    </td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">办公室流转审批意见</td>
  </tr>
  <tr>
    <td height="81" colspan="4"><span class="STYLE3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;办公室流转审批意见：&nbsp;&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;否</span>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">质量控制部流转审批意见</td>
  </tr>
  <tr>
    <td height="45" colspan="4" class="STYLE3"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全套文件是否归档：&nbsp;&nbsp;&nbsp;&nbsp;是 &nbsp;&nbsp;&nbsp;&nbsp;否</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>    </td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">财务部流转审批意见</td>
  </tr>
  <tr>
    <td height="141" colspan="4" class="STYLE3"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全套文件是否归档：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否</p>
      <p class="STYLE3">&nbsp;&nbsp;&nbsp;&nbsp;付款条件、收款条件、起租条件是否清晰：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>    </td>
  </tr>
  <tr>
    <td height="20" colspan="4" align="center" bgcolor="#CCCCCC" class="STYLE4">商务部流转审批意见</td>
  </tr>
  <tr>
    <td height="141" colspan="4" class="STYLE3"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全套文件是否归档：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;商务运作先决条件、付款条件、收款条件、起租条件是否清晰：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;否</p>
      <p>&nbsp;</p>
    <p>&nbsp;</p>    </td>
  </tr>
</table>
 <!-- C-D交接表格结束 -->
<%db.close(); %>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">
$(function(){
	$("textarea[name='paymentContent']").each(
		function(){
			$(this).unbind().bind("blur",function(){
				var tempurl="/Tw_DataSync/servlet/FIDataSyncServlet?status=updateFundCondition";
				var $curTd=$(this).parent();//时间所在TD
				var content=$curTd.find("[name='paymentContent']").val();
				var para ={"paymentId":$curTd.find("[name='paymentId']").val()
							,"paymentContent":content};
				$.ajax({
					type: "POST",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					url: tempurl,
					data:para ,
	               // dataType:  "json",
					success: function(data){
						
					},
					error: function (data){
						alert("付款支付条件保持失败！");
					}
				}); 
			});
		}		
	);
	
	
	
	
});
function syncProjOnHire(){
	var tempurl="/Tw_DataSync/servlet/FIDataSyncServlet?status=updateProjOnHire";
	var para ={"projId":$("#projId").val()
				,"contractId":$("#contractId").val()
				,"onHireCondition":$("#onHireCondition").val()
				,"onHireDate":$("#onHireDate").val()};
	$.ajax({
		type: "POST",
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		url: tempurl,
		data:para ,
       // dataType:  "json",
		success: function(data){
			
		},
		error: function (data){
			alert("付款支付条件保存失败！");
		}
	});
}

function wordLimitFundCondition(ta){
	wordLimit(80,ta);
}
function wordLimitProjOnHire(ta){
	wordLimit(20,ta);
}
function wordLimit (len,ta){
	if(ta.value.length>len){
		ta.value = ta.value.substr(0,len); 
	}
}
function hiddenFrame(){
	/* var $divs=$("div[id$='div']");
	$divs.each(function (){
		content =$(this).children(":first").val();
		$(this).html(content);
	});*/
	var $onHireCondition = $("#onHireCondition");
	var $onHireDate = $("#onHireDate");
	if(''==$("#onHireCondition").val()){
		$("#onHireCondition").val("");
	}
	if(''==$("#onHireDate").val()){
		$("#onHireDate").val("");
	}
	$onHireCondition.parent().html($onHireCondition.val());
	$onHireDate.parent().html($onHireDate.val());
}
function yincang(){
	//同步proj_on_hire
	syncProjOnHire();
	
	//隐藏边框
	hiddenFrame();
	
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
	
	window.print();
}

function zy(){
	window.location.href = window.location.href+'&1=1';
	window.reload();
}
</script>
</html>
