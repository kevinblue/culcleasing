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
<title>资产包管理 - 打包</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
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
	function check_date(){
		//form1
		var cust_name =  document.getElementById('cust_name1').value;
		if(cust_name == null || cust_name == ""){
			alert("承租人不能为空请填写!");
			return false;
		}else{
			form1.submit();
		}
	}
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
	
	//资产打包操作
	function zc_db(){
		var str_checkbos_list = '';
		var str_rent_list = '';
		var str_contract_id = '';
		var str_cust_id = '';
		var selectedIndex = -1;
	    var form1 = document.getElementById("form1");
	    var str = document.getElementsByName("checkbos_list");
	    var i = 0;
	    for (i = 0; i < str.length; i++)
	    {
	        if (str[i].checked)
	        {
	            selectedIndex = i;
	            str_checkbos_list = str_checkbos_list + str[i].value + "#";
	            //拼装期项的值
	            var rent_list = str[i].getAttribute('rent_list');
	           // alert(str[i].getAttribute('rent_list'));
	            str_rent_list = str_rent_list + rent_list + "#";
	            var contract_id = str[i].getAttribute('contract_id');
	            str_contract_id = str_contract_id + contract_id + "#";
	            var cust_id = str[i].getAttribute('cust_id');
	            str_cust_id =  cust_id;
	        }
	    }
	    if (selectedIndex < 0 )
	    {
	        alert("请先选择需要打包的租金偿还计划!");
	        return false;
	    }
	    
	   str_checkbos_list = str_checkbos_list.substring(0,str_checkbos_list.length-1);
	   str_rent_list = str_rent_list.substring(0,str_rent_list.length-1);
	   str_contract_id = str_contract_id.substring(0,str_contract_id.length-1);
	  // str_cust_id = str_cust_id.substring(0,str_cust_id.length-1);
	   //租金偿还计划的主键
	   document.getElementById('all_checkbos_value').value = str_checkbos_list;
	   document.getElementById('rent_list_value').value = str_rent_list;
	   document.getElementById('str_contract_id').value = str_contract_id;
	   
	  
	   var cust_id = str_cust_id;
	   
	   document.getElementById('cust_id_v').value = cust_id;
	   //alert("==>"+document.getElementById('cust_id_v').value );
	   //alert("zc_executeDB.jsp?model=add&cust_id="+cust_id);
	   form1.action = "zc_executeDB.jsp?model=add&cust_id="+cust_id;//调整的jsp页面
	   document.form1.target = "_blank";
	   form1.submit();
	}
	
	function query_cust(){
		var cust_name = document.getElementById('cust_name').value;
		window.open("query_cust.jsp?cust_name="+cust_name,'客户查询','height=400,width=800,top=200,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no'); 
	}
	//赋值
	function addText(str){
		//alert("join---?>"+str);
		var cust_id = str.split("#")[0];
		var cust_name = str.split("#")[1];
		document.getElementById('cust_name').value = cust_name;
		document.getElementById('cust_id').value = cust_id;
	}
