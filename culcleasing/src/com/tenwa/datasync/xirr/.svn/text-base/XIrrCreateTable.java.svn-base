package com.tenwa.datasync.xirr;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.util.CommonTool;
import com.tenwa.datasync.xirr.vo.XIrrBean;
import com.tenwa.datasync.xirr.vo.XIrrNewVo;


public class XIrrCreateTable {
	// 设置的年限区间
	public static final int BEYONDYEAR = 10;
	public static final int BEGINYEAR = 2006;
	private XIrrInit xii;

	/**
	 * 传入一个XIrrInit对象来控制数据库连接
	 * 
	 * @param xii
	 */
	public XIrrCreateTable(XIrrInit xii) {
		this.xii = xii;
	}

	/**
	 * 初始化表
	 * 
	 * @throws SQLException
	 * @throws ParseException
	 */
	public void initTable() throws SQLException, ParseException {
		this.dropIndex();
		this.clearTable();
		this.insertTableFirst();
		this.addPara();
		this.createIndex();
	}

	/**
	 * 用于定期更新数据
	 * 
	 * @throws SQLException
	 * @throws ParseException
	 */
	public int insertTableNext() throws SQLException, ParseException {
		this.dropIndex();
		int a = this.addPara();
		this.createIndex();
		return a;
	}

	/**
	 * 定期更新数据的具体方法
	 * 
	 * @throws SQLException
	 * @throws ParseException
	 */
	private int addPara() throws SQLException, ParseException {
		Calendar now = Calendar.getInstance();//数据库连接
		int beginYear = now.get(Calendar.YEAR);
		deleteCurYear(beginYear);
		now.add(Calendar.YEAR, BEYONDYEAR);
		int endYear = now.get(Calendar.YEAR);
		String sql="select convert(varchar(4),max(plan_date),120) from fund_rent_plan";
		ResultSet rs = xii.erpDataSource.executeQuery(sql);
		if (rs.next()) {
			endYear=Integer.parseInt( rs.getString(1));
		}
		
		int a = this.insertTable(beginYear, endYear);
		return a;
	}

	/**
	 * 清空当前年及以后的所有数据
	 * 
	 * @param curYear
	 * @return
	 * @throws SQLException
	 */
	public int deleteCurYear(int curYear) throws SQLException {
		String del = "delete from xirr where cur_year >= " + curYear;
		System.out.println("本年及以后数据 已清空成功！");
		return xii.erpDataSource.executeUpdate(del);
	}

	/**
	 * TODO 动态改变索引
	 */
	private void dropIndex() {

	}

	private void createIndex() {

	}

	/**
	 * 清空xirr表
	 * 
	 * @return
	 * @throws SQLException
	 */
	private int clearTable() throws SQLException {
		String del = "delete from xirr where 1=1";
		System.out.println("xirr 表已清空成功！");
		return xii.erpDataSource.executeUpdate(del);
	}

	/**
	 * 用于初始化 xirr表的数据
	 * 
	 * @throws SQLException
	 * @throws ParseException
	 */
	public void insertTableFirst() throws SQLException, ParseException {
		Calendar now = Calendar.getInstance();
		int beginYear = BEGINYEAR;
		int endYear = now.get(Calendar.YEAR);
		this.insertTable(beginYear, endYear);
	}

	/**
	 * 给xirr表添加初始化数据
	 * @param beginYear
	 * @param endYear
	 * @throws SQLException
	 * @throws ParseException
	 */
	public int insertTable(int beginYear, int endYear) throws SQLException,
			ParseException {
		xii.initErpDataSource();
		int a = 0;
		// 批量添加
		Calendar now = Calendar.getInstance();
		// beginYear = BEGINYEAR;
		// endYear = now.get(Calendar.YEAR);

		DateFormat df = new SimpleDateFormat("yyyy-MM");
		// 取得全部合同ID
		List<String> allContractIds = this.getAllContractIds();
		for (String contract : allContractIds) {
			String signXirr = xii.getXIrrByContractId(contract);
			if (signXirr == null || "0E-20".equals(signXirr)
					|| Float.parseFloat(signXirr) == 100.0f) {
				signXirr = "0";
			}
			Date contractStart = this.xii.getMinDate(contract);
			Date contractEnd = this.xii.getMaxDate(contract);
			// 签约XIrr
			for (int i = beginYear; i <= endYear; i++) {
				if (contractStart != null && contractEnd != null
						&& i >= contractStart.getYear() + 1900
						&& i <= contractEnd.getYear() + 1900) {
					StringBuilder sb = new StringBuilder();
					sb.append(
							"insert into xirr (contract_id , cur_year ,sign_xirr, jan , feb , mar , apr , may , jun , jul , aug , sep , oct , nov , dece)values(  '")
							.append(contract).append("' , ").append(i)
							.append(" , ").append(signXirr);
					for (int j = 1; j <= 12; j++) {
						now.setTime(contractStart);
						now.add(Calendar.MONTH, -1);
						contractStart = now.getTime();
						now.set(i, j, 1);
						String monxirr = null;
						Date temp = now.getTime();
						String timestr = df.format(temp);
						// 比对合同区间
						System.out.println("当前时间：" + temp);
						System.out.println("开始时间：" + contractStart);
						System.out.println("结束时间：" + contractEnd);

						if (temp.after(contractStart)
								&& temp.before(contractEnd)) {
							monxirr = xii.getXIrrByContractidAndPlandate(
									contract, timestr);
							if (monxirr == null || "0E-20".equals(monxirr)
									|| Float.parseFloat(monxirr) == 100.0f) {
								monxirr = "0";
							}
							System.out.println("合同：" + contract + "\t时间："
									+ timestr);
						}
						sb.append(" , ").append(monxirr);
					}
					sb.append(" ) ");
					a += xii.erpDataSource.executeUpdate(sb.toString());
				}
			}
		}
		xii.closeErpDataSource();
		
		return a;
	}
	
