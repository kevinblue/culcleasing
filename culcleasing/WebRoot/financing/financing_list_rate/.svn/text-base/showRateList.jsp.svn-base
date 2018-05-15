<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>历年次央行利率表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript">
//新增操作
function newAdd(){
//alert("join");
//	var str = document.getElementsByName("name")[0].value;
	//弹出窗口进行新增操作
	window.open('rate_add.jsp?model="add"','央行基准利率新增操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}
//删除操作
function newDel(){
	var str_key_id;
	var selectedIndex = -1;
    var form1 = document.getElementById("form1");
    var i = 0;
    for (i = 0; i < form1.key_id.length; i++)
    {
        if (form1.key_id[i].checked)
        {
            selectedIndex = i;
            str_key_id = form1.key_id[i].value;
            break;
        }
    }
    alert(str_key_id);
    if (selectedIndex < 0)
    {
        alert("请先选择需要删除的数据行!");
        return false;
    }
	window.open("rate_save.jsp?model=del&key_id="+str_key_id,'央行基准利率删除操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<body>
<%
	//权限处理 
	String dqczy = (String) session.getAttribute("czyid");
	String str = "";
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//央行基准利率表
	String sqlstr = " select * from financing_list_rate order by id "; 
%>
<form name="form1" action="showRateList.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	历年次央行利率表
      </td>
    </tr>
  </table>
  <!--标题结束-->
  <!--副标题和操作区开始-->
  <table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="3">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
            <!-- 权限控制 -->
         <% //if (right.CheckRight("zjcs-tx-add",dqczy)>0){ %>
	              <a href="#" accesskey="n" onClick="dataHander('add','rate_add.jsp?model=add',form1.key_id);">
	              		<img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <%// } %>
	
            <%//if (right.CheckRight("zjcs-tx-del",dqczy)>0){ %>
			   <a href="#" accesskey="d" onClick="dataHander('del','rate_save.jsp?model=del&key_id=',form1.key_id);">
				<img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        <%// }%>
	        
			</td>
          </tr>
        </table>
        </td>
    </tr>
 
    <tr class="maintab">
      <td align="center" width="1%">
        <table border="0" cellspacing="0" cellpadding="0" >
        </table>
	  </td>
      <td align="right" width="90%">
 <!--翻页控制开始-->
<% 
	int intPageSize = 15;   //一页显示的记录数
	int intRowCount = 0;   //记录总数
	int intPageCount = 1; //总页数
	int intPage;       //待显示页码
	String strPage = getStr(request.getParameter("page") );          //取得待显示页码
	if( strPage.equals("") ){                                         //表明在QueryString中没有page这一个参数，此时显示第一页数据
	   intPage = 1;
	}else{
	   intPage = java.lang.Integer.parseInt(strPage);
	   if(intPage<1) intPage = 1;
	} 
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
		var nf = document.form1;
	</script>
    <td nowrap>共 <%=intRowCount%> 条 / <%=intPageCount%> 页 
	<%if(intPage>1){%>	<img align="absmiddle" style="cursor:pointer; " onClick="goPage('first')" src="../../images/ico_first.gif" alt="第一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('prev')" src="../../images/ico_prev.gif" alt="上一页"    border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_first.gif" alt="第一页"  border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_prev.gif" alt="上一页" border="0"><% } %>
	第 <font color="red"><%=intPage%></font> 页	
	<%if(intPage<intPageCount){%> <img align="absmiddle" style="cursor:pointer; " onClick="goPage('next')" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="cursor:pointer; " onClick="goPage('last')" src="../../images/ico_last.gif" alt="最后页" border="0">
	<%}else{%><img align="absmiddle" style="filter:Gray;" src="../../images/ico_next.gif" alt="下一页" border="0"><img align="absmiddle" style="filter:Gray;" src="../../images/ico_last.gif" alt="最后页" border="0"><% } %></td>
	
    <td nowrap><img align="absmiddle" src="../../images/sbtn_split.gif"></td>
    
    <td nowrap>转到 <input name="page" type="text" size="2" value="1"> 页 <img align="absmiddle" style="cursor:pointer; " onClick="goPage('jump')" src="../../images/goto.gif" alt="执行" border="0" align="absmiddle"></td>
 </tr>
</table>

</td>
</tr>

</table>

<!--翻页控制结束 style="vertical-align:top;width:100%;overflow:auto;position: relative;" -->
  <div style="height=85%;vertical-align:top;width:100%;overflow:auto;position: relative;" id="mydiv";>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" hight="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>操作</th>
	    <th>调整时间</th>
		<th>六个月至一年（含一年）</th>
		<th>一至三年（含三年）</th>
		<th>三至五年（含五年）</th>
		<th>五年以上</th>
		<th>开始时间</th>
		<th>截止时间</th>
		<th>当前应用利率</th>
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
		BigDecimal bignum = new BigDecimal("100");
%>
      <tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td align="center" nowrap><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("id"))%>"/></td>
        <td align="center" nowrap><%= getDBStr(rs.getString("Adjust_time"))%></td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_one").multiply(bignum).doubleValue()%>%</td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_three").multiply(bignum).doubleValue()%>%</td>
		<td align="center" nowrap><%= rs.getBigDecimal("base_rate_five").multiply(bignum).doubleValue()%>%</td>
	    <td align="center" nowrap><%= rs.getBigDecimal("base_rate_abovefiv").multiply(bignum).doubleValue()%>%</td>
        <td align="center" nowrap><%= getDBStr(rs.getString("rate_start_date"))%></td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("rate_end_date"))%></td>	
        <td align="center" nowrap><%= getDBStr(rs.getString("Rate_flag"))%></td>	
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
