<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/headImport.jsp"%>

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />

<!-- 05.002 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��Ŀ������-��ʷ��ѯ</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<!-- ����ֵ -->
<%@ include file="../../public/selectData.jsp"%>
<!-- ����ֵ -->

<!-- ���޹�˾�������̵��ж� -->
<%@ include file="../../public/pageRight.jsp"%>
<!-- ���޹�˾�������̵��ж� -->

<body onload="public_onload(0);">
<form action="super_proj_history_report.jsp" name="dataNav" onSubmit="return goPage()">
<input type="hidden" id="choiceType" name="choiceType">
<input type="hidden" id="sqldata" name="sqldata"><!-- sqldata���� -->

<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0"
	height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			��Ŀ������&gt; ��ʷ��ѯ
		</td>
	</tr>
</table><!--�������-->
<%
ResultSet rs1 = null;
wherestr="";

String dld_name = getStr(request.getParameter("dld_name"));
String cust_name = getStr(request.getParameter("cust_name"));
String proj_id = getStr(request.getParameter("proj_id"));
String zzs = getStr(request.getParameter("zzs"));
String equip_sn = getStr(request.getParameter("equip_sn"));
String end_date = getStr(request.getParameter("end_date"));

if(dld_name!=null && !"".equals(dld_name)){
	wherestr+=" and dld like '%"+dld_name+"%'";
}
if(cust_name!=null && !"".equals(cust_name)){
	wherestr+=" and khmc like '%"+cust_name+"%'";
}
if(proj_id!=null && !"".equals(proj_id)){
	wherestr+=" and proj_id like '%"+proj_id+"%'";
}
if(equip_sn!=null && !"".equals(equip_sn)){
	wherestr+=" and equip_sn like '%"+equip_sn+"%'";
}
if(zzs!=null && !"".equals(zzs)){
	wherestr+=" and manufacturer = '"+zzs+"'";
}

if(end_date!=null && !"".equals(end_date)){
	wherestr+=" and convert(varchar(10),lx_date,21)<='"+end_date+"' ";
}else{
	end_date = getSystemDate(0);
	wherestr+=" and convert(varchar(10),lx_date,21)<='"+end_date+"' ";
}
 
countSql = "select count(id) as amount from vi_sup_proj_his_base where 1=1 "+filterAgent+wherestr;

//����sql
String datasqlstr = filterAgent+wherestr;

%>	
<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="1" cellpadding="0">
<tr>
<td>��&nbsp;��&nbsp;��</td>
<td><input name="dld_name" type="text" size="13" value="<%=dld_name %>"></td>
<td>��Ŀ���</td>
<td><input name="proj_id" type="text" size="13" value="<%=proj_id %>"></td>

<td>��ѯ����&nbsp;
<input name="end_date" type="text" size="12" readonly dataType="Date" value="<%=end_date %>"><img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
<td><input type="button" onclick="dataNav.submit()" value="��ѯ"></td>
</tr>

<tr>
<td>�ͻ�����</td>
<td><input name="cust_name" type="text" size="13" value="<%=cust_name %>"></td>
<td>�������</td>
<td><input name="equip_sn" type="text" size="13" value="<%=equip_sn %>"></td>
<td>�� �� ��&nbsp;
<select name="zzs" style="width:100px;">
 <script>w(mSetOpt('<%=zzs%>',"<%=zzs_str%>"));</script>
</select>
</td>
<td><input type="button" onclick="clearQuery()" value="���"></td>
</tr>

