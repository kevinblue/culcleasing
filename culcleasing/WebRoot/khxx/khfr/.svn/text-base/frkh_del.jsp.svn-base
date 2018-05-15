<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>删除客户名片信息信息 - 客户信息管理</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_frkh_del",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

	String custId = getStr( request.getParameter("custId") );
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator)from vi_cust_info where cust_id='"+custId+"'"; 
	ResultSet rs = db.executeQuery(sqlstr);
	String cust_id="";//客户名称\省份
	String cust_name="";
	String cust_ename="";
	String cust_byname="";
	String cust_type="";
	String cust_type2="";
	String industry_type="";
	String industry_Level1="";
	String industry_Level2="";
	String industry_Level3="";
	String industry_level4="";
	String country="";
	String province="";
	String city="";
	String memo="";
	String id_card_no="";
	String legal_representative="";
	String reg_addr="";
	String office_addr="";
	String post_code="";
	String mail_addr="";
	String phone="";
	String linkman="";
	String creator="";
	String imp_exp_flag="";
	String listed_corp_flag="";
	String land_tax_number="";
	String national_tax_number="";
	String scale="";
	String e_mail="";
	String ownership="";
	String mobile_number="";
	String cable_addr="";
	String org_code="";
	String license_number="";
	String loan_number="";
        String loan_number_pwd="";
	String biz_scope_primary="";
	String web_site="";
	String fax_number="";
	String biz_scope_secondary="";
	String reg_capital="";
	String reg_type="";
	String license_exp_date="";
	String estab_date="";
	String creator_dept="";
	String info_flag="";
	String modify_date="";
	String create_date="";
	String area="";
	String region="";
	String modificator="";
	String djr="";
	String provinceName="";
	String reg_money="";
	String assets="";
	//客户类别
	String lbdlmc="";
	String lbxlmc="";
	//国家 区域 省份 城市
	String gjmc="";
	String qymc="";
	String sfmc="";
	String csmc="";
	//门类 大类 中类 小类
	String hymlmc="";
	String hydlmc="";
	String hyzlmc="";
	String hyxlmc="";
	if(rs.next()){
	lbdlmc = getDBStr( rs.getString("lbdlmc") );
		lbxlmc = getDBStr( rs.getString("lbxlmc") );
		gjmc = getDBStr( rs.getString("gjmc") );
		qymc = getDBStr( rs.getString("qymc") );
		sfmc = getDBStr( rs.getString("sfmc") );
		csmc = getDBStr( rs.getString("csmc") );
		hymlmc = getDBStr( rs.getString("hymlmc") );
		hydlmc = getDBStr( rs.getString("hydlmc") );
		hyzlmc = getDBStr( rs.getString("hyzlmc") );
		hyxlmc = getDBStr( rs.getString("hyxlmc") );
		cust_id=getDBStr(rs.getString("cust_id"));
		cust_name=getDBStr(rs.getString("cust_name"));
		cust_ename=getDBStr(rs.getString("cust_ename"));
		cust_byname=getDBStr(rs.getString("cust_byname"));
		city=getDBStr(rs.getString("city"));
		memo=getDBStr(rs.getString("memo"));
		cust_type=getDBStr(rs.getString("cust_type"));
		cust_type2=getDBStr(rs.getString("cust_type2"));
		industry_type=getDBStr(rs.getString("industry_type"));
		industry_Level1=getDBStr(rs.getString("industry_Level1"));
		industry_Level2=getDBStr(rs.getString("industry_Level2"));
		industry_Level3=getDBStr(rs.getString("industry_Level3"));
		industry_level4=getDBStr(rs.getString("industry_level4"));
		country=getDBStr(rs.getString("country"));
		String	scale_name = "";//企业规模（定级）
		area=getDBStr(rs.getString("area"));
		region=getDBStr(rs.getString("region"));
		id_card_no=getDBStr(rs.getString("id_card_no"));
		legal_representative=getDBStr(rs.getString("legal_representative"));
		reg_addr=getDBStr(rs.getString("reg_addr"));
		office_addr=getDBStr(rs.getString("office_addr"));
		post_code=getDBStr(rs.getString("post_code"));
		mail_addr=getDBStr(rs.getString("mail_addr"));
		phone=getDBStr(rs.getString("phone"));
		linkman=getDBStr(rs.getString("linkman"));
		cust_byname=getDBStr(rs.getString("cust_byname"));
		province=getDBStr(rs.getString("province"));
		mobile_number=getDBStr(rs.getString("mobile_number"));
		fax_number=getDBStr(rs.getString("fax_number"));
	    cable_addr=getDBStr(rs.getString("cable_addr"));
		web_site=getDBStr(rs.getString("web_site"));
		ownership=getDBStr(rs.getString("ownership"));
		e_mail=getDBStr(rs.getString("e_mail"));
	    scale=getDBStr(rs.getString("scale"));
	    org_code=getDBStr(rs.getString("org_code"));
	    biz_scope_primary=getDBStr(rs.getString("biz_scope_primary"));
	   	loan_number=getDBStr(rs.getString("loan_number"));
loan_number_pwd=getDBStr(rs.getString("loan_number_pwd"));
	   	license_number=getDBStr(rs.getString("license_number"));
	   	biz_scope_secondary=getDBStr(rs.getString("biz_scope_secondary"));
		reg_capital=getDBStr(rs.getString("reg_capital"));
	    license_exp_date=getDBStr(rs.getString("license_exp_date"));
		reg_type=getDBStr(rs.getString("reg_type"));
		estab_date=getDBStr(rs.getString("estab_date"));
		national_tax_number=getDBStr(rs.getString("national_tax_number"));
	    land_tax_number=getDBStr(rs.getString("land_tax_number"));
	    listed_corp_flag=getDBStr(rs.getString("listed_corp_flag"));
	    imp_exp_flag=getDBStr(rs.getString("imp_exp_flag"));
	    
		
	//	creator_dept = getDBStr( rs.getString("creator_dept") );
		//djr=getDBStr( rs.getString("dengjiren") );
		//if ((djr==null) || (djr.equals("")))
		//{
		//	djr="无记录";
		//}
		
		
		//scale_name = getDBStr( rs.getString("scale_name") );
	    
	    create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
	    
	   	creator=getDBStr(rs.getString("dengjiren"));
	   	creator_dept=getDBStr(rs.getString("creator_dept"));
	   	info_flag=getDBStr(rs.getString("info_flag"));
	   	create_date=getDBStr(rs.getString("create_date"));
	   	modify_date=getDBStr(rs.getString("modify_date"));
	}
	rs.close(); 
	String sql="select dept_name from dbo.base_department where id='"+creator_dept+"'";
	ResultSet rs1 = db.executeQuery(sql);
	String dept_name="";
	if(rs1.next()){
	dept_name=getDBStr(rs1.getString("dept_name"));
	}
	System.out.println(dept_name+"12");
	rs1.close(); 
	db.close();
