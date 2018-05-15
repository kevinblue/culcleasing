<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*"%>
<%@ page import="dbconn.*"%>
<%@page import="com.tenwa.log.LogWriter"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common_simple.jsp"%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	
</head>

<BODY>
		<%
			String dqczy = (String) session.getAttribute("czyid");
	        System.out.print("join@2"+dqczy);
			//String custId = getStr(request.getParameter("custId"));
			//System.out.println("****"+custId+"&&&&&&&&&&");
				String custId = getStr(request.getParameter("custId"));
			String cust_id = getStr(request.getParameter("cust_id"));
			String systemDate = getSystemDate(0);
			String cust_name = getStr(request.getParameter("cust_name"));
			String cust_ename = getStr(request.getParameter("cust_ename"));
			String sex = getStr(request.getParameter("sex"));
			String nation = getStr(request.getParameter("nation"));
			String id_card_no = getStr(request.getParameter("id_card_no"));
			String brith_date = getStr(request.getParameter("brith_date"));
			
			String lbdldata = getStr(request.getParameter("cust_type"));//客户大类
			String lbxldata = getStr(request.getParameter("cust_type2"));//客户小类
			
			String industry_type = getStr(request.getParameter("industry_type"));//内部行业
			String parent_company=getStr(request.getParameter("parent_company"));
			String license_number=getStr(request.getParameter("license_number"));
			String cust_no_type=getStr(request.getParameter("cust_no_type"));

String industry_level1 = getStr( request.getParameter("hyml") );
String industry_level2 = getStr( request.getParameter("hydl") );
String industry_level3 = getStr( request.getParameter("hyzl") );
String industry_level4 = getStr( request.getParameter("hyxl") );

String country = getStr( request.getParameter("gj") );
String province = getStr( request.getParameter("sf") );
String city = getStr( request.getParameter("cs") );
String area = getStr( request.getParameter("area") );
String region = getStr(request.getParameter("region"));//区县   
			
//String systemDate = getSystemDate(0); //获取系统时间

			String domicile_place = getStr(request
					.getParameter("domicile_place"));
			String work_add = getStr(request.getParameter("work_add"));
			String home_add = getStr(request.getParameter("home_add"));
			String mail_addr = getStr(request.getParameter("mail_addr"));
			String post_code = getStr(request.getParameter("post_code"));
			String phone = getStr(request.getParameter("phone"));
			String mobile_number = getStr(request.getParameter("mobile_number"));
			String fax_number = getStr(request.getParameter("fax_number"));
			String cable_addr = getStr(request.getParameter("cable_addr"));
			String e_mail = getStr(request.getParameter("e_mail"));
			String web_site = getStr(request.getParameter("web_site"));
			String marital_status = getStr(request
					.getParameter("marital_status"));
			String imp_social_relation = getStr(request
					.getParameter("imp_social_relation"));
			String criminal_record = getStr(request
					.getParameter("criminal_record"));
			String bad_hobby = getStr(request.getParameter("bad_hobby"));
			String education = getStr(request.getParameter("education"));
			String school = getStr(request.getParameter("school"));
			String major = getStr(request.getParameter("major"));
			String express_linkman = getStr(request
					.getParameter("express_linkman"));

			String biz_scope = getStr(request.getParameter("biz_scope"));
			String memo = getStr(request.getParameter("memo"));

			String info_flag = getStr(request.getParameter("info_flag"));
			String creator = getStr(request.getParameter("creator"));
	
			String create_date = getStr(request.getParameter("create_date"));
			String modificator = getStr(request.getParameter("modificator"));
			String modify_date = getStr(request.getParameter("modify_date"));
			//String cust_id = getStr(request.getParameter("cust_id"));
	
	//配偶信息
	String match=getStr(request.getParameter("match"));
	System.out.print("match="+match);
	String match_card_no=getStr(request.getParameter("match_card_no"));
	String match_tel=getStr(request.getParameter("match_tel"));
	String matchPhone=getStr(request.getParameter("matchPhone"));
			//String create_dept = "";
			//String userName = (String) session.getAttribute("czyid");
			String sqlstr;
			ResultSet rs;
			int flag = 0;
			String message = "";
			String creator_dept="";
	//String creator_dept = getStr(request.getParameter("creator_dept"));
	String creator_deptname="";
	//String create_dept;
		
