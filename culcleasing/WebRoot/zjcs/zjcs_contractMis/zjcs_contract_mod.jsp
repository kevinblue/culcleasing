<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ��Ϣ - �����ƻ��޸�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script><script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
	
	function checkDate(){//�������
	alert('join');
		var nowDateTime = document.getElementById('nowDateTime').value;
		var newDateTime = document.getElementById('plan_date').value;
		//alert(newDateTime);
		if(newDateTime < nowDateTime){
			alert("�������ڲ���С�ڽ��������!");
			document.getElementById('plan_date').value = nowDateTime;
			return false;
		}
	}
	//�����ֵ
	function fzValue(){
		//��� = ���� + ��Ϣ
		var corpus = document.getElementById('corpus').value;
		var interest = document.getElementById('interest').value;	
		if(corpus == null || corpus == ''){
			alert("������Ϊ��!");
			return false;
		}
		else if(interest == null || interest == ''){
			alert("��Ϣ����Ϊ��!");
			return false;
		}
		else{
			document.getElementById('rent').value = Number(corpus) + Number(interest);
		}
			
	}
</script>
</head>

<%
	String dqczy = (String) session.getAttribute("czyid");
	if ((dqczy == null) || (dqczy.equals("")))
	{
		dqczy = "����֤";
	}
	//�Ӳ���
	//String doc_id = getStr(request.getParameter("doc_id"));//�ĵ����
	String contract_id = getStr(request.getParameter("contract_id"));//��ͬ���
	//String proj_id = getStr(request.getParameter("proj_id"));//��Ŀ���
	//String temp = getStr(request.getParameter("temp"));//�����ж�����Ŀ���Ǻ�ͬ�Ĳ���
	String savetype = getStr(request.getParameter("savetype"));//��������
	String key_id = getStr(request.getParameter("itemselect"));//id
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	ResultSet rs;
	
	String sqlstr = "";
	String	rent_list = "";//����
	String	plan_date = "";//��������
	String	rent = "";//���
	String	corpus = "";//����
	String	interest = "";//��Ϣ
	//�ж�Ҫ�޸ĵ������Ƿ���δ����
	String plan_status = "";
	
	//��ͬ
	sqlstr = " select * from fund_rent_plan where  contract_id = '"+contract_id+"' ";
%>
<%
		rs = db.executeQuery(sqlstr);
		System.out.println("sql==> : "+sqlstr);
		while(rs.next()){
			rent_list = getDBStr(rs.getString("rent_list") );
			plan_date = getDBDateStr(rs.getString("plan_date") );
			rent = formatNumberDoubleTwo(getDBStr(rs.getString("rent")));
			corpus = formatNumberDoubleTwo(getDBStr(rs.getString("corpus")));
			interest = formatNumberDoubleTwo(getDBStr(rs.getString("interest")));
			plan_status = getDBStr( rs.getString("plan_status") );
		}
		rs.close();
		db.close();
%>
<!-- onload="fun_winMax();" -->
<body >
<form name="form1" method="post" action="zjcs_contract_save.jsp" onSubmit="return Validator.Validate(this,3);">
<input type="hidden" name="savetype" value="<%=savetype%>">
<input type="hidden" name="czid" value="<%=dqczy%>">
<input type="hidden" name="contract_id" value="<%=contract_id%>">
<input type="hidden" name="key_id" value="<%=key_id%>">

<div id=bgDiv>
<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">
<tr valign="top" class="tree_title_txt">
<td class="tree_title_txt"  height=26 valign="middle">
��ͬ��Ϣ &gt; �����ƻ��޸�
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
<table class="tab_table_title" border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
  	<td align="center">
		���
	</td>
	<td>
		<input name="name_id" type="text" size="20" maxB="20"
			Require="ture" value="<%=contract_id%>" readonly>
		<span class="biTian">*</span>
	</td>
	<td align="center">����</td>
    <td>
    	<input name="rent_list" type="text" size="20" 
    	maxB="20" Require="true" dataType="Integer" 
    	value="<%=rent_list%>" readonly="readonly"/>
    	<span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td align="center">��������</td>
    <td>
    	<input name="plan_date" type="text" size="15" onchange="checkDate()"
    	 readonly maxlength="10" dataType="Date" Require="ture" 
    	 value="<%=plan_date%>"> 
    	 <img  onClick="openCalendar(plan_date);return false" 
    	 style="cursor:pointer; " src="../../images/tbtn_overtime.gif"
    	  width="20" height="19" border="0" align="absmiddle">
		<span class="biTian">*</span>
	</td>
  	<td align="center">����</td>
    <td>
    	<input name="corpus" type="text" size="20" maxB="20" 
    	Require="true" dataType="Money" value="<%=corpus%>" />
    	<span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td align="center">��Ϣ</td>
    <td>
    	<input name="interest" type="text" size="20" onchange="fzValue()"
    		maxB="20" Require="true" dataType="Double" 
    		value="<%=interest%>" />
    		<span class="biTian">*</span></td>
    <td align="center">���</td>
    <td>
    	<input name="rent" type="text" size="20" 
    	maxB="20" Require="true" dataType="Money" 
    	value="<%=rent%>" />
    	<span class="biTian">*</span></td>
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
