<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String systemDate = getSystemDate(0);
String cust_name = getStr( request.getParameter("cust_name") );
String cust_ename = getStr( request.getParameter("cust_ename") );
String birthday = getStr( request.getParameter("birthday") );
String is_marriage = getStr( request.getParameter("is_marriage") );
String sex = getStr( request.getParameter("sex") );
String certificate = getStr( request.getParameter("certificate") );
String certificate_no = getStr( request.getParameter("certificate_no") );
String education = getStr( request.getParameter("education") );
String reg_per_addr = getStr( request.getParameter("reg_per_addr") );
String work_addr = getStr( request.getParameter("work_addr") );
String headship = getStr( request.getParameter("headship") );
String off_phone = getStr( request.getParameter("off_phone") );
String home_phone = getStr( request.getParameter("home_phone") );
String mobile_number = getStr( request.getParameter("mobile_number") );
String home_addr = getStr( request.getParameter("home_addr") );
String mail_addr = getStr( request.getParameter("mail_addr") );
String post_code = getStr( request.getParameter("post_code") );
String eme_contacts = getStr( request.getParameter("eme_contacts") );
String reg_number = getStr( request.getParameter("reg_number") );
String license_exp_date = getStr( request.getParameter("license_exp_date") );
String annual_due_date = getStr( request.getParameter("annual_due_date") );
String fax_number = getStr( request.getParameter("fax_number") );
String e_mail = getStr( request.getParameter("e_mail") );
String web_site = getStr( request.getParameter("web_site") );
String biz_scope = getStr( request.getParameter("biz_scope") );
String memo = getStr( request.getParameter("memo") );
String unit_name = getStr( request.getParameter("unit_name") );

String gjdata = getStr( request.getParameter("country") );//国家
String sfdata = getStr( request.getParameter("province") );//省份
String csdata = getStr( request.getParameter("city") );//城市
String qxdata = getStr( request.getParameter("qxdata") );//区县
String hydldata = getStr( request.getParameter("industry_level1") );//客户所属行业大类
String hyxldata = getStr( request.getParameter("industry_level2") );//客户所属行业小类
String lbdldata = getStr( request.getParameter("category_level1") );//客户类别

String cust_id ="";
String create_dept = "";
String userName=(String)session.getAttribute("czyid");
System.out.print("------------------------------"+userName);
String sqlstr;
ResultSet rs;
int flag=0;
String message="";
sqlstr="select name from base_user where id='"+dqczy+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	create_dept = getDBStr(rs.getString("name"));
}
String stype =  getStr( request.getParameter("savetype") );
if ( stype.equals("add") ){ 
		//构建用户ID开始
			sqlstr = "select top 1 cust_id from vi_cust_all_info order by cust_id desc";
			String temp_id="";
			String temp_date=systemDate.replaceAll("-", "");//截取出年月日并去掉中间的-符号
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr); 
			if ( rs.next() ) {
				temp_id = getDBStr( rs.getString("cust_id") );//获得最近一个产生的ID
			}
			rs.close();
			if ( ( temp_id == null ) || ( temp_id.equals("") ) ) {
				//这种情况表示数据库还没数据
				temp_id = temp_date + "0001";
			} else {
				//获得上一个ID的产生日期
				String old_date=temp_id.substring(0,8);
				if(old_date.equals(temp_date)){//同一天的数据插入则累加位数
					//获得上一次产生的ID的尾数号(4位)
					int temp_num=Integer.parseInt("1"+temp_id.substring(temp_id.length()-4,temp_id.length()));//为了转换是前面的零不丢失在数字前加1;
					temp_num++;//数字自加
					temp_id=String.valueOf(temp_num).substring(1);//获取后四位数字
					temp_id=String.valueOf(temp_date+temp_id);//完整取得ID
				}else{//不是同一天的数据从1开始加
					temp_id=temp_date+"0001";
				}
			}
			cust_id=temp_id;
			czid=cust_id;//用于页面跳转
			//构建用户ID结束