%>
<body onLoad="public_onload();fun_winMax();" class="linetype">
<form name="form1" method="post" action="frkh_save.jsp" onSubmit="return checkdata(this);">
<div id=bgDiv>


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
个人客户信息管理 &gt; 删除自然人客户信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=98%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="删除"  type="submit" >
<img src="../../images/btn_delete.gif" align="absmiddle" border="0">删除</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/fdmo_37.gif" align="absmiddle" border="0">关闭</button>

	    	</td>
	  </tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">删除</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
   <script language="javascript">
ShowTabN(0);
</script>
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>
<!--
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
-->
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">


<input type="hidden" name="savetype" value="del">
<input type="hidden" name="custId" value="<%= custId %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	  <tr>
	    
	    <td width="18%">客户编号：</td>
	    <td width="18%"><%=cust_id %></td>
	    <td width="18%">公司名称：</td>
	    <td width="18%"><%=cust_name %></td>
	    <td width="18%">英文名称：</td>
	    <td width="18%"><%=cust_ename %></td>
	  </tr>
	  
	   <tr>
	    <td>客户简称：</td>
	    <td><%=cust_byname %></td>
		<td>客户类别大类：</td>
	    <td><%=lbdlmc %></td>
	    <td>客户类别小类：</td>
	    <td><%=lbxlmc %></td>
	  </tr>
	  
	   <tr>
		<td>内部行业：</td>
	    <td><%=industry_type %></td>
	    <td>客户所属行业门类：</td>
	    <td><%=hymlmc %></td>
		<td>客户所属行业大类：</td>
	    <td><%=hydlmc %></td>
	  </tr>
	  
	   <tr>
	    <td>户所属行业中类：</td>
	    <td><%=hyzlmc %></td>
		<td>客户所属行业小类：</td>
	    <td><%=hyxlmc%></td>
	     <td>国家：</td>
	    <td><%=gjmc %></td>
	  </tr>
	  
	   <tr>
		<td>区域：</td>
	    <td><%=qymc %></td>
	    <td>省份：</td>
	    <td><%=sfmc %></td>
		<td>城市：</td>
	    <td><%=csmc %></td>
	  </tr>
	  
	   <tr>
	   
		<td>法人代表：</td>
	    <td><%=legal_representative %></td>
	    <td>法人代表身份证号：</td>
	    <td><%=id_card_no %></td>
		<td>注册地址：</td>
	    <td><%=reg_addr %></td>
	  </tr>
	  
	   <tr>
	    <td>公司地址：</td>
	    <td><%=office_addr %></td>
	     <td>邮编：</td>
	    <td><%=post_code %></td>
		<td>准确邮编地址：</td>
	    <td><%=mail_addr %></td>
	  </tr>
	  
	   <tr>
		<td>联系人：</td>
	    <td><%=linkman %></td>
	    <td>电话：</td>
	    <td><%=phone %></td>
		<td>手机：</td>
	    <td><%=mobile_number %></td>
	  </tr>
	  
	   <tr>
	    <td>传真：</td>
	    <td><%=fax_number %></td>
		<td>电挂：</td>
	    <td><%=cable_addr %></td>
	      <td>网站：</td>
	    <td><%=web_site %></td>
	  </tr>
	  
	   <tr>
		<td>企业性质：</td>
	    <td><%=ownership %></td>
	    <td>企业规模定级：</td>
	    <td><%=scale %></td>
		<td>组织机构代码：</td>
	    <td><%=org_code %></td>
	  </tr>
	  
	   <tr>
	    <td>贷款证号码：</td>
	    <td><%=loan_number %></td>
  <td>贷款证密码：</td>
	    <td><%=loan_number_pwd%></td>
 <td>信息状态：</td>
