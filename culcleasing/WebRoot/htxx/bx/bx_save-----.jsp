<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*"%>
<%@ page import="java.io.File" %>
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="fileBean" scope="page" class="com.UploadBean" />
<%@ page import="java.sql.*"%>

<%@ include file="../../func/common.jsp"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>资产管理 - 保险管理</title>
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
	</head>
	<BODY>
		<%
String czy=(String)session.getAttribute("czyid");
System.out.println("c&&&&&&&&&&&&&&&&&&"+czy);
//获取系统时间
String datestr=getSystemDate(0); 
	//int flag=0;
	//String message="";
	//String cust_id="";
	//String id = getStr(request.getParameter("id"));
	// System.out.println("id="+id);
	//String stype = getStr(request.getParameter("savetype"));
	 //保险字段
	 String contract_id;
	// System.out.println("contract_id="+contract_id);
	 String insurance_my;
	 String insurance_id;
	 String buy_insuranceself;
	// String period_insurance=getStr(request.getParameter("period_insurance"));
	// System.out.println("1.period_insurance="+period_insurance);
	String period_insurance;
	 String colleaction_date;
	 String insurance_type;
	 String payments;
	 String insured_amount;
	 String pay_date;
	   //String proj_id=getStr(request.getParameter("proj_id"));
	String insurance_company;
	String insured;
    String b_insured;
    String insurance_coverage;
	String price_coverage;
	String price_appraisal;
	String assessment_company;
    String production_date;
	String total_insurance;
	String deductible_accident;
	String premium_rate;
	String general_insurance;
	String jurisdiction;
	String beneficiaries;
	String memo;
	String attachment;
	   
String sqlstr;
String uid="";
int i;
String id;
String fj = "";
String fj_flag = "0";
String fj_name = "0";
String Description = "";

