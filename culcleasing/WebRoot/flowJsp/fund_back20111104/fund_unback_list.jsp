<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ��˿� - ���˿��ʽ�</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function sub_back(){
	//�ж��Ƿ���ѡ��
	var priId = $(":input[name='itemselect']:checked").val();
	var flag = $(":input[name='itemselect']:checked").attr("flag");
	var contrId = $(":input[name='itemselect']:checked").attr("contrId");
	
	if(	priId==undefined || priId==""){
		alert("��ѡ����Ҫ�˿���ʽ�");
	}else if(flag>0){
		alert("���ʽ����������У���ѡ�������ʽ�");
	}else{
		window.open("http://domino.culc.com/ELeasing/ProjectWF/ProjectDFund.nsf/OSNewWorkFlowFromZJTK?openagent&Flow=�˿�����&priId="+priId+"&contractId="+contrId);
	}
}
</script>
</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="fund_unback_list.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		�ʽ��˿�&gt; ���˿��ʽ�</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = "";

//��ҳ��ѯ����
String project_name = getStr( request.getParameter("client_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and project_name like '%" + project_name + "%'";
}

countSql = "select count(id) as amount from vi_Flow_ZJTK_data where 1=1 "+wherestr;

%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<tr>
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="15" value="<%=project_name %>"></td>

<td>
<input type="button" value="��ѯ" onclick="dataNav.submit();">
&nbsp;&nbsp;
<input type="button" value="���" onclick="clearQuery();" >
</td>
</tr>
</table>
</fieldset>
</div>
<!--���۵���ѯ����-->

<!--������Ͳ�������ʼ-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<tr class="maintab">
	<td align="left" width="20%">
	<!--������ť��ʼ-->
	<table border="0" cellspacing="0" cellpadding="0" >    
	    <tr class="maintab">
		    <td><a href="#" accesskey="m" onclick="sub_back()">
		    <img align="absmiddle"  src="../../images/sbtn_mod.gif" alt="�����˿�(Alt+M)" align="absmiddle">�����˿�</a></td>
	    </tr>
	</table>
	<!--������ť����-->
	</td>
	<td align="right" width="60%"><!--��ҳ���ƿ�ʼ-->
	<!-- ��ҳ���ƿ�ʼ -->
	<%@ include file="../../public/pageSplit.jsp"%>
	<!--��ҳ���ƽ���-->	
	</td>		 	
 </tr>
</table>


<!--����ʼ-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
		<th>��Ŀ����</th>
		<th>��ͬ���</th>

        <th>��������</th>
        <th>�ڴ�</th>
        <th>��������</th>
        <th>�ƻ��˿���</th>
        <th>�ƻ��˿���</th>
        <th>�ѳ�ֽ��</th>
        <th>���˿���</th>
        <th>ʣ���˿���</th>
        <th>�տ���</th>
        <th>״̬</th>
      </tr>
      <tbody id="data">
<%
String col_str=" id,project_name,contract_id,fee_type_name,fee_name,fee_num,plan_date,plan_money,rid_money,back_money,curr_plan_money,pay_obj_name,flag ";

sqlstr = "select top "+ intPageSize +" "+col_str+" from vi_Flow_ZJTK_data where id not in( ";
sqlstr += " select top "+ (intPage-1)*intPageSize +" id from vi_Flow_ZJTK_data where 1=1 "+wherestr+" order by contract_id ) "+wherestr ;
sqlstr += " order by contract_id ";

rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td><input class="rd" type="radio" name="itemselect" value="<%=getDBStr( rs.getString("id") ) %>" 
        flag="<%=getDBStr( rs.getString("flag")) %>" contrId="<%=getDBStr( rs.getString("contract_id")) %>"></td>
		<td align="left"><%=getDBStr( rs.getString("project_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("contract_id")) %></td>	

		<td align="center"><%=getDBStr( rs.getString("fee_type_name")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("fee_num")) %></td>	
		<td align="center"><%=getDBStr( rs.getString("fee_name")) %></td>	
		
		<td align="center"><%=getDBDateStr( rs.getString("plan_date")) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("plan_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("rid_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("back_money" )) %></td>	
		<td align="center"><%= CurrencyUtil.convertFinance( rs.getString("curr_plan_money" )) %></td>	
		<td align="center"><%=getDBStr( rs.getString("pay_obj_name")) %></td>	
		<td align="center">
			<font color="blue">
			<%
				String pFl = rs.getString("flag");
				if("0".equals(pFl)){%>
					δ�˿�
				<%}else if("3".equals(pFl)){ %>
					�����
				<%}else if("4".equals(pFl)){ %>
					�˿���
			<%	}
			%>
			</font>
		</td>
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
