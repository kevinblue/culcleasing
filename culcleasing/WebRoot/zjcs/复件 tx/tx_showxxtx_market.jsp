<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- ������ģ����ҳ -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��ͬ��Ϣ - ��Ϣǰ��Ա�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script type="text/javascript">
	//��Ϣ�ع�
	function tiaoxi_hg(){
		if(confirm("�Ƿ���е�Ϣ�ع�����?")){
			var sql_where = document.getElementById('sql_where').value;
			var contract_id = document.getElementById('contract_id').value;
			form1.action = "tx_back.jsp?sql_where="+sql_where+"&contract_id="+contract_id;
			form1.target = "_blank";
			form1.submit();
		}
	}
</script>
<script>
</script>
</head>
<%
    //ͨ���������ڱ�fund_adjust_interest_contract�в�ѯ��Ӧ��measure_id
	String custId = getStr(request.getParameter("custId")); 
	String start_date = getStr(request.getParameter("start_date")); //��Ϣ��ʼ����
	String contract_id = getStr(request.getParameter("contract_id")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); //�Ƿ��Ϣ���
	System.out.println("adjust_flag=====>"+adjust_flag);
	ResultSet rs;
	StringBuffer sql_first = new StringBuffer();//��Ϣǰ�б�SQL
	StringBuffer sql_last = new StringBuffer();//��Ϣ��
	
	//2010-12-10 �������� ��ѯ�¾�����
	String query_rate = " select before_rate,after_rate,isHG,hgCreateDate,hgCreator from fund_adjust_interest_contract where contract_id = '"+contract_id+"' and adjust_id = '"+custId+"'  ";
	ResultSet rs_r = null;
	String before_rate = ""; //��
	String after_rate = "";//��
	String isHG = "";//�Ƿ�ع�
	String hgCreateDate = "";//�ع�ʱ��
	String hgCreator = "";//�ع���
	rs_r = db.executeQuery(query_rate);
 	while(rs_r.next()){
 		before_rate = getDBStr(rs_r.getString("before_rate"));
 		after_rate = getDBStr(rs_r.getString("after_rate"));
 		isHG = getDBStr(rs_r.getString("isHG"));
 		hgCreateDate = getDBDateStr(rs_r.getString("hgCreateDate"));
 		hgCreator = getDBStr(rs_r.getString("hgCreator"));
 	}
 	if(isHG.equals("") || isHG == null){
 		isHG = "��";
 	}
 	//��ѯ��¼�� ���ݵ�¼ID
 	String query_userName = " select * from base_user  where id = '"+hgCreator+"'";
 	rs_r = db.executeQuery(query_userName);
 	String  name = "";
 	while(rs_r.next()){
 		name = getDBStr(rs_r.getString("name"));
 	}
 	rs_r.close();
 	
	StringBuffer query_TXsql = new StringBuffer();//��ѯ ��Ϣ��ʼ����
	query_TXsql.append(" select min(rent_list) as rent_list from fund_rent_plan ")
				.append(" where contract_id = '"+contract_id+"' ")
	            .append("  and plan_date > '"+start_date+"' ")//plan_date > ��Ϣ��ʼ���� 
	            .append(" and plan_status = 'δ����' ");
	System.out.println("query_TXsql===>>  "+query_TXsql.toString());
 	rs = db.executeQuery(query_TXsql.toString());
 	String rent_num = "";//��Ϣ��ʼ����
 	while(rs.next()){
 		rent_num = getDBStr(rs.getString("rent_list"));
 	}
 	//������Ϣ�� ��Ϣ���ȥ��Ϣǰ
 	String end_interest = "";
 	StringBuffer sql =  new StringBuffer();
 	sql.append(" select (sum(case status when '��' then interest end) ")
 	   .append(" - ")
 	   .append(" sum(case status when 'ǰ' then interest end) )as end_interest ")
 	   .append(" from fund_rent_plan_his  ")
 	   .append(" where  mod_reason = '��Ϣ' ")
 	   .append(" and measure_id = '"+custId+"' ")
	   .append(" and  contract_id = '"+contract_id+"' ");
	ResultSet rs_one = db.executeQuery(sql.toString());
	while(rs_one.next()){
		end_interest = getDBStr(rs_one.getString("end_interest"));
	}
	rs_one.close();
	//��ѯ���׽ṹ
	String query_jyjg = " select  case   isnull(ajdustStyle,0)   when '0' then '����' when '1' then '����' when '2' then '����' when '3' then '����'  end   as ajdustStyle,case measure_type when '1' then '�ȶ����' end as measure_type from  contract_condition where contract_id = '"+contract_id+"'  and measure_type <> '0'";
	ResultSet  rs_cc = db.executeQuery(query_jyjg);
	String measure_type = "";//�ֶμ��㷽��
	String ajdustStyle = "";//��Ϣ��ʽ
	while(rs_cc.next()){
		measure_type = getDBStr(rs_cc.getString("measure_type"));
		ajdustStyle = getDBStr(rs_cc.getString("ajdustStyle"));
	}
	rs_cc.close();
 %>
