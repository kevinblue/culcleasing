<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>������ - �ֽ����б�</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//��¼ģ����ѯ
function query(){
	//form1.action = "";
	//document.form1.target = "";
	var start_plan_date = document.getElementById("start_plan_date").value ;
	 var end_plan_date = document.getElementById("end_plan_date").value ;
	// alert(end_plan_date > start_plan_date);
    if((start_plan_date != null && start_plan_date != '')&&(end_plan_date != null && end_plan_date != '')){
    	if(end_plan_date < start_plan_date){
    		alert("�������ڲ���С�ڿ�ʼ����!");
    		return false;
    	}
    }
    var inputs = document.getElementsByTagName("input");
	for(var i = 0;i<inputs.length;i++){
		if(inputs[i].type=="text"){
			if(inputs[i].value.indexOf("\'")>=0){
				alert("�����������Ƿ��ַ�!");
				return false;
			}
		}
	}   	
	form1.submit();
}
//�Ƿ��ַ���֤
function isValidStr(str,name){
    if(str.indexOf("\\") != -1)
    {
       //alert( name+ "���ܰ�����б��\���ţ�");
       return false;
    }
    var ignoreStr="'\"����()<>#$%^&*+";
    for(i=0;i<str.length;i++){
         if(ignoreStr.indexOf(str.substring(i,i+1)) != -1)
         {
            //alert( name+"���ܰ���'��\"��<>#$%^&*+���ŵȷ��ţ����������룡");
            return false;
          }
     }
    return true;
}  
</script>
</head>
<body>
<%
	//Ȩ�޴��� 
	//String dqczy = (String) session.getAttribute("czyid");
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "����֤";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//��ʽ��ʱ��
	String nowDateTime = sdf.format(new Date());//��ǰ��ʽ��֮���ʱ��
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//���л�׼���ʱ�
	String sqlstr = " select * from fund_contract_plan where 1=1  "; 
	//��ȡ��ѯ����
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
	String start_plan_date = getStr(request.getParameter("start_plan_date")); 
	String end_plan_date = getStr(request.getParameter("end_plan_date")); 
	//if(start_plan_date.equals("") || start_plan_date == null){
	//	start_plan_date = nowDateTime;
	//}
	//if(end_plan_date.equals("") || end_plan_date == null){
	//	end_plan_date = nowDateTime;
	//}
	
	if(!contract_id.equals("") && contract_id != null){
		sqlstr = sqlstr + " and  contract_id like '"+contract_id+"'";
	}
	if(!doc_id.equals("") && doc_id != null){
		sqlstr = sqlstr + " and  doc_id like '"+doc_id+"'";
	}
	if(!start_plan_date.equals("") && start_plan_date != null){
		sqlstr = sqlstr + " and  plan_date >= '"+start_plan_date+"' ";
	}
	if(!end_plan_date.equals("") && end_plan_date != null){
		sqlstr = sqlstr + " and  plan_date <= '"+end_plan_date+"' ";
	}
	sqlstr = sqlstr + " order by id";
	System.out.println("sqlstr��ѯsql���==>> "+sqlstr);
%>
<form name="form1" action="zjcs_xjl.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--���⿪ʼ-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	������ &gt; �ֽ����б�
      </td>
    </tr>
    <tr class="maintab">
		<td align="left" colspan="2">               
			&nbsp;��ͬ���/��Ŀ���&nbsp;
			<input type="text" name="contract_id"  value="<%=contract_id%>"/>
			&nbsp;�ĵ����&nbsp;
			<input name="doc_id" type="text" size="15" value="" value="<%=doc_id%>"/>
			&nbsp;������&nbsp;
			<input name="start_plan_date" id="start_plan_date" type="text" value="<%=start_plan_date%>"  
					 dataType="Date" size="13" maxlength="20"  Require="true"  readonly="readonly"/>
				<img  onClick="openCalendar(start_plan_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
			&nbsp;��&nbsp;
			<input name="end_plan_date" id="end_plan_date" type="text" value="<%=end_plan_date%>"  
					 dataType="Date" size="13" maxlength="20"  Require="true"   readonly/>
				<img  onClick="openCalendar(end_plan_date);return false" style="cursor:pointer; " 
				 src="../../images/fdmo_63.gif" width="20" height="19" border="0" align="absmiddle">
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="��ѯ" border="0" align="absmiddle" >
			</a>
       </td>
	</tr>
  </table>
  <!--�������-->
  <!--������Ͳ�������ʼ-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
 
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--��ҳ���ƿ�ʼ-->
<% 
	int intPageSize = 15;   //һҳ��ʾ�ļ�¼��
	int intRowCount = 0;   //��¼����
	int intPageCount = 1; //��ҳ��
	int intPage;       //����ʾҳ��
	String strPage = getStr(request.getParameter("page") );          //ȡ�ô���ʾҳ��
	if( strPage.equals("") ){                                         //������QueryString��û��page��һ����������ʱ��ʾ��һҳ����
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
	rs = db.executeQuery(sqlstr);

	rs.last();                                                  //��ȡ��¼����
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
		var nf = document.form1;
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

<!--��ҳ���ƽ��� style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>��ͬ���/��Ŀ���</th>
	    <th>�ĵ����</th>
	    <th>����</th>
		<th>������</th>
		<th>�������嵥</th>
		<th>������</th>
		<th>�������嵥</th>
		<th>������</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
		<td nowrap align="center"><%=getDBStr(rs.getString("contract_id"))%></td>
		<td nowrap align="center"><%=getDBStr(rs.getString("doc_id"))%></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_in")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_in_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("follow_out")),"#,##0.00")%></td>
		<td align="center"><%=getDBStr(rs.getString("follow_out_detail"))%></td>
		<td nowrap align="center"><%=formatNumberStr(getDBStr(rs.getString("net_follow")),"#,##0.00")%></td>				
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
  

</form>
</body>
</html>
