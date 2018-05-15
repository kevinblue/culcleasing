<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>供应商付款单信息</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript" src="../../js/table.js"></script> 
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script type="text/javascript">
	function test(){
		var now=new Date();

 		var year=now.getYear();

 		var month=now.getMonth();

 		var day=now.getDate();

 		var hours=now.getHours();

 		var minutes=now.getMinutes();

 		var seconds=now.getSeconds();

		var selNames=document.getElementsByName("ssid");
		var selSum=0;
		var val = "";
		for(var i=0;i<selNames.length;i++){
			if(selNames[i].checked == true)
			{
				selSum++;
			}
		}
		if(selNames.length==0){
			alert("没有选择要打印的记录！");
		}else{
			if(selSum==0){
				alert("请先选择要打印的记录！");
			}else{
				for(var i=0; i<selNames.length; i++){
					if(selNames[i].checked == true){
						if(selNames[i].value==""||selNames[i].value=="."){
						   alert("供应商编号不能为空");
						}else{
						   val += selNames[i].value+";";
						}						
			        }					    						
				}
				if(val==""||val.value=="."){
					
				}else{
					document.forms.dataNav1.action="http://192.168.0.14/ELeasing/ProjectWF/ProjectFundOPUser.nsf/CreatePayFilesByUserID?openagent&fileno=10&list="+val+"&time="+seconds+"";
					alert(document.forms.dataNav1.action);
					document.forms.dataNav1.method="post";
					document.forms.dataNav1.submit();
				}
			}
		}
		
	}
</script>
<script>
   function SelectAll() {
	 var checkboxs=document.getElementsByName("ssid");
	 for (var i=0;i<checkboxs.length;i++) {
		 var e=checkboxs[i];
		 e.checked=!e.checked;
	 }
	}
</script>
</head>
<body onLoad="" style="border:1px solid #8DB2E3;overflow:auto">
<%
String dqczy=(String) session.getAttribute("czyid");
String where = "";
String searchFld = getStr( request.getParameter("searchFld") );
String searchKey = getStr( request.getParameter("searchKey") );
if(!searchKey.equals("")){
   where = " and (select c_info.cust_name from vi_cust_all_info as c_info where c_info.cust_id = v_plan.pay_cust) like '%"+searchKey+"%'";
}
ResultSet rs;
String wherestr = " where 1=1";
String searchFld_tmp = "";
String sqlstr = "select row_number() over (order by v_plan.pay_cust) as num,v_plan.pay_cust,(select suppliers.cust_name from vi_phone_suppliers as suppliers where suppliers.cust_id = v_plan.pay_cust) as supper,(select c_info.cust_name from vi_cust_all_info as c_info where c_info.cust_id = v_plan.pay_cust) as cust_name,sum(v_plan.plan_money) as sum_pay_money,sum(v_plan.owPlan_money)as sum_owPlan_money,sum(v_plan.owPayed_money) as owPayed_money from vi_phone_charge_plan as v_plan where v_plan.owPlan_money >0 "+where+" group by v_plan.pay_cust";
System.out.println("###"+sqlstr);
%>
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      供应商付款单信息</td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
    <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;" >
	 <form name="dataNav1" action="supper_list.jsp">		
	<tr class="maintab">
				<td align="left" colspan="2">               
					&nbsp;按&nbsp;<select name="searchFld"><script>w(mSetOpt("<%= searchFld %>","|供应商"));</script></select>&nbsp;查询&nbsp;<input name="searchKey" accesskey="s" type="text" size="15" value="<%= searchKey %>">
		<input name="image" type="image" src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle"  onclick="searchbar.submit();">
                </td>
			</tr>
    <tr class="maintab">
      <td align="left" width="1%"><!--操作按钮开始-->
        <table border="0" cellspacing="0" cellpadding="0" >
			<tr class="maintab">
				<td nowrap><a onClick="SelectAll()">全选</a>&nbsp;&nbsp;&nbsp;</td>
				<td><input id="btnChong" type="button" name="btnSava" value="打印" onClick="test()"></td>
    </tr>
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
          </form>
        </table></td>
    </tr>
  </table>
  <!--翻页控制结束-->
  <!--报表开始-->
  <div style="vertical-align:top;width:100%;overflow:auto;position: relative;"  id="mydiv";>
    <form action="supper_list.jsp" name="dataNav">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th width="1%"></th>
	    <th nowrap>编号</th>
		<th nowrap>供应商</th>
		<th nowrap>计划付款金额</th>
		<th nowrap>已付金额</th>
		<th nowrap>未付金额</th>
      </tr>
<%	  

if ( intRowCount!=0 ) {
rs.previous();
if ( rs.next() )
{
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
        <td align="center" nowrap><input type="checkbox" name="ssid" value="<%=getDBStr( rs.getString("pay_cust") )%>"></td>
        <td align="center" nowrap><%=getDBStr( rs.getString("num") )  %></td>
		<td align="center" nowrap><a href="supper_list_detail.jsp?id=<%= getDBStr( rs.getString("pay_cust") ) %>" target="_blank"><%=getDBStr( rs.getString("cust_name") )  %></a></td>
		<td align="center" nowrap><%=formatNumberStr( rs.getString("sum_pay_money"),"#,##0.00") %></td>

		<td align="center" nowrap><%=formatNumberStr( rs.getString("owPayed_money"),"#,##0.00") %></td>
		<td align="center" nowrap><%=formatNumberStr( rs.getString("sum_owPlan_money"),"#,##0.00") %></td>
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
</body>
</html>
