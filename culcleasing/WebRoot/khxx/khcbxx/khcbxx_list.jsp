<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.culc.util.OperationUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ����񱨱���Ϣ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->


<body onLoad="public_onload(0);">
<form action="khcbxx_list.jsp" name="dataNav">
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="30">
    <tr class="tree_title_txt">
     	 <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	�ͻ���Ϣ &gt; ���񱨱���Ϣ</td>
    </tr>
  </table>
  <!--�������-->

<%
wherestr = "";

String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
String financial_year = getStr( request.getParameter("financial_year") );
String index_meaning=getStr(request.getParameter("index_meaning"));
String financial_subject = getStr( request.getParameter("financial_subject") );
String financial_subdata = getStr( request.getParameter("financial_subdata") );
String financial_average = getStr( request.getParameter("financial_average") );


if(cust_id!=null && !"".equals(cust_id)){
	wherestr+= " and cust_id like '%" + cust_id + "%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+= " and cust_name like '%" + cust_name + "%'";
}
if(financial_year!=null && !"".equals(financial_year)){
	wherestr+= " and financial_year like '%" + financial_year + "%'";
}
if(index_meaning!=null && !"".equals(index_meaning)){
	wherestr+= " and index_meaning like '%" + index_meaning + "%'";
}
if(financial_subject!=null && !"".equals(financial_subject)){
	wherestr+= " and financial_subject like '%" + financial_subject + "%'";
}



//Ȩ���ж�
//wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);

countSql = "select count(id) as amount from vi_finance_info where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;">  
<legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	<td>               
		�ͻ����&nbsp;<input name="cust_id" type="text" size="15" value="<%=cust_id %>">
	</td>
	<td>
		�ͻ�����&nbsp;<input name="cust_name" type="text" size="15" value="<%=cust_name %>">
	</td>	
	<td>
		��    ��&nbsp;<input name="financial_year" type="text" size="15" value="<%=financial_year %>">
    </td>
	</tr>
	
	<tr>
	<td>               
		ָ�����&nbsp;<input name="index_meaning" type="text" size="15" value="<%=index_meaning %>">
	</td>
	<td>
		���ݿ�Ŀ&nbsp;<input name="financial_subject" type="text" size="15" value="<%=financial_subject %>">
	</td>		
		<td>
		<input type="button" value="��ѯ" onclick="dataNav.submit();">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="���" onclick="clearQuery();" >
		</td>
	</tr>
	</table>
	</fieldset>
	</div>
<!--���۵���ѯ����-->


    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:3px;" >
    <tr class="maintab">
     <%if(right.CheckRight("khxx_frkh_add",dqczy)>0){%><td><a href="#" accesskey="n" onClick="dataHander('add','frkh_add.jsp',dataNav.itemselect);"><img   src="../../images/sbtn_new.gif" alt="����(Alt+N)" align="absmiddle">��&nbsp;��</a>&nbsp;</td><%}%> 
    
      <td align="left" width="90%" rowspan="2"><!--������ť��ʼ-->
  
        <!--������ť����--></td>
        <td align="right" width="20%" colspan="2"><!--��ҳ���ƿ�ʼ-->
		<%@ include file="../../public/pageSplit.jsp"%>
        </td>
    </tr>
  </table>
  <!--��ҳ���ƽ���-->
  
  <!--����ʼ-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>�ͻ����</th>
	    <th>�ͻ�����</th>
		 <th>���</th>
		 <th>���⺬��</th>
	    <th>��Ŀ</th>
	    <th>����</th>
	    <th>ƽ��ֵ</th>
		 
		<th>������1</th>
	    <th>������2</th>
	    <th>ʡ��</th>
	    <th>����</th>
		<th>����</th>
		<th>���˿�(����)</th>
	    <th>GDP����Ԫ��</th>
		<th>�����ۼ�δ��������Ԫ��</th>
		<th>��������֧�����루Ԫ��</th>
	    <th>ũ�����루Ԫ��</th>
		<th>�Ƿ��������覴�</th>
		 <th>ҵ����</th>
		<th>���������</th>
	

      </tr>
      <tbody id="data">
<%


sqlstr = "select top "+ intPageSize +"* from vi_finance_info where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_finance_info where 1=1 "+wherestr+" order by cust_name,financial_year desc ) "+wherestr ;
sqlstr += " order by cust_name,financial_year desc ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>

      <tr>
        <td align="center">
        <input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") )%>" 
        custName="<%=getDBStr( rs.getString("cust_name") ) %>"></td>
        
		<td align="center"><%=getDBStr( rs.getString("cust_id") ) %></td>
		<td align="center"><%=getDBStr( rs.getString("cust_name") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("financial_year") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("index_meaning") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_subject") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_subdata") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_average") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("guarantor_one") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("guarantor_two") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("province") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("city") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("county") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("total_population") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("financial_gdp") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("outstand_principal") ) %></td>		
		<td align="center"><%= getDBStr( rs.getString("towner_disposable_inconme") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("farmer_inconme") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("credit_blemish") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("business_department") ) %></td>
		
		<td align="center"><%= getDBStr( rs.getString("risk_evaluation_manager") ) %></td>				

		
		
      </tr>
<%}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div>
<!-- ������� -->

</form>
</body>
</html>
