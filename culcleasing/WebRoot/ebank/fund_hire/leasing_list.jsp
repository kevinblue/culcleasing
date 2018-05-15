<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�����ʽ��տ��б�(����)</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
//���к���
function validata_hx() {
	//��ȡѡ�е�Id
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var glideId = "";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			glideId = names[i].attributes["fid"].nodeValue;
		}
	}
	
	if(flag_bh==0){
		alert("��ѡ��������տ��!");
		return false;
	}else{
		window.open("leasing_hire.jsp?glideId="+glideId);
	}
}

//����
function validata_bh() {
	//�Ƿ���ѡ�еĵ���
	var names=document.getElementsByName("list");
	var flag_bh=0;
	var str_bh="";//������Ҫ���صĸ����
	var sql_bh_ids="";
	var status= "";
	for(i=0;i<names.length;i++){
		if (names[i].checked){
			flag_bh++;
			var fid= names[i].attributes["fid"].nodeValue;
			status= names[i].attributes["status"].nodeValue;
			str_bh+=fid+",";
			sql_bh_ids+="'"+fid+"',";
		}
	}

	str_bh=str_bh.substring(0,str_bh.length-1);
	sql_bh_ids=sql_bh_ids.substring(0,sql_bh_ids.length-1);
	if (flag_bh==0) {
		alert("��ѡ����Ҫ���ص��տ��!");
		return false;
	}else {
		if(status=="���ֺ���"){
			alert("���ֺ����������أ������������������ݺ�����");
			return false;
		}else if (confirm("���Ƿ�ȷ�ϲ����տ(�տ��:'"+str_bh+"')?")) {
			document.getElementById("savetype").value="bh";
			document.getElementById("sql_bh_ids").value=sql_bh_ids;
			document.dataNav.action="leasing_save.jsp";
			document.dataNav.target="_blank";
			document.dataNav.submit();
			document.dataNav.action="leasing_list.jsp";
			document.dataNav.target="_self";
		}
	}
}
</script>
</head>

<body onload="public_onload(0);">
<form action="leasing_list.jsp" name="dataNav" onSubmit="return goPage()">
<input name="savetype" id="savetype" type="hidden" value="add">
<input name="sid" id="sid" type="hidden">
<input name="sql_bh_ids" id="sql_bh_ids" type="hidden">

<%
String dqczy=(String) session.getAttribute("czyid");
String sqlstr="";
ResultSet rs=null;

if ((dqczy==null) || (dqczy.equals("")))
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

String wherestr=" ";
	
String code = getStr( request.getParameter("code") );

String date_start = getStr( request.getParameter("date_start") );
String date_end = getStr( request.getParameter("date_end") );
	
if ( !code.equals("") ) {
	wherestr += " and glide_id like '%" + code + "%'";
}

if(date_start!=null&&!date_start.equals("")){
	wherestr +=" and convert(varchar(10),plan_date,21)>='"+date_start+"' ";
}
if(date_end!=null&&!date_end.equals("")){
	wherestr +=" and convert(varchar(10),plan_date,21)<='"+date_end+"' ";
}

sqlstr = "select * from vi_apply_info where type='�����ʽ��տ�' and status in('δ����') and isnull(is_sub,'')='���ύ' "+wherestr;
sqlstr+= " order by create_date desc";

%>		
			
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
   <tr>
    <td scope="row">�տ���:</td>
    <td>
  	<input name="code" type="text"  size="13"  value="<%=code %>"   >
    </td>   
    
    <td scope="row">�ύʱ���:</td>
    <td colspan="5"> 
    <input name="date_start" type="text"  size="10"  value="<%=date_start %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(date_start);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
     -
    <input name="date_end" type="text"  size="10"  value="<%=date_end %>"   readonly  dataType="Date">
     <img  onClick="openCalendar(date_end);return false" style="cursor:pointer; " 
     src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
	</td>
	<td>
	     <input type="button" value="��ѯ" onclick="dataNav.submit();">&nbsp;&nbsp;
		 <input type="button" value="���" onclick="clearQuery();">
	</td>
  </tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			�����ʽ��տ��б�
		</td>
	</tr>
</table>
<!--�������-->


<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
			<BUTTON class="btn_2" id="hx" name="btnHire" value="����"  type="button" onclick="validata_hx();">
			<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;�����������ݺ���</button>
			</td>
			<td>								
			 <BUTTON class="btn_2" name="btnBh" value="����"  type="button" onclick="validata_bh();">
			 <img src="../../images/hg.gif" align="absmiddle" border="0">&nbsp;����</button>
			</td>
			<td>
			</td>
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			</td>
		</tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="90%">
	<!--��ҳ���ƿ�ʼ-->
	<%@ include file="../../public/pageSplitNoCode.jsp" %>
	<!--��ҳ���ƽ���-->
	</td>
</tr>
</table>

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;height:80%;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
	class="maintab_content_table">
<tr class="maintab_content_table_title"> 
     <th width="1%"></th> 			 						
	 <th>�տ��</th>
	 <th>����</th>
	 <th width='80'>�տ���</th>
	 <th>�ύ����</th>
	 <th>ȷ��״̬</th>
			 
</tr>
<tbody id="data">
<%	  
rs.previous();
if ( rs.next() ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	//�����,Ӧ�ս��,ʵ�ս��,ʵ������,
	String fid=getDBStr(rs.getString("glide_id"));
%>
	<tr>				
		<td>
			<input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("glide_id"))%>" fid="<%=fid %>" status="<%=getDBStr(rs.getString("status")) %>">
		</td>

		<td align="center">
		<a href="leasing.jsp?fact_date=&czid=<%=getDBStr(rs.getString("glide_id"))%>" target="_blank">
		<%=getDBStr(rs.getString("glide_id"))%></a>
		</td>
		<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount")) %></td>
		<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("amt")) %></td>
		<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
		<td align="center"><%=getDBStr(rs.getString("status")) %></td>
	</tr>
<%
		rs.next();
		i++;
	}
}
rs.close(); 
db.close();
%>
</tbody>
</table>
</div><!--�������-->
</form>
</body>
</html>

