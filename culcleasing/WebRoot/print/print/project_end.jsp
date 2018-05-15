<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>


<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>合同结清申请单</title>
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
String conId=getStr(request.getParameter("conId"));//合同编号
String money1 =getStr(request.getParameter("my1"));//未偿还租金
String money2=getStr(request.getParameter("my2")) ;//罚息金额
String money3 =getStr(request.getParameter("my3"));//残值
String money4=getStr(request.getParameter("my4")) ;//保证金余额
String money5 =getStr(request.getParameter("my5"));//结清款
String money6=getStr(request.getParameter("my6"));//租金差异
String isEd=getStr(request.getParameter("isEd"));//是否可编辑
String bankName=java.net.URLDecoder.decode(getStr(request.getParameter("bName")),"utf-8");//银行
String bankAccount=getStr(request.getParameter("bAcco"));//账号
String custname=java.net.URLDecoder.decode(getStr(request.getParameter("custName123")),"UTF-8");
System.out.println("nnnnnnnnNNN"+isEd);
String sqlstr="SELECT project_name,dept_name,proj_manage_name,(SELECT COUNT(rent_list) FROM fund_rent_plan WHERE contract_id=vci.contract_id AND fund_rent_plan.plan_status='未回笼') AS rent_list,cep.print_remark,";
sqlstr = sqlstr + "( select top 1 cust_name from vi_cust_all_info where cust_id in(select pay_obj from contract_fund_fund_charge_plan";
sqlstr = sqlstr + " where contract_id=vci.contract_id and fee_type='30' and plan_status<>'已回笼') ) as cust_name ";
sqlstr = sqlstr + "FROM vi_contract_info vci left join contract_end_print cep on cep.contract_id=vci.contract_id "+
"where vci.contract_id='"+conId+"'";

ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
 %>
<body>

<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>
<%if(!isEd.equals("0")){ %>
<input type="button" value="编辑" id="upd" name="upd" onclick="javascript:window.location.href='project_end_upd.jsp?conId=<%=conId %>&my1=<%=money1 %>&my2=<%=money2 %>&my3=<%=money3 %>&my4=<%=money4 %>&my5=<%=money5 %>&my6=<%=money6 %>&custname=<%=custname %>&bankName=<%=bankName %>&bankAccount=<%=bankAccount %>'"/>
<%} %>


      <!-- 项目信息 -->
      <h3 align="center" style="font-family: 楷体_GB2312;">合同结清退款申请单</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">出单部门</td>
          <td bgcolor="#FFFFFF" width="30%"><%=getDBStr(rs.getString("dept_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">项目经理</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=getDBStr(rs.getString("proj_manage_name")) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">项目名称</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=getDBStr(rs.getString("project_name")) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">返还保证金金额</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money4) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">抵扣租金期次</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("rent_list")) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">抵扣租金金额</td>
          <td  bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money1) %></td>
        </tr>

		<tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">租金差异金额</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=CurrencyUtil.convertFinance(money6) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">罚息金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money2) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">留购价格</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money3) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">退还金额</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money5) %></td>
		  <td bgcolor="#FFFFFF" width="20%" align="center">收款人</td>
          <td bgcolor="#FFFFFF"><%=custname %></td>
        </tr>

        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">收款人银行</td>
          <td bgcolor="#FFFFFF"><%=bankName %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">收款人账号</td>
          <td bgcolor="#FFFFFF"><%=bankAccount %></td>
        </tr>

        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">备注及其他说明</td>
          <td bgcolor="#FFFFFF" colspan="3" class="autoNewLine" width="680px;"><%=java.net.URLDecoder.decode(getDBStr(rs.getString("print_remark"))) %></td>
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
		 <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">财务部流转审批意见</td>
        </tr>
         <tr>
		  <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          项目执行专员:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
          财务部负责人：
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
     <%}
     db.close();
      %>
<p>&nbsp;</p>
<input type="button" value="打印" onclick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">
function yincang(){
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
	//if(<%=isEd%>!=0){
	document.getElementsByName("upd")[0].style.display="none";
	//}
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