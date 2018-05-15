package com.tenwa.culc.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.bean.ContractPlanBean;
import com.tenwa.culc.bean.VbadinfoBean;
import com.tenwa.culc.bean.VendProBean;
import com.tenwa.culc.dao.ProjInfoDao;
import com.tenwa.log.LogWriter;

/**
 * 
 * @ClassName ProjInfoWriteService

 * @Description 回写CRM调用的service方法

 * @Author 崔天帅

 * @Date 2013-6-12下午04:33:10
 */

public class ProjInfoWriteService {
	
	/**
	 * 
	 * @Title dataSyncFinal
	
	 * @Param contractId 合同编号
	
	 * @Description 批量回写供应商租赁信息、不良信息
	
	 * @Return int 执行成功返回插入的条目数,执行失败返回0
	
	 * @throw
	 */
	public static int dataSyncFinal(String contractId){
		int res = 0;
		List<String> list = new ArrayList<String>();
		ProjInfoDao projIndoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1从Client1 服务器读取数据
				list = projIndoDao.readERPProjEquipInfoData(contractId);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("读取ERP Server [项目信息] 异常");
			}

			// 2.将数据同步到Server数据库服务器
			try {
				dataSync4(contractId);
				for (String string : list) {
					dataSync6(contractId,string);
					res++;
				}
			} catch (Exception e) {
				e.printStackTrace();
				LogWriter.logError("更新CRM Server [项目信息] 异常,异常信息: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("项目编号不合法：" + contractId);
		}
		return res;
	}
	
	
	/**
	 * 
	 * @Title dataSync6
	
	 * @Param contractId 合同编号
	 * @Param equip_id 租赁物件ID
	
	 * @Description 回写供应商租赁项目信息
	
	 * @Return int 执行成功返回插入的条目数,执行失败返回0
	
	 * @throw
	 */
	public static int dataSync6(String contractId,String equip_id){
		int res = 0;
		// 1.从ERP数据库服务器读出数据保存在VendProBean
		VendProBean vendProBean = new VendProBean();
		ProjInfoDao projIndoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1从Client1 服务器读取数据
				vendProBean = projIndoDao.readERPProjVendProInfoData(contractId,equip_id);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("读取ERP Server [项目信息] 异常");
			}

			// 2.将VendProBean数据同步到Server数据库服务器
			try {
				//插入数据返回插入条数
				res = projIndoDao.insertCRMVendProData(vendProBean);
				System.out.println(vendProBean.getDarrive());
				dataSync5(contractId,
						//2014年9月18日更改计划时间
						vendProBean.getDarrive().substring(0, 10),vendProBean.getPlan_date().substring(0, 10)
						//"2013-03-13"
								,equip_id);
			} catch (SQLException e) {
				// 写错误日志到数据库2013-7-22
				/*try {
					OperationUtil.operationExceptionLog("DATA_VENDPRO_WRITE_INFO",
							"ERP回写CRM项目信息", "读取异常：" + e.getMessage());
				} catch (SQLException e1) {
					e1.printStackTrace();
				}*/
				e.printStackTrace();
				LogWriter.logError("更新CRM Server [项目信息] 异常,异常信息: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("项目编号不合法：" + contractId);
		}
		// 本次执行是否成功
		return res;
	}
	
	/**
	 * 
	 * @Title dataSync5
	
	 * @Param contractId 合同编号
	 * @Param factDate 实际到货时间
	 * @Param planDate 计划到货时间
	 * @Param equip_id 租赁物件ID
	
	 * @Description 将不良信息回写到crm中
	
	 * @Return int 执行成功返回回写的条目数,执行失败返回0
	
	 * @throw
	 */
	public static int dataSync5(String contractId,String factDate,String planDate,String equip_id){
		int res = 0;
		// 1.从ERP数据库服务器读出数据保存在VbadinfoBean
		VbadinfoBean vbadinfoBean = new VbadinfoBean();
		ProjInfoDao projInfoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1从Client1 服务器读取数据
				vbadinfoBean = projInfoDao.readERPProjBadInfoData(contractId,factDate,planDate,equip_id);
			} catch (SQLException e) {
				// 写错误日志到数据库2013-7-22
				/*try {
					OperationUtil.operationExceptionLog("DATA_VBAD_WRITE_INFO",
							"ERP回写CRM项目信息", "读取异常：" + e.getMessage());
				} catch (SQLException e1) {
					e1.printStackTrace();
				}*/
				e.printStackTrace();
				LogWriter.logError("读取ERP Server [项目信息] 异常");
			}

			// 2.将VbadinfoBean数据同步到Server数据库服务器
			try {
				//插入数据返回插入条数
				res = projInfoDao.insertCRMBadData(vbadinfoBean,factDate,planDate);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("更新CRM Server [项目信息] 异常,异常信息: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("项目编号不合法：" + contractId);
		}

		// 本次执行是否成功
		return res;
	}
	
	/**
	 * 
	 * @Title dataSync4
	
	 * @Param contractId 合同编号
	
	 * @Description 将供应商项目相关银行账号信息回写到crm
	
	 * @Return int 执行成功返回回写的条目数,执行失败返回0
	
	 * @throw
	 */
	public static int dataSync4(String contractId){
		int res = 0;
		// 1.从ERP数据库服务器读出数据保存在ContractPlanBean
		List<ContractPlanBean> contractPlanList = new ArrayList<ContractPlanBean>();
		ProjInfoDao projInfoDao = new ProjInfoDao();
		if (contractId != null && !"".equals(contractId) && !"null".equals(contractId)) {

			try {
				// 1.1从Client1 服务器读取数据
				contractPlanList = projInfoDao.readERPProjZJJHInfoData(contractId);
			} catch (SQLException e) {
				// 写错误日志到数据库2013-7-22
//				try {
//					OperationUtil.operationExceptionLog("DATA_GYSXM_WRITE_INFO",
//							"ERP回写CRM项目信息", "读取异常：" + e.getMessage());
//				} catch (SQLException e1) {
//					e1.printStackTrace();
//				}
				e.printStackTrace();
				LogWriter.logError("读取ERP Server [项目信息] 异常");
			}

			// 2.将ContractPlanBean数据同步到Server数据库服务器
			try {
				//插入数据返回插入条数
				res = projInfoDao.insertCRMZJJHData(contractPlanList);
			} catch (SQLException e) {
				e.printStackTrace();
				LogWriter.logError("更新CRM Server [项目信息] 异常,异常信息: "
						+ e.getMessage());
			}
		} else {
			LogWriter.logError("项目编号不合法：" + contractId);
		}

		// 本次执行是否成功
		return res;
	}
}
