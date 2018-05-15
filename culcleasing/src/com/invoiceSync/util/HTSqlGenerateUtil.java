package com.invoiceSync.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.bean.InterContractInfo;
import com.tenwa.bean.InterFinaBeginInfo;
import com.tenwa.bean.InterFinaContractCondition;
import com.tenwa.culc.calc.util.YongYouDataSource;
import com.tenwa.culc.util.CommonTool;





/**
 * @author kevin
 * SQL������ɹ���
 * 2017-11-16 
 * 
 */
public class HTSqlGenerateUtil {

	private static  ResultSet rs = null;
	
	
	/**��ѯ��Ŀ������Ϣ
	 * @param proj_id
	 * @return
	 */
	public static String generateSelectProjInfoSql(String proj_id) {
		
		StringBuffer sqlStr = new StringBuffer();
		if(null!=proj_id && !"".equals(proj_id)){
			sqlStr.append("select * ")
					.append("from vi_inter_proj_info vpi ")
					.append("where proj_id='"+proj_id+"'");
		}else{
			sqlStr.append("select * ")
			.append("from vi_inter_proj_info vpi ")
			.append("where proj_status is not null and  not exists ( ")
			.append("select id from YY_ERP_DATA_SYNC_INFO info where  info.pri_id=vpi.proj_id and info.status_name=vpi.proj_status ")
			.append(")");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}
	
	/**��ѯ��ͬ������Ϣ
	 * @param contract_id
	 * @return
	 */
	public static String generateSelectContractInfoSql(String contract_id) {
		
		StringBuffer sqlStr = new StringBuffer();
		if(null!=contract_id && !"".equals(contract_id)){
			sqlStr.append("select * ")
					.append("from vi_inter_contract_info  ")
					.append(" where contract_id='"+contract_id+"'");
		}else{
			sqlStr.append("select * from vi_inter_contract_info c where not exists (")
			      .append("select 1 from YY_ERP_DATA_SYNC_INFO info  INNER JOIN YY_ERP_DATA_SYNC_LOG YY_LOG on info.oper_id=YY_LOG.oper_id where oper_name like '%��ͬ������Ϣ%' and info.pri_id = c.contract_id and info.status_name = c.proj_status)");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}
	public static String generatecontractInfoSql(InterContractInfo interProjInfoBean) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		
		
		
		sqlStr.append("insert into inter_contract_info(id,company_name,proj_id,contract_id,contract_type,project_name,cust_name,cont_ratio,")
		    .append("proj_dept,proj_area,industry_type,leas_type,medical_revenue,hospital_scale_level,")
		    .append("qualification_grade,hyxlmc,proj_manager,sign_date,proj_status,spare_column1,")
		    .append("spare_column2,spare_column3,spare_column4,spare_column5,spare_column6,spare_column7,spare_column8,")
		    .append("spare_column9,spare_column10,create_date,creator,flag,oper_id)")
			.append("values(")
			.append("'" + interProjInfoBean.getId() +"','"
					+ interProjInfoBean.getCompanyName() +"','"
					+ interProjInfoBean.getProjId() +"','"
					+ interProjInfoBean.getContractId() +"','"
					+ interProjInfoBean.getContractType() +"','"
					+ interProjInfoBean.getProjectName() +"','"
					+ interProjInfoBean.getCustName() +"','"
					+ interProjInfoBean.getContRatio() +"','"
					+ interProjInfoBean.getProjDept() +"','"
					+ interProjInfoBean.getProjArea() +"','"
					+ interProjInfoBean.getIndustryType() +"','"
					+ interProjInfoBean.getLeasType() +"','"
					+ interProjInfoBean.getMedicalRevenue() +"','"
					+ interProjInfoBean.getHospitalScaleLevel() +"','"
					+ interProjInfoBean.getQualificationGrade() +"','"
					+ interProjInfoBean.getHyxlmc() +"','"
					+ interProjInfoBean.getProjManager() +"','"
					+ interProjInfoBean.getSignDate() +"','"
					+ interProjInfoBean.getProjStatus() +"','"
					+ interProjInfoBean.getSpareColumn1() +"','"
					+ interProjInfoBean.getSpareColumn2() +"','"
					+ interProjInfoBean.getSpareColumn3() +"','"
					+ interProjInfoBean.getSpareColumn4() +"','"
					+ interProjInfoBean.getSpareColumn5() +"','"
					+ interProjInfoBean.getSpareColumn6() +"','"
					+ interProjInfoBean.getSpareColumn7() +"','"
					+ interProjInfoBean.getSpareColumn8() +"','"
					+ interProjInfoBean.getSpareColumn9() +"','"
					+ interProjInfoBean.getSpareColumn10() +"','"
					+ interProjInfoBean.getCreateDate() +"','"
					+ interProjInfoBean.getCreator() +"','"
					+ interProjInfoBean.getFlag() +"','"
				+ interProjInfoBean.getOPER_ID() + "'");
			sqlStr.append(")");
		System.out.println(sqlStr.toString());
		
		return sqlStr.toString();
	}
	
	
	/**
	 * @param table_name  ��Ҫ���µı������
	 * @param key_type    ��Ҫ���µ� where����������
	 * @param proj_id     where������ֵ
	 * @return
	 */
	public static String generateUpdateProjInfoFlag(String table_name,String key_type,String proj_id){
		StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("update "+table_name+" set flag= 1 where "+key_type+"= '"+proj_id+"'");
		return sqlStr.toString();
	}
	
	
	/**
	 * �������
	 * @param interProjInfoBean
	 * @return
	 */
//	public static String generateInsertProjInfoSql(	InterProjInfoBean interProjInfoBean) {
//		// 1Buffer����
//		StringBuffer sqlStr = new StringBuffer();
//		sqlStr.append("insert into inter_proj_info(id,company_name,proj_id,contract_type,project_name,cust_name,proj_dept_,proj_area,industry_type,")
//			.append("leas_type,medical_revenue,hospital_scale_level,")
//			.append("qualification_grade,hyxlmc,proj_manager,proj_date,proj_status,")
//			.append("spare_column1,spare_column3,spare_column4,spare_column5,")
//			.append("spare_column6,spare_column7,spare_column8,spare_column9,spare_column10,create_date,creator,flag,oper_id)")
//		    .append("values(")
//			.append("'" + interProjInfoBean.getId() +"','"
//					+ interProjInfoBean.getCompanyName() +"','"
//					+ interProjInfoBean.getProjId() +"','"
//					+ interProjInfoBean.getContractType() +"','"
//					+ interProjInfoBean.getProjectName() +"','"
//					+ interProjInfoBean.getCustName() +"','"
//					+ interProjInfoBean.getProjDept() +"','"
//					+ interProjInfoBean.getProjArea() +"','"
//					+ interProjInfoBean.getIndustryType() +"','"
//					+ interProjInfoBean.getLeasType() +"','"
//					+ interProjInfoBean.getMedicalRevenue() +"','"
//					+ interProjInfoBean.getHospitalScaleLevel() +"','"
//					+ interProjInfoBean.getQualificationGrade() +"','"
//					+ interProjInfoBean.getHyxlmc() +"','"
//					+ interProjInfoBean.getProjManager() +"','"
//					+ interProjInfoBean.getProjDate() +"','"
//					+ interProjInfoBean.getProjStatus() +"','"
//					+ interProjInfoBean.getSpareColumn1() +"','"
//					+ interProjInfoBean.getSpareColumn2() +"','"
//					+ interProjInfoBean.getSpareColumn3() +"','"
//					+ interProjInfoBean.getSpareColumn4() +"','"
//					+ interProjInfoBean.getSpareColumn5() +"','"
//					+ interProjInfoBean.getSpareColumn6() +"','"
//					+ interProjInfoBean.getSpareColumn7() +"','"
//					+ interProjInfoBean.getSpareColumn8() +"','"
//					+ interProjInfoBean.getSpareColumn9() +"','"
//					+ interProjInfoBean.getSpareColumn10() +"','"
//					+ interProjInfoBean.getCreateDate() +"','"
//					+ interProjInfoBean.getCreator() +"','"
//					+ interProjInfoBean.getFlag() +"','"
//					+ interProjInfoBean.getOPER_ID() +"'");
//			sqlStr.append(")");
//		
//		
//		return sqlStr.toString();
//	}
	
	/**
	 * ��Ŀ��Ϣ������־
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @return
	 */
	public static String generateDataSyncProjInfoLog(int insAmount,
			int updAmount, String oper_id,String oper_type_name,String datasynctype) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr
				.append(
						"Insert into YY_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
				.append("update_amount,insert_amount) ");

		sqlStr.append(" values('" + oper_id
				+ "','"+datasynctype+"','"+oper_type_name+"����ͬ��','��','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "','"
				+ updAmount + "','" + insAmount + "')");
		System.out.println(sqlStr.toString());
		// 3����
		return sqlStr.toString();
	}
	
	/**
	 * ��������ͬ����Ϣ
	 * 
	 * @param oper_id
	 * @param pri_id
	 * @return
	 */
	public static String generateDataSyncDBInfo(String oper_id, String pri_id,String status_name) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr
				.append(
						"Insert into YY_ERP_DATA_SYNC_INFO(pri_id,status_name,oper_id,create_date)")
				.append("values('" + pri_id + "','"+status_name+"','" + oper_id + "',getdate())");
		// 3����
		return sqlStr.toString();
	}
	
