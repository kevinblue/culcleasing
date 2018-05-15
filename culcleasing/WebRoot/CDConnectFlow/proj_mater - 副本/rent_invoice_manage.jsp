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
		    var invoice_is = $materTr.find("td>:input[name^='invoice_is']:checked");
		    var item = $materTr.find("td>:input[name^='it_']");
		    var begin_id=$materTr.find("td>:input[name^='begin_id_']");
		    var rent_list=$materTr.find("td>:input[name^='rent_list_']");
		    var create_date=$materTr.find("td>:input[name^='create_date_']");
		    var invoice_remark=$materTr.find("td>:input[name^='invoice_remark_']");
		    var creator=$materTr.find("td>:input[name^='creator_']");
		    var modificator=$materTr.find("td>:input[name^='modificator_']");
		    var modify_date=$materTr.find("td>:input[name^='modify_date_']");
		    
			//alert("text_status"+text_status.val());
			//�ж����ݵ���ȷ��
			if($.trim(invoice_is.val())==""  ){
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
     	<th>��Ŀ���</th>
	    <th>��Ŀ����</th>
	    <th>��������</th>
     	<th>��Ŀ����</th>
 		<th>�������</th>
 		
		<th>Ӧ������</th>
	 	<th>Ӧ�����</th>
	 	<th>��Ϣ</th>
	 	<th>����</th>
	 	<th>��Ʊ���߷�ʽ</th>
	 	<th>�Ƿ񿪾�</th>
	 	<th>��ע</th>
	 	<th>����Ƿ����</th>
	 	<th>��������</th>
      </tr>
   </tr>
   <tbody id="allMaters">
<%

String user_id = (String)session.getAttribute("czyid");//��ǰ��½��
String col_str="*";

sqlstr = "select "+col_str+" from vi_func_rent_manage ";

rs = db.executeQuery(sqlstr);
int index_no = 0;
while ( rs.next() ) {
index_no++;
%>   
     <tr class="materTr_<%=index_no %>">
        <td align="center">
        <BUTTON class="btn_2" name="btnHire" value="ת��"  type="button" onclick="return changeOne()">
        			<img src="../../images/fdmo_36.gif" align="absmiddle" alt="ת��(Alt+Y)" border="0">
        			&nbsp;���
        			</button>
        
        <td align="left"><%=getDBStr(rs.getString("proj_id"))%></td>
        <input type="hidden" name="it_<%=index_no %>" value="<%=index_no %>">
        <input type="hidden" name="begin_id_<%=index_no %>" value="<%=getDBStr(rs.getString("begin_id")) %>"/>
        <input type="hidden" name="rent_list_<%=index_no %>" value="<%=getDBStr(rs.getString("rent_list")) %>"/>
        <input type="hidden" name="creator_<%=index_no %>" value="<%=getDBStr(rs.getString("creator")) %>"/>
        <input type="hidden" name="create_date_<%=index_no %>" value="<%=getDBStr(rs.getString("create_date")) %>"/>
        <input type="hidden" name="czyid_<%=index_no %>" value="<%=(String)session.getAttribute("czyid")%>"/>
        <input type="hidden" name="modify_date_<%=index_no %>" value="<%=getDBStr(rs.getString("modify_date")) %>"/>
        
        <td align="left"><%=getDBStr(rs.getString("project_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("dept_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("proj_manage_name"))%></td>
        <td align="left"><%=getDBStr(rs.getString("rent_list"))%></td>
        <td align="left"><%=getDBStr(rs.getString("plan_date"))%></td>
		<td align="left"><%=getDBStr(rs.getString("rent"))%></td>
		<td align="left"><%=getDBStr(rs.getString("interest"))%></td>
		<td align="left"><%=getDBStr(rs.getString("corpus"))%></td>
		<td align="left"><%=getDBStr(rs.getString("invoice_type"))%></td>	
		<td align="center">
			<input type="radio" class="rd" name="invoice_is_<%=index_no %>" value="��" 
     			<%="��".equals(getDBStr(rs.getString("text_status")))?"checked='checked'":"" %>>��&nbsp;&nbsp;
     		<input type="radio" class="rd" name="invoice_is_<%=index_no %>" value="��" 
     			<%="��".equals(getDBStr(rs.getString("text_status")))?"checked='checked'":"" %>>��
		</td>	
		<td align="left"><input type="text" name="invoice_remark_<%=index_no %>" value="<%=getDBStr(rs.getString("invoice_remark"))%>"/></td>
		<td align="left"><%=getDBStr(rs.getString("plan_status"))%></td>
		<td align="left"><%=getDBStr(rs.getString("modificator"))%></td>
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
