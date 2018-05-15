package ServiceImp;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import service.PersonService;



public class PersonServiceImpl implements PersonService {
	public static String mang="oracle.jdbc.driver.OracleDriver";//数据类型
	public static String url="jdbc:oracle:thin:@127.0.0.1:1521:orcl";//datesorue也就是url地址
	public static String users="txzl";
	public static String password="123";
	public static Connection con=null;
	public static Statement st=null;
	public static PreparedStatement ps=null;
	public static StringBuffer objsb=null;//拼接SQL语句
	public static PreparedStatement selectps = null;//查询
	public static PreparedStatement selectsb = null;//查询

	
   /*	 编程思路 ：利用hibernate的特性动态保存对象
	* 动态检索类做insert操作
	*    1、 创建bean对象
	*    2、 创建bean数据库
	*    3、 连接数据库获取表中的每个字段
	*    3、动态匹配数据库的字段和java对象中的成员变量
	*    4、通过method.invoke(java成员变量，参数值value)
	*    5、执行SQL语句
	*/
	@Override
	public <T> void saveEntity(T t) throws Exception {
		    Method method = null;//反射鸡肋
		    Class<?> c = t.getClass();//获取对象
		    Method[] mt=c.getMethods();//代表类的方法；
		    Field[] fields = c.getDeclaredFields();//代表类的成员变量
		    String tablename=c.getSimpleName().toUpperCase();//获取对象,查询数据库中的表一定要大写获取所有字段
		    objsb=new StringBuffer(" insert into "+tablename+"(");//获取对象名称，比如person.  c.getName获取对象地址
		    StringBuffer sbvalue = new StringBuffer();
			Class.forName(mang);
        	con = DriverManager.getConnection(url,users, password);
        	String sqltablecolumns = "SELECT c.COLUMN_NAME as name FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='"
					+ tablename + "' order by c.COLUMN_ID asc ";
        	selectps=con.prepareStatement(sqltablecolumns);
			ResultSet rscolumns = selectps.executeQuery();
			while(rscolumns.next()){//循环检索所有字段
				String columnkey = rscolumns.getString("name");
				String columnnamekey = rscolumns.getString("name").replace("_", "").toUpperCase();//获取表中字段列名并转换为大写
				for (int i = 0; i < fields.length; i++) {
					String fieldNamevalue = fields[i].getName().replace("_", "").toUpperCase();//获取动态对象字段列名并转换为大写
					String fieltype = fields[i].getGenericType().toString(); //获取对象属性的类型
					if (columnnamekey.equals(fieldNamevalue)) {
						objsb.append(columnkey).append(",");		
						sbvalue.append("'"+getFieldValueByName(fields[i].getName(),t)+"',");						
					}
				}
			}
			String insertsql="";
			if(sbvalue.length()>0){
				objsb.deleteCharAt(objsb.length() - 1);
				sbvalue.deleteCharAt(sbvalue.length() - 1);
				insertsql=objsb.toString() + ")values(" + sbvalue.toString()+ ")";
			}
			ps=con.prepareStatement(insertsql);
			ps.executeUpdate();
	    System.out.println("插入成功");
	}

	@Override
	public <T> void updateEntity(T entity) throws Exception {
        
	}

	@Override
	public <T> void removeEntityById(T t,String id ) throws Exception {
		Method method = null;//反射鸡肋
	    Class<?> c = t.getClass();//获取对象	
	    System.out.println("c");
	    String tablename=c.getSimpleName().toUpperCase();//获取对象,查询数据库中的表一定要大写获取所有字段
	   String  sqlStr=" delete from "+tablename+" where id='"+id+"'";//获取对象名称，比如person.  c.getName获取对象地址
	    
	   System.out.println(sqlStr);
	   System.out.println("删除成功");
	    con = DriverManager.getConnection(url,users, password);
	    Statement sss = con.createStatement();
	      sss.executeUpdate(sqlStr);
	    con.close();
	    
	   
	    
	    
	   
	
	    
	}
	
