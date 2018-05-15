/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.util.ERPDataSource;

/**
 * 项目现金流
 * 
 * @author Jaffe
 * 
 * Date:Jul 13, 2011 10:25:26 AM Email:JaffeHe@hotmail.com
 */
public class RentCashDao {
	private static Logger log = Logger.getLogger(RentCashDao.class);
	// 公共参数
	private ResultSet rs = null;

	/**
	 * 删除项目租金现金流数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentCashProjTempHisData(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_proj_plan_mark_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除fund_proj_plan_mark_temp成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 将租金现金流List保存
	 * 
	 * @param rentCashList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentCashProjTempData(List<RentCashBean> rentCashList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentCashList.size(); i++) {
			RentCashBean rentCashBean = rentCashList.get(i);
			sqlStr = "insert into fund_proj_plan_mark_temp(proj_id,doc_id,plan_date,follow_in,follow_in_detail,";
			sqlStr += "follow_out,follow_out_detail,net_follow,creator,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentCashBean.getProj_id() + "','"
					+ rentCashBean.getDoc_id() + "','"
					+ rentCashBean.getPlan_date() + "','"
					+ BigDecimal.valueOf(Double.parseDouble(rentCashBean.getFollow_in())) + "','"
					
					+ rentCashBean.getFollow_in_detail() + "','"
					+ rentCashBean.getFollow_out() + "','"
					+ rentCashBean.getFollow_out_detail() + "','"
					+ rentCashBean.getNet_follow() + "','"
					+ rentCashBean.getCreator() + "','"
					+ rentCashBean.getCreate_date() + "'";
			sqlStr += ")";
			System.out.println("现金流查询："+sqlStr);
			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 判断数据是否存在
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
		String sqlStr = "select id from fund_proj_plan_mark_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 数据拷贝
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
						"Insert into fund_proj_plan_mark_temp(proj_id,doc_id,plan_date,follow_in,follow_in_detail,follow_out,")
				.append(
						"follow_out_detail,net_follow,creator,create_date,modificator,modify_date,note,adjust_id)");
		sqlBuilder
				.append(
						"select proj_id,'"
								+ doc_id
								+ "',plan_date,follow_in,follow_in_detail,follow_out,")
				.append(
						"follow_out_detail,net_follow,creator,create_date,modificator,modify_date,note,adjust_id")
				.append(" from fund_proj_plan_mark");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

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
		String sqlStr = "select id from fund_contract_plan_mark_temp where contract_id='"
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
						"insert into fund_contract_plan_mark_temp(contract_id,doc_id,plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,")
				.append(
						"net_follow,creator,create_date,modificator,modify_date,note,adjust_id)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,")
				.append(
						"net_follow,creator,create_date,modificator,modify_date,note,adjust_id from fund_proj_plan_mark ");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 删除合同现金流数据
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentCashContractTempHisData(String contract_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from fund_contract_plan_mark_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除[fund_contract_plan_mark_temp]成功");
		}
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 保存合同现金流
	 * 
	 * @param rentCashList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentCashContractTempData(List<RentCashBean> rentCashList)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入租金
		String sqlStr = "";
		for (int i = 0; i < rentCashList.size(); i++) {
			RentCashBean rentCashBean = rentCashList.get(i);
			sqlStr = "insert into fund_contract_plan_mark_temp(contract_id,doc_id,plan_date,follow_in,follow_in_detail,";
			sqlStr += "follow_out,follow_out_detail,net_follow,creator,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentCashBean.getContract_id() + "','"
					+ rentCashBean.getDoc_id() + "','"
					+ rentCashBean.getPlan_date() + "','"
					+ rentCashBean.getFollow_in() + "','"
					+ rentCashBean.getFollow_in_detail() + "','"
					+ rentCashBean.getFollow_out() + "','"
					+ rentCashBean.getFollow_out_detail() + "','"
					+ rentCashBean.getNet_follow() + "','"
					+ rentCashBean.getCreator() + "','"
					+ rentCashBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}

	/**
	 * 判断合同现金流数据是否存在
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
		String sqlStr = "select id from fund_contract_plan_mark_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 合同现金流数据拷贝
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
						"insert into fund_contract_plan_mark_temp(contract_id,doc_id,plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,")
				.append(
						"net_follow,creator,create_date,modificator,modify_date,note,adjust_id)");
		sqlBuilder
				.append(
						"select contract_id,'"
								+ doc_id
								+ "',plan_date,follow_in,follow_in_detail,follow_out,follow_out_detail,")
				.append(
						"net_follow,creator,create_date,modificator,modify_date,note,adjust_id from fund_contract_plan_mark ");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 删除[fund_begin_plan_mark_temp]表数据
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteCashListBeginHisData(String begin_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Delete from fund_begin_plan_mark_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行删除[Begin_id]" + begin_id
					+ ", [fund_begin_plan_mark_temp]成功");
		}
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 保存到[fund_begin_plan_mark_temp]表
	 * 
	 * @param rentDetails
	 * @return
	 * @throws SQLException
	 */
	public int updateCashListBeginData(List<RentCashBean> rentDetails)
			throws SQLException {
		int resVal = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.循环插入现金流
		String sqlStr = "";
		for (int i = 0; i < rentDetails.size(); i++) {
			RentCashBean rentCashBean = rentDetails.get(i);
			sqlStr = "insert into fund_begin_plan_mark_temp(begin_id,doc_id,plan_date,follow_in,follow_in_detail,";
			sqlStr += "follow_out,follow_out_detail,net_follow,creator,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentCashBean.getBegin_id() + "','"
					+ rentCashBean.getDoc_id() + "','"
					+ rentCashBean.getPlan_date() + "','"
					+ rentCashBean.getFollow_in() + "','"
					+ rentCashBean.getFollow_in_detail() + "','"
					+ rentCashBean.getFollow_out() + "','"
					+ rentCashBean.getFollow_out_detail() + "','"
					+ rentCashBean.getNet_follow() + "','"
					+ rentCashBean.getCreator() + "','"
					+ rentCashBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		return resVal;
	}
}
