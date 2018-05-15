package com.tenwa.datasync.xirr;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.datasync.xirr.vo.XIrrBean;

public class XIrrInit {
	// 公共参数
	public ERPDataSource erpDataSource = null;
	private ResultSet rs = null;
	public String countSql;
	private String wherestr = "";

	/**
	 * 取得计划时间点
	 * @param begindate
	 * @param enddate
	 * @param projectName
	 * @return
	 * @throws SQLException
	 */
	public List<String> getPlanDate(String begindate, String enddate,
			String projectName) throws SQLException {
		if (projectName != null && !projectName.equals("")) {
			if (begindate == null || "".equals(begindate) || enddate == null
					|| "".equals(enddate)) {
				String contractId = getContractIdByProjName(projectName);
				if (contractId != null && !"".equals(contractId)) {
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
					Date d1 = getMinDate(contractId);
					Date d2 = getMaxDate(contractId);
					if (d1 != null) {
						begindate = df.format(d1);
					}
					if (d2 != null) {
						enddate = df.format(d2);
					}
				}
			}
		}
		String sql = "select distinct convert(varchar(7),plan_date,120) "
				+ " from fund_rent_plan "
				+ " where convert(varchar(10),plan_date,120) between " + "\'"
				+ begindate + "\'" + " and " + "\'" + enddate + "\'"
				+ " order by convert(varchar(7),plan_date,120) ";
		List<String> list = null;
		try {
			rs = erpDataSource.executeQuery(sql);
			if (list == null) {
				list = new ArrayList<String>();
			}
			while (rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 初始化ContractIdList
	/**
	 * 取得合同的集合
	 * @param projectName
	 * @param projId
	 * @param deptName
	 * @param projManageName
	 * @param size
	 * @param currentPage
	 * @return
	 */
	public List<XIrrBean> getContractIdList(String projectName, String projId,
			String deptName, String projManageName, int size, int currentPage) {
		/*
		 * String projectName="";//项目名称 String projId="";//项目ID String
		 * department ="";//部门名称 String menagerName="";//项目经理名称
		 */
		List<XIrrBean> list = new ArrayList<XIrrBean>();
		setWherestr(projId, projectName, deptName, projManageName);

		// //权限判断
		// wherestr = OperationUtil.getCustInfoSelectSql(dqczy, wherestr);
		//

		String sql = "SELECT TOP " + size + " contract_id ,project_name "
				+ " FROM dbo.vi_contract_info "
				+ "WHERE  proj_status>=40 and (contract_id NOT IN "
				+ " (SELECT TOP " + size * (currentPage - 1) + " contract_id "
				+ " FROM dbo.vi_contract_info " + " where proj_status>=40 "
				+ wherestr + " ORDER BY contract_id))" + wherestr
				+ " ORDER BY contract_id ";
		try {
			rs = erpDataSource.executeQuery(sql);
			while (rs.next()) {
				XIrrBean xb = new XIrrBean();
				xb.setContractId(rs.getString("contract_id"));
				xb.setProjectName(rs.getString("project_name"));
				list.add(xb);
			}
		} catch (Exception e) {
			System.out.println("取得分页合同id失败");
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 取的页面显示的XIrr内容
	 * 
	 * @param contracts
	 * @param dates
	 */
	public void initContractList(List<XIrrBean> contracts, List<String> dates) {
		try {
			for (int i = 0; i < contracts.size(); i++) {
				XIrrBean xb = contracts.get(i);
				String contactId = xb.getContractId();
				String signXirr = getXIrrByContractId(contactId);
				// 去除异常数据

				if (signXirr == null || "0E-20".equals(signXirr)
						|| Float.parseFloat(signXirr) == 100.0f) {
					signXirr = "0";
				}

				xb.setSignXirr(signXirr);
				Map<String, String> map = new HashMap<String, String>();
				DateFormat sdf = new SimpleDateFormat("yyyy-MM");

				Date contractStart = this.getMinDate(contactId);
				Date contractEnd = this.getMaxDate(contactId);
				// 调整起始日期
				if (contractStart != null && contractEnd != null) {
					Calendar cld = Calendar.getInstance();
					cld.setTime(contractStart);
					cld.add(Calendar.MONTH, -1);
					contractStart = cld.getTime();
				}

				for (int j = 0; j < dates.size(); j++) {
					Date d = sdf.parse(dates.get(j));
					// 比对合同区间
					if (contractStart != null && contractEnd != null
							&& d.after(contractStart) && d.before(contractEnd)) {
						// 去除异常数据
						String tempXirr = getXIrrByContractidAndPlandate(
								contactId, dates.get(j));
						// System.out.println(dates.get(j));

						if (tempXirr == null || "0E-20".equals(tempXirr)
								|| Float.parseFloat(tempXirr) == 100.0f) {
							tempXirr = "0";
						}

						map.put(dates.get(j), tempXirr);
						// System.out.println("合同id="+contactId+"\t时间="+dates.get(j)+"\t运行到：（"
						// + i + "，" + j + "）");
					}
				}
				xb.setXirrMap(map);
				contracts.set(i, xb);
			}
		} catch (ParseException e) {
			System.out.println("日期格式错误");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("sql语句错误");
			e.printStackTrace();
		}
	}
	/**
	 * XIrrInit 创建数据库连接
	 */
	public void initErpDataSource() {
		this.erpDataSource = new ERPDataSource();
	}
	/**
	 * XIrrInit 关闭数据库连接
	 */
	public void closeErpDataSource() {
		if (erpDataSource != null) {
			erpDataSource.close();
		}
	}

	/**
	 * 根据合同ID计算xirr
	 * 
	 * @param contactId
	 * @return
	 * @throws SQLException
	 * @throws ParseException
	 */
	String getXIrrByContractId(String contactId) throws SQLException,
			ParseException {
		String XIrr = null;
		List l_rent = new ArrayList();// 现金流
		List l_date = new ArrayList();// 对应的日期
		String sql = "select sum(plan_money) plan_money,plan_date from vi_cash_flow where "
				+ "contract_id = '" + contactId + "' group by plan_date";
		rs = erpDataSource.executeQuery(sql);
		while (rs.next()) {
			l_rent.add(rs.getString("plan_money"));
			l_date.add(rs.getString("plan_date"));
		}
		// 调用XIRR计算方法，计算XIRR
		if (l_date.size() > 1 && l_rent.size() > 1
				&& l_date.size() == l_rent.size()) {
			XIrr = new XIrrCal().getXIRR(l_rent, l_date);
		}
		return XIrr;
	}

	/**
	 * 根据合同ID和计划时间点求XIrr
	 * 
	 * @param contractId
	 * @param date2012-02
	 * @return
	 */
	String getXIrrByContractidAndPlandate(String contractId, String date)
			throws SQLException {
		String XIrr = null;
		List l_rent = new ArrayList();// 现金流
		List l_date = new ArrayList();// 对应的日期

		StringBuilder sb = new StringBuilder();
		// 项目总款
		sb.append("Select cffcp.fact_money*-1.00 as plan_money ")
				.append(" , convert(varchar(10),cffcp.fact_date,111) as plan_date ")
				.append(" from fund_fund_charge cffcp ")
				.append(" left join contract_info cif ")
				.append(" on cffcp.contract_id = cif.contract_id ")
				.append(" where cffcp.item_method = '付款' and fee_type = 17 ")
				.append(" and cffcp.fact_date is not null ")
				.append(" and cffcp.contract_id = ")
				.append(" '" + contractId + "' ")
				// 项目返回的保证金
				.append(" union all ")
				.append(" select cffcp.fact_money*-1.00 as plan_money ")
				.append(" , convert(varchar(10),cffcp.fact_date,111) as plan_date ")
				.append(" from fund_fund_charge cffcp ")
				.append(" left join contract_info cif ")
				.append(" on cffcp.contract_id = cif.contract_id ")
				.append(" where cffcp.item_method = '付款' and fee_type != 17 ")
				.append(" and cffcp.fact_date is not null ")
				.append(" and cffcp.contract_id = ")
				.append(" '" + contractId + "' ")
				// 服务费和管理费
				.append(" union all ")
				.append(" select cffcp.fact_money as plan_money ")
				.append(" , convert(varchar(10),cffcp.fact_date,111) as plan_date ")
				.append(" from fund_fund_charge cffcp ")
				.append(" left join contract_info cif on cffcp.contract_id = cif.contract_id ")
				.append(" where cffcp.item_method = '收款' ")
				.append(" and cffcp.fact_date is not null ")
				.append(" and cffcp.contract_id = ")
				.append(" '" + contractId + "' ");

		List<String> begins = this.getBeginIdByContractId(contractId);
		for (String begin : begins) {
			// 计算已经支付次数
			String incomeCount = "select max(plan_list) from fund_rent_income where begin_id = "
					+ "'"
					+ begin
					+ "'"
					+ " and  convert(varchar(7),hire_date,120) <= '"
					+ date
					+ "'";
			rs = erpDataSource.executeQuery(incomeCount);
			long incomeTimes = 0;
			if (rs.next()) {
				incomeTimes = rs.getLong(1);
			}
			// 计算最后一次还款的金额
			String lastIncomesql = "select sum(rent) from fund_rent_income where begin_id = "
					+ " '" + begin + "' " + " and  plan_list = " + incomeTimes;
			rs = erpDataSource.executeQuery(lastIncomesql);
			long lastIncome = 0;
			if (rs.next()) {
				lastIncome = rs.getLong(1);
			}

			// 计划计算最后一次还款的金额
			String lastPlansql = "select sum(rent) from fund_rent_plan where begin_id = "
					+ "'" + begin + "'" + " and  rent_list = " + incomeTimes;
			rs = erpDataSource.executeQuery(lastPlansql);
			long lastPlan = 0;
			if (rs.next()) {
				lastPlan = rs.getLong(1);
			}
			// 当次还款还未换的部分
			long lastmoney = lastPlan - lastIncome;
			if (lastmoney < 0) {
				lastmoney = 0;
			}

			// 已付期次的款项
			sb.append(" union all ")
					.append(" select rent as plan_money ")
					.append(" ,convert(varchar(10),hire_date,111) as plan_date ")
					.append(" from fund_rent_income ")
					.append(" where begin_id = ")
					.append(" '" + begin + "' ")
					.append(" and convert(varchar(7),hire_date,120) <= ")
					.append(" '" + date + "' ")
					// 特点时间的点的款项差值
					.append(" union all ")
					.append(" select ")
					.append(lastmoney)
					.append(" as plan_money ")
					.append(" , convert(varchar(10),plan_date,111) as plan_date ")
					.append(" from fund_rent_plan ")
					.append(" where begin_id = ")
					.append(" '" + begin + "' ")
					.append(" and  rent_list = ")
					.append(incomeTimes)
					// 还未付的计划资金
					.append(" union all ")
					.append(" select rent as plan_money ")
					.append(" , convert(varchar(10),plan_date,111) as plan_date ")
					.append(" from fund_rent_plan ")
					.append(" where begin_id = ").append(" '" + begin + "' ")
					.append(" and  rent_list > ").append(incomeTimes);
		}
		sb.append(" order by plan_date ");
		rs = erpDataSource.executeQuery(sb.toString());
		while (rs.next()) {
			l_rent.add(rs.getString("plan_money"));
			l_date.add(rs.getString("plan_date"));
		}
		// 调用XIRR计算方法，计算XIRR
		if (l_date.size() > 1 && l_rent.size() > 1
				&& l_date.size() == l_rent.size()) {
			XIrr = new XIrrCal().getXIRR(l_rent, l_date);
		}
		return XIrr;
	}
	/**
	 * 通过合同id获得起租id
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	private List<String> getBeginIdByContractId(String contractId)
			throws SQLException {
		String contractEndSql = "select distinct begin_id from fund_rent_plan where contract_id = "
				+ "'" + contractId + "'";
		rs = erpDataSource.executeQuery(contractEndSql);
		List<String> beginIds = new ArrayList<String>();
		while (rs.next()) {

			beginIds.add(rs.getString("begin_id"));
		}
		return beginIds;
	}
	/**
	 * 取得用于分页的sql语句
	 * @param projId
	 * @param projectName
	 * @param deptName
	 * @param projManageName
	 * @return
	 */
	public String getCountSql(String projId, String projectName,
			String deptName, String projManageName) {
		this.setWherestr(projId, projectName, deptName, projManageName);
		return "select count(contract_id) as amount from vi_contract_info ci LEFT JOIN cust_info cif ON cif.cust_id=ci.cust_id where proj_status>=40  "
				+ getWherestr();
	}
	/**
	 * 设置用于分页的sql语句
	 * @param countSql
	 */
	public void setCountSql(String countSql) {
		this.countSql = countSql;
	}
	/**
	 * 取得查询条件语句
	 * @return
	 */
	public String getWherestr() {
		return wherestr;
	}
	/**
	 * 设置查询条件语句
	 * @param projId
	 * @param projectName
	 * @param deptName
	 * @param projManageName
	 */
	void setWherestr(String projId, String projectName, String deptName,
			String projManageName) {
		wherestr = "";

		if (!projId.equals("")) {
			wherestr = wherestr + " and proj_id like '%" + projId + "%'";
		}
		// 此段代码用于基于项目名称的精确查询
		if (projectName != null && !projectName.equals("")) {
			wherestr += " and project_name = '" + projectName + "' ";
		}
		if (deptName != null && !deptName.equals("")) {
			wherestr += " and dept_name like '%" + deptName + "%' ";
		}
		if (projManageName != null && !projManageName.equals("")) {
			wherestr += " and proj_manage_name like '%" + projManageName
					+ "%' ";
		}

	}
	/**
	 * 根据合同id确定合同的开始时间
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public Date getMinDate(String contractId) throws SQLException {
		String contractStartsql = "select min(plan_date) from fund_rent_plan where contract_id = "
				+ "'" + contractId + "'";

		rs = erpDataSource.executeQuery(contractStartsql);
		if (rs.next()) {
			return rs.getDate(1);
		}
		return null;
	}
	/**
	 * 根据合同id确定合同结束时间
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public Date getMaxDate(String contractId) throws SQLException {
		String contractEndSql = "select max(plan_date) from fund_rent_plan where contract_id = "
				+ "'" + contractId + "'";
		rs = erpDataSource.executeQuery(contractEndSql);
		if (rs.next()) {

			return rs.getDate(1);
		}
		return null;
	}
	/**
	 * 根据项目名称确定合同ID
	 * @param projName
	 * @return
	 * @throws SQLException
	 */
	public String getContractIdByProjName(String projName) throws SQLException {
		String contractEndSql = "select contract_id from dbo.vi_contract_info where project_name = "
				+ "'" + projName + "'";
		rs = erpDataSource.executeQuery(contractEndSql);
		if (rs.next()) {
			return rs.getString(1);
		}
		return null;
	}
}
