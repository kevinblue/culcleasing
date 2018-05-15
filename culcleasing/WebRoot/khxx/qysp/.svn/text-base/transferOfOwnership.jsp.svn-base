<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>所有权转让审批打印</title>
<script type="text/javascript" src="../../js/jquery.js"></script>
<!-- 留意时间控件 -->
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<style type="text/css">

.STYLE3 {
	font-family: "华文楷体";
	font-size: 16px;
}
.STYLE4 {
	font-family: "华文楷体";
	font-weight: bold;
	font-size: 16px;
}

</style>
</head>

<body>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onClick="javascript:zy();" name="printB23"/>
<table width="650" border="0" align="center" cellspacing="0" cellpadding="5">
  <tr>
    <td align="center" class="STYLE4" style="font-size: 20px;">所有权转让审批表</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
  </tr>
</table>
<%
	String projId=getStr(request.getParameter("projId"));
	String contractId = "";
	String makeContractId="";
	String projectName = "";
	String parentDeptname = "";
	java.util.Date startDate = null;
	double termOfLease = 0;
	double totalRent = 0;
	double finalRent = 0;
	
	String selectTransferOfOwnership = "select top 1 contract_id, make_contract_id,project_name,parent_deptname,term_of_lease,start_date,term_of_lease,total_rent,final_rent from transfer_of_ownership where proj_id = '"
			+ projId + "'";
	ResultSet rs = db.executeQuery(selectTransferOfOwnership);
	boolean flag = false;// 判断TransferOfOwnership中是否有数据
	if (rs.next()) {
		flag = true;
		contractId = rs.getString("contract_id");
		makeContractId = rs.getString("make_contract_id");
		projectName = rs.getString("project_name");
		parentDeptname = rs.getString("parent_deptname");
		startDate = rs.getDate("start_date");
		termOfLease = rs.getDouble("term_of_lease");
		totalRent = rs.getDouble("total_rent");
		finalRent = rs.getDouble("final_rent");
	}
	if (!flag) {
		String sqlviContractInfo = "select contract_id,project_name,parent_deptname from vi_contract_info where proj_id = '"
				+ projId + "'";
		ResultSet rsviContractInfo = db.executeQuery(sqlviContractInfo);
		if (rsviContractInfo.next()) {
			contractId = rsviContractInfo.getString("contract_id");
			projectName = rsviContractInfo.getString("project_name");
			parentDeptname = rsviContractInfo.getString("parent_deptname");
		}
		
		String sqlcontractListInfo = "select top 1 make_contract_id from  contract_list_info where make_contract_id like '%CULC%L%' and proj_id = '"
				+ projId + "'";
		ResultSet rscontractListInfo = db.executeQuery(sqlcontractListInfo);
		if (rscontractListInfo.next()) {
			makeContractId = rscontractListInfo
					.getString("make_contract_id");
		}
		
		String sqlcontractCondition = "select top 1 lease_term from contract_condition where contract_id = '"
				+ contractId + "'";
		ResultSet rscontractCondition = db
				.executeQuery(sqlcontractCondition);
		if (rscontractCondition.next()) {
			termOfLease = rscontractCondition.getDouble("lease_term") / 12;
		}
		String sqlbeginInfo = "select top 1 start_date from begin_info where contract_id = '"
				+ contractId + "'";
		ResultSet rsbeginInfo = db.executeQuery(sqlbeginInfo);
		if (rsbeginInfo.next()) {
			startDate = rsbeginInfo.getDate("start_date");
		}
		String sqlfundRentPlan1 = "select sum(rent) as total_rent from fund_rent_plan where contract_id = '"
				+ contractId + "'";
		ResultSet rsfundRentPlan1 = db.executeQuery(sqlfundRentPlan1);
		if (rsfundRentPlan1.next()) {
			totalRent = rsfundRentPlan1.getDouble("total_rent");
		}
		String sqlfundRentPlan2 = "select rent as final_rent from fund_rent_plan frp,(select max(plan_date) as plan_date from fund_rent_plan where contract_id = '"
				+ contractId
				+ "' ) ex where frp.plan_date = ex.plan_date and frp.contract_id= '"
				+ contractId + "'";
		ResultSet rsfundRentPlan2 = db.executeQuery(sqlfundRentPlan2);
		if (rsfundRentPlan2.next()) {
			finalRent = rsfundRentPlan2.getDouble("final_rent");
		}
}
%>  
<form id="transferOfOwnership">
  <table  width="650"  border="1" align="center" cellpadding="3" cellspacing="0">
  <tr>
    <td width="17%" height="27" align="center" class="STYLE3">项目名称</td>
    <td width="33%" align="center" class="STYLE3">
    	<input type="hidden" name="projId" value="<%=projId %>"/>
    	<input type="hidden" name="projectName" value="<%=projectName %>"/>
    	<input type="hidden" name="contractId" value="<%=contractId%>"/>
    	<%=projectName %>
    </td>
    <td width="17%" align="center" class="STYLE3">租赁合同编号</td>
    <td width="33%" align="center" class="STYLE3">
    	<input type="text" id="contractIdInput" name="makeContractId" value="<%=makeContractId %>" onpropertychange="wordLimitInput(this);"/>
    </td>
  </tr>
  <tr>
    <td height="27" align="center" class="STYLE3">租赁期限</td>
    <td align="center" class="STYLE3" >
   		<input type="text" id="termOfLeaseInput" name="termOfLease" value="<%=CurrencyUtil.convertFinance(String.valueOf(termOfLease)) %>" onpropertychange="wordLimitInput(this);"/>
    </td>
    <td align="center" class="STYLE3" >租金总额</td>
    <td align="center" class="STYLE3" >
    	<input type="text" id="totalRentInput" name="totalRent" value="<%=CurrencyUtil.convertFinance(totalRent) %>" onpropertychange="wordLimitInput(this);"/>
    </td>
  </tr>
   <tr>
    <td height="30" align="center" class="STYLE3">起租日</td>
    <td align="center" class="STYLE3" >
    	<%
    		if(startDate == null){
    			%>
    			<input type="text" id="startDateInput" name="startDate" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日'})"/>
    			<%
    		}else{
    			%>
    			<input type="text" id="startDateInput" name="startDate"
    			 readonly="readonly" 
    			 value="<%=new SimpleDateFormat("yyyy年MM月dd日").format(startDate) %>" 
    			 value="<%=startDate %>"
    			 onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日'})"/>
    			<%
    		}
    	%>
    </td>
    <td align="center" class="STYLE3" >最后一期租金金额</td>
    <td align="center" class="STYLE3" >
    	<input type="text" id="finalRentInput" name="finalRent" value="<%=CurrencyUtil.convertFinance(finalRent) %>" onpropertychange="wordLimitInput(this);"/>
    </td>
  </tr>
  <tr align="center" class="STYLE4">
    <td height="20" colspan="4" bgcolor="#CCCCCC">事业部门意见</td>
  </tr>
  <tr class="STYLE3">
    <td height="26" colspan="4">
    <input type="hidden" name="parentDeptname" value="<%=parentDeptname %>"/>
      &nbsp;&nbsp;&nbsp;&nbsp;该项目租赁期限已经结束，全部租金及残值100元已经按时足额到账，我<%=parentDeptname %>申请办理所有权转移事宜。
       <p>&nbsp;</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;项目经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门总经理：</p>
