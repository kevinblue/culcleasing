<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ include file="../../func/common_simple.jsp"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.File" %>
<%@ page import="com.tenwa.culc.service.ProjInfoWriteService" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//基本变量
String sqlstr;
String czy = (String) session.getAttribute("czyid");//当前登陆人
System.out.println("[[[[[[[]]]]]]]"+czy);
String datestr = getSystemDate(0); //获取系统时间

String contract_id="";
String equip_id ="";
String table_type ="";
String plan_date = "";
String equip_status = "";
String table="";
String fact_date = "";
String is_arrive = "";

String uid="";
int i;
String fj = "";
String fj_flag = "0";
String fj_name = "0";
String Description = "";
String filePath;
String fileName = "";
int flag = 0;


//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
fileBean.setObjectPath( path + "\\uploadEquipDoc\\" );

//设定上传附件总体大小限制
fileBean.setSize(8*1024*1024);

//设定上传附件文件类型
fileBean.setSuffix(".zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt");

//设定上传用户ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   uid=czy.substring(7);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
System.out.println("测试iCount"+iCount);
String sObjectPath = fileBean.getObjectPath();
System.out.println("测试sObjectPath"+sObjectPath);

if( Description.indexOf("出错") < 0 ) {
      
                contract_id = fileBean.getFieldValue("contract_id"); 
				equip_id = fileBean.getFieldValue("equip_id");
				table_type = fileBean.getFieldValue("table_type");  
				plan_date = fileBean.getFieldValue("plan_date"); 
				equip_status = fileBean.getFieldValue("equip_status");
				fact_date = fileBean.getFieldValue("fact_date");
				is_arrive = fileBean.getFieldValue("isDeliver");
				    if(table_type.equals("机电")){
					table="dbo.contract_equip_machine";
					}else if(table_type.equals("教育")){
					table="dbo.contract_equip_education";
					}else if(table_type.equals("船舶")){
					table="dbo.contract_equip_ship";
					}else if(table_type.equals("通用")){
					table="dbo.contract_equip_common";
					}else if(table_type.equals("医疗事业")){
					table="dbo.contract_equip_medical";
					}
				//修改计划到货时间，状态
			    sqlstr = "update "+table+" set plan_date='"+plan_date+"',fact_date='"+fact_date+"',equip_status=(select title from dbo.ifelc_conf_dictionary where name='"+equip_status+"'),is_arrive='"+is_arrive+"' where contract_id='"+contract_id+"' and equip_id='"+equip_id+"'";
			    System.out.println("*************"+sqlstr);
               	flag = db.executeUpdate(sqlstr);
				//先删除附件
			    filePath = pageContext.getServletContext().getRealPath("/") + "\\uploadEquipDoc\\";
				System.out.println("file="+filePath);
				sqlstr = "select * from upload_doc where contract_id='"+contract_id+"' and equip_id='"+equip_id+"'";
				System.out.println("sqlstr========"+sqlstr);
				int upload_id = 0;
                ResultSet rs = db.executeQuery(sqlstr);
				if( rs.next() ){	
					upload_id = rs.getInt("id");
					sqlstr = "update upload_doc set flag='1',modificator='"+czy+"',modify_date=getdate() where contract_id='"+contract_id+"' and equip_id='"+equip_id+"'";
					flag += db.executeUpdate(sqlstr);
				}else{
					sqlstr = "insert into upload_doc (contract_id,equip_id,creator,create_date,flag) values('"+contract_id+"','"+equip_id+"','"+czy+"',getdate(),'0')";
	               	flag += db.executeUpdate(sqlstr);
					sqlstr = "select * from upload_doc where contract_id='"+contract_id+"' and equip_id='"+equip_id+"'";
					rs = db.executeQuery(sqlstr);
					if(rs.next()){
						upload_id = rs.getInt("id");
					}
				}
				for ( i = 0;i < iCount;i++ ) {
					   if ( saSourceFile[i] == null || saSourceFile[i].equals("") ) {

					   }else {
					     fj = "<a href=../../uploadEquipDoc/" + saObjectFile[i] + " target=_blank>" + saObjectFile[i] + "</a><br>";
					     sqlstr = "insert into upload_doc_detail(pid,upload_file_path,creator,create_date,flag) values("+upload_id+",'"+fj+"','"+czy+"',getdate(),'0')";
					     Description = Description + "<br>" + saDescription[i];
					     db.executeUpdate(sqlstr);
					   }
				}
}
	String f_date = getStr( fileBean.getFieldValue("f_date"));
	String factDate = getStr( fileBean.getFieldValue("fact_date"));
	String planDate = getStr( fileBean.getFieldValue("plan_date"));
	String contractId = getStr( fileBean.getFieldValue("contract_id") );
	String leas_form = fileBean.getFieldValue("leas_form");
	
	System.out.println("即将进入接口中====----leas_form=" + leas_form + "====----equip_id=" + equip_id);
	System.out.println("=即将进入接口中===----f_date="+f_date+"--contractId="+contractId+"factDate="+factDate);
	if(factDate != null && !"".equals(factDate)&&"直租".equals(leas_form)){
		System.out.println("开始进入CRM接口更操作contract_id="+contractId+" equip_id="+equip_id);
		ProjInfoWriteService.dataSync6(contractId,equip_id);
	}
	String idss = getStr( fileBean.getFieldValue("ids"));
	System.out.println(idss+"iiiiiiiiiiii");
	if(idss != null && !"".equals(idss)){
		String[] ids = idss.split(",");
		for(int a = 0;a < ids.length;a++ ){
			String id = getStr( fileBean.getFieldValue("ids"+a));
			if(id != null && !"".equals(id)){
				sqlstr = "update upload_doc_detail set flag='1',modificator='"+czy+"',modify_date=getdate() where id='"+id+"'";
				db.executeUpdate(sqlstr);
			}
		}
	}
	
	
	
db.close();

//3返回判断

	if(flag>0){%>
	
	<script type="text/javascript">
		//window.close();
		opener.alert("修改成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("修改失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>

<%
	

%>
</BODY>
</HTML>
