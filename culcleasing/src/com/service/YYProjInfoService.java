
package com.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.tenwa.bean.InterProjInfoDao;




import com.tenwa.bean.InterProjInfoBean;
import com.tenwa.culc.calc.util.YongYouOperationUtil;

import com.tenwa.log.LogWriter;



/**1
 * @author Toybaby
 * 
 * 2016-8-9 下午08:46:50
 * Email: toybaby@tenwa.com
 */
public class YYProjInfoService {
	

	private static String sync_type_name = "[项目基本信息]";
	/**1
	 * 指定项目基本信息数据同步
	 * 
	 * @param proj_id
	 *            项目编号
	 * @return
	 */
	public static int dataSync(String proj_id) {
		int res = 0;
		// 1.从数据库服务器读出数据
		InterProjInfoDao interProjInfoDao = new InterProjInfoDao();
		List<InterProjInfoBean> beanList = new ArrayList<InterProjInfoBean>();
		try {
			// 1.1从Client1 服务器读取数据
			beanList = interProjInfoDao.readProjInfoData(proj_id);
		} catch (SQLException e) {
			e.printStackTrace();
			LogWriter.logError("读取[" + proj_id + "]Client Server "+sync_type_name+"数据异常");
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_PROJ_INFO",sync_type_name+"数据同步", "读取异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

		// .将List数据同步到Server数据库服务器
		try {
			//2先将server服务器的数据置可不可用
			//通用方法，传参数 表名和字段名，统一进行更新不可用。
			interProjInfoDao.updateInterProjInfoFlag( "INTER_PROJ_INFO", "PROJ_ID",proj_id);
			//3 将数据同步到Server服务器				
			res += interProjInfoDao.insert2HostData(beanList);
			
			
		} catch (SQLException e) {
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_PROJ_INFO",sync_type_name+"数据同步", "插入异常：" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("更新Host Server "+sync_type_name+" 异常,异常信息: "	+ e.getMessage());
		}

		// 本次执行是否成功
		return res;
	}
	public static void main(String[] args) {
		int i=YYProjInfoService.dataSync("08D0210230");
		System.out.println(i);
	}
}