</td>
  </tr>
  
  <tr align="center" class="STYLE4">
    <td height="20" colspan="4" bgcolor="#CCCCCC">财务部门意见</td>
  </tr>
  <tr class="STYLE3">
    <td height="26" colspan="4">
      &nbsp;&nbsp;&nbsp;&nbsp;我部门已确认该项目租金总额以及设备残值100元足额到账，同意转让。
      <p>&nbsp;&nbsp;&nbsp;&nbsp;评审专员：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门总经理：</p>
        <p>&nbsp;</p>
    </td>
  </tr>
  
  <tr align="center" class="STYLE4">
    <td height="20" colspan="4" bgcolor="#CCCCCC">商务部门意见</td>
  </tr>
  <tr>
    <td height="100" colspan="4" class="STYLE3"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;《租赁物件所有权转让证书》已按照《融资租赁合同》的约定制定完毕。</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;项目评审经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门总经理：</p>
      <p>&nbsp;</p>      </td>
  </tr>
  <tr align="center" class="STYLE4">
    <td height="20" colspan="4" bgcolor="#CCCCCC">质控部意见</td>
  </tr>
  <tr>
    <td height="26" colspan="2" align="center" class="STYLE3">资产专员</td>
    <td height="26" colspan="2" align="center" class="STYLE3">资产管理部门经理</td>
  </tr>
  <tr>
    <td height="137" colspan="2" class="STYLE3"><p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资产专员：</p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
    <td height="137" colspan="2" class="STYLE3"><p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 部门经理： </p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>
</form>
<%db.close(); %>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">

function wordLimitInput(ta){
	wordLimit(20,ta);
}
function wordLimit (len,ta){
	if(ta.value.length>len){
		ta.value = ta.value.substr(0,len); 
	}
}
function syncTransferOfOwner(){
	var tempurl="/Tw_DataSync/servlet/FIDataSyncServlet?status=updateTransferOfOwner";
	var para = $("#transferOfOwnership").serialize();
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
}

function hiddenFrame(){
	$("input[id$='Input']").each(function(){
		$(this).parent().html($(this).val());
	});
}
function yincang(){
	//检查参数合法性
	var termOfLeaseValue = $.trim($("#termOfLeaseInput").val());
	while(termOfLeaseValue.indexOf(",") != -1|| termOfLeaseValue.indexOf("，") != -1){
		termOfLeaseValue = termOfLeaseValue.replace(",","");
		termOfLeaseValue = termOfLeaseValue.replace("，","");
	}
	try{
	 	Number(termOfLeaseValue);
	}catch(e){
		alert(termOfLeaseValue+"为非法内容！");
		return false;
	}
	var totalRentValue = $.trim($("#totalRentInput").val());
	while(totalRentValue.indexOf(",") != -1|| totalRentValue.indexOf("，") != -1){
		totalRentValue = totalRentValue.replace(",","");
		totalRentValue = totalRentValue.replace("，","");
	}
	try{
		Number(totalRentValue);
	}catch(e){
		alert(totalRentValue+"为非法内容！");
		return false;
	}
	var finalRentValue = $.trim($("#finalRentInput").val());
	while(finalRentValue.indexOf(",") != -1|| finalRentValue.indexOf("，") != -1){
		finalRentValue = finalRentValue.replace(",","");
		finalRentValue = finalRentValue.replace("，","");
	}
	try{
		Number(finalRentValue);
	}catch(e){
		alert(finalRentValue+"为非法内容!");
		return false;
	}
	
	//同步transferOfOwner表
	syncTransferOfOwner();
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
