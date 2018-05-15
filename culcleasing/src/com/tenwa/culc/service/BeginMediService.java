/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.service;
import java.sql.SQLException;


import com.tenwa.culc.bean.BeginInfoMediBean;

import com.tenwa.culc.dao.BeginMediDao;
import com.tenwa.log.LogWriter;

/**
 * 起租信息保存(医疗)
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 8:16:44 PM Email:JaffeHe@hotmail.com
 */
public class BeginMediService {

	/**
	 * 保存BeginInfoBean，保存到begin_info_temp表
	 * 
	 * @param beginInfoBean
	 * @param save_type
	 * @return 影响行数
	 */
	public static int saveBeginBeanIntoTemp(BeginInfoMediBean beginInfomediBean,
			String save_type) {
		int flag = 0;

		LogWriter.logDebug("将执行保存起租信息结构到Temp表，操作类型：" + save_type + " 合同id:"
				+ beginInfomediBean.getContract_id() + "，起租Id:"
				+ beginInfomediBean.getBegin_id());
		// 1.BeginDao1 实例化
		BeginMediDao beginmMdiDao = new BeginMediDao();
		// 2.执行操作
		// 2.1先删除数据 [再] 插入数据
		try {
			beginmMdiDao.deleteBeginInfoTempData(beginInfomediBean.getBegin_id(),
					beginInfomediBean.getDoc_id());
			LogWriter.logDebug("删除起租Id" + beginInfomediBean.getBegin_id()
					+ "在begin_info_temp表数据成功，开始执行插入操作");
			flag = beginmMdiDao.insertBeginBeanIntoTempTable(beginInfomediBean);

			LogWriter
					.logDebug("执行插入BeginInfoMediBean到begin_info_Medi_temp,更新结果：" + flag);

		} catch (SQLException e) {
			e.printStackTrace();
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
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			saveType = beginmMdiDao.judgeItemExist(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("判断起租操作，执行操作类型：" + saveType);

		return saveType;
	}
	/**
	 * 判断当前起租Id是否存在
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String judgeSaveType1(String begin_id) {
		String saveType = "";

		// 1.BeginDao1 实例化
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			saveType = beginmMdiDao.judgeItemExist1(begin_id);
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
	public static BeginInfoMediBean initBeginInfoBean(String begin_id, String doc_id) {
		BeginInfoMediBean beginInfoMediBean = null;

		// 查询数据库假装Bean
		LogWriter.logDebug("加载当前起租Id：" + begin_id + " doc_id:" + doc_id
				+ " 到beginInfoBean");

		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			LogWriter.logDebug("进入到beginmMdiDao");
			beginInfoMediBean = beginmMdiDao.loadBeginInfoBeanByKey(begin_id, doc_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoMediBean;
	}
	/**
	 * 起租测算，初始化起租Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoMediBean initBeginInfoBean1(String begin_id) {
		BeginInfoMediBean beginInfoMediBean = null;

		// 查询数据库假装Bean
		LogWriter.logDebug("加载当前起租Id：" + begin_id +  " 到beginInfoBean");

		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			LogWriter.logDebug("进入到beginmMdiDao");
			beginInfoMediBean = beginmMdiDao.loadBeginInfoBeanByKey1(begin_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoMediBean;
	}

	/**
	 * 历史起租信息加载Bean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static BeginInfoMediBean initBeginInfoHisBean(String begin_id) {
		BeginInfoMediBean beginInfoMediBean = null;

		// 查询数据库假装Bean
		LogWriter.logDebug("加载历史起租[Begin_id]：" + begin_id + " 到beginInfoBean");

		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			beginInfoMediBean = beginmMdiDao.loadBeginInfoHisBeanByKey(begin_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return beginInfoMediBean;
	}

	/**
	 * 合同总租赁本金
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String getTotalLeaseMoney(String contract_id) {
		String totalLeaseMoney = "";
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			totalLeaseMoney = beginmMdiDao.selectTotalLeaseMoney(contract_id);
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
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			usedLeaseMoney = beginmMdiDao.selectUsedLeaseMoney(contract_id);
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
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			usedLeaseMoney = beginmMdiDao.selectUsedLeaseMoneyB(contract_id, flow_date);
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
	public static int saveUploadBeginInfoBean(BeginInfoMediBean beginInfomediBean) {
		int resVal = 0;
		// 1.beginDao 实例化
		BeginMediDao beginmMdiDao = new BeginMediDao();
		// 2.执行操作
		// 2.1先删除该数据
		try {
			beginmMdiDao.delBeginInfoTempData(beginInfomediBean.getContract_id(),
					beginInfomediBean.getBegin_id(), beginInfomediBean.getDoc_id());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// 2.2插入最新数据
		try {
			resVal = beginmMdiDao.insertBean2BeginIntoTempTable(beginInfomediBean);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		LogWriter.logDebug("上传保存，更新contract_id:"
				+ beginInfomediBean.getContract_id() + "，起租编号:"
				+ beginInfomediBean.getBegin_id() + " 交易结构临时表，更新结果："
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
		BeginMediDao beginmMdiDao = new BeginMediDao();
		try {
			beginOrderIndex = beginmMdiDao.selectBeginOrderIndex(contract_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return beginOrderIndex;
	}
}
