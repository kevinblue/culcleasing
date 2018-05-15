<%@ page contentType="text/html; charset=gbk" language="java" errorPage=""%>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@ page import="com.*"%>
<%@page import="com.rent.calc.bg.*"%>
<%@page import="com.rent.calc.bg.CommUtil"%>
<%@page import="com.rent.calc.update.CalcUtil"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="condition" scope="page" class="com.condition.ConditionOperating" />
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ���׽ṹ - �������������ݲ���ҳ</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	String savaType = getStr(request.getParameter("savaType"));
	StringBuffer sql = new StringBuffer();
	ResultSet rs = null;
	int flag = 0;
	String message = "";
	//�Ӳ�
    String doc_id = getStr(request.getParameter("doc_id")); //�ĵ���� measure_id
    String contract_id = getStr(request.getParameter("contract_id")); //��ͬ���
    String proj_id = getStr(request.getParameter("proj_id")); //��Ŀ���
	String income_day = getStr(request.getParameter("income_day"));//ÿ�³�����
	String start_date = getStr(request.getParameter("start_date"));//������
	String year_rate = getStr(request.getParameter("year_rate"));//����������
    
	String currency = "";//��������
	String equip_amt = "";//������(�豸���)
	String first_payment = "";//�׸���
	String lease_money = "";//���ޱ���
	String caution_money = "";//���ޱ�֤��
	String net_lease_money = "";//�����ʶ�
	String handling_charge = "";//�����ѣ������̣�
	String income_number_year = "";//���ⷽʽ
	String lease_term = "";//��������(��)
	String income_number = "";//�������
	String nominalprice = "";//��ĩ��ֵ(������������)
	String period_type = "";//�������� period_type
	String return_amt = "";//���̷���
	String rate_float_type = "";//���ʸ�������
	String before_interest = "";//��ǰϢ
	String rate_adjustment_modulus = "";//���ʵ���ϵ��
	String pena_rate = "";//��Ϣ����
	String plan_irr = "";//plan_irr(�ڲ�������)
	String measure_type = "";//�����㷽��
	String other_income = "";//��������
	String other_expenditure = "";//����֧��
	String creator = "";//�Ǽ���
	String create_date = "";//�Ǽ�ʱ��
    String modify_date = "";//��������
	String modificator = "";//������
	String rate_float_amt = "";//���ʵ���ֵ
	String consulting_fee = "";//��ѯ�� ��ע���¼��ֶΡ�
	String rentScale = "";//Բ����
	
	String liugprice = "";//�����ۿ� ��ע���¼��ֶ� 2010-09-21 ԭ���������۸ĳɲ�ֵ��
	String delay = "";//�������ֶ� 2010-10-20�� �ӳ�����
	String grace = "";//�������ֶ� 2010-10-20����������
	String management_fee = "";//�������ֶ� 2010-11-11�������
		
	String sumMon = "";//=(isnull(net_lease_money,0) + isnull(caution_money,0))*-1
	if(rate_float_amt.equals("") || rate_float_amt == null){
		rate_float_amt = "0";
	}
	/* ��ͬ���׽ṹ�޸Ĳ��� */
	if(savaType.equals("mod")){
	   //ƴװ�޸�SQL��� ��������Ŀ��� contract_id
	   sql.append("UPDATE contract_condition_temp ")
		  .append("SET income_day = '"+income_day+"' ")
	      .append(",start_date = '"+start_date+"' ")
	      .append(",year_rate = '"+year_rate+"' ")//��2011-05-05�����޸�:��������ġ��������ʡ��޸�Ȩ�ޣ���������ط��ţ�������ʱ������������������������޸ģ���
	 	  .append("WHERE contract_id = '"+contract_id+"' ")
	 	  .append("  and measure_id = '"+doc_id+"' ");//���
		System.out.println("==================================================>�޸�SQL-->   "+sql.toString());
		flag = db.executeUpdate(sql.toString());
		message = "�޸ĺ�ͬ���׽ṹ";
	}
	/* ��ͬ���׽ṹɾ������ --��ʱδ��֤�÷�������ȷ�� */
	if(savaType.equals("del")){
		//������������Ŀ��š���������ɾ������
		sql.append("delete from contract_condition_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ");
		flag = db.executeUpdate(sql.toString());
//System.out.println("ɾ��SQL-->   "+sql.toString());
		message = "ɾ����ͬ���׽ṹ";
	}
	String query_sql = " select (isnull(net_lease_money,0) + isnull(caution_money,0)) as sumMon,* from contract_condition_temp  where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
	rs = db.executeQuery(query_sql);
