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

String u_id="";
String sqlstr;
int i;
String id;
//String cust_id;
//String contact_date;
//String record_type;
//String record_content;
//�޸��ֶ�
String bid;
String uid;
String manuf_name;
String margin_per;
String vendor_payment;
String min_payment;
String ensure_payment;
String margin_amount;
String deposit_amount;
String margin_time;
String margin_reason;
String deposit_export;
String export_time;
String export_reason;
//String attachment;
String contract_id;
//��֤�����
//String caution_money_ratio;


String fj = "";
String fj_flag = "0";
String fj_name = "0";
String Description = "";
ResultSet rs;
String fj_del="";
String filePath;
String fileName = "";

//��ȡϵͳʱ��
String datestr=getSystemDate(0); 

//�趨�������·��
String path = pageContext.getServletContext().getRealPath("/");
fileBean.setObjectPath( path + "\\upload\\" );

//�趨�ϴ����������С����
fileBean.setSize(8*1024*1024);

//�趨�ϴ������ļ�����
fileBean.setSuffix(".zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt");

//�趨�ϴ��û�ID
if ( ( czy != null ) && ( !czy.equals("") ) ) {
   u_id=czy.substring(7);
}
fileBean.setUserid(u_id);
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
if( Description.indexOf("����") < 0 ) {
       if ( fileBean.getFieldValue("savetype") != null ) {
            String stype = fileBean.getFieldValue("savetype");
            if ( stype.indexOf("add") >= 0) {
                //cust_id = fileBean.getFieldValue("cust_id");
                //record_type = fileBean.getFieldValue("record_type");
               // record_content = fileBean.getFieldValue("record_content");
	          //  contact_date = fileBean.getFieldValue("contact_date");
			  uid=fileBean.getFieldValue("uid");
			  System.out.println("uid$$$$$$$$$$$$$$$$$"+uid);
 manuf_name= fileBean.getFieldValue("manuf_name");
 margin_per= fileBean.getFieldValue("margin_per");
 vendor_payment= fileBean.getFieldValue("vendor_payment");
 min_payment= fileBean.getFieldValue("min_payment");
 ensure_payment= fileBean.getFieldValue("ensure_payment");
 System.out.println("TTTTTTTTTTTT"+ensure_payment);
 margin_amount= fileBean.getFieldValue("margin_amount");
 deposit_amount= fileBean.getFieldValue("deposit_amount");
 margin_time= fileBean.getFieldValue("margin_time");
 margin_reason= fileBean.getFieldValue("margin_reason");
 deposit_export= fileBean.getFieldValue("deposit_export");
 export_time= fileBean.getFieldValue("export_time");
 export_reason= fileBean.getFieldValue("export_reason");
 //attachment= fileBean.getFieldValue("attachment");
 contract_id= fileBean.getFieldValue("contract_id");
 //caution_money_ratio=fileBean.getFieldValue("caution_money_ratio");
                sqlstr="insert into mproj_company (uid ,ensure_payment,margin_per ,vendor_payment , min_payment,margin_amount,deposit_amount,margin_time,margin_reason,deposit_export,export_time,export_reason,contract_id, attachment , creator , create_date , modificator , modify_date ) values ('"+uid+"','"+ensure_payment+"','"+margin_per+"','" + vendor_payment + "','"+min_payment+"','"+margin_amount+"','"+deposit_amount+"','"+margin_time+"','"+margin_reason+"','"+deposit_export+"','"+export_time+"','"+export_reason+"','"+contract_id+"','" + fj + "','" + czy + "','" + datestr + "','" + czy + "','" + datestr + "')";
                db.executeUpdate(sqlstr); 
			System.out.println(sqlstr);
%>
				<script>
					window.close();
					opener.alert("��ӳɹ�!");
					opener.location.reload();
				</script>
<%

           
            }
           if (stype.indexOf("mod")>=0){
                id = fileBean.getFieldValue("id");
				fj_del = fileBean.getFieldValue("fj_del");
bid = fileBean.getFieldValue("bid");
               // record_type = fileBean.getFieldValue("record_type");
                //record_content = fileBean.getFieldValue("record_content");
                // contact_date = fileBean.getFieldValue("contact_date");
  //manuf_name= fileBean.getFieldValue("manuf_name");
 //margin_per= fileBean.getFieldValue("margin_per");
 //vendor_payment= fileBean.getFieldValue("vendor_payment");
 //min_payment= fileBean.getFieldValue("min_payment");
 //ensure_payment= fileBean.getFieldValue("ensure_payment");
 margin_amount= fileBean.getFieldValue("margin_amount");
 deposit_amount= fileBean.getFieldValue("deposit_amount");
 margin_time= fileBean.getFieldValue("margin_time");
 margin_reason= fileBean.getFieldValue("margin_reason");
 deposit_export= fileBean.getFieldValue("deposit_export");
 export_time= fileBean.getFieldValue("export_time");
 export_reason= fileBean.getFieldValue("export_reason");

 //contract_id= fileBean.getFieldValue("contract_id");

				sqlstr = "select * from mproj_company where bid='" + bid + "'";
System.out.println("sqlstr-------------------------------------------------------------"+sqlstr);
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
					 					fileName = fileName.substring( fileName.indexOf(">") + 1 , fileName.indexOf("</") );
												filePath = filePath + fileName;
							new File(filePath).delete();
					 
					 sqlstr = "update mproj_company set attachment='' where id='" + id + "'";
				
                     db.executeUpdate(sqlstr); 
					 	 System.out.println("sqlstr%%%^^^^^"+sqlstr);

				}
	
                sqlstr = "update mproj_company set deposit_amount='"+deposit_amount+"',margin_time='"+margin_time+"',margin_reason='"+margin_reason+"',deposit_export='"+deposit_export+"',export_time='"+export_time+"',export_reason='"+export_reason+"',attachment='"+fj+"',creator='"+czy+"',create_date='"+datestr+"',modificator='" + czy + "',modify_date='" + datestr + "' where bid='" + bid + "'";
                db.executeUpdate(sqlstr); 
System.out.println("sqlstr*****"+sqlstr);
				if(fj_del==null || fj_del.equals("")) {
					
		
%>
				<script>
					window.close();
					opener.alert("�޸ĳɹ�!");
					opener.location.reload();
				</script>
<%

		}else{
%>
				<script>

					window.location.href="csbzj_mod.jsp?bid=<%=id%>";
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
				sqlstr = "select * from mproj_company where id='" + id + "'";
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
                sqlstr = "delete from mproj_company where bid='" + id + "'";
                System.out.println("%%%%%delete%%%%%% del sqlstr = "+sqlstr);
                db.executeUpdate(sqlstr); 

%>
				<script>
					window.close();
					opener.alert("ɾ���ɹ�!");
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
<input type="button" value="����" onclick="history.back();">
<%
}

db.close();
%>


</BODY>
</HTML>
