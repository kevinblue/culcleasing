<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ŀ���� - �����嵥</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<%
//��ȡ����proj_id,doc_id
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
//ģ�⸳ֵ
proj_id = "00007-03-02-2010-00162-00000";
doc_id = "F54FA93C6C6E0F0B4825780300334D18";

//00007-03-02-2010-00162-00000
//F54FA93C6C6E0F0B4825780300334D18
%>

<body onLoad="public_onload(0)" style="overflow: auto;">
<!-- text="#000000" bgcolor="#FFFFFF" topmargin=0 leftmargin=0 class=menu style='border:1px solid #8DB2E3;margin:0px;' -->

<!-- �ʽ�ƻ����� -->
<div style="margin-top: 0px;">

<div id="cwTop">
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle">
		��Ŀ�����嵥</td>
	</tr>
</table> 
</div>
<!-- end cwTop -->

<script type="text/javascript">
//������Ŀ����
function updMater(){

	window.open('proj_updmater.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>', 'newwindow', 'height=450, width=560, top=0, left=0,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no');

	//window.showModalDialog("proj_updmater.jsp?proj_id=<%=proj_id %>&doc_id=<%=doc_id %>",obj,"dialogWidth=560px;dialogHeight=450px;center=yes;resizable=yes;");
	//window.showModelessDialog();
}
</script>

<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td>
			<!-- �����ʽ�ƻ� -->
			<BUTTON class="btn_2" type="button" onclick="updMater();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0" alt="�޸�(Alt+N)">&nbsp;�޸�����</button>
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
     <th>�ı��Ƿ�鵵</th>
     <th>���Ӱ��Ƿ�鵵</th>
     <th>��ע</th>
     <th>����</th>
   </tr>
   <tbody>
<%
String col_str="id,proj_id,doc_id,document_id,doc_title,doc_par_title,text_status,electron_status,remark";

sqlstr = "select "+col_str+" from vi_proj_document where proj_id='"+proj_id+"' and doc_id='"+doc_id+"' order by doc_par_title";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
     <tr>
     	<td align="left"><%=getDBStr(rs.getString("doc_par_title")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("doc_title")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("text_status")) %></td>
     	<td align="center"><%=getDBStr(rs.getString("electron_status")) %></td>
     	<td align="left"><%=getDBStr(rs.getString("remark")) %></td>
     	<td align="center">
     	<!-- ɾ����� -->
	    <script type="text/javascript">
			function delItem(obj){
				if(confirm("ȷ��ɾ������Ŀ���ϣ�")){
					window.open('proj_matersave.jsp?type=del&item_id='+obj );
				}
			}
		</script>
	    <a href='Javascript: delItem(<%=getDBStr(rs.getString("id"))%>)'>
	    <img src="../../images/sbtn_del.gif" align="bottom" border="0">ɾ��</a>
     	</td>
     </tr>
<%}
rs.close();
db.close();
%>     
     </tbody>
</table>
</div>
</div><!-- �����ʽ�ƻ�div -->

</body>
</html>
