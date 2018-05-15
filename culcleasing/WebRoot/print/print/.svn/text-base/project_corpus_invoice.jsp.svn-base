<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>


<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>发票开具申请单</title>
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
String contract_id=getStr(request.getParameter("contract_id"));//合同编号
String isEd=getStr(request.getParameter("isEd"));//是否可编辑
String isPro=getStr(request.getParameter("isPro"));//是否专用发票
String cust_id=getStr(request.getParameter("cust_id"));//是否专用发票
String invoice_money=getStr(request.getParameter("invoice_money"));//是否专用发票
String invoice_name=getStr(request.getParameter("invoice_name"));//是否专用发票
String remark=getStr(request.getParameter("remark"));//备注

System.out.println("nnnnnnnnNNN"+isEd);
String sqlstr="SELECT * from base_taxPayer where cust_id='"+cust_id+"'";

String tax_payer_no = "";
String address = "";
String tel = "";
String bank_name = "";
String bank_no = "";

ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
tax_payer_no = getDBStr(rs.getString("tax_payer_no"));
address = getDBStr(rs.getString("address"));
tel = getDBStr(rs.getString("tel"));
bank_name = getDBStr(rs.getString("bank_name"));
bank_no = getDBStr(rs.getString("bank_no"));


}
if(!"".equals(cust_id)&&null!=cust_id){
 %>
<body>

<input type="button" value="打印" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="乱码转译" onclick="javascript:zy();" id="printB23"/>
<%if(!isEd.equals("0")){ %>
<input type="button" value="编辑" id="upd" name="upd" onclick="javascript:window.location.href='project_end_upd.jsp?conId='"/>
<%} %>

	<% if("专用发票".equals(isPro)) {%>
      <!-- 项目信息 -->
      <div id="pro_apply">
      <h3 align="center" style="font-family: 楷体_GB2312;">增值税专用发票开具申请单（仅提前开出全额本金发票时使用）</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="7" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" colspan="2" align="center"><b>发票抬头</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=invoice_name%></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>纳税人识别号</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=tax_payer_no %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>地址、电话</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=address %>,<%=tel %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>开户行及帐号</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=bank_name %>,<%=bank_no %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>款项名称</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5">本金</td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>发票金额</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%= invoice_money%></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>备注信息</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5">《融资租赁合同》编号为（<%=contract_id %>）<%=remark %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="16%" align="center"><b>财务部申请人</b></td>
          <td bgcolor="#FFFFFF" width="16%" colspan="2"  align="center"></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"><b>开票人</b></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"><b>领用人</b></td>
          <td bgcolor="#FFFFFF" width="20%"   align="center"></td>
        </tr>
      
        
      </table>
      </div>
      <%}else{%>
          <div id="pro_apply">
      <h3 align="center" style="font-family: 楷体_GB2312;">增值税普通发票开具申请单（仅提前开出全额本金发票时使用）</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="7" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          日期：<%=time %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" colspan="2" align="center"><b>发票抬头</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=invoice_name%></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>款项名称</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5">本金</b></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>发票金额</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5"><%=invoice_money %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="20%" colspan="2"  align="center"><b>备注信息</b></td>
          <td bgcolor="#FFFFFF" width="80%" colspan="5">《融资租赁合同》编号为（<%=contract_id %>）<%=remark %></td>
        </tr>
        <tr height="35">  
          <td bgcolor="#FFFFFF" width="16%" align="center"><b>财务部申请人</b></td>
          <td bgcolor="#FFFFFF" width="16%" colspan="2"  align="center"></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"><b>开票人</b></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"></td>
          <td bgcolor="#FFFFFF" width="16%"   align="center"><b>领用人</b></td>
          <td bgcolor="#FFFFFF" width="20%"   align="center"></td>
        </tr>
      
        
      </table>
      </div>
      <%} %>
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
	if(<%=isEd%>!=0){
	document.getElementsByName("upd")[0].style.display="none";
	}
	window.print();
}

function zy(){
	window.location.href = window.location.href+'&1=1';
	window.reload();
}
</script>
</html>