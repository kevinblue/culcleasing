<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ���� - ���ž�Ӫָ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="depttarget_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
������Ϣ���� &gt; ���ž�Ӫָ��
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" height="30">
	  <tr>
	    <td>
	    	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button>

	    	</td>
	  </tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�޸���Ϣ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("depttarget-depttarget-mod",dqczy)>0) canedit=1;
%>
<script>
if (<%=canedit%>==0){
	window.close();
	opener.alert("��û�в���Ȩ�ޣ�");
}

</script>
<%
//--------����ΪȨ�޿���-----------------------------


	String czid = getStr( request.getParameter("czid") );
	String sqlstr = "select base_dept_target.*,jb_gsbm.bmmc from base_dept_target left join jb_gsbm on base_dept_target.dept_id=jb_gsbm.id where base_dept_target.id=" + czid ; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	target_year = "";
	String	dept_id = "";
	String	bmmc = "";
	String	target_1_asset = "";
	String	target_1_corpus = "";
	String	target_2_asset = "";
	String	target_2_corpus = "";
	String	target_3_asset = "";
	String	target_3_corpus = "";
	String	target_4_asset = "";
	String	target_4_corpus = "";
	String	target_5_asset = "";
	String	target_5_corpus = "";
	String	target_6_asset = "";
	String	target_6_corpus = "";
	String	target_7_asset = "";
	String	target_7_corpus = "";
	String	target_8_asset = "";
	String	target_8_corpus = "";
	String	target_9_asset = "";
	String	target_9_corpus = "";
	String	target_10_asset = "";
	String	target_10_corpus = "";
	String	target_11_asset = "";
	String	target_11_corpus = "";
	String	target_12_asset = "";
	String	target_12_corpus = "";


	if ( rs.next() ) {
		target_year = getDBStr( rs.getString("target_year") );
		dept_id = getDBStr( rs.getString("dept_id") );
		bmmc = getDBStr( rs.getString("bmmc") );
		target_1_asset = getDBDecStr(rs.getBigDecimal("target_1_asset",2)).toString();
		target_1_corpus = getDBDecStr(rs.getBigDecimal("target_1_corpus",2)).toString();
		target_2_asset = getDBDecStr(rs.getBigDecimal("target_2_asset",2)).toString();
		target_2_corpus = getDBDecStr(rs.getBigDecimal("target_2_corpus",2)).toString();
		target_3_asset = getDBDecStr(rs.getBigDecimal("target_3_asset",2)).toString();
		target_3_corpus = getDBDecStr(rs.getBigDecimal("target_3_corpus",2)).toString();
		target_4_asset = getDBDecStr(rs.getBigDecimal("target_4_asset",2)).toString();
		target_4_corpus = getDBDecStr(rs.getBigDecimal("target_4_corpus",2)).toString();
		target_5_asset = getDBDecStr(rs.getBigDecimal("target_5_asset",2)).toString();
		target_5_corpus = getDBDecStr(rs.getBigDecimal("target_5_corpus",2)).toString();
		target_6_asset = getDBDecStr(rs.getBigDecimal("target_6_asset",2)).toString();
		target_6_corpus = getDBDecStr(rs.getBigDecimal("target_6_corpus",2)).toString();
		target_7_asset = getDBDecStr(rs.getBigDecimal("target_7_asset",2)).toString();
		target_7_corpus = getDBDecStr(rs.getBigDecimal("target_7_corpus",2)).toString();
		target_8_asset = getDBDecStr(rs.getBigDecimal("target_8_asset",2)).toString();
		target_8_corpus = getDBDecStr(rs.getBigDecimal("target_8_corpus",2)).toString();
		target_9_asset = getDBDecStr(rs.getBigDecimal("target_9_asset",2)).toString();
		target_9_corpus = getDBDecStr(rs.getBigDecimal("target_9_corpus",2)).toString();
		target_10_asset = getDBDecStr(rs.getBigDecimal("target_10_asset",2)).toString();
		target_10_corpus = getDBDecStr(rs.getBigDecimal("target_10_corpus",2)).toString();
		target_11_asset = getDBDecStr(rs.getBigDecimal("target_11_asset",2)).toString();
		target_11_corpus = getDBDecStr(rs.getBigDecimal("target_11_corpus",2)).toString();
		target_12_asset = getDBDecStr(rs.getBigDecimal("target_12_asset",2)).toString();
		target_12_corpus = getDBDecStr(rs.getBigDecimal("target_12_corpus",2)).toString();
		
	}
	rs.close(); 
	db.close();




