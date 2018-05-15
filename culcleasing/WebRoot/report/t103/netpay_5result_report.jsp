<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>��Ŀ̨��-�ۿ�δ�ɹ���ϸ��</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<body onload="public_onload(0);">
<form action="netpay_5result_report.jsp" name="dataNav">
<%
wherestr=" and 1=1 ";

int year = getInt(request.getParameter("cho_year"), getCurrentDatePart(1));
int month = getInt(request.getParameter("cho_month"), getCurrentDatePart(2));
	
sqlstr = " select distinct dld,agent_id,manufacturer from v_zzs_dld_stat ";
sqlstr+= " where proj_id in( ";
sqlstr+= " select proj_id from fund_rent_plan ";
sqlstr+= " where year(plan_date)="+year+" and month(plan_date)="+month+" ";
sqlstr+= " and day(plan_date)=5 and rent_list<>1 ";
sqlstr+= " )union ";
sqlstr+= " select '' as dld,'0' as agent_id,zzsmc as manufacturer from jb_zlwjzzs ";
sqlstr+= " order by manufacturer ";

%>

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		  ���ͳ��&gt;<font color="color:red;"><%=year %>��<%=month %>��</font>&gt;5�տۿ���
		</td>
	</tr>
</table><!--�������-->

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
				<td>
				<BUTTON class="btn_2"  type="button" onclick="exportData();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
				</td><!--������ť����-->
			</tr>
		</table><!--������ť����-->
		</td>
		<td align="right" width="90%">
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplitNoCode.jsp"%>
		<!--��ҳ���ƽ���-->	
		</td>
	</tr>
</table>
 
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
        <th>���</th>
		<th>������</th>
        <th>��������</th>
		
		<th colspan="4" style="font-weight: bold;">5�տۿ���</th>
		<th colspan="3" style="font-weight: bold;">10�տۿ���</th>
		<th colspan="3" style="font-weight: bold;">15�տۿ���</th>
	</tr>
	<tr class="maintab_content_table_title">
	    <th></th>
		<th></th>
        <th></th>
		<th colspan="4" style="font-weight: bold;color: blue;">�ۿ����</th>
		<th colspan="3" style="font-weight: bold;color: blue;">�ۿ����</th>
		<th colspan="3" style="font-weight: bold;color: blue;">�ۿ����</th>
	</tr>
	<tr class="maintab_content_table_title">
		<th></th>
		<th></th>
        <th></th>
		<th>Ӧ��</th>
		<th>�ɹ�</th>
		<th>ʧ��</th>
		<th>ʧ�ܱ���(%)</th>
		
		<th>�ɹ�</th>
		<th>ʧ��</th>
		<th>ʧ�ܱ���(%)</th>
		
		<th>�ɹ�</th>
		<th>ʧ��</th>
		<th>ʧ�ܱ���(%)</th>
	</tr>
<tbody id="data">
<%
ResultSet rs1 = null;
//=======���������======
String partSql = "";
String agent_id = "";
String zzsmc = "";
//-�ۿ����-
int rent_yk = 0;//���Ӧ��
int rent_succ = 0;//���ۿ�ɹ�
int rent_fail = 0;//���ۿ�ʧ��
double rent_fail_ratio = 0f;//���ۿ�ʧ�ܱ���

int penalty_yk = 0;//ΥԼ��Ӧ�� = δ����+�������ڽ��ڵ���20������5��֮��
int penalty_succ = 0;//ΥԼ��ۿ�ɹ�
int penalty_fail = 0;//ΥԼ��ۿ�ʧ��
double penalty_fail_ratio = 0f;//ΥԼ��ۿ�ʧ�ܱ���

//-ʧ��̨��-
int equip_fail = 0;//ʧ�� = ʧ�ܵ�����Ŀ����������̨��
int equip_fail_1 = 0;//����һ������
int equip_fail_2 = 0;//���¶�������
int equip_fail_3 = 0;//������������
int equip_fail_up3 = 0;//���³���������

//----------------

