/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.service.SqlGenerateUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * RentPlanDao操作
 * 
 * @author Jaffe
 * 
 * Date:Jul 12, 2011 1:19:53 PM Email:JaffeHe@hotmail.com
 */
public class RentPlanDao {
	private static Logger log = Logger.getLogger(RentPlanDao.class);
	// 公共参数
	private ResultSet rs = null;

	/**
	 * 更新项目租金计划临时表数据
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateFundRentPlanProjTempData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_proj_temp(proj_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getProj_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 更新医疗管理项目计划临时表数据
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateMediProjRentListData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_proj_bd_medi_temp(proj_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getProj_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";
			System.out.println("Sql::::"+sqlStr);
			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	
	/**
	 * 更新医疗管理项目计划临时表数据
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateMediContRentListData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_contract_bd_medi_temp(contract_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";
			System.out.println("Sql::::"+sqlStr);
			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 删除临时历史数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanProjTempHisData(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_rent_plan_proj_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除fund_rent_plan_proj_temp成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 删除临时历史数据-医疗管理项目租金计划
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteMediProjRentListData(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_rent_plan_proj_bd_medi_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除[fund_rent_plan_proj_bd_medi_temp]成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}
	
	/**
	 * 删除临时历史数据-医疗管理项目租金计划
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteMediContRentListData(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_rent_plan_contract_bd_medi_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除[fund_rent_plan_proj_bd_medi_temp]成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 删除起租时历史数据 （包括）
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentListBeginHisData(String begin_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// dbo.fund_rent_plan_temp2
		// dbo.fund_rent_plan_his2
		// dbo.fund_rent_plan_before2
		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateDelRentBeginDataSql(begin_id,
				doc_id);

		erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("执行删除[fund_rent_plan_temp]成功");
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 流程初始化判断租金计划临时表数据是否存在
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemExist(String proj_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from fund_rent_plan_proj_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 初始化流程项目租金计划临时表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2Temp(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into fund_rent_plan_proj_temp(proj_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,")
				.append(
						"year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,curr_penalty,")
				.append("penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select proj_id,'"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,")
				.append(
						"year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,curr_penalty,")
				.append(
						"penalty,creator,create_date,modificator,modify_date from fund_rent_plan_proj");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();
		
		System.out.println("test----------------"+sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 判断数据是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemContractExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	public void copyData2ContractTemp(String contract_id, String proj_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date from fund_rent_plan_proj ");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 删除合同租金计划
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanContractTempHisData(String contract_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除fund_rent_plan_contract_temp成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 保存合同租金计划
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateFundRentPlanContractTempData(
			List<RentPlanBean> rentPlanList) throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 判断合同租金计划数据是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractDataExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "select id from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 合同租金计划数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select contract_id,'"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date from fund_rent_plan_contract ");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 保存[fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before]数据
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentListBeginData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2 循环插入
		// [fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before] 表
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);

			// fund_rent_plan_temp 租金计划临时表
			sqlStr = "  insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,curr_corpus,corpus,year_rate,curr_interest,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += " values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getBegin_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getMeasure_date() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','"
					+ rentPlanBean.getCurr_corpus() + "','"
					+ rentPlanBean.getCorpus() + "','"
					+ rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getCurr_interest() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ") ";
			System.out.println("租金计划临时表===="+sqlStr);

			resVal += erpDataSource.executeUpdate(sqlStr);
		}

		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 判断租金变更流程[fund_rent_plan_temp]是否存在数据
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeBeginItemExist(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from fund_rent_plan_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
				+ "' and oth_remark='租金变更前' and doc_id='" + doc_id + "'";

		LogWriter.logSqlStr("租金变更->判断数据存在", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 租金变更流程拷贝租金计划正式数据到[fund_rent_plan_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyBeginRentData2Temp(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date,oth_remark)");

		sqlBuilder
				.append(
						"Select contract_id,begin_id,'"
								+ doc_id
								+ "',getdate(),rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date,'租金变更前' ")
				.append(
						" From fund_rent_plan where contract_id='"
								+ contract_id + "' and begin_id='" + begin_id
								+ "'");

		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("租金变更->临时数据拷贝", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断在[fund_rent_plan_temp]是否存在数据
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeRentTempItemExist(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from fund_rent_plan_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
				+ "' and doc_id='" + doc_id + "'";

		LogWriter.logSqlStr("起租流程->判断数据存在", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 起租流程 - 租金计划的数据初始化[fund_rent_plan_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyContract2BeginRentData2Temp(String contract_id,
			String begin_id, String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"Select contract_id,'"
								+ begin_id
								+ "','"
								+ doc_id
								+ "',getdate(),rent_list,plan_date,'',curr_rent,rent,corpus,corpus,")
				.append(
						"year_rate,interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append("penalty_overage,plan_status,'','','','','',").append(
						"'',creator,getdate(),modificator,modify_date ")
				.append(
						" From fund_rent_plan_contract where contract_id='"
								+ contract_id + "'");

		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("起租流程->临时数据拷贝", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 删除[fund_rent_plan_temp]表数据
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanBeginTempHisData(String begin_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// dbo.fund_rent_plan_temp
		// dbo.fund_rent_plan_his
		// dbo.fund_rent_plan_before
		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateDelRentBeginDataSql(begin_id,
				doc_id);
		LogWriter.logSqlStr("起租流程-上传租金", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		LogWriter
				.logDebug("执行删除[fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before]成功");
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 租金变更流程
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentChangeBeginTempData(String begin_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Delete from fund_rent_plan_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id
				+ "' and oth_remark='租金变更后'";
		LogWriter.logSqlStr("租金变更流程-删除上传历史", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("执行删除[fund_rent_plan_temp]成功");
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 保存租金变更后的租金数据
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentChangeListBeginData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2 循环插入
		// [fund_rent_plan_temp] 表
		RentPlanBean rentPlanBean = null;
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			rentPlanBean = rentPlanList.get(i);
			// fund_rent_plan_temp 租金计划临时表
			sqlStr = "  insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,curr_corpus,corpus,year_rate,curr_interest,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date,oth_remark)";
			sqlStr += " values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getBegin_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getMeasure_date() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','"
					+ rentPlanBean.getCurr_corpus() + "','"
					+ rentPlanBean.getCorpus() + "','"
					+ rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getCurr_interest() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "','租金变更后'";
			sqlStr += ") ";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}

		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}
}
