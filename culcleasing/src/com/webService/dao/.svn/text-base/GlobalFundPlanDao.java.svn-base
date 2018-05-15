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
import com.webService.bean.GlobalFundPlanBean;

import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.FundPaymentPlanXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;





/**
 * 资金收付计划 Dao 操作
 * 
 * @author toybaby Date:Sep 15, 20116:38:46 PM Email: toybaby@mail2.tenwa.com.cn
 */
public class GlobalFundPlanDao {

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
				amount, "DATA_SYNC_GLOBAL_FUNDPLAN_NC", "NC资金收付计划表财务接口数据同步", operRmark);

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
	private void writeDataSyncDBInfo2(
			GlobalFundPlanBean globalFundPlanBean, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		ifsuccess = ifsuccess.replaceAll("'", "''");
		String sqlStr = "";
		
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalFundPlanBean.getPriId(), globalFundPlanBean
							.getPara_2(), globalFundPlanBean.getPara_3(),
					globalFundPlanBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_fundplan_nc");

			// 执行操作
			erpDataSource.executeUpdate(sqlStr);
		
		erpDataSource.close();
	}

	/**
	 * 读取ERP 资金收付计划表数据
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalFundPlanBean> readGlobalFundPlanData(String syncType)
			throws SQLException {
		List<GlobalFundPlanBean> globalFundPlanList = new ArrayList<GlobalFundPlanBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalFundPlanData1();
		LogWriter.logSqlStr("读取ERP批量资金收付计划表信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalFundPlanBean globalFundPlanBean = new GlobalFundPlanBean();
			// 装载属性
			globalFundPlanBean.setPriId(ConvertUtil
					.getDBStr(rs.getString("id")));
			globalFundPlanBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalFundPlanBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalFundPlanBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalFundPlanBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalFundPlanBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalFundPlanBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalFundPlanBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalFundPlanBean.setTenancytype(ConvertUtil.getDBStr(rs
					.getString("tenancytype")));
			globalFundPlanBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalFundPlanBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalFundPlanBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalFundPlanBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalFundPlanBean.setChangesign(ConvertUtil.getDBStr(rs
					.getString("changesign")));
			globalFundPlanBean.setOdate(ConvertUtil.getDBStr(rs
					.getString("odate")));
			globalFundPlanBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalFundPlanBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalFundPlanBean
					.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalFundPlanBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalFundPlanBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalFundPlanBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalFundPlanBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			
			globalFundPlanBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));
					
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalFundPlanBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalFundPlanBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			globalFundPlanBean.setAcode(ConvertUtil.getDBStr(rs
					.getString("acode")));
			// 装载到大List
			globalFundPlanList.add(globalFundPlanBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalFundPlanBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalFundPlanList;
	}

	/**
	 * 插入数据到财务接口Oracle数据库
	 * 资金收付款计划表
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalFundPlanBean> globalFundPlantList,
			String syncType) throws Exception {
		if(globalFundPlantList.size()<1){
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		}else{
			String oper_id=CommonTool.getUUID();//操作Id
			int i=0;
			FundPaymentPlanXml  fundPaymentPlanXml=new FundPaymentPlanXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer server=new RequestNcServer();
			//1遍历所有的List数据
			for(GlobalFundPlanBean globalFundPlanBean:globalFundPlantList ){
				//判断是否有nc编码
				if("".equals(globalFundPlanBean.getNccode())||globalFundPlanBean.getNccode()==null||"null".equals(globalFundPlanBean.getNccode())){
					writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				if("".equals(globalFundPlanBean.getCcode())||globalFundPlanBean.getCcode()==null||"null".equals(globalFundPlanBean.getCcode())){
					writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,"传输失败！-收款人编码为空");
					continue;
				}
				if("0.00".equals(globalFundPlanBean.getRmb())||"0".equals(globalFundPlanBean.getRmb())){
					writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalFundPlanBean.getNcdeptno())||globalFundPlanBean.getNcdeptno()==null||"null".equals(globalFundPlanBean.getNcdeptno())){
					writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				
				String xmlMassage=null;
				String xmlStr=null;
				String ifsuccess="-1";
				String errorMsg="";
				boolean key=true;
				try {										
					xmlMassage=fundPaymentPlanXml.getXmlStr(globalFundPlanBean);
					//请求nc服务器
					xmlStr=server.requst_Nc_Finance("0101", "F3", xmlMassage);
					System.out.println("xmlStr:"+xmlStr);
					ifsuccess=xmlanalysis.getMsg(xmlStr);
					System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,e.getMessage()==null?"java.lang.NullPointerException":e.getMessage());	
					} catch (Exception e2) {
						e2.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e2.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalFundPlanBean.getPriId());
					
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							i++;
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-资金收付款单接口", "XML如下:"+xmlMassage,"资金收付款单NC数据同步日志");			
							// 记录同步成功数据信息
							writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,ifsuccess);
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalFundPlanBean.getPriId());

						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-资金收付款单接口", "XML如下:"+xmlMassage,"资金收付款单NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								//记录同步失败数据信息
								writeDataSyncDBInfo2(globalFundPlanBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								// TODO: handle exception
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalFundPlanBean.getPriId());
							
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-资金收付款单接口", "XML如下:"+xmlMassage,"资金收付款单NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，插入数据["
					+ i + "]条"+",失败["+(globalFundPlantList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，插入数据["+ i + "]条"+",失败["+(globalFundPlantList.size()-i)+"]条"));
			
			
		}
		
	}


}
