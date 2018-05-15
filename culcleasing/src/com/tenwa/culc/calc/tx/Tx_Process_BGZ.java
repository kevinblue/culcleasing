/**
 * 
 */
package com.tenwa.culc.calc.tx;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.tenwa.culc.calc.tx.util.Tx_EqualDiffCorUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualDiffRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualPaymentUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualRatioCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_EqualRatioRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_ImplicitInterestUtil;
import com.tenwa.culc.calc.tx.util.Tx_NotEqualCorpusUtil;
import com.tenwa.culc.calc.tx.util.Tx_NotEqualRentUtil;
import com.tenwa.culc.calc.tx.util.Tx_SettleLawUtil;

/**
 * �������Ϣ���
 * @author toybaby
 * Date:Aug 8, 2016-06-26      Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_Process_BGZ {
	
	/*public static void main(String[] args) {
		Tx_Process_BGZ Tx_Process_BGZ =	new Tx_Process_BGZ();
		try {
			//Tx_Process_BGZ.tx_ProcessInfo("15CULC082828L57", "15CULC082828L5796", "RentCalcType10", "129", "admin", "����");
			Tx_Process_BGZ.tx_CancleInfo("13CULC202173L58","13CULC202173L5847","129","����");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
	
	
	/**ִ�е�Ϣ
	 * @param contract_str
	 * @param settle_str
	 * @param txId
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int tx_ProcessInfo(String contract_str,String begin_str,String settle_str,
					String txId,String czyid,String adjust_style_str) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil_BGZ tx_DataCtrolUtil = new Tx_DataCtrolUtil_BGZ();//��ʼ�����ݿ����ݴ�����
		Tx_RentInfoBox rentInfoBox = null;//��װ���ƻ�bean
		String [] contract_list = contract_str.split("#");//��ͬ�������
		String [] begin_id  = begin_str.split("#");//��ͬ�������
		String [] settle_method_list = settle_str.split("#");//���㷽��
		String [] adjust_style = adjust_style_str.split("#");//��Ϣ��ʽ
		Map<String, String> condition_Map = new HashMap<String, String>(); 

		for(int i = 0; i<contract_list.length;i++){
			/**
			 *=================================
			 * Ԥ�����ֽӿڴ������մ����ж�������ͬ����ʱֻ������ڣ�
			 * if(����){  �����ڴ��ڵ�ռ����������Դ������ȣ�
			 * �����㷨
			 * }
			 * else if("����"){
			 * 	1.���ڵĵ����������ڵ��������̶�Ҫ������д�����⵱�ڵ��������
			 *  2.�����е�������ֻ�����һ��ʱ������ֻ�ܵ����������ٵ��ô��ڵķ����������
			 * �����㷨
			 * }
			 * ================================
			 */	
			if("����".equals(adjust_style[i])){
			
					//��һ��:�ѵ�Ϣ��ʼ�ڴ�֮ǰ�����ݿ��뵽His����
					tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
					//�ڶ�������õ�Ϣ����ǰ�Ĳ�����������
					condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
					
					String rate_float_type = condition_Map.get("rate_float_type");//���ʸ�������
					if("2".equals(rate_float_type)){//�������ʵ�Ϣ
						Tx_ImplicitInterestUtil tx_ImplicitInterestUtil=new Tx_ImplicitInterestUtil();
						//������ ������Ӧ���㷨���м����Ϣ������ƻ�����
						rentInfoBox = tx_ImplicitInterestUtil.getRentInfoBox(contract_list[i], begin_id[i],settle_method_list[i], condition_Map);
						//���Ĳ�:�ѵ�Ϣ������ݿ���His����
						//			System.out.println("��ʼ����========"+rent_list_start);
						flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfterForImp(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
						//System.out.println("ִ�гɹ�"+flag+"��");
						//���岽:ɾ����ʽ��ʼ�ڴ�֮�������
						int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//��ʼ����
									
						tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
						//������:�ѵ�Ϣ������ݴ�his������ʽ��
						tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
						//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
						tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);				
					}else{//���������ʵ�Ϣ
						//������:������ͬ�Ĳ��㷽ʽ��������Ӧ���㷨���м����Ϣ������ƻ�����
						rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
						//���Ĳ�:�ѵ�Ϣ������ݿ���His����
			//			System.out.println("��ʼ����========"+rent_list_start);
						flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
			//			System.out.println("ִ�гɹ�"+flag+"��");
						//���岽:ɾ����ʽ��ʼ�ڴ�֮�������
						int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//��ʼ����
						tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
						//������:�ѵ�Ϣ������ݴ�his������ʽ��
						tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
						//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
						tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
						//�ڰ˲�:�����׽ṹ�����е������ʸ��³����µ�������
						tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
						}
						System.out.println("��ͬ"+contract_list[i]+" ��Ϣ�ɹ�");
		}else if("����".equals(adjust_style[i])){//���յ��㷨
			 //	1.���ڵĵ����������ڵ��������̶�Ҫ������д�����⵱�ڵ��������
			 // 2.�����е�������ֻ�����һ��ʱ������ֻ�ܵ����������ٵ��ô��ڵķ����������
			 // 3.��һ�ڵĴ��յ�ϢҲ�赥������
			//################
			//�ۺϿ��ǣ���ȡ��Ϣ����Ϊ�Ƚ��������Ĵ��ڵĵ�Ϣ����ɺ�Ȼ��Կ�ʼ�ڴε���һ�ڽ��и��²�����
			//��Ϊ���ǵ���һ�ڵ��������ʣ�౾����õ�����ʣ�౾��+���ڵı����ٳ��Ե�Ϣǰ������ʲ
			//�ټ��ϵ���ԭʼ����Ϣ�����õ���ȷ�ĵ�Ϣֵ������ٸ���һ��
			//���ǣ���ִ�д��ڲ�����ʱ����Ҫ�ų���ʣ���һ�ڵ�����
			//��ʼ�ڴε���һ�������������ʼ�ڴ��Ѻ��������Ҳ�������ڴΣ���ֱ��ִ�д��ڡ�
			//############################################################################
			//�����ڵ�һ��֮ǰ����һ������ѯ��һ���Ƿ��ǵ�һ�ڣ�����ǵ�һ�ڣ��������ڵĲ��裬ֱ��ִ�д��ղ���
			int max_list = tx_DataCtrolUtil.getMaxRentList(begin_id[i]);
			//��һ��:�ѵ�Ϣ��ʼ�ڴ�֮ǰ�����ݿ��뵽His����
			tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
			//�ڶ�������õ�Ϣ����ǰ�Ĳ�����������
			condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
			int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//��ʼ����
			String rate_float_type = condition_Map.get("rate_float_type");//���ʸ�������
			//�����һ�ڻ���
			if(max_list!=rent_list_start){
			if("2".equals(rate_float_type)){//�������ʵ�Ϣ
				Tx_ImplicitInterestUtil tx_ImplicitInterestUtil=new Tx_ImplicitInterestUtil();
				//������ ������Ӧ���㷨���м����Ϣ������ƻ�����
				rentInfoBox = tx_ImplicitInterestUtil.getRentInfoBox(contract_list[i], begin_id[i],settle_method_list[i], condition_Map);
				//���Ĳ�:�ѵ�Ϣ������ݿ���His����
				//			System.out.println("��ʼ����========"+rent_list_start);
				flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfterForImp(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
				//System.out.println("ִ�гɹ�"+flag+"��");
				//���岽:ɾ����ʽ��ʼ�ڴ�֮�������
							
				tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
				//������:�ѵ�Ϣ������ݴ�his������ʽ��
				tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
				//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
				tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);				
			}else{//���������ʵ�Ϣ
				//������:������ͬ�Ĳ��㷽ʽ��������Ӧ���㷨���м����Ϣ������ƻ�����
				rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
				//���Ĳ�:�ѵ�Ϣ������ݿ���His����
	//			System.out.println("��ʼ����========"+rent_list_start);
				flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
	//			System.out.println("ִ�гɹ�"+flag+"��");
				//���岽:ɾ����ʽ��ʼ�ڴ�֮�������
				
				tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
				//������:�ѵ�Ϣ������ݴ�his������ʽ��
				tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
				//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
				tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
				//�ڰ˲�:�����׽ṹ�����е������ʸ��³����µ�������
				tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
				}
			//���ڲ��ֽ���
			}
			/*��ʼ����������ղ���
			 * ��� ��ʼ�ڴ� �ѻ����������ղ���������
			 * ���ղ�������Ϣ���㹫ʽ��
			 * �����ڵ�ʣ�౾��+���ڵı���*�����ڼƻ�����-��Ϣ���ڣ�*����Ϣ������-��Ϣǰ���ʣ�
			 * 
			 */
			//���жϵ����Ƿ��Ѳ�������ֵ
			String is_hire = tx_DataCtrolUtil.getIsRentHire(begin_id[i],rent_list_start);
			System.out.println("�����Ƿ��Ѳ�������ֵ======"+is_hire);
			if("��".equals(is_hire)){//����δ����ʱִ�д��յ�Ϣ������
			double adjust_interest=0.00;
			//��õ�Ϣ���ڵ���Ϣ����ֵ
			adjust_interest = tx_DataCtrolUtil.getAdjust_Interest(begin_id[i],rent_list_start,txId);
			System.out.println("������Ϊ"+begin_id[i]+"����Ŀ�ĵ�"+rent_list_start+"������"+adjust_interest);
			//����his���е�Ϣ��ĵ��ڵ���Ϣֵ
			tx_DataCtrolUtil.updateRentAfterHis(begin_id[i],adjust_interest,rent_list_start,txId);
			tx_DataCtrolUtil.updateRentAfter(begin_id[i],adjust_interest,rent_list_start);
			//������ʽ�б��Ϣ��ĵ��ڵ���Ϣֵ
			}
				System.out.println("��ͬ"+contract_list[i]+" ��Ϣ�ɹ�");
		}else if("����".equals(adjust_style[i])){
			//*****ע�⣺�����Ϣ�߼��ϣ������Ϊ��Ϣ����һ�꣬һ��һ�ſ�ʼ�Ĵ��յ�Ϣ����Ҳ�߸�������ͬ������ֻ�Ƿ������ʱ����ʼ�ڴθ�Ϊ��һ��ĵ�һ��*****
			//############################################################################
			//��ѯ��һ���Ƿ��ǵ�һ�ڣ�����ǵ�һ�ڣ��������ڵĲ��裬ֱ��ִ�д��ղ���
			int max_list = tx_DataCtrolUtil.getMaxRentList(begin_id[i]);
			//��һ��:�ѵ�Ϣ��ʼ�ڴ�֮ǰ�����ݣ�������ʼ�ڴΣ����뵽His����
			tx_DataCtrolUtil.copyRentPlanIntoHis(contract_list[i],begin_id[i],txId,czyid);
			//�ڶ�������õ�Ϣ����ǰ�Ĳ�����������
			condition_Map = tx_DataCtrolUtil.getConditionInfo(contract_list[i],begin_id[i],txId);
			int rent_list_start = Integer.parseInt(condition_Map.get("rent_list_start"));//��ʼ����
			String rate_float_type = condition_Map.get("rate_float_type");//���ʸ�������
			//�����һ�ڻ���
			if(max_list!=rent_list_start){
			    //���������ʵ�Ϣ
				if("-1".equals(condition_Map.get("rent_list_start"))){//����û���ڴε����
					tx_DataCtrolUtil.copyRentPlanAllIntoHis(contract_list[i],begin_id[i],txId,czyid);
					//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
					tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
					//�ڰ˲�:�����׽ṹ�����е������ʸ��³����µ�������
					tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
					flag +=1;
					continue;
				}else{
					//������:������ͬ�Ĳ��㷽ʽ��������Ӧ���㷨���м����Ϣ������ƻ�����
					rentInfoBox = choiceSettleMethod(contract_list[i],begin_id[i],settle_method_list[i],condition_Map,txId);
					//���Ĳ�:�ѵ�Ϣ������ݿ���His����
		//			System.out.println("��ʼ����========"+rent_list_start);
					flag += tx_DataCtrolUtil.copyRentPlanIntoHisAfter(contract_list[i],begin_id[i],rentInfoBox,condition_Map,txId,czyid);
		//			System.out.println("ִ�гɹ�"+flag+"��");
					//���岽:ɾ����ʽ��ʼ�ڴ�֮�������
					tx_DataCtrolUtil.delRentPlanAfter(contract_list[i],begin_id[i],rent_list_start);
					//������:�ѵ�Ϣ������ݴ�his������ʽ��
					tx_DataCtrolUtil.copyRentPlanFromHis(contract_list[i],begin_id[i],txId);
					//���߲�:�ѵ�Ϣ��¼���еĵ�Ϣ״̬����Ϊ��
					tx_DataCtrolUtil.updateFundAdjust(contract_list[i],begin_id[i],txId);
					//�ڰ˲�:�����׽ṹ�����е������ʸ��³����µ�������
					tx_DataCtrolUtil.updateConditionForProcess(contract_list[i],begin_id[i], txId);
				}
			//���ڲ��ֽ���
			}
			/*��ʼ����������ղ���
			 * ��� ��ʼ�ڴ� �ѻ����������ղ���������
			 * ���ղ�������Ϣ���㹫ʽ��
			 * �����ڵ�ʣ�౾��+���ڵı���*�����ڼƻ�����-��Ϣ���ڣ�*����Ϣ������-��Ϣǰ���ʣ�
			 * 
			 */
			//���жϵ����Ƿ��Ѳ�������ֵ
			String is_hire = tx_DataCtrolUtil.getIsRentHire(begin_id[i],rent_list_start);
			System.out.println("�����Ƿ��Ѳ�������ֵ======"+is_hire);
			if("��".equals(is_hire)){//����δ����ʱִ�д��յ�Ϣ������
			double adjust_interest=0.00;
			//��õ�Ϣ���ڵ���Ϣ����ֵ
			adjust_interest = tx_DataCtrolUtil.getAdjust_Interest2(begin_id[i],rent_list_start,txId);
			System.out.println("������Ϊ"+begin_id[i]+"����Ŀ�ĵ�"+rent_list_start+"������"+adjust_interest);
			//����his���е�Ϣ��ĵ��ڵ���Ϣֵ
			tx_DataCtrolUtil.updateRentAfterHis(begin_id[i],adjust_interest,rent_list_start,txId);
			//������ʽ�б��Ϣ��ĵ��ڵ���Ϣֵ
			tx_DataCtrolUtil.updateRentAfter(begin_id[i],adjust_interest,rent_list_start);
			}
				System.out.println("��ͬ"+contract_list[i]+" ��Ϣ�ɹ�");
		
		}
		
	}
		
		
		
		
		
		return flag;
	}
	
	/**
	 * ������ͬ��������ʽ������������
	 * @param contract_id
	 * @param settle_method
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public Tx_RentInfoBox choiceSettleMethod(String contract_id,String begin_id,String settle_method,Map condition_Map,String txId) throws SQLException{
		Tx_RentInfoBox rentInfoBox = null;
		if ("RentCalcType1".equals(settle_method)) {// �ȶ����
			System.out.println("����"+contract_id+"�ȶ����ĵ�Ϣ����");
			rentInfoBox = Tx_EqualPaymentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType2".equals(settle_method)) {// �Ȳ����
			System.out.println("����"+contract_id+"�Ȳ����ĵ�Ϣ����");
			rentInfoBox = Tx_EqualDiffRentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType3".equals(settle_method)) {// �ȱ����
			System.out.println("����"+contract_id+"�ȱ����ĵ�Ϣ����");
			rentInfoBox = Tx_EqualRatioRentUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType4".equals(settle_method)) {// �ȶ��
			System.out.println("����"+contract_id+"�ȶ��ĵ�Ϣ����");
			rentInfoBox = Tx_EqualCorpusUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType5".equals(settle_method)) {// �Ȳ��
			System.out.println("����"+contract_id+"�Ȳ��ĵ�Ϣ����");
			rentInfoBox = Tx_EqualDiffCorUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		} else if ("RentCalcType6".equals(settle_method)) {// �ȱȱ���
			System.out.println("����"+contract_id+"�ȱȱ���ĵ�Ϣ����");
			rentInfoBox = Tx_EqualRatioCorpusUtil.getRentInfoBox(condition_Map);
		} else if ("RentCalcType7".equals(settle_method)) {// ��Ϣ��
			System.out.println("����"+contract_id+"��Ϣ���ĵ�Ϣ����");
			rentInfoBox = Tx_SettleLawUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		} else if ("RentCalcType9".equals(settle_method)) {// ���ȶ��
			System.out.println("����"+contract_id+"���ȶ��ĵ�Ϣ����");
			rentInfoBox = Tx_NotEqualCorpusUtil.getRentInfoBox(contract_id,begin_id,condition_Map);
		}else if ("RentCalcType8".equals(settle_method)) {// ���ȶ����
			System.out.println("����"+contract_id+"���ȶ����ĵ�Ϣ����");
			rentInfoBox = Tx_NotEqualRentUtil.getRentInfoBox(contract_id,begin_id,condition_Map,txId);
		}else if ("RentCalcType10".equals(settle_method)) {// ���ȶ����
			System.out.println("����"+contract_id+"������ĵ�Ϣ����");
			rentInfoBox = Tx_NotEqualRentUtil.getRentInfoBox(contract_id,begin_id,condition_Map,txId);
		}
		System.out.println("��ͬ"+contract_id+"�������");
		return rentInfoBox;
	}
	
	/**��ͬ�������Ϣ����ʱ���г���
	 * @param contract_str
	 * @param czyid
	 * @return
	 * @throws SQLException
	 */
	public int tx_CancleInfo(String contract_str,String begin_str,String txId,String adjust_style_str) throws SQLException{
		int flag = 0;
		Tx_DataCtrolUtil_BGZ tx_DataCtrolUtil = new Tx_DataCtrolUtil_BGZ();//��ʼ�����ݿ����ݴ�����
		System.out.println("contract_list="+contract_str+"     begin_id="+begin_str);
		String [] contract_list = contract_str.split("#");//��ͬ�������
		String [] begin_id = begin_str.split("#");//����������
		String [] adjust_style = adjust_style_str.split("#");//��Ϣ��ʽ
		/**
		 *=================================
		 * Ԥ�����ֽӿڴ������մ����ж�������ͬ����ʱֻ������ڣ�
		 * if("����"){
		 * ����ʱ�����в�֮ͬ�������ڵ����Ĵ���ʽ�Ĳ�ͬ
		 * �����㷨
		 * }
		 * else{
		 * �����㷨
		 *  ͬ��Ϣִ�У��ڳ�����ʱ���Կ�ά��ԭ���ģ�ֻ����Ҫ�����ٰѵ��ڵĽ��лָ�һ��
		 * }
		 * ================================
		 */	
		
		for(int i = 0; i<contract_list.length;i++){
			//��һ��:ɾ����ʽ��ʼ�ڴ��Ժ�ĵ�����
			tx_DataCtrolUtil.delPlanForCancle(contract_list[i],begin_id[i], txId);
			//�ڶ���:��his��ʼ�ڴ��Ժ�����ݿ�����ʽ��
			tx_DataCtrolUtil.copPlanForCancle(contract_list[i],begin_id[i], txId);
			//������:��begin_info�������ʻָ�����Ϣǰ��������
			tx_DataCtrolUtil.updateConditionForCancle(contract_list[i],begin_id[i], txId);
			//������һ����������գ����ڵ������и���
			if("����".equals(adjust_style[i])||"����".equals(adjust_style[i])){
				tx_DataCtrolUtil.updateRentAfterCancle(begin_id[i],txId);
			}
			//���Ĳ�:��his�������ɾ��
			tx_DataCtrolUtil.delPlanHisForCancle(contract_list[i],begin_id[i], txId);
			//���岽:ɾ����Ϣ��¼��ļ�¼
			flag +=tx_DataCtrolUtil.delFundAdjustForCancle(contract_list[i],begin_id[i], txId);
			//tx_DataCtrolUtil.delPlanHisForCancle(contract_list[i], begin_id[i], txId);
		    //flag += tx_DataCtrolUtil.delFundAdjustForCancle(contract_list[i], begin_id[i], txId);
		}
		
		return flag;
	}

	
	
}
