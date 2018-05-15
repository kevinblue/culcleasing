package com.tenwa.culc.calc.util;

import java.util.List;
import com.Tools;
import dbconn.Conn;

/**
 * <p>���������������ݵĴ�������</p>
 * @author Сл
 * <p>Jan 11, 2011</p>
 */
public class Rent_init {
	
	/**
	 * <p>���ݴ�����������¶�Ӧ����𳥻��ƻ���</p>
	 * @author Сл
	 * @param tableName ����
	 * @param l_plan_date ��������list
	 * @param l_rent ���list
	 * @param l_corpus ���񱾽�list
	 * @param l_interest ������Ϣlist
	 * @param l_corpus_overage ����ʣ�౾��list
	 * @param year_rate ������
	 * @param l_corpus_market �г�����list
	 * @param l_interest_market �г���Ϣlist
	 * @param l_corpus_overage_market �г�ʣ�౾��list
	 * @param doc_id �ĵ����
	 * @param proj_id ��Ŀ���
	 * @param contract_id ��ͬ���
	 * @return ���³ɹ���� int
	 */
	@SuppressWarnings("unchecked")
	public int init_Rent(String tableName,List l_plan_date,
				List l_rent,List l_corpus,List l_interest,List l_corpus_overage,
				String year_rate,
				List l_corpus_market,List l_interest_market,List l_corpus_overage_market,
				String doc_id,String proj_id,String contract_id){
		int flag = 0;
		String sqlstr = "";
		Conn db = new Conn();
		//��Ŀ��𳥻��ƻ�����
		if("fund_rent_plan_proj_temp".equals(tableName)){
			//��ɾ���ٸ���
			sqlstr = "delete from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
			try {
				flag = db.executeUpdate(sqlstr);
				for(int i=0;i<l_rent.size();i++){
					//�����ֶ�˳��:�ĵ����(������),��ͬ���,����״̬,���,����,��Ϣ,�������,������
					sqlstr="insert into fund_rent_plan_proj_temp"+
					"(measure_id,proj_id,"+
					"rent_list,plan_date,plan_status,rent,corpus,"+
					"interest,corpus_overage,year_rate,corpus_market,interest_market,corpus_overage_market) "+
					"select '"+doc_id+"','"+proj_id+"',"+(i+1)+","+
					"'"+l_plan_date.get(i)+"','δ����',"+l_rent.get(i)+","+
					""+l_corpus.get(i)+","+l_interest.get(i)+","+
					""+l_corpus_overage.get(i)+","+year_rate+","+
					l_corpus_market.get(i)+","+l_interest_market.get(i)+","+l_corpus_overage_market.get(i)+" ;";
					//System.out.println("^^^^^^^^^^^^^^^������sql=====> "+sqlstr);
					flag = db.executeUpdate(sqlstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//��ͬ��𳥻��ƻ�����
		else if("fund_rent_plan_temp".equals(tableName)){
			//�������  fund_rent_plan_temp //������ ���� �ĵ����
			sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			try {
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
					//System.out.println(i+"^^^^^^^^^^^^^^^��ͬ���������sqlstr2====="+sqlstr);
					db.executeUpdate(sqlstr);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else{
			flag = -1;
		}
		db.close();
		return flag;
	}
	
	/**
	 * <p>���½��׽ṹ�еĲ���IRR���г�IRR��</p>
	 * @author Сл
	 * @param irr ����irr
	 * @param Markirr �г�irr
	 * @param proj_id ��Ŀ���
	 * @param doc_id �ĵ����
	 * @param contract_id ��ͬ���
	 * @param tabelNmae ����
	 * @return ���ظ��³ɹ���� int
	 */
	@SuppressWarnings("static-access")
	public int init_irr(String irr,String Markirr,String proj_id,String doc_id,String contract_id,String tabelNmae){
		int flag = 0;
		Tools tools = new Tools();
		Conn db = new Conn();
		String sqlstr = "";
		try {
			if("proj_condition_temp".equals(tabelNmae)){//��Ŀ���׽ṹ
				sqlstr = "update proj_condition_temp set plan_irr="+tools.formatNumberDoubleScale(irr,8)+"*100 where proj_id='"+proj_id+"' and doc_id = '"+doc_id+"' ";
			}else if("contract_condition_temp".equals(tabelNmae)){//��ͬ���׽ṹ
				sqlstr = "update contract_condition_temp set plan_irr="+tools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"+contract_id+"' and doc_id = '"+doc_id+"'  ";
			}
			flag = db.executeUpdate(sqlstr);	
			System.out.println("���½��׽ṹirr��sql--��"+sqlstr);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			db.close();
		}
		return flag;
	}
}
