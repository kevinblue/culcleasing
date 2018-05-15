<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息 - 法人客户信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>


<BODY>
<%
	out.print("join@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
	String savaType=getStr(request.getParameter("savetype"));
	String sql = "";
	ResultSet rs=null;
	int flag=0;
	String message="";
	//String hydldata = getStr( request.getParameter("industry_level1") );
	    String cust_id=getStr(request.getParameter("cust_id"));
	out.print(cust_id);
		String cust_name=getStr(request.getParameter("cust_name"));
		String cust_ename=getStr(request.getParameter("cust_ename"));
		String cust_byname=getStr(request.getParameter("cust_byname"));
		String city=getStr(request.getParameter("city"));
		String memo=getStr(request.getParameter("memo"));
		String cust_type=getStr(request.getParameter("cust_type"));
		String cust_type2=getStr(request.getParameter("cust_type2"));
		String industry_type=getStr(request.getParameter("industry_type"));
		String industry_level1=getStr(request.getParameter("ndustry_level1"));
		String industry_level2=getStr(request.getParameter("ndustry_level2"));
		String industry_level3=getStr(request.getParameter("ndustry_level3"));
		String industry_level4=getStr(request.getParameter("ndustry_level4"));
		String country=getStr(request.getParameter("country"));
		String area=getStr(request.getParameter("area"));
		String region=getStr(request.getParameter("region"));
		String id_card_no=getStr(request.getParameter("id_card_no"));
		String legal_representative=getStr(request.getParameter("legal_representative"));
		String reg_addr=getStr(request.getParameter("reg_addr"));
		String office_addr=getStr(request.getParameter("office_addr"));
		String post_code=getStr(request.getParameter("post_code"));
		String mail_addr=getStr(request.getParameter("mail_addr"));
		String phone=getStr(request.getParameter("phone"));
		String linkman=getStr(request.getParameter("linkman"));
		String province=getStr(request.getParameter("province"));
		String mobile_number=getStr(request.getParameter("mobile_number"));
		String fax_number=getStr(request.getParameter("fax_number"));
	    String cable_addr=getStr(request.getParameter("cable_addr"));
		String web_site=getStr(request.getParameter("web_site"));
		String ownership=getStr(request.getParameter("ownership"));
		String e_mail=getStr(request.getParameter("e_mail"));
	    String scale=getStr(request.getParameter("scale"));
	    String org_code=getStr(request.getParameter("org_code"));
	    String biz_scope_primary=getStr(request.getParameter("biz_scope_primary"));
	   	String loan_number=getStr(request.getParameter("loan_number"));
	   	String license_number=getStr(rs.getString("icense_number"));
	   	String biz_scope_secondary=getStr(rs.getString("biz_scope_secondary"));
		String reg_capital=getStr(request.getParameter("reg_capital"));
	    String license_exp_date=getStr(request.getParameter("license_exp_date"));
		String reg_type=getStr(request.getParameter("reg_type"));
		String estab_date=getStr(request.getParameter("estab_date"));
		String national_tax_number=getStr(request.getParameter("national_tax_number"));
	    String land_tax_number=getStr(request.getParameter("land_tax_number"));
	    String isted_corp_flag=getStr(request.getParameter("isted_corp_flag"));
	    String imp_exp_flag=getStr(request.getParameter("imp_exp_flag"));
	   	String creator=getStr(request.getParameter("creator"));
	   	String creator_dept=getStr(request.getParameter("creator_dept"));
	   	String info_flag=getStr(request.getParameter("info_flag"));
	   	String create_date=getStr(request.getParameter("create_date"));
	   	String modify_date=getStr(request.getParameter("modify_date"));
	   	String modificator=getStr(request.getParameter("modificator"));
	   	String listed_corp_flag=getStr(request.getParameter("listed_corp_flag"));
	    //String creator=(String) session.getAttribute("czyid");
	
//	String create_date="";
	//String modificator=(String) session.getAttribute("czyid");
//	String modify_date="";
	//String provinceName=request.getParameter("");

	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
	//String nowTime=sdf.format(new Date());//当前格式化之后的时间
	System.out.print("+++++++++++");
	if(savaType.equals("add")){
	System.out.print("+++++++++++");
		sql="insert into cust_info(cust_id,cust_name,cust_ename,cust_byname,cust_type,cust_type2,industry_type,"+
		"industry_level1,industry_level2,industry_level3,industry_level4,country,area,province,city,"+
		"region,legal_representative,id_card_no,reg_addr,office_addr,mail_addr,post_code,linkman,phone,"+
		"mobile_number,fax_number,cable_addr,e_mail,web_site,ownership,scale,org_code,loan_number,"+
		"biz_scope_primary,biz_scope_secondary,license_number,license_exp_date,"+
		"reg_type,estab_date,national_tax_number,land_tax_number,license_exp_date,"+
		"reg_capital,reg_type,estab_date,national_tax_number,land_tax_number,listed_corp_flag,"+
		"imp_exp_flag,memo,info_flag,creator,creator_dept,create_date,modificator,modify_date)"+
		"values('"+cust_id+"','"+cust_name+"','"+cust_ename+"','"+cust_byname+"','"+cust_type+"','"+cust_type2+"',"+
			"'"+industry_type+"','"+industry_level1+"','"+industry_level2+"','"+industry_level3+"','"+industry_level4+"','"+country+"',"+
			"'"+area+"','"+province+"','"+city+"','"+region+"','"+legal_representative+"','"+id_card_no+"','"+reg_addr+"'"+
			"'"+office_addr+"','"+mail_addr+"','"+post_code+"','"+linkman+"','"+phone+"','"+web_site+"'"+
			"'"+mobile_number+"','"+fax_number+"','"+cable_addr+";,'"+e_mail+"','"+web_site+"','"+ownership+"','"+scale+"','"+org_code+"','"+loan_number+"'"+
			"'"+biz_scope_primary+"','"+biz_scope_secondary+"','"+license_number+"','"+license_exp_date+"'"+
			"'"+reg_type+"','"+estab_date+"','"+national_tax_number+"','"+land_tax_number+"','"+listed_corp_flag+"'"+
			"'"+imp_exp_flag+"','"+memo+"','"+info_flag+"','"+creator+"'"+
			"'"+creator_dept+"','"+create_date+"','"+modificator+"','"+modify_date+"')";
		
		System.out.print(sql+"+++++++++++++++++");
		flag=db.executeUpdate(sql);
		message="法人客户登记";
	}
	if(savaType.equals("add2")){
		sql="update cust_info set cust_name='"+cust_name+"','"+cust_ename+"',cust_byname='"+cust_byname+"',cust_type='"+cust_type+"',"+
		"cust_type2='"+cust_type2+"',industry_type='"+industry_type+"',industry_level1='"+industry_level1+"',industry_level2='"+industry_level2+"',"+
		"industry_level3='"+industry_level3+"',industry_level4='"+industry_level4+"',country='"+country+"',area='"+area+"',"+
		"province='"+province+"',city='"+city+"',region='"+region+"',"+
		"legal_representative='"+legal_representative+"',id_card_no='"+id_card_no+"',reg_addr='"+reg_addr+"',office_addr='"+office_addr+"',mail_addr='"+mail_addr+"',"+
		"post_code='"+post_code+"',linkman='"+linkman+"',web_site='"+web_site+"',"+
		"mobile_number='"+mobile_number+"',fax_number='"+fax_number+"',cable_addr='"+cable_addr+"',e_mail='"+e_mail+"',web_site='"+web_site+"',ownership='"+ownership+"',scale='"+scale+"',org_code='"+org_code+"',"+
		"loan_number='"+loan_number+"',biz_scope_primary='"+biz_scope_primary+"',biz_scope_secondary='"+biz_scope_secondary+"',"+
		"license_number='"+license_number+"',license_exp_date='"+license_exp_date+"',reg_type='"+reg_type+"',estab_date='"+estab_date+"'"+
		"national_tax_number='"+national_tax_number+"',land_tax_number='"+land_tax_number+"',listed_corp_flag='"+listed_corp_flag+"',imp_exp_flag='"+imp_exp_flag+"',memo='"+memo+"'"+
		"info_flag='"+info_flag+"',creator='"+creator+"',creator_dept='"+creator_dept+"',"+
		"create_date='"+create_date+"',modificator='"+modificator+"',modify_date='"+modify_date+"',"+
		"where cust_id='"+cust_id+"'";
		//" insert into cust_flowing (cust_id,flowing) values ('"+cust_id+"','"+nowTime+"')";
		System.out.print(sql);
		flag=db.executeUpdate(sql);
		message="法人客户登记";
	}
	if(savaType.equals("mod")){
		sql="update cust_info set cust_name='"+cust_name+"',cust_byname='"+cust_byname+"',cust_type='"+cust_type+"',"+
		"cust_type2='"+cust_type2+"',industry_type='"+industry_type+"',industry_level1='"+industry_level1+"',industry_level2='"+industry_level2+"',"+
		"industry_level3='"+industry_level3+"',industry_level4='"+industry_level4+"',country='"+country+"',area='"+area+"',"+
		"province='"+province+"',city='"+city+"',region='"+region+"',"+
		"legal_representative='"+legal_representative+"',id_card_no='"+id_card_no+"',office_addr='"+office_addr+"',"+
		"post_code='"+post_code+"',linkman='"+linkman+"',web_site='"+web_site+"',"+
		"mobile_number='"+mobile_number+"',scale='"+scale+"',org_code='"+org_code+"',"+
		"loan_number='"+loan_number+"',biz_scope_primary='"+biz_scope_primary+"',biz_scope_secondary='"+biz_scope_secondary+"',"+
		"license_number='"+license_number+"',license_exp_date='"+license_exp_date+"',reg_type='"+reg_type+"',estab_date='"+estab_date+"'"+
		"national_tax_number='"+national_tax_number+"',land_tax_number='"+land_tax_number+"',imp_exp_flag='"+imp_exp_flag+"',memo='"+memo+"'"+
		"info_flag='"+info_flag+"',creator='"+creator+"',creator_dept='"+creator_dept+"',"+
		"create_date='"+create_date+"',modify_date='"+modify_date+"',"+
		"where cust_id='"+cust_id+"'";
		System.out.print(sql);
		flag=db.executeUpdate(sql);
		message="修改客户信息";
	}
	if(savaType.equals("del")){
		sql="delete from cust_info where cust_id='"+cust_id+"'";
		flag=db.executeUpdate(sql);
		System.out.print(sql);
		message="删除客户信息";
	}
	if(flag>0){
		String hrefStr="";
		if(savaType.equals("del")){
%>
        <script>
		opener.window.location.href = "frkh_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script>
		window.location.href = "frkh.jsp?custId=<%=cust_id%>";
		alert("<%=message%>成功!");
		opener.location.reload();
		</script>
<%
		}
	}else{
%>
        <script>
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
<%	
	}
	db.close();
%>