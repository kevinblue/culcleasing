<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.service.ProjMaterService"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���� - CD����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	//�ύ��������״̬
	function updMaterStatus(){
		var totalMoney = 0;
		var flag = 0;
		var erItems = "";
		var items = "";
		$("#allMaters>tr").each(function(i){
		    var $materTr = $(this); 
		    var text_status = $materTr.find("td>:input[name^='text_status_']:checked");
			var electron_status = $materTr.find("td>:input[name^='electron_status_']:checked");
			var item = $materTr.find("td>:input[name^='it_']");
			var itemId = $materTr.find("td>:input[name^='item_']");
			//alert("text_status"+text_status.val());
			//�ж����ݵ���ȷ��
			if($.trim(text_status.val())=="" || $.trim(electron_status.val())=="" ){
				//alert("��["+(i+1)+"]����Ŀ������ѡ�񽻽ӹ鵵�����");
				flag = 1;
				erItems += " ["+(i+1)+"] ";
			}
			items += $.trim(item.val())+"|";// ��|��ʵ����-���ֶ�
		});
		//alert(parseFloat(totalMoney)+'sdsdsd'+parseFloat(cost));
		if(flag!=0){
		    alert("��ȷ��ÿ1����Ŀ���Ϲ鵵��������е� "+erItems+" ��û��ѡ��");
			return false;
		}else{
			$(":input[name=itemStr]").val(items.substring(0,items.length-1));
			document.form1.submit();
		}
	}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����contract_id,doc_id
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
if(contract_id==null || "".equals(contract_id)){
	contract_id = "CULC_0022_T001";
	doc_id = "JS999999900_HT11_22_44";
}

//�ȳ�ʼ��������Ŀ�����嵥
ProjMaterService.flowInitContractData(contract_id, doc_id);
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<form name="form1" method="post" target="_blank" action="proj_mater_save.jsp">
<input type="hidden" name="type" value="updStatus">
<input type="hidden" name="itemStr">
<input type="hidden" name="itemIdStr">

<!-- �ʽ�ƻ����� -->
<div style="margin-top: 20px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��Ŀ�����嵥</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- �����ʽ�ƻ� -->
			<BUTTON class="btn_2" type="button" onclick="return updMaterStatus();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�ύ(Alt+N)">&nbsp;�ύ</button>
		</td>
		
		<!-- ��ҳ���� -->
		<td align="right" width="100%">
		</td><!-- ��ҳ���� -->
	</tr>
</table>

<div style="vertical-align:top;width:100%;overflow:auto;position: relative;">
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" class="maintab_content_table">
   <tr class="maintab_content_table_title">
     <th>���ϴ���</th>
     <th>����С��</th>
     <th>��ע</th>
     <th>�ı��Ƿ�鵵</th>
     <th>���Ӱ��Ƿ�鵵</th>
   </tr>
   <tbody id="allMaters">
<%
String col_str="id,contract_id,doc_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";

sqlstr = "select "+col_str+" from vi_contract_document_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
	index_no++;
%>
     <tr class="materTr_<%=index_no %>">
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %>
     	<input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
     	<input type="hidden" name="item_<%=index_no %>" value="<%=getDBStr(rs.getString("id")) %>">
     	</td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     		<input type="radio" class="rd" name="text_status_<%=index_no %>" value="��">��&nbsp;&nbsp;
     		<input type="radio" class="rd" name="text_status_<%=index_no %>" value="��">��
     	</td>
     	<td align="center">
     		<input type="radio" class="rd" name="electron_status_<%=index_no %>" value="��">��&nbsp;&nbsp;
     		<input type="radio" class="rd" name="electron_status_<%=index_no %>" value="��">��
     	</td>
     </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div>
</form>

</body>
</html>
