package com.invoiceSync.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.invoiceSync.log.HTLogWriter;
import com.tenwa.bean.InterContractInfo;
import com.tenwa.bean.InterFinaBeginInfo;
import com.tenwa.bean.InterFinaContractCondition;
import com.tenwa.culc.calc.util.YongYouDataSource;
import com.tenwa.culc.util.CommonTool;





/**
 * @author kevin
 * SQL语句生成工具
 * 2017-11-16 
 * 
 */
public class HangTianSqlGenerateUtil {

	private static  ResultSet rs = null;
	
	
	
	
	
	
	/**
	 * @param table_name  需要更新的表的名称
	 * @param key_type    需要更新的 where条件的列名
	 * @param proj_id     where条件的值
	 * @return
	 */
	public static String generateUpdateProjInfoFlag(String table_name,String key_type,String proj_id){
		StringBuffer sqlStr = new StringBuffer();
			sqlStr.append("update "+table_name+" set flag= 1 where "+key_type+"= '"+proj_id+"'");
		return sqlStr.toString();
	}
	
	
	
	/**
	 * 项目信息数据日志
	 * 
	 * @param insAmount
	 * @param updAmount
	 * @param oper_id
	 * @return
	 */
	public static String generateDataSyncProjInfoLog(int insAmount,
			int updAmount, String oper_id,String oper_type_name,String datasynctype) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into HT_ERP_DATA_SYNC_LOG(oper_id,oper_type,oper_name,oper_remark,oper_date,")
				.append("update_amount,insert_amount) ");

		sqlStr.append(" values('" + oper_id
				+ "','"+datasynctype+"','"+oper_type_name+"数据同步','无','"
				+ CommonTool.getSysDate("yyyy-MM-dd HH:mm:dd") + "','"
				+ updAmount + "','" + insAmount + "')");
		System.out.println(sqlStr.toString());
		// 3返回
		return sqlStr.toString();
	}
	
	
	
	//2商务条件insert   oracle连接2
	public static String generatecontractConditionSql(InterFinaContractCondition interProjInfoBean) throws SQLException {
    	YongYouDataSource	single = new YongYouDataSource();
		String sqltablecolumns = "SELECT c.COLUMN_NAME as columnname FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='INTER_FINA_CONTRACT_CONDITION' order by c.COLUMN_ID asc ";		
		  rs=single.executeQuery(sqltablecolumns);
		StringBuffer sbkey = new StringBuffer(); 
		while(rs.next()){
			//添加所有列
			sbkey.append(rs.getString("columnname")).append(",");
		}
		sbkey.deleteCharAt(sbkey.length()-1);

	    String strvalue=getFiledName(interProjInfoBean);//获取所有属性值	
		
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into inter_fina_contract_condition("+sbkey.toString()+")")
		.append("values(").append(strvalue+")");
		System.out.println(sqlStr.toString());
		single.close();
		return sqlStr.toString();
	}
	

	
	//3起租信息insert     oracle连接
	public static String generateFinaBeginInfoSql(InterFinaBeginInfo finabeginfo) throws SQLException {
    	YongYouDataSource	single = new YongYouDataSource();
		String sqltablecolumns = "SELECT c.COLUMN_NAME as columnname FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='INTER_FINA_BEGIN_INFO' order by c.COLUMN_ID asc ";		
		  rs=single.executeQuery(sqltablecolumns);
	 
		StringBuffer sbkey = new StringBuffer(); 
		while(rs.next()){
			//添加所有列
			sbkey.append(rs.getString("columnname")).append(",");
			
		}
		sbkey.deleteCharAt(sbkey.length()-1);
	     String strvalue=getFiledName(finabeginfo);//获取所有属性值	
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		sqlStr.append("insert into inter_fina_begin_info("+sbkey.toString()+")")
			.append("values(").append(strvalue+")");
		
		System.out.println(sqlStr.toString());
		single.close();
		return sqlStr.toString();
	}
		

	   /** 
	    * 获取属性名
	    * */  
	  private static String getFiledName(Object o){  
	    Field[] fields=o.getClass().getDeclaredFields();  
	        String[] fieldNames=new String[fields.length]; 
	        StringBuffer sb = new StringBuffer();    
	    for(int i=0;i<fields.length;i++){  
	        //System.out.println(fields[i].getType());//用来判断类型 
	        fieldNames[i]=fields[i].getName();
	        sb.append("'"+getFieldValueByName(fields[i].getName(),o)+"',");
	    }  
	    sb.deleteCharAt(sb.length()-1);
	    return sb.toString();  
	   } 
 
	   /** 
	    * 根据属性名获取属性值 
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
	//获取ERP表中的数据
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
	
	
	public static String getDataSyncDBPlanInfoALLinvoice(String oper_id, String out_no,String cust_name,String status_name) {
		// 1Buffer对象
		StringBuffer sqlStr = new StringBuffer();
		// 2拼接sql
		sqlStr
				.append(
						"Insert into HT_ERP_DATA_SYNC_INFO(pri_id,oper_id,cust_name,status_name,create_date,modificator,modify_date)")
				.append("values('" + out_no + "','"+oper_id+"','"+cust_name+"','0',getdate(),'','')");
		// 3返回
		return sqlStr.toString();
	}
	
	
}
