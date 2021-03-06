<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>保理维护</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
	
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
System.out.println("dqczy="+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where 1=1";

String searchFld_tmp = "";
if( searchFld.equals("承租人") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "contract_id";
}else if( searchFld.equals("保理") ) {
	searchFld_tmp = "factoring";
}else{
	searchFld_tmp = "";
}

if ( !searchFld.equals("") && !searchKey.equals("") ) {

	wherestr = wherestr + " and " + searchFld_tmp + " like '%" + searchKey + "%'";
}
if(create_start_date!=null&&!create_start_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)>='"+create_start_date+"' ";
}
if(create_end_date!=null&&!create_end_date.equals("")){
	wherestr+=" and convert(varchar(10),plan_date,21)<='"+create_end_date+"' ";
}

String sqlstr = "select *  from vi_fund_rent_plan_factoring " + wherestr+" order by plan_date desc"; 
System.out.println("###"+sqlstr);
%>
<!--<body onLoad="public_onload(0);"-->

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
     保理维护</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	 <form name="dataNav1"  method="post" action="factoring.jsp">		
	
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|承租人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		添加日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			
        </table>
        <!--操作按钮结束--></td>
      <td align="right" width="90%"><!--翻页控制开始-->
        <% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr( request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 

System.out.println("%%%%===================================%%"+sqlstr);
    rs = db.executeQuery(sqlstr); 


	rs.last();                                                  //获取记录总数
	intRowCount = rs.getRow();
	intPageCount = ( intRowCount + intPageSize - 1) / intPageSize;   //记算总页数
	if( intPage > intPageCount ) intPage = intPageCount;            //调整待显示的页码
	if( intPageCount > 0 )
	   rs.absolute( ( intPage-1 ) * intPageSize + 1 );              //将记录指针定位到待显示页的第一条记录上
	int i = 0;
	
%>
        <table border="0" cellspacing="0" cellpadding="0">
          <tr class="maintab">
            <script>
		var cp = <%= intPage %>;
		var lp = <%= intPageCount %>;
		var nf = document.dataNav1;
	</script>
            <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页
              <%if(intPage>1){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0">
              <% } %>
              第 <font color="red"><%=intPage%></font> 页
              <%if(intPage<intPageCount){%>
              <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
              <%}else{%>
              <img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0">
              <% } %></td>
            <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
            <td nowrap>转到
              <input name="page" type="text" size="2" value="1">
              页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
          </tr>


</td>
          </form>
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--控制全选的-->
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">
<tr class="maintab">
<td>
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
</td>
	<td align="left" colspan="10"></td>

</tr>
 <tr>
   
	<td scope="row" colspan="5">
		
		<input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();"/>  全选/反选
	</td>
    

	
  </tr>


</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <form name="dataNav"  method="post" action="factoring.jsp">		
	 <input id="id" name="id" type="hidden" >
	 <input id="savetype" name="savetype" type="hidden" value="mod">
	  <input id="l_id" name="l_id" type="hidden" >
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>序号</th>
	    <th>承租人</th>
	    <th>合同号</th>
	    <th>合同期次</th>
	    <th>计划收取日</th>
	    <th>每期租金</th>
	    <th>每期本金</th>
	    <th>每期租息</th>
	    <th>剩余本金</th>
		<th>保理</th>
		<th>保理本金</th>
		<th>保理租金</th>
		
		
		
      </tr>

<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
	String id=getDBStr(rs.getString("id"));
	int flag=0;
	System.out.println(id+"()((((((((((((((((((((");
%>

      <tr>
         <td align="center"><input  type="checkbox" name="list" id=<%=getDBStr(rs.getString("id"))%> flag="<%=flag %>" value="<%=getDBStr( rs.getString("id") )%>" /></td>
        
         <td align="center"><%=getDBStr( rs.getString("id") )  %></a></td>
        <td align="center">
		<%= getDBStr( rs.getString("cust_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   	<td align="center"><%= getDBStr( rs.getString(("rent_list") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("plan_date") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("rent") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("interest") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("corpus_overage") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_pringcipal") ) %></td>
		<td align="center"><%= getDBStr( rs.getString("factoring_rantal") ) %></td>
		
		
      </tr>
<%
		rs.next();
		i++;
		
	}
}
}
rs.close(); 
db.close();
%>
    </table>
    </form>
  </div>
  <!--报表结束-->
<script>
function isSelectAll () {

	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	//makeValue();
}

function makeValue()
{
	 var sid="";
	//得到复选框的集合
 var names=document.getElementsByName("list");
	//alert(names);
 for(i=0;i<names.length;i++){
 if(names[i].checked){
 var id=names[i].attributes["id"].nodeValue;
  sid=sid+id+",";
 }
 }
  	document.getElementById("id").value=sid.substring(0,sid.length-1);
	id.value=sid.substring(0,sid.length-1);
	
  
}

function isSub(obj) {
	 var sid="";
		//得到复选框的集合  
 	var names=document.getElementsByName("list");
//alert(names.length);
 	var statu=0;
	var l_id = "";//jiezhi
	var id = "";
    for(i=0;i<names.length;i++){
	    if (names[i].checked){
			statu++; 
			id = names[i].attributes["id"].nodeValue; 
			sid=sid+id+",";
			l_id=sid;
			
		}
	}
	
	//alert("=====>"+l_id.substring(0,l_id.length-1));
	
	if (statu==0) {
			alert("请选择您要申请的项目!");
			return false;
	} else{
			//alert("进来没！");
			//l_id=l_id+sid;
			//alert(l_id);
			//alert("GGGGG"+l_id.substring(0,l_id.length-1));
			//alert("factoring_tt.jsp?l_id="+l_id);
			//l_id = l_id.substring(0,l_id.length-1);
			dataNav.action="factoring_tt.jsp?l_id="+l_id;
		 	//dataNav.action="factoring_tt.jsp?savetype=mod?l_id="+l_id;
			dataNav.target ="_blank";
            dataNav.method = "post";
            dataNav.submit();
		 
	}
	return false;
	
}

//function search_proj() {
	//document.search.action="factoring.jsp";
	//document.search.submit();
//}

</script>
</body>
</html>
