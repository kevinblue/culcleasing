package com.tenwa.leasing.dao.rent.tranrate;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;
import com.tenwa.leasing.util.NumTools;


/**
 * ���ƻ���
 * 
 * @author shf
 * 
 */
public class FundRentPlan {

	/**
	 * �����г����ƻ���
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void processMarkerPlan(String proj_id, String start_term,
			List rent_list, List interest, List corpusList,
			List corpusOvergeList, String year_rate) throws Exception {

		String sql = "";
		for (int i = 0; i < interest.size(); i++) {
			sql += "  update fund_rent_plan set rent='"
					+ NumTools.formatNumberDoubleScale(rent_list.get(i).toString(),2)
					+ "',interest_market='"
					+ NumTools.formatNumberDoubleScale(interest.get(i).toString(),2)

					+ "',year_rate='"
					+ NumTools.formatNumberDoubleScale(year_rate,6)

					+ "',corpus_market='"
					+ NumTools.formatNumberDoubleScale(corpusList.get(i).toString(),2)
					+ "',corpus_overage_market='"
					+ NumTools.formatNumberDoubleScale(corpusOvergeList.get(i)
							.toString(),2) + "' where rent_list='" + start_term
					+ "' and contract_id='" + proj_id + "' ";
			start_term = String.valueOf(Integer.parseInt(start_term) + 1);
			// System.out.println(sql);
		}

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * �����г����ƻ���
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void updateSignMarkerPlan(String proj_id, String start_term,
			String interest, String corpusList, String corpusOvergeList,
			String year_rate) throws Exception {

		String sql = "";

		sql += "  update fund_rent_plan set interest_market='"
				+ NumTools.formatNumberDoubleScale(interest,2) + "',corpus_market='"
				+ NumTools.formatNumberDoubleScale(corpusList,2)

				+ "',year_rate='" + NumTools.formatNumberDoubleScale(year_rate,6)

				+ "',corpus_overage_market='"
				+ NumTools.formatNumberDoubleScale(corpusOvergeList,2)
				+ "' where rent_list='" + start_term + "' and contract_id='"
				+ proj_id + "' ";

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * ���²���ı���ֵ
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void updateSignFinacPlan(String proj_id, String start_term,
			String interest, String corpusList, String corpusOvergeList)
			throws Exception {

		String sql = "";

		sql += "  update fund_rent_plan set interest='"
				+ NumTools.formatNumberDoubleScale(interest,2) + "',corpus='"
				+ NumTools.formatNumberDoubleScale(corpusList,2)
				+ "',corpus_overage='"
				+ NumTools.formatNumberDoubleScale(corpusOvergeList,2)
				+ "' where rent_list='" + start_term + "' and contract_id='"
				+ proj_id + "' ";

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * ���²������ƻ���
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void processFinacePlan(String proj_id, String start_term,
			List interest, List corpusList, List corpusOvergeList)
			throws Exception {

		String sql = "";
		for (int i = 0; i < interest.size(); i++) {
			sql += "  update fund_rent_plan set interest='"
					+ NumTools.formatNumberDoubleScale(interest.get(i).toString(),2)
					+ "',corpus='"
					+ NumTools.formatNumberDoubleScale(corpusList.get(i).toString(),2)
					+ "',corpus_overage='"
					+ NumTools.formatNumberDoubleScale(corpusOvergeList.get(i)
							.toString(),2) + "' where rent_list='" + start_term
					+ "' and contract_id='" + proj_id + "' ";
			start_term = String.valueOf(Integer.parseInt(start_term) + 1);
			// System.out.println("=="+sql);
		}

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * �г����ֵ�ĸ���
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 * @throws SQLException
	 */

