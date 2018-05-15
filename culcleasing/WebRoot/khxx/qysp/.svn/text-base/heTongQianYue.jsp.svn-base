<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>合同签约确认书打印</title>
<style type="text/css">
<!--
.STYLE1 {font-family: "华文楷体"}
.STYLE2 {font-family: "华文楷体"; font-weight: bold; }
-->
</style>
</head>

<body>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" name="printB23"/>
<%
	String projId=getStr(request.getParameter("projId"));//编号唯一
	String projName =getStr(request.getParameter("projName"));//项目名称
	String prodRa = getStr(request.getParameter("prodRa"));
%>
<!-- 项目信息 -->
<div>
  <div align="center" class="STYLE2"><h3>合同签约确认书</h3></div>
</div>
<div>
  <div align="right" class="STYLE1"><%=prodRa %></div>
</div>
<table width="650" height="551" align="center" cellpadding="3" cellspacing="0" border="1">
  <tr>
    <td width="15%" height="30"><div align="center" class="STYLE1">项目名称</div></td>
    <td width="35%"><div align="center" class="STYLE1"><%=projName %></div></td>
    <td width="15%"><div align="center" class="STYLE1">项目编号</div></td>
    <td width="35%"><div align="center" class="STYLE1"><%=projId %></div></td>
  </tr>
  <tr>
    <td height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>事业部门</strong></div></td>
  </tr>
  <tr>
    <td height="133" colspan="4"><p> &nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">该项目所有法律合同文本按照公司领导和相关部门的意见全部修改完毕；并按照公司规定，经我部三级人员审核，确认最终合同文本无误。</span></p>
      <p><span class="STYLE1">项目助理：</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">项目经理：</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>商务部门</strong></div></td>
  </tr>
  <tr>
    <td height="133" colspan="4"><p>&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">我部已就该项目合同文本涉及商务运作部门职责和涉及商务条款的变动部分加以审查、复核完毕，确认最终合同文本无误。</span></p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">确认人签字：</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td  height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>法务部门</strong></div></td>
  </tr>
  <tr>
    <td height="130" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">我部已就该项目合同文本中涉及质控部门职责和资信条款的变动部分加以审查完毕；并就事业部门按照商务部门、财务部门意见对合同条款所做的更改与变动部分进行了法律形式和文字上的稽核，确认最终合同文本无误。
    </span>
      <p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">法务经理：</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>
<p>&nbsp;</p>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB1"/>
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
