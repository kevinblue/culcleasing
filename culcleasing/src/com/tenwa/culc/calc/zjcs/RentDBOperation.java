/**
 * com.tenwa.culc.calc.util
 */
package com.tenwa.culc.calc.zjcs;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.condition.CashFlow;
import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.dao.RentPlanDao;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.MathExtend;
import com.tenwa.log.LogWriter;

/**
 * @author Jaffe
 * 
 * Date:Jul 18, 2011 10:34:26 AM Email:JaffeHe@hotmail.com
 */
public class RentDBOperation {

	/**
	 * ���ݿ����
	 * 
	 * @param contract_id
	 * @param conditionBean
	 * @param Markirr
	 * @param l_plan_date
	 * @param l_rent
	 * @param l_corpus
	 * @param l_interest
	 * @param l_corpus_overage
	 * @param l_RentDetails
	 * @param rent
	 * @param new_rent
	 */
	@SuppressWarnings("unchecked")
	public static void execDBOperation(String contract_id,
			ConditionBean conditionBean, String irr, List l_plan_date,
			List l_rent, List l_corpus, List l_interest, List l_corpus_overage,
			List l_RentDetails, RentCalc rent, List new_rent) {
		/**
		 * =======================================================
		 * ��ʼ�������ݿ�����ݣ����׽ṹ��ʱ����Ŀ���ƻ���ʱ����Ŀ����ֽ�����ʱ��
		 * =======================================================
		 */
		// --�жϸ��º�ͬ������Ŀ��
		System.out.println("���ݿ���±�����ж�contract_id="+contract_id+"proj_id="+rent.getContract_id());
		int flag = 0;
		if ("".equals(contract_id)|| contract_id == null) {
			// =======1 ���½��׽ṹ���plan_irr
			flag = updateConditionTempPlanIrr(conditionBean.getProj_id(),
					conditionBean.getDoc_id(), irr);
			LogWriter.logDebug("����proj_condition_temp,�����" + flag);

			// // =======2 ������Ŀ���ƻ���ʱ��
			flag = updateFundRentPlanProjTemp(l_plan_date, l_rent,
					conditionBean.getYear_rate(), l_corpus, l_interest,
					l_corpus_overage, conditionBean.getDoc_id(), conditionBean
							.getProj_id());
			LogWriter.logDebug("����fund_rent_plan_proj_temp,�����" + flag);

			// ======3��Ŀ�ֽ�����ʱ��
			// ���޸��գ�2010-07-26���ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤��
			l_RentDetails = rent.getRentDetails(l_rent, conditionBean
					.getCaution_money());
			// �õ���֤��ֿ����List rent_list ���List,caut_money ��֤��
			new_rent = rent.getRentCautNew(l_rent, conditionBean
					.getCaution_money());

			String proj_id = conditionBean.getProj_id();
			String doc_id = conditionBean.getDoc_id();

			// 1��������
			CashFlow cashFlow = new CashFlow();

			// �г��ֽ���
			String new_del_sql = " delete  fund_proj_plan_mark_temp where proj_id = '"
					+ proj_id + "' and doc_id = '" + doc_id + "'";
			flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date, new_rent,
					conditionBean.getLease_money(), conditionBean
							.getConsulting_fee_out(), conditionBean
							.getHandling_charge(),
					conditionBean.getEquip_amt(), conditionBean
							.getOther_expenditure(), conditionBean
							.getCaution_money(), conditionBean.getReturn_amt(),
					conditionBean.getOther_income(), conditionBean
							.getFirst_payment(), conditionBean.getStart_date(),
					conditionBean.getPeriod_type(), proj_id, doc_id,
					conditionBean.getCreator(), conditionBean.getCreate_date(),
					conditionBean.getModificator(), conditionBean
							.getModify_date(), new_del_sql, "", "market_irr",
					"fund_proj_plan_mark_temp", conditionBean
							.getBefore_interest(), l_RentDetails);//

			// �ֽ���������롾2010-08-06��
			if (!conditionBean.getNominalprice().equals("")) {//
				double t_num = Double.valueOf(conditionBean.getNominalprice());
				if (t_num > 0) {// �����۴���0�Ž��д˲���
					// �г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
					String query_count_market = " select * from fund_proj_plan_mark_temp  where  proj_id = '"
							+ proj_id + "' and doc_id = '" + doc_id + "'";
					query_count_market = query_count_market
							+ " and plan_date = ( select max(plan_date) from fund_proj_plan_mark_temp where proj_id = '"
							+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
					query_count_market = query_count_market
							+ " and id = ( select max(id) from fund_proj_plan_mark_temp where proj_id = '"
							+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
					System.out
							.println("��ѯ��Ŀ�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "
									+ query_count_market);
					// ����ͨ�÷���
					flag = cashFlow.update_xjl_market(query_count_market,
							conditionBean.getNominalprice(),
							"fund_proj_plan_mark_temp", proj_id, "");// �г�
				}
			}

			String management_fee = conditionBean.getManagement_fee();
			// ��������,�ֽ���������롾2010-11-30�� �ֽ�����һ�ڼ��Ϲ���ѣ���������������
			if (!"".equals(management_fee)
					&& management_fee != null
					&& (!"0.00".equals(management_fee) && !"0"
							.equals(management_fee))) {
				// ��ѯ�г���һ�ڵ�����
				String query_min_market = " select * from fund_proj_plan_mark_temp  where  proj_id = '"
						+ proj_id + "' and doc_id = '" + doc_id + "'";
				query_min_market = query_min_market
						+ " and id = ( select min(id) from fund_proj_plan_mark_temp where proj_id = '"
						+ proj_id + "'  and doc_id = '" + doc_id + "' ) ";
				System.out.println("��ѯ��Ŀ�г��ֽ�����Сһ�ڵ�ֵ ==> " + query_min_market);
				// ���ù��÷���������Ѽӵ���������
				flag = cashFlow.updat_xjl(query_min_market, management_fee,
						proj_id, "", doc_id, "proj", "market");
			}

		} else {
			// =======1 ���½��׽ṹ���plan_irr
			flag = updateConditionContractTempPlanIrr(conditionBean
					.getContract_id(), conditionBean.getDoc_id(), irr);
			LogWriter.logDebug("����contract_condition_temp,�����" + flag);

			// // =======2 ������Ŀ���ƻ���ʱ��
			flag = updateFundRentPlanProjContractTemp(l_plan_date, l_rent,
					conditionBean.getYear_rate(), l_corpus, l_interest,
					l_corpus_overage, conditionBean.getDoc_id(), conditionBean
							.getContract_id());
			LogWriter.logDebug("����fund_rent_plan_contract_temp,�����" + flag);

			// ======3��Ŀ�ֽ�����ʱ��
			// ���޸��գ�2010-07-26���ֽ������뱣֤��ֿۣ��õ���֤��ֿ����List��,���������List����֤��
			l_RentDetails = rent.getRentDetails(l_rent, conditionBean
					.getCaution_money());
			// �õ���֤��ֿ����List rent_list ���List,caut_money ��֤��
			new_rent = rent.getRentCautNew(l_rent, conditionBean
					.getCaution_money());

			String proj_id = conditionBean.getProj_id();
			String doc_id = conditionBean.getDoc_id();

			// 1��������
			CashFlow cashFlow = new CashFlow();

			// �г��ֽ���
			String new_del_sql = " delete  fund_contract_plan_mark_temp where contract_id = '"
					+ contract_id + "' and doc_id = '" + doc_id + "'";
			flag = cashFlow.execProjORcontract_xjl_mark(l_plan_date, new_rent,
					conditionBean.getLease_money(), conditionBean
							.getConsulting_fee_out(), conditionBean
							.getHandling_charge(),
					conditionBean.getEquip_amt(), conditionBean
							.getOther_expenditure(), conditionBean
							.getCaution_money(), conditionBean.getReturn_amt(),
					conditionBean.getOther_income(), conditionBean
							.getFirst_payment(), conditionBean.getStart_date(),
					conditionBean.getPeriod_type(), proj_id, doc_id,
					conditionBean.getCreator(), conditionBean.getCreate_date(),
					conditionBean.getModificator(), conditionBean
							.getModify_date(), new_del_sql, contract_id,
					"market_irr", "fund_contract_plan_mark_temp", conditionBean
							.getBefore_interest(), l_RentDetails);//

			// �ֽ���������롾2010-08-06��
			if (!conditionBean.getNominalprice().equals("")) {//
				double t_num = Double.valueOf(conditionBean.getNominalprice());
				if (t_num > 0) {// �����۴���0�Ž��д˲���
					// �г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ
					String query_count_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"
							+ contract_id + "' and doc_id = '" + doc_id + "'";
					query_count_market = query_count_market
							+ " and plan_date = ( select max(plan_date) from fund_contract_plan_mark_temp where contract_id = '"
							+ contract_id + "'  and doc_id = '" + doc_id
							+ "' ) ";
					query_count_market = query_count_market
							+ " and id = ( select max(id) from fund_contract_plan_mark_temp where contract_id = '"
							+ contract_id + "'  and doc_id = '" + doc_id
							+ "' ) ";
					System.out
							.println("��ѯ��Ŀ�г��ֽ������һ�ڵ� ���������������嵥�������� �����ֶε�ֵ ==> "
									+ query_count_market);
					// ����ͨ�÷���
					flag = cashFlow.update_xjl_market(query_count_market,
							conditionBean.getNominalprice(),
							"fund_contract_plan_mark_temp", proj_id, "");// �г�
				}
			}

			String management_fee = conditionBean.getManagement_fee();
			// ��������,�ֽ���������롾2010-11-30�� �ֽ�����һ�ڼ��Ϲ���ѣ���������������
			if (!"".equals(management_fee)
					&& management_fee != null
					&& (!"0.00".equals(management_fee) && !"0"
							.equals(management_fee))) {
				// ��ѯ�г���һ�ڵ�����
				String query_min_market = " select * from fund_contract_plan_mark_temp  where  contract_id = '"
						+ contract_id + "' and doc_id = '" + doc_id + "'";
				query_min_market = query_min_market
						+ " and id = ( select min(id) from fund_contract_plan_mark_temp where contract_id = '"
						+ contract_id + "'  and doc_id = '" + doc_id + "' ) ";
				System.out.println("��ѯ��Ŀ�г��ֽ�����Сһ�ڵ�ֵ ==> " + query_min_market);
				// ���ù��÷���������Ѽӵ���������
				flag = cashFlow.updat_xjl(query_min_market, management_fee,
						proj_id, "", doc_id, "contract", "market");
			}
		}
	}

	/**
	 * ��ͬ���ƻ�
	 * 
	 * @param l_plan_date
	 * @param l_rent
	 * @param year_rate
	 * @param l_corpus
	 * @param l_interest
	 * @param l_corpus_overage
	 * @param doc_id
	 * @param contract_id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static int updateFundRentPlanProjContractTemp(List l_plan_date,
			List l_rent, String year_rate, List l_corpus, List l_interest,
			List l_corpus_overage, String doc_id, String contract_id) {
		// 1.��װRentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < l_rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// ���Ը�ֵ
			rentPlanBean.setContract_id(contract_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) l_plan_date.get(i));
			rentPlanBean.setPlan_status("δ����");
			rentPlanBean.setCurr_rent((String) l_rent.get(i));
			rentPlanBean.setRent((String) l_rent.get(i));
			rentPlanBean.setCorpus((String) l_corpus.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) l_interest.get(i));
			rentPlanBean.setCorpus_overage((String) l_corpus_overage.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			// ��ӵ�list
			rentPlanList.add(rentPlanBean);
		}
		// 2. === �����ݸ��� ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1ɾ����ʷ����
		try {
			rentPlanDao.deleteRentPlanContractTempHisData(contract_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		int resVal = 0;
		try {
			resVal = rentPlanDao
					.updateFundRentPlanContractTempData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����contract_Id:" + contract_id + " �����ƻ���ʱ�����ݣ����½����"
				+ (resVal == 0 ? "ʧ��" : "�ɹ�"));
		// 3.����
		return resVal;
	}

	/**
	 * ���º�ͬirr
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param markirr
	 * @return
	 */
	private static int updateConditionContractTempPlanIrr(String contract_id,
			String doc_id, String markirr) {
		// 1.����ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ��update����
		markirr = MathExtend.multiply(
				Tools.formatNumberDoubleScale(markirr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionContractTempPlanIrrOper(
					contract_id, doc_id, markirr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����contract_Id:" + contract_id + " ��plan_irr��"
				+ markirr + " ���½����" + (resVal == 0 ? "ʧ��" : "�ɹ�"));
		// 3.����
		return resVal;
	}

	/**
	 * ����fund_rent_plan_proj_temp����Ŀ���ƻ���ʱ������
	 * 
	 * @param l_plan_date
	 *            ��������list
	 * @param l_rent
	 *            ���list
	 * @param year_rate
	 *            ������
	 * @param l_corpus_market
	 *            �г�����list
	 * @param l_interest_market
	 *            �г���Ϣlist
	 * @param l_corpus_overage_market
	 *            �г�ʣ�౾��list
	 * @param doc_id
	 *            �ĵ����
	 * @param proj_id
	 *            ��Ŀ���
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static int updateFundRentPlanProjTemp(List l_plan_date,
			List l_rent, String year_rate, List l_corpus_market,
			List l_interest_market, List l_corpus_overage_market,
			String doc_id, String proj_id) {
		// 1.��װRentPlanBeanList
		List<RentPlanBean> rentPlanList = new ArrayList<RentPlanBean>();
		RentPlanBean rentPlanBean = null;
		for (int i = 0; i < l_rent.size(); i++) {
			rentPlanBean = new RentPlanBean();
			// ���Ը�ֵ
			rentPlanBean.setProj_id(proj_id);
			rentPlanBean.setDoc_id(doc_id);
			rentPlanBean.setRent_list(String.valueOf((i + 1)));
			rentPlanBean.setPlan_date((String) l_plan_date.get(i));
			rentPlanBean.setPlan_status("δ����");
			rentPlanBean.setCurr_rent((String) l_rent.get(i));
			rentPlanBean.setRent((String) l_rent.get(i));
			rentPlanBean.setCorpus((String) l_corpus_market.get(i));
			rentPlanBean.setYear_rate(year_rate);
			rentPlanBean.setInterest((String) l_interest_market.get(i));
			rentPlanBean.setCorpus_overage((String) l_corpus_overage_market
					.get(i));
			rentPlanBean.setCreate_date(CommonTool.getSysDate("yyyy-MM-dd"));
			// ��ӵ�list
			rentPlanList.add(rentPlanBean);
		}
		// 2. === �����ݸ��� ====
		RentPlanDao rentPlanDao = new RentPlanDao();
		// 2.1ɾ����ʷ����
		try {
			rentPlanDao.deleteRentPlanProjTempHisData(proj_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2������������
		int resVal = 0;
		try {
			resVal = rentPlanDao.updateFundRentPlanProjTempData(rentPlanList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����proj_Id:" + proj_id + " �����ƻ���ʱ�����ݣ����½����"
				+ (resVal == 0 ? "ʧ��" : "�ɹ�"));
		// 3.����
		return resVal;
	}

	/**
	 * ����ָ��proj_id,doc_id��plan_irr�г�irr�ֶ�
	 * 
	 * @param proj_id
	 *            ��Ŀid
	 * @param doc_id
	 *            �ĵ�Id
	 * @param markirr
	 *            �ڲ�������
	 * @return
	 */
	private static int updateConditionTempPlanIrr(String proj_id,
			String doc_id, String markirr) {
		// 1.����ConditionDao
		ConditionDao conditionDao = new ConditionDao();
		// 2.ִ��update����
		markirr = MathExtend.multiply(
				Tools.formatNumberDoubleScale(markirr, 8), "100");
		int resVal = 0;
		try {
			resVal = conditionDao.updateConditionTempPlanIrrOper(proj_id,
					doc_id, markirr);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		LogWriter.logDebug("����proj_Id:" + proj_id + " ��plan_irr��" + markirr
				+ " ���½����" + (resVal == 0 ? "ʧ��" : "�ɹ�"));
		// 3.����
		return resVal;
	}

}
