<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="dbconn.*,com.service.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<%@ include file="../../func/sms_common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<%
String dqczy=(String) session.getAttribute("czyid");
if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

int canedit=0;
if (right.CheckRight("sms-smstest-list",dqczy)>0) canedit=1;
if (canedit==0) response.sendRedirect("../../noright.jsp");

//----------����ΪȨ�޿���--------
String context = request.getContextPath();
SMSThread sms = (SMSThread)session.getAttribute("thread");
String searchKey = getStr(request.getParameter("searchKey"));
String searchType = getStr(request.getParameter("searchType"));
String searchDel = getStr(request.getParameter("searchDel"));
String searchPhone = getStr(request.getParameter("searchPhone"));
//String searchAddTime = getStr(request.getParameter("searchAddTime"));
//[START]
String searchAddTimeBegin = getStr(request.getParameter("searchAddTimeBegin"));
String searchAddTimeEnd = getStr(request.getParameter("searchAddTimeEnd"));
//[END]
//String searchActualTime = getStr(request.getParameter("searchActualTime"));
//[START]
String searchActualTimeBegin = getStr(request.getParameter("searchActualTimeBegin"));
String searchActualTimeEnd = getStr(request.getParameter("searchActualTimeEnd"));
//[END]
//String searchPerformTime = getStr(request.getParameter("searchPerformTime"));
//[START]
String searchPerformTimeBegin = getStr(request.getParameter("searchPerformTimeBegin"));
String searchPerformTimeEnd = getStr(request.getParameter("searchPerformTimeEnd"));
if(sms!=null){
if(!sms.isAlive()){
 %>
 
 <script language="javascript">
 alert("���ŷ������");
 </script>
 <%session.setAttribute("thread",null);

 }else{
 %>
 <META HTTP-EQUIV="refresh" CONTENT="5;URL=./sms_list.jsp?searchKey=<%=searchKey %>&searchType=<%=searchType %>&searchPhone=<%=searchPhone %>&searchAddTimeBegin=<%=searchAddTimeBegin %>&searchAddTimeEnd=<%=searchAddTimeEnd %>&searchActualTimeBegin=<%=searchActualTimeBegin %>&searchActualTimeEnd=<%=searchActualTimeEnd %>&searchPerformTimeBegin=<%=searchPerformTimeBegin %>&searchPerformTimeEnd=<%=searchPerformTimeEnd %>">
 <%
 }} %>
<title>���ŷ���ƽ̨ - ���ŷ���ƽ̨</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body style="border:1px solid #8DB2E3;">
<form action="sms_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
				���ŷ���ƽ̨ &gt; ���ŷ���ƽ̨</td>
			</tr>
</table>
<!--�������-->
<%
ResultSet rs = null;
String sql = "";
String strwhere = "";
strwhere=" where 1=1 ";

//[END]
if(searchKey!=null&&!searchKey.equals("")){
	if(searchKey.equals("ȫ��")){
	
	}else if(searchKey.equals("������")){
		strwhere +=" and perform_flag<=0 ";
	}else if(searchKey.equals("�ѷ��ͳɹ�")){
		strwhere +=" and perform_flag>0 ";
	}else if(searchKey.equals("������")){
		strwhere +=" and perform_flag=0 and perform_time is not null and actual_time is null ";
	}else if(searchKey.equals("����ʧ��")){
		strwhere +=" and perform_flag<0 ";
	}else if(searchKey.equals("δ����")){
		strwhere +=" and perform_flag=0 and perform_time is null";
	}
}else{
	searchKey = "������";
	strwhere +=" and perform_flag<=0 ";
}
if(searchType!=null&&!searchType.equals("")){
	strwhere +=" and type='"+searchType+"'";
}
if(searchDel!=null&&!searchDel.equals("")){
 	if(!searchDel.equals("-1")){
		strwhere +=" and delete_flag='"+searchDel+"'";
	}
}else{
	searchDel="��Ч";
	strwhere +=" and delete_flag='0'";
}
if(searchPhone!=null&&!searchPhone.equals("")){
	strwhere +=" and mobile_phone like '%"+searchPhone+"%'";
}
//if(searchAddTime!=null&&!searchAddTime.equals("")){
//	strwhere +=" and convert(char(10),add_time,21) = '"+searchAddTime+"'";
//}
//ѡ�����ʱ�䷶Χ [START]
if(searchAddTimeBegin!=null&&!searchAddTimeBegin.equals("")){
	strwhere +=" and convert(char(10),add_time,21) >= '"+searchAddTimeBegin+"'";
}
if(searchAddTimeEnd!=null&&!searchAddTimeEnd.equals("")){
	strwhere +=" and convert(char(10),add_time,21) <= '"+searchAddTimeEnd+"'";
}
//ѡ�����ʱ�䷶Χ [END]

