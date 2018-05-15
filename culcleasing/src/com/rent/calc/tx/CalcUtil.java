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
 * �����㹤�߸�����
 * 
 * @author Administrator
 * 
 */
public class CalcUtil {
	/**
	 * ��ĳ�������������Ӧ�������յļ���
	 * 
	 * @param strDate
	 *            ��ʼ����
	 * @param leng
	 *            ��ӵĴ�С
	 * @param type
	 *            ����������
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
	 * �õ���������֮����·ݼ��
	 * 
	 * @param bdate
	 *            ��ʼ����
	 * @param edate
	 *            ��������
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
	 * �ж�ĳ�������ǲ�����ʱ�伯����,�������򷵻������±��ʶ
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
	 * ���·���һ���ڴ��ַ
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

	public static long getDateDiff(String strbdate, String stredate) // ������ʱ��������
	// bdate--��ʼʱ���ַ���
	// edate--����ʱ���ַ���
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
	 * �õ�ÿһ�ڵ����
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

		// �õ�ÿһ����������
		retu_vale = getPreRate(retu_vale, income_number_year);

		// �õ��µ��������ڴ�,���ڿ����ڲ�����pmt��������
		rem_rent_list = String.valueOf(Integer.parseInt(mp.get("rem_rent_list")
				.toString())
				- Integer.parseInt(mp.get("igrace").toString()));

		// �õ����
		String rent = RentTx.getPMT(retu_vale, rem_rent_list, "-" + rem_corpus,
				nominalprice, period_type);
		System.out.println("�µ���� :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * 
	 * @param calcRate
	 *            ��Ҫ����������ʻ���irr֮���
	 * @param lease_interval
	 *            �����
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
	 *            �µ�����б�
	 * @param interestList
	 *            �µ���Ϣ�б�
	 * @param corpus
	 *            �µı����б�
	 * @param corpus_overage
	 *            �µı�������б�
	 * @throws Exception
	 */
	public static void updateRentPlan(List rentList, List interestList,
			List corpus, List corpus_overage, String proj_id, String startTerm)
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
	 * �õ�ǰ�ڿ���
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

		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select ((isnull(handling_charge,0)+isnull(return_amt,0)+isnull(other_income,0)+isnull(first_payment,0)+isnull(before_interest,0))-(isnull(equip_amt,0)+isnull(consulting_fee,0)+isnull(other_expenditure,0))) net_flow from contract_condition where contract_id='"
				+ contract_id + "' ";
		rs = conn.executeQuery(sql);
		String net_flow = "0";
		List l_rent_list = new ArrayList();// ���ڴ���µ��ֽ���
		if (rs.next()) {
			net_flow = rs.getString(1);
			l_rent_list.add(Tools.formatNumberDoubleScale(net_flow, 2));
		}

		// String ajdustStyle = mp.get("ajdustStyle").toString(); // ������ʽ
		// if ("0".equals(ajdustStyle)) {//����Ǵ���ʱ
		// endTerm = String.valueOf(Integer.parseInt(endTerm)-1);
		// }

		sql = "select rent from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list < " + endTerm + " ";
		rs = conn.executeQuery(sql);

		List pre_list = new ArrayList();
		// �ӳٸ�������ǽ��������ֽ���֮ǰ�Ĵ���
		// mp.put("delay", condtion_info.get("delay"));
		String sdelay = mp.get("delay").toString();
		// ����ӳٸ�������
		for (int i = 0; i < Integer.parseInt(sdelay); i++) {
			pre_list.add("0");
		}
		// ������������Ϣǰ�����
		while (rs.next()) {
			pre_list
					.add(Tools.formatNumberDoubleScale(rs.getString("rent"), 2));
		}

