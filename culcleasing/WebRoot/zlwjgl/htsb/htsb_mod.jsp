<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - ��ͬ�豸ά��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
</head>



<body onload="fun_winMax();">
<form name="form1" method="post" action="htsb_save.jsp" onSubmit="return Validator.Validate(this,3);">
<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ��Ϣ &gt; ��ͬ�豸ά��
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
if (right.CheckRight("zjwjgl-htsb-mod",dqczy)>0) canedit=1;
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


<input type="hidden" name="savetype" value="mod">
<input type="hidden" name="czid" value="<%= czid %>">
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <td>��ͬ���</td>
    <td><input name="contract_id" type="text" size="20"  Require="true" readonly value="<%= contract_id%>"></td>

    <td>�����������</td>
    <td><input name="eqip_name" type="text" size="20" maxB="300" Require="true" value="<%= eqip_name%>">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>Ʒ��</td>
    <td><input name="brand" type="text" size="20" maxB="100" value="<%= brand%>"></td>

    <td>�ͺ�/���</td>
    <td><input name="model" type="text" size="20" maxB="500" value="<%= model%>"></td>
  </tr>
  <tr>
    <td>�豸���к�</td>
    <td><input name="equip_sn" type="text" size="20" maxB="500" value="<%= equip_sn%>"></td>

    <td>����</td>
    <td><input name="equip_price" type="text" size="20" dataType="Money" Require="true" value="<%= equip_price%>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>����</td>
    <td><input name="equip_num" type="text" size="20" dataType="Integer" Require="true" value="<%= equip_num%>"><span class="biTian">*</span></td>

    <td>�ܼ�</td>
    <td><input name="total_price" type="text" size="20" dataType="Money" Require="true" value="<%= total_price%>"><span class="biTian">*</span></td>
  </tr>
  <tr>
    <td>��������</td>
    <td><input name="manufacturer_name" type="text" size="40" readonly value="<%= manufacturer_name%>"><input type="hidden" name="manufacturer" value="<%= manufacturer%>"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','�ͻ���Ϣ','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.manufacturer_name','form1.manufacturer');">
    </td>

    <td>������λ</td>
    <td><input name="distributor_name" type="text" size="40" readonly value="<%= distributor_name%>"><input type="hidden" name="distributor" value="<%= distributor%>"><img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onclick="OpenDataWindow('','','','','�ͻ���Ϣ','vi_cust_all_info','cust_name','cust_id','cust_name','cust_name','asc','form1.distributor_name','form1.distributor');">
    </td>
  </tr>
  <tr>
    <td>���������</td>
    <td><input name="equip_delivery_place" type="text" size="40" maxB="300" value="<%= equip_delivery_place%>"></td>
    <td>�豸���õ�</td>
    <td><input name="equip_place" type="text" size="40" maxB="300" value="<%= equip_place%>"></td>
  </tr>
  <tr>
    <td>����ʱ��</td>
    <td><input name="equip_delivery_date" type="text" size="15" readonly maxlength="10" dataType="Date" value="<%= equip_delivery_date%>"> <img  onClick="openCalendar(equip_delivery_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>������֤��</td>
    <td><input name="shelf_life" type="text" size="15" readonly maxlength="10" dataType="Date" value="<%= shelf_life%>"> <img  onClick="openCalendar(shelf_life);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>
  	<td>���״̬</td>
    <td><select name="equip_status"></select>
	<script language="javascript">dict_list("equip_status","equip_status","<%= equip_status%>","name");</script>
    </td>
    <td>״̬����</td>
    <td><input name="status_date" type="text" size="15" readonly maxlength="10" dataType="Date" value="<%= status_date%>"> <img  onClick="openCalendar(status_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
  </tr>
  <tr>
  	<td>�Ƿ���˰</td>
    <td colspan="3"><select name="tax_flag"><script>w(mSetOpt("<%=tax_flag%>",'��˰|��˰'));</script></select>
    </td>
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
