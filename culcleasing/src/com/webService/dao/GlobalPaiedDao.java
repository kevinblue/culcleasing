/**
 * com.tenwa.datasync.finance.dao
 */
package com.webService.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalPaiedBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.RequestNcServer;
import com.webService.service.XmlAnalysis;


/**
 * 付款单 Dao 操作
 * 
 * @author toybaby Date:Sep 15, 20116:37:52 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalPaiedDao {

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
		String sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBLog(oper_id,
				amount, "DATA_SYNC_GLOBAL_PAIED_NC", "nc付款单财务接口数据同步", operRmark);

		erpDataSource.executeUpdate(sqlStr);
		// 3.释放
		erpDataSource.close();
	}
	
	
	//单个保存数据同步信息
	private void writeDataSyncDBInfo2(GlobalPaiedBean globalPaiedBean,
			String oper_id, String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(globalPaiedBean
					.getPriId(), globalPaiedBean.getPara_2(), globalPaiedBean
					.getPara_3(), globalPaiedBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_paied_nc");

			System.out.println("999999999999999999999"+sqlStr);
			// 执行操作
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * 读取ERP 起租数据
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalPaiedBean> readGlobalPaiedData(String syncType)
			throws SQLException {
		List<GlobalPaiedBean> globalPaiedList = new ArrayList<GlobalPaiedBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalPaiedData1();
		LogWriter.logSqlStr("读取ERP批量付款单信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalPaiedBean globalPaiedBean = new GlobalPaiedBean();
			// 装载属性
			globalPaiedBean.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalPaiedBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalPaiedBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalPaiedBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalPaiedBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalPaiedBean.setBcode(ConvertUtil
					.getDBStr(rs.getString("bcode")));
			globalPaiedBean.setRdate(ConvertUtil.getDBDateStr(rs
					.getString("rdate")));
			globalPaiedBean.setCcode(ConvertUtil
					.getDBStr(rs.getString("ccode")));
			globalPaiedBean.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalPaiedBean.setModifydate(ConvertUtil.getDBDateStr(rs
					.getString("modifydate")));
			globalPaiedBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalPaiedBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalPaiedBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalPaiedBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalPaiedBean.setPcode(ConvertUtil
					.getDBStr(rs.getString("pcode")));
			globalPaiedBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalPaiedBean.setSettlement(ConvertUtil.getDBStr(rs
					.getString("settlement")));
			globalPaiedBean.setPawnsign(ConvertUtil.getDBStr(rs
					.getString("pawnsign")));
			globalPaiedBean.setPawnrmb(ConvertUtil.getDBStr(rs
					.getString("pawnrmb")));
			globalPaiedBean.setAcode(ConvertUtil
					.getDBStr(rs.getString("acode")));
			globalPaiedBean.setO_acode(ConvertUtil.getDBStr(rs
					.getString("o_acode")));

			globalPaiedBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalPaiedBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalPaiedBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalPaiedBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			
			globalPaiedBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));						
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalPaiedBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalPaiedBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			
			// 装载到大List
			globalPaiedList.add(globalPaiedBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalPaiedBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalPaiedList;
	}

	/**
	 * 同步数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalPaiedBean> globalPaiedList,
			String syncType) throws Exception {
		if (globalPaiedList.size() < 1) {
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id
			int i=0;
			FinancialPaiedXml financialpaiedxml = new FinancialPaiedXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			for (GlobalPaiedBean globalPaiedBean : globalPaiedList) {
				if("".equals(globalPaiedBean.getNccode())||globalPaiedBean.getNccode()==null||"null".equals(globalPaiedBean.getNccode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				
				if("".equals(globalPaiedBean.getCcode())||globalPaiedBean.getCcode()==null||"null".equals(globalPaiedBean.getCcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"传输失败！-收款人编码为空");
					continue;
				}
				if("0.00".equals(globalPaiedBean.getRmb())||"0".equals(globalPaiedBean.getRmb())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalPaiedBean.getNcdeptno())||"null".equals(globalPaiedBean.getNcdeptno())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				
				if("".equals(globalPaiedBean.getBcode())||"null".equals(globalPaiedBean.getBcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"传输失败！-人员编码为空(项目经理)");
					continue;
				}
				if("".equals(globalPaiedBean.getAcode())||"null".equals(globalPaiedBean.getAcode())){
					writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,"银行账户为空");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				try {
					//组装xml字符串
					xmlMassage = FinancialPaiedXml.getXmlStr(globalPaiedBean);
					//请求nc服务端
				    xmlStr=erfs.requst_Nc_Finance("0101","F3",xmlMassage);
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalPaiedBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalPaiedBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-付款单接口", "XML如下:"+xmlMassage,"付款单NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// 记录同步失败数据信息
								writeDataSyncDBInfo2(globalPaiedBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalPaiedBean.getPriId());
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-付款单接口", "XML如下:"+xmlMassage,"付款单NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
				
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，成功["
					+ i + "]条"+",失败["+(globalPaiedList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalPaiedList.size()-i)+"]条"));
			
		}
	}
}
