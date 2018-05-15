<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>调息 - 所有已经调息列表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script>  
<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript">
//调息操作
function processxm(){
//alert("join");
	var str_checkbos_list = '';//合同号
	var str_settle_method = '';//测算方式
	var str_adjust_style = '';//调息方式
	var begin_id_list = '';//起租编号
	var adjust_flag = '';//是否调息
	var selectedIndex = -1;
    var dataNav = document.getElementById("dataNav");
    var str = document.getElementsByName("checkbos_list");
    var i = 0;
    for (i = 0; i < str.length; i++)
    {
        if (str[i].checked)
        {
            selectedIndex = i;
            str_checkbos_list = str_checkbos_list + str[i].value + "#";
            begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue + "#";
            str_adjust_style = str_adjust_style + str[i].attributes["adjust_style"].nodeValue + "#";
            str_settle_method = str_settle_method + str[i].attributes["settle_method"].nodeValue+"#";
            
            adjust_flag = str[i].attributes["adjust_flag"].nodeValue;
            //alert("adjust_flag="+adjust_flag);
            if(adjust_flag=="是"){
            	alert("合同"+str[i].value+"请不要重复调息");
            	return false;
            }
            	
            //alert(str_settle_method);
        }
    }
    if (selectedIndex < 0 )
    {
        alert("请先选择需要调息的数据行!");
        return false;
    }
   str_checkbos_list = str_checkbos_list.substring(0,str_checkbos_list.length-1);
   str_settle_method = str_settle_method.substring(0,str_settle_method.length-1);
   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
   str_adjust_style = str_adjust_style.substring(0,str_adjust_style.length-1);
    //window.open('tx_executeTx.jsp?all_checkbos_value='+str_checkbos_list,'进行调息','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
   //合同编号
   document.getElementById('all_checkbos_value').value = str_checkbos_list;
   document.getElementById('str_settle_method').value = str_settle_method;
   document.getElementById('adjust_style').value = str_adjust_style;
   document.getElementById('begin_id_list').value = begin_id_list;
   document.getElementById('save_type').value = "process";
    //alert(str_checkbos_list);
    dataNav.action = "tx_executeTx.jsp";
    document.dataNav.target = "_blank";
    dataNav.submit();
	dataNav.action = "tx_showAll_ytx.jsp";
    document.dataNav.target = "_self";
}
//调息撤销
function delxm(){
//alert("join");
	var str_checkbos_list = '';//合同编号
	var begin_id_list = '';//起租编号
	var str_adjust_style = '';//调息方式
	var selectedIndex = -1;
    var dataNav = document.getElementById("dataNav");
    var str = document.getElementsByName("checkbos_list");
    var i = 0;
    for (i = 0; i < str.length; i++)
    {
        if (str[i].checked)
        {
            selectedIndex = i;
            str_checkbos_list = str_checkbos_list + str[i].value + "#";
            begin_id_list = begin_id_list + str[i].attributes["begin_id"].nodeValue+"#";
            str_adjust_style = str_adjust_style + str[i].attributes["adjust_style"].nodeValue+"#";
        }
    }
    if (selectedIndex < 0 )
    {
        alert("请先选择需要调息的数据行!");
        return false;
    }
   str_checkbos_list = str_checkbos_list.substring(0,str_checkbos_list.length-1);
   begin_id_list = begin_id_list.substring(0,begin_id_list.length-1);
   str_adjust_style = str_adjust_style.substring(0,str_adjust_style.length-1);
    //window.open('tx_executeTx.jsp?all_checkbos_value='+str_checkbos_list,'进行调息','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
   //合同编号
   document.getElementById('all_checkbos_value').value = str_checkbos_list;
   document.getElementById('begin_id_list').value = begin_id_list;
   document.getElementById('adjust_style').value = str_adjust_style;
   document.getElementById('save_type').value = "del";
    //alert(str_checkbos_list);
    dataNav.action = "tx_executeTx.jsp";
    document.dataNav.target = "_blank";
    dataNav.submit();

	dataNav.action = "tx_showAll_ytx.jsp";
    document.dataNav.target = "_self";
}

