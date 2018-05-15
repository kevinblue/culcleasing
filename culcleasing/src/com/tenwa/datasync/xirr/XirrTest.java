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
		//id=10D0410606_01	时间=2016-10
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
		String begindate = "";//"2005-01-01";// 查询时间节点
		String enddate ="";//"2030-01-01";//截止节点		每月更新一次
		String projectName="安徽省六安市立医院德国siemensCT售后回租赁项目";//"湖北省鄂州市中医医院售后回租赁项目";//项目名称
		String projId="";//项目ID
		String deptName ="";//部门名称
		String projManageName="";//项目经理名称
		
		XIrrInit xi=new XIrrInit();
		String countSql=xi.getCountSql(projId,projectName,deptName,projManageName);
		xi.initErpDataSource();
		XIrrCreateTable xict = new XIrrCreateTable(xi);
		List<XIrrNewVo> contractList = xict.selectTable(projectName, projId, deptName, projManageName, intPageSize, intPage);
		List<String> planDateList = xi.getPlanDate(begindate,enddate,projectName);
		List<XIrrBean> xibs= xict.swap(projectName,begindate, enddate, contractList, planDateList);
		
		//获取报表信息
		xi.closeErpDataSource();
				//showTable(begindate,enddate,xict,contractList,planDateList);
		show(xibs,planDateList);
	}
	public void showTable(String projectName,String begindate,String enddate,XIrrCreateTable xict,List<XIrrNewVo> xirrNewVos, List<String> dates) throws ParseException, SQLException{
		List<XIrrBean> list=xict.swap(projectName,begindate,enddate,xirrNewVos,dates);
		show(list,dates);
	}
	//动态更新表中的数据 	每周一次
	/**
	 * 用于定时更新xirr表的方法
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
		// 2拼接sql
		sqlStr.append("Insert into CRM_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
			.append("update_amount,insert_amount) ");
		sqlStr.append(" values('" + oper_id + "','DATA_SYNC_FUND_PLAN_IRR','合同资金计划[IRR信息]数据操作','无','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "','"
				+ 0 + "','" + a + "')");
		xii.erpDataSource.executeUpdate(sqlStr.toString());
		xii.closeErpDataSource();
	}
	//动态创建表中的数据
	/**
	 * 用于初始化xirr表的方法
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
	//指定时间与合同的xirr
	public void testOne(String contractIdstr,String datestr) throws SQLException{
		String contractId=contractIdstr;
		String date=datestr;
		XIrrInit xi=new XIrrInit();
		xi.erpDataSource=new ERPDataSource();
		System.out.println("xirr="+xi.getXIrrByContractidAndPlandate(contractId,date));
		xi.getXIrrByContractidAndPlandate(contractId,date);
		xi.closeErpDataSource();
	}
	//动态计算xirr__时间较长
	public void test() throws SQLException {
		int intPageSize = 20;
		int intPage = 1;
		String begindate = "2006-01-01";// 查询时间节点
		String enddate ="2023-01-01";//截止节点		每月更新一次
		//String projectName="安徽省蚌埠市蚌埠一院艾德康流水式全自动酶联免疫工作站融资租赁项目";
		//String projectName="湖北省襄樊一院GE";
		String projectName="";//"湖北省鄂州市中医医院售后回租赁项目";//项目名称
		//String projId="08D0110002_01";//项目ID
		String projId="";//项目ID
		String deptName ="";//部门名称
		String projManageName="";//项目经理名称
		
		XIrrInit xi=new XIrrInit();
		xi.initErpDataSource();
		String countSql=xi.getCountSql(projId,projectName,deptName,projManageName);
		List<XIrrBean> contractList = xi.getContractIdList(projectName,projId,deptName,projManageName,
				intPageSize, intPage);
		
		List<String> planDateList = xi.getPlanDate(begindate,enddate,projectName);
		//获取报表信息
		xi.initContractList(contractList, planDateList);
		xi.closeErpDataSource();
		//System.out.println(contractList);
		show(contractList,planDateList);
	}
	//用于显示测试结果
	public void show(List<XIrrBean> contractList,List<String> planDateList){
		StringBuilder sb=new StringBuilder();
		sb.append("项目名称\t").append("签约IRR\t");
		sb.append("合同ID\t");
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
