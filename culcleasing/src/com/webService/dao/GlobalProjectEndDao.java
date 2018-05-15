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
import com.webService.bean.GlobalProjectEndBean;
import com.webService.bean.OracleDataSource;
import com.webService.service.GlobalProjectEndXml;
import com.webService.service.RequestNcServer;
import com.webService.service.SqlGenerateFIUtil;
import com.webService.service.XmlAnalysis;


public class GlobalProjectEndDao {

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
				amount, "DATA_SYNC_GLOBAL_PROJECTEND_NC", "nc合同结清接口数据同步", operRmark);
		LogWriter.logDebug("writeDataSyncDBLog" + sqlStr);

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
			GlobalProjectEndBean globalProjectEndBean, String oper_id,
			String syncType,String operRmark) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		operRmark=operRmark.replaceAll("'", "''");
		String sqlStr = "";
		
			// 插入
			sqlStr = SqlGenerateFIUtil.generateFIDataSyncDBInfo(
					globalProjectEndBean.getPriId(), globalProjectEndBean
							.getPara_2(), globalProjectEndBean.getPara_3(),
					globalProjectEndBean.getPara_4(),
					operRmark,
					oper_id,
					"vi_INTERFACE_fina_global_htjq_nc" );
			// LogWriter.logDebug("writeDataSyncDBInfo" + sqlStr);

			// 执行操作
			erpDataSource.executeUpdate(sqlStr);
		
		erpDataSource.close();
	}

	/**
	 * 读取ERP 合同结清表数据
	 * 
	 * @param syncType
	 * @return
	 * @throws SQLException
	 */
	public List<GlobalProjectEndBean> readGlobalInterestSubsidy(String syncType)
			throws SQLException {
		List<GlobalProjectEndBean> globalProjectEndBeanList = new ArrayList<GlobalProjectEndBean>();
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.查询Client1数据库
		String sqlStr = SqlGenerateFIUtil
				.generateSelectERPGlobalProjectEndData1();
		LogWriter.logSqlStr("读取ERP合同结清表信息", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		// 3.装载到List
		while (rs.next()) {
			GlobalProjectEndBean globalProjectEndBean = new GlobalProjectEndBean();
			// 装载属性
			globalProjectEndBean.setId(rs.getInt("id"));
			globalProjectEndBean.setPriId(ConvertUtil.getDBStr(rs
					.getString("id")));
			globalProjectEndBean.setPara_4(ConvertUtil.getDBStr(rs
					.getString("para_4")));
			globalProjectEndBean.setPara_2(ConvertUtil.getDBStr(rs
					.getString("para_2")));
			globalProjectEndBean.setPara_3(ConvertUtil.getDBStr(rs
					.getString("para_3")));
			globalProjectEndBean.setInvcode(ConvertUtil.getDBStr(rs
					.getString("invcode")));
			// ConvertUtil.getDBStr("")
			globalProjectEndBean.setCcodetrust(ConvertUtil.getDBStr(rs
					.getString("ccodetrust")));
			globalProjectEndBean.setBcode(ConvertUtil.getDBStr(rs
					.getString("bcode")));
			globalProjectEndBean.setAcode(ConvertUtil.getDBStr(rs
					.getString("acode")));
			globalProjectEndBean.setOdate(ConvertUtil.getDBDateStr(rs
					.getString("odate")));
			globalProjectEndBean.setCcode(ConvertUtil.getDBStr(rs
					.getString("ccode")));

			globalProjectEndBean.setRemark(ConvertUtil.getDBStr(rs
					.getString("remark")));
			globalProjectEndBean.setRmb(ConvertUtil.getDBStr(rs
					.getString("rmb")));

			globalProjectEndBean.setModifydate(ConvertUtil.getDBStr(rs
					.getString("modifydate")));
			globalProjectEndBean.setInvtype(ConvertUtil.getDBStr(rs
					.getString("invtype")));
			globalProjectEndBean.setOrdcode(ConvertUtil.getDBStr(rs
					.getString("ordcode")));
			globalProjectEndBean.setPicode(ConvertUtil.getDBStr(rs
					.getString("picode")));
			globalProjectEndBean.setPcode(ConvertUtil.getDBStr(rs
					.getString("pcode")));

			globalProjectEndBean.setRemark_o(ConvertUtil.getDBStr(rs
					.getString("remark_o")));
			globalProjectEndBean.setIndustry(ConvertUtil.getDBStr(rs
					.getString("industry")));
			globalProjectEndBean.setLeas_type(ConvertUtil.getDBStr(rs
					.getString("leas_type")));
			globalProjectEndBean.setRemark_1(ConvertUtil.getDBStr(rs
					.getString("remark_1")));
			String invtype=ConvertUtil.getDBStr(rs
					.getString("invtype"));
			System.out.println("invtype:"+invtype);
			if("872".equals(invtype)||"8721".equals(invtype)||"8722".equals(invtype)||"8723".equals(invtype)||"893".equals(invtype)
					||"894".equals(invtype)||"895".equals(invtype)||"897".equals(invtype)||"898".equals(invtype)||"899".equals(invtype)
					||"8851".equals(invtype)||"8852".equals(invtype)||"8853".equals(invtype)||"853".equals(invtype)			
					||"851".equals(invtype)){
				globalProjectEndBean.setRemark_2("0.06");
			}else{
				globalProjectEndBean.setRemark_2(ConvertUtil.getDBStr(rs
						.getString("remark_2")));
			}			
			System.out.println("remark_2:"+ConvertUtil.getDBStr(rs
					.getString("remark_2")));
			globalProjectEndBean.setNcode(ConvertUtil.getDBStr(rs
					.getString("nccode")));
			globalProjectEndBean.setNcdeptno(ConvertUtil.getDBStr(rs
					.getString("nc_deptno")));
			// 装载到大List
			globalProjectEndBeanList.add(globalProjectEndBean);

			LogWriter.logDebug("加载[" + syncType + "]，单据号："
					+ globalProjectEndBean.getInvcode());
		}
		// 4.关闭资源
		erpDataSource.close();

		// 5.返回
		return globalProjectEndBeanList;
	}

	/**
	 * 插入数据到财务接口Oracle数据库
	 * 
	 * @param globalReceiveList
	 * @param syncType
	 * @throws Exception 
	 */
	public void insert2OracleData(
			List<GlobalProjectEndBean> globalProjectEndList, String syncType)
			throws Exception {
		if(globalProjectEndList.size()<1){
			LogWriter.logDebug("当前没有[" + syncType + "]数据需要同步");			
		}else{
			String oper_id=CommonTool.getUUID();//操作Id
			int i=0;
			GlobalProjectEndXml globalProjectEndXml=new GlobalProjectEndXml();
			XmlAnalysis xmlanalysis = new XmlAnalysis();
			RequestNcServer ncserver=new RequestNcServer();
			for(GlobalProjectEndBean globalProjectEndBean  :globalProjectEndList){
               //判断是够有nc编码
				if("".equals(globalProjectEndBean.getNcode())||globalProjectEndBean.getNcode()==null||"null".equals(globalProjectEndBean.getNcode())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"传输失败！-NC客商编码为空");
					System.out.println("nccode:"+globalProjectEndBean.getNcode());
					continue; 
               }
				if("0.00".equals(globalProjectEndBean.getRmb())||"0".equals(globalProjectEndBean.getRmb())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"传输失败！-金额为空");
					continue; 
               }
				if("".equals(globalProjectEndBean.getNcdeptno())||globalProjectEndBean.getNcdeptno()==null||"null".equals(globalProjectEndBean.getNcdeptno())){
					writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,"传输失败！-NC部门编码为空");
					continue; 
               }
				System.out.println("nccode:============================="+globalProjectEndBean.getNcode());
				String xmlMassage=null;
				String xmlStr=null;
				String ifsuccess="-1";
				String errorMsg="";
				boolean key=true;
				try {
					xmlMassage=	globalProjectEndXml.getXmlStr(globalProjectEndBean);
					xmlStr=	ncserver.requst_Nc_Finance("010101", "F2", xmlMassage);
					System.out.println("xmlStr:"+xmlStr);
					ifsuccess= xmlanalysis.getMsg(xmlStr);
					System.out.println("ifsuccess"+ifsuccess);
				} catch (Exception e) {
					e.printStackTrace();
					try {
						writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,e.getMessage()==null?"java.lang.NullPointerException":e.getMessage());	
	
					} catch (Exception e2) {
						e2.printStackTrace();
						LogWriter.logError("传输失败原因："+(e.getMessage()==null?"java.lang.NullPointerException":e2.getMessage()));
						throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalProjectEndBean.getPriId());
						
					}
					key=false;
					continue;
				}finally{
					if("0".equals(ifsuccess)){
					 try{
						i++;
					  LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
								"插入数据到nc财务接口数据库-合同结清收款单接口", "XML如下:"+xmlMassage,"合同结清收款单NC数据同步日志");			
						// 记录同步成功数据信息
						writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,ifsuccess);
					 }catch (Exception e2) {
							// TODO: handle exception
							e2.printStackTrace();
							throw new Exception("此条数据同步成功，但写入日志时报错-"+"项目ID:"+globalProjectEndBean.getPriId());

						}
					 try {
							// 文件日志,成功记录
							LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输成功",
									"插入数据到nc财务接口数据库-合同结清收款单接口", "XML如下:"+xmlMassage,"合同结清收款单NC数据同步日志");
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}else{
						if(key){
							try {
								writeDataSyncDBInfo(globalProjectEndBean, oper_id, syncType,ifsuccess);								
							} catch (Exception e2) {
								e2.printStackTrace();
								LogWriter.logError("传输失败原因："+ifsuccess);
								throw new Exception("此条数据同步失败，且写入日志时报错-"+"项目ID:"+globalProjectEndBean.getPriId());
				
							}
							try {
								// 文件日志,失败记录
								LogWriter.operationFILogNc("本次执行[" + syncType + "]数据同步，数据传输失败",
										"插入数据到nc财务接口数据库-合同结清收款单接口", "XML如下:"+xmlMassage,"合同结清收款单NC数据同步日志");
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						}
					}
				}
			}
			LogWriter.logDebug("本次执行[" + syncType + "]数据同步，插入数据["
					+ i + "]条"+",失败["+(globalProjectEndList.size()-i)+"]条");
			// 数据库日志
			writeDataSyncDBLog(oper_id, i, syncType,("本次执行[" + syncType + "]数据同步，插入数据["+ i + "]条"+",失败["+(globalProjectEndList.size()-i)+"]条"));
			
			
			
		}
		
	}


}