	/**
	 * 给xirr表添加初始化数据
	 * @param beginYear
	 * @param endYear
	 * @throws SQLException
	 * @throws ParseException
	 */
	public void insertOneTable(int beginYear, int endYear,String contract) throws SQLException,
			ParseException {
		xii.initErpDataSource();
		int a = 0;
		// 批量添加
		Calendar now = Calendar.getInstance();
		// beginYear = BEGINYEAR;
		// endYear = now.get(Calendar.YEAR);

		DateFormat df = new SimpleDateFormat("yyyy-MM");
		// 取得全部合同ID
			String signXirr = xii.getXIrrByContractId(contract);
			if (signXirr == null || "0E-20".equals(signXirr)
					|| Float.parseFloat(signXirr) == 100.0f) {
				signXirr = "0";
			}
			Date contractStart = this.xii.getMinDate(contract);
			Date contractEnd = this.xii.getMaxDate(contract);
			// 签约XIrr
			for (int i = beginYear; i <= endYear; i++) {
				if (contractStart != null && contractEnd != null
						&& i >= contractStart.getYear() + 1900
						&& i <= contractEnd.getYear() + 1900) {
					StringBuilder sb = new StringBuilder();
					sb.append(
							"insert into xirr (contract_id , cur_year ,sign_xirr, jan , feb , mar , apr , may , jun , jul , aug , sep , oct , nov , dece)values(  '")
							.append(contract).append("' , ").append(i)
							.append(" , ").append(signXirr);
					for (int j = 1; j <= 12; j++) {
						now.setTime(contractStart);
						now.add(Calendar.MONTH, -1);
						contractStart = now.getTime();
						now.set(i, j, 1);
						String monxirr = null;
						Date temp = now.getTime();
						String timestr = df.format(temp);
						// 比对合同区间
						System.out.println("当前时间：" + temp);
						System.out.println("开始时间：" + contractStart);
						System.out.println("结束时间：" + contractEnd);

						if (temp.after(contractStart)
								&& temp.before(contractEnd)) {
							monxirr = xii.getXIrrByContractidAndPlandate(
									contract, timestr);
							if (monxirr == null || "0E-20".equals(monxirr)
									|| Float.parseFloat(monxirr) == 100.0f) {
								monxirr = "0";
							}
							System.out.println("合同：" + contract + "\t时间："
									+ timestr);
						}
						sb.append(" , ").append(monxirr);
					}
					sb.append(" ) ");
					a += xii.erpDataSource.executeUpdate(sb.toString());
				}
			}
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
	
	/**
	 * 取得所有合同的ID
	 * 
	 * @return
	 * @throws SQLException
	 */
	private List<String> getAllContractIds() throws SQLException {
		List<String> list = null;
		String del = "select distinct contract_id from vi_contract_info ci LEFT JOIN cust_info cif ON cif.cust_id=ci.cust_id where proj_status>=40";
		ResultSet rs = xii.erpDataSource.executeQuery(del);
		if (list == null) {
			list = new ArrayList<String>();
		}
		while (rs.next()) {
			list.add(rs.getString(1));
		}
		return list;
	}

	/**
	 * 从xirr表中查询记录
	 * 
	 * @return
	 * @throws SQLException
	 */
	public List<XIrrNewVo> selectTable(String projectName, String projId,
			String deptName, String projManageName, int size, int currentPage)
			throws SQLException {
		System.out.println("begin.................");
		this.xii.setWherestr(projId, projectName, deptName, projManageName);
		String str = "select x.contract_id , x.cur_year ,x.sign_xirr, x.jan , x.feb , x.mar , x.apr , x.may , x.jun , x.jul , x.aug , x.sep , x.oct , x.nov , x.dece , a.project_name "
				+ " from xirr x ,( SELECT TOP "
				+ size
				+ " contract_id,project_name "
				+ " from dbo.vi_contract_info "
				+ " WHERE proj_status >= 40 and (contract_id NOT IN "
				+ " (SELECT TOP "
				+ size
				* (currentPage - 1)
				+ " contract_id "
				+ " FROM dbo.vi_contract_info "
				+ " where proj_status >= 40"
				+ xii.getWherestr()
				+ " ORDER BY contract_id )) "
				+ xii.getWherestr()
				+ " ORDER BY contract_id "
				+ ") a"
				+ " where x.contract_id=a.contract_id"
				+ " order by x.contract_id,x.cur_year";
		System.out.println("str="+str);
		List<XIrrNewVo> list = null;
		ResultSet rs = xii.erpDataSource.executeQuery(str);
		if (list == null) {
			list = new ArrayList<XIrrNewVo>();
		}
		System.out.println("MIDDLE...............................");
		while (rs.next()) {
			XIrrNewVo xinv = new XIrrNewVo();
			xinv.setContractId(rs.getString(1));
			xinv.setCurYear(rs.getInt(2));
			xinv.setSignXIrr(rs.getString(3));
			xinv.setJan(rs.getString(4));
			xinv.setFeb(rs.getString(5));
			xinv.setMar(rs.getString(6));
			xinv.setApr(rs.getString(7));
			xinv.setMay(rs.getString(8));
			xinv.setJun(rs.getString(9));
			xinv.setJul(rs.getString(10));
			xinv.setAug(rs.getString(11));
			xinv.setSep(rs.getString(12));
			xinv.setOct(rs.getString(13));
			xinv.setNov(rs.getString(14));
			xinv.setDece(rs.getString(15));
			xinv.setProjectName(rs.getString(16));
			list.add(xinv);
		}
		System.out.println("end......................");
		return list;
	}

	/**
	 * 将从xirr表从查出的数据转换为页面展示对象
	 * 
	 * @param projectName
	 * @param begindate
	 * @param enddate
	 * @param xirrNewVos
	 * @param dates
	 * @return
	 * @throws ParseException
	 * @throws SQLException
	 */
	public List<XIrrBean> swap(String projectName, String begindate,
			String enddate, List<XIrrNewVo> xirrNewVos, List<String> dates)
			throws ParseException, SQLException {
		List<XIrrBean> list = new ArrayList<XIrrBean>();
		String flagstr = "";
		XIrrBean xb = new XIrrBean();
		Map<String, String> map = new HashMap<String, String>();
		for (XIrrNewVo xinv : xirrNewVos) {
			if ("".equals(flagstr)) {
				flagstr = xinv.getContractId();
				xb = new XIrrBean();
				xb.setContractId(xinv.getContractId());
				xb.setSignXirr(xinv.getSignXIrr());
				xb.setProjectName(xinv.getProjectName());
				map = new HashMap<String, String>();
				// System.out.print("项目名称：" + xinv.getProjectName() + "\t");
				// System.out.print("签约XIrr" + xinv.getSignXIrr());
			}
			if (!flagstr.equals(xinv.getContractId())) {
				flagstr = xinv.getContractId();

				xb.setXirrMap(map);
				list.add(xb);
				xb = new XIrrBean();
				xb.setContractId(xinv.getContractId());
				xb.setSignXirr(xinv.getSignXIrr());
				xb.setProjectName(xinv.getProjectName());
				map = new HashMap<String, String>();
				// System.out.println("\n");
				// System.out.print("项目名称：" + xinv.getProjectName() + "\t");
				// System.out.print("签约XIrr" + xinv.getSignXIrr());
			}
			// System.out.print(xinv.getCurYear() + "\t");
			// 判断年限是是否在规定范围内，并且，月份是否在规定范围内
			// dates
			if (projectName != null && !projectName.equals("")) {
				if (begindate == null || "".equals(begindate)
						|| enddate == null || "".equals(enddate)) {
					String contractId = this.xii
							.getContractIdByProjName(projectName);
					if (contractId != null && !"".equals(contractId)) {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						Date d1 = this.xii.getMinDate(contractId);
						Date d2 = this.xii.getMaxDate(contractId);
						if (d1 != null) {
							begindate = df.format(d1);
						}
						if (d2 != null) {
							enddate = df.format(d2);
						}
					}
				}
			}
			if (begindate != null && enddate != null && !"".equals(begindate)
					&& !"".equals(enddate)) {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date begin = df.parse(begindate);
				java.util.Date end = df.parse(enddate);
				for (int i = 1; i <= 12; i++) {
					Calendar now = Calendar.getInstance();
					now.set(xinv.getCurYear(), i, 1);
					java.util.Date curYear = now.getTime();
					DateFormat dfo = new SimpleDateFormat("yyyy-MM");

					if (begin != null && begin != null) {
						Calendar cld = Calendar.getInstance();
						cld.setTime(begin);
						cld.add(Calendar.MONTH, -1);
						begin = cld.getTime();
					}

					if (curYear.before(end) && curYear.after(begin)) {
						// System.out.println(xinv.get(i)+"\t");
						map.put(dfo.format(curYear), xinv.get(i));
					}
				}
			}
		}
		xb.setXirrMap(map);
		list.add(xb);
		return list;
	}
}
