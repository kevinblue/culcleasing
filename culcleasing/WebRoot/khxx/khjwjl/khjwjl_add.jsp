<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�����ͻ�������¼ - �ͻ���Ϣ����</title>

<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
<script src="../../js/calend.js"></script>
</head>

<body>


<form name="form1" enctype="multipart/form-data"  method="post" action="khjwjl_save.jsp" onSubmit="return Validator.Validate(this,3);">



<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
�ͻ���Ϣ���� &gt; �����ͻ�������¼
</td>
</tr>
<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--������ť��ʼ-->

<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
<BUTTON class="btn_2" name="btnSave" value="����"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">����</button>
<BUTTON class="btn_2" name="btnReset" value="ȡ��" onclick="window.close();">
<img src="../../images/btn_close.gif" align="absmiddle" border="0">�ر�</button>

    	
<!--  	
    	<a href="" class="fontcolor" type="submit" name="btnSave"><img align="absmiddle" src="../../images/save.gif" border="0" alt="����"> ����</a>
    	<a href="" class="fontcolor" type="reset"><img align="absmiddle" src="../../images/hg.gif" border="0" alt="����"> ����</a>
    	
    	<input class="btn" name="btnSave" value="����" type="submit">
    	<input class="btn" name="btnReset" value="����" type="reset">
    	-->
    </td></tr>
</table>
<!--������ť����-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_0" class="Form_tab" width=70 align=center onclick="chgTabN()"  valign="middle">�� ��</td>
  
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  
 </tr>
 </table>
  <script language="javascript">
ShowTabN(0);
</script> 
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwCellTop -->

<%
	String cust_id = getStr( request.getParameter("cust_id") );
	String cust_name = "";
	ResultSet rs;
	String sqlstr = "select cust_name from vi_cust_all_info where cust_id='" + cust_id + "'"; 

	rs = db.executeQuery(sqlstr); 
	if (rs.next()){
		cust_name = getDBStr( rs.getString("cust_name") );
	}
	rs.close();
	db.close();
%>


<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<!--
<div class="linetype" id="mydiv" style="padding:12px vertical-align:top;margin:0px 12px 12px 12px;overflow:auto;height:300px">
-->
<input type="hidden" value="add" name="savetype">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
    <td scope="row" nowrap>�ͻ����ƣ�</td>
    <td><%= cust_name %>
    <input name="cust_id" type="hidden" value="<%= cust_id %>"></td>
  </tr>
  <tr>
    <td scope="row" nowrap>����ʱ�䣺</td>
    <td><input name="contact_date" type="text" value="" dataType="Date" Require="true" readonly><img  onClick="openCalendar(contact_date);return false" style="cursor:pointer; " src="../../images/btn_time.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  <td scope="row" nowrap>��¼���ͣ�</td>
    <td>
    	<input type="text" name="record_type" maxB="20">
    	</td>
  </tr>
  
  <tr>
    <td >��¼���ݣ�</td>
<td scope="row" colspan="4">
    <textarea class="text" name="record_content"  maxB="300" rows="15"></textarea></td>
  </tr>
  <tr>
    <td scope="row">������</td>
    <td><!-- �ϴ���� -->
	<!--
<input type="button" onclick="insRow('tabUpFile')" value="�����ϴ���"  name="addFileNum" >
-->
<table id="tabUpFile" border="0" cellpadding="0" cellspacing="0"></table><script>insRow('tabUpFile')</script>
<!-- End �ϴ���� --><span class="biTian">�����ϴ����ļ�����.zip.jpg.jpeg.gif.bmp.xls.doc.ppt.mpp.rar.txt</span></td>
  </tr>
</table>


</div>

</div>
</td></tr></table>
    </form>

<!-- end cwMain -->
</body>
</html>