		if ("0".equals(sdelay)) {// ���ӳٸ���ʱ
			// ������ڳ����ҿ�ʼ��Ϣ���ڴ���1,
			if ("1".equals(endTerm) && "1".equals(qzOrqm)) {

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(rent_list.get(
												0).toString(), 2))), 2));

				// ��Ӻ�������ֵ
				for (int i = 1; i < rent_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(rent_list.get(i)
									.toString(), 2)));
				}
				return l_rent_list;

			} else if ("1".equals(endTerm) && !"1".equals(qzOrqm)) {// ��������ڳ��������Ǵӵ�һ�ڿ�ʼ��Ϣ��
				// ��Ӻ�������ֵ
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));// ������е����
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && "1".equals(qzOrqm)) {// ������ڳ������Ǵӵ�һ�ڿ�ʼʱ���Ȳ�ѯ������ǰ�������ڴ�
				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// �������������
				for (int j = 1; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}

				// ��Ӻ�������ֵ
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
				// ��Ӻ�������ֵ
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			}
		} else if (Integer.parseInt(sdelay) > 0) {// ���ӳٸ���ʱ

			// ������ڳ����ҿ�ʼ��Ϣ���ڴ���1,
			if ("1".equals(endTerm) && "1".equals(qzOrqm)) {

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// �������ʱ�����ֵ
				for (int i = 1; i < pre_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(
									pre_list.get(i).toString(), 2)));
				}

				// ��Ӻ�������ֵ(�����ڣ��������)
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(rent_list.get(i)
									.toString(), 2)));
				}
				return l_rent_list;

			} else if ("1".equals(endTerm) && !"1".equals(qzOrqm)) {// ��������ڳ��������Ǵӵ�һ�ڿ�ʼ��Ϣ��

				// �������ʱ�����ֵ
				for (int i = 0; i < pre_list.size(); i++) {
					l_rent_list.add(Double.parseDouble(Tools
							.formatNumberDoubleScale(
									pre_list.get(i).toString(), 2)));
				}

				// ��Ӻ�������ֵ
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));// ������е����
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && "1".equals(qzOrqm)) {// ������ڳ������Ǵӵ�һ�ڿ�ʼʱ���Ȳ�ѯ������ǰ�������ڴ�

				l_rent_list.set(0, Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(Tools
								.formatNumberDoubleScale(net_flow, 2))
								+ Double.parseDouble(Tools
										.formatNumberDoubleScale(pre_list
												.get(0).toString(), 2))), 2));

				// �������������
				for (int j = 1; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}

				// ��Ӻ�������ֵ
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			} else if (!"1".equals(endTerm) && !"1".equals(qzOrqm)) {// �ǵ�һ�ڷ�����ʱ

				for (int j = 0; j < pre_list.size(); j++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(pre_list.get(
							j).toString(), 2));
				}
				// ��Ӻ�������ֵ
				for (int i = 0; i < rent_list.size(); i++) {
					l_rent_list.add(Tools.formatNumberDoubleScale(rent_list
							.get(i).toString(), 2));
				}
				return l_rent_list;

			}

		}
		rs.close();
		conn.close();

		// ��������������ᷢ��
		return rent_list;

	}

	/**
	 * �������ƻ���
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

					+ corpus_overage.get(i).toString() + "',interest_market='"
					+ interestList_mark.get(i).toString() + "',corpus_market='"
					+ corpus_mark.get(i).toString()
					+ "',corpus_overage_market='"

					+ corpus_overage_market.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// ִ�и��²���
		conn.executeUpdate(sql);
		rs.close();
		conn.close();

	}

	/**
	 * ������Ŀ(��ͬ)��id��ѯ��Ŀ����ͬ�����׽ṹ��Ϣ
	 * 
	 * @param proj_id
	 * @param term
	 *            �ӵڼ��ڿ�ʼ��ʣ�౾��
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	public static HashMap getProj_ConditionInfoByProj_id(String proj_id,
			String term) throws Exception {

		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select isnull(ajdustStyle,'') ajdustStyle,isnull(rentScale,0) rentScale,isnull(nominalprice,0) nominalprice,isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,isnull(equip_amt,0) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt,isnull(delay,0) delay,isnull(grace,0) grace from contract_condition where contract_id='"
				+ proj_id + "'";

		HashMap hmp = new HashMap();

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rate_float_type", rs.getString("rate_float_type")); // ���ʸ�������
			// ��������(��)
			hmp.put("lease_term", rs.getString("lease_term"));
			// ���ⷽʽ,�꣬��
			hmp.put("income_number_year", rs.getString("income_number_year"));
			// �������
			hmp.put("income_number", rs.getString("income_number"));
			// ��������,�ڳ�����ĩ
			hmp.put("period_type", rs.getString("period_type"));
			// ���ʵ���ֵ
			hmp.put("rate_float_amt", rs.getString("rate_float_amt"));

			// measure_type�����㷽��
			hmp.put("measure_type", rs.getString("measure_type"));

			// ���ޱ�֤��
			hmp.put("caution_money", rs.getString("caution_money"));
			// ������
			hmp.put("nominalprice", rs.getString("nominalprice"));
			hmp.put("year_rate", rs.getString("year_rate"));
			hmp.put("rentScale", rs.getString("rentScale"));
			// �����ڣ��ӳٸ�������
			hmp.put("delay", rs.getString("delay"));
			hmp.put("grace", rs.getString("grace"));
			hmp.put("ajdustStyle", rs.getString("ajdustStyle"));// ��������ʽ

		}

		// �õ���ʼ�ڵ�����
		sql = "select plan_date from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("plan_date_first", rs.getString("plan_date"));
		}

		// ����ǰ�����,����ʱ�����ڼ���pmt��ʣ�౾��
		if ("3".equals(hmp.get("ajdustStyle").toString())
				|| "0".equals(hmp.get("ajdustStyle").toString())
				|| "1".equals(hmp.get("ajdustStyle").toString())) {
			term = String.valueOf(Integer.parseInt(term) + 1);// ���ڼ���ʣ��ļ��㱾��Ŀ�ʼ�ڴ�
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
	 * ���ݵ�Ϣ����ȡ����һ�����ڵĴ���ĵ�һ��
	 * 
	 * @param txrq
	 *            ��Ϣ����
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
		// 0,1������ֵ �ȶ����,���������,�ֹ�����ʱ��Ϊ2ʱ�ȶ���Ȳ�������

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
