<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/headImport.jsp"%>
<!-- 05.002 -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>������- ������ϸ��</title>
	<link href="../../css/global.css" rel="stylesheet" type="text/css">
	<script src="../../js/comm.js"></script>
	<script src="../../js/delitem.js"></script>

	<script Language="Javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
	<script type="text/javascript" src="../../js/stleasing_function.js"></script>
	<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
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

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<!-- ���޹�˾�������̵��ж� -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- ���޹�˾�������̵��ж� -->

<body onload="public_onload(0);">
<form action="overdue_detail_list.jsp" name="dataNav" onSubmit="return goPage()">
	<!--���⿪ʼ-->
	<table border="0" width="100%" cellspacing="0" cellpadding="0"
		height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				������&gt; ������ϸ��
			</td>
		</tr>
	</table>
<!--�������-->
<%String yq_amount_str = "|����1��|����2��|����3��|3������"; %>
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>������</td>
<td><input name="dld_name" type="text" size="11" ></td>
<td>��Ŀ���</td>
<td><input name="proj_id" type="text" size="11" ></td>
<td>����������</td>
<td><select name="prod_id" style="width:90px;">
     <script>w(mSetOpt('',"<%= prod_id_str%>"));</script>
     </select>
</td>

<td>����ȷ����</td>
<td><input name="start_date" type="text" size="10" readonly dataType="Date" ><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">&nbsp;��
<input name="end_date" type="text" size="10" readonly dataType="Date" ><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="waitSub()" value="��ѯ"></td>
</tr>

<tr>
<td>������</td>
<td><select name="zzs" style="width:90px;">
     <script>w(mSetOpt('',"<%=zzs_str%>"));</script>
     </select></td>
<td>�ͻ�����</td>
<td><input name="cust_name" type="text" size="11" ></td>
<td>����&nbsp;&nbsp;����</td><td><select name="yq_amount" style="width:90px;">
     <script>w(mSetOpt('',"<%= yq_amount_str%>"));</script>
     </select>
</td>

<td>����&nbsp;&nbsp;����</td>
<td><input name="overdue_day_start" type="text" size="10" >&nbsp;&nbsp;��&nbsp;&nbsp;
<input name="overdue_day_end" type="text" size="10">
</td>
<td><input type="button" onclick="clearQuery()" value="���"></td>
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
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
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

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">

	<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		<tr class="maintab_content_table_title">
		<th width="1%"></th> 						
        <th>���</th>
        <th>����</th>
		<th>�����</th>
        <th>��֧����</th>
        <th>��Ŀ���</th>
        <th>�ͻ�����</th>
		<th>������</th>
		<th>����������</th>
        <th>����</th>
        <th>�������</th>
        
		<th>��������</th>
		<th>��������</th>
		<th>�ƻ���������</th>

		<th>�����ﹺ��ۿ�</th>
        
		<th>����ܶ�</th>
		<th>�Ѹ�����</th>
		<th>�Ѹ����</th>

		<th>δ������</th>
		<th>δ�����</th>
        
		<th>��������</th>
		<th>�ۼ�����</th>
        <th>��������</th>
        <th>���������</th>
        
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