	public void proceMarkerInfo(String proj_id, String start_term,
			String add_value) throws Exception, SQLException {
		// �г������Ϣ����
		String sql = "update fund_rent_plan set rent=rent+"
				+ NumTools.formatNumberDoubleScale(add_value,2)
				+ " ,interest_market=interest_market+ "
				+ NumTools.formatNumberDoubleScale(add_value,2)
				+ "  where contract_id='" + proj_id + "' and rent_list>='"
				+ start_term + "'";
		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);
	}

	/**
	 * �������ڴε����ֵ
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param flow
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List getOtherFlowRent(String proj_id, String start_term, List flow)
			throws Exception, SQLException {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		sql = "select isnull(rent,0) rent from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>'" + start_term + "'";
		rs = conn.executeQuery(sql);
		while (rs.next()) {
			flow.add(rs.getString("rent"));
		}

		DaoUtil.closeRSOrConn(rs, conn);

		return flow;
	}

	/**
	 * ���ֽ����ĵ�һ�ڵ�ʣ�౾��ֵ
	 * 
	 * @param proj_id
	 * @param start_term
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List getIrrFisrtSumCorpMarker(String proj_id, String start_term)
			throws Exception, SQLException {

		Conn conn = new Conn();

		// �����г���irr
		String sql = "select isnull(sum(corpus_market),0) scorpus from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + start_term + "'";

		// System.out.println("scorpus:" + sql);
		List flow = new ArrayList();
		ResultSet rs = conn.executeQuery(sql);

		if (rs.next()) {
			flow.add("-" + rs.getString("scorpus"));
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return flow;
	}

	/**
	 * ���ֽ����ĵ�һ�ڵ�ʣ�౾��ֵ ����
	 * 
	 * @param proj_id
	 * @param start_term
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List getIrrFisrtSumCorpFina(String proj_id, String start_term)
			throws Exception, SQLException {
		String sql = "";
		Conn conn = new Conn();

		// �����г���irr
		sql = "select isnull(sum(corpus),0) scorpus from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + start_term + "'";
		// System.out.println("scorpus:" + sql);

		ResultSet rs = conn.executeQuery(sql);
		List flow = new ArrayList();

		if (rs.next()) {
			flow.add("-" + rs.getString("scorpus"));
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return flow;
	}

	/**
	 * 
	 * 
	 * @param proj_id
	 * @param start_term
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public String getFisrtSumCorpMarket(String proj_id, String start_term)
			throws Exception, SQLException {
		String sql = "";
		Conn conn = new Conn();

		// �����г���irr
		sql = "select isnull(sum(corpus_market),0) scorpus from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + start_term + "'";
		// System.out.println("scorpus:" + sql);

		ResultSet rs = conn.executeQuery(sql);
		String corpus_market = "0";

		if (rs.next()) {
			corpus_market = rs.getString("scorpus");
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return corpus_market;
	}

	/**
	 * �õ����ƻ���������
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getTotalCount(String contract_id) throws Exception {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		String totalTerm = "0";
		sql = " select count(*) from fund_rent_plan where contract_id='"
				+ contract_id + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			totalTerm = rs.getString(1);
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return totalTerm;

	}

	/**
	 * �õ�������ı������
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getTotalCorpusByQc(String contract_id, String start_term)
			throws Exception {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		String corpus_overage_market = "0";
		sql = " select isnull(corpus_overage_market,0) corpus_overage_market from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list='" + start_term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			corpus_overage_market = rs.getString(1);
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return corpus_overage_market;

	}

	/**
	 * �õ�������ı������ �����
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getTotalCorpusFinacByQc(String contract_id, String start_term)
			throws Exception {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		String corpus_overage = "0";
		sql = " select isnull(corpus_overage,0) corpus_overage from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list='" + start_term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			corpus_overage = rs.getString(1);
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return corpus_overage;

	}

	/**
	 * ���ݺ�ͬ�� ��Ϣ����
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getAdjustMinRentList(String contract_id, String txrq)
			throws Exception {

		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		String sql = " select isnull(min(rent_list),0) from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and convert(varchar(10),plan_date,120)>convert(varchar(10),'"
				+ txrq + "',120) and plan_status='δ����'";
		rs = conn.executeQuery(sql);
		String minRent_list = "";
		if (rs.next()) {
			minRent_list = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return minRent_list;
	}

	/**
	 * ��ѯ��ǰ�ڵ�ǰһ�ڵ�����
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getPreDate(String contract_id, String nextTerm)
			throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select convert(varchar(120),plan_date,120) plan_date from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list ='"
				+ (Integer.parseInt(nextTerm) - 1) + "'";
		rs = conn.executeQuery(sql);
		String preDate = "0";
		if (rs.next()) {
			preDate = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return preDate;
	}

	/**
	 * ��ѯ��ǰ�ڵ����
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getDqZj(String contract_id, String nextTerm) throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select rent from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list ='" + nextTerm + "'";
		rs = conn.executeQuery(sql);
		String rent = "0";
		if (rs.next()) {
			rent = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return rent;
	}

	/**
	 * ��ѯ��ǰ�ڵ����
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getDqCorpus(String contract_id, String nextTerm)
			throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select corpus_market from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list ='" + nextTerm + "'";
		rs = conn.executeQuery(sql);
		String corpus_market = "0";
		if (rs.next()) {
			corpus_market = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return corpus_market;
	}

	/**
	 * ��ѯ��ǰ�ڵĲ���ı���
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getDqCorpusFinac(String contract_id, String nextTerm)
			throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select corpus from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list ='" + nextTerm + "'";
		rs = conn.executeQuery(sql);
		String corpus = "0";
		if (rs.next()) {
			corpus = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return corpus;
	}

	/**
	 * ��ѯ���ڵ�����
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getDqDate(String contract_id, String nextTerm)
			throws Exception {
		// ���ݿ��������
		Conn conn = new Conn();
		ResultSet rs = null;

		// ������׽ṹ���е�������������
		String sql = "select convert(varchar(120),plan_date,120) plan_date from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list ='"
				+ (Integer.parseInt(nextTerm)) + "'";
		rs = conn.executeQuery(sql);
		String dqDate = "0";
		if (rs.next()) {
			dqDate = rs.getString(1);
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return dqDate;
	}

	/**
	 * �õ�Ҫ�޸ĵ�����ֵ
	 * 
	 * @param contract_id
	 * @param startStages
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List getPlanDate(String contract_id, String startStages)
			throws Exception {

		String sql = " select convert(varchar(10),plan_date,120) plan_date  from dbo.fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list>="
				+ startStages
				+ "  order by rent_list    ";
		Conn conn = new Conn();
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		List plan_list = new ArrayList();
		while (rs.next()) {
			plan_list.add(rs.getString("plan_date"));
		}
		DaoUtil.closeRSOrConn(null, conn);
		return plan_list;

	}

	/**
	 * �õ�������ı������ �����
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getTotalCorpusFinac(String contract_id, String start_term)
			throws Exception {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		String corpus_overage = "0";
		sql = " select isnull(sum(corpus),0) corpus from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list>='" + start_term + "'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			corpus_overage = rs.getString(1);
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return corpus_overage;

	}

	/**
	 * �õ��г�����list ����ƽϢ����Ϣ
	 * 
	 * @param proj_id
	 * @param start_term
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List getCorpsMarker(String proj_id, String start_term)
			throws Exception, SQLException {

		Conn conn = new Conn();

		// �����г���irr
		String sql = "select isnull(corpus_market,0) corpus from fund_rent_plan where contract_id='"
				+ proj_id + "' and rent_list>='" + start_term + "'";

		// System.out.println("scorpus:" + sql);
		List flow = new ArrayList();
		ResultSet rs = conn.executeQuery(sql);

		while (rs.next()) {
			flow.add(rs.getString("corpus"));
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return flow;
	}

	/**
	 * �����г����ƻ��� ����ƽϢ������
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void updateMarkerPlanBySet(String proj_id, String start_term,
			List rent_list, List interest, String year_rate) throws Exception {

		String sql = "";
		for (int i = 0; i < interest.size(); i++) {
			sql += "  update fund_rent_plan set rent='"
					+ NumTools.formatNumberDoubleScale(rent_list.get(i).toString(),2)
					+ "',interest_market='"
					+ NumTools.formatNumberDoubleScale(interest.get(i).toString(),2)

					+ "',year_rate='" + NumTools.formatNumberDoubleScale(year_rate,6)

					+ "' where rent_list='" + start_term
					+ "' and contract_id='" + proj_id + "' ";
			start_term = String.valueOf(Integer.parseInt(start_term) + 1);
			// System.out.println(sql);
		}

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * �����г����ƻ��� ƽϢ����һ��
	 * 
	 * @param proj_id
	 *            ��ͬ��
	 * @param start_term
	 *            ��ʼ����
	 * @param interest
	 *            ��Ϣ
	 * @param corpusList
	 *            ����
	 * @param corpusOvergeList
	 *            �������
	 * @throws Exception
	 */
	public void updateSignMarkerPlan(String proj_id, String start_term,
			String rent, String interest, String year_rate) throws Exception {

		String sql = "";

		sql += "  update fund_rent_plan set interest_market='"
				+ NumTools.formatNumberDoubleScale(interest,2) + "',rent='"

				+ NumTools.formatNumberDoubleScale(rent,2) + "',year_rate='"
				+ NumTools.formatNumberDoubleScale(year_rate,6)
				+ "' where rent_list='" + start_term + "' and contract_id='"
				+ proj_id + "' ";

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	/**
	 * ��ǰһ�ڵ�����ֵ
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param flow
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public String getPreRate(String Contract_id, String start_term)
			throws Exception, SQLException {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		sql = "select isnull(year_rate,0) year_rate from fund_rent_plan where contract_id='"
				+ Contract_id + "' and rent_list=" + start_term + "-1";
		rs = conn.executeQuery(sql);
		String year_rate = "0";
		if (rs.next()) {
			year_rate = rs.getString("year_rate");
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return year_rate;

	}

	/**
	 * �õ���ʼ�����ı���list
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param flow
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List getStartCorpus(String Contract_id, String start_term)
			throws Exception, SQLException {
		String sql;
		Conn conn = new Conn();
		ResultSet rs;
		sql = "select isnull(corpus_market,0) corpus_market from fund_rent_plan where contract_id='"
				+ Contract_id + "' and rent_list>=" + start_term;
		rs = conn.executeQuery(sql);
		List l_corpus_market = new ArrayList();
		while (rs.next()) {
			l_corpus_market.add(rs.getString("corpus_market"));
		}

		DaoUtil.closeRSOrConn(rs, conn);
		return l_corpus_market;

	}

	public void proceFinacRentPlan(String proj_id, String start_term)
			throws Exception {

		String sql = "";
		sql += "  update fund_rent_plan set interest=rent where rent_list='"
				+ start_term + "' and contract_id='" + proj_id + "' ";

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

	public void updateMarketRentPlanByGrace(String proj_id, String start_term)
			throws Exception {

		String sql = "";
		sql += "  update fund_rent_plan set rent=interest_market  where rent_list='"
				+ start_term + "' and contract_id='" + proj_id + "' ";

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}

}