<body style="overflow:auto;"> 
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle" align="left">��ͬ��Ϣǰ��Ա�</td>
</tr>
<tr>
<td align=center width=100% height=100% valign="top">
<form name="form1" method="post"  onSubmit="return false;">
<input type="hidden" id="adjust_flag" name="adjust_flag" value="<%=adjust_flag %>"/>  
<input type="hidden" id="custId" name="custId" value="<%=custId %>"/>  
<input type="hidden" id="contract_id" name="contract_id" value="<%=contract_id %>"/>  
<input type="hidden" id="sql_where" name="sql_where" value="<%="and mod_reason = '��Ϣ'  and status = 'ǰ' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'"%>"/>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="maintab_content_table">  
<% if(!"��".equals(adjust_flag) && !isHG.equals("��")){
%>	
	<tr scope="row" align="left">
		<td	colspan=2">
			<a href="#" onclick="tiaoxi_hg();">
            	<img src="../../images/sbtn_yijiao.gif" alt="��Ϣ�ع�" border="0" align="absmiddle" >
            </a>
		</td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">��Ϣ���ڣ�<%=getDBDateStr(start_date) %>&nbsp;&nbsp;&nbsp;��Ϣ��ʼ���<%=rent_num %>&nbsp;&nbsp;��Ϣ�Ƿ����:<%=adjust_flag %></td>
		<td>��Ϣǰ����Ϣ��Ϊ(��Ϣ�����Ϣǰ)��<%=end_interest%></td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">��Ϣǰ���ʣ�<%=before_rate%></td>
		<td>��Ϣ�����ʣ�<%=after_rate%></td>
	</tr>
<%}else{ %>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">��Ϣ���ڣ�<%=getDBDateStr(start_date) %>&nbsp;&nbsp;&nbsp;��Ϣ��ʼ���<%=rent_num %>&nbsp;&nbsp;��Ϣ�Ƿ����:<%=adjust_flag %></td>
		<td>��Ϣǰ����Ϣ��Ϊ(��Ϣ�����Ϣǰ)��0</td>
	</tr>
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">��Ϣǰ���ʣ�<%=before_rate%></td>
		<td>��Ϣ�����ʣ�<%=after_rate%></td>
	</tr>
<%} %>	
	<tr scope="row" align="left">
		<td width="50%" class="cwDLRow">�����㷽����<%=measure_type%></td>
		<td>��Ϣ��ʽ��<%=ajdustStyle%></td>
	</tr>
	<tr scope="row" align="left">
		<td width="" class="cwDLRow">�ع�״̬��<%=isHG%></td>
		<td>�ع��ˣ�<%=name%>&nbsp;&nbsp;�ع�ʱ�䣺<%=getDBDateStr(hgCreateDate)%></td>
	</tr>
	
	<tr scope="row" align="center">
		<td>��Ϣǰ�����ƻ�</td>
		<td>��Ϣ�󳥻��ƻ�</td>
	</tr>

	<tr>
<%
		String query_sum = "  select SUM(rent) as sum_rent,SUM(corpus_market) as sum_corpus,SUM(interest_market) as sum_interest from fund_rent_plan_his  where 1=1   ";
		query_sum = query_sum + " and mod_reason = '��Ϣ'  and status = 'ǰ' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'  ";
		ResultSet rs_sum = db.executeQuery(query_sum);
		String sum_rent_b = "";
		String sum_corpus_b = "";
		String sum_interest_b = "";
		while(rs_sum.next()){
			sum_rent_b = getDBStr(rs_sum.getString("sum_rent"));
			sum_corpus_b = getDBStr(rs_sum.getString("sum_corpus"));
			sum_interest_b = getDBStr(rs_sum.getString("sum_interest"));
		}
		rs_sum.close();
		//��Ϣǰ�����ƻ��б�
		sql_first.append(" select * from fund_rent_plan_his ")
			   .append(" where 1=1 ")
			   .append(" and mod_reason = '��Ϣ' ")
			   .append(" and status = 'ǰ' ")
			   .append(" and measure_id = '"+custId+"' ")
			   .append(" and  contract_id = '"+contract_id+"' ")
			   .append(" order by rent_list ");
	    System.out.println("sql_first.toString()==>>"+sql_first.toString());
 		rs = db.executeQuery(sql_first.toString());
 		rs.last();
 		int count_last = rs.getRow();
 		rs.beforeFirst();
 		if(count_last > 0){
%>

	  <td>
  	  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" width="100%" 
 class="maintab_content_table">
   				<tr class="maintab_content_table_title1">
					<th nowrap="nowrap">����</th>
					<th nowrap="nowrap">�ƻ�״̬</th>
					<th nowrap>�и�����</th>
					<th nowrap>���</th>
					<th nowrap>����</th>
					<th nowrap>��Ϣ</th>
					<th nowrap>�������</th>
				  </tr>
<%
	while(rs.next()){
%>
				<tr class="cwDLRow" >
					<td align="center" nowrap><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="center" nowrap><%=getDBStr(rs.getString("plan_status"))%></td>
					<td align="center" nowrap><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("rent")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")))%></td>
				  </tr>
<%	
	}
%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_rent_b)%></td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_corpus_b)%></td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_interest_b)%></td>
					<td align="center" nowrap>&nbsp;</td>
				  </tr>
