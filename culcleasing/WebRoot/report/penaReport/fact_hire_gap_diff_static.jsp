<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����ʵ�ʼ�������</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script language="javascript">
function clearQuery(){
$("#queryArea input").not(":button").val("");
	$("#queryArea select").val("");
}

function waitSub(){
	//�жϱ������Ƿ���д
	var sD = $(":input[name='start_date']").val();
	var eD = $(":input[name='end_date']").val();
	
	if(sD=="" || eD==""){
		alert("��ѯʱ��α�����д����");
		return false;
	}else{
		$("#firstload").css("display","none");
		$("#waitload").css("display","block");
	
		dataNav.submit();
	}
}
</script>
<style type="text/css">
.maintab_content_table_title2 {
/*background-image:url(../images/pageleft_topbg_1.gif);*/
background-color:#ffffff;
color:#15428B;
text-align:center;
border-top:1px solid #FF0000;
position:relative;
}
</style>
</head>

<body onload="public_onload(0);">
<form action="fact_hire_gap_diff.jsp" name="dataNav">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		 ����ʵ�ʼ�������
		</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="15"></td>
<td>�ͻ�����:&nbsp;<input name="cust_name"  type="text" size="15"></td>

<td>
���:&nbsp;<select name="board_name" style="width:115px;">
  <script type="text/javascript">
   	w(mSetOpt('',"|ҽ����ҵ|����|����|��е|����","|ҽ����ҵ|����|����|��е|����"));
  </script>
</select>
</td>

<td><input type="button" value="��ѯ" onclick="waitSub()"></td>
</tr>

<tr>
<td>��ѯʱ��:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>

<td>��Ŀ����:&nbsp;<input name="manage_name"  type="text" size="15"></td>
<td>����:&nbsp;<input name="dept_name"  type="text" size="15"></td>

<td><input type="button" value="���" onclick="clearQuery();" ></td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

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
			
		<td>
			<img src="../../images/sbtn_split.gif" width="2" height="14">
		</td>
		<td nowrap>
		</td><!--������ť����-->
	</tr>
	</table><!--������ť����-->
	</td>
	<td align="right" width="90%">
	</td>
	</tr>
</table>
 
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center"
		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
	
	 <tr class="maintab_content_table_title">
		<th>��Ŀ����</th>
        <th>�ͻ�����</th>
        <th>���</th>
        <th>ǩԼʱ��</th>
        
        <th>����</th>
        <th>��Ŀ����</th>
        <th>ҽԺ�ȼ�</th>
        <th>ҽԺ����</th>
        <th>�Ƿ����</th>
        <th>��ͬ���޼�����죩</th>
        
        <th width="60px;">��1������죨�죩</th>
        <th width="60px;">��2������죨�죩</th>
        <th width="60px;">��3������죨�죩</th>
        <th width="60px;">......</th>
        <th width="60px;">......</th>
        <th width="60px;">��N������죨�죩</th>
      </tr>  
<tbody>
	
	<tr>
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	

		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	

		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>	
		<td align="left"></td>
		<td align="left"></td>		
	</tr>	
	
	
	<tr><td colspan="16">
	<div id="firstload">
		<!-- �Ѻ���ʾ -->
		<center><div style="margin-top:10px">
		<font color=#808080>
		&nbsp;&nbsp;���ã��״�����������ѯ...</font></div></center>
		<!-- �Ѻ���ʾ���� -->
		</div>
		<div id="waitload" style="display:none;">
		<!-- �Ѻ���ʾ -->
		<center><div style="margin-top:10px">
		<img src="../../images/loading.gif" style="text-align: center;">
		<font color=#808080>
		&nbsp;&nbsp;���������У����Ժ�...</font></div></center>
		<!-- �Ѻ���ʾ���� -->
	</div>
	</td></tr>
</tbody>

</table>
</div><!--�������-->
</form>
</body>
</html>