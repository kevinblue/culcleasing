<%@ page contentType="text/html; charset=gbk" language="java"  %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="dbconn.*" %> 
<%@page import="com.condition.ZC_Package"%> 
<jsp:useBean id="right" scope="page" class="com.filter.FilterCredit" />
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>资产包管理 - 承租人查询</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<script type="text/javascript">
	function check_input(){
		var inputs = document.getElementsByTagName("input");
		for(var i = 0;i<inputs.length;i++){
			if(inputs[i].type=="text"){
				if(inputs[i].value.indexOf("\'")>=0){
					alert("\' 是非法字符");
					return false;
				}
			}
		}
	}
	//非法字符验证
	function isValidStr(str,name,name_name){
	    if(str.indexOf("\\") != -1)
	    {
	       alert( name+ "的输入不能包含反斜杠\符号！");
	       document.getElementById(name_name).value = "";
	       return false;
	    }
	    var ignoreStr="'\"（）()<>#$%^&*+";
	    for(i=0;i<str.length;i++){
	         if(ignoreStr.indexOf(str.substring(i,i+1)) != -1)
	         {
	            alert( name+"的输入不能包含'和\"以<>#$%^&*+括号等符号，请重新输入！");
		        document.getElementById(name_name).value = "";
	            return false;
	          }
	     }
	    return true;
	} 
	
	//
	function check_date(){
		//searchbar
		var cust_name =  document.getElementById('cust_name').value;
		if(cust_name == null || cust_name == ""){
			alert("承租人不能为空请填写!");
			return false;
		}else{
			searchbar.submit();
		}
	}
	
	//确定选择的客户
	function form_submit(){
		var str_key_id = '';
		var cust_name = '';
		var selectedIndex = -1;
	    var form1 = document.getElementById("searchbar");
	    var str = document.getElementsByName("key_id");
	    var i = 0;
	    for (i = 0; i < str.length; i++)
	    {
	        if (str[i].checked)
	        {
	            selectedIndex = i;
	            str_key_id = str[i].value ;
	            //拼装期项的值
	            cust_name = str[i].getAttribute('cust_name');
	        }
	    }
	    if (selectedIndex < 0 )
	    {
	        alert("请先选择客户!");
	        return false;
	    }
    //alert(str_key_id);
    //alert(cust_name);
    var str = str_key_id + "#" + cust_name;
    window.parent.opener.addText(str);
   window.parent.close();
}
	
</script>
<form name="searchbar" action="query_cust.jsp">
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >

					 
<%
	//根据后台类生成资产编号
	ZC_Package zc_Package = new ZC_Package();
	String zc_num = zc_Package.get_Id();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs = null;
	//承租人查询： 
	String cust_name =  getStr( request.getParameter("cust_name"));// "上海庞源建筑机械租赁有限公司"
	
	StringBuffer sql = new StringBuffer();
	sql.append(" select    cust_id,cust_name  ") 
		 .append(" from vi_cust_all_info   ") 
		 .append(" where cust_name like '%"+cust_name+"%' ")
	     .append(" order by cust_id ");
	System.out.println("<><><><><><>====="+sql);
%>

<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
			<tr class="tree_title_txt">
				<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
					资产包管理 &gt; 打包  
				</td>
			</tr>
</table>
<!--标题结束-->
<!--副标题和操作区开始-->

<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
			<tr class="maintab" >
				<td align="left" colspan="2" nowrap="nowrap">
					&nbsp;承租人&nbsp;
						<input type="text" name="cust_name" id="cust_name" size="26" value="<%=cust_name%>"  onblur="isValidStr(this.value,'承租人','cust_name')"/>
						<span class="biTian">*</span>
					<button class="btn_2" name="btnSave" value="查询" onclick="check_date();" type="submit">
						<img src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" border="0">
						<BUTTON class="btn_2" name="btnSave" value="提交"  onclick="form_submit()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">提交</button>
					</button>
				</td>
			</tr>
			<tr class="maintab">
				<td align="left" width="1%">
				<!--操作按钮开始-->
				<table border="0" cellspacing="0" cellpadding="0" >    
				    <tr class="maintab">
						<td nowrap>
						</td>
				    </tr>
				</table>
				<!--操作按钮结束-->
			</td>
		
<td align="right" width="90%">
<!--翻页控制开始-->
<% 
	int intPageSize = 50;   //一页显示的记录数
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
	rs = db.executeQuery(sql.toString()); 
	rs.last();                                      //获取记录总数
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
		var nf = document.searchbar;
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
<!--翻页控制结束-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>选择</th>
		<th>承租人编号</th>
		<th>承租人</th> 
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<td><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("cust_id"))%>" cust_name="<%=getDBStr(rs.getString("cust_name"))%>"/></td>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("cust_id") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("cust_name") ) %></td>
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
    </form>
</div>
<!--报表结束-->
</body>
</html>
