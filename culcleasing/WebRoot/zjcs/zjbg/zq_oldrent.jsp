<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - �����ƻ����</title>
<!-- ���ƻ����--��ǰ���ƻ���ѯ sea  -->
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body style="overflow:auto;" >
<%
	
    String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���
    String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
    String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
    
	String sqlstrs = " select * from contract_condition where contract_id = '"+contract_id+"' "; 
	ResultSet rs_one = db.executeQuery(sqlstrs);
	System.out.println("contract_condition==>==>  : "+sqlstrs);
	String income_number = "";//�������
	while(rs_one.next()){
		income_number = getDBStr(rs_one.getString("income_number"));
		System.out.println("income_number==>==>  : "+income_number);
	}
	rs_one.close();
    String sqlstr = "";
    ResultSet rs;
	//��ѯ��ǰ�Ļ����ƻ�������ʽ��fund_rent_plan�����в�ѯ
	sqlstr = "select * from fund_rent_plan where contract_id='" + contract_id + "' order by rent_list"; 
	rs = db.executeQuery(sqlstr); 
	System.out.println("sqlstr==)))))))))))))  "+sqlstr);
 %>

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <form name="list">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>�ƻ�����</th>
		<th>����</th>
		<th>���</th>
		<th>����</th>
		<th>����(%)</th>
		<th>��Ϣ</th>
		<th>ʣ�౾��</th>
		<th>����״̬</th>
      </tr>
<%
	while(rs.next()){
%>
		<tr>
			<td align="center">
				<%=getDBDateStr(rs.getString("plan_date"))%>
			</td>
		<%
			//���ӳ�����ʱֻ�� δ����������  ���ҵ�һ�ڲ��ܽ��б��
			if(getDBStr(rs.getString("plan_status")).equals("δ����") && !getDBStr(rs.getString("rent_list")).equals("1")){ 
		%>
			<td align="center">
				<!--  ����������ֵ����Ϊ���ĵ���ţ���Ŀ��ţ�����  -->
				<a target="ets_info" 
				href="zq_ets.jsp?doc_id=<%=doc_id%>&proj_id=<%=proj_id%>&start_rent_list=<%=getDBStr(rs.getString("rent_list"))%>&contract_id=<%=contract_id%>&income_number=<%=income_number%>">
				<%=getDBStr(rs.getString("rent_list"))%>
				</a>
			</td>
		<%
			}else{ 
			//corpus_market,interest_market,corpus_overage_market
		%>
			<td align="center">
				<%=getDBStr(rs.getString("rent_list"))%>
			</td>
		<%} %>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("rent")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("corpus_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberInterest(getDBStr(rs.getString("year_rate")))%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("interest_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("corpus_overage_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=getDBStr(rs.getString("plan_status"))%>
			</td>
      </tr>
<%
	}
	rs.close();
	db.close();
%>
    </table>
</form>
</div>
</div>
</body>

</html>
