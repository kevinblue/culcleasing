<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ͬ���²���</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function closeWindow(){
		window.close();
	}
	//�ύ��������״̬
	 function updMaterStatus(openUrl,selfUrl){
		var seal_date = document.getElementById("seal_date").value;
			if(null == seal_date || '' == seal_date){
				alert("��ͬ����ʱ�䲻��Ϊ�գ�");
				return false;
			}
		dataNav.action = openUrl;
		dataNav.target = "_blank"
		dataNav.submit();
		dataNav.action = selfUrl;
		dataNav.target = "_self"
	} 

	//�Ƿ�ȫѡ
function SelectAll(){
	var checkboxs=document.getElementsByName("list");
	var all=document.getElementsByName("all");
	all.checked=!all.checked;
	for (var i=0;i<checkboxs.length;i++) {
	var e=checkboxs[i];
	e.checked=!e.checked;
 }
	}
	</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="contract_list_seal_date.jsp" name="dataNav" onSubmit="return goPage()" method="post">

<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">
<!-- �ʽ�ƻ����� -->

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��ͬ���²���</td>
	</tr>
</table> 

<%

wherestr = "";
String contractId = getStr(request.getParameter("contract_id"));
String seal_date = getStr(request.getParameter("seal_date"));

wherestr += " and phy_contract_id = '" + contractId + "'";
countSql = "select count(id) as amount from vi_contract_list_info_seal_date where 1=1 "+wherestr;

%>
<!--���۵���ѯ��ʼ-->
	<div style="width:100%;" id="queryArea">
	<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
	  <legend>&nbsp;�����޸�
	<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
	</legend>
	<table border="0" width="100%" cellspacing="5" cellpadding="0">
	<tr>
	
	<td scope="row" id="bj_4">��ͬ����ʱ�䣺&nbsp;
	<input type="text" id="seal_date" name="seal_date" readonly="readonly"
	value="<%=seal_date %>"
	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
</td>
<td>			
	<input type="button" value="ȷ��" onclick="return updMaterStatus('contract_list_info_seal_date_upd.jsp','contract_list_seal_date.jsp');">
	&nbsp;&nbsp;
	<input type="button" value="�ر�" onclick="closeWindow();" />
	<!-- <input type="button" value="���" onclick="clearQuery();" > -->
	</td>
	
	</tr>
	</table>
	</fieldset>
	</div>
	<!--���۵���ѯ����-->
<!-- end cwTop -->
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
<td></td>
		<!-- ��ҳ���� -->
		<td width="60%" align="right"><!--��ҳ���ƿ�ʼ-->
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->
		</td><!-- ��ҳ���� -->
</tr>
</table>
<input type="hidden" name="contract_id" value="<%=contractId %>"/>
<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	  <th align="center"><input type="checkbox" name="all" id="all" style="border:0px;" onclick="SelectAll()">ȫ/��ѡ</th> 
	    <th>��ͬ����</th>
		<th>��ͬ���</th>
		<th>��ͬ���</th>
		<th>ǩԼ��</th>
		<th>��ͬ���</th>
     	<th>Ԥ��ǩԼ����</th>
 		<th>��ͬ״̬</th>
		<th>����ʱ��</th>
      </tr>
   <tbody id="data">
<%

String col_str="*";

sqlstr = "select top "+ intPageSize +" * from vi_contract_list_info_seal_date where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_contract_list_info_seal_date where 1=1 "+wherestr+" order by id ) "+wherestr ;
sqlstr +=" order by id";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
		<td><input type="checkbox" name="list" value="<%=getDBStr(rs.getString("id"))%>"></td>
        <td align="left"><%=getDBStr(rs.getString("contract_main_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("make_contract_id"))%></td>
		<td align="left"><%=getDBStr(rs.getString("contract_type"))%></td>
		<td align="left"><%=getDBStr(rs.getString("sign_way"))%></td>
		<td align="left"><%=CurrencyUtil.convertFinance(rs.getString("sign_money"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("plan_sign_date"))%></td>
        <td align="left"><%=getDBStr(rs.getString("contract_status"))%></td>
        <td align="left"><%=getDBDateStr(rs.getString("seal_date"))%></td>
      </tr>
<%}
			//System.out.println("test=========="+index_no);
rs.close();
db.close();
%>  

<%-- <tr><td colspan='20'>���Ե�SQL<%=sqlstr %></td></tr> --%>   
     </tbody>
</table>
</div>
</form>

</body>
</html>
