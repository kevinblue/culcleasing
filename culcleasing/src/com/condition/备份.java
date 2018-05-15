package com.condition;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Hashtable;
import com.rent.calc.bg.RentCalc;

import dbconn.Conn;

/**
 * <p>��Ϣ�ֽ���ʵ���ࡣ</p>
 * @author Сл
 * <p>Jun 10, 2010</p>
 */
public class ���� {
		
		/**
		 * <p>���ݴ���ĺ�ͬ���listѭ����ѯ��ͬ���׽ṹ��ѯ��Ҫ�����ֽ������ֶΡ�</p>
		 * @author Сл
		 * @param contractId_list װ��contract_id��list
		 * @param adjust_id ���л�׼���ʱ���
		 * @return �ֽ�������ɹ����
		 */
		@SuppressWarnings("unchecked")
		public int addCashFlow(List<String> contractId_list,String adjust_id){
			int flag = 0;
			StringBuffer query_sql = new StringBuffer();
			StringBuffer query_rent_sql = new StringBuffer();
			//ѭ��
			for(int i = 0;i < contractId_list.size();i++){
				query_sql = new StringBuffer();
				//��һ�������ݺ�ͬ��Ų�ѯ��Ӧ�Ľ��׽ṹ��Ϣ
				query_sql.append(" select * from contract_condition  ")
				         .append(" where contract_id =  ")
				         .append(" '"+contractId_list.get(i) +"' ");
				//�ڶ��������ݺ�ͬ��Ų�ѯ����б�plan_date,rent 
				query_rent_sql = new StringBuffer();
				query_rent_sql.append(" select * from fund_rent_plan ")
							  .append(" where contract_id = ")
							  .append(" '"+contractId_list.get(i) +"' ");
				System.out.println("��Ϣ�ֽ���join1==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : ");
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//��ѯ ���׽ṹ���� ���д���     ��һ��������
				List<String> contract_condition_list = this.execute_contract_condition_sql(query_sql.toString());
				System.out.println("��Ϣ�ֽ���join2==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : "+query_rent_sql.toString());
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//��ѯ ��𳥻��ƻ� ���д���     ������������
				Hashtable  data_table = this.execute_fund_rent_plan(query_rent_sql.toString());
				System.out.println("��Ϣ�ֽ���join3==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ : ");
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//ִ���ֽ����������             ������������
				String contract_id = contractId_list.get(i);
				System.out.println("��Ϣ�ֽ���join4==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ contract_id: "+contract_id);
				//flag = this.getCashFlowList(contract_condition_list, data_table, contract_id, adjust_id);
				//��2010-08-05 �޸ġ�
				flag = this.exec_cashFlow(contract_condition_list, data_table, contract_id, adjust_id);
				System.out.println("��Ϣ�ֽ���join5==>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ flag: "+flag);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//ƴװ�������IRR���г�IRR�Ĳ�ѯ��� ���Ĳ�������
				String query_cw_xjl = " select * from fund_contract_plan  where  contract_id = '"+contract_id+"' ";
				String query_market_xjl = " select * from fund_contract_plan_mark  where contract_id = '"+contract_id+"'";
				flag = this.update_contract_condition(contractId_list, contract_condition_list, query_cw_xjl, query_market_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				
				//IRR���������²�����г����ֽ������� ���岽������
				//���ݺ�ͬ��Ų�ѯ�ֽ����������һ�ڣ������� �ֶ� ���� ������ �Լ��������嵥 �ж������۴���0 
				//ͬʱ ������ + ������  ע�⣺ͬ����ͨ����������ֽ���Ҳ��Ҫ����
				String nominalprice = contract_condition_list.get(18);//�ȵõ�������
				if(!nominalprice.equals("") ){
					int num_t = Integer.parseInt(nominalprice);
					if(num_t > 0){//�����۴���0�Ž��д˲���
						//��ѯ�����ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
						String  query_count_cw = " select * from fund_contract_plan where  contract_id = '"+contract_id+"'";
						query_count_cw = query_count_cw + " and plan_date = ( select max(plan_date) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						query_count_cw = query_count_cw + " and id = ( select max(id) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						System.out.println("��ѯ�����ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						
						//��ѯ�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
						String  query_count_market = " select * from fund_contract_plan_mark  where  contract_id = '"+contract_id+"'";
						query_count_market = query_count_market + " and plan_date = ( select max(plan_date) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						query_count_market = query_count_market + " and id = ( select max(id) from fund_contract_plan where contract_id = '"+contract_id+"' ) ";
						System.out.println("��ѯ�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "+query_count_cw);
						System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
						flag = this.update_xjl_cw(query_count_cw, nominalprice,"fund_contract_plan");//����
						flag = this.update_xjl_market(query_count_market, nominalprice,"fund_contract_plan_mark");//�г�
					}
				}
				
			}
			System.out.println("���յ�Ϣ�ֽ����ķ���ֵΪflag==> : "+flag);
			return flag;
		}
		/**
		 * <p>���ݴ���������۸����ֽ��������������������嵥�������������ֶε�ֵ��</p>
		 * @author Сл
		 * @param query_count_cw ��ѯ�����ֽ��������ֶε�SQL
		 * @param nominalprice ������
		 * @param tableName ����ı��������ڽ��������ͨ�����������۵ĸ��������������ķ��� ��Ϊ ��Ŀ��ͬ�����ģ�鶼Ҫ�õ�
		 * @return
		 */
		public int update_xjl_cw(String  query_count_cw,String nominalprice,String tableName){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs;
			String  follow_in = "";//������
			String  follow_in_detail = "";//�������嵥
			String  net_follow = "";//������
			try {
				rs = db.executeQuery(query_count_cw);
				while(rs.next()){
					follow_in = getDBStr(rs.getString("follow_in"));
					follow_in_detail = getDBStr(rs.getString("follow_in_detail"));
					net_follow = getDBStr(rs.getString("net_follow"));
				}
				
				//ƴװ�µ��������嵥�Լ������µ����룬��������ֵ
				Double now_follow_in = Double.valueOf(follow_in) + Double.valueOf(nominalprice);
				String now_follow_in_detail = follow_in_detail + " ������:"+nominalprice;
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String update_fund_contract_plan = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				update_fund_contract_plan = update_fund_contract_plan + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				flag = db.executeUpdate(update_fund_contract_plan);
				System.out.println("���²����ֽ������������ۺ������ֶε�SQL == �� "+update_fund_contract_plan);
				//formatNumberDoubleTwo(
				String new_follow_in_detail = "";
				String new_net_follow = "";
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
		}
		/**
		 * <p>���ݴ���������۸����г��ֽ��������������������嵥�������������ֶε�ֵ��</p>
		 * @author Сл
		 * @param query_count_market ��ѯ�г��ֽ����ֶε�SQL
		 * @param nominalprice ������
		 * @param tableName ����ı��������ڽ��������ͨ�����������۵ĸ��������������ķ��� ��Ϊ ��Ŀ��ͬ�����ģ�鶼Ҫ�õ�
		 * @return
		 */
		public int update_xjl_market(String  query_count_market,String nominalprice,String tableName){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs;
			String  follow_in = "";//������
			String  follow_in_detail = "";//�������嵥
			String  net_follow = "";//������
			try {
				rs = db.executeQuery(query_count_market);
				while(rs.next()){
					follow_in = getDBStr(rs.getString("follow_in"));
					follow_in_detail = getDBStr(rs.getString("follow_in_detail"));
					net_follow = getDBStr(rs.getString("net_follow"));
				}
				
				//ƴװ�µ��������嵥�Լ������µ����룬��������ֵ
				Double now_follow_in = Double.valueOf(follow_in) + Double.valueOf(nominalprice);
				String now_follow_in_detail = follow_in_detail + " ������:"+nominalprice;
				Double now_net_follow = Double.valueOf(net_follow) + Double.valueOf(nominalprice);
				String fund_contract_plan_mark = " update  "+tableName+"  set follow_in= '"+formatNumberDoubleTwo(now_follow_in)+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,follow_in_detail = '"+now_follow_in_detail+"' ";
				fund_contract_plan_mark = fund_contract_plan_mark + "  ,net_follow = '"+formatNumberDoubleTwo(now_net_follow)+"' ";
				flag = db.executeUpdate(fund_contract_plan_mark);
				System.out.println("�����г��ֽ������������ۺ������ֶε�SQL == �� "+fund_contract_plan_mark);
				//formatNumberDoubleTwo(
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>�ֽ���������ɺ��ѯ���º���ֽ����б��еľ������б���в�����г�IRR�����¼��㣬Ȼ����º�ͬ���׽ṹ��ʽ��</p>
		 * @author Сл
		 * @param contractId_list ��ͬ��ż���  
		 * @param contract_condition_list ���׽ṹ  
		 * @param query_cw_xjl ��ѯ�����ֽ�����������sql
		 * @param query_market_xjl ��ѯ�г��ֽ�����������sql
		 * @return
		 */
		private int update_contract_condition(List<String> contractId_list,List<String> contract_condition_list,String query_cw_xjl,String query_market_xjl){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
			//�ڶ����͵���������ֵ��ͬ
			String income_number_year  = contract_condition_list.get(16);//���ⷽʽ 16  ���ⷽʽ���¸�|����|���긶|�긶","1|3|6|12��
			//���ĸ�����
			String income_number  = contract_condition_list.get(17);//�껷����� 17 
			
			//��һ������IRR�Ĳ��� �������б�
			List<String> l_inflow_pour = new ArrayList<String>();
			String cw_net_follow = "";//������
			try{	
				rs = db.executeQuery(query_cw_xjl);
				System.out.println("��Ϣ�ֽ������ѯ����IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				while(rs.next()){
					cw_net_follow = getDBStr(rs.getString("net_follow"));
					l_inflow_pour.add(cw_net_follow);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//��һ���г�IRR�Ĳ��� �������б�
			List<String> l_inflow_pour_market = new ArrayList<String>();
			String market_net_follow = "";//������
			try{	
				rs = db.executeQuery(query_cw_xjl);
				System.out.println("��Ϣ�ֽ������ѯ�г�IRR��Ҫ�ľ�����SQL==�� "+query_cw_xjl);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				while(rs.next()){
					market_net_follow = getDBStr(rs.getString("net_follow"));
					l_inflow_pour_market.add(market_net_follow);
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
 			db.close();
 			//���ü���IRR�ķ���
 			String plan_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour,income_number_year,income_number_year,income_number);
 			String market_irr = com.rent.calc.tx.bg.IrrCalc.getIRR(l_inflow_pour_market,income_number_year,income_number_year,income_number);
 			flag = this.update_Irr(contractId_list, plan_irr, market_irr);
			return flag;
		}
		
		/**
		 * <p>���ݺ�ͬ���list�ʹ����IRR���к�ͬ���׽ṹ��ʽ��ĸ��²�����</p>
		 * @author Сл
		 * @param contractId_list ��ͬ��ż���
		 * @param plan_irr ����IRR
		 * @param market_irr �г�IRR
		 * @return
		 */
		private int update_Irr(List<String> contractId_list,String plan_irr,String market_irr){
			int flag = 0;
			Conn db = new Conn();
			ResultSet rs = null;
			//���½��׽ṹ���2��IRR
			String update_sql = "";
			for(int i = 0;i < contractId_list.size();i++){
				update_sql = " update contract_condition set plan_irr="+plan_irr+",market_irr = "+market_irr+"  where contract_id='"+contractId_list.get(i)+"' '  ";
				try {
					flag = db.executeUpdate(update_sql);
					System.out.println("��Ϣ�ֽ���������ɺ���е��޸�IRR SQL==> "+update_sql);
					System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			db.close();
			return flag;
		}
		/**
		 * <p>���ݽ��׽ṹ�ͳ����ƻ�����ƴװ������Ҫ���µ��ֽ������ݣ���Ϊ�����ֽ������г��ֽ�����</p>
		 * @author Сл
		 * @param contract_condition_list ���׽ṹ
		 * @param data_table list_date:��װ�����ڵ�list��list_rent����װ��ÿ������list
		 * @param contract_id ��ͬ���
		 * @param adjust_id ���л�׼���ʱ���
		 * @date 2010-08-05���
		 * @return �ֽ������³ɹ����
		 */
		@SuppressWarnings("unchecked")
		private int exec_cashFlow(List<String> contract_condition_list,Hashtable  data_table,String contract_id,String adjust_id){
			int flag = 0;
			//ȡ���׽ṹ����
			String lease_money = contract_condition_list.get(0);//���ޱ��� 0
			String consulting_fee = contract_condition_list.get(1);//��ѯ�� 1
			String handling_charge = contract_condition_list.get(2);//������ 2
			String period_type = contract_condition_list.get(3);//1�ڳ�,0��ĩ֧�� 3
			String creator = contract_condition_list.get(4);//������ 4
			String create_date = contract_condition_list.get(5);//����ʱ�� 5
			String modificator = contract_condition_list.get(6);//�޸��� 6
			String modify_date = contract_condition_list.get(7);//�޸�ʱ�� 7
			String start_date = contract_condition_list.get(8);//������ 8
			//��2010-08-05�޸� �����ֶΡ�
			String equip_amt  = contract_condition_list.get(9);//�豸�� 9
			String other_expenditure  = contract_condition_list.get(10);//����֧�� 10
			String caution_money  = contract_condition_list.get(11);//��֤�� 11
			String return_amt  = contract_condition_list.get(12);//���̷�Ӷ 12
			String other_income  = contract_condition_list.get(13);//�������� 13
			String first_payment  = contract_condition_list.get(14);//�׸���  14
			String before_interest  = contract_condition_list.get(15);//��ǰϢ 15
			
			//�õ��������ںͳ�������б��list
			List<String> l_plan_date = (List<String>) data_table.get("list_date");
			List<String> l_rent = (List<String>) data_table.get("list_rent");
			
			//�ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤�� �г�irr
			RentCalc rent = new RentCalc();
			List l_RentDetails = rent.getRentDetails(l_rent,caution_money);
			
			String proj_id = "";//��ͬ�Ĳ�����Ŀ��ţ�Ϊ�մ���
			//�����ֽ���
			String del_sql = " delete  fund_contract_plan where contract_id = '"+contract_id+"' ";
			flag = this.execProjORcontract_xjl(l_plan_date,l_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, adjust_id,
						 creator, create_date, modificator, modify_date,del_sql,contract_id,"plan_irr",
						 "fund_contract_plan",before_interest);//
			
			//�г��ֽ��� 
			//�õ���֤��ֿ����List rent_list  ���List,caut_money  ��֤��
			List new_rent = rent.getRentCautNew(l_rent,caution_money);
			String new_del_sql = " delete  fund_contract_plan_mark where contract_id = '"+contract_id+"' ";
			flag = this.execProjORcontract_xjl_mark(l_plan_date,new_rent,lease_money,
						 consulting_fee, handling_charge, equip_amt,
						 other_expenditure, caution_money, return_amt,
						 other_income, first_payment, start_date,
						 period_type, proj_id, adjust_id,
						 creator, create_date, modificator, modify_date,new_del_sql,contract_id,"market_irr",
						 "fund_contract_plan_mark",before_interest,l_RentDetails);//
			
			return flag;
		}

		/**
		 * <p>��ѯ���׽ṹSQL,���ؽ������</p>
		 * @author Сл
		 * @param sql String
		 * @return List<String> list
		 */
		private List<String> execute_contract_condition_sql(String sql){
			Conn db = new Conn();
			ResultSet rs;
			List<String> list = new ArrayList<String>();
			try {
				rs = db.executeQuery(sql);//ִ�в�ѯ���׽ṹ
				System.out.println("��Ϣ�ֽ���֮��ѯ���׽ṹsql==> : "+sql);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				//��ʼ��
				String lease_money = "";//���ޱ���
				String consulting_fee = "";//��ѯ��
				String handling_charge = "";//������
				String period_type = "";//1�ڳ�,0��ĩ֧��
				String creator = "";//������
				String create_date = "";//����ʱ��
				String modificator = "";//�޸���
				String modify_date = "";//�޸�ʱ��
				String start_date = "";//������
				//��2010-08-05�޸� �����ֶΡ�
				String equip_amt  = "";//�豸�� 9
				String other_expenditure  = "";//����֧�� 10
				String caution_money  = "";//��֤�� 11
				String return_amt  = "";//���̷�Ӷ 12
				String other_income  = "";//�������� 13
				String first_payment  = "";//�׸���  14
				String before_interest  = "";//��ǰϢ 15
				//�����¼��������г�IRR��Ҫ�Ĳ���������
				String  income_number_year = "";//���ⷽʽ 16  ���ⷽʽ���¸�|����|���긶|�긶","1|3|6|12��
				String  income_number = "";//�껷����� 17 
				String  nominalprice = "";//������ 18
				
				//doc_id �ĵ���� == adjust_id tableName����µı���   contract_id ��ͬ��� proj_id ��Ŀ���
				String model_temp = "";//�����ж��ǲ���IRR���ֽ�����plan_irr�������г�IRR���ֽ�����market_irr�� 
				//ȡֵ
				while(rs.next()){
					lease_money = getZeroStr(getStr(rs.getString("lease_money")));//���ޱ���
					consulting_fee = getZeroStr(getStr(rs.getString("consulting_fee")));//��ѯ��
					handling_charge = getZeroStr(getStr(rs.getString("handling_charge")));//������
					//�����ֶβ���Ҫ�������⴦��
					period_type = getDBStr(rs.getString("period_type"));
					creator = getDBStr(rs.getString("creator"));
					create_date = getDBStr(rs.getString("create_date"));
					modificator = getDBStr(rs.getString("modificator"));
					modify_date = getDBStr(rs.getString("modify_date"));
					start_date = getStr(rs.getString("start_date"));
					//��2010-08-05�޸� �����ֶΡ�
					equip_amt  = getDBStr(rs.getString("equip_amt"));//�豸�� 9
					other_expenditure  = getDBStr(rs.getString("other_expenditure"));//����֧�� 10
					caution_money  = getDBStr(rs.getString("caution_money"));//��֤�� 11
					return_amt  = getDBStr(rs.getString("return_amt"));//���̷�Ӷ 12
					other_income  = getDBStr(rs.getString("other_income"));//�������� 13
					first_payment  = getDBStr(rs.getString("first_payment"));//�׸���  14
					before_interest  = getDBStr(rs.getString("before_interest"));//��ǰϢ 15
					income_number_year  = getDBStr(rs.getString("income_number_year"));//���ⷽʽ 16  
					income_number  = getDBStr(rs.getString("income_number"));//�껷����� 17 
					nominalprice  = getDBStr(rs.getString("nominalprice"));//18
				}
				//��װֵ
				list.add(lease_money);//0
				list.add(consulting_fee);//1
				list.add(handling_charge);//2
				list.add(period_type);//3
				list.add(creator);//4
				list.add(create_date);//5
				list.add(modificator);//6
				list.add(modify_date);//7
				list.add(start_date);//8
				//��2010-08-05�޸� �����ֶΡ�
				list.add(equip_amt);//9
				list.add(other_expenditure);//10
				list.add(caution_money);//11
				list.add(return_amt);//12
				list.add(other_income);//13
				list.add(first_payment);//14
				list.add(before_interest);//15
				list.add(income_number_year);//16
				list.add(income_number);//17
				list.add(nominalprice);//18
				
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return list;
		}
		/**
		 * <p>��ѯ��ͬ����б��SQL��</p>
		 * @author Сл
		 * @param sql String
		 * @return Hashtable list_date:��װ�����ڵ�list��list_rent����װ��ÿ������list
		 */
		@SuppressWarnings("unchecked")
		private Hashtable execute_fund_rent_plan(String sql){
			Conn db = new Conn();
			ResultSet rs;
			Hashtable  data_table = new Hashtable();
			try {
				rs = db.executeQuery(sql);
				System.out.println("��Ϣ�ֽ���֮��ͬ��𳥻��ƻ�sql==> : "+sql);
				System.out.println("-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
				String plan_date = "";
				String rent = "";
				List<String> list_date = new ArrayList<String>();
				List<String> list_rent = new ArrayList<String>();
				while(rs.next()){
					plan_date = getStr(getStr(rs.getString("plan_date")));//��������
					rent = getZeroStr(getStr(rs.getString("rent")));//ÿ�����
					list_date.add(plan_date);
					list_rent.add(rent);
				}
				data_table.put("list_date", list_date);
				data_table.put("list_rent", list_rent);
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			db.close();
			return data_table;
		}
		
		/**
		 * <p>��Ŀ(��ͬ)�������в���IRR���ֽ�������������</p>
		 * @author sea
		 * @param l_plan_date ���������б�List
		 * @param l_rent ����б�List
		 * @param lease_money ���ޱ���
		 * @param consulting_fee ��ѯ��
		 * @param handling_charge ������
		 * @param equip_amt �豸��
		 * @param other_expenditure ����֧��
		 * @param caution_money ��֤��
		 * @param return_amt ���̷�Ӷ
		 * @param other_income ��������
		 * @param first_payment �׸��� 
		 * @param other_expenditure ����֧��
		 * @param old_start_date ������
		 * @param period_type 1,�ڳ� 0,��δ��ֵ
		 * @param proj_id ��Ŀ���
		 * @param doc_id �ĵ����
		 * @param creator ������
		 * @param create_date ��������
		 * @param modificator �޸���
		 * @param modify_date �޸�����
		 * @param contract_id ��ͬ���
		 * @param model_temp �����ж��ǲ���IRR���ֽ�����plan_irr�������г�IRR���ֽ�����market_irr�� 
		 * @param tableName ����µı��� 
		 * @param before_interest ��ǰϢ
		 * @return �ֽ�������ɹ����
		 */
		@SuppressWarnings("unchecked")
		public int execProjORcontract_xjl(List l_plan_date,List l_rent,String lease_money,
				String consulting_fee,String handling_charge,String equip_amt,
				String other_expenditure,String caution_money,String return_amt,
				String other_income,String first_payment,String old_start_date,
				String period_type,String proj_id,String doc_id,
				String creator,String create_date,String modificator,String modify_date,
				String del_sql,String contract_id,String model_temp,String tableName,
				String before_interest){
			//
			Conn db = new Conn();
			int flag = 0;
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
			//������2�����������޸�ʱ��2010-06-29��
			String l_equip_amt = "-"+equip_amt;//�豸��
			String l_other_expenditure = "-"+other_expenditure;//����֧��
			
			Double count_money = 0.00;//������
			String follow_in_detailTemp = "";//�������嵥ƴװ
			String follow_out_detailTemp = "";//�������嵥ƴװ
			Double follow_out_money = 0.00;//�������ֽ�
			Double follow_in_money = 0.00;//�������ֽ�
			Double temp_in = 0.00;
			Double temp_out = 0.00;
			
			//�����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧��-�׸��� -��ǰϢ����������2010-07-23��
			//��һ���ֽ�����������룺-��֤��-������-���̷�Ӷ-��������-�׸��� -��ǰϢ��2010-07-23�޸ġ�
			//2010-07-14�޸� ����ȥ�� ��֤�� 
			if(model_temp.equals("plan_irr")){
				//Double.valueOf(caution_money) +
				temp_in =  Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}else{//market_irr
				//�г�IRR���ֽ�����������֤��	
				temp_in = Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}
			//��һ���ֽ������������: �豸�� ��ѯ�� ����֧�� ���ޱ���
			// + Double.valueOf(l_money) 2010-07-14�޸� ����ȥ�� ���ޱ���
			temp_out = Double.valueOf(l_equip_amt) + Double.valueOf(l_consulting_fee) + Double.valueOf(l_other_expenditure);
			//����Ҫ����
			Double now_temp_out = Double.valueOf(equip_amt) + Double.valueOf(consulting_fee) + Double.valueOf(other_expenditure);
			//�������嵥���ڳ� ���ϵ�һ�������嵥 ��ĩ�򲻼�	
			String str_follow_in_detailTemp = "";
			if(model_temp.equals("plan_irr")){
				////2010-07-14�޸� ����ȥ�� ��֤�� 
				str_follow_in_detailTemp = "";
				//str_follow_in_detailTemp = str_follow_in_detailTemp + " ��֤��:"+caution_money;
			}else{//market_irr
				str_follow_in_detailTemp = "";
			}
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ������:"+handling_charge;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ���̷�Ӷ:"+return_amt;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ��������:"+other_income;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " �׸���:"+first_payment;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ��ǰϢ:"+before_interest;
			//�������嵥 �ڳ���ĩһ��	
			String str_follow_out_detailTemp = "";
			str_follow_out_detailTemp = str_follow_out_detailTemp + " �豸��:"+equip_amt;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " ��ѯ��:"+consulting_fee;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " ����֧��:"+other_expenditure;
			// 2010-07-14�޸� ����ȥ�� ���ޱ���
			//str_follow_out_detailTemp = str_follow_out_detailTemp + " ���ޱ���:"+lease_money;
					
			//�ڳ���Ҫ�ӵ�һ�����  (period_type 1,�ڳ� 0,��δ��ֵ)
			if(period_type.equals("1")){
				String first_rent = l_rent.get(0).toString();//��һ����� ��ע�⡿
				//��һ���ֽ�����������롾��һ�����
				follow_in_money = temp_in + Double.valueOf(first_rent);//���վ�������
				//��һ���ֽ�������
				follow_out_money = now_temp_out;//���վ������� 
				//������ ���� - ���� 
				count_money = follow_in_money - follow_out_money;
				plan_date_list.add(old_start_date);//��һ���ֽ�����Ӧ���ڣ���������Ϊ׼
				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//��һ���ֽ�������
				//�������嵥
				follow_in_detailTemp = str_follow_in_detailTemp + " ��һ�����:"+first_rent+"";
				follow_in_detail_list.add(follow_in_detailTemp);//��һ���ֽ��������嵥����
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//��һ���ֽ�������
				//�������嵥
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//��һ���ֽ��������嵥
				//��һ���ֽ�����
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//�ڳ����list�ӵڶ�����ʼȡֵ�±�Ϊ1
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//����
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//����
					follow_in_detailTemp = "���:"+l_rent.get(i);
					follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
					follow_out_list.add("0.00");//����
					follow_out_detail_list.add("");//�����嵥
					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
				}
			}else{//��ĩ��������һ����� 
				follow_in_money = temp_in;//��һ��������Ϊ��������
				plan_date_list.add(old_start_date);//��һ������
				follow_in_list.add(formatNumberDoubleTwo(temp_in.toString()));//��һ������
				
				follow_in_detailTemp = str_follow_in_detailTemp;//��һ�������嵥
				follow_in_detail_list.add(follow_in_detailTemp);
				follow_out_money = now_temp_out;//
				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//������
				follow_out_detailTemp = str_follow_out_detailTemp;//��һ���ֽ��������嵥
				follow_out_detail_list.add(follow_out_detailTemp);
				count_money =  follow_out_money - follow_in_money;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//������
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//����
					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//����
					follow_in_detailTemp = "���:"+l_rent.get(i);
					follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
					follow_out_list.add("0.00");//����
					follow_out_detail_list.add("");//�����嵥
					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
				}
			}
			try {
				//ÿ�β���֮ǰ��ɾ��֮ǰ���������
				flag = db.executeUpdate(del_sql);
				System.out.println("�ֽ������ݲ���ǰ��ɾ�����==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				if(contract_id.equals("") || contract_id == null){
					flag = condition.update_fund_proj_plan(proj_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}else{
					flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>��Ŀ����ͬ�����������г�IRR���ֽ�������������</p>
		 * @author sea
		 * @param l_plan_date ���������б�List
		 * @param l_rent ����б�List
		 * @param lease_money ���ޱ���
		 * @param consulting_fee ��ѯ��
		 * @param handling_charge ������
		 * @param equip_amt �豸��
		 * @param other_expenditure ����֧��
		 * @param caution_money ��֤��
		 * @param return_amt ���̷�Ӷ
		 * @param other_income ��������
		 * @param first_payment �׸��� 
		 * @param other_expenditure ����֧��
		 * @param old_start_date ������
		 * @param period_type 1,�ڳ� 0,��δ��ֵ
		 * @param proj_id ��Ŀ���
		 * @param doc_id �ĵ����
		 * @param creator ������
		 * @param create_date ��������
		 * @param modificator �޸���
		 * @param modify_date �޸�����
		 * @param contract_id ��ͬ���
		 * @param model_temp �����ж��ǲ���IRR���ֽ�����plan_irr�������г�IRR���ֽ�����market_irr�� 
		 * @param tableName ����µı��� 
		 * @param before_interest ��ǰϢ
		 * @param l_RentDetails ��֤��ֿ����List ���з�װ����hashmap��hashmap�з�װ�����ֵ
		 * @return �ֽ�������ɹ����
		 */
		@SuppressWarnings("unchecked")
		public int execProjORcontract_xjl_mark(List l_plan_date,List l_rent,String lease_money,
				String consulting_fee,String handling_charge,String equip_amt,
				String other_expenditure,String caution_money,String return_amt,
				String other_income,String first_payment,String old_start_date,
				String period_type,String proj_id,String doc_id,
				String creator,String create_date,String modificator,String modify_date,
				String del_sql,String contract_id,String model_temp,String tableName,
				String before_interest,List l_RentDetails){
			//�ȴ���֤��ֿ����List
			List new_follow_in = new ArrayList();//������
			List new_follow_in_detail = new ArrayList();//�������嵥
			List new_follow_out = new ArrayList();//������
			List new_follow_out_detail = new ArrayList();//�������嵥
			List new_net_follow = new ArrayList();//��������
			if(l_RentDetails.size() > 0){
				for(int i = 0;i < l_RentDetails.size();i++){
					Hashtable map = new Hashtable<String, String>();
					map = (Hashtable) l_RentDetails.get(i);
					new_follow_in.add(map.get("follow_in"));
					new_follow_in_detail.add(map.get("follow_in_detail"));
					new_follow_out.add(map.get("follow_out"));
					new_follow_out_detail.add(map.get("follow_out_detail"));
					new_net_follow.add(map.get("net_follow"));
				}
			}
			Conn db = new Conn();
			int flag = 0;
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
			//������2�����������޸�ʱ��2010-06-29��
			String l_equip_amt = "-"+equip_amt;//�豸��
			String l_other_expenditure = "-"+other_expenditure;//����֧��
			
			Double count_money = 0.00;//������
			String follow_in_detailTemp = "";//�������嵥ƴװ
			String follow_out_detailTemp = "";//�������嵥ƴװ
			Double follow_out_money = 0.00;//�������ֽ�
			Double follow_in_money = 0.00;//�������ֽ�
			Double temp_in = 0.00;
			Double temp_out = 0.00;
			
			//�����ʶ�=�豸��-��֤��-������-���̷�Ӷ-��������+��ѯ��+����֧��-�׸��� -��ǰϢ����������2010-07-23��
			//��һ���ֽ�����������룺-��֤��-������-���̷�Ӷ-��������-�׸��� -��ǰϢ��2010-07-23�޸ġ�
			//2010-07-14�޸� ����ȥ�� ��֤�� ----- 2010-07-28�޸� �г����ϱ�֤��
			if(model_temp.equals("market_irr")){
				//Double.valueOf(caution_money) +
				temp_in =  Double.valueOf(caution_money) +Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}else{//market_irr
				//����IRR���ֽ�����������֤��	Double.valueOf(caution_money) +
				temp_in = Double.valueOf(handling_charge) + Double.valueOf(return_amt) + Double.valueOf(other_income) + Double.valueOf(first_payment)+Double.valueOf(before_interest);
			}
			//��һ���ֽ������������: �豸�� ��ѯ�� ����֧�� ���ޱ���
			// + Double.valueOf(l_money) 2010-07-14�޸� ����ȥ�� ���ޱ���
			temp_out = Double.valueOf(l_equip_amt) + Double.valueOf(l_consulting_fee) + Double.valueOf(l_other_expenditure);
			//����Ҫ����
			Double now_temp_out = Double.valueOf(equip_amt) + Double.valueOf(consulting_fee) + Double.valueOf(other_expenditure);
			//�������嵥���ڳ� ���ϵ�һ�������嵥 ��ĩ�򲻼�	
			String str_follow_in_detailTemp = "";
			if(model_temp.equals("market_irr")){//market_irr
				////2010-07-14�޸� ����ȥ�� ��֤�� -- 2010-07-28�޸� �г����ϱ�֤��
				str_follow_in_detailTemp = "";
				str_follow_in_detailTemp = str_follow_in_detailTemp + " ��֤��:"+caution_money;
			}else{//����IRR ��֤�𲻼���###########
				str_follow_in_detailTemp = "";
			}
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ������:"+handling_charge;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ���̷�Ӷ:"+return_amt;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ��������:"+other_income;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " �׸���:"+first_payment;
			str_follow_in_detailTemp = str_follow_in_detailTemp + " ��ǰϢ:"+before_interest;
			//�������嵥 �ڳ���ĩһ��	
			String str_follow_out_detailTemp = "";
			str_follow_out_detailTemp = str_follow_out_detailTemp + " �豸��:"+equip_amt;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " ��ѯ��:"+consulting_fee;
			str_follow_out_detailTemp = str_follow_out_detailTemp + " ����֧��:"+other_expenditure;
			// 2010-07-14�޸� ����ȥ�� ���ޱ���
			//str_follow_out_detailTemp = str_follow_out_detailTemp + " ���ޱ���:"+lease_money;
			
			//�ڳ���Ҫ�ӵ�һ�����  (period_type 1,�ڳ� 0,��δ��ֵ)
			if(period_type.equals("1")){
				String first_rent = l_rent.get(0).toString();//��һ����� ��ע�⡿
				//��һ���ֽ�����������롾��һ�����
				follow_in_money = temp_in + Double.valueOf(first_rent);//���վ�������
				//��һ���ֽ�������
				follow_out_money = now_temp_out;//���վ������� 
				//������ ���� - ���� 
				count_money = follow_in_money - follow_out_money;
				plan_date_list.add(old_start_date);//��һ���ֽ�����Ӧ���ڣ���������Ϊ׼
				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//��һ���ֽ�������
				//�������嵥
				follow_in_detailTemp = str_follow_in_detailTemp + " ��һ�����:"+first_rent+"";
				follow_in_detail_list.add(follow_in_detailTemp);//��һ���ֽ��������嵥����
				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//��һ���ֽ�������
				//�������嵥
				follow_out_detailTemp = str_follow_out_detailTemp;
				follow_out_detail_list.add(follow_out_detailTemp);//��һ���ֽ��������嵥
				//��һ���ֽ�����
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));
				//�ڳ����list�ӵڶ�����ʼȡֵ�±�Ϊ1
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//����
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//������
					//follow_in_detailTemp = "���:"+new_follow_in.get(i);
					follow_in_detail_list.add(new_follow_in_detail.get(i).toString());//�������嵥
					follow_out_list.add(formatNumberDoubleTwo(new_follow_out.get(i).toString()));//������
					follow_out_detail_list.add(new_follow_out_detail.get(i).toString());//�������嵥
					net_follow_list.add(formatNumberDoubleTwo(new_net_follow.get(i).toString()));//������
				}
			}else{//��ĩ��������һ����� 
				follow_in_money = temp_in;//��һ��������Ϊ��������
				plan_date_list.add(old_start_date);//��һ������
				follow_in_list.add(formatNumberDoubleTwo(temp_in.toString()));//��һ������
				
				follow_in_detailTemp = str_follow_in_detailTemp;//��һ�������嵥
				follow_in_detail_list.add(follow_in_detailTemp);
				follow_out_money = now_temp_out;//
				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//������
				follow_out_detailTemp = str_follow_out_detailTemp;//��һ���ֽ��������嵥
				follow_out_detail_list.add(follow_out_detailTemp);
				count_money = follow_out_money - follow_in_money ;//
				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//������
				for(int i = 1;i < l_rent.size();i++){
					plan_date_list.add(l_plan_date.get(i).toString());//����
					follow_in_list.add(formatNumberDoubleTwo(new_follow_in.get(i).toString()));//������
					follow_in_detail_list.add(new_follow_in_detail.get(i).toString());//�������嵥
					follow_out_list.add(formatNumberDoubleTwo(new_follow_out.get(i).toString()));//������
					follow_out_detail_list.add(new_follow_out_detail.get(i).toString());//�������嵥
					net_follow_list.add(formatNumberDoubleTwo(new_net_follow.get(i).toString()));//������
				}
			}
			try {
				//ÿ�β���֮ǰ��ɾ��֮ǰ���������
				flag = db.executeUpdate(del_sql);
				System.out.println("�ֽ������ݲ���ǰ��ɾ�����==> :"+del_sql);
				ConditionOperating condition = new ConditionOperating();
				if(contract_id.equals("") || contract_id == null){//�����ͬ���Ϊ�յĻ� ������Ŀ���ֽ��� �����ֽ����ı��淽��
					flag = condition.update_fund_proj_plan(proj_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}else{//��������ͬ�ֽ����ı��淽��
					flag = condition.update_fund_contract_plan(contract_id,doc_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date,tableName);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return flag;
		}
		/**
		 * <p>request�ַ������Ĵ���</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String getStr(String str) 
		{
			try
			{
				String temp_p = str;
				byte[] temp_t = temp_p.getBytes("ISO8859-1");
				String temp = new String(temp_t);
				return temp;
			}catch(Exception e) {
			}
			return "";
		}
		
		/**
		 * <p>�����ַ���ת��Ϊ"0"��</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String getZeroStr(String str){
			try{
				String temp_n = str;
				if(temp_n == null || temp_n.equals("") || temp_n.equals("null")){
					temp_n = "0";
				}
				return temp_n;
			}catch(Exception e){
			
			}
			return "0";
		}
		
		/**
		 * <p>DB�ַ���ȡ������</p>
		 * @author common.jsp
		 * @param str �����ַ���
		 * @return �ַ���Ϊ�շ��ؿմ�
		 */
		public String getDBStr(String str){
			try
			{
		        String temp_n = str;
		        if ((temp_n == null) || (temp_n.equals("")) || (temp_n.equals("null"))){
		        	temp_n = "";
		        }
		        return temp_n; 
			}catch(Exception e){
				e.printStackTrace();
			}
			return "";
		}
		/**
		 * <p>���ָ�ʽ��Ϊ2λС����</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberDoubleTwo(String str){
			try
			{
		        String temp_num=str;
		            if ((temp_num==null) || (temp_num.equals("")))
		        {
		        temp_num="";
		        }
		        else
		        {
				 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
				 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
				 BigDecimal bd = new BigDecimal(temp_num);
				 temp_num=ft.format(bd);
		 
		        }
		        return temp_num; 
			}
			catch(Exception e)
			{
			}
			return "";
		}
		/**
		 * <p>���ָ�ʽ��Ϊ2λС����</p>
		 * @author common.jsp
		 * @param str
		 * @return
		 */
		public String formatNumberDoubleTwo(double str){
			try
			{
		        String temp_num=String.valueOf(str);
		            if ((temp_num==null) || (temp_num.equals("")))
		        {
		        temp_num="";
		        }
		        else
		        {
				 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.00");
				 BigDecimal bd=new BigDecimal(temp_num);
				 temp_num=ft.format(bd);
		 
		        }
		        return temp_num; 
			}
			catch(Exception e)
			{
			}
			return "";
		}
		//****************************************��2010-08-05�޸� ��д�µĵ�Ϣ�ֽ������� ���Ϸ�������		
//		/**
//		 * <p>���ݽ��׽ṹ�ͳ����ƻ�����ƴװ������Ҫ������6��list��ִ�С�</p>
//		 * @author Сл
//		 * @param contract_condition_list ���׽ṹ
//		 * @param data_table list_date:��װ�����ڵ�list��list_rent����װ��ÿ������list
//		 * @param contract_id ��ͬ���
//		 * @param adjust_id ���л�׼���ʱ���
//		 * @return
//		 */
//		@SuppressWarnings("unchecked")
//		private int getCashFlowList(List<String> contract_condition_list,Hashtable  data_table,String contract_id,String adjust_id){
//			int flag = 0;
//			Conn db = new Conn();
//			//��ʼ��6�����飺���� plan_date_list,������ follow_in_list,�������嵥 follow_in_detail_list
//			//������ follow_out_list,�������嵥 follow_out_detail_list,������ net_follow_list
//			List<String> plan_date_list = new ArrayList<String>();//
//			List<String> follow_in_list = new ArrayList<String>();//
//			List<String> follow_in_detail_list = new ArrayList<String>();//
//			List<String> follow_out_list = new ArrayList<String>();//
//			List<String> follow_out_detail_list = new ArrayList<String>();//
//			List<String> net_follow_list = new ArrayList<String>();//
//			//���׽ṹ����
//			String lease_money = contract_condition_list.get(0);//���ޱ���
//			String consulting_fee = contract_condition_list.get(1);//��ѯ��
//			String handling_charge = contract_condition_list.get(2);//������
//			String period_type = contract_condition_list.get(3);//1�ڳ�,0��ĩ֧��
//			String creator = contract_condition_list.get(4);//������
//			String create_date = contract_condition_list.get(5);//
//			String modificator = contract_condition_list.get(6);//
//			String modify_date = contract_condition_list.get(7);//
//			String start_date = contract_condition_list.get(8);//������
//			//���������γɵķ���
//			String l_money = "-"+lease_money;//���ޱ���
//			String l_consulting_fee = "-"+consulting_fee;//��ѯ��
//			String l_handling_charge = handling_charge;//������
//			//��𳥻��б�����
//			List<String> l_plan_date = (List<String>) data_table.get("list_date");
//			List<String> l_rent = (List<String>) data_table.get("list_rent");
//			//
//			Double count_money = 0.00;//������
//			String follow_in_detailTemp = "";//�������嵥ƴװ
//			String follow_out_detailTemp = "";//�������嵥ƴװ
//			Double follow_out_money = 0.00;//�������ֽ�
//			Double follow_in_money = 0.00;//�������ֽ�
//			//
//			//�ڳ�����ѯ��+���ޱ���+������+��һ�����  (period_type 1,�ڳ� 0,��δ��ֵ)
//			if(period_type.equals("1")){
//				String first_rent = l_rent.get(0).toString();//��һ�����
//				follow_in_money = Double.valueOf(l_handling_charge)+Double.valueOf(first_rent);//������+��һ����� ������
//				follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//���ޱ���+��ѯ��  ������ 
//				count_money = follow_out_money+follow_in_money;//������
//				plan_date_list.add(start_date);//��һ���ֽ�����Ӧ���ڣ���������Ϊ׼
//				follow_in_list.add(formatNumberDoubleTwo(String.valueOf(follow_in_money)));//��һ���ֽ�����������
//				follow_in_detailTemp = "������:"+l_handling_charge+" ��һ�����:"+first_rent+" ";
//				follow_in_detail_list.add(follow_in_detailTemp);//��һ���ֽ��������嵥����
//				follow_out_list.add(String.valueOf(formatNumberDoubleTwo(follow_out_money)));//��һ���ֽ�������
//				follow_out_detailTemp = ":���ޱ���"+lease_money+" ��ѯ��:"+consulting_fee+"";//��һ���ֽ��������嵥
//				follow_out_detail_list.add(follow_out_detailTemp);
//				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//��һ���ֽ�����
//				//�ڳ����list�ӵڶ�����ʼȡֵ�±�Ϊ1
//				for(int i = 1;i < l_rent.size();i++){
//					plan_date_list.add(l_plan_date.get(i).toString());//����
//					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//���
//					follow_in_detailTemp = "���:"+l_rent.get(i);
//					follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
//					follow_out_list.add("-0.00");//����
//					follow_out_detail_list.add("");//�����嵥
//					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
//				}
//			}else{//��ĩ��������һ����� 
//				follow_in_money = Double.valueOf(l_handling_charge);//��һ��������Ϊ��������
//				plan_date_list.add(start_date);//��һ������
//				follow_in_list.add(formatNumberDoubleTwo(Double.valueOf(follow_in_money).toString()));//��һ������
//				follow_in_detailTemp = "������:"+l_handling_charge;//��һ���嵥
//				follow_in_detail_list.add(follow_in_detailTemp);
//				follow_out_money = Double.valueOf(l_money)+Double.valueOf(l_consulting_fee);//���ޱ���+��ѯ��
//				follow_out_list.add(formatNumberDoubleTwo(String.valueOf(follow_out_money)));//������
//				follow_out_detailTemp = ":���ޱ���"+lease_money+" ��ѯ��:"+consulting_fee+"";//��һ���ֽ��������嵥
//				follow_out_detail_list.add(follow_out_detailTemp);
//				count_money = follow_in_money+follow_out_money;//
//				net_follow_list.add(formatNumberDoubleTwo(String.valueOf(count_money)));//������
//				for(int i = 0;i < l_rent.size();i++){
//					plan_date_list.add(l_plan_date.get(i).toString());//����
//					follow_in_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//���
//					follow_in_detailTemp = "���:"+l_rent.get(i);
//					follow_in_detail_list.add(follow_in_detailTemp);//�����嵥
//					follow_out_list.add("-0.00");//����
//					follow_out_detail_list.add("");//�����嵥
//					net_follow_list.add(formatNumberDoubleTwo(l_rent.get(i).toString()));//������
//				}
//			}
//			//ÿ�β���֮ǰ��ɾ��֮ǰ���������
//			String del_sql = " delete from fund_contract_plan where contract_id = '"+contract_id+"' and adjust_id = '"+adjust_id+"' and note = '��Ϣ'";
//			try {
//				System.out.println("delete from fund_contract_plan����SQL���Ϊ==> : "+del_sql);
//				flag = db.executeUpdate(del_sql);//adjust_id == doc_id
//				flag = this.update_fund_contract_plan(contract_id,adjust_id,plan_date_list,follow_in_list,follow_in_detail_list,follow_out_list,follow_out_detail_list,net_follow_list, creator, create_date,modificator, modify_date);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			db.close();
//			return flag;
//		}
//		/**
//		 * <p>���±�fund_contract_plan������</p>
//		 * @author Сл
//		 * @param contract_id ��ͬ���
//		 * @param doc_id  �ĵ����
//		 * @param plan_date_list ����list
//		 * @param follow_in_list �ֽ�������list
//		 * @param follow_in_detail_list �ֽ��������嵥list
//		 * @param follow_out_list  �ֽ�������list
//		 * @param follow_out_detail_list �ֽ��������嵥list
//		 * @param net_follow_list ������list
//		 * @param creator ������
//		 * @param create_date ��������
//		 * @param modify_date �޸�����
//		 * @param modificator �޸���
//		 * @return ���½�� 0:����ʧ�� >0���³ɹ� ��������:INT 
//		 */
//		public int update_fund_contract_plan(String contract_id,String doc_id,List<String> plan_date_list,List<String> follow_in_list,List<String> follow_in_detail_list,List<String> follow_out_list,List<String> follow_out_detail_list,List<String> net_follow_list,String creator,String create_date,String modify_date,String modificator){
//			//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//��ʽ��ʱ��
//			//String nowTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
//			//��ʼ��6�����飺���� plan_date_list,������ follow_in_list,�������嵥 follow_in_detail_list
//			//������ follow_out_list,�������嵥 follow_out_detail_list,������ net_follow_list
//			System.out.println("join�෽��");
//			int count = 0;
//			Conn db = new Conn();
//			StringBuffer sql = new StringBuffer();
//			for(int i = 0;i < plan_date_list.size();i++){
//				sql.append(" INSERT INTO fund_contract_plan ")
//				.append(" (contract_id ,doc_id ,plan_date ,follow_in ")
//				.append(" ,follow_in_detail ,follow_out ,follow_out_detail ")
//				.append(" ,net_follow ,creator ,create_date ,modificator ,modify_date,note) ")
//				.append(" VALUES ")
//				.append(" ('"+contract_id+"','"+doc_id+"' ")
//				.append(" ,'"+plan_date_list.get(i)+"' ")//���� formatNumberDoubleTwo
//				.append(" ,'"+follow_in_list.get(i)+"' ")//����
//				.append(" ,'"+follow_in_detail_list.get(i)+"' ")//�����嵥
//				.append(" ,'"+follow_out_list.get(i)+"' ")//����
//				.append(" ,'"+follow_out_detail_list.get(i)+"' ")//�����嵥
//				.append(" ,'"+net_follow_list.get(i)+"' ")//������
//				.append(" ,'"+creator+"' ")//������
//				.append(" ,'"+create_date+"' ")//��������
//				.append(" ,'"+modify_date+"' ")//�޸����� 
//				.append(" ,'"+modificator+"','��Ϣ'); ");//�޸���
//				// System.out.println("����SQL���Ϊ==> : "+sql.toString());
//			}
//			
//			try {
//				count = db.executeUpdate(sql.toString());
//				System.out.println("INSERT INTO fund_contract_plan����SQL���Ϊ==> : "+sql.toString());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}finally{
//				db.close();
//			}
//			return count;
//		}
}
