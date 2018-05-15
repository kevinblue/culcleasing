<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ page import="java.sql.*" %>
<%@ include file="../../func/common.jsp"%>
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 调息</title>
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
	window.open('tx_fsi_add.jsp?model="add"','央行基准利率新增操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}
//修改操作
function newMod(){
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
    if (selectedIndex < 0)
    {
        alert("请先选择需要修改的数据行!");
        return false;
    }
	window.open("tx_fsi_add.jsp?model=mod&key_id="+str_key_id,'央行基准利率修改操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
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
	window.open("tx_fsi_add.jsp?model=del&key_id="+str_key_id,'央行基准利率删除操作','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
}

</script>
</head>
<body>
<%
	//权限处理 
	String dqczy = (String) session.getAttribute("czyid");
	//if ((dqczy == null) || (dqczy.equals("")))
	//{
	//  dqczy = "无认证";
	//  response.sendRedirect("../../noright.jsp");
	//}
	//int canedit=0;
	//if (right.CheckRight("zjcs-tx-list",dqczy) > 0) canedit=1;
	//if (canedit == 0) response.sendRedirect("../../noright.jsp");
%>

<%
	String str = "";
	ResultSet rs;
	String wherestr = " where 1=1 ";
	//央行基准利率表
	String sqlstr = " select * from fund_standard_interest order by start_date desc"; 
%>
<form name="form1" action="tx_showMainList.jsp"  onSubmit="return goPage()">
<input type="hidden" name="na" id="na" >
  <!--标题开始-->
  <table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
    <tr class="tree_title_txt">
      <td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
      	租金测算 &gt; 调息
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
	              <a href="#" accesskey="n" onClick="dataHander('add','tx_fsi_add.jsp?model=add',form1.key_id);">
	              		<img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <%// } %>
	
            <%//if (right.CheckRight("zjcs-tx-mod",dqczy)>0){ %>
            	<a href="#" accesskey="m" onClick="dataHander('mod','tx_fsi_add.jsp?model=mod&key_id=',form1.key_id);">
            		<img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" >
            	</a>
	        <%// }%>
            <%//if (right.CheckRight("zjcs-tx-del",dqczy)>0){ %>
			   <a href="#" accesskey="d" onClick="dataHander('del','tx_fsi_add.jsp?model=del&key_id=',form1.key_id);">
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
      <!-- 
	    <th width="1%">
	    	<input name="itemselectall" type="checkbox" class="rd" value="" title="全选" onpropertychange="selectAllItems(list.itemselect)">
	    </th>
	   --> 
	    <th>操作</th>
	    <th>开始日期</th>
		<th>利息调整幅度1年</th>
		<th>利息调整幅度1至3年</th>
		<th>利息调整幅度3至5年</th>
		<th>利息调整幅度5年以上</th>
		<th>租金计算方式</th>
		<th>调息是否完成</th>
		<th>通知书</th>
		  <!-- 
		<th>登记人</th>
		<th>登记时间</th>
		<th>本次调整后央行基础利率1年</th>
		<th>本次调整后央行基础利率1至3年</th>
		<th>本次调整后央行基础利率3至5年</th>
		<th>本次调整后央行基础利率5年以上</th> --> 
      </tr>

<%	  if ( intRowCount>0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("id"))%>"/></td>
        <td align="center" nowrap="nowrap"><%=getDBDateStr(rs.getString("start_date"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("rate_one"))%></td>
	    <td align="center" nowrap><%= getDBStr(rs.getString("rate_three"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("rate_five"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("rate_abovefive"))%></td>
		      	<td align="center">
      		<select onChange="window.open(this.value)">  
      			<option> </option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType1&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等额租金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType4&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等额本金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType2&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等差租金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType5&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等差本金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType3&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等比租金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType6&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">等比本金</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType7&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">均息法</option>
      			<option value="tx_showMaintx.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType9&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">不等额本金</option>
      			<option value="tx_showMaintx_bgz.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType8&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">不等额租金</option>
      	        <option value="tx_showMaintx_bgz.jsp?czid=<%=getDBStr(rs.getString("id"))%>&adjust_method=RentCalcType10&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>">不规则</option>
      		</select>
      	</td>

		
	<%-- 	
		<td align="center" nowrap><%= getDBStr(rs.getString("base_rate_abovefive"))%><td><br></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("base_rate_three"))%></td>	 	
		<td align="center" nowrap><%= getDBStr(rs.getString("base_rate_five"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("base_rate_one"))%></td>
		<td align="center" nowrap><%= getDBStr(rs.getString("creator"))%></td>
		<td align="center" nowrap><%= getDBDateStr(rs.getString("create_date"))%></td> 
		<td align="center" nowrap>
		<% 
			//2010-12-30新增
			String adjust_flag = getDBStr(rs.getString("adjust_flag"));//是否调息完成
			System.out.println("adjust_flag--->"+adjust_flag);
			//if(!"是".equals(adjust_flag)){//是 表明已经完成调息
		%>	
			<!-- 跳转到具体的调息页面带主键过去  -->
        	<a href="tx_showMaintx.jsp?custId=<%=getDBStr(rs.getString("id"))%>&start_date=<%=getDBDateStr(rs.getString("start_date"))%>&adjust_flag=<%=getDBStr(rs.getString("adjust_flag"))%>" target="_blank">
        		调息
        	</a>
		<%// } %>	
        </td>	--%>
        		<td align="center" nowrap><%= getDBStr(rs.getString("adjust_flag"))%></td>	
        <td align="center" nowrap>		
        		<%
	String adjust_flag="";
 	adjust_flag=getDBStr(rs.getString("adjust_flag"));
  if (adjust_flag.indexOf("是")>=0)
	{
%>
	通知管理员生成租金变更通知书	
<%
	}
	else
	{
%>
	
	调息还没有完成
<%
	}
%>
&nbsp;</td>		
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