<td><%=info_flag%></td>
</tr>
<tr>
		<td>经营范围(主营)：</td>
	    <td><%=biz_scope_primary %></td>
	     <td>经营范围(兼营)：</td>
	    <td><%=biz_scope_secondary %></td>
	<td>进出口权标志：</td>
	    <td><%=imp_exp_flag %></td>
	  </tr>
	  
	   <tr>
		<td>营业执照号：</td>
	    <td><%=license_number %></td>
	    <td>营业执照到期日期：</td>
	    <td><%=getDBDateStr(license_exp_date)%></td>
<td>上市公司标志：</td>
	    <td><%=listed_corp_flag %></td>
</tr>
<tr>
		<td>注册资金：</td>
	    <td><%=formatNumberInterest(reg_capital) %></td>
	  
	    <td>登记注册类型：</td>
	    <td><%=reg_type%></td>
		<td>成立日期：</td>
	    <td><%=getDBDateStr(estab_date) %></td>
	    
	
	  </tr>
	
	   <tr>
<td>国税登记号：</td>
	    <td><%=national_tax_number %></td>
	   	<td>地税登记号：</td>
	    <td><%=land_tax_number %></td>
	    
	
	  </tr>
	  
	    
	    <tr>
		<td>备注：</td>
		<td>
<textarea readonly class="text">
	   <%=memo %></textarea></td>
	   <td></td><td></td>
	   <td></td><td></td>
	   </tr>
</table>
</div>

</center>
<table width=96% align=center border="0" cellspacing="0" cellpadding="0">
<tr><td width="50%"></td>
<td width="50%" valign="middle" align="right">&nbsp;</td></tr>
</table>
</td>
</tr>
</table>  
</div>
<!--添加结束-->

<!--控制选择卡和内置iframe的高度适应窗口-->

</form>

<!-- end cwMain -->
</body>
</html>
