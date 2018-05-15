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
String cust_oname = getStr( request.getParameter("cust_oname") );
String org_code = getStr( request.getParameter("org_code") );
String stock = getStr( request.getParameter("stock") );

String nbhydata = getStr( request.getParameter("nbhydata") );

String hydldata = getStr( request.getParameter("industry_level1") );
String hyxldata = getStr( request.getParameter("industry_level2") );
String lbdldata = getStr( request.getParameter("category_level1") );

String quality = getStr( request.getParameter("quality") );
String scale_name = getStr( request.getParameter("scale_name") );
String biz_method = getStr( request.getParameter("biz_method") );
String biz_scope_primary = getStr( request.getParameter("biz_scope_primary") );
String biz_scope_secondary = getStr( request.getParameter("biz_scope_secondary") );
String legal_representative = getStr( request.getParameter("legal_representative") );
String id_card_no = getStr( request.getParameter("id_card_no") );

String gjdata = getStr( request.getParameter("country") );
String sfdata = getStr( request.getParameter("province") );
String csdata = getStr( request.getParameter("city") );
String county = getStr( request.getParameter("county") );

String listed_corp_flag = getStr( request.getParameter("listed_corp_flag") );
String imp_exp_flag = getStr( request.getParameter("imp_exp_flag") );
String reg_number = getStr( request.getParameter("reg_number") );	
String estab_date = getStr( request.getParameter("estab_date") );
String license_exp_date = getStr( request.getParameter("license_exp_date") );
String annual_due_date = getStr( request.getParameter("annual_due_date") );
String national_tax_number = getStr( request.getParameter("national_tax_number") );
String land_tax_number = getStr( request.getParameter("land_tax_number") );
String reg_capital = getStr( request.getParameter("reg_capital") );
String reg_capital_cur_name = getStr( request.getParameter("reg_capital_cur_name") );
String fact_capital = getStr( request.getParameter("fact_capital") );
String fact_capital_cur_name = getStr( request.getParameter("fact_capital_cur_name") );
String loan_number = getStr( request.getParameter("loan_number") );
String phone = getStr( request.getParameter("phone") );
String mobile_number = getStr( request.getParameter("mobile_number") );
String cable_addr = getStr( request.getParameter("cable_addr") );
String fax_number = getStr( request.getParameter("fax_number") );
String tax_number = getStr( request.getParameter("tax_number") );
String mailing_addr = getStr( request.getParameter("mailing_addr") );
String company_addr = getStr( request.getParameter("company_addr") );
String reg_addr = getStr( request.getParameter("reg_addr") );
String web_site = getStr( request.getParameter("web_site") );
String post_code = getStr( request.getParameter("post_code") );
String memo = getStr( request.getParameter("memo") );
String cust_mesage = getStr( request.getParameter("cust_mesage") );
String biz_scope = getStr( request.getParameter("biz_scope") );
String creator_dept = getStr( request.getParameter("creator_dept") );
String creator = getStr( request.getParameter("creator") );
String position = getStr( request.getParameter("position") );
String cust_id ="";
String create_dept = "";
String stype =  getStr( request.getParameter("savetype") );
String sqlstr="";
ResultSet rs=null;
ResultSet rsOrg = null;
boolean bflag = true;
int flag=0;
String message="";
try{
	sqlstr="select name from base_user where id='"+dqczy+"'";
	System.out.println(sqlstr);
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		create_dept = getDBStr(rs.getString("name"));
	}
	if ( stype.equals("add") ){
           if(org_code.length()>0){
		sqlstr = "select count(*) from vi_cust_info where org_code='"+org_code+"'";//构建SQL语句
		System.out.println(sqlstr);
		rsOrg = db.executeQuery(sqlstr); 
		if(rsOrg.next()){
			if(rsOrg.getInt(1)>0){
				bflag = false;
			}else{
				bflag = true;
			}
		}
            }
		if(bflag){
			message="添加客户信息";
			//构建用户ID开始
			sqlstr = "select top 1  cust_id from vi_cust_all_info order by cust_id desc";
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
			sqlstr="insert into cust_info (cust_id,cust_name,cust_ename,cust_byname,stock_relation,org_code,industry_type,industry_level1,industry_level2,cust_type,ownership,scale,biz_method,biz_scope_primary,biz_scope_secondary,legal_representative,id_card_no,country,province,city,listed_corp_flag,imp_exp_flag,reg_number,estab_date,license_exp_date,annual_due_date,national_tax_number,land_tax_number,reg_capital,reg_capital_cur,reg_capital2,reg_capital_cur2,loan_number,phone,mobile_number,cable_addr,fax_number,tax_number,mail_add,post_addr,reg_addr,web_site,post_code,memo,biz_scope,cust_mesage,creator_dept,creator,create_date,county,position) values (";
			sqlstr+="'"+cust_id+"',";
			if(cust_name!=null&&!cust_name.equals(""))
			sqlstr+="'"+cust_name+"',";
			else
			sqlstr+="null,";
			if(cust_ename!=null&&!cust_ename.equals(""))
			sqlstr+="'"+cust_ename+"',";
			else
			sqlstr+="null,";
			if(cust_oname!=null&&!cust_oname.equals(""))
			sqlstr+="'"+cust_oname+"',";
			else
			sqlstr+="null,";
			if(stock!=null&&!stock.equals(""))
			sqlstr+="'"+stock+"',";
			else
			sqlstr+="null,";
			if(org_code!=null&&!org_code.equals(""))
			sqlstr+="'"+org_code+"',";
			else
			sqlstr+="null,";
			if(nbhydata!=null&&!nbhydata.equals(""))
			sqlstr+="'"+nbhydata+"',";
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
			if(quality!=null&&!quality.equals(""))
			sqlstr+="'"+quality+"',";
			else
			sqlstr+="null,";
			if(scale_name!=null&&!scale_name.equals(""))
			sqlstr+="'"+scale_name+"',";
			else
			sqlstr+="null,";
			if(biz_method!=null&&!biz_method.equals(""))
			sqlstr+="'"+biz_method+"',";
			else
			sqlstr+="null,";
			if(biz_scope_primary!=null&&!biz_scope_primary.equals(""))
			sqlstr+="'"+biz_scope_primary+"',";
			else
			sqlstr+="null,";
			if(biz_scope_secondary!=null&&!biz_scope_secondary.equals(""))
			sqlstr+="'"+biz_scope_secondary+"',";
			else
			sqlstr+="null,";
			if(legal_representative!=null&&!legal_representative.equals(""))
			sqlstr+="'"+legal_representative+"',";
			else
			sqlstr+="null,";
			if(id_card_no!=null&&!id_card_no.equals(""))
			sqlstr+="'"+id_card_no+"',";
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
			if(listed_corp_flag!=null&&!listed_corp_flag.equals(""))
			sqlstr+="'"+listed_corp_flag+"',";
			else
			sqlstr+="null,";
			if(imp_exp_flag!=null&&!imp_exp_flag.equals(""))
			sqlstr+="'"+imp_exp_flag+"',";
			else
			sqlstr+="null,";
			if(reg_number!=null&&!reg_number.equals(""))
			sqlstr+="'"+reg_number+"',";
			else
			sqlstr+="null,";
			if(estab_date!=null&&!estab_date.equals(""))
			sqlstr+="'"+estab_date+"',";
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
			if(national_tax_number!=null&&!national_tax_number.equals(""))
			sqlstr+="'"+national_tax_number+"',";
			else
			sqlstr+="null,";
			if(land_tax_number!=null&&!land_tax_number.equals(""))
			sqlstr+="'"+land_tax_number+"',";
			else
			sqlstr+="null,";
			if(reg_capital!=null&&!reg_capital.equals(""))
			sqlstr+="'"+reg_capital+"',";
			else
			sqlstr+="null,";
			if(reg_capital_cur_name!=null&&!reg_capital_cur_name.equals(""))
			sqlstr+="'"+reg_capital_cur_name+"',";
			else
			sqlstr+="null,";
			if(fact_capital!=null&&!fact_capital.equals(""))
			sqlstr+="'"+fact_capital+"',";
			else
			sqlstr+="null,";
			if(fact_capital_cur_name!=null&&!fact_capital_cur_name.equals(""))
			sqlstr+="'"+fact_capital_cur_name+"',";
			else
			sqlstr+="null,";
			if(loan_number!=null&&!loan_number.equals(""))
			sqlstr+="'"+loan_number+"',";
			else
			sqlstr+="null,";
			if(phone!=null&&!phone.equals(""))
			sqlstr+="'"+phone+"',";
			else
			sqlstr+="null,";
			if(mobile_number!=null&&!mobile_number.equals(""))
			sqlstr+="'"+mobile_number+"',";
			else
			sqlstr+="null,";
			if(cable_addr!=null&&!cable_addr.equals(""))
			sqlstr+="'"+cable_addr+"',";
			else
			sqlstr+="null,";			
			if(fax_number!=null&&!fax_number.equals(""))
			sqlstr+="'"+fax_number+"',";
			else
			sqlstr+="null,";
			if(tax_number!=null&&!tax_number.equals(""))
			sqlstr+="'"+tax_number+"',";
			else
			sqlstr+="null,";
			if(mailing_addr!=null&&!mailing_addr.equals(""))
			sqlstr+="'"+mailing_addr+"',";
			else
			sqlstr+="null,";
			if(company_addr!=null&&!company_addr.equals(""))
			sqlstr+="'"+company_addr+"',";
			else
			sqlstr+="null,";			
			if(reg_addr!=null&&!reg_addr.equals(""))
			sqlstr+="'"+reg_addr+"',";
			else
			sqlstr+="null,";
			if(web_site!=null&&!web_site.equals(""))
			sqlstr+="'"+web_site+"',";
			else
			sqlstr+="null,";
			if(post_code!=null&&!post_code.equals(""))
			sqlstr+="'"+post_code+"',";
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
			if(cust_mesage!=null&&!cust_mesage.equals(""))
			sqlstr+="'"+cust_mesage+"',";
			else
			sqlstr+="null,";
			sqlstr+="'"+create_dept+"',";
			sqlstr+="'"+dqczy+"',";
			sqlstr+="'"+systemDate+"',";
			sqlstr+="'"+county+"',";
			sqlstr+="'"+position+"'";
			sqlstr+=")";
			System.out.println(sqlstr);
			flag = db.executeUpdate(sqlstr);
		}else{
			flag = 0;
			message="组织机构代码重复，添加客户";
		}
	}
	if ( stype.equals("mod") ){ 
		sqlstr = "select count(*) from vi_cust_info where org_code='"+org_code+"' and cust_id!="+czid;
		System.out.println(sqlstr);
		rsOrg = db.executeQuery(sqlstr); 
		if(rsOrg.next()){
			if(rsOrg.getInt(1)>0){
				bflag = false;
			}else{
				bflag = true;
			}
		}
		if(bflag){
			message="修改法人客户";
			sqlstr="update cust_info set ";
			sqlstr+=" cust_name='"+cust_name+"',";
			sqlstr+=" cust_ename='"+cust_ename+"',";
			sqlstr+=" cust_byname='"+cust_oname+"',";
			sqlstr+=" stock_relation='"+stock+"',";
			sqlstr+=" org_code='"+org_code+"',";
			sqlstr+=" industry_type='"+nbhydata+"',";
			sqlstr+=" industry_level1='"+hydldata+"',";
			sqlstr+=" industry_level2='"+hyxldata+"',";
			sqlstr+=" cust_type='"+lbdldata+"',";
			sqlstr+=" ownership='"+quality+"',";
			sqlstr+=" scale='"+scale_name+"',";
			sqlstr+=" biz_method='"+biz_method+"',";
			sqlstr+=" biz_scope_primary='"+biz_scope_primary+"',";
			sqlstr+=" biz_scope_secondary='"+biz_scope_secondary+"',";
			sqlstr+=" legal_representative='"+legal_representative+"',";
			sqlstr+=" id_card_no='"+id_card_no+"',";
			sqlstr+=" country='"+gjdata+"',";
			sqlstr+=" province='"+sfdata+"',";
			sqlstr+=" city='"+csdata+"',";
			sqlstr+=" listed_corp_flag='"+listed_corp_flag+"',";
			sqlstr+=" imp_exp_flag='"+imp_exp_flag+"',";
			sqlstr+=" reg_number='"+reg_number+"',";
			sqlstr+=" estab_date='"+estab_date+"',";
			sqlstr+=" license_exp_date='"+license_exp_date+"',";
			sqlstr+=" annual_due_date='"+annual_due_date+"',";
			sqlstr+=" national_tax_number='"+national_tax_number+"',";
			sqlstr+=" land_tax_number='"+land_tax_number+"',";
			sqlstr+=" reg_capital='"+reg_capital+"',";
			sqlstr+=" reg_capital_cur='"+reg_capital_cur_name+"',";
			sqlstr+=" reg_capital2='"+fact_capital+"',";
			sqlstr+=" reg_capital_cur2='"+fact_capital_cur_name+"',";
			sqlstr+=" loan_number='"+loan_number+"',";
			sqlstr+=" mobile_number='"+mobile_number+"',";
			sqlstr+=" phone='"+phone+"',";
			sqlstr+=" fax_number='"+fax_number+"',";
			sqlstr+=" tax_number='"+tax_number+"',";
			sqlstr+=" cable_addr='"+cable_addr+"',";
			sqlstr+=" reg_addr='"+reg_addr+"',";
			sqlstr+=" web_site='"+web_site+"',";
			sqlstr+=" post_code='"+post_code+"',";
			sqlstr+=" memo='"+memo+"',";
			sqlstr+=" biz_scope='"+biz_scope+"',";
			sqlstr+=" cust_mesage='"+cust_mesage+"',";
			sqlstr+=" mail_add='"+mailing_addr+"',";
			sqlstr+=" county='"+county+"',";
			sqlstr+=" post_addr='"+company_addr+"',";
			sqlstr+=" modificator='"+dqczy+"',";
			sqlstr+=" position='"+position+"',";
			sqlstr+=" modify_date='"+systemDate+"'";
			sqlstr+=" where cust_id='"+czid+"'";
			System.out.println(sqlstr);
			flag = db.executeUpdate(sqlstr);
		}else{
			flag = 0;
			message="组织机构代码重复，修改客户";
		}
	}
	if ( stype.equals("del") ){ 
	sqlstr="delete from cust_info where  cust_id='"+czid+"'";
	flag = db.executeUpdate(sqlstr);
	message="删除法人客户";;
	}
	System.out.println("stype"+stype);
	
	rs.close();
	rsOrg.close();
	db.close();
}catch(Exception e){
	System.out.println(e);
}
if(flag==0){
		%>
        <script>
		alert("<%=message%>失败!");
		window.history.go(-1);
		//opener.location.reload();
		//this.close();
		</script>
		<%		
	}else{
		String hrefStr="";
		if(stype.equals("del")){
			%>
        <script>
		opener.window.location.href = "khmpxx_list.jsp";
		alert("<%=message%>成功!");
		this.close();
		</script>
		<%
		}else{
		%>
        <script>
		window.location.href = "khmpxx.jsp?czid=<%=czid%>";
		alert("<%=message%>成功!");
		opener.location.reload();
		</script>
		<%
		}
	}
%>