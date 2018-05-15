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
import com.webService.bean.GlobalStartRentBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.GlobalStartRentXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;



/**
 * 起租 Dao 操作
 * 
 * @author Jaffe
 * 
 * Date:Sep 12, 2011 6:42:30 PM Email:JaffeHe@hotmail.com
 */
public class GlobalStartRentDao {

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
				amount, "DATA_SYNC_GLOBAL_START_RENT_NC", "NC起租财务接口数据同步", operRmark);

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
			GlobalStartRentBean globalStartRentBean, String oper_id,
			String syncType,String ifsuccess) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalStartRentBean.getPriId(), globalStartRentBean
							.getPara_2(), globalStartRentBean.getPara_3(),
					globalStartRentBean.getPara_4(),ifsuccess, oper_id,
					"vi_INTERFACE_fina_global_rent_start_rent_nc");

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
	public List<GlobalStartRentBean> readGlobalStartRentData(String syncType)
			throws SQLException {
		List<GlobalStartRentBean> globalStartRentList = new ArrayList<GlobalStartRentBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalStartRentData1();
		LogWriter.logSqlStr("读取ERP批量起租信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalStartRentBean globalStartRentBean = new GlobalStartRentBean();
			// 装载属性
			globalStartRentBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalStartRentBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalStartRentBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalStartRentBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalStartRentBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalStartRentBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalStartRentBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));
			globalStartRentBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalStartRentBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalStartRentBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));
			globalStartRentBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalStartRentBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalStartRentBean.setChangesign(ConvertUtil.getDBStr(rs
					.getString("changesign")));
			globalStartRentBean.setOdate(ConvertUtil.getDBDateStr(rs
					.getString("odate")));
			globalStartRentBean.setModifydate(ConvertUtil.getDBDateStr(rs
					.getString("modifydate")));
			globalStartRentBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalStartRentBean.setRmb(ConvertUtil
					.getDBStr(rs.getString("rmb")));
			globalStartRentBean.setStartrentscode(ConvertUtil.getDBStr(rs
					.getString("startrentscode")));
			globalStartRentBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalStartRentBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalStartRentBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalStartRentBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			globalStartRentBean.setRemark_2(ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalStartRentBean.setNccode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalStartRentBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));

			// 装载到大List
			globalStartRentList.add(globalStartRentBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalStartRentBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalStartRentList;
	}

	/**
	 * 插入数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(
			List<GlobalStartRentBean> globalStartRentList, String syncType)
			throws Exception {
		if(globalStartRentList.size()<1){
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");
		}else{
			String oper_id=CommonTool.getUUID();//操作Id
			int i=0;
			GlobalStartRentXml globalStartRentXml=new GlobalStartRentXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer ncserver=new RequestNcServer();
			//遍历所有list
			for(GlobalStartRentBean globalStartRentBean:globalStartRentList){
				//判断是否有nc编码
				if("".equals(globalStartRentBean.getNccode())||globalStartRentBean.getNccode()==null || "null".equals(globalStartRentBean.getNccode()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					continue;
				}
				if("0.00".equals(globalStartRentBean.getRmb())|| "0".equals(globalStartRentBean.getRmb()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"传输失败！-金额为零");
					continue;
				}
				if("".equals(globalStartRentBean.getNcdeptno())||globalStartRentBean.getNcdeptno()==null || "null".equals(globalStartRentBean.getNcdeptno()) ){
					writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue;
				}
				String xmlMassage=null;
				String xmlStr=null;
				String ifsuccess="-1";
				String errorMsg="";
				boolean key=true;
				
				try {
					xmlMassage=globalStartRentXml.getXmlStr(globalStartRentBean);
					xmlStr=ncserver.requst_Nc_Finance("010101", "F0", xmlMassage);
					System.out.println("xmlStr:"+xmlStr);
					ifsuccess= xmlanalysis.getMsg(xmlStr);
					System.out.println("ifsuccess"+ifsuccess);

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					try{
						writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,e.getMessage()==null?"java.lang.NullPointerException":e.getMessage());	

					}catch(Exception e2){
						e2.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e2.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalStartRentBean.getPriId());
						
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
						try {
							i++;
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-起租(应收)单接口", "XML如下:"+xmlMassage,"起租(应收)单NC数据同步日志");			
							// 记录同步成功数据信息
							writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,ifsuccess);
						} catch (Exception e2) {
							// TODO: handle exception
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalStartRentBean.getPriId());
						}
						try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-起租(应收)单接口", "XML如下:"+xmlMassage,"起租(应收)单接口NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								writeDataSyncDBInfo(globalStartRentBean, oper_id, syncType,ifsuccess);
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalStartRentBean.getPriId());
				
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-起租(应收)单接口", "XML如下:"+xmlMassage,"起租(应收)单接口NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
		
		LogWriter.logDebug("本次执行[" + syncType + "]数据同步，插入数据["
				+ i + "]条"+",失败["+(globalStartRentList.size()-i)+"]条");
		// 数据库日志
		writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，插入数据["+ i + "]条"+",失败["+(globalStartRentList.size()-i)+"]条"));
		
		
	}

	}

}
