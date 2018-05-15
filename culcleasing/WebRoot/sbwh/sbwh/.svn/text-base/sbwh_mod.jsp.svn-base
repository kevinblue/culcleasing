<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("sbwh-sbwh-mod",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>设备修改- 设备维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
<form name="form1" method="post" action="sbwh_save.jsp" onSubmit="">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
 设备维护 &gt; 设备修改
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
<BUTTON class="btn_2" name="btnReset" value="取消" onClick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>

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
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<%
    String id = getStr( request.getParameter("id") );
	String sqlstr = "select model_id,equip_type,model_name from equip_model where model_id='"+id+"'"; 
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String equip_type="";
	String model_name="";
	
	if ( rs.next() ) {
		equip_type=getDBStr( rs.getString("equip_type") );
		model_name=getDBStr( rs.getString("model_name") );
	}
	rs.close(); 
	/*String equip_id="";
	String equip_name="";
	sqlstr="select name,title from ifelc_conf_dictionary where parentid='mequip_type'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		equip_id+=getDBStr(rs.getString("name"))+"|";
		equip_name+=getDBStr(rs.getString("title"))+"|";
	}rs.close();
	if(insurer_value.length()>0){
		equip_id=insurer_value.substring(0,insurer_value.length()-1);
		equip_name=insurer_str.substring(0,insurer_str.length()-1);
	}
*/
	db.close();
%>
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%=id %>">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
              
              <tr>
                <th >设备名称：</th>
                <td><select name="equip_type" width="80px" Require="true">
    	<script language="javascript">
			dict_list("equip_type","mequip_type","<%=equip_type%>","name");
		</script>	
    </select><span class="biTian">*</span></td>

              <th >设备型号：</th>
                <td><input name="model_name" type="text" size="10" value="<%=model_name%>"></td>
              </tr>
            </table>
</div>
</div>

    </form>
</body>
</html>
