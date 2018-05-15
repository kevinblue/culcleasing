/**
 * com.tenwa.culc.util
 */
package com.tenwa.culc.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.VendProBean;
import com.tenwa.culc.dao.ConditionDao;
import com.tenwa.culc.service.SqlGenerateUtil;
import com.tenwa.log.LogWriter;


/**
 * CRM简单操作公共类
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class CRMOperationUtil {

	private static Logger log = Logger.getLogger(ConditionDao.class);

	private static CRMDataSource crmDataSource=null;

	// 公共参数
	private static ResultSet rs = null;

	/**
	 * 查询用户是否注册
	 * 
	 * @param settle_method
	 * @param period_type
	 * @param ext
	 * @return
	 */
	public static boolean getRegisterIf(String loginId) {
		boolean resVal = false;
		// 1.查询CRM系统该登陆Id是否注册
		crmDataSource=new CRMDataSource();
		try {
			String sqlStr = "select * from org_employee where sCode='"+loginId+"'";
			rs = crmDataSource.executeQuery(sqlStr);
			resVal = rs.next();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3.关闭资源
			crmDataSource.close();
		}

		if (log.isDebugEnabled()) {
			log.debug(loginId + "该用户是否注册：" + (resVal ? "注册过" : "未注册"));
		}

		return resVal;
	}

		public static int inser(String serpCode,String sCode,String sName,String subsidiary){
			int row=0;
			crmDataSource=new CRMDataSource();
			try {
				String sqlStr = "exec Proc_Register_User '"+sCode+"','"+sName+"','"+serpCode+"','"+subsidiary+"'";
				crmDataSource.executeUpdate(sqlStr);
				row=1;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 3.关闭资源
				crmDataSource.close();
			}
			return row;
		}
	/**
	 * 租金计算方法
	 * 
	 * @param uploadFileName
	 * @return
	 */
	public static boolean registerCust(String loginId) {
		boolean resVal = false;

		// 在CRM注册该登陆用户的数据

		return resVal;
	}

}
