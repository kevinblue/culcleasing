<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!-- �����㹫���� -->
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������ - �����ƻ����</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
	String proj_id = getStr(request.getParameter("proj_id")); //��Ŀ���
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����  "FA6FFC6AC326B1CF4825772E0027A83E";//
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ��� "2010-00002-002-175";//
	//���ú�̨����
	String model = condition.Oper_Contract_Condition_Temp(proj_id,doc_id,contract_id);
	//�ֹ������Ļ���ֱ�ӽ��������ҳ�� ���ж�
	//����Ҫ�ж� �ñ���µ����ƻ����ֹ�������������ĵ�����ʽ
	//�Ӻ�ͬ�����ʱ���в�ѯ
	String sql = " select * from contract_condition_temp where contract_id = '"
			+ contract_id + "' and measure_id = '" + doc_id + "'";
	ResultSet rs_t = db.executeQuery(sql);
	String measure_type = "";//�����㷽�� �ȶ����|�ȶ��|������|�ֹ�����","1|2|0|3"
	if (rs_t.next()) {
		measure_type = getDBStr(rs_t.getString("measure_type"));
	}
	rs_t.close();
	//��ѯ��ʽ�� ��ʽ�� �ж������ʽ���Ƿ�������� û���������ܽ��б��
	String query_sql = " select * from  fund_rent_plan where contract_id = '"+contract_id+"'";
	ResultSet rs_o = db.executeQuery(query_sql);
	rs_o.last();
	int count_data = rs_o.getRow();
	rs_o.beforeFirst();	
	//����ʽ�����ƻ����ݲ��뵽��ʱ����
	int flag = condition.init_fund_rent_plan_temp(contract_id,doc_id,proj_id);
	//��ʼ���ֽ���
	flag = condition.init_fcptemp(doc_id,contract_id);
%>  
  <body style="overflow:auto;">
 <% 
 	if("0".equals(measure_type)){
 %> 
 	<center>
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
		�ݲ�֧�������㷽ʽΪ������������!
	</div> 	
	</center>
 <% 
 	}else{
 %> 
  	<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	    <div id="tabletit" class="tabtitexp" >
			�����--��ǰ�����ƻ�
	    </div> 
	    <div id="tablesub">
			<iframe frameborder="0" name="old_plan" width="100%" height="400"
			 src="zq_oldrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id %>&proj_id=<%=proj_id%>">
			</iframe>
		</div>
		<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		�����--���е���
    	</div> 
    	<div id="tablesub">
			<iframe frameborder="0" name="ets_info" width="100%" height="100" 
			src="zq_ets.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id%>&doc_id=<%=doc_id %>">
			</iframe>
		</div>
		<div id="tablenode"> 
    	<div id="tabletit" class="tabtitexp">
    		�����--����󳥻��ƻ�
    	</div> 
    	<div id="tablesub"> 
			<iframe frameborder="0" name="new_plan" width="100%" height="700" 
			src="zibg_div_list.jsp?contract_id=<%=contract_id%>&proj_id=<%=proj_id %>&doc_id=<%=doc_id %>">
			</iframe>
		</div>
	</div>
	</div>
  	</div>
<%
	}
 %>
  </body>
</html>
<%if(null != db){db.close();}%>