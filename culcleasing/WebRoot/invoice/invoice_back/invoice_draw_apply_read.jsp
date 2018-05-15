<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Ʊ�ݹ��� - Ʊ�����˻��б�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

<script type="text/javascript">	
//ɾ��ʱ
function validate_del() {
	var fpId = $(":radio[name='list']:checked").val();
	if(fpId==undefined){
		alert("��ѡ����Ҫɾ���ķ�Ʊ�˻����뵥!");
		return false;
	}else{
		if (confirm("���Ƿ�ȷ��ɾ����Ʊ�˻����뵥(���뵥��:'"+fpId+"')?")) {
			window.open("apply_save_del.jsp?savetype=del&sql_ids="+fpId);
		}
	}
}

//�޸�ʱ
function validate_mod() {
	//�Ƿ���ѡ�еĸ����
	var fpId = $(":radio[name='list']:checked").val();
	if(fpId==undefined){
		alert("��ѡ�����뵥�Ž��в�����");
		return false;
	}else{
		window.open("apply_mod.jsp?fpId="+fpId);
	}
	
}
	
//�ύʱ
function validate_sub() {
	//�Ƿ���ѡ�еĸ����
	var fpId = $(":radio[name='list']:checked").val();
	var fpAmount = $(":radio[name='list']:checked").attr("fpAmount");
	
	if(fpId==undefined){
		alert("��ѡ����Ҫ�ύ�ķ�Ʊ�˻����뵥!");
		return false;
	}else{
		if(fpAmount==0){
			alert("��Ҫ�ύ�ķ�Ʊ�˻����뵥��Ʊ��Ŀ����Ϊ0�����޸ĺ��ύ��");
			return false;
		}
		if (confirm("���Ƿ�ȷ���ύ��Ʊ�˻����뵥(���뵥��:'"+fpId+"')?")) {
			window.open("apply_save_del.jsp?savetype=sub&sql_ids="+fpId);
		}
	}
}
</script>		
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">
<form action="invoice_draw_apply.jsp" name="dataNav" onSubmit="return goPage()">

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			Ʊ�ݹ��� - ��Ʊ�˻��б�
		</td>
	</tr>
</table><!--�������-->

<%
if ( dqczy.equals("ADMN-WUSESSION") )
{
  dqczy="����֤";
  response.sendRedirect("../../noright.jsp");
}

wherestr=" and status in('���˻�') and type='��Ʊ�˻�' and isnull(is_sub,'')='���ύ' and creator='"+dqczy+"' ";

countSql = "select count(id) as amount from invoice_draw_info_t where 1=1 "+wherestr;

//LogWriter.logDebug("Sql-----apply_list.jsp--"+sqlstr);
%>

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
	<td align="left" width="1%">
		<!--������ť��ʼ
		
		<table border="0" cellspacing="0" cellpadding="0">
		<tr class="maintab">
			<td nowrap>
				<BUTTON class="btn_2" name="btnAdd" value="����"  type="button" onclick="dataHander('add','apply_add_save.jsp',dataNav.itemselect);">
				<img src="../../images/sbtn_new.gif" align="absmiddle" border="0">&nbsp;����</button>
			</td>
			
			<td>
				<BUTTON class="btn_2" name="btnmod" value="�޸�"  type="button" onclick="validate_mod();">
				<img src="../../images/sbtn_mod.gif" align="absmiddle" border="0">&nbsp;�޸�</button>
			</td>
			
			<td>
				<BUTTON class="btn_2" name="btndel" value="ɾ��"  type="button" onclick="validate_del();">
				<img src="../../images/sbtn_del.gif" align="absmiddle" border="0">&nbsp;ɾ��</button>
			</td>
			
			<td>
				<BUTTON class="btn_2" name="btndel" value="�ύ"  type="button" onclick="validate_sub();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;�ύ</button>
			</td>
			<td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
			</td>
			<td nowrap>
			</td>
		</tr>
		</table>-->
		<!--������ť����-->
	</td>
	<td align="right" width="90%">
	<!--��ҳ���ƿ�ʼ-->
	<%@ include file="../../public/pageSplit.jsp"%>
	</td><!--��ҳ���ƽ���-->	
	</tr>
</table>

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
	<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%"
		class="maintab_content_table">
		<tr class="maintab_content_table_title">
			 <th width="1%"></th> 			 						
			 <th>���뵥��</th>
			 <th>�˻ط�Ʊ����</th>
			 <th>�ʽ�Ʊ</th>
			 <th>��Ϣ��Ʊ</th>
			 <th>�����Ϣ��Ʊ</th>
			 
			 <th>������</th>
			 <th>�ύ����</th>
			 <th>ȷ��״̬</th>
		</tr>
<tbody id="data">
<%	  

String col_str=" ci.*,apply_p=dbo.getUserName(ci.creator) ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from invoice_draw_info_t ci where ci.id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from invoice_draw_info_t where 1=1 "+wherestr+" order by create_date desc ) "+wherestr ;
sqlstr += " order by create_date desc ";

LogWriter.logDebug(request, "####�������Ͻ���#####"+sqlstr);
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
		<tr>
			<td><input type="radio" name="list" style="border: none;" value="<%=getDBStr(rs.getString("glide_id"))%>" 
			fpAmount="<%=getDBStr(rs.getString("amount_t"))%>"></td>	
			<td align="center">
			<a href="apply.jsp?fpId=<%=getDBStr(rs.getString("glide_id"))%>" target="_blank">
			<%=getDBStr(rs.getString("glide_id"))%></a>
			</td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_t")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_zj")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_fx")) %></td>
			<td align="center"><%=CurrencyUtil.convertIntAmount(rs.getDouble("amount_lx")) %></td>
			<td align="center"><%=getDBStr(rs.getString("apply_p")) %></td>
			
			<td align="center"><%=getDBDateStr(rs.getString("plan_date")) %></td>
			<td align="center"><%=getDBStr(rs.getString("status")) %></td>
		</tr>
<%
}
rs.close(); 
db.close();
%>
	</tbody></table>
</div><!--�������-->

</form>
</body>
</html>

