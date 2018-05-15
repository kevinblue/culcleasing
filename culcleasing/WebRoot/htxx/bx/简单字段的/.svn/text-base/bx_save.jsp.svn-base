<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="java.io.File" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<%@ include file="../../func/common.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czy = (String) session.getAttribute("czyid");

String uid="";
String sqlstr;
int i;
String id;
//String cust_id;
//String contact_date;
//String record_type;
//String record_content;
 String contract_id;
 //=getStr(request.getParameter("contract_id"));
  String insurance_type;
  //=getStr(request.getParameter("insurance_type"));
//String contract_id;
//String attachment;
String fj = "";
String fj_flag = "0";
String fj_name = "0";
String Description = "";
ResultSet rs;
String fj_del="";
String filePath;
String fileName = "";

//获取系统时间
String datestr=getSystemDate(0); 

//设定附件相对路径
String path = pageContext.getServletContext().getRealPath("/");
fileBean.setObjectPath( path + "\\upload\\" );

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
System.out.println("iCount#########"+iCount);
String sObjectPath = fileBean.getObjectPath();

for ( i = 0;i < iCount;i++ ) {
   if ( saSourceFile[i] == null || saSourceFile[i].equals("") ) {

   }else {
     fj = fj + "<a href=../../upload/" + saObjectFile[i] + " target=_blank>" + saObjectFile[i] + "</a><br>";
     Description = Description + "<br>" + saDescription[i];
System.out.println("^^^^^^^^^^^^^^^^"+Description);
   }
}
if( Description.indexOf("出错") < 0 ) {
       if ( fileBean.getFieldValue("savetype") != null ) {
            String stype = fileBean.getFieldValue("savetype");
            if ( stype.indexOf("add") >= 0) {
                //cust_id = fileBean.getFieldValue("cust_id");
               // record_type = fileBean.getFieldValue("record_type");
              //  record_content = fileBean.getFieldValue("record_content");
				//contact_date = fileBean.getFieldValue("contact_date");
			//	contract_id=fileBean.getFieldValue("contract_id");
				//period_insurance=fileBean.getFieldValue("period_insurance");
				contract_id=fileBean.getFieldValue("contract_id");
				insurance_type=fileBean.getFieldValue("insurance_type");
                sqlstr="insert into contract_insurance(contract_id ,insurance_type ,attachment,creator , create_date , modificator , modify_date ) values ('"+contract_id+"','" + insurance_type + "','" + fj + "','" + czy + "','" + datestr + "','" + czy + "','" + datestr + "')";
                db.executeUpdate(sqlstr); 
			System.out.println(sqlstr);
%>
				<script>
					window.close();
					opener.alert("添加成功!");
					opener.location.reload();
				</script>
<%

           
            }
           if (stype.indexOf("mod")>=0){
                id = fileBean.getFieldValue("id");
				fj_del = fileBean.getFieldValue("fj_del");
               // record_type = fileBean.getFieldValue("record_type");
               // record_content = fileBean.getFieldValue("record_content");
                 //contact_date = fileBean.getFieldValue("contact_date");
                 contract_id=fileBean.getFieldValue("contract_id");
                 insurance_type=fileBean.getFieldValue("insurance_type");
				sqlstr = "select * from contract_insurance where id='" + id + "'";
				fileName = "";
			
				rs = db.executeQuery(sqlstr);
					 if( rs.next() ){
						  
							fileName = getDBStr( rs.getString("attachment") );
							
		


					 }
				if(fj_del==null || fj_del.equals("")) {
					if(fj==null || fj.equals(""))
					fj=fileName;
					
				}else{
					 filePath = pageContext.getServletContext().getRealPath("/") + "\\upload\\";
					 					fileName = fileName.substring( fileName.indexOf(">") + 1 , fileName.indexOf

("</") );
												filePath = filePath + fileName;
							new File(filePath).delete();
					 
					 sqlstr = "update contract_insurance set attachment='' where id='" + id + "'";
                     db.executeUpdate(sqlstr); 

				}
	
                sqlstr = "update contract_insurance set contract_id='"+contract_id+"',insurance_type='" + insurance_type + "',attachment='"+fj+"',creator='"+czy+"',create_date='"+datestr+"',modificator='" + czy + "',modify_date='" + datestr + "' where id='" + id + "'";
                db.executeUpdate(sqlstr); 
				if(fj_del==null || fj_del.equals("")) {
					
		
%>
				<script>
					window.close();
					opener.alert("修改成功!");
					opener.location.reload();
				</script>
<%

		}else{
%>
				<script>

					window.location.href="bx_mod.jsp?czid=<%=id%>";
				</script>
<%
		}
           }
           if (stype.indexOf("del")>=0) {
			    id = fileBean.getFieldValue("id");

			    fj_name = fileBean.getFieldValue("fj_name");
			    if(fj_name == null || fj_name == "")
			    {
			    	fj_flag="1";
			    }
			    filePath = pageContext.getServletContext().getRealPath("/") + "\\upload\\";
				sqlstr = "select * from contract_insurance where id='" + id + "'";
				fileName = "";
                rs = db.executeQuery(sqlstr);
				if( rs.next() ){
					if(!fj_flag.equals("1"))
					{
						fileName = getDBStr( rs.getString("attachment") );
						fileName = fileName.substring( fileName.indexOf(">") + 1 , fileName.indexOf("</") );
						filePath = filePath + fileName;
						new File(filePath).delete();
					}
				}
                sqlstr = "delete from contract_insurance where id='" + id + "'";
                System.out.println("%%%%%%%%%%% del sqlstr = "+sqlstr);
                db.executeUpdate(sqlstr); 

%>
				<script>
					window.close();
					opener.alert("删除成功!");
					opener.location.reload();
				</script>
<%			
           }
   
       }  
}
else
{
%>

<br>
<input type="button" value="返回" onclick="history.back();">
<%
}
db.close();
%>


</BODY>
</HTML>
