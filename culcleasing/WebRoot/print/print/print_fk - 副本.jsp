<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��Ŀ������Ϣ��ӡ</title>
</head>

<style>
table{border-collapse:collapse;margin:0 10px;font-size:12px;color:black;background:#fff;}
table tr td{padding:0 10px;border:solid 1px black}
</style>


<body>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="����ת��" onclick="javascript:zy();" id="printB23" name="printB23"/>
<%
String priId=getStr(request.getParameter("priId"));//���Ψһ
String isDebut=getStr(request.getParameter("isDebut"));//�Ƿ�����
if(isDebut.equals("1"))
isDebut="��";
else
isDebut="��";
//String offM=getStr(request.getParameter("offM"));//�ֿ۽��
String factPM=getStr(request.getParameter("factPM"));//ʵ��Ӧ�����
String bName=getStr(request.getParameter("bName"));//��������
String bNo=getStr(request.getParameter("bNo"));//�����˺�
String fDate =getStr(request.getParameter("fDate"));//ʵ�ʸ���ʱ��
String hth =getStr(request.getParameter("hth"));//��ͬ��
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
System.out.println("������"+sqlStr);
String factP="";	
if(rs.next()){
	String partSql = "select (select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')"+
	" as title,status from contract_fund_fund_charge_condition pffcct where payment_id='"+rs.getString("payment_id")+"'";
	ResultSet rs1 = db1.executeQuery(partSql);
	System.out.println("������1"+partSql);
	String payment="";
	while(rs1.next()){
		payment+=rs1.getString("title")+",";
	}
	rs1.close();
	if( !"".equals(payment) ){
		payment=payment.substring(0,payment.length()-1);
	}
	factP = "��".equals(isDebut)?factPM:rs.getString("plan_money");
 %>
      <!-- ��Ŀ��Ϣ -->
      <table align="center" cellpadding="3" cellspacing="0" >
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>��Ŀ������Ϣ </strong></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��������</td>
          <td bgcolor="#FFFFFF" width="30%"><%=getDBStr(rs.getString("dept_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%">��Ŀ����</td>
          <td bgcolor="#FFFFFF" width="30%" ><%=getDBStr(rs.getString("proj_manage_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��Ŀ���</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("proj_id")) %></td>
          <td bgcolor="#FFFFFF" width="20%">��Ŀ�������</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("board_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��Ŀ����</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=getDBStr(rs.getString("project_name")) %></td>
        </tr>
		
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>������Ϣ</strong></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">�Ƿ�����</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=isDebut %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��ͬ���</td>
          <td bgcolor="#FFFFFF"><%=hth %></td>
          <td bgcolor="#FFFFFF" width="20%">��������</td>
          <td  bgcolor="#FFFFFF"><%=getDBStr(rs.getString("fee_name")) %></td>
        </tr>

		<tr height="25">
          <td bgcolor="#FFFFFF" width="20%">�տ���</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("cust_name")) %></td>
          <td bgcolor="#FFFFFF" width="20%">��������</td>
          <td  bgcolor="#FFFFFF"><%=getDBStr(rs.getString("feetype_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">������</td>
          <td colspan="3" bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">�ƻ�֧������</td>
          <td bgcolor="#FFFFFF"><%=getDBDateStr(rs.getString("plan_date")) %></td>
          <td bgcolor="#FFFFFF" width="20%">ʵ��֧������</td>
          <td bgcolor="#FFFFFF"><%=fDate %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">Ӧ������</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
          <td bgcolor="#FFFFFF" width="20%">����ʵ�ʸ�����</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(factP) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" colspan="2"></td>
          <td bgcolor="#FFFFFF" width="20%">���ۺ���</td>
          <td bgcolor="#FFFFFF"><%=CurrencyUtil.convertFinance(factP) %></td>
        </tr>
         <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">�տ�����</td>
          <td bgcolor="#FFFFFF"><%=bName %></td>
          <td bgcolor="#FFFFFF" width="20%">�տ��˺�</td>
          <td bgcolor="#FFFFFF"><%=bNo %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��Ʊ/�ʽ�/����<br/>�����������ڵ�</td>
          <td bgcolor="#FFFFFF"></td>
          <td bgcolor="#FFFFFF" width="20%">���㷽ʽ</td>
          <td bgcolor="#FFFFFF"><%=getDBStr(rs.getString("pay_type_name")) %></td>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��������</td>
          <%if(payment!=null && !"".equals(payment)) {%>
          <td bgcolor="#FFFFFF" colspan="3" height="25"><%=payment %></td>
          <%} else{%>
          <td bgcolor="#FFFFFF" colspan="3" height="25">�޸�������</td>
          <%} %>
        </tr>
        <tr height="25">
          <td bgcolor="#FFFFFF" width="20%">��ע</td>
          <td bgcolor="#FFFFFF" colspan="3"><%=getDBStr(rs.getString("fpnote")) %></td>
        </tr>
        <tr height="25">
          <td colspan="4" bgcolor="#FFFFFF"><strong>ȷ����Ϣ</strong></td>
        </tr>
        <tr>
          <td height="50" bgcolor="#FFFFFF" colspan="4">��ҵ��ȷ��</td>
        </tr>
        <tr height="50">
          <td align="center" bgcolor="#FFFFFF">�ʲ�����Ա</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">��ҵ��������</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50" bgcolor="#FFFFFF" colspan="4">����ȷ��</td>
        </tr>
        <tr height="50">
          <td align="center" bgcolor="#FFFFFF">������</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">���񲿸�����</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">����ȷ��</td>
        </tr>
        <tr height="50px">
          <td align="center" bgcolor="#FFFFFF">��Ŀִ�й�����</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">��Ŀ����רԱ</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr height="50px">
          <td align="center" bgcolor="#FFFFFF">�����ʽ����Ա</td>
          <td bgcolor="#FFFFFF"></td>
          <td align="center" bgcolor="#FFFFFF">���񲿸�����</td>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">���ܾ���/�ܻ��ʦ</td>
        </tr>
        <tr>
          <td height="50px" bgcolor="#FFFFFF" colspan="4">��˾����</td>
        </tr>
      </table>
      <!-- ������ϸ��Ϣ���� -->
      <%}db.close(); %>
<p>&nbsp;</p>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB1"/>
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