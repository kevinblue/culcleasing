<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common_simple.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>个人客户(法人)明细 - 客户行业信息管理</title>

		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
	</head>
	<body>
		<table class="title_top" width=100% height=100% align="center"
			cellspacing=0 border="0" cellpadding="0">
			<tr valign="top" class="tree_title_txt">
				<td class="tree_title_txt" height=26 valign="middle">
					客户信息管理 &gt; 客户行业信息
				</td>
			</tr>
			<tr valign="top">
				<td align=center width=100% height=100%>
					<table align=center width=96% border="0" cellspacing="0"
						cellpadding="0" style="margin-top: 0px">
						<tr>
							<td height="1" bgcolor="#DFDFDF"></td>
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
						<tr>
							<td width="100%">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td id="Form_tab_0" class="Form_tab" width=70 align=center
											onClick="chgTabN()" valign="middle">
											详细信息
										</td>

										<td id="Form_tab_1" class="Form_tab" width=0 align=center
											onClick="chgTabN()" valign="middle"></td>
										<td id="Form_tab_2" class="Form_tab" width=0 align=center
											onClick="chgTabN()" valign="middle"></td>

									</tr>
								</table>
								<script language="javascript">
ShowTabN(0);
</script>
							</td>
						</tr>
						<tr>
							<td class="tab_subline" width="100%" height="2"></td>
						</tr>
					</table>
					<!-- end cwTop -->

					<!-- end cwCellTop -->
					<div id="divH" class="tabBody"
						style="background: #ffffff; width: 96%; height: 500px; overflow: auto;">
						<div id="TD_tab_0">
							<%
request.setCharacterEncoding("gbk");
String cust_id=getDBStr(request.getParameter("cust_id"));// 客户编号
System.out.println("-----------------------------"+cust_id);
String industry_type=getDBStr(request.getParameter("industry_type"));//内部行业
System.out.println("-----------------------------"+industry_type);
//定义变量--医疗
String trade="";//客户行业信息
String board_name="";//项目所属板块
String cust_name="";//客户名称
String contract_id="";// 合同编号
String proj_devp_way="";// 项目开发方式
String proj_industry="";// 项目所属行业

String qualification_grade="";// 资质等级
String employees_amount="";// 在职员工数
String open_bed_amount="";// 开放床位数
String bed_use_rate="";// 病床使用率
String year_out_number="";// 年出院人次

String current_assets="";// 当期资产负债率
String medical_revenue="";// 医疗药品收入
String hospital_scale_level="";// 医院规模等级
String leased_customers="";// 承租客户


String year_doorsee="";// 年门诊量
String remark="";// 备注

//船舶
String company_name="";// 公司名称
String employeer_amount="";// 职工人数
String establishing_time="";// 成立时间
String control_capacity="";// 控制运力
String free_ship_number="";// 自由船舶数量

String free_engine="";// 自由动力
String main_ship_style="";// 主要船型
String main_business_routes="";// 主要经营航线
String waterway_num="";// 水运证号
String business_scope="";// 经营范围
String end_time="";// 到期日
//教育
String staff_number="";// 教职工人数
String school_enrolments="";// 在校人数
String school_property="";// 学校性质
String tuition="";// 学费
String government_funding="";// 政府拨款
String enrollment="";// 招生人数

String employment_figure="";// 就业人数
String area="";// 所在区域

//机械
String company_set_year="";//企业成立年限
String employee_amount="";//在职员工数
String register_capital="";//注册资本
String company_quality="";//企业性质
String old_assets="";//最近年度资产负债率
String old_sell_revenue="";//最近年度销售收入
String curr_sell_revenue="";//当前销售收入
String company_credit_level="";//企业信用等级

