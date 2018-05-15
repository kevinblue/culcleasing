<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.OperationUtil"%>
<%@page import="java.util.Date"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>客户信息 - 法人客户信息保存</title>
	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
	<script src="../../js/calend.js"></script>
</head>
<BODY>
		<%
			String dqczy = (String) session.getAttribute("czyid");
			System.out.print("join@777777777777777&&&&&&&&&&&&&&&&&&&&2"+dqczy);
			//System.out.println(czyid);
					
			String savaType = getStr(request.getParameter("savetype"));
			String sql = "";
			ResultSet rs = null;
			int flag = 0;
			String message = "";
			//String hydldata = getStr( request.getParameter("industry_level1") );
			String czid = getStr(request.getParameter("czid"));
			String custId = getStr(request.getParameter("custId"));
			String cust_id = getStr(request.getParameter("cust_id"));
			String cust_name = getStr(request.getParameter("cust_name"));
			String cust_ename = getStr(request.getParameter("cust_ename"));
			String cust_byname = getStr(request.getParameter("cust_byname"));
			String parent_company = getStr(request.getParameter("parent_company"));
			String memo = getStr(request.getParameter("memo"));
			//类别
			//String custtype=getStr(request.getParameter("cust_type"));
			//System.out.println("cust_type="+custtype);
		//	String custtype2=getStr(request.getParameter("cust_type2"));
			String cust_type = getStr(request.getParameter("lbdlmc"));
			String cust_type2 = getStr(request.getParameter("lbxlmc"));
			String industry_type = getStr(request.getParameter("industry_type"));
			//行业门类
			//String industry_level1 =getStr(request.getParameter("industry_level1"));
			//String industry_level2 =getStr(request.getParameter("industry_level2"));
			//String industry_level3 =getStr(request.getParameter("industry_level3"));
			//String industry_level4 =getStr(request.getParameter("industry_level4"));
			String industry_level1 = getStr(request.getParameter("hymlmc"));
			String industry_level2 = getStr(request.getParameter("hydlmc"));
			String industry_level3 = getStr(request.getParameter("hyzlmc"));
			String industry_level4 = getStr(request.getParameter("hyxlmc"));
			//国家 区域 省份 城市
			//String country = getStr(request.getParameter("country"));
			//String area = getStr(request.getParameter("area"));
			//String province = getStr(request.getParameter("province"));
			//String city = getStr(request.getParameter("city"));
	        String country = getStr(request.getParameter("gjmc"));
			//System.out.println("country="+country);
			//String country=getStr(request.getParameter("country"));
			String area = getStr(request.getParameter("qymc"));
			String province = getStr(request.getParameter("sfmc"));
			String city = getStr(request.getParameter("csmc"));
			
			
			String region = getStr(request.getParameter("region"));
			String id_card_no = getStr(request.getParameter("id_card_no"));
			String legal_representative = getStr(request
					.getParameter("legal_representative"));
			String reg_addr = getStr(request.getParameter("reg_addr"));
			String office_addr = getStr(request.getParameter("office_addr"));
			String post_code = getStr(request.getParameter("post_code"));
			String mail_addr = getStr(request.getParameter("mail_addr"));
			String phone = getStr(request.getParameter("phone"));
			String linkman = getStr(request.getParameter("linkman"));

			String mobile_number = getStr(request.getParameter("mobile_number"));
			String fax_number = getStr(request.getParameter("fax_number"));
			String cable_addr = getStr(request.getParameter("cable_addr"));
			String web_site = getStr(request.getParameter("web_site"));
			String ownership = getStr(request.getParameter("ownership"));
			String e_mail = getStr(request.getParameter("e_mail"));
			String scale = getStr(request.getParameter("scale"));
			String org_code = getStr(request.getParameter("org_code"));
			String biz_scope_primary = getStr(request
					.getParameter("biz_scope_primary"));
			String loan_number = getStr(request.getParameter("loan_number"));
                        String loan_number_pwd = getStr(request.getParameter("loan_number_pwd"));
			String license_number = getStr(request
					.getParameter("license_number"));
			String biz_scope_secondary = getStr(request
					.getParameter("biz_scope_secondary"));
			String reg_capital = getStr(request.getParameter("reg_capital"));
			String license_exp_date = getStr(request
					.getParameter("license_exp_date"));
			String reg_type = getStr(request.getParameter("reg_type"));
			String estab_date = getStr(request.getParameter("estab_date"));
			String national_tax_number = getStr(request
					.getParameter("national_tax_number"));
			String land_tax_number = getStr(request
					.getParameter("land_tax_number"));
			String listed_corp_flag = getStr(request
					.getParameter("listed_corp_flag"));
			String imp_exp_flag = getStr(request.getParameter("imp_exp_flag"));
			String info_flag = getStr(request.getParameter("info_flag"));
			String owner_ship = getStr(request.getParameter("owner_ship"));

			//String creator = getStr(request.getParameter("creator"));
			String creator_dept = getStr(request.getParameter("creator_dept"));
			String create_date = getStr(request.getParameter("create_date"));
			String modify_date = getStr(request.getParameter("modify_date"));
			String modificator = getStr(request.getParameter("modificator"));

			String stype = getStr(request.getParameter("savetype"));
			String cust_no_type = getStr(request.getParameter("cust_no_type"));
			
			//ResultSet rsOrg = null;
			//boolean bflag = true;
			//ResultSet rsName=null;
			
			String systemDate = getSystemDate(0);

			String sqlstr;
			String create_dept;
			String creator_deptname = "";
			sqlstr = "select a.id,a.name,b.dept_name,a.department from base_user a left join base_department b on a.department=b.id  where a.id='" + dqczy + "'";
			System.out.println(sqlstr);
			rs = db.executeQuery(sqlstr);
			if (rs.next()) {
				creator_dept = getDBStr(rs.getString("department"));
				creator_deptname = getDBStr(rs.getString("dept_name"));
			}
			LogWriter.logDebug(request, "创建人所属部门："+creator_dept+" 部门名称："+creator_deptname);
			//System.out.println(creator_dept + "123");
	if (savaType.equals("add")) {
				//
				Date dateStr = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				String nowTime = sdf.format(dateStr);
				System.out.println("nowTime="+nowTime);
				//获得流水号
				String nowNumber = OperationUtil.getSerialNumber("承租人","0001",4);
				cust_id = "ERP"+nowTime+nowNumber;
				System.out.println("新的cust_id="+cust_id);
				czid = cust_id;//用于页面跳转

				System.out.println("cust_id" + cust_id);
				czid = cust_id;//用于页面跳转

				//构建用户ID结束
				sql = "insert into cust_info(cust_id,cust_name,cust_ename,cust_byname,cust_type,cust_type2,industry_type,"
				+ "industry_level1,industry_level2,industry_level3,industry_level4,country,area,province,city,"
				+ "region,legal_representative,id_card_no,reg_addr,office_addr,mail_addr,post_code,linkman,phone,"
				+ "mobile_number,fax_number,cable_addr,e_mail,web_site,ownership,scale,org_code,loan_number,loan_number_pwd,"
				+ "biz_scope_primary,biz_scope_secondary,license_number,license_exp_date,"
				+ "reg_capital,reg_type,estab_date,national_tax_number,land_tax_number,listed_corp_flag,"
				+ "imp_exp_flag,memo,info_flag,creator,creator_dept,create_date,parent_company,cust_no_type,flag)"
				+ "values('"
				+ cust_id
				+ "','"
				+ cust_name
				+ "','"
				+ cust_ename
				+ "','"
				+ cust_byname
				+ "','"
				+ cust_type
				+ "','"
				+ cust_type2
				+ "',"
				+ "'"
				+ industry_type
				+ "','"
				+ industry_level1
				+ "','"
				+ industry_level2
				+ "','"
				+ industry_level3
				+ "','"
				+ industry_level4
				+ "','"
				+ country
				+ "',"
				+ "'"
				+ area
				+ "','"
				+ province
				+ "','"
				+ city
				+ "','"
				+ region
				+ "','"
				+ legal_representative
				+ "','"
				+ id_card_no
				+ "','"
				+ reg_addr
				+ "',"
				+ "'"
				+ office_addr
				+ "','"
				+ mail_addr
				+ "','"
				+ post_code
				+ "','"
				+ linkman
				+ "','"
				+ phone
				+ "',"
				+ "'"
				+ mobile_number
				+ "','"
				+ fax_number
				+ "','"
				+ cable_addr
				+ "','"
				+ e_mail
				+ "','"
				+ web_site
				+ "','"
				+ ownership
				+ "','"
				+ scale
				+ "','"
				+ org_code
				+ "','"
				+ loan_number
				+ "','"
        +loan_number_pwd
        + "',"                        
				+ "'"
				+ biz_scope_primary
				+ "','"
				+ biz_scope_secondary
				+ "','"
				+ license_number
				+ "','"
				+ license_exp_date
				+ "','"
				+ reg_capital
				+ "',"
				+ "'"
				+ reg_type
				+ "','"
				+ estab_date
				+ "','"
				+ national_tax_number
				+ "','"
				+ land_tax_number
				+ "','"
				+ listed_corp_flag
				+ "',"
				+ "'"
				+ imp_exp_flag
				+ "','"
				+ memo
				+ "','"
				+ info_flag
				+ "','"
				+ dqczy
				+ "',"
				+ "'"
				+creator_dept
				+ "','"
				+ systemDate
				+ "','"
				+ parent_company
			
				+ "','"
				+ cust_no_type
			
				+ "',1)";

				System.out.print(sql + "+++++++++++++++++");

				flag = db.executeUpdate(sql);
				//客户查询权限中间表
				String sql2 = "insert into cust_query_power(cust_id,query_user_id)values('"+cust_id+"','"+dqczy+"')";
				flag += db.executeUpdate(sql2);
				message = "法人客户登记";
			//	}else{
		//	flag = 0;
			//message="组织机构代码重复或客户名重复，添加客户";
		}
			
			
			if (savaType.equals("add2")) {
				sql = "update cust_info set cust_name='" + cust_name + "','"
				+ cust_ename + "',cust_byname='" + cust_byname
				+ "',cust_type='" + cust_type + "'," + "cust_type2='"
				+ cust_type2 + "',industry_type='" + industry_type
				+ "',industry_level1='" + industry_level1
				+ "',industry_level2='" + industry_level2 + "',"
				+ "industry_level3='" + industry_level3+ "',"
				+ "parent_company='" + parent_company
				+ "',industry_level4='" + industry_level4
				+ "',country='" + country + "',area='" + area + "',"
				+ "province='" + province + "',city='" + city
				+ "',region='" + region + "',"
				+ "legal_representative='" + legal_representative
				+ "',id_card_no='" + id_card_no + "',reg_addr='"
				+ reg_addr + "',office_addr='" + office_addr
				+ "',mail_addr='" + mail_addr + "'," + "post_code='"
				+ post_code + "',linkman='" + linkman + "',web_site='"
				+ web_site + "'," + "mobile_number='" + mobile_number
				+ "',fax_number='" + fax_number + "',cable_addr='"
				+ cable_addr + "',e_mail='" + e_mail + "',web_site='"
				+ web_site + "',ownership='" + ownership + "',scale='"
				+ scale + "',org_code='" + org_code + "',"
				+ "loan_number='" + loan_number+"',loan_number_pwd='"+loan_number_pwd
				+ "',biz_scope_primary='" + biz_scope_primary
				+ "',biz_scope_secondary='" + biz_scope_secondary
				+ "'," + "license_number='" + license_number
				+ "',license_exp_date='" + license_exp_date
				+ "',reg_type='" + reg_type + "',estab_date='"
				+ estab_date + "'," + "national_tax_number='"
				+ national_tax_number + "',land_tax_number='"
				+ land_tax_number + "',listed_corp_flag='"
				+ listed_corp_flag + "',imp_exp_flag='" + imp_exp_flag
				+ "',memo='" + memo + "'," + "info_flag='" + info_flag
				+ "',creator='" + dqczy + "',creator_dept='"
				+ creator_dept + "'," + "create_date='" + systemDate
				+ "',modificator='" + dqczy + "',modify_date='"
				+ systemDate + "'" + "where cust_id='" + cust_id + "'";
				//" insert into cust_flowing (cust_id,flowing) values ('"+cust_id+"','"+nowTime+"')";
				System.out.print(sql);
				flag = db.executeUpdate(sql);
				message = "法人客户登记";
			}
			else if (savaType.equals("mod")) {
				sql = "update cust_info set cust_name='" + cust_name
				+ "',cust_byname='" + cust_byname + "',cust_type='"
				+ cust_type + "'," + "cust_type2='" + cust_type2
				+ "',industry_type='" + industry_type
				+ "',industry_level1='" + industry_level1
				+ "',industry_level2='" + industry_level2 + "',"
				+ "industry_level3='" + industry_level3
				+ "',industry_level4='" + industry_level4
				+ "',country='" + country + "',area='" + area + "',"
				+ "province='" + province + "',city='" + city
				+ "',region='" + region + "',"
				+ "legal_representative='" + legal_representative
				+ "',id_card_no='" + id_card_no + "',office_addr='"
				+ office_addr + "'," + "post_code='" + post_code
				+ "',linkman='" + linkman + "',web_site='" + web_site
				+ "'," + "mobile_number='" + mobile_number
				+ "',scale='" + scale + "',org_code='" + org_code
				+ "'," + "loan_number='" + loan_number
                                + "'," + "loan_number_pwd='" + loan_number_pwd
				+ "',biz_scope_primary='" + biz_scope_primary
				+ "',biz_scope_secondary='" + biz_scope_secondary
				+ "'," + "license_number='" + license_number
				+ "',license_exp_date='" + license_exp_date
				
				+ "',phone='" + phone
				+ "',e_mail='" + e_mail
				+ "',fax_number='" + fax_number
				+ "',ownership='" + ownership
				+ "',cable_addr='"+ cable_addr 
				+ "',reg_capital='"+reg_capital
				+ "',reg_addr='"+ reg_addr
				 + "',mail_addr='"+ mail_addr
				 + "',parent_company='"+ parent_company
				 + "',cust_no_type='"+ cust_no_type
				
				+ "',reg_type='" + reg_type + "',estab_date='"
				+ estab_date + "'," + "national_tax_number='"
				+ national_tax_number + "',land_tax_number='"
				+ land_tax_number + "',listed_corp_flag='"+listed_corp_flag+"',imp_exp_flag='" + imp_exp_flag
				+ "',memo='" + memo + "'," + "info_flag='" + info_flag
				+ "',modificator='" + dqczy + "',modify_date='"
				+ systemDate + "'" + "where cust_id='" + cust_id + "'";
				System.out.print(sql);

				flag = db.executeUpdate(sql);
				message = "修改客户信息";
			}else if (savaType.equals("mod2")) {
				sql = "update cust_info set cust_name='" + cust_name
				+ "',cust_byname='" + cust_byname + "',cust_type='"
				+ cust_type + "'," + "cust_type2='" + cust_type2
				+ "',industry_type='" + industry_type
				+ "',industry_level1='" + industry_level1
				+ "',industry_level2='" + industry_level2 + "',"
				+ "industry_level3='" + industry_level3
				+ "',industry_level4='" + industry_level4
				+ "',country='" + country + "',area='" + area + "',"
				+ "province='" + province + "',city='" + city
				+ "',region='" + region + "',"
				+ "legal_representative='" + legal_representative
				+ "',id_card_no='" + id_card_no + "',office_addr='"
				+ office_addr + "'," + "post_code='" + post_code
				+ "',linkman='" + linkman + "',web_site='" + web_site
				+ "'," + "mobile_number='" + mobile_number
				+ "',scale='" + scale + "',org_code='" + org_code
				+ "'," + "loan_number='" + loan_number
                                + "'," + "loan_number_pwd='" + loan_number_pwd
				+ "',biz_scope_primary='" + biz_scope_primary
				+ "',biz_scope_secondary='" + biz_scope_secondary
				+ "'," + "license_number='" + license_number
				+ "',license_exp_date='" + license_exp_date
				
				+ "',phone='" + phone
				+ "',e_mail='" + e_mail
				+ "',fax_number='" + fax_number
				+ "',ownership='" + ownership
				+ "',cable_addr='"+ cable_addr 
				+ "',reg_capital='"+reg_capital
				+ "',reg_addr='"+ reg_addr
				 + "',mail_addr='"+ mail_addr
				 + "',parent_company='"+ parent_company
				 + "',cust_no_type='"+ cust_no_type
				
				+ "',reg_type='" + reg_type + "',estab_date='"
				+ estab_date + "'," + "national_tax_number='"
				+ national_tax_number + "',land_tax_number='"
				+ land_tax_number + "',listed_corp_flag='"+listed_corp_flag+"',imp_exp_flag='" + imp_exp_flag
				+ "',memo='" + memo + "'," + "info_flag='" + info_flag
				+ "',modificator='" + dqczy + "',modify_date='"
				+ systemDate + "'" + "where cust_id='" + cust_id + "'";
				System.out.print(sql);

				flag = db.executeUpdate(sql);
				message = "修改客户信息";
			}else if (savaType.equals("del")) {
				//先判断是否有项目
				sql = "select proj_id from proj_info where cust_id='"+custId+"'";
				rs = db.executeQuery(sql);
				if(rs.next()){
					message = "该客户下有项目，不允许删除！";
				}else{
					//删除主要联系人
					sql = "delete from cust_person where cust_id='"+cust_id+"'";
					//删除主要股东
					sql += " delete from cust_stockholder where cust_id='"+cust_id+"'";
					//下属公司 cust_member_company
					sql += " delete from cust_member_company where cust_id='"+cust_id+"'";
					//主要参股 cust_share_company
					sql += " delete from cust_share_company where cust_id='"+cust_id+"'";
					//银行账号 cust_account
					sql += " delete from cust_account where cust_id='"+cust_id+"'";
					//信用等级 cust_credit_rank
					sql += " delete from cust_credit_rank where cust_id='"+cust_id+"'";
					//交往记录 cust_intercourse
					sql += " delete from cust_intercourse where cust_id='"+cust_id+"'";
					// cust_query_power
					sql += " delete from cust_query_power where cust_id='"+cust_id+"'";
					db.executeUpdate(sql);
					//没有则删除
					sql = "delete from cust_info where cust_id='" + custId + "'";
					flag = db.executeUpdate(sql);
					LogWriter.logDebug(request, "删除客户信息："+sql);
					message = "删除客户信息";
				}
			}
			rs.close();
			db.close();
	if (flag > 0) {
		String hrefStr = "";
		if (savaType.equals("del")) {
%>
<script type="text/javascript">
opener.window.location.href = "frkh_list.jsp";
alert("<%=message%>成功!");
this.close();
</script>
<%
} else if("mod2".equals(savaType)){
%>
	<script type="text/javascript">
	window.location.href = "frkh_flow_edit.jsp?custId=<%=cust_id%>";
	alert("<%=message%>成功!");
	</script>
<%
} else {
%>
<script type="text/javascript">
window.location.href = "frkh.jsp?custId=<%=cust_id%>";
alert("<%=message%>成功!");
opener.location.reload();
</script>
<%
	}
	} else {
%>
<script type="text/javascript">
alert("<%=message%>失败!");
opener.location.reload();
this.close();
</script>
<%
	}
%>
</BODY>
</html>
