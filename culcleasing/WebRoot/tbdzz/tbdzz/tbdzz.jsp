<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<%@ page import="java.util.GregorianCalendar" %>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}
int canedit=0;
if (right.CheckRight("tbdzz-tbdzz-add",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Ͷ��������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script>
function savetype(type){
	if(type=="1"){
	document.getElementById('savetype').value="pingan";
	}
	if(type=="2"){
    document.getElementById('savetype').value="zhonghua";
	}
	if(type=="3"){
	document.getElementById('savetype').value="qita";
	}
	var contract_id=document.getElementById('contract_id').value
	if(contract_id!=""){
	document.forms.item(0).submit();
	}else{
		alert('��ѡ��һ����ͬ!');
		document.getElementById('contract_id').focus();
	}
}
</script>
</head>
<body>

<form name="form1" method="post" action="tbdzz_out.jsp">
  <table  class="title_top" width=100% height=100% align="center" cellspacing=0 border="0" cellpadding="0">
  <tr valign="top" class="tree_title_txt">
    <td class="tree_title_txt"  height=26 valign="middle"> Ͷ�������� &gt;  Ͷ�������� </td>
  </tr>
  <tr valign="top">
    <td  align=center width=100% height=100%><table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
        <tr>
          <td><!--������ť��ʼ-->
            <table border="0" cellspacing="0" cellpadding="0">
              <tr class="maintab_dh">
                <td nowrap >
                <input name="type" id="savetype" type="hidden" value="">
<a href="JavaScript:savetype('1')"><img src="../../images/save.gif" align="absmiddle" border="0">ƽ������</a>
<a href="JavaScript:savetype('2')"><img src="../../images/save.gif" align="absmiddle" border="0">�л�����</a>
<a href="JavaScript:savetype('3')"><img src="../../images/save.gif" align="absmiddle" border="0">��������</a>
              </tr>
            </table>
            <!--������ť����--></td>
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
                <td id="Form_tab_0" class="Form_tab" width=70 align=center onClick="chgTabN()"  valign="middle">��ϸ��Ϣ</td>
                <td id="Form_tab_1" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
                <td id="Form_tab_2" class="Form_tab" width=0 align=center onClick="chgTabN()"  valign="middle"></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td class="tab_subline" width="100%" height="2"></td>
        </tr>
      </table>
      <!-- end cwTop -->
      <!-- end cwCellTop -->
      <div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
        <div id="TD_tab_0">
          <table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
            <TR>
              <td>��ѡ���ͬ���</td>
              <td><input name="contract_id" id="contract_id" type="text" readonly>
                <img src="../../images/sbtn_more.gif" alt="ѡ" width="19" height="19" align="absmiddle"  style="cursor:pointer" onClick="OpenDataWindow('','','','','��ͬ���',  'vi_baoxian','contract_id','cust_name|code|mobile_number|addr|post_code|eqip_name|device_type|equip_sn|engine_code|start_date|end_date|lease_term|cust_insurance|lsh_insurance|insurance|insurer|insurance_type|dealer|equip_amt|manufacturer|leave_date','contract_id','contract_id','desc','form1.contract_id','form1.cust_name|form1.code|form1.mobile_number|form1.addr|form1.post_code|form1.eqip_name|form1.device_type|form1.equip_sn|form1.engine_code|form1.start_date|form1.end_date|form1.lease_term|form1.cust_insurance|form1.lsh_insurance|form1.insurance|form1.insurer|form1.insurance_type|form1.dealer|form1.equip_amt|form1.manufacturer|form1.leave_date');"><span class="biTian">*</span></td>
              <td scope="row" nowrap width="20%">Ͷ����</td>
              <td><input name="cust_name" type="text" readonly></td>
            </TR>
            <tr>
              <td scope="row" nowrap width="20%" >Ͷ�������֤����֯�ṹID</td>
              <td><input name="code" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >Ͷ������ϵ�绰</td>
              <td><input name="mobile_number" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">Ͷ���˵�ַ</td>
              <td><input name="addr" type="text" size="40" readonly></td>
              <td scope="row" nowrap width="20%" >�ʱ�</td>
              <td><input name="post_code" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">�����豸����</td>
              <td><input name="eqip_name" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >�豸�ͺ�</td>
              <td><input name="device_type" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">�����</td>
              <td><input name="equip_sn" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >���������</td>
              <td><input name="engine_code" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">�������޿�ʼ����</td>
              <td><input name="start_date" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >�������޽�������</td>
              <td><input name="end_date" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">��������(��)</td>
              <td><input name="lease_term" type="text" readonly></td>
              <td scope="row" nowrap width="20%">���շ�</td>
              <td><input name="insurance" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%" >���չ�˾</td>
              <td><input name="insurer" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >����</td>
              <td><input name="insurance_type" size="40" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">�ͻ��е��ı��շ�</td>
              <td><input name="cust_insurance" type="text" readonly></td>
              <td scope="row" nowrap width="20%" >LSH֧��</td>
              <td><input name="lsh_insurance" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">������</td>
              <td><input name="dealer" type="text" size="40" readonly></td>
              <td scope="row" nowrap width="20%">�������ܼ۸�</td>
              <td><input name="equip_amt" type="text" readonly></td>
            </tr>
            <tr>
              <td scope="row" nowrap width="20%">��������</td>
              <td><input name="manufacturer" type="text" size="40" readonly></td>
              <td scope="row" nowrap width="20%" >��������</td>
              <td><input name="leave_date" type="text" readonly></td>
            </tr>
          </table>
        </div>
      </div>
</form>
</body>
</html>