String sqlStr="";
if(industry_type.contains("医疗行业")){
	sqlStr="select top 1 bd.trade as trade,bd.board_name as board_name,info.cust_name as cust_name,cim.* from dbo.contract_industry_medical cim "+
           "left join contract_info ci on ci.contract_id=cim.contract_id "+
           "left join base_trade bd on bd.code=ci.industry_type left join cust_info info on info.cust_id=cim.cust_id"+
           " where cim.cust_id='"+cust_id+"' order by cim.id desc";
           System.out.println("输出sql语句医疗---------"+sqlStr);
           ResultSet rs=db.executeQuery(sqlStr);
           if(rs.next()){
           		trade=getDBStr(rs.getString("trade"));
           		board_name=getDBStr(rs.getString("board_name"));
           		cust_name=getDBStr(rs.getString("cust_name"));
           		contract_id=getDBStr(rs.getString("contract_id"));
           		proj_devp_way=getDBStr(rs.getString("proj_devp_way"));
           		proj_industry=getDBStr(rs.getString("proj_industry"));
           		qualification_grade=getDBStr(rs.getString("qualification_grade"));
           		employees_amount=getDBStr(rs.getString("employees_amount"));
           		open_bed_amount=getDBStr(rs.getString("open_bed_amount"));
           		bed_use_rate=getDBStr(rs.getString("bed_use_rate"));
           		year_doorsee=getDBStr(rs.getString("year_doorsee"));
           		year_out_number=getDBStr(rs.getString("year_out_number"));
           		current_assets=getDBStr(rs.getString("current_assets"));
           		medical_revenue=getDBStr(rs.getString("medical_revenue"));
           		hospital_scale_level=getDBStr(rs.getString("hospital_scale_level"));
           		leased_customers=getDBStr(rs.getString("leased_customers"));
           		remark=getDBStr(rs.getString("remark"));
           		
           }      
           rs.close();
           %>

							<table border="0" cellspacing="0" cellpadding="0" width="98%"
								align="center" class="tab_table_title">
								
								<tr>
									<td scope="row" nowrap width="15%">
										资质等级：
									</td>
									<td scope="row" nowrap width="15%"><%=qualification_grade %></td>
									<td scope="row" nowrap width="15%">
										在职员工数：
									</td>
									<td scope="row" nowrap width="15%"><%=employees_amount %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										开放床位数：
									</td>
									<td scope="row" nowrap width="15%"><%=open_bed_amount %></td>
									<td scope="row" nowrap width="15%">
										病床使用率：
									</td>
									<td scope="row" nowrap width="15%"><%=bed_use_rate %>%
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										年门诊量：
									</td>
									<td scope="row" nowrap width="15%"><%=year_doorsee %></td>
									<td scope="row" nowrap width="15%">
										年出院人次：
									</td>
									<td scope="row" nowrap width="15%"><%=year_out_number %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										当期资产负债率：
									</td>
									<td scope="row" nowrap width="15%"><%=current_assets %></td>
									<td scope="row" nowrap width="15%">
										医疗药品收入：
									</td>
									<td scope="row" nowrap width="15%"><%=medical_revenue %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										医院规模等级：
									</td>
									<td scope="row" nowrap width="15%"><%=hospital_scale_level %></td>
									<td scope="row" nowrap width="15%">
										承租客户（附）：
									</td>
									<td scope="row" nowrap width="15%"><%=leased_customers %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										备注：
									</td>
									<td scope="row" nowrap width="15%"><%=remark %></td>
								</tr>
							</table>
							<%
}else if(industry_type.contains("医疗管理")){
sqlStr="select top 1 bd.trade as trade,bd.board_name as board_name,info.cust_name as cust_name,cim.* from dbo.contract_industry_medical_manage cim "+
           "left join contract_info ci on ci.contract_id=cim.contract_id "+
           "left join base_trade bd on bd.code=ci.industry_type left join cust_info info on info.cust_id=cim.cust_id"+
           " where cim.cust_id='"+cust_id+"' order by cim.id desc";
           System.out.println("输出sql语句医疗管理---------"+sqlStr);
           ResultSet rs4=db.executeQuery(sqlStr);
           if(rs4.next()){
           		trade=getDBStr(rs4.getString("trade"));
           		board_name=getDBStr(rs4.getString("board_name"));
           		cust_name=getDBStr(rs4.getString("cust_name"));
           		contract_id=getDBStr(rs4.getString("contract_id"));
           		proj_devp_way=getDBStr(rs4.getString("proj_devp_way"));
           		proj_industry=getDBStr(rs4.getString("proj_industry"));
           		qualification_grade=getDBStr(rs4.getString("qualification_grade"));
           		employees_amount=getDBStr(rs4.getString("employees_amount"));
           		open_bed_amount=getDBStr(rs4.getString("open_bed_amount"));
           		bed_use_rate=getDBStr(rs4.getString("bed_use_rate"));
           		year_doorsee=getDBStr(rs4.getString("year_doorsee"));
           		year_out_number=getDBStr(rs4.getString("year_out_number"));
           		current_assets=getDBStr(rs4.getString("current_assets"));
           		medical_revenue=getDBStr(rs4.getString("medical_revenue"));
           		hospital_scale_level=getDBStr(rs4.getString("hospital_scale_level"));
           		leased_customers=getDBStr(rs4.getString("leased_customers"));
           		remark=getDBStr(rs4.getString("remark"));
           		
           }      
           rs4.close();
           %>

							<table border="0" cellspacing="0" cellpadding="0" width="98%"
								align="center" class="tab_table_title">
						

								<tr>
									<td scope="row" nowrap width="15%">
										资质等级：
									</td>
									<td scope="row" nowrap width="15%"><%=qualification_grade %></td>
									<td scope="row" nowrap width="15%">
										在职员工数：
									</td>
									<td scope="row" nowrap width="15%"><%=employees_amount %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										开放床位数：
									</td>
									<td scope="row" nowrap width="15%"><%=open_bed_amount %></td>
									<td scope="row" nowrap width="15%">
										病床使用率：
									</td>
									<td scope="row" nowrap width="15%"><%=bed_use_rate %>%
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										年门诊量：
									</td>
									<td scope="row" nowrap width="15%"><%=year_doorsee %></td>
									<td scope="row" nowrap width="15%">
										年出院人次：
									</td>
									<td scope="row" nowrap width="15%"><%=year_out_number %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										当期资产负债率：
									</td>
									<td scope="row" nowrap width="15%"><%=current_assets %></td>
									<td scope="row" nowrap width="15%">
										医疗药品收入：
									</td>
									<td scope="row" nowrap width="15%"><%=medical_revenue %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										医院规模等级：
									</td>
									<td scope="row" nowrap width="15%"><%=hospital_scale_level %></td>
									<td scope="row" nowrap width="15%">
										承租客户（附）：
									</td>
									<td scope="row" nowrap width="15%"><%=leased_customers %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										备注：
									</td>
									<td scope="row" nowrap width="15%"><%=remark %></td>
								</tr>
							</table>
							<%
}else if(industry_type.contains("机械") || industry_type.contains("机床")){
	sqlStr="select top 1 bd.trade as trade,bd.board_name as board_name,info.cust_name as cust_name,cima.* from dbo.contract_industry_machine cima "+
           "left join contract_info ci on ci.contract_id=cima.contract_id "+
           "left join base_trade bd on bd.code=ci.industry_type left join cust_info info on info.cust_id=cima.cust_id"+
           " where cima.cust_id='"+cust_id+"' order by cima.id desc";
           System.out.println("输出sql语句机械---------"+sqlStr);
           ResultSet rs3=db.executeQuery(sqlStr);
           if(rs3.next()){
          		trade=getDBStr(rs3.getString("trade"));
           		board_name=getDBStr(rs3.getString("board_name"));
           		cust_name=getDBStr(rs3.getString("cust_name"));
           		current_assets=getDBStr(rs3.getString("current_assets"));
           		old_assets=getDBStr(rs3.getString("old_assets"));
           		old_sell_revenue=getDBStr(rs3.getString("old_sell_revenue"));
           		curr_sell_revenue=getDBStr(rs3.getString("curr_sell_revenue"));
           		company_credit_level=getDBStr(rs3.getString("company_credit_level"));
           		company_set_year=getDBStr(rs3.getString("company_set_year"));
           		employee_amount=getDBStr(rs3.getString("employee_amount"));
           		register_capital=getDBStr(rs3.getString("register_capital"));
           		company_quality=getDBStr(rs3.getString("company_quality"));
           		remark=getDBStr(rs3.getString("remark"));
           }
           rs3.close();
           %>
							<table border="0" cellspacing="0" cellpadding="0" width="98%"
								align="center" class="tab_table_title">
								<tr>
									<td scope="row" nowrap width="15%">
										企业成立年限：
									</td>
									<td scope="row" nowrap width="15%"><%=company_set_year %></td>
									<td scope="row" nowrap width="15%">
										在职员工：
									</td>
									<td scope="row" nowrap width="15%"><%=employee_amount %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										注册资本：
									</td>
									<td scope="row" nowrap width="15%"><%=register_capital %></td>
									<td scope="row" nowrap width="15%">
										企业性质：
									</td>
									<td scope="row" nowrap width="15%"><%=company_quality %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										最近年度资产负债率:
									</td>
									<td scope="row" nowrap width="15%"><%=old_assets %></td>
									<td scope="row" nowrap width="15%">
										最近年度销售收入
									</td>
									<td scope="row" nowrap width="15%"><%=old_sell_revenue %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										当前销售收入:
									</td>
									<td scope="row" nowrap width="15%"><%=curr_sell_revenue %></td>
									<td scope="row" nowrap width="15%">
										企业信用等级
									</td>
									<td scope="row" nowrap width="15%"><%=company_credit_level %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										当前资产负债率：
									</td>
									<td scope="row" nowrap width="15%"><%=current_assets %></td>
									<td scope="row" nowrap width="15%">
										备注：
									</td>
									<td scope="row" nowrap width="15%"><%=remark %></td>
								</tr>
							</table>
							<%
}else if(industry_type.contains("教育")){
	sqlStr="select top 1 bd.trade as trade,bd.board_name as board_name,info.cust_name as cust_name,cie.* from dbo.contract_industry_education cie "+
           "left join contract_info ci on ci.contract_id=cie.contract_id "+
           "left join base_trade bd on bd.code=ci.industry_type left join cust_info info on info.cust_id=cie.cust_id"+
           " where cie.cust_id='"+cust_id+"' order by cie.id desc";
           System.out.println("输出sql语句教育---------"+sqlStr);
           ResultSet rs2=db.executeQuery(sqlStr);
           if(rs2.next()){
           		trade=getDBStr(rs2.getString("trade"));
           		board_name=getDBStr(rs2.getString("board_name"));
           		cust_name=getDBStr(rs2.getString("cust_name"));
           		staff_number=getDBStr(rs2.getString("staff_number"));
           		school_enrolments=getDBStr(rs2.getString("school_enrolments"));
           		school_property=getDBStr(rs2.getString("school_property"));
           		tuition=getDBStr(rs2.getString("tuition"));
           		government_funding=getDBStr(rs2.getString("government_funding"));
           		enrollment=getDBStr(rs2.getString("enrollment"));
           		employment_figure=getDBStr(rs2.getString("employment_figure"));
           		area=getDBStr(rs2.getString("area"));
           		remark=getDBStr(rs2.getString("remark"));
           		
           }
           rs2.close();
           %>
							<table border="0" cellspacing="0" cellpadding="0" width="98%"
								align="center" class="tab_table_title">
								
								<tr>
									<td scope="row" nowrap width="15%">
										教职工人数：
									</td>
									<td scope="row" nowrap width="15%"><%=staff_number %></td>
									<td scope="row" nowrap width="15%">
										在校人数：
									</td>
									<td scope="row" nowrap width="15%"><%=school_enrolments %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										学校性质：
									</td>
									<td scope="row" nowrap width="15%"><%=school_property %></td>
									<td scope="row" nowrap width="15%">
										学费：
									</td>
									<td scope="row" nowrap width="15%"><%=tuition %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										政府拨款：
									</td>
									<td scope="row" nowrap width="15%"><%=government_funding %>元
									</td>
									<td scope="row" nowrap width="15%">
										招生人数：
									</td>
									<td scope="row" nowrap width="15%"><%=enrollment %>人
									</td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										就业人数：
									</td>
									<td scope="row" nowrap width="15%"><%=employment_figure %>人
									</td>
									<td scope="row" nowrap width="15%">
										所在区域：
									</td>
									<td scope="row" nowrap width="15%"><%=area %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										备注：
									</td>
									<td scope="row" nowrap width="15%"><%=remark %></td>
								</tr>
							</table>
							<%
}else if(industry_type.contains("船舶")){
	sqlStr="select top 1 bd.trade as trade,bd.board_name as board_name,info.cust_name as cust_name,cis.* from dbo.contract_industry_ship cis "+
           "left join contract_info ci on ci.contract_id=cis.contract_id "+
           "left join base_trade bd on bd.code=ci.industry_type left join cust_info info on info.cust_id=cis.cust_id"+
           " where cis.cust_id='"+cust_id+"' order by  cis.id desc ";
           System.out.println("输出sql语句船舶---------"+sqlStr);
           ResultSet rs1=db.executeQuery(sqlStr);
           if(rs1.next()){
          		trade=getDBStr(rs1.getString("trade"));
           		board_name=getDBStr(rs1.getString("board_name"));
           		cust_name=getDBStr(rs1.getString("cust_name"));
           		company_name=getDBStr(rs1.getString("company_name"));
           		employeer_amount=getDBStr(rs1.getString("employeer_amount"));
           		establishing_time=getDBStr(rs1.getString("establishing_time"));
           		control_capacity=getDBStr(rs1.getString("control_capacity"));
           		free_ship_number=getDBStr(rs1.getString("free_ship_number"));
           		free_engine=getDBStr(rs1.getString("free_engine"));
           		main_ship_style=getDBStr(rs1.getString("main_ship_style"));
           		main_business_routes=getDBStr(rs1.getString("main_business_routes"));
           		waterway_num=getDBStr(rs1.getString("waterway_num"));
           		business_scope=getDBStr(rs1.getString("business_scope"));
           		end_time=getDBStr(rs1.getString("end_time"));
           		remark=getDBStr(rs1.getString("remark"));
           }
           rs1.close();
           %>
							<table border="0" cellspacing="0" cellpadding="0" width="98%"
								align="center" class="tab_table_title">
								
								<tr>
									<td scope="row" nowrap width="15%">
										公司名称：
									</td>
									<td scope="row" nowrap width="15%"><%=company_name %></td>
									<td scope="row" nowrap width="15%">
										职工人数：
									</td>
									<td scope="row" nowrap width="15%"><%=employeer_amount %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										成立时间：
									</td>
									<td scope="row" nowrap width="15%"><%=establishing_time %></td>
									<td scope="row" nowrap width="15%">
										控制运力：
									</td>
									<td scope="row" nowrap width="15%"><%=control_capacity %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										自有船舶数量：
									</td>
									<td scope="row" nowrap width="15%"><%=free_ship_number %></td>
									<td scope="row" nowrap width="15%">
										自有动力：
									</td>
									<td scope="row" nowrap width="15%"><%=free_engine %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										主要船型：
									</td>
									<td scope="row" nowrap width="15%"><%=main_ship_style %></td>
									<td scope="row" nowrap width="15%">
										主要经营航线：
									</td>
									<td scope="row" nowrap width="15%"><%=main_business_routes %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										水运证号：
									</td>
									<td scope="row" nowrap width="15%"><%=waterway_num %></td>
									<td scope="row" nowrap width="15%">
										经营范围：
									</td>
									<td scope="row" nowrap width="15%"><%=business_scope %></td>
								</tr>
								<tr>
									<td scope="row" nowrap width="15%">
										到期日：
									</td>
									<td scope="row" nowrap width="15%"><%=end_time %></td>
									<td scope="row" nowrap width="15%">
										备注：
									</td>
									<td scope="row" nowrap width="15%"><%=remark %></td>
								</tr>
							</table>
						</div>
					</div>
				</td>
			</tr>
		</table>
	<%
	}
%>
	</body>
</html>
<%if(null != db){db.close();}%>