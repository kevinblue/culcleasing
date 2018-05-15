<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>签约变更审批表打印</title>
<style type="text/css">
<!--
.STYLE1 {font-family: "华文楷体";
			font-size: 16px;
}
.STYLE2 {font-family: "华文楷体"; font-weight: bold;font-size: 16px; }
-->
</style>
</head>

<body>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onClick="javascript:zy();" name="printB23"/>
<%
	String projId=getStr(request.getParameter("projId"));//编号唯一
	String projName =getStr(request.getParameter("projName"));//项目名称
	String prodRa = getStr(request.getParameter("prodRa"));
%>
<table width="650" border="0" align="center" cellspacing="0" cellpadding="5">
  <tr>
    <td colspan="2" align="center" class="STYLE2" style="font-size: 20px;">签约变更审批表</td>
  </tr>
  <tr>
    <td  width="50%" class="STYLE1">&nbsp;</td>
	<td  width="50%" align="center" class="STYLE1"><%=prodRa %></td>
  </tr>
</table>
<table  width="650"  align="center" cellpadding="3" cellspacing="0" border="1">
	<tr style="display:none">
		<td width="14%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="14%"></td>
		<td width="27%"></td>
	</tr>
  <tr>
    <td width="14%" height="30" align="center" class="STYLE1">项目名称</td>
    <td colspan="5" align="center" class="STYLE1"><%=projName %></td>
	<td width="14%" align="center" class="STYLE1">项目编号</td>
	<td width="27%" align="center" class="STYLE1"><%=projId %></td>
  </tr>
  <tr>
    <td height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">事业部门意见</td>
  </tr>
  <tr>
    <td height="134" colspan="8" class="STYLE1"><p> &nbsp;&nbsp;&nbsp;&nbsp;1、待变更合同（<strong>填写待审批的变更合同的名称</strong>）：</p>
      
      <table width="650"  align="center" cellpadding="3" cellspacing="0" border="0">
      	<%
      	String sqlstr = "select * from contract_list_info where contract_status ='启用' and contract_type <>'咨询服务报告' and (isseal != '1' or isseal is null) and proj_id ='"+ projId +"' ";
      	ResultSet rs = db.executeQuery(sqlstr);
		for(int i=0;i<10;i++){%>
		<tr class="STYLE1" align="left">
			<%if( rs.next()){%>
				<td><%=rs.getString("make_contract_id") %></td>
			<%}else{%>
				<td>&nbsp;</td>	
			<%} if(rs.next()) {%>
				<td><%=rs.getString("make_contract_id") %></td>
			<%}else{%>
				<td>&nbsp;</td>
			<%}%>
		</tr>
		<%}%>
      </table>
      
      <p>&nbsp;&nbsp;&nbsp;&nbsp;2、变更的主要内容：</p>
      <p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;3、我部已审查内容：已完成对变更合同所涉及的要素（包括但不限于合作双方名称、地址、法定代表人、账号、设备名称、型号、生产厂家、设备数量、租赁成本、租金总额、租赁利率、各期租金、购买价款、支付条件等）的填写及审核，相关内容正确、无误。</p>
      <p>项目经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门经理：</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">商务部门意见</td>
  </tr>
  <tr class="STYLE1">
    <td height="101" colspan="8"><p>&nbsp;&nbsp;&nbsp;&nbsp;1、已完成审核事项：我部已就该变更合同涉及的租赁物件价格、货物交接、安装、调试、交接、维修、保险等商务条件，以及合同中涉及商务条款的变动部分全部审核完毕无误，同意签约。 </p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;2、<strong>重点提示事项</strong>： </p>
      <p>&nbsp;</p>
      <p>项目评审经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门经理：</p>
    </td>
  </tr>
</table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
 <table  width="650"  align="center" cellpadding="3" cellspacing="0" border="1">
 <tr style="display:none">
		<td width="14%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="14%"></td>
		<td width="27%"></td>
   </tr>
	 <tr>
    <td width="14%" height="30" align="center" class="STYLE1">项目名称</td>
    <td colspan="5" align="center" class="STYLE1"><%=projName %></td>
	<td width="14%" align="center" class="STYLE1">项目编号</td>
	<td width="27%" align="center" class="STYLE1"><%=projId %></td>
  </tr>
  <tr>
    <td  height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">财务部门意见</td>
  </tr>
  <tr class="STYLE1">
    <td colspan="8"><p>&nbsp;&nbsp;&nbsp;&nbsp;1、已完成审核事项：我部已就该变更合同涉及的财务报价、付款条件、票据流转及合同中涉及租金数额、起租条件、利率等财务条款的变动部分全部审核完毕无误，同意签约。 </p>
      <p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;2、<strong>重点提示事项</strong>：</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>项目评审经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门经理：</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td  height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">法务部门意见</td>
  </tr>
  <tr class="STYLE1">
    <td height="97"   colspan="8"><p>&nbsp;&nbsp;&nbsp;&nbsp;已就该项目的交易结构、交易条件和操作流程，以及所涉及的法律合同文本等全部稽核完毕，无违背现行法律之处，合同中不存在法律条款、文本上的错误。 </p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;<strong>需特别提示事项</strong>： </p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
      <p>法务经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门经理：</p>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td  height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">质控部门意见</td>
  </tr>
  <tr class="STYLE1">
    <td height="97"   colspan="8"><p>&nbsp;&nbsp;&nbsp;&nbsp;鉴于承租人经营、财务状况良好，具有较强的偿债能力；而且根据现场的考察访谈，管理层守法与信用意识较好，还款意愿真实，项目资信风险可控，同意签约，详见《资信评审报告》。 </p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;<strong>需特别提示事项</strong>： </p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
      <p>项目评审经理：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部门经理：</p>
      <p>&nbsp;</p></td>
  </tr>
</table>
 <p>&nbsp;</p>
  <p>&nbsp;</p>
  <table  width="650"  align="center" cellpadding="3" cellspacing="0" border="1">
 <tr style="display:none">
		<td width="14%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="9%"></td>
		<td width="14%"></td>
		<td width="27%"></td>
   </tr>
	 <tr>
    <td width="14%" height="30" align="center" class="STYLE1">项目名称</td>
    <td colspan="5" align="center" class="STYLE1"><%=projName %></td>
	<td width="14%" align="center" class="STYLE1">项目编号</td>
	<td width="27%" align="center" class="STYLE1"><%=projId %></td>
  </tr>
  <tr>
    <td height="20" colspan="8" align="center" bgcolor="#CCCCCC" class="STYLE2">公司审批意见</td>
  </tr>
  <tr class="STYLE1">
    <td colspan="8" height="182"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;○通过&nbsp;&nbsp;&nbsp;&nbsp;○否决&nbsp;&nbsp;&nbsp;&nbsp;○需增加、完善风险防范措施 </p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>
<input type="button" value="打印" onClick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">
function yincang(){
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
<%if(null != db){db.close();}%>