<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>调息管理－(不规则)项目列表</title>
<link href="../../css/main.css" type="text/css" rel="stylesheet" >
</head>

<body onload="public_onload(0);">
<%
	String sqlstr;
	ResultSet rs = null;

	String czid = request.getParameter("czid");
%>

<div class="cellTit" style="display:none">
          <div class="cellTitL"></div>
          <div class="cellTitC NormTit" id="cellTitTxt"></div>
          <div class="cellTitR"></div> 
<div id="listToolbar"><a href="#" accesskey="d" onClick="delxm();"></a>
</div>
</div>

<div class="divCBox"  id="dataList"  style="padding:0px">
<form name="list" action="tx_bgz_choice_save.jsp" method="post" target="_blank">

<input type="hidden" name="savetype" value="">
<input type="hidden" name="czid" value="<%=czid%>">
<input type="hidden" name="xmidstr" value="">

<table border="0" align="center" cellpadding="2" cellspacing="0" class="cTable">
  <tr class="cwDLHead">
	 <th width="1%" height="25" nowrap><input name="itemselectall" type="checkbox" class="rd" value="" title="全选" onpropertychange="selectAllItems(list.itemselect)"></th>
	 <th nowrap>项目编号</th>
	 <th nowrap>客户名称</th>
	 <th nowrap>是否已调息</th>
  </tr> 
<%
    sqlstr="select adjust_interest_proj.*,vi_cust_all_info.cust_name from adjust_interest_proj left join proj_info ";
    sqlstr+=" on adjust_interest_proj.proj_id=proj_info.proj_id left join vi_cust_all_info on proj_info.cust_id=vi_cust_all_info.cust_id ";
    sqlstr+=" where adjust_interest_proj.adjust_id='"+czid+"' and adjust_flag='否' ";//and adjust_flag='否'
//sqlstr+=" where adjust_interest_proj.adjust_id='"+czid+"' and adjust_flag='是' and exists(select proj_id from proj_condition where method='否' and proj_id=adjust_interest_proj.proj_id)";//and adjust_flag='否'

 	System.out.println("sqlstr-choice======================="+sqlstr);
 	rs = db.executeQuery(sqlstr);
 	while (rs.next()) {
 %>
  <tr class="cwDLRow" >
      <td nowrap><input class="rd" type="checkbox" name="itemselect" value="<%=getDBStr(rs.getString("proj_id"))%>"></td>
	  <td><%=getDBStr(rs.getString("proj_id"))%></td>
      <td nowrap><%=getDBStr(rs.getString("cust_name"))%></td>
      <%
      if((getDBStr(rs.getString("adjust_flag"))).equals("是")){
       %>
      <td nowrap><a href="txdb.jsp?proj_id=<%=getDBStr(rs.getString("proj_id"))%>&txid=<%=czid%>" target="_blank"><%=getDBStr(rs.getString("adjust_flag"))%></a></td>
      <%}
      else{
       %>
       <td nowrap><%=getDBStr(rs.getString("adjust_flag"))%></td>
       <%} %>
  </tr>
<%
	}
	rs.close();
	db.close();
%>
</table>
</form>

</div>



<div class="listInfo">
</div>


</body>
</html>
<script>

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
function processxm()
  {
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
		document.getElementById("savetype").value = "process";
		//alert(document.getElementById("savetype").value);
		list.submit();
	}
  }

  function delxm()
  {
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
		document.getElementById("savetype").value = "del";
		list.submit();
	}
  }
</script>
