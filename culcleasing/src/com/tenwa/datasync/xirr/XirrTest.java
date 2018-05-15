package com.tenwa.datasync.xirr;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.datasync.xirr.vo.XIrrBean;
import com.tenwa.datasync.xirr.vo.XIrrNewVo;

public class XirrTest {
	
	public static void main(String[] args) throws SQLException, ParseException {
		long d = System.currentTimeMillis();
		//id=10D0410606_01	ʱ��=2016-10
		//testOne("10D0410606_01","2016-10");
		new XirrTest().
		//testStartTaskGlobalXIrr();
		//createTable();
		//selectTable();
		updateTable();
		System.out.println((System.currentTimeMillis() - d) + "ms");
	}
	public  void selectTable() throws SQLException, ParseException{
		int intPageSize = 20;
		int intPage = 1;
		String begindate = "";//"2005-01-01";// ��ѯʱ��ڵ�
		String enddate ="";//"2030-01-01";//��ֹ�ڵ�		ÿ�¸���һ��
		String projectName="����ʡ��������ҽԺ�¹�siemensCT�ۺ��������Ŀ";//"����ʡ��������ҽҽԺ�ۺ��������Ŀ";//��Ŀ����
		String projId="";//��ĿID
		String deptName ="";//��������
		String projManageName="";//��Ŀ��������
		
		XIrrInit xi=new XIrrInit();
		String countSql=xi.getCountSql(projId,projectName,deptName,projManageName);
		xi.initErpDataSource();
		XIrrCreateTable xict = new XIrrCreateTable(xi);
		List<XIrrNewVo> contractList = xict.selectTable(projectName, projId, deptName, projManageName, intPageSize, intPage);
		List<String> planDateList = xi.getPlanDate(begindate,enddate,projectName);
		List<XIrrBean> xibs= xict.swap(projectName,begindate, enddate, contractList, planDateList);
		
		//��ȡ������Ϣ
		xi.closeErpDataSource();
				//showTable(begindate,enddate,xict,contractList,planDateList);
		show(xibs,planDateList);
	}
	public void showTable(String projectName,String begindate,String enddate,XIrrCreateTable xict,List<XIrrNewVo> xirrNewVos, List<String> dates) throws ParseException, SQLException{
		List<XIrrBean> list=xict.swap(projectName,begindate,enddate,xirrNewVos,dates);
		show(list,dates);
	}
	//��̬���±��е����� 	ÿ��һ��
	/**
	 * ���ڶ�ʱ����xirr��ķ���
	 * @throws SQLException
	 * @throws ParseException
	 */
	public synchronized void updateTable() throws SQLException, ParseException{
		XIrrInit xii =new XIrrInit();
		int a = 0;
		xii.erpDataSource=new ERPDataSource();
		XIrrCreateTable xct=new XIrrCreateTable(xii);
		a = xct.insertTableNext();
		String oper_id = CommonTool.getUUID();
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr.append("Insert into CRM_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
			.append("update_amount,insert_amount) ");
		sqlStr.append(" values('" + oper_id + "','DATA_SYNC_FUND_PLAN_IRR','��ͬ�ʽ�ƻ�[IRR��Ϣ]���ݲ���','��','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "','"
				+ 0 + "','" + a + "')");
		xii.erpDataSource.executeUpdate(sqlStr.toString());
		xii.closeErpDataSource();
	}
	//��̬�������е�����
	/**
	 * ���ڳ�ʼ��xirr��ķ���
	 * @throws SQLException
	 * @throws ParseException
	 */
	public synchronized void createTable() throws SQLException, ParseException{
		XIrrInit xii =new XIrrInit();
		xii.erpDataSource=new ERPDataSource();
		XIrrCreateTable xct=new XIrrCreateTable(xii);
		xct.initTable();
		xii.closeErpDataSource();
		
	}
	//ָ��ʱ�����ͬ��xirr
	public void testOne(String contractIdstr,String datestr) throws SQLException{
		String contractId=contractIdstr;
		String date=datestr;
		XIrrInit xi=new XIrrInit();
		xi.erpDataSource=new ERPDataSource();
		System.out.println("xirr="+xi.getXIrrByContractidAndPlandate(contractId,date));
		xi.getXIrrByContractidAndPlandate(contractId,date);
		xi.closeErpDataSource();
	}
	//��̬����xirr__ʱ��ϳ�
	public void test() throws SQLException {
		int intPageSize = 20;
		int intPage = 1;
		String begindate = "2006-01-01";// ��ѯʱ��ڵ�
		String enddate ="2023-01-01";//��ֹ�ڵ�		ÿ�¸���һ��
		//String projectName="����ʡ�����а���һԺ���¿���ˮʽȫ�Զ�ø�����߹���վ����������Ŀ";
		//String projectName="����ʡ�差һԺGE";
		String projectName="";//"����ʡ��������ҽҽԺ�ۺ��������Ŀ";//��Ŀ����
		//String projId="08D0110002_01";//��ĿID
		String projId="";//��ĿID
		String deptName ="";//��������
		String projManageName="";//��Ŀ��������
		
		XIrrInit xi=new XIrrInit();
		xi.initErpDataSource();
		String countSql=xi.getCountSql(projId,projectName,deptName,projManageName);
		List<XIrrBean> contractList = xi.getContractIdList(projectName,projId,deptName,projManageName,
				intPageSize, intPage);
		
		List<String> planDateList = xi.getPlanDate(begindate,enddate,projectName);
		//��ȡ������Ϣ
		xi.initContractList(contractList, planDateList);
		xi.closeErpDataSource();
		//System.out.println(contractList);
		show(contractList,planDateList);
	}
	//������ʾ���Խ��
	public void show(List<XIrrBean> contractList,List<String> planDateList){
		StringBuilder sb=new StringBuilder();
		sb.append("��Ŀ����\t").append("ǩԼIRR\t");
		sb.append("��ͬID\t");
		for(String dl:planDateList){
			sb.append(dl+"\t");
		}
		sb.append("\n");
		for(XIrrBean xb:contractList){
			sb.append(xb.getProjectName()+"\t")
			.append(xb.getSignXirr()+"\t");
			sb.append(xb.getContractId()+"\t");
			for(String dl:planDateList){
				String temp=xb.getXirrMap().get(dl);
				//if(temp ==null){
					//temp="0";
				//}
				sb.append(temp+"\t");
			}
			sb.append("\n");
		}
		System.out.println(sb.toString());
	}
}