<%	
}else{
%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>��Ϣǰ�����ƻ�������!</td>
				</tr>			  
<%} %>				  
				  
			  </table>
		  </td>
<%
		//2011-01-04���޸� ������fund_rent_plan_his �޸�Ϊ fund_rent_plan
		query_sum = "";
		query_sum = "  select SUM(rent) as sum_rent,SUM(corpus_market) as sum_corpus,SUM(interest_market) as sum_interest from fund_rent_plan_his  where 1=1   ";
		query_sum = query_sum + " and mod_reason = '��Ϣ'  and status = '��' and measure_id = '"+custId+"'  and  contract_id = '"+contract_id+"'  ";
		query_sum = query_sum + "   and  contract_id = '"+contract_id+"'  ";
		ResultSet rs_sum_a = db.executeQuery(query_sum);
		String sum_rent_a = "";
		String sum_corpus_a = "";
		String sum_interest_a = "";
		while(rs_sum_a.next()){
			sum_rent_a = getDBStr(rs_sum_a.getString("sum_rent"));
			sum_corpus_a = getDBStr(rs_sum_a.getString("sum_corpus"));
			sum_interest_a = getDBStr(rs_sum_a.getString("sum_interest"));
		}
		rs_sum_a.close();
		//��Ϣ�󳥻��ƻ��б�
		//2011-01-06 �������  �жϻع�״̬ ���� �� ��ѯ״̬Ϊ ���  �����ѯ ǰ��   
		if(!"��".equals(isHG)){
			sql_last.append(" select * from fund_rent_plan_his ")
				   .append(" where 1=1 ")
				   .append(" and mod_reason = '��Ϣ' ")
				   .append(" and status = '��' ")
				   .append(" and measure_id = '"+custId+"' ")
				   .append("  and contract_id = '"+contract_id+"' ")
			  	 	.append(" order by rent_list ");
		}else{
			sql_last.append(" select * from fund_rent_plan_his ")
				    .append(" where 1=1 ")
				    .append(" and mod_reason = '��Ϣ' ")
				    .append(" and status = 'ǰ' ")
				    .append(" and measure_id = '"+custId+"' ")
				    .append(" and  contract_id = '"+contract_id+"' ")
			   		.append(" order by rent_list ");
		}
		//֮ǰ��	 fund_rent_plan �в�ѯ
		//sql_last.append(" select * from fund_rent_plan ")
		//	   .append(" where 1=1 ")
		//	   .append("  and contract_id = '"+contract_id+"' ");
		System.out.println("sql_last.toString()==>>"+sql_last.toString());
 		rs = db.executeQuery(sql_last.toString());
 		rs.last();
 		int count_first = rs.getRow();
 		rs.beforeFirst();
%>
		  <td>
		  <table border="0" style="border-collapse:collapse;" align="center" cellpadding="0" cellspacing="0" 
 width="100%" class="maintab_content_table" >
<%
	if(count_first > 0){
%>
   				<tr class="maintab_content_table_title1">
					<th nowrap>����</th>
					<th nowrap>�ƻ�״̬</th>
					<th nowrap>�и�����</th>
					<th nowrap>���</th>
					<th nowrap>����</th>
					<th nowrap>��Ϣ</th>					
					<th nowrap>�������</th>
				  </tr>
<%
	while(rs.next()){
%>
				<tr class="cwDLRow" >
					<td align="center" nowrap><%=getDBStr(rs.getString("rent_list"))%></td>
					<td align="center" nowrap><%=getDBStr(rs.getString("plan_status"))%></td>
					<td align="center" nowrap><%=getDBDateStr(rs.getString("plan_date"))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("rent")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("interest_market")))%></td>
					<td align="center" nowrap><%=formatNumberDoubleTwo(getDBStr(rs.getString("corpus_overage_market")))%></td>
				  </tr>
<%	
	}
	%>	
				<tr class="cwDLRow" >
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>&nbsp;</td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_rent_a)%></td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_corpus_a)%></td>
					<td align="center" nowrap>�ϼ�:<%=formatNumberDoubleTwo(sum_interest_a)%></td>
					<td align="center" nowrap>&nbsp;</td>
				  </tr>
<%	
}else{
%>
	<tr class="cwDLRow" >
		<td align="center" rowspan="" nowrap>��Ϣ�󳥻��ƻ�������!</td>
	</tr>
<%	
}
	rs.close();
	db.close();
%>	
			  </table>
		  </td>
      </tr>
    </table>
<div  style="margin:12px;text-align:right;">
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td width=8 width="12">
<input name="btnClose" value="�ر�" type="button" onClick="window.close();" class="btn3_mouseout">
</td>
</tr>
</table>
</div>
   </form>
</body>
</html>
