<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�ʽ��ո��ƻ�����ͬ��</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">

</head>

<!-- �������� -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- �������� -->

<body onload="public_onload(0);">

<form action="people_transfer_zjjh_to_yy.jsp" name="dataNav" onSubmit="return goPage()">
<!--���⿪ʼ-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
		�ʽ��ո��ƻ�����ͬ��</td>
	</tr>
</table>
<!--�������-->

<%
wherestr = "";

//��ҳ��ѯ����
String project_name = getStr( request.getParameter("project_name") );

if ( project_name!=null && !"".equals(project_name) ) {
	wherestr += " and vfp.pcode like '%" + project_name + "%'";
}

String proj_id = getStr( request.getParameter("proj_id") );

if ( proj_id!=null && !"".equals(proj_id) ) {
	wherestr += " and vfp.picode like '%" + proj_id + "%'";
}

String start_date = getStr(request.getParameter("start_date"));//�����ֶ�
String end_date = getStr(request.getParameter("end_date"));//�����ֶ�
if(start_date!=null && !"".equals(start_date) && end_date!=null && !"".equals(end_date)){
	wherestr += " and convert(varchar(10),vfp.odate,21)>='"+start_date+"'";
	wherestr += " and convert(varchar(10),vfp.odate,21)<='"+end_date+"'";
	System.out.println("start_date����" + start_date);
}
countSql = "select count(vfp.id) as amount from vi_INTERFACE_fina_global_fundplan_nc vfp where 1=1 and vfp.odate>='2017-07-01' "+wherestr;
//ʣ����>0
%>

<!--���۵���ѯ��ʼ-->
<div style="width:100%;" id="queryArea">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;��ѯ����
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="��ʾ/��������">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">
<td>��Ŀ����:&nbsp;<input name="project_name"  type="text" size="30" value="<%=project_name %>"></td>
<td>��Ŀ���:&nbsp;<input name="proj_id"  type="text" size="30" value="<%=proj_id %>"></td>

<td>���ڲ�ѯ:&nbsp;<input name="start_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;��&nbsp;
<input name="end_date" type="text" size="10" readonly dataType="Date"><span class="biTian">*</span>
<img  onClick="openCalendar(end_date);return false" style="cursor:pointer; " 
src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
</td>
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
	    <th>���</th>
        <th>��Ŀ���</th>	 	
	 	<th>��ͬ��</th>
	 	<th>��Ŀ����</th>
	 	 <th>��������</th>
	    <th>����ͻ�</th>
	    <th>��/������</th>
	    <th>��������</th>
	    <th>˰��</th>
		<th>���</th>
		<th>�ƻ�����</th>
		<th>ͬ��</th>             
      </tr>
      <tbody id="data">
<%
String col_str="id,ccodetrust,picode,ccode,remark,bcode,leas_type,remark_o,pcode,ordcode,rmb,odate,nccode,nc_deptno";
int i=1;
sqlstr = "SELECT top "+ intPageSize +" "+col_str+" FROM vi_INTERFACE_fina_global_fundplan_nc vfp WHERE vfp.odate>='2017-07-01' and  vfp.id not in(select top "+ (intPage-1)*intPageSize +" vfp.id from vi_INTERFACE_fina_global_fundplan_nc vfp  where 1=1 and vfp.odate>='2017-07-01' "+wherestr+"  )  ";
sqlstr += "and isnull(invcode,'')<>'' AND isnull(ccode,'')<>'' AND isnull(ccodetrust,'')<>''  and isnull(bcode,'')<>'' and isnull(invtype,'')<>'' and ccodetrust<>'null'"+wherestr;
rs = db.executeQuery(sqlstr);
while ( rs.next() ) {
%>
      <tr>
        <td align="center"><%=i%></td>
         <td align="left"><%=getDBStr(rs.getString("picode"))%></td>
         <td align="left"><%=getDBStr(rs.getString("ordcode"))%></td>
         <td align="left"><%=getDBStr(rs.getString("pcode"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("leas_type"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("ccodetrust"))%></td>
		 <td align="left"><%=getDBStr(rs.getString("bcode"))%></td>	
         <td align="left"><%=getDBStr(rs.getString("remark"))%></td>
         <td align="left"><%=getDBStr(rs.getString("remark_o"))%></td>        			
		 <td align="left"><%=getDBStr(rs.getString("rmb"))%></td>
		 <td align="left"><%=getDBStr(rs.getString("odate"))%></td>
		 <td align="left">
			<a href='fundplan_info_add.jsp?proj_id=<%=getDBStr(rs.getString("picode"))%>&id=<%=getDBStr(rs.getString("id"))%>' target="_blank">
	    <img src="../../images/sbtn_quick_up.gif" align="bottom" border="0">����ִ��ͬ��</a>
     	<a href=""></a>
		 </td>
      </tr>
<%
i++;
}
rs.close(); 
db.close();
%>
</tbody></table>
</div><!--�������-->

</form>
</body>
</html>
