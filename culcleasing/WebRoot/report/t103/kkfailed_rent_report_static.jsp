<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Expires" content="3600"><!-- ����1Сʱ -->	
	<title>������ - �ۿ�δ�ɹ���ϸ��</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script language="javascript">
	function clearQuery(){
	$("#queryArea input").not(":button").val("");
		$("#queryArea select").val("");
	}

	function waitSub(){
		$("#firstload").css("display","none");
		$("#waitload").css("display","block");

		dataNav.submit();
	}
	</script>
</head>

<!-- ����ֵ -->
<%@ include file="../../public/selectStaticData.jsp"%>
<!-- ����ֵ -->

<body onload="public_onload(0);">
<form action="kkfailed_rent_report.jsp" name="dataNav">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			������ &gt; �ۿ�δ�ɹ���ϸ��
		</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>������</td>
<td><input name="dld_name" type="text" size="11"></td>
<td>��Ŀ���</td>
<td><input name="proj_id" type="text" size="11"></td>
<td>����������</td>
<td><select name="prod_id" style="width:88px;">
     <script>w(mSetOpt('',"<%=prod_id_str %>"));</script>
     </select>
</td>

<td>Ӧ������</td>
<td><input name="start_date" type="text" size="9" readonly dataType="Date">
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"></td>
<td>&nbsp;&nbsp;��&nbsp;</td>
<td>
<input name="end_date" type="text" size="9" readonly dataType="Date">
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td>��������</td>
<td><select name="bank" style="width:90px;">
     <script>w(mSetOpt('',"<%=bank_str %>"));</script>
     </select></td>

</tr>

<tr>
<td>������</td>
<td>
<select name="zzs" style="width:88px;">
 <script>w(mSetOpt('',"<%=zzs_str%>"));</script>
</select>
</td>
<td>�ͻ�����</td>
<td><input name="cust_name" type="text" size="11"></td>
<td>����&nbsp;&nbsp;���</td>
<td><input name="equip_sn" type="text" size="11"></td>

<td>�ʽ�״̬</td>
<td>
<select name="zj_status" style="width:100px;">
 <script>w(mSetOpt('',"|����|����"));</script>
</select>
</td>
<td>��������</td>
<td>
<select name="fee_type" style="width:100px;">
 <script>w(mSetOpt('',"|���|ΥԼ��"));</script>
</select>
</td>
<td align="left"><input type="button" onclick="waitSub()" value="��ѯ"></td>
<td align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="clearQuery()" value="���"></td>
</tr>
</table>
</fieldset>
</div><!-- ��ѯ�������� -->


<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<BUTTON class="btn_2"  type="button" onclick="javascript: alert('�Բ����������ݣ��޷�������');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!-- 
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;ҳ��ȫѡ
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;����ȫѡ
				</td><!--������ť����-->
			</tr>
		</table><!--������ť����-->
		</td>
</tr>
</table>				
</td>
</tr>
</table>
 
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
	cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>���</th>
		<th>����</th>
		<th>������</th>
        <th>��Ŀ���</th>
		<th>�ͻ�����</th>
		
		<th>���򸶿�</th>
		<th>����������</th>
		<th>������</th>
		<th>����</th>
		<th>�������</th>

		<th>��������</th>
		<th>�ڴ�</th>
		<th>�ۿʽ</th>
		<th>Ӧ������</th>
		<th>Ӧ�ս��</th>

		<th>�ۿ�����</th>
		<th>δ�ɹ�ԭ��</th>
		<!--
		<th>���</th>
		-->
		
		<th>����ԭ��</th>
		<th>����˵��</th>
		<th>��ϸ����</th>
	</tr>
</table>

<div id="firstload">
<!-- �Ѻ���ʾ -->
<center><div style="margin-top:40px">
<font color=#808080>
&nbsp;&nbsp;���ã��״�����������ѯ...</font></div></center>
<!-- �Ѻ���ʾ���� -->
</div>

<div id="waitload" style="display:none;">
<!-- �Ѻ���ʾ -->
<center><div style="margin-top:40px">
<img src="../../images/loading.gif" align="center">
<font color=#808080>
&nbsp;&nbsp;���������У����Ժ�...</font></div></center>
<!-- �Ѻ���ʾ���� -->
</div>

</div><!--�������-->
</form>
</body>
</html>