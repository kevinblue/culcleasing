package com.rent.calc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * 调息处理类
 * 
 * @author Administrator
 * 
 */
public class TransRate {
	private String irr = "0";

	/**
	 * 固定调整租金金额
	 * 
	 * @param lease_term
	 *            期限
	 * @param adjust_value
	 *            添加的值
	 * @param adjust
	 *            基准率信息
	 * @return 每期要添加的租金的值
	 */
	public String getFixed(String lease_term, String adjust_value,
			HashMap adjust) {

		double rate_d = 0.0;
		if ("6".equals(lease_term)) {// 六个月时
			rate_d = (Double.parseDouble(adjust.get("rate_half").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));

		} else if ("12".equals(lease_term)) {// 一年时
			rate_d = (Double.parseDouble(adjust.get("rate_one").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_d = (Double.parseDouble(adjust.get("rate_three").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_d = (Double.parseDouble(adjust.get("rate_five").toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_d = (Double.parseDouble(adjust.get("rate_abovefive")
					.toString()) / 0.27)
					* (Double.parseDouble(adjust_value));
		} else {
			rate_d = 0.0;
		}
		// 返回每一期租金所应加的值
		return String.valueOf(rate_d);
	}

	/**
	 * 按央行利率加点
	 * 
	 * @param lease_term
	 *            期限
	 * @param adjust_point
	 *            所要加点的值
	 * @return
	 */
	public String getRateByPoint(String lease_term, String adjust_point,
			HashMap adjust) {

		String rate_ = "0";
		if ("6".equals(lease_term)) {// 六个月时
			rate_ = adjust.get("base_rate_half").toString();

		} else if ("12".equals(lease_term)) {// 一年时
			rate_ = adjust.get("base_rate_one").toString();
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_ = adjust.get("base_rate_three").toString();
		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_ = adjust.get("base_rate_five").toString();
		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_ = adjust.get("base_rate_abovefive").toString();
		} else {
			rate_ = "0";
		}
		// 计算他的利率值,在央行的基础上加多少点
		rate_ = String.valueOf(Double.parseDouble(rate_)
				+ Double.parseDouble(adjust_point));
		// 返回的是%之多少
		return rate_;
	}

	/**
	 * 按央行利率浮动比率
	 * 
	 * @param lease_term
	 *            交易结构表期限
	 * @param adjust
	 *            调整利率值信息
	 * @return 相应的利率
	 */
	public String getRateByBaseRate(String lease_term, HashMap adjust) {

		String rate_ = "0";
		if ("6".equals(lease_term)) {// 六个月时
			rate_ = adjust.get("base_rate_half").toString();

		} else if ("12".equals(lease_term)) {// 一年时
			rate_ = adjust.get("base_rate_one").toString();
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_ = adjust.get("base_rate_three").toString();
		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_ = adjust.get("base_rate_five").toString();
		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_ = adjust.get("base_rate_abovefive").toString();
		} else {
			rate_ = "0";
		}
		// 计算他的利率值
		rate_ = String.valueOf(Double.parseDouble(rate_) * 1.1);
		// 返回的是%之多少
		return rate_;
	}

	/**
	 * 
	 * @param proj_id项目编号
	 * @param start_list
	 *            开始期限
	 * @param preiod
	 *            期初还是期未
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

		if (preiod.equals("0")) {// 期初时
			start_date = Tools.dateAdd("month", -Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("变化的第一期时间:" + start_date);
		return start_date;
	}

	/**
	 * 得到调息的前的租金计划
	 * 
	 * @param start_list
	 *            截止的期限
	 * @param proj_id
	 *            项目编号
	 * @param preRentList
	 *            前期款
	 * @param preDateList
	 *            前期款时间
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
	 *            新的租金列表
	 * @param interestList
	 *            新的利息列表
	 * @param corpus
	 *            新的本金列表
	 * @param corpus_overage
	 *            新的本金余额列表
	 * @throws Exception
	 */
	public void updateRentPlan(List rentList, List interestList, List corpus,
			List corpus_overage, String proj_id, String startTerm)
			throws Exception {

		// 所要更新的记录
		String sql = "select id,rent_list from fund_rent_plan where contract_id='"
				+ proj_id
				+ "' and rent_list>='"
				+ startTerm
				+ "' order by rent_list ";

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		// 构造所要执行的sql语句
		sql = "   ";
		int i = 0;// 用于租金,本金等数据的提取
		while (rs.next()) {
			sql += " update fund_rent_plan set rent='"
					+ rentList.get(i).toString() + "',corpus='"
					+ corpus.get(i).toString() + "',interest='"
					+ interestList.get(i).toString() + "',corpus_overage='"
					+ corpus_overage.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// 执行更新操作
		conn.executeUpdate(sql);
		rs.close();
		conn.close();

	}

	/**
	 * 根据项目的id查询项目交易结构信息
	 * 
	 * @param proj_id
	 * @param term
	 *            从第几期开始算剩余本金
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	public HashMap getProj_ConditionInfoByProj_id(String proj_id, String term)
			throws Exception {

		// 数据库操作对象
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
	 *            利率调整id
	 * @return 利率调整信息
	 * @throws Exception
	 */
	public HashMap getAdjustInterInfo(String adjustId) throws Exception {
		// 数据库操作对象
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
	 * 得到总的租金期数,以及调息期数数
	 * 
	 * @return
	 * @throws Exception
	 */
	public HashMap getRemAndTotalIncome(String proj_id, String start_date)
			throws Exception {

		// 友联是从当前期次的下一期开发始调
		int nextTerm = 0;
		int totalTerm = 0;
		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " select isnull(min(rent_list),0) from fund_rent_plan where contract_id='"
				+ proj_id
				+ "' and convert(varchar(10),plan_date,120)>convert(varchar(10),'"
				+ start_date + "',120) and plan_status='未回笼'";

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
	 *            调息表的id
	 * @param projs
	 *            所对应的项目
	 * @throws Exception
	 */
	public void processInterest(String adjustId, List projs) throws Exception {
		// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变
		// // 0,1,2,3,4

		Conn conn = new Conn();
		// 循环页面传过来的项目
		for (int i = 0; i < projs.size(); i++) {
			// 根据所要调整的id，得到利率调整的信息
			HashMap adjust_map = this.getAdjustInterInfo(adjustId);
			HashMap rent_list_map = this.getRemAndTotalIncome(projs.get(i)
					.toString(), adjust_map.get("start_date").toString());

			if (Integer.parseInt(rent_list_map.get("nextTerm").toString()) <= Integer
					.parseInt(rent_list_map.get("totalTerm").toString())) {
				// --调整前偿还计划插入调息历史
				String sql = "	insert into dbo.fund_rent_plan_his(contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
						+ adjustId
						+ "','前' from fund_rent_plan 	 where contract_id='"
						+ projs.get(i).toString() + "'";
				System.out.println("sql==" + sql);
				conn.executeUpdate(sql);

				// 计算出的年利率,得到他的利率浮动类型
				HashMap condtion_info = this.getProj_ConditionInfoByProj_id(
						projs.get(i).toString(), rent_list_map.get("nextTerm")
								.toString());
				String flo_type = condtion_info.get("rate_float_type")
						.toString();
				boolean is_fix_value = false;// 是不是给每一期的租金添加固定的值

				// 按央行利率浮动比率,按央行利率加点,固定调整租金金额,保持不变
				// // 0,1,2,3,4
				String retu_vale = "0.0";
				if ("0".equals(flo_type)) {// 按央行利率浮动比率
					retu_vale = this.getRateByBaseRate(condtion_info.get(
							"lease_term").toString(), adjust_map);

				} else if ("1".equals(flo_type)) {// 按央行利率加点
					retu_vale = this.getRateByPoint(condtion_info.get(
							"lease_term").toString(), condtion_info.get(
							"rate_float_amt").toString(), adjust_map);

				} else if ("2".equals(flo_type)) {// 固定调整租金金额
					retu_vale = this.getFixed(condtion_info.get("lease_term")
							.toString(), condtion_info.get("rate_float_amt")
							.toString(), adjust_map);
					is_fix_value = true;//
				} else if ("3".equals(flo_type)) {// 保持不变,不再重新计算
					continue;
				}

				// --剩余本金,租金间隔,剩余期数
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

				if (!is_fix_value) {// 不是固定添加租金时,等额租金时

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
					// 更新租金计划
					this.calRentByNew(mp);

					// --修改调息项目表,添加调息项目信息
					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,before_rate,after_rate,rent_list_start,adjust_id,contract_id) select '是',";
					ins_sql += "'" + condtion_info.get("year_rate").toString()
							+ "','" + retu_vale + "','"
							+ rent_list_map.get("nextTerm").toString() + "','"
							+ adjustId + "','" + projs.get(i).toString() + "'";
					conn.executeUpdate(ins_sql);

				} else {// 给每一期固定加一定值时

					this.addRent(projs.get(i).toString(), rent_list_map.get(
							"nextTerm").toString(), retu_vale);

					// --修改调息项目表
					String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,rent_list_start,adjust_id,contract_id,adjust_amt) select '是','";
					ins_sql += rent_list_map.get("nextTerm").toString() + "','"
							+ adjustId + "','" + projs.get(i).toString()
							+ "','" + retu_vale + "'";

					conn.executeUpdate(ins_sql);
				}

			}

			// --调整后偿还计划插入调息历史,更新合同交易结构表
			String upd_sql = " update dbo.contract_condition set plan_irr='"
					+Tools.formatNumberDoubleScale(this.irr, 6) 
					+ "' where contract_id='"
					+ projs.get(i).toString()
					+ "'  insert into dbo.fund_rent_plan_his(contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
					+ adjustId
					+ "','后' from fund_rent_plan where contract_id='"
					+ projs.get(i).toString() + "'";
			System.out.println("=upd_sql==:"+upd_sql);
			conn.executeUpdate(upd_sql);

		}

	}

	/**
	 * 重新计算租金
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
		rent.setPeriod_type(mp.get("period_type").toString());// 期初还是期未
		rent.setIrr_type("2");// 1，为按月份来计算irr,2为租金间隔来处理
		rent.setScale("8");// 设置irr计算时的精度
		rent.setLease_interval(String.valueOf(Integer.parseInt(mp.get(
				"income_number_year").toString())));

		String dt = this.getDateByPreiod(mp.get("proj_id").toString(), mp.get(
				"nextTerm").toString(), mp.get("period_type").toString(),
				String.valueOf(Integer.parseInt(mp.get("income_number_year")
						.toString())));
		rent.setPlan_date(dt);

		List l_rent_1 = new ArrayList();
		List l_plane = new ArrayList();

		// 设置前期付款额,租赁公司付出的为-，收入的为+,包括，手续费，设备款，保证金等
		// 在租金变更时可以放调整前的租金列表
		
		
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

		// 得到前面的租金list,计算irr的需要
		HashMap hm_ = this.getTxBefore(mp.get("nextTerm").toString(), mp.get(
				"proj_id").toString().toString(), l_rent_1, l_plane);
		List list_cash = (List) hm_.get("preRentList");
		List list_dt = (List) hm_.get("preDateList");
		rent.setPreCash(list_cash);
		rent.setPreDate(list_dt);

		// 正常情况完全不予考虑
		if ("0".equals(rent.getYear_rate())) {
			rent.setYear_rate("1");
		}

		// 得到租金list,注意不规则时的租金list
		List rent_list = rent.eqRentList(rent.getYear_rate());// 规则时
		List l_plan_date_ = rent.getPlanDateList(rent_list, rent
				.getPeriod_type());// 计划时间

		// 1，等额租金，2，等额本金,等额本金时rent_list,l_plan_date_,可以传一个空过去
		HashMap hm = null;
		if ("1".equals(measure_type) || "0".equals(measure_type)) {// 等额租金,不规则测算
			hm = rent.getHashRentPlan("1", rent_list, l_plan_date_);
		} else if ("2".equals(measure_type)) {// 等额本金
			hm = rent.getHashRentPlan("2", null, null);
		} else {// 手动时,默认
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

		// 更新租金表
		this.updateRentPlan(l_rent, l_interest, l_corpus, l_corpus_overage, mp
				.get("proj_id").toString(), mp.get("nextTerm").toString());
	}

	/**
	 * 固定值时添加每一期的租金
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
