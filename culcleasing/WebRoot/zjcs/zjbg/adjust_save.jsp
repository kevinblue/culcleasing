<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@ page import="com.rent.*"%>
<%@page import="com.rent.calc.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<!-- ���������ҳ�治����  -->
<%
	String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	
	String sqlstr = "";
	ResultSet rs;
	String message = "";
	int flag = 0;
	
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));//
	String proj_id = getStr(request.getParameter("proj_id"));//
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//���ޱ���
	String year_rate = getZeroStr(getStr(request.getParameter("year_rate")));//������
	
	String handling_charge = getZeroStr(getStr(request.getParameter("handling_charge")));//������
	String caution_money = getZeroStr(getStr(request.getParameter("caution_money")) );//���ޱ�֤��
	String equip_amt = getZeroStr(getStr(request.getParameter("equip_amt")));//�豸��
	String start_date = getStr(request.getParameter("start_date"));//������
	String income_day = getStr(request.getParameter("income_day"));//ÿ�³�����
	String old_start_date = start_date;	//�ֽ���ʹ��
	start_date = start_date.substring(0,8)+income_day;
	
	String income_number_year = getStr(request.getParameter("income_number_year"));//���ⷽʽ
	String net_lease_money = getZeroStr(getStr(request.getParameter("net_lease_money")));//�����ʶ�
	String period_type = getZeroStr(getStr(request.getParameter("period_type")));//�ڳ�1����ĩ0��֧��
	String consulting_fee = getZeroStr(getStr(request.getParameter("consulting_fee")));//��ѯ��
	String num  = getStr(request.getParameter("count_rent_list"));//����ȷ��ÿһ��input���������ԣ�Ҳ��ԭ���м����ڵ��ж�����
	
	String zjbg0Value = getStr(request.getParameter("zjbg1"));//ȡ��һ��ѡ����ֵ ����1��ʼƴ�����ԡ�
	//�����㷽�� �ȶ����|�ȶ��|������","1|2|0"
	String measure_type = getStr(request.getParameter("measure_type"));
	//�ֽ����������Ҫ
	String creator = getStr(request.getParameter("creator"));//������
	String create_date = getStr(request.getParameter("create_date"));//��������
	String modificator = getStr(request.getParameter("modificator"));//�޸���
	String modify_date = getStr(request.getParameter("modify_date"));//�޸�����
	System.out.println("join1==>==>  : ");
	int new_rent_list = 1;//����һ��'δ����'������
	//���Ϊ�������κβ���
	if(!contract_id.equals("") || !doc_id.equals("")){	
		String now_plan_date = ""; //���յ���������ʼ����
		String now_corpus_overage = "";//���յġ�ʣ�౾���ܶ��Ϊ�����������֮һ
		String now_count_rent_list = "";//������Ҫ���㼸�ڻ����ƻ� now_count_rent_list = num(������) - '�ѻ�������'
		
	 	//ȡ�����һ��input����Ϊ'zjbg1'��ֵ,�����һ�ڻ����ƻ�����δ�����ģ�����������Ҫ�õ���ʣ�౾���ܶ���ʵ���ǡ����ޱ���
		if(((zjbg0Value.equals("") || zjbg0Value == null) && !zjbg0Value.equals("�ѻ���"))){
			now_corpus_overage = lease_money;//�������� == �����ޱ���
			now_plan_date = start_date;//�������ƻ���ʼ���ڡ� == �������ա�+��ÿ�³����ա����������ֵ
			now_count_rent_list = num;//�������� == num
			new_rent_list = 1;
		}
		//�����һ�ڻ����ƻ��ǡ��ѻ����������ҳ�����һ��δ����������������� �ҳ���Ӧ�ġ�ʣ�౾���ܶ�Լ����µ��������ڡ�
		else{
		
			//���µ��������ڡ�����Ϊ��1�ڳ�ȡ��һ�����ݵġ��������ڡ� 0��ĩȡ���еġ��������ڡ�
			StringBuffer sql = new StringBuffer();
			sql.append(" select * from fund_rent_plan_temp  ")
			   .append(" where 1 = 1 ")
			   .append(" and contract_id = '"+contract_id+"' ")//��Ŀ��� proj_id
			   .append(" and plan_status = 'δ����' ")
			   .append(" and rent_list = ( ")//����δ����������
			   					.append(" select min(rent_list) as rent_list from fund_rent_plan_temp   ")
			   					.append(" where contract_id = '"+contract_id+"'  and plan_status = 'δ����'  ")
			   	.append(" ) ")
			   	.append(" and measure_id = '"+doc_id+"' ");
			rs = db.executeQuery(sql.toString());
			
			String  now_rent_list = "";//��ʾ���һ�ڡ��ѻ������������Ǽ��� ���ڣ�����һ��'δ����'�������1
			if(rs.next()){
				new_rent_list = Integer.parseInt(getDBStr(rs.getString("rent_list")));//����һ��δ����������
				now_rent_list = String.valueOf(new_rent_list - 1);//�·���ѯ����,���ڲ�ѯ��ʣ�౾���ܶ�͡������ա�
				now_plan_date = getDBStr(rs.getString("plan_date"));//���л����ƻ��Ļ������� ��ĩȡ����
			}
			
			//��ѯ���յġ��������Լ��������ƻ���ʼ���ڡ� ����������
			String query_whlSql = " select plan_date,corpus_overage from  fund_rent_plan_temp where rent_list = '"+now_rent_list+"' ";
			query_whlSql = query_whlSql + " and contract_id = '"+contract_id+"' and measure_id = '"+doc_id+"' ";
			rs = db.executeQuery(sql.toString());
			if(rs.next()){
				//1�ڳ�ȡ��һ�����ݵġ��������ڡ� 0��ĩȡ���еġ��������ڡ� �Լ�ȡ����Ӧ��������
				if(period_type.equals("1")){
					now_plan_date = getDBStr(rs.getString("plan_date"));//��һ�л����ƻ��Ļ�������
				}//�����0��ĩ�����Ϸ��Ծ�ȷ������Ϊ��������
				now_corpus_overage = getDBStr(rs.getString("corpus_overage"));//�������ÿ����ȡ��һ�ڻ����ƻ��ı������
			}
			//������Ҫ���㼸�ڻ����ƻ� ���㷽ʽ�������� - ���һ��'�ѻ���'������  �ó�'δ����'�������Ҫ���������
			now_count_rent_list = String.valueOf(Integer.parseInt(num) - Integer.parseInt(now_rent_list));//
		}
			
		//��װ�ʽ��������ڵ�����
		List<String> list_cash = new ArrayList<String>();
		List<String> list_date = new ArrayList<String>();
		list_cash.add(handling_charge);//������
		list_date.add(start_date);
		list_cash.add("-"+consulting_fee);//��ѯ��
		list_date.add(start_date);
		list_cash.add("-"+lease_money);//���ޱ���
		list_date.add(start_date);
		
		//��װ ��������������֮����б�  �����+�������������µ�����б�
		List<String> list_cashRent = new ArrayList<String>();	
		//ѭ��ȡֵ  
		//System.out.println("join^^^^^^^^^^^^^new_rent_list^^^^^^^^^^^new_rent_listֵΪ:"+new_rent_list);
		for(int i = 1;i <= Integer.parseInt(num);i++){
			String plan_date_NameValue = "plan_date"+i;//����
			String rent_NameValue = "rent"+i;//ԭ�����
			String zjbg_NameValue = "zjbg"+i;//�Ѹ������
			//ȡԭ�����͸��ĵ���� ����µ����list ע�⣺ֻȡ��δ�������������װ�µ����list
			String zjbgValue = getStr(request.getParameter(zjbg_NameValue));
			
			if((zjbgValue.equals("") || zjbgValue == null)&& !zjbgValue.equals("�ѻ���")){
				String rentValue = getZeroStr(getStr(request.getParameter(rent_NameValue)));
				list_cashRent.add(rentValue);
			}else{
				if(zjbgValue.equals("�ѻ���") || zjbgValue.equals("���ֻ���")){//��������ѻ�������ȡ�ѻ������������ڼ���list list_cash��list_date��
					//�ѻ���������������Ҫװ�������list��
					list_cash.add(getZeroStr(getStr(request.getParameter(rent_NameValue))));//�ѻ������
					list_date.add(getStr(request.getParameter(plan_date_NameValue)));//�ѻ�����������
				}else{//��������µ����list��
					list_cashRent.add(zjbgValue);
				}
			}
		}
		
	for(int i = 0;i < list_cashRent.size();i++){
		System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^list_cashRentֵΪ:"+list_cashRent.get(i));
		System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^numֵΪ:"+num);
	}	
		
		//���������
		List l_plan_date = new ArrayList();
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();
		//�������
		RentCalc rent = new RentCalc();
		//��װ �ʽ��� ���� �豸�������ѣ���֤��
		rent.setPreCash(list_cash);//
	    rent.setPreDate(list_date);//
		//��װ�����������	
		rent.setYear_rate(year_rate); //������   
		rent.setFuture_money("0");//δ��ֵ 
		rent.setPeriod_type(period_type);//1,�ڳ� 0,��δ��ֵ 
		rent.setIrr_type("2");//1,Ϊ���·ݵĴ�; 2,Ϊ��������Ĵ��� ��ʱ��2
		rent.setScale("8");//irr��С��λ�� ��ʱ����8λ
		rent.setLease_interval(income_number_year);//����� (���ⷽʽ)
		//�������������Ƚ����⣬��ϸ���Ϸ�����................
		rent.setIncome_number(now_count_rent_list);//����  �µ��������ж����ڲ������ѻ���������
		rent.setLease_money(now_corpus_overage);//���ޱ��������п�������һ�ڵ�ʣ�౾����
		rent.setPlan_date(now_plan_date);//������  
		
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^income_number_year:==>"+income_number_year);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^period_type:==>"+period_type);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^year_rate:==>"+year_rate);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_corpus_overage:���ޱ���==>"+now_corpus_overage);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_plan_date������:==>"+now_plan_date);
	//System.out.println("join^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^now_count_rent_list:����==>"+now_count_rent_list);
	
	
		//������������£�������������£�
		List rent_list = list_cashRent;// �õ����list,ע�ⲻ����ʱ�����list (ֻ���µ�����LIST�������� ��������Щ�ֽ�)
		//getPlanDateList(����һ,������)   ����һ �Ϸ����飬���list ������ �ڳ�(1)or��ĩ֧��(0)
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// �ƻ�ʱ�� 
		//����˵�� getHashRentPlan(����һ,������,������) 
		//����һ�����ڳ�(1)or��ĩ֧��(0)�������������Ϸ���list ��װ����������б� 
		//������ measure_type�����㷽���ȶ����|�ȶ��|������","1|2|0" �Ϸ����� ��װʱ��Ľ����
		//******************************************************????????????????????????????????????????????????????
		//measure_type ��ʱ���ȶ�������
		String str_temp = measure_type;
		if(measure_type.equals("0")){
			str_temp = "1";
		}
		HashMap hm = rent.getHashRentPlan(str_temp, rent_list, l_plan_date_);
		//ȡֵ
		l_plan_date = (List)hm.get("plan_date");//��𳥻�����
		l_rent = (List)hm.get("rent");//���
		l_corpus = (List)hm.get("corpus");//����
		l_interest = (List)hm.get("interest");//��Ϣ
		l_corpus_overage = (List)hm.get("corpus_overage");//ʣ�౾��
		
		//����irr  
		Double getIrr = Double.parseDouble(rent.getV_irr())*100;
		//�޸ı�contract_condition�еļƻ�IRR��ֵ
		String update_sqlstr = "update contract_condition_temp set plan_irr="+getIrr+" where contract_id='"+contract_id+"'";
		flag = db.executeUpdate(update_sqlstr);
		String  measure_id = doc_id;//�ĵ����
		//ɾ����Ӧ ����Ŀ��š��͡��ĵ���š��ڱ�fund_rent_plan_temp����ǰ��������ƻ�
		sqlstr = "";
		//ɾ��ʱ��ע�ⲻ��ɾ���Ի���������ڼƻ� 
		sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+measure_id+"'";
		sqlstr = sqlstr + "  and rent_list >= '"+new_rent_list+"' ";
		flag = db.executeUpdate(sqlstr);
		sqlstr = "";
		//ƴװ�µ�������������䣬����fund_rent_plan_temp�н�������ֵ��������,�ɹ���ˢ�¸�ҳ��ĸ�ҳ
		for(int i=0;i<l_rent.size();i++){
		//�ĵ����(������),��ͬ���,����״̬,���,����,��Ϣ,�������,������
			sqlstr+="  insert into fund_rent_plan_temp"+
			       "(measure_id,contract_id,"+
			       "rent_list,plan_date,plan_status,rent,corpus,"+
			       "interest,corpus_overage,year_rate) "+
			       "select '"+measure_id+"','"+contract_id+"',"+(new_rent_list+i)+","+//��������ѻ������������
			       "'"+l_plan_date.get(i)+"','δ����',"+l_rent.get(i)+","+
			       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
			       ""+l_corpus_overage.get(i)+","+year_rate+"  ;  ";
		}
		//System.out.println("===sqlo===:==>"+sqlstr);
		flag = db.executeUpdate(sqlstr);
		
		
		
		
		//************************************************************************************************
		//                                            �ֽ���
		//************************************************************************************************
		//System.out.println("join1====>------->join1");
		//��ʼ��6�����飺���� plan_date_list,������ follow_in_list,�������嵥 follow_in_detail_list
		//������ follow_out_list,�������嵥 follow_out_detail_list,������ net_follow_list
		List<String> plan_date_list = new ArrayList<String>();//
		List<String> follow_in_list = new ArrayList<String>();//
		List<String> follow_in_detail_list = new ArrayList<String>();//
		List<String> follow_out_list = new ArrayList<String>();//
		List<String> follow_out_detail_list = new ArrayList<String>();//
		List<String> net_follow_list = new ArrayList<String>();//
		//�ж��ڳ���ĩ��
		String l_money = "-"+lease_money;//���ޱ���
		String l_consulting_fee = "-"+consulting_fee;//��ѯ��
		String l_handling_charge = handling_charge;//������
		Double count_money = 0.00;//������
		String follow_in_detailTemp = "";//�������嵥ƴװ
		String follow_out_detailTemp = "";//�������嵥ƴװ
		Double follow_out_money = 0.00;//�������ֽ�
		Double follow_in_money = 0.00;//�������ֽ�
		
		//�ڳ�����ѯ��+���ޱ���+������+��һ�����  (period_type 1,�ڳ� 0,��δ��ֵ)
		if(period_type.equals("1")){
			String first_rent = l_rent.get(0).toString();//��һ�����
			follow_in_money = Double.valueOf(l_handling_charge)+Double.valueOf(first_rent);//������+��һ����� ������
			follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//���ޱ���+��ѯ��  ������ 
			count_money = follow_out_money+follow_in_money;//������
			plan_date_list.add(old_start_date);//��һ���ֽ�����Ӧ���ڣ���������Ϊ׼
			follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)).toString());//��һ���ֽ�����������
			follow_in_detailTemp = "������:"+l_handling_charge+" ��һ�����:"+first_rent+" ";
			follow_in_detail_list.add(follow_in_detailTemp);//��һ���ֽ��������嵥����
			follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//��һ���ֽ�������
			follow_out_detailTemp = ":���ޱ���"+lease_money+" ��ѯ��:"+consulting_fee+"";//��һ���ֽ��������嵥
			follow_out_detail_list.add(follow_out_detailTemp);
			net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//��һ���ֽ�����
			//�ڳ����list�ӵڶ�����ʼȡֵ�±�Ϊ1
			for(int i = 1;i < l_rent.size();i++){
				plan_date_list.add(l_plan_date.get(i).toString());//����
				follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()).toString());//���
				follow_in_detailTemp = "���:"+l_rent.get(i);
				follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
				follow_out_list.add("-0.00");//����
				follow_out_detail_list.add("");//�����嵥
				net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
			}
		}else{//��ĩ��������һ����� 
			follow_in_money = Double.valueOf(l_handling_charge);//��һ��������Ϊ��������
			plan_date_list.add(old_start_date);//��һ������
			follow_in_list.add(formatNumberDoubleTwo(Double.valueOf(follow_in_money).toString()));//��һ������
			follow_in_detailTemp = "������:"+l_handling_charge;//��һ���嵥
			follow_in_detail_list.add(follow_in_detailTemp);
			follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//���ޱ���+��ѯ��
			follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//������
			follow_out_detailTemp = ":���ޱ���"+lease_money+" ��ѯ��:"+consulting_fee+"";//��һ���ֽ��������嵥
			follow_out_detail_list.add(follow_out_detailTemp);
			count_money = follow_in_money+follow_out_money;//
			net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//������
			for(int i = 0;i < l_rent.size();i++){
				plan_date_list.add(l_plan_date.get(i).toString());//����
				follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//���
				follow_in_detailTemp = "���:"+l_rent.get(i);
				follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
				follow_out_list.add("-0.00");//����
				follow_out_detail_list.add("");//�����嵥
				net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
			}
		}
		//ÿ�β���֮ǰ��ɾ��֮ǰ���������
		String del_sql = " delete from fund_contract_plan where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = db.executeUpdate(del_sql);
		flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,"fund_contract_plan");
		
	db.close();
	}
	
	if(flag > 0){
		message = "�����������ɹ�!";	
	}else{
		message = "������ʧ��!";
	}
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.parent.location.reload();
		</script>
