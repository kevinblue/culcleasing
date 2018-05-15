package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tenwa.culc.bean.ContractPlanBean;
import com.tenwa.culc.bean.VbadinfoBean;
import com.tenwa.culc.bean.VendProBean;
import com.tenwa.culc.service.YGZSqlGenerateUtil;



import com.tenwa.culc.util.CRMDataSource;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.culc.util.ConvertUtil;
import com.tenwa.log.LogWriter;

/**
 * 
 * @ClassName ProjInfoDao

 * @Description 回写CRM调用的Dao方法

 * @Author 崔天帅

 * @Date 2013-6-12下午04:33:10
 */
public class ProjInfoDao {
	
	private ResultSet rs = null;
	
	/**
	 * 
	 * @Title readERPProjEquipInfoData
	
	 * @Param contractId 合同编号
	 * @Param @throws SQLException
	
	 * @Description 获取租赁物件ID
	
	 * @Return List<String>
	
	 * @throw
	 */
	public List<String> readERPProjEquipInfoData(String contractId) throws SQLException {
		//定义变量
		List<String> list = new ArrayList<String>();
		//定义数据源
		ERPDataSource erpDataSource=new ERPDataSource();
		//获取查询sql
		String sqlStr = YGZSqlGenerateUtil.generateSelectERPProjEquipInfoSql(contractId);
		System.out.println(sqlStr);
		//返回结果
		rs = erpDataSource.executeQuery(sqlStr);
		while(rs.next()) {
			list.add(ConvertUtil.getDBStr(rs.getString("equip_id")));
		}
		erpDataSource.close();
		return list;
	}
	/**
	 * 
	 * @throws SQLException 
	 * @Title readERPProjVendProInfoData
	
	 * @Param contractId 合同编号
	
	 * @Description 查询供应商租赁项目信息
	
	 * @Return VendProBean
	
	 * @throw
	 */
	public VendProBean readERPProjVendProInfoData(String contractId,String equip_id) throws SQLException {
		// 1.定义变量
		VendProBean vendProBean = null;
		String sqlStr = "";
		//获取CRM供应商Id
		String idVendor = getCRMIdvendor(contractId,equip_id);
		//获取项目ID与项目名称
		String[] str = getProjIdAndName(contractId);
		//获取部门及项目经理
		String[] deptOwner = getIdOwnerDept(contractId);
		// 2.查询 ERP 数据库
		ERPDataSource erpDataSource=new ERPDataSource();
		//获取查询sql
		sqlStr = YGZSqlGenerateUtil.generateSelectERPVendProjInfoSql(contractId,equip_id);
		System.out.println(sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		//查询结果保存在VendProBean
		while(rs.next()) {
			vendProBean = new VendProBean();
			vendProBean.setSname(ConvertUtil.getDBStr(rs.getString("project_name")));
			vendProBean.setVentype(ConvertUtil.getDBStr(rs.getString("provider_type")));
			vendProBean.setIdpro(str[0]);
			System.out.println("Idpro========" + str[0]);
			vendProBean.setIdvendor(idVendor);
			System.out.println("idVendor========" + idVendor);
			vendProBean.setEquip(ConvertUtil.getDBStr(rs.getString("equip_name")));
			vendProBean.setEquip_id(ConvertUtil.getDBStr(rs.getString("equip_id")));
			vendProBean.setModels(ConvertUtil.getDBStr(rs.getString("equip_model")));
			vendProBean.setProducer(ConvertUtil.getDBStr(rs.getString("equip_manufacturer")));
			vendProBean.setDarrive(rs.getString("fact_date"));
			vendProBean.setPlan_date(ConvertUtil.getDBStr(rs.getString("plan_date")));
			vendProBean.setIddep(deptOwner[0]);
			System.out.println("Iddep========" + deptOwner[0]);
			vendProBean.setIdowner(deptOwner[1]);
			System.out.println("Idowner========" + deptOwner[1]);
			vendProBean.setSflag("1");	
			vendProBean.setQualification_name(ConvertUtil.getDBStr(rs.getString("qualification_name")));
			vendProBean.setQualification_date(rs.getDate("qualification_date"));
			System.out.println("qualification_date========" + rs.getString("qualification_date"));
			vendProBean.setIs_arrive(ConvertUtil.getDBStr(rs.getString("is_arrive")));
		}
		erpDataSource.close();
		return vendProBean;
	}
	
	/**
	 * 获取ERP中供应商类型
	 * 
	 * @param contractId 合同编号
	 * @param equipId 设备编号

	 * @return String

	 * @throws SQLException
	 */
	public String getERPVendorType(String contractId,String equipId) throws SQLException{
		String ventype = "";
		//获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		//执行判断
		String sql = "select kh.lbxlmc from contract_equip_medical cem left join kh_lbxl kh " +
				"on cem.supplier_type_id=kh.id " +
				"where contract_id = '"+contractId+"' and equip_id='"+equipId+"'";
		ResultSet rs = erpDataSource.executeQuery(sql);
		while (rs.next()) {
			ventype = ConvertUtil.getDBStr(rs.getString("lbxlmc"));
		}
		//释放资源
		erpDataSource.close();
		return ventype;
	}
	/**
	 * 获取ERP中供应商ID
	 * 
	 * @param contractId 合同编号
	 * @param equip_id 设备编号
	 * 
	 * @return String
	 * @throws SQLException
	 */
	public String getERPIdvendor(String contractId,String equip_id) throws SQLException{
		String idvendor = "";
		//获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		//执行判断
		String sql = "select provider_id from vi_contract_equip_all_info where contract_id='"+contractId+"' and equip_id='"+equip_id+"'";
		ResultSet rs = erpDataSource.executeQuery(sql);
		while (rs.next()) {
			idvendor = ConvertUtil.getDBStr(rs.getString("provider_id"));
		}
		//释放资源
		erpDataSource.close();
		return idvendor;
	}
	
	/**
	 * 获取CRM中供应商ID
	 * 
	 * @param contractId 合同编号
	 * @param equip_id 设备编号
	 * 
	 * @return String
	 * @throws SQLException
	 */
	public String getCRMIdvendor(String contractId,String equip_id) throws SQLException{
		//定义变量
		String idvendor = "";
		String custId = getERPIdvendor(contractId,equip_id);
		//执行判断
		if (custId == null || "".equals(custId)) {
			LogWriter.logDebug("当前没有供应商ID数据");
		} else {
			//获得连接
			CRMDataSource crmDataSource = new CRMDataSource();
			String sql = "select uuid from vi_cust_2ERP where cust_id='"+custId+"'";
			ResultSet rs = crmDataSource.executeQuery(sql);
			while (rs.next()) {
				idvendor = ConvertUtil.getDBStr(rs.getString("uuid"));
			}
			//释放资源
			crmDataSource.close();
		}
		return idvendor;
	}
	
	/**
	 * 
	 * @throws SQLException 
	 * @Title insertCRMVendProData
	
	 * @Param VendProBean 
	
	 * @Description 回写插入供应商租赁项目信息 
	
	 * @Return int 执行成功返回回写的条目数,执行失败返回0
	
	 * @throw
	 */
	public int insertCRMVendProData(VendProBean vendProBean) throws SQLException {
		//定义变量
		int res = 0;
		//判断该数据是否存在,true更新,false并且是否延期到货为是 插入
		boolean flag = existData(vendProBean);
		if (vendProBean == null) {
			LogWriter.logDebug("当前没有数据需要插入");
		} else {
			//获取连接
			CRMDataSource crmDataSource = new CRMDataSource();
			if(flag){
				String sql = YGZSqlGenerateUtil.getUpdateVendProOfSql(vendProBean);
				System.out.println(sql);
				crmDataSource.executeUpdate(sql);
				res++;
			}else{
				if("是".equals(vendProBean.getIs_arrive())){
					String sql = YGZSqlGenerateUtil.getInsertVendProOfSql(vendProBean);
					System.out.println(sql);
					crmDataSource.executeUpdate(sql);
					res++;
				}
			}
			//释放资源
			crmDataSource.close();
		}
		return res;
	}
	
	
	/**
	 * 判断是否存在供应商租赁项目数据
	 * 
	 * @param vendProBean
	 * 
	 * @return flag 存在返回true,反之返回false
	 * @throws SQLException
	 */
	private boolean existData(VendProBean vendProBean) throws SQLException {
		boolean flag = false;
		// 1.获取连接
		CRMDataSource crmDataSource = new CRMDataSource();
		// 2.执行判断
		String sqlStr = "select id from vend_pro where idpro='"+vendProBean.getIdpro()+"' and equipid='"+vendProBean.getEquip_id()+"'";
		ResultSet rs2 = crmDataSource.executeQuery(sqlStr);
		flag = rs2.next();
		// 3.释放资源
		crmDataSource.close();
		// 返回
		return flag;
	}
	
	/**
	 * 获取CRM中项目ID及项目名称
	 * 
	 * @param contractId 合同编号
	 * 
	 * @return String[]
	 * @throws SQLException
	 */
	public String[] getProjIdAndName(String contractId) throws SQLException{
		//定义变量
		String projId = "";
		String projName = "";
		String projManage = "";
		String subsidiary ="";
		//获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		//执行判断
		String sql = "select p.crm_proj_id,p.project_name,p.proj_manage,p.subsidiary from proj_info p left join contract_info c " +
				"on p.proj_id = c.proj_id where c.contract_id='"+contractId+"'";
		ResultSet rs = erpDataSource.executeQuery(sql);
		while (rs.next()) {
			projId = rs.getString("crm_proj_id");
			projName = ConvertUtil.getDBStr(rs.getString("project_name"));
			projManage = ConvertUtil.getDBStr(rs.getString("proj_manage"));
			subsidiary =ConvertUtil.getDBStr(rs.getString("subsidiary"));
		}
		String[] str = new String[]{projId,projName,projManage,subsidiary};
		//释放资源
		erpDataSource.close();
		return str;
	}
	/**
	 * 
	 * @Title getIdOwnerDept
	
	 * @Param @param contractId
	 * @Param @throws SQLException
	
	 * @Description 查询项目经理ID及部门ID
	
	 * @Return String[]
	
	 * @throw
	 */
	private String[] getIdOwnerDept(String contractId) throws SQLException {
		//定义变量
		String idDep = "";
		String idOwner = "";
		//获取项目ID与项目名称
		String[] str = getProjIdAndName(contractId);
		// 1.获取连接
		CRMDataSource CrmDataSource = new CRMDataSource();
		String emare ="";
		if (str[3]!=null&&str[3].equals("culc_010"))
			emare="da31ae0e7c4b5cfbd956b41816b95415";//北京
		else if (str[3]!=null&&str[3].equals("culc_022"))
			emare="77dd6f2dcf43be58fd2eac8029dcd52b";//天津
		System.out.println("str[3]="+str[3]);
		// 2.执行判断
		String sqlStr = "select id,iddep from org_employee where emarea='"+emare+"' and serpcode='" + str[2] 
				+ "'";
		System.out.println("sqlStr= ============="+sqlStr);
		ResultSet rs = CrmDataSource.executeQuery(sqlStr);
		while (rs.next()) {
			idDep = rs.getString("iddep");
			idOwner = rs.getString("id");
		}
		//将数据添加到数组中
		String[] deptOwner = new String[]{idDep,idOwner,str[0],str[1]};
		// 3.释放资源
		CrmDataSource.close();
		// 返回
		return deptOwner;
	}
	/**
	 * 查询不良信息
	 * 
	 * @Param contractId 合同编号
	 * @Param factDate 实际到货时间
	 * @Param planDate 计划到货时间
	 * @Param equip_id 租赁物件ID
	 * 
	 * @return VbadinfoBean
	 * @throws SQLException
	 */
	public VbadinfoBean readERPProjBadInfoData(String contractId,
			String factDate, String planDate,String equip_id) throws SQLException {
		//格式化时间
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		//定义变量
		Date fDate = null;
		Date pDate = null;
		try {
			fDate = dateFormat.parse(factDate);
			pDate = dateFormat.parse(planDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//获取部门及项目经理
		String[] deptOwner = getIdOwnerDept(contractId);
		//获取CRM中供应商ID
		String Idvendor = getCRMIdvendor(contractId,equip_id);
		//定义不良信息Bean
		VbadinfoBean vbadinfoBean = new VbadinfoBean();
		//保存数据到VbadinfoBean
		vbadinfoBean.setIdpro(deptOwner[2]);
		vbadinfoBean.setSname(deptOwner[3]);
		//判断到货状态是否延期
		if(fDate.after(pDate)){
			vbadinfoBean.setDelivery("是");
		}else{
			vbadinfoBean.setDelivery("否");
		}
		vbadinfoBean.setIdvendor(Idvendor);
		vbadinfoBean.setIddep(deptOwner[0]);
		vbadinfoBean.setIdowner(deptOwner[1]);
		//返回数据
		return vbadinfoBean;
	}
	
	/**
	 * 判断是否存在不良信息数据
	 * 
	 * @param vbadinfoBean
	 * @return
	 * @throws SQLException
	 */
	private boolean existBadData(VbadinfoBean vbadinfoBean) throws SQLException {
		boolean flag = false;
		// 1.获取连接
		CRMDataSource crmDataSource = new CRMDataSource();
		// 2.执行判断
		String sqlStr = "select id from vbadinfo where idpro='"+vbadinfoBean.getIdpro()+"' and idvendor='"+vbadinfoBean.getIdvendor()+"'";
		ResultSet rs2 = crmDataSource.executeQuery(sqlStr);
		flag = rs2.next();
		// 3.释放资源
		crmDataSource.close();
		// 返回
		return flag;
	}
	
	/**
	 * 插入不良信息
	 * 
	 * @param projId
	 * @return
	 * @throws SQLException
	 */
	public int insertCRMBadData(VbadinfoBean vbadinfoBean,String factDate,String planDate) throws SQLException {
		//定义变量
		int res = 0;
		//格式化时间
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date fDate = null;
		Date pDate = null;
		try {
			fDate = dateFormat.parse(factDate);
			pDate = dateFormat.parse(planDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//判断是否存在该条数据
		boolean flag  = existBadData(vbadinfoBean);
		if (vbadinfoBean == null) {
			LogWriter.logDebug("当前没有数据需要插入");
		} else {
			//获取连接
			CRMDataSource crmDataSource = new CRMDataSource();
			//如果该条数据已存在
			if(flag){
				//如果设备到货状态为延期,更新
				if(fDate.after(pDate)){
					//获取更新sql
					String sql = YGZSqlGenerateUtil.getUpdateBadOfSql(vbadinfoBean);
					System.out.println(sql+"=======");
					crmDataSource.executeUpdate(sql);
					res++;
				}else{
					System.out.println("无需更新");
				}
			//如果该条数据不存在,插入
			}else{
				//获取插入sql
				String sql = YGZSqlGenerateUtil.getInsertVbadOfSql(vbadinfoBean);
				System.out.println(sql);
				crmDataSource.executeUpdate(sql);
				res++;
			}
			
			crmDataSource.close();
		}
		return res;
	}
	/**
	 * 
	 * @Title getCountByContractId
	
	 * @Param @param contractId
	 * @Param @throws SQLException
	
	 * @Description  获取指定contract_id的供应商租赁项目数量
	
	 * @Return int
	
	 * @throw
	 */
	public int getCountByContractId(String contractId) throws SQLException{
		int count = 0;
		//获取连接
		ERPDataSource erpDataSource = new ERPDataSource();
		//执行判断
		String sql = "select count(id) c from vi_contract_htzx_erp_crm where contract_id='"+contractId+"'";
		rs = erpDataSource.executeQuery(sql);
		while(rs.next()){
			count = rs.getInt("c");
		}
		//释放资源
		erpDataSource.close();
		return count;
	}
	/**
	 * 
	 * @throws SQLException 
	 * @Title readERPProjVendProInfoData
	
	 * @Param contractId
	
	 * @Description 查询供应商租赁项目信息
	
	 * @Return VendProBean
	
	 * @throw
	 */
	public List<VendProBean> readERPProjVendProInfoData(String contractId) throws SQLException {
		//定义变量
		VendProBean vendProBean = null;
		List<VendProBean> list = new ArrayList<VendProBean>(); 
		String sqlStr = "";
		// 获取连接
		ERPDataSource erpDataSource=new ERPDataSource();
		//获取查询sql
		sqlStr = YGZSqlGenerateUtil.generateSelectERPVendProjInfoSql(contractId);
		System.out.println(sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		//保存数据
		while(rs.next()) {
			vendProBean = new VendProBean();
			vendProBean.setEquip_id(ConvertUtil.getDBStr(rs.getString("equip_id")));
			vendProBean.setDarrive(rs.getString("fact_date"));
			vendProBean.setPlan_date(ConvertUtil.getDBStr(rs.getString("plan_date")));
			list.add(vendProBean);
		}
		//释放资源
		erpDataSource.close();
		return list;
	}
	/**
	 * 
	 * @Title readERPProjZJJHInfoData
	
	 * @Param @param contractId 合同编号
	 * @Param @return
	 * @Param @throws SQLException
	
	 * @Description 查询供应商项目相关银行账号信息
	
	 * @Return List<ContractPlanBean>
	
	 * @throw
	 */
	public List<ContractPlanBean> readERPProjZJJHInfoData(String contractId) throws SQLException {
		//定义变量
		List<ContractPlanBean> contractPlanList = new ArrayList<ContractPlanBean>();
		ContractPlanBean contractPlanBean = null;
		String sqlStr = "";
		String crmSql = "";
		//获取项目ID与项目名称
		String[] str = getProjIdAndName(contractId);
		//获取部门与项目经理
		String[] deptOwner = getIdOwnerDept(contractId);
		//获取连接
		ERPDataSource erpDataSource=new ERPDataSource();
		//获取查询sql语句
		sqlStr = YGZSqlGenerateUtil.generateSelectERPProjZJJHInfoSql(contractId);
		rs = erpDataSource.executeQuery(sqlStr);
		//将数据保存到ContractPlanBean中
		while(rs.next()) {
			String idvendor = "";
			contractPlanBean = new ContractPlanBean();
			contractPlanBean.setContract_id(contractId);
			contractPlanBean.setPay_bank_name(rs.getString("crm_account_id"));
			contractPlanBean.setPay_bank_no(ConvertUtil.getDBStr(rs.getString("pay_bank_no")));
			//contractPlanBean.setPay_obj(ConvertUtil.getDBStr(rs.getString("pay_obj")));
			contractPlanBean.setProj_id(str[0]);
			contractPlanBean.setProjname(str[1]);
			contractPlanBean.setId_dept(deptOwner[0]);
			contractPlanBean.setId_owner(deptOwner[1]);
			idvendor = getUuid(ConvertUtil.getDBStr(rs.getString("pay_obj")));
			contractPlanBean.setPay_obj(idvendor);
			String[] personPhone = getIdPerson(str[0], idvendor);
			contractPlanBean.setId_person(personPhone[0]);
			contractPlanBean.setPhone(personPhone[1]);
			contractPlanList.add(contractPlanBean);
		}
		//释放资源
		erpDataSource.close();
		return contractPlanList;
	}
	/**
	 * 
	 * @param str
	 * 
	 * @return
	 * @throws SQLException
	 */
	public String getUuid(String str) throws SQLException {
			String uuid = "";
			CRMDataSource crmDataSource = new CRMDataSource();
			String sql = "select uuid from vi_cust_2ERP where cust_id='"+str+"'";
			ResultSet rs = crmDataSource.executeQuery(sql);
			while(rs.next()){
				uuid = rs.getString("uuid");
			}
			crmDataSource.close();
		return uuid;
	}
	/**
	 * 获取租赁项目供应商主要联系人
	 * @param projId
	 * @return
	 * @throws SQLException
	 */
	public String[] getIdPerson(String idpro,String idvendor) throws SQLException {
			//定义变量
			String idPerson = "";
			String phone = "";
			//获取连接
			CRMDataSource crmDataSource = new CRMDataSource();
			String sql = "select person_id,phone from proj_vendor_person where project_id='"+idpro+"' " +
					"and vendoraccount_id='"+idvendor+"'";
			ResultSet rs = crmDataSource.executeQuery(sql);
			//保存数据
			while(rs.next()){
				idPerson = ConvertUtil.getDBStr(rs.getString("person_id"));
				phone = ConvertUtil.getDBStr(rs.getString("phone"));
			}
			String[] personPhone = new String[]{idPerson,phone};
			System.out.println(personPhone[0]+"==="+personPhone[1]);
			crmDataSource.close();
			return personPhone;
	}
	/**
	 * 资金计划相关信息插入CRM中
	 * 
	 * @param projId
	 * @return
	 * @throws SQLException
	 */
	public int insertCRMZJJHData(List<ContractPlanBean> contractPlanList) throws SQLException {
		//定义变量
		int res = 0;
		boolean flag = true;
		//判断List是否为空
		if (contractPlanList.size() < 1) {
			LogWriter.logDebug("当前没有数据需要插入");
		} else {
			//获取连接
			CRMDataSource crmDataSource = new CRMDataSource();
			for (ContractPlanBean contractPlanBean : contractPlanList) {
				//判断该条数据是否存在，true无需更新，false插入
				flag = existGYSXMData(contractPlanBean);
				if(flag){
					System.out.println("gysxm无需更新");
				}else{
					//获取插入的sql语句
					String sql = YGZSqlGenerateUtil.getInsertGysxmOfSql(contractPlanBean);
					crmDataSource.executeUpdate(sql);
					res++;
				}
			}
			crmDataSource.close();
		}
		return res;
	}
	/**
	 * 判断是否存在GYSXM信息数据
	 * 
	 * @param cust_id
	 * @return
	 * @throws SQLException
	 */
	private boolean existGYSXMData(ContractPlanBean contractPlanBean) throws SQLException {
		boolean flag = false;
		// 1.获取连接
		CRMDataSource crmDataSource = new CRMDataSource();
		// 2.执行判断
		String sqlStr = "select id from gysxm where idpro='"+contractPlanBean.getProj_id()+"' and idvendor='"+contractPlanBean.getPay_obj()+"'";
		ResultSet rs2 = crmDataSource.executeQuery(sqlStr);
		flag = rs2.next();
		// 3.释放资源
		crmDataSource.close();
		// 返回
		return flag;
	}
}
