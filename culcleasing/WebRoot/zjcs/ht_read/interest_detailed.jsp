<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������Ϣ &gt;ʵ����Ϣ��ϸ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>
<%
	String oneId = getStr( request.getParameter("id") );
	String sqlstr = "select id,measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent_adjust,eptd_rent,rent,corpus,straight_interest,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,fin_interest,creator,create_date,modificator,modify_date from fund_rent_plan where id ='" + oneId + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr);
	/* �����ֶ�(25) */ 
	String	id = "";//int
	String	measure_id = "";//varchar
	String	measure_date = "";//datetime
	String	contract_id = "";//varchar
	String	rent_list = "";//int
	String	plan_status = "";//varchar
	String	plan_date = "";//datetime
	String	rent_adjust = "";//money
	String	eptd_rent = "";//money
	String	rent = "";//money
	String	corpus = "";//money
	String	straight_interest = "";//money
	String	year_rate = "";//decimal(18, 6)
	String	interest = "";//money
	String	rent_overage = "";//money
	String	corpus_overage = "";//money
	String	interest_overage = "";//money
	String	penalty_overage = "";//money
	String	penalty = "";//money
	String	rent_type = "";//varchar
	String	fin_interest = "";//money
	String	creator = "";//varchar
	String	create_date = "";//datetime
	String	modificator = "";//varchar
	String	modify_date = "";//datetime

	if ( rs.next() ) {
		id = getDBStr( rs.getString("id") );
		measure_id = getDBStr( rs.getString("measure_id") );
		measure_date = getDBDateStr( rs.getString("measure_date") );//����
		contract_id = getDBStr( rs.getString("contract_id") );
		rent_list = getDBStr( rs.getString("rent_list") );
		plan_status = getDBStr( rs.getString("plan_status") );
		plan_date = getDBDateStr( rs.getString("plan_date") );//����
		rent_adjust = formatNumberStr(getDBStr( rs.getString("rent_adjust") ),"#,##0.00");//
		eptd_rent = formatNumberStr(getDBStr( rs.getString("eptd_rent") ),"#,##0.00");//
		rent = formatNumberStr(getDBStr( rs.getString("rent") ),"#,##0.00");//
		corpus = formatNumberStr(getDBStr( rs.getString("corpus") ),"#,##0.00");//
		straight_interest = formatNumberStr(getDBStr( rs.getString("straight_interest") ),"#,##0.00");//
		
		year_rate = getDBStr( rs.getString("year_rate") );//������ ��ʱδ���κδ���
		
		interest = formatNumberStr(getDBStr( rs.getString("interest") ),"#,##0.00");//
		rent_overage = formatNumberStr(getDBStr( rs.getString("rent_overage") ),"#,##0.00");//
		corpus_overage = formatNumberStr(getDBStr( rs.getString("corpus_overage") ),"#,##0.00");//
		interest_overage = formatNumberStr(getDBStr( rs.getString("interest_overage") ),"#,##0.00");//
		penalty_overage = formatNumberStr(getDBStr( rs.getString("penalty_overage") ),"#,##0.00");//
		penalty = formatNumberStr(getDBStr( rs.getString("penalty") ),"#,##0.00");//
		rent_type = getDBStr( rs.getString("rent_type") );
		fin_interest = formatNumberStr(getDBStr( rs.getString("fin_interest") ),"#,##0.00");//
		creator = getDBStr( rs.getString("creator") );
		create_date = getDBDateStr( rs.getString("create_date") );//����
		modificator = getDBStr( rs.getString("modificator") );
		modify_date = getDBDateStr( rs.getString("modify_date") );//����
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="csa_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
������Ϣ &gt;ʵ����Ϣ��ϸ��Ϣ
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
<!--
		<a href="csa_mod.jsp?id=<%= id %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a>
-->
	  	<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
		<img src="../../images/hg.gif" align="absmiddle" border="0">ȡ��</button></td>
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
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ϸ</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<center>

<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<table border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	<tr>
	    <td>id</td>
	    <td><%=id%></td>
	</tr>
	<tr>
	    <td>docid</td>
	    <td><%=measure_id%></td>
	</tr>
	<tr>
	    <td>docdate</td>
	    <td><%=measure_date%></td>
	</tr>
	<tr>
	    <td>��ͬ���</td>
	    <td><%=contract_id%></td>
	</tr>
	<tr>
	    <td>����</td>
	    <td><%=rent_list%></td>
	</tr>
	<tr>
	    <td>�ƻ�״̬</td>
	    <td><%=plan_status%></td>
	</tr>
	<tr>
	    <td>�и�����</td>
	    <td><%=plan_date%></td>
	</tr>
	<tr>
	    <td>������</td>
	    <td><%=rent_adjust%></td>
	</tr>
	<tr>
	    <td>Ԥ�����</td>
	    <td><%=eptd_rent%></td>
	</tr>
	<tr>
	    <td>���</td>
	    <td><%=rent%></td>
	</tr>
	<tr>
	    <td>����</td>
	    <td><%=corpus%></td>
	</tr>
	<tr>
	    <td>ֱ�߷���Ϣ</td>
	    <td><%=straight_interest%></td>
	</tr>
	<tr>
	    <td>������</td>
	    <td><%=year_rate%></td>
	</tr>
	<tr>
	    <td>��Ϣ</td>
	    <td><%=interest%></td>
	</tr>
	<tr>
	    <td>������</td>
	    <td><%=rent_overage%></td>
	</tr>
	<tr>
	    <td>�������</td>
	    <td><%=corpus_overage%></td>
	</tr>
	<tr>
	    <td>��Ϣ���</td>
	    <td><%=interest_overage%></td>
	</tr>
	<tr>
	    <td>��Ϣ���</td>
	    <td><%=penalty_overage%></td>
	</tr>
	<tr>
	    <td>��Ϣ</td>
	    <td><%=penalty%></td>
	</tr>
	<tr>
	    <td>�������</td>
	    <td><%=rent_type%></td>
	</tr>
	<tr>
	    <td>ȷ������</td>
	    <td><%=fin_interest%></td>
	</tr>
	<tr>
	    <td>�Ǽ���</td>
	    <td><%=creator%></td>
	</tr>
	<tr>
	    <td>�Ǽ�����</td>
	    <td><%=create_date%></td>
	</tr>
	<tr>
	    <td>������</td>
	    <td><%=modificator%></td>
	</tr>
	<tr>
	    <td>��������</td>
	    <td><%=modify_date%></td>
	</tr>
</table>
<br>

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

<!--����ѡ�񿨺�����iframe�ĸ߶���Ӧ����-->
<script language="javascript">
ShowTabN(0);
ShowTabSub(0);
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
</script>
</form>
<!-- end cwMain -->
</body>
</html>
