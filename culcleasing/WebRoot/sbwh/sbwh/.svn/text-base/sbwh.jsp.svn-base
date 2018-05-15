<em>
<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
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
if (right.CheckRight("sbwh-sbwh-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>设备明细- 设备维护</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String id=request.getParameter("id");
	String sqlstr = "select model_id,dbo.FK_GETNAME(equip_type) as equip_type,model_name from equip_model where model_id='"+id+"'"; 
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	String equip_type="";
	String model_name="";
	
	if ( rs.next() ) {
		equip_type=getDBStr( rs.getString("equip_type") );
		model_name=getDBStr( rs.getString("model_name") );
	}
	rs.close(); 
	db.close();
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<form name="form1" method="post" action="sbwh_save.jsp" onSubmit="return checkdata(this);">
  <div id=bgDiv>
    <table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
      <tr valign="top" class="tree_title_txt">
        <td class="tree_title_txt"  height=26 valign="middle"> 设备明细 </td>
      </tr>
      <tr valign="top">
        <td  align=center width=100% height=100%><table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
            <tr>
              <td><!--操作按钮开始-->
                <table border="0" cellspacing="0" cellpadding="0" height="30">
                  <tr>
                    <td><a href="sbwh_mod.jsp?id=<%= id %>"  accesskey="m" title="修改(Alt+M)" class="fontcolor"> <img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >修改</a></td>
                    <td><a href="#" onClick="window.close();;opener.location.reload();"  accesskey="m" title="关闭" class="fontcolor"> <img src="../../images/sbtn_close.gif" width="19" height="19" align="absmiddle" >关闭</a></td>
                  </tr>
                </table>
                <!--操作按钮结束--></td>
            </tr>
            <tr>
              <td height="1" bgcolor="#DFDFDF"></td>
            </tr>
            <tr>
              <td height="5"></td>
            </tr>
            <tr>
              <td width="100%"><table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">明 细</td>
                    <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
                    <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
                  </tr>
                </table></td>
            </tr>
            <tr>
              <td class="tab_subline" width="100%" height="2"></td>
            </tr>
          </table>
          <center>
          <div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
          <div id="TD_tab_0">
            <table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
              <tr>
                <td >设备名称：</td>
                <td><%= equip_type %></td>
               <td >设备型号：</td>
                <td><%=model_name%></td>
              </tr>
            </table></div></div></center></td></tr></table></div></form>
</body>
</html>
</em>