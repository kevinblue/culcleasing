<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>项目付款信息打印</title>
</head>

<style>
table{border-collapse:collapse;margin:0 10px;font-size:12px;color:black;background:#fff;}
table tr td{padding:0 10px;border:solid 1px black}
</style>


<body>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23" name="printB23"/>
<%
String priId=getStr(request.getParameter("priId"));//编号唯一
String isDebut=getStr(request.getParameter("isDebut"));//是否坐扣
if(isDebut.equals("1"))
isDebut="是";
else
isDebut="否";
//String offM=getStr(request.getParameter("offM"));//抵扣金额
String factPM=getStr(request.getParameter("factPM"));//实际应付金额
String bName=getStr(request.getParameter("bName"));//银行名称
String bNo=getStr(request.getParameter("bNo"));//银行账号
String fDate =getStr(request.getParameter("fDate"));//实际付款时间
String hth =getStr(request.getParameter("hth"));//合同号
String col_str="ffcp.payment_id,vci.dept_name,vci.proj_manage_name,vci.proj_id,vci.board_name,vci.project_name,"+
				"fee_name,bf.feetype_name,ci.cust_name,plan_money,"+
				"bp.pay_type_name,plan_date,fpnote";
				
String sqlStr="select "+col_str+" FROM contract_fund_fund_charge_plan ffcp "+
			"LEFT JOIN vi_contract_info vci ON vci.contract_id=ffcp.contract_id "+
			"LEFT JOIN base_feetype bf ON bf.feetype_number=ffcp.fee_type "+
			"left join base_paytype bp on bp.pay_type_code=ffcp.pay_type "+
			"left join cust_info ci on ci.cust_id=ffcp.pay_obj "+
			"where ffcp.id='"+priId+"'";
ResultSet rs = db.executeQuery(sqlStr);
System.out.println("输出语句"+sqlStr);
String factP="";	
if(rs.next()){
	String partSql = "select (select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')"+
	" as title,status from contract_fund_fund_charge_condition pffcct where payment_id='"+rs.getString("payment_id")+"'";
	ResultSet rs1 = db1.executeQuery(partSql);
	System.out.println("输出语句1"+partSql);
	String payment="";
	while(rs1.next()){
		payment+=rs1.getString("title")+",";
	}
	rs1.close();
	if( !"".equals(payment) ){
		payment=payment.substring(0,payment.length()-1);
	}
	factP = "是".equals(isDebut)?factPM:rs.getString("plan_money");
 %>
      <!-- 项目信息 -->
      <table align="center" cellpadding="3" cellspacing="0" >
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>项目基本信息 </strong></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=getDBStr(rs.getString("dept_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=getDBStr(rs.getString("proj_manage_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">项目编号</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("proj_id")) %></td>
          <td bgcolor="#FFFFFF" width="20%">项目所属板块</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("board_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">项目名称</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=getDBStr(rs.getString("project_name")) %></td>
        </tr>
		
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>付款信息</strong></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">是否坐扣</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=isDebut %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">合同编号</td>
          <td bgcolor="#FFFFFF"><%=hth %></td>
          <td bgcolor="#FFFFFF" width="20%">款项名称</td>
          <td  bgcolor="#FFFFFF"><%=getDBStr(rs.getString("fee_name")) %></td>
        </tr>

		<tr height="25">
          <td bgcolor="#FFFFFF" width="20%">收款人</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("cust_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%">款项内容</td>
          <td  bgcolor="#FFFFFF"><%=getDBStr(rs.getString("feetype_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">付款金额</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">计划支付日期</td>
          <td bgcolor="#FFFFFF"><%=getDBDateStr(rs.getString("plan_date")) %></td>
          <td bgcolor="#FFFFFF" width="20%">实际支付日期</td>
          <td bgcolor="#FFFFFF"><%=fDate %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">应付款金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
          <td bgcolor="#FFFFFF" width="20%">最终实际付款金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(factP) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" colspan="2"></td>
          <td bgcolor="#FFFFFF" width="20%">坐扣后金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(factP) %></td>
        </tr>
         <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">收款银行</td>
          <td bgcolor="#FFFFFF"><%=bName %></td>
          <td bgcolor="#FFFFFF" width="20%">收款账号</td>
          <td bgcolor="#FFFFFF"><%=bNo %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">银票/资金/保函<br/>款项入账所在地</td>
          <td bgcolor="#FFFFFF"></td>
          <td bgcolor="#FFFFFF" width="20%">结算方式</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("pay_type_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">付款条件</td>
          <%if(payment!=null && !"".equals(payment)) {%>
          <td bgcolor="#FFFFFF" colspan="3" height="25"><%=payment %></td>
          <%} else{%>
          <td bgcolor="#FFFFFF" colspan="3" height="25">无付款条件</td>
          <%} %>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">备注</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=getDBStr(rs.getString("fpnote")) %></td>
        </tr>
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>确认信息</strong></td>
        </tr>
        <tr>
          <td height="50" bgcolor="#FFFFFF" colspan="4">事业部确认</td>
        </tr>
        <tr height="50">
          <td align="center" bgcolor="#FFFFFF">资产管理员</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">事业部负责人</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50" bgcolor="#FFFFFF" colspan="4">商务部确认</td>
        </tr>
        <tr height="50">
          <td align="center" bgcolor="#FFFFFF">商务经理</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">商务部负责人</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">财务部确认</td>
        </tr>
        <tr height="50px">
          <td align="center" bgcolor="#FFFFFF">项目执行管理人</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">项目评审专员</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr height="50px">
          <td align="center" bgcolor="#FFFFFF">融资资金管理员</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">财务部负责人</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">副总经理/总会计师</td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">公司审批</td>
        </tr>
      </table>
      <!-- 工单明细信息结束 -->
      <%}db.close(); %>
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
<%if(null != db1){db1.close();}%>