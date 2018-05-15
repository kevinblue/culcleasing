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
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalInterestBean;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.GlobalInterestXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;


/**
 * 利息计算表 Dao 操作
 * 
 * @author toybaby Date:Sep 15, 20114:18:09 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalInterestDao {

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
				amount, "DATA_SYNC_GLOBAL_INTEREST_NC", "NC利息计算表财务接口数据同步",operRmark);

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
	@SuppressWarnings("unused")
	private void writeDataSyncDBInfo(
			GlobalInterestBean globalInterestRent, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
		// 1.遍历所有List数据
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalInterestRent.getPriId(), globalInterestRent
							.getPara_2(), globalInterestRent.getPara_3(),
							globalInterestRent.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_interest");

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
	public List<GlobalInterestBean> readGlobalInterestData(String syncType)
			throws SQLException {
		List<GlobalInterestBean> globalInterestList = new ArrayList<GlobalInterestBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalInterestData();
		LogWriter.logSqlStr("读取ERP批量利息计算表信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalInterestBean globalInterestBean = new GlobalInterestBean();
			// 获得流水号
			// String SerialNumber = OperationUtil.getSerialNumber("起租", "0001",
			// 4);
			// 装载属性
			globalInterestBean.setPriId(ConvertUtil
					.getDBStr(rs.getString("id")));
			globalInterestBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalInterestBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalInterestBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalInterestBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalInterestBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalInterestBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalInterestBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalInterestBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalInterestBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalInterestBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalInterestBean.setInvyear(ConvertUtil.getDBStr(rs
					.getString("invyear")));
			globalInterestBean.setInvmonth(ConvertUtil.getDBStr(rs
					.getString("invmonth")));
			globalInterestBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalInterestBean
					.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalInterestBean.setInvyear_month(ConvertUtil.getDBStr(rs
					.getString("invyear_month")));
			globalInterestBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalInterestBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalInterestBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalInterestBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalInterestBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			
			globalInterestBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			
			globalInterestBean.setOdate(ConvertUtil.getDBStr(rs
					.getString("odate")));
			globalInterestBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));


			// 装载到大List
			globalInterestList.add(globalInterestBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalInterestBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalInterestList;
	}

	/**
	 * 插入数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalInterestBean> globalInterestList,
			String syncType) throws Exception {
		if (globalInterestList.size() < 1) {
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id
			int i=0;
			GlobalInterestXml globalinterestxml = new GlobalInterestXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			for (GlobalInterestBean globalInterestBean : globalInterestList) {
				if("".equals(globalInterestBean.getNccode())||globalInterestBean.getNccode()==null||"null".equals(globalInterestBean.getNccode())){
					writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}				
				if("0.00".equals(globalInterestBean.getRmb())||"0".equals(globalInterestBean.getRmb())){
					writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalInterestBean.getNcdeptno())||globalInterestBean.getNcdeptno()==null||"null".equals(globalInterestBean.getNcdeptno())){
					writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				String number = OperationUtil.getSerialNumber(syncType, "0001",
						4);
				globalInterestBean.setInvcode(globalInterestBean.getInvcode()
						+ number);
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				try {
					//组装xml字符串
					xmlMassage = globalinterestxml.getXmlStr(globalInterestBean);
					//请求nc服务端
				    xmlStr=erfs.requst_Nc_Finance("0101","F0",xmlMassage);
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalInterestBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalInterestBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-利息计算表（应收）接口", "XML如下:"+xmlMassage,"利息计算表（应收）NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// 记录同步失败数据信息
								writeDataSyncDBInfo(globalInterestBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalInterestBean.getPriId());
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-利息计算表（应收）接口", "XML如下:"+xmlMassage,"利息计算表（应收）NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
			   }
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，成功["
					+ i + "]条"+",失败["+(globalInterestList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalInterestList.size()-i)+"]条"));
	 }
  }
}
