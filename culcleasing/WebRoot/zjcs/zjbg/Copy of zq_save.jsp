<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<!--  ��𳥻��ƻ����--�������ҳ  -->
<%
	//String czyid = (String)session.getAttribute("czyid");
	//String datestr = getSystemDate(0);
	
	String sqlstr;
	ResultSet rs;
	
	String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
	String contract_id = getStr(request.getParameter("contract_id"));//��Ŀ��� proj_id
	
	String start_list = getStr(request.getParameter("start_list"));//������ʼ����
	String adjust_list = getStr(request.getParameter("adjust_list"));//����������
	String year_rate = getStr(request.getParameter("year_rate"));//������
	String lease_money = getStr(request.getParameter("lease_money"));//�����ܶ�
	String handling_charge = getStr(request.getParameter("handling_charge"));//������
	String start_date = getStr(request.getParameter("start_date"));//��Ӧ����������������
	String period_type = "";// 0�ڳ���1��ĩ �� 
	String income_number_year = "";//���ⷽʽ 1�� 3�� 6���� 12��
	//���������� - ����ǰ���� = ������������� (ע��:����������Ҫ��1)
	int countDate = Integer.parseInt(adjust_list) - Integer.parseInt(start_list) + 1;//������������
	String count_adjust = String.valueOf(countDate);//������Ҫ����������
	
	handling_charge = "0";
	//�޸Ľ��׽ṹ�й�����𳥻��ƻ���������ĵġ����������ʡ��Լ������������,������Ҫ�����ټ�...............................?
	StringBuffer sql_update = new StringBuffer();
	//income_number �������  ����������year_rate 
	sql_update.append(" update contract_condition  set ")
			  .append(" income_number = '"+adjust_list+"', ")
			  .append(" year_rate = '"+year_rate+"' ")
			  .append(" where proj_id = '"+contract_id+"' ");
	db.executeUpdate(sql_update.toString());
	//��ѯ��Ҫ�����������һЩ����
	sqlstr = " select * from contract_condition where proj_id = '"+contract_id+"'  ";
	rs = db.executeQuery(sqlstr);
	sqlstr = "";
	if(rs.next()){
		period_type = getDBStr(rs.getString("period_type"));//
		income_number_year = getDBStr(rs.getString("income_number_year"));//
	}
	//*******************************************************************************************
	//���������� 
	List l_plan_date = new ArrayList();
	List l_rent = new ArrayList();
	List l_corpus = new ArrayList();
	List l_interest = new ArrayList();
	List l_corpus_overage = new ArrayList();
	//��������������
	RentCalc rent = new RentCalc();
	rent.setYear_rate(year_rate); //������   
	rent.setIncome_number(count_adjust);//���� (�Ӿ����������������)
	rent.setLease_money(lease_money);//���ʶ� (ʣ�౾���ܶ�)
	rent.setFuture_money("0");//δ��ֵ 
	rent.setPeriod_type(period_type);//1,�ڳ� 0,��δ��ֵ 
	rent.setIrr_type("2");//1,Ϊ���·ݵĴ�; 2,Ϊ��������Ĵ��� ��ʱ��2
	rent.setScale("2");//irr��С��λ�� ��ʱ����2λ
	rent.setLease_interval(income_number_year);//����� (���ⷽʽ)
	rent.setPlan_date(start_date);//������  
	//����ǰ���ֽ�������
	//???????????????????????????????????????????????????????????????????????????
	//�������
	HashMap hm = rent.getHashRentPlan(period_type);
	l_plan_date = (List)hm.get("plan_date");
	l_rent = (List)hm.get("rent");
	l_corpus = (List)hm.get("corpus");
	l_interest = (List)hm.get("interest");
	l_corpus_overage = (List)hm.get("corpus_overage");
System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^count_adjust"+count_adjust);	
	//����irr  
	String irr = "";
	irr = String.valueOf(Double.parseDouble(rent.getV_irr())*100);
	//�޸ġ����������������мƻ�IRR��ֵ
	String update_irr = "update contract_condition set plan_irr="+irr+" where proj_id='"+contract_id+"'";
	db.executeUpdate(update_irr);
	
	//�������  fund_rent_plan_temp //������ ���� �ĵ����
	StringBuffer sql_del_frpt = new StringBuffer();
	//ɾ���ӵڼ��ڿ�ʼ������𳥻��ƻ�������������б�
	sql_del_frpt.append(" delete from fund_rent_plan_temp where measure_id='"+doc_id+"'  ")
	            .append(" and contract_id ='"+contract_id+"' ")
	            .append(" and measure_id = '"+doc_id+"' ")
	            .append(" and rent_list >= '"+start_list+"' ")//�ӿ�ʼ����������ɾ�������������
	            ;//.append(" and plan_status  ");//������ڻ���������ʱδ����$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$?
	db.executeUpdate(sql_del_frpt.toString());
	for(int i=0;i<l_rent.size();i++){
	//�����ֶ�˳��:�ĵ����(������),��ͬ���,����״̬,���,����,��Ϣ,�������,������
		sqlstr="insert into fund_rent_plan_temp"+
		       "(measure_id,contract_id,"+
		       "rent_list,plan_date,plan_status,rent,corpus,"+
		       "interest,corpus_overage,year_rate) "+//�����ǽ��ŵ�����ʼ��������ʼ��
		       "select '"+doc_id+"','"+contract_id+"',"+(i+Integer.parseInt(start_list))+","+
		       "'"+l_plan_date.get(i)+"','δ����',"+l_rent.get(i)+","+
		       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
		       ""+l_corpus_overage.get(i)+","+year_rate;
//System.out.println("^^^^^^^^^^^^^^^sqlstr2====="+sqlstr);
		db.executeUpdate(sqlstr);
	}	
db.close();
%>
<script>
	opener.alert("�ɹ�!");
	//��ʱ��ˢ�¸�ҳ�����д���
	//opener.parent.location.reload();
	window.close();
</script>
