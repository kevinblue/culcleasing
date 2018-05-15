<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>


<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>资金退款申请单</title>
</head>

<style type="text/css">
table{border-collapse:collapse;margin:0 10px;font-size:14px;color:black;background:#fff;font-family: "楷体_GB2312";}
table tr td{padding:0 10px;border:solid 1px black}
.autoNewLine{
 word-break: break-all;
 overflow: hidden; 
 text-overflow:ellipsis;
}
</style>

<%
SimpleDateFormat formater=new SimpleDateFormat("yyyy年MM月dd日");
String time=formater.format(new Date());
//request.setCharacterEncoding("gbk");
String isEd=getStr(request.getParameter("isEd"));//是否可编辑
String docId=getStr(request.getParameter("docId"));
String Contractid=getStr(request.getParameter("Contractid"));
String ProjectFromDept=getStr(request.getParameter("ProjectFromDept"));//出单部门
String Xmzb=getStr(request.getParameter("Xmzb"));//项目经理
String ProjectName=getStr(request.getParameter("ProjectName"));//项目名称
String NRealMoney=getStr(request.getParameter("NRealMoney"));//应收提前结清款
String NActionMoney=getStr(request.getParameter("NActionMoney"));//实际到账提前结清款
String NActionDif=getStr(request.getParameter("NActionDif"));//退还金额
String CustomerName=getStr(request.getParameter("CustomerName123"));//收款人
String JQCustBankName=getStr(request.getParameter("JQCustBankName"));//收款人银行
String JQCustBankNum=getStr(request.getParameter("JQCustBankNum"));//收款人账号
String remark="";
String sqlstr="select print_remark from contract_end_print where doc_id='"+docId+"'";

ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
 remark=java.net.URLDecoder.decode(getDBStr(rs.getString("print_remark")));
}
if(rs!=null){rs.close();}
if(db!=null){db.close();}
String url="docId="+docId+"&Contractid="+Contractid+"&ProjectFromDept="+ProjectFromDept+"&Xmzb="+Xmzb+"&ProjectName="+ProjectName+"&NRealMoney="+NRealMoney;
url=url+"&NActionMoney="+NActionMoney+"&NActionDif="+NActionDif+"&CustomerName123="+CustomerName+"&JQCustBankName="+JQCustBankName+"&JQCustBankNum="+JQCustBankNum;
%>
<body>
 <form action="contract_end_save.jsp" method="post">

<input type="hidden" name="docId" value="<%=docId %>">
<input type="hidden" name="Contractid" value="<%=Contractid %>">
<input type="hidden" name="ProjectFromDept" value="<%=ProjectFromDept %>">
<input type="hidden" name="Xmzb" value="<%=Xmzb %>">
<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
<input type="hidden" name="NRealMoney" value="<%=NRealMoney %>">
<input type="hidden" name="NActionMoney" value="<%=NActionMoney %>">
<input type="hidden" name="NActionDif" value="<%=NActionDif %>">
<input type="hidden" name="CustomerName" value="<%=CustomerName %>">
<input type="hidden" name="JQCustBankName" value="<%=JQCustBankName %>">
<input type="hidden" name="JQCustBankNum" value="<%=JQCustBankNum %>">

 <input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>
 <input type="submit" value="保存"/>
      <!-- 项目信息 -->
      <h3 align="center" style="font-family: 楷体_GB2312;">资金退款申请单</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=ProjectFromDept %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=Xmzb %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目名称</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=ProjectName %></td>
        </tr>
		
		<tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">应收提前结清款</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(NRealMoney)%></td>
        </tr>
		
		<tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">实际到账提前结清款</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(NActionMoney) %></td>
        </tr>
		
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">退还金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(NActionDif) %></td>
		  <td bgcolor="#FFFFFF" width="20%" align="center">收款人</td>
          <td bgcolor="#FFFFFF"><%=CustomerName %></td>
        </tr>

        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">收款人银行</td>
          <td bgcolor="#FFFFFF"><%=JQCustBankName %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">收款人账号</td>
          <td bgcolor="#FFFFFF"><%=JQCustBankNum %></td>
        </tr>

        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">备注及其他说明</td>
          <td bgcolor="#FFFFFF" colspan="3" class="autoNewLine" width="680px;">
		      <textarea rows="3" cols="70" name="remark" ><%=remark %></textarea>
		  </td>
        </tr>
		 
		
        <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">事业部流转审批意见</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          项目经理:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
          事业部负责人：
          </td>
        </tr>
		<!--
		 <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">商务部流转审批意见</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          商务经理:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
          商务部负责人：
          </td>
        </tr>
		-->
		 <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">财务部流转审批意见</td>
        </tr>
         <tr>
		  <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          项目执行专员:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
          项目评审专员：
          </td>
        </tr>
        <tr>
		  <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          财务部负责人:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
         
          </td>
        </tr>

        <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4"  style="background-color: green;" align="center">领导审批意见</td>
        </tr>
        <tr>
          <td colspan="4" bgcolor="#FFFFFF" height="80"></td>
        </tr>
        
      </table>
      <!-- 工单明细信息结束 -->
<p>&nbsp;</p>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB1"/>
</form>
</body>
<script type="text/javascript">
function yincang(){
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
	 
 
	window.print();
}

function zy(){
//alert(2);
	window.location.href = window.location.href+'&1=1';
	//alert(2);
	window.reload();
	//alert(1);
}
</script>
</html>