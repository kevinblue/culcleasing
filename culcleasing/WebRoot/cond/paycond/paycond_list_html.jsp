<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ǰ�� - �ʽ�ƻ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(document).ready(function(){
		$("tbody[id='dataNew']>tr").each(function(i){
			//��td�� row\col����
			$(this).children("td").each(function(j){
				$(this).addClass("noNewLine");//ǿ�Ʋ�����  break-all�Զ�����
			});
		});
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onLoad="public_onload(0)">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- ��Ŀ������Ϣ -->
<div style="margin: 0px;">
<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			��Ŀ������Ϣ</td>
		</tr>
</table> 
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="tab_table_title">
  <tr>
    <td scope="row">��Ŀ���</td>
    <td scope="row">CULCD100000022</td>
    <td scope="row">��Ŀ����</td>
    <td scope="row">����**ҽԺֱ����Ŀ</td>
  </tr>
  
  <tr>
    <td scope="row">������</td>
    <td scope="row">����***ҽԺ</td>
    <td scope="row">��ҵ</td>
    <td scope="row">ҽ����ҵ</td>
  </tr>
</table>
</div>

<!-- �Զ����ɡ��������ɰ�ť -->
<div style="margin-top: 10px;text-align: left;">
	<button name="btnAutoIn" type="button" onclick="">
	<img src="../../images/btn_rename.gif" align="bottom" border="0">�Զ������ʽ�ƻ�</button>
	&nbsp;&nbsp;&nbsp;
	<button name="btnAgain" type="button" onclick="">
	<img src="../../images/btn_refresh.gif" align="bottom" border="0">���������ʽ�ƻ�</button>
</div>


<!-- �ʽ�ƻ����� -->
<div style="margin-top: 20px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			�ʽ�ƻ�</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">

		<td><a href="#" accesskey="n" onClick="dataHander('add','basetrade_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="����(Alt+N)"></a>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','basetrade_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','basetrade_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" ></a></td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��/������</th>
     <th>��/�������˺�</th>
     <th>��֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>���㷽ʽ</th>
     <th>��ע</th>
     <th>����</th>
     
     <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��/������</th>
     <th>��/�������˺�</th>
     <th>��֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>���㷽ʽ</th>
     <th>��ע</th>
     <th>����</th>
     
     <th>���ʽ</th>
     <th>��������</th>
     <th>���</th>
     <th>��/������</th>
     <th>��/�������˺�</th>
     <th>��֧ʱ��</th>
     <th>����</th>
     <th>��/������</th>
     <th>���㷽ʽ</th>
     <th>��ע</th>
     <th>����</th>
   </tr>
   <tbody id="dataNew">
     <tr>
     	<td>�տ�</td>
     	<td>�׸���</td>
     	<td>1</td>
     	<td>����</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>�����</td>
     	<td>450,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>�޸�|ɾ��</td>
     	
     	<td>�տ�</td>
     	<td>�׸���</td>
     	<td>1</td>
     	<td>����</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>�����</td>
     	<td>450,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>�޸�|ɾ��</td>
     	
     	
     	<td>�տ�</td>
     	<td>�׸���</td>
     	<td>1</td>
     	<td>����</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>�����</td>
     	<td>450,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>�޸�|ɾ��</td>
     </tr>
     <tr>
     	<td>�տ�</td>
     	<td>������</td>
     	<td>1</td>
     	<td>����</td>
     	<td>3423478787878</td>
     	<td>2011-06-12</td>
     	<td>�����</td>
     	<td>440,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>�޸�|ɾ��</td>
     </tr>
     <tr>
     	<td>����</td>
     	<td>�豸���</td>
     	<td>1</td>
     	<td>��������</td>
     	<td>38773434444787878</td>
     	<td>2011-09-12</td>
     	<td>�����</td>
     	<td>12,450,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>�޸�|ɾ��</td>
     </tr>
     </tbody>
</table>
</div>

</div><!-- �����ʽ�ƻ�div -->

<!-- �ʽ𸶿�ǰ�� -->
<div style="margin-top: 50px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
		<tr class="tree_title_txt">
			<td nowrap width="100%" class="tree_title_txt" valign="middle">
			�ʽ𸶿�ǰ��</td>
		</tr>
</table> 
</div>
<!-- end cwTop -->

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">

		<td><a href="#" accesskey="n" onClick="dataHander('add','basetrade_add.jsp',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_new.gif" alt="����(Alt+N)"></a>

		<td><a href="#"  accesskey="m" onClick="dataHander('mod','basetrade_mod.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_mod.gif" alt="�޸�(Alt+M)" width="19" height="19" align="absmiddle" ></a></td>

        <td><a href="#" accesskey="d" onClick="dataHander('del','basetrade_del.jsp?czid=',dataNav.itemselect);">
		<img align="absmiddle" src="../../images/sbtn_del.gif" alt="ɾ��(Alt+D)" ></a></td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>��������</th>
     <th>���</th>
     <th>��֧ʱ��</th>
     <th>����</th>
     <th>������</th>
     <th>���㷽ʽ</th>
     <th>��ע</th>
     <th>����ǰ��</th>
     <th>����</th>
   </tr>
     <tr>
     	<td>�豸���</td>
     	<td>1</td>
     	<td>2011-09-12</td>
     	<td>�����</td>
     	<td>12,450,33</td>
     	<td>���</td>
     	<td>��</td>
     	<td>
     	��Ʊ��<br>
     	�ʽ��տ��վ�&nbsp;&nbsp;
     	<input class="rd" type="radio" name="sfsd" value="����">����
     	<input class="rd" type="radio" name="sfsd" value="δ��">δ��
     	<input class="rd" type="radio" name="sfsd" value="�ղ���">�ղ���
     	<br>
     	</td>
     	<td>�޸�|ɾ��</td>
     </tr>
</table>
</div>

</div><!-- �����ʽ𸶿�ǰ��div -->

</body>
</html>
