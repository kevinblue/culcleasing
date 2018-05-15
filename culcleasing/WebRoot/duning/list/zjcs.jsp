<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>逾期情况明细 - 租金催收</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
String dqczy=(String) session.getAttribute("czyid");
String enddate = getStr( request.getParameter("enddate") );
String cust_id = getStr( request.getParameter("cust_id") );
String contract_id=getStr( request.getParameter("contract_id"));
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="无认证";
 response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("duning-zjcs-mx",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<body onLoad="setDivHeight('divH',-55);fun_winMax();">
<div style="vertical-align:top;width:100%;height:100%;position: relative; left: 0px; top: 0px"  id="mydiv";>
  <table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
    <tr>
    <tr valign="top" class="tree_title_txt">
      <td class="tree_title_txt"  height=26 valign="middle"> 逾期情况明细 </td>
    </tr>
    <tr valign="top">
      <td  align=center width=100% height=100%><div style="vertical-align:top;overflow:auto;text-align:left;width:98%">
          <div id="TD_s_tab_0">
            <iframe style="funny:expression(autoResize())" id="UserBody0" frameborder="0" width="100%" height="500" src="zjcs_mx.jsp?cust_id=<%=cust_id%>&enddate=<%=enddate%>" align="center"></iframe>
          </div>
          <div id="TD_s_tab_1">
            <iframe style="funny:expression(autoResize())" id="UserBody1" frameborder="0" width="100%" src="../record/record_list.jsp?cust_id=<%=cust_id%>" align="center"></iframe>
          </div>
          <div id="TD_s_tab_2">
            <iframe style="funny:expression(autoResize())" id="UserBody2" frameborder="0" width="100%" src="../directives/directives_list.jsp?cust_id=<%=cust_id%>" align="center"></iframe>
          </div>
        </div>
        <div id="TD_tab_1" style="display:none;"> 选择卡中的内容2 </div>
        <div id="TD_tab_2" style="display:none;"> 选择卡中的内容3
          
          选择卡中可能包含以下内容：
          
          注意HTMLBody并不是选择卡中的内容，因此需要独立拿出来放在最后。 </div>
        <table width=96% align=center border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="50%"></td>
            <td width="50%" valign="middle" align="right">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<!--添加结束-->
<!--控制选择卡和内置iframe的高度适应窗口-->
<script language="javascript">
//ShowTabN(0);
//ShowTabSub(0);
reinitIframe();
//外部div高度自适应
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//内部Iframe高度自适应
function autoResize()
{
	try
	{
		document.all["UserBody0"].style.height=UserBody0.document.body.scrollHeight
		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
		document.all["UserBody2"].style.height=UserBody2.document.body.scrollHeight
	}
	catch(e)
	{}
}
</script>
<!-- end cwMain -->
</body>
</html>
