/**
 * com.tenwa.culc.util
 */
package com.tenwa.culc.util;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.log.LogWriter;

/**
 * 简单操作公共类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class OperationUtil {

	private static Logger log = Logger.getLogger(ConditionDao.class);

	private static ERPDataSource erpDataSource=null;

	// 公共参数
	private static ResultSet rs = null;

	/**
	 * 返回租金测算下载的文件名称
	 * 
	 * @param settle_method
	 * @param period_type
	 * @param ext
	 * @return
	 */
	public static String getFileName(String settle_method, String period_type,
			String ext) {
		String fileName = "";
		// 1.查询数据库得到settle_method值
		erpDataSource=new ERPDataSource();
		try {
			String sqlStr = "select title from dbo.ifelc_conf_dictionary where parentid='RentCalcType' and name='"
					+ settle_method + "'";
			rs = erpDataSource.executeQuery(sqlStr);
			String settle_method_name = "";
			if (rs.next()) {
				settle_method_name = rs.getString("title");
			}
			// 2.拼接
			String period_type_name = "";
			if (period_type != null && "1".equals(period_type)) {// 期初
				period_type_name = "先付";
			} else {
				period_type_name = "后付";
			}

			if ("等额租金后付(均息法)".equals(settle_method_name)) {
				fileName = settle_method_name + "." + ext;
			} else {
				fileName = settle_method_name + period_type_name + "." + ext;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3.关闭资源
			erpDataSource.close();
		}

		if (log.isDebugEnabled()) {
			log.debug("租金测算下载文件名称：" + fileName);
		}

		return fileName;
	}

	/**
	 * 租金计算方法
	 * 
	 * @param uploadFileName
	 * @return
	 */
	public static String getSettleMethod(String uploadFileName) {
		String settleMethod = "";

		String seTitle = uploadFileName;
		
		// 1.查询数据库得到settle_method值
		erpDataSource=new ERPDataSource();
		try {
			String sqlStr = "select name from ifelc_conf_dictionary where parentid='RentCalcType' and title='"
					+ seTitle + "'";
			rs = erpDataSource.executeQuery(sqlStr);
			if (rs.next()) {
				settleMethod = rs.getString("name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		return settleMethod;
	}

	/**
	 * 返回客户查询界面的CountSql
	 * 
	 * @param dqczy
	 * @param wherestr
	 * @return
	 */
	public static String getCustSelectSql(String dqczy, String wherestr) {
		String sqlStr = "";
		StringBuffer sqlBuffer = new StringBuffer();
		// 普通参数
		String sql = "";
		String parent_deptname = "";
		String role = "";
		erpDataSource=new ERPDataSource();
		try {
			// ====1.判断当前人所属部门
			sql = "select dept_name,parent_deptname from v_base_department where id =(";
			sql += "select department from v_base_user where id='" + dqczy
					+ "')";
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()) {
				parent_deptname = rs.getString("parent_deptname");
			}
			// 1.0判断部门是否为业务部
			if (checkDetpType(parent_deptname)) {
				// ====2.判断当前人的角色
				sql = "select name,isnull(role,'') as role from v_base_user where id='"
						+ dqczy + "'";
				rs = erpDataSource.executeQuery(sql);
				if (rs.next()) {
					role = rs.getString("role");
				}
				if ("项目经理".equals(role) && role != null) {
					// 2.1如果是项目经理，只能查看自己有权限查看的客户
					sqlBuffer
							.append(" and cust_id in( select cust_id from cust_query_power where query_user_id='"
									+ dqczy + "' ) ");
				} else if ("部门经理".equals(role) && role != null) {
					// 2.2如果非项目经理（部门经理），能查看当前部门及子部门下所有客户
					sqlBuffer
							.append(" and creator_dept in( ")
							.append(
									"select department as id from v_base_user where id='"
											+ dqczy + "'")
							.append(
									" union select id from v_base_department where superior_dept=(")
							.append(
									"select department from v_base_user where id='"
											+ dqczy + "'").append(") ) ");
				} else if ("大区经理".equals(role) && role != null) {
					// 2.2如果是大区经理，可以查询该大区所有客户
					sqlBuffer.append(" and creator_dept in( ").append(
							"select department from v_base_user where id='"
									+ dqczy + "')");
				} else {
					sqlBuffer.append(" and 1=2 ");
				}

			} else {// 非业务部人员可以查看所有客户
				sqlBuffer.append("");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		sqlStr = wherestr + sqlBuffer.toString();
		return sqlStr;
	}

	/**
	 * 返回法人客户查询界面的CountSql
	 * 
	 * @param dqczy
	 * @param wherestr
	 * @return
	 */
	public static String getCustInfoSelectSql(String dqczy, String wherestr) {
		String sqlStr = "";
		StringBuffer sqlBuffer = new StringBuffer();
		// 普通参数
		String sql = "";
		String parent_deptname = "";
		String role = "";
		erpDataSource=new ERPDataSource();
		try {
			// ====1.判断当前人所属部门
			sql = "select dept_name,parent_deptname from v_base_department where id =(";
			sql += "select department from v_base_user where id='" + dqczy
					+ "')";
			System.out.println("权限部门查询SQL="+sql);
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()) {
				parent_deptname = rs.getString("parent_deptname");
			}
			System.out.println("parent_deptname=="+parent_deptname);
			if("租赁事业二部".equals(parent_deptname)){
				System.out.println("部分OK");
			}
			// 1.0判断部门是否为业务部
			if (checkDetpType(parent_deptname)) {
				// ====2.判断当前人的角色
				sql = "select name,isnull(role,'') as role from v_base_user where id='"
						+ dqczy + "'";
				System.out.println("当前人的角色查询SQL="+sql);
				rs = erpDataSource.executeQuery(sql);
				if (rs.next()) {
					role = rs.getString("role");
				}
				System.out.println("当前登陆人角色为=="+role);
				if ("项目经理".equals(role) && role != null) {
					// 2.1如果是项目经理，只能查看自己有权限查看的客户
					sqlBuffer
							.append(" and cust_id in( select cust_id from cust_query_power where query_user_id='"
									+ dqczy + "' ) ");
				} else if ("部门经理".equals(role) && role != null) {
					// 2.2如果非项目经理（部门经理），能查看当前部门及子部门下所有客户
					sqlBuffer
							.append(" and creator_dept in( ")
							.append(
									"select department as id from v_base_user where id='"
											+ dqczy + "'")
							.append(
									" union select id from v_base_department where superior_dept=(")
							.append(
									"select department from v_base_user where id='"
											+ dqczy + "'").append(") ) ");
				} else if ("大区经理".equals(role) && role != null) {
					// 2.2如果是大区经理，可以查询该大区所有客户
					sqlBuffer.append(" and creator_dept in( ").append(
							"select department from v_base_user where id='"
									+ dqczy + "')");
				} else {
					sqlBuffer.append(" and 1=2 ");
				}

			} else {// 非业务部人员可以查看所有客户
				sqlBuffer.append("");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		sqlStr = wherestr + sqlBuffer.toString();
		return sqlStr;
	}

	/**
	 * 返回个人客户查询界面的CountSql
	 * 
	 * @param dqczy
	 * @param wherestr
	 * @return
	 */
	public static String getCustEwlpInfoSelectSql(String dqczy, String wherestr) {
		String sqlStr = "";
		StringBuffer sqlBuffer = new StringBuffer();
		// 普通参数
		String sql = "";
		String parent_deptname = "";
		String role = "";
		erpDataSource=new ERPDataSource();
		try {
			// ====1.判断当前人所属部门
			sql = "select dept_name,parent_deptname from v_base_department where id =(";
			sql += "select department from v_base_user where id='" + dqczy
					+ "')";
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()) {
				parent_deptname = rs.getString("parent_deptname");
			}
			System.out.println("parent_deptname=="+parent_deptname);
			if("租赁事业二部".equals(parent_deptname)){
				System.out.println("部分OK");
			}
			// 1.0判断部门是否为业务部
			if (checkDetpType(parent_deptname)) {
				// ====2.判断当前人的角色
				sql = "select name,isnull(role,'') as role from v_base_user where id='"
						+ dqczy + "'";
				rs = erpDataSource.executeQuery(sql);
				if (rs.next()) {
					role = rs.getString("role");
				}
				if ("项目经理".equals(role) && role != null) {
					// 2.1如果是项目经理，只能查看自己有权限查看的客户
					sqlBuffer
							.append(" and cust_id in( select cust_id from cust_query_power where query_user_id='"
									+ dqczy + "' ) ");
				} else if ("部门经理".equals(role) && role != null) {
					// 2.2如果非项目经理（部门经理），能查看当前部门及子部门下所有客户
					sqlBuffer
							.append(" and creator_dept in( ")
							.append(
									"select department as id from v_base_user where id='"
											+ dqczy + "'")
							.append(
									" union select id from v_base_department where superior_dept=(")
							.append(
									"select department from v_base_user where id='"
											+ dqczy + "'").append(") ) ");
				} else {
					sqlBuffer.append(" and 1=2 ");
				}
			} else {// 非业务部人员可以查看所有客户
				sqlBuffer.append("");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		sqlStr = wherestr + sqlBuffer.toString();
		return sqlStr;
	}

	/**
	 * 判断是否存在该合同冲抵第一期租金
	 * 
	 * @param contractId
	 * @return
	 */
	public static int judgeOffFirstRent(String contractId) {
		int flag = 0;
		// 判断是否存在第一期租金冲抵
		erpDataSource=new ERPDataSource();
		try {
			String sql = "Select id from fund_fund_offset_first_rent where contract_id='"
					+ contractId + "' and flag=0";
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()) {
				flag = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		return flag;
	}

	/**
	 * 获取该合同冲抵第一期租金信息
	 * 
	 * @param contractId
	 * @return
	 */
	public static String getOffFirstRentInfo(String contractId) {
		String resVal = "";
		// 判断是否存在第一期租金冲抵
		erpDataSource=new ERPDataSource();
		try {
			String sql = "select id,off_first_rent,off_time,(select fee_name from vi_contract_fund_fund_charge_plan";
			sql += " where id=match_id) as fee_name from fund_fund_offset_first_rent where contract_id='"
					+ contractId + "'";
			rs = erpDataSource.executeQuery(sql);
			if (rs.next()) {
				resVal = "款项：" + rs.getString("fee_name") + " 冲抵租金："
						+ rs.getString("off_first_rent") + " 冲抵日期："
						+ rs.getString("off_time");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			erpDataSource.close();
		}

		return resVal;
	}
	
	public static boolean checkDetpType(String deptName) throws SQLException{
		// true 为业务，false为职能
		ERPDataSource db=new ERPDataSource();
		ResultSet rs1 =null;
		try {
			String sql = "select is_select,id,dept_name from base_department";
			sql += " where dept_name='"
					+ deptName + "'";
			System.out.println(sql);
			rs1 = db.executeQuery(sql);
			if (rs1.next()) {
				String type = rs1.getString("is_select");
				if(type==null){
					return true;
				}else
				if("1".equals(type)){
					return false;
				}
			}else{
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs1!=null){
				rs1.close();
			}
			db.close();
		}
		return false;
	}
	public static void main(String[] args){
	String str=	getCustInfoSelectSql("ADMN-8HT5LJ","");
	System.out.println(str);
	}

	/**
	 * ERP错误日志操作
	 * 
	 * @param oper_type
	 * @param oper_name
	 * @param oper_excep
	 * @throws SQLException
	 */
	public static void ERPoperationExceptionLog(String oper_type,
			String oper_name, String oper_excep) throws SQLException {
		// 1.创建连接
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.插入最新数据
		String sql = "";

		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();

		oper_excep = oper_excep.replaceAll("'", "''");
		// 2拼接sql
		sqlStr
				.append("Insert into FI_ERP_DATA_SYNC_LOG_NC(oper_id,oper_type,oper_name,oper_remark,oper_date,amount)");
		sqlStr.append(" values('无-产生异常','" + oper_type + "','" + oper_name
				+ "','" + oper_excep + "','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "',0)");
		LogWriter.logError("产生异常：" + sqlStr.toString());
		sql = sqlStr.toString();
		erpDataSource.executeUpdate(sql);
		erpDataSource.close();
	}
	/**
	 * 获取最新流水号
	 * 
	 * @param type
	 *            类型 例：国内收款单
	 * @param defaultVal
	 *            默认流水号
	 * @param amount
	 *            流水号长度
	 * @return
	 */
	public static String getSerialNumber(String type, String defaultVal,
			int amount) {
		String resVal = "";
		String sqlStr = "";
		// 1.查询数据库得到settle_method值
		ERPDataSource erpDataSource=new ERPDataSource();
		try {
			// 1查询出最新编号
			sqlStr = "select isnull(max(cast(no as int)),1)+1 as no from GENERATE_NO where generate_type='"
					+ type + "'";
			rs = erpDataSource.executeQuery(sqlStr);
			if (rs.next()) {
				resVal = rs.getString("no");
			}
			// 2.插入当前编号
			sqlStr = "insert into generate_no select '" + type
					+ "',getdate(),'" + resVal + "'";
			erpDataSource.executeUpdate(sqlStr);
		} catch (SQLException e) {
			LogWriter.logError("生成[" + type + "]流程号异常，\n" + e.getMessage());
		} finally {
			// 3.关闭资源
			erpDataSource.close();
		}
		// 补零操作
		if (resVal == null || "".equals(resVal)) {
			resVal = defaultVal;
		} else {
			resVal = CommonTool.operOStr(resVal, amount);
		}

		return resVal;
	}

}
