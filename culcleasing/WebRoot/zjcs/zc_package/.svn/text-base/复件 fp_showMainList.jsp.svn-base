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
<title>发票管理 - 电信发票列表</title>
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
	//checkbos全选
	function isSelectAll() {
		var names = document.getElementsByName("checkbos_list");
		var isck_all = document.getElementById("ck_all").checked;
		for (var n=0;n<names.length;n++) {
			names[n].checked=isck_all;
		}
	}
	function closeWin(){
		window.close();
		opener.location.reload();
	}

</script>


<%
	
	//权限处理  取得登录人的ID
	String dqczy =  (String) session.getAttribute("czyid");//ADMN-857CHJ  资产管理部   计划财务部 ADMN-857CH2
	//select dbo.GETUSERNAME ('ADMN-84XDH3')
	
	//根据登录人编号查询登录部门名称
	String qx_value = "";//变量，控制权限的判断
	String query_department = " select dept_name from base_department where id = ( ";
	query_department = query_department +" select department from base_user where id = '"+dqczy+"')  ";
	System.out.println("部门名称sql->"+query_department);
	ResultSet rs_d = db.executeQuery(query_department);
	String dept_name = "";
	if(rs_d.next()){
		dept_name = getDBStr( rs_d.getString("dept_name") ) ;
	}
	System.out.println("部门名称-部门名称-部门名称-部门名称->"+dept_name);
	if("".equals(dept_name) || dept_name == null){//未有部门
		qx_value = "0";
	}else if ("资产管理部".equals(dept_name)){
		qx_value = "1";
	}else if ("财务会计部".equals(dept_name)){
		qx_value = "2";
	}
	rs_d.close();
	
	//根据后台类生成资产编号
	ZC_Package zc_Package = new ZC_Package();
	String zc_num = zc_Package.get_Id();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//格式化时间
	String nowDateTime = sdf.format(new Date());//当前格式化之后的时间
	ResultSet rs = null;
	String Zc_num = getStr(request.getParameter("Zc_num"));
	String status_tem = getStr(request.getParameter("status_tem"));//操作状态
	
	//********************************************************************************
	//查询所有已开发票的比例，租金，本金，利息等信息
	List<String> list = zc_Package.querySumMoney_Fp(Zc_num);
	String yk_Fp_countMoney = list.get(0);
	String yk_Fp_corpus = list.get(1);
	String yk_Fp_interest = list.get(2);
	String Fp_rate = list.get(3);
		
	//********************************************************************************
	
	//发票抬头查询： 
	String Fp_tt =  getStr( request.getParameter("Fp_tt"));// "上海庞源建筑机械租赁有限公司"
	//发票编号查询： 
	String Fp_num = getStr(request.getParameter("Fp_num"));
	//查询范围2：付退款时间   从__到__
	String dateStart = getStr(request.getParameter("dateStart") );
	String dateEnd = getStr(request.getParameter("dateEnd") );
	
	StringBuffer sql = new StringBuffer();
	sql.append(" select *  from fund_Assets_Invoice  where id in( select fp_id from fund_Assets_Invoice_Corresponding where Zc_num = '"+Zc_num+"' )     ") ;
	String searchFld_tmp = "";
	// 发票编号 
	if( !Fp_num.equals("") && Fp_num != null ) {
		sql.append(" and Fp_num = '"+Fp_num+"'  ");
	}
	if( !Fp_tt.equals("") && Fp_tt != null ) {
		sql.append(" and Fp_tt like '%"+Fp_tt+"%'  ");
	}
	//查询范围2：付退款时间   从__到__
	if((!dateStart.equals("") && dateStart != null) && (!dateEnd.equals("") && dateEnd != null)){
		sql.append("  and Caertor_date >= '"+dateStart+"' ");
		sql.append("  and Caertor_date <= '"+dateEnd+"' ");
	}else{
		dateStart = "2010-11-01";//nowDateTime;
		dateEnd = "2010-12-31";//nowDateTime;
	}	
	sql.append("  order by  id  ") ;
	System.out.println("<><><><><><>====="+sql);
%>
<form name="searchbar" action="zc_list.jsp">
<body onload="public_onload(0);" onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}else{return true;}" >
<!--标题开始-->
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="25">
	<tr class="tree_title_txt">
		<td nowrap width="100%" class="tree_title_txt" valign="middle" id="cwCellTopTitTxt">
			发票管理 &gt; 电信发票列表   
		</td>
	</tr>
