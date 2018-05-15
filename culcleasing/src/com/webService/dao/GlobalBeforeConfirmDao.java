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
import com.webService.bean.GlobalBeforeConfirmBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
import com.webService.service.GlobalBeforeComfirmXml;
import com.webService.service.GlobalReceiveXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;

/**
 * 国内收款单 Dao 操作
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:42:30 PM Email:JaffeHe@hotmail.com
 */
public class GlobalBeforeConfirmDao {

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
				amount, "DATA_SYNC_GLOBAL_BEFORE_CONFIRM_NC", "提前终止合同收款单数据同步", operRmark);

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
	private void writeDataSyncDBInfo(GlobalBeforeConfirmBean globalBeforeConfirmBean,
			String oper_id, String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark = operRmark.replaceAll("'", "''");
		String sqlStr = "";
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalBeforeConfirmBean.getPriId(),
					globalBeforeConfirmBean.getPara_2(), 
					globalBeforeConfirmBean.getPara_3(),
					globalBeforeConfirmBean.getPara_4(),
					operRmark,
					oper_id, 
					"vi_INTERFACE_before_confirm_nc"
					);

			// 执行操作
			System.out.println("执行sql："+sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		erpDataSource.close();
	}

	/**
	 * 读取ERP 国内收款单数据
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalBeforeConfirmBean> readGlobalBeforeConfirmData(String syncType)
			throws SQLException {
		List<GlobalBeforeConfirmBean> globalBeforeConfirmList = new ArrayList<GlobalBeforeConfirmBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPBeforeConfirmData();
		LogWriter.logSqlStr("读取ERP批量国内收款单", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalBeforeConfirmBean globalBeforeConfirmBean = new GlobalBeforeConfirmBean();
			// 装载属性
			globalBeforeConfirmBean.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalBeforeConfirmBean.setInvcode(ConvertUtil.getDBStr(rs.getString("invcode")));//单据号
			globalBeforeConfirmBean.setCcodetrust(ConvertUtil.getDBStr(rs.getString("ccodetrust")));//承租客户
			globalBeforeConfirmBean.setBcode(ConvertUtil.getDBStr(rs.getString("bcode")));//项目经理
			globalBeforeConfirmBean.setReceive_account(ConvertUtil.getDBStr(rs.getString("receipt_number")));//收款账户
			globalBeforeConfirmBean.setPayer(ConvertUtil.getDBStr(rs.getString("ccodetrust")));//付款人
			globalBeforeConfirmBean.setContract_id(ConvertUtil.getDBStr(rs.getString("contract_id")));//合同号
			globalBeforeConfirmBean.setProj_code(ConvertUtil.getDBStr(rs.getString("proj_id")));//项目编号
			globalBeforeConfirmBean.setProj_name(ConvertUtil.getDBStr(rs.getString("project_name")));//项目名称
			globalBeforeConfirmBean.setIndustry(ConvertUtil.getDBStr(rs.getString("industry_type")));//内部行业
			globalBeforeConfirmBean.setLeas_type(ConvertUtil.getDBStr(rs.getString("leas_type")));//租赁类型
			globalBeforeConfirmBean.setRemark_2(ConvertUtil.getDBStr(rs.getString("taxrate")));//税率
			globalBeforeConfirmBean.setAction_date(ConvertUtil.getDBStr(rs.getString("action_date")));//实际到账日期
			globalBeforeConfirmBean.setRent(ConvertUtil.getDBStr(rs.getString("rent")));//租金
			globalBeforeConfirmBean.setGuarantee_money(ConvertUtil.getDBStr(rs.getString("guarantee_money")));//保证金
			globalBeforeConfirmBean.setPenalty(ConvertUtil.getDBStr(rs.getString("agree_penalty")));//罚息
			globalBeforeConfirmBean.setNormal_money(ConvertUtil.getDBStr(rs.getString("nominal_price")));//留购价格（又叫残值收入）
			globalBeforeConfirmBean.setAction_money(ConvertUtil.getDBStr(rs.getString("action_money")));//项目结清款
			globalBeforeConfirmBean.setRent_cha(ConvertUtil.getDBStr(rs.getString("rentcha")));//租金差额
			globalBeforeConfirmBean.setInteret_cha(ConvertUtil.getDBStr(rs.getString("rentcha")));//利息差额
			globalBeforeConfirmBean.setInterest_sr(ConvertUtil.getDBStr(rs.getString("interestsr")));//利息收入
			globalBeforeConfirmBean.setNcdeptno(ConvertUtil.getDBStr(rs.getString("nc_deptno")));//部门编码
			globalBeforeConfirmBean.setRemark_o(ConvertUtil.getDBStr(rs.getString("remark_o")));//税种			
			globalBeforeConfirmBean.setRent_diff(ConvertUtil.getDBStr(rs.getString("rent_diff")));//多到租金或者少到租金
		    //下面是款项内容
			// 装载到大List
			globalBeforeConfirmList.add(globalBeforeConfirmBean);
			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalBeforeConfirmBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalBeforeConfirmList;
	}

	/**
	 * 传输到财务接口国内收款单
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalBeforeConfirmBean> globalBeforeConfirmList,
			String syncType) throws Exception {
		if (globalBeforeConfirmList.size() < 1) {
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id

			int i=0;
			GlobalBeforeComfirmXml globalBeforeComfirmXml = new GlobalBeforeComfirmXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			for (GlobalBeforeConfirmBean globalBeforeConfirmBean : globalBeforeConfirmList) {
				
				if("".equals(globalBeforeConfirmBean.getBcode())||globalBeforeConfirmBean.getBcode()==null||"null".equals(globalBeforeConfirmBean.getBcode())){
					writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}				
			
				if("".equals(globalBeforeConfirmBean.getNcdeptno())||globalBeforeConfirmBean.getNcdeptno()==null||"null".equals(globalBeforeConfirmBean.getNcdeptno())){
					writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				//组装xml字符串
				try {
					xmlMassage = globalBeforeComfirmXml.getXmlStr(globalBeforeConfirmBean);
					//请求nc服务端
				   xmlStr=erfs.requst_Nc_Finance("010101","F2",xmlMassage);//=================================================先测试
				    ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalBeforeConfirmBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalBeforeConfirmBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口-国内收款单接口", "XML如下:"+xmlMassage,"国内收款单NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								// 记录同步失败数据信息
								writeDataSyncDBInfo(globalBeforeConfirmBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalBeforeConfirmBean.getPriId());
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口-国内收款单接口", "XML如下:"+xmlMassage,"国内收款单NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，插入数据["
					+ i + "]条"+",失败["+(globalBeforeConfirmList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalBeforeConfirmList.size()-i)+"]条"));
		}
	}
}
