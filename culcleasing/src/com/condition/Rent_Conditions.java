package com.condition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Tools;
import com.rent.calc.bg.RentCalc;
import com.rent.calc.bg.RentDelayCalc;
import com.rent.calc.bg.RentDelayGraceCalc;
import com.rent.calc.bg.RentGraceCalc;

import dbconn.Conn;


/**
 * <p>���������SAVEҳ�������������ȫ������װ����̨��������</p>
 * @author Сл
 * <p>Oct 22, 2010</p>
 */
public class Rent_Conditions {
	
	@SuppressWarnings("unchecked")
	public List fz_Conditions(Map<String,String> map,String type){
		Conn db = new Conn();
		Tools tools = new Tools();
		List new_rent = new ArrayList<List<String>>();
		
		RentCalc rent = new RentCalc();
		//��һ���ֲ�������
		rent.setYear_rate(map.get("year_rate")); //������  0 
		rent.setIncome_number(map.get("income_number"));//���� 
		rent.setLease_money(map.get("lease_money"));//���ޱ��� �����ޱ��� = �豸��� - �׸��
		rent.setFuture_money(map.get("nominalprice"));//������   
		rent.setPeriod_type(map.get("period_type"));//1,�ڳ� 0,��δ��ֵ  
		rent.setIrr_type("2");//1,Ϊ���·ݵĴ�; 2,Ϊ��������Ĵ��� ��ʱ��2   
		rent.setScale("8");//irr��С��λ�� ��ʱ����8λ   
		rent.setLease_interval(map.get("income_number_year"));//����� (���ⷽʽ)  
		rent.setPlan_date(map.get("now_start_date"));//ÿ�³����� �滻 ������ �ľ�������  
		rent.setContract_id(map.get("proj_id"));//���������Ŀ�ֽ�����KEY 
		rent.setRentScale(map.get("rentScale"));//Բ����   
		//�ڶ����ֲ�������
		Double mon = Double.parseDouble(map.get("net_lease_money"))+ Double.parseDouble(map.get("caution_money"));
		rent.setCle_cau_Money(mon.toString());//�����ʶ� net_lease_money+��֤�� caution_money
		rent.setCauti_Money(map.get("caution_money"));//��֤��
		rent.setFuture_money(map.get("nominalprice"));//��ĩ��ֵ ��ע���Ӹ��ű�Ϊ��������2010-08-04 �޸�ȥ�����š�
		rent.setStart_date(map.get("now_start_date"));//��֤�������ʱ��
		//�������ֲ�������
		//��������ֽ�����װ ��Ҫ�� ���ޱ��������ѣ���ѯ�� ��
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		//�޸ģ�-�����ʶ� net_lease_money-��֤�� caution_money  �����IRR
		Double list_mon =( Double.parseDouble(map.get("net_lease_money")) + Double.parseDouble(map.get("caution_money")) )*-1;
		llist_case.add(list_mon.toString());
		list_date.add(map.get("start_date"));
		rent.setPreCash(llist_case);//
	    rent.setPreDate(list_date);//
		System.out.println("�����ʶ�Ϊ==>"+map.get("net_lease_money"));
		System.out.println("��֤��==>"+map.get("caution_money"));
		System.out.println("�豸��==>"+map.get("equip_amt"));
		System.out.println("ֵΪ==>"+map.get("list_mon)"));
		System.out.println("����==>"+map.get("start_date"));
		List rent_list = new ArrayList();
		List l_plan_date_ = new ArrayList();
		/* ������� */
		//delay	int �ӳ�����//grace int��������
		//RentDelayGraceCalc�ӳٸ���,�����ڹ���������//RentGraceCalc�����ڹ���������//RentDelayCalc�ӳٸ������������
		int tem_delay = Integer.parseInt(map.get("delay"));//�ӳ�����
		int tem_grace = Integer.parseInt(map.get("grace"));//��������
		if(type.equals("����")){
			//����������£�������������£�
			rent_list = rent.eqRentList(rent.getYear_rate());// �õ����list,ע�ⲻ����ʱ�����list (ֻ���µ�����LIST�������� ��������Щ�ֽ�)
			//getPlanDateList(����һ,������)   ����һ �Ϸ����飬���list ������ �ڳ�(1)or��ĩ֧��(0)
			l_plan_date_ = rent.getPlanDateList(rent_list, rent.getPeriod_type());// �ƻ�ʱ�� 
		}
		else if(type.equals("�����0�ӵ���0")){
			RentGraceCalc rent2 = new RentGraceCalc();
			rent_list = rent2.eqRentList(rent.getYear_rate(),tem_grace);// �õ����list,ע�ⲻ����ʱ�����list (ֻ���µ�����LIST�������� ��������Щ�ֽ�)
			l_plan_date_ = rent2.getPlanDateList(rent_list, rent.getPeriod_type());// �ƻ�ʱ�� 
		}
		else if(type.equals("�����0�Ӵ���0")){
			RentDelayCalc rent3 = new RentDelayCalc();
			//����������£�������������£�
			rent_list = rent.eqRentList(rent.getYear_rate());// �õ����list,ע�ⲻ����ʱ�����list (ֻ���µ�����LIST�������� ��������Щ�ֽ�)
			//getPlanDateList(����һ,������)   ����һ �Ϸ����飬���list ������ �ڳ�(1)or��ĩ֧��(0)
			l_plan_date_ = rent3.getPlanDateList(rent_list, rent.getPeriod_type(),tem_delay);// �ƻ�ʱ�� 
		}else{//��>0��>0
			 RentDelayGraceCalc  rent4 = new RentDelayGraceCalc();
		}
		
		//����˵�� getHashRentPlan(����һ,������,������) 
		//����һ����measure_type�����㷽���������������Ϸ���list ��װ����������б�  ������ l_plan_date_ �Ϸ����� ��װʱ��Ľ����
		String m_type = tools.getStr(map.get("measure_type"));
		if ("0".equals(m_type)) {
			m_type="1";
		}
		HashMap hm;
		try {
			hm = rent.getHashRentPlan(m_type, rent_list, l_plan_date_);
			//���������
			List l_plan_date = new ArrayList();
			List l_rent = new ArrayList();
			List l_corpus = new ArrayList();
			List l_interest = new ArrayList();
			List l_corpus_overage = new ArrayList();
			//ȡֵ
			l_plan_date = (List)hm.get("plan_date");//��𳥻�����
			l_rent = (List)hm.get("rent");//���
			l_corpus = (List)hm.get("corpus");//����
			l_interest = (List)hm.get("interest");//��Ϣ
			l_corpus_overage = (List)hm.get("corpus_overage");//ʣ�౾��
			//����irr  
			Double irr = Double.parseDouble(rent.getV_irr())*100;
			//�г�IRR 
			Double Markirr = Double.parseDouble(rent.getMarket_irr())*100;
			//�޸ġ����������������мƻ�IRR��ֵ
			String sqlstr = "update proj_condition_temp set plan_irr="+irr+",market_irr = "+Markirr+"   where proj_id='"+map.get("proj_id")+"' and measure_id = '"+map.get("doc_id")+"' ";
			db.executeUpdate(sqlstr);
			//* �õ� �г������ƻ���һЩ��Ϣ
			//* 
			//* @param p_year_rate //ÿһ�ڵ���Ϣ (�г�IRR/100/12(�·�))*�����
			//* @param rent_c_list ��� list       l_rent
			//* @param lease_money_p  ��Ҫ����ı���   ��ͬ�� ���ޱ���lease_money ����ֶ�
			//* @param period_type_p  �ڳ�����ĩ      
			//* @return
			//*/
			Double temp_num = (Double.parseDouble(map.get("year_rate"))/100/12)*Double.parseDouble(map.get("income_number_year"));
			//���������ֶΡ��г������г���Ϣ���г�������
			HashMap hx = rent.getPlanMarketByEqRent(String.valueOf(temp_num),l_rent,map.get("lease_money"),map.get("period_type"));
			List l_corpus_market = new ArrayList();
			List l_interest_market = new ArrayList();
			List l_corpus_overage_market = new ArrayList();
			l_corpus_market = (List) hx.get("corpus_market");//�г�����
			l_interest_market = (List) hx.get("interest_market");//�г���Ϣ
		    l_corpus_overage_market = (List) hx.get("corpus_overage_market");//�г��������
			//�������  fund_rent_plan_temp //������ ���� �ĵ����
			sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+map.get("proj_id")+"' and measure_id='"+map.get("doc_id")+"'";
			db.executeUpdate(sqlstr);
			//���뵽�б�
			for(int i=0;i<l_rent.size();i++){
				//�����ֶ�˳��:�ĵ����(������),��ͬ���,����״̬,���,����,��Ϣ,�������,������
				sqlstr="insert into fund_rent_plan_proj_temp"+
				       "(measure_id,proj_id,"+
				       "rent_list,plan_date,plan_status,rent,corpus,"+
				       "interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
				       "select '"+map.get("doc_id")+"','"+map.get("proj_id")+"',"+(i+1)+","+
				       "'"+l_plan_date.get(i)+"','δ����',"+l_rent.get(i)+","+
				       ""+l_corpus.get(i)+","+l_interest.get(i)+","+
				       ""+l_corpus_overage.get(i)+","+map.get("year_rate")+","+
				       l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
				System.out.println("^^^^^^^^^^^^^^^������sql=====> "+sqlstr);
				db.executeUpdate(sqlstr);
			}
			//�ֽ����õ���2��list
			List l_RentDetails = new ArrayList(); 
			//�ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤��
			l_RentDetails = rent.getRentDetails(l_rent,map.get("caution_money"));
			//�õ���֤��ֿ����List rent_list  ���List,caut_money  ��֤��
			new_rent = rent.getRentCautNew(l_rent,map.get("caution_money"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new_rent;
		
	}	
}
