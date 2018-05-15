<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>��Ŀ̨��-���ͳ��-20�������ۿ�</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<style type="text/css">
	tr.maintab_content_table_title2 {
		/*background-image:url(../images/pageleft_topbg_1.gif);*/
		background-color:#ffffff;
		height:25px!important;
		color:#15428B;
		text-align:center;
		border-top:1px solid #FF0000;
		position:relative;
	}
	tr.maintab_content_table_title2 th {
		background-color:#D8E6F6;
		font-weight:normal;white-space: nowrap;border:0px solid #FF0000;
	}
	.tbodyStyle {
		color:#10418C;
		font-weight:500;
		background-color: #CCFFFF;
	}
	tfoot tr td {
		color:#E74100;
		font-weight:550;
	}
	</style>
	
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="20netpay_rs_report.jsp" name="dataNav">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		  ���ͳ��&gt; 20�������ۿ�
		</td>
	</tr>
</table><!--�������-->
<%

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2));

%>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>ѡ����ݣ�&nbsp;
<select name="cho_year" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=<%=getCurrentDatePart(1) %>;i><%=getCurrentDatePart(1)-5 %>;i--){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>
<td>ѡ���·ݣ�&nbsp;
<select name="cho_month" onblur="selectToNow()">
<option value="0"></option>
<script type="text/javascript">
for(var i=1;i<=12;i++){
	document.write("<option value='"+i+"'>"+i+"</option>");
}
</script>
</select>
</td>

<td colspan="2">
<input type="button" onclick="dataNav.submit()" value="��ѯ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="���"></td>
</tr>
</table>
</fieldset>
<script type="text/javascript">
$("select[name='cho_year']").val(<%=year %>);
$("select[name='cho_month']").val(<%=month %>);
</script>
</div><!-- ��ѯ�������� -->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="javascript: alert('������˼�������У��޷�������');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				
			</tr>
		</table><!--������ť����-->
		</td>
		<td align="right" width="90%">
		</td>
	</tr>
</table>
 
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
<tr class="maintab_content_table_title">
        <th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
        
		<th colspan="2" style="font-weight: bold;">20�տۿ�</th>
		<th colspan="4" style="font-weight: bold;">20��</th>
		<th colspan="4" style="font-weight: bold;">25��</th>
		<th colspan="4" style="font-weight: bold;">30��</th>
		<th colspan="6" style="font-weight: bold;">�µ�ͳ��</th>
		<!-- 
		<th colspan="6" style="font-weight: bold;">�µ�ͳ��</th>
		 -->
	</tr>
	<tr class="maintab_content_table_title">
		<th colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </th>
	    <th align="center">����</th>
	    <th align="center">���</th>
	    <th align="center">�ɹ�����</th>
	    <th align="center">�ɹ����</th>
	    <th align="center">δ�ɹ�����</th>
	    <th align="center">δ�ɹ����</th>
	    <th align="center">�ɹ�����</th>
	    <th align="center">�ɹ����</th>
	    <th align="center">δ�ɹ�����</th>
	    <th align="center">δ�ɹ����</th>
	    <th align="center">�ɹ�����</th>
	    <th align="center">�ɹ����</th>
	    <th align="center">δ�ɹ�����</th>
	    <th align="center">δ�ɹ����</th>
	    <th align="center">�ɹ�����</th>
	    <th align="center">�ɹ����</th>
	    <th align="center">δ�ɹ�����</th>
	    <th align="center">δ�ɹ����</th>
	    <th align="center">δ�ɹ�����%</th>
	    <th align="center">δ�ɹ����%</th>
	</tr>
<tbody>
<%
//=======���������======
String partSql = "";
//-�ۿ����-
int rent_CCB_kkbs = 0;//�������ۿ����������Ŀ�Ŀ������о�����
int rent_ABC_kkbs = 0;//ũ�����ۿ����

int penalty_CCB_kkbs = 0;//���з�Ϣ�ۿ����������Ŀ�Ŀ������о�����
int penalty_ABC_kkbs = 0;//ũ�з�Ϣ�ۿ����
//-�ۿ���-
double rent_CCB_kkje = 0f;//���ۿ���
double rent_ABC_kkje = 0f;//���ۿ���

double penalty_CCB_kkje = 0f;//��Ϣ�ۿ���
double penalty_ABC_kkje = 0f;//��Ϣ�ۿ���
//-20��-
int rent_CCB_20cgbs = 0;//20�����ɹ�����
double rent_CCB_20cgje = 0f;//20�����ɹ����
int rent_CCB_20sbbs = 0;//20�����ʧ�ܱ���
double rent_CCB_20sbje = 0f;//20�����ʧ�ܽ��

int penalty_CCB_20cgbs = 0;//20��ΥԼ��ɹ�����
double penalty_CCB_20cgje = 0f;//20��ΥԼ��ɹ����
int penalty_CCB_20sbbs = 0;//20��ΥԼ��ʧ�ܱ���
double penalty_CCB_20sbje = 0f;//20��ΥԼ��ʧ�ܽ��
//-25��-
int rent_CCB_25cgbs = 0;//25�����ɹ�����
double rent_CCB_25cgje = 0f;//25�����ɹ����
int rent_CCB_25sbbs = 0;//25�����ʧ�ܱ���
double rent_CCB_25sbje = 0f;//25�����ʧ�ܽ��

int penalty_CCB_25cgbs = 0;//25��ΥԼ��ɹ�����
double penalty_CCB_25cgje = 0f;//25��ΥԼ��ɹ����
int penalty_CCB_25sbbs = 0;//25��ΥԼ��ʧ�ܱ���
double penalty_CCB_25sbje = 0f;//25��ΥԼ��ʧ�ܽ��
//-30��-
int rent_CCB_30cgbs = 0;//30�����ɹ�����
double rent_CCB_30cgje = 0f;//30�����ɹ����
int rent_CCB_30sbbs = 0;//30�����ʧ�ܱ���
double rent_CCB_30sbje = 0f;//30�����ʧ�ܽ��

int penalty_CCB_30cgbs = 0;//30��ΥԼ��ɹ�����
double penalty_CCB_30cgje = 0f;//30��ΥԼ��ɹ����
int penalty_CCB_30sbbs = 0;//30��ΥԼ��ʧ�ܱ���
double penalty_CCB_30sbje = 0f;//30��ΥԼ��ʧ�ܽ��

//-�����µ�-
int rent_CCB_00cgbs = 0;
double rent_CCB_00cgje = 0f;
int rent_CCB_00sbbs = 0;
double rent_CCB_00sbje = 0f;
double rent_CCB_a_failed_rate = 0f;
double rent_CCB_m_failed_rate = 0f;

int penalty_CCB_00cgbs = 0;
double penalty_CCB_00cgje = 0f;
int penalty_CCB_00sbbs = 0;
double penalty_CCB_00sbje = 0f;
double penalty_CCB_failed_rate = 0f;
double penalty_CCB_a_failed_rate = 0f;
double penalty_CCB_m_failed_rate = 0f;
//-ũ��ÿ�׶οۿ����-
//-20��-
int rent_ABC_20cgbs = 0;//20�����ɹ�����
double rent_ABC_20cgje = 0f;//20�����ɹ����
int rent_ABC_20sbbs = 0;//20�����ʧ�ܱ���
double rent_ABC_20sbje = 0f;//20�����ʧ�ܽ��

int penalty_ABC_20cgbs = 0;//20��ΥԼ��ɹ�����
double penalty_ABC_20cgje = 0f;//20��ΥԼ��ɹ����
int penalty_ABC_20sbbs = 0;//20��ΥԼ��ʧ�ܱ���
double penalty_ABC_20sbje = 0f;//20��ΥԼ��ʧ�ܽ��
//-25��-
int rent_ABC_25cgbs = 0;//25�����ɹ�����
double rent_ABC_25cgje = 0f;//25�����ɹ����
int rent_ABC_25sbbs = 0;//25�����ʧ�ܱ���
double rent_ABC_25sbje = 0f;//25�����ʧ�ܽ��

int penalty_ABC_25cgbs = 0;//25��ΥԼ��ɹ�����
double penalty_ABC_25cgje = 0f;//25��ΥԼ��ɹ����
int penalty_ABC_25sbbs = 0;//25��ΥԼ��ʧ�ܱ���
double penalty_ABC_25sbje = 0f;//25��ΥԼ��ʧ�ܽ��
//-30��-
int rent_ABC_30cgbs = 0;//30�����ɹ�����
double rent_ABC_30cgje = 0f;//30�����ɹ����
int rent_ABC_30sbbs = 0;//30�����ʧ�ܱ���
double rent_ABC_30sbje = 0f;//30�����ʧ�ܽ��

int penalty_ABC_30cgbs = 0;//30��ΥԼ��ɹ�����
double penalty_ABC_30cgje = 0f;//30��ΥԼ��ɹ����
int penalty_ABC_30sbbs = 0;//30��ΥԼ��ʧ�ܱ���
double penalty_ABC_30sbje = 0f;//30��ΥԼ��ʧ�ܽ��

//-ũ���µ�-
int rent_ABC_00cgbs = 0;
double rent_ABC_00cgje = 0f;
int rent_ABC_00sbbs = 0;
double rent_ABC_00sbje = 0f;
double rent_ABC_a_failed_rate = 0f;
double rent_ABC_m_failed_rate = 0f;

int penalty_ABC_00cgbs = 0;
double penalty_ABC_00cgje = 0f;
int penalty_ABC_00sbbs = 0;
double penalty_ABC_00sbje = 0f;
double penalty_ABC_failed_rate = 0f;
double penalty_ABC_a_failed_rate = 0f;
double penalty_ABC_m_failed_rate = 0f;

//-С��-
int rent_kkbs_xj = 0;//�ۿ����С�ƣ��ֿۿ����У�
double rent_kkje_xj = 0f;//�ۿ���С��
//-20��-
int rent_20cgbs_xj = 0;//20�ճɹ�С��
double rent_20cgje_xj = 0;//20�ճɹ�С��
int rent_20sbbs_xj = 0;//20��δ�ɹ�С��
double rent_20sbje_xj = 0;//20��δ�ɹ�С��
//-25��-
int rent_25cgbs_xj = 0;//25�ճɹ�С��
double rent_25cgje_xj = 0;//25�ճɹ�С��
int rent_25sbbs_xj = 0;//25��δ�ɹ�С��
double rent_25sbje_xj = 0;//25��δ�ɹ�С��
//-30��-
int rent_30cgbs_xj = 0;//30�ճɹ�С��
double rent_30cgje_xj = 0;//30�ճɹ�С��
int rent_30sbbs_xj = 0;//30��δ�ɹ�С��
double rent_30sbje_xj = 0;//30��δ�ɹ�С��

//-�µ�-
int rent_00cgbs_xj = 0;
double rent_00cgje_xj = 0;
int rent_00sbbs_xj = 0;
double rent_00sbje_xj = 0;
double rent_00sbbs_rate_xj = 0;
double rent_00sbje_rate_xj = 0;

//=======���������======
%>
	<tr>
		<td rowspan="3">����</td>
		<td align="center" nowrap="nowrap">���</td>
		<%
			//����20�տۿ�Ӧ�������� = ����20�տۿ�������+����20�տۿ�����������
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'CCB',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_kkbs+"") %></td>
        <%
     		//����20�տۿ������
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_kkje) %></td>
        <!-- &&&&&&&&&&&&20�տۿ�&&&&&&&&&&&&& -->
        <%
     		//���ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_20cgbs+"") %></td>
        <%
     		//���ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_20cgje) %></td>
         <%
     		//���δ�ɹ� = �ۿ���� - �ɹ�����
			rent_CCB_20sbbs = rent_CCB_kkbs - rent_CCB_20cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_20sbbs+"") %></td>
        <%
     		//���δ�ɹ���� = �ۿ��� - �ɹ����
			rent_CCB_20sbje = rent_CCB_kkje - rent_CCB_20cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_20sbje) %></td>
        
        <!-- &&&&&******&&&&25�տۿ�&&&******&&&& -->
        <%
     		//���ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_25cgbs+"") %></td>
        <%
     		//���ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_25cgje) %></td>
         <%
     		//���δ�ɹ� = 20��ʧ��-�ɹ�
			rent_CCB_25sbbs = rent_CCB_20sbbs - rent_CCB_25cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_25sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			rent_CCB_25sbje = rent_CCB_20sbje - rent_CCB_25cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_25sbje) %></td>
        
        <!-- &&&&%%%%%%%&&30�տۿ�&&&%%%%%%%%%&&& -->
        <%
     		//���ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_30cgbs+"") %></td>
        <%
     		//���ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_30cgje) %></td>
         <%
     		//���δ�ɹ�
			rent_CCB_30sbbs = rent_CCB_25sbbs-rent_CCB_30cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_30sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			rent_CCB_30sbje = rent_CCB_25sbje-rent_CCB_30cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_30sbje) %></td>
        <!-- &&&&%%%%%%%&&�µ׿ۿ����&&&%%%%%%%%%&&& -->
        <%
     		//���ɹ�
			partSql = "select dbo.t103_netpay_rent_00cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_00cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_00cgbs+"") %></td>
        <%
     		//���ɹ����
			partSql = "select dbo.t103_netpay_rent_00cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_CCB_00cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_00cgje) %></td>
         <%
     		//���δ�ɹ�
			rent_CCB_00sbbs = rent_CCB_kkbs - rent_CCB_00cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_CCB_00sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			rent_CCB_00sbje = rent_CCB_kkje-rent_CCB_00cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_00sbje) %></td>
        <%
     		//δ�ɹ�������
     		if(rent_CCB_kkbs!=0){
			rent_CCB_a_failed_rate = rent_CCB_00sbbs*100.00/rent_CCB_kkbs;
     		}else{ rent_CCB_a_failed_rate = 0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_a_failed_rate) %></td>
        <%
     		//���δ�ɹ����
     		if(rent_CCB_kkje!=0){
     		rent_CCB_m_failed_rate = rent_CCB_00sbje*100.00/rent_CCB_kkje;
     		}else{ rent_CCB_m_failed_rate=0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_CCB_m_failed_rate) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">��Ϣ</td>
		<%
			//����20�շ�Ϣ�ۿ����
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_kkbs+"") %></td>
        <%
     		//����20�տۿϢ���
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_kkje) %></td>
        
        <!-- $$$$$$$$$$-20�տۿ�-$$$$$$$ -->
        <%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_20cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_20cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_CCB_20sbbs = penalty_CCB_kkbs-penalty_CCB_20cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_20sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_CCB_20sbje = penalty_CCB_kkje-penalty_CCB_20cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_20sbje) %></td>
        
        <!-- $$$@@@@@@$$-25�տۿ�-$$#######$$ -->
        <%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_25cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_25cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_CCB_25sbbs = penalty_CCB_20sbbs-penalty_CCB_25cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_25sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_CCB_25sbje = penalty_CCB_20sbje - penalty_CCB_25cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_25sbje) %></td>
        
        <!-- $$$@@@@@@$$-30�տۿ�-$$#######$$ -->
        <%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_30cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'CCB',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_30cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_CCB_30sbbs = penalty_CCB_25sbbs - penalty_CCB_30cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_30sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_CCB_30sbje = penalty_CCB_25sbje-penalty_CCB_30cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_30sbje) %></td>
         <!-- &&&&%%%%%%%&&�µ׿ۿ����&&&%%%%%%%%%&&& -->
        <%
			partSql = "select dbo.t103_netpay_penalty_00cgbs("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_00cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_00cgbs+"") %></td>
        <%
			partSql = "select dbo.t103_netpay_penalty_00cgje("+year+","+month+",'CCB',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_CCB_00cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_00cgje) %></td>
         <%
     		//���δ�ɹ�
			penalty_CCB_00sbbs = penalty_CCB_kkbs-penalty_CCB_00cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_CCB_00sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			penalty_CCB_00sbje = penalty_CCB_kkje-penalty_CCB_00cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_00sbje) %></td>
        <%
     		//δ�ɹ�������
     		if(penalty_CCB_kkbs!=0){
     			penalty_CCB_a_failed_rate = penalty_CCB_00sbbs*100.00/penalty_CCB_kkbs;
     		}else{ penalty_CCB_a_failed_rate = 0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_a_failed_rate) %></td>
        <%
     		//���δ�ɹ����
     		if(rent_CCB_kkje!=0){
     			penalty_CCB_m_failed_rate = penalty_CCB_00sbje*100.00/penalty_CCB_kkje;
     		}else{ penalty_CCB_m_failed_rate=0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_CCB_m_failed_rate) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">С��</td>
		<%
			//�������ۿ�С��
			rent_kkbs_xj = rent_CCB_kkbs+penalty_CCB_kkbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//���пۿ���С��
			rent_kkje_xj = rent_CCB_kkje+penalty_CCB_kkje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		
		<!-- &&&&&&&-20��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_20cgbs_xj = rent_CCB_20cgbs + penalty_CCB_20cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_20cgje_xj = rent_CCB_20cgje + penalty_CCB_20cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_20sbbs_xj = rent_CCB_20sbbs + penalty_CCB_20sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20sbbs_xj+"") %></td>
		<%
			//δ�ɹ����С��
			rent_20sbje_xj = rent_CCB_20sbje + penalty_CCB_20sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20sbje_xj) %></td>
		
		<!-- &&&&&&&-25��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_25cgbs_xj = rent_CCB_25cgbs + penalty_CCB_25cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_25cgje_xj = rent_CCB_25cgje + penalty_CCB_25cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_25sbbs_xj = rent_CCB_25sbbs + penalty_CCB_25sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25sbbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_25sbje_xj = rent_CCB_25sbje + penalty_CCB_25sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25sbje_xj) %></td>
		
		<!-- &&&&&&&-30��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_30cgbs_xj = rent_CCB_30cgbs + penalty_CCB_30cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_30cgje_xj = rent_CCB_30cgje + penalty_CCB_30cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_30sbbs_xj = rent_CCB_30sbbs + penalty_CCB_30sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30sbbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_30sbje_xj = rent_CCB_30sbje + penalty_CCB_30sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30sbje_xj) %></td>
			<!-- &&&&&&&-�µ�ͳ��-&&&&&& -->
		<%
			rent_00cgbs_xj = rent_CCB_00cgbs + penalty_CCB_00cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_00cgbs_xj+"") %></td>
		<%
			rent_00cgje_xj = rent_CCB_00cgje + penalty_CCB_00cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00cgje_xj) %></td>
		<%
			rent_00sbbs_xj = rent_CCB_00sbbs + penalty_CCB_00sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_00sbbs_xj+"") %></td>
		<%
			rent_00sbje_xj = rent_CCB_00sbje + penalty_CCB_00sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbje_xj) %></td>
		<%
			if(rent_kkbs_xj!=0){
			rent_00sbbs_rate_xj = rent_00sbbs_xj*100.00 / rent_kkbs_xj;
			}else{ rent_00sbbs_rate_xj=0.00; }
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbbs_rate_xj) %></td>
		<%
			if(rent_kkje_xj!=0){
			rent_00sbje_rate_xj = rent_00sbje_xj*100.00 /rent_kkje_xj;
			}else{ rent_00sbje_rate_xj=0.00; }
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbje_rate_xj) %></td>
		
	</tr>
	<tr>
		<td rowspan="3">ũ��</td>
		<td align="right" nowrap="nowrap">���</td>
		<%
			//���пۿ�������
			partSql = "select dbo.t103_netpay_rent_kkbs("+year+","+month+",'ABC',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_kkbs+"") %></td>
        <%
     		//ũ��5�տۿ������
			partSql = "select dbo.t103_netpay_rent_kkje("+year+","+month+",'ABC',20) as amount";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_kkje) %></td>
        
        <!-- %#########20�տۿ�#########% -->
        <%
     		//�ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_20cgbs+"") %></td>
        <%
     		//�ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_20cgje) %></td>
         <%
     		//δ�ɹ�
			rent_ABC_20sbbs = rent_ABC_kkbs-rent_ABC_20cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_20sbbs+"") %></td>
        <%
     		//δ�ɹ����
			rent_ABC_20sbje = rent_ABC_kkje - rent_ABC_20cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_20sbje) %></td>
        
        <!-- %#########25�տۿ�#########% -->
        <%
     		//�ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_25cgbs+"") %></td>
        <%
     		//�ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_25cgje) %></td>
         <%
     		//δ�ɹ�
			rent_ABC_25sbbs = rent_ABC_20sbbs - rent_ABC_25cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_25sbbs+"") %></td>
        <%
     		//δ�ɹ����
			rent_ABC_25sbje = rent_ABC_20sbje - rent_ABC_25cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_25sbje) %></td>
        
        <!-- %#########30�տۿ�#########% -->
        <%
     		//�ɹ�
			partSql = "select dbo.t103_netpay_rent_cgbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_30cgbs+"") %></td>
        <%
     		//�ɹ����
			partSql = "select dbo.t103_netpay_rent_cgje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_30cgje) %></td>
         <%
     		//δ�ɹ�
			rent_ABC_30sbbs = rent_ABC_25sbbs - rent_ABC_30cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_30sbbs+"") %></td>
        <%
     		//δ�ɹ����
			rent_ABC_30sbje = rent_ABC_25sbje - rent_ABC_30cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_30sbje) %></td>
        <!-- &&&&%%%%%%%&&�µ׿ۿ����&&&%%%%%%%%%&&& -->
        <%
     		//���ɹ�
			partSql = "select dbo.t103_netpay_rent_00cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_00cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_00cgbs+"") %></td>
        <%
     		//���ɹ����
			partSql = "select dbo.t103_netpay_rent_00cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				rent_ABC_00cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_00cgje) %></td>
         <%
     		//���δ�ɹ�
			rent_ABC_00sbbs = rent_ABC_kkbs-rent_ABC_00cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_ABC_00sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			rent_ABC_00sbje = rent_ABC_kkje-rent_ABC_00cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_00sbje) %></td>
        <%
     		//δ�ɹ�������
     		if(rent_ABC_kkbs!=0){
			rent_ABC_a_failed_rate = rent_ABC_00sbbs*100.00/rent_ABC_kkbs;
     		}else{ rent_ABC_a_failed_rate = 0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_a_failed_rate) %></td>
        <%
     		//���δ�ɹ����
     		if(rent_ABC_kkje!=0){
     		rent_ABC_m_failed_rate = rent_ABC_00sbje*100.00/rent_ABC_kkje;
     		}else{ rent_ABC_m_failed_rate=0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(rent_ABC_m_failed_rate) %></td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap">��Ϣ</td>
		<%
			//ũ��20�շ�Ϣ�ۿ����
			partSql = "select dbo.t103_netpay_penalty_kkbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_kkbs+"") %></td>
        <%
     		//ũ��20�տۿϢ���
			partSql = "select dbo.t103_netpay_penalty_kkje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_kkje = rs.getDouble("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_kkje) %></td>
        
        <!-- $###############20�տۿ�##################$ -->
		<%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_20cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_20cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_20cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_ABC_20sbbs = penalty_ABC_kkbs-penalty_ABC_20cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_20sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_ABC_20sbje = penalty_ABC_kkje-penalty_ABC_20cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_20sbje) %></td>
        
        <!-- $###############25�տۿ�##################$ -->
		<%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_25cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',25) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_25cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_25cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_ABC_25sbbs = penalty_ABC_20sbbs-penalty_ABC_25cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_25sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_ABC_25sbje = penalty_ABC_20sbje - penalty_ABC_25cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_25sbje) %></td>
        
        <!-- $###############30�տۿ�##################$ -->
		<%
     		//ΥԼ��ɹ�
			partSql = "select dbo.t103_netpay_penalty_cgbs("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_30cgbs+"") %></td>
        <%
     		//ΥԼ��ɹ����
			partSql = "select dbo.t103_netpay_penalty_cgje("+year+","+month+",'ABC',30) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_30cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_30cgje) %></td>
         <%
     		//ΥԼ��δ�ɹ�
			penalty_ABC_30sbbs = penalty_ABC_25sbbs - penalty_ABC_30cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_30sbbs+"") %></td>
        <%
     		//ΥԼ��δ�ɹ����
			penalty_ABC_30sbje = penalty_ABC_25sbje-penalty_ABC_30cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_30sbje) %></td>
         <!-- &&&&%%%%%%%&&�µ׿ۿ����&&&%%%%%%%%%&&& -->
        <%
			partSql = "select dbo.t103_netpay_penalty_00cgbs("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_00cgbs = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_00cgbs+"") %></td>
        <%
			partSql = "select dbo.t103_netpay_penalty_00cgje("+year+","+month+",'ABC',20) as amount ";
			rs = db.executeQuery(partSql);
			if(rs.next()){
				penalty_ABC_00cgje = rs.getInt("amount");
			} 
			rs.close();
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_00cgje) %></td>
         <%
     		//���δ�ɹ�
			penalty_ABC_00sbbs = penalty_ABC_kkbs-penalty_ABC_00cgbs;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_ABC_00sbbs+"") %></td>
        <%
     		//���δ�ɹ����
			penalty_ABC_00sbje = penalty_ABC_kkje-penalty_ABC_00cgje;
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_00sbje) %></td>
        <%
     		//δ�ɹ�������
     		if(penalty_ABC_kkbs!=0){
     			penalty_ABC_a_failed_rate = penalty_ABC_00sbbs*100.00/penalty_ABC_kkbs;
     		}else{ penalty_ABC_a_failed_rate = 0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_a_failed_rate) %></td>
        <%
     		//���δ�ɹ����
     		if(penalty_ABC_kkje!=0){
     			penalty_ABC_m_failed_rate = penalty_ABC_00sbje*100.00/penalty_ABC_kkje;
     		}else{ penalty_ABC_m_failed_rate=0.00; }
		%>
        <td align="right"><%=CurrencyUtil.convertFinance(penalty_ABC_m_failed_rate) %></td>
	</tr>
	<tr class="tbodyStyle">
		<td align="right">С��</td>
		<%
			//ũ�����ۿ�С��
			rent_kkbs_xj = rent_ABC_kkbs+penalty_ABC_kkbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_kkbs_xj+"") %></td>
		<%
			//ũ�пۿ���С��
			rent_kkje_xj = rent_ABC_kkje+penalty_ABC_kkje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_kkje_xj) %></td>
		
		<!-- &&&&&&&-20��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_20cgbs_xj = rent_ABC_20cgbs + penalty_ABC_20cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_20cgje_xj = rent_ABC_20cgje + penalty_ABC_20cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_20sbbs_xj = rent_ABC_20sbbs + penalty_ABC_20sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_20sbbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_20sbje_xj = rent_ABC_20sbje + penalty_ABC_20sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_20sbje_xj) %></td>
		
		<!-- &&&&&&&-25��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_25cgbs_xj = rent_ABC_25cgbs + penalty_ABC_25cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_25cgje_xj = rent_ABC_25cgje + penalty_ABC_25cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_25sbbs_xj = rent_ABC_25sbbs + penalty_ABC_25sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_25sbbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_25sbje_xj = rent_ABC_25sbje + penalty_ABC_25sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_25sbje_xj) %></td>
		
		<!-- &&&&&&&-30��-&&&&&& -->
		<%
			//�ɹ�����С��
			rent_30cgbs_xj = rent_ABC_30cgbs + penalty_ABC_30cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30cgbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_30cgje_xj = rent_ABC_30cgje + penalty_ABC_30cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30cgje_xj) %></td>
		<%
			//δ�ɹ�����С��
			rent_30sbbs_xj = rent_ABC_30sbbs + penalty_ABC_30sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_30sbbs_xj+"") %></td>
		<%
			//�ɹ����С��
			rent_30sbje_xj = rent_ABC_30sbje + penalty_ABC_30sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_30sbje_xj) %></td>
		<!-- &&&&&&&-�µ�ͳ��-&&&&&& -->
		<%
			rent_00cgbs_xj = rent_ABC_00cgbs + penalty_ABC_00cgbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_00cgbs_xj+"") %></td>
		<%
			rent_00cgje_xj = rent_ABC_00cgje + penalty_ABC_00cgje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00cgje_xj) %></td>
		<%
			rent_00sbbs_xj = rent_ABC_00sbbs + penalty_ABC_00sbbs;
		%>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rent_00sbbs_xj+"") %></td>
		<%
			rent_00sbje_xj = rent_ABC_00sbje + penalty_ABC_00sbje;
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbje_xj) %></td>
		<%
			if(rent_kkbs_xj!=0){
			rent_00sbbs_rate_xj = rent_00sbbs_xj*100.00 / rent_kkbs_xj;
			}else{ rent_00sbbs_rate_xj=0.00; }
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbbs_rate_xj) %></td>
		<%
			if(rent_kkje_xj!=0){
			rent_00sbje_rate_xj = rent_00sbje_xj*100.00 / rent_kkje_xj;
			}else{ rent_00sbje_rate_xj=0.00; }
		%>
		<td align="right"><%=CurrencyUtil.convertFinance(rent_00sbje_rate_xj) %></td>
	</tr>
	<tr><td colspan="26">
	</td></tr>
</tbody>	
</table>

</div><!--�������-->
</form>
</body>
</html>