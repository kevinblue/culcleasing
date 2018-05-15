
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
 * 2016-8-9 ����08:46:50
 * Email: toybaby@tenwa.com
 */
public class YYProjInfoService {
	

	private static String sync_type_name = "[��Ŀ������Ϣ]";
	/**1
	 * ָ����Ŀ������Ϣ����ͬ��
	 * 
	 * @param proj_id
	 *            ��Ŀ���
	 * @return
	 */
	public static int dataSync(String proj_id) {
		int res = 0;
		// 1.�����ݿ��������������
		InterProjInfoDao interProjInfoDao = new InterProjInfoDao();
		List<InterProjInfoBean> beanList = new ArrayList<InterProjInfoBean>();
		try {
			// 1.1��Client1 ��������ȡ����
			beanList = interProjInfoDao.readProjInfoData(proj_id);
		} catch (SQLException e) {
			e.printStackTrace();
			LogWriter.logError("��ȡ[" + proj_id + "]Client Server "+sync_type_name+"�����쳣");
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_PROJ_INFO",sync_type_name+"����ͬ��", "��ȡ�쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

		// .��List����ͬ����Server���ݿ������
		try {
			//2�Ƚ�server�������������ÿɲ�����
			//ͨ�÷����������� �������ֶ�����ͳһ���и��²����á�
			interProjInfoDao.updateInterProjInfoFlag( "INTER_PROJ_INFO", "PROJ_ID",proj_id);
			//3 ������ͬ����Server������				
			res += interProjInfoDao.insert2HostData(beanList);
			
			
		} catch (SQLException e) {
			try {
				YongYouOperationUtil.operationExceptionLog("DATA_SYNC_INTER_PROJ_INFO",sync_type_name+"����ͬ��", "�����쳣��" + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			LogWriter.logError("����Host Server "+sync_type_name+" �쳣,�쳣��Ϣ: "	+ e.getMessage());
		}

		// ����ִ���Ƿ�ɹ�
		return res;
	}
	public static void main(String[] args) {
		int i=YYProjInfoService.dataSync("08D0210230");
		System.out.println(i);
	}
}
