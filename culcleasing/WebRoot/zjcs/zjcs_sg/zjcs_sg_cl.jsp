<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %>
<%@page import="com.rent.calc.bg.AbnormalCalc"%>
<%@page import="com.rent.calc.bg.RentCalc"%> 

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="cashFlow" scope="page" class="com.condition.CashFlow" />
<%@page import="com.rent.calc.update.CalcUtil"%>

<html>
<head>
<title>��������㴦��ҳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	int flag = 0;
	String message = "";
	String sqlstr;
	ResultSet rs;
	String dqczy = (String) session.getAttribute("czyid");
	String czid = getStr(request.getParameter("czid") );
	String curr_date = getSystemDate(0);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	
	
	String temp = getStr(request.getParameter("temp") );//�ж��Ƿ�����Ŀ���Ǻ�ͬ
	String	contract_id = getStr(request.getParameter("contract_id") );
	String	proj_id = getStr(request.getParameter("proj_id") );
	String	measure_id = getStr(request.getParameter("measure_id") );
	
	
	//**********************************************************************************************************************
	//��2011-04-07 ����������������ǰ�ж��г������һ�����������Ƿ����0������0���������ɲ������ݡ�
	//��һ������ȡ�����Լ�����
		String table_name = "";
		String table_name_frpt = "";
		String where_s = "";
		if (temp.equals("proj_zjcs")){
			 table_name_frpt = " fund_rent_plan_proj_temp ";
			 table_name = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"' ";//���׽ṹ
			 where_s = " fund_rent_plan_proj_temp where   proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"'  ";// ���ƻ���
		}
		//��ͬ
		if (temp.equals("contract_zjcs")){
			 table_name_frpt = " fund_rent_plan_temp ";
			 table_name = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"' ";//���׽ṹ 
			 where_s = " fund_rent_plan_temp  where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"' ";//���ƻ���
		}
		//��ѯ���һ�𳥻��ƻ��ı������
		String query_m = " select isnull(corpus_overage_market,0) as corpus_overage_market from  "+where_s;
		query_m = query_m + " and rent_list = (select max(rent_list) as rent_list from "+where_s+" ) ";
		rs = db.executeQuery(query_m);
		String corpus_overage_market_last = "";
		System.out.println("��ѯ���һ�𳥻��ƻ��ı������"+query_m);
		if(rs.next()){
			corpus_overage_market_last = rs.getString("corpus_overage_market");
		}
		
		System.out.println("Double.valueOf(corpus_overage_market_last) > Double.valueOf(0.00)---"+(Double.valueOf(corpus_overage_market_last) > Double.valueOf("0.00")));
		if(Double.valueOf(corpus_overage_market_last) > Double.valueOf("0.00")){
		%>
				<script>
					alert("���һ���г��������Ϊ<%=corpus_overage_market_last%>����0�޷����ж�Ӧ�����������ɲ���!");
					window.close();
					opener.opener.parent.location.reload();
				</script>
		<%
		}else{
			//**********************************************************************************************************************
			//��һ�����������ݱ���ı���
			String ctbName = ""; // ���׽ṹ��
		    String ftbName = "";// ���ƻ���
			String contractColum = ""; // ��ͬ������
			String contractId = "";// ��ͬ��
			String docId = "";// ���̺�
			String docColumn = "";// ���̺�����
			String table_where = "";
			String xjl_table_cw = "";//�����ֽ����ı���
			String xjl_table_mar = "";//�г��ֽ����ı���
			String xjl_table_cw_where = "";//�����ֽ����ı���������
			String xjl_table_mar_where = "";//�г��ֽ����ı���������
			String xjl_temp = "";//�ֽ�����һ�ڼ��Ϲ�����õ���һ��ֵ
			//��Ŀ
			if (temp.equals("proj_zjcs")){
			     xjl_table_cw_where = " fund_proj_plan_temp where   proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"' ";//�����ֽ����ı���������
			     xjl_table_mar_where = " fund_proj_plan_mark_temp  where  proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"' ";//�г��ֽ����ı���������
				 table_where = " proj_condition_temp where  proj_id = '"+proj_id+"' and measure_id = '"+measure_id+"'";
				 xjl_temp = "proj";
				 ctbName = "proj_condition_temp"; // ���׽ṹ��
			     ftbName = "fund_rent_plan_proj_temp";// ���ƻ���
				 contractColum = "proj_id"; // ��Ŀ������
				 contractId = proj_id;// ��Ŀ��
				 docId = measure_id;// ���̺�
				 docColumn = "measure_id";// ���̺�����
				 xjl_table_cw = "fund_proj_plan_temp";
				 xjl_table_mar = "fund_proj_plan_mark_temp";
			}
			//��ͬ
			if (temp.equals("contract_zjcs")){
			     xjl_table_cw_where = " fund_contract_plan_temp where   contract_id = '"+contract_id+"' and doc_id = '"+measure_id+"' ";//�����ֽ����ı���������
			     xjl_table_mar_where = " fund_contract_plan_mark_temp  where  contract_id = '"+contract_id+"' and doc_id = '"+measure_id+"' ";//�г��ֽ����ı���������
				table_where = " contract_condition_temp where contract_id = '"+contract_id+"' and measure_id = '"+measure_id+"'";
				 xjl_temp = "contract";
				 ctbName = "contract_condition_temp"; // ���׽ṹ��
			     ftbName = "fund_rent_plan_temp";// ���ƻ���
				 contractColum = "contract_id"; // ��ͬ������
				 contractId = contract_id;// ��ͬ��
				 docId = measure_id;// ���̺�
				 docColumn = "measure_id";// ���̺�����
				 xjl_table_cw = "fund_contract_plan_temp";
				 xjl_table_mar = "fund_contract_plan_mark_temp";
			}
			//�ڶ�����д��ֵ  ctbName, ftbName, contractColum,contractId, docId, docColumn
			AbnormalCalc abnormalCalc = new AbnormalCalc();
			abnormalCalc.setCtbName(ctbName);
		    abnormalCalc.setFtbName(ftbName);
			abnormalCalc.setContractColum(contractColum);
			abnormalCalc.setContractId(contractId);
			abnormalCalc.setDocId(docId);
			abnormalCalc.setDocColumn(docColumn);
			//����������ѯ���׽ṹ
			sqlstr = " select * from  "+table_where;
			rs =  db.executeQuery(sqlstr);
			System.out.println("���������--��������ǰ��ѯ���׽ṹ-->"+sqlstr);
			String net_lease_money = "";//�����ʶ�
			String caution_money = "";//���ޱ�֤��
			//���¼������ֽ�����Ҫ�õ�������
			String lease_money = "";//���ޱ���
			String consulting_fee = "";//��ѯ��
			String handling_charge = "";//������
			String equip_amt = "";//������(�豸���)
			String other_expenditure = "";//����֧��
			String return_amt = "";//���̷���
			String other_income = "";//��������
			String first_payment = "";//�׸���
			String start_date = "";//������
			String period_type = "";//��������
			String creator = "";//�Ǽ���
			String create_date = "";//�Ǽ�����
			String modificator = "";//�޸���
			String modify_date = "";//�޸�����
			String before_interest = "";//��ǰϢ
			String nominalprice = "";//��ĩ��ֵ
			String management_fee = "";//�����
			while(rs.next()){
				net_lease_money = getZeroStr(rs.getString("net_lease_money"));
				caution_money = getZeroStr(rs.getString("caution_money"));
				
				 lease_money = getZeroStr(rs.getString("lease_money"));//���ޱ���
			 	 consulting_fee = getZeroStr(rs.getString("consulting_fee"));//��ѯ��
				 handling_charge = getZeroStr(rs.getString("handling_charge"));//������
				 equip_amt = getZeroStr(rs.getString("equip_amt"));//������(�豸���)
				 other_expenditure = getZeroStr(rs.getString("other_expenditure"));//����֧��
				 return_amt = getZeroStr(rs.getString("return_amt"));//���̷���
				 other_income = getZeroStr(rs.getString("other_income"));//��������
				 first_payment = getZeroStr(rs.getString("first_payment"));//�׸���
				 start_date = getDBStr(getStr(rs.getString("start_date")));//������
				 period_type = getZeroStr(rs.getString("period_type"));//��������
				 creator =  getDBStr(getStr(rs.getString("creator")));//�Ǽ���
				 create_date =  getDBStr(getStr(rs.getString("create_date")));//�Ǽ�����
				 modificator =  getDBStr(getStr(rs.getString("modificator")));//�޸���
				 modify_date =  getDBStr(getStr(rs.getString("modify_date")));//�޸�����
				 before_interest = getZeroStr(rs.getString("before_interest"));//��ǰϢ
				 nominalprice = getZeroStr(rs.getString("nominalprice"));//��ĩ��ֵ
				 management_fee = getZeroStr(rs.getString("management_fee"));//�����
			}
			rs.close();
			String money = String.valueOf(Double.valueOf(caution_money) + Double.valueOf(net_lease_money));
			//���Ĳ����������ݵ����ɲ���
			//  @param markIrrValue  �г��ֽ������׽ṹֵ (�����ʶ�)
			//  @param finIrrValue�������ֽ������׽ṹֵ  (���ޱ�֤��+�����ʶ�)
			//  @param finCalcValue �������ƻ�����ֵ�� (���ޱ�֤��+�����ʶ�)
			Hashtable  ht =  abnormalCalc.getPlanInfo(net_lease_money,  money, money);
			//���岽��ȡ���������ڽ����
			List date_list = (List) ht.get("l_date");//����
			List rent_list = (List) ht.get("rent_list");//���
			
			//�������� �ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤��
			//�����ֽ����õ������list
			List l_rent_new = CalcUtil.getNewList(rent_list);//2010-11-30�޸� �����ֽ����õ�
			RentCalc rent = new RentCalc();
			//�г��ֽ�����
			List l_RentDetails = rent.getRentDetails(rent_list,caution_money);//�õ���֤��ֿۺ������������ϸֵ
			List new_rent = rent.getRentCautNew(rent_list,caution_money);//�õ���֤��ֿ����List
			
			//���߲��������µ��ֽ���
			//ÿ�β���֮ǰ��ɾ��֮ǰ��������� ��2010-7-30�޸ģ�������Ŀ���ֽ��������ٺͺ�ͬ���ֽ�������һ�ű��ˡ�
			//�����ֽ�����
			String del_sql = " delete  "+xjl_table_cw_where;
			flag = cashFlow.execProjORcontract_xjl(date_list,l_rent_new,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, measure_id,
						 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
						 xjl_table_cw,before_interest);//�����ֽ�������Ҫ���б�֤��ֿ� 
			//	System.out.println("2                                                        "+flag);			 
			//�г��ֽ��� 
			String new_del_sql = " delete  "+xjl_table_mar_where;//xjl_table_mar+" where proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'";
			flag = cashFlow.execProjORcontract_xjl_mark(date_list,new_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, measure_id,
						 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
						 xjl_table_mar,before_interest,l_RentDetails);//
			 //	System.out.println("3                                                        "+flag);
			 	//�ֽ���������롾2010-08-06��
				if(!nominalprice.equals("")){//
					double t_num = Double.valueOf(nominalprice); 
					if(t_num > 0){//�����۴���0�Ž��д˲���
						//�����ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
						String  query_count_cw = " select * from  "+xjl_table_cw_where;
						query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from  "+xjl_table_cw_where+" ) ";
						query_count_cw = query_count_cw + " and id = ( select max(id) from "+xjl_table_cw_where+" ) ";
						System.out.println("��ѯ��Ŀ�����ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
						//����ͨ�÷���,���С������ۡ����޸Ĳ���
						flag = cashFlow.update_xjl_cw(query_count_cw, nominalprice,xjl_table_cw,proj_id,contract_id);//����
						//System.out.println("4                                                        "+flag);			
						//�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
						String  query_count_market = " select * from  "+xjl_table_mar_where;
						query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from "+xjl_table_mar_where+" ) ";
						query_count_market = query_count_market + " and id = ( select max(id) from "+xjl_table_mar_where+"  ) ";
						System.out.println("��ѯ��Ŀ�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
						//����ͨ�÷���
						flag = cashFlow.update_xjl_market(query_count_market, nominalprice,xjl_table_mar,proj_id,contract_id);//�г�
						//System.out.println("5                                                       "+flag);
					}
				}
				//��������,�ֽ���������롾2010-11-30�� �ֽ�����һ�ڼ��Ϲ���ѣ���������������
				if(!"".equals(management_fee) && management_fee != null && (!"0.00".equals(management_fee) && !"0".equals(management_fee))){
					//follow_in,follow_in_detail,follow_out,follow_out_detail,net_follow
					//��ѯ�����ֽ�����һ�ڵ�����
					String  query_min_cw = " select * from  "+xjl_table_cw_where;//fund_proj_plan_temp where   proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'
						query_min_cw = query_min_cw + " and id = ( select min(id) from "+xjl_table_cw_where+" ) ";
					System.out.println("��ѯ��Ŀ�����ֽ�����Сһ�ڵ�ֵ ==> "+query_min_cw);
					//���ù��÷���������Ѽӵ���������	
					//����:String sql,String management_fee,String proj_id,String contract_id,String doc_id,String model
					flag = cashFlow.updat_xjl(query_min_cw,management_fee,proj_id,"",measure_id,xjl_temp,"cw");
					//��ѯ�г���һ�ڵ�����
					String  query_min_market = " select * from "+xjl_table_mar_where;// fund_proj_plan_mark_temp  where  proj_id = '"+proj_id+"' and doc_id = '"+measure_id+"'
						query_min_market = query_min_market + " and id = ( select min(id) from "+xjl_table_mar_where+" ) ";
					System.out.println("��ѯ��Ŀ�г��ֽ�����Сһ�ڵ�ֵ ==> "+query_min_market);
					//���ù��÷���������Ѽӵ���������	
					flag = cashFlow.updat_xjl(query_min_market,management_fee,proj_id,"",measure_id,xjl_temp,"market");
				}
				//**********************************************************************************************************************
				//��2011-04-07 �������󣺽��г��ı���������²���һ�Σ�ÿ�ڵ�ʣ�౾��=��һ��ʣ�౾���ȥ���ڵı���
				//��һ�������Ϸ��� 
				//�ڶ������Ȳ�ѯ�ܵ�ʣ�౾���Ƕ��� ���׽ṹ�е����ޱ���
				String q_condition = " select isnull(lease_money,0) as lease_money from  "+table_name;
				String lease_money_t = "";
				System.out.println("q_condition---->"+q_condition);
				ResultSet rs_c = db.executeQuery(q_condition);
				if(rs_c.next()){
					lease_money_t = rs_c.getString("lease_money");
				}
				//����������ѯ��𳥻��ƻ����е�ÿ�ڵı��� 
				String q_cm = " select id,isnull(corpus_market,0) as corpus_market from  "+where_s;
				System.out.println("q_cm---->"+q_cm);
				String corpus_market = "";//�г�����
				String corpus_market_id = "";//�г������޸Ķ�Ӧ����id
				rs_c = db.executeQuery(q_cm);
				List corpus_market_l = new ArrayList();
				List id_l = new ArrayList();
				while(rs_c.next()){
					corpus_market = rs_c.getString("corpus_market");
					corpus_market_id = rs_c.getString("id");
					corpus_market_l.add(corpus_market);
					id_l.add(corpus_market_id);
				}
				rs_c.close();
				//���Ĳ������ú�̨�������¼����г���ʣ�౾��
				List corpusOvergeMarket_l = rent.getCorpusOvergeList(lease_money_t,corpus_market_l);
				//���岽��ѭ���޸��������г������Ӧ��id�����޸������г�����Ĳ���
				StringBuffer uSql =  new StringBuffer();
				for(int i = 0 ;i < id_l.size();i++){
					uSql.append(" update  ")
					    .append(table_name_frpt)
					    .append(" set corpus_overage_market = '"+corpusOvergeMarket_l.get(i)+"' ")
					    .append(" where id =  "+id_l.get(i))
					    .append(" ");
				}
				db.executeUpdate(uSql.toString());
				System.out.println("�޸��г�ʣ�౾��---->"+uSql);
				//**********************************************************************************************************************
		
		System.out.println("flag---------------->"+flag);
			if(flag != 0){
		%>
				<script>
					//alert(opener.opener.rate_float_type.value);
					//alert("�������ݳɹ�!");
					//window.close();
					//opener.parent.refreshOpener();
					//opener.opener.parent.location.reload();
					
					window.close();
					opener.alert("�ɹ�!");
					//opener.location.reload();//ˢ��listҳ��
					window.opener.parent.parent.location.reload();
					//opener.opener.window.navigate('../zjcs/main.jsp');
					//opener.parent.parent.opener.parent.location.reload();
				</script>
		<%
			}else{
		%>
				<script>
					alert("��������ʧ��!");
					window.close();
					opener.opener.parent.location.reload();
				</script>
		<%
			}
	}
	db.close();
%>