//System.out.println("====> : "+query_sql);
	while(rs.next()){
		 currency = getStr(rs.getString("currency"));//��������
		 equip_amt = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("equip_amt"))));//������(�豸���)
		 first_payment = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("first_payment"))));//�׸���
		 lease_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("lease_money"))));//���ޱ���
		 caution_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("caution_money"))));//���ޱ�֤��
		 net_lease_money = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("net_lease_money"))));//�����ʶ�
		 handling_charge = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("handling_charge"))));//�����ѣ������̣�
		 income_number_year = getStr(rs.getString("income_number_year"));//���ⷽʽ
		 lease_term = getStr(rs.getString("lease_term"));//��������(��)
		 income_number = getZeroStr(getStr(rs.getString("income_number")));//�������
		 nominalprice = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("nominalprice"))));//��ĩ��ֵ(������������)
		 period_type = getStr(rs.getString("period_type"));//�������� period_type
		 return_amt = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("return_amt"))));//���̷���
		 year_rate = getStr(rs.getString("year_rate"));//����������
		 rate_float_type = getStr(rs.getString("rate_float_type"));//���ʸ�������
		 before_interest = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("before_interest"))));//��ǰϢ
		 rate_adjustment_modulus = getStr(rs.getString("rate_adjustment_modulus"));//���ʵ���ϵ��
		 pena_rate = getZeroStr(getStr(rs.getString("pena_rate")));//��Ϣ����
		 plan_irr = getZeroStr(getStr(rs.getString("plan_irr")));//plan_irr(�ڲ�������)
		 measure_type = getStr(rs.getString("measure_type"));//�����㷽��
		 other_income = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("other_income"))));//��������
		 other_expenditure = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("other_expenditure"))));//����֧��
		 creator = getStr(rs.getString("creator"));//�Ǽ���
		 create_date = getStr(rs.getString("create_date"));//�Ǽ�ʱ��
	     modify_date = getStr(rs.getString("modify_date"));//��������
		 modificator = getStr(rs.getString("modificator"));//������
		 rate_float_amt = getZeroStr(getStr(rs.getString("rate_float_amt")));//���ʵ���ֵ
		 consulting_fee = formatNumberDoubleTwo(getZeroStr(getStr(rs.getString("consulting_fee"))));//��ѯ�� ��ע���¼��ֶΡ�
		 rentScale = getDBStr(getStr(rs.getString("rentScale")));//Բ����
		 sumMon = formatNumberDoubleTwo(getStr(rs.getString("sumMon")));//
		 liugprice = getZeroStr(getStr(rs.getString("liugprice")));//�����ۿ� ��ע���¼��ֶ� 2010-09-21 ԭ���������۸ĳɲ�ֵ��
		 delay = getZeroStr(getStr(rs.getString("delay")));//�������ֶ� 2010-10-20��36 �ӳ�����
		 grace = getZeroStr(getStr(rs.getString("grace")));//�������ֶ� 2010-10-20��37 ��������
		 management_fee = getZeroStr(getStr(rs.getString("management_fee")));//�������ֶ� 2010-11-11��38�����
	}
 	String old_start_date = start_date;		//�����ֽ���
  	
