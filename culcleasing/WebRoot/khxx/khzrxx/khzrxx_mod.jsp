<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%

String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("khxx_khzrxx_mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ͻ���Ƭ��Ϣ - �ͻ���Ϣ����(����)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>

<%
String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select *,dengjiren=dbo.GETUSERNAME(creator),xiugairen=dbo.GETUSERNAME(modificator) from vi_cust_ewlp_info where cust_id='" + czid + "'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	
	String	cust_name = "";//�ͻ����� *
	String	cust_ename = "";//�ͻ�Ӣ����
	String	sex = "";//�ͻ��Ա�
	String	birthday = "";//��������
	String	is_marriage = "";//����״��
	String	certificate = "";//֤������
	String	certificate_no = "";//֤������ *
	String	education = "";//ѧ��
	String	reg_per_addr = "";//�������ڵ�
	String	work_addr = "";//��λ��ַ
	String	headship = "";//��λְ��
	String	off_phone = "";//�칫�ҵ绰
	String	home_phone = "";//סլ�绰 *
	String	mobile_number = "";//��  �� *
	String  home_addr="";
	String	mail_addr = "";
	String	post_code = "";
	String	eme_contacts = "";
	String	reg_number = "";
	String	license_exp_date = "";
	String  annual_due_date = "";
	String	hydldata = "";
	String	hyxldata = "";
	String	lbdldata = "";
	String	fax_number = "";
	String	e_mail = "";
	String  web_site = "";
	String	gjdata = "";
	String	sfdata = "";
	String	csdata = "";
	String	qxdata = "";
	String	memo = "";
	String creator = "";
	String create_date = "";
	String modificator = "";
	String modify_date = "";
	String	creator_dept = "";
	String biz_scope="";
	
	String category_level1="";
	String industry_level1 = "";
	String industry_level2 = "";
	String country="";
	String province="";
	String city="";
	String unit_name="";
	if ( rs.next() ) {
		unit_name = getDBStr( rs.getString("unit_name") );
		cust_name = getDBStr( rs.getString("cust_name") );
		cust_ename = getDBStr( rs.getString("cust_ename") );
		sex = getDBStr( rs.getString("sex") );
		reg_number = getDBStr( rs.getString("reg_number") );
		is_marriage = getDBStr( rs.getString("is_marriage") );
		birthday = getDBDateStr( rs.getString("birthday") );
		license_exp_date = getDBDateStr( rs.getString("license_exp_date") );
		annual_due_date = getDBDateStr( rs.getString("annual_due_date") );
		mobile_number = getDBStr( rs.getString("mobile_number") );
		fax_number = getDBStr( rs.getString("fax_number") );
		e_mail = getDBStr( rs.getString("e_mail") );
		web_site = getDBStr( rs.getString("web_site") );
		home_addr = getDBStr( rs.getString("home_addr") );
		post_code = getDBStr( rs.getString("post_code") );
		biz_scope = getDBStr( rs.getString("biz_scope") );
		memo = getDBStr( rs.getString("memo") );
		
		//��ҵ
		hydldata = getDBStr( rs.getString("hydlmc") );
		hyxldata = getDBStr( rs.getString("hyxlmc") );
		lbdldata = getDBStr( rs.getString("lbdlmc") );
		//���ҡ�ʡ�ݡ�����
		gjdata = getDBStr( rs.getString("gjmc") );
		sfdata = getDBStr( rs.getString("sfmc") );
		csdata = getDBStr( rs.getString("csmc") );
		qxdata = getDBStr( rs.getString("county") );

		creator = getDBStr( rs.getString("dengjiren") );
		create_date = getDBDateStr( rs.getString("create_date") );
		modificator = getDBStr( rs.getString("xiugairen") );
		modify_date = getDBDateStr( rs.getString("modify_date") );
		creator_dept = getDBStr( rs.getString("creator_dept") );
		
		education=getDBStr( rs.getString("education") );
		reg_per_addr=getDBStr( rs.getString("reg_per_addr") );
		work_addr=getDBStr( rs.getString("work_addr") );
		headship=getDBStr( rs.getString("headship") );
		off_phone=getDBStr( rs.getString("off_phone") );
		home_phone=getDBStr( rs.getString("home_phone") );
		mail_addr=getDBStr( rs.getString("mail_addr") );
		eme_contacts=getDBStr( rs.getString("eme_contacts") );
		certificate_no=getDBStr( rs.getString("certificate_no") );
		certificate=getDBStr( rs.getString("certificate") );
		
	 category_level1=getDBStr( rs.getString("cust_type") );
	 industry_level1 =getDBStr( rs.getString("industry_level1") );
	 industry_level2 = getDBStr( rs.getString("industry_level2") );
	 country=getDBStr( rs.getString("country") );
	 province=getDBStr( rs.getString("province") );
	 city=getDBStr( rs.getString("city") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="khzrxx_save.jsp" onSubmit="return Validator.Validate(this,3);">
<style type="text/css">
body {overflow:hidden;}
</style>
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
���˿ͻ���Ϣ���� &gt; �޸Ŀͻ���Ƭ��Ϣ
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="�ύ"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">�ύ��Ч</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td>�ͻ�����</td>
    <td><input name="cust_name" readonly  value="<%=cust_name%>" type="text" size="40" maxB="100"  Require="true" >
	<span class="biTian">*</span></td>

    <td>Ӣ������</td>
    <td><input name="cust_ename" value="<%=cust_ename%>" type="text" size="40" maxB="100" dataType="English"></td>
  </tr>
  <tr>
    <td>֤�����ͣ�</td>
    <td><select name="certificate" ><script>w(mSetOpt('<%=certificate%>',"|���֤|����"));</script></select></td>
    <td>֤�����룺</td>
    <td><input name="certificate_no" readonly  value="<%=certificate_no%>" type="text" size="20" maxB="40" dataType="IdCard"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>�������£�</td>
    <td><input name="birthday" value="<%=birthday%>" type="text" size="15" readonly maxB="10" Require="true" dataType="Date"> <img  onClick="openCalendar(birthday);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>

    <td>����״����</td>
    <td><select name="is_marriage" ><script>w(mSetOpt('<%=is_marriage%>',"|�ѻ�|δ��|����|ɥż"));</script></select></td>
  </tr>
  <tr>
    <td>�Ա�</td>
    <td><select name="sex" ><script>w(mSetOpt('<%=sex%>',"|��|Ů"));</script></select></td>
    <td>ѧ����</td>
    <td><select name="education" ><script>w(mSetOpt('<%=education%>',"|��������|����|��ʿ|˶ʿ"));</script></select></td>
  </tr>
  <tr>
  <td>�������ڵأ�</td>
    <td><input name="reg_per_addr" value="<%=reg_per_addr%>" type="text" size="40" maxB="400" Require="true"><span class="biTian">*</span>
      <span class="biTian">*</span></td>
    <td>סլ�绰��</td>
    <td><input name="home_phone"  type="text" size="20" maxB="40" dataType="Phone" value="<%=home_phone%>" ></td>
  </tr>
  <tr>
  <td>��λ����:</td><td><input name="unit_name" type="text" size="20" maxB="100" value="<%=unit_name%>" ></td>
  
  <td>��λְ��</td>
    <td><input name="headship" type="text" size="20" maxB="100" value="<%=headship%>" ></td>  
  </tr>
   <tr><td >��λ��ַ��</td>
    <td><input name="work_addr"  type="text" size="40" maxB="400" value="<%=work_addr%>" ></td>
    <td>�칫�ҵ绰��</td><td><input name="off_phone" type="text" size="20" maxb="40" dataType="Phone" value="<%=off_phone%>" ></td></tr>
  <tr>
  <td height="19">Ӫҵִ�պţ�</td>
    <td><input name="reg_number"  type="text" size="20" maxb="40" value="<%=reg_number%>" ></td>
  <td >Ӫҵִ�յ�������:</td>
    <td><input name="license_exp_date" value="<%=license_exp_date%>" type="text" size="15" readonly maxb="10" dataType="Date">
      <img  onClick="openCalendar(license_exp_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
 <tr>
    <td>������쵽����:</td>
    <td><input name="annual_due_date"  value="<%=annual_due_date%>" type="text" size="15" readonly maxb="10" dataType="Date">
      <img onClick="openCalendar(annual_due_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
    <td>������ϵ�ˣ�</td>
    <td><input name="eme_contacts" value="<%=eme_contacts%>" type="text" size="20" maxb="40"></td>
  </tr>
  <tr>
    <td>�ͻ����:</td>
    <td><input type="text" value="<%=lbdldata%>" name="lbdldata" readonly Require="ture"><input type="hidden" value="<%=category_level1%>" name="category_level1" onPropertychange="form1.industry_level1.value='';form1.industry_level2.value='';form1.hyxldata.value='';form1.hydldata.value='';"> <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','�ͻ����','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	<span class="biTian">*</span></td>
    <td>�ֻ�:</td>
    <td><input type="text" name="mobile_number" value="<%=mobile_number%>"  Require="ture" datetype="MobileEXT"><span class="biTian">*</span></td>
  </tr>
     <tr>
   		<td>�ͻ�������ҵ����:</td>
    	<td><input name="hydldata" type="text" size="20" value="<%=hydldata%>" readonly><input type="hidden"  value="<%=industry_level1%>" name="industry_level1" onPropertychange=""> <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','�ͻ����','kh_lbdl','lbdlmc','id','lbdlmc','lbdlmc','asc','form1.lbdldata','form1.category_level1');">
	  	</td>
   		<td>�ͻ�������ҵС��:</td>
    	<td><input name="hyxldata" value="<%=hyxldata%>" type="text" size="20" readonly>
    	<input name="industry_level2" type="hidden"  value="<%=industry_level2%>"  onPropertychange=""><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer"
		onclick="OpenDataWindow('form1.industry_level1','�ͻ�������ҵ����','substring(hyxlbh,2,2)','string','��ҵ����','kh_hyxl_gb','hyxlmc','hyxlbh','hyxlmc','hyxlmc','asc','form1.hyxldata','form1.industry_level2');">
	  	</td>
 	</tr>
  <tr>
  <td >�ʼĵ�ַ��</td>
    <td><input name="mail_addr" value="<%=mail_addr%>"  type="text" size="40" maxB="400"  Require="ture">
      <span class="biTian">*</span></td>
    <td >�ʱࣺ</td>
    <td><input name="post_code" value="<%=post_code%>" type="text" size="20" maxb="40" dataType="Zip" Require="ture">
      <span class="biTian">*</span></td>
  </tr>
  <tr>
  <td >���棺</td>
    <td><input name="fax_number" value="<%=fax_number%>" type="text" size="40" maxB="40"></td>
    <td >E-mail��ַ��</td>
    <td><input name="e_mail" value="<%=e_mail%>" type="text" size="20" maxB="40"   dataType="Email"></td>
  </tr>
  <tr>
    <td >סլסַ��</td>
    <td><input name="home_addr" value="<%=home_addr%>"  type="text" size="40" maxB="400"></td>
    <td >��ַ��</td>
    <td><input name="web_site" value="<%=web_site%>" type="text" size="20" maxb="40" dataType="Url"></td>
  </tr>
  <tr>
    <td >����:</td>
    <td><input type="text" name="gjdata" value="<%=gjdata%>" readonly Require="ture">
      <input type="hidden" name="country" value="<%=country%>"   onpropertychange="form1.sfdata.value='';form1.province.value='';form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','����','jb_gjxx','gjmc','id','gjmc','gjmc','asc','form1.gjdata','form1.country');"> <span class="biTian">*</span></td>
    <td>ʡ��:</td>
    <td><input type="text" name="sfdata" value="<%=sfdata%>" readonly Require="ture">
      <input type="hidden" name="province" value="<%=province%>"  onpropertychange="form1.csdata.value='';form1.city.value='';">
      <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.country','����','','','ʡ��','jb_ssxx','sfmc','id','sfmc','sfmc','asc','form1.sfdata','form1.province');"> <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>����:</td>
    <td><input type="text" name="csdata" value="<%=csdata%>" readonly Require="ture">
      <input type="hidden" name="city" value="<%=city%>" >
      <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('form1.province','ʡ��','sfid','string','����','jb_csxx','csmc','id','csmc','csmc','asc','form1.csdata','form1.city');"> <span class="biTian">*</span></td>
	<td>��/��:</td>
    <td><input type="text" name="qxdata" value="<%= qxdata %>" require="ture" maxb="100">
      <span class="biTian">*</span></td>
    </tr>
  <tr>
    <td>��Ӫ��Χ:</td>
    <td><textarea name="biz_scope" cols="40" rows="4" maxB="1000"><%=biz_scope%></textarea></td>
  
    <td>��ע</td>
    <td><textarea name="memo" cols="40" rows="4" maxB="1000"><%=memo%></textarea></td> 
  </tr>

</table>
</div>

<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

</div>

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
<!--��ӽ���-->
</form>

<!-- end cwMain -->
</body>
</html>
