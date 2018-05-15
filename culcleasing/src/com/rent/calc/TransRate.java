package com.rent.calc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * ��Ϣ������
 * 
 * @author Administrator
 * 
 */
public class TransRate {
	private String irr = "0";

	/**
	 * �̶����������
	 * 
	 * @param lease_term
	 *            ����
	 * @param adjust_value
	 *            ��ӵ�ֵ
	 * @param adjust
	 *            ��׼����Ϣ
	 * @return ÿ��Ҫ��ӵ�����ֵ
	 */
	public String getFixed(String lease_term, String adjust_value,
			HashMap adjust) {

		double rate_d = 0.0;
		if ("6".equals(lease_term)) {// ������ʱ
			rate_d = (Double.parseDouble(adjust.get("rate_half").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));

		} else if ("12".equals(lease_term)) {// һ��ʱ
			rate_d = (Double.parseDouble(adjust.get("rate_one").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// ���굽����֮��ʱ
			rate_d = (Double.parseDouble(adjust.get("rate_three").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// �ģ�����֮��ʱ
			rate_d = (Double.parseDouble(adjust.get("rate_five").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 60) {// ��������ʱ
			rate_d = (Double.parseDouble(adjust.get("rate_abovefive")
					.toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else {
			rate_d = 0.0;
		}
		// ����ÿһ�������Ӧ�ӵ�ֵ
		return String.valueOf(rate_d);
	}

	/**
	 * ���������ʼӵ�
	 * 
	 * @param lease_term
	 *            ����
	 * @param adjust_point
	 *            ��Ҫ�ӵ��ֵ
	 * @return
	 */
	public String getRateByPoint(String lease_term, String adjust_point,
			HashMap adjust) {

		String rate_ = "0";
		if ("6".equals(lease_term)) {// ������ʱ
			rate_ = adjust.get("base_rate_half").toString();

		} else if ("12".equals(lease_term)) {// һ��ʱ
			rate_ = adjust.get("base_rate_one").toString();
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// ���굽����֮��ʱ
			rate_ = adjust.get("base_rate_three").toString();
		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// �ģ�����֮��ʱ
			rate_ = adjust.get("base_rate_five").toString();
		} else if (Integer.parseInt(lease_term) > 60) {// ��������ʱ
			rate_ = adjust.get("base_rate_abovefive").toString();
		} else {
			rate_ = "0";
		}
		// ������������ֵ,�����еĻ����ϼӶ��ٵ�
		rate_ = String.valueOf(Double.parseDouble(rate_)
				+ Double.parseDouble(adjust_point));
		// ���ص���%֮����
		return rate_;
	}

	/**
	 * ���������ʸ�������
	 * 
	 * @param lease_term
	 *            ���׽ṹ������
	 * @param adjust
	 *            ��������ֵ��Ϣ
	 * @return ��Ӧ������
	 */
	public String getRateByBaseRate(String lease_term, HashMap adjust) {

		String rate_ = "0";
		if ("6".equals(lease_term)) {// ������ʱ
			rate_ = adjust.get("base_rate_half").toString();

		} else if ("12".equals(lease_term)) {// һ��ʱ
			rate_ = adjust.get("base_rate_one").toString();
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// ���굽����֮��ʱ
			rate_ = adjust.get("base_rate_three").toString();
		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// �ģ�����֮��ʱ
			rate_ = adjust.get("base_rate_five").toString();
		} else if (Integer.parseInt(lease_term) > 60) {// ��������ʱ
			rate_ = adjust.get("base_rate_abovefive").toString();
		} else {
			rate_ = "0";
		}
		// ������������ֵ
		rate_ = String.valueOf(Double.parseDouble(rate_) * 1.1);
		// ���ص���%֮����
		return rate_;
	}

	/**
	 * 
	 * @param proj_id��Ŀ���
	 * @param start_list
	 *            ��ʼ����
	 * @param preiod
	 *            �ڳ�������δ
	 * @return
	 * @throws Exception
	 */
	public String getDateByPreiod(String proj_id, String start_list,
			String preiod, String lease_interval) throws Exception {
		Conn conn = new Conn();
		String start_date = "";
		String sql = "select plan_date from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list='" + start_list + "'";
		ResultSet rs = conn.executeQuery(sql);

		if (rs.next()) {
			start_date = rs.getString("plan_date");
		}
		rs.close();
		conn.close();

		if (preiod.equals("0")) {// �ڳ�ʱ
			start_date = Tools.dateAdd("month", -Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("�仯�ĵ�һ��ʱ��:" + start_date);
		return start_date;
	}

	/**
	 * �õ���Ϣ��ǰ�����ƻ�
	 * 
	 * @param start_list
	 *            ��ֹ������
	 * @param proj_id
	 *            ��Ŀ���
	 * @param preRentList
	 *            ǰ�ڿ�
	 * @param preDateList
	 *            ǰ�ڿ�ʱ��
	 * @return
	 * @throws Exception
	 */
	public HashMap getTxBefore(String start_list, String proj_id,
			List preRentList, List preDateList) throws Exception {

		Conn conn = new Conn();
		ResultSet rs = conn
				.executeQuery("select rent,plan_date from fund_rent_plan where contract_id='"
						+ proj_id + "' and rent_list<'" + start_list + "'");

		while (rs.next()) {
			preRentList.add(rs.getString("rent"));
			preDateList.add(rs.getString("plan_date"));
		}
		rs.close();
		conn.close();
		HashMap hmp = new HashMap();
		hmp.put("preRentList", preRentList);
		hmp.put("preDateList", preDateList);
		return hmp;

	}

	/**
	 * 
	 * @param rentList
	 *            �µ�����б�
	 * @param interestList
	 *            �µ���Ϣ�б�
	 * @param corpus
	 *            �µı����б�
	 * @param corpus_overage
	 *            �µı�������б�
	 * @throws Exception
	 */
	public void updateRentPlan(List rentList, List interestList, List corpus,
			List corpus_overage, String proj_id, String startTerm)
			throws Exception {

		// ��Ҫ���µļ�¼
		String sql = "select id,rent_list from fund_rent_plan where contract_id='"
				+ proj_id
				+ "' and rent_list>='"
				+ startTerm
				+ "' order by rent_list ";

		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		// ������Ҫִ�е�sql���
		sql = "   ";
		int i = 0;// �������,��������ݵ���ȡ
		while (rs.next()) {
			sql += " update fund_rent_plan set rent='"
					+ rentList.get(i).toString() + "',corpus='"
					+ corpus.get(i).toString() + "',interest='"
					+ interestList.get(i).toString() + "',corpus_overage='"
					+ corpus_overage.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// ִ�и��²���
		conn.executeUpdate(sql);
		rs.close();
		conn.close();

	}

	/**
	 * ������Ŀ��id��ѯ��Ŀ���׽ṹ��Ϣ
	 * 
	 * @param proj_id
	 * @param term
	 *            �ӵڼ��ڿ�ʼ��ʣ�౾��
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	public HashMap getProj_ConditionInfoByProj_id(String proj_id, String term)
			throws Exception {

		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,isnull(equip_amt,0) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt from contract_condition where contract_id='"
				+ proj_id + "'";

		HashMap hmp = new HashMap();

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rate_float_type", rs.getString("rate_float_type"));
			hmp.put("lease_term", rs.getString("lease_term"));
			hmp.put("income_number_year", rs.getString("income_number_year"));
			hmp.put("income_number", rs.getString("income_number"));

			hmp.put("period_type", rs.getString("period_type"));
			hmp.put("rate_float_amt", rs.getString("rate_float_amt"));
			hmp.put("year_rate", rs.getString("year_rate"));
			hmp.put("handling_charge", rs.getString("handling_charge"));
			hmp.put("caution_money", rs.getString("caution_money"));
			hmp.put("start_date", rs.getString("start_date"));
			hmp.put("equip_amt", rs.getString("equip_amt"));
			hmp.put("measure_type", rs.getString("measure_type"));
			hmp.put("lease_money", rs.getString("lease_money"));
			hmp.put("consulting_fee", rs.getString("consulting_fee"));

		}

		//
		sql = "select isnull(sum(corpus),0) rem_corpus,count(*) rem_rent_list,isnull(sum(rent),0) adjust_amt from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rem_corpus", rs.getString("rem_corpus"));
			hmp.put("rem_rent_list", rs.getString("rem_rent_list"));
			hmp.put("adjust_amt", rs.getString("adjust_amt"));
		}
		rs.close();
		conn.close();
		return hmp;

	}

	/**
	 * 
	 * @param adjustId
	 *            ���ʵ���id
	 * @return ���ʵ�����Ϣ
	 * @throws Exception
	 */
	public HashMap getAdjustInterInfo(String adjustId) throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select  start_date,isnull(rate_half,0) rate_half,isnull(rate_one,0) rate_one,isnull(rate_three,0) rate_three,isnull(rate_five,0) rate_five,isnull(rate_abovefive,0) rate_abovefive, isnull(base_rate_half,0) base_rate_half,isnull(base_rate_one,0) base_rate_one,isnull(base_rate_three,0) base_rate_three,isnull(base_rate_five,0) base_rate_five,isnull(base_rate_abovefive,0) base_rate_abovefive  from fund_standard_interest where id='"
				+ adjustId + "' ";

		HashMap hmp = new HashMap();
		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("start_date", rs.getString("start_date"));
			hmp.put("rate_half", rs.getString("rate_half"));
			hmp.put("rate_one", rs.getString("rate_one"));
			hmp.put("rate_three", rs.getString("rate_three"));

			hmp.put("rate_five", rs.getString("rate_five"));
			hmp.put("rate_abovefive", rs.getString("rate_abovefive"));
			hmp.put("base_rate_half", rs.getString("base_rate_half"));
			hmp.put("base_rate_one", rs.getString("base_rate_one"));

			hmp.put("base_rate_three", rs.getString("base_rate_three"));
			hmp.put("base_rate_five", rs.getString("base_rate_five"));
			hmp.put("base_rate_abovefive", rs.getString("base_rate_abovefive"));
		}
		rs.close();
		conn.close();

		return hmp;
	}

	/**
	 * �õ��ܵ��������,�Լ���Ϣ������
	 * 
	 * @return
	 * @throws Exception
	 */
	public HashMap getRemAndTotalIncome(String proj_id, String start_date)
			throws Exception {

		// �����Ǵӵ�ǰ�ڴε���һ�ڿ���ʼ��
		int nextTerm = 0;
		int totalTerm = 0;
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " select isnull(min(rent_list),0) from fund_rent_plan where contract_id='"
				+ proj_id
				+ "' and convert(varchar(10),plan_date,120)>convert(varchar(10),'"
				+ start_date + "',120) and plan_status='δ����'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			nextTerm = rs.getInt(1);
		}

		sql = " select count(*) from fund_rent_plan where contract_id='"
				+ proj_id + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			totalTerm = rs.getInt(1);
		}

		HashMap hm = new HashMap();
		hm.put("nextTerm", nextTerm);
		hm.put("totalTerm", totalTerm);

		rs.close();
		conn.close();
		return hm;
	}

	/**
	 * 
	 * @param adjustId
	 *            ��Ϣ���id
	 * @param projs
	 *            ����Ӧ����Ŀ
	 * @throws Exception
	 */
	public void processInterest(String adjustId, List projs) throws Exception {
		// ���������ʸ�������,���������ʼӵ�,�̶����������,���ֲ���
		// // 0,1,2,3,4

		Conn conn = new Conn();
		// ѭ��ҳ�洫��������Ŀ
		for (int i = 0; i < projs.size(); i++) {
			// ������Ҫ������id���õ����ʵ�������Ϣ
			HashMap adjust_map = this.getAdjustInterInfo(adjustId);
			HashMap rent_list_map = this.getRemAndTotalIncome(projs.get(i)
					.toString(), adjust_map.get("start_date").toString());

			if (Integer.parseInt(rent_list_map.get("nextTerm").toString()) <= Integer
					.parseInt(rent_list_map.get("totalTerm").toString())) {
				// --����ǰ�����ƻ������Ϣ��ʷ
				String sql = "	insert into dbo.fund_rent_plan_his(contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'��Ϣ','"
						+ adjustId
						+ "','ǰ' from fund_rent_plan 	 where contract_id='"
						+ projs.get(i).toString() + "'";
				System.out.println("sql==" + sql);
				conn.executeUpdate(sql);

				// �������������,�õ��������ʸ�������
				HashMap condtion_info = this.getProj_ConditionInfoByProj_id(
						projs.get(i).toString(), rent_list_map.get("nextTerm")
								.toString());
				String flo_type = condtion_info.get("rate_float_type")
						.toString();
				boolean is_fix_value = false;// �ǲ��Ǹ�ÿһ�ڵ������ӹ̶���ֵ

				// ���������ʸ�������,���������ʼӵ�,�̶����������,���ֲ���
				// // 0,1,2,3,4
				String retu_vale = "0.0";
				if ("0".equals(flo_type)) {// ���������ʸ�������
					retu_vale = this.getRateByBaseRate(condtion_info.get(
							"lease_term").toString(), adjust_map);

				} else if ("1".equals(flo_type)) {// ���������ʼӵ�
					retu_vale = this.getRateByPoint(condtion_info.get(
							"lease_term").toString(), condtion_info.get(
							"rate_float_amt").toString(), adjust_map);

				} else if ("2".equals(flo_type)) {// �̶����������
					retu_vale = this.getFixed(condtion_info.get("lease_term")
							.toString(), condtion_info.get("rate_float_amt")
							.toString(), adjust_map);
					is_fix_value = true;//
				} else if ("3".equals(flo_type)) {// ���ֲ���,�������¼���
					continue;
				}

				// --ʣ�౾��,�����,ʣ������
				String measure_type = condtion_info.get("measure_type")
						.toString();
				String rem_corpus = condtion_info.get("rem_corpus").toString();
				String income_number_year = condtion_info.get(
						"income_number_year").toString();
				String rem_rent_list = condtion_info.get("rem_rent_list")
						.toString();
				String period_type = condtion_info.get("period_type")
						.toString();
				String handling_charge = condtion_info.get("handling_charge")
						.toString();
				String consulting_fee = condtion_info.get("consulting_fee")
						.toString();
				String caution_money = condtion_info.get("caution_money")
						.toString();
				String start_date = condtion_info.get("start_date").toString();
				String equip_amt = condtion_info.get("equip_amt").toString();
				String lease_money = condtion_info.get("lease_money")
						.toString();

				if (!is_fix_value) {// ���ǹ̶�������ʱ,�ȶ����ʱ

					HashMap mp = new HashMap();
					mp.put("retu_vale", retu_vale);
					mp.put("rem_rent_list", rem_rent_list);
					mp.put("rem_corpus", rem_corpus);
					mp.put("period_type", period_type);
					mp.put("income_number_year", income_number_year);
					mp.put("consulting_fee", consulting_fee);
					mp.put("lease_money", lease_money);
					mp.put("proj_id", projs.get(i).toString());
					mp
							.put("nextTerm", rent_list_map.get("nextTerm")
									.toString());
					mp.put("equip_amt", equip_amt);
					mp.put("start_date", start_date);
					mp.put("caution_money", caution_money);
					mp.put("handling_charge", handling_charge);
					mp.put("measure_type", measure_type);
					// �������ƻ�
					this.calRentByNew(mp);

					// --�޸ĵ�Ϣ��Ŀ��,��ӵ�Ϣ��Ŀ��Ϣ
					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,before_rate,after_rate,rent_list_start,adjust_id,contract_id) select '��',";
					ins_sql += "'" + condtion_info.get("year_rate").toString()
							+ "','" + retu_vale + "','"
							+ rent_list_map.get("nextTerm").toString() + "','"
							+ adjustId + "','" + projs.get(i).toString() + "'";
					conn.executeUpdate(ins_sql);

				} else {// ��ÿһ�ڹ̶���һ��ֵʱ

					this.addRent(projs.get(i).toString(), rent_list_map.get(
							"nextTerm").toString(), retu_vale);

					// --�޸ĵ�Ϣ��Ŀ��
					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,rent_list_start,adjust_id,contract_id,adjust_amt) select '��','";
					ins_sql += rent_list_map.get("nextTerm").toString() + "','"
							+ adjustId + "','" + projs.get(i).toString()
							+ "','" + retu_vale + "'";

					conn.executeUpdate(ins_sql);
				}

			}

			// --�����󳥻��ƻ������Ϣ��ʷ,���º�ͬ���׽ṹ��
			String upd_sql = " update dbo.contract_condition set plan_irr='"
					+Tools.formatNumberDoubleScale(this.irr, 6) 
					+ "' where contract_id='"
					+ projs.get(i).toString()
					+ "'  insert into dbo.fund_rent_plan_his(contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'��Ϣ','"
					+ adjustId
					+ "','��' from fund_rent_plan where contract_id='"
					+ projs.get(i).toString() + "'";
			System.out.println("=upd_sql==:"+upd_sql);
			conn.executeUpdate(upd_sql);

		}

	}

	/**
	 * ���¼������
	 * 
	 * @param mp
	 * @throws Exception
	 */

	public void calRentByNew(HashMap mp) throws Exception {

		RentCalc rent = new RentCalc();
		rent.setYear_rate(mp.get("retu_vale").toString());
		String measure_type = mp.get("measure_type").toString();

		rent.setIncome_number(mp.get("rem_rent_list").toString());
		rent.setLease_money(Tools.formatNumberDoubleTwo(mp.get("rem_corpus")
				.toString()));
		rent.setFuture_money("0");
		rent.setPeriod_type(mp.get("period_type").toString());// �ڳ�������δ
		rent.setIrr_type("2");// 1��Ϊ���·�������irr,2Ϊ�����������
		rent.setScale("8");// ����irr����ʱ�ľ���
		rent.setLease_interval(String.valueOf(Integer.parseInt(mp.get(
				"income_number_year").toString())));

		String dt = this.getDateByPreiod(mp.get("proj_id").toString(), mp.get(
				"nextTerm").toString(), mp.get("period_type").toString(),
				String.valueOf(Integer.parseInt(mp.get("income_number_year")
						.toString())));
		rent.setPlan_date(dt);

		List l_rent_1 = new ArrayList();
		List l_plane = new ArrayList();

		// ����ǰ�ڸ����,���޹�˾������Ϊ-�������Ϊ+,�����������ѣ��豸���֤���
		// �������ʱ���Էŵ���ǰ������б�
		
		
		if (mp.get("lease_money").toString().length() > 0
				&& mp.get("lease_money").toString().indexOf("-") > -1) {
			l_rent_1.add(Tools.formatNumberDoubleTwo(mp.get("lease_money")
					.toString()));
		}else {
			l_rent_1
			.add("-"
					+ Tools.formatNumberDoubleTwo(mp.get("lease_money")
							.toString()));
		}
		

		l_plane.add(mp.get("start_date").toString());

		l_rent_1.add(mp.get("consulting_fee").toString());
		l_plane.add(mp.get("start_date").toString());

		l_rent_1.add(mp.get("handling_charge").toString());
		l_plane.add(mp.get("start_date").toString());

		// �õ�ǰ������list,����irr����Ҫ
		HashMap hm_ = this.getTxBefore(mp.get("nextTerm").toString(), mp.get(
				"proj_id").toString().toString(), l_rent_1, l_plane);
		List list_cash = (List) hm_.get("preRentList");
		List list_dt = (List) hm_.get("preDateList");
		rent.setPreCash(list_cash);
		rent.setPreDate(list_dt);

		// ���������ȫ���迼��
		if ("0".equals(rent.getYear_rate())) {
			rent.setYear_rate("1");
		}

		// �õ����list,ע�ⲻ����ʱ�����list
		List rent_list = rent.eqRentList(rent.getYear_rate());// ����ʱ
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent
				.getPeriod_type());// �ƻ�ʱ��

		// 1���ȶ����2���ȶ��,�ȶ��ʱrent_list,l_plan_date_,���Դ�һ���չ�ȥ
		HashMap hm = null;
		if ("1".equals(measure_type) || "0".equals(measure_type)) {// �ȶ����,���������
			hm = rent.getHashRentPlan("1", rent_list, l_plan_date_);
		} else if ("2".equals(measure_type)) {// �ȶ��
			hm = rent.getHashRentPlan("2", null, null);
		} else {// �ֶ�ʱ,Ĭ��
			hm = rent.getHashRentPlan("1", rent_list, l_plan_date_);
		}

		this.irr = rent.getV_irr();
		System.out.println("irr:" + rent.getV_irr());

		List l_rent = (List) hm.get("rent");
		List l_corpus = (List) hm.get("corpus");
		List l_interest = (List) hm.get("interest");
		List l_corpus_overage = (List) hm.get("corpus_overage");
		List l_plan_date = (List) hm.get("plan_date");

		for (int j = 0; j < l_rent.size(); j++) {
			System.out.println("plan_date:  " + l_plan_date.get(j)
					+ "\t rent:  " + l_rent.get(j) + " \t corpus: "
					+ l_corpus.get(j) + " \t interest:  " + l_interest.get(j)
					+ " \t corpus_overage:  " + l_corpus_overage.get(j));
		}

		// ��������
		this.updateRentPlan(l_rent, l_interest, l_corpus, l_corpus_overage, mp
				.get("proj_id").toString(), mp.get("nextTerm").toString());
	}

	/**
	 * �̶�ֵʱ���ÿһ�ڵ����
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 */
	public void addRent(String proj_id, String start_term, String add_value)
			throws Exception {
		String sql = "update fund_rent_plan set rent=rent+" + add_value
				+ " where contract_id='" + proj_id + "' and rent_list>='"
				+ start_term + "'";
		Conn conn = new Conn();
		conn.executeUpdate(sql);

	}

}
