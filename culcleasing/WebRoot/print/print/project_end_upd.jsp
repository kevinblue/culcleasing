<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="java.util.Date"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ�������뵥�༭</title>
</head>

<style>
table{border-collapse:collapse;margin:0 10px;font-size:14px;color:black;background:#fff;font-family: "����_GB2312";}
table tr td{padding:0 10px;border:solid 1px black}
</style>

<%
SimpleDateFormat formater=new SimpleDateFormat("yyyy��MM��dd��");
String time=formater.format(new Date());
String conId=getDBStr(request.getParameter("conId"));//��ͬ���
String money1 =getDBStr(request.getParameter("my1"));//δ�������
String money2=getDBStr(request.getParameter("my2")) ;//��Ϣ���
String money3 =getDBStr(request.getParameter("my3"));//��ֵ
String money4=getDBStr(request.getParameter("my4")) ;//��֤�����
String money5 =getDBStr(request.getParameter("my5"));//�����
String money6=getDBStr(request.getParameter("my6"));//������
String bankName=getStr(request.getParameter("bankName"));//����
String bankAccount=getStr(request.getParameter("bankAccount"));//�˺�
String custname=getStr(request.getParameter("custname"));
String sqlstr="SELECT project_name,dept_name,proj_manage_name,(SELECT COUNT(rent_list) FROM fund_rent_plan WHERE contract_id=vci.contract_id AND fund_rent_plan.plan_status='δ����') AS rent_list,cep.print_remark,";
sqlstr = sqlstr + "( select top 1 cust_name from vi_cust_all_info where cust_id in(select pay_obj from contract_fund_fund_charge_plan";
sqlstr = sqlstr + " where contract_id=vci.contract_id and fee_type='30' and plan_status<>'�ѻ���') ) as cust_name ";
sqlstr = sqlstr + "FROM vi_contract_info vci left join contract_end_print cep on cep.contract_id=vci.contract_id "+
"where vci.contract_id='"+conId+"'";

ResultSet rs=db.executeQuery(sqlstr);
if(rs.next()){
 %>
<body>
<form action="project_end_save.jsp" method="post">
<input type="hidden" name="conId" value="<%=conId %>">
<input type="hidden" name="my1" value="<%=money1 %>">
<input type="hidden" name="my2" value="<%=money2 %>">
<input type="hidden" name="my3" value="<%=money3 %>">
<input type="hidden" name="my4" value="<%=money4 %>">
<input type="hidden" name="my5" value="<%=money5 %>">
<input type="hidden" name="my6" value="<%=money6 %>">

<input type="hidden" name="custName123" value="<%=custname %>">
<input type="hidden" name="bName" value="<%=bankName %>">
<input type="hidden" name="bAcco" value="<%=bankAccount %>">

<input type="button" value="����ת��" onclick="javascript:zy();" id="printB23"/>
<input type="submit" value="����"/>


      <!-- ��Ŀ��Ϣ -->
      <h3 align="center" style="font-family: ����_GB2312;">��ͬ�����˿����뵥</h3>
      <table align="center" cellpadding="3" cellspacing="0">
        <tr height="40">
          <td colspan="4" bgcolor="#FFFFFF" align="right"  style="border-left: none;border-right: none;border-top: none;">
          ���ڣ�<%=time %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">��������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=getDBStr(rs.getString("dept_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ����</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=getDBStr(rs.getString("proj_manage_name")) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ŀ����</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=getDBStr(rs.getString("project_name")) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">������֤����</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money4) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">�ֿ�����ڴ�</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("rent_list")) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">�ֿ������</td>
          <td  bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money1) %></td>
        </tr>

		<tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">��������</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=CurrencyUtil.convertFinance(money6) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">��Ϣ���</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money2) %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">�����۸�</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money3) %></td>
        </tr>
        <tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">�˻����</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(money5) %></td>
		  <td bgcolor="#FFFFFF" width="20%" align="center">�տ���</td>
          <td bgcolor="#FFFFFF"><%=custname %></td>
        </tr>

		<tr height="35">
          <td bgcolor="#FFFFFF" width="20%" align="center">�տ�������</td>
          <td bgcolor="#FFFFFF"><%=bankName %></td>
          <td bgcolor="#FFFFFF" width="20%" align="center">�տ����˺�</td>
          <td bgcolor="#FFFFFF"><%=bankAccount %></td>
        </tr>

        <tr height="70">
          <td bgcolor="#FFFFFF" width="20%" align="center">��ע������˵��</td>
          <td bgcolor="#FFFFFF"  colspan="3">
          <textarea rows="3" cols="70" name="remark" ><%=getDBStr(rs.getString("print_remark")) %></textarea>
          </td>
        </tr>

		 <tr height="25">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">������ת�������</td>
        </tr>

         <tr>
		  <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-right: none;">
          ��Ŀִ��רԱ:</td>
          <td bgcolor="#FFFFFF" height="100" colspan="2" style="padding-top: 50px;border-left:none; ">
          ���񲿸����ˣ�
          </td>
        </tr>

        <tr height="45">
          <td bgcolor="#FFFFFF" colspan="4" style="background-color: green;" align="center">��ҵ����ת�������</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" height="120" colspan="2" style="padding-top: 60px;border-right: none;">
          ��Ŀ����:</td>
          <td bgcolor="#FFFFFF" height="120" colspan="2" style="padding-top: 60px;border-left:none; ">
          ��ҵ�������ˣ�
          </td>
        </tr>
        <tr height="45">
          <td bgcolor="#FFFFFF" colspan="4"  style="background-color: green;" align="center">�쵼�������</td>
        </tr>
        <tr>
          <td colspan="4" bgcolor="#FFFFFF" height="120"></td>
        </tr>
        
      </table>
      <!-- ������ϸ��Ϣ���� -->
     <%}
     db.close();
      %>
<p>&nbsp;</p>
</form>
</body>
<script type="text/javascript">
function yincang(){
	document.getElementsByName("printB23")[0].style.display="none";
	window.print();
}

function zy(){
	window.location.href = window.location.href+'&1=1';
	window.reload();
}
</script>
</html>