</table>
</fieldset>
</div><!-- ��ѯ�������� -->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">		
		<!--������ť��ʼ-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input type="hidden" name="datasqlstr" value="<%=datasqlstr %>"> 
				<BUTTON class="btn_2"  type="button" onclick="return validata_report_data_exp('super_proj_history_export_save.jsp','super_proj_history_report.jsp');">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����EXCEL</button>
				</td>
				<!--
				<td>
				<BUTTON class="btn_2"  type="button" onclick="return validata_data_exp()">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;����PDF</button>
				</td>
				-->
				 <td>
				<img src="../../images/sbtn_split.gif" width="2" height="14">
				</td>
				<td nowrap>
					<input name="ck_all" style="border:none;" type="checkbox">&nbsp;ҳ��ȫѡ
					<input name="data_ck_all" style="border:none;" type="checkbox">&nbsp;����ȫѡ
				</td><!--������ť����-->
			</tr>
		</table><!--������ť����-->
		</td>

		<td align="right" width="90%">
		<!-- ��ҳ���ƿ�ʼ -->
		<%@ include file="../../public/pageSplit.jsp"%>
		<!--��ҳ���ƽ���-->	 
		</td>
	</tr>
</table><!--������Ͳ���������-->

<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv">
<table border="0" style="border-collapse:collapse;" align="center"
cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
<tr class="maintab_content_table_title">
	<th width="1%"></th>
    <th>���</th>
	<th>����</th>
	<th>������</th>
    <th>��Ŀ���</th>
	<th>�ͻ�����</th>
	
	<th>����������</th>
	<th>������</th>
	<th>����</th>
	<th>�������</th>
	<th>���ܺ�</th>
	<th>̨��</th>

	<th>��������</th>
	<th>��������</th>
	<th>����ȷ������</th>
		
	<th>��������</th>
    <th>�����ﹺ��ۿ�</th>
    <th>�������޶�</th>
    <th>�������</th>
    <th>���ڸ���</th>

	<th>����ܶ�</th>
	<th>�ѻ�������</th>
	<th>�ѻ����</th>
	<th>ʣ���������</th>
	<th>������</th>
	<th>ʣ�౾��</th>
	<th>�������</th>
	<th>��������</th>

	<th>ΥԼ��ϼ�</th>
	<th>����ΥԼ��</th>
	<th>δ��ΥԼ��</th>
	<th>��������</th>
	<th>�ۼ�����</th>
	<!-- 
	<th>״̬</th>
	 -->
</tr>
<tbody id="data">
<%	  
String col_str = " id,qymc,dld,agent_id,proj_id,khmc,prod_id,model_id,equip_sn,bodyno,equip_amount";
col_str+=" ,manufacturer,lease_term,equip_amt,lease_zl_money,status_name";
col_str+=" ,head_ratio,first_payment,total_amt,lx_date,check_date,qz_date";

sqlstr = "select top "+ intPageSize+ col_str +" from vi_sup_proj_his_base where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_sup_proj_his_base where 1=1 "+filterAgent+wherestr+" order by dld,id ) "+filterAgent+wherestr;
sqlstr += " order by dld,id ";