//checkbos全选
function isSelectAll () {
	var names = document.getElementsByName("checkbos_list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	//makeValue();
}
//调息之未调息记录模糊查询
function query(){
	//form1.action = "";
	//document.form1.target = "tx_showAll_wtx.jsp";
	dataNav.submit();
}
</script>
</head>
<body>
<%
	 //央行利率基准表中的主键,通过该主键在表fund_adjust_interest_contract中查询对应的adjust_id
	String txId = getStr(request.getParameter("txId"));  
	String adjust_method = getStr(request.getParameter("adjust_method")); 
	String adjust_flag = getStr(request.getParameter("adjust_flag")); 
	String adjustFlag = getStr(request.getParameter("adjustFlag")); 
	String adjustStyle = getStr(request.getParameter("adjustStyle")); 
	//String start_date = getStr(request.getParameter("start_date"));//调息开始日期
	//获取查询条件
	String contract_id = getStr(request.getParameter("query_contract_id")); 
	String project_name = getStr(request.getParameter("query_project_name")); 
	
	String str = "";
	ResultSet rs = null;
	StringBuffer sql = new StringBuffer();
	sql.append(" select * from vi_tx_showAll_ytx  vts")
	   .append(" where  exists ( ")
	   .append(" select begin_id from fund_adjust_interest_contract fa ")
	   .append(" where fa.contract_id=vts.contract_id and fa.begin_id=vts.begin_id  ");
	   
	   if(!txId.equals("") && txId != null){
		  sql.append(" and adjust_id = "+txId+" ");//传入的ID是fund_standard_interest的ID
	    }   
	   sql.append(" ) ");
	   if(!contract_id.equals("") && contract_id != null){
		  sql.append(" and contract_id like '%"+contract_id+"%' ");//
	   }   
	   if(!project_name.equals("") && project_name != null){
		  sql.append(" and project_name like '%"+project_name+"%' ");//
	   }  
	   if(!"".equals(adjustFlag) && adjustFlag != null){
		  sql.append(" and adjust_flag = '"+adjustFlag+"' ");//
	   }  
	   if(!"".equals(adjustStyle) && adjustStyle != null){
		  sql.append(" and adjust_style = '"+adjustStyle+"' ");//
	   }  
	   sql.append("  and adjust_id='"+txId+"' and settle_method='"+adjust_method+"'");
	   System.out.println("调息界面Sql==>> "+sql.toString());
	   String sqlstr = sql.toString();
%>
<form name="dataNav" id="dataNav" action="tx_showAll_ytx.jsp" method="post" onSubmit="return goPage()">
<!-- custId == adjust_id  -->
<input type="hidden" name="txId" id="txId" value="<%=txId%>">
<input type="hidden" name="adjust_method" id="adjust_method" value="<%=adjust_method%>">
<input type="hidden" name="all_checkbos_value" id="all_checkbos_value"/>
<input type="hidden" name="begin_id_list" id="begin_id_list"/>
<input type="hidden" name="adjust_style" id="adjust_style"/>
<input type="hidden" name="str_settle_method" id="str_settle_method"/>
<input type="hidden" name="save_type" id="save_type"/>
<input type="hidden" name="adjust_flag" id="adjust_flag" value="<%=adjust_flag%>">

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" colspan="5" id="cwCellTopTitTxt">
      	租金测算 &gt; 已调息记录列表
      </td>
    </tr>
    <tr class="maintab">
		<td nowrap align="left" >               
			&nbsp;合同编号&nbsp;
			<input type="text" name="query_contract_id" size="15" value="<%=contract_id%>" />
			&nbsp;项目名称&nbsp;
			<input name="query_project_name" type="text" size="15" value="<%=project_name%>"/>
		调息状态
			<select name="adjustFlag">
			  <script type="text/javascript">
			   	w(mSetOpt('<%=adjustFlag %>',"|是|否","|是|否"));
			  </script>
			</select>
			调息方式
			<select name="adjustStyle">
			  <script type="text/javascript">
			   	w(mSetOpt('<%=adjustStyle %>',"|次日|次期","|次日|次期"));
			  </script>
			</select>
			<a href="#" onclick="query();">
				<img src="../../images/tbtn_searh.gif" alt="查询" border="0" align="absmiddle" >
			</a>
       </td>
       <td nowrap="nowrap">
       	<%	
			if("否".equals(adjust_flag)){
		%>	
         <span class="tTable" style="float:right; margin-top:1px; margin-right:5px" ><a href="#" onClick="delxm();"><img src="../../images/sbtn_del.gif" width="19" height="19" title="调息撤消">调息撤消</a></span>
  		 <span class="tTable" style="float:right; margin-top:1px; margin-right:5px" ><a href="#" onClick="processxm();"><img src="../../images/sbtn_chkit.gif" width="19" height="19" title="执行调息">调息处理</a></span>
  		   <%
           }
           %>
       </td>
	</tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
    <tr class="maintab">
      <td align="left" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
	<!-- 翻页控制开始 -->
	<%@ include file="../../public/pageSplitNoCode.jsp"%>
	<!--翻页控制结束-->	
	</td>
	</tr>
</table>

  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%">
	    	 <input name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();">全选
	    </th>
	  
	    <th>合同编号</th>
	    <th>起租编号</th>
		<th>项目名称</th>
		<th>部门</th>
		<th>利率浮动类型</th>
		<th>利率调整值</th>
		<th>租金计算方式</th>
		<th>调息方式</th>
		<th>调息状态</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
	String settle_method="";
	settle_method=getDBStr(rs.getString("settle_method"));
%>
      <tr>
      	<td align="center"><input type="checkbox" name="checkbos_list" value="<%=getDBStr(rs.getString("contract_id"))%>" 
      	settle_method="<%=getDBStr(rs.getString("settle_method"))%>" adjust_flag="<%= getDBStr(rs.getString("adjust_flag"))%>" 
      	begin_id="<%=getDBStr(rs.getString("begin_id"))%>"  adjust_style="<%=getDBStr(rs.getString("adjust_style"))%>"/></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("contract_id"))%></td>
        <td align="center" nowrap><%=getDBStr(rs.getString("begin_id"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("project_name"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("dept_name"))%></td>
		
		<td align="center" nowrap><%= getDBStr(rs.getString("rate_float_type"))%></td>
		<td align="center" nowrap><%= rs.getDouble("rate_float_amt") %></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_type"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_style"))%></td>
	   <%
    	  if( "是".equals(getDBStr(rs.getString("adjust_flag"))) ){
       %>
		<td align="center" nowrap>
	        <a href="txdb.jsp?begin_id=<%=getDBStr(rs.getString("begin_id"))%>&txid=<%=getDBStr(rs.getString("adjust_id"))%>" target="_blank">
	      		<b style="color:#E46344;"><%=getDBStr(rs.getString("adjust_flag"))%></b>
	        </a>
	    </td>  
       <%} else{
       %>
		<td align="center" nowrap><%=getDBStr(rs.getString("adjust_flag"))%></td>
       <%} %>
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
