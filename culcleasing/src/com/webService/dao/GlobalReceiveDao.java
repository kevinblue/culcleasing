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
import com.webService.bean.GlobalReceiveBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.FinancialPaiedXml;
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
public class GlobalReceiveDao {

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
				amount, "DATA_SYNC_GLOBAL_RECEIVE", "nc国内收款单财务接口数据同步", operRmark);

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
	private void writeDataSyncDBInfo(GlobalReceiveBean globalReceiveBean,
			String oper_id, String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark = operRmark.replaceAll("'", "''");
		String sqlStr = "";
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalReceiveBean.getPriId(),
					globalReceiveBean.getPara_2(), 
					globalReceiveBean.getPara_3(),
					globalReceiveBean.getPara_4(),
					operRmark,
					oper_id, 
					"vi_INTERFACE_fina_global_receive_nc"
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
	public List<GlobalReceiveBean> readGlobalReceiveData(String syncType)
			throws SQLException {
		List<GlobalReceiveBean> globalReceiveList = new ArrayList<GlobalReceiveBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil.generateSelectERPGlobalReceiveData();
		LogWriter.logSqlStr("读取ERP提前终止合同收款单", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalReceiveBean globalReceiveBean = new GlobalReceiveBean();
			// 装载属性

			globalReceiveBean
					.setPriId(ConvertUtil.getDBStr(rs.getString("id")));
			globalReceiveBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalReceiveBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalReceiveBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			// ConvertUtil.getDBStr("")
			globalReceiveBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			globalReceiveBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalReceiveBean.setAcode(ConvertUtil.getDBStr(rs
					.getString("acode")));
			globalReceiveBean.setOdate(ConvertUtil.getDBStr(rs
					.getString("odate")));
			globalReceiveBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalReceiveBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalReceiveBean.setRmb(ConvertUtil.getDBStr(rs.getString("rmb")));
			globalReceiveBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalReceiveBean.setOffset(ConvertUtil.getDBStr(rs
					.getString("offset")));
			globalReceiveBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));			
			globalReceiveBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalReceiveBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalReceiveBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalReceiveBean.setPawnsign(ConvertUtil.getDBStr(rs
					.getString("pawnsign")));
			globalReceiveBean.setPawnrmb(ConvertUtil.getDBStr(rs
					.getString("pawnrmb")));
			globalReceiveBean.setPawncode(ConvertUtil.getDBStr(rs
					.getString("pawncode")));
			globalReceiveBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalReceiveBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalReceiveBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalReceiveBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			System.out.println("invtype:"+ConvertUtil.getDBStr(rs
					.getString("invtype")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			//851，853，8851,8852,8853,8723,8721，8722,897,898,899,885,872
			if("872".equals(invtype)||"8721".equals(invtype)||"8722".equals(invtype)||"8723".equals(invtype)||"893".equals(invtype)
			||"894".equals(invtype)||"895".equals(invtype)||"897".equals(invtype)||"898".equals(invtype)||"899".equals(invtype)
			||"8851".equals(invtype)||"8852".equals(invtype)||"8853".equals(invtype)||"853".equals(invtype)			
			||"851".equals(invtype)){
				globalReceiveBean.setRemark_2("0.06");
			}else if("871".equals(invtype)||"873".equals(invtype)){ //设计的是首付款 、预付款利息（租前息）
				globalReceiveBean.setRemark_2("0.17");
			}else{
				globalReceiveBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));
			}
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalReceiveBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalReceiveBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			globalReceiveBean.setSparecolumn_a(ConvertUtil.getDBStr(rs
					.getString("sparecolumn_a")));
			globalReceiveBean.setSparecolumn_b(ConvertUtil.getDBStr(rs
					.getString("sparecolumn_b")));
			// 装载到大List
			globalReceiveList.add(globalReceiveBean);
			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalReceiveBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalReceiveList;
	}

	/**
	 * 传输到财务接口国内收款单
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(List<GlobalReceiveBean> globalReceiveList,
			String syncType) throws Exception {
		if (globalReceiveList.size() < 1) {
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		} else {
			String oper_id = CommonTool.getUUID();// 操作Id

			int i=0;
			GlobalReceiveXml globalreceivexml = new GlobalReceiveXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer erfs=new RequestNcServer();
			// 1.遍历所有List数据
			for (GlobalReceiveBean globalReceiveBean : globalReceiveList) {
				if("".equals(globalReceiveBean.getNccode())||globalReceiveBean.getNccode()==null||"null".equals(globalReceiveBean.getNccode())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				if("0.00".equals(globalReceiveBean.getRmb())||"0".equals(globalReceiveBean.getRmb())||"0.0000".equals(globalReceiveBean.getRmb())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				
				if("".equals(globalReceiveBean.getNcdeptno())||globalReceiveBean.getNcdeptno()==null||"null".equals(globalReceiveBean.getNcdeptno())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				if("".equals(globalReceiveBean.getAcode())||globalReceiveBean.getAcode()==null||"null".equals(globalReceiveBean.getAcode())){
					writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,"传输失败！-银行账户为空");
					continue;
				}
				String xmlMassage = null;
				String xmlStr=null;
				String ifsuccess = "-1";
				String erroMsg = "";
				boolean key = true;
				//组装xml字符串
				try {
					xmlMassage = globalreceivexml.getXmlStr(globalReceiveBean);
					//请求nc服务端
				   xmlStr=erfs.requst_Nc_Finance("010101","F2",xmlMassage);//=================================================先测试
				   System.out.println("xmlStr::::;;;;"+xmlStr); 
				   System.out.println("_-------------------------------"); 
				   ifsuccess =  xmlanalysis.getMsg(xmlStr);
				    System.out.println(ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
					} catch (Exception e2) {
						e.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalReceiveBean.getPriId());
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,ifsuccess);
							i++;
						} catch (Exception e2) {
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalReceiveBean.getPriId());
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
								writeDataSyncDBInfo(globalReceiveBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalReceiveBean.getPriId());
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
					+ i + "]条"+",失败["+(globalReceiveList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，成功["+ i + "]条"+",失败["+(globalReceiveList.size()-i)+"]条"));
		}
	}
}
