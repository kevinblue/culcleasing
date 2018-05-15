<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>客户信息管理-重要个人信息管理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>

<script type="text/javascript">
//选择收付款人账号信息
function choi_custProj(){
	//判断是否有选中开户
	var custId = $(":input[name='cust_id']").val();
	if(custId==""){
		alert( "请先选择"+$("#bj_1").text());
	}else{
		popUpWindow('proj_info.jsp?cust_id='+custId,250,350);
	}
}
</script>
</head>

<%
	String cust_id = getStr( request.getParameter("cust_id") );
	String sqlstr="select cust_name from vi_cust_all_info  where cust_id='"+cust_id+"'";
	ResultSet rs = db.executeQuery(sqlstr);
	String cust_name="";
	if( rs.next() ){
		cust_name=getDBStr(rs.getString("cust_name"));
	}
	rs.close();
	db.close();
%>
<body onLoad="public_onload();fun_winMax();">
<form name="form1" method="post" action="khzygr_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
客户信息管理 &gt; 新增客户重要个人信息
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td >
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">关闭</button>
    </td></tr>
</table>
<!--操作按钮结束-->

</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">新 增</td>
  
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
<!-- end cwTop -->
<!-- end cwCellTop -->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="add">
<input type="hidden" name="cust_id" value="<%=cust_id %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
 
    <td nowrap>姓名：</td>
    <td nowrap><input class="text" name="name" type="text"  maxlength="40" maxB="40"  Require="true"><span class="biTian">*</span></td>
    <td nowrap>是否接收短信：</td>
    <td nowrap>
    <select class="text" name="msg_recieved" Require="true">
    <script>w(mSetOpt('',"否|是"));</script>
    </select><span class="biTian">*</span>
    </td>
  </tr>
  <tr>
	<td nowrap>性别：</td>
	<td nowrap>
     	<input name="sex" type="radio" value="是" checked="checked">
													男
													<input name="sex" type="radio" value="否">
												女
													</td>
   
  
    <td nowrap>性格：</td>
    <td nowrap><input class="text" name="person_character" type="text"  maxlength="100" maxB="100"></td>
  </tr>
  <tr>
    <td nowrap>年龄：</td>
    <td nowrap><input class="text" name="age" type="text" size="3" maxlength="3" maxB="3" dataType="Number"></td>
  
    <td nowrap>任职年限：</td>
    <td nowrap><input class="text" name="service_life" type="text" size="3"  maxlength="3"  maxB="40" dataType="Number">年</td>
  </tr>
  
  <tr>
	  <td nowrap>是否主动联系人：</td>
   <td nowrap>
     	<input name="main_person_flag" type="radio" value="是" checked="checked">
													是
													<input name="main_person_flag" type="radio" value="否">
													否
													</td>
    <td nowrap>出生年月：</td>
    <td nowrap><input class="text" name="birth_date" type="text" size="10" maxlength="10" readonly dataType="Date"><img  onClick="openCalendar(birth_date);return false" style="cursor:pointer; " src="../../images/btn_time.gif" width="20" height="19" border="0" align="absmiddle"></td>
  </tr>
  <tr>
    <td nowrap>籍贯：</td>
    <td nowrap><input class="text" name="native_place" type="text"  maxlength="50" maxB="50"></td>
  
    <td nowrap>电话：</td>
    <td nowrap><input class="text" name="phone" type="text"  maxlength="40" maxB="40" dataType="Phone"></td>
  </tr>
  <tr>
  <td nowrap>手机：</td>
    <td nowrap><input class="text" name="mobile_number" type="text"  maxlength="40" maxB="40" dataType="Number"></td>
    <td nowrap>传真：</td>
    <td nowrap><input class="text" name="fax" type="text"  maxlength="40" maxB="40" dataType="Phone"></td>
   </tr>
  <tr>
    <td nowrap>毕业学校：</td>
    <td nowrap><input class="text" name="graduate_school" type="text"  maxlength="100" maxB="100"></td>
 
    <td nowrap>专业：</td>
    <td nowrap><input class="text" name="major" type="text"  maxlength="100" maxB="100"></td>
  </tr>
  <tr>
  	<td nowrap>学历：</td>
    <td nowrap><input class="text" name="education" type="text"  maxlength="50" maxB="50"></td>
    <td nowrap>E-mail</td>
    <td nowrap><input class="text" name="e_mail" type="text"  maxlength="40" maxB="40" dataType="Email" ></td>
  </tr>
  <tr>
    <td nowrap>爱好：</td>
    <td nowrap> <input class="text" name="hobbies" type="text"  maxlength="100" maxB="100"></td>
  
    <td nowrap>职位/关系：</td>
    <td nowrap><input class="text" name="jobposition" type="text"  maxlength="40" maxB="40"></td>
  </tr>
  <tr>
    <td nowrap>学科领域：</td>
    <td nowrap><input class="text" name="subject_field" type="text"  maxlength="100" maxB="100"></td>
  
    <td nowrap>学术职务：</td>
    <td nowrap><input class="text" name="academic_duty" type="text"  maxlength="40" maxB="40"></td>
  </tr>
  <tr>
    <td nowrap>社会职务：</td>
    <td nowrap><input class="text" name="social_duty" type="text"  maxlength="100" maxB="100"></td>
  <td >管理风格：</td>
	<td nowrap><select class="text" name="managial_style"><script>w(mSetOpt('',"集中|中等|民主"));</script></select></td>
    
  </tr>
  <tr>
  <td nowrap>配偶：</td>
    <td nowrap><input class="text" name="spouse" type="text"  maxlength="100" maxB="100"></td>
    <td nowrap>子女：</td>
    <td nowrap><input class="text" name="children" type="text" maxB="200"></input></td>
  </tr>
 
  <tr>
	<td>备注：</td>
	<td nowrap><textarea class="text" id="memo" name="memo" rows="5" value=""  maxB="300"></textarea></td>
	<td nowrap>管理项目</td>
    <td nowrap>
    <input style="width:160px;" name="res_project" type="text" readonly="readonly">
    <input name="project_name" type="hidden">

	<img src="../../images/sbtn_more.gif" alt="选" width="19" height="19" align="absmiddle"  
	style="cursor:pointer" onclick="choi_custProj();">
	
    </td>
   </tr>
</table>
</div></div></td></tr></table>
</form>
</body>
</html>
