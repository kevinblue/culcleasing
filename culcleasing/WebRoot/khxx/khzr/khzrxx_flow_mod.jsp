<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title>客户名片信息 - 客户信息管理(个人)</title>

	<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/validator.js"></script>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/public.js"></SCRIPT>
	<SCRIPT Language="Javascript" SRC="/tenwa/js/publicEvent.js"></SCRIPT>
	<script language="javascript" src="/dict/js/js_dictionary.js"></script>
	<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_zrrkh_mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

%>


<script>
function isConsort(){
			var consort=document.getElementsByName("marital_status");
			var index="是";
			for(var i=0;i<consort.length;i++){
				if(consort[i].checked==true){
					index=consort[i].value;
					break;
				}
			}
			if(index=="否"){
				document.getElementById("trConsort1").style.display="none";
				document.getElementById("trConsort2").style.display="none";
				document.getElementById("match").value="";
				document.getElementById("match_card_no").value="";
				document.getElementById("match_tel").value="";
				document.getElementById("matchPhone").value="";
			}else{
				document.getElementById("trConsort1").style.display="";
				document.getElementById("trConsort2").style.display="";
			}
			
		}
</script>

	<%
		String custId = getStr(request.getParameter("custId"));
			String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator),base_department.dept_name,match,match_card_no,match_tel,matchPhone from vi_cust_ewlp_info left join cust_mate on vi_cust_ewlp_info.cust_id=cust_mate.cust_id left join base_department on vi_cust_ewlp_info.creator_dept=base_department.id where vi_cust_ewlp_info.cust_id='" + custId+ "'";
		//String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_ewlp_info where cust_id='"
		//		+ custId+ "'";
		ResultSet rs = db.executeQuery(sqlstr);

		String cust_type = "";//
		String cust_name = "";//客户名称 *
		String cust_ename = "";//客户英文名
		String sex = "";//客户性别
		String nation = "";
		String id_card_no = "";//证件号码 *
		String brith_date = "";//出生年月
		String lbdldata = "";
		String lbxldata = "";
		String industry_type = "";
		String hymldata = "";
		String hydldata = "";
		String hyzldata = "";
		String hyxldata = "";
		String industry_level1="";
		String csdata = "";
		String qxdata = "";
		String gjdata = "";
		String sfdata = "";
