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
 * CRM�򵥲���������
 * 
 * @author Jaffe
 * 
 * Date:Jun 28, 2011 10:52:29 AM Email:JaffeHe@hotmail.com
 */
public class CRMOperationUtil {

	private static Logger log = Logger.getLogger(ConditionDao.class);

	private static CRMDataSource crmDataSource=null;

	// ��������
	private static ResultSet rs = null;

	/**
	 * ��ѯ�û��Ƿ�ע��
	 * 
	 * @param settle_method
	 * @param period_type
	 * @param ext
	 * @return
	 */
	public static boolean getRegisterIf(String loginId) {
		boolean resVal = false;
		// 1.��ѯCRMϵͳ�õ�½Id�Ƿ�ע��
		crmDataSource=new CRMDataSource();
		try {
			String sqlStr = "select * from org_employee where sCode='"+loginId+"'";
			rs = crmDataSource.executeQuery(sqlStr);
			resVal = rs.next();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3.�ر���Դ
			crmDataSource.close();
		}

		if (log.isDebugEnabled()) {
			log.debug(loginId + "���û��Ƿ�ע�᣺" + (resVal ? "ע���" : "δע��"));
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
				// 3.�ر���Դ
				crmDataSource.close();
			}
			return row;
		}
	/**
	 * �����㷽��
	 * 
	 * @param uploadFileName
	 * @return
	 */
	public static boolean registerCust(String loginId) {
		boolean resVal = false;

		// ��CRMע��õ�½�û�������

		return resVal;
	}

}