	//2��������insert   oracle����2
	public static String generatecontractConditionSql(InterFinaContractCondition interProjInfoBean) throws SQLException {
    	YongYouDataSource	single = new YongYouDataSource();
		String sqltablecolumns = "SELECT c.COLUMN_NAME as columnname FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='INTER_FINA_CONTRACT_CONDITION' order by c.COLUMN_ID asc ";		
		  rs=single.executeQuery(sqltablecolumns);
		StringBuffer sbkey = new StringBuffer(); 
		while(rs.next()){
			//���������
			sbkey.append(rs.getString("columnname")).append(",");
		}
		sbkey.deleteCharAt(sbkey.length()-1);

	    String strvalue=getFiledName(interProjInfoBean);//��ȡ��������ֵ	
		
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into inter_fina_contract_condition("+sbkey.toString()+")")
		.append("values(").append(strvalue+")");
		System.out.println(sqlStr.toString());
		single.close();
		return sqlStr.toString();
	}
	/**��ѯ����������Ϣ
	 * @param contract_id
	 * @return
	 */ 
	//2��������select  sql server����
	public static String generateSelectContractContionInfoSql(String contract_id) {
		
		StringBuffer sqlStr = new StringBuffer();
		if(null!=contract_id && !"".equals(contract_id)){
			sqlStr.append("select * ")
					.append("from vi_inter_fina_contract_condition  ")
					.append(" where contract_id='"+contract_id+"'");
		}else{
			sqlStr.append("select * from vi_inter_fina_contract_condition c where not exists (")
		      .append("select 1 from YY_ERP_DATA_SYNC_INFO info left join YY_ERP_DATA_SYNC_LOG yy on info.oper_id=yy.oper_id where yy.oper_name='[����������Ϣ]����ͬ��' and info.pri_id = c.contract_id and info.status_name = c.proj_status) and c.proj_status is not null");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}

	
	//3������Ϣinsert     oracle����
	public static String generateFinaBeginInfoSql(InterFinaBeginInfo finabeginfo) throws SQLException {
    	YongYouDataSource	single = new YongYouDataSource();
		String sqltablecolumns = "SELECT c.COLUMN_NAME as columnname FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='INTER_FINA_BEGIN_INFO' order by c.COLUMN_ID asc ";		
		  rs=single.executeQuery(sqltablecolumns);
	 
		StringBuffer sbkey = new StringBuffer(); 
		while(rs.next()){
			//���������
			sbkey.append(rs.getString("columnname")).append(",");
			
		}
		sbkey.deleteCharAt(sbkey.length()-1);
	     String strvalue=getFiledName(finabeginfo);//��ȡ��������ֵ	
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into inter_fina_begin_info("+sbkey.toString()+")")
			.append("values(").append(strvalue+")");
		
		System.out.println(sqlStr.toString());
		single.close();
		return sqlStr.toString();
	}
	/**��ѯ��ͬ������Ϣ
	 * @param contract_id
	 * @return  VI_INTER_FINA_BEGIN_INFNO
	 */
	//3������Ϣselect  sql server����
	public static String generateSelectFinaBeginInfoSql(String begin_id) {
		
		StringBuffer sqlStr = new StringBuffer();
		if(null!=begin_id && !"".equals(begin_id)){
			sqlStr.append("select * ")
					.append("from vi_inter_fina_begin_info  ")
					.append(" where begin_id='"+begin_id+"'");
		}else{
			sqlStr.append("select * from vi_inter_fina_begin_info c where  not exists (")
			.append(" select 1 from YY_ERP_DATA_SYNC_INFO info  INNER JOIN YY_ERP_DATA_SYNC_LOG YY_LOG on info.oper_id=YY_LOG.oper_id where oper_name like '%��ͬ������Ϣ%'   and  info.pri_id = c.begin_id and info.status_name = proj_status)");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}	

	   /** 
	    * ��ȡ������
	    * */  
	  private static String getFiledName(Object o){  
	    Field[] fields=o.getClass().getDeclaredFields();  
	        String[] fieldNames=new String[fields.length]; 
	        StringBuffer sb = new StringBuffer();    
	    for(int i=0;i<fields.length;i++){  
	        //System.out.println(fields[i].getType());//�����ж����� 
	        fieldNames[i]=fields[i].getName();
	        sb.append("'"+getFieldValueByName(fields[i].getName(),o)+"',");
	    }  
	    sb.deleteCharAt(sb.length()-1);
	    return sb.toString();  
	   } 
 
	   /** 
	    * ������������ȡ����ֵ 
	    * */  
	private static Object getFieldValueByName(String fieldName, Object o) {
	    
	     try {    
	              String firstLetter = fieldName.substring(0, 1).toUpperCase(); 
	              String getter = "get" + firstLetter + fieldName.substring(1);
	              System.out.println(fieldName+"------");
	              Method method = o.getClass().getMethod(getter, new Class[] {});    
	              Object value = method.invoke(o, new Object[] {});
	              if(value==null){
	            	  
	            	  value="";
	              }
	              return value;    
	       } catch (Exception e) {    
	              e.getMessage();
	              return null;    
	       }    
	   } 
	//��ȡERP���е�����
	public static String getAllTableColumnSQL(String column,String tablename) {
		
		StringBuffer sqlStr = new StringBuffer("select * from "+tablename+" where 1=1 ");
		if(null!=column && !"".equals(column)){
		  sqlStr.append(" and acc_number='").append(column).append("'");
		}else{
	     sqlStr.append("select * from "+tablename+" where 1=1 ");
			
		}
		sqlStr.append("");
		return sqlStr.toString();
	}
	
	//��ȡERP�����˺Żش����е�����
	public static String getAllFactoringBankColumnSQL(String column,String tablename) {
		
		StringBuffer sqlStr = new StringBuffer("select * from "+tablename+" where 1=1 ");
		if(null!=column && !"".equals(column)){
		  sqlStr.append(" and begin_id='").append(column).append("'");
		}else{
			sqlStr.append(" and read_flag=0");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}
	//10�����ʲ���Ϣselect  sql server����
	public static String generateSelectAssetsInfoSql(String contract_id) {
		
		StringBuffer sqlStr = new StringBuffer();
		if(null!=contract_id && !"".equals(contract_id)){
			sqlStr.append("select * ")
					.append("from vi_inter_assets_info  ")
					.append(" where contract_id='"+contract_id+"'");
		}else{
			sqlStr.append("select * from vi_inter_assets_info info ")
		.append("where not exists (select 1 from YY_ERP_DATA_SYNC_INFO tt where tt.status_name = '[�����ʲ���Ϣ]' and tt.pri_id = info.contract_id)");
		}
		sqlStr.append("");
		return sqlStr.toString();
	}
	public static String getDataSyncDBInfoALL(String oper_id, String proj_id,String contract_id,String plan_id,String status_name,String plan_status) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr
				.append(
						"Insert into YY_ERP_DATA_SYNC_INFO_CONTRACT(proj_id,contract_id,plan_id,status_name,oper_id,create_date,plan_status)")
				.append("values('" + proj_id + "','"+contract_id+"','"+plan_id+"','"+status_name+"','" + oper_id + "',getdate(),'"+plan_status+"')");
		// 3����
		return sqlStr.toString();
	}
	
	//��������ķ��������� rent_list  ��   flag�ֶΣ�flag�ֶα����Ч��Ч�����ڴ������ƻ�������Щ���ݱ�ɾ���ˣ�ԭ��SQLʶ�𲻳������������������ͬ��һ�Σ��Ѵ�plan_id��ʶΪ1 Ϊ�����ڴ�
	public static String getDataSyncDBInfoALL2(String oper_id, String proj_id,String contract_id,String plan_id,String rent_list,String status_name,String plan_status) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr
				.append(
						"Insert into YY_ERP_DATA_SYNC_INFO_CONTRACT(proj_id,contract_id,plan_id,status_name,rent_list,oper_id,create_date,plan_status,flag)")
				.append("values('" + proj_id + "','"+contract_id+"','"+plan_id+"','"+status_name+"','" + rent_list + "','" + oper_id + "',getdate(),'"+plan_status+"',0)");
		// 3����
		return sqlStr.toString();
	}
	public static String getDataSyncDBPlanInfoALL(String oper_id, String proj_id,String contract_id,String plan_id,String status_name,String plan_status,String sync_type_name) {
		// 1Buffer����
		StringBuffer sqlStr = new StringBuffer();
		// 2ƴ��sql
		sqlStr
				.append(
						"Insert into YY_ERP_DATA_SYNC_INFO_CONTRACT(proj_id,contract_id,plan_id,status_name,oper_id,create_date,plan_status,plan_type_name)")
				.append("values('" + proj_id + "','"+contract_id+"','"+plan_id+"','"+status_name+"','" + oper_id + "',getdate(),'"+plan_status+"','"+sync_type_name+"')");
		// 3����
		return sqlStr.toString();
	}
	
}