//hyml hydl hyzl hyxl gj sf cs area cust_type cust_type2
		String domicile_place = "";
		String work_add = "";
		String home_add = "";
		String mail_addr = "";
		String post_code = "";
		String phone = "";
		String mobile_number = "";
		String fax_number = "";
		String cable_addr = "";
		String e_mail = "";
		String web_site = "";
		String marital_status = "";
		String imp_social_relation = "";
		String criminal_record = "";
		String bad_hobby = "";
		String education = "";
		String school = "";
		String major = "";
		String express_linkman = "";
		String biz_scope = "";
		String memo = "";
		String info_flag = "";
		String creator = "";
		String creator_dept = "";
			String dept_name = "";
		String create_date = "";
		String modificator = "";
		String modify_date = "";
        String cust_type2="";
        String industry_level2="";
        String industry_level3="";
        String industry_level4="";
        String country="";
        String area="";
        String province="";
        String city="";
        //配偶信息
        String match="";
        String match_card_no="";
        String match_tel="";
        String matchPhone="";
        String parent_company="";
        String license_number="";
        String cust_no_type="";
		if (rs.next()) {
		match = getDBStr(rs.getString("match"));
		match_card_no = getDBStr(rs.getString("match_card_no"));
		match_tel = getDBStr(rs.getString("match_tel"));
		matchPhone = getDBStr(rs.getString("matchPhone"));
		
			cust_name = getDBStr(rs.getString("cust_name"));
			cust_ename = getDBStr(rs.getString("cust_ename"));
			sex = getDBStr(rs.getString("sex"));
			nation = getDBStr(rs.getString("nation"));
			id_card_no = getDBStr(rs.getString("id_card_no"));
			brith_date = getDBDateStr(rs.getString("brith_date"));
			parent_company = getDBStr(rs.getString("parent_company"));
			license_number = getDBStr(rs.getString("license_number"));
			System.out.println("license_number=========="+license_number);
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		cust_type = getDBStr( rs.getString("cust_type") );
		lbxldata = getDBStr( rs.getString("lbxlmc") );
		cust_type2 = getDBStr( rs.getString("cust_type2") );
		industry_type = getDBStr(rs.getString("industry_type"));
			
		//quality = getDBStr( rs.getString("quality") );
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyzldata = getDBStr( rs.getString("hyzlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		hymldata = getDBStr( rs.getString("hymlmc") );
		
		industry_level1=getDBStr(rs.getString("industry_level1"));
		industry_level2=getDBStr(rs.getString("industry_level2"));
		industry_level3=getDBStr(rs.getString("industry_level3"));
		industry_level4=getDBStr(rs.getString("industry_level4"));
		//国家、省份、城市
		gjdata = getDBStr( rs.getString("gjmc") );
		qxdata = getDBStr( rs.getString("qymc") );
		sfdata = getDBStr( rs.getString("sfmc") );
		csdata = getDBStr( rs.getString("csmc") );
		country=getDBStr( rs.getString("country") );
		province=getDBStr( rs.getString("province") );
		area=getDBStr( rs.getString("area") );
		city=getDBStr( rs.getString("city") );
			domicile_place = getDBStr(rs.getString("domicile_place"));
			work_add = getDBStr(rs.getString("work_add"));
			home_add = getDBStr(rs.getString("home_add"));
			mail_addr = getDBStr(rs.getString("mail_addr"));
			post_code = getDBStr(rs.getString("post_code"));
			phone = getDBStr(rs.getString("phone"));
			mobile_number = getDBStr(rs.getString("mobile_number"));
			fax_number = getDBStr(rs.getString("fax_number"));
			cable_addr = getDBStr(rs.getString("cable_addr"));
			e_mail = getDBStr(rs.getString("e_mail"));
			web_site = getDBStr(rs.getString("web_site"));
			marital_status = getDBStr(rs.getString("marital_status"));
			imp_social_relation = getDBStr(rs
			.getString("imp_social_relation"));
			criminal_record = getDBStr(rs.getString("criminal_record"));
			bad_hobby = getDBStr(rs.getString("bad_hobby"));
			education = getDBStr(rs.getString("education"));
			school = getDBStr(rs.getString("school"));
			major = getDBStr(rs.getString("major"));
			express_linkman = getDBStr(rs.getString("express_linkman"));
			biz_scope = getDBStr(rs.getString("biz_scope"));
			memo = getDBStr(rs.getString("memo"));
			System.out.println("memo="+memo);
			info_flag = getDBStr(rs.getString("info_flag"));
			creator = getDBStr(rs.getString("dengjiren"));
			dept_name = getDBStr(rs.getString("dept_name"));
			create_date = getDBStr(rs.getString("create_date"));
			modificator = getDBStr(rs.getString("xiugairen"));
			modify_date = getDBStr(rs.getString("modify_date"));
			cust_no_type=getDBStr(rs.getString("cust_no_type"));
			//hyml hydl hyzl hyxl gj sf cs area cust_type cust_type2
		}
		rs.close();
		String sql="select * from dbo.base_department where id='"+creator_dept+"'";
	ResultSet rs1 = db.executeQuery(sql);
	//String dept_name="";
	if(rs1.next()){
	dept_name=getDBStr(rs1.getString("dept_name"));
	}
	System.out.println(dept_name+"12");
	rs1.close(); 
		db.close();
	%>
	<body onLoad="public_onload();fun_winMax();">
		<form name="form1" method="post" action="khzrxx_save.jsp"
			onSubmit="return Validator.Validate(this,3);">
			<style type="text/css">
body {
	overflow: hidden;
}
</style>

			<div id=bgDiv>


				<table class="title_top" width=100% height=100% align=center
					cellspacing=0 border="0" cellpadding="0">
					<tr valign="top" class="tree_title_txt">
						<td class="tree_title_txt" height=26 valign="middle">
							个人客户信息管理 &gt; 修改客户名片信息
						</td>
					</tr>
					<tr valign="top">
						<td align=center width=100% height=100%>
							<table align=center width=98% border="0" cellspacing="0"
								cellpadding="0" style="margin-top: 0px">
								<tr>
									<td scope="row" nowrap>
										<!--操作按钮开始-->
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="maintab_dh">
												<td nowrap>
													<BUTTON class="btn_2" name="btnSave" value="提交"
														type="submit">
														<img src="../../images/save.gif" align="absmiddle"
															border="0">
														提交生效
													</button>
												</td>
											</tr>
										</table>
										<!--操作按钮结束-->
										
									</td>
								</tr>
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
													修 改
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
							<center>
                                                              <!--
								<div id="divH" class="tabBody"
									style="background: #ffffff; width: 96%; height: 500px; overflow: auto;">
									<div id="TD_tab_0">
                                               -->

<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">

										<input type="hidden" name="savetype" value="mod2">
										<input type="hidden" name="custId" value="<%=custId%>">
										<table border="0" cellspacing="0" cellpadding="0" width="98%"
											align="center" class="tab_table_title">
											<tr>
												<td scope="row" nowrap>
													客户名称：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cust_name" readonly value="<%=cust_name%>"
														type="text"  maxB="100" Require="true">
													<span class="biTian">*</span>
												</td>

												<td scope="row" nowrap>
													英文名称：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cust_ename" value="<%=cust_ename%>"
														type="text"  maxB="100" dataType="English">
												</td>
												<td scope="row" nowrap>
													性别：
												</td>
												<%
												if(sex.equals("男")){
												 %>
												 <td scope="row" nowrap>
													<input name="sex" type="radio" value="男" checked="checked">
													男
													<input name="sex" type="radio" value="女">
													女
												
												</td>
												 <%
												 }else{
												  %>
												  <td scope="row" nowrap>
													<input name="sex" type="radio" value="男" >
													男
													<input name="sex" type="radio" value="女" checked="checked">
													女
												
												</td>
												  <%
												  }
												   %>
												
												
											</tr>
											
											<tr>
												<td scope="row" nowrap>
													民族：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="nation" value="<%=nation%>" type="text"
														 maxB="100">
												</td>
													
											<td scope="row" nowrap>
													证件类型：
												</td>
												
												  <td nowrap class="text"><select class="text" name="cust_no_type"><script>w(mSetOpt("<%=cust_no_type%> ","|身份证|警官证|毕业证|护照|签证"));</script></select></td>
												
												<td scope="row" nowrap>
													证件号码：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="id_card_no" readonly value="<%=id_card_no%>"
														type="text"  maxB="100">
													<span class="biTian">*</span>
												</td>

												
											</tr>
											
											<tr>

		

	
    <td scope="row" nowrap>客户所属行业门类：</td>
    <td scope="row" nowrap><input class="text" name="hymldata" type="text"  value="<%=hymldata%>" readonly  Require="true"  maxB="100">
   		<input name="hyml" type="hidden" value="<%=industry_level1%>" onPropertychange="form1.hydldata.value='';form1.hydl.value='';form1.hyzldata.value='';form1.hyzl.value='';form1.hyxldata.value='';form1.hyxl.value='';"><img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer"
 		onclick="SpecialDataWindow('行业门类','kh_hyml_gb','hymlmc','hymlbh','hymlmc','stringfld','hymlbh','form1.hymldata','form1.hyml');">
 		<span class="biTian">*</span> </td>
 		
 			<td scope="row" nowrap>户口所在地：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="domicile_place" value="<%=domicile_place%>"
														type="text" >
													
												</td>
												<td scope="row" nowrap>
													出生日期
												</td>
												<td scope="row" nowrap>
													<input class="text" name="brith_date" value="<%=brith_date%>"
														type="text"  maxB="100" readonly>
												</td>
 		

</tr>
<tr>
 	<td scope="row" nowrap>客户所属行业大类：</td>
    	<td scope="row" nowrap><input class="text" name="hydldata" type="text"  value="<%=hydldata%>" readonly  Require="true"  maxB="100">
    	<input name="hydl" type="hidden" value="<%=industry_level2%>" onPropertychange="form1.hyzldata.value='';form1.hyzl.value='';form1.hyxldata.value='';form1.hyxl.value='';"><img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hyml,'该行业大类所属门类','kh_hydl_gb','hydlmc','hydlbh','hymlbh','stringfld','hydlmc','form1.hydldata','form1.hydl');"> 
		<span class="biTian">*</span></td>

	  	  	
	  	<td scope="row" nowrap>客户类别大类：</td>
	  	
    <td scope="row" nowrap>
    	<input type="text" class="text" name="lbdldata" readonly Require="true" value="<%=lbdldata%>"   maxB="100"/>
    	<input type="hidden" name="cust_type"  value="<%=cust_type%>" /> 
    	<img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','客户类别大类','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.cust_type');">
		<span class="biTian">*</span>
	</td>
	  	
    <td scope="row" nowrap>客户类别小类：</td>
    <td scope="row" nowrap><input class="text" type="text"  name="lbxldata" readonly Require="ture"  maxB="100" value="<%=lbxldata%>"/>
    <input type="hidden" name="cust_type2" value="<%=cust_type2 %>"/> 
    <img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.cust_type','客户类别大类','ssdl','string','客户类别小类','kh_lbxl','lbxlmc','id','lbxlmc','lbxlmc','asc','form1.lbxldata','form1.cust_type2');"/>
	<span class="biTian">*</span></td>
	  	
	  
	


</tr>
<tr> 
    <td scope="row" nowrap>客户所属行业中类：</td>
    	<td scope="row" nowrap><input class="text" name="hyzldata" type="text"  value="<%=hyzldata%>" readonly  Require="true"  maxB="100">
    	<input name="hyzl" type="hidden" value="<%=industry_level3%>" onPropertychange="form1.hyxldata.value='';form1.hyxl.value='';"><img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hydl,'该行业中类所属大类','kh_hyzl_gb','hyzlmc','hyzlbh','substring(hyzlbh,1,2)','stringfld','hyzlmc','form1.hyzldata','form1.hyzl');">
		<span class="biTian">*</span>
	  	</td>
	<td scope="row" nowrap>国家：</td>
    <td scope="row" nowrap><input class="text" type="text"  name="gjdata" value="中华人民共和国" readonly Require="true"  maxB="100"/>
    <input type="hidden" name="gj" value="CHN" onPropertychange="form1.qxdata.value='';form1.area.value='';" value="<%=country%>"/>
    <img src="../../images/sbtn_more.gif" alt="选" align="absmiddle" style="cursor:pointer" onClick="OpenDataWindow('','','','','国家','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.gj');">
	<span class="biTian">*</span></td>
	<td scope="row" nowrap>区域：</td>
    <td scope="row" nowrap><input class="text" type="text"  name="qxdata" value="<%=qxdata%>" readonly Require="true"  maxB="100"/>
    <input type="hidden" name="area" value="<%=area%>" onPropertychange="form1.sfdata,form1.sf.value='';"/> 
    <img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','区域','jb_qyxx','qymc','qyid','qymc','qymc','asc','form1.qxdata','form1.area');">
	<span class="biTian">*</span></td>
    </tr>    
    
    <tr>						
 
  	 <td scope="row" nowrap>客户所属行业小类：</td>
    	<td scope="row" nowrap><input class="text" name="hyxldata" type="text"  value="<%=hyxldata%>" readonly  Require="true"  maxB="100">
    	<input name="hyxl" type="hidden" value="<%=industry_level4%>" onPropertychange=""><img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer"
		onclick="SimpleDataWindow(form1.hyzl,'该行业小类所属中类','kh_hyxl_gb','hyxlmc','hyxlbh','substring(hyxlbh,2,3)','stringfld','hyxlmc','form1.hyxldata','form1.hyxl');">
		<span class="biTian">*</span>
	  	</td>
	  	<td scope="row" nowrap>
													省份：
												</td>
												<td scope="row" nowrap>
													<input class="text" type="text"  name="sfdata" readonly
														Require="true" value="<%=sfdata %>" />
													<input type="hidden" name="sf" value="<%=province%>"
														onPropertychange="form1.csdata.value='';form1.cs.value='';" />
													<img src="../../images/sbtn_more.gif" alt="选"
														align="absmiddle" style="cursor: pointer"
														onClick="OpenDataWindow('form1.area','区域','qyid','string','省份','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.sf');">
													<span class="biTian">*</span>
												</td>
    <td scope="row" nowrap>城市：</td>
    <td scope="row" nowrap><input class="text" type="text"  name="csdata" value="<%=csdata%>" readonly Require="true"  maxB="100">
    <input type="hidden" name="cs" value="<%=city%>" onPropertychange="form1.reg.value='';form1.region.value='';"> 
    <img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.sf','省份','sfid','string','城市','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.cs');">
	<span class="biTian">*</span>
	</td>
		  
	
  </tr>	
											<tr>
												<td scope="row" nowrap>
													单位地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="work_add" value="<%=work_add%>" type="text"
														 maxB="100">
												</td>
											
												<td scope="row" nowrap>
													住宅地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="home_add" value="<%=home_add%>" type="text"
														 maxB="100">
													<span class="biTian">*</span>
												</td>

												<td scope="row" nowrap>
													邮寄地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="mail_addr" value="<%=mail_addr%>" type="text"
														 maxB="100">
												</td>
											</tr>
											
											<tr>
												<td scope="row" nowrap>
													邮编：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="post_code" value="<%=post_code%>" type="text"
														 maxB="100"  minB="6" maxB="6">
													<span class="biTian">*</span>
												</td>

												<td scope="row" nowrap>
													电话：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="phone" value="<%=phone%>" type="text"
														 maxB="100">
												</td>
													<td scope="row" nowrap>
													手机：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="mobile_number" value="<%=mobile_number%>"
														type="text"  maxB="100">
													<span class="biTian">*</span>
												</td>
											</tr>
											
											<tr>
												<td scope="row" nowrap>
													传真：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="fax_number" value="<%=fax_number%>" type="text"  maxB="100">
														
												</td>
											
												<td scope="row" nowrap>
													电挂：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="cable_addr" value="<%=cable_addr%>"
														type="text"  maxB="100">
												
												</td>

												<td scope="row" nowrap>
													E-mail地址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="e_mail" value="<%=e_mail%>" type="text"
														 maxB="100" dataType="Email">
												</td>
											</tr>
											
											<tr>
												<td scope="row" nowrap>
													网址：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="web_site" value="<%=web_site%>" type="text"
														 maxB="100" dataType="Url">
												
												</td>

												<td scope="row" nowrap>
													婚姻状况：
												</td>
												<td scope="row" nowrap>
												<%if(marital_status.equals("是")){ %>
												<input name="marital_status" type="radio" value="是"
														checked="checked"  onclick="isConsort()">
													已婚
													<input name="marital_status" type="radio" value="否"
														onclick="isConsort()">
													未婚
												<%
												}else{
												  
												 %>
												
										
													<input name="marital_status" type="radio" value="是"
														 onclick="isConsort()">
													已婚
													<input name="marital_status" type="radio" value="否"
													checked="checked" 	onclick="isConsort()">
													未婚
													
												
												<%
												}
												 %>
												 </td>
												 <td  scope="row" nowrap>所属公司:</td><td scope="row" nowrap><input class="text" name="parent_company" type="text" value="<%=parent_company %>"></td>
												 </tr>
												<tr id="trConsort1">
												<td scope="row" nowrap>
													配偶姓名：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="match" value="<%=match%>"
														type="text"  maxB="20" >
												</td>
												<td scope="row" nowrap>
													配偶身份证号：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="match_card_no" value="<%=match_card_no%>"
														type="text"  maxB="50"  dataType="IdCard">
												</td>
												<td scope="row" nowrap>营业执照号:</td>
												<td scope="row" nowrap><input class="text" name="license_number" type="text" value="<%=license_number %>"></td>
												</tr>
												<tr id="trConsort2">
												
												<td scope="row" nowrap>
													配偶手机号码：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="match_tel" value="<%=match_tel%>"
														type="text"  maxB="50" dataType="Mobile_T">
												</td>
												<td scope="row" nowrap>
													配偶固定住机号：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="matchPhone" value="<%=matchPhone%>"
														type="text"  maxB="50"  >
												</td>
												<td scope="row" nowrap>内部行业：</td>
												<td scope="row" nowrap>
													<input class="text" name="industry_type" 
														value="<%=industry_type%>" type="text" 
														maxB="100">
													
												</td>
												</tr>
												
											<tr>
												<td scope="row" nowrap>
													有无犯罪记录：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="criminal_record" value="<%=criminal_record%>"
														type="text" >
												</td>
										
												<td scope="row" nowrap>
													不良嗜好：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="bad_hobby" value="<%=bad_hobby%>" type="text"
														 maxB="100" readonly>
													
												</td>

												<td scope="row" nowrap>
													学历：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="education" value="<%=education%>" type="text"
														 maxB="100" readonly>
												</td>
											</tr>
											
											<tr>
												<td scope="row" nowrap>
													毕业学校：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="school" value="<%=school%>" type="text"
														 maxB="100">
												
												</td>

												<td scope="row" nowrap>
													专业：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="major" value="<%=major%>" type="text"
														 maxB="100">
												</td>
												<td scope="row" nowrap>
													紧急联系人：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="express_linkman" value="<%=express_linkman%>"
														type="text" >
												
												</td>
											</tr>
											<tr>
											
												<td scope="row" nowrap>
													信息状态：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="info_flag" value="<%=info_flag%>" type="text"
														 maxB="100">
												</td>
														<td scope="row" nowrap>
													重要社会关系：
												</td>
												<td scope="row" nowrap>
													<input class="text" name="imp_social_relation"
														value="<%=imp_social_relation%>" type="text" >
												
										</td>
												
											</tr>
											
											
										
											 <tr>
											    <td scope="row" nowrap>经营范围：</td>
	<td ><textarea class="text" name="biz_scope" rows="3" value="<%=biz_scope%>"><%=biz_scope %></textarea></td>
   <td scope="row" nowrap>备注：</td>
	<td><textarea class="text" name="memo" rows="3" value="<%=memo%>"><%=memo %></textarea></td>
   </tr>
										</table>
									</div>

									<div id="TD_tab_1" style="display: none;">
										选择卡中的内容2
									</div>
									<div id="TD_tab_2" style="display: none;">
										选择卡中的内容3 选择卡中可能包含以下内容： 注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。

									</div>

							</center>
							<table width=96% align=center border="0" cellspacing="0"
								cellpadding="0">
								<tr>
									<td width="50%"></td>
									<td width="50%" valign="middle" align="right">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<!--添加结束-->
		</form>

		<!-- end cwMain -->
	</body>
</html>