//if(searchActualTime!=null&&!searchActualTime.equals("")){
//	strwhere +=" and convert(char(10),actual_time,21) = '"+searchActualTime+"'";
//}
//ѡ��ʵ�ʷ���ʱ�䷶Χ [START]
if(searchActualTimeBegin!=null&&!searchActualTimeBegin.equals("")){
	strwhere +=" and convert(char(10),actual_time,21) >= '"+searchActualTimeBegin+"'";
}
if(searchActualTimeEnd!=null&&!searchActualTimeEnd.equals("")){
	strwhere +=" and convert(char(10),actual_time,21) <= '"+searchActualTimeEnd+"'";
}
//ѡ��ʵ�ʷ���ʱ�䷶Χ [END]
//if(searchPerformTime!=null&&!searchPerformTime.equals("")){
//	strwhere +=" and convert(char(10),perform_time,21) = '"+searchPerformTime+"'";
//}
//ѡ����ʱ�䷶Χ [START]
if(searchPerformTimeBegin!=null&&!searchPerformTimeBegin.equals("")){
	strwhere +=" and convert(char(10),perform_time,21) >= '"+searchPerformTimeBegin+"'";
}
if(searchPerformTimeEnd!=null&&!searchPerformTimeEnd.equals("")){
	strwhere +=" and convert(char(10),perform_time,21) <= '"+searchPerformTimeEnd+"'";
}
//ѡ����ʱ�䷶Χ [END]
strwhere +=" order by id desc";
sql = "select * from sms_info "+strwhere;

//
String strType = "";
String sqlType = "select distinct type from sms_info";
System.out.println(sqlType);
ResultSet rsType = db.executeQuery(sqlType);
while(rsType.next()){
	strType +="|"+getDBStr(rsType.getString("type"));
}
%>
					 	
<!--��ҳ���ƿ�ʼ-->


<% 
	int intPageSize = 800;   //һҳ��ʾ�ļ�¼��
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

System.out.println(sql);;
rs = db.executeQuery(sql); 

	rs.last();                                      //��ȡ��¼����
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //������ҳ��
	if( intPage > intPageCount ) intPage = intPageCount;            //��������ʾ��ҳ��
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //����¼ָ�붨λ������ʾҳ�ĵ�һ����¼��
	int i = 0;
	
%>
<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab">
				<td colspan="2">
					&nbsp;&nbsp;<select name="searchKey"><script>w(mSetOpt('<%=searchKey%>',"ȫ��|�ѷ��ͳɹ�|������|������|δ����|����ʧ��"));</script></select>
			    	����:<select name="searchType"><script>w(mSetOpt('<%=searchType%>',"<%=strType%>"));</script></select>
			    	<select name="searchDel"><script>w(mSetOpt('<%=searchDel%>',"ȫ��|��Ч|����","-1|0|1"));</script></select>
			    	�ֻ��ţ�<input type="text" size="12" name="searchPhone" value="<%=searchPhone %>">
			    	���ʱ��:<input type="text" size="10" name="searchAddTimeBegin" value="<%=searchAddTimeBegin %>"><img  onClick="openCalendar(searchAddTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
			    	<input type="text" size="10" name="searchAddTimeEnd" value="<%=searchAddTimeEnd %>"><img  onClick="openCalendar(searchAddTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				</td>
			</tr>
			<tr class="maintab">
				<td colspan="2">
				����ʱ��:<input type="text" size="10" name="searchPerformTimeBegin" value="<%=searchPerformTimeBegin %>"><img  onClick="openCalendar(searchPerformTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
				<input type="text" size="10" name="searchPerformTimeEnd" value="<%=searchPerformTimeEnd %>"><img  onClick="openCalendar(searchPerformTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
				
			    	ʵ�ʷ���ʱ��:<input type="text" size="10" name="searchActualTimeBegin" value="<%=searchActualTimeBegin %>"><img  onClick="openCalendar(searchActualTimeBegin);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">-
			    	<input type="text" size="10" name="searchActualTimeEnd" value="<%=searchActualTimeEnd %>"><img  onClick="openCalendar(searchActualTimeEnd);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
			    	<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="��ѯ" align="absmiddle"  onclick="forms[0].submit();">
				</td>
			</tr>
			<tr class="maintab">
				<td align="left" width="50%">
					 