	public <T> void removeEntity(T t ) throws Exception {
			    	  	  	 	    
	}

/*	@Override
	public <T> T findEntityByID(Class<T> entityClass, String id)
			throws DataAccessException, Exception {
		return null;
	}*/
	private static   <T> Object getFieldValueByName(String fieldName,T t ) {
		//t代表对象地址
		try {
			String firstLetter = fieldName.substring(0, 1).toUpperCase();
			String getter = "get" + firstLetter + fieldName.substring(1);//输出getName
			System.out.println(getter);
			//获取对象所在的位子比如public java.lang.String com.tenwa.server.bean.Person.getName()
			Method method = t.getClass().getMethod(getter, new Class[] {});
			Object value = method.invoke(t,new Object[] {});
			System.out.println(method+"==="+value);
			if (value == null) {
				value = "";
			}
			return value;
		} catch (Exception e) {
			e.getMessage();
			e.printStackTrace();
			return null;
		}
	}

	

	@Override
	public <T> void removeAll(T t) throws Exception {
		Method method = null;//反射鸡肋
	    Class<?> c = t.getClass();//获取对象	
	    System.out.println("c");
	    String tablename=c.getSimpleName().toUpperCase();//获取对象,查询数据库中的表一定要大写获取所有字段
	   String  sqlStr=" delete from "+tablename;//获取对象名称，比如person.  c.getName获取对象地址
	    
	   System.out.println(sqlStr);
	   System.out.println("删除成功");
	    con = DriverManager.getConnection(url,users, password);
	    Statement sss = con.createStatement();
	      sss.executeUpdate(sqlStr);
	    con.close();
		
	}    

	@Override
	public <T> List<T> findEntityByID(Class<T> entityClass,T t, String id) throws Exception {
		Class<?> c = t.getClass();//获取对象			  
		  String tablename=c.getSimpleName().toUpperCase();//获取对象,查询数据库中的表一定要大写获取所有字段
		  List<T> list=new  ArrayList<T>();
		String sqlStr="select * from "+tablename+" where  id='"+id+"'";
		System.out.println(sqlStr);
		 con = DriverManager.getConnection(url,users, password);
		    Statement sss = con.createStatement();
		    ResultSet rs= sss.executeQuery(sqlStr);
		    
		  while(rs.next()){			 
			 T ccc= entityClass.newInstance();//获取实例对象
			 ccc=getResultSetObj(ccc, rs, tablename);
			 list.add(ccc);
			 
		  }
		 
	
		return list;
	}
	
	public static <T> T getResultSetObj(T entity, ResultSet rs,String tablename) throws SQLException {
		// 1获取SQL service连接
		Method method = null;
		con = DriverManager.getConnection(url,users, password);
		 Statement sss = con.createStatement();
		try {
			String sqltablecolumns = "SELECT c.COLUMN_NAME as name FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='"
					+ tablename + "' order by c.COLUMN_ID asc ";
			ResultSet rscolumns = sss.executeQuery(sqltablecolumns);
			Field[] fields = entity.getClass().getDeclaredFields();
			
			while (rscolumns.next()) {
				String columnname = rscolumns.getString("name");//列名
				String key = columnname.replace("_", "").toUpperCase();
				for (int i = 0; i < fields.length; i++) {
					String fieldName = fields[i].getName();
					String value = fieldName.replace("_", "").toUpperCase();
					 String type = fields[i].getGenericType().toString(); // 获取属性的类型
					if (key.equals(value)) {
						String firstLetter = fieldName.substring(0, 1).toUpperCase();
						String setter = "set" +firstLetter+fieldName.substring(1);
						//System.out.println(key+"11"+value+"22"+fieldName+"333"+ fieldName+"44");
						 if("class java.lang.String".equals(type)){
						  method = entity.getClass().getMethod(setter,String.class);
						 String ee =  rs.getString(columnname);
						  method.invoke(entity,rs.getString(columnname));
						 }else if("class java.lang.Integer".equals(type)){
						  method = entity.getClass().getMethod(setter,Integer.class);
						 // System.out.println(setter+"---"+rs.getString(columnname)+"==="+type);
						  method.invoke(entity,("".equals(rs.getString(columnname))||null==rs.getString(columnname) ) ?null:Integer.parseInt(rs.getString(columnname)));
						 }else if("class java.math.BigDecimal".equals(type)){
						//	 System.out.println(setter+"---"+rs.getString(columnname)+"==="+type);
						  method = entity.getClass().getMethod(setter,BigDecimal.class);
						  method.invoke(entity,("".equals(rs.getString(columnname))||null==rs.getString(columnname) ) ?null:new BigDecimal(rs.getString(columnname))); 
						 }else{
						//	 System.out.println(type+"4444"+rs.getString(columnname)+"000"+columnname);	 
							 
						 }
						
					
					   break;
					}
				}

			}
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			con.close();
		}

		return entity;

	}