</script>
<form name="form1" action="zc_list.jsp">
<input type="hidden" name="model" id="model" value="add"/>
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >

					 
<%
	//根据后台类生成资产编号
	ZC_Package zc_Package = new ZC_Package();
	String zc_num = zc_Package.get_Id();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs = null;
	//承租人查询： 
	String cust_name1 = getStr( request.getParameter("cust_name1"));// "上海庞源建筑机械租赁有限公司"
	//合同号查询： 
	String model = getStr(request.getParameter("model"));
	String contract_id = getStr(request.getParameter("contract_id"));
	//查询范围2：付退款时间   从__到__
	String dateStart = getStr(request.getParameter("dateStart") );
	String dateEnd = getStr(request.getParameter("dateEnd") );
	
	StringBuffer sql = new StringBuffer();
	sql.append(" select f.id,f.contract_id,f.plan_date,f.rent_list,f.rent,f.corpus,f.interest ,f.plan_status ") 
		 .append(" ,v.cust_name,c.cust_id ") 
		 .append(" from fund_rent_plan  as f ") 
		 .append(" left join contract_info as c on c.contract_id = f.contract_id ") 
		 .append(" left join vi_cust_all_info as v on v.cust_id = c.cust_id  where 1=1 ") ;
	if(!cust_name1.equals("") && cust_name1 != null )	{
		 sql.append(" and  v.cust_name = '"+cust_name1+"' ")   ;
	}else{
		 sql.append(" and  1 = 2 ")   ;
	} 
	String searchFld_tmp = "";
	// 合同号 
	if( !contract_id.equals("") && contract_id != null ) {
		sql.append(" and f.contract_id like '%"+contract_id+"%'  ");
	}
	//查询范围2：付退款时间   从__到__
	if((!dateStart.equals("") && dateStart != null) && (!dateEnd.equals("") && dateEnd != null)){
		sql.append("  and f.plan_date >= '"+dateStart+"' ");
		sql.append("  and f.plan_date <= '"+dateEnd+"' ");
	}else{
		dateStart = "2010-11-01";//nowDateTime;
		dateEnd = "2010-12-31";//nowDateTime;
	}	
	sql.append(" and f.id not in ( select chjx_id from fund_Assets_rent_Corresponding ) ");
	sql.append("  and f.plan_status <> '已回笼' order by f.contract_id  ") ;
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
 						<!-- 
						<input type="text" name="cust_name" id="cust_name" size="26" value="<%= cust_name1 %>" onblur="isValidStr(this.value,'承租人','cust_name')"/>
						<input type="hidden" name="cust_id" id="cust_id"/>
						<input type="button" name="button" class="btn" value="选择客户" onclick="query_cust()"/>
						
 						function OpenDataWindow(checkobj,checkfldname,checkfld,checktype,selfldname,tblname,listfld,listvalue,filterfld,orderfld,ordertype,dataobj,valueobj)
						//checkobj--应检查前导字段对象,以"|"分隔 
						//checkfldname--前导字段中文名称,以"|"分隔
						//checkfld--前导字段名,以"|"分隔
						//checktype--前导字段数据类型,以"|"分隔,枚举值：string,number
						//selfldname--检索字段中文名称,以"|"分隔
						//tblname-- 所查数据表名或视图名
						//listfld--list显示字段
						//listvalue--list实填值字段,以"|"分隔
						//filterfld--筛选字段
						//orderfld--排序字段,以"|"分隔
						//ordertype--排序方式,升序或降序,以"|"分隔
						//dataobj--返回数据显示对象
						//valueobj--返回数据实际值对象+其他需填充对象,以"|"分隔
 						 -->
						<input class="text" type="text" name="cust_name1"  value="<%=cust_name1%>" onblur="isValidStr(this.value,'承租人','cust_name1')"/>
					    <input type="hidden" name="cust_id1" id="cust_id1" />
					    <img src="../../images/sbtn_more.gif" alt="选" align="absmiddle"  style="cursor:pointer" 
					    	 onClick="OpenDataWindow('','','','','承租人','vi_cust_all_info','cust_name','cust_id','cust_name','cust_id','asc','form1.cust_name1','form1.cust_id1');">
						
						<span class="biTian">*</span>
					&nbsp;合同号&nbsp;
						<input type="text" name="contract_id" id="contract_id" value="<%= contract_id %>"  onblur="isValidStr(this.value,'合同号','contract_id')"/>
					&nbsp;时间起 &nbsp;
					<input name="dateStart" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=dateStart%>"> 
					<img  onClick="openCalendar(dateStart);return false" 
						style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
						height="19" border="0" align="absmiddle">
					&nbsp;至&nbsp;
					<input name="dateEnd" type="text" size="10" readonly maxlength="10" dataType="Date" value="<%=dateEnd%>"> 
					<img  onClick="openCalendar(dateEnd);return false" 
						style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" 
						height="19" border="0" align="absmiddle">
						
					<button class="btn_2" name="btnSave" value="查询" onclick="check_date();" type="submit">
						<img src="../../images/tbtn_searh.gif" alt="查询" align="absmiddle" border="0">
					</button>
					
					<a href="#" onclick="zc_db();">
		            	<img src="../../images/sbtn_yijiao.gif" alt="资产打包" border="0" align="absmiddle" >
		            </a>
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
<!--翻页控制结束-->
<!--报表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv";>
	<input type="hidden" name="all_checkbos_value" id="all_checkbos_value"/>
	<input type="hidden" name="rent_list_value" id="rent_list_value"/>
	<input type="hidden" name="str_contract_id" id="str_contract_id"/>
	<input type="hidden" name="zc_num" id="zc_num" value="<%=zc_num%>"/>
	<input type="hidden" name="cust_name" id="cust_name" value="<%=cust_name1%>"/>
	<input type="hidden" name="cust_id_v" id="cust_id_v" />
	<input type="hidden" name="contract_id" id="contract_id" value="<%=contract_id%>"/>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	
		<th width="1%">
	    	<input name="ck_all" id="ck_all" type="checkbox" style="border:0"  onclick="isSelectAll();">全选
	    </th>
		<th>编号</th>
		<th>合同号</th>
		<th>承租人</th> 
		<th>期次</th> 
		<th>偿还日期</th> 
		<th>租金</th> 
		<th>本金</th> 
		<th>利息</th>
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	<td  align="center"><input type="checkbox"  style="border:0"  name="checkbos_list" contract_id="<%=getDBStr(rs.getString("contract_id"))%>" cust_id="<%=getDBStr(rs.getString("cust_id"))%>" rent_list="<%=getDBStr(rs.getString("rent_list"))%>" value="<%=getDBStr(rs.getString("id"))%>"/></td>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("id") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr(rs.getString("contract_id"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("cust_name") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("rent_list") ) %></td>
		<td nowrap align="center" width=""><%= getDBDateStr( rs.getString("plan_date") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("rent") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("corpus") ) %></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("interest") ) %></td>
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