//=======���������======
int startIndex = (intPage-1)*intPageSize+1;
if ( intRowCount!=0) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	agent_id = getDBStr(rs.getString("agent_id"));
	zzsmc = getDBStr(rs.getString("manufacturer"));
%>
	<tr>
		<% if("0".equals(agent_id)){ %>
		<!-- ������С�� -->
		<td colspan="2" rowspan="2" align="center" valign="center" style="color:#10418C;font-weight:bold;"><%=zzsmc %>�ϼ�</td>
		<% }else { %>
		<td align="center" rowspan="2" align="center" valign="center"><%=startIndex++ %></td>
		<td align="center" rowspan="2" align="center" valign="center"><%=getDBStr(rs.getString("dld")) %></td>
		<% } %>
		<!-- ��� �ۿ���� -->
		<td align="center">���</td>	
		<%
			//����Ӧ��
			partSql = "select dbo.t103_rent_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_yk = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_yk+"") %></td>
		<%
			//�ɹ�
			partSql = "select dbo.t103_rent_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',2) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//ʧ��
			rent_fail = rent_yk - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio = 0f;			
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
        
        <!-- ################### 10�տۿ��� #################### -->
        <%
			//�ɹ�
			partSql = "select dbo.t103_rent_netpay_10result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//ʧ��
			rent_fail = rent_fail - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
		
		<!-- ################### 15�տۿ��� #################### -->
		<%
			//�ɹ�
			partSql = "select dbo.t103_rent_netpay_15result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				rent_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_succ+"") %></td>
		<%
			//ʧ��
			rent_fail = rent_fail - rent_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(rent_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(rent_yk!=0){
				rent_fail_ratio = rent_fail*100.00/rent_yk;
			}else{
				rent_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(rent_fail_ratio) %></td>
	</tr>
	<tr>
		<!-- ��Ϣ �ۿ���� -->
		<td align="center">��Ϣ</td>	
		<%
			//Ӧ��
			partSql = "select dbo.t103_penalty_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_yk = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_yk+"") %></td>
		<%
			//�ɹ�
			partSql = "select dbo.t103_penalty_netpay_5result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',2) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//ʧ��
			penalty_fail = penalty_yk - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>
        
        <!-- $$$$$$$$$$$$$$$$$$$$$ 10�տۿ��� $$$$$$$$$$$$$$$$$$$$$$ -->
		<%
			//�ɹ�
			partSql = "select dbo.t103_penalty_netpay_10result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//ʧ��
			penalty_fail = penalty_fail - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>

        <!-- $$$$$$$$$$$$$$$$$$$$$ 15�տۿ��� $$$$$$$$$$$$$$$$$$$$$$ -->
		<%
			//�ɹ�
			partSql = "select dbo.t103_penalty_netpay_15result("+year+","+month+",'"+agent_id+"','"+zzsmc+"',1) as amount ";
			rs1 = db1.executeQuery(partSql);
			if(rs1.next()){
				penalty_succ = rs1.getInt("amount");
			} 
			rs1.close();
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_succ+"") %></td>
		<%
			//ʧ��
			penalty_fail = penalty_fail - penalty_succ;
		%>
        <td align="center"><%=CurrencyUtil.convertIntAmount(penalty_fail+"") %></td>
		<%
			//ʧ�ܱ���=ʧ��/Ӧ��
			if(penalty_yk!=0){
				penalty_fail_ratio = penalty_fail*100.00/penalty_yk;
			}else{
				penalty_fail_ratio=0f;
			}
		%>
        <td align="center"><%=CurrencyUtil.convertFinance(penalty_fail_ratio) %></td>
	</tr>
<%
	rs.next();
	i++;
}}
rs.close(); 
db.close();
%>
</tbody>	
</table>
</div><!--�������-->
</form>
</body>
<script type="text/javascript">
 function exportData(){
 	if(confirm("�Ƿ�ȷ������excel?")){
 		dataNav.action="netpay_5result_export_save.jsp";
 		dataNav.target="_black";
 		dataNav.submit();
 		dataNav.action="netpay_5result_report.jsp";
 		dataNav.target="_self";
 	}
 }
</script>
</html>