//求部门

	sqlstr = "select a.id,a.name,b.dept_name,a.department from base_user a left join base_department b on a.department=b.id  where a.id='" + dqczy + "'";
	System.out.println(sqlstr);
	rs = db.executeQuery(sqlstr);
	System.out.println("creator_dept***************=");
	if(rs.next()){
		//create_dept = getDBStr(rs.getString("name"));
	creator_dept = getDBStr(rs.getString("department"));
	System.out.println("creator_dept="+creator_dept);
	creator_deptname = getDBStr(rs.getString("dept_name"));
	System.out.println("creator_deptname="+creator_deptname);
	}
   
			String stype = getStr(request.getParameter("savetype"));
			if (stype.equals("add")) {
				//构建用户ID开始
			sqlstr = "select top 1  cust_id from vi_cust_all_info_t order by cust_id desc";
			String temp_id = "";
			System.out.println(sqlstr);
			System.out.println(cust_id+"123");
			//	ResultSet rs1;
			rs= db.executeQuery(sqlstr); 
			if ( rs.next() ) {
				temp_id = getDBStr( rs.getString("cust_id") );//获得最近一个产生的ID
		}
			 if ((temp_id == null) || (temp_id.equals(""))) 
					temp_id = "00001";
			else {
			  int num=0;
			  num=Integer.parseInt(temp_id) ;
			  num++;
					String temp_id_max=String.valueOf(num);
					if(Integer.parseInt(temp_id_max) <= 9)
					  temp_id_max = "0000" + (Integer.parseInt(temp_id_max));
					else if (Integer.parseInt(temp_id_max) > 9 && Integer.parseInt(temp_id_max) <= 99)
	                 temp_id_max = "000" + (Integer.parseInt(temp_id_max));
	                 else if (Integer.parseInt(temp_id_max) > 99 && Integer.parseInt(temp_id_max) <= 999)
	                 temp_id_max = "00" + (Integer.parseInt(temp_id_max));
	                 else if (Integer.parseInt(temp_id_max) > 999 && Integer.parseInt(temp_id_max) <= 9999)
	                 temp_id_max = "0" + (Integer.parseInt(temp_id_max));
	              else if (Integer.parseInt(temp_id_max) >= 100000)
	                  temp_id_max = "" + (Integer.parseInt(temp_id_max));
	                  
	                  temp_id=temp_id_max;
				}
				//}
				rs.close();
				cust_id=temp_id;
				custId=cust_id;//用于页面跳转
		
				System.out.println("cust_id"+cust_id);
				//custId = cust_id;//用于页面跳转
	
				//构建用户ID结束

				sqlstr = "insert into cust_ewlp_info (cust_id,cust_name,cust_ename,sex,nation,id_card_no,brith_date,cust_type,cust_type2,industry_type,industry_level1,industry_level2,industry_level3,industry_level4,country,area,province,city,region,domicile_place,work_add,home_add,mail_addr,post_code,phone,mobile_number,fax_number,cable_addr,e_mail,web_site,marital_status,imp_social_relation,criminal_record,bad_hobby,education,school,major,express_linkman,biz_scope,memo,info_flag,creator_dept,creator,create_date,modificator,modify_date,parent_company,license_number,cust_no_type) values (";

				sqlstr += "'" + cust_id + "',";

				if (cust_name != null && !cust_name.equals(""))
					sqlstr += "'" + cust_name + "',";
				else
					sqlstr += "null,";
				if (cust_ename != null && !cust_ename.equals(""))
					sqlstr += "'" + cust_ename + "',";
				else
					sqlstr += "null,";
				if (sex != null && !sex.equals(""))
					sqlstr += "'" + sex + "',";
				else
					sqlstr += "null,";
				if (nation != null && !nation.equals(""))
					sqlstr += "'" + nation + "',";
				else
					sqlstr += "null,";
				if (id_card_no != null && !id_card_no.equals(""))
					sqlstr += "'" + id_card_no + "',";
				else
					sqlstr += "null,";
				if (brith_date != null && !brith_date.equals(""))
					sqlstr += "'" + brith_date + "',";
				else
					sqlstr += "null,";
				if (lbdldata!= null && !lbdldata.equals(""))
					sqlstr += "'" + lbdldata + "',";
				else
					sqlstr += "null,";
				if (lbxldata != null && !lbxldata.equals(""))
					sqlstr += "'" + lbxldata + "',";
				else
					sqlstr += "null,";
				if (industry_type != null && !industry_type.equals(""))
					sqlstr += "'" + industry_type + "',";
				else
					sqlstr += "null,";
				if (industry_level1 != null && !industry_level1.equals(""))
					sqlstr += "'" + industry_level1 + "',";
				else
					sqlstr += "null,";
				if (industry_level2 != null && !industry_level2.equals(""))
					sqlstr += "'" + industry_level2 + "',";
				else
					sqlstr += "null,";
				if (industry_level3 != null && !industry_level3.equals(""))
					sqlstr += "'" + industry_level3 + "',";
				else
					sqlstr += "null,";
				if (industry_level4 != null && !industry_level4.equals(""))
					sqlstr += "'" + industry_level4 + "',";
				else
					sqlstr += "null,";
				if (country != null && !country.equals(""))
					sqlstr += "'" + country + "',";
				else
					sqlstr += "null,";
				if (area != null && !area.equals(""))
					sqlstr += "'" + area + "',";
				else
					sqlstr += "null,";
				if (province != null && !province.equals(""))
					sqlstr += "'" + province + "',";
				else
					sqlstr += "null,";
				if (city != null && !city.equals(""))
					sqlstr += "'" + city + "',";
				else
					sqlstr += "null,";
				if (region != null && !region.equals(""))
					sqlstr += "'" + region + "',";
				else
					sqlstr += "null,";
				if (domicile_place != null && !domicile_place.equals(""))
					sqlstr += "'" + domicile_place + "',";
				else
					sqlstr += "null,";
				if (work_add != null && !work_add.equals(""))
					sqlstr += "'" + work_add + "',";
				else
					sqlstr += "null,";
				if (home_add != null && !home_add.equals(""))
					sqlstr += "'" + home_add + "',";
				else
					sqlstr += "null,";
				if (mail_addr != null && !mail_addr.equals(""))
					sqlstr += "'" + mail_addr + "',";
				else
					sqlstr += "null,";
				if (post_code != null && !post_code.equals(""))
					sqlstr += "'" + post_code + "',";
				else
					sqlstr += "null,";
				if (phone != null && !phone.equals(""))
					sqlstr += "'" + phone + "',";
				else
					sqlstr += "null,";
				if (mobile_number != null && !mobile_number.equals(""))
					sqlstr += "'" + mobile_number + "',";
				else
					sqlstr += "null,";
				if (fax_number != null && !fax_number.equals(""))
					sqlstr += "'" + fax_number + "',";
				else
					sqlstr += "null,";
				if (cable_addr != null && !cable_addr.equals(""))
					sqlstr += "'" + cable_addr + "',";
				else
					sqlstr += "null,";
				if (e_mail != null && !e_mail.equals(""))
					sqlstr += "'" + e_mail + "',";
				else
					sqlstr += "null,";
				if (web_site != null && !web_site.equals(""))
					sqlstr += "'" + web_site + "',";
				else
					sqlstr += "null,";
				if (marital_status != null && !marital_status.equals(""))
					sqlstr += "'" + marital_status + "',";
				else
					sqlstr += "null,";
				if (imp_social_relation != null
				&& !imp_social_relation.equals(""))
					sqlstr += "'" + imp_social_relation + "',";
				else
					sqlstr += "null,";
				if (criminal_record != null && !criminal_record.equals(""))
					sqlstr += "'" + criminal_record + "',";
				else
					sqlstr += "null,";
				if (bad_hobby != null && !bad_hobby.equals(""))
					sqlstr += "'" + bad_hobby + "',";
				else
					sqlstr += "null,";
				if (education != null && !education.equals(""))
					sqlstr += "'" + education + "',";
				else
					sqlstr += "null,";
				if (school != null && !school.equals(""))
					sqlstr += "'" + school + "',";
				else
					sqlstr += "null,";
				if (major != null && !major.equals(""))
					sqlstr += "'" + major + "',";
				else
					sqlstr += "null,";
				if (express_linkman != null && !express_linkman.equals(""))
					sqlstr += "'" + express_linkman + "',";
				else
					sqlstr += "null,";
				if (biz_scope != null && !biz_scope.equals(""))
					sqlstr += "'" + biz_scope + "',";
				else
					sqlstr += "null,";
				if (memo != null && !memo.equals(""))
					sqlstr += "'" + memo + "',";
				else
					sqlstr += "null,";
				if (info_flag != null && !info_flag.equals(""))
					sqlstr += "'" + info_flag + "',";
				else
					sqlstr += "null,";
				
			   sqlstr+="'"+creator_dept+"',";
			   sqlstr+="'"+dqczy+"',";
			   sqlstr+="'"+systemDate+"',";
			   sqlstr+="'"+dqczy+"',";
			   sqlstr+="'"+systemDate+"',";
			   sqlstr+="'"+parent_company+"',";
			   sqlstr+="'"+license_number+"',";
			   sqlstr+="'"+cust_no_type+"'";
			   
				sqlstr += ")";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				//if(marital_status.equals("是")){
				System.out.print("marital_status="+marital_status);
				String sqls="";
				sqls="insert into cust_mate(cust_id,match,match_card_no,match_tel,matchPhone) values('"+cust_id+"','"+match+"','"+match_card_no+"','"+match_tel+"','"+matchPhone+"')";
				System.out.println("sqls="+sqls);
				flag=db.executeUpdate(sqls);
				
				//客户查询权限中间表
				String sql2 = "insert into cust_query_power(cust_id,query_user_id)values('"+cust_id+"','"+dqczy+"')";
				flag += db.executeUpdate(sql2);
			//	}
				db.close();
				message = "添加客户信息";
			}
			if (stype.equals("mod")) {
				sqlstr = "update cust_ewlp_info set ";
				sqlstr += " cust_name='" + cust_name + "',";
				sqlstr += " cust_ename='" + cust_ename + "',";
				sqlstr += " sex='" + sex + "',";
				sqlstr += " nation='" + nation + "',";
				sqlstr += " id_card_no='" + id_card_no + "',";
				sqlstr += " brith_date='" + brith_date + "',";
				sqlstr += " cust_type='" + lbdldata + "',";
				sqlstr += " cust_type2='" + lbxldata + "',";
				sqlstr += " industry_type='" + industry_type + "',";
				sqlstr += " industry_level1='" + industry_level1 + "',";
				sqlstr += " industry_level2='" + industry_level2 + "',";
				sqlstr += " industry_level3='" + industry_level3 + "',";
				sqlstr += " industry_level4='" + industry_level4 + "',";
				sqlstr += " country='" + country + "',";
				sqlstr += " area='" + area + "',";
				sqlstr += " province='" + province + "',";
				sqlstr += " city='" + city + "',";
				sqlstr += " region='" + region + "',";
				sqlstr += " domicile_place='" + domicile_place + "',";
				sqlstr += " work_add='" + work_add + "',";
				sqlstr += " home_add='" + home_add + "',";
				sqlstr += " mail_addr='" + mail_addr + "',";
				sqlstr += " post_code='" + post_code + "',";
				sqlstr += " phone='" + phone + "',";
				sqlstr += " mobile_number='" + mobile_number + "',";
				sqlstr += " fax_number='" + fax_number + "',";
				sqlstr += " cable_addr='" + cable_addr + "',";
				sqlstr += " e_mail='" + e_mail + "',";
				sqlstr += " web_site='" + web_site + "',";
				sqlstr += " marital_status='" + marital_status + "',";
				sqlstr += " imp_social_relation='" + imp_social_relation + "',";
				sqlstr += " criminal_record='" + criminal_record + "',";
				sqlstr += " bad_hobby='" + bad_hobby + "',";
				sqlstr += " education='" + education + "',";
				sqlstr += " school='" + school + "',";
				sqlstr += " major='" + major + "',";
				sqlstr += " express_linkman='" + express_linkman + "',";
				sqlstr += " biz_scope='" + biz_scope + "',";
				sqlstr += " memo='" + memo + "',";
				sqlstr += " info_flag='" + info_flag + "',";
			
				sqlstr += " modificator='" + dqczy + "',";
				sqlstr += " parent_company='" + parent_company + "',";
				sqlstr += " license_number='" + license_number + "',";
				sqlstr += " cust_no_type='" + cust_no_type + "',";
				sqlstr += " modify_date='" + systemDate + "'";
				
				sqlstr += " where cust_id='" + custId + "'";
				System.out.println(sqlstr);
				flag = db.executeUpdate(sqlstr);
				
				////if(marital_status.equals("是")){
				System.out.print("marital_status="+marital_status);
				String sqls="";
				sqls="update  cust_mate set match='"+match+"',match_card_no='"+match_card_no+"',match_tel='"+match_tel+"',matchPhone='"+matchPhone+"' where cust_id='"+custId+"'";
				System.out.println("sqls="+sqls);
				flag+=db.executeUpdate(sqls);
				//}
				db.close();
				message = "修改客户信息";
			}
			if (stype.equals("del")) {
				String sql="";
				//先判断是否有项目
				sql = "select proj_id from proj_info where cust_id='"+custId+"'";
				rs = db.executeQuery(sql);
				if(rs.next()){
					message = "该客户下有项目，不允许删除！";
				}else{
					//删除主要个人
					sql = "delete from cust_person where cust_id='"+cust_id+"'";
					//银行账号 cust_account
					sql += " delete from cust_account where cust_id='"+cust_id+"'";
					//信用等级 cust_credit_rank
					sql += " delete from cust_credit_rank where cust_id='"+cust_id+"'";
					//交往记录 cust_intercourse
					sql += " delete from cust_intercourse where cust_id='"+cust_id+"'";
					db.executeUpdate(sql);
					// cust_query_power
					sql += " delete from cust_query_power where cust_id='"+cust_id+"'";
					db.executeUpdate(sql);
					
					//没有则删除
					sql = "delete from cust_ewlp_info where cust_id='" + custId + "'";
					sql+= " delete from cust_mate where cust_id='"+custId+"'";
					flag = db.executeUpdate(sql);
					LogWriter.logDebug(request, "删除客户信息："+sql);
					message = "删除客户信息";
				}
			}
		if(flag>0){
		String hrefStr="";
		if(stype.equals("del")){
%>
        <script type="text/javascript">
		opener.window.location.href = "khzrxx_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
<%
		}else{
		%>
        <script type="text/javascript">
		window.location.href = "khzrxx.jsp?custId=<%=custId%>";
		alert("<%=message%>成功!");
		opener.location.reload();
		</script>
<%
		}
	}else{
%>
        <script type="text/javascript">
		alert("<%=message%>失败!");
		opener.location.reload();
		this.close();
		</script>
<%	
	}
	db.close();
%>
</body>
</html>