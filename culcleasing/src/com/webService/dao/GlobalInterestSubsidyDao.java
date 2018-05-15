package com.webService.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestSubsidyBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.GlobalInterestSubsidyXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;


public class GlobalInterestSubsidyDao {

	// 公共参数
	private ResultSet rs = null;

	/**
	 * 服务器数据库日志
	 * 
	 * @param oper_id
	 * @param amount
	 * @param syncType
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(String oper_id, int amount, String syncType,String operRmark)
			throws SQLException {
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.更新数据
		String sqlStr = SqlGenerateFIUtil
				.generateFIDataSyncDBLog(oper_id, amount,
						"DATA_SYNC_GLOBAL_INTERESTSUBSIDY", "nc确认利息补贴接口数据同步", operRmark);
		LogWriter.logDebug("writeDataSyncDBLog11" + sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.释放
		erpDataSource.close();
	}

	/**
	 * 数据同步信息
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(
			GlobalInterestSubsidyBean globalInterestSubsidyBean,
			String oper_id, String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalInterestSubsidyBean.getPriId(),
					globalInterestSubsidyBean.getPara_2(),
					globalInterestSubsidyBean.getPara_3(),
					globalInterestSubsidyBean.getPara_4(),
					ifsuccess,
					oper_id,
					"vi_INTERFACE_fina_global_interestSubsidy");
			// LogWriter.logDebug("writeDataSyncDBInfo22" + sqlStr);

			// 执行操作
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * 读取ERP 确认利息补贴表数据
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalInterestSubsidyBean> readGlobalInterestSubsidy(
			String syncType) throws SQLException {
		List<GlobalInterestSubsidyBean> globalInterestSubsidyList = new ArrayList<GlobalInterestSubsidyBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalInterestSubsidyData();
		LogWriter.logSqlStr("读取ERP确认利息补贴表信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalInterestSubsidyBean globalInterestSubsidyBean = new GlobalInterestSubsidyBean();
			// 装载属性
			globalInterestSubsidyBean.setId(rs.getInt("id"));
			globalInterestSubsidyBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalInterestSubsidyBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalInterestSubsidyBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalInterestSubsidyBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalInterestSubsidyBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalInterestSubsidyBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalInterestSubsidyBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalInterestSubsidyBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalInterestSubsidyBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalInterestSubsidyBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			// 2012-2-22 Jaffe 新增，前期漏写
			globalInterestSubsidyBean.setSub_date(ConvertUtil.getDBDateStr(rs
					.getString("sub_date")));

			globalInterestSubsidyBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalInterestSubsidyBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalInterestSubsidyBean.setRmb(ConvertUtil.getDBStr(rs
					.getString("rmb")));
			globalInterestSubsidyBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalInterestSubsidyBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalInterestSubsidyBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalInterestSubsidyBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalInterestSubsidyBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			
			globalInterestSubsidyBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalInterestSubsidyBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
					
			// 装载到大List
			globalInterestSubsidyList.add(globalInterestSubsidyBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalInterestSubsidyBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalInterestSubsidyList;
	}

	/**
	 * 同步数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception
	 */
	public void insert2OracleData(
			List<GlobalInterestSubsidyBean> globalInterestSubsidyList,
			String syncType) throws Exception {
		if (globalInterestSubsidyList.size() < 1) {
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id
            int i = 0;
            GlobalInterestSubsidyXml globalinterestsubsidyxml = new GlobalInterestSubsidyXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			for (GlobalInterestSubsidyBean globalInterestSubsidyBean : globalInterestSubsidyList) {
				if("".equals(globalInterestSubsidyBean.getNccode())||globalInterestSubsidyBean.getNccode()==null||"null".equals(globalInterestSubsidyBean.getNccode())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				
				if("0.00".equals(globalInterestSubsidyBean.getRmb())||"0".equals(globalInterestSubsidyBean.getRmb())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalInterestSubsidyBean.getNcdeptno())||globalInterestSubsidyBean.getNcdeptno()==null||"null".equals(globalInterestSubsidyBean.getNcdeptno())){
					writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				String number = OperationUtil.getSerialNumber(syncType, "0001",
						4);
				globalInterestSubsidyBean.setInvcode(globalInterestSubsidyBean
						.getInvcode()
						+ number);
				try {
					//组装xml字符串
					xmlMassage = globalinterestsubsidyxml.getXmlStr(globalInterestSubsidyBean);
					//请求nc服务端
				    xmlStr=erfs.requst_Nc_Finance("010101","F0",xmlMassage);
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalInterestSubsidyBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalInterestSubsidyBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-确认利息补贴接口", "XML如下:"+xmlMassage,"确认利息补贴(应收)NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// 记录同步失败数据信息
								writeDataSyncDBInfo(globalInterestSubsidyBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalInterestSubsidyBean.getPriId());
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-确认利息补贴接口", "XML如下:"+xmlMassage,"确认利息补贴(应收)NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
			}
			}
				LogWriter.logDebug("本次执行[" + syncType + "]数据同步，成功["
						+ i + "]条"+",失败["+(globalInterestSubsidyList.size()-i)+"]条");
				// 数据库日志
			
				writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalInterestSubsidyList.size()-i)+"]条"));
		
	}
  }
}