<!--������ť��ʼ-->
<table border="0" cellspacing="0" cellpadding="0" >    
    <tr class="maintab">
		<%if (right.CheckRight("sms-smstest-send",dqczy)>0) {%>
		<td><a href="#" accesskey="n" onclick="fun_smssend()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="���Ͷ���" align="absmiddle">���Ͷ���</a> </td>
		<%}%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="fun_refresh()"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="ˢ��" align="absmiddle">ˢ��</a></td>
		<%if (right.CheckRight("sms-smstest-add",dqczy)>0) {%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="dataHander('add','sms_add.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="����" align="absmiddle">����</a></td>
		<%}%>
		
		<%if (right.CheckRight("sms-smstest-info",dqczy)>0) {%>
		<td> &nbsp;&nbsp;<a href="#" accesskey="n" onclick="dataHander('add','sms_info.jsp',dataNav.itemselect);"><img align="absmiddle"  src="../../images/sbtn_new.gif" alt="�ɷ��Ͷ�������" align="absmiddle">�ɷ��Ͷ�������</a></td>
		<%}%>
    	<td>&nbsp;&nbsp;<%if(sms!=null){
if(!sms.isAlive()){ %>���ŷ�����ɣ���쿴�ѷ��Ͷ��ż�¼<%}else{%>��ǰ�� <%=intRowCount%> ����¼δ����<%}} %></td>
    </tr>
</table>

<!--������ť����-->
</td>
					 <td align="right" width="40%">
					 	



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
<input type="hidden" name="czid">
<input type="hidden" name="del_flag">
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      
      <tr class="maintab_content_table_title">
	    <th>���ͺ���</th>
	    <th>������Ϣ</th>
	    <th>���ʱ��</th>
	    <th>����ʱ��</th>
	    <th>ʵ�ʷ���ʱ��</th>
	    <th>����</th>
	    <th>��Ч/����</th>
	    <th>������־</th>
      </tr>
  

<%	  

if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>

      <tr>

		<td><%= getDBStr( rs.getString("mobile_phone") ) %></td>	
		<td><%= smsReplace(getDBStr( rs.getString("sms_message") )) %></td>
		<td><%= getDBStr( rs.getString("add_time")) %></td>
		<td><%= getDBStr( rs.getString("perform_time")) %></td>
		<td><%= getDBStr( rs.getString("actual_time")) %></td>
		<td><%= getDBStr( rs.getString("type")) %></td>
		<td><%if( getDBStr( rs.getString("delete_flag")).equals("0")){ %><a href="#" onclick="fun_del('<%=getDBStr( rs.getString("id")) %>')"><span title="����Ϊ����">��Ч</span></a><%}else{ %><a href="#" onclick="fun_use('<%=getDBStr( rs.getString("id")) %>')"><span title="����Ϊ��Ч">����</span></a><%} %></td>
		<td><%int flag = rs.getInt("perform_flag");%><% if(flag>0){ %>���ͳɹ�<%}else if(flag<0){ %>����ʧ��<%}else if(flag==0&&!getDBStr( rs.getString("perform_time")).equals("")){ %>������<%}else if(flag==0&&getDBStr( rs.getString("perform_time")).equals("")){ %>δ����<%} %></td>
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

</html>
<script language="javascript">
function fun_smssend(){
	if(confirm("ȷʵҪ���Ͷ���")){
		alert("�벻Ҫ�رյ�ǰҳ�棬���ŷ��ͽ�����쿴ϵͳ��ʾ");
		document.forms[0].action="sms_send.jsp";
		document.forms[0].submit();
	}
}
function fun_refresh(){
	document.forms[0].action="sms_list.jsp";
	document.forms[0].submit();
}
function fun_del(id){
	if(confirm("ȷʵҪ����¼����")){
		document.forms[0].action="sms_del.jsp";
		document.forms[0].target="_black";
		document.forms[0].czid.value=id;
		document.forms[0].del_flag.value=1;
		document.forms[0].submit();
		
	}
}
function fun_use(id){
	if(confirm("ȷʵҪ����¼��Ч")){
		document.forms[0].action="sms_del.jsp";
		document.forms[0].target="_black";
		document.forms[0].czid.value=id;
		document.forms[0].del_flag.value=0;
		document.forms[0].submit();
		
	}
}
</script>
