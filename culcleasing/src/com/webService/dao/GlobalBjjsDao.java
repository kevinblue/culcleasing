/**
 * com.tenwa.datasync.finance.dao
 */
package com.webService.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.OperationUtil;
import com.tenwa.log.LogWriter;
import com.webService.bean.GlobalBjjsBean;
import com.webService.bean.GlobalInterestBean;
import com.webService.bean.OracleDataSource;

import com.webService.service.GlobalBjjsXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;



/**
 * 利息计算表 Dao 操作
 * 
 * @author toybaby Date:Sep 15, 20114:18:09 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalBjjsDao {

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
						amount, "DATA_SYNC_GLOBAL_BJJS_NC", "NC利息计算表财务接口数据同步",operRmark);
				
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
			GlobalBjjsBean globalBjjsBean, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
		// 1.遍历所有List数据
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalBjjsBean.getPriId(), globalBjjsBean
							.getPara_2(), globalBjjsBean.getPara_3(),
							globalBjjsBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_bjjs_nc");

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
	public List<GlobalBjjsBean> readGlobalBjjsData(String syncType,String sqlIds)
			throws SQLException {
		List<GlobalBjjsBean> globalBjjsList = new ArrayList<GlobalBjjsBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalBjjsDataNc(sqlIds);
		LogWriter.logSqlStr("读取ERP批量本金计税表信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalBjjsBean globalBjjsBean = new GlobalBjjsBean();
			// 获得流水号
			// String SerialNumber = OperationUtil.getSerialNumber("起租", "0001",
			// 4);
			// 装载属性
			globalBjjsBean.setPriId(ConvertUtil
					.getDBStr(rs.getString("id")));
			globalBjjsBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalBjjsBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalBjjsBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalBjjsBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalBjjsBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalBjjsBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalBjjsBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalBjjsBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalBjjsBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalBjjsBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalBjjsBean.setInvyear(ConvertUtil.getDBStr(rs
					.getString("invyear")));
			globalBjjsBean.setInvmonth(ConvertUtil.getDBStr(rs
					.getString("invmonth")));
			globalBjjsBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalBjjsBean
					.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalBjjsBean.setInvyear_month(ConvertUtil.getDBStr(rs
					.getString("invyear_month")));
			globalBjjsBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalBjjsBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalBjjsBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalBjjsBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalBjjsBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));			
			globalBjjsBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalBjjsBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));

			// 装载到大List
			globalBjjsList.add(globalBjjsBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalBjjsBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		System.out.println("test==="+globalBjjsList.size());
		return globalBjjsList;
	}

	/**
	 * 插入数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws SQLException
	 */
	public Map<String,Integer> insert2OracleData(List<GlobalBjjsBean> globalBjjsList,
			String syncType) throws Exception {
		int i=0;
		Map<String,Integer> amount=new HashMap<String,Integer>();    
		if (globalBjjsList.size() < 1) {
			i=globalBjjsList.size();//i=0;
			amount.put("success", i);
			amount.put("fail", 0);
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id
			 i=0;
			GlobalBjjsXml globalBjjsXml = new GlobalBjjsXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			System.out.println("=============入口3==================");		
			for (GlobalBjjsBean globalBjjsBean : globalBjjsList) {
				if("".equals(globalBjjsBean.getNccode())||globalBjjsBean.getNccode()==null||"null".equals(globalBjjsBean.getNccode())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				
				if("0.00".equals(globalBjjsBean.getRmb())||"0".equals(globalBjjsBean.getRmb())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalBjjsBean.getNcdeptno())||globalBjjsBean.getNcdeptno()==null||"null".equals(globalBjjsBean.getNcdeptno())){
					writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				String number = "";
				try {
					System.out.println("=============入口3-1==================");	
					 number = OperationUtil.getSerialNumber(syncType, "0001",4);
					 System.out.println("=============入口3-2==================");	
				} catch (Exception e) {
					throw new Exception("序列号错误");

				}
				globalBjjsBean.setInvcode(globalBjjsBean.getInvcode()
						+ number);
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				try{
					
				try {
					//组装xml字符串
					xmlMassage = globalBjjsXml.getXmlStr(globalBjjsBean);
					//请求nc服务端
					System.out.println("=============入口4==================");		
				    xmlStr=erfs.requst_Nc_Finance("010101","F0",xmlMassage);
				    System.out.println("=============入口4-----------:"+xmlStr+"==================");		
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalBjjsBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalBjjsBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-利本金计税表（应收）接口", "XML如下:"+xmlMassage,"本金计税表（应收）NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// 记录同步失败数据信息
								writeDataSyncDBInfo(globalBjjsBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalBjjsBean.getPriId());
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-本金计税表（应收）接口", "XML如下:"+xmlMassage,"本金计税表（应收）NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
			   }
				} catch (Exception e) {
					throw new Exception("序列号错误1111");

				}
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，成功["
					+ i + "]条"+",失败["+(globalBjjsList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalBjjsList.size()-i)+"]条"));
			amount.put("success", i);
			amount.put("fail",globalBjjsList.size()-i);
		}
		
		return amount;
	}

	

}