	@Override
	public <T> List<T> findAllEntity(Class<T> entityClass, Map<String, Object> map) throws Exception {
		List<T> list=new ArrayList<T>();
		 Method method = null;//反射鸡肋
		 Class<?> c = entityClass.newInstance().getClass();//获取对象
		 Method[] mt=c.getMethods();//代表类的方法；
		 Field[] fields = c.getDeclaredFields();//代表类的成员变量
		 String tablename=c.getSimpleName().toUpperCase();//获取对象,查询数据库中的表一定要大写获取所有字段
		 objsb=new StringBuffer(" select * from "+tablename +" where 1=1");//获取对象名称，比如person.  c.getName获取对象地址
		 StringBuffer sbvalue = new StringBuffer();
	     Class.forName(mang);
     	 con = DriverManager.getConnection(url,users, password);
     	 String sqltablecolumns = "SELECT c.COLUMN_NAME as name FROM USER_TAB_COLUMNS c  where c.TABLE_NAME='"
					+ tablename + "' order by c.COLUMN_ID asc ";
     	 selectps=con.prepareStatement(sqltablecolumns);
			ResultSet rscolumns = selectps.executeQuery();
			List<String> listcolumn=new ArrayList<String>();
			while(rscolumns.next()){//循环检索所有字段
				String columnkey = rscolumns.getString("name");
               if(!listcolumn.contains(listcolumn.add(columnkey))){
            	   listcolumn.add(columnkey);
				}
				String columnnamekey = rscolumns.getString("name").replace("_", "").toUpperCase();//获取表中字段列名并转换为大写
				for (int i = 0; i < fields.length; i++) {
					String fieldNamevalue = fields[i].getName().replace("_", "").toUpperCase();//获取动态对象字段列名并转换为大写
					String fieltype = fields[i].getGenericType().toString(); //获取对象属性的类型
					for (String  keymap : map.keySet()) {
						if (columnnamekey.equals(fieldNamevalue)&&columnnamekey.equals(keymap.toUpperCase())) {
							objsb.append(" and "+columnkey+"='"+map.get(keymap)+"'");
						  
							
						}
					}
				}
			}
			selectsb=con.prepareStatement(objsb.toString());
			ResultSet rs = selectsb.executeQuery();
			T t=null;
			while(rs.next()){
				t=entityClass.newInstance();
				for(int u=0;listcolumn.size()>u;u++){
					String columnname = listcolumn.get(u);//列名
					String key = columnname.replace("_", "").toUpperCase();
					for (int y = 0; y < fields.length; y++) {
						String fieldName = fields[y].getName();
						String value = fieldName.replace("_", "").toUpperCase();
						 String type = fields[y].getGenericType().toString(); // 获取属性的类型
						if (key.equals(value)) {
							String firstLetter = fieldName.substring(0, 1).toUpperCase();
							String setter = "set" +firstLetter+fieldName.substring(1);
							 if("class java.lang.String".equals(type)){
							  method = t.getClass().getMethod(setter,String.class);
							  method.invoke(t,rs.getString(columnname));
							 }else if("class java.lang.Integer".equals(type)){
							  method = t.getClass().getMethod(setter,Integer.class);
							  method.invoke(t,("".equals(rs.getString(columnname))||null==rs.getString(columnname) ) ?null:Integer.parseInt(rs.getString(columnname)));
							 }else if("class java.math.BigDecimal".equals(type)){
							  method = t.getClass().getMethod(setter,BigDecimal.class);
							  method.invoke(t,("".equals(rs.getString(columnname))||null==rs.getString(columnname) ) ?null:new BigDecimal(rs.getString(columnname))); 
							 }else{
							 }
						
						}
					}

				}
				list.add(t);
			}
		return list;
	}
	
	
}
