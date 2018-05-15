package com.rent.calc.tx;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;


/**
 * 租金测算工具辅助类
 * 
 * @author Administrator
 * 
 */
public class CalcUtil {
	/**
	 * 在某个日期上添加相应的年月日的计算
	 * 
	 * @param strDate
	 *            开始日期
	 * @param leng
	 *            添加的大小
	 * @param type
	 *            年月日类型
	 * @return
	 */
	public static String getDateAdd(String strDate, int leng, String type) {
		Date addDate = null;
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = sdf.parse(strDate);
		} catch (Exception e) {
			System.out.println(e);
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if (type.equals("yy")) {
			cal.add(Calendar.YEAR, leng);
		} else if (type.equals("mm")) {
			cal.add(Calendar.MONTH, leng);
		} else if (type.equals("we")) {
			cal.add(Calendar.WEEK_OF_YEAR, leng);
		} else if (type.equals("dd")) {
			cal.add(Calendar.DAY_OF_YEAR, leng);
		} else if (type.equals("hh")) {
			cal.add(Calendar.HOUR_OF_DAY, leng);
		} else if (type.equals("mi")) {
			cal.add(Calendar.MINUTE, leng);
		} else if (type.equals("ss")) {

		}
		addDate = cal.getTime();
		return sdf.format(addDate);
	}

	/**
	 * 得到两个日期之间的月份间隔
	 * 
	 * @param bdate
	 *            开始日期
	 * @param edate
	 *            结束日期
	 * @return
	 */
	public static int getDateDiffMonth(String bdate, String edate) {
		try {
			String[] barray = bdate.split("-");
			String[] earray = edate.split("-");
			return (Integer.parseInt(earray[0]) - Integer.parseInt(barray[0]))
					* 12
					+ (Integer.parseInt(earray[1]) - Integer
							.parseInt(barray[1]));
		} catch (Exception e) {

		}
		return 0;
	}

	/**
	 * 判断某个日期是不是在时间集合中,如里在则返回他的下标标识
	 * 
	 * @param date
	 * @return
	 */
	public static int isInDateList(String date, List inList) {
		for (int i = 0; i < inList.size(); i++) {
			if (date.equals(inList.get(i).toString().subSequence(0, 7))) {
				return i;
			}
		}
		return -1;
	}

	/**
	 * 重新返回一块内存地址
	 * 
	 * @param l_info
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getNewList(List l_info) {
		List l_new = new ArrayList();
		for (int i = 0; i < l_info.size(); i++) {
			l_new.add(l_info.get(i));
		}
		return l_new;

	}

	public static long getDateDiff(String strbdate, String stredate) // 返回两时间间隔天数
	// bdate--开始时间字符串
	// edate--结束时间字符串
	{
		Date bdate = null;
		Date edate = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			bdate = sdf.parse(strbdate);
			edate = sdf.parse(stredate);
			long datediff = (bdate.getTime() - edate.getTime())
					/ (1000 * 60 * 60 * 24);
			return datediff;
		} catch (Exception e) {

		}
		return 0;
	}

	/**
	 * 得到每一期的租金
	 * 
	 * @param mp
	 * @return
	 */
	public static String getRentByPmt(HashMap mp) {

		String retu_vale = mp.get("retu_vale").toString();
		String rem_rent_list = mp.get("rem_rent_list").toString();
		String rem_corpus = mp.get("rem_corpus").toString();
		String period_type = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		String nominalprice = mp.get("nominalprice").toString();
		String rentScale = mp.get("rentScale").toString();

		// 得到每一期租金的利率
		retu_vale = getPreRate(retu_vale, income_number_year);

		// 得到新的租金测算期次,由于宽限期不用于pmt的租金测算
		rem_rent_list = String.valueOf(Integer.parseInt(mp.get("rem_rent_list")
				.toString())
				- Integer.parseInt(mp.get("igrace").toString()));

		// 得到租金
		String rent = RentTx.getPMT(retu_vale, rem_rent_list, "-" + rem_corpus,
				nominalprice, period_type);
		System.out.println("新的租金 :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * 
	 * @param calcRate
	 *            所要计算的年利率或都是irr之类的
	 * @param lease_interval
	 *            租金间隔
	 * @return
	 */
	@SuppressWarnings("unused")
	public static String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
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
	public static void updateRentPlan(List rentList, List interestList,
			List corpus, List corpus_overage, String proj_id, String startTerm)
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
	 * 得到前期款项
	 * 
	 * @param contract_id
	 * @param endTerm
	 * @param qzOrqm
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static List getCashList(String contract_id, String endTerm,
			String qzOrqm, List rent_list, HashMap mp) throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 查出交易结构表中的流入流出数据
		String sql = "select ((isnull(handling_charge,0)+isnull(return_amt,0)+isnull(other_income,0)+isnull(first_payment,0)+isnull(before_interest,0))-(isnull(equip_amt,0)+isnull(consulting_fee,0)+isnull(other_expenditure,0))) net_flow from contract_condition where contract_id='"
				+ contract_id + "' ";
		rs = conn.executeQuery(sql);
		String net_flow = "0";
		List l_rent_list = new ArrayList();// 用于存放新的现金流
		if (rs.next()) {
			net_flow = rs.getString(1);
			l_rent_list.add(Tools.formatNumberDoubleScale(net_flow, 2));
		}

		// String ajdustStyle = mp.get("ajdustStyle").toString(); // 调整方式
		// if ("0".equals(ajdustStyle)) {//如果是次日时
		// endTerm = String.valueOf(Integer.parseInt(endTerm)-1);
		// }

		sql = "select rent from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list < " + endTerm + " ";
		rs = conn.executeQuery(sql);

		List pre_list = new ArrayList();
		// 延迟付款的我们将他放在现金流之前的处理
		// mp.put("delay", condtion_info.get("delay"));
		String sdelay = mp.get("delay").toString();
		// 添加延迟付款期数
		for (int i = 0; i < Integer.parseInt(sdelay); i++) {
			pre_list.add("0");
		}
		// 其他的正常调息前的租金
		while (rs.next()) {
			pre_list
					.add(Tools.formatNumberDoubleScale(rs.getString("rent"), 2));
		}

		if ("0".equals(sdelay)) {// 无延迟付款时
			// 如果是期初，且开始调息的期次是1,
			if ("1".equals(endTerm) && "1".equals(qzOrqm)) {

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(rent_list.get(
												0).toString(), 2))), 2));

