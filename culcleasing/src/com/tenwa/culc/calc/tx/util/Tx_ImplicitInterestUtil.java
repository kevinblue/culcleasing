package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.Tools;
/**
 * 
 * @author toybaby
 * Date:Aug 18, 201111:46:51 AM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_ImplicitInterestUtil {
	/**�����������ʵ�Ϣ��rentInfoBox
	 * @param contract_id
	 * @param begin_id
	 * @param condition_Map
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public Tx_RentInfoBox getRentInfoBox(String contract_id,String begin_id,String settle_method,Map condition_Map) throws SQLException{
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		Tx_DataCtrolUtil dataCtrolUtil = new Tx_DataCtrolUtil();
		String rent_list_start = condition_Map.get("rent_list_start").toString();
		
		List<String> l_rent = new ArrayList<String>();//��Ϣ���µ����ƻ�
		List<String> l_new_rent = new ArrayList<String>();//��Ϣ���µ����ƻ�
		List<String> l_interest = new ArrayList<String>();//��Ϣ���µ���Ϣ�ƻ�
		List<String> l_corpus = new ArrayList<String>();//����ƻ�
		List<String> l_corpus_overage = new ArrayList<String>();//ʣ�౾��
		Map<String, List<String>> rentInfo_Map = new HashMap<String, List<String>>();//��𣬱���list
		//��һ��:��õ�Ϣǰ�����ͱ���list��
		rentInfo_Map = dataCtrolUtil.getRentInfoMap(contract_id, begin_id, rent_list_start);
		//�ڶ����������Ϣ֮������
		String after_rate=condition_Map.get("implicite_rate").toString();//��Ϣ�����������
		l_corpus = rentInfo_Map.get("l_corpus");
		l_rent = rentInfo_Map.get("l_rent");
		l_corpus_overage = rentInfo_Map.get("corpus_overage");
		l_new_rent = getNewRent(after_rate,l_rent,settle_method);
		//�������������µ���Ϣ
		l_interest = getNewInterest(l_new_rent,l_corpus);
		//rentInfoBox ���з�װ
		rentInfoBox.setL_rent(l_new_rent);
		rentInfoBox.setL_corpus(l_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_corpus_overage);
		return rentInfoBox;
	}

	/**�����µ���Ϣ�б�
	 * @param l_new_rent
	 * @param l_corpus
	 * @return
	 */
	public List<String> getNewInterest(List<String> l_new_rent,
			List<String> l_corpus) {
		List<String> l_interest = new ArrayList<String>();//��Ϣ���µ���Ϣ�ƻ�
		String interest="0";
		for(int i=0;i<l_new_rent.size();i++){
			//��Ϣ=���-����
			interest = Tools.formatNumberDoubleFour(String.valueOf(Double.parseDouble(l_new_rent.get(i))-
					Double.parseDouble(l_corpus.get(i))));
			l_interest.add(interest);
		}
		
		
		return l_interest;
	}

	/**
	 * �����µ����
	 * @param after_rate
	 * @param l_corpus
	 * @return
	 */
	public List<String> getNewRent(String after_rate, List<String> l_rent,String settle_method) {
		List<String> l_new_rent = new ArrayList<String>();
		String new_rent = "0";
		for(int i = 0; i<l_rent.size();i++){
			if("RentCalcType7".equals(settle_method)){//��Ϣ��ʱ���ȷ��Ԫ
				new_rent = Tools.formatNumberDoubleZero(String.valueOf(Double.parseDouble(
						l_rent.get(i))*Double.parseDouble(after_rate)));
				//System.out.println(new_rent+"="+l_rent.get(i)+"*"+after_rate);
			}else{//�Ǿ�Ϣ����ȷ��С�������λ
				new_rent = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(
						l_rent.get(i))*Double.parseDouble(after_rate)));
				System.out.println(new_rent+"="+l_rent.get(i)+"*"+after_rate);
			}
			l_new_rent.add(new_rent);
		}
		return l_new_rent;
	}
}
