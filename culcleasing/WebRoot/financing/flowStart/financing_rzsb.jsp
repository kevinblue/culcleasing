<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����걨</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_startFlow(){
	//�ж��Ƿ���ѡ��
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var FinancingCrediter = $(":input[name='itemselect']:checked").attr("FinancingCrediter");
	var FinancingCreditId = $(":input[name='itemselect']:checked").attr("FinancingCreditId");

	if(	priId==undefined || priId==""){
		alert("��ѡ����Ҫ�걨��������Ϣ��");
	}else{
		window.open("http://culc.eleasing.com.cn/ELeasing/ProjectWF/Financing.nsf/OSNewFlowFromMenuSBJSP?openagent&priId="+priId+"&FinancingCrediter="+FinancingCrediter+"&FinancingCreditId="+FinancingCreditId);
	}
}
</script>
</head>


<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="financing_rzsb.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		�����걨</td>
	</tr>
</table>
<!--�������-->

<%
//wherestr = " and isnull(credit_left_money,0)>0 ";

//��ҳ��ѯ����
String crediter = getStr( request.getParameter("crediter") );

if ( crediter!=null && !"".equals(crediter) ) {
	wherestr += " and crediter like '%" + crediter + "%'";
}

countSql = "select count(credit_id) as amount from vi_select_fina_credit_FLOW_SB where 1=1 "+wherestr;
//������� - �������>0

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>���ŵ�λ:&nbsp;<input name="crediter"  type="text" size="15" value="<%=crediter %>"></td>

<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
	    	<td><a href="#" accesskey="m" onclick="sub_startFlow()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�걨(Alt+M)" align="absmiddle">�걨</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--������ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>���ŵ�λ</th>
		<th>���ű��</th>
		<th>��������</th>
        <th>���Ŷ��ʹ�÷�ʽ</th>
        
        <th>���Ŷ��</th>
        <th>���ź�ͬ��</th>
        <!-- 
        <th>״̬</th>
         -->
      </tr>
      <tbody id="data">
<%
String col_str=" isnull(vi_select_fina_credit_FLOW_SB.credit_contract_id,'') as credit_contract_id,* ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_select_fina_credit_FLOW_SB where credit_id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" credit_id from vi_select_fina_credit_FLOW_SB where 1=1 "+wherestr+" order by crediter,credit_id ) "+wherestr ;
sqlstr += " order by crediter,credit_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
      	 <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("credit_id") ) %>" 
        flag="0" FinancingCrediter="<%=getDBStr( rs.getString("crediter")) %>" 
        FinancingCreditId="<%=getDBStr( rs.getString("credit_id")) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("crediter")) %></td>	
		<td align="left"><%=getDBStr( rs.getString("credit_id")) %></td>
		<td align="center"><%=getDBStr( rs.getString("credit_type")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("credit_use_type")) %></td>	
		
		<td align="left"><%= CurrencyUtil.convertFinance( rs.getString("credit_money" )) %></td>	
		<td align="center"><%=  rs.getString("credit_contract_id" ) %></td>	
		
		<%-- 
		<td align="center">
			<font color="blue">
			δ����
			</font>
		</td>
		--%>
      </tr>
<%
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--��������-->

</form>
</body>
</html>