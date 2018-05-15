/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service1;

import java.sql.SQLException;

import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.dao.BeginDao;
import com.tenwa.culc.dao1.BeginDao1;
import com.tenwa.culc.dao1.ConditionDao1;
import com.tenwa.log.LogWriter;

/**
 * 起租信息保存
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 8:16:44 PM Email:JaffeHe@hotmail.com
 */
public class BeginService1 {

	/**
	 * 保存BeginInfoBean，保存到begin_info_temp表
	 * 
	 * @param beginInfoBean
	 * @param save_type
	 * @return 影响行数
	 */
	public static int saveBeginBeanIntoTemp(BeginInfoBean beginInfoBean,
			String save_type) {
		int flag = 0;

		LogWriter.logDebug("将执行保存起租信息结构到Temp表，操作类型：" + save_type + " 合同id:"
				+ beginInfoBean.getContract_id() + "，起租Id:"
				+ beginInfoBean.getBegin_id());
		// 1.BeginDao1 实例化
		BeginDao beginDao = new BeginDao();
		// 2.执行操作
		// 2.1先删除数据 [再] 插入数据
		try {
			beginDao.deleteBeginInfoTempData(beginInfoBean.getBegin_id(),
					beginInfoBean.getDoc_id());
			LogWriter.logDebug("删除起租Id" + beginInfoBean.getBegin_id()
					+ "在begin_info_temp表数据成功，开始执行插入操作");
			flag = beginDao.insertBeginBeanIntoTempTable(beginInfoBean);

			LogWriter
					.logDebug("执行插入BeginInfoBean到begin_info_temp,更新结果：" + flag);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return flag;
	}
	/**
	 * 保存时更新税种字段
	 * 
	 * @param contract_id
	 * @param doc_id
	 */
	public static int flowUpdateTaxtypeToBeginTemp(
			BeginInfoBean beginInfoBean) {

		BeginDao1 beginDao1 = new BeginDao1();
		int flag = 0;
		try {
			flag = beginDao1.updateTaxTypeToBeginTemp(beginInfoBean);
			LogWriter.logDebug("合同Id:" + beginInfoBean.getContract_id()
					+ " 文档Id:" + beginInfoBean.getDoc_id()
					+ " 数据[项目交易结构临时表][contract_condition_temp]更新tax_type完成"
					+ beginInfoBean.getTax_type());
		} catch (SQLException e) {
			LogWriter
					.logError("合同Id:"
							+ beginInfoBean.getContract_id()
							+ " 文档Id:"
							+ beginInfoBean.getDoc_id()
							+ " 数据[项目交易结构临时表][contract_condition_temp]更新tax_type异常，异常信息：\t"
							+ e.getMessage());
		}
		return flag;
	}
	/**
	 * 判断当前起租Id是否存在
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String judgeSaveType(String begin_id, String doc_id) {
		String saveType = "";

		// 1.BeginDao1 实例化
		BeginDao beginDao = new BeginDao();
		try {
			saveType = beginDao.judgeItemExist(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("判断起租操作，执行操作类型：" + saveType);

		return saveType;
	}

	/**
	 * 起租测算，初始化起租Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoBean initBeginInfoBean(BeginInfoBean beginInfoBean) {

		BeginDao1 beginDao1 = new BeginDao1();
		try {
			beginInfoBean = beginDao1.loadBeginInfoBeanByKey(beginInfoBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoBean;
	}

	/**
	 * 历史起租信息加载Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoBean initBeginInfoHisBean(String begin_id) {
		BeginInfoBean beginInfoBean = null;

		// 查询数据库假装Bean
		LogWriter.logDebug("加载历史起租[Begin_id]：" + begin_id + " 到beginInfoBean");

		BeginDao beginDao = new BeginDao();
		try {
			beginInfoBean = beginDao.loadBeginInfoHisBeanByKey(begin_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoBean;
	}

	/**
	 * 合同总租赁本金
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getTotalLeaseMoney(String contract_id) {
		String totalLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			totalLeaseMoney = beginDao.selectTotalLeaseMoney(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return totalLeaseMoney;
	}

	/**
	 * 合同已起租的租赁本金
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getUsedLeaseMoney(String contract_id) {
		String usedLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			usedLeaseMoney = beginDao.selectUsedLeaseMoney(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return usedLeaseMoney;
	}
	
	/**
	 * 合同已起租的租赁本金
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getUsedLeaseMoneyB(String contract_id,String flow_date) {
		String usedLeaseMoney = "";
		BeginDao beginDao = new BeginDao();
		try {
			usedLeaseMoney = beginDao.selectUsedLeaseMoneyB(contract_id, flow_date);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return usedLeaseMoney;
	}

	/**
	 * 起租上传租金测算，保存beginInfoBean，保存到begin_info_temp表
	 * 
	 * @param beginInfoBean
	 * @param save_type
	 * @return 影响行数
	 */
	public static int saveUploadBeginInfoBean(BeginInfoBean beginInfoBean) {
		int resVal = 0;
		// 1.beginDao 实例化
		BeginDao beginDao = new BeginDao();
		// 2.执行操作
		// 2.1先删除该数据
		try {
			beginDao.delBeginInfoTempData(beginInfoBean.getContract_id(),
					beginInfoBean.getBegin_id(), beginInfoBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2插入最新数据
		try {
			resVal = beginDao.insertBean2BeginIntoTempTable(beginInfoBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("上传保存，更新contract_id:"
				+ beginInfoBean.getContract_id() + "，起租编号:"
				+ beginInfoBean.getBegin_id() + " 交易结构临时表，更新结果："
				+ (resVal == 0 ? "失败" : "成功"));

		return resVal;
	}

	/**
	 * 查询本次合同的起租序列号
	 * 
	 * @param contract_id
	 * @return
	 */
	public static int getBeginOrderIndex(String contract_id) {
		int beginOrderIndex = 1;
		BeginDao beginDao = new BeginDao();
		try {
			beginOrderIndex = beginDao.selectBeginOrderIndex(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return beginOrderIndex;
	}
}
