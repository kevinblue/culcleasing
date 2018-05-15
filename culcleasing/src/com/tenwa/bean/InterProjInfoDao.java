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
 * ��Ŀ������Ϣͬ��
 * 2016-8-9 ����09:33:01
 * Email: toybaby@tenwa.com
 */
public class InterProjInfoDao {
	// ��������

	private ResultSet rs = null;
	private String sync_type_name = "[��Ŀ������Ϣ]";

	/**
	 * ��ȡ��Ŀ������Ϣ
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<InterProjInfoBean>  readProjInfoData(String proj_id) throws SQLException {
		InterProjInfoBean interProjInfoBean = null;
		List<InterProjInfoBean> beanList = new ArrayList<InterProjInfoBean>();
		// 1��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2��ѯ
		String sqlStr = YYSqlGenerateUtil.generateSelectProjInfoSql(proj_id);
		rs = erpDataSource.executeQuery(sqlStr);

		while (rs.next()) {
			interProjInfoBean = new InterProjInfoBean();  
			interProjInfoBean=(InterProjInfoBean) YYSqlTableUtil.getResultSetObj(interProjInfoBean, rs, "vi_inter_proj_info");
			LogWriter.logDebug("������Ŀ��Ϣ����Ŀ��ţ�" + interProjInfoBean.getProjId());
			beanList.add(interProjInfoBean);
		}

		// 4.�ر���Դ
		erpDataSource.close();

		return beanList;
	}

	/**
	 * @param list   INTER_PROJ_INFO ��ԭ���ݸ�Ϊ����
	 * @param table_name
	 * @param proj_id
	 * @throws SQLException
	 */
	public void updateInterProjInfoFlag(String table_name,String column_name, String column_value) throws SQLException {
		YongYouDataSource YYDataSource = new YongYouDataSource();
		String sqlStr = YYSqlGenerateUtil.generateUpdateProjInfoFlag("INTER_PROJ_INFO", column_name, column_value);
		LogWriter.logDebug("�������ѱ�������Ϊ������������"+table_name+" ���� "+column_name+" = "+column_value +"" );
		YYDataSource.executeUpdate(sqlStr);
		// 4.�ر���Դ
		YYDataSource.close();
	}



	/**
	 * �����м��
	 * @param beanList
	 * @throws SQLException
	 */
	public int insert2HostData(List<InterProjInfoBean> beanList)	throws SQLException {
		
		System.out.println("1111111111111111111111111");
		int updAmount = 0;// �޸�����������
		int insAmount = 0;// ��������������
		if (beanList.size() < 1) {
			LogWriter.logDebug("��ǰû��"+sync_type_name+"������Ҫͬ��");
		} else {
				String oper_id = CommonTool.getUUID();// ����Id
				System.out.println("22222222222222222222oper_id="+oper_id);
				boolean isExist = false;
				String flag = "";
				YongYouDataSource yyDataSource=new YongYouDataSource();
				System.out.println("33333333333333333=yyDataSource"+yyDataSource.toString());
				String sqlStr = "";
				// 1.��������List����
				for (InterProjInfoBean interProjInfoBean : beanList) {
					interProjInfoBean.setOPER_ID(oper_id);
					System.out.println("4444444444444444444444444");
						sqlStr = YYSqlTableUtil.getAllFiledInsertSQL(interProjInfoBean,"INTER_PROJ_INFO");
						insAmount++;
			
					// 2.1.3ִ�в���
						System.out.println("55555555555����ִ��"+sync_type_name+"����ͬ������������[" + insAmount+ "]��");
					if (!"".equals(sqlStr)) {
						updateInterProjInfoFlag( "INTER_PROJ_INFO", "PROJ_ID",interProjInfoBean.getProjId());
						yyDataSource.executeUpdate(sqlStr);
					}
				}
				System.out.println("666666666666666");
				LogWriter.logDebug("����ִ��"+sync_type_name+"����ͬ������������[" + insAmount+ "]��");
				System.out.println("777777777777777");
				// �ļ���־
				LogWriter.operationLog("����ִ��"+sync_type_name+"����ͬ������������[" + insAmount+ "]��");
				System.out.println("88888888888888888");
				// ���ݿ���־
				writeDataSyncDBLog(insAmount, updAmount, oper_id);
				System.out.println("999999999999999999");
				// ͬ��������Ϣ
				writeDataSyncDBInfo(beanList,oper_id);
				System.out.println("10101010101010");
			
				yyDataSource.close();
			}
		return insAmount;
}

	

	/**
	 * ����ͬ����Ϣ
	 * 
	 * @param equipMedLibList
	 * @throws SQLException
	 */
	private void writeDataSyncDBInfo(List<InterProjInfoBean> beanList,	String oper_id) throws SQLException {
		ERPDataSource erpDataSource = new ERPDataSource();
		String sqlStr = "";
		// 1.��������List����
		for (InterProjInfoBean interProjInfoBean : beanList) {
			// ����
			sqlStr = YYSqlGenerateUtil.generateDataSyncDBInfo(oper_id, interProjInfoBean.getProjId(),
					interProjInfoBean.getProjStatus());

			// ִ�в���
			System.out.println(sync_type_name+"ͬ����Ϣ������־SQL" + sqlStr);
			erpDataSource.executeUpdate(sqlStr);
		}
		erpDataSource.close();
	}

	/**
	 * ���������ݿ���־
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @throws SQLException
	 */
	private void writeDataSyncDBLog(int insAmount, int updAmount, String oper_id)
			throws SQLException {
		// 1.��ȡ����
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.��������
		String sqlStr = YYSqlGenerateUtil.generateDataSyncProjInfoLog(
				insAmount, updAmount, oper_id,sync_type_name,"DATA_SYNC_INTER_PROJ_INFO");

		erpDataSource.executeUpdate(sqlStr);

		// 3.�ͷ�
		erpDataSource.close();
	}


	

}
