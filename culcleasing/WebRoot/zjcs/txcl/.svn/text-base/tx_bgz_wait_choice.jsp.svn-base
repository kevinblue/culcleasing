<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>调息管理－－(不规则)项目列表</title>
<link href="../../css/main.css" type="text/css" rel="stylesheet" >
<script language="javascript" src="/dict/js/js_dictionary.js"></script>

<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/delitem.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<body onload="public_onload(0);">
<%
	String czid = getStr(request.getParameter("czid"));
	String proj_id = getStr(request.getParameter("proj_id"));
	String dld = getStr(request.getParameter("dld"));
	String zzs = getStr(request.getParameter("zzs"));
	String lease_term = getStr(request.getParameter("lease_term"));
	String start_qrdate = getStr(request.getParameter("start_qrdate"));
	String end_qrdate = getStr(request.getParameter("end_qrdate"));
	String nll = getStr(request.getParameter("nll"));
	
	String sqlstr = "";
	ResultSet rs = null;
	String start_date="";
	sqlstr="select * from base_adjust_interest where id='"+czid+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_date=getDBDateStr(rs.getString("start_date"));
	}rs.close();
	// where adjust_id='"+czid+"'
	String wherestr=" where proj_status=20 and method='否' and proj_id not in(select proj_id from adjust_interest_proj where adjust_id='"+czid+"') and proj_id in(select proj_id from fund_rent_plan where plan_status='0' and plan_date>'"+start_date+"')";
	if(!proj_id.equals("")){
		wherestr+=" and proj_id like '%"+proj_id+"%'";
	}
	if(!lease_term.equals("")){
		wherestr+=" and lease_term='"+lease_term+"'";
	}
	if(!dld.equals("")){
		wherestr+=" and dld like '%"+dld+"%'";
	}
	if(!zzs.equals("")){
		wherestr+=" and manufacturer like '%"+zzs+"%'";
	}
    if(start_qrdate!=null && !"".equals(start_qrdate)){
		wherestr+=" and convert(varchar(10),qz_date,21)>='"+start_qrdate+"' ";
	}
	if(end_qrdate!=null && !"".equals(end_qrdate)){
		wherestr+=" and convert(varchar(10),qz_date,21)<='"+end_qrdate+"' ";
	}
	if(nll!=null && !"".equals(nll)){
		wherestr+=" and (select year_rate from proj_condition where proj_id=vi_proj_base_info.proj_id)='"+nll+"' ";
	}else{
		wherestr+=" and 1=2";	
	}
	
	//sqlstr="select proj_info.*,vi_cust_all_info.cust_name from proj_info left join vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id";
	sqlstr=" select proj_id,dld,khmc,lease_term,(select year_rate from proj_condition where proj_id=vi_proj_base_info.proj_id) as year_rate,qz_date from vi_proj_base_info"+wherestr;
	sqlstr+=" order by lease_term asc";
	System.out.println("sqlstr-wait-choice===================="+sqlstr);
	
	String exesqlstr="select proj_id '项目编号',dld '代理商',khmc '客户名称',lease_term '租赁期限',prod_id '租赁物类型',manufacturer '制造商',";
	exesqlstr+=" (select year_rate from proj_condition where proj_id=vi_proj_base_info.proj_id) '年利率',qz_date '起租确认日期' from vi_proj_base_info ";
	exesqlstr+=" where proj_status=20 and method='否' and proj_id not in(select proj_id from adjust_interest_proj where adjust_id='"+czid+"') and proj_id in(select proj_id from fund_rent_plan where plan_status='0' and plan_date>'"+start_date+"')";
	
	if(!proj_id.equals("")){
		exesqlstr+=" and proj_id like '%"+proj_id+"%'";
	}
	if(!lease_term.equals("")){
		exesqlstr+=" and lease_term='"+lease_term+"'";
	}
	if(!dld.equals("")){
		exesqlstr+=" and dld like '%"+dld+"%'";
	}
	if(!zzs.equals("")){
		exesqlstr+=" and manufacturer like '%"+zzs+"%'";
	}
    if(start_qrdate!=null && !"".equals(start_qrdate)){
    	exesqlstr+=" and convert(varchar(10),qz_date,21)>='"+start_qrdate+"' ";
	}
	if(end_qrdate!=null && !"".equals(end_qrdate)){
		exesqlstr+=" and convert(varchar(10),qz_date,21)<='"+end_qrdate+"' ";
	}
	if(nll!=null && !"".equals(nll)){
		exesqlstr+=" and (select year_rate from proj_condition where proj_id=vi_proj_base_info.proj_id)='"+nll+"' ";
	}
%>


<div class="divCBox"  id="dataList" style="padding:0px" >
<div id="cwCellContent">
<form name="list" action="tx_bgz_wait_choice_save.jsp" method="post" target="_blank">
<input type="hidden" name="czid" value="<%=czid%>">
<input type="hidden" name="xmidstr" value="">

