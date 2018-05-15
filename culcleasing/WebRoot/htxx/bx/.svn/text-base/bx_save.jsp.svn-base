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

String contract_id;
String insurance_my;
String insurance_type;
String insurance_company;
String insurance_id;
String insured;
String b_insured;
String period_insurance;
String start_date;
String end_date;
String insurance_coverage;
String price_coverage;
String price_appraisal;
String assessment_company;
String production_date;
String payments;
String premium_rate;
String general_insurance;
String total_insurance;
String deductible_accident;
String pay_date;
String jurisdiction;
String beneficiaries;
String add_beneficiaries;
String memo;


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
                
				contract_id=fileBean.getFieldValue("contract_id");
				

insurance_my=fileBean.getFieldValue("insurance_my");
insurance_type=fileBean.getFieldValue("insurance_type");
insurance_company=fileBean.getFieldValue("insurance_company");
insurance_id=fileBean.getFieldValue("insurance_id");
insured=fileBean.getFieldValue("insured");
b_insured=fileBean.getFieldValue("b_insured");
period_insurance=fileBean.getFieldValue("period_insurance");
start_date=fileBean.getFieldValue("start_date");
end_date=fileBean.getFieldValue("end_date");
insurance_coverage=fileBean.getFieldValue("insurance_coverage");
price_coverage=fileBean.getFieldValue("price_coverage");
price_appraisal=fileBean.getFieldValue("price_appraisal");
assessment_company=fileBean.getFieldValue("assessment_company");
production_date=fileBean.getFieldValue("production_date");
payments=fileBean.getFieldValue("payments");
premium_rate=fileBean.getFieldValue("premium_rate");
general_insurance=fileBean.getFieldValue("general_insurance");
total_insurance=fileBean.getFieldValue("total_insurance");
deductible_accident=fileBean.getFieldValue("deductible_accident");
pay_date=fileBean.getFieldValue("pay_date");
jurisdiction=fileBean.getFieldValue("jurisdiction");
beneficiaries=fileBean.getFieldValue("beneficiaries");
add_beneficiaries=fileBean.getFieldValue("add_beneficiaries");
memo=fileBean.getFieldValue("memo");
                sqlstr="insert into contract_insurance(contract_id,insurance_my,insurance_type ,insurance_company,insurance_id,insured,b_insured,period_insurance,start_date,end_date,insurance_coverage,price_coverage,price_appraisal,assessment_company,production_date,payments,premium_rate,general_insurance,total_insurance,deductible_accident,pay_date,jurisdiction,beneficiaries,add_beneficiaries,memo,attachment,creator , create_date , modificator , modify_date ) values ('"+contract_id+"','"+insurance_my+"','" + insurance_type + "','"+insurance_company+"','"+insurance_id+"','"+insured+"','"+b_insured+"','"+period_insurance+"','"+start_date+"','"+end_date+"','"+insurance_coverage+"','"+price_coverage+"','"+price_appraisal+"','"+assessment_company+"','"+production_date+"','"+payments+"','"+premium_rate+"','"+general_insurance+"','"+total_insurance+"','"+deductible_accident+"','"+pay_date+"','"+jurisdiction+"','"+beneficiaries+"','"+add_beneficiaries+"','"+memo+"','" + fj + "','" + czy + "','" + datestr + "','" + czy + "','" + datestr + "')";
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
                 contract_id=fileBean.getFieldValue("contract_id");
                insurance_my=fileBean.getFieldValue("insurance_my");
insurance_type=fileBean.getFieldValue("insurance_my");
insurance_company=fileBean.getFieldValue("insurance_company");
insurance_id=fileBean.getFieldValue("insurance_id");
insured=fileBean.getFieldValue("insured");
b_insured=fileBean.getFieldValue("b_insured");
period_insurance=fileBean.getFieldValue("period_insurance");
start_date=fileBean.getFieldValue("start_date");
end_date=fileBean.getFieldValue("end_date");
insurance_coverage=fileBean.getFieldValue("insurance_coverage");
price_coverage=fileBean.getFieldValue("price_coverage");
price_appraisal=fileBean.getFieldValue("price_appraisal");
assessment_company=fileBean.getFieldValue("assessment_company");
production_date=fileBean.getFieldValue("production_date");
payments=fileBean.getFieldValue("payments");
premium_rate=fileBean.getFieldValue("premium_rate");
general_insurance=fileBean.getFieldValue("general_insurance");
total_insurance=fileBean.getFieldValue("total_insurance");
deductible_accident=fileBean.getFieldValue("deductible_accident");
pay_date=fileBean.getFieldValue("pay_date");
jurisdiction=fileBean.getFieldValue("jurisdiction");
beneficiaries=fileBean.getFieldValue("beneficiaries");
add_beneficiaries=fileBean.getFieldValue("add_beneficiaries");
memo=fileBean.getFieldValue("memo");
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
	
                sqlstr = "update contract_insurance set contract_id='"+contract_id+"',insurance_my='"+insurance_my+"',insurance_type='" + insurance_type + "',insurance_company='"+insurance_company+"',insurance_id='"+insurance_id+"',insured='"+insured+"',b_insured='"+b_insured+"',period_insurance='"+period_insurance+"',start_date='"+start_date+"',end_date='"+end_date+"',insurance_coverage='"+insurance_coverage+"',price_coverage='"+price_coverage+"',price_appraisal='"+price_appraisal+"',assessment_company='"+assessment_company+"',production_date='"+production_date+"',payments='"+payments+"',premium_rate='"+premium_rate+"',general_insurance='"+general_insurance+"',total_insurance='"+total_insurance+"',deductible_accident='"+deductible_accident+"',pay_date='"+pay_date+"',jurisdiction='"+jurisdiction+"',beneficiaries='"+beneficiaries+"',add_beneficiaries='"+add_beneficiaries+"',memo='"+memo+"',attachment='"+fj+"',creator='"+czy+"',create_date='"+datestr+"',modificator='" + czy + "',modify_date='" + datestr + "' where id='" + id + "'";
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

					window.location.href="bx_mod.jsp?id=<%=id%>";
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
