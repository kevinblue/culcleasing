<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ�ƻ� - ����ǰ��</title>
<link href="../css/global.css" rel="stylesheet" type="text/css">
<script src="../js/comm.js"></script>
<script src="../js/delitem.js"></script>

<script Language="Javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../js/stleasing_function.js"></script>
<link href="../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	//�ύ��������״̬
	function updCondStatus(){
		var flag = 0;
		var erItems = "";
		var items = "";
		
		$(".allMaters>tr").each(function(i){
		    var $materTr = $(this); 
		    var text_status = $materTr.find("td>:input[name^='text_status_']:checked");
			var item = $materTr.find("td>:input[name^='it_']");
			var itemId = $materTr.find("td>:input[name^='item_']");
			//alert("text_status"+text_status.val());
			//�ж����ݵ���ȷ��
			if(text_status.val() != undefined){
				if($.trim(text_status.val())=="" ){
				//alert("��["+(i+1)+"]����Ŀ������ѡ�񽻽ӹ鵵�����");
				flag = 1;
				erItems += " ["+(i+1)+"] ";
				}
			}
			if(text_status.val() != undefined){
				items += $.trim(item.val())+"|";// ��|��ʵ����-���ֶ�
			}
		});
		//alert(items);
		if(flag!=0){
		    alert("��ȷ��ÿ1������ǰ�ᣡ���е� "+erItems+" ��û��ѡ��");
			return false;
		}else{
			$(":input[name=itemStr]").val(items.substring(0,items.length-1));
			document.form1.submit();
		}
	}
</script>
</head>

<!-- �������� -->
<%@ include file="../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id
String contract_id = getStr( request.getParameter("contract_id") );
//ģ�⸳ֵ
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
}
%>

<body onLoad="public_onload(0)" style="overflow: auto;">

<form name="form1" method="post" target="_blank" action="proj_cond_save.jsp">
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ𸶿�ǰ�� -->
<div style="margin-top: 20px;">

<div id="tabletit" class="tabtitexp" style="height: 25px;vertical-align: middle;">&nbsp;  
	�ʽ𸶿�ǰ��&nbsp;
	<img name="Changeicon" border="0" src="../images/jt_b.gif" onclick="javascript:fieldsetHidden();" 
	style="cursor:hand" title="��ʾ/��������">				 
</div> 

<!-- end cwTop -->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>&nbsp;
		<!-- -->
			<BUTTON class="btn_2" type="button" onclick="return updCondStatus();">
			<img src="../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ύ(Alt+N)">&nbsp;�ύ</button>
			
		</td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��������</th>
     <th>���</th>
	 <th>��������</th>
     <th>֧��ʱ��</th>
     <th>����</th>
     <th>������</th>
     <th>����ǰ��</th>
   </tr>
   <tbody id="allMaters">
<%
String col_str="payment_id,contract_id,pay_type_name,fee_type_name,fee_num,fee_name,plan_date,plan_money,";
col_str += "currency_name,pay_obj,pay_obj_name,pay_bank_no,pay_way,fpnote,plan_status";

sqlstr = "select "+col_str+" from vi_contract_fund_fund_charge_plan where plan_status='δ����'and pay_way='����' and contract_id='"+contract_id+"' order by fee_type";

rs = db.executeQuery(sqlstr);
int rowIndex = 2;
while ( rs.next() ) {
rowIndex++;
%>
     <tr>
     	<td align="center"><%=getDBStr(rs.getString("fee_type_name")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("fee_num")) %></td>
		<td align="center"><%=getDBStr(rs.getString("fee_name")) %></td>
     	<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("currency_name")) %></td>
     	<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("plan_money")) %></td>
     	<td align="left">
     		<%
     			String partSql = "select id,(select title from ifelc_conf_dictionary where name=pffcct.pay_condition and parentid like 'PaymentPremise%')";
				partSql += " as title,status from contract_fund_fund_charge_condition pffcct where payment_id='"+rs.getString("payment_id")+"' ";
				ResultSet rs1 = db1.executeQuery(partSql);
				
				if(rs1.next()){
					rs1.beforeFirst();
					int index_no = 10;
     		%>
     		<!-- Ƕ��table -->
     		<table border="0" cellpadding="0" cellspacing="0">
     			<tr>
     				<th>��������</th>
     				<th>״̬</th>
     			</tr>
     			<tbody class="allMaters">
     			<%
	 				while(rs1.next()){ 
	 					index_no++;
	 					%>
						<tr class="materTr_<%=rowIndex %>_<%=index_no %>">
							<td><%=getDBStr(rs1.getString("title")) %>
								<input type="hidden" name="it_<%=rowIndex %>_<%=index_no %>" value="<%=rowIndex %>_<%=index_no %>">
	     						<input type="hidden" name="item_<%=rowIndex %>_<%=index_no %>" value="<%=getDBStr(rs1.getString("id")) %>">
							</td>
							<td>
							<%if("����".equals(getDBStr(rs1.getString("status")))){ %>
							����
				     		<%}else{%>
				     		<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="����"/>
				     		����&nbsp;&nbsp;
				     		<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="δ��" 
				     		<%="δ��".equals(getDBStr(rs1.getString("status")))?"checked='checked'":"" %>>δ��&nbsp;&nbsp;
				     		<input type="radio" class="rd" name="text_status_<%=rowIndex %>_<%=index_no %>" value="���ڲ���" 
				     		<%="���ڲ���".equals(getDBStr(rs1.getString("status")))?"checked='checked'":"" %>>���ڲ���
				     		<%} %>
				     		
							</td>
						</tr>
				<%	}%>
				</tbody>
     		</table>
     			<%
				}else{
     			%>
     			�޸���ǰ��
     			<%} %>
     	</td>
     </tr>
<%}
rs.close();
%>     
     </tbody>
</table>
</div>

<div style="text-align:right;margin-top:20px;margin-right:120px;display:none;">
<BUTTON class="btn_2" type="button" onclick="return updCondStatus();">
<img src="../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ύ(Alt+N)">&nbsp;�ύ</button>
</div>


</div><!-- �����ʽ𸶿�ǰ��div -->

</form>
</body>
</html>
<%if(null != db){db.close();}%><%if(null != db1){db1.close();}%>