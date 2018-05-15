package com.tenwa.bean;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.service.YYSqlGenerateUtil;
import com.service.YYSqlTableUtil;
import com.tenwa.bean.InterProjInfoBean;
import com.tenwa.culc.calc.util.YongYouDataSource;
import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;

import com.tenwa.log.LogWriter;




/**
 * @author Toybaby
 * 项目基本信息同步
 * 2016-8-9 下午09:33:01
 * Email: toybaby@tenwa.com
 */
public class InterProjInfoDao {
	// 公共参数

	private ResultSet rs = null;
	private String sync_type_name = "[项目基本信息]";

	/**
	 * 读取项目基本信息
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<InterProjInfoBean>  readProjInfoData(String proj_id) throws SQLException {
		InterProjInfoBean interProjInfoBean = null;
		List<InterProjInfoBean> beanList = new ArrayList<InterProjInfoBean>();
		// 1获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2查询
		String sqlStr = YYSqlGenerateUtil.generateSelectProjInfoSql(proj_id);
		rs = erpDataSource.executeQuery(sqlStr);

		while (rs.next()) {
			interProjInfoBean = new InterProjInfoBean();  
			interProjInfoBean=(InterProjInfoBean) YYSqlTableUtil.getResultSetObj(interProjInfoBean, rs, "vi_inter_proj_info");
			LogWriter.logDebug("加载项目信息，项目编号：" + interProjInfoBean.getProjId());
			beanList.add(interProjInfoBean);
		}

		// 4.关闭资源
		erpDataSource.close();

		return beanList;
	}

	/**
	 * @param list   INTER_PROJ_INFO 表原数据改为废弃
	 * @param table_name
	 * @param proj_id
	 * @throws SQLException
	 */
	public void updateInterProjInfoFlag(String table_name,String column_name, String column_value) throws SQLException {
		YongYouDataSource YYDataSource = new YongYouDataSource();
		String sqlStr = YYSqlGenerateUtil.generateUpdateProjInfoFlag("INTER_PROJ_INFO", column_name, column_value);
		LogWriter.logDebug("更新用友表中数据为废弃，表名："+table_name+" 参数 "+column_name+" = "+column_value +"" );
		YYDataSource.executeUpdate(sqlStr);
		// 4.关闭资源
		YYDataSource.close();
	}



	/**
	 * 插入中间库
	 * @param beanList
	 * @throws SQLException
	 */
	public int insert2HostData(List<InterProjInfoBean> beanList)	throws SQLException {
		
		System.out.println("1111111111111111111111111");
		int updAmount = 0;// 修改数据数据量
		int insAmount = 0;// 插入数据数据量
		if (beanList.size() < 1) {
			LogWriter.logDebug("当前没有"+sync_type_name+"数据需要同步");
		} else {
				String oper_id = CommonTool.getUUID();// 操作Id
				System.out.println("22222222222222222222oper_id="+oper_id);
				boolean isExist = false;
				String flag = "";
				YongYouDataSource yyDataSource=new YongYouDataSource();
				System.out.println("33333333333333333=yyDataSource"+yyDataSource.toString());
				String sqlStr = "";
				// 1.遍历所有List数据
				for (InterProjInfoBean interProjInfoBean : beanList) {
					interProjInfoBean.setOPER_ID(oper_id);
					System.out.println("4444444444444444444444444");
						sqlStr = YYSqlTableUtil.getAllFiledInsertSQL(interProjInfoBean,"INTER_PROJ_INFO");
						insAmount++;
			
					// 2.1.3执行操作
						System.out.println("55555555555本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
					if (!"".equals(sqlStr)) {
						updateInterProjInfoFlag( "INTER_PROJ_INFO", "PROJ_ID",interProjInfoBean.getProjId());
						yyDataSource.executeUpdate(sqlStr);
					}
				}
				System.out.println("666666666666666");
				LogWriter.logDebug("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				System.out.println("777777777777777");
				// 文件日志
				LogWriter.operationLog("本次执行"+sync_type_name+"数据同步，插入数据[" + insAmount+ "]条");
				System.out.println("88888888888888888");
				// 数据库日志
				writeDataSyncDBLog(insAmount, updAmount, oper_id);
				System.out.println("999999999999999999");
				// 同步数据信息
				writeDataSyncDBInfo(beanList,oper_id);
				System.out.println("10101010101010");
			
				yyDataSource.close();
			}
		return insAmount;
}

	

	/**
	 * 数据同步信息
	 * 
	 * @param equipMedLibList
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(List<InterProjInfoBean> beanList,	String oper_id) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		// 1.遍历所有List数据
		for (InterProjInfoBean interProjInfoBean : beanList) {
			// 插入
			sqlStr = YYSqlGenerateUtil.generateDataSyncDBInfo(oper_id, interProjInfoBean.getProjId(),
					interProjInfoBean.getProjStatus());

			// 执行操作
			System.out.println(sync_type_name+"同步信息插入日志SQL" + sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		}
		erpDataSource.close();
	}

	/**
	 * 服务器数据库日志
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(int insAmount, int updAmount, String oper_id)
			throws SQLException {
		// 1.获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.更新数据
		String sqlStr = YYSqlGenerateUtil.generateDataSyncProjInfoLog(
				insAmount, updAmount, oper_id,sync_type_name,"DATA_SYNC_INTER_PROJ_INFO");

		erpDataSource.executeUpdate(sqlStr);

		// 3.释放
		erpDataSource.close();
	}


	

}
