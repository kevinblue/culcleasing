<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
		<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>统计逾期</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
	
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
    <form name="dataNav"  method="post" action="overdue.jsp">	
<%
String dqczy=(String) session.getAttribute("czyid");
System.out.println("dqczy="+dqczy);
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
String create_start_date = getStr( request.getParameter("create_start_date") );
String create_end_date = getStr( request.getParameter("create_end_date") );
ResultSet rs;
String wherestr = " where yq_rent>0 ";

String searchFld_tmp = "";
if( searchFld.equals("承租人") ) {
	searchFld_tmp = "cust_name";
}else if( searchFld.equals("合同编号") ) {
	searchFld_tmp = "frp.contract_id";
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

String sqlstr = "select * from vi_statistical_overdue  ";

sqlstr+=" " + wherestr+" order by plan_date desc"; 
System.out.println("###"+sqlstr);
%>
<!--<body onLoad="public_onload(0);"-->

  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
     统计逾期</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|合同编号|承租人"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		计划日期<input name="create_start_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_start_date %>"> <img  onClick="openCalendar(create_start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		-<input name="create_end_date" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=create_end_date %>"> <img  onClick="openCalendar(create_end_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="dataNav.submit();">
                </td>
			</tr>
    <tr class="maintab">
         
      <td align="left" width="1%"><!--操作按钮开始-->
          <%if(right.CheckRight("factoring",dqczy)>0){%>
          <BUTTON class="btn_2" name="btnSave" value="保存"  type="submit"  onclick="return isSub(this);" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
          <%}%>
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
		var nf = document.dataNav;
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
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--控制全选的-->
<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" class="tab_table_title">

 <tr>
   
	<td scope="row" colspan="5">
		
		<input  name="ck_all" id="ck_all" type="checkbox" onclick="isSelectAll();"/>  全选/反选
		<input type="hidden" name="contract_str" id="contract_str">
		<input type="hidden" name="rent_str" id="contract_str">
		<input type="hidden" name="reason_str" id="contract_str">
	</td>
    <td>逾期原因:
    <input type="text" name="reason2" id="reason2" style="width: 300px" >
    </td>

	
  </tr>


</table>

  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
	
	 <input id="id" name="id" type="hidden" >
	 <input id="savetype" name="savetype" type="hidden" value="add">
	  <input id="l_id" name="l_id" type="hidden" >
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th>序号</th>
	    <th>承租人</th>
	    <th>合同号</th>
	    <th>合同期次</th>
	    <th>计划收取日</th>
	    <th>逾期租金</th>
	    <th>逾期原因</th>
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
         <td align="center"><input  type="checkbox" name="list" id=<%=getDBStr(rs.getString("id"))%> flag="<%=flag %>" contract_id=<%=getDBStr(rs.getString("contract_id"))%> 
         rent_list=<%=getDBStr(rs.getString("rent_list"))%> reason=<%=getDBStr(rs.getString("reason"))%> value="<%=getDBStr( rs.getString("id") )%>" onclick="getNum('list','reason2','reason');"/></td>
        
          <td align="center"><a href="factoring_mod.jsp?id=<%=getDBStr( rs.getString("id") ) %>" target="_blank"><%=getDBStr( rs.getString("id") )  %></a></td>
        <td align="center">
		<%= getDBStr( rs.getString("cust_name") ) %></td>
	   <td align="center"><%= getDBStr( rs.getString("contract_id") ) %></td>
	   	<td align="center"><%= getDBStr( rs.getString(("rent_list") )) %></td>
	   <td align="center"><%= getDBStr( rs.getString("plan_date") ) %></td>
	    <td align="center"><%= getDBStr( rs.getString("yq_rent") ) %></td>
		<td align="center"><input type="text" name="reason" style="width: 300px" onblur="getNum2('list','reason2','reason');" value="<%= getDBStr( rs.getString("reason") ) %>" ></td>
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
         function getNum(src,getValue,setValue)
         {		 var sid1="";
         		 var sid2="";
         		 var sid3="";
         		 var sid4="";
         			
			//得到复选框的集合
             var checks = document.getElementsByName(src);
             var iupt = document.getElementsByName(setValue);
             for(var i=0;i<checks.length;i++)
             {

                 if(checks[i].checked)
                {		 
                		 //alert(document.getElementsByName(setValue)[i].value);
                		//注意这里的取值如果是从一个固定的input取值则【】中的下标一直取0的否则取i
                		
                         var temp=document.getElementsByName(setValue)[i].value;
                		
                         document.getElementsByName(setValue)[i].value = document.getElementsByName(getValue)[0].value;
                         if (temp!=""){
                         	document.getElementsByName(setValue)[i].value=temp;
                         }
                         checks[i].attributes["reason"].nodeValue= document.getElementsByName(setValue)[i].value;
                          var id=checks[i].attributes["id"].nodeValue;
 						  var ct_id=checks[i].attributes["contract_id"].nodeValue;
						  var rt_list=checks[i].attributes["rent_list"].nodeValue;
 						  var rn_list=checks[i].attributes["reason"].nodeValue;
 						  sid1=sid1+id+",";
 						  sid2=sid2+ct_id+"#";
 						  sid3=sid3+rt_list+"#";
 						  sid4=sid4+rn_list+"#";
 						  //alert(sid1);
 						  //alert(sid2);
 						  //alert(sid3);
 						  //alert(sid4);
 						  
                }
                else
                {
                         //document.getElementsByName(setValue)[i].value=document.getElementsByName(setValue)[i].value;
         		}

             }
             
             document.getElementById("contract_str").value=sid2.substring(0,sid2.length-1);
             document.getElementById("rent_str").value=sid3.substring(0,sid3.length-1);
             document.getElementById("reason_str").value=sid4.substring(0,sid4.length-1);
             //alert(sid3);
             //alert(sid4);
         }
         
          function getNum2(src,getValue,setValue)
         {		 var sid1="";
         		 var sid2="";
         		 var sid3="";
         		 var sid4="";
         			
			//得到复选框的集合
             var checks = document.getElementsByName(src);
             for(var i=0;i<checks.length;i++)
             {

                 if(checks[i].checked)
                {		 
                		 //alert(document.getElementsByName(setValue)[i].value);
                		//注意这里的取值如果是从一个固定的input取值则【】中的下标一直取0的否则取i
                		
                         var temp=document.getElementsByName(setValue)[i].value;
                		
                         document.getElementsByName(setValue)[i].value = document.getElementsByName(getValue)[0].value;
                         if (temp!=""){
                         	document.getElementsByName(setValue)[i].value=temp;
                         }
                         checks[i].attributes["reason"].nodeValue= document.getElementsByName(setValue)[i].value;
                          var id=checks[i].attributes["id"].nodeValue;
 						  var ct_id=checks[i].attributes["contract_id"].nodeValue;
						  var rt_list=checks[i].attributes["rent_list"].nodeValue;
 						  var rn_list=checks[i].attributes["reason"].nodeValue;
 						  sid1=sid1+id+",";
 						  sid2=sid2+ct_id+"#";
 						  sid3=sid3+rt_list+"#";
 						  sid4=sid4+rn_list+"#";
 						  //alert(sid1);
 						  //alert(sid2);
 						  //alert(sid3);
 						  //alert(sid4);
 						  
                }
                else
                {
                         //document.getElementsByName(setValue)[i].value="";
         		}

             }
             
             document.getElementById("contract_str").value=sid2.substring(0,sid2.length-1);
             document.getElementById("rent_str").value=sid3.substring(0,sid3.length-1);
             document.getElementById("reason_str").value=sid4.substring(0,sid4.length-1);
             //alert(sid3);
             //alert(sid4);
             
         }
         
         

function isSelectAll () {

	var names=document.getElementsByName("list");
	var isck_all = document.getElementById("ck_all").checked;
	for (var n=0;n<names.length;n++) {
		names[n].checked=isck_all;
	}
	//makeValue();
	 getNum('list','reason2','reason');
}

function makeValue()
{
	 var sid="";
	//得到复选框的集合
 var names=document.getElementsByName("list");
 var reason=document.getElementById("reason2").value;
  //alert(reason);
	//alert(names);
 for(i=0;i<names.length;i++){
 if(names[i].checked){
	document.getElementById("reason")[i].value=reason;
 var id=names[i].attributes["id"].nodeValue;
 var ct_id=names[i].attributes["contract_id"].nodeValue;
 var rt_list=names[i].attributes["rent_list"].nodeValue;
 var rn_list=names[i].attributes["reason"].nodeValue;
  sid=sid+id+",";
  document.getElementById("reason").value=reason;
 // document.getelementbyid(names[i].reason).value
 	//alert(document.getElementById("reason")[i]);
 }
 }	
  	document.getElementById("id").value=sid.substring(0,sid.length-1);
  	//alert(sid);
	id.value=sid.substring(0,sid.length-1);
}

function isSub(obj) {
	var n=0;
 	var names=document.getElementsByName("list");
 	for(var i=0;i<names.length;i++){
 	if(names[i].checked){
		n=n+1;
	}
	}
	//alert(n);
	if(n==0){
	alert("请选择要修改的项目");	
	return false;
	}else{
	dataNav.action="overdue_save.jsp";
	dataNav.submit();
	dataNav.action="overdue.jsp";
	}
	
 	
	
}


</script>
</body>
</html>
