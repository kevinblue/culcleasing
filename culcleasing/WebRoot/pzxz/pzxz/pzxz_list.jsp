<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>����ƾ֤���� - ����ƾ֤����</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%
String context = request.getContextPath();
 %>
<body style="border:1px solid #8DB2E3;">
<form action="pzxz_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				����ƾ֤���� &gt; ����ƾ֤����</td>
			</tr>
</table>
<!--�������-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td align="left" width="60%">
					 
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("pzxz-pzxz-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------����ΪȨ�޿���--------
ResultSet rs = null;
String sql = "";
String strwhere = "";
String cert_date = getStr(request.getParameter("cert_date"));
String process_name = getStr(request.getParameter("process_name"));

ResultSet rsName = null;
String processList = "";
sql = "select distinct process_name from inter_evidence_info";
System.out.println(sql);
rsName = db.executeQuery(sql);
while(rsName.next()){
	processList+="|"+getDBStr(rsName.getString("process_name"));
}
rsName.close();

strwhere=" where status='��Ч' and exp_flag='��' ";
if(cert_date!=null&&!cert_date.equals("")){
	strwhere+=" and convert(varchar(10),create_date,21)='"+cert_date+"'";
}
if(process_name!=null&&!process_name.equals("")){
	strwhere+=" and process_name='"+process_name+"'";
}
strwhere+=" order by evidence_number";
sql = "select * from inter_evidence_info "+strwhere;
System.out.println("pzxz_list========================"+sql);

%>



<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<td nowrap><input name="cert_date" type="text" size="15" readonly maxlength="10" value="<%=cert_date %>" dataType="Date"> <img  onClick="openCalendar(cert_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<select name="process_name"><script>w(mSetOpt('<%=process_name%>',"<%=processList%>"));</script></select>
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="fun_search()">
		</td>
		<td><a href="#" accesskey="n" onclick="fun_cert()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="����ƾ֤" align="absmiddle">����ƾ֤</a><a href="#" accesskey="n" onclick="fun_down()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="ƾ֤�б�" align="absmiddle">ƾ֤�б�</a></td>
    </tr>
</table>

<!--������ť����-->
</td>
					 <td align="right" width="40%">
					 	
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 10;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr( request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 


	rs = db.executeQuery(sql); 

	rs.last();                                      //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>


<table border="0" cellspacing="0" cellpadding="0">
  <tr class="maintab">
	<script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav;
	</script>
    <td nowrap>�� <%=intRowCount%> �� / <%=intPageCount%> ҳ 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="��һҳ"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="��һҳ"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="��һҳ" border="0"><% } %>
	�� <font color="red"><%=intPage%></font> ҳ	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="���ҳ" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="��һҳ" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="���ҳ" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>ת�� <input name="page" type="text" size="2" value="1"> ҳ <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="ִ��" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>
</table>

<!--��ҳ���ƽ���-->

<!--
</form>
<form name="list">
-->

<!--����ʼ-->

<div style="vertical-align:top;width:100%;height=100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>�Ƶ�����</th>
	    <th>���</th>
        <th>ƾ֤��</th>
        <th>ժҪ</th>                
        <th>��Ŀ����</th>
		<th>�跽</th>
		<th>����</th>
	    <th>�ͻ�����</th>
        <th>��Ӧ�̱���</th>
        <th>���׺�</th>                
        <th>���</th>
		<th>�·�</th>
		<th>���˳���</th>
	    <th>�к�</th>
        <th>��Ŀ����</th>
        <th>�ͻ����</th>                
        <th>��Ӧ�̼��</th>
		<th>�Է���Ŀ</th>
		<th>��Ŀ</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>

		<td><%= getDBDateStr( rs.getString("create_date") ) %></td>	
		<td><%= getDBStr( rs.getString("evidence_type") ) %></td> 
		<td><%= getDBStr( rs.getString("evidence_number") ) %></td>
		<td><%= getDBStr( rs.getString("evidence_summary") ) %></td>
		<td><%= getDBStr( rs.getString("subject_number") ) %></td>
		<td><%= getDBStr( rs.getString("debit") ) %></td>	
		<td><%= getDBStr( rs.getString("credit") ) %></td> 
		<td><%= getDBStr( rs.getString("client_id") ) %></td>
		<td><%= getDBStr( rs.getString("vndr_id") ) %></td>
		<td><%= getDBStr( rs.getString("acc_set_number") ) %></td>
		<td><%= getDBStr( rs.getString("acc_year") ) %></td>	
		<td><%= getDBStr( rs.getString("acc_month") ) %></td> 
		<td><%= getDBStr( rs.getString("type_number") ) %></td>
		<td><%= getDBStr( rs.getString("line_number") ) %></td>
		<td><%= getDBStr( rs.getString("subject_name") ) %></td>
		<td><%= getDBStr( rs.getString("client_abbr") ) %></td>
		<td><%= getDBStr( rs.getString("vndr_addr") ) %></td>
		<td><%= getDBStr( rs.getString("subject_opposite") ) %></td>
		<td><%= getDBStr( rs.getString("process_name") ) %></td>
      </tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
    </table>
 
</div>


<!--�������-->
   </form>
</body>
</html>
<script language="javascript">
function fun_cert(){
	var downtime = document.forms[0].cert_date.value;
	var style = document.forms[0].process_name.value;
	var message = "";
	message +="��ȷ��ƾ֤����ʱ��\"";
	if(downtime!=""){
		message+=downtime;
	}else{
		message+="ȫ��";
	}
	message+="\"��ƾ֤����\"";
	if(style!=""){
		message+=style
	}else{
		message+="ȫ��";
	}
	message+="\"";
	if(confirm(message)){
		document.forms[0].action="<%=context %>/servlet/DownloadServlet";
		document.forms[0].target="_black";
		document.forms[0].submit();
	}
}
function fun_down(){
	document.forms[0].action="pzxz_download.jsp";
	document.forms[0].target="_black";
	document.forms[0].submit();
}
function fun_search(){
	document.forms[0].action="pzxz_list.jsp";
	document.forms[0].target="_self";
	document.forms[0].submit();
}
</script>