</table>
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
   <!--     -->
    <tr class="maintab">
      <td align="center" colspan="2">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
          <tr class="maintab">
            <td align="left">
            <!-- 权限控制 -->
            <%if(!qx_value.equals("2")){ %>
            		
	              <a href="#" accesskey="n" onClick="dataHander('add','fp_add.jsp?model=add&UserName=<%=Fp_tt%>&Zc_num=<%=Zc_num%>',searchbar.Zc_num);">
	              		<img src="../../images/sbtn_new.gif" alt="新增(Alt+N)" width="19" height="19" align="absmiddle">
	              </a>
	        <% } %>
            <%
            	//计划财务部才能进入操作，并且‘审核完毕’的发票不允许做任何操作,带提交的发票
            	if(qx_value.equals("2") && !"审核完毕".equals(status_tem) && !"提交审核".equals(status_tem)){
            	//计划财务部 进入添加发票编号
            %>
            <!--  -->
            	<a href="#" accesskey="m" onClick="dataHander('mod','fp_mod.jsp?model=mod&key_id=',searchbar.key_id);">
            		<img src="../../images/sbtn_mod.gif" alt="修改(Alt+M)" width="19" height="19" align="absmiddle" >
            	</a>
	        <% }%>
            <%if(!qx_value.equals("2")){ %>
			   <a href="#" accesskey="d" onClick="dataHander('del','fp_add.jsp?model=del&Zc_num=<%=Zc_num%>&key_id=',searchbar.key_id);">
				<img src="../../images/sbtn_del.gif" alt="删除(Alt+D)" width="19" height="19" align="absmiddle" >
				</a>
	        <% }%>
	        <BUTTON class="btn_2" name="btnReset" value="取消" onClick="closeWin();">
								<img src="../../images/hg.gif" align="absmiddle" border="0">关闭</button>
			</td>
          </tr>
        </table>
        </td>
    </tr>
    </table>
<!--标题结束-->
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
<!--副标题和操作区开始
			<tr class="maintab" >
				<td align="left" colspan="2" nowrap="nowrap">
					&nbsp;发票抬头&nbsp;
						<input type="text" name="Fp_tt" id="Fp_tt" size="26" value="<%=Fp_tt%>" onblur="isValidStr(this.value,'发票抬头','Fp_tt')"/>
					&nbsp;发票编号&nbsp;
						<input type="text" name="Fp_num" id="Fp_num" value="<%=Fp_num%>"  onblur="isValidStr(this.value,'发票编号','Fp_num')"/>
					&nbsp;开票时间起 &nbsp;
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
				</td>
			</tr>
-->
<tr class="maintab" >
	<td align="left" colspan="2" nowrap="nowrap">
		<font color="red">
		&nbsp;发票抬头：<%=Fp_tt%>&nbsp;已开票比例：<%=formatNumberDoubleTwo(Fp_rate)%>% &nbsp;已开票金额：<%=formatNumberStr(yk_Fp_countMoney,"#,##0.00")%> &nbsp;已开票本金：<%=formatNumberStr(yk_Fp_corpus,"#,##0.00")%>&nbsp;已开票利息：<%=formatNumberStr(yk_Fp_interest,"#,##0.00")%> 
		</font>
	</td>
</tr>						
<tr class="maintab">
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
	<input type="hidden" name="Zc_num" id="Zc_num" value="<%=Zc_num%>"/>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
      	 <%if((!"审核完毕".equals(status_tem)&& !"提交审核".equals(status_tem)) || !qx_value.equals("2") ){  %>
		<th width="1%"> 选择 </th>
		<%} %>
		<th>编号</th>
		<th>发票编号</th>
		<th>金额比例</th> 
		<th>发票金额</th> 
		<th>本金</th> 
		<th>利息</th>
		<th>开票时间</th> 
      </tr> 
<%	  
if ( intRowCount!=0 ) {
	while( i < intPageSize && !rs.isAfterLast() ) {
%>
      <tr>
      	 <%if((!"审核完毕".equals(status_tem)&& !"提交审核".equals(status_tem)) || !qx_value.equals("2")){  %>
      	<!-- 针对具体数据行进行修改删除操作  -->
      	<td><input type="radio"  style="border:0" name="key_id" value="<%=getDBStr(rs.getString("id"))%>"/></td>
      	<%} %>
        <td nowrap align="center" width=""><%= getDBStr( rs.getString("id"))%></td>
		<td nowrap align="center" width=""><%= getDBStr(rs.getString("Fp_num"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_rate"))%>%</td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_countMoney"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_corpus"))%></td>
		<td nowrap align="center" width=""><%= getDBStr( rs.getString("Fp_interest"))%></td>
		<td nowrap align="center" width=""><%= getDBDateStr( rs.getString("Kp_date"))%></td>
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
