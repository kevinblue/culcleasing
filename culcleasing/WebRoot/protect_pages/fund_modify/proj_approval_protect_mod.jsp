<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目信息维护-修改</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<script src="../../js/calend.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>


</head>

<%
    String useid=(String) session.getAttribute("czyid");
	String id = getStr( request.getParameter("id") );
	String sqlstr="select id,proj_id,project_name,is_exec,proj_pg_date,creator,create_date,wh_modificator,wh_modify_date from proj_Info where id='" + id+"'";
	System.out.println("aaaaaaaaaaaaaa"+sqlstr);
	String proj_id;
	String project_name;
	String is_exec;
	String proj_pg_date;
	String creator;
	String create_date;
	String wh_modificator="";  
	String wh_modify_date=getSystemDate(1);
	
	if(wh_modify_date.indexOf("\'")==0){
	wh_modify_date = wh_modify_date.substring(1,wh_modify_date.length()); 
	}
	if(wh_modify_date.lastIndexOf("\'")==(wh_modify_date.length()-1)){
	wh_modify_date = wh_modify_date.substring(0,wh_modify_date.length()-1); 
	}
	
	String sqluser="select name from base_user where id='" + useid+"'";
	ResultSet rsid = db.executeQuery(sqluser);
	if(rsid.next()){
		wh_modificator=getDBStr(rsid.getString("name"));
	}
	rsid.close();
	ResultSet rs = db.executeQuery(sqlstr);
	if( rs.next() ){
		proj_id=getDBStr(rs.getString("proj_id"));
		project_name=getDBStr(rs.getString("project_name"));
		
	   
	    
		
%>
<body  onload="public_onload();fun_winMax();" >
<form name="form1" method="post" action="proj_approval_protect_save.jsp" onSubmit="return Validator.Validate(this,3);">
<table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
项目信息维护 &gt; 修改项目信息
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">修 改</td>
  
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
<!-- end cwCellTop -->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="id" value="<%=id%>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">

  <tr>
    <td nowrap>项目编号</td>
    <td nowrap><input class="text" name="proj_id" type="text" maxlength="3" readOnly size="3" maxB="40" value="<%=proj_id%>"></td>
  
    <td nowrap>项目名称</td>
    <td nowrap><input class="text" name="project_name" type="text" size="3" style="width:350px;" maxlength="40" maxB="100" value="<%=project_name%>"></td>
  </tr>

  <tr>
		  
 <td nowrap>是否执行</td>
    <td nowrap> 

				<select style="width:160px;" id="is_exec" name="is_exec" >  
        <option value="1A" >执行</option>  
        <option value="2A" >不执行</option>  
        <option value="3A" >不确定</option></select>
			 


</td>
  <td nowrap>项目日期</td>
    <td nowrap><input class="text" name="proj_pg_date" type="text"  maxlength="40"  readOnly maxB="40" value="<%=getDBDateStr(rs.getString("proj_pg_date"))%>" ></td>
  </tr>
  <tr>
    <td nowrap>创建人</td>
    <td nowrap><input class="text" name="creator" type="text"  maxlength="50" readOnly maxB="50" value="<%=getDBStr(rs.getString("creator"))%>"></td>
  
    <td nowrap>创建时间</td>
    <td nowrap><input class="text" name="create_date" type="text"  maxlength="40"  readOnly maxB="40" value="<%=getDBDateStr(rs.getString("create_date"))%>" ></td>
  </tr>
  <tr>
	<td nowrap>维护人</td>
    <td nowrap><input class="text" name="wh_modificator" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modificator%>"></td>
	<td nowrap>维护时间</td>
    <td nowrap><input class="text" name="wh_modify_date" type="text" size="3"  maxlength="3" maxB="40" readOnly value="<%=wh_modify_date%>"></td>    
  </tr>
  
 <tr>

  
</table>
	<%
	}
rs.close();
db.close();
db1.close();
%>

<!-- end cwDataNav -->
</div>
<!-- end cwCellContent -->
</div>
<!-- end cwToolbar -->
</td></tr></table>
</form>

<!-- end cwMain -->
</body>
</html>
