<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ�豸ά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
</head>

<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("zjwjgl-htsb-view",dqczy)>0) canedit=1;
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
	String sqlstr = "select contract_equip.*,vi_cust_all_info.cust_name as manufacturer_name,vi_cust_all_info2.cust_name as distributor_name, ifelc_conf_dictionary.title as equip_status_name from contract_equip left join vi_cust_all_info on contract_equip.manufacturer=vi_cust_all_info.cust_id left join vi_cust_all_info vi_cust_all_info2 on contract_equip.distributor=vi_cust_all_info2.cust_id left join ifelc_conf_dictionary on contract_equip.equip_status=ifelc_conf_dictionary.name where contract_equip.id='" + czid + "'"; 
	//System.out.println("sqlstr======================"+sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 

	String	contract_id = "";
	String	eqip_name = "";
	String	brand = "";
	String	model = "";
	String	equip_sn = "";
	String	equip_price = "";
	String	equip_num = "";
	String	total_price = "";
	String	manufacturer = "";
	String	manufacturer_name = "";
	String	distributor = "";
	String	distributor_name = "";
	String	equip_delivery_place = "";
	String	equip_status = "";
	String	equip_status_name = "";
	String	status_date = "";
	
	String	equip_place = "";
	String	equip_delivery_date = "";
	String	shelf_life = "";
	String  tax_flag="";


	if ( rs.next() ) {
		contract_id = getDBStr( rs.getString("contract_id") );
		eqip_name = getDBStr( rs.getString("eqip_name") );
		brand = getDBStr( rs.getString("brand") );
		model = getDBStr( rs.getString("model") );
		equip_sn = getDBStr( rs.getString("equip_sn") );
		equip_price = getDBStr( rs.getString("equip_price") );
		equip_num = getDBStr( rs.getString("equip_num") );
		total_price = getDBStr( rs.getString("total_price") );
		manufacturer = getDBStr( rs.getString("manufacturer") );
		manufacturer_name = getDBStr( rs.getString("manufacturer_name") );
		distributor = getDBStr( rs.getString("distributor") );
		distributor_name = getDBStr( rs.getString("distributor_name") );
		equip_delivery_place = getDBStr( rs.getString("equip_delivery_place") );
		equip_status = getDBStr( rs.getString("equip_status") );
		equip_status_name = getDBStr( rs.getString("equip_status_name") );
		contract_id = getDBStr( rs.getString("contract_id") );
		status_date = getDBDateStr( rs.getString("status_date") );
		
		equip_place = getDBStr( rs.getString("equip_place") );
		equip_delivery_date = getDBDateStr( rs.getString("equip_delivery_date") );
		shelf_life = getDBDateStr( rs.getString("shelf_life") );
		tax_flag = getDBStr( rs.getString("tax_flag") );
	}
	rs.close(); 
	db.close();
%>
<body onload="fun_winMax();">

<form name="form1" method="post" action="htsb_save.jsp" onSubmit="return checkdata(this);">	
<div id=bgDiv>
	


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ�豸ά����ϸ
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
		<%if (right.CheckRight("zjwjgl-htsb-mod",dqczy)>0){ %>
		<a href="htsb_mod.jsp?czid=<%= czid %>"  accesskey="m" title="�޸�(Alt+M)" class="fontcolor">
		<img src="../../images/sbtn_mod.gif" width="19" height="19" align="absmiddle" >�޸�</a>
		<%} %>
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
    <td scope="row" nowrap width="20%">��ͬ��ţ�</td>
    <td><%=contract_id %></td>

    <td scope="row" nowrap width="20%">����������ƣ�</td>
    <td><%=eqip_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">Ʒ�ƣ�</td>
    <td><%=brand %></td>

    <td scope="row" nowrap width="20%">�ͺ�/���</td>
    <td><%=model %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�豸���кţ�</td>
    <td><%=equip_sn %></td>

    <td scope="row" nowrap width="20%">���ۣ�</td>
    <td><%=equip_price %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">������</td>
    <td><%=equip_num %></td>

    <td scope="row" nowrap width="20%">�ܼۣ�</td>
    <td><%=total_price %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�������̣�</td>
    <td><%=manufacturer_name %></td>

    <td scope="row" nowrap width="20%">������λ��</td>
    <td><%=distributor_name %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">��������أ�</td>
    <td><%=equip_delivery_place %></td>
	<td scope="row" nowrap width="20%">�豸���õأ�</td>
    <td><%=equip_place %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">����ʱ�䣺</td>
    <td><%=equip_delivery_date %></td>
	<td scope="row" nowrap width="20%">������֤�ڣ�</td>
    <td><%=shelf_life %></td>
  </tr>
  <tr>
  	<td scope="row" nowrap width="20%">���״̬��</td>
    <td><%=equip_status_name %></td>
    <td scope="row" nowrap width="20%">״̬���ڣ�</td>
    <td><%=status_date %></td>
  </tr>
  <tr>
    <td scope="row" nowrap width="20%">�Ƿ���˰��</td>
    <td colspan="3"><%=tax_flag %></td>
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