String fj_del="";
String filePath;
String fileName = "";
ResultSet rs;

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
   System.out.println("uid---------"+uid);
}
fileBean.setUserid(uid);
fileBean.setSourceFile(request);
String [] saSourceFile = fileBean.getSourceFile();
String [] saObjectFile = fileBean.getObjectFileName();
String [] saDescription = fileBean.getDescription();
int iCount = fileBean.getCount();
System.out.println("iCount+++++++++++++"+iCount);
String sObjectPath = fileBean.getObjectPath();
System.out.println("sObjectPath========="+sObjectPath);
for ( i = 0;i < iCount;i++ ) {
System.out.println("sObjectPath=========");
 System.out.println("saSourceFile==="+saSourceFile[i]);
   if ( saSourceFile[i] == null || saSourceFile[i].equals("") ) {

   }else {
     fj = fj + "<a href=../../upload/" + saObjectFile[i] + " target=_blank>" + saObjectFile[i] + "</a><br>";
          System.out.println("#############"+ fj);
     Description = Description + "<br>" + saDescription[i];
     System.out.println("#############"+Description);
   }
}
if( Description.indexOf("出错") < 0 ) {
       if ( fileBean.getFieldValue("savetype") != null ) {
            String stype = fileBean.getFieldValue("savetype");
            System.out.println("stype$$$$$$$$$$$$$"+stype);
            if ( stype.indexOf("add") >= 0) {
   contract_id=fileBean.getFieldValue("contract_id");
   System.out.print("contract_id()()()()()()()()("+contract_id);
   insurance_my=fileBean.getFieldValue("insurance_my");
   insurance_type=fileBean.getFieldValue("insurance_type");
   insurance_company=fileBean.getFieldValue("insurance_company");
   insurance_id=fileBean.getFieldValue("insurance_id");
   insured=fileBean.getFieldValue("insured");
   b_insured=fileBean.getFieldValue("b_insured");
   colleaction_date=fileBean.getFieldValue("colleaction_date");
	 payments=fileBean.getFieldValue("payments");
	 pay_date=fileBean.getFieldValue("pay_date");
	 buy_insuranceself=fileBean.getFieldValue("buy_insuranceself");
	 period_insurance=fileBean.getFieldValue("period_insurance");
	 insured_amount=fileBean.getFieldValue("insured_amount");
     insurance_coverage=fileBean.getFieldValue("insurance_coverage");
	 price_coverage=fileBean.getFieldValue("price_coverage");
	 price_appraisal=fileBean.getFieldValue("price_appraisal");
	 assessment_company=fileBean.getFieldValue("assessment_company");
     production_date=fileBean.getFieldValue("production_date");
	 total_insurance=fileBean.getFieldValue("total_insurance");
	 deductible_accident=fileBean.getFieldValue("deductible_accident");
	 premium_rate=fileBean.getFieldValue("premium_rate");
	 general_insurance=fileBean.getFieldValue("general_insurance");
	 jurisdiction=fileBean.getFieldValue("jurisdiction");
	 beneficiaries=fileBean.getFieldValue("beneficaries");
	 memo=fileBean.getFieldValue("memo");
	// attachment=fileBean.getFieldValue("attachment");colleaction_date 
      
               sqlstr="insert into contract_insurance(contract_id,insurance_my,insurance_id,buy_insuranceself,period_insurance,colleaction_date,insurance_type,pay_date,payments,insured_amount,insurance_company,insured,b_insured,insurance_coverage,price_coverage,price_appraisal,assessment_company,production_date,total_insurance,deductible_accident,premium_rate,general_insurance,jurisdiction,beneficiaries,memo,attachment,creator,create_date,modificator,modify_date)"+
		"values('"+contract_id+"','"+insurance_my+"','"+insurance_id+"','"+buy_insuranceself+"','"+period_insurance+"','"+colleaction_date+"','"+insurance_type+"','"+pay_date+"','"+payments+"','"+insured_amount+"','"+insurance_company+"','"+insured+"','"+b_insured+"','"+insurance_coverage+"','"+price_coverage+"','"+price_appraisal+"','"+assessment_company+"','"+production_date+"','"+total_insurance+"','"+deductible_accident+"','"+premium_rate+"','"+general_insurance+"','"+jurisdiction+"','"+beneficiaries+"','"+memo+"','"+fj+"','"+czy+"','"+datestr+"','"+czy+"','"+datestr+"') ";
		
            db.executeUpdate(sqlstr); 
			System.out.println("insert"+sqlstr);
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
   insurance_type=fileBean.getFieldValue("insurance_type");
   insurance_company=fileBean.getFieldValue("insurance_company");
   insurance_id=fileBean.getFieldValue("insurance_id");
   insured=fileBean.getFieldValue("insured");
   b_insured=fileBean.getFieldValue("b_insured");
    colleaction_date=fileBean.getFieldValue("colleaction_date");
	 payments=fileBean.getFieldValue("payments");
	 pay_date=fileBean.getFieldValue("pay_date");
	 buy_insuranceself=fileBean.getFieldValue("buy_insuranceself");
	 period_insurance=fileBean.getFieldValue("period_insurance");
	 //proj_id=fileBean.getFieldValue("proj_id");
	// cust_id=fileBean.getFieldValue("cust_id");
	// cust_name=fileBean.getFieldValue("cust_name");
	// project_name=fileBean.getFieldValue("project_name");
	 //out_dept=fileBean.getFieldValue("out_dept");
	// creator=fileBean.getFieldValue("creator");
	// create_date=fileBean.getFieldValue("create_date");
	// modificator=fileBean.getFieldValue("modificator");
	// modify_date=fileBean.getFieldValue("modify_date");
	 insured_amount=fileBean.getFieldValue("insured_amount");
     insurance_coverage=fileBean.getFieldValue("insurance_coverage");
	 price_coverage=fileBean.getFieldValue("price_coverage");
	 price_appraisal=fileBean.getFieldValue("price_appraisal");
	 assessment_company=fileBean.getFieldValue("assessment_company");
     production_date=fileBean.getFieldValue("production_date");
	 total_insurance=fileBean.getFieldValue("total_insurance");
	 deductible_accident=fileBean.getFieldValue("deductible_accident");
	 premium_rate=fileBean.getFieldValue("premium_rate");
	 general_insurance=fileBean.getFieldValue("general_insurance");
	 jurisdiction=fileBean.getFieldValue("jurisdiction");
	 beneficiaries=fileBean.getFieldValue("beneficaries");
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
					 					fileName = fileName.substring( fileName.indexOf(">") + 1 , fileName.indexOf("</") );
												filePath = filePath + fileName;
							new File(filePath).delete();
					 
					 sqlstr = "update contract_insurance set attachment='' where id='" + id + "'";
                     db.executeUpdate(sqlstr); 
                     //System.out.prinltn("update"+sqlstr);

				}
	
sqlstr="update contract_insurance set "+
		"insurance_my='"+insurance_my+"',insurance_id='"+insurance_id+"',buy_insuranceself='"+buy_insuranceself+"',period_insurance='"+period_insurance+"',"+
		"colleaction_date='"+colleaction_date+"',insurance_type='"+insurance_type+"',creator='"+czy+"',create_date='"+datestr+"',modificator='"+czy+"',modify_date='"+datestr+"',pay_date='"+pay_date+"',insured_amount='"+insured_amount+"',payments='"+payments+"',"+
		"insurance_company='"+insurance_company+"',insured='"+insured+"',b_insured='"+b_insured+"',insurance_coverage='"+insurance_coverage+"',price_coverage='"+price_coverage+"',price_appraisal='"+price_appraisal+"',assessment_company='"+assessment_company+"',production_date='"+production_date+"',total_insurance='"+total_insurance+"',deductible_accident='"+deductible_accident+"',premium_rate='"+premium_rate+"',general_insurance='"+general_insurance+"',jurisdiction='"+jurisdiction+"',beneficiaries='"+beneficiaries+"',memo='"+memo+"',attachment='"+fj+"',"+
		"where id='"+id+"'";
		System.out.print("xiugaisql"+sqlstr);
               
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