rs = db.executeQuery(sqlstr);
//=========����������=======
String partSql = "";
//========================
String item_id = "";
String projId = "";
String yhqs = "0";//�ѻ�������
String yhzj = "0";//�ѻ����
String syzjqs = "0";//ʣ���������
String syzj = "0";//������
String sybj = "0";//��𱾽�
String yqzj = "0";//�������
String yqts = "0";//��������
String wyjhj = "0";//ΥԼ��ϼ�
String yswyj = "0";//����ΥԼ��
String wswyj = "0";//δ��ΥԼ��
String yqqs = "0";//��������
String ljyq = "0";//�ۼ�����
//==========
int startIndex = (intPage-1)*intPageSize+1;
while ( rs.next() ) {
	item_id = getDBStr( rs.getString("id") );
	projId = getDBStr( rs.getString("proj_id") );
%>
<tr>
	<td><input type="checkbox" name="list" item_id="<%=item_id %>"></td>
	<td align="center"><%=startIndex++ %></td>
	<td align="center"><%=getDBStr(rs.getString("qymc"))%></td>
	<td align="center"><%=getDBStr(rs.getString("dld"))%></td>
	<td align="center">
	<%-- --%>
	<a href="http://online.strongflc.com/Eleasing/PMAgent.nsf/OSShowProjectInfo?openagent&proj_id=<%=projId %>" target="_blank">
	</a>
	<%=projId %>
	</td>
	<td align="center"><%=getDBStr(rs.getString("khmc")) %></td>
	
	<!-- ��������Ϣ -->
	<td align="center"><%=getDBStr(rs.getString("prod_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("manufacturer"))%></td>
	<td align="center"><%=getDBStr(rs.getString("model_id")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_sn")) %></td>
	<td align="center"><%=getDBStr(rs.getString("bodyno")) %></td>
	<td align="center"><%=getDBStr(rs.getString("equip_amount"))%></td>

	<!-- ��Ŀ�������� -->
	<td align="center"><%=getDBDateStr(rs.getString("lx_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("check_date")) %></td>
	<td align="center"><%=getDBDateStr(rs.getString("qz_date")) %></td>
	<td align="center">&gt;&gt;<%=getDBStr(rs.getString("lease_term")) %></td>
	
	<!-- ��Ŀ��� -->
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("equip_amt")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("lease_zl_money")) %></td>
	<td align="center"><%=CurrencyUtil.convertFinance(rs.getDouble("head_ratio"))%></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("first_payment")) %></td>
	<td align="right"><%=CurrencyUtil.convertFinance(rs.getDouble("total_amt")) %></td>
	
	<!-- �������� -->
	<%
		//�ѻ�������
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yhqs = getDBStr( rs1.getString("r") );
		}else {yhqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=yhqs %></td>
	<%
		//�ѻ����
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yhzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yhzj = getDBStr( rs1.getString("r") );
		}else{yhzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yhzj) %></td>
	<%
		//ʣ���������
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzjqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			syzjqs = getDBStr( rs1.getString("r") );
		}else{syzjqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=syzjqs %></td>
	<%
		//ʣ�����
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','syzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			syzj = getDBStr( rs1.getString("r") );
		}else{syzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(syzj) %></td>
	<%
		//ʣ�౾��
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','sybj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			sybj = getDBStr( rs1.getString("r") );
		}else{sybj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(sybj) %></td>
	<%
		//�������
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqzj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqzj = getDBStr( rs1.getString("r") );
		}else{yqzj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yqzj) %></td>
	<%
		//��������
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqts') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqts = getDBStr( rs1.getString("r") );
		}else{yqts = "0";}
		rs1.close();
	%>
	<td align="center"><%=yqts %></td>
	<%
		//ΥԼ��ϼ�
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','wyjhj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			wyjhj = getDBStr( rs1.getString("r") );
		}else{wyjhj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(wyjhj) %></td>
	<%
		//����ΥԼ��
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yswyj') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yswyj = getDBStr( rs1.getString("r") );
		}else{yswyj = "0";}
		rs1.close();
	%>
	<td align="center"><%=CurrencyUtil.convertFinance(yswyj) %></td>
	<%
		//δ��ΥԼ��
		if(wyjhj==null || "".equals(wyjhj)){
			wyjhj = "0";
		}
		if(yswyj==null || "".equals(yswyj)){
			yswyj = "0";
		}
		wswyj = String.valueOf(Double.parseDouble(wyjhj)-Double.parseDouble(yswyj));
	%>
	<td align="center"><%=wswyj %></td>
	<%
		//��������
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','yqqs') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			yqqs = getDBStr( rs1.getString("r") );
		}else{yqqs = "0";}
		rs1.close();
	%>
	<td align="center"><%=yqqs %></td>
	<%
		//�ۼ�����
		partSql = " select dbo.t6_his_cal_tool('"+projId+"','"+end_date+"','ljyq') as r";
		rs1 = db1.executeQuery(partSql);
		if(rs1.next()){
			ljyq = getDBStr( rs1.getString("r") );
		}else{ljyq = "0";}
		rs1.close();
	%>
	<td align="center"><%=ljyq %></td>
</tr>
<% }
rs.close(); 
db.close();
db1.close();
%>  
</tbody></table>
</div><!--�������-->
</form>
</body>
</html>
