<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>��ͬǩԼȷ�����ӡ</title>
<style type="text/css">
<!--
.STYLE1 {font-family: "���Ŀ���"}
.STYLE2 {font-family: "���Ŀ���"; font-weight: bold; }
-->
</style>
</head>

<body>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB2"/>
<input type="button" value="����ת��" onclick="javascript:zy();" name="printB23"/>
<%
	String projId=getStr(request.getParameter("projId"));//���Ψһ
	String projName =getStr(request.getParameter("projName"));//��Ŀ����
	String prodRa = getStr(request.getParameter("prodRa"));
%>
<!-- ��Ŀ��Ϣ -->
<div>
  <div align="center" class="STYLE2"><h3>��ͬǩԼȷ����</h3></div>
</div>
<div>
  <div align="right" class="STYLE1"><%=prodRa %></div>
</div>
<table width="650" height="551" align="center" cellpadding="3" cellspacing="0" border="1">
  <tr>
    <td width="15%" height="30"><div align="center" class="STYLE1">��Ŀ����</div></td>
    <td width="35%"><div align="center" class="STYLE1"><%=projName %></div></td>
    <td width="15%"><div align="center" class="STYLE1">��Ŀ���</div></td>
    <td width="35%"><div align="center" class="STYLE1"><%=projId %></div></td>
  </tr>
  <tr>
    <td height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>��ҵ����</strong></div></td>
  </tr>
  <tr>
    <td height="133" colspan="4"><p> &nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">����Ŀ���з��ɺ�ͬ�ı����չ�˾�쵼����ز��ŵ����ȫ���޸���ϣ������չ�˾�涨�����Ҳ�������Ա��ˣ�ȷ�����պ�ͬ�ı�����</span></p>
      <p><span class="STYLE1">��Ŀ����</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">��Ŀ����</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>������</strong></div></td>
  </tr>
  <tr>
    <td height="133" colspan="4"><p>&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">�Ҳ��Ѿ͸���Ŀ��ͬ�ı��漰������������ְ����漰��������ı䶯���ּ�����顢������ϣ�ȷ�����պ�ͬ�ı�����</span></p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">ȷ����ǩ�֣�</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td  height="20" colspan="4" bgcolor="#CCCCCC"><div align="center" class="STYLE1"><strong>������</strong></div></td>
  </tr>
  <tr>
    <td height="130" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">�Ҳ��Ѿ͸���Ŀ��ͬ�ı����漰�ʿز���ְ�����������ı䶯���ּ��������ϣ�������ҵ���Ű��������š�����������Ժ�ͬ���������ĸ�����䶯���ֽ����˷�����ʽ�������ϵĻ��ˣ�ȷ�����պ�ͬ�ı�����
    </span>
      <p>&nbsp;</p>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="STYLE1">������</span></p>
      <p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
</table>
<p>&nbsp;</p>
<input type="button" value="��ӡ" onclick="javascript:yincang();" name="printB1"/>
</body>
<script type="text/javascript">
function yincang(){
	document.getElementsByName("printB1")[0].style.display="none";
	document.getElementsByName("printB2")[0].style.display="none";
	document.getElementsByName("printB23")[0].style.display="none";
	
	window.print();
}

function zy(){
	window.location.href = window.location.href+'&1=1';
	window.reload();
}
</script>
</html>
