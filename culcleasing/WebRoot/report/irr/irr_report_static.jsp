<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��̬IRR</title>
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
	$("#firstload").css("display","none");
	$("#waitload").css("display","block");

	dataNav.submit();
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
<form action="irr_report.jsp" name="dataNav" method="get">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		��̬IRR
		</td>
	</tr>
</table><!--�������-->

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" 
onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td scope="row">
��Ŀ���:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
<input style="width:150px;" name="proj_id" id="proj_id" type="text">
</td>


<td>��Ŀ����:&nbsp;
<input style="width:150px;" name="project_name" id="project_name" type="text">
</td>	

<td>�ͻ�����:&nbsp;&nbsp;
<input style="width:150px;" name="cust_name" id="cust_name" type="text">
</td>	
<td colspan="2" align="left">
<input type="button" onclick="waitSub()" value="��ѯ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" onclick="clearQuery()" value="���"></td>
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
		<th align="center" style="font-weight: bold;">��Ŀ���</th>
	    <th align="center" style="font-weight: bold;">��ͬ���</th>
	    <th align="center" style="font-weight: bold;">��Ŀ����</th>
	    <th align="center" style="font-weight: bold;">�ͻ�����</th>
	    <th align="center" style="font-weight: bold;">�ƻ�IRR</th>
	    <th align="center" style="font-weight: bold;">ʵ��IRR</th>
	</tr>
<tbody>
	
	
	
	<tr><td colspan="6">
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