//*****************************************************************************************************	
//***                                  ������                                                             ****
//*****************************************************************************************************	
 	start_date = start_date.substring(0,8)+income_day;
 	
 	//��2011-04-13�������󣬲������ʱ�򲻽��������������ֻ�ǽ����޸����ڵĲ�����
 	if("0".equals(measure_type)){//�ȶ����|�ȶ��|������","1|2|0
 		//�Ȳ�ѯÿ�ڵĳ�������
 		String sql_q = "select * from  fund_rent_plan_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
 		rs = db.executeQuery(sql_q);
 		StringBuffer usql = new StringBuffer();
 		while(rs.next()){
 			String plan_date = getDBDateStr(rs.getString("plan_date"));
 			String key = rs.getString("id");
 			String new_date = plan_date.substring(0,8)+income_day;
 			usql.append(" update  fund_rent_plan_temp  ")
 			    .append(" set plan_date = '"+new_date+"'  ")
 			    .append(" where id = "+key+" ;");
	 	}
	 	System.out.println("������ʱ���޸�SQL-->   "+usql.toString());
	 	flag = db.executeUpdate(usql.toString());
 	}else{
	 	//
	 	String sql_q = "select * from  fund_rent_plan_temp where contract_id = '"+contract_id+"'  and measure_id = '"+doc_id+"' ";
	 	rs = db.executeQuery(sql_q);
	 	List l_rent = new ArrayList();//���
	 	List l_corpus = new ArrayList();//����
	 	List l_interest = new ArrayList();//��Ϣ
	 	List l_corpus_overage = new ArrayList();//ʣ�౾��
	 	List l_corpus_market = new ArrayList();
		List l_interest_market = new ArrayList();
		List l_corpus_overage_market = new ArrayList();
	 	while(rs.next()){
	 		l_rent.add(getZeroStr(getStr(rs.getString("rent"))));
	 		l_corpus.add(getZeroStr(getStr(rs.getString("corpus"))));
	 		l_interest.add(getZeroStr(getStr(rs.getString("interest"))));
	 		l_corpus_overage.add(getZeroStr(getStr(rs.getString("corpus_overage"))));
	 		l_corpus_market.add(getZeroStr(getStr(rs.getString("corpus_market"))));
	 		l_interest_market.add(getZeroStr(getStr(rs.getString("interest_market"))));
	 		l_corpus_overage_market.add(getZeroStr(getStr(rs.getString("corpus_overage_market"))));
	 	}
	 	rs.close();
	 	//RentCalc rentCalc = new RentCalc();
	 	//rentCalc.setPlan_date(start_date);//�����µ�������
		//rentCalc.setPeriod_type(period_type);//�ڳ���ĩ
		//rentCalc.setLease_interval(income_number_year);//���ⷽʽ �����
		//List l_plan_date = rentCalc.getPlanDateList(l_rent, income_number_year);///?????
		
		//2010-11-30�޸�  �������ӳٺͿ��޵��жϲ���
	 	List l_rent_new = CalcUtil.getNewList(l_rent);//2010-11-30�޸� �����ֽ����õ�
		CommUtil commUtil = new CommUtil(); 
		List l_plan_date = commUtil.getPlanDateList(l_rent,period_type,delay,income_number_year,start_date);
		List new_rent_1 = commUtil.getDelayRent(l_rent, delay);//�ӳ�����»�ȡ�µ��г����,�����ֽ�����ƴװ
		
		
			//�������  fund_rent_plan_temp //������ ���� �ĵ����
			String sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			db.executeUpdate(sqlstr);
			for(int i=0;i<l_rent.size();i++){
			//�����ֶ�˳��:�ĵ����(������),��ͬ���,����״̬,���,����,��Ϣ,�������,������
				sqlstr="insert into fund_rent_plan_temp"+
				       "(measure_id,contract_id,"+
				       "rent_list,plan_date,plan_status,rent,corpus,"+
				       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
				       "select '"+doc_id+"','"+contract_id+"',"+(i+1)+","+
				       "'"+l_plan_date.get(i)+"','δ����',"+l_rent.get(i)+","+
				       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
				       ""+l_corpus_overage.get(i)+","+year_rate+","+
				       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
				System.out.println(i+"^^^^^^^^^^^^^^^��ͬ���������sqlstr2====="+sqlstr);
				System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
				db.executeUpdate(sqlstr);
			}
		
		RentCalc rent = new RentCalc();
		//���޸��գ�2010-07-26���ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤��
		List l_RentDetails = rent.getRentDetails(new_rent_1,caution_money);
		List new_rent = rent.getRentCautNew(new_rent_1,caution_money);
	
		//System.out.println("^^^^^^^^^^^^^^^flag====="+flag);	
		//************************************************************************************************
		//                                            �ֽ���
		//************************************************************************************************
		if(Integer.parseInt(delay) > 0){//�ӳ��ڴ���0  2010-12-01����
			l_plan_date = commUtil.getDelayPlanDateList(l_rent,period_type,delay,income_number_year,start_date);
			l_rent_new = commUtil.getDelayRent(l_rent_new, delay);//�ӳ�����»�ȡ�µĲ������,�����ֽ�����ƴװ
		}
		//ÿ�β���֮ǰ��ɾ��֮ǰ���������
		String del_sql = " delete  fund_contract_plan_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = cashFlow.execProjORcontract_xjl(l_plan_date,l_rent_new,lease_money,
					 consulting_fee, handling_charge, equip_amt,
					 other_expenditure, caution_money, return_amt,
					 other_income, first_payment, old_start_date,
					 period_type, proj_id, doc_id,
					 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
					 "fund_contract_plan_temp",before_interest);//
		//�г��ֽ��� 
		String new_del_sql = " delete  fund_contract_plan_mark_temp where contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
		flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date,new_rent,lease_money,
					 consulting_fee, handling_charge, equip_amt,
					 other_expenditure, caution_money, return_amt,
					 other_income, first_payment, old_start_date,
					 period_type, proj_id, doc_id,
					 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
					 "fund_contract_plan_mark_temp",before_interest,l_RentDetails);//
			
		//�ֽ���������롾2010-08-06��
		if(!nominalprice.equals("")){//
			double t_num = Double.valueOf(nominalprice); 
			if(t_num > 0){//�����۴���0�Ž��д˲���
			
				//�����ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
				String  query_count_cw = " select * from fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
				query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("��ѯ��ͬ��������ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
				//����ͨ�÷���,���С������ۡ����޸Ĳ���
				flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan_temp","",contract_id);//����
				
				//�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
				String  query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
				query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				System.out.println("��ѯ��ͬ�����г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
				//����ͨ�÷���
				flag = cashFlow.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark_temp","",contract_id);//�г�
			}
		}
		//��������,�ֽ���������롾2010-11-30�� �ֽ�����һ�ڼ��Ϲ���ѣ���������������
		if(!"".equals(management_fee) && management_fee != null && (!"0.00".equals(management_fee) && !"0".equals(management_fee))){
			//follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow
			//��ѯ�����ֽ�����һ�ڵ�����
			String  query_min_cw = " select * from fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"' ";
				//query_min_cw = query_min_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_min_cw = query_min_cw + " and id = ( select max(id) from fund_contract_plan_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("��ѯ��ͬ�����ֽ�����Сһ�ڵ�ֵ ==> "+query_min_cw);
			//���ù��÷���������Ѽӵ���������	
			//����:String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model
			flag = cashFlow.updat_xjl(query_min_cw,management_fee,proj_id,contract_id,doc_id,"contract","cw");
			//��ѯ�г���һ�ڵ�����
			String  query_min_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+doc_id+"'";
				//query_min_market = query_min_market + " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
				query_min_market = query_min_market + " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"+contract_id+"'  and doc_id = '"+doc_id+"' ) ";
			System.out.println("��ѯ��ͬ�г��ֽ�����Сһ�ڵ�ֵ ==> "+query_min_market);
			//���ù��÷���������Ѽӵ���������	
			flag = cashFlow.updat_xjl(query_min_market,management_fee,proj_id,contract_id,doc_id,"contract","market");
		}
 	}//�������ж�else����
	
	db.close();

// ***********************************************************
	if(flag > 0){
		String hrefStr="";
		if(savaType.equals("del")){//ɾ���ɹ�
%>
        <script>
		//opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>�ɹ�!");
		this.close();
		</script>
<%
		}else{//�޸���ӳɹ�
%>
        <script>
			alert("��ͬ������ɹ�!");
			opener.parent.location.reload();
			//opener.location.reload();
			window.close();
		</script>
<%
		}
	}else{
%>
        <script>
			alert("��ͬ������ʧ��!");
			opener.location.reload();
			this.close();
		</script>
<%	
	}
	db.close();
%>