<!--可折叠查询开始-->
<div style="width:100%;">
<fieldset style="width:100%;TEXT-ALIGN:center;margin:0px 5px 0px 5px;"> 
  <legend>&nbsp;高级操作
<img name="Changeicon" border="0" src="../../images/jt_b.gif" onclick="javascript:fieldsetHidden();" style="cursor:hand" title="显示/隐藏内容">&nbsp;
</legend>
<table border="0" width="100%" cellspacing="5" cellpadding="0">

<tr>
<td>项目名称<input name="proj_id" type="text"  size="12" value="<%=proj_id %>">
&nbsp;&nbsp;
租赁期限<input name="lease_term" type="text"  size="12" value="<%=lease_term %>">
&nbsp;&nbsp;
代理商<input name="dld" type="text"  size="12" value="<%=dld %>">
&nbsp;&nbsp;
年利率<input name="nll" type="text"  size="8" value="<%=nll %>">
&nbsp;&nbsp;
制造商<input name="zzs" type="text"  size="12" value="<%=zzs %>">
&nbsp;&nbsp;
起租确认日:
<input name="start_qrdate" type="text" size="10" readonly dataType="Date">
<img  onClick="openCalendar(start_qrdate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
-至-
<input name="end_qrdate" type="text" size="10" readonly dataType="Date" >
<img  onClick="openCalendar(end_qrdate);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
&nbsp;&nbsp;
<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" onclick="xx_submit();"></td>
</tr>
</table>
</fieldset>
</div>

<!--副标题和操作区开始-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="1%">
		<!--操作按钮开始-->
		<table border="0" cellspacing="0" cellpadding="0" >    
			<tr class="maintab">
				<td>
				<input name="expsqlstr" type="hidden" value="<%=exesqlstr %>">
				<BUTTON class="btn_2"  type="button" onclick="return exportData();">
				<img src="../../images/save.gif" align="absmiddle" border="0">&nbsp;导出EXCEL</button>
				</td>
			</tr>
		</table><!--操作按钮结束-->
		</td>
	</tr>
</table>

<!--可折叠查询结束-->
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="cTable">
  <tr class="cwDLHead">
   <th width="1%" height="25" nowrap><input name="itemselectall" type="checkbox" class="rd" value="" title="全选" onpropertychange="selectAllItems(list.itemselect)"></th>
	 <th nowrap>项目编号</th>
	 <th nowrap>代理商</th>
	 <th nowrap>客户名称</th>
	 <th nowrap>租赁期限</th>
	 <th nowrap>年利率</th>
	 <th nowrap>起租确认日期</th>
  </tr>
<%
	
	rs = db.executeQuery(sqlstr);
	while (rs.next()) {
%>
  <tr class="cwDLRow" >
  
      <td nowrap><input class="rd" type="checkbox" name="itemselect" value="<%=getDBStr(rs.getString("proj_id"))%>"></td>
      <td nowrap><%=getDBStr(rs.getString("proj_id"))%></td>
      <td nowrap><%=getDBStr(rs.getString("dld"))%></td>
      <td nowrap><%=getDBStr(rs.getString("khmc"))%></td>
      <td nowrap><%=getDBStr(rs.getString("lease_term"))%></td>
      <td nowrap><%=getDBStr(rs.getString("year_rate"))%></td>
      <td nowrap><%=getDBDateStr(rs.getString("qz_date"))%></td>
  </tr>
<%
	}
	rs.close();
	db.close();
%>
</table>
</form>
</div>
</div>

<div class="listInfo">
</div>
</body>
</html>
<script language="javascript">
function exportData(){
	if(confirm("是否导出为excel？")){
		list.action="../../func/exp_report.jsp";
		list.target="_blank";
		list.submit();
		list.action="tw_bgz_wait_choice.jsp";
		list.target="_self";
	}
}

function selectAllItems(items){
	//var items= document.all.itemselect;
	if(items==undefined)return;
	if (items.length==undefined){
		items.checked=event.srcElement.checked;
	}
	for(i=0;i<items.length;i++){
		items[i].checked=event.srcElement.checked;
	}
	
}
function addxm(){ 
  	var arrCB=document.getElementsByName("itemselect");
	var tempStr="";
	var j=0;
	for(i=0;i<arrCB.length;i++){
		if(arrCB[i].checked){
			
			tempStr+=(j>0)?",":"";	
			tempStr+=arrCB[i].value;
			j++;
		}
	}
	if(j==0){
		alert("请选择项目");
	}else{

		document.getElementById("xmidstr").value=tempStr;
		list.action="tx_bgz_wait_choice_save.jsp";
		list.target="_blank";
		list.submit();
	}
}
function xx_submit(){
	list.action="tx_bgz_wait_choice.jsp";
	list.target="";
	list.submit();
}
</script>