				// 添加后面的租金值
				for (int i = 1; i < rent_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(rent_list.get(i)
									.toString(), 2)));
				}
				return l_rent_list;

			} else if ("1".equals(endTerm) && !"1".equals(qzOrqm)) {// 如果不是期初，但还是从第一期开始调息的
				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));// 添加所有的租金
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && "1".equals(qzOrqm)) {// 如果是期初但不是从第一期开始时，先查询出调整前的所有期次
				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// 添加其他的期项
				for (int j = 1; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}

				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && !"1".equals(qzOrqm)) {

				for (int j = 0; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}
				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			}
		} else if (Integer.parseInt(sdelay) > 0) {// 有延迟付款时

			// 如果是期初，且开始调息的期次是1,
			if ("1".equals(endTerm) && "1".equals(qzOrqm)) {

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// 添加延期时的租金值
				for (int i = 1; i < pre_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(
									pre_list.get(i).toString(), 2)));
				}

				// 添加后面的租金值(宽限期，正常租金)
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(rent_list.get(i)
									.toString(), 2)));
				}
				return l_rent_list;

			} else if ("1".equals(endTerm) && !"1".equals(qzOrqm)) {// 如果不是期初，但还是从第一期开始调息的

				// 添加延期时的租金值
				for (int i = 0; i < pre_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(
									pre_list.get(i).toString(), 2)));
				}

				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));// 添加所有的租金
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && "1".equals(qzOrqm)) {// 如果是期初但不是从第一期开始时，先查询出调整前的所有期次

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// 添加其他的期项
				for (int j = 1; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}

				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && !"1".equals(qzOrqm)) {// 非第一期非起租时

				for (int j = 0; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}
				// 添加后面的租金值
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			}

		}
		rs.close();
		conn.close();

		// 正常情况根本不会发生
		return rent_list;

	}

	/**
	 * 更新租金计划表
	 * 
	 * @param rentList
	 * @param interestList
	 * @param corpus
	 * @param corpus_overage
	 * @param interestList_mark
	 * @param corpus_mark
	 * @param corpus_overage_market
	 * @param proj_id
	 * @param startTerm
	 * @throws Exception
	 */

	public static void updateRentPlan(List rentList, List interestList,
			List corpus, List corpus_overage, List interestList_mark,
			List corpus_mark, List corpus_overage_market, String proj_id,
			String startTerm) throws Exception {

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

					+ corpus_overage.get(i).toString() + "',interest_market='"
					+ interestList_mark.get(i).toString() + "',corpus_market='"
					+ corpus_mark.get(i).toString()
					+ "',corpus_overage_market='"

					+ corpus_overage_market.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// 执行更新操作
		conn.executeUpdate(sql);
		rs.close();
		conn.close();

	}

	/**
	 * 根据项目(合同)的id查询项目（合同）交易结构信息
	 * 
	 * @param proj_id
	 * @param term
	 *            从第几期开始算剩余本金
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	public static HashMap getProj_ConditionInfoByProj_id(String proj_id,
			String term) throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select isnull(ajdustStyle,'') ajdustStyle,isnull(rentScale,0) rentScale,isnull(nominalprice,0) nominalprice,isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,isnull(equip_amt,0) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt,isnull(delay,0) delay,isnull(grace,0) grace from contract_condition where contract_id='"
				+ proj_id + "'";

		HashMap hmp = new HashMap();

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rate_float_type", rs.getString("rate_float_type")); // 利率浮动类型
			// 租赁期限(月)
			hmp.put("lease_term", rs.getString("lease_term"));
			// 付租方式,年，季
			hmp.put("income_number_year", rs.getString("income_number_year"));
			// 还租次数
			hmp.put("income_number", rs.getString("income_number"));
			// 付租类型,期初或期末
			hmp.put("period_type", rs.getString("period_type"));
			// 利率调整值
			hmp.put("rate_float_amt", rs.getString("rate_float_amt"));

			// measure_type租金计算方法
			hmp.put("measure_type", rs.getString("measure_type"));

			// 租赁保证金
			hmp.put("caution_money", rs.getString("caution_money"));
			// 留购价
			hmp.put("nominalprice", rs.getString("nominalprice"));
			hmp.put("year_rate", rs.getString("year_rate"));
			hmp.put("rentScale", rs.getString("rentScale"));
			// 宽限期，延迟付款期数
			hmp.put("delay", rs.getString("delay"));
			hmp.put("grace", rs.getString("grace"));
			hmp.put("ajdustStyle", rs.getString("ajdustStyle"));// 租金调整方式

		}

		// 得到开始期的日期
		sql = "select plan_date from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("plan_date_first", rs.getString("plan_date"));
		}

		// 如果是按次年,次日时，用于计算pmt的剩余本金
		if ("3".equals(hmp.get("ajdustStyle").toString())
				|| "0".equals(hmp.get("ajdustStyle").toString())
				|| "1".equals(hmp.get("ajdustStyle").toString())) {
			term = String.valueOf(Integer.parseInt(term) + 1);// 用于计算剩余的计算本金的开始期次
		}

		//
		sql = "select isnull(sum(corpus_market),0) corpus_market, isnull(sum(corpus),0) rem_corpus,count(*) rem_rent_list,isnull(sum(rent),0) rem_rent from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rem_corpus", rs.getString("rem_corpus"));
			hmp.put("rem_rent", rs.getString("rem_rent"));
			hmp.put("corpus_market", rs.getString("corpus_market"));
		}

		rs.close();
		conn.close();
		return hmp;

	}


	/**
	 * 根据调息日期取得下一期日期的次年的第一天
	 * 
	 * @param txrq
	 *            调息日期
	 * @return
	 */
	public static String getYearFirstDate(String txrq) {

		String rdate = CalcUtil.getDateAdd(txrq, 1, "yy");
		rdate = rdate.substring(0, 4) + "-01-01";
		return rdate;

	}

	public static void printRentInfo(List retn_list, List interest_list,
			List corp_list, List corp__overage_list, List l_inte_mark,
			List l_corpus_market, List l_corpus_overage_market) {
		// 0,1，其他值 等额租金,不规则测算,手工调整时，为2时等额本金，先不做考虑

		System.out.println(" rent" + " \t corpus" + " \t interest "
				+ " \t corpus_overage" + " \t interest_market"
				+ " \t corpus_market " + " \t corpus_overage_market");

		for (int j = 0; j < retn_list.size(); j++) {
			System.out.println(retn_list.get(j) + "\t" + corp_list.get(j)
					+ "\t" + interest_list.get(j) + "\t"
					+ corp__overage_list.get(j) + "\t" + l_inte_mark.get(j)
					+ "\t" + l_corpus_market.get(j) + "\t"
					+ l_corpus_overage_market.get(j) + "\t");
		}
	}



}