%>


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>ָ�����</td>
    <td><select name="target_year" require="true"><script>w(mSetOpt("<%=target_year%>",'2000|2001|2002|2003|2004|2005|2006|2007|2008|2009|2010|2011|2012|2013|2014|2015|2016|2017|2018|2019|2020|2021|2022|2023|2024|2025|2026|2027|2028|2029|2030'));</script></select>
	<span class="biTian">*</span></td>

    <td>����</td>
    <td><input name="bmmc" type="text" size="20" readonly value="<%=bmmc%>" require="true"><input type="hidden" name="dept_id" value="<%=dept_id%>"> <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','����ѡ��','jb_gsbm','bmmc','id','bmmc','bmmc','asc','form1.bmmc','form1.dept_id');">
	<span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>1�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_1_asset" type="text" size="20" dataType="Money" value="<%=target_1_asset%>"></td>
    <td>1�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_1_corpus" type="text" size="20" dataType="Money" value="<%=target_1_corpus%>"></td>
  </tr>
  <tr>
    <td>2�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_2_asset" type="text" size="20" dataType="Money" value="<%=target_2_asset%>"></td>
    <td>2�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_2_corpus" type="text" size="20" dataType="Money" value="<%=target_2_corpus%>"></td>
  </tr>
  <tr>
    <td>3�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_3_asset" type="text" size="20" dataType="Money" value="<%=target_3_asset%>"></td>
    <td>3�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_3_corpus" type="text" size="20" dataType="Money" value="<%=target_3_corpus%>"></td>
  </tr>
  <tr>
    <td>4�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_4_asset" type="text" size="20" dataType="Money" value="<%=target_4_asset%>"></td>
    <td>4�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_4_corpus" type="text" size="20" dataType="Money" value="<%=target_4_corpus%>"></td>
  </tr>
  <tr>
    <td>5�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_5_asset" type="text" size="20" dataType="Money" value="<%=target_5_asset%>"></td>
    <td>5�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_5_corpus" type="text" size="20" dataType="Money" value="<%=target_5_corpus%>"></td>
  </tr>
  <tr>
    <td>6�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_6_asset" type="text" size="20" dataType="Money" value="<%=target_6_asset%>"></td>
    <td>6�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_6_corpus" type="text" size="20" dataType="Money" value="<%=target_6_corpus%>"></td>
  </tr>
  <tr>
    <td>7�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_7_asset" type="text" size="20" dataType="Money" value="<%=target_7_asset%>"></td>
    <td>7�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_7_corpus" type="text" size="20" dataType="Money" value="<%=target_7_corpus%>"></td>
  </tr>
  <tr>
    <td>8�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_8_asset" type="text" size="20" dataType="Money" value="<%=target_8_asset%>"></td>
    <td>8�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_8_corpus" type="text" size="20" dataType="Money" value="<%=target_8_corpus%>"></td>
  </tr>
  <tr>
    <td>9�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_9_asset" type="text" size="20" dataType="Money" value="<%=target_9_asset%>"></td>
    <td>9�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_9_corpus" type="text" size="20" dataType="Money" value="<%=target_9_corpus%>"></td>
  </tr>
  <tr>
    <td>10�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_10_asset" type="text" size="20" dataType="Money" value="<%=target_10_asset%>"></td>
    <td>10�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_10_corpus" type="text" size="20" dataType="Money" value="<%=target_10_corpus%>"></td>
  </tr>
  <tr>
    <td>11�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_11_asset" type="text" size="20" dataType="Money" value="<%=target_11_asset%>"></td>
    <td>11�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_11_corpus" type="text" size="20" dataType="Money" value="<%=target_11_corpus%>"></td>
  </tr>
  <tr>
    <td>12�·ݼƻ�����豸���ָ��</td>
    <td><input name="target_12_asset" type="text" size="20" dataType="Money" value="<%=target_12_asset%>"></td>
    <td>12�·ݼƻ���ɱ���ָ��</td>
    <td><input name="target_12_corpus" type="text" size="20" dataType="Money" value="<%=target_12_corpus%>"></td>
  </tr>

</table>
	




</div>

</div>

<div id="TD_tab_1" style="display:none;"> 
  ѡ���е�����2
</div>
<div id="TD_tab_2" style="display:none;"> 
  ѡ���е�����3

ѡ���п��ܰ����������ݣ�

ע��HTMLBody������ѡ���е����ݣ������Ҫ�����ó����������

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

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">
ShowTabN(0);
reinitIframe();
//�ⲿdiv�߶�����Ӧ
function reinitIframe(){
var divH = document.getElementById("divH");
var reinitIframe_resize=function(){
divH.style.height=window.document.body.clientHeight-100;
}
reinitIframe_resize();
window.onresize=reinitIframe_resize;
}
//�ڲ�Iframe�߶�����Ӧ
//function autoResize()
//{
//	try
//	{
//		document.all["UserBody1"].style.height=UserBody1.document.body.scrollHeight
//	}
//	catch(e)
//	{}
//}
</script>
</form>








<!-- end cwMain -->
</body>
</html>