sqlstr="insert into cust_ewlp_info (cust_id,cust_name,cust_ename,sex,brith_date,marital_status,passport_type,id_card_no,school,domicile_place,work_add,unit_position,work_phone,home_phone,mobile_number,home_add,mail_add,post_code,linkman,reg_number,license_exp_date,annual_due_date,industry_level1,industry_level2,cust_type,fax_number,e_mail,web_site,country,province,city,memo,biz_scope,creator_dept,creator,create_date,county,unit_name) values (";

sqlstr+="'"+cust_id+"',";
if(cust_name!=null&&!cust_name.equals(""))
sqlstr+="'"+cust_name+"',";
else
sqlstr+="null,";
if(cust_ename!=null&&!cust_ename.equals(""))
sqlstr+="'"+cust_ename+"',";
else
sqlstr+="null,";
if(sex!=null&&!sex.equals(""))
sqlstr+="'"+sex+"',";
else
sqlstr+="null,";
if(birthday!=null&&!birthday.equals(""))
sqlstr+="'"+birthday+"',";
else
sqlstr+="null,";
if(is_marriage!=null&&!is_marriage.equals(""))
sqlstr+="'"+is_marriage+"',";
else
sqlstr+="null,";
if(certificate!=null&&!certificate.equals(""))
sqlstr+="'"+certificate+"',";
else
sqlstr+="null,";
if(certificate_no!=null&&!certificate_no.equals(""))
sqlstr+="'"+certificate_no+"',";
else
sqlstr+="null,";
if(education!=null&&!education.equals(""))
sqlstr+="'"+education+"',";
else
sqlstr+="null,";
if(reg_per_addr!=null&&!reg_per_addr.equals(""))
sqlstr+="'"+reg_per_addr+"',";
else
sqlstr+="null,";
if(work_addr!=null&&!work_addr.equals(""))
sqlstr+="'"+work_addr+"',";
else
sqlstr+="null,";
if(headship!=null&&!headship.equals(""))
sqlstr+="'"+headship+"',";
else
sqlstr+="null,";
if(off_phone!=null&&!off_phone.equals(""))
sqlstr+="'"+off_phone+"',";
else
sqlstr+="null,";
if(home_phone!=null&&!home_phone.equals(""))
sqlstr+="'"+home_phone+"',";
else
sqlstr+="null,";
if(mobile_number!=null&&!mobile_number.equals(""))
sqlstr+="'"+mobile_number+"',";
else
sqlstr+="null,";
if(home_addr!=null&&!home_addr.equals(""))
sqlstr+="'"+home_addr+"',";
else
sqlstr+="null,";
if(mail_addr!=null&&!mail_addr.equals(""))
sqlstr+="'"+mail_addr+"',";
else
sqlstr+="null,";
if(post_code!=null&&!post_code.equals(""))
sqlstr+="'"+post_code+"',";
else
sqlstr+="null,";
if(eme_contacts!=null&&!eme_contacts.equals(""))
sqlstr+="'"+eme_contacts+"',";
else
sqlstr+="null,";
if(reg_number!=null&&!reg_number.equals(""))
sqlstr+="'"+reg_number+"',";
else
sqlstr+="null,";
if(license_exp_date!=null&&!license_exp_date.equals(""))
sqlstr+="'"+license_exp_date+"',";
else
sqlstr+="null,";
if(annual_due_date!=null&&!annual_due_date.equals(""))
sqlstr+="'"+annual_due_date+"',";
else
sqlstr+="null,";
if(hydldata!=null&&!hydldata.equals(""))
sqlstr+="'"+hydldata+"',";
else
sqlstr+="null,";
if(hyxldata!=null&&!hyxldata.equals(""))
sqlstr+="'"+hyxldata+"',";
else
sqlstr+="null,";
if(lbdldata!=null&&!lbdldata.equals(""))
sqlstr+="'"+lbdldata+"',";
else
sqlstr+="null,";
if(fax_number!=null&&!fax_number.equals(""))
sqlstr+="'"+fax_number+"',";
else
sqlstr+="null,";
if(e_mail!=null&&!e_mail.equals(""))
sqlstr+="'"+e_mail+"',";
else
sqlstr+="null,";
if(web_site!=null&&!web_site.equals(""))
sqlstr+="'"+web_site+"',";
else
sqlstr+="null,";
if(gjdata!=null&&!gjdata.equals(""))
sqlstr+="'"+gjdata+"',";
else
sqlstr+="null,";
if(sfdata!=null&&!sfdata.equals(""))
sqlstr+="'"+sfdata+"',";
else
sqlstr+="null,";
if(csdata!=null&&!csdata.equals(""))
sqlstr+="'"+csdata+"',";
else
sqlstr+="null,";
if(memo!=null&&!memo.equals(""))
sqlstr+="'"+memo+"',";
else
sqlstr+="null,";
if(biz_scope!=null&&!biz_scope.equals(""))
sqlstr+="'"+biz_scope+"',";
else
sqlstr+="null,";
sqlstr+="'"+dqczy+"',";
sqlstr+="'"+userName+"',";
sqlstr+="'"+systemDate+"',";
sqlstr+="'"+qxdata+"',";
sqlstr+="'"+unit_name+"'";
sqlstr+=")";
System.out.println(sqlstr);
flag = db.executeUpdate(sqlstr);
db.close();
message="添加客户信息";
}
if ( stype.equals("mod") ){ 
sqlstr="update cust_ewlp_info set ";
sqlstr+=" cust_name='"+cust_name+"',";
sqlstr+=" cust_ename='"+cust_ename+"',";
sqlstr+=" sex='"+sex+"',";
sqlstr+=" brith_date='"+birthday+"',";
sqlstr+=" marital_status='"+is_marriage+"',";
sqlstr+=" passport_type='"+certificate+"',";
sqlstr+=" id_card_no='"+certificate_no+"',";
sqlstr+=" school='"+education+"',";
sqlstr+=" domicile_place='"+reg_per_addr+"',";
sqlstr+=" work_add='"+work_addr+"',";
sqlstr+=" unit_position='"+headship+"',";
sqlstr+=" work_phone='"+off_phone+"',";
sqlstr+=" home_phone='"+home_phone+"',";
sqlstr+=" mobile_number='"+mobile_number+"',";
sqlstr+=" home_add='"+home_addr+"',";
sqlstr+=" mail_add='"+mail_addr+"',";
sqlstr+=" post_code='"+post_code+"',";
sqlstr+=" linkman='"+eme_contacts+"',";
sqlstr+=" reg_number='"+reg_number+"',";
sqlstr+=" license_exp_date='"+license_exp_date+"',";
sqlstr+=" annual_due_date='"+annual_due_date+"',";
sqlstr+=" industry_level1='"+hydldata+"',";
sqlstr+=" industry_level2='"+hyxldata+"',";
sqlstr+=" cust_type='"+lbdldata+"',";
sqlstr+=" fax_number='"+fax_number+"',";
sqlstr+=" e_mail='"+e_mail+"',";
sqlstr+=" web_site='"+web_site+"',";
sqlstr+=" country='"+gjdata+"',";
sqlstr+=" province='"+sfdata+"',";
sqlstr+=" city='"+csdata+"',";
sqlstr+=" biz_scope='"+biz_scope+"',";
sqlstr+=" memo='"+memo+"',";
sqlstr+=" modificator='"+userName+"',";
sqlstr+=" modify_date='"+systemDate+"',";
sqlstr+=" unit_name='"+unit_name+"',";
sqlstr+=" county='"+qxdata+"'";
sqlstr+=" where cust_id='"+czid+"'";
System.out.println(sqlstr);
flag = db.executeUpdate(sqlstr);
db.close();
message="修改客户信息";
}
if ( stype.equals("del") ){ 
sqlstr="delete from cust_ewlp_info where  cust_id='"+czid+"'";
System.out.println(sqlstr);
flag = db.executeUpdate(sqlstr);
db.close();
message="删除客户信息";
}
if(flag==0){
		%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
		<%		
	}else{
		String hrefStr="";
		if(stype.equals("del")){
			%>
        <script>
		opener.window.location.href = "khzrxx_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
		}else{
		%>
        <script>
		window.location.href = "khzrxx.jsp?czid=<%=czid%>";
		alert("<%=message%>成功!");
		opener.location.reload();
		</script>
		<%
		}
